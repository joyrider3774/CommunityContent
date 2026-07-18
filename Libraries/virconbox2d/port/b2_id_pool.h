/* *****************************************************************************
*  VirconBox2D : b2_id_pool.h        (port of Box2D v3 src/id_pool.{h,c})
*  --------------------------------------------------------------------------- *
*  Hands out small integer ids, recycling freed ones (LIFO). Used by the world  *
*  to index its body/shape/contact arrays.                                      *
*                                                                              *
*  Upstream backs the free list with the `b2Array(int)` macro container, which  *
*  relies on `##` token pasting (unsupported here). We instead hand-roll the    *
*  free list as a plain growable int array on the b2_core allocator -- same      *
*  semantics, no macro machinery. b2CreateIdPool returns void via an out-ptr    *
*  (the struct is multi-word). Validation helpers are omitted.                  *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_ID_POOL_H
    #define B2_ID_POOL_H

    #include "b2_core.h"
// *****************************************************************************


struct b2IdPool
{
    int* freeArray;   // stack of freed ids available for reuse
    int count;        // number of ids currently in freeArray
    int capacity;     // allocated capacity of freeArray
    int nextIndex;    // next fresh id to hand out
};


void b2CreateIdPool( b2IdPool* pool )
{
    pool->capacity = 32;
    pool->count = 0;
    pool->nextIndex = 0;
    pool->freeArray = b2Alloc( pool->capacity * sizeof( int ) );
}

void b2DestroyIdPool( b2IdPool* pool )
{
    b2Free( pool->freeArray, pool->capacity * sizeof( int ) );
    pool->freeArray = NULL;
    pool->count = 0;
    pool->capacity = 0;
    pool->nextIndex = 0;
}

// Allocate an id: reuse the most-recently-freed one, else hand out a fresh index.
int b2AllocId( b2IdPool* pool )
{
    if( pool->count > 0 )
    {
        pool->count = pool->count - 1;
        return pool->freeArray[pool->count];
    }

    int id = pool->nextIndex;
    pool->nextIndex = pool->nextIndex + 1;
    return id;
}

// Return an id to the pool for reuse.
void b2FreeId( b2IdPool* pool, int id )
{
    if( pool->count == pool->capacity )
    {
        int oldCapacity = pool->capacity;
        pool->capacity = oldCapacity + ( oldCapacity >> 1 );   // grow ~1.5x
        if( pool->capacity <= oldCapacity )
            pool->capacity = oldCapacity + 1;
        pool->freeArray = b2GrowAlloc( pool->freeArray,
                                       oldCapacity * sizeof( int ),
                                       pool->capacity * sizeof( int ) );
    }

    pool->freeArray[pool->count] = id;
    pool->count = pool->count + 1;
}

// Number of ids currently handed out (not freed).
int b2GetIdCount( b2IdPool* pool )
{
    return pool->nextIndex - pool->count;
}

// Highest fresh index reached (id capacity).
int b2GetIdCapacity( b2IdPool* pool )
{
    return pool->nextIndex;
}


// *****************************************************************************
    #endif
// *****************************************************************************
