/* *****************************************************************************
*  VirconBox2D : b2_manifold.h        (port of Box2D v3 src/manifold.c)
*  --------------------------------------------------------------------------- *
*  Contact manifold generation between shape pairs. SLICE 1: the circle-based  *
*  collisions (circle/circle, capsule/circle, polygon/circle), which are       *
*  self-contained on the already-ported math + collision types.                *
*                                                                              *
*  Upstream signature: b2LocalManifold b2CollideX( ..., b2Transform xf ).      *
*  Port idiom: b2LocalManifold is multi-word, so it cannot cross a function    *
*  boundary by value -> every collide function takes a caller-supplied         *
*  b2LocalManifold* as its LAST argument and returns void. xf likewise passes  *
*  by pointer. pointCount is zeroed up front so the beyond-speculative early    *
*  returns simply leave an empty manifold.                                     *
*                                                                              *
*  Deferred to later slices: capsule/capsule, polygon/polygon, segment pairs,  *
*  chain segments, and the id-packing macro B2_MAKE_ID (every id here is 0).   *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_MANIFOLD_H
    #define B2_MANIFOLD_H

    #include "b2_math.h"
    #include "b2_constants.h"
    #include "b2_collision.h"
    #include "b2_distance.h"     // b2ShapeDistance/b2MakeProxy (chain vs polygon)
    #include "b2_geometry.h"     // b2TransformPolygon (chain vs polygon)
// *****************************************************************************


// Pack two feature indices into a contact point id. Upstream uses
// (uint8_t)(A) << 8 | (uint8_t)(B); no uint8_t / no '##' here, so mask to 8 bits
// with & 255 (the id field is a plain int).
#define B2_MAKE_ID( A, B ) ( ( ( ( A ) & 255 ) << 8 ) | ( ( B ) & 255 ) )


// -----------------------------------------------------------------------------
//   Circle vs circle
// -----------------------------------------------------------------------------
void b2CollideCircles( b2Circle* circleA, b2Circle* circleB, b2Transform* xf,
                       b2LocalManifold* manifold )
{
    manifold->pointCount = 0;

    b2Vec2 pointA = circleA->center;
    b2Vec2 pointB;
    b2TransformPoint( xf, &circleB->center, &pointB );

    b2Vec2 d;
    b2Sub( &pointB, &pointA, &d );
    float distance;
    b2Vec2 normal;
    b2GetLengthAndNormalize( &distance, &d, &normal );

    float radiusA = circleA->radius;
    float radiusB = circleB->radius;

    float separation = distance - radiusA - radiusB;
    if( separation > B2_SPECULATIVE_DISTANCE )
        return;

    b2Vec2 cA;  b2MulAdd( &pointA, radiusA, &normal, &cA );
    b2Vec2 cB;  b2MulAdd( &pointB, -radiusB, &normal, &cB );

    manifold->normal = normal;
    b2LocalManifoldPoint* mp = &manifold->points[0];
    b2Lerp( &cA, &cB, 0.5, &mp->point );
    mp->separation = separation;
    mp->id = 0;
    manifold->pointCount = 1;
}


// -----------------------------------------------------------------------------
//   Capsule vs circle
// -----------------------------------------------------------------------------
void b2CollideCapsuleAndCircle( b2Capsule* capsuleA, b2Circle* circleB,
                                b2Transform* xf, b2LocalManifold* manifold )
{
    manifold->pointCount = 0;

    // circle position in the frame of the capsule
    b2Vec2 pB;
    b2TransformPoint( xf, &circleB->center, &pB );

    // closest point on the capsule core segment [p1,p2]
    b2Vec2 p1 = capsuleA->center1;
    b2Vec2 p2 = capsuleA->center2;
    b2Vec2 e;
    b2Sub( &p2, &p1, &e );

    b2Vec2 tmp1;  b2Sub( &pB, &p1, &tmp1 );
    float s1 = b2Dot( &tmp1, &e );
    b2Vec2 tmp2;  b2Sub( &p2, &pB, &tmp2 );
    float s2 = b2Dot( &tmp2, &e );

    b2Vec2 pA;
    if( s1 < 0.0 )
    {
        // p1 region
        pA = p1;
    }
    else if( s2 < 0.0 )
    {
        // p2 region
        pA = p2;
    }
    else
    {
        // circle colliding with segment interior
        float s = s1 / b2Dot( &e, &e );
        b2MulAdd( &p1, s, &e, &pA );
    }

    b2Vec2 d;
    b2Sub( &pB, &pA, &d );
    float distance;
    b2Vec2 normal;
    b2GetLengthAndNormalize( &distance, &d, &normal );

    float radiusA = capsuleA->radius;
    float radiusB = circleB->radius;
    float separation = distance - radiusA - radiusB;
    if( separation > B2_SPECULATIVE_DISTANCE )
        return;

    b2Vec2 cA;  b2MulAdd( &pA, radiusA, &normal, &cA );
    b2Vec2 cB;  b2MulAdd( &pB, -radiusB, &normal, &cB );

    manifold->normal = normal;
    b2LocalManifoldPoint* mp = &manifold->points[0];
    b2Lerp( &cA, &cB, 0.5, &mp->point );
    mp->separation = separation;
    mp->id = 0;
    manifold->pointCount = 1;
}


// -----------------------------------------------------------------------------
//   Polygon vs circle
// -----------------------------------------------------------------------------
void b2CollidePolygonAndCircle( b2Polygon* polygonA, b2Circle* circleB,
                                b2Transform* xf, b2LocalManifold* manifold )
{
    manifold->pointCount = 0;
    float speculativeDistance = B2_SPECULATIVE_DISTANCE;

    // circle position in the frame of the polygon
    b2Vec2 center;
    b2TransformPoint( xf, &circleB->center, &center );
    float radiusA = polygonA->radius;
    float radiusB = circleB->radius;
    float radius = radiusA + radiusB;

    // find the min separating edge
    int normalIndex = 0;
    float separation = -FLT_MAX;
    int vertexCount = polygonA->count;

    int i;
    for( i = 0; i < vertexCount; ++i )
    {
        b2Vec2 cmv;
        b2Sub( &center, &polygonA->vertices[i], &cmv );
        float s = b2Dot( &polygonA->normals[i], &cmv );
        if( s > separation )
        {
            separation = s;
            normalIndex = i;
        }
    }

    if( separation > radius + speculativeDistance )
        return;

    // vertices of the reference edge
    int vertIndex1 = normalIndex;
    int vertIndex2;
    if( vertIndex1 + 1 < vertexCount )
        vertIndex2 = vertIndex1 + 1;
    else
        vertIndex2 = 0;
    b2Vec2 v1 = polygonA->vertices[vertIndex1];
    b2Vec2 v2 = polygonA->vertices[vertIndex2];

    // barycentric coordinates
    b2Vec2 cmv1;   b2Sub( &center, &v1, &cmv1 );
    b2Vec2 v2mv1;  b2Sub( &v2, &v1, &v2mv1 );
    float u1 = b2Dot( &cmv1, &v2mv1 );
    b2Vec2 cmv2;   b2Sub( &center, &v2, &cmv2 );
    b2Vec2 v1mv2;  b2Sub( &v1, &v2, &v1mv2 );
    float u2 = b2Dot( &cmv2, &v1mv2 );

    if( u1 < 0.0 && separation > FLT_EPSILON )
    {
        // circle center is closest to v1 and safely outside the polygon
        b2Vec2 dv;  b2Sub( &center, &v1, &dv );
        b2Vec2 normal;
        b2Normalize( &dv, &normal );
        separation = b2Dot( &dv, &normal );
        if( separation > radius + speculativeDistance )
            return;

        b2Vec2 cA;  b2MulAdd( &v1, radiusA, &normal, &cA );
        b2Vec2 cB;  b2MulSub( &center, radiusB, &normal, &cB );

        manifold->normal = normal;
        b2LocalManifoldPoint* mp = &manifold->points[0];
        b2Lerp( &cA, &cB, 0.5, &mp->point );
        b2Vec2 cBmcA;  b2Sub( &cB, &cA, &cBmcA );
        mp->separation = b2Dot( &cBmcA, &normal );
        mp->id = 0;
        manifold->pointCount = 1;
    }
    else if( u2 < 0.0 && separation > FLT_EPSILON )
    {
        // circle center is closest to v2 and safely outside the polygon
        b2Vec2 dv;  b2Sub( &center, &v2, &dv );
        b2Vec2 normal;
        b2Normalize( &dv, &normal );
        separation = b2Dot( &dv, &normal );
        if( separation > radius + speculativeDistance )
            return;

        b2Vec2 cA;  b2MulAdd( &v2, radiusA, &normal, &cA );
        b2Vec2 cB;  b2MulSub( &center, radiusB, &normal, &cB );

        manifold->normal = normal;
        b2LocalManifoldPoint* mp = &manifold->points[0];
        b2Lerp( &cA, &cB, 0.5, &mp->point );
        b2Vec2 cBmcA;  b2Sub( &cB, &cA, &cBmcA );
        mp->separation = b2Dot( &cBmcA, &normal );
        mp->id = 0;
        manifold->pointCount = 1;
    }
    else
    {
        // circle center is between v1 and v2; center may be inside polygon
        b2Vec2 normal = polygonA->normals[normalIndex];
        manifold->normal = normal;

        // cA = projection of the circle center onto the reference edge
        b2Vec2 cmv1b;  b2Sub( &center, &v1, &cmv1b );
        float coef = radiusA - b2Dot( &cmv1b, &normal );
        b2Vec2 cA;  b2MulAdd( &center, coef, &normal, &cA );

        // cB = deepest point on the circle wrt the reference edge
        b2Vec2 cB;  b2MulSub( &center, radiusB, &normal, &cB );

        b2LocalManifoldPoint* mp = &manifold->points[0];
        b2Lerp( &cA, &cB, 0.5, &mp->point );
        mp->separation = separation - radius;
        mp->id = 0;
        manifold->pointCount = 1;
    }
}


// -----------------------------------------------------------------------------
//   Capsule vs capsule  (Ericson 5.1.9 closest points + clipping for 2 points)
// -----------------------------------------------------------------------------
void b2CollideCapsules( b2Capsule* capsuleA, b2Capsule* capsuleB, b2Transform* xf,
                        b2LocalManifold* manifold )
{
    manifold->pointCount = 0;

    b2Vec2 origin = capsuleA->center1;

    // shift to the origin in frame A for round-off (pure translation in A's frame)
    b2Transform xfs;
    b2Sub( &xf->p, &origin, &xfs.p );
    xfs.q = xf->q;

    b2Vec2 p1 = b2Vec2_zero;
    b2Vec2 q1;  b2Sub( &capsuleA->center2, &origin, &q1 );

    b2Vec2 p2;  b2TransformPoint( &xfs, &capsuleB->center1, &p2 );
    b2Vec2 q2;  b2TransformPoint( &xfs, &capsuleB->center2, &q2 );

    b2Vec2 d1;  b2Sub( &q1, &p1, &d1 );
    b2Vec2 d2;  b2Sub( &q2, &p2, &d2 );

    float dd1 = b2Dot( &d1, &d1 );
    float dd2 = b2Dot( &d2, &d2 );

    float epsSqr = FLT_EPSILON * FLT_EPSILON;
    // B2_ASSERT( dd1 > epsSqr && dd2 > epsSqr ) omitted

    b2Vec2 r;  b2Sub( &p1, &p2, &r );
    float rd1 = b2Dot( &r, &d1 );
    float rd2 = b2Dot( &r, &d2 );

    float d12 = b2Dot( &d1, &d2 );
    float denom = dd1 * dd2 - d12 * d12;

    // fraction on segment 1
    float f1 = 0.0;
    if( denom != 0.0 )
        f1 = b2ClampFloat( ( d12 * rd2 - rd1 * dd2 ) / denom, 0.0, 1.0 );

    // point on segment 2 closest to p1 + f1 * d1
    float f2 = ( d12 * f1 + rd2 ) / dd2;

    // clamping segment 2 requires a do over on segment 1
    if( f2 < 0.0 )
    {
        f2 = 0.0;
        f1 = b2ClampFloat( -rd1 / dd1, 0.0, 1.0 );
    }
    else if( f2 > 1.0 )
    {
        f2 = 1.0;
        f1 = b2ClampFloat( ( d12 - rd1 ) / dd1, 0.0, 1.0 );
    }

    b2Vec2 closest1;  b2MulAdd( &p1, f1, &d1, &closest1 );
    b2Vec2 closest2;  b2MulAdd( &p2, f2, &d2, &closest2 );
    float distanceSquared = b2DistanceSquared( &closest1, &closest2 );

    float radiusA = capsuleA->radius;
    float radiusB = capsuleB->radius;
    float radius = radiusA + radiusB;
    float maxDistance = radius + B2_SPECULATIVE_DISTANCE;

    if( distanceSquared > maxDistance * maxDistance )
        return;

    float distance = sqrt( distanceSquared );

    float length1, length2;
    b2Vec2 u1;  b2GetLengthAndNormalize( &length1, &d1, &u1 );
    b2Vec2 u2;  b2GetLengthAndNormalize( &length2, &d2, &u2 );

    // does segment B project outside segment A?
    b2Vec2 tv;
    b2Sub( &p2, &p1, &tv );  float fp2 = b2Dot( &tv, &u1 );
    b2Sub( &q2, &p1, &tv );  float fq2 = b2Dot( &tv, &u1 );
    bool outsideA = ( fp2 <= 0.0 && fq2 <= 0.0 ) || ( fp2 >= length1 && fq2 >= length1 );

    // does segment A project outside segment B?
    b2Sub( &p1, &p2, &tv );  float fp1 = b2Dot( &tv, &u2 );
    b2Sub( &q1, &p2, &tv );  float fq1 = b2Dot( &tv, &u2 );
    bool outsideB = ( fp1 <= 0.0 && fq1 <= 0.0 ) || ( fp1 >= length2 && fq1 >= length2 );

    if( outsideA == false && outsideB == false )
    {
        // attempt to clip; may yield points with excessive separation, in which
        // case we fall back to single-point collision below.

        // reference edge of A via SAT
        b2Vec2 normalA;
        float separationA;
        {
            b2LeftPerp( &u1, &normalA );
            b2Sub( &p2, &p1, &tv );  float ss1 = b2Dot( &tv, &normalA );
            b2Sub( &q2, &p1, &tv );  float ss2 = b2Dot( &tv, &normalA );
            float s1p = b2MinFloat( ss1, ss2 );
            float s1n = b2MinFloat( -ss1, -ss2 );
            if( s1p > s1n )
            {
                separationA = s1p;
            }
            else
            {
                separationA = s1n;
                b2Neg( &normalA, &normalA );
            }
        }

        // reference edge of B via SAT
        b2Vec2 normalB;
        float separationB;
        {
            b2LeftPerp( &u2, &normalB );
            b2Sub( &p1, &p2, &tv );  float ss1 = b2Dot( &tv, &normalB );
            b2Sub( &q1, &p2, &tv );  float ss2 = b2Dot( &tv, &normalB );
            float s1p = b2MinFloat( ss1, ss2 );
            float s1n = b2MinFloat( -ss1, -ss2 );
            if( s1p > s1n )
            {
                separationB = s1p;
            }
            else
            {
                separationB = s1n;
                b2Neg( &normalB, &normalB );
            }
        }

        // biased to avoid feature flip-flop
        if( separationA + 0.1 * B2_LINEAR_SLOP >= separationB )
        {
            manifold->normal = normalA;
            b2Vec2 cp = p2;
            b2Vec2 cq = q2;

            // clip to p1
            if( fp2 < 0.0 && fq2 > 0.0 )
                b2Lerp( &p2, &q2, ( 0.0 - fp2 ) / ( fq2 - fp2 ), &cp );
            else if( fq2 < 0.0 && fp2 > 0.0 )
                b2Lerp( &q2, &p2, ( 0.0 - fq2 ) / ( fp2 - fq2 ), &cq );

            // clip to q1
            if( fp2 > length1 && fq2 < length1 )
                b2Lerp( &p2, &q2, ( fp2 - length1 ) / ( fp2 - fq2 ), &cp );
            else if( fq2 > length1 && fp2 < length1 )
                b2Lerp( &q2, &p2, ( fq2 - length1 ) / ( fq2 - fp2 ), &cq );

            b2Sub( &cp, &p1, &tv );  float sp = b2Dot( &tv, &normalA );
            b2Sub( &cq, &p1, &tv );  float sq = b2Dot( &tv, &normalA );

            if( sp <= distance + B2_LINEAR_SLOP || sq <= distance + B2_LINEAR_SLOP )
            {
                b2LocalManifoldPoint* mp;
                mp = &manifold->points[0];
                b2MulAdd( &cp, 0.5 * ( radiusA - radiusB - sp ), &normalA, &mp->point );
                mp->separation = sp - radius;
                mp->id = B2_MAKE_ID( 0, 0 );

                mp = &manifold->points[1];
                b2MulAdd( &cq, 0.5 * ( radiusA - radiusB - sq ), &normalA, &mp->point );
                mp->separation = sq - radius;
                mp->id = B2_MAKE_ID( 0, 1 );
                manifold->pointCount = 2;
            }
        }
        else
        {
            // normal always points from A to B
            b2Neg( &normalB, &manifold->normal );
            b2Vec2 cp = p1;
            b2Vec2 cq = q1;

            // clip to p2
            if( fp1 < 0.0 && fq1 > 0.0 )
                b2Lerp( &p1, &q1, ( 0.0 - fp1 ) / ( fq1 - fp1 ), &cp );
            else if( fq1 < 0.0 && fp1 > 0.0 )
                b2Lerp( &q1, &p1, ( 0.0 - fq1 ) / ( fp1 - fq1 ), &cq );

            // clip to q2
            if( fp1 > length2 && fq1 < length2 )
                b2Lerp( &p1, &q1, ( fp1 - length2 ) / ( fp1 - fq1 ), &cp );
            else if( fq1 > length2 && fp1 < length2 )
                b2Lerp( &q1, &p1, ( fq1 - length2 ) / ( fq1 - fp1 ), &cq );

            b2Sub( &cp, &p2, &tv );  float sp = b2Dot( &tv, &normalB );
            b2Sub( &cq, &p2, &tv );  float sq = b2Dot( &tv, &normalB );

            if( sp <= distance + B2_LINEAR_SLOP || sq <= distance + B2_LINEAR_SLOP )
            {
                b2LocalManifoldPoint* mp;
                mp = &manifold->points[0];
                b2MulAdd( &cp, 0.5 * ( radiusB - radiusA - sp ), &normalB, &mp->point );
                mp->separation = sp - radius;
                mp->id = B2_MAKE_ID( 0, 0 );
                mp = &manifold->points[1];
                b2MulAdd( &cq, 0.5 * ( radiusB - radiusA - sq ), &normalB, &mp->point );
                mp->separation = sq - radius;
                mp->id = B2_MAKE_ID( 1, 0 );
                manifold->pointCount = 2;
            }
        }
    }

    if( manifold->pointCount == 0 )
    {
        // single point collision
        b2Vec2 normal;  b2Sub( &closest2, &closest1, &normal );
        if( b2Dot( &normal, &normal ) > epsSqr )
            b2Normalize( &normal, &normal );
        else
            b2LeftPerp( &u1, &normal );

        b2Vec2 c1;  b2MulAdd( &closest1, radiusA, &normal, &c1 );
        b2Vec2 c2;  b2MulAdd( &closest2, -radiusB, &normal, &c2 );

        int i1;  if( f1 == 0.0 ) i1 = 0; else i1 = 1;
        int i2;  if( f2 == 0.0 ) i2 = 0; else i2 = 1;

        manifold->normal = normal;
        b2LocalManifoldPoint* mp = &manifold->points[0];
        b2Lerp( &c1, &c2, 0.5, &mp->point );
        mp->separation = sqrt( distanceSquared ) - radius;
        mp->id = B2_MAKE_ID( i1, i2 );
        manifold->pointCount = 1;
    }

    // undo the origin shift so points are in frame A.
    // Unrolled with constant indices: taking the address of a variable-indexed
    // member of a struct array ( &manifold->points[i].point ) miscompiles here
    // (only constant [0]/[1] indices into struct arrays are safe -- see dialect doc).
    if( manifold->pointCount > 0 )
    {
        b2LocalManifoldPoint* mp = &manifold->points[0];
        b2Add( &mp->point, &origin, &mp->point );
    }
    if( manifold->pointCount > 1 )
    {
        b2LocalManifoldPoint* mp = &manifold->points[1];
        b2Add( &mp->point, &origin, &mp->point );
    }
}


// -----------------------------------------------------------------------------
//   Segment vs circle / capsule  (thin wrappers: a segment is a zero-radius
//   capsule). Segment-vs-polygon is deferred until b2CollidePolygons exists.
// -----------------------------------------------------------------------------
void b2CollideSegmentAndCircle( b2Segment* segmentA, b2Circle* circleB,
                                b2Transform* xf, b2LocalManifold* manifold )
{
    b2Capsule capsuleA;
    capsuleA.center1 = segmentA->point1;
    capsuleA.center2 = segmentA->point2;
    capsuleA.radius = 0.0;
    b2CollideCapsuleAndCircle( &capsuleA, circleB, xf, manifold );
}

void b2CollideSegmentAndCapsule( b2Segment* segmentA, b2Capsule* capsuleB,
                                 b2Transform* xf, b2LocalManifold* manifold )
{
    b2Capsule capsuleA;
    capsuleA.center1 = segmentA->point1;
    capsuleA.center2 = segmentA->point2;
    capsuleA.radius = 0.0;
    b2CollideCapsules( &capsuleA, capsuleB, xf, manifold );
}


// -----------------------------------------------------------------------------
//   Chain-segment collisions (SLICE 3) -- one-sided, ghost-vertex culled.
// -----------------------------------------------------------------------------
//   A chain segment collides only from its RIGHT side (normal = RightPerp(edge))
//   and uses its ghost vertices to reject contacts that belong to a neighbouring
//   segment's Voronoi region, so a body sliding across a junction never catches a
//   phantom edge (the "ghost collision" problem). Port of manifold.c
//   b2CollideChainSegmentAndCircle. Capsule/polygon chain collisions are DEFERRED
//   (they need the ~300-line b2CollideChainSegmentAndPolygon ghost-Gauss-map path).
void b2CollideChainSegmentAndCircle( b2ChainSegment* segmentA, b2Circle* circleB,
                                     b2Transform* xf, b2LocalManifold* manifold )
{
    manifold->pointCount = 0;

    // circle center in the segment's frame
    b2Vec2 pB;  b2TransformPoint( xf, &circleB->center, &pB );

    b2Vec2 p1 = segmentA->segment.point1;
    b2Vec2 p2 = segmentA->segment.point2;
    b2Vec2 e;  b2Sub( &p2, &p1, &e );

    // one-sided: the normal points right; reject centers on the left/back side
    b2Vec2 eRight;  b2RightPerp( &e, &eRight );
    b2Vec2 pBmp1;   b2Sub( &pB, &p1, &pBmp1 );
    float offset = b2Dot( &eRight, &pBmp1 );
    if( offset < 0.0 )
        return;

    // barycentric coordinates of pB along the edge
    b2Vec2 p2mpB;  b2Sub( &p2, &pB, &p2mpB );
    float u = b2Dot( &e, &p2mpB );
    float v = b2Dot( &e, &pBmp1 );

    b2Vec2 pA;
    if( v <= 0.0 )
    {
        // behind point1 -- only collide if pB is in THIS segment's Voronoi region
        // (not the previous edge ghost1->p1), else the neighbour owns it
        b2Vec2 prevEdge;  b2Sub( &p1, &segmentA->ghost1, &prevEdge );
        float uPrev = b2Dot( &prevEdge, &pBmp1 );
        if( uPrev <= 0.0 )
            return;
        pA = p1;
    }
    else if( u <= 0.0 )
    {
        // ahead of point2 -- reject if pB is in the next edge's (p2->ghost2) region
        b2Vec2 nextEdge;  b2Sub( &segmentA->ghost2, &p2, &nextEdge );
        b2Vec2 pBmp2;     b2Sub( &pB, &p2, &pBmp2 );
        float vNext = b2Dot( &nextEdge, &pBmp2 );
        if( vNext > 0.0 )
            return;
        pA = p2;
    }
    else
    {
        // projection onto the segment interior: pA = (u*p1 + v*p2) / (e.e)
        float ee = b2Dot( &e, &e );
        b2Vec2 num;
        num.x = u * p1.x + v * p2.x;
        num.y = u * p1.y + v * p2.y;
        if( ee > 0.0 )
            b2MulSV( 1.0 / ee, &num, &pA );
        else
            pA = p1;
    }

    float distance;
    b2Vec2 d;       b2Sub( &pB, &pA, &d );
    b2Vec2 normal;  b2GetLengthAndNormalize( &distance, &d, &normal );

    float radius = circleB->radius;
    float separation = distance - radius;
    if( separation > B2_SPECULATIVE_DISTANCE )
        return;

    b2Vec2 cA = pA;
    b2Vec2 cB;  b2MulAdd( &pB, -radius, &normal, &cB );   // pB - radius*normal

    manifold->normal = normal;
    b2Vec2 mid;  b2Lerp( &cA, &cB, 0.5, &mid );
    manifold->points[0].point = mid;
    manifold->points[0].separation = separation;
    manifold->points[0].id = 0;
    manifold->pointCount = 1;
}


// -----------------------------------------------------------------------------
//   Polygon collisions (SLICE 2b)
// -----------------------------------------------------------------------------

// Build a 2-vertex "capsule" polygon (the manifold module treats a capsule as a
// 2-gon with a radius). Named *Polygon to avoid colliding with any public
// capsule maker. (upstream static b2MakeCapsule in manifold.c)
void b2MakeCapsulePolygon( b2Vec2* p1, b2Vec2* p2, float radius, b2Polygon* shape )
{
    memset( shape, 0, sizeof( b2Polygon ) );
    shape->vertices[0] = *p1;
    shape->vertices[1] = *p2;
    b2Lerp( p1, p2, 0.5, &shape->centroid );

    b2Vec2 d;     b2Sub( p2, p1, &d );
    b2Vec2 axis;  b2Normalize( &d, &axis );
    b2Vec2 normal;  b2RightPerp( &axis, &normal );

    shape->normals[0] = normal;
    b2Neg( &normal, &shape->normals[1] );
    shape->count = 2;
    shape->radius = radius;
}

// ---------------------------------------------------------

// Max separation between poly1 and poly2 using poly1's edge normals.
float b2FindMaxSeparation( int* edgeIndex, b2Polygon* poly1, b2Polygon* poly2 )
{
    int count1 = poly1->count;
    int count2 = poly2->count;

    int bestIndex = 0;
    float maxSeparation = -FLT_MAX;
    int i;
    for( i = 0; i < count1; ++i )
    {
        b2Vec2 n = poly1->normals[i];
        b2Vec2 v1 = poly1->vertices[i];

        // deepest point of poly2 for normal i
        // HOT PATH (5.6): b2Sub+b2Dot inlined as scalar math on LOCAL copies. The
        // per-element whole-struct copy `v2 = poly2->vertices[j]` is the proven-green
        // variable-index form (same as b2ClipPolygons); arithmetic touches only locals,
        // so no fixed-array-member value-index read is introduced. sij = dot(n, v2-v1).
        float si = FLT_MAX;
        int j;
        for( j = 0; j < count2; ++j )
        {
            b2Vec2 v2 = poly2->vertices[j];
            float sij = n.x * ( v2.x - v1.x ) + n.y * ( v2.y - v1.y );
            if( sij < si )
                si = sij;
        }

        if( si > maxSeparation )
        {
            maxSeparation = si;
            bestIndex = i;
        }
    }

    *edgeIndex = bestIndex;
    return maxSeparation;
}

// ---------------------------------------------------------

// Clip the reference edge (edgeA on polyA / edgeB on polyB, flipped if 'flip')
// against the incident edge to produce up to two contact points.
void b2ClipPolygons( b2Polygon* polyA, b2Polygon* polyB, int edgeA, int edgeB,
                     bool flip, b2LocalManifold* manifold )
{
    manifold->pointCount = 0;

    // reference polygon
    b2Polygon* poly1;
    int i11, i12;
    // incident polygon
    b2Polygon* poly2;
    int i21, i22;

    if( flip )
    {
        poly1 = polyB;
        poly2 = polyA;
        i11 = edgeB;
        if( edgeB + 1 < polyB->count ) i12 = edgeB + 1; else i12 = 0;
        i21 = edgeA;
        if( edgeA + 1 < polyA->count ) i22 = edgeA + 1; else i22 = 0;
    }
    else
    {
        poly1 = polyA;
        poly2 = polyB;
        i11 = edgeA;
        if( edgeA + 1 < polyA->count ) i12 = edgeA + 1; else i12 = 0;
        i21 = edgeB;
        if( edgeB + 1 < polyB->count ) i22 = edgeB + 1; else i22 = 0;
    }

    b2Vec2 normal = poly1->normals[i11];

    // reference edge vertices
    b2Vec2 v11 = poly1->vertices[i11];
    b2Vec2 v12 = poly1->vertices[i12];
    // incident edge vertices
    b2Vec2 v21 = poly2->vertices[i21];
    b2Vec2 v22 = poly2->vertices[i22];

    // HOT PATH (5.6): vector helpers inlined as scalar math. normal/tangent and
    // v11..v22 are all LOCAL b2Vec2 (v11..v22 are the proven-green whole-struct
    // variable-index copies above), so this touches only locals -- no array-member
    // value-index read introduced. Semantics identical to the b2CrossSV/b2Sub/b2Dot/
    // b2Lerp/b2MulAdd sequence it replaces.
    // tangent = b2CrossSV(1, normal) = { -normal.y, normal.x }
    b2Vec2 tangent;  tangent.x = -normal.y;  tangent.y = normal.x;

    float lower1 = 0.0;
    float upper1 = ( v12.x - v11.x ) * tangent.x + ( v12.y - v11.y ) * tangent.y;

    // incident edge points opposite of tangent due to CCW winding
    float upper2 = ( v21.x - v11.x ) * tangent.x + ( v21.y - v11.y ) * tangent.y;
    float lower2 = ( v22.x - v11.x ) * tangent.x + ( v22.y - v11.y ) * tangent.y;

    // disjoint?
    if( upper2 < lower1 || upper1 < lower2 )
        return;

    b2Vec2 vLower;
    if( lower2 < lower1 && upper2 - lower2 > FLT_EPSILON )
    {
        // b2Lerp(v22, v21, t) = (1-t)*v22 + t*v21
        float t = ( lower1 - lower2 ) / ( upper2 - lower2 );
        vLower.x = ( 1.0 - t ) * v22.x + t * v21.x;
        vLower.y = ( 1.0 - t ) * v22.y + t * v21.y;
    }
    else
        vLower = v22;

    b2Vec2 vUpper;
    if( upper2 > upper1 && upper2 - lower2 > FLT_EPSILON )
    {
        float t = ( upper1 - lower2 ) / ( upper2 - lower2 );
        vUpper.x = ( 1.0 - t ) * v22.x + t * v21.x;
        vUpper.y = ( 1.0 - t ) * v22.y + t * v21.y;
    }
    else
        vUpper = v21;

    float separationLower = ( vLower.x - v11.x ) * normal.x + ( vLower.y - v11.y ) * normal.y;
    float separationUpper = ( vUpper.x - v11.x ) * normal.x + ( vUpper.y - v11.y ) * normal.y;

    float r1 = poly1->radius;
    float r2 = poly2->radius;

    // put contact points at the midpoint, accounting for radii (b2MulAdd inlined)
    float sL = 0.5 * ( r1 - r2 - separationLower );
    b2Vec2 cLower;  cLower.x = vLower.x + sL * normal.x;  cLower.y = vLower.y + sL * normal.y;
    float sU = 0.5 * ( r1 - r2 - separationUpper );
    b2Vec2 cUpper;  cUpper.x = vUpper.x + sU * normal.x;  cUpper.y = vUpper.y + sU * normal.y;

    float radius = r1 + r2;

    if( flip == false )
    {
        manifold->normal = normal;
        b2LocalManifoldPoint* cp = &manifold->points[0];
        cp->point = cLower;
        cp->separation = separationLower - radius;
        cp->id = B2_MAKE_ID( i11, i22 );

        cp = &manifold->points[1];
        cp->point = cUpper;
        cp->separation = separationUpper - radius;
        cp->id = B2_MAKE_ID( i12, i21 );
        manifold->pointCount = 2;
    }
    else
    {
        // manifold->normal = -normal (b2Neg inlined)
        manifold->normal.x = -normal.x;  manifold->normal.y = -normal.y;
        b2LocalManifoldPoint* cp = &manifold->points[0];
        cp->point = cUpper;
        cp->separation = separationUpper - radius;
        cp->id = B2_MAKE_ID( i21, i12 );

        cp = &manifold->points[1];
        cp->point = cLower;
        cp->separation = separationLower - radius;
        cp->id = B2_MAKE_ID( i22, i11 );
        manifold->pointCount = 2;
    }
}

// ---------------------------------------------------------

// Contact manifold between two convex polygons (every polygon is rounded due to
// speculation). Ports the active (#if 1) upstream path.
void b2CollidePolygons( b2Polygon* polygonA, b2Polygon* polygonB, b2Transform* xf,
                        b2LocalManifold* manifold )
{
    manifold->pointCount = 0;

    b2Vec2 origin = polygonA->vertices[0];
    float linearSlop = B2_LINEAR_SLOP;
    float speculativeDistance = B2_SPECULATIVE_DISTANCE;

    // shift to the origin in frame A for round-off (pure translation in A's frame)
    b2Transform xfs;
    b2Sub( &xf->p, &origin, &xfs.p );
    xfs.q = xf->q;

    // localPolyA: polygonA shifted to origin. Access through a pointer so every
    // variable-index array read/write uses the proven-safe &ptr->arr[i] form
    // (variable-index into a *local* struct lacks a known-good precedent here).
    b2Polygon localPolyA;
    b2Polygon* lpA = &localPolyA;
    lpA->count = polygonA->count;
    lpA->radius = polygonA->radius;
    lpA->vertices[0] = b2Vec2_zero;
    lpA->normals[0] = polygonA->normals[0];
    int i;
    for( i = 1; i < lpA->count; ++i )
    {
        b2Sub( &polygonA->vertices[i], &origin, &lpA->vertices[i] );
        lpA->normals[i] = polygonA->normals[i];
    }

    // localPolyB: polygonB in polyA's frame (same pointer-access rationale)
    b2Polygon localPolyB;
    b2Polygon* lpB = &localPolyB;
    lpB->count = polygonB->count;
    lpB->radius = polygonB->radius;
    for( i = 0; i < lpB->count; ++i )
    {
        b2TransformPoint( &xfs, &polygonB->vertices[i], &lpB->vertices[i] );
        b2RotateVector( &xfs.q, &polygonB->normals[i], &lpB->normals[i] );
    }

    int edgeA = 0;
    float separationA = b2FindMaxSeparation( &edgeA, lpA, lpB );

    int edgeB = 0;
    float separationB = b2FindMaxSeparation( &edgeB, lpB, lpA );

    float radius = lpA->radius + lpB->radius;

    if( separationA > speculativeDistance + radius || separationB > speculativeDistance + radius )
        return;

    // find incident edge
    bool flip;
    if( separationA >= separationB )
    {
        flip = false;
        b2Vec2 searchDirection = lpA->normals[edgeA];
        int count = lpB->count;
        edgeB = 0;
        float minDot = FLT_MAX;
        for( i = 0; i < count; ++i )
        {
            float dot = b2Dot( &searchDirection, &lpB->normals[i] );
            if( dot < minDot )
            {
                minDot = dot;
                edgeB = i;
            }
        }
    }
    else
    {
        flip = true;
        b2Vec2 searchDirection = lpB->normals[edgeB];
        int count = lpA->count;
        edgeA = 0;
        float minDot = FLT_MAX;
        for( i = 0; i < count; ++i )
        {
            float dot = b2Dot( &searchDirection, &lpA->normals[i] );
            if( dot < minDot )
            {
                minDot = dot;
                edgeA = i;
            }
        }
    }

    // using slop so vertex-vertex normals can be safely normalized
    if( separationA > 0.1 * linearSlop || separationB > 0.1 * linearSlop )
    {
        // edges are disjoint: closest points between reference and incident edge
        int i11 = edgeA;
        int i12;  if( edgeA + 1 < lpA->count ) i12 = edgeA + 1; else i12 = 0;
        int i21 = edgeB;
        int i22;  if( edgeB + 1 < lpB->count ) i22 = edgeB + 1; else i22 = 0;

        b2Vec2 v11 = lpA->vertices[i11];
        b2Vec2 v12 = lpA->vertices[i12];
        b2Vec2 v21 = lpB->vertices[i21];
        b2Vec2 v22 = lpB->vertices[i22];

        b2SegmentDistanceResult result;
        b2SegmentDistance( &v11, &v12, &v21, &v22, &result );
        float distance = sqrt( result.distanceSquared );
        float separation = distance - radius;

        if( distance - radius > speculativeDistance )
            return;   // can happen in the vertex-vertex case

        // attempt to clip edges (fills manifold)
        b2ClipPolygons( lpA, lpB, edgeA, edgeB, flip, manifold );

        // min separation across clip points (unrolled; <=2 points)
        float minSeparation = FLT_MAX;
        if( manifold->pointCount > 0 )
            minSeparation = b2MinFloat( minSeparation, manifold->points[0].separation );
        if( manifold->pointCount > 1 )
            minSeparation = b2MinFloat( minSeparation, manifold->points[1].separation );

        // does vertex-vertex have substantially larger separation?
        if( separation + 0.1 * linearSlop < minSeparation )
        {
            float invDistance = 1.0 / distance;
            if( result.fraction1 == 0.0 && result.fraction2 == 0.0 )
            {
                // v11 - v21
                b2Vec2 normal;  b2Sub( &v21, &v11, &normal );
                normal.x = normal.x * invDistance;
                normal.y = normal.y * invDistance;
                b2Vec2 c1;  b2MulAdd( &v11, lpA->radius, &normal, &c1 );
                b2Vec2 c2;  b2MulAdd( &v21, -lpB->radius, &normal, &c2 );
                manifold->normal = normal;
                b2Lerp( &c1, &c2, 0.5, &manifold->points[0].point );
                manifold->points[0].separation = distance - radius;
                manifold->points[0].id = B2_MAKE_ID( i11, i21 );
                manifold->pointCount = 1;
            }
            else if( result.fraction1 == 0.0 && result.fraction2 == 1.0 )
            {
                // v11 - v22
                b2Vec2 normal;  b2Sub( &v22, &v11, &normal );
                normal.x = normal.x * invDistance;
                normal.y = normal.y * invDistance;
                b2Vec2 c1;  b2MulAdd( &v11, lpA->radius, &normal, &c1 );
                b2Vec2 c2;  b2MulAdd( &v22, -lpB->radius, &normal, &c2 );
                manifold->normal = normal;
                b2Lerp( &c1, &c2, 0.5, &manifold->points[0].point );
                manifold->points[0].separation = distance - radius;
                manifold->points[0].id = B2_MAKE_ID( i11, i22 );
                manifold->pointCount = 1;
            }
            else if( result.fraction1 == 1.0 && result.fraction2 == 0.0 )
            {
                // v12 - v21
                b2Vec2 normal;  b2Sub( &v21, &v12, &normal );
                normal.x = normal.x * invDistance;
                normal.y = normal.y * invDistance;
                b2Vec2 c1;  b2MulAdd( &v12, lpA->radius, &normal, &c1 );
                b2Vec2 c2;  b2MulAdd( &v21, -lpB->radius, &normal, &c2 );
                manifold->normal = normal;
                b2Lerp( &c1, &c2, 0.5, &manifold->points[0].point );
                manifold->points[0].separation = distance - radius;
                manifold->points[0].id = B2_MAKE_ID( i12, i21 );
                manifold->pointCount = 1;
            }
            else if( result.fraction1 == 1.0 && result.fraction2 == 1.0 )
            {
                // v12 - v22
                b2Vec2 normal;  b2Sub( &v22, &v12, &normal );
                normal.x = normal.x * invDistance;
                normal.y = normal.y * invDistance;
                b2Vec2 c1;  b2MulAdd( &v12, lpA->radius, &normal, &c1 );
                b2Vec2 c2;  b2MulAdd( &v22, -lpB->radius, &normal, &c2 );
                manifold->normal = normal;
                b2Lerp( &c1, &c2, 0.5, &manifold->points[0].point );
                manifold->points[0].separation = distance - radius;
                manifold->points[0].id = B2_MAKE_ID( i12, i22 );
                manifold->pointCount = 1;
            }
        }
    }
    else
    {
        // polygons overlap
        b2ClipPolygons( lpA, lpB, edgeA, edgeB, flip, manifold );
    }

    // undo the origin shift so points are in frame A (unrolled constant indices;
    // variable-index address-of into a struct array miscompiles -- see dialect doc)
    if( manifold->pointCount > 0 )
    {
        b2LocalManifoldPoint* mp = &manifold->points[0];
        b2Add( &mp->point, &origin, &mp->point );
    }
    if( manifold->pointCount > 1 )
    {
        b2LocalManifoldPoint* mp = &manifold->points[1];
        b2Add( &mp->point, &origin, &mp->point );
    }
}

// ---------------------------------------------------------

// Polygon vs capsule: treat the capsule as a 2-vertex rounded polygon.
void b2CollidePolygonAndCapsule( b2Polygon* polygonA, b2Capsule* capsuleB,
                                 b2Transform* xf, b2LocalManifold* manifold )
{
    b2Polygon polyB;
    b2MakeCapsulePolygon( &capsuleB->center1, &capsuleB->center2, capsuleB->radius, &polyB );
    b2CollidePolygons( polygonA, &polyB, xf, manifold );
}

// Segment vs polygon: a segment is a zero-radius 2-vertex polygon.
void b2CollideSegmentAndPolygon( b2Segment* segmentA, b2Polygon* polygonB,
                                 b2Transform* xf, b2LocalManifold* manifold )
{
    b2Polygon polygonA;
    b2MakeCapsulePolygon( &segmentA->point1, &segmentA->point2, 0.0, &polygonA );
    b2CollidePolygons( &polygonA, polygonB, xf, manifold );
}


// -----------------------------------------------------------------------------
//   Chain segment vs polygon / capsule  (the ghost Gauss-map path)
// -----------------------------------------------------------------------------
//   Port of manifold.c b2CollideChainSegmentAndPolygon (+ its helpers b2ClipSegments
//   and b2ClassifyNormal). This is what makes chain terrain work for BOXES, not just
//   circles: a chain segment is a one-sided edge that only owns the contacts inside
//   its own Gauss-map region, so a box sliding along a chain never catches on the
//   "ghost" of a neighbouring segment's endpoint.
//
//   The Gauss map (https://box2d.org/posts/2020/06/ghost-collisions/) classifies a
//   candidate normal against the two neighbour edges: SKIP (a neighbour owns it),
//   ADMIT (this segment owns it), or SNAP (concave corner -> use the segment normal).
//
//   DEVIATION: the b2SimplexCache is COLD (count = 0) on every call. Upstream keeps
//   a per-contact cache to warm-start GJK; the port has no persistent GJK cache
//   (b2UpdateContact is SAT-based), so this costs a few extra GJK iterations and, in
//   a degenerate tie, lets the chosen feature indices (hence the contact-point ids
//   used for impulse warm-start) flip between steps. For a body resting on a chain
//   the closest feature is a stable face, so this does not disturb resting contacts.

#define b2_normalSkip   0   // normal belongs to a neighbour segment -- no contact
#define b2_normalAdmit  1   // normal is owned by this segment -- collide
#define b2_normalSnap   2   // concave corner -- snap the normal to the segment normal

// The chain segment's local Gauss-map frame: its own edge plus the two neighbour
// (ghost) normals and whether each corner is convex.
struct b2ChainSegmentParams
{
    b2Vec2 edge1;      // unit edge p1 -> p2
    b2Vec2 normal0;    // unit normal of the previous edge (ghost1 -> p1)
    b2Vec2 normal2;    // unit normal of the next edge (p2 -> ghost2)
    bool convex1;      // is the corner at p1 convex?
    bool convex2;      // is the corner at p2 convex?
};

// Evaluate the Gauss map: does this segment own the given normal direction?
int b2ClassifyNormal( b2ChainSegmentParams* params, b2Vec2* normal )
{
    float sinTol = 0.01;

    if( b2Dot( normal, &params->edge1 ) <= 0.0 )
    {
        // normal points towards the segment tail
        if( params->convex1 )
        {
            if( b2Cross( normal, &params->normal0 ) > sinTol )
                return b2_normalSkip;
            return b2_normalAdmit;
        }
        return b2_normalSnap;
    }
    else
    {
        // normal points towards the segment head
        if( params->convex2 )
        {
            if( b2Cross( &params->normal2, normal ) > sinTol )
                return b2_normalSkip;
            return b2_normalAdmit;
        }
        return b2_normalSnap;
    }
}

// Clip the incident segment (b1,bb2) against the reference segment (a1,a2) along
// `normal`, producing a 2-point manifold (or 0 points when they do not overlap).
// ra/rb are the reference/incident radii. (upstream static b2ClipSegments)
void b2ClipSegments( b2Vec2* a1, b2Vec2* a2, b2Vec2* b1, b2Vec2* bb2, b2Vec2* normal,
                     float ra, float rb, int id1, int id2, b2LocalManifold* manifold )
{
    manifold->pointCount = 0;

    b2Vec2 tangent;  b2LeftPerp( normal, &tangent );

    // barycentric coordinates of each point relative to a1 along tangent
    float lower1 = 0.0;
    b2Vec2 dA;   b2Sub( a2, a1, &dA );
    float upper1 = b2Dot( &dA, &tangent );

    // the incident edge points opposite of tangent due to CCW winding
    b2Vec2 dB1;  b2Sub( b1, a1, &dB1 );
    float upper2 = b2Dot( &dB1, &tangent );
    b2Vec2 dB2;  b2Sub( bb2, a1, &dB2 );
    float lower2 = b2Dot( &dB2, &tangent );

    // do the segments overlap?
    if( upper2 < lower1 || upper1 < lower2 )
        return;

    b2Vec2 vLower;
    if( lower2 < lower1 && upper2 - lower2 > FLT_EPSILON )
    {
        float t = ( lower1 - lower2 ) / ( upper2 - lower2 );
        b2Lerp( bb2, b1, t, &vLower );
    }
    else
        vLower = *bb2;

    b2Vec2 vUpper;
    if( upper2 > upper1 && upper2 - lower2 > FLT_EPSILON )
    {
        float t = ( upper1 - lower2 ) / ( upper2 - lower2 );
        b2Lerp( bb2, b1, t, &vUpper );
    }
    else
        vUpper = *b1;

    b2Vec2 dL;  b2Sub( &vLower, a1, &dL );
    float separationLower = b2Dot( &dL, normal );
    b2Vec2 dU;  b2Sub( &vUpper, a1, &dU );
    float separationUpper = b2Dot( &dU, normal );

    // put the contact points at the midpoint, accounting for the radii
    b2Vec2 cLower;  b2MulAdd( &vLower, 0.5 * ( ra - rb - separationLower ), normal, &cLower );
    b2Vec2 cUpper;  b2MulAdd( &vUpper, 0.5 * ( ra - rb - separationUpper ), normal, &cUpper );

    float radius = ra + rb;

    manifold->normal = *normal;
    manifold->points[0].point = cLower;
    manifold->points[0].separation = separationLower - radius;
    manifold->points[0].id = id1;
    manifold->points[1].point = cUpper;
    manifold->points[1].separation = separationUpper - radius;
    manifold->points[1].id = id2;
    manifold->pointCount = 2;
}

// One-sided chain segment vs polygon. `cache` is filled by the internal GJK call and
// is read back to identify the closest features; pass a cache with count = 0.
void b2CollideChainSegmentAndPolygon( b2ChainSegment* segmentA, b2Polygon* polygonB,
                                      b2Transform* xf, b2SimplexCache* cache,
                                      b2LocalManifold* manifold )
{
    manifold->pointCount = 0;

    // polygonB in frame A (vertices, normals and centroid all transformed). Accessed
    // through a pointer so every array read is the attested-green whole-struct
    // variable-index copy, never an `arr[i].x` value-index read.
    b2Polygon localPolyB;
    b2Polygon* lpB = &localPolyB;
    b2TransformPolygon( xf, polygonB, lpB );

    b2Vec2 centroidB = lpB->centroid;
    float radiusB = lpB->radius;
    int count = lpB->count;

    b2Vec2 p1 = segmentA->segment.point1;
    b2Vec2 p2 = segmentA->segment.point2;

    b2Vec2 e;      b2Sub( &p2, &p1, &e );
    b2Vec2 edge1;  b2Normalize( &e, &edge1 );

    b2ChainSegmentParams smoothParams;
    smoothParams.edge1 = edge1;

    float convexTol = 0.01;

    b2Vec2 e0;     b2Sub( &p1, &segmentA->ghost1, &e0 );
    b2Vec2 edge0;  b2Normalize( &e0, &edge0 );
    b2RightPerp( &edge0, &smoothParams.normal0 );
    smoothParams.convex1 = b2Cross( &edge0, &edge1 ) >= convexTol;

    b2Vec2 e2;     b2Sub( &segmentA->ghost2, &p2, &e2 );
    b2Vec2 edge2;  b2Normalize( &e2, &edge2 );
    b2RightPerp( &edge2, &smoothParams.normal2 );
    smoothParams.convex2 = b2Cross( &edge1, &edge2 ) >= convexTol;

    // the collidable normal points to the right of edge1
    b2Vec2 normal1;  b2RightPerp( &edge1, &normal1 );

    b2Vec2 cFromP1;  b2Sub( &centroidB, &p1, &cFromP1 );
    bool behind1 = b2Dot( &normal1, &cFromP1 ) < 0.0;
    bool behind0 = true;
    bool behind2 = true;

    if( smoothParams.convex1 )
        behind0 = b2Dot( &smoothParams.normal0, &cFromP1 ) < 0.0;

    if( smoothParams.convex2 )
    {
        b2Vec2 cFromP2;  b2Sub( &centroidB, &p2, &cFromP2 );
        behind2 = b2Dot( &smoothParams.normal2, &cFromP2 ) < 0.0;
    }

    if( behind1 && behind0 && behind2 )
        return;                                   // one-sided: B is behind the chain

    // GJK between the zero-radius segment and the zero-radius polygon hull. The
    // distance alone would not identify the closest features, so the simplex cache
    // is read back below. (Distance does not work correctly on partial polygons,
    // hence the radii are excluded here and folded in afterwards.)
    b2DistanceInput input;
    input.proxyA.points[0] = p1;
    input.proxyA.points[1] = p2;
    input.proxyA.count = 2;
    input.proxyA.radius = 0.0;
    b2MakeProxy( lpB->vertices, count, 0.0, &input.proxyB );
    input.transform = b2Transform_identity;       // B is already in A's frame
    input.useRadii = false;

    b2DistanceOutput output;
    b2ShapeDistance( &input, cache, &output );

    if( output.distance > radiusB + B2_SPECULATIVE_DISTANCE )
        return;

    // snap concave neighbour normals to the segment normal (partial polygon)
    b2Vec2 n0 = normal1;
    if( smoothParams.convex1 )  n0 = smoothParams.normal0;
    b2Vec2 n2 = normal1;
    if( smoothParams.convex2 )  n2 = smoothParams.normal2;

    // index of the incident vertex / incident normal on the polygon (-1 = unset)
    int incidentIndex = -1;
    int incidentNormal = -1;

    if( behind1 == false && output.distance > 0.1 * B2_LINEAR_SLOP )
    {
        // The closest features may be two vertices, or an edge and a vertex, even
        // when there should be face contact -- resolve them via the simplex cache.
        if( cache->count == 1 )
        {
            // vertex-vertex collision
            b2Vec2 pA = output.pointA;
            b2Vec2 pB = output.pointB;
            b2Vec2 d;       b2Sub( &pB, &pA, &d );
            b2Vec2 normal;  b2Normalize( &d, &normal );

            int type = b2ClassifyNormal( &smoothParams, &normal );
            if( type == b2_normalSkip )
                return;

            if( type == b2_normalAdmit )
            {
                manifold->normal = normal;
                manifold->points[0].point = pA;
                manifold->points[0].separation = output.distance - radiusB;
                manifold->points[0].id = B2_MAKE_ID( cache->indexA[0], cache->indexB[0] );
                manifold->pointCount = 1;
                return;
            }

            // fall through b2_normalSnap
            incidentIndex = cache->indexB[0];
        }
        else
        {
            // vertex-edge collision (cache->count == 2)
            int ia1 = cache->indexA[0];
            int ia2 = cache->indexA[1];
            int ib1 = cache->indexB[0];
            int ib2 = cache->indexB[1];

            if( ia1 == ia2 )
            {
                // 1 point on A, 2 points on B: find the polygon normal most aligned
                // with the vector between the closest points (this sorts ib1/ib2)
                b2Vec2 normalB;  b2Sub( &output.pointA, &output.pointB, &normalB );
                b2Vec2 nb1 = lpB->normals[ib1];
                b2Vec2 nb2 = lpB->normals[ib2];
                float dot1 = b2Dot( &normalB, &nb1 );
                float dot2 = b2Dot( &normalB, &nb2 );
                int ib = ib2;
                if( dot1 > dot2 )  ib = ib1;

                normalB = lpB->normals[ib];       // use the accurate normal

                b2Vec2 negNormalB;  b2Neg( &normalB, &negNormalB );
                int type = b2ClassifyNormal( &smoothParams, &negNormalB );
                if( type == b2_normalSkip )
                    return;

                if( type == b2_normalAdmit )
                {
                    // the polygon edge associated with that normal
                    ib1 = ib;
                    if( ib < count - 1 )  ib2 = ib + 1;  else  ib2 = 0;

                    b2Vec2 b1  = lpB->vertices[ib1];
                    b2Vec2 bv2 = lpB->vertices[ib2];

                    // find the incident segment vertex; if the neighbour edge faces
                    // the polygon more directly, the neighbour owns this contact
                    b2Vec2 d1;  b2Sub( &p1, &b1, &d1 );
                    b2Vec2 d2;  b2Sub( &p2, &b1, &d2 );
                    dot1 = b2Dot( &normalB, &d1 );
                    dot2 = b2Dot( &normalB, &d2 );

                    if( dot1 < dot2 )
                    {
                        if( b2Dot( &n0, &normalB ) < b2Dot( &normal1, &normalB ) )
                            return;               // neighbour is incident
                    }
                    else
                    {
                        if( b2Dot( &n2, &normalB ) < b2Dot( &normal1, &normalB ) )
                            return;               // neighbour is incident
                    }

                    b2ClipSegments( &b1, &bv2, &p1, &p2, &normalB, radiusB, 0.0,
                                    B2_MAKE_ID( ib1, 1 ), B2_MAKE_ID( ib2, 0 ), manifold );
                    if( manifold->pointCount == 2 )
                        b2Neg( &normalB, &manifold->normal );
                    return;
                }

                // fall through b2_normalSnap
                incidentNormal = ib;
            }
            else
            {
                // get the index of the incident polygonB vertex
                b2Vec2 vb1 = lpB->vertices[ib1];
                b2Vec2 vb2 = lpB->vertices[ib2];
                b2Vec2 d1;  b2Sub( &vb1, &p1, &d1 );
                b2Vec2 d2;  b2Sub( &vb2, &p2, &d2 );
                float dot1 = b2Dot( &normal1, &d1 );
                float dot2 = b2Dot( &normal1, &d2 );
                if( dot1 < dot2 )  incidentIndex = ib1;  else  incidentIndex = ib2;
            }
        }
    }
    else
    {
        // ---- SAT: the chain segment's own normal ----
        float edgeSeparation = FLT_MAX;
        int i;
        for( i = 0; i < count; ++i )
        {
            b2Vec2 v = lpB->vertices[i];
            b2Vec2 d;  b2Sub( &v, &p1, &d );
            float s = b2Dot( &normal1, &d );
            if( s < edgeSeparation )
            {
                edgeSeparation = s;
                incidentIndex = i;
            }
        }

        // a convex neighbour may own a deeper separating axis; incidentIndex = -1
        // then means "the neighbouring segment owns this, not us"
        if( smoothParams.convex1 )
        {
            float s0 = FLT_MAX;
            for( i = 0; i < count; ++i )
            {
                b2Vec2 v = lpB->vertices[i];
                b2Vec2 d;  b2Sub( &v, &p1, &d );
                float s = b2Dot( &smoothParams.normal0, &d );
                if( s < s0 )  s0 = s;
            }
            if( s0 > edgeSeparation )
            {
                edgeSeparation = s0;
                incidentIndex = -1;
            }
        }

        if( smoothParams.convex2 )
        {
            float s2 = FLT_MAX;
            for( i = 0; i < count; ++i )
            {
                b2Vec2 v = lpB->vertices[i];
                b2Vec2 d;  b2Sub( &v, &p2, &d );
                float s = b2Dot( &smoothParams.normal2, &d );
                if( s < s2 )  s2 = s;
            }
            if( s2 > edgeSeparation )
            {
                edgeSeparation = s2;
                incidentIndex = -1;
            }
        }

        // ---- SAT: the polygon normals (only those this segment is allowed to own) ----
        float polygonSeparation = -FLT_MAX;
        int referenceIndex = -1;

        for( i = 0; i < count; ++i )
        {
            b2Vec2 n = lpB->normals[i];
            b2Vec2 negN;  b2Neg( &n, &negN );
            if( b2ClassifyNormal( &smoothParams, &negN ) != b2_normalAdmit )
                continue;

            b2Vec2 p = lpB->vertices[i];
            b2Vec2 dp2;  b2Sub( &p2, &p, &dp2 );
            b2Vec2 dp1;  b2Sub( &p1, &p, &dp1 );
            float s = b2MinFloat( b2Dot( &n, &dp2 ), b2Dot( &n, &dp1 ) );

            if( s > polygonSeparation )
            {
                polygonSeparation = s;
                referenceIndex = i;
            }
        }

        if( polygonSeparation > edgeSeparation )
        {
            // the polygon face is the reference face
            int ia1 = referenceIndex;
            int ia2;
            if( ia1 < count - 1 )  ia2 = ia1 + 1;  else  ia2 = 0;

            b2Vec2 a1 = lpB->vertices[ia1];
            b2Vec2 a2 = lpB->vertices[ia2];
            b2Vec2 n  = lpB->normals[ia1];

            b2Vec2 d1;  b2Sub( &p1, &a1, &d1 );
            b2Vec2 d2;  b2Sub( &p2, &a1, &d2 );
            float dot1 = b2Dot( &n, &d1 );
            float dot2 = b2Dot( &n, &d2 );

            if( dot1 < dot2 )
            {
                if( b2Dot( &n0, &n ) < b2Dot( &normal1, &n ) )
                    return;                       // neighbour is incident
            }
            else
            {
                if( b2Dot( &n2, &n ) < b2Dot( &normal1, &n ) )
                    return;                       // neighbour is incident
            }

            b2ClipSegments( &a1, &a2, &p1, &p2, &n, radiusB, 0.0,
                            B2_MAKE_ID( ia1, 1 ), B2_MAKE_ID( ia2, 0 ), manifold );
            if( manifold->pointCount == 2 )
                b2Neg( &n, &manifold->normal );
            return;
        }

        if( incidentIndex == -1 )
            return;                               // a neighbouring segment separates

        // fall through to the segment normal axis
    }

    // ---- Segment normal is the reference axis ----
    // Find the incident polygon edge: the edge adjacent to the deepest vertex whose
    // normal is most anti-parallel to the segment normal.
    int ib1;
    int ib2;

    if( incidentNormal != -1 )
    {
        ib1 = incidentNormal;
        if( ib1 < count - 1 )  ib2 = ib1 + 1;  else  ib2 = 0;
    }
    else
    {
        int i2 = incidentIndex;
        int i1;
        if( i2 > 0 )  i1 = i2 - 1;  else  i1 = count - 1;

        b2Vec2 nn1 = lpB->normals[i1];
        b2Vec2 nn2 = lpB->normals[i2];
        float d1 = b2Dot( &normal1, &nn1 );
        float d2 = b2Dot( &normal1, &nn2 );

        if( d1 < d2 )
        {
            ib1 = i1;
            ib2 = i2;
        }
        else
        {
            ib1 = i2;
            if( i2 < count - 1 )  ib2 = i2 + 1;  else  ib2 = 0;
        }
    }

    b2Vec2 b1  = lpB->vertices[ib1];
    b2Vec2 bv2 = lpB->vertices[ib2];

    b2ClipSegments( &p1, &p2, &b1, &bv2, &normal1, 0.0, radiusB,
                    B2_MAKE_ID( 0, ib2 ), B2_MAKE_ID( 1, ib1 ), manifold );
}

// Chain segment vs capsule: treat the capsule as a 2-vertex rounded polygon.
void b2CollideChainSegmentAndCapsule( b2ChainSegment* segmentA, b2Capsule* capsuleB,
                                      b2Transform* xf, b2SimplexCache* cache,
                                      b2LocalManifold* manifold )
{
    b2Polygon polyB;
    b2MakeCapsulePolygon( &capsuleB->center1, &capsuleB->center2, capsuleB->radius, &polyB );
    b2CollideChainSegmentAndPolygon( segmentA, &polyB, xf, cache, manifold );
}


// *****************************************************************************
    #endif
// *****************************************************************************
