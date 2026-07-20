# VirconBox2D

**A port of [Box2D v3](https://github.com/erincatto/box2d) — Erin Catto's 2D physics engine — to the [Vircon32](https://www.vircon32.com/) fantasy game console.**

VirconBox2D brings a full rigid-body 2D physics engine to Vircon32: bodies fall, collide,
rest, stack, bounce, sleep and wake; seven joint types constrain them; ray/shape/overlap
queries and a character-controller mover let games interrogate the world. It is a faithful
re-expression of upstream Box2D v3's algorithms, rewritten to fit the console's restricted C
dialect and single-core, cacheless, word-addressed machine.

**Status: complete.** Every simulation module upstream ships (except the deliberately-excluded
parallel-solver infrastructure) is ported and verified, and the entire *portable* public
`b2*` API surface is implemented. See [Scope](#scope) for what is intentionally left out.

## Documentation

**New here? Start at [`docs/vb2.md`](docs/vb2.md)** — the easy API, and the quickstart below.

Full `b2*` reference in [`docs/`](docs/index.md): [World](docs/world.md) ·
[Bodies](docs/bodies.md) · [Shapes](docs/shapes.md) · [Joints](docs/joints.md) ·
[Queries](docs/queries.md) · [Events](docs/events.md) · [Mover](docs/mover.md).
[`docs/index.md`](docs/index.md) explains the calling conventions and has the full-API version of
the example below.

---

## Quickstart

Two headers ship for game code:

| Include | What you get |
|---|---|
| [`vb2.h`](vb2.h) | **The easy API.** One implicit world, `int` handles, scalars in and out. Covers the 90% path: boxes, balls, walls, forces, ray casts, touch events, hinges and ropes. |
| [`virconbox2d.h`](virconbox2d.h) | **The whole engine** — the complete `b2*` API in one include. (`vb2.h` pulls this in, so you can mix the two freely.) |

A ball falling onto a floor, drawn at 60 fps:

```c
#include "time.h"
#include "video.h"
#include "vb2.h"

void main()
{
    vb2_Init();                                   // gravity (0, -10)
    vb2_EnableSleep( true );                      // settled bodies stop costing solve time
    vb2_SetCamera( 0.0, 0.0, 20.0 );              // 20 pixels per meter

    vb2_Wall( 0.0, -5.0, 8.0, 0.5 );              // static floor  (x, y, HALF-extents)
    int ball = vb2_Ball( 0.0, 5.0, 0.5 );         // dynamic circle

    while( true )
    {
        vb2_Step();                               // one step, 1/60 s

        clear_screen( color_black );
        print_at( vb2_ScreenX( vb2_GetX( ball ) ),
                  vb2_ScreenY( vb2_GetY( ball ) ), "O" );
        end_frame();
    }
}
```

`bash build.sh template` builds a complete starter ROM ([`template.c`](template.c)) — a level, a
player you drive, crates to shove around, a ray-cast laser and a ray-cast ground check.

The facade is sugar, never a wall: `vb2_world` is an ordinary `b2World`, and `vb2_GetBodyId` hands
back a real `b2BodyId`, so you can drop to the full API at any point without restructuring
anything.

---

## Why this is not a recompile

Vircon32 runs C compiled by its own toolchain (`compile.exe` v26.04.24), and the language it
accepts is a strict subset with a few hard, non-obvious restrictions. Box2D could not be
compiled as-is; it had to be ported line by line. The rules that shaped this port:

- **No multi-word struct passing across a function boundary.** `b2Vec2`, `b2Rot`,
  `b2Transform`, `b2AABB` are all larger than one 32-bit word, so they can be neither passed
  by value nor returned by value. This drives the entire API convention (below).
- **No ternary `?:`, no compound literals, no `#pragma once`, no variadics, no
  token-paste/stringize, no `#if`/`#elif`.** (`union` works as a *named* type; only
  anonymous inline union members are rejected. `b2JointSim` uses a named union of
  joint payloads, accessed as `sim->u.<type>Joint`.)
- **No `char`, `double`, `unsigned`, or 64-bit integers.** 32-bit `int` and `float` only.
- **Memory is word-addressed:** `sizeof`, `memcpy`, `memset` count 32-bit **words**, not bytes.
- **`NULL == -1`** (not 0), and `>>` is logical.
- **Tiny float literals underflow to zero** — anything below ~1e-6 (including `FLT_EPSILON`)
  is silently read as `0.0` by the lexer *and* the constant folder, so small constants are
  produced by runtime division against a global.
- **Function calls are expensive** (~10 + 2·args instructions) while `fmin`/`fmax`/`fabs`/
  `pow`/float-divide are single-cycle, and there is **no data cache** (so struct-of-arrays
  layouts buy nothing). The optimization levers are call elimination and better algorithms,
  not locality.

The full, empirically-verified rule set lives in
[`../VIRCON32_C_DIALECT.md`](../VIRCON32_C_DIALECT.md). Read it before touching the port.

---

## API convention

Because multi-word structs cannot cross function boundaries by value, the port mirrors the
idiom of Vircon32's official `vector2d.h`:

- **A function that upstream returned a struct becomes `void` and takes a result
  OUT-pointer as its last argument.**
  Upstream `b2Vec2 b2Add(b2Vec2 a, b2Vec2 b)` becomes
  `void b2Add(b2Vec2* a, b2Vec2* b, b2Vec2* result)`.
- **Scalars** (`float`, `int`, `bool` — one word) are still returned by value.
- **Handles** (`b2BodyId`, `b2ShapeId`, `b2JointId`, `b2ContactId`) are multi-word, so they
  too come back through an out-pointer and are passed in by pointer.
- **The `b2World` is threaded explicitly** as a `b2World*` first argument, rather than
  upstream's opaque `b2WorldId`. (Consequently there is no `b2*_GetWorld` / `b2World_IsValid`
  — you already hold the world.)
- **Query callbacks** receive a **raw `int` shape id** plus pointer arguments, not a by-value
  `b2ShapeId`/`b2Vec2`. Resolve a raw id to a checked handle with `b2MakeShapeId`.

Everything is header-only and compiled as a **single translation unit** (no linker): each
`port/b2_*.h` carries full implementations behind an include guard.

---

## Repository layout

| Path | What |
|------|------|
| `vb2.h` | The game-facing facade — the easy API. |
| `virconbox2d.h` | Umbrella header: the whole engine in one include. |
| `template.c` / `template.xml` | The copy-me starter ROM. |
| `port/` | The port itself — one header per upstream module (`b2_math.h`, `b2_body.h`, …). Header-only, single-TU. |
| `harness.c` / `harness.xml` | **Frozen** cumulative regression suite (~520+ known-value checks, all green). |
| `harness2.c` / `harness2.xml` | **Active-development** suite; new slices add checks here. |
| `boxtests.c` | Port of upstream `box2d/test/*.c` (Erin Catto's own unit tests) onto the green/red contract. |
| `benchmark.c` | Upstream benchmark scenes as a perf + validation ROM. |
| `showcase.c` / `SHOWCASE.md` | Interactive MEGADEMO ROM (renderer + car/joints/sleep/laser/gravity-flip). |
| `demo.c`, `perf.c`, `sleep_demo.c`, `joint_demo.c` | Smaller demo / profiling ROMs. |
| `probes/` | Tiny programs that settled dialect questions empirically. |
| `build.sh` | compile → assemble → packrom → `bin/<name>.v32`. |
| `../box2d/` | Stock upstream Box2D v3 source — **read-only reference**, not part of the build. |
| `../VIRCON32_C_DIALECT.md` | The dialect bible. |

`#include "virconbox2d.h"` pulls in every `port/` header in dependency order. (The one header
deliberately left out is `port/b2_validate.h` — `b2ValidateWorld`, a structural self-check. Single-TU
means everything you include lands in the ROM, and that one is a dev tool; add it yourself, after
the umbrella, when you need it.)

---

## Build & run

```bash
cd VirconBox2d
bash build.sh template      # -> bin/template.v32  (the copy-me starter game)
bash build.sh harness       # -> bin/harness.v32   (frozen regression suite)
bash build.sh harness2      # -> bin/harness2.v32  (active suite)
bash build.sh showcase      # -> bin/showcase.v32  (interactive demo)
```

`build.sh <name>` runs the full pipeline on `<name>.c` + `<name>.xml` and emits
`bin/<name>.v32`. The toolchain lives in `E:\Claude\Projects\Vircon32\DevTools\`
(`compile.exe` / `assemble.exe` / `packrom.exe`, compiler **v26.04.24**).

Run a ROM in the emulator (it auto-powers-on):

```
E:\Soft\Vircon32\Emulator\Vircon32.exe bin/harness.v32
```

ROMs are asset-free (empty `<textures/>` / `<sounds/>` in the XML).

### The verification model

Screenshots / computer-use are off by design; correctness is proven with a **green/red**
contract on hardware:

1. Known-value `Check(...)` cases are AND-ed into a single verdict.
2. The ROM clears the screen **green** if every check passed, **red** otherwise.
3. On red, the BIOS font prints `FIRST FAIL CHECK #N` / `TOTAL CHECKS M`, which maps
   straight back to the failing `Check(` call — no bisection needed.

`harness.c` is a frozen baseline; `harness2.c` is where new work is validated. Any change to
a `port/` header must keep **both** green.

---

## Feature coverage

Verified working on-console:

- **Bodies & shapes** — static / kinematic / dynamic bodies; circle, capsule, polygon,
  segment, and chain-segment shapes; mass/inertia from density; create/destroy with full
  contact & joint teardown.
- **Collision** — the complete narrow phase (all shape-pair manifolds, SAT + clipping),
  broad-phase AABB tree, GJK distance, time-of-impact, shape casting.
- **Solver** — TGS-soft contact solve with friction, restitution, 2-point manifolds,
  stacking, cross-step warm starting, speed caps and motion locks.
- **Joints** — all seven v3 types: distance, revolute, prismatic, weld, wheel, motor, and
  filter, each with motor / limit / spring options, plus a generation-checked `b2JointId`
  and a full runtime setter/getter API.
- **Islands, sleeping & waking** — bodies settle, an island sleeps and drops out of the
  solve, and a collision from an awake body wakes it; `b2SplitIsland` keeps islands minimal.
- **Continuous collision** — bullet-vs-static and bullet-vs-dynamic/kinematic via a
  post-finalize TOI pass (opt-in).
- **Sensors & events** — sensor overlap begin/end, contact begin/end-touch, and contact hit
  events, all as poll-after-step queries.
- **Queries** — closest and all-hits ray casts, shape casts, AABB and shape overlap, point
  tests, closest-point, world bounds, and radial `b2World_Explode`.
- **Character controller** — the `mover` module (`b2World_CollideMover` / `b2World_CastMover`
  + `b2SolvePlanes` / `b2ClipVector`).

Optional behaviors default to the setting that keeps the frozen suite bit-identical:
**sleeping and continuous collision are OFF by default** (`world.enableSleep` /
`world.enableContinuous`); warm starting is ON.

---

## The same thing, in the full API

The [quickstart](#quickstart) above is the facade. Here is the identical scene through the `b2*`
API — the same physics, with the conventions on display. This is what you write once you need
capsules, filters, sensors, or anything else the facade doesn't cover:

```c
#include "virconbox2d.h"

void main()
{
    b2World world;
    b2CreateWorld( &world );          // gravity defaults to (0, -10)

    // --- static ground ---
    b2BodyDef groundDef;
    b2DefaultBodyDef( &groundDef );
    groundDef.type = b2_staticBody;
    b2BodyId ground;
    b2CreateBody( &world, &groundDef, &ground );

    b2Polygon groundBox;
    b2MakeBox( 50.0, 1.0, &groundBox );          // half-extents
    b2ShapeDef groundShape;
    b2DefaultShapeDef( &groundShape );
    b2ShapeId gs;
    b2CreatePolygonShape( &world, &ground, &groundShape, &groundBox, &gs );

    // --- a falling dynamic box ---
    b2BodyDef boxDef;
    b2DefaultBodyDef( &boxDef );
    boxDef.type = b2_dynamicBody;
    boxDef.position.x = 0.0;
    boxDef.position.y = 10.0;
    b2BodyId box;
    b2CreateBody( &world, &boxDef, &box );

    b2Polygon dynBox;
    b2MakeBox( 0.5, 0.5, &dynBox );
    b2ShapeDef boxShape;
    b2DefaultShapeDef( &boxShape );
    boxShape.density = 1.0;
    b2ShapeId bs;
    b2CreatePolygonShape( &world, &box, &boxShape, &dynBox, &bs );

    // --- step ---
    int i;
    for( i = 0; i < 90; ++i )
    {
        b2World_Step( &world, 1.0 / 60.0, 4 );   // dt, sub-steps

        b2Vec2 p;                                // result comes back by out-pointer
        b2Body_GetPosition( &world, &box, &p );
        // p.x, p.y -> draw the box at its world position
    }

    b2DestroyWorld( &world );
}
```

Note the two conventions in action: the `b2World*` is threaded through every call, and
`b2Body_GetPosition` returns the position through a `b2Vec2*` out-pointer rather than by value.

---

## Scope

The port is complete for the Vircon32 model. What remains unported is genuinely out of scope,
not deferred work — it either can't exist in the dialect, or has no meaning on a single-core,
file-less console:

- **Parallel-solver infrastructure** — the constraint graph, task scheduler, and
  `parallel_for` (the solver runs serially; there are no threads).
- **Recording / replay / world snapshots** — needs file I/O and serialization.
- **Chain aggregate handle** — `b2CreateChain` builds chain-segment shapes, but there is no
  `b2ChainId` aggregate or per-chain surface-material arrays.
- **Surface / user materials and wind** (`b2Shape_*SurfaceMaterial`, `ApplyWind`) — the port
  carries friction/restitution directly on the shape instead of a material registry.
- **Threading, debug-draw, and profiling hooks** (`*WorkerCount`, `b2World_Draw`,
  `GetProfile`, `GetCounters`, `DumpMemoryStats`).
- **Callback setters** (`Set*Callback` for custom filtering / friction / restitution /
  pre-solve) — the port uses fixed default mixing.
- **`char`-based names** (`b2Body_*Name`) — the dialect has no `char`.

Some upstream shapes differ rather than being absent: the aggregate `b2World_Get*Events`
getters are replaced by per-kind poll accessors (`b2World_GetContactHitEvents`,
`GetSensorBeginEvents`, …), and world/body/shape validity is checked structurally with
`b2ValidateWorld` instead of a `b2WorldId`-based `IsValid`.

Known deviations that matter for anyone building on the port:

- `b2MakeRot` / `b2Atan2` use the console's **hardware** trig, not Box2D's deterministic
  software trig — so the simulation is not bit-reproducible across platforms.
- `b2ShapeCast`'s hit fraction stops **one `B2_LINEAR_SLOP` short** of geometric contact.
- Held `b2ContactId` handles go stale often (contacts are engine-managed and destroyed the
  moment shapes separate) — always check `b2Contact_IsValid` / the `b2Contact_GetData`
  return value.

---

## Credits & license

- **Box2D** © Erin Catto, [MIT License](https://github.com/erincatto/box2d/blob/main/LICENSE).
  This port carries the same license as the upstream it derives from.
- **Vircon32** © Carra — console, toolchain, and emulator.

VirconBox2D is an independent port and is not affiliated with either project.
