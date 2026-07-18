# World

The `b2World` owns everything: bodies, shapes, joints, contacts, and the broad-phase trees.
You allocate the `b2World` yourself (usually one global) and pass its address to every call.

[← Reference index](index.md) · [Bodies →](bodies.md)

## Lifecycle

```c
void b2CreateWorld( b2World* world );
void b2DestroyWorld( b2World* world );
```

`b2CreateWorld` initializes a world in storage you provide. Defaults: gravity `(0, -10)`,
sleeping **off**, continuous collision **off**, warm starting **on**.

`b2DestroyWorld` frees every heap allocation the world owns (bodies, shapes, trees, contacts,
joints). The `b2World` struct itself is yours — it is not freed. After this call the world must
not be used again unless re-created.

```c
b2World world;
b2CreateWorld( &world );
// ... use it ...
b2DestroyWorld( &world );
```

## Stepping the simulation

```c
void b2World_Step( b2World* world, float dt, int subStepCount );
```

Advances the world by `dt` seconds using `subStepCount` solver sub-steps. This is the one call
that actually moves anything: it runs the broad phase, narrow phase, solver, and (if enabled)
sleeping and continuous collision.

- **`dt` should be fixed**, not your frame delta. Use a constant like `1.0 / 60.0` (or
  `1.0 / 30.0`) every step. A variable `dt` makes the simulation non-deterministic and can
  destabilize stacks.
- **`subStepCount`** trades accuracy for cost; **4** is the standard value. More sub-steps make
  joints and stacks stiffer at linear extra cost.
- If your render runs faster than your physics, step at a fixed rate and interpolate body poses
  between steps for display.

```c
b2World_Step( &world, 1.0 / 60.0, 4 );
```

## Gravity

```c
void b2World_SetGravity( b2World* world, b2Vec2* gravity );
void b2World_GetGravity( b2World* world, b2Vec2* result );
```

Gravity is a world acceleration applied to every dynamic body (scaled per-body by
`b2Body_SetGravityScale`). Positive Y is up, so downward gravity is negative Y.

```c
b2Vec2 g;  g.x = 0.0;  g.y = -10.0;
b2World_SetGravity( &world, &g );
```

The world's `gravity` is also a plain public field, so `world.gravity.y = -10.0;` works too.

## Global solver tuning

```c
void b2World_SetContactTuning( b2World* world, float hertz, float dampingRatio, float pushSpeed );
```

Controls the softness of contact response. Defaults are `hertz = 30`, `dampingRatio = 10`,
`pushSpeed = 3`. Higher `hertz` is stiffer; `pushSpeed` caps how fast overlap is resolved
(m/s). Leave these at their defaults unless you have a specific stability problem.

```c
void  b2World_SetRestitutionThreshold( b2World* world, float value );
float b2World_GetRestitutionThreshold( b2World* world );
```

Impacts slower than this closing speed (default `1.0` m/s) do not bounce, even on restitutive
shapes. Prevents resting bodies from jittering.

```c
void  b2World_SetHitEventThreshold( b2World* world, float value );
float b2World_GetHitEventThreshold( b2World* world );
```

Minimum approach speed for a contact to emit a hit event (see [Events](events.md)).

```c
void  b2World_SetMaximumLinearSpeed( b2World* world, float value );
float b2World_GetMaximumLinearSpeed( b2World* world );
```

Per-step speed clamp (default `400`). A body is prevented from moving faster than this, which
stops tunneling and numerical blow-ups.

## Toggles

```c
void b2World_EnableSleeping( b2World* world, bool flag );
bool b2World_IsSleepingEnabled( b2World* world );

void b2World_EnableContinuous( b2World* world, bool flag );
bool b2World_IsContinuousEnabled( b2World* world );

void b2World_EnableWarmStarting( b2World* world, bool flag );
bool b2World_IsWarmStartingEnabled( b2World* world );
```

- **Sleeping** (default **off**) lets settled islands stop being solved, which is a large CPU
  saving in scenes with many resting bodies. Turn it **on** for any real game:
  `b2World_EnableSleeping( &world, true );`
- **Continuous** collision (default **off**) sweeps fast bodies so they don't tunnel through
  thin geometry. Enable it if you have bullets or fast movers, and mark those bodies as bullets
  (`b2Body_SetBullet`).
- **Warm starting** (default **on**) reuses last step's impulses to converge faster. Leave it on.

These default off (except warm starting) so that enabling them is an explicit, opt-in decision.

## Utilities

```c
void b2World_GetBounds( b2World* world, b2AABB* result );
```

The union AABB of everything in the broad phase — useful for framing a camera or a minimap.
This is the **fat**-AABB union, so it is slightly larger than the tight geometry. An empty world
returns an inverted box (`lowerBound > upperBound`), which you can test for "nothing here".

```c
int b2World_GetAwakeBodyCount( b2World* world );
```

Number of bodies actually being simulated this step (i.e. not asleep or static). A cheap way to
gauge load or detect that a scene has fully settled.

```c
void  b2World_SetUserData( b2World* world, void* userData );
void* b2World_GetUserData( b2World* world );
```

Stash an opaque game pointer on the world.

---

Continue to [Bodies](bodies.md).
