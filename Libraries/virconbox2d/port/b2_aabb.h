/* *****************************************************************************
*  VirconBox2D : b2_aabb.h        (port of Box2D v3 src/aabb.h + src/aabb.c)
*  --------------------------------------------------------------------------- *
*  Axis-aligned bounding box helpers. Note b2AABB itself and the simple        *
*  query helpers (Contains/Center/Extents/Union/Overlaps/MakeAABB) live in     *
*  b2_math.h; this header adds the rest of the AABB module.                     *
*                                                                              *
*  Port notes: b2AABB_RayCast returned a b2CastOutput by value -> now an       *
*  out-pointer. b2OffsetAABB returned a b2AABB -> out-pointer. b2Perimeter /    *
*  b2EnlargeAABB / b2IsValidAABB keep scalar/bool returns. 'f' suffixes        *
*  stripped, FLT_MAX/FLT_EPSILON from b2_math.h.                                *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_AABB_H
    #define B2_AABB_H

    #include "b2_math.h"
    #include "b2_collision.h"
// *****************************************************************************


// surface area (perimeter length) of an AABB
float b2Perimeter( b2AABB* a )
{
    float wx = a->upperBound.x - a->lowerBound.x;
    float wy = a->upperBound.y - a->lowerBound.y;
    return 2.0 * ( wx + wy );
}

// ---------------------------------------------------------

// enlarge a to contain b; returns true if a grew
bool b2EnlargeAABB( b2AABB* a, b2AABB* b )
{
    bool changed = false;

    if( b->lowerBound.x < a->lowerBound.x )
    {
        a->lowerBound.x = b->lowerBound.x;
        changed = true;
    }

    if( b->lowerBound.y < a->lowerBound.y )
    {
        a->lowerBound.y = b->lowerBound.y;
        changed = true;
    }

    if( a->upperBound.x < b->upperBound.x )
    {
        a->upperBound.x = b->upperBound.x;
        changed = true;
    }

    if( a->upperBound.y < b->upperBound.y )
    {
        a->upperBound.y = b->upperBound.y;
        changed = true;
    }

    return changed;
}

// ---------------------------------------------------------

// translate a relative AABB into world space (directed outward rounding;
// a no-op narrowing in single precision)
void b2OffsetAABB( b2AABB* box, b2Pos* origin, b2AABB* result )
{
    result->lowerBound.x = b2RoundDownFloat( origin->x + box->lowerBound.x );
    result->lowerBound.y = b2RoundDownFloat( origin->y + box->lowerBound.y );
    result->upperBound.x = b2RoundUpFloat( origin->x + box->upperBound.x );
    result->upperBound.y = b2RoundUpFloat( origin->y + box->upperBound.y );
}

// ---------------------------------------------------------

// a valid AABB has non-negative extents and finite bounds
bool b2IsValidAABB( b2AABB* a )
{
    b2Vec2 d;
    b2Sub( &a->upperBound, &a->lowerBound, &d );
    bool valid = d.x >= 0.0 && d.y >= 0.0;
    valid = valid && b2IsValidVec2( &a->lowerBound ) && b2IsValidVec2( &a->upperBound );
    return valid;
}

// ---------------------------------------------------------

// ray-cast against an AABB (From Real-time Collision Detection, p179).
// Radius not handled. Result is written to *output.
void b2AABB_RayCast( b2AABB* a, b2Vec2* p1, b2Vec2* p2, b2CastOutput* output )
{
    // output = { 0 }
    output->normal.x = 0.0;  output->normal.y = 0.0;
    output->point.x = 0.0;   output->point.y = 0.0;
    output->fraction = 0.0;
    output->iterations = 0;
    output->hit = false;

    float tMin = -FLT_MAX;
    float tMax =  FLT_MAX;

    b2Vec2 p;  p.x = p1->x;  p.y = p1->y;
    b2Vec2 d;     b2Sub( p2, p1, &d );
    b2Vec2 absD;  b2Abs( &d, &absD );

    b2Vec2 normal;  normal.x = 0.0;  normal.y = 0.0;

    // x-coordinate
    if( absD.x < FLT_EPSILON )
    {
        // parallel: reject if origin is outside the slab
        if( p.x < a->lowerBound.x || a->upperBound.x < p.x )
          return;
    }
    else
    {
        float inv_d = 1.0 / d.x;
        float t1 = ( a->lowerBound.x - p.x ) * inv_d;
        float t2 = ( a->upperBound.x - p.x ) * inv_d;
        float s = -1.0;

        if( t1 > t2 )
        {
            float tmp = t1;  t1 = t2;  t2 = tmp;
            s = 1.0;
        }

        if( t1 > tMin )
        {
            normal.y = 0.0;
            normal.x = s;
            tMin = t1;
        }

        tMax = b2MinFloat( tMax, t2 );

        if( tMin > tMax )
          return;
    }

    // y-coordinate
    if( absD.y < FLT_EPSILON )
    {
        if( p.y < a->lowerBound.y || a->upperBound.y < p.y )
          return;
    }
    else
    {
        float inv_d = 1.0 / d.y;
        float t1 = ( a->lowerBound.y - p.y ) * inv_d;
        float t2 = ( a->upperBound.y - p.y ) * inv_d;
        float s = -1.0;

        if( t1 > t2 )
        {
            float tmp = t1;  t1 = t2;  t2 = tmp;
            s = 1.0;
        }

        if( t1 > tMin )
        {
            normal.x = 0.0;
            normal.y = s;
            tMin = t1;
        }

        tMax = b2MinFloat( tMax, t2 );

        if( tMin > tMax )
          return;
    }

    // ray starts inside the box?
    if( tMin < 0.0 )
      return;

    // intersection beyond the segment length?
    if( 1.0 < tMin )
      return;

    // intersection
    output->fraction = tMin;
    output->normal = normal;
    b2Lerp( p1, p2, tMin, &output->point );
    output->hit = true;
}


// *****************************************************************************
    #endif
// *****************************************************************************
