/* *****************************************************************************
*  VirconBox2D : b2_table.h          (port of Box2D v3 src/table.{c,h})
*  --------------------------------------------------------------------------- *
*  Open-addressing hash set used by the broad-phase to track which shape pairs  *
*  already have a contact. Upstream keys are uint64_t = (shapeIdA<<32 | shapeIdB) *
*  -- no 64-bit ints here, so a key is the PAIR OF SHAPE IDS, passed as two      *
*  ints and stored as two int fields. The API is specialized to (int a, int b)  *
*  and canonicalizes (min,max) internally so (a,b) and (b,a) map to one slot.    *
*                                                                              *
*  Empty-slot sentinel: (key1==0 && key2==0). A live pair is two DISTINCT ids,   *
*  so its canonical max (key2) is >= 1 -> (0,0) never occurs for a live entry    *
*  (exactly mirrors upstream's `key != 0`). Occupied test must therefore be      *
*  `key1 != 0 || key2 != 0` -- pair (0,5) is live with key1==0.                  *
*                                                                              *
*  Hash: a 32-bit fmix (Murmur3 finalizer) replaces the 64-bit Murmur (whose    *
*  >>33 is meaningless at 32 bits). Open addressing is correct for ANY           *
*  deterministic key->int hash; quality only affects probe-chain length.        *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_TABLE_H
    #define B2_TABLE_H

    #include "b2_core.h"     // b2Alloc / b2Free, memset (word-counted)
    #include "b2_ctz.h"      // b2RoundUpPowerOf2
// *****************************************************************************


struct b2SetItem
{
    int key1;   // canonical min of the shape-id pair
    int key2;   // canonical max  (>= 1 for any live entry)
};

struct b2HashSet
{
    b2SetItem* items;
    int capacity;   // always a power of 2
    int count;
};


// 32-bit Murmur3 finalizer. Multiplies wrap mod 2^32 (low word is sign-agnostic);
// `>>` is logical, which is what the mixer wants.
int b2MixU32( int h )
{
    h = h ^ ( h >> 16 );
    h = h * 0x85ebca6b;
    h = h ^ ( h >> 13 );
    h = h * 0xc2b2ae35;
    h = h ^ ( h >> 16 );
    return h;
}

int b2KeyHash( int a, int b )
{
    int h = b2MixU32( a );
    h = h ^ b2MixU32( b );
    h = b2MixU32( h );
    return h;
}

// True if the slot at `index` holds a live entry.
bool b2SlotOccupied( b2HashSet* set, int index )
{
    return set->items[index].key1 != 0 || set->items[index].key2 != 0;
}

// Linear-probe to the slot for (a,b): either the matching entry or the first empty.
int b2FindSlot( b2HashSet* set, int a, int b, int hash )
{
    int capacity = set->capacity;
    int index = hash & ( capacity - 1 );
    while( b2SlotOccupied( set, index ) &&
           !( set->items[index].key1 == a && set->items[index].key2 == b ) )
    {
        index = ( index + 1 ) & ( capacity - 1 );
    }
    return index;
}


void b2CreateSet( int capacity, b2HashSet* set )
{
    // capacity must be a power of 2, minimum 16
    if( capacity > 16 )
        set->capacity = b2RoundUpPowerOf2( capacity );
    else
        set->capacity = 16;

    set->count = 0;
    set->items = b2Alloc( set->capacity * sizeof( b2SetItem ) );
    memset( set->items, 0, set->capacity * sizeof( b2SetItem ) );
}

void b2DestroySet( b2HashSet* set )
{
    b2Free( set->items, set->capacity * sizeof( b2SetItem ) );
    set->items = NULL;
    set->count = 0;
    set->capacity = 0;
}

void b2ClearSet( b2HashSet* set )
{
    set->count = 0;
    memset( set->items, 0, set->capacity * sizeof( b2SetItem ) );
}

int b2GetSetCount( b2HashSet* set )
{
    return set->count;
}

int b2GetSetCapacity( b2HashSet* set )
{
    return set->capacity;
}

// Insert (a,b) assuming there's room and it's not already present.
void b2AddKeyHaveCapacity( b2HashSet* set, int a, int b, int hash )
{
    int index = b2FindSlot( set, a, b, hash );
    set->items[index].key1 = a;
    set->items[index].key2 = b;
    set->count = set->count + 1;
}

void b2GrowTable( b2HashSet* set )
{
    int oldCapacity = set->capacity;
    b2SetItem* oldItems = set->items;

    set->count = 0;
    set->capacity = 2 * oldCapacity;
    set->items = b2Alloc( set->capacity * sizeof( b2SetItem ) );
    memset( set->items, 0, set->capacity * sizeof( b2SetItem ) );

    int i;
    for( i = 0; i < oldCapacity; ++i )
    {
        int k1 = oldItems[i].key1;
        int k2 = oldItems[i].key2;
        if( k1 == 0 && k2 == 0 )
            continue;   // empty
        int hash = b2KeyHash( k1, k2 );
        b2AddKeyHaveCapacity( set, k1, k2, hash );
    }

    b2Free( oldItems, oldCapacity * sizeof( b2SetItem ) );
}

// Canonicalize the input pair to (min,max).
void b2CanonPair( int ia, int ib, int* a, int* b )
{
    if( ia < ib )
    {
        *a = ia;  *b = ib;
    }
    else
    {
        *a = ib;  *b = ia;
    }
}

bool b2ContainsKey( b2HashSet* set, int ia, int ib )
{
    int a;  int b;  b2CanonPair( ia, ib, &a, &b );
    int hash = b2KeyHash( a, b );
    int index = b2FindSlot( set, a, b, hash );
    return set->items[index].key1 == a && set->items[index].key2 == b;
}

// Returns true if the key was already present.
bool b2AddKey( b2HashSet* set, int ia, int ib )
{
    int a;  int b;  b2CanonPair( ia, ib, &a, &b );
    int hash = b2KeyHash( a, b );

    int index = b2FindSlot( set, a, b, hash );
    if( b2SlotOccupied( set, index ) )
        return true;   // already in set

    if( 2 * set->count >= set->capacity )
        b2GrowTable( set );

    b2AddKeyHaveCapacity( set, a, b, hash );
    return false;
}

// Backward-shift deletion (open addressing). Returns true if the key was found.
bool b2RemoveKey( b2HashSet* set, int ia, int ib )
{
    int a;  int b;  b2CanonPair( ia, ib, &a, &b );
    int hash = b2KeyHash( a, b );
    int i = b2FindSlot( set, a, b, hash );
    if( b2SlotOccupied( set, i ) == false )
        return false;   // not in set

    // mark slot i empty
    set->items[i].key1 = 0;
    set->items[i].key2 = 0;
    set->count = set->count - 1;

    int capacity = set->capacity;
    int j = i;
    while( true )
    {
        j = ( j + 1 ) & ( capacity - 1 );
        if( set->items[j].key1 == 0 && set->items[j].key2 == 0 )
            break;

        // k = the home slot for item j
        int hash_j = b2KeyHash( set->items[j].key1, set->items[j].key2 );
        int k = hash_j & ( capacity - 1 );

        // skip if k lies cyclically in (i, j]
        if( i <= j )
        {
            if( i < k && k <= j )
                continue;
        }
        else
        {
            if( i < k || k <= j )
                continue;
        }

        // move j into i
        set->items[i] = set->items[j];
        set->items[j].key1 = 0;
        set->items[j].key2 = 0;
        i = j;
    }

    return true;
}


// *****************************************************************************
    #endif
// *****************************************************************************
