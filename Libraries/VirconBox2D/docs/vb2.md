# vb2 — the easy API

**Start here.** `vb2.h` is a thin facade over the full `b2*` API, built for the 90% of game code
that just wants to drop a box, push it, and find out what it hit.

The `b2*` API is a faithful port of Box2D v3, which means it inherits the console's constraints:
the world is threaded through every call, every vector comes back through an out-pointer, and a
handle is a multi-word struct you have to keep storage for. That is correct, and you can always
drop down to it. But it makes a five-line idea cost twenty-five lines.

The facade trades that generality for three things:

- **One implicit world**, created by `vb2_Init()`. A console game has one physics world.
- **Handles are a plain `int`** — return them, store them in your own structs, compare them.
  `-1` means "none".
- **Scalars in, scalars out.** No `b2Vec2` round-trips anywhere.

It is sugar, never a wall: `vb2_world` is an ordinary `b2World`, so you can mix `b2*` calls with
facade calls in the same program, and reach for the full API the moment you outgrow this one.

```c
#include "video.h"
#include "vb2.h"

void main()
{
    vb2_Init();
    vb2_SetCamera( 0.0, 0.0, 20.0 );              // 20 pixels per meter

    vb2_Wall( 0.0, -5.0, 8.0, 0.5 );              // static floor
    int ball = vb2_Ball( 0.0, 5.0, 0.5 );         // dynamic circle, falls onto it

    while( true )
    {
        vb2_Step();

        clear_screen( color_black );
        print_at( vb2_ScreenX( vb2_GetX( ball ) ),
                  vb2_ScreenY( vb2_GetY( ball ) ), "O" );
        end_frame();
    }
}
```

That is the whole shape of a physics game: create, step, read, draw.

See [`template.c`](../template.c) for a complete starter ROM (`bash build.sh template`) — a
level, a player you drive, crates to shove, a ray-cast laser, and a ray-cast ground check.

---

## Units and coordinates

The world is in **meters, y-up**. The screen is 640×360 **pixels, y-down**. `vb2_SetCamera`
bridges them.

**Do not draw at 1 pixel = 1 meter.** Box2D's tolerances (a ~0.005 m contact slop, a 0.05 m AABB
margin) are tuned for human-sized objects, so a body a few pixels wide is a body a few
*centimeters* wide, and it will jitter and behave badly. Keep your objects roughly **0.5–5 m**
and let the camera scale them up. At the default 20 px/m, a 1 m crate draws 20 px across.

All sizes passed to the creators are **half-extents**, matching `b2MakeBox`: a 2×1 m crate is
`vb2_Box( x, y, 1.0, 0.5 )`.

---

## World

```c
void  vb2_Init();                                  // create the world; gravity (0, -10)
void  vb2_Quit();
void  vb2_SetGravity( float gx, float gy );
void  vb2_EnableSleep( bool flag );
void  vb2_Step();                                  // 1/60 s, 4 sub-steps
```

`vb2_Step()` runs exactly one step per displayed frame, which matches the console's fixed 60 fps.
A game that needs 30 Hz physics with interpolated drawing should call `b2World_Step` directly —
see [SHOWCASE.md](../SHOWCASE.md) for that pattern.

**`vb2_EnableSleep( true )` is worth doing early.** Sleeping is off by default in this port (a
decision made to keep the frozen regression suite bit-identical, which is a port concern, not a
game one). With it on, a settled pile drops out of the solve entirely — on a 250,000-cycle frame
budget that is often the difference between a scene fitting and not.

---

## Bodies

```c
int   vb2_Wall( float x, float y, float halfW, float halfH );   // static box
int   vb2_Box(  float x, float y, float halfW, float halfH );   // dynamic box
int   vb2_Ball( float x, float y, float radius );               // dynamic circle
int   vb2_Line( float x1, float y1, float x2, float y2 );       // static segment
void  vb2_Destroy( int body );
bool  vb2_Exists( int body );
```

Each creator makes a body with exactly one shape. That one-shape rule is what lets the facade hide
`b2ShapeId` entirely. A body that needs several shapes — a capsule, a polygon, a chain — is a
`b2*` API body; see [Shapes](shapes.md).

### Reading

```c
float vb2_GetX( int body );                 float vb2_GetY( int body );
float vb2_GetAngle( int body );             // radians, counter-clockwise
float vb2_GetVX( int body );                float vb2_GetVY( int body );
float vb2_GetAngularVelocity( int body );
float vb2_GetMass( int body );
bool  vb2_IsAwake( int body );
```

### Writing

```c
void  vb2_SetPosition( int body, float x, float y );      // teleport, keeps rotation
void  vb2_SetAngle( int body, float radians );            // rotate, keeps position
void  vb2_SetVelocity( int body, float vx, float vy );
void  vb2_SetAngularVelocity( int body, float w );
void  vb2_ApplyImpulse( int body, float ix, float iy );   // instant kick — jumps, knockback
void  vb2_ApplyForce( int body, float fx, float fy );     // sustained push — thrust, wind
void  vb2_ApplyTorque( int body, float torque );          // spin — rolling a ball
void  vb2_Wake( int body );
```

An impulse is applied *once*; a force acts for *one step*, so call it every frame you want it to
push. Both wake a sleeping body.

### Material

These poke the body's single shape:

