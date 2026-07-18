/* *****************************************************************************
*  VirconBox2D : b2_distance.h        (port of Box2D v3 src/distance.c -- slice 1)
*  --------------------------------------------------------------------------- *
*  Closest-distance helpers and shape proxies.                                 *
*                                                                              *
*  SLICE 1 (self-contained: math only): b2SegmentDistance, b2MakeProxy,        *
*  b2MakeOffsetProxy. Deferred to later slices (GJK simplex machinery): the    *
*  b2ShapeDistance core, b2ShapeCast, and the b2TimeOfImpact subsystem.        *
*                                                                              *
*  Port notes: b2SegmentDistanceResult / b2ShapeProxy returned by value ->     *
*  out-pointers; b2Vec2 / b2Rot args -> pointers; designated initializers      *
*  (.p = ...) -> field assignments; 'f' suffixes stripped; '{0}' handled by    *
*  assigning every field. FLT_EPSILON is the runtime-safe value from b2_math.h.*
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_DISTANCE_H
    #define B2_DISTANCE_H

    #include "math.h"
    #include "misc.h"            // memset
    #include "b2_math.h"
    #include "b2_collision.h"
// *****************************************************************************


// Closest distance between two line segments [p1,q1] and [p2,q2], clamping at
// the end points when needed. Handles degenerate (zero-length) segments.
void b2SegmentDistance( b2Vec2* p1, b2Vec2* q1, b2Vec2* p2, b2Vec2* q2, b2SegmentDistanceResult* result )
{
    b2Vec2 d1;  b2Sub( q1, p1, &d1 );
    b2Vec2 d2;  b2Sub( q2, p2, &d2 );
    b2Vec2 r;   b2Sub( p1, p2, &r );

    float dd1 = b2Dot( &d1, &d1 );
    float dd2 = b2Dot( &d2, &d2 );
    float rd1 = b2Dot( &r, &d1 );
    float rd2 = b2Dot( &r, &d2 );

    // FLT_EPSILON is a runtime division (b2_math.h), so this product is computed
    // at runtime and is not affected by the small-literal underflow trap.
    float epsSqr = FLT_EPSILON * FLT_EPSILON;

    if( dd1 < epsSqr || dd2 < epsSqr )
    {
        // handle degeneracies
        if( dd1 >= epsSqr )
        {
            // segment 2 is degenerate
            result->fraction1 = b2ClampFloat( -rd1 / dd1, 0.0, 1.0 );
            result->fraction2 = 0.0;
        }
        else if( dd2 >= epsSqr )
        {
            // segment 1 is degenerate
            result->fraction1 = 0.0;
            result->fraction2 = b2ClampFloat( rd2 / dd2, 0.0, 1.0 );
        }
        else
        {
            result->fraction1 = 0.0;
            result->fraction2 = 0.0;
        }
    }
    else
    {
        // non-degenerate segments
        float d12 = b2Dot( &d1, &d2 );
        float denominator = dd1 * dd2 - d12 * d12;

        float f1 = 0.0;
        if( denominator != 0.0 )
        {
            // not parallel
            f1 = b2ClampFloat( ( d12 * rd2 - rd1 * dd2 ) / denominator, 0.0, 1.0 );
        }

        // closest point on segment 2 to p1 + f1 * d1
        float f2 = ( d12 * f1 + rd2 ) / dd2;

        // clamping segment 2 requires recomputing segment 1
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

        result->fraction1 = f1;
        result->fraction2 = f2;
    }

    b2MulAdd( p1, result->fraction1, &d1, &result->closest1 );
    b2MulAdd( p2, result->fraction2, &d2, &result->closest2 );
    result->distanceSquared = b2DistanceSquared( &result->closest1, &result->closest2 );
}

// ---------------------------------------------------------

// Make a distance proxy (point cloud + radius) from a set of points.
void b2MakeProxy( b2Vec2* points, int count, float radius, b2ShapeProxy* proxy )
{
    count = b2MinInt( count, B2_MAX_POLYGON_VERTICES );

    for( int i = 0; i < count; i++ )
      proxy->points[i] = points[i];

    proxy->count = count;
    proxy->radius = radius;
}

// ---------------------------------------------------------

// Make a distance proxy from points transformed by (position, rotation).
void b2MakeOffsetProxy( b2Vec2* points, int count, float radius, b2Vec2* position, b2Rot* rotation, b2ShapeProxy* proxy )
{
    count = b2MinInt( count, B2_MAX_POLYGON_VERTICES );

    b2Transform transform;
    transform.p = *position;
    transform.q = *rotation;

    for( int i = 0; i < count; i++ )
      b2TransformPoint( &transform, &points[i], &proxy->points[i] );

    proxy->count = count;
    proxy->radius = radius;
}


// =============================================================================
//   GJK DISTANCE  (slice 2: the simplex machinery + b2ShapeDistance)
// =============================================================================
//   The upstream code indexes the simplex vertices through a local pointer
//   array { &s.v1, &s.v2, &s.v3 }; this helper replaces that (no runtime-
//   address array initializers needed). The debug-simplex output parameters
//   are dropped. Functions returning b2Vec2/b2Simplex/b2SimplexCache/output
//   become out-pointers; nested vector expressions are unrolled into temps.


// pointer to the i-th simplex vertex (i in 0..2)
b2SimplexVertex* b2SimplexVertexPtr( b2Simplex* s, int i )
{
    if( i == 0 ) return &s->v1;
    if( i == 1 ) return &s->v2;
    return &s->v3;
}

// ---------------------------------------------------------

void b2Weight2( float a1, b2Vec2* w1, float a2, b2Vec2* w2, b2Vec2* result )
{
    result->x = a1 * w1->x + a2 * w2->x;
    result->y = a1 * w1->y + a2 * w2->y;
}

// ---------------------------------------------------------

void b2Weight3( float a1, b2Vec2* w1, float a2, b2Vec2* w2, float a3, b2Vec2* w3, b2Vec2* result )
{
    result->x = a1 * w1->x + a2 * w2->x + a3 * w3->x;
    result->y = a1 * w1->y + a2 * w2->y + a3 * w3->y;
}

// ---------------------------------------------------------

// index of the proxy point furthest along 'direction'
int b2FindSupport( b2ShapeProxy* proxy, b2Vec2* direction )
{
    int count = proxy->count;
    int bestIndex = 0;
    float bestValue = b2Dot( &proxy->points[0], direction );

    for( int i = 1; i < count; i++ )
    {
        float value = b2Dot( &proxy->points[i], direction );
        if( value > bestValue )
        {
            bestIndex = i;
            bestValue = value;
        }
    }

    return bestIndex;
}

// ---------------------------------------------------------

void b2MakeSimplexFromCache( b2SimplexCache* cache, b2ShapeProxy* proxyA, b2ShapeProxy* proxyB, b2Simplex* s )
{
    s->count = cache->count;

    for( int i = 0; i < s->count; i++ )
    {
        b2SimplexVertex* v = b2SimplexVertexPtr( s, i );
        v->indexA = cache->indexA[i];
        v->indexB = cache->indexB[i];
        v->wA = proxyA->points[v->indexA];
        v->wB = proxyB->points[v->indexB];
        b2Sub( &v->wA, &v->wB, &v->w );
        v->a = -1.0;   // invalid
    }

    // empty / invalid cache -> seed with the first points
    if( s->count == 0 )
    {
        b2SimplexVertex* v = b2SimplexVertexPtr( s, 0 );
        v->indexA = 0;
        v->indexB = 0;
        v->wA = proxyA->points[0];
        v->wB = proxyB->points[0];
        b2Sub( &v->wA, &v->wB, &v->w );
        v->a = 1.0;
        s->count = 1;
    }
}

// ---------------------------------------------------------

void b2MakeSimplexCache( b2Simplex* simplex, b2SimplexCache* cache )
{
    cache->count = simplex->count;
    for( int i = 0; i < simplex->count; i++ )
    {
        b2SimplexVertex* v = b2SimplexVertexPtr( simplex, i );
        cache->indexA[i] = v->indexA;
        cache->indexB[i] = v->indexB;
    }
}

// ---------------------------------------------------------

void b2ComputeWitnessPoints( b2Simplex* s, b2Vec2* a, b2Vec2* b )
{
    if( s->count == 1 )
    {
        *a = s->v1.wA;
        *b = s->v1.wB;
    }
    else if( s->count == 2 )
    {
        b2Weight2( s->v1.a, &s->v1.wA, s->v2.a, &s->v2.wA, a );
        b2Weight2( s->v1.a, &s->v1.wB, s->v2.a, &s->v2.wB, b );
    }
    else if( s->count == 3 )
    {
        b2Weight3( s->v1.a, &s->v1.wA, s->v2.a, &s->v2.wA, s->v3.a, &s->v3.wA, a );
        *b = *a;
    }
    else
    {
        *a = b2Vec2_zero;
        *b = b2Vec2_zero;
    }
}

// ---------------------------------------------------------

// Solve a 2-vertex simplex; writes the search direction (toward the origin).
void b2SolveSimplex2( b2Simplex* s, b2Vec2* searchDir )
{
    b2Vec2 w1 = s->v1.w;
    b2Vec2 w2 = s->v2.w;
    b2Vec2 e12;  b2Sub( &w2, &w1, &e12 );

    // w1 region
    float d12_2 = -b2Dot( &w1, &e12 );
    if( d12_2 <= 0.0 )
    {
        s->v1.a = 1.0;
        s->count = 1;
        b2Neg( &w1, searchDir );
        return;
    }

    // w2 region
    float d12_1 = b2Dot( &w2, &e12 );
    if( d12_1 <= 0.0 )
    {
        s->v2.a = 1.0;
        s->count = 1;
        s->v1 = s->v2;
        b2Neg( &w2, searchDir );
        return;
    }

    // e12 region
    float inv_d12 = 1.0 / ( d12_1 + d12_2 );
    s->v1.a = d12_1 * inv_d12;
    s->v2.a = d12_2 * inv_d12;
    s->count = 2;

    b2Vec2 sum;  b2Add( &w1, &w2, &sum );
    float cr = b2Cross( &sum, &e12 );
    b2CrossSV( cr, &e12, searchDir );
}

// ---------------------------------------------------------

// Solve a 3-vertex simplex; writes the search direction (zero if origin inside).
void b2SolveSimplex3( b2Simplex* s, b2Vec2* searchDir )
{
    b2Vec2 w1 = s->v1.w;
    b2Vec2 w2 = s->v2.w;
    b2Vec2 w3 = s->v3.w;

    b2Vec2 e12;  b2Sub( &w2, &w1, &e12 );
    float w1e12 = b2Dot( &w1, &e12 );
    float w2e12 = b2Dot( &w2, &e12 );
    float d12_1 = w2e12;
    float d12_2 = -w1e12;

    b2Vec2 e13;  b2Sub( &w3, &w1, &e13 );
    float w1e13 = b2Dot( &w1, &e13 );
    float w3e13 = b2Dot( &w3, &e13 );
    float d13_1 = w3e13;
    float d13_2 = -w1e13;

    b2Vec2 e23;  b2Sub( &w3, &w2, &e23 );
    float w2e23 = b2Dot( &w2, &e23 );
    float w3e23 = b2Dot( &w3, &e23 );
    float d23_1 = w3e23;
    float d23_2 = -w2e23;

    float n123 = b2Cross( &e12, &e13 );
    float cw2w3 = b2Cross( &w2, &w3 );
    float cw3w1 = b2Cross( &w3, &w1 );
    float cw1w2 = b2Cross( &w1, &w2 );
    float d123_1 = n123 * cw2w3;
    float d123_2 = n123 * cw3w1;
    float d123_3 = n123 * cw1w2;

    // w1 region
    if( d12_2 <= 0.0 && d13_2 <= 0.0 )
    {
        s->v1.a = 1.0;
        s->count = 1;
        b2Neg( &w1, searchDir );
        return;
    }

    // e12
    if( d12_1 > 0.0 && d12_2 > 0.0 && d123_3 <= 0.0 )
    {
        float inv_d12 = 1.0 / ( d12_1 + d12_2 );
        s->v1.a = d12_1 * inv_d12;
        s->v2.a = d12_2 * inv_d12;
        s->count = 2;
        b2Vec2 sum;  b2Add( &w1, &w2, &sum );
        float cr = b2Cross( &sum, &e12 );
        b2CrossSV( cr, &e12, searchDir );
        return;
    }

    // e13
    if( d13_1 > 0.0 && d13_2 > 0.0 && d123_2 <= 0.0 )
    {
        float inv_d13 = 1.0 / ( d13_1 + d13_2 );
        s->v1.a = d13_1 * inv_d13;
        s->v3.a = d13_2 * inv_d13;
        s->count = 2;
        s->v2 = s->v3;
        b2Vec2 sum;  b2Add( &w1, &w3, &sum );
        float cr = b2Cross( &sum, &e13 );
        b2CrossSV( cr, &e13, searchDir );
        return;
    }

    // w2 region
    if( d12_1 <= 0.0 && d23_2 <= 0.0 )
    {
        s->v2.a = 1.0;
        s->count = 1;
        s->v1 = s->v2;
        b2Neg( &w2, searchDir );
        return;
    }

    // w3 region
    if( d13_1 <= 0.0 && d23_1 <= 0.0 )
    {
        s->v3.a = 1.0;
        s->count = 1;
        s->v1 = s->v3;
        b2Neg( &w3, searchDir );
        return;
    }

    // e23
    if( d23_1 > 0.0 && d23_2 > 0.0 && d123_1 <= 0.0 )
    {
        float inv_d23 = 1.0 / ( d23_1 + d23_2 );
        s->v2.a = d23_1 * inv_d23;
        s->v3.a = d23_2 * inv_d23;
        s->count = 2;
        s->v1 = s->v3;
        b2Vec2 sum;  b2Add( &w2, &w3, &sum );
        float cr = b2Cross( &sum, &e23 );
        b2CrossSV( cr, &e23, searchDir );
        return;
    }

    // triangle123 -> origin enclosed
    float inv_d123 = 1.0 / ( d123_1 + d123_2 + d123_3 );
    s->v1.a = d123_1 * inv_d123;
    s->v2.a = d123_2 * inv_d123;
    s->v3.a = d123_3 * inv_d123;
    s->count = 3;
    *searchDir = b2Vec2_zero;
}

// ---------------------------------------------------------

// GJK: closest points / distance between two convex point clouds (frame A).
// 'cache' is in/out; set cache->count = 0 on the first call.
void b2ShapeDistance( b2DistanceInput* input, b2SimplexCache* cache, b2DistanceOutput* output )
{
    memset( output, 0, sizeof( b2DistanceOutput ) );

    b2ShapeProxy* proxyA = &input->proxyA;

    // bring proxyB into frame A so the main loop needs no transforms
    b2ShapeProxy localProxyB;
    localProxyB.count = input->proxyB.count;
    localProxyB.radius = input->proxyB.radius;
    for( int i = 0; i < localProxyB.count; i++ )
      b2TransformPoint( &input->transform, &input->proxyB.points[i], &localProxyB.points[i] );

    b2Simplex simplex;
    b2MakeSimplexFromCache( cache, proxyA, &localProxyB, &simplex );

    b2Vec2 nonUnitNormal = b2Vec2_zero;
    int[3] saveA;
    int[3] saveB;

    float epsSqr = FLT_EPSILON * FLT_EPSILON;
    int maxIterations = 20;
    int iteration = 0;

    while( iteration < maxIterations )
    {
        // remember the current simplex to detect duplicates
        int saveCount = simplex.count;
        for( int i = 0; i < saveCount; i++ )
        {
            b2SimplexVertex* sv = b2SimplexVertexPtr( &simplex, i );
            saveA[i] = sv->indexA;
            saveB[i] = sv->indexB;
        }

        b2Vec2 d;  d.x = 0.0;  d.y = 0.0;
        if( simplex.count == 1 )
          b2Neg( &simplex.v1.w, &d );
        else if( simplex.count == 2 )
          b2SolveSimplex2( &simplex, &d );
        else if( simplex.count == 3 )
          b2SolveSimplex3( &simplex, &d );

        // origin inside the triangle -> overlap
        if( simplex.count == 3 )
        {
            b2ComputeWitnessPoints( &simplex, &output->pointA, &output->pointB );
            return;
        }

        // degenerate search direction -> treat as overlap
        if( b2Dot( &d, &d ) < epsSqr )
        {
            b2ComputeWitnessPoints( &simplex, &output->pointA, &output->pointB );
            return;
        }

        nonUnitNormal = d;

        // new support vertex: support(A,d) - support(B,-d)
        b2SimplexVertex* vertex = b2SimplexVertexPtr( &simplex, simplex.count );
        vertex->indexA = b2FindSupport( proxyA, &d );
        vertex->wA = proxyA->points[vertex->indexA];

        b2Vec2 negd;  b2Neg( &d, &negd );
        vertex->indexB = b2FindSupport( &localProxyB, &negd );
        vertex->wB = localProxyB.points[vertex->indexB];
        b2Sub( &vertex->wA, &vertex->wB, &vertex->w );

        iteration++;

        // terminate on a duplicate support point
        bool duplicate = false;
        for( int i = 0; i < saveCount; i++ )
        {
            if( vertex->indexA == saveA[i] && vertex->indexB == saveB[i] )
            {
                duplicate = true;
                break;
            }
        }

        if( duplicate )
          break;

        simplex.count += 1;
    }

    // prepare output in frame A
    b2Vec2 normal;  b2Normalize( &nonUnitNormal, &normal );
    b2ComputeWitnessPoints( &simplex, &output->pointA, &output->pointB );
    output->normal = normal;
    output->distance = b2Distance( &output->pointA, &output->pointB );
    output->iterations = iteration;
    output->simplexCount = 0;

    b2MakeSimplexCache( &simplex, cache );

    if( input->useRadii )
    {
        float radiusA = input->proxyA.radius;
        float radiusB = input->proxyB.radius;
        output->distance = b2MaxFloat( 0.0, output->distance - radiusA - radiusB );

        // keep closest points on the perimeters for smooth motion
        b2MulAdd( &output->pointA, radiusA, &normal, &output->pointA );
        b2MulSub( &output->pointB, radiusB, &normal, &output->pointB );
    }
}

// ---------------------------------------------------------

// Is a point inside a (solid) convex polygon? Uses GJK distance.
// (Ported here, not in b2_geometry.h, because it depends on the distance core.)
bool b2PointInPolygon( b2Polygon* shape, b2Vec2* point )
{
    b2DistanceInput input;
    memset( &input, 0, sizeof( b2DistanceInput ) );
    b2MakeProxy( shape->vertices, shape->count, 0.0, &input.proxyA );
    b2MakeProxy( point, 1, 0.0, &input.proxyB );
    input.transform = b2Transform_identity;
    input.useRadii = false;

    b2SimplexCache cache;
    cache.count = 0;

    b2DistanceOutput output;
    b2ShapeDistance( &input, &cache, &output );

    return output.distance <= shape->radius;
}


// =============================================================================
//   SHAPE CAST (linear sweep of shape B against a fixed shape A)
// =============================================================================
//   Port of distance.c b2ShapeCast: conservative advancement. Shape A is fixed;
//   shape B starts at input->transform and translates by input->translationB. The
//   whole query runs in A's frame, so the returned point/normal are in A's frame.
//
//   Each iteration asks GJK for the core-to-core distance (useRadii = false), then
//   advances the fraction by exactly the amount that would close that distance at
//   the current closing rate. Because the closing rate can only decrease as the
//   shapes rotate past each other, the advance never overshoots the true impact.
//
//   TARGET is NOT geometric contact: the loop stops at
//       target = max( B2_LINEAR_SLOP, totalRadius - B2_LINEAR_SLOP )
//   i.e. a hair BEFORE the surfaces touch. So a circle of radius r cast at a wall
//   reports a fraction corresponding to a centre-to-wall distance of r - linearSlop,
//   not r. Hand-computed test values must include that offset.
//
//   Initial overlap (distance already within target at iteration 0) returns
//   hit = true, fraction = 0 and the midpoint as `point`, with NO normal -- despite
//   what upstream's header comment claims. `canEncroach` instead relaxes the target
//   so a touching, radius-bearing shape may still advance.
void b2ShapeCast( b2ShapeCastPairInput* input, b2CastOutput* output )
{
    output->normal = b2Vec2_zero;
    output->point = b2Vec2_zero;
    output->fraction = 0.0;
    output->iterations = 0;
    output->hit = false;

    float linearSlop = B2_LINEAR_SLOP;
    float totalRadius = input->proxyA.radius + input->proxyB.radius;
    float target = b2MaxFloat( linearSlop, totalRadius - linearSlop );
    float tolerance = 0.25 * linearSlop;

    b2SimplexCache cache;
    cache.count = 0;

    float fraction = 0.0;

    // The cast runs in frame A: advance B's relative pose each iteration rather than
    // re-relativizing world poses, which keeps the math near the local origin.
    b2DistanceInput distanceInput;
    distanceInput.proxyA = input->proxyA;
    distanceInput.proxyB = input->proxyB;
    distanceInput.transform = input->transform;
    distanceInput.useRadii = false;

    b2Vec2 delta2 = input->translationB;

    int iteration;
    for( iteration = 0; iteration < 20; ++iteration )
    {
        output->iterations = output->iterations + 1;

        b2DistanceOutput distanceOutput;
        b2ShapeDistance( &distanceInput, &cache, &distanceOutput );

        if( distanceOutput.distance < target + tolerance )
        {
            if( iteration == 0 )
            {
                if( input->canEncroach && distanceOutput.distance > 2.0 * linearSlop )
                {
                    // Already touching, but there is room to encroach: pull the target
                    // in and keep sweeping instead of reporting an overlap.
                    target = distanceOutput.distance - linearSlop;
                }
                else
                {
                    // Initial overlap: report a common point, leave fraction/normal zero.
                    output->hit = true;
                    b2Vec2 c1;  b2MulAdd( &distanceOutput.pointA, input->proxyA.radius,
                                          &distanceOutput.normal, &c1 );
                    b2Vec2 c2;  b2MulAdd( &distanceOutput.pointB, -input->proxyB.radius,
                                          &distanceOutput.normal, &c2 );
                    b2Lerp( &c1, &c2, 0.5, &output->point );
                    return;
                }
            }
            else
            {
                // Regular hit: the surface point lies proxyA.radius along the normal
                // from A's core witness point.
                output->fraction = fraction;
                b2MulAdd( &distanceOutput.pointA, input->proxyA.radius,
                          &distanceOutput.normal, &output->point );
                output->normal = distanceOutput.normal;
                output->hit = true;
                return;
            }
        }

        // Are the shapes approaching? normal points A->B, so B receding gives >= 0.
        float denominator = b2Dot( &delta2, &distanceOutput.normal );
        if( denominator >= 0.0 )
            return;                                   // miss: B never closes on A

        // Advance the sweep by the fraction that would close the remaining gap at the
        // current closing rate. (target - distance) < 0 and denominator < 0 -> positive.
        fraction = fraction + ( target - distanceOutput.distance ) / denominator;
        if( fraction >= input->maxFraction )
            return;                                   // miss: impact is beyond the cast

        b2MulAdd( &input->transform.p, fraction, &delta2, &distanceInput.transform.p );
    }

    // Failed to converge in 20 iterations -> report a miss.
}


// =============================================================================
//   TIME OF IMPACT (continuous collision, distance slice 3)
// =============================================================================
//   CCD via the local separating-axis method (upstream distance.c b2TimeOfImpact):
//   advance the sweep looking for the largest time at which the shapes stay
//   separated. Uses b2ShapeDistance (GJK) + a separation function whose 1D root is
//   found by mixed false-position/bisection. All by-value returns are OUT-pointered
//   and the upstream switch(type) is an if/else chain (dialect). b2SeparationFunction
//   embeds both sweeps (big) so it is always passed by pointer.

// Interpolate a sweep to a body-origin transform at fraction `time` in [0,1].
void b2GetSweepTransform( b2Sweep* sweep, float time, b2Transform* xf )
{
    b2Vec2 a;  b2MulSV( 1.0 - time, &sweep->c1, &a );
    b2Vec2 b;  b2MulSV( time, &sweep->c2, &b );
    b2Add( &a, &b, &xf->p );

    b2Rot q;
    q.c = ( 1.0 - time ) * sweep->q1.c + time * sweep->q2.c;
    q.s = ( 1.0 - time ) * sweep->q1.s + time * sweep->q2.s;
    b2NormalizeRot( &q, &xf->q );

    // shift from center-of-mass frame to body-origin frame
    b2Vec2 rc;  b2RotateVector( &xf->q, &sweep->localCenter, &rc );
    b2Vec2 p;   b2Sub( &xf->p, &rc, &p );
    xf->p = p;
}

// b2SeparationType (upstream enum -> #defines)
#define b2_pointsType   0
#define b2_faceAType    1
#define b2_faceBType    2

struct b2SeparationFunction
{
    b2ShapeProxy* proxyA;
    b2ShapeProxy* proxyB;
    b2Sweep sweepA;
    b2Sweep sweepB;
    b2Vec2 localPoint;
    b2Vec2 axis;
    int type;
};

// Build the separating-axis function from the GJK simplex cache at t1 (out-pointer).
void b2MakeSeparationFunction( b2SimplexCache* cache, b2ShapeProxy* proxyA, b2Sweep* sweepA,
                               b2ShapeProxy* proxyB, b2Sweep* sweepB, float t1, b2SeparationFunction* f )
{
    f->proxyA = proxyA;
    f->proxyB = proxyB;
    int count = cache->count;
    f->sweepA = *sweepA;
    f->sweepB = *sweepB;

    b2Transform xfA;  b2GetSweepTransform( sweepA, t1, &xfA );
    b2Transform xfB;  b2GetSweepTransform( sweepB, t1, &xfB );

    if( count == 1 )
    {
        f->type = b2_pointsType;
        b2Vec2 localPointA = proxyA->points[ cache->indexA[0] ];
        b2Vec2 localPointB = proxyB->points[ cache->indexB[0] ];
        b2Vec2 pointA;  b2TransformPoint( &xfA, &localPointA, &pointA );
        b2Vec2 pointB;  b2TransformPoint( &xfB, &localPointB, &pointB );
        b2Vec2 d;  b2Sub( &pointB, &pointA, &d );
        b2Normalize( &d, &f->axis );
        f->localPoint = b2Vec2_zero;
        return;
    }

    if( cache->indexA[0] == cache->indexA[1] )
    {
        // two points on B, one on A -> face B
        f->type = b2_faceBType;
        b2Vec2 localPointB1 = proxyB->points[ cache->indexB[0] ];
        b2Vec2 localPointB2 = proxyB->points[ cache->indexB[1] ];
        b2Vec2 e;  b2Sub( &localPointB2, &localPointB1, &e );
        b2Vec2 axis;  b2CrossVS( &e, 1.0, &axis );
        b2Normalize( &axis, &f->axis );
        b2Vec2 normal;  b2RotateVector( &xfB.q, &f->axis, &normal );

        f->localPoint.x = 0.5 * ( localPointB1.x + localPointB2.x );
        f->localPoint.y = 0.5 * ( localPointB1.y + localPointB2.y );
        b2Vec2 pointB;  b2TransformPoint( &xfB, &f->localPoint, &pointB );

        b2Vec2 localPointA = proxyA->points[ cache->indexA[0] ];
        b2Vec2 pointA;  b2TransformPoint( &xfA, &localPointA, &pointA );

        b2Vec2 dAB;  b2Sub( &pointA, &pointB, &dAB );
        if( b2Dot( &dAB, &normal ) < 0.0 )
        {
            b2Vec2 neg;  b2Neg( &f->axis, &neg );
            f->axis = neg;
        }
        return;
    }

    // two points on A, one or two on B -> face A
    f->type = b2_faceAType;
    b2Vec2 localPointA1 = proxyA->points[ cache->indexA[0] ];
    b2Vec2 localPointA2 = proxyA->points[ cache->indexA[1] ];
    b2Vec2 e;  b2Sub( &localPointA2, &localPointA1, &e );
    b2Vec2 axis;  b2CrossVS( &e, 1.0, &axis );
    b2Normalize( &axis, &f->axis );
    b2Vec2 normal;  b2RotateVector( &xfA.q, &f->axis, &normal );

    f->localPoint.x = 0.5 * ( localPointA1.x + localPointA2.x );
    f->localPoint.y = 0.5 * ( localPointA1.y + localPointA2.y );
    b2Vec2 pointA;  b2TransformPoint( &xfA, &f->localPoint, &pointA );

    b2Vec2 localPointB = proxyB->points[ cache->indexB[0] ];
    b2Vec2 pointB;  b2TransformPoint( &xfB, &localPointB, &pointB );

    b2Vec2 dBA;  b2Sub( &pointB, &pointA, &dBA );
    if( b2Dot( &dBA, &normal ) < 0.0 )
    {
        b2Vec2 neg;  b2Neg( &f->axis, &neg );
        f->axis = neg;
    }
}

// Deepest separation at time t, recording the witness support indices (out).
float b2FindMinSeparation( b2SeparationFunction* f, int* indexA, int* indexB, float t )
{
    b2Transform xfA;  b2GetSweepTransform( &f->sweepA, t, &xfA );
    b2Transform xfB;  b2GetSweepTransform( &f->sweepB, t, &xfB );

    if( f->type == b2_pointsType )
    {
        b2Vec2 axisA;    b2InvRotateVector( &xfA.q, &f->axis, &axisA );
        b2Vec2 negAxis;  b2Neg( &f->axis, &negAxis );
        b2Vec2 axisB;    b2InvRotateVector( &xfB.q, &negAxis, &axisB );

        *indexA = b2FindSupport( f->proxyA, &axisA );
        *indexB = b2FindSupport( f->proxyB, &axisB );

        b2Vec2 localPointA = f->proxyA->points[ *indexA ];
        b2Vec2 localPointB = f->proxyB->points[ *indexB ];
        b2Vec2 pointA;  b2TransformPoint( &xfA, &localPointA, &pointA );
        b2Vec2 pointB;  b2TransformPoint( &xfB, &localPointB, &pointB );

        b2Vec2 d;  b2Sub( &pointB, &pointA, &d );
        return b2Dot( &d, &f->axis );
    }
    else if( f->type == b2_faceAType )
    {
        b2Vec2 normal;  b2RotateVector( &xfA.q, &f->axis, &normal );
        b2Vec2 pointA;  b2TransformPoint( &xfA, &f->localPoint, &pointA );

        b2Vec2 negNormal;  b2Neg( &normal, &negNormal );
        b2Vec2 axisB;      b2InvRotateVector( &xfB.q, &negNormal, &axisB );

        *indexA = -1;
        *indexB = b2FindSupport( f->proxyB, &axisB );

        b2Vec2 localPointB = f->proxyB->points[ *indexB ];
        b2Vec2 pointB;  b2TransformPoint( &xfB, &localPointB, &pointB );

        b2Vec2 d;  b2Sub( &pointB, &pointA, &d );
        return b2Dot( &d, &normal );
    }
    else   // face B
    {
        b2Vec2 normal;  b2RotateVector( &xfB.q, &f->axis, &normal );
        b2Vec2 pointB;  b2TransformPoint( &xfB, &f->localPoint, &pointB );

        b2Vec2 negNormal;  b2Neg( &normal, &negNormal );
        b2Vec2 axisA;      b2InvRotateVector( &xfA.q, &negNormal, &axisA );

        *indexB = -1;
        *indexA = b2FindSupport( f->proxyA, &axisA );

        b2Vec2 localPointA = f->proxyA->points[ *indexA ];
        b2Vec2 pointA;  b2TransformPoint( &xfA, &localPointA, &pointA );

        b2Vec2 d;  b2Sub( &pointA, &pointB, &d );
        return b2Dot( &d, &normal );
    }
}

// Separation at time t for the FIXED witness indices (root-finder evaluation).
float b2EvaluateSeparation( b2SeparationFunction* f, int indexA, int indexB, float t )
{
    b2Transform xfA;  b2GetSweepTransform( &f->sweepA, t, &xfA );
    b2Transform xfB;  b2GetSweepTransform( &f->sweepB, t, &xfB );

    if( f->type == b2_pointsType )
    {
        b2Vec2 localPointA = f->proxyA->points[ indexA ];
        b2Vec2 localPointB = f->proxyB->points[ indexB ];
        b2Vec2 pointA;  b2TransformPoint( &xfA, &localPointA, &pointA );
        b2Vec2 pointB;  b2TransformPoint( &xfB, &localPointB, &pointB );
        b2Vec2 d;  b2Sub( &pointB, &pointA, &d );
        return b2Dot( &d, &f->axis );
    }
    else if( f->type == b2_faceAType )
    {
        b2Vec2 normal;  b2RotateVector( &xfA.q, &f->axis, &normal );
        b2Vec2 pointA;  b2TransformPoint( &xfA, &f->localPoint, &pointA );
        b2Vec2 localPointB = f->proxyB->points[ indexB ];
        b2Vec2 pointB;  b2TransformPoint( &xfB, &localPointB, &pointB );
        b2Vec2 d;  b2Sub( &pointB, &pointA, &d );
        return b2Dot( &d, &normal );
    }
    else   // face B
    {
        b2Vec2 normal;  b2RotateVector( &xfB.q, &f->axis, &normal );
        b2Vec2 pointB;  b2TransformPoint( &xfB, &f->localPoint, &pointB );
        b2Vec2 localPointA = f->proxyA->points[ indexA ];
        b2Vec2 pointA;  b2TransformPoint( &xfA, &localPointA, &pointA );
        b2Vec2 d;  b2Sub( &pointA, &pointB, &d );
        return b2Dot( &d, &normal );
    }
}

// Compute the first time-of-impact of two swept convex proxies (out-pointer).
void b2TimeOfImpact( b2TOIInput* input, b2TOIOutput* output )
{
    output->state = b2_toiStateUnknown;
    output->fraction = input->maxFraction;
    output->point = b2Vec2_zero;
    output->normal = b2Vec2_zero;

    b2Sweep sweepA = input->sweepA;
    b2Sweep sweepB = input->sweepB;

    b2ShapeProxy* proxyA = &input->proxyA;
    b2ShapeProxy* proxyB = &input->proxyB;

    float tMax = input->maxFraction;

    float totalRadius = proxyA->radius + proxyB->radius;
    float target = b2MaxFloat( B2_LINEAR_SLOP, totalRadius - B2_LINEAR_SLOP );
    float tolerance = 0.25 * B2_LINEAR_SLOP;

    float t1 = 0.0;
    int k_maxIterations = 20;
    int distanceIterations = 0;

    b2SimplexCache cache;  cache.count = 0;
    b2DistanceInput distanceInput;
    distanceInput.proxyA = input->proxyA;
    distanceInput.proxyB = input->proxyB;
    distanceInput.useRadii = false;

    // outer loop: progressively find a new separating axis until one repeats.
    bool loop = true;
    while( loop )
    {
        b2Transform xfA;  b2GetSweepTransform( &sweepA, t1, &xfA );
        b2Transform xfB;  b2GetSweepTransform( &sweepB, t1, &xfB );
        b2InvMulTransforms( &xfA, &xfB, &distanceInput.transform );
        b2DistanceOutput distanceOutput;
        b2ShapeDistance( &distanceInput, &cache, &distanceOutput );

        // project witness data (frame A) back to world
        b2Vec2 worldNormal;  b2RotateVector( &xfA.q, &distanceOutput.normal, &worldNormal );
        b2Vec2 worldPointA;  b2TransformPoint( &xfA, &distanceOutput.pointA, &worldPointA );
        b2Vec2 worldPointB;  b2TransformPoint( &xfA, &distanceOutput.pointB, &worldPointB );

        distanceIterations = distanceIterations + 1;

        // overlapped at t1: give up on CCD
        if( distanceOutput.distance <= 0.0 )
        {
            output->state = b2_toiStateOverlapped;
            output->fraction = 0.0;
            return;
        }

        // within the target band: hit at t1
        if( distanceOutput.distance <= target + tolerance )
        {
            output->state = b2_toiStateHit;
            b2Vec2 pA;  b2MulAdd( &worldPointA, proxyA->radius, &worldNormal, &pA );
            b2Vec2 pB;  b2MulAdd( &worldPointB, -proxyB->radius, &worldNormal, &pB );
            b2Lerp( &pA, &pB, 0.5, &output->point );
            output->normal = worldNormal;
            output->fraction = t1;
            return;
        }

        b2SeparationFunction fcn;
        b2MakeSeparationFunction( &cache, proxyA, &sweepA, proxyB, &sweepB, t1, &fcn );

        // inner loop: resolve the deepest point, bounded by the vertex count
        bool done = false;
        float t2 = tMax;
        int pushBackIterations = 0;
        bool inner = true;
        while( inner )
        {
            int indexA;  int indexB;
            float s2 = b2FindMinSeparation( &fcn, &indexA, &indexB, t2 );

            // final configuration separated -> victory
            if( s2 > target + tolerance )
            {
                output->state = b2_toiStateSeparated;
                output->fraction = tMax;
                done = true;
                break;
            }

            // reached tolerance at t2 -> advance the sweep
            if( s2 > target - tolerance )
            {
                t1 = t2;
                break;
            }

            float s1 = b2EvaluateSeparation( &fcn, indexA, indexB, t1 );

            // initial overlap (root finder ran out) -> failure at t1
            if( s1 < target - tolerance )
            {
                output->state = b2_toiStateFailed;
                output->fraction = t1;
                done = true;
                break;
            }

            // touching at t1 -> hit
            if( s1 <= target + tolerance )
            {
                output->state = b2_toiStateHit;
                b2Vec2 pA;  b2MulAdd( &worldPointA, proxyA->radius, &worldNormal, &pA );
                b2Vec2 pB;  b2MulAdd( &worldPointB, -proxyB->radius, &worldNormal, &pB );
                b2Lerp( &pA, &pB, 0.5, &output->point );
                output->normal = worldNormal;
                output->fraction = t1;
                done = true;
                break;
            }

            // 1D root of f(t) - target = 0 (mixed false-position / bisection)
            int rootIterationCount = 0;
            float a1 = t1;  float a2 = t2;
            bool rootLoop = true;
            while( rootLoop )
            {
                float t;
                if( ( rootIterationCount & 1 ) != 0 )
                    t = a1 + ( target - s1 ) * ( a2 - a1 ) / ( s2 - s1 );   // false position
                else
                    t = 0.5 * ( a1 + a2 );                                  // bisection

                rootIterationCount = rootIterationCount + 1;

                float s = b2EvaluateSeparation( &fcn, indexA, indexB, t );

                if( b2AbsFloat( s - target ) < tolerance )
                {
                    t2 = t;      // tentative t1
                    break;
                }

                if( s > target )
                {
                    a1 = t;  s1 = s;
                }
                else
                {
                    a2 = t;  s2 = s;
                }

                if( rootIterationCount == 50 )
                    break;
            }

            pushBackIterations = pushBackIterations + 1;
            if( pushBackIterations == B2_MAX_POLYGON_VERTICES )
                break;
        }

        if( done )
            break;

        // root finder stuck across many axes -> semi-victory at t1
        if( distanceIterations == k_maxIterations )
        {
            output->state = b2_toiStateFailed;
            b2Vec2 pA;  b2MulAdd( &worldPointA, proxyA->radius, &worldNormal, &pA );
            b2Vec2 pB;  b2MulAdd( &worldPointB, -proxyB->radius, &worldNormal, &pB );
            b2Lerp( &pA, &pB, 0.5, &output->point );
            output->normal = worldNormal;
            output->fraction = t1;
            break;
        }
    }
}


// *****************************************************************************
    #endif
// *****************************************************************************
