# VirconBox2D — API Reference

The game-facing reference for [VirconBox2D](../README.md), the Box2D v3 port for Vircon32.
This documents the public `b2*` functions you call to build and run a physics world. It is
written for **game developers using the library**, not for people extending the port.

If you have used Box2D v3 before, the concepts are identical — this reference exists because
the *shape* of every call is different (see [Conventions](#conventions) below).

**If you are new, start at [vb2](vb2.md) instead** — the easy API, which covers the 90% game path
with one implicit world, `int` handles and scalar arguments, and none of the conventions below.
Come back here when you outgrow it (you can mix the two freely).

## Reference map

| Page | Covers |
|------|--------|
| [**vb2**](vb2.md) | **Start here.** The game-facing facade: create, step, read, draw — plus camera, ray casts, touch events, hinges and ropes. |
| [World](world.md) | Create/destroy the world, step the simulation, gravity, global tuning, toggles. |
| [Bodies](bodies.md) | Create/destroy bodies, read/write pose & velocity, apply forces & impulses, mass, body type. |
| [Shapes](shapes.md) | Attach geometry (box / circle / capsule / polygon / segment / chain), density, friction, filters. |
| [Joints](joints.md) | The seven joint types and their motor / limit / spring controls. |
| [Queries](queries.md) | Ray casts, shape casts, overlap tests, point tests, closest point, explosions, world bounds. |
| [Events](events.md) | Contact begin/end-touch, hit events, sensor overlap — all polled after the step. |
| [Mover](mover.md) | The kinematic character-controller helpers. |

## Conventions

Three rules govern **every** call in this library. They exist because the Vircon32 C compiler
cannot pass or return a struct larger than one 32-bit word. Once you internalize them, the whole
API is predictable.

### 1. The world is passed explicitly

Every function takes a `b2World* world` as its first argument. There is no opaque `b2WorldId`;
you hold the `b2World` yourself. (This is why there is no `b2World_IsValid` or `b2*_GetWorld` —
you already have the world in hand.)

### 2. Struct results come back through an out-pointer (last argument)

Anything bigger than one word — vectors, rotations, transforms, AABBs, and the ID handles — is
**returned through a pointer you pass as the last argument**, and passed **in** by pointer.
Scalars (`float`, `int`, `bool`) are still returned normally.

```c
// Upstream Box2D:   b2Vec2 p = b2Body_GetPosition(bodyId);
// VirconBox2D:
b2Vec2 p;
b2Body_GetPosition( &world, &body, &p );   // result written into p

float m = b2Body_GetMass( &world, &body ); // scalar -> normal return
```

### 3. IDs are multi-word handles, so they follow the same rule

`b2BodyId`, `b2ShapeId`, `b2JointId`, and `b2ContactId` are structs, not integers. A *create*
call writes the new handle into an out-pointer; every later call takes it by pointer.

```c
b2BodyId body;                          // you own the storage
b2CreateBody( &world, &def, &body );    // handle written into `body`
b2Body_SetLinearVelocity( &world, &body, &v );
```

Callbacks (used by the query surface) are handed a **raw `int` shape id** instead of a
`b2ShapeId`, because a struct can't be passed to a callback by value. Turn a raw id into a
checked handle with `b2MakeShapeId( &world, rawId, &outHandle )`.

## Core types

```c
struct b2Vec2 { float x, y; };          // a 2D vector or point
struct b2Rot  { float c, s; };          // a rotation, stored as cos/sin (NOT an angle)
struct b2Transform { b2Vec2 p; b2Rot q; };
struct b2AABB { b2Vec2 lowerBound, upperBound; };
```

`b2Rot` holds cosine and sine, not radians. Build one from an angle and read it back:

```c
b2Rot r;
b2MakeRot( 1.5708, &r );                 // ~90 degrees
float radians = b2Rot_GetAngle( &r );
extern b2Rot b2Rot_identity;             // { 1, 0 } — no rotation
```

Handles all share the same three-word shape and can be validity-checked:

```c
struct b2BodyId  { int index1; int world0; int generation; };
struct b2ShapeId { int index1; int world0; int generation; };
// b2JointId, b2ContactId identical

bool ok = b2Body_IsValid( &world, &body );   // false once the body is destroyed
```

## Units & conventions

- **Units are meters, kilograms, seconds, radians.** Keep bodies roughly 0.1–10 m; the solver is
  tuned for that range. A "pixel = meter" world will jitter — scale your rendering instead.
- **Half-extents:** `b2MakeBox(halfWidth, halfHeight, ...)` takes half-sizes, so a 2×2 m box is
  `b2MakeBox(1.0, 1.0, ...)`.
- **No `2.0f` suffix.** Write float literals as `2.0`, never `2.0f` — the compiler rejects the
  suffix. And never write a literal smaller than ~1e-6; it silently becomes `0.0`.
- **Gravity** defaults to `(0, -10)`. Positive Y is up.

## A complete minimal program

```c
#include "port/b2_math.h"
#include "port/b2_constants.h"
#include "port/b2_aabb.h"
#include "port/b2_geometry.h"
#include "port/b2_hull.h"
#include "port/b2_distance.h"
#include "port/b2_manifold.h"
#include "port/b2_ctz.h"
#include "port/b2_core.h"
#include "port/b2_dynamic_tree.h"
#include "port/b2_id_pool.h"
#include "port/b2_arena_allocator.h"
#include "port/b2_shape.h"
#include "port/b2_body.h"
#include "port/b2_bitset.h"
#include "port/b2_table.h"
#include "port/b2_solver.h"

void main()
{
    b2World world;
    b2CreateWorld( &world );

    // static ground
    b2BodyDef groundDef;  b2DefaultBodyDef( &groundDef );
    groundDef.type = b2_staticBody;
    b2BodyId ground;  b2CreateBody( &world, &groundDef, &ground );
    b2Polygon groundBox;  b2MakeBox( 50.0, 1.0, &groundBox );
    b2ShapeDef groundShape;  b2DefaultShapeDef( &groundShape );
    b2ShapeId gs;  b2CreatePolygonShape( &world, &ground, &groundShape, &groundBox, &gs );

    // falling box
    b2BodyDef boxDef;  b2DefaultBodyDef( &boxDef );
    boxDef.type = b2_dynamicBody;
    boxDef.position.x = 0.0;  boxDef.position.y = 10.0;
    b2BodyId box;  b2CreateBody( &world, &boxDef, &box );
    b2Polygon dynBox;  b2MakeBox( 0.5, 0.5, &dynBox );
    b2ShapeDef boxShape;  b2DefaultShapeDef( &boxShape );
    boxShape.density = 1.0;
    b2ShapeId bs;  b2CreatePolygonShape( &world, &box, &boxShape, &dynBox, &bs );

    int i;
    for( i = 0; i < 90; ++i )
    {
        b2World_Step( &world, 1.0 / 60.0, 4 );
        b2Vec2 p;  b2Body_GetPosition( &world, &box, &p );
        // draw the box at (p.x, p.y)
    }

    b2DestroyWorld( &world );
}
```

The include block is fixed order (no umbrella header yet). Continue to [World](world.md).
