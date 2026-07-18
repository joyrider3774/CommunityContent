# PLAN — `virconbox2d.h` umbrella + `vb2` game-facing facade

Status: **DONE 2026-07-11.** All four slices shipped and verified: S1 umbrella (`virconbox2d.h`,
harness2 + showcase converted), S2 core facade (`vb2.h`), S3 camera + `template.v32`, S4
queries/events/joints. harness2 GREEN including the S2 twin-world equivalence group; template.v32
user-verified. Docs: `docs/vb2.md` + README quickstart rewritten.

**ONE DEVIATION from the plan below — handles pack the GENERATION, not just the index.** The plan
said the handle is the raw `id.index1` and that rebuilding via `b2MakeBodyId` would still catch
stale ids. It would not: `b2MakeBodyId` stamps whatever generation the slot *currently* holds, so
a handle rebuilt from a bare index always validates — and once the freed slot is recycled by a
later create, that stale handle silently addresses a **different body**. (Plain destroy *was*
caught, via the freed-slot marker, which is why the plan's own acceptance test would have passed
while the bug stayed invisible.) So a handle is `(generation & 0x7FFF) << 16 | index1`, bit 31
always clear so `-1` stays an unambiguous "none"; the resolve path builds the `b2BodyId` directly
instead of calling `b2MakeBodyId`, and masks the generation compare to the 15 stored bits so a
slot recycled 32768+ times degrades to a rare aliasing case rather than breaking permanently.
Same treatment for joint handles (`b2MakeJointId` has the identical flaw). The harness2
slot-recycle check is the one that fails under the original design.

Everything else below was built as written.

## Problem

The port is faithful but verbose. Dropping one box on a floor costs ~25 lines: five def
structs, five out-pointer create calls, a 17-line fixed-order include block. Three specific
frictions for a game developer:

1. **The include block** — 17 `port/b2_*.h` includes in an exact attested order, copied from
   an existing ROM. One typo = cryptic compile errors.
2. **Multi-word handles** — `b2BodyId` (3 words) can't be returned by value, so every create
   is a def + out-pointer dance, and handles can't be casually stored/passed in game code.
3. **The out-pointer convention everywhere** — correct and necessary for the full API, but
   the 90% game path (`where is my body? push it left`) doesn't need `b2Vec2` round-trips.

The dialect has no classes, so "the API class" = a facade module: **one implicit global
world + 1-word int handles + scalar in/out**. The full `b2*` API stays available underneath;
the facade is sugar, never a wall.

## Layer 1 — `virconbox2d.h` umbrella header (S1, trivial, do first)

One file at `VirconBox2d/virconbox2d.h`:

```c
#ifndef VIRCONBOX2D_H
#define VIRCONBOX2D_H
// attested-green order (from showcase.c / harness2.c)
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
#include "port/b2_mover.h"
#endif
```

- Port headers already `#include` their own deps behind guards, so this list is belt-and-
  braces — keep the attested order anyway (zero risk, self-documenting).
- **`b2_validate.h` stays OUT** (single TU = every included fn lands in the ROM; the
  validator is a dev tool). Document "add `#include "port/b2_validate.h"` after the umbrella
  for the safety net".
- Console headers (`math.h`/`string.h`/`misc.h`) are pulled transitively by the port headers;
  the game still includes its own `video.h`/`input.h`/`time.h`.

**Acceptance:** swap `harness2.c`'s include block for the umbrella → build → user runs →
green (proves equivalence). Then swap `showcase.c` (proves it coexists with the full console
header set). Update README + `docs/index.md` minimal examples to the single include.

## Layer 2 — `vb2.h` facade (S2–S4)

New file `VirconBox2d/vb2.h`, `#include "virconbox2d.h"` at top, everything prefixed `vb2_`.

### Design rules (all forced by the dialect)

- **One implicit world**: `b2World vb2_world;` global, created by `vb2_Init()`. Realistic for
  a console game; anyone needing two worlds uses the b2 API directly.
- **Handles are the raw 1-word `int` index** (`id.index1`) → returnable by value, storable in
  game structs. Each facade call rebuilds the generation-checked handle internally via the
  existing `b2MakeBodyId`/`b2MakeShapeId`/`b2MakeJointId`, so stale ids are still caught.
  `-1` = no body / miss (matches `NULL == -1`).
- **Scalar in/out only** — floats and ints, never a struct across the facade boundary.
  Where a result is naturally a pair (ray hit point), the facade keeps a static
  "last result" record with scalar accessors instead of out-params.
- **The easy path is one shape per body.** The facade hides `b2ShapeId` entirely; material
  setters poke the body's first shape (`headShapeId`). Multi-shape bodies = b2 API.
- Perf: one extra call layer ≈ 10+2·args instr. Irrelevant for creators (cold) and fine for
  per-frame getters (~50 bodies × ~15 instr ≪ 250k budget). Hot inner loops can always hold
  a real `b2BodyId` and call `b2Body_*` directly — document this escape hatch.

### S2 — core (init / create / step / read / write)

