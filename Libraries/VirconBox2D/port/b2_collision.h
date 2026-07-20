/* *****************************************************************************
*  VirconBox2D : b2_collision.h        (port of Box2D v3 include/box2d/collision.h)
*  --------------------------------------------------------------------------- *
*  Collision data types. This header grows as collision modules are ported;    *
*  for now it carries the ray-cast input/output used by the AABB module.       *
*  These are plain data structs (no by-value-returning functions), so they     *
*  port almost verbatim -- only array members use the 'type[n] name' syntax.   *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_COLLISION_H
    #define B2_COLLISION_H

    #include "b2_math.h"
// *****************************************************************************


// maximum vertices in a convex polygon
#define B2_MAX_POLYGON_VERTICES 8


// Mass, centroid, and rotational inertia of a shape
struct b2MassData
{
    float mass;                 // mass, usually in kilograms
    b2Vec2 center;              // centroid relative to the shape origin
    float rotationalInertia;    // inertia about the shape center
};

// ---------------------------------------------------------

// A distance proxy: a point cloud with a radius (encapsulates any shape for GJK)
struct b2ShapeProxy
{
    b2Vec2[B2_MAX_POLYGON_VERTICES] points;   // the point cloud
    int count;                                // number of points (> 0)
    float radius;                             // external radius (may be zero)
};

// ---------------------------------------------------------

// A solid circle
struct b2Circle
{
    b2Vec2 center;
    float radius;
};

// ---------------------------------------------------------

// A solid capsule: two semicircles connected by a rectangle
struct b2Capsule
{
    b2Vec2 center1;   // local center of the first semicircle
    b2Vec2 center2;   // local center of the second semicircle
    float radius;     // radius of the semicircles
};

// ---------------------------------------------------------

// A solid convex polygon (interior is to the left of each edge).
// Build with b2MakeBox/b2MakePolygon -- do not fill manually.
struct b2Polygon
{
    b2Vec2[B2_MAX_POLYGON_VERTICES] vertices;   // the vertices
    b2Vec2[B2_MAX_POLYGON_VERTICES] normals;    // outward edge normals
    b2Vec2 centroid;                            // centroid
    float radius;                               // external radius (rounded polygons)
    int count;                                  // number of vertices
};

// ---------------------------------------------------------

// A line segment with two-sided collision
struct b2Segment
{
    b2Vec2 point1;
    b2Vec2 point2;
};

// ---------------------------------------------------------

// A line segment with ONE-SIDED collision plus ghost vertices from the adjoining
// chain segments. Ordered ghost1 -> point1 -> point2 -> ghost2. Only collides from
// its right side (normal = RightPerp(point2-point1)); the ghosts let the narrow
// phase cull contacts that belong to a neighbour segment (no ghost collisions at
// junctions). chainId links back to the owning b2Chain (B2_NULL_INDEX if standalone).
struct b2ChainSegment
{
    b2Vec2 ghost1;
    b2Segment segment;
    b2Vec2 ghost2;
    int chainId;
};

// ---------------------------------------------------------

// The result of a convex hull computation
struct b2Hull
{
    b2Vec2[B2_MAX_POLYGON_VERTICES] points;   // the final hull points
    int count;                                // number of points
};

// ---------------------------------------------------------

// Result of a segment-to-segment distance query
struct b2SegmentDistanceResult
{
    b2Vec2 closest1;        // closest point on the first segment
    b2Vec2 closest2;        // closest point on the second segment
    float fraction1;        // barycentric coordinate on the first segment
    float fraction2;        // barycentric coordinate on the second segment
    float distanceSquared;  // squared distance between the closest points
};

// ---------------------------------------------------------

// GJK warm-start cache. (upstream uint16/uint8 fields widened to int.)
struct b2SimplexCache
{
    int count;          // number of stored simplex points
    int[3] indexA;      // cached simplex indices on shape A
    int[3] indexB;      // cached simplex indices on shape B
};

// ---------------------------------------------------------

// Input for b2ShapeDistance
struct b2DistanceInput
{
    b2ShapeProxy proxyA;     // proxy for shape A
    b2ShapeProxy proxyB;     // proxy for shape B
    b2Transform transform;   // pose of B in A's frame
    bool useRadii;           // consider the proxy radii?
};

// ---------------------------------------------------------

// Output for b2ShapeDistance
struct b2DistanceOutput
{
    b2Vec2 pointA;       // closest point on shape A, in A's frame
    b2Vec2 pointB;       // closest point on shape B, in A's frame
    b2Vec2 normal;       // A->B normal in A's frame (invalid if distance is zero)
    float distance;      // final distance, zero if overlapped
    int iterations;      // number of GJK iterations used
    int simplexCount;    // number of debug simplexes stored (0 here)
};

// ---------------------------------------------------------

// A motion sweep of a shape's center of mass over one time step, used by the
// continuous / time-of-impact code. Interpolate to a transform with b2GetSweepTransform.
struct b2Sweep
{
    b2Vec2 localCenter;   // local center of mass
    b2Vec2 c1;            // starting center-of-mass world position
    b2Vec2 c2;            // ending center-of-mass world position
    b2Rot  q1;            // starting world rotation
    b2Rot  q2;            // ending world rotation
};

// Time-of-impact result state (upstream b2TOIState enum -> #defines, no enum needed)
#define b2_toiStateUnknown     0
#define b2_toiStateFailed      1
#define b2_toiStateOverlapped  2
#define b2_toiStateHit         3
#define b2_toiStateSeparated   4

// Input for b2TimeOfImpact: two proxies each moving along a sweep over [0, maxFraction].
struct b2TOIInput
{
    b2ShapeProxy proxyA;
    b2ShapeProxy proxyB;
    b2Sweep sweepA;
    b2Sweep sweepB;
    float maxFraction;
};

// Output from b2TimeOfImpact.
struct b2TOIOutput
{
    int    state;        // b2_toiState* code
    b2Vec2 point;        // hit point (world)
    b2Vec2 normal;       // hit normal (world)
    float  fraction;     // sweep time of collision in [0, maxFraction]
};

// ---------------------------------------------------------

// A GJK simplex vertex
struct b2SimplexVertex
{
    b2Vec2 wA;       // support point in proxyA
    b2Vec2 wB;       // support point in proxyB
    b2Vec2 w;        // wB - wA
    float a;         // barycentric coordinate for the closest point
    int indexA;      // wA index
    int indexB;      // wB index
};

// ---------------------------------------------------------

// A GJK simplex (1 to 3 vertices)
struct b2Simplex
{
    b2SimplexVertex v1, v2, v3;
    int count;
};


// ---------------------------------------------------------
// Contact manifolds (frame A). Upstream returns b2LocalManifold by value;
// here every collide function fills a caller-supplied b2LocalManifold* (last arg).
// Only the local-frame manifold types are needed for the manifold module; the
// solver-side b2Manifold/b2ManifoldPoint + B2_MAKE_ID packing are deferred until
// a later slice needs them. (uint16_t id widened to int.)

// Contact manifold point in local coordinates (frame A)
struct b2LocalManifoldPoint
{
    b2Vec2 point;       // contact point in frame A
    float separation;   // separation, negative if penetrating
    int id;             // uniquely identifies a contact point between two shapes
};

// ---------------------------------------------------------

// Contact manifold in local coordinates (frame A)
struct b2LocalManifold
{
    b2Vec2 normal;                      // unit normal in frame A, points A->B
    b2LocalManifoldPoint[2] points;     // up to two contact points in 2D
    int pointCount;                     // number of contact points: 0, 1, or 2
};

// ---------------------------------------------------------
// Solver-side manifold (world anchors relative to each body's center of mass).
// b2UpdateContact marshals the frame-A b2LocalManifold above into this form.
// (uint16_t id widened to int; the warm-start impulse fields are carried for the
// future solver but are zeroed for now -- see b2UpdateContact.)

// A solver manifold point: world-space anchors + cached impulses for warm starting.
struct b2ManifoldPoint
{
    b2Vec2 anchorA;          // contact point relative to bodyA center of mass (world)
    b2Vec2 anchorB;          // contact point relative to bodyB center of mass (world)
    float separation;        // separation, negative if penetrating
    float baseSeparation;    // cached separation used for contact recycling
    float normalImpulse;     // impulse along the manifold normal
    float tangentImpulse;    // friction impulse
    float totalNormalImpulse;// accumulated normal impulse across sub-steps/restitution
    float normalVelocity;    // relative normal velocity pre-solve (for hit events)
    int id;                  // uniquely identifies a contact point between two shapes
    bool persisted;          // did this point exist the previous step?
};

// ---------------------------------------------------------

// A solver contact manifold (up to two points in 2D)
struct b2Manifold
{
    b2Vec2 normal;                  // unit normal in world space, points A->B
    float rollingImpulse;           // angular impulse for rolling resistance
    b2ManifoldPoint[2] points;      // up to two contact points
    int pointCount;                 // number of contact points: 0, 1, or 2
};

// ---------------------------------------------------------

// Low-level ray-cast input
struct b2RayCastInput
{
    b2Vec2 origin;        // start point of the ray
    b2Vec2 translation;   // translation of the ray
    float maxFraction;    // max fraction of the translation to consider (usually 1)
};

// ---------------------------------------------------------

// Low-level ray/shape cast output
struct b2CastOutput
{
    b2Vec2 normal;        // surface normal at the hit point
    b2Vec2 point;         // surface hit point
    float fraction;       // fraction of the input translation at collision
    int iterations;       // number of iterations used
    bool hit;             // did the cast hit?
};

// ---------------------------------------------------------

// Input for casting one generic shape (proxy) against a specific shape.
struct b2ShapeCastInput
{
    b2ShapeProxy proxy;   // the moving shape, as a point cloud + radius
    b2Vec2 translation;   // the translation of the shape cast
    float maxFraction;    // max fraction of the translation to consider (usually 1)
    bool canEncroach;     // let an initially-touching cast advance slightly (needs radius > 0)
};

// ---------------------------------------------------------

// Input for casting shape B (moving) against shape A (fixed). The whole query runs
// in A's frame, so the hit point and normal come back in A's frame.
struct b2ShapeCastPairInput
{
    b2ShapeProxy proxyA;   // the fixed shape
    b2ShapeProxy proxyB;   // the moving shape
    b2Transform transform; // pose of B in A's frame
    b2Vec2 translationB;   // translation of B, in A's frame
    float maxFraction;     // max fraction of the translation to consider (usually 1)
    bool canEncroach;      // allow shapes with a radius to move slightly closer if touching
};

// ---------------------------------------------------------

// Input for sweeping an AABB through the dynamic tree (the broad phase of a shape
// cast: the box conservatively bounds the moving shape, radius already folded in).
struct b2BoxCastInput
{
    b2AABB box;           // the AABB to cast, in the tree's frame
    b2Vec2 translation;   // the sweep translation
    float maxFraction;    // max fraction of the translation to consider (usually 1)
};


// ---------------------------------------------------------
//   Mover (character controller) types
// ---------------------------------------------------------

// One collision plane found between the mover capsule and a convex shape, as
// returned through b2World_CollideMover's callback.
//
// UPSTREAM QUIRK, ported faithfully: `plane.normal` is rotated back into WORLD
// space by b2CollideMover, but `point` is left in the SHAPE'S LOCAL frame. The
// samples only ever consume the plane, so upstream never noticed. Do not "fix" it
// here -- the port's whole validation is cross-checking against upstream.
struct b2PlaneResult
{
    b2Plane plane;   // collision plane between the mover and the shape
    b2Vec2 point;    // collision point on the shape (SHAPE-LOCAL -- see above)
    bool hit;        // did the collision register? if not, ignore this plane
};

// A collision plane to feed b2SolvePlanes. Normally the user assembles these from
// the b2PlaneResults handed to them by b2World_CollideMover.
struct b2CollisionPlane
{
    b2Plane plane;       // the collision plane
    float pushLimit;     // FLT_MAX = rigid; lower values make the plane soft (meters)
    float push;          // the push on the mover, computed by b2SolvePlanes (meters)
    bool clipVelocity;   // should b2ClipVector clip against this plane? false for soft
};

// Result of b2SolvePlanes.
struct b2PlaneSolverResult
{
    b2Vec2 translation;   // the resolved translation of the mover
    int iterationCount;   // iterations the plane solver used (diagnostics)
};


// *****************************************************************************
    #endif
// *****************************************************************************
