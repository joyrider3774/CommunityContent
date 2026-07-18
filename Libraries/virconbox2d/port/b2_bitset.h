/* *****************************************************************************
*  VirconBox2D : b2_bitset.h        (port of Box2D v3 src/bitset.{c,h})
*  --------------------------------------------------------------------------- *
*  Fast operations on large bit arrays. Used by the constraint-graph coloring   *
*  and the broad-phase moved-proxy sets.                                        *
*                                                                              *
*  KEY REWORK: upstream blocks are `uint64_t` (64 bits each). Vircon32 has no    *
*  64-bit integers, so blocks here are 32-bit `int` words (32 bits each). This   *
*  is one of the project's "big three" structural items; every / 64, % 64,      *
*  << 64 becomes / 32, % 32, << 32. Bit semantics are identical, only the block *
*  granularity changes. `b2PopCount64` is replaced by a 32-bit Kernighan count.  *
*                                                                              *
*  Port notes: b2BitSet is multi-word -> b2CreateBitSet returns via out-pointer. *
*  uint32 counts -> int. sizeof(int)==1 word, so block sizes are word counts.    *
*  `>>` is logical here, which is what bit math wants. No B2_ASSERT.            *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_BITSET_H
    #define B2_BITSET_H

    #include "b2_core.h"     // b2Alloc / b2Free, memset / memcpy (word-counted)
// *****************************************************************************


#define B2_BITS_PER_BLOCK 32

struct b2BitSet
{
    int* bits;          // array of 32-bit blocks
    int  blockCapacity;
    int  blockCount;
};


void b2CreateBitSet( int bitCapacity, b2BitSet* bitSet )
{
    bitSet->blockCapacity = ( bitCapacity + B2_BITS_PER_BLOCK - 1 ) / B2_BITS_PER_BLOCK;
    bitSet->blockCount = 0;
    bitSet->bits = b2Alloc( bitSet->blockCapacity * sizeof( int ) );
    memset( bitSet->bits, 0, bitSet->blockCapacity * sizeof( int ) );
}

void b2DestroyBitSet( b2BitSet* bitSet )
{
    b2Free( bitSet->bits, bitSet->blockCapacity * sizeof( int ) );
    bitSet->blockCapacity = 0;
    bitSet->blockCount = 0;
    bitSet->bits = NULL;
}

void b2SetBitCountAndClear( b2BitSet* bitSet, int bitCount )
{
    int blockCount = ( bitCount + B2_BITS_PER_BLOCK - 1 ) / B2_BITS_PER_BLOCK;
    if( bitSet->blockCapacity < blockCount )
    {
        b2DestroyBitSet( bitSet );
        int newBitCapacity = bitCount + ( bitCount >> 1 );
        b2CreateBitSet( newBitCapacity, bitSet );
    }

    bitSet->blockCount = blockCount;
    memset( bitSet->bits, 0, bitSet->blockCount * sizeof( int ) );
}

void b2GrowBitSet( b2BitSet* bitSet, int blockCount )
{
    if( blockCount > bitSet->blockCapacity )
    {
        int oldCapacity = bitSet->blockCapacity;
        bitSet->blockCapacity = blockCount + blockCount / 2;
        int* newBits = b2Alloc( bitSet->blockCapacity * sizeof( int ) );
        memset( newBits, 0, bitSet->blockCapacity * sizeof( int ) );
        memcpy( newBits, bitSet->bits, oldCapacity * sizeof( int ) );
        b2Free( bitSet->bits, oldCapacity * sizeof( int ) );
        bitSet->bits = newBits;
    }

    bitSet->blockCount = blockCount;
}

void b2InPlaceUnion( b2BitSet* setA, b2BitSet* setB )
{
    int blockCount = setA->blockCount;
    int i;
    for( i = 0; i < blockCount; ++i )
        setA->bits[i] = setA->bits[i] | setB->bits[i];
}

void b2SetBit( b2BitSet* bitSet, int bitIndex )
{
    int blockIndex = bitIndex / B2_BITS_PER_BLOCK;
    bitSet->bits[blockIndex] = bitSet->bits[blockIndex] | ( 1 << ( bitIndex % B2_BITS_PER_BLOCK ) );
}

void b2SetBitGrow( b2BitSet* bitSet, int bitIndex )
{
    int blockIndex = bitIndex / B2_BITS_PER_BLOCK;
    if( blockIndex >= bitSet->blockCount )
        b2GrowBitSet( bitSet, blockIndex + 1 );
    bitSet->bits[blockIndex] = bitSet->bits[blockIndex] | ( 1 << ( bitIndex % B2_BITS_PER_BLOCK ) );
}

void b2ClearBit( b2BitSet* bitSet, int bitIndex )
{
    int blockIndex = bitIndex / B2_BITS_PER_BLOCK;
    if( blockIndex >= bitSet->blockCount )
        return;
    bitSet->bits[blockIndex] = bitSet->bits[blockIndex] & ( ~( 1 << ( bitIndex % B2_BITS_PER_BLOCK ) ) );
}

bool b2GetBit( b2BitSet* bitSet, int bitIndex )
{
    int blockIndex = bitIndex / B2_BITS_PER_BLOCK;
    if( blockIndex >= bitSet->blockCount )
        return false;
    return ( bitSet->bits[blockIndex] & ( 1 << ( bitIndex % B2_BITS_PER_BLOCK ) ) ) != 0;
}

int b2CountSetBits( b2BitSet* bitSet )
{
    int popCount = 0;
    int i;
    for( i = 0; i < bitSet->blockCount; ++i )
    {
        // Kernighan: clear the lowest set bit each iteration
        int block = bitSet->bits[i];
        while( block != 0 )
        {
            block = block & ( block - 1 );
            popCount = popCount + 1;
        }
    }
    return popCount;
}


// *****************************************************************************
    #endif
// *****************************************************************************
