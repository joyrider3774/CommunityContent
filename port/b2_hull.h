/* *****************************************************************************
*  VirconBox2D : b2_hull.h        (port of Box2D v3 src/hull.c)
*  --------------------------------------------------------------------------- *
*  Quickhull convex hull computation and validation.                           *
*                                                                              *
*  Port notes: b2RecurseHull / b2ComputeHull returned a b2Hull by value -> now *
*  out-pointers. The recursion is preserved (depth bounded by vertex count <=  *
*  8, so stack use is small). A forward declaration is provided for the        *
*  recursive helper. Nested vector expressions are unrolled into temps;        *
*  ternaries -> if/else; 'f' suffixes stripped; '{0}' -> field init; the       *
*  small left/right scratch arrays are sized to the full max (harmless).       *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_HULL_H
    #define B2_HULL_H

    #include "b2_math.h"
    #include "b2_constants.h"
    #include "b2_collision.h"
// *****************************************************************************


// forward declaration (the helper is recursive)
void b2RecurseHull( b2Vec2* p1, b2Vec2* p2, b2Vec2* ps, int count, b2Hull* hull );


// quickhull recursion: builds the hull of points to the right of edge p1->p2
void b2RecurseHull( b2Vec2* p1, b2Vec2* p2, b2Vec2* ps, int count, b2Hull* hull )
{
    hull->count = 0;

    if( count == 0 )
      return;

    // edge vector pointing from p1 to p2
    b2Vec2 diff;  b2Sub( p2, p1, &diff );
    b2Vec2 e;     b2Normalize( &diff, &e );

    // discard points left of e and find the point furthest to the right
    b2Vec2[B2_MAX_POLYGON_VERTICES] rightPoints;
    int rightCount = 0;

    int bestIndex = 0;
    b2Vec2 tmp;
    b2Sub( &ps[bestIndex], p1, &tmp );
    float bestDistance = b2Cross( &tmp, &e );

    if( bestDistance > 0.0 )
    {
        rightPoints[rightCount] = ps[bestIndex];
        rightCount++;
    }

    for( int i = 1; i < count; i++ )
    {
        b2Sub( &ps[i], p1, &tmp );
        float distance = b2Cross( &tmp, &e );

        if( distance > bestDistance )
        {
            bestIndex = i;
            bestDistance = distance;
        }

        if( distance > 0.0 )
        {
            rightPoints[rightCount] = ps[i];
            rightCount++;
        }
    }

    if( bestDistance < 2.0 * B2_LINEAR_SLOP )
      return;

    b2Vec2 bestPoint = ps[bestIndex];

    // hull to the right of p1-bestPoint
    b2Hull hull1;
    b2RecurseHull( p1, &bestPoint, rightPoints, rightCount, &hull1 );

    // hull to the right of bestPoint-p2
    b2Hull hull2;
    b2RecurseHull( &bestPoint, p2, rightPoints, rightCount, &hull2 );

    // stitch the hulls together
    for( int i = 0; i < hull1.count; i++ )
    {
        hull->points[hull->count] = hull1.points[i];
        hull->count++;
    }

    hull->points[hull->count] = bestPoint;
    hull->count++;

    for( int i = 0; i < hull2.count; i++ )
    {
        hull->points[hull->count] = hull2.points[i];
        hull->count++;
    }
}

// ---------------------------------------------------------

// Compute the convex hull of a point set. Welds nearby points and removes
// collinear ones (both using B2_LINEAR_SLOP). Returns an empty hull on failure.
void b2ComputeHull( b2Vec2* points, int count, b2Hull* hull )
{
    hull->count = 0;

    if( count < 3 || count > B2_MAX_POLYGON_VERTICES )
      return;

    count = b2MinInt( count, B2_MAX_POLYGON_VERTICES );

    b2AABB aabb;
    aabb.lowerBound.x =  FLT_MAX;  aabb.lowerBound.y =  FLT_MAX;
    aabb.upperBound.x = -FLT_MAX;  aabb.upperBound.y = -FLT_MAX;

    // aggressive point welding; first point always remains. Also build the AABB.
    b2Vec2[B2_MAX_POLYGON_VERTICES] ps;
    int n = 0;
    float linearSlop = B2_LINEAR_SLOP;
    float tolSqr = 16.0 * linearSlop * linearSlop;

    for( int i = 0; i < count; i++ )
    {
        b2Min( &aabb.lowerBound, &points[i], &aabb.lowerBound );
        b2Max( &aabb.upperBound, &points[i], &aabb.upperBound );

        b2Vec2 vi = points[i];

        bool unique = true;
        for( int j = 0; j < i; j++ )
        {
            b2Vec2 vj = points[j];
            float distSqr = b2DistanceSquared( &vi, &vj );
            if( distSqr < tolSqr )
            {
                unique = false;
                break;
            }
        }

        if( unique )
        {
            ps[n] = vi;
            n++;
        }
    }

    if( n < 3 )
      return;

    // find an extreme point (furthest from the AABB center) as the first hull point
    b2Vec2 c;  b2AABB_Center( &aabb, &c );
    int f1 = 0;
    float dsq1 = b2DistanceSquared( &c, &ps[f1] );
    for( int i = 1; i < n; i++ )
    {
        float dsq = b2DistanceSquared( &c, &ps[i] );
        if( dsq > dsq1 )
        {
            f1 = i;
            dsq1 = dsq;
        }
    }

    // remove p1 from the working set
    b2Vec2 p1 = ps[f1];
    ps[f1] = ps[n - 1];
    n = n - 1;

    int f2 = 0;
    float dsq2 = b2DistanceSquared( &p1, &ps[f2] );
    for( int i = 1; i < n; i++ )
    {
        float dsq = b2DistanceSquared( &p1, &ps[i] );
        if( dsq > dsq2 )
        {
            f2 = i;
            dsq2 = dsq;
        }
    }

    // remove p2 from the working set
    b2Vec2 p2 = ps[f2];
    ps[f2] = ps[n - 1];
    n = n - 1;

    // split remaining points into those left and right of line p1-p2
    b2Vec2[B2_MAX_POLYGON_VERTICES] rightPoints;
    int rightCount = 0;
    b2Vec2[B2_MAX_POLYGON_VERTICES] leftPoints;
    int leftCount = 0;

    b2Vec2 diff;  b2Sub( &p2, &p1, &diff );
    b2Vec2 e;     b2Normalize( &diff, &e );

    for( int i = 0; i < n; i++ )
    {
        b2Vec2 t;  b2Sub( &ps[i], &p1, &t );
        float d = b2Cross( &t, &e );

        if( d >= 2.0 * linearSlop )
        {
            rightPoints[rightCount] = ps[i];
            rightCount++;
        }
        else if( d <= -2.0 * linearSlop )
        {
            leftPoints[leftCount] = ps[i];
            leftCount++;
        }
    }

    // recurse on each side
    b2Hull hull1;  b2RecurseHull( &p1, &p2, rightPoints, rightCount, &hull1 );
    b2Hull hull2;  b2RecurseHull( &p2, &p1, leftPoints, leftCount, &hull2 );

    if( hull1.count == 0 && hull2.count == 0 )
      return;

    // stitch, preserving CCW winding
    hull->points[hull->count] = p1;
    hull->count++;

    for( int i = 0; i < hull1.count; i++ )
    {
        hull->points[hull->count] = hull1.points[i];
        hull->count++;
    }

    hull->points[hull->count] = p2;
    hull->count++;

    for( int i = 0; i < hull2.count; i++ )
    {
        hull->points[hull->count] = hull2.points[i];
        hull->count++;
    }

    // merge collinear points
    bool searching = true;
    while( searching && hull->count > 2 )
    {
        searching = false;

        for( int i = 0; i < hull->count; i++ )
        {
            int i1 = i;
            int i2 = ( i + 1 ) % hull->count;
            int i3 = ( i + 2 ) % hull->count;

            b2Vec2 s1 = hull->points[i1];
            b2Vec2 s2 = hull->points[i2];
            b2Vec2 s3 = hull->points[i3];

            b2Vec2 sdiff;  b2Sub( &s3, &s1, &sdiff );
            b2Vec2 r;      b2Normalize( &sdiff, &r );

            b2Vec2 s2s1;   b2Sub( &s2, &s1, &s2s1 );
            float distance = b2Cross( &s2s1, &r );

            if( distance <= 2.0 * linearSlop )
            {
                // remove the midpoint
                for( int j = i2; j < hull->count - 1; j++ )
                  hull->points[j] = hull->points[j + 1];

                hull->count -= 1;
                searching = true;
                break;
            }
        }
    }

    if( hull->count < 3 )
      hull->count = 0;
}

// ---------------------------------------------------------

// Validate that a hull is convex, CCW, and free of collinear points.
bool b2ValidateHull( b2Hull* hull )
{
    if( hull->count < 3 || B2_MAX_POLYGON_VERTICES < hull->count )
      return false;

    // every point must be behind every edge
    for( int i = 0; i < hull->count; i++ )
    {
        int i1 = i;
        int i2 = 0;
        if( i < hull->count - 1 ) i2 = i1 + 1;

        b2Vec2 p = hull->points[i1];
        b2Vec2 ediff;  b2Sub( &hull->points[i2], &p, &ediff );
        b2Vec2 e;      b2Normalize( &ediff, &e );

        for( int j = 0; j < hull->count; j++ )
        {
            // skip the points that form this edge
            if( j == i1 || j == i2 )
              continue;

            b2Vec2 t;  b2Sub( &hull->points[j], &p, &t );
            float distance = b2Cross( &t, &e );
            if( distance >= 0.0 )
              return false;
        }
    }

    // reject collinear triples
    float linearSlop = B2_LINEAR_SLOP;
    for( int i = 0; i < hull->count; i++ )
    {
        int i1 = i;
        int i2 = ( i + 1 ) % hull->count;
        int i3 = ( i + 2 ) % hull->count;

        b2Vec2 p1 = hull->points[i1];
        b2Vec2 p2 = hull->points[i2];
        b2Vec2 p3 = hull->points[i3];

        b2Vec2 ediff;  b2Sub( &p3, &p1, &ediff );
        b2Vec2 e;      b2Normalize( &ediff, &e );

        b2Vec2 p2p1;   b2Sub( &p2, &p1, &p2p1 );
        float distance = b2Cross( &p2p1, &e );
        if( distance <= linearSlop )
          return false;
    }

    return true;
}


// *****************************************************************************
    #endif
// *****************************************************************************
