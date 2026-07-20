/* *****************************************************************************
*  VirconBox2D : b2_arena_allocator.h   (port of Box2D v3 src/arena_allocator.c)
*  --------------------------------------------------------------------------- *
*  A stack/bump allocator for fast per-step temporary allocations. You must     *
*  nest allocate/free pairs (LIFO). If a request exceeds the remaining buffer   *
*  it falls back to the heap. b2GrowStack resizes the buffer (when idle) toward  *
*  the observed high-water mark.                                                *
*                                                                              *
*  Port notes: sizes are WORD counts (memory is word-addressed). The upstream    *
*  32-byte SIMD alignment padding and the debug `name`/`char*` fields are        *
*  dropped (no SIMD, no char type). b2CreateStack returns via an out-pointer.    *
*  The entries list is a hand-rolled growable array (upstream's b2Array uses     *
*  `##`), same idiom as b2_id_pool.                                             *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_ARENA_ALLOCATOR_H
    #define B2_ARENA_ALLOCATOR_H

    #include "b2_core.h"
// *****************************************************************************


struct b2StackEntry
{
    int* data;        // pointer to the allocation (into the buffer, or heap)
    int size;         // size in words
    bool usedMalloc;  // true if this entry fell back to the heap
};

struct b2Stack
{
    int* data;              // the arena buffer
    int capacity;           // buffer capacity (words)
    int index;              // current bump offset (words)
    int allocation;         // total currently allocated (words)
    int maxAllocation;      // high-water mark (words)
    b2StackEntry* entries;  // LIFO stack of live allocations
    int entryCount;
    int entryCapacity;
};


void b2CreateStack( int capacity, b2Stack* a )
{
    a->capacity = capacity;
    a->data = b2Alloc( capacity );
    a->index = 0;
    a->allocation = 0;
    a->maxAllocation = 0;
    a->entryCapacity = 32;
    a->entryCount = 0;
    a->entries = b2Alloc( a->entryCapacity * sizeof( b2StackEntry ) );
}

void b2DestroyStack( b2Stack* a )
{
    b2Free( a->entries, a->entryCapacity * sizeof( b2StackEntry ) );
    b2Free( a->data, a->capacity );
}

void* b2StackAlloc( b2Stack* a, int size )
{
    // grow the entries list if needed
    if( a->entryCount == a->entryCapacity )
    {
        int oldCapacity = a->entryCapacity;
        a->entryCapacity = oldCapacity + ( oldCapacity >> 1 );
        a->entries = b2GrowAlloc( a->entries,
                                  oldCapacity * sizeof( b2StackEntry ),
                                  a->entryCapacity * sizeof( b2StackEntry ) );
    }

    b2StackEntry* entry = a->entries + a->entryCount;
    entry->size = size;
    if( a->index + size > a->capacity )
    {
        // insufficient room: fall back to the heap
        entry->data = b2Alloc( size );
        entry->usedMalloc = true;
    }
    else
    {
        entry->data = a->data + a->index;
        entry->usedMalloc = false;
        a->index = a->index + size;
    }
    a->entryCount = a->entryCount + 1;

    a->allocation = a->allocation + size;
    if( a->allocation > a->maxAllocation )
        a->maxAllocation = a->allocation;

    return entry->data;
}

void b2StackFree( b2Stack* a, void* mem )
{
    // must free in LIFO order: the top entry is the one being freed
    b2StackEntry* entry = a->entries + ( a->entryCount - 1 );
    if( entry->usedMalloc )
        b2Free( entry->data, entry->size );
    else
        a->index = a->index - entry->size;

    a->allocation = a->allocation - entry->size;
    a->entryCount = a->entryCount - 1;
}

// Resize the buffer toward the observed high-water mark. Stack must be idle.
void b2GrowStack( b2Stack* a )
{
    if( a->maxAllocation > a->capacity )
    {
        b2Free( a->data, a->capacity );
        a->capacity = a->maxAllocation + a->maxAllocation / 2;
        a->data = b2Alloc( a->capacity );
    }
}

int b2GetStackCapacity( b2Stack* a )
{
    return a->capacity;
}

int b2GetStackAllocation( b2Stack* a )
{
    return a->allocation;
}

int b2GetMaxStackAllocation( b2Stack* a )
{
    return a->maxAllocation;
}


// *****************************************************************************
    #endif
// *****************************************************************************