```c
void  vb2_Init();                    // creates vb2_world (gravity 0,-10)
void  vb2_SetGravity( float gx, float gy );
void  vb2_Quit();

// creators return the body id (int). Sizes are HALF-extents, like b2MakeBox.
int   vb2_Wall( float x, float y, float halfW, float halfH );   // static box
int   vb2_Box( float x, float y, float halfW, float halfH );    // dynamic box
int   vb2_Ball( float x, float y, float radius );               // dynamic circle
int   vb2_Line( float x1, float y1, float x2, float y2 );       // static segment
void  vb2_Destroy( int body );
bool  vb2_Exists( int body );

void  vb2_Step();                    // b2World_Step(&vb2_world, 1.0/60.0, 4)

float vb2_GetX( int body );          float vb2_GetY( int body );
float vb2_GetAngle( int body );      // radians
float vb2_GetVX( int body );         float vb2_GetVY( int body );
void  vb2_SetPosition( int body, float x, float y );
void  vb2_SetVelocity( int body, float vx, float vy );
void  vb2_SetAngularVelocity( int body, float w );
void  vb2_ApplyImpulse( int body, float ix, float iy );   // at center, wakes
void  vb2_ApplyForce( int body, float fx, float fy );

// material — pokes the body's first shape
void  vb2_SetFriction( int body, float f );
void  vb2_SetBounce( int body, float restitution );
void  vb2_SetDensity( int body, float d );                 // + mass recompute
```

**Acceptance (harness2 group):** every facade call cross-checked against its b2-API
equivalent on a twin world — `vb2_Box` then 90 × `vb2_Step` must land **bit-identical** to
the README example's `b2Body_GetPosition` result. Plus a stale-id check
(`vb2_Destroy` → `vb2_Exists == false` → getters return 0 harmlessly).

### S3 — camera + draw helpers + starter ROM

The docs already warn "pixel = meter jitters; scale your rendering". Make that scaling a
one-liner (Vircon32 screen is 640×360, Y-down; world is meters, Y-up):

```c
void  vb2_SetCamera( float centerX, float centerY, float pixelsPerMeter );
int   vb2_ScreenX( float worldX );   // world -> screen, Y flipped
int   vb2_ScreenY( float worldY );
float vb2_WorldX( int screenX );     // screen -> world (mouse/touch picking)
float vb2_WorldY( int screenY );
```

Plus `template.c` / `template.xml` → `bin/template.v32`: the canonical "new game" ROM —
`vb2_Init`, a floor, gamepad-driven box, draw loop with `vb2_ScreenX/Y`. This is the
copy-me starting point (demo.c stays as the b2-API dogfood).

Deliberately NOT in S3: the showcase's 30 Hz-physics/60 fps-interpolation machinery. It's
documented in SHOWCASE.md for games that need it; the facade default is the simple
1-step-per-frame loop. (Revisit only if users ask.)

**Acceptance:** round-trip checks in harness2 (`vb2_WorldX(vb2_ScreenX(x)) ≈ x`, Y-flip
sign, off-center camera) + user runs template.v32 and confirms the box responds/draws sanely.

### S4 — queries, events, joint one-liners

```c
// queries — result record kept in a static, scalar accessors
int   vb2_RayCast( float x0, float y0, float x1, float y1 );  // body id or -1
float vb2_HitX();  float vb2_HitY();  float vb2_HitNX();  float vb2_HitNY();
float vb2_HitFraction();
int   vb2_BodyAt( float x, float y );                         // point pick, -1 = none

// events — begin-touch pairs, polled after vb2_Step, body-level
int   vb2_TouchCount();
int   vb2_TouchA( int i );   int   vb2_TouchB( int i );       // body ids

// joints — the two overwhelmingly common cases; the rest = def-based b2 API
int   vb2_Pin( int bodyA, int bodyB, float worldX, float worldY );  // revolute
int   vb2_Rope( int bodyA, int bodyB );        // distance at current positions
void  vb2_Motor( int joint, float speed, float maxTorque );
void  vb2_DestroyJoint( int joint );
```

Internals: `vb2_RayCast` wraps `b2World_CastRayClosest` (NULL filter); `vb2_TouchA/B`
resolve the event's raw shape id → `b2MakeShapeId` → `b2Shape_GetBody` → `index1`;
`vb2_Pin` converts the world anchor to each body's local frame (`b2Body_GetLocalPoint`)
before filling the revolute def.

**Acceptance (harness2):** ray known-value vs the existing CastRayClosest checks; touch pair
after a scripted drop matches `b2World_GetBeginTouchEvents`; pin joint holds its anchor
across a swing (reuse the Phase-E hinge invariant with facade calls).

### Docs (with S2 and S4)

- `docs/vb2.md` — quickstart page, first link in the reference map ("start here; drop to the
  b2 API when you outgrow it").
- README: quickstart example rewritten with the facade (~15 lines instead of ~70), full
  b2-API example moved to docs/index.md.

## Order & effort

| Slice | Contents | Size |
|---|---|---|
| S1 | umbrella header + convert harness2/showcase + doc touch-up | ~1 h, near-zero risk |
| S2 | vb2 core + harness2 twin-world group | the main slice |
| S3 | camera + template.v32 | small |
| S4 | queries/events/joints + docs/vb2.md | small-medium |

Every slice is green-gated (both harnesses; template.v32 user-verified). No port/ header
changes are expected anywhere in this plan — the facade is purely additive, so the frozen
harness only needs its periodic sanity rebuild.

## Open decisions (defaults chosen, flag if you disagree)

1. **Naming** — `vb2_` prefix (short, can't collide with `b2*`). Alt: `VB2_`.
2. **Facade hides shapes** — one shape per body in the easy path. Multi-shape/capsule/chain
   bodies stay b2-API-only in v1 (add `vb2_AddBox(body, ...)` later only if asked).
3. **`vb2_Step` hardwires 1/60, 4 substeps** — matches the console's fixed 60 fps frame.
   Games needing 30 Hz physics call `b2World_Step` themselves (SHOWCASE.md pattern).
4. **Static last-hit record for rays** — not reentrant, but there are no threads and it
   keeps every accessor scalar. Documented.