```c
void  vb2_SetFriction( int body, float f );          // 0 = ice, 0.6 = default, 1+ = grippy
void  vb2_SetBounce( int body, float restitution );  // 0 = dead (default), 1 = bounces back to drop height
void  vb2_SetDensity( int body, float d );           // kg/m^2, default 1 — recomputes mass
```

### Handles, and what happens when a body dies

A handle is one `int`, packing the body's slot **and its generation**. That second half is what
makes a dead handle *detectable*: when a body is destroyed its slot is recycled by the next
create, and a handle carrying only an index would silently start addressing whichever body took
the slot. The generation catches it.

So a handle to a destroyed body is safe to hold, pass around, and call:

```c
int box = vb2_Box( 0.0, 5.0, 0.5, 0.5 );
vb2_Destroy( box );

vb2_Exists( box );          // false — forever, even after the slot is reused
vb2_GetX( box );            // 0.0, not a crash
vb2_SetVelocity( box, 1.0, 0.0 );   // a no-op, not a crash
vb2_Destroy( box );         // also a no-op
```

Every getter reads `0.0` on a dead handle and every setter does nothing, so you never need to
guard a call — use `vb2_Exists` only when you need to tell "the value is zero" from "the body is
gone".

---

## Camera

```c
void  vb2_SetCamera( float centerX, float centerY, float pixelsPerMeter );
int   vb2_ScreenX( float worldX );      int   vb2_ScreenY( float worldY );
float vb2_WorldX( int screenX );        float vb2_WorldY( int screenY );
```

`centerX/centerY` is the world point that lands at the middle of the screen. `ScreenY` flips the
axis for you. The inverse pair turns a screen position back into a world position — pair it with
`vb2_BodyAt` for cursor picking.

Defaults to the world origin, screen-centered, at 20 px/m.

---

## Queries

```c
int   vb2_RayCast( float x0, float y0, float x1, float y1 );   // closest body, or -1
float vb2_HitX();   float vb2_HitY();          // where it struck
float vb2_HitNX();  float vb2_HitNY();         // the surface normal there
float vb2_HitFraction();                       // 0 = at the origin, 1 = at the far end
int   vb2_BodyAt( float x, float y );          // the body under a point, or -1
```

The hit is kept in a static record and read back with scalar accessors, so read it before you cast
again. (There are no threads on this console; that is the only rule.)

> **A ray that starts inside a shape hits that shape**, at fraction 0. Casting from a body's
> center — for line of sight, or a ground check — will find that body and nothing else. Start the
> ray on the surface instead:
>
> ```c
> // ground check: cast down from just BELOW the ball, not from its center
> int ground = vb2_RayCast( x, y - radius - 0.02, x, y - radius - 0.15 );
> bool grounded = ( ground != -1 );
> ```

---

## Events

```c
int   vb2_TouchCount();
int   vb2_TouchA( int i );    int   vb2_TouchB( int i );    // the two BODIES that touched
```

Poll these **after** `vb2_Step()`; the next step clears them. The engine reports collisions as
shape pairs; the facade resolves them to body handles for you, so you can compare them straight
against the handles you're holding:

```c
vb2_Step();

int e;
for( e = 0; e < vb2_TouchCount(); e++ )
{
    if( vb2_TouchA( e ) == player || vb2_TouchB( e ) == player )
        PlayThud();
}
```

For end-touch, hit events (with impact speed), and sensors, use the `b2*` API — see
[Events](events.md).

---

## Joints

```c
int   vb2_Pin( int bodyA, int bodyB, float worldX, float worldY );  // hinge at a world point
int   vb2_Rope( int bodyA, int bodyB );        // hold their CURRENT distance
void  vb2_Motor( int joint, float speed, float maxTorque );         // drive a pin
void  vb2_DestroyJoint( int joint );
bool  vb2_JointExists( int joint );
```

The two a game actually reaches for. A **pin** is a hinge: doors, ragdoll limbs, a wheel on a
chassis, a swinging bridge. A **rope** holds two bodies a fixed distance apart — place them first,
then rope them, because it uses the distance they're at.

`vb2_Motor` drives a pin: `speed` in rad/s, using at most `maxTorque` N·m to get there. Speed `0`
with a high torque makes the hinge hold its angle, like a servo. It ignores a rope.

Joint handles pack index and generation exactly like body handles, so a handle that outlives its
joint is detected rather than silently reused.

The other five joint types — prismatic, weld, wheel, motor, filter — and the spring/limit options
on these two are the def-based `b2*` API. See [Joints](joints.md).

---

## Dropping down to the full API

The facade is a strict subset of what the engine can do. When you need the rest — capsules,
chains, multi-shape bodies, collision filters, sensors, shape casts, continuous collision,
character-controller movers — reach straight past it. `vb2_world` is a plain `b2World`:

```c
b2World_SetContactTuning( &vb2_world, 30.0, 10.0, 3.0 );
```

And any facade handle converts to a real, generation-checked `b2BodyId`:

```c
b2BodyId id;
if( vb2_GetBodyId( player, &id ) )
    b2Body_SetBullet( &vb2_world, &id, true );
```

That is also the escape hatch for a hot loop: hold the `b2BodyId` and call `b2Body_*` directly,
skipping the facade's resolve. (Each facade call costs one extra call layer — roughly
`10 + 2·args` instructions. Irrelevant for creators and fine for a few dozen per-frame getters
against a 250,000-cycle budget, but worth knowing about if you're iterating hundreds of bodies.)

Start at [`docs/index.md`](index.md) for the full `b2*` reference and its conventions.
