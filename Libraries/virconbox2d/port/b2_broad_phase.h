/* *****************************************************************************
*  VirconBox2D : b2_broad_phase.h    (port of Box2D v3 broad_phase.c -- SLICE 1)
*  --------------------------------------------------------------------------- *
*  The bridge from the sim-core (shapes) to the already-green dynamic_tree.     *
*  A b2BroadPhase holds one AABB tree per body type (static/kinematic/dynamic); *
*  a proxy key packs [30 bits proxyId | 2 bits body-type] so one key identifies *
*  both which tree and which node.                                             *
*                                                                              *
*  SLICE 1 = just the trees + Create/Destroy/Move proxy delegating to the tree. *
*  DEFERRED (the contact-pair pipeline): the movedProxies bitsets, moveArray,   *
*  movePairs/moveResults, and the pairSet hash — all of that exists to report   *
*  NEW overlapping pairs for automatic contact creation, which isn't ported.    *
*                                                                              *
*  Port note: `trees` is a HEAP array, not a fixed `b2DynamicTree trees[3]`     *
*  member. A fixed array member indexed by a variable (the body type) hits the  *
*  known dialect miscompile; a heap-pointer array indexed by a variable is      *
*  probe-confirmed safe. The move-buffering helpers (b2BufferMove) are dropped. *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_BROAD_PHASE_H
    #define B2_BROAD_PHASE_H

    #include "b2_dynamic_tree.h"
    #include "b2_core.h"
    #include "b2_bitset.h"
    #include "b2_table.h"
// *****************************************************************************


// b2BodyType (also the broad-phase tree index per body). Defined here because
// the trees are keyed by body type; b2_body.h includes this header.
#define b2_staticBody     0
#define b2_kinematicBody  1
#define b2_dynamicBody    2

#define b2_bodyTypeCount 3

// Proxy key packs the proxy id and the body type (lower 2 bits).
#define B2_PROXY_TYPE( KEY )      ( ( KEY ) & 3 )
#define B2_PROXY_ID( KEY )        ( ( KEY ) >> 2 )
#define B2_PROXY_KEY( ID, TYPE )  ( ( ( ID ) << 2 ) | ( TYPE ) )


struct b2BroadPhase
{
    b2DynamicTree* trees;        // heap array [b2_bodyTypeCount], indexed by body type

    // Move buffering: which proxies moved this step, so the pairing pass knows
    // what to re-query. INVARIANT: a bit is set in movedProxies[type] at proxyId
    // iff that proxy's key is present in moveArray.
    b2BitSet* movedProxies;      // heap array [b2_bodyTypeCount] (per-type, indexed by proxyId)
    int* moveArray;              // dynamic array of packed proxy keys
    int moveCount;
    int moveCapacity;

    // Tracks shape pairs that already have a contact (keyed by the shape-id pair).
    b2HashSet pairSet;

    // DEFERRED to the solver slice: moveResults, movePairs (deterministic parallel emit).
};


void b2CreateBroadPhase( b2BroadPhase* bp )
{
    bp->trees = b2Alloc( b2_bodyTypeCount * sizeof( b2DynamicTree ) );
    bp->movedProxies = b2Alloc( b2_bodyTypeCount * sizeof( b2BitSet ) );
    int i;
    for( i = 0; i < b2_bodyTypeCount; ++i )
    {
        b2DynamicTree_Create( 16, &bp->trees[i] );
        b2CreateBitSet( 64, &bp->movedProxies[i] );
        b2SetBitCountAndClear( &bp->movedProxies[i], 64 );
    }
    bp->moveArray = NULL;
    bp->moveCount = 0;
    bp->moveCapacity = 0;
    b2CreateSet( 32, &bp->pairSet );
}

void b2DestroyBroadPhase( b2BroadPhase* bp )
{
    int i;
    for( i = 0; i < b2_bodyTypeCount; ++i )
    {
        b2DynamicTree_Destroy( &bp->trees[i] );
        b2DestroyBitSet( &bp->movedProxies[i] );
    }
    b2Free( bp->trees, b2_bodyTypeCount * sizeof( b2DynamicTree ) );
    b2Free( bp->movedProxies, b2_bodyTypeCount * sizeof( b2BitSet ) );
    if( bp->moveArray != NULL )
        b2Free( bp->moveArray, bp->moveCapacity * sizeof( int ) );
    b2DestroySet( &bp->pairSet );
}


// Mark a proxy as moved this step (deduplicated via its movedProxies bit).
void b2BufferMove( b2BroadPhase* bp, int proxyKey )
{
    int proxyType = B2_PROXY_TYPE( proxyKey );
    int proxyId = B2_PROXY_ID( proxyKey );
    if( b2GetBit( &bp->movedProxies[proxyType], proxyId ) == false )
    {
        b2SetBitGrow( &bp->movedProxies[proxyType], proxyId );
        bp->moveArray = b2GrowArray( bp->moveArray, &bp->moveCapacity, bp->moveCount + 1, sizeof( int ) );
        bp->moveArray[ bp->moveCount ] = proxyKey;
        bp->moveCount = bp->moveCount + 1;
    }
}

// Remove a proxy from the move buffer (clear the bit + swap-remove from the array).
void b2UnBufferMove( b2BroadPhase* bp, int proxyKey )
{
    int proxyType = B2_PROXY_TYPE( proxyKey );
    int proxyId = B2_PROXY_ID( proxyKey );
    if( b2GetBit( &bp->movedProxies[proxyType], proxyId ) )
    {
        b2ClearBit( &bp->movedProxies[proxyType], proxyId );
        int count = bp->moveCount;
        int i;
        for( i = 0; i < count; ++i )
        {
            if( bp->moveArray[i] == proxyKey )
            {
                bp->moveArray[i] = bp->moveArray[ count - 1 ];   // swap-remove
                bp->moveCount = count - 1;
                break;
            }
        }
    }
}

// End-of-step: clear every moved bit then empty the array (restores the invariant).
void b2BroadPhase_ClearMoveBuffer( b2BroadPhase* bp )
{
    int i;
    for( i = 0; i < bp->moveCount; ++i )
    {
        int proxyKey = bp->moveArray[i];
        b2ClearBit( &bp->movedProxies[ B2_PROXY_TYPE( proxyKey ) ], B2_PROXY_ID( proxyKey ) );
    }
    bp->moveCount = 0;
}

// Insert a proxy for body type `proxyType` and return its packed proxy key.
int b2BroadPhase_CreateProxy( b2BroadPhase* bp, int proxyType, b2AABB* aabb, int categoryBits, int shapeIndex )
{
    int proxyId = b2DynamicTree_CreateProxy( &bp->trees[ proxyType ], aabb, categoryBits, shapeIndex );
    int proxyKey = B2_PROXY_KEY( proxyId, proxyType );
    // Static proxies don't move, so they don't seed the move buffer.
    // (forcePairCreation is deferred until the pairing/sensor slice.)
    if( proxyType != b2_staticBody )
        b2BufferMove( bp, proxyKey );
    return proxyKey;
}

void b2BroadPhase_DestroyProxy( b2BroadPhase* bp, int proxyKey )
{
    b2UnBufferMove( bp, proxyKey );
    int proxyType = B2_PROXY_TYPE( proxyKey );
    int proxyId = B2_PROXY_ID( proxyKey );
    b2DynamicTree_DestroyProxy( &bp->trees[ proxyType ], proxyId );
}

void b2BroadPhase_MoveProxy( b2BroadPhase* bp, int proxyKey, b2AABB* aabb )
{
    int proxyType = B2_PROXY_TYPE( proxyKey );
    int proxyId = B2_PROXY_ID( proxyKey );
    b2DynamicTree_MoveProxy( &bp->trees[ proxyType ], proxyId, aabb );
    b2BufferMove( bp, proxyKey );
}


// *****************************************************************************
    #endif
// *****************************************************************************
