# Bodies

A **body** is a rigid object with a position, a rotation, and a velocity. It carries no shape by
itself — you attach one or more [shapes](shapes.md) to give it collision geometry and mass.

[← World](world.md) · [Reference index](index.md) · [Shapes →](shapes.md)

## Body types

```c
#define b2_staticBody     0   // never moves; infinite mass; collides with dynamic only
#define b2_kinematicBody  1   // moves by velocity you set; not affected by forces or gravity
#define b2_dynamicBody    2   // fully simulated: gravity, forces, collision response
```

- **Static** — floors, walls, level geometry. Zero velocity, infinite mass.
- **Kinematic** — moving platforms, doors. You drive it with `b2Body_SetLinearVelocity` (or
  `b2Body_SetTargetTransform`); it pushes dynamic bodies but nothing pushes it.
- **Dynamic** — everything the physics actually simulates.

## Creating and destroying

```c
void b2DefaultBodyDef( b2BodyDef* def );
void b2CreateBody( b2World* world, b2BodyDef* def, b2BodyId* result );
void b2DestroyBody( b2World* world, b2BodyId* bodyId );
```

Always start from `b2DefaultBodyDef` so new fields get sane defaults, then override what you
need. `b2CreateBody` writes the new handle into `result`. `b2DestroyBody` also destroys every
shape, contact, and joint attached to the body — you do not clean those up yourself.

```c
b2BodyDef def;
b2DefaultBodyDef( &def );
def.type = b2_dynamicBody;
def.position.x = 0.0;
def.position.y = 10.0;

b2BodyId body;
b2CreateBody( &world, &def, &body );
```

### `b2BodyDef` fields

| Field | Meaning |
|-------|---------|
| `type` | `b2_staticBody` / `b2_kinematicBody` / `b2_dynamicBody` (default static). |
| `position` | Initial world position (`b2Vec2`). |
| `rotation` | Initial rotation (`b2Rot`; default `b2Rot_identity`). |
| `linearVelocity`, `angularVelocity` | Initial velocity. |
| `linearDamping`, `angularDamping` | Velocity decay per second (0 = none). |
| `gravityScale` | Per-body gravity multiplier (default 1; use 0 for floaty objects). |
| `sleepThreshold` | Speed below which the body may sleep. |
| `lockLinearX`, `lockLinearY`, `lockAngularZ` | Freeze motion on an axis (e.g. a 2D platformer that never rotates). |
| `enableSleep`, `isAwake`, `isBullet`, `isEnabled` | Per-body flags. |
| `userData` | Opaque game pointer (see below). |

## Pose: position and rotation

```c
void b2Body_GetPosition( b2World* world, b2BodyId* bodyId, b2Vec2* result );
void b2Body_GetRotation( b2World* world, b2BodyId* bodyId, b2Rot* result );
void b2Body_GetTransform( b2World* world, b2BodyId* bodyId, b2Transform* result );
```

These read the body's current origin and orientation — call them after `b2World_Step` to draw
the body. `b2Body_GetTransform` gets both at once.

```c
void b2Body_SetTransform( b2World* world, b2BodyId* bodyId, b2Vec2* position, b2Rot* rotation );
```

Teleports the body to a new pose. This is a hard set — it does not produce a collision response
along the way, and it wakes the body. Use it for spawning and respawning, **not** for normal
movement (drive dynamic bodies with forces/velocity, kinematic bodies with velocity).

```c
void b2Body_SetTargetTransform( b2World* world, b2BodyId* bodyId, b2Transform* target, float timeStep );
```

For **kinematic** bodies: sets the velocity needed to reach `target` in `timeStep` seconds, so
the body sweeps there and interacts with dynamic bodies on the way (a moving platform). Pass the
same `dt` you step with.

## Velocity

```c
void  b2Body_GetLinearVelocity( b2World* world, b2BodyId* bodyId, b2Vec2* result );
void  b2Body_SetLinearVelocity( b2World* world, b2BodyId* bodyId, b2Vec2* linearVelocity );
float b2Body_GetAngularVelocity( b2World* world, b2BodyId* bodyId );
void  b2Body_SetAngularVelocity( b2World* world, b2BodyId* bodyId, float angularVelocity );
```

Linear velocity is m/s; angular velocity is radians/s (positive = counter-clockwise).

## Forces and impulses

Apply over time (**forces**, cleared each step) or instantaneously (**impulses**). The `wake`
argument wakes a sleeping body so the effect is felt.

```c
void b2Body_ApplyForce( b2World* world, b2BodyId* bodyId, b2Vec2* force, b2Vec2* point, bool wake );
void b2Body_ApplyForceToCenter( b2World* world, b2BodyId* bodyId, b2Vec2* force, bool wake );
void b2Body_ApplyTorque( b2World* world, b2BodyId* bodyId, float torque, bool wake );

void b2Body_ApplyLinearImpulse( b2World* world, b2BodyId* bodyId, b2Vec2* impulse, b2Vec2* point, bool wake );
void b2Body_ApplyLinearImpulseToCenter( b2World* world, b2BodyId* bodyId, b2Vec2* impulse, bool wake );
void b2Body_ApplyAngularImpulse( b2World* world, b2BodyId* bodyId, float impulse, bool wake );

void b2Body_ClearForces( b2World* world, b2BodyId* bodyId );
```

- **Force** (newtons) accumulates until the next `b2World_Step`, then clears — call it every step
  while a thruster is firing.
- **Impulse** (newton-seconds) is a one-shot change in momentum — call it once for a jump or a hit.
- The `...ToCenter` variants apply at the center of mass (no spin); the `point`-taking variants
  apply at a world point and also induce rotation.

