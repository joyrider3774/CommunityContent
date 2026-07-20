/* *****************************************************************************
*  VirconBox2D : b2_core.h        (minimal port of Box2D v3 src/core.h + core.c)
*  --------------------------------------------------------------------------- *
*  Upstream core.h is mostly platform/SIMD/atomics/int64 detection that does    *
*  not apply to Vircon32. This is a minimal, dialect-clean substitute carrying  *
*  only what the rest of the port needs:                                        *
*    - the allocator (b2Alloc/b2Free/...), mapped onto the console heap         *
*      (malloc/calloc/realloc/free from misc.h)                                 *
*    - B2_NULL_INDEX, the "no index" sentinel used throughout the engine        *
*                                                                              *
*  IMPORTANT (word-addressed memory): sizeof counts 32-bit WORDS here, and the  *
*  console malloc takes a WORD count, so b2Alloc(sizeof(T)) maps straight to    *
*  malloc(words) with no byte/word conversion.                                  *
*                                                                              *
*  B2_ASSERT is intentionally NOT defined: per the port convention asserts are  *
*  omitted at the call sites (a function-like no-op macro would also choke on   *
*  asserts whose argument contains a comma, since variadics are unsupported).   *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_CORE_H
    #define B2_CORE_H

    #include "misc.h"      // malloc / calloc / realloc / free
    #include "string.h"    // memset / memcpy (word-counted)
// *****************************************************************************


// Box2D uses -1 as the "no index" sentinel for its array-based data structures.
// (On Vircon32, NULL is also -1, so this matches the pointer sentinel too.)
#define B2_NULL_INDEX ( -1 )


// -----------------------------------------------------------------------------
//   Allocator (sizes are WORD counts, matching sizeof)
// -----------------------------------------------------------------------------

void* b2Alloc( int size )
{
    return malloc( size );
}

void* b2AllocZeroInit( int size )
{
    // calloc( count, size ) zero-initializes count*size words
    return calloc( size, 1 );
}

// 'size' is accepted to mirror the upstream signature (used there for byte
// accounting); the console heap tracks block sizes itself, so it is unused here.
void b2Free( void* mem, int size )
{
    free( mem );
}

void* b2GrowAlloc( void* oldMem, int oldSize, int newSize )
{
    return realloc( oldMem, newSize );
}


// -----------------------------------------------------------------------------
//   Generic array-grow helper (one implementation for every typed array)
// -----------------------------------------------------------------------------
//   Ensures the array can hold `needed` elements of `elemWords` words each and
//   returns the (possibly reallocated) data pointer; the caller assigns it back
//   to its typed `.data` and does slot addressing with typed pointers. Growth
//   policy mirrors upstream b2Array: 0 -> 8, otherwise double, at least needed.
//   (elemWords is sizeof(T), which counts WORDS on this target.)
void* b2GrowArray( void* data, int* capacity, int needed, int elemWords )
{
    int cap = *capacity;
    if( cap >= needed )
        return data;

    int newCap = 8;
    if( cap != 0 )
        newCap = 2 * cap;
    if( newCap < needed )
        newCap = needed;

    void* result;
    if( data == NULL )
        result = b2Alloc( newCap * elemWords );
    else
        result = b2GrowAlloc( data, cap * elemWords, newCap * elemWords );

    *capacity = newCap;
    return result;
}


// *****************************************************************************
    #endif
// *****************************************************************************
