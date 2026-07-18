/* *****************************************************************************
*  VirconBox2D : b2_shape.h        (port of Box2D v3 src/shape.c -- SLICE 1)
*  --------------------------------------------------------------------------- *
*  Sim-core entry. SLICE 1: the pure, world-independent shape compute helpers   *
*  that dispatch on shape type into the already-ported geometry routines --     *
*  b2ComputeShapeAABB / b2ComputeShapeMass / b2ComputeShapeExtent. These need    *
*  no b2World/b2Body back-references, so they're a clean first testable unit.   *
*                                                                              *
*  b2Shape here is MINIMAL: just the discriminant + per-type shape data +       *
*  density (enough for these helpers). The full solver-side b2Shape (ids, AABB  *
*  cache, filter, material, events, world links) is deferred. No unions, so the  *
*  shape variants are separate fields. switch -> if/else. chainSegment deferred. *
*  Returns are via out-pointers (multi-word). b2WorldTransform == b2Transform.   *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_SHAPE_H
    #define B2_SHAPE_H

    #include "b2_math.h"
    #include "b2_constants.h"
    #include "b2_collision.h"
    #include "b2_geometry.h"
// *****************************************************************************


// b2ShapeType discriminant (upstream enum order: circle, capsule, segment, polygon, chain)
#define b2_circleShape        0
#define b2_capsuleShape       1
#define b2_segmentShape       2
#define b2_polygonShape       3
#define b2_chainSegmentShape  4


struct b2ShapeExtent
{
    float minExtent;   // smallest distance from the shape centroid to a face
    float maxExtent;   // largest distance from localCenter to a feature
};

// Collision filter (P1.2). categoryBits = what this shape IS; maskBits = what it
// collides WITH; groupIndex = an override: two shapes with the same non-zero group
// always collide (group>0) or never collide (group<0), regardless of category/mask.
// Bit fields are 32-bit int masks (the port has no 64-bit / unsigned; -1 = all bits).
struct b2Filter
{
    int categoryBits;
    int maskBits;
    int groupIndex;
};

// Shape: identity + body link + discriminant + per-type data + density.
// (No union; per-type fields are separate. Still DEFERRED from the full
// solver-side struct: material, aabb/fatAABB caches, proxyKey,
// sensorIndex, localCentroid, the enable* event flags.)
struct b2Shape
{
    int id;            // index into world->shapes (B2_NULL_INDEX when free)
    int bodyId;        // owning body id
    int prevShapeId;   // doubly-linked list within the body
    int nextShapeId;
    int type;          // b2ShapeType
    float density;
    float friction;    // surface friction (mixed with sqrt at contact)
    float restitution; // surface restitution/bounce (mixed with max at contact)
    int proxyKey;      // packed broad-phase proxy key (B2_NULL_INDEX if none)
    b2AABB aabb;       // tight AABB + speculativeDistance on each side. b2Collide skips
                       // the narrow phase for a pair whose aabb's don't overlap (disjoint
                       // early-out) -- tighter than fatAABB so it filters near-but-not-
                       // touching pairs the fat margin manufactures. (upstream shape->aabb)
    b2AABB fatAABB;    // fat AABB stored in the broad-phase tree (tight +- aabbMargin).
                       // The proxy is only moved when the tight AABB escapes this
                       // (PLAN_FOR_OPUS.md 5.2) -- resting bodies stop churning the tree.
    float aabbMargin;  // fattening added on each side (static: speculative; else max margin)
    int generation;    // bumped on (re)allocation, for stable b2ShapeId
    b2Filter filter;   // collision filter (category/mask/group)
    bool enableHitEvents; // emit b2ContactHitEvent when a solved impact exceeds world->hitEventThreshold
    bool enableContactEvents; // emit begin/end touch events (default true; BOTH shapes must opt in)
    bool isSensor;        // a sensor detects overlap but generates no collision response
    bool enableSensorEvents; // this shape participates in sensor overlap events (as sensor or visitor)
    int* sensorOverlaps;  // visitor shape ids currently overlapping this sensor (heap, sensor shapes only)
    int  sensorOverlapCount;
    int  sensorOverlapCapacity;
    void* userData;       // opaque game pointer, copied from b2ShapeDef at create
    b2Circle  circle;
    b2Capsule capsule;
    b2Polygon polygon;
    b2Segment segment;
    b2ChainSegment chainSegment;
};

// Stable, generation-checked handle to a shape (multi-word -> out-pointer).
struct b2ShapeId
{
    int index1;        // 1-based index into world->shapes
    int world0;
    int generation;
};

// Shape construction parameters (minimal subset). Init with b2DefaultShapeDef().
struct b2ShapeDef
{
    float density;
    float friction;         // surface friction coefficient (default 0.6)
    float restitution;      // surface restitution/bounce (default 0.0)
    b2Filter filter;        // collision filter (default: category 1, mask all, group 0)
    bool  enableHitEvents;  // opt in to hit events for this shape (default false)
    bool  enableContactEvents; // opt out of begin/end touch events (default true)
    bool  isSensor;         // make this shape a sensor (overlap detection, no response; default false)
    bool  enableSensorEvents; // participate in sensor overlap events (default true)
    bool  updateBodyMass;   // recompute the body's mass data on attach
    void* userData;
};

void b2DefaultShapeDef( b2ShapeDef* def )
{
    def->density = 1.0;
    def->friction = 0.6;
    def->restitution = 0.0;
    def->filter.categoryBits = 1;
    def->filter.maskBits = -1;      // -1 == all 32 bits set -> collides with everything
    def->filter.groupIndex = 0;
    def->enableHitEvents = false;
    def->enableContactEvents = true;
    def->isSensor = false;
    def->enableSensorEvents = true;
    def->updateBodyMass = true;
    def->userData = NULL;
}

// Should two shapes collide, per their filters? group override first (same non-zero
// group forces collide if >0 / never if <0), else the symmetric category/mask test.
// (upstream b2ShouldShapesCollide)
bool b2ShouldShapesCollide( b2Filter* a, b2Filter* b )
{
    if( a->groupIndex == b->groupIndex && a->groupIndex != 0 )
        return a->groupIndex > 0;
    return ( a->maskBits & b->categoryBits ) != 0 && ( a->categoryBits & b->maskBits ) != 0;
}

// ---------------------------------------------------------
//   Query filter: which shapes a spatial query is willing to see.
// ---------------------------------------------------------
//   Distinct from b2Filter: a query has no groupIndex, so the group override that
//   b2ShouldShapesCollide applies does not exist here -- only the category/mask
//   handshake, which must pass in BOTH directions.
//
//   Everywhere a query takes a `b2QueryFilter*`, passing NULL means "no filtering,
//   see every shape". (Upstream passes the filter by value; it is two words here, so
//   it crosses the boundary by pointer, and that makes the NULL opt-out natural.)
struct b2QueryFilter
{
    int categoryBits;   // the categories this query belongs to (normally one bit)
    int maskBits;       // the shape categories this query accepts
};

void b2DefaultQueryFilter( b2QueryFilter* filter )
{
    filter->categoryBits = 1;
    filter->maskBits = -1;      // all bits set
}

bool b2ShouldQueryCollide( b2Filter* shapeFilter, b2QueryFilter* queryFilter )
{
    return ( shapeFilter->categoryBits & queryFilter->maskBits ) != 0
        && ( shapeFilter->maskBits & queryFilter->categoryBits ) != 0;
}

// Typed dynamic array of shapes (lives in b2World; grown via b2GrowArray).
struct b2ShapeArray { b2Shape* data;  int count;  int capacity; };


// Axis-aligned bounding box of the shape under world transform xf.
void b2ComputeShapeAABB( b2Shape* shape, b2Transform* xf, b2AABB* result )
{
    if( shape->type == b2_circleShape )
        b2ComputeCircleAABB( &shape->circle, xf, result );
    else if( shape->type == b2_capsuleShape )
        b2ComputeCapsuleAABB( &shape->capsule, xf, result );
    else if( shape->type == b2_polygonShape )
        b2ComputePolygonAABB( &shape->polygon, xf, result );
    else if( shape->type == b2_segmentShape )
        b2ComputeSegmentAABB( &shape->segment, xf, result );
    else if( shape->type == b2_chainSegmentShape )
        b2ComputeSegmentAABB( &shape->chainSegment.segment, xf, result );
    else
    {
        result->lowerBound.x = 0.0;  result->lowerBound.y = 0.0;
        result->upperBound.x = 0.0;  result->upperBound.y = 0.0;
    }
}

// True if the world-space point lies inside the shape (segments have no inside).
// Transforms the point into the shape's local frame, then dispatches by type.
// Companion to the ray casts -- for point/mouse/touch picking.
bool b2ShapeTestPoint( b2Shape* shape, b2Transform* xf, b2Vec2* worldPoint )
{
    b2Vec2 local;  b2InvTransformPoint( xf, worldPoint, &local );
    if( shape->type == b2_circleShape )
        return b2PointInCircle( &shape->circle, &local );
    else if( shape->type == b2_capsuleShape )
        return b2PointInCapsule( &shape->capsule, &local );
    else if( shape->type == b2_polygonShape )
        return b2PointInPolygon( &shape->polygon, &local );
    return false;   // segments (and unknown types) have no interior
}

// Sweep a moving proxy (given in some outer frame) against ONE shape whose pose in
// that frame is `transform`. The proxy and its translation are pulled into the
// shape's local frame, then dispatched by type; the returned point/normal are in the
// shape's LOCAL frame and the fraction is directly comparable to the input's, because
// a rigid transform preserves the translation's length.
// (Port of shape.c b2ShapeCastShape. The proxy arrays are walked through pointers,
// the attested-green idiom for fixed array members at a variable index.)
void b2ShapeCastShape( b2ShapeCastInput* input, b2Shape* shape, b2Transform* transform,
                       b2CastOutput* output )
{
    output->normal = b2Vec2_zero;
    output->point = b2Vec2_zero;
    output->fraction = 0.0;
    output->iterations = 0;
    output->hit = false;

    if( input->proxy.count == 0 )
        return;

    b2ShapeCastInput localInput = *input;

    b2ShapeProxy* src = &input->proxy;
    b2ShapeProxy* dst = &localInput.proxy;
    int i;
    for( i = 0; i < src->count; ++i )
    {
        b2Vec2 p = src->points[i];
        b2InvTransformPoint( transform, &p, &dst->points[i] );
    }
    b2InvRotateVector( &transform->q, &input->translation, &localInput.translation );

    if( shape->type == b2_circleShape )
        b2ShapeCastCircle( &shape->circle, &localInput, output );
    else if( shape->type == b2_capsuleShape )
        b2ShapeCastCapsule( &shape->capsule, &localInput, output );
    else if( shape->type == b2_polygonShape )
        b2ShapeCastPolygon( &shape->polygon, &localInput, output );
    else if( shape->type == b2_segmentShape )
        b2ShapeCastSegment( &shape->segment, &localInput, output );
    else if( shape->type == b2_chainSegmentShape )
        b2ShapeCastSegment( &shape->chainSegment.segment, &localInput, output );
}

// Collide a capsule mover against ONE shape whose pose is `transform`. The mover is
// given in the same outer frame as `transform`; it is pulled into the shape's local
// frame, collided, and the resulting plane NORMAL is rotated back out.
//
// UPSTREAM QUIRK, ported faithfully: `result->point` is NOT transformed back -- it
// stays in the shape's local frame while the normal is in the outer frame. Upstream's
// samples only consume the plane, so this was never noticed. See b2PlaneResult.
//
// Segments and chain segments are collided TWO-SIDED here, losing the one-sidedness
// that chain COLLISION enforces (upstream does the same, and so does b2ShapeCastShape).
void b2CollideMover( b2Capsule* mover, b2Shape* shape, b2Transform* transform,
                     b2PlaneResult* result )
{
    result->plane.normal = b2Vec2_zero;
    result->plane.offset = 0.0;
    result->point = b2Vec2_zero;
    result->hit = false;

    b2Capsule localMover;
    b2InvTransformPoint( transform, &mover->center1, &localMover.center1 );
    b2InvTransformPoint( transform, &mover->center2, &localMover.center2 );
    localMover.radius = mover->radius;

    if( shape->type == b2_circleShape )
        b2CollideMoverAndCircle( &localMover, &shape->circle, result );
    else if( shape->type == b2_capsuleShape )
        b2CollideMoverAndCapsule( &localMover, &shape->capsule, result );
    else if( shape->type == b2_polygonShape )
        b2CollideMoverAndPolygon( &localMover, &shape->polygon, result );
    else if( shape->type == b2_segmentShape )
        b2CollideMoverAndSegment( &localMover, &shape->segment, result );
    else if( shape->type == b2_chainSegmentShape )
        b2CollideMoverAndSegment( &localMover, &shape->chainSegment.segment, result );
    else
        return;

    if( result->hit == false )
        return;

    b2Vec2 localNormal = result->plane.normal;
    b2RotateVector( &transform->q, &localNormal, &result->plane.normal );
}

// Build a GJK distance proxy (local-frame point cloud + radius) for the shape,
// dispatching by type (port of upstream b2MakeShapeDistanceProxy). Used by the
// sensor overlap pass. For capsule/segment the two endpoints are contiguous
// b2Vec2 members, so &center1 / &point1 is read as a 2-point array (as upstream).
void b2MakeShapeProxy( b2Shape* shape, b2ShapeProxy* proxy )
{
    if( shape->type == b2_capsuleShape )
        b2MakeProxy( &shape->capsule.center1, 2, shape->capsule.radius, proxy );
    else if( shape->type == b2_circleShape )
        b2MakeProxy( &shape->circle.center, 1, shape->circle.radius, proxy );
    else if( shape->type == b2_polygonShape )
        b2MakeProxy( shape->polygon.vertices, shape->polygon.count, shape->polygon.radius, proxy );
    else if( shape->type == b2_segmentShape )
        b2MakeProxy( &shape->segment.point1, 2, 0.0, proxy );
    else if( shape->type == b2_chainSegmentShape )
        b2MakeProxy( &shape->chainSegment.segment.point1, 2, 0.0, proxy );
    else
        proxy->count = 0;
}

// Geometric centroid of the shape in its local frame (upstream b2GetShapeCentroid).
// Used by b2World_Explode when the blast center sits exactly on the closest point.
void b2GetShapeCentroid( b2Shape* shape, b2Vec2* result )
{
    if( shape->type == b2_circleShape )
        *result = shape->circle.center;
    else if( shape->type == b2_capsuleShape )
        b2Lerp( &shape->capsule.center1, &shape->capsule.center2, 0.5, result );
    else if( shape->type == b2_polygonShape )
        *result = shape->polygon.centroid;
    else if( shape->type == b2_segmentShape )
        b2Lerp( &shape->segment.point1, &shape->segment.point2, 0.5, result );
    else if( shape->type == b2_chainSegmentShape )
        b2Lerp( &shape->chainSegment.segment.point1, &shape->chainSegment.segment.point2, 0.5, result );
    else
        *result = b2Vec2_zero;
}

// Width of the shape's silhouette projected onto `line` (upstream
// b2GetShapeProjectedPerimeter): the extent of the shape facing a direction, used to
// scale the explosion impulse by how much of the shape the blast can "see".
float b2GetShapeProjectedPerimeter( b2Shape* shape, b2Vec2* line )
{
    if( shape->type == b2_circleShape )
        return 2.0 * shape->circle.radius;

    if( shape->type == b2_capsuleShape )
    {
        b2Vec2 axis;  b2Sub( &shape->capsule.center2, &shape->capsule.center1, &axis );
        float projectedLength = b2AbsFloat( b2Dot( &axis, line ) );
        return projectedLength + 2.0 * shape->capsule.radius;
    }

    if( shape->type == b2_polygonShape )
    {
        b2Vec2 v0 = shape->polygon.vertices[0];       // whole-struct copy (attested-safe)
        float lower = b2Dot( &v0, line );
        float upper = lower;
        int i;
        for( i = 1; i < shape->polygon.count; ++i )
        {
            b2Vec2 vi = shape->polygon.vertices[i];
            float value = b2Dot( &vi, line );
            lower = b2MinFloat( lower, value );
            upper = b2MaxFloat( upper, value );
        }
        return ( upper - lower ) + 2.0 * shape->polygon.radius;
    }

    if( shape->type == b2_segmentShape )
    {
        float value1 = b2Dot( &shape->segment.point1, line );
        float value2 = b2Dot( &shape->segment.point2, line );
        return b2AbsFloat( value2 - value1 );
    }

    return 0.0;
}

// Mass, centroid, and rotational inertia of the shape at its density.
void b2ComputeShapeMass( b2Shape* shape, b2MassData* result )
{
    if( shape->type == b2_circleShape )
        b2ComputeCircleMass( &shape->circle, shape->density, result );
    else if( shape->type == b2_capsuleShape )
        b2ComputeCapsuleMass( &shape->capsule, shape->density, result );
    else if( shape->type == b2_polygonShape )
        b2ComputePolygonMass( &shape->polygon, shape->density, result );
    else
    {
        result->mass = 0.0;
        result->center.x = 0.0;  result->center.y = 0.0;
        result->rotationalInertia = 0.0;
    }
}

// Min/max extent of the shape relative to a given local center.
void b2ComputeShapeExtent( b2Shape* shape, b2Vec2* localCenter, b2ShapeExtent* extent )
{
    extent->minExtent = 0.0;
    extent->maxExtent = 0.0;

    if( shape->type == b2_capsuleShape )
    {
        float radius = shape->capsule.radius;
        extent->minExtent = radius;
        b2Vec2 c1;  b2Sub( &shape->capsule.center1, localCenter, &c1 );
        b2Vec2 c2;  b2Sub( &shape->capsule.center2, localCenter, &c2 );
        extent->maxExtent = sqrt( b2MaxFloat( b2LengthSquared( &c1 ), b2LengthSquared( &c2 ) ) ) + radius;
    }
    else if( shape->type == b2_circleShape )
    {
        float radius = shape->circle.radius;
        extent->minExtent = radius;
        b2Vec2 d;  b2Sub( &shape->circle.center, localCenter, &d );
        extent->maxExtent = b2Length( &d ) + radius;
    }
    else if( shape->type == b2_polygonShape )
    {
        b2Polygon* poly = &shape->polygon;
        float minExtent = B2_HUGE;
        float maxExtentSqr = 0.0;
        int count = poly->count;
        int i;
        for( i = 0; i < count; ++i )
        {
            b2Vec2 cv;  b2Sub( &poly->vertices[i], &poly->centroid, &cv );
            float planeOffset = b2Dot( &poly->normals[i], &cv );
            minExtent = b2MinFloat( minExtent, planeOffset );

            b2Vec2 dv;  b2Sub( &poly->vertices[i], localCenter, &dv );
            float distanceSqr = b2LengthSquared( &dv );
            maxExtentSqr = b2MaxFloat( maxExtentSqr, distanceSqr );
        }
        extent->minExtent = minExtent + poly->radius;
        extent->maxExtent = sqrt( maxExtentSqr ) + poly->radius;
    }
}


// *****************************************************************************
    #endif
// *****************************************************************************