```c
b2Vec2 jump;  jump.x = 0.0;  jump.y = 8.0;
b2Body_ApplyLinearImpulseToCenter( &world, &player, &jump, true );
```

## Mass

```c
float b2Body_GetMass( b2World* world, b2BodyId* bodyId );
void  b2Body_GetMassData( b2World* world, b2BodyId* bodyId, b2MassData* result );
void  b2Body_SetMassData( b2World* world, b2BodyId* bodyId, b2MassData* massData );
void  b2Body_ApplyMassFromShapes( b2World* world, b2BodyId* bodyId );
```

By default a body's mass is computed automatically from its shapes' density. You rarely touch
this. `b2Body_ApplyMassFromShapes` recomputes it (call it if you changed a shape's density after
creation); `b2Body_SetMassData` overrides it with explicit mass, center, and inertia
(`b2MassData { float mass; b2Vec2 center; float rotationalInertia; }`).

## Body flags and tuning

```c
void  b2Body_SetGravityScale( b2World* world, b2BodyId* bodyId, float gravityScale );
float b2Body_GetGravityScale( b2World* world, b2BodyId* bodyId );

void  b2Body_SetLinearDamping( b2World* world, b2BodyId* bodyId, float linearDamping );
float b2Body_GetLinearDamping( b2World* world, b2BodyId* bodyId );
// (angular damping mirrors this)
```

```c
void b2Body_SetMotionLocks( b2World* world, b2BodyId* bodyId, bool linearX, bool linearY, bool angularZ );
void b2Body_GetMotionLocks( b2World* world, b2BodyId* bodyId, bool* linearX, bool* linearY, bool* angularZ );
```

Freeze motion on individual axes — e.g. `b2Body_SetMotionLocks( &world, &crate, false, false, true )`
keeps a crate upright by locking rotation.

```c
void b2Body_SetBullet( b2World* world, b2BodyId* bodyId, bool flag );
bool b2Body_IsBullet( b2World* world, b2BodyId* bodyId );
```

Mark a fast body a bullet so continuous collision sweeps it (requires
`b2World_EnableContinuous( &world, true )`).

## Type, enable, sleep

```c
int  b2Body_GetType( b2World* world, b2BodyId* bodyId );
void b2Body_SetType( b2World* world, b2BodyId* bodyId, int type );
```

Change a body between static/kinematic/dynamic at runtime (e.g. freeze a body by making it
static). This moves the body between internal solver sets and rebuilds its contacts — correct
but not free, so don't do it every frame.

```c
void b2Body_Enable( b2World* world, b2BodyId* bodyId );
void b2Body_Disable( b2World* world, b2BodyId* bodyId );
bool b2Body_IsEnabled( b2World* world, b2BodyId* bodyId );
```

A disabled body is removed from the simulation (no collision, no solve) but keeps its handle and
shapes — cheaper than destroying and re-creating for objects that flicker in and out of play.

```c
void b2Body_Wake( b2World* world, b2BodyId* bodyId );
bool b2Body_IsAwake( b2World* world, b2BodyId* bodyId );
void b2Body_WakeTouching( b2World* world, b2BodyId* bodyId );
void b2Body_EnableSleep( b2World* world, b2BodyId* bodyId, bool flag );
```

Only relevant when world sleeping is on. `b2Body_WakeTouching` wakes every body in contact with
this one (without waking this one) — handy after you teleport or modify a body that others rest on.

## Coordinate conversions

```c
void b2Body_GetWorldPoint( b2World* world, b2BodyId* bodyId, b2Vec2* localPoint, b2Vec2* result );
void b2Body_GetLocalPoint( b2World* world, b2BodyId* bodyId, b2Vec2* worldPoint, b2Vec2* result );
void b2Body_GetWorldVector( b2World* world, b2BodyId* bodyId, b2Vec2* localVector, b2Vec2* result );
void b2Body_GetLocalVector( b2World* world, b2BodyId* bodyId, b2Vec2* worldVector, b2Vec2* result );
void b2Body_GetWorldCenter( b2World* world, b2BodyId* bodyId, b2Vec2* result );
```

Convert between a body's local frame and world space — e.g. find where a gun muzzle (a fixed
local offset) currently is in the world. *Point* conversions include translation; *vector*
conversions rotate only.

## Attached shapes and joints

```c
int b2Body_GetShapeCount( b2World* world, b2BodyId* bodyId );
int b2Body_GetShapes( b2World* world, b2BodyId* bodyId, int* shapeIds, int capacity );
int b2Body_GetJointCount( b2World* world, b2BodyId* bodyId );
int b2Body_GetJoints( b2World* world, b2BodyId* bodyId, int* jointIds, int capacity );
```

Enumerate what's attached. The `Get*` fill functions write up to `capacity` **raw int ids** into
your array and return how many were written; resolve each with `b2MakeShapeId` / `b2MakeJointId`
if you need a handle.

## Validity and user data

```c
bool  b2Body_IsValid( b2World* world, b2BodyId* bodyId );
void  b2Body_SetUserData( b2World* world, b2BodyId* bodyId, void* userData );
void* b2Body_GetUserData( b2World* world, b2BodyId* bodyId );
```

`b2Body_IsValid` returns false once the body has been destroyed (its slot reused) — check it
before using a handle you have held across steps. `userData` is the standard way to link a body
back to your game object; it is what collision events hand you (via the body behind a shape id).

```c
b2Body_SetUserData( &world, &body, myEntityPointer );
```

---

Continue to [Shapes](shapes.md).
