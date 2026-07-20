# Shapes

A **shape** is a piece of collision geometry attached to a [body](bodies.md). A body can carry
several shapes. Shapes give the body its silhouette, its mass (via density), and its surface
properties (friction, restitution, filtering). Static bodies use shapes for level geometry;
dynamic bodies use them for everything they collide with.

[← Bodies](bodies.md) · [Reference index](index.md) · [Joints →](joints.md)

## Shape types

```c
#define b2_circleShape        0
#define b2_capsuleShape       1
#define b2_segmentShape       2
#define b2_polygonShape       3
#define b2_chainSegmentShape  4
```

There are five geometry primitives. You build the primitive struct, then attach it to a body
with the matching `b2Create*Shape` call.

## The shape definition

Every attach call takes a `b2ShapeDef` describing the surface. Start from the default and
override:

```c
void b2DefaultShapeDef( b2ShapeDef* def );
```

### `b2ShapeDef` fields

| Field | Default | Meaning |
|-------|---------|---------|
| `density` | `1.0` | Mass per unit area (kg/m²); drives the body's computed mass. Use `0` for a massless shape. |
| `friction` | `0.6` | Surface friction coefficient. Mixed between the two shapes in contact. |
| `restitution` | `0.0` | Bounciness, 0–1. Mixed as the max of the two shapes. |
| `filter` | cat 1 / mask all | Collision filter (see [Filtering](#collision-filtering)). |
| `isSensor` | `false` | If true, detects overlap but produces no collision response. |
| `enableContactEvents` | `true` | Emit begin/end-touch events (both shapes must agree). |
| `enableHitEvents` | `false` | Emit hit events on hard impacts. |
| `enableSensorEvents` | `true` | Participate in sensor overlap events. |
| `userData` | `NULL` | Opaque game pointer on the shape. |

## Building the geometry

### Circle

Construct directly — a local center and a radius:

```c
b2Circle circle;
circle.center.x = 0.0;  circle.center.y = 0.0;   // in the body's local frame
circle.radius = 0.5;
```

### Capsule

A "stadium" — two circle ends joined by a rectangle. Give the two local endpoints and a radius:

```c
b2Capsule capsule;
capsule.center1.x = -0.5;  capsule.center1.y = 0.0;
capsule.center2.x =  0.5;  capsule.center2.y = 0.0;
capsule.radius = 0.25;
```

### Segment

A one-sided line between two local points — used for thin static walls and floors:

```c
b2Segment segment;
segment.point1.x = -5.0;  segment.point1.y = 0.0;
segment.point2.x =  5.0;  segment.point2.y = 0.0;
```

### Polygon (boxes and convex shapes)

Boxes have dedicated makers (all take **half-extents**):

```c
void b2MakeBox( float halfWidth, float halfHeight, b2Polygon* shape );
void b2MakeSquare( float halfWidth, b2Polygon* shape );
void b2MakeRoundedBox( float halfWidth, float halfHeight, float radius, b2Polygon* shape );
void b2MakeOffsetBox( float halfWidth, float halfHeight, b2Vec2* center, b2Rot* rotation, b2Polygon* shape );
```

- `b2MakeBox` — an axis-aligned box centered on the body origin; a 2×2 m box is
  `b2MakeBox( 1.0, 1.0, &poly )`.
- `b2MakeSquare` — a box with equal half-extents.
- `b2MakeRoundedBox` — a box with rounded corners of the given radius.
- `b2MakeOffsetBox` — a box placed at a local `center` and `rotation` (for a shape that isn't
  centered on the body origin).

Arbitrary convex polygons are built from a **hull**:

```c
void b2ComputeHull( b2Vec2* points, int count, b2Hull* hull );
bool b2ValidateHull( b2Hull* hull );

void b2MakePolygon( b2Hull* hull, float radius, b2Polygon* shape );
void b2MakeOffsetPolygon( b2Hull* hull, b2Vec2* position, b2Rot* rotation, b2Polygon* shape );
void b2MakeOffsetRoundedPolygon( b2Hull* hull, b2Vec2* position, b2Rot* rotation, float radius, b2Polygon* shape );
```

`b2ComputeHull` turns a point cloud into a convex hull (up to `B2_MAX_POLYGON_VERTICES` points);
`b2MakePolygon` turns that hull into a polygon with an optional rounding `radius` (use `0.0` for
sharp corners). The `Offset` variants place the polygon at a local position/rotation.

```c
b2Vec2 pts[3];
pts[0].x = -0.5;  pts[0].y = -0.5;
pts[1].x =  0.5;  pts[1].y = -0.5;
pts[2].x =  0.0;  pts[2].y =  0.5;
b2Hull hull;      b2ComputeHull( pts, 3, &hull );
b2Polygon tri;    b2MakePolygon( &hull, 0.0, &tri );
```

## Attaching a shape to a body

```c
void b2CreateCircleShape ( b2World* world, b2BodyId* bodyId, b2ShapeDef* def, b2Circle*  circle,  b2ShapeId* result );
void b2CreateCapsuleShape( b2World* world, b2BodyId* bodyId, b2ShapeDef* def, b2Capsule* capsule, b2ShapeId* result );
void b2CreateSegmentShape( b2World* world, b2BodyId* bodyId, b2ShapeDef* def, b2Segment* segment, b2ShapeId* result );
void b2CreatePolygonShape( b2World* world, b2BodyId* bodyId, b2ShapeDef* def, b2Polygon* polygon, b2ShapeId* result );
```

Each attaches the geometry to `bodyId`, applies the surface properties from `def`, updates the
body's mass, inserts a broad-phase proxy, and writes the new shape handle into `result`.

```c
b2ShapeDef def;   b2DefaultShapeDef( &def );
def.density = 1.0;
def.friction = 0.3;

b2Polygon box;    b2MakeBox( 0.5, 0.5, &box );
b2ShapeId shape;
b2CreatePolygonShape( &world, &body, &def, &box, &shape );
```

### Chains

A **chain** is a run of connected segments for level terrain — smooth to slide along, with no
"ghost collisions" at the joints between segments.

```c
void b2DefaultChainDef( b2ChainDef* def );
void b2CreateChain( b2World* world, b2BodyId* bodyId, b2ChainDef* def );
```

Fill `b2ChainDef` with an ordered array of points (`points`, `count` ≥ 4) and set `isLoop` to
connect the last point back to the first. Chains attach to static bodies for world geometry.

```c
b2Vec2 pts[5];   /* ...fill terrain outline... */
b2ChainDef cd;   b2DefaultChainDef( &cd );
cd.points = pts;
cd.count = 5;
cd.isLoop = false;
b2CreateChain( &world, &ground, &cd );
```

## Destroying a shape

```c
void b2DestroyShape( b2World* world, b2ShapeId* shapeId, bool updateBodyMass );
```

Removes one shape from its body (destroying its contacts and proxy). Pass `true` for
`updateBodyMass` to recompute the body's mass afterward. Destroying the whole body
(`b2DestroyBody`) removes all its shapes automatically — you only need this to remove one shape
from a multi-shape body.

## Surface properties

```c
void  b2Shape_SetDensity( b2World* world, b2ShapeId* shapeId, float density, bool updateBodyMass );
float b2Shape_GetDensity( b2World* world, b2ShapeId* shapeId );
void  b2Shape_SetFriction( b2World* world, b2ShapeId* shapeId, float friction );
float b2Shape_GetFriction( b2World* world, b2ShapeId* shapeId );
void  b2Shape_SetRestitution( b2World* world, b2ShapeId* shapeId, float restitution );
float b2Shape_GetRestitution( b2World* world, b2ShapeId* shapeId );
```

Read or change the surface after creation. `b2Shape_SetDensity` takes an `updateBodyMass` flag
because changing density changes the body's mass — pass `true` to apply it immediately, or
`false` and call `b2Body_ApplyMassFromShapes` later.

## Collision filtering

```c
struct b2Filter { int categoryBits; int maskBits; int groupIndex; };

void b2Shape_SetFilter( b2World* world, b2ShapeId* shapeId, b2Filter* filter );
void b2Shape_GetFilter( b2World* world, b2ShapeId* shapeId, b2Filter* result );
```

Two shapes collide only if each one's `categoryBits` is present in the other's `maskBits`.
`categoryBits` says "what I am", `maskBits` says "what I collide with". `groupIndex` overrides:
shapes in the same positive group always collide, in the same negative group never collide.

```c
// player is category 0x0002, collides with everything except category 0x0008 (its own bullets)
b2Filter f;
f.categoryBits = 0x0002;
f.maskBits = ~0x0008;      // -1 with bit 3 cleared
f.groupIndex = 0;
b2Shape_SetFilter( &world, &playerShape, &f );
```

Changing a filter destroys the shape's existing contacts and re-evaluates them next step.

## Reading geometry back

```c
int  b2Shape_GetType( b2World* world, b2ShapeId* shapeId );          // b2_circleShape, ...
void b2Shape_GetCircle ( b2World* world, b2ShapeId* shapeId, b2Circle*  result );
void b2Shape_GetCapsule( b2World* world, b2ShapeId* shapeId, b2Capsule* result );
void b2Shape_GetSegment( b2World* world, b2ShapeId* shapeId, b2Segment* result );
void b2Shape_GetPolygon( b2World* world, b2ShapeId* shapeId, b2Polygon* result );
void b2Shape_GetChainSegment( b2World* world, b2ShapeId* shapeId, b2ChainSegment* result );
```

Check the type first, then read the matching primitive (all in the body's local frame).

```c
void b2Shape_SetCircle ( b2World* world, b2ShapeId* shapeId, b2Circle*  circle );
void b2Shape_SetCapsule( b2World* world, b2ShapeId* shapeId, b2Capsule* capsule );
void b2Shape_SetSegment( b2World* world, b2ShapeId* shapeId, b2Segment* segment );
void b2Shape_SetPolygon( b2World* world, b2ShapeId* shapeId, b2Polygon* polygon );
void b2Shape_SetChainSegment( b2World* world, b2ShapeId* shapeId, b2ChainSegment* chainSegment );
```

Swap a shape's geometry in place. This recomputes its AABB, proxy, and mass. Setting a different
*type* than the shape currently holds is not supported — the setter matches the existing type.

## Identity and world placement

```c
void b2Shape_GetBody( b2World* world, b2ShapeId* shapeId, b2BodyId* result );
void b2Shape_GetAABB( b2World* world, b2ShapeId* shapeId, b2AABB* result );
```

`b2Shape_GetBody` returns the owning body (the usual step from a collision event's shape id to
your game object). `b2Shape_GetAABB` returns the shape's current world-space bounding box.

> **Note:** the returned AABB is the shape's cached fat box (padded by a speculative margin), so
> it is slightly larger than the tight geometry.

```c
bool b2Shape_TestPoint( b2World* world, b2ShapeId* shapeId, b2Vec2* point );
void b2Shape_GetClosestPoint( b2World* world, b2ShapeId* shapeId, b2Vec2* target, b2Vec2* result );
```

- `b2Shape_TestPoint` — is a world point inside this shape? (mouse/cursor picking).
- `b2Shape_GetClosestPoint` — the point on the shape's surface nearest a world `target`. If the
  target is *inside* the shape the result is degenerate, so use it for outside queries (nearest
  approach, aim assist).

```c
void b2Shape_RayCast( b2World* world, b2ShapeId* shapeId, b2RayCastInput* input, b2CastOutput* result );
```

Cast a ray against this single shape (see [Queries](queries.md) for `b2RayCastInput` /
`b2CastOutput` and the world-wide casts).

```c
void b2Shape_ComputeMassData( b2World* world, b2ShapeId* shapeId, b2MassData* result );
```

The shape's mass, centroid, and inertia at its density — without touching the body.

## Event opt-ins

```c
void b2Shape_EnableContactEvents( b2World* world, b2ShapeId* shapeId, bool flag );
bool b2Shape_AreContactEventsEnabled( b2World* world, b2ShapeId* shapeId );
void b2Shape_EnableHitEvents( b2World* world, b2ShapeId* shapeId, bool flag );
bool b2Shape_AreHitEventsEnabled( b2World* world, b2ShapeId* shapeId );
void b2Shape_EnableSensorEvents( b2World* world, b2ShapeId* shapeId, bool flag );
bool b2Shape_AreSensorEventsEnabled( b2World* world, b2ShapeId* shapeId );
bool b2Shape_IsSensor( b2World* world, b2ShapeId* shapeId );
```

Toggle which [events](events.md) a shape produces. Contact events are on by default (and both
shapes in a pair must have them enabled); hit events are off by default. See [Events](events.md)
for what each one reports. `isSensor` is fixed at creation and cannot be toggled at runtime.

## Contact and sensor enumeration

```c
int b2Shape_GetContactCapacity( b2World* world, b2ShapeId* shapeId );
int b2Shape_GetContactData( b2World* world, b2ShapeId* shapeId, b2ContactData* data, int capacity );
int b2Shape_GetSensorCapacity( b2World* world, b2ShapeId* shapeId );
int b2Shape_GetSensorData( b2World* world, b2ShapeId* shapeId, int* visitorIds, int capacity );
```

Poll a shape's current contacts or (for a sensor) the shapes overlapping it. The `Capacity`
call sizes your array; the `Data` call fills up to `capacity` entries and returns how many were
written. `b2Shape_GetSensorData` writes **raw int** visitor shape ids; resolve with
`b2MakeShapeId`. See [Events](events.md) for `b2ContactData`.

## Validity and user data

```c
bool  b2Shape_IsValid( b2World* world, b2ShapeId* id );
void  b2Shape_SetUserData( b2World* world, b2ShapeId* shapeId, void* userData );
void* b2Shape_GetUserData( b2World* world, b2ShapeId* shapeId );
```

`b2Shape_IsValid` returns false once the shape is destroyed. `userData` is how you tag a shape
(distinct from the body's user data) — useful when one body has several shapes with different
meanings (a hurtbox vs a hitbox).

---

Continue to [Joints](joints.md).
