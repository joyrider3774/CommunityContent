/* *****************************************************************************
*  VirconBox2D : b2_geometry.h        (port of Box2D v3 src/geometry.c -- slice 1)
*  --------------------------------------------------------------------------- *
*  Shape construction, mass properties, shape AABBs, and point tests.          *
*                                                                              *
*  SLICE 1 (self-contained: math only). Deferred to later slices because they  *
*  depend on the hull / distance modules: b2MakePolygon*, b2PointInPolygon,    *
*  all ray casts, shape casts, and mover collisions.                           *
*                                                                              *
*  Port notes: functions returning b2Polygon / b2MassData / b2AABB by value    *
*  become out-pointers; b2WorldTransform / b2Vec2 / b2Rot args become pointers;*
*  compound literals -> temps; ternaries -> if / fmin / fmax; '{0}' -> memset; *
*  'double' math -> float; 'f' suffixes stripped.                              *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_GEOMETRY_H
    #define B2_GEOMETRY_H

    #include "math.h"
    #include "misc.h"            // memset
    #include "b2_math.h"
    #include "b2_collision.h"
    #include "b2_distance.h"     // b2MakeProxy / b2ShapeCast (shape casts + rounded ray)
// *****************************************************************************


// =============================================================================
//   SHAPE CONSTRUCTION
// =============================================================================


// axis-aligned box centered at the origin
void b2MakeBox( float halfWidth, float halfHeight, b2Polygon* shape )
{
    memset( shape, 0, sizeof( b2Polygon ) );
    shape->count = 4;

    shape->vertices[0].x = -halfWidth;  shape->vertices[0].y = -halfHeight;
    shape->vertices[1].x =  halfWidth;  shape->vertices[1].y = -halfHeight;
    shape->vertices[2].x =  halfWidth;  shape->vertices[2].y =  halfHeight;
    shape->vertices[3].x = -halfWidth;  shape->vertices[3].y =  halfHeight;

    shape->normals[0].x =  0.0;  shape->normals[0].y = -1.0;
    shape->normals[1].x =  1.0;  shape->normals[1].y =  0.0;
    shape->normals[2].x =  0.0;  shape->normals[2].y =  1.0;
    shape->normals[3].x = -1.0;  shape->normals[3].y =  0.0;

    shape->radius = 0.0;
    shape->centroid.x = 0.0;  shape->centroid.y = 0.0;
}

// ---------------------------------------------------------

void b2MakeSquare( float halfWidth, b2Polygon* shape )
{
    b2MakeBox( halfWidth, halfWidth, shape );
}

// ---------------------------------------------------------

void b2MakeRoundedBox( float halfWidth, float halfHeight, float radius, b2Polygon* shape )
{
    b2MakeBox( halfWidth, halfHeight, shape );
    shape->radius = radius;
}

// ---------------------------------------------------------

// box centered at 'center' and rotated by 'rotation'
void b2MakeOffsetBox( float halfWidth, float halfHeight, b2Vec2* center, b2Rot* rotation, b2Polygon* shape )
{
    b2Transform xf;
    xf.p = *center;
    xf.q = *rotation;

    memset( shape, 0, sizeof( b2Polygon ) );
    shape->count = 4;

    b2Vec2 corner;
    corner.x = -halfWidth;  corner.y = -halfHeight;  b2TransformPoint( &xf, &corner, &shape->vertices[0] );
    corner.x =  halfWidth;  corner.y = -halfHeight;  b2TransformPoint( &xf, &corner, &shape->vertices[1] );
    corner.x =  halfWidth;  corner.y =  halfHeight;  b2TransformPoint( &xf, &corner, &shape->vertices[2] );
    corner.x = -halfWidth;  corner.y =  halfHeight;  b2TransformPoint( &xf, &corner, &shape->vertices[3] );

    b2Vec2 n;
    n.x =  0.0;  n.y = -1.0;  b2RotateVector( &xf.q, &n, &shape->normals[0] );
    n.x =  1.0;  n.y =  0.0;  b2RotateVector( &xf.q, &n, &shape->normals[1] );
    n.x =  0.0;  n.y =  1.0;  b2RotateVector( &xf.q, &n, &shape->normals[2] );
    n.x = -1.0;  n.y =  0.0;  b2RotateVector( &xf.q, &n, &shape->normals[3] );

    shape->radius = 0.0;
    shape->centroid = xf.p;
}

// ---------------------------------------------------------

// area-weighted centroid of a convex polygon
void b2ComputePolygonCentroid( b2Vec2* vertices, int count, b2Vec2* result )
{
    b2Vec2 center;  center.x = 0.0;  center.y = 0.0;
    float area = 0.0;

    // first vertex as triangle-fan origin (reduces round-off)
    b2Vec2 origin = vertices[0];
    float inv3 = 1.0 / 3.0;

    for( int i = 1; i < count - 1; i++ )
    {
        b2Vec2 e1;  b2Sub( &vertices[i], &origin, &e1 );
        b2Vec2 e2;  b2Sub( &vertices[i + 1], &origin, &e2 );
        float a = 0.5 * b2Cross( &e1, &e2 );

        b2Vec2 e1pe2;  b2Add( &e1, &e2, &e1pe2 );
        b2MulAdd( &center, a * inv3, &e1pe2, &center );
        area += a;
    }

    float invArea = 1.0 / area;
    center.x *= invArea;
    center.y *= invArea;

    // restore the origin offset
    b2Add( &origin, &center, result );
}

// ---------------------------------------------------------

// build a polygon from a computed hull (b2_hull.h). Edges must be non-degenerate.
void b2MakePolygon( b2Hull* hull, float radius, b2Polygon* shape )
{
    if( hull->count < 3 )
    {
        // bad hull fallback
        b2MakeSquare( 0.5, shape );
        return;
    }

    memset( shape, 0, sizeof( b2Polygon ) );
    shape->count = hull->count;
    shape->radius = radius;

    // copy vertices
    for( int i = 0; i < shape->count; i++ )
      shape->vertices[i] = hull->points[i];

    // outward normals
    for( int i = 0; i < shape->count; i++ )
    {
        int i2 = 0;
        if( i + 1 < shape->count ) i2 = i + 1;

        b2Vec2 edge;  b2Sub( &shape->vertices[i2], &shape->vertices[i], &edge );
        b2Vec2 cv;    b2CrossVS( &edge, 1.0, &cv );
        b2Normalize( &cv, &shape->normals[i] );
    }

    b2ComputePolygonCentroid( shape->vertices, shape->count, &shape->centroid );
}

// ---------------------------------------------------------

// Make a (rounded) polygon from a hull, placed at position/rotation. Mirrors
// b2MakePolygon but transforms each hull point into world first, then derives
// normals from the transformed edges. (out-pointer result; multi-word inputs
// position/rotation passed by pointer.)
void b2MakeOffsetRoundedPolygon( b2Hull* hull, b2Vec2* position, b2Rot* rotation, float radius, b2Polygon* shape )
{
    if( hull->count < 3 )
    {
        b2MakeSquare( 0.5, shape );
        return;
    }

    b2Transform transform;
    transform.p = *position;
    transform.q = *rotation;

    memset( shape, 0, sizeof( b2Polygon ) );
    shape->count = hull->count;
    shape->radius = radius;

    for( int i = 0; i < shape->count; i++ )
      b2TransformPoint( &transform, &hull->points[i], &shape->vertices[i] );

    for( int i = 0; i < shape->count; i++ )
    {
        int i2 = 0;
        if( i + 1 < shape->count ) i2 = i + 1;

        b2Vec2 edge;  b2Sub( &shape->vertices[i2], &shape->vertices[i], &edge );
        b2Vec2 cv;    b2CrossVS( &edge, 1.0, &cv );
        b2Normalize( &cv, &shape->normals[i] );
    }

    b2ComputePolygonCentroid( shape->vertices, shape->count, &shape->centroid );
}

void b2MakeOffsetPolygon( b2Hull* hull, b2Vec2* position, b2Rot* rotation, b2Polygon* shape )
{
    b2MakeOffsetRoundedPolygon( hull, position, rotation, 0.0, shape );
}

// ---------------------------------------------------------

// Apply a transform to a polygon's vertices/normals/centroid, writing 'result'.
// (result may NOT alias polygon; each field is transformed via a local copy so
// no variable-index array member is read and written in the same call.)
void b2TransformPolygon( b2Transform* transform, b2Polygon* polygon, b2Polygon* result )
{
    memcpy( result, polygon, sizeof( b2Polygon ) );

    for( int i = 0; i < result->count; i++ )
    {
        b2Vec2 v = result->vertices[i];
        b2TransformPoint( transform, &v, &result->vertices[i] );
        b2Vec2 n = result->normals[i];
        b2RotateVector( &transform->q, &n, &result->normals[i] );
    }

    b2Vec2 c = result->centroid;
    b2TransformPoint( transform, &c, &result->centroid );
}


// =============================================================================
//   MASS PROPERTIES
// =============================================================================


void b2ComputeCircleMass( b2Circle* shape, float density, b2MassData* massData )
{
    float rr = shape->radius * shape->radius;
    massData->mass = density * B2_PI * rr;
    massData->center = shape->center;
    // inertia about the center of mass
    massData->rotationalInertia = massData->mass * 0.5 * rr;
}

// ---------------------------------------------------------

void b2ComputeCapsuleMass( b2Capsule* shape, float density, b2MassData* massData )
{
    float radius = shape->radius;
    float rr = radius * radius;
    b2Vec2 p1 = shape->center1;
    b2Vec2 p2 = shape->center2;

    b2Vec2 diff;  b2Sub( &p2, &p1, &diff );
    float length = b2Length( &diff );
    float ll = length * length;

    float circleMass = density * ( B2_PI * radius * radius );
    float boxMass = density * ( 2.0 * radius * length );

    massData->mass = circleMass + boxMass;
    massData->center.x = 0.5 * ( p1.x + p2.x );
    massData->center.y = 0.5 * ( p1.y + p2.y );

    // parallel-axis theorem applied to two offset half-circles plus a box
    float lc = 4.0 * radius / ( 3.0 * B2_PI );   // half-circle centroid
    float h = 0.5 * length;                       // half rectangle length

    float circleInertia = circleMass * ( 0.5 * rr + h * h + 2.0 * h * lc );
    float boxInertia = boxMass * ( 4.0 * rr + ll ) / 12.0;
    massData->rotationalInertia = circleInertia + boxInertia;
}

// ---------------------------------------------------------

void b2ComputePolygonMass( b2Polygon* shape, float density, b2MassData* massData )
{
    // degenerate cases fall back to circle / capsule
    if( shape->count == 1 )
    {
        b2Circle circle;
        circle.center = shape->vertices[0];
        circle.radius = shape->radius;
        b2ComputeCircleMass( &circle, density, massData );
        return;
    }

    if( shape->count == 2 )
    {
        b2Capsule capsule;
        capsule.center1 = shape->vertices[0];
        capsule.center2 = shape->vertices[1];
        capsule.radius = shape->radius;
        b2ComputeCapsuleMass( &capsule, density, massData );
        return;
    }

    b2Vec2[B2_MAX_POLYGON_VERTICES] vertices;
    memset( vertices, 0, sizeof( vertices ) );
    int count = shape->count;
    float radius = shape->radius;

    if( radius > 0.0 )
    {
        // approximate a rounded polygon by pushing the vertices outward
        float sqrt2 = 1.412;
        for( int i = 0; i < count; i++ )
        {
            int j = i - 1;
            if( i == 0 ) j = count - 1;

            b2Vec2 n1 = shape->normals[j];
            b2Vec2 n2 = shape->normals[i];
            b2Vec2 sum;  b2Add( &n1, &n2, &sum );
            b2Vec2 mid;  b2Normalize( &sum, &mid );
            b2MulAdd( &shape->vertices[i], sqrt2 * radius, &mid, &vertices[i] );
        }
    }
    else
    {
        for( int i = 0; i < count; i++ )
          vertices[i] = shape->vertices[i];
    }

    b2Vec2 center;  center.x = 0.0;  center.y = 0.0;
    float area = 0.0;
    float rotationalInertia = 0.0;

    // reference point for triangle fan (first vertex reduces round-off)
    b2Vec2 r = vertices[0];
    float inv3 = 1.0 / 3.0;

    for( int i = 1; i < count - 1; i++ )
    {
        b2Vec2 e1;  b2Sub( &vertices[i], &r, &e1 );
        b2Vec2 e2;  b2Sub( &vertices[i + 1], &r, &e2 );

        float D = b2Cross( &e1, &e2 );
        float triangleArea = 0.5 * D;
        area += triangleArea;

        // area-weighted centroid (r at origin)
        b2Vec2 e1pe2;  b2Add( &e1, &e2, &e1pe2 );
        b2MulAdd( &center, triangleArea * inv3, &e1pe2, &center );

        float ex1 = e1.x;  float ey1 = e1.y;
        float ex2 = e2.x;  float ey2 = e2.y;

        float intx2 = ex1 * ex1 + ex2 * ex1 + ex2 * ex2;
        float inty2 = ey1 * ey1 + ey2 * ey1 + ey2 * ey2;

        rotationalInertia += ( 0.25 * inv3 * D ) * ( intx2 + inty2 );
    }

    massData->mass = density * area;

    // shift centroid back from origin at r
    float invArea = 1.0 / area;
    center.x *= invArea;
    center.y *= invArea;
    b2Add( &r, &center, &massData->center );

    // inertia about the local origin, then shift to the center of mass
    massData->rotationalInertia = density * rotationalInertia;
    massData->rotationalInertia -= massData->mass * b2Dot( &center, &center );
}


// =============================================================================
//   SHAPE AABBs
// =============================================================================
//   In single precision the rounding helpers are plain pass-throughs, so the
//   "fat" (margin) helpers and the public AABB functions are straightforward.


void b2ComputeCircleFatAABB( b2Circle* shape, b2WorldTransform* xf, float extra, b2AABB* aabb )
{
    b2Pos c;  b2TransformWorldPoint( xf, &shape->center, &c );
    float r = shape->radius + extra;
    aabb->lowerBound.x = b2RoundDownFloat( c.x - r );
    aabb->lowerBound.y = b2RoundDownFloat( c.y - r );
    aabb->upperBound.x = b2RoundUpFloat( c.x + r );
    aabb->upperBound.y = b2RoundUpFloat( c.y + r );
}

// ---------------------------------------------------------

void b2ComputeCapsuleFatAABB( b2Capsule* shape, b2WorldTransform* xf, float extra, b2AABB* aabb )
{
    b2Pos v1;  b2TransformWorldPoint( xf, &shape->center1, &v1 );
    b2Pos v2;  b2TransformWorldPoint( xf, &shape->center2, &v2 );
    float r = shape->radius + extra;
    aabb->lowerBound.x = b2RoundDownFloat( fmin( v1.x, v2.x ) - r );
    aabb->lowerBound.y = b2RoundDownFloat( fmin( v1.y, v2.y ) - r );
    aabb->upperBound.x = b2RoundUpFloat( fmax( v1.x, v2.x ) + r );
    aabb->upperBound.y = b2RoundUpFloat( fmax( v1.y, v2.y ) + r );
}

// ---------------------------------------------------------

void b2ComputePolygonFatAABB( b2Polygon* shape, b2WorldTransform* xf, float extra, b2AABB* aabb )
{
    b2Pos v;  b2TransformWorldPoint( xf, &shape->vertices[0], &v );
    float lx = v.x;  float ly = v.y;  float ux = v.x;  float uy = v.y;

    for( int i = 1; i < shape->count; i++ )
    {
        b2TransformWorldPoint( xf, &shape->vertices[i], &v );
        lx = fmin( v.x, lx );
        ly = fmin( v.y, ly );
        ux = fmax( v.x, ux );
        uy = fmax( v.y, uy );
    }

    float r = shape->radius + extra;
    aabb->lowerBound.x = b2RoundDownFloat( lx - r );
    aabb->lowerBound.y = b2RoundDownFloat( ly - r );
    aabb->upperBound.x = b2RoundUpFloat( ux + r );
    aabb->upperBound.y = b2RoundUpFloat( uy + r );
}

// ---------------------------------------------------------

void b2ComputeSegmentFatAABB( b2Segment* shape, b2WorldTransform* xf, float extra, b2AABB* aabb )
{
    b2Pos v1;  b2TransformWorldPoint( xf, &shape->point1, &v1 );
    b2Pos v2;  b2TransformWorldPoint( xf, &shape->point2, &v2 );
    aabb->lowerBound.x = b2RoundDownFloat( fmin( v1.x, v2.x ) - extra );
    aabb->lowerBound.y = b2RoundDownFloat( fmin( v1.y, v2.y ) - extra );
    aabb->upperBound.x = b2RoundUpFloat( fmax( v1.x, v2.x ) + extra );
    aabb->upperBound.y = b2RoundUpFloat( fmax( v1.y, v2.y ) + extra );
}

// ---------------------------------------------------------

void b2ComputeCircleAABB( b2Circle* shape, b2WorldTransform* xf, b2AABB* result )
{
    b2ComputeCircleFatAABB( shape, xf, 0.0, result );
}

void b2ComputeCapsuleAABB( b2Capsule* shape, b2WorldTransform* xf, b2AABB* result )
{
    b2ComputeCapsuleFatAABB( shape, xf, 0.0, result );
}

void b2ComputePolygonAABB( b2Polygon* shape, b2WorldTransform* xf, b2AABB* result )
{
    b2ComputePolygonFatAABB( shape, xf, 0.0, result );
}

void b2ComputeSegmentAABB( b2Segment* shape, b2WorldTransform* xf, b2AABB* result )
{
    b2ComputeSegmentFatAABB( shape, xf, 0.0, result );
}


// =============================================================================
//   POINT TESTS
// =============================================================================


bool b2PointInCircle( b2Circle* shape, b2Vec2* point )
{
    return b2DistanceSquared( point, &shape->center ) <= shape->radius * shape->radius;
}

// ---------------------------------------------------------

bool b2PointInCapsule( b2Capsule* shape, b2Vec2* point )
{
    float rr = shape->radius * shape->radius;
    b2Vec2 p1 = shape->center1;
    b2Vec2 p2 = shape->center2;

    b2Vec2 d;  b2Sub( &p2, &p1, &d );
    float dd = b2Dot( &d, &d );

    if( dd == 0.0 )
    {
        // capsule is really a circle
        return b2DistanceSquared( point, &p1 ) <= rr;
    }

    // closest point on the capsule segment: c = p1 + t * d
    b2Vec2 pmp1;  b2Sub( point, &p1, &pmp1 );
    float t = b2Dot( &pmp1, &d ) / dd;
    t = b2ClampFloat( t, 0.0, 1.0 );

    b2Vec2 c;  b2MulAdd( &p1, t, &d, &c );
    return b2DistanceSquared( point, &c ) <= rr;
}


// =============================================================================
//   SHAPE RAY CASTS  (geometry slice 2 -- ports geometry.c b2RayCast*)
// =============================================================================
//   All are in the SHAPE's local frame: transform the ray into local space
//   before calling (b2World_CastRay will do that once it exists). Upstream
//   returned a b2CastOutput by value -> here it is the LAST out-pointer arg,
//   zeroed up front (a miss leaves hit == false).
// -----------------------------------------------------------------------------

void b2RayCastCircle( b2Circle* shape, b2RayCastInput* input, b2CastOutput* output )
{
    output->normal = b2Vec2_zero;
    output->point = b2Vec2_zero;
    output->fraction = 0.0;
    output->iterations = 0;
    output->hit = false;

    b2Vec2 p = shape->center;

    // shift ray so the circle center is the origin: s = origin - center
    b2Vec2 s;  b2Sub( &input->origin, &p, &s );

    float r = shape->radius;
    float rr = r * r;

    float length;
    b2Vec2 d;  b2GetLengthAndNormalize( &length, &input->translation, &d );
    if( length == 0.0 )
    {
        // zero-length ray: hit only if it starts inside
        if( b2LengthSquared( &s ) < rr )
        {
            output->point = input->origin;
            output->hit = true;
        }
        return;
    }

    // closest point on the ray line to the origin: t = -dot(s, d)
    float t = -b2Dot( &s, &d );
    b2Vec2 c;  b2MulAdd( &s, t, &d, &c );   // c = s + t*d
    float cc = b2Dot( &c, &c );

    if( cc > rr )
        return;   // closest point is outside the circle -> miss

    float h = sqrt( rr - cc );              // Pythagoras
    float fraction = t - h;

    if( fraction < 0.0 || input->maxFraction * length < fraction )
    {
        // intersection outside the ray segment (but maybe started inside)
        if( b2LengthSquared( &s ) < rr )
        {
            output->point = input->origin;
            output->hit = true;
        }
        return;
    }

    b2Vec2 hitPoint;  b2MulAdd( &s, fraction, &d, &hitPoint );   // relative to center
    output->fraction = fraction / length;
    b2Normalize( &hitPoint, &output->normal );
    b2MulAdd( &p, shape->radius, &output->normal, &output->point );
    output->hit = true;
}

// ---------------------------------------------------------

void b2RayCastCapsule( b2Capsule* shape, b2RayCastInput* input, b2CastOutput* output )
{
    output->normal = b2Vec2_zero;
    output->point = b2Vec2_zero;
    output->fraction = 0.0;
    output->iterations = 0;
    output->hit = false;

    b2Vec2 v1 = shape->center1;
    b2Vec2 v2 = shape->center2;
    b2Vec2 e;  b2Sub( &v2, &v1, &e );

    float capsuleLength;
    b2Vec2 a;  b2GetLengthAndNormalize( &capsuleLength, &e, &a );

    if( capsuleLength < FLT_EPSILON )
    {
        // capsule is really a circle
        b2Circle circle;  circle.center = v1;  circle.radius = shape->radius;
        b2RayCastCircle( &circle, input, output );
        return;
    }

    b2Vec2 p1 = input->origin;
    b2Vec2 d = input->translation;

    b2Vec2 q;  b2Sub( &p1, &v1, &q );       // q = p1 - v1
    float qa = b2Dot( &q, &a );
    b2Vec2 qp;  b2MulAdd( &q, -qa, &a, &qp );   // qp = q - qa*a (perp to axis)

    float radius = shape->radius;

    // does the ray start within the infinite-length capsule?
    if( b2Dot( &qp, &qp ) < radius * radius )
    {
        if( qa < 0.0 )
        {
            b2Circle circle;  circle.center = v1;  circle.radius = shape->radius;
            b2RayCastCircle( &circle, input, output );
            return;
        }
        if( qa > capsuleLength )
        {
            b2Circle circle;  circle.center = v2;  circle.radius = shape->radius;
            b2RayCastCircle( &circle, input, output );
            return;
        }
        output->point = input->origin;   // starts inside the capsule
        output->hit = true;
        return;
    }

    // perpendicular to the axis, pointing right
    b2Vec2 n;  n.x = a.y;  n.y = -a.x;

    float rayLength;
    b2Vec2 u;  b2GetLengthAndNormalize( &rayLength, &d, &u );

    // Cramer's rule [a -u]
    float den = -a.x * u.y + u.x * a.y;
    if( -FLT_EPSILON < den && den < FLT_EPSILON )
        return;   // ray parallel to capsule and outside it

    b2Vec2 b1;   b2MulSub( &q, radius, &n, &b1 );   // b1 = q - radius*n
    b2Vec2 b2v;  b2MulAdd( &q, radius, &n, &b2v );   // b2 = q + radius*n

    float invDen = 1.0 / den;
    float s21 = ( a.x * b1.y  - b1.x  * a.y ) * invDen;   // [a b1]
    float s22 = ( a.x * b2v.y - b2v.x * a.y ) * invDen;   // [a b2]

    float s2;
    b2Vec2 b;
    if( s21 < s22 )
    {
        s2 = s21;
        b = b1;
    }
    else
    {
        s2 = s22;
        b = b2v;
        b2Neg( &n, &n );   // flip the normal to the other side
    }

    if( s2 < 0.0 || input->maxFraction * rayLength < s2 )
        return;

    float s1 = ( -b.x * u.y + u.x * b.y ) * invDen;   // [b -u]

    if( s1 < 0.0 )
    {
        // ray passes behind the capsule segment -> cap at v1
        b2Circle circle;  circle.center = v1;  circle.radius = shape->radius;
        b2RayCastCircle( &circle, input, output );
        return;
    }
    else if( capsuleLength < s1 )
    {
        // ray passes ahead of the capsule segment -> cap at v2
        b2Circle circle;  circle.center = v2;  circle.radius = shape->radius;
        b2RayCastCircle( &circle, input, output );
        return;
    }
    else
    {
        // ray hits the capsule side
        output->fraction = s2 / rayLength;
        b2Vec2 lp;  b2Lerp( &v1, &v2, s1 / capsuleLength, &lp );
        b2Vec2 rn;  b2MulSV( shape->radius, &n, &rn );
        b2Add( &lp, &rn, &output->point );
        output->normal = n;
        output->hit = true;
    }
}

// ---------------------------------------------------------

// Ray vs line segment. oneSided skips left-side (back-face) collisions.
void b2RayCastSegment( b2Segment* shape, b2RayCastInput* input, bool oneSided, b2CastOutput* output )
{
    output->normal = b2Vec2_zero;
    output->point = b2Vec2_zero;
    output->fraction = 0.0;
    output->iterations = 0;
    output->hit = false;

    if( oneSided )
    {
        // skip left-side collision: offset = cross(origin - p1, p2 - p1)
        b2Vec2 op1;  b2Sub( &input->origin, &shape->point1, &op1 );
        b2Vec2 e0;   b2Sub( &shape->point2, &shape->point1, &e0 );
        if( b2Cross( &op1, &e0 ) < 0.0 )
            return;
    }

    b2Vec2 p1 = input->origin;
    b2Vec2 d = input->translation;
    b2Vec2 v1 = shape->point1;
    b2Vec2 v2 = shape->point2;
    b2Vec2 e;  b2Sub( &v2, &v1, &e );

    float length;
    b2Vec2 eUnit;  b2GetLengthAndNormalize( &length, &e, &eUnit );
    if( length == 0.0 )
        return;

    // normal points to the right, looking from v1 towards v2
    b2Vec2 normal;  b2RightPerp( &eUnit, &normal );

    // intersect ray with the infinite segment line
    b2Vec2 v1mp1;  b2Sub( &v1, &p1, &v1mp1 );
    float numerator = b2Dot( &normal, &v1mp1 );
    float denominator = b2Dot( &normal, &d );

    if( denominator == 0.0 )
        return;   // parallel

    float t = numerator / denominator;
    if( t < 0.0 || input->maxFraction < t )
        return;   // out of ray range

    b2Vec2 p;  b2MulAdd( &p1, t, &d, &p );   // p = p1 + t*d

    // position of p along the segment
    b2Vec2 pmv1;  b2Sub( &p, &v1, &pmv1 );
    float s = b2Dot( &pmv1, &eUnit );
    if( s < 0.0 || length < s )
        return;   // out of segment range

    if( numerator > 0.0 )
        b2Neg( &normal, &normal );

    output->fraction = t;
    output->point = p;
    output->normal = normal;
    output->hit = true;
}

// ---------------------------------------------------------

// Ray vs convex polygon. A radius-0 polygon takes the exact half-space clip below;
// a ROUNDED polygon (radius > 0) has curved corners, so it is handled by casting the
// ray's origin as a zero-radius point proxy against the rounded hull (b2ShapeCast).
void b2RayCastPolygon( b2Polygon* shape, b2RayCastInput* input, b2CastOutput* output )
{
    output->normal = b2Vec2_zero;
    output->point = b2Vec2_zero;
    output->fraction = 0.0;
    output->iterations = 0;
    output->hit = false;

    if( shape->radius != 0.0 )
    {
        b2ShapeCastPairInput castInput;
        b2MakeProxy( shape->vertices, shape->count, shape->radius, &castInput.proxyA );
        b2MakeProxy( &input->origin, 1, 0.0, &castInput.proxyB );
        castInput.transform = b2Transform_identity;
        castInput.translationB = input->translation;
        castInput.maxFraction = input->maxFraction;
        castInput.canEncroach = false;
        b2ShapeCast( &castInput, output );
        return;
    }

    // shift all math to the first vertex (polygon may be far from origin)
    b2Vec2 base = shape->vertices[0];
    b2Vec2 p1;  b2Sub( &input->origin, &base, &p1 );
    b2Vec2 d = input->translation;

    float lower = 0.0;
    float upper = input->maxFraction;
    int index = -1;

    int edgeIndex;
    for( edgeIndex = 0; edgeIndex < shape->count; ++edgeIndex )
    {
        // whole-struct variable-index copies (the attested-green form) -> locals
        b2Vec2 vtx = shape->vertices[edgeIndex];
        b2Vec2 nrm = shape->normals[edgeIndex];

        b2Vec2 vertex;  b2Sub( &vtx, &base, &vertex );
        b2Vec2 vmp1;    b2Sub( &vertex, &p1, &vmp1 );
        float numerator = b2Dot( &nrm, &vmp1 );
        float denominator = b2Dot( &nrm, &d );

        if( denominator == 0.0 )
        {
            if( numerator < 0.0 )
                return;   // parallel and outside this edge -> miss
        }
        else
        {
            // division-free half-space update (see upstream note)
            if( denominator < 0.0 && numerator < lower * denominator )
            {
                lower = numerator / denominator;   // segment enters this half-space
                index = edgeIndex;
            }
            else if( denominator > 0.0 && numerator < upper * denominator )
            {
                upper = numerator / denominator;   // segment exits this half-space
            }
        }

        if( upper < lower )
            return;   // ray misses
    }

    if( index >= 0 )
    {
        output->fraction = lower;
        output->normal = shape->normals[index];   // whole-struct variable-index copy
        b2MulAdd( &input->origin, lower, &d, &output->point );
        output->hit = true;
    }
    else
    {
        // initial overlap (ray starts inside the polygon)
        output->point = input->origin;
        output->hit = true;
    }
}


// =============================================================================
//   SHAPE CASTS (sweep a generic proxy against one shape)
// =============================================================================
//   Thin wrappers over b2ShapeCast: build the fixed shape's proxy, hand it the
//   moving proxy from the input, and cast in the fixed shape's frame. The hit
//   point/normal come back in that same frame.
//
//   Note the hit fraction stops a hair short of geometric contact -- see the
//   TARGET note on b2ShapeCast in b2_distance.h before hand-computing values.

void b2ShapeCastCircle( b2Circle* shape, b2ShapeCastInput* input, b2CastOutput* output )
{
    b2ShapeCastPairInput pairInput;
    b2MakeProxy( &shape->center, 1, shape->radius, &pairInput.proxyA );
    pairInput.proxyB = input->proxy;
    pairInput.transform = b2Transform_identity;
    pairInput.translationB = input->translation;
    pairInput.maxFraction = input->maxFraction;
    pairInput.canEncroach = input->canEncroach;

    b2ShapeCast( &pairInput, output );
}

void b2ShapeCastCapsule( b2Capsule* shape, b2ShapeCastInput* input, b2CastOutput* output )
{
    b2ShapeCastPairInput pairInput;
    b2MakeProxy( &shape->center1, 2, shape->radius, &pairInput.proxyA );
    pairInput.proxyB = input->proxy;
    pairInput.transform = b2Transform_identity;
    pairInput.translationB = input->translation;
    pairInput.maxFraction = input->maxFraction;
    pairInput.canEncroach = input->canEncroach;

    b2ShapeCast( &pairInput, output );
}

void b2ShapeCastSegment( b2Segment* shape, b2ShapeCastInput* input, b2CastOutput* output )
{
    b2ShapeCastPairInput pairInput;
    b2MakeProxy( &shape->point1, 2, 0.0, &pairInput.proxyA );
    pairInput.proxyB = input->proxy;
    pairInput.transform = b2Transform_identity;
    pairInput.translationB = input->translation;
    pairInput.maxFraction = input->maxFraction;
    pairInput.canEncroach = input->canEncroach;

    b2ShapeCast( &pairInput, output );
}

void b2ShapeCastPolygon( b2Polygon* shape, b2ShapeCastInput* input, b2CastOutput* output )
{
    b2ShapeCastPairInput pairInput;
    b2MakeProxy( shape->vertices, shape->count, shape->radius, &pairInput.proxyA );
    pairInput.proxyB = input->proxy;
    pairInput.transform = b2Transform_identity;
    pairInput.translationB = input->translation;
    pairInput.maxFraction = input->maxFraction;
    pairInput.canEncroach = input->canEncroach;

    b2ShapeCast( &pairInput, output );
}


// =============================================================================
//   MOVER COLLIDE  (character controller: capsule mover vs one convex shape)
// =============================================================================
//   Each returns a b2PlaneResult: the half-space the mover must be pushed out of.
//   All four share one shape: GJK the shape's CORE hull against the mover's core
//   segment (useRadii = false), then compare the core distance against the combined
//   radii. The plane's normal points shape -> mover (the push direction) and its
//   offset is the penetration depth.
//
//   DEEP OVERLAP: `hit` is set whenever distance <= totalRadius, which INCLUDES
//   distance == 0 (mover wedged inside the shape) -- and there b2Normalize hands
//   back a zero normal. Upstream filters that in its tree callback, not here, so
//   these functions are faithful and b2World_CollideMover carries the
//   b2IsNormalized guard. A direct caller must do the same.
//
//   `point` is the witness on the SHAPE, in whatever frame the caller passed in.

void b2CollideMoverAndCircle( b2Capsule* mover, b2Circle* shape, b2PlaneResult* result )
{
    result->plane.normal = b2Vec2_zero;
    result->plane.offset = 0.0;
    result->point = b2Vec2_zero;
    result->hit = false;

    b2DistanceInput input;
    b2MakeProxy( &shape->center, 1, 0.0, &input.proxyA );
    b2MakeProxy( &mover->center1, 2, mover->radius, &input.proxyB );
    input.transform = b2Transform_identity;
    input.useRadii = false;

    float totalRadius = mover->radius + shape->radius;

    b2SimplexCache cache;  cache.count = 0;
    b2DistanceOutput output;
    b2ShapeDistance( &input, &cache, &output );

    if( output.distance <= totalRadius )
    {
        result->plane.normal = output.normal;
        result->plane.offset = totalRadius - output.distance;
        result->point = output.pointA;
        result->hit = true;
    }
}

void b2CollideMoverAndCapsule( b2Capsule* mover, b2Capsule* shape, b2PlaneResult* result )
{
    result->plane.normal = b2Vec2_zero;
    result->plane.offset = 0.0;
    result->point = b2Vec2_zero;
    result->hit = false;

    b2DistanceInput input;
    b2MakeProxy( &shape->center1, 2, 0.0, &input.proxyA );
    b2MakeProxy( &mover->center1, 2, mover->radius, &input.proxyB );
    input.transform = b2Transform_identity;
    input.useRadii = false;

    float totalRadius = mover->radius + shape->radius;

    b2SimplexCache cache;  cache.count = 0;
    b2DistanceOutput output;
    b2ShapeDistance( &input, &cache, &output );

    if( output.distance <= totalRadius )
    {
        result->plane.normal = output.normal;
        result->plane.offset = totalRadius - output.distance;
        result->point = output.pointA;
        result->hit = true;
    }
}

void b2CollideMoverAndPolygon( b2Capsule* mover, b2Polygon* shape, b2PlaneResult* result )
{
    result->plane.normal = b2Vec2_zero;
    result->plane.offset = 0.0;
    result->point = b2Vec2_zero;
    result->hit = false;

    b2DistanceInput input;
    b2MakeProxy( shape->vertices, shape->count, shape->radius, &input.proxyA );
    b2MakeProxy( &mover->center1, 2, mover->radius, &input.proxyB );
    input.transform = b2Transform_identity;
    input.useRadii = false;

    float totalRadius = mover->radius + shape->radius;

    b2SimplexCache cache;  cache.count = 0;
    b2DistanceOutput output;
    b2ShapeDistance( &input, &cache, &output );

    if( output.distance <= totalRadius )
    {
        result->plane.normal = output.normal;
        result->plane.offset = totalRadius - output.distance;
        result->point = output.pointA;
        result->hit = true;
    }
}

// Segments have no radius, so the combined radius is the mover's alone.
void b2CollideMoverAndSegment( b2Capsule* mover, b2Segment* shape, b2PlaneResult* result )
{
    result->plane.normal = b2Vec2_zero;
    result->plane.offset = 0.0;
    result->point = b2Vec2_zero;
    result->hit = false;

    b2DistanceInput input;
    b2MakeProxy( &shape->point1, 2, 0.0, &input.proxyA );
    b2MakeProxy( &mover->center1, 2, mover->radius, &input.proxyB );
    input.transform = b2Transform_identity;
    input.useRadii = false;

    float totalRadius = mover->radius;

    b2SimplexCache cache;  cache.count = 0;
    b2DistanceOutput output;
    b2ShapeDistance( &input, &cache, &output );

    if( output.distance <= totalRadius )
    {
        result->plane.normal = output.normal;
        result->plane.offset = totalRadius - output.distance;
        result->point = output.pointA;
        result->hit = true;
    }
}


// *****************************************************************************
    #endif
// *****************************************************************************
