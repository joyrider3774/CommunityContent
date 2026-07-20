/* *****************************************************************************
*  VirconBox2D : b2_ctz.h        (port of Box2D v3 src/ctz.h)
*  --------------------------------------------------------------------------- *
*  Bit utilities. Upstream uses compiler intrinsics (__builtin_ctz / MSVC       *
*  _BitScan*); those don't exist on the Vircon32 compiler, so the 32-bit ops    *
*  are reimplemented in plain C. ( >> is a LOGICAL shift in this dialect. )     *
*                                                                              *
*  Deferred: the 64-bit variants b2CTZ64 / b2PopCount64 (no 64-bit ints here) -- *
*  they are only used by the constraint-graph bitset, which is being reworked   *
*  to 32-bit words separately.                                                  *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_CTZ_H
    #define B2_CTZ_H
// *****************************************************************************


// Count trailing zeros: number of low-order zero bits. Returns 32 for 0.
int b2CTZ32( int block )
{
    if( block == 0 )
        return 32;

    int count = 0;
    while( ( block & 1 ) == 0 )
    {
        count = count + 1;
        block = block >> 1;
    }
    return count;
}

// Count leading zeros: number of high-order zero bits. Returns 32 for 0.
int b2CLZ32( int value )
{
    if( value == 0 )
        return 32;

    int n = 0;
    int i;
    for( i = 31; i >= 0; --i )
    {
        if( ( ( value >> i ) & 1 ) != 0 )
            return n;
        n = n + 1;
    }
    return n;
}

// ---------------------------------------------------------

bool b2IsPowerOf2( int x )
{
    return ( x & ( x - 1 ) ) == 0;
}

// Smallest k such that 2^k >= x  (the exponent, not the value).
int b2BoundingPowerOf2( int x )
{
    if( x <= 1 )
        return 1;
    return 32 - b2CLZ32( x - 1 );
}

// Smallest power of two >= x  (the value).
int b2RoundUpPowerOf2( int x )
{
    if( x <= 1 )
        return 1;
    return 1 << ( 32 - b2CLZ32( x - 1 ) );
}


// *****************************************************************************
    #endif
// *****************************************************************************
