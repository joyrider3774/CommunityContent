# Events

Events tell you what happened during a `b2World_Step`: shapes that started or stopped touching,
hard impacts, and sensor overlaps. **All events are polled, not called back.** After each step,
the world holds arrays of what occurred; you read them before the next step (which clears and
rebuilds them).

[← Queries](queries.md) · [Reference index](index.md) · [Mover →](mover.md)

## The polling pattern

Every event kind has a matching **count** and **array** getter. Read them right after
`b2World_Step`:

```c
b2World_Step( &world, 1.0 / 60.0, 4 );

int n = b2World_GetBeginTouchEventCount( &world );
b2TouchEvent* events = b2World_GetBeginTouchEvents( &world );
int i;
for( i = 0; i < n; ++i )
{
    // events[i].shapeIdA, events[i].shapeIdB   (raw shape ids)
}
```

Shape ids in events are **raw ints**. To reach your game object, mint a handle and walk to the
body's user data:

```c
b2ShapeId sid;   b2MakeShapeId( &world, events[i].shapeIdA, &sid );
b2BodyId  bid;   b2Shape_GetBody( &world, &sid, &bid );
void* entity =   b2Body_GetUserData( &world, &bid );
```

## Touch events (begin / end)

Fired when two solid shapes start or stop touching. Both shapes must have contact events enabled
(they are on by default; toggle with `b2Shape_EnableContactEvents`).

```c
struct b2TouchEvent { int shapeIdA; int shapeIdB; };

int          b2World_GetBeginTouchEventCount( b2World* world );
b2TouchEvent* b2World_GetBeginTouchEvents   ( b2World* world );
int          b2World_GetEndTouchEventCount  ( b2World* world );
b2TouchEvent* b2World_GetEndTouchEvents     ( b2World* world );
```

Use these for "landed on the ground", "left the platform", "bumped a wall" logic. A begin event
fires the step the shapes first touch; an end event fires the step they separate.

> Natural separation (bodies moving apart) fires an end-touch event. A touching contact removed
> by *destroying* a body/shape does **not** currently emit an end-touch event — handle cleanup in
> your own destroy path.

## Hit events

Fired for a hard impact — a touching contact whose closing speed exceeds the world's hit-event
threshold. **Opt-in per shape** (`b2ShapeDef.enableHitEvents = true` or
`b2Shape_EnableHitEvents`).

```c
struct b2ContactHitEvent {
    b2Vec2 point;         // approximate world contact point
    b2Vec2 normal;        // world normal, A -> B
    int    shapeIdA;
    int    shapeIdB;
    float  approachSpeed; // closing speed before the solve (>= threshold)
};

int               b2World_GetContactHitEventCount( b2World* world );
b2ContactHitEvent* b2World_GetContactHitEvents    ( b2World* world );
```

Use `approachSpeed` to scale a sound, a particle burst, or damage. Tune the trigger with
`b2World_SetHitEventThreshold`.

```c
int n = b2World_GetContactHitEventCount( &world );
b2ContactHitEvent* hits = b2World_GetContactHitEvents( &world );
for( i = 0; i < n; ++i )
    PlayImpactSound( hits[i].point, hits[i].approachSpeed );
```

## Sensor events

A **sensor** shape (`b2ShapeDef.isSensor = true`) detects overlap but produces no collision
response — a trigger volume. Sensor events fire when another shape (a "visitor") begins or ends
overlapping a sensor.

```c
struct b2SensorTouchEvent { int sensorShapeId; int visitorShapeId; };

int                b2World_GetSensorBeginEventCount( b2World* world );
b2SensorTouchEvent* b2World_GetSensorBeginEvents    ( b2World* world );
int                b2World_GetSensorEndEventCount  ( b2World* world );
b2SensorTouchEvent* b2World_GetSensorEndEvents      ( b2World* world );
```

Use these for pickups, checkpoints, damage zones, "player entered room". Only shapes with
`enableSensorEvents` (default true) participate. You can also poll a sensor's current overlap set
directly with `b2Shape_GetSensorData` (see [Shapes](shapes.md#contact-and-sensor-enumeration)).

```c
b2ShapeDef def;  b2DefaultShapeDef( &def );
def.isSensor = true;
b2ShapeId trigger;
b2CreatePolygonShape( &world, &zoneBody, &def, &zoneBox, &trigger );
// ... after each step, read b2World_GetSensorBeginEvents / EndEvents
```

## Reading contact detail

Beyond the touch/hit events, you can inspect the full contact manifold — the actual contact
points, normal, separation, and impulses.

```c
struct b2ManifoldPoint {
    b2Vec2 anchorA, anchorB;   // contact point relative to each body's center of mass (world)
    float  separation;         // negative if penetrating
    float  normalImpulse;      // impulse applied along the normal
    float  tangentImpulse;     // friction impulse
    float  normalVelocity;     // relative normal velocity before the solve
    int    id;                 // stable id for this point across steps
    bool   persisted;          // did this point exist last step?
    // (plus internal fields)
};
struct b2Manifold {
    b2Vec2 normal;             // world normal, A -> B
    b2ManifoldPoint points[2];
    int    pointCount;         // 0, 1, or 2
};
struct b2ContactData {
    b2ContactId contactId;
    int shapeIdA;
    int shapeIdB;
    b2Manifold  manifold;
};
```

Enumerate a body's or shape's current touching contacts:

```c
int b2Body_GetContactData ( b2World* world, b2BodyId*  bodyId,  b2ContactData* data, int capacity );
int b2Shape_GetContactData( b2World* world, b2ShapeId* shapeId, b2ContactData* data, int capacity );
```

Each fills up to `capacity` `b2ContactData` entries and returns how many were written. Pair them
with `b2Body_GetContactCapacity` / `b2Shape_GetContactCapacity` to size your array. Use this to
read contact forces (`normalImpulse`) for a physics-reactive material, or exact contact points
for effects.

### Contact handles

```c
void b2MakeContactId ( b2World* world, int contactId, b2ContactId* result );
bool b2Contact_IsValid( b2World* world, b2ContactId* id );
bool b2Contact_GetData( b2World* world, b2ContactId* id, b2ContactData* result );
```

`b2ContactData` carries a `b2ContactId` you can hold to re-query the same contact on a later step.
**Contacts are short-lived** — the broad phase destroys a contact the instant its shapes separate
— so a held id goes stale often. Always check `b2Contact_IsValid`, or the `false` return of
`b2Contact_GetData`, before trusting it.

```c
b2ContactData cd;
if( b2Contact_GetData( &world, &savedId, &cd ) )
{
    // still touching; cd.manifold is current
}
```

---

Continue to [Mover](mover.md).
