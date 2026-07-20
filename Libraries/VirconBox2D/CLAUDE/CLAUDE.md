# VirconBox2D — porting Box2D v3 to the Vircon32 console

Porting **Box2D v3** (Erin Catto's 2D physics engine, written in C17) to run on the
**Vircon32** fantasy game console via its custom C compiler.

## Layout

| Path | What |
|------|------|
| `box2d/` | Stock upstream Box2D v3 source (C17). **Read-only reference** — do not edit; port *out* of it. |
| `VirconBox2d/` | The actual port (Vircon32-dialect C). |
| `VirconBox2d/port/` | Ported headers, one per upstream module (e.g. `b2_math.h`). **The engine is complete as of 2026-07-10** (mover.c was the last module); what remains upstream is API surface + the deliberately-excluded constraint_graph / scheduler / recording / world_snapshot. |
| `VirconBox2d/harness.c` + `harness.xml` | Green/red known-value test harness. |
| `VirconBox2d/showcase.c` + `SHOWCASE.md` | Interactive MEGADEMO ROM (GPU-primitive renderer, car/joints/sleep/laser/gravity-flip, 30 Hz physics + 60 fps interpolated render, adaptive substep governor). **SHOWCASE.md documents every trap + the port-seam workarounds to delete as P0/P1 slices land.** |
| `VirconBox2d/build.sh` | compile → assemble → packrom → `bin/<name>.v32`. |
| `VirconBox2d/probes/` | Tiny programs that settled dialect questions empirically. |
| `VIRCON32_C_DIALECT.md` | **The dialect bible.** Read it before writing any port code. |

## Build & run

```bash
cd VirconBox2d && bash build.sh harness      # -> bin/harness.v32
```
- Tools: `E:\Claude\Projects\Vircon32\DevTools\` (`compile.exe`/`assemble.exe`/`packrom.exe`), compiler **v26.04.24**.
- Emulator: `E:\Soft\Vircon32\Emulator\Vircon32.exe <rom.v32>` — **auto-powers-on** and runs. Logs to `DebugLog.txt` (load/halt/host errors; NOT CPU faults). Memory-card mode is set to **manual** so no card popup.
- Asset-free ROMs are valid (`<textures />`/`<sounds />` empty in the XML).

## Verification loop (human-in-the-loop)

Computer-use/screenshots are **off** by user choice. The loop is:
1. Add known-value `Check(...)` cases to the harness, all AND-ed into `AllPassed`.
2. `bash build.sh harness` (or `harness2`).
3. **The user runs the ROM and reports the screen color.** Green = all pass, red = something failed.
4. If red: read `FIRST FAIL CHECK #N` off the screen and map N to the failing `Check(` call.

**Two harnesses (split 2026-07-04 when `harness.c` hit ~2600 lines):**
- `harness.c` / `harness.v32` — **FROZEN cumulative regression baseline** (all green through
  the restitution + stacking slices). Rebuild + run periodically to confirm no regression.
- `harness2.c` / `harness2.v32` — **active-development suite**; new-slice checks go here so
  iteration edits a small file. Self-contained scaffolding (own `Check`/`feq`/`ShowInt`/
  `ShowFloat`/verdict), same port `#include`s. Run this while iterating a slice.
Both share `port/*.h`; a change to a port header must keep BOTH green.

Do **not** build font/number display or autonomous readback (memcard/DebugLog are dead ends for this — see dialect doc). Green/red + bisection is the contract.

## The dialect rules that bite (full detail in VIRCON32_C_DIALECT.md)

Empirically confirmed against the real compiler — **these are hard errors, not warnings**:
- **No multi-word struct by value across a function boundary.** Params and returns must be ≤ 1 word. `b2Vec2`/`b2Rot`/`b2Transform`/`b2Mat22`/`b2AABB` are all > 1 word.
- **No ternary `?:`** → rewrite as `if/else`.
- **No compound literals `(T){...}`** → named temp + field assignments.
- **No `#pragma once`** → include guards (`#ifndef X_H / #define X_H / #endif`).
- **No `#if`/`#elif`, no `#`/`##`, no variadics, no `char`/`double`/`unsigned`/64-bit ints.**
- **`union` IS supported as a NAMED type** (p11 re-probed 2026-07-18 — the original "no
  union" verdict only tested the still-unsupported *anonymous inline* member form
  `union { ... } u;`). `union U { ... };` + `U u;` compiles with true overlaid storage.
  `b2JointSim` was CONVERTED to `union b2JointPayload` (`sim->u.<type>Joint`) 2026-07-19,
  shrinking it 212 → 63 words — all ROMs green. Public joint API unchanged (handle-based
  setters unaffected); NOTE a wrong-type setter now corrupts the active payload
  (upstream hazard; upstream asserts, port omits).
- Memory is **word-addressed**: `sizeof` and `memcpy`/`memset` count 32-bit **words**, not bytes.
- `NULL == -1` (not 0). `>>` is logical. No sci-notation float literals. **No `f` suffix** (`2.0f` → error — strip it).
- **Float literals < ~1e-6 silently underflow to 0.0** (lexer AND folder). `FLT_EPSILON` (1.19e-7)
  becomes `0.0` → broke a guard into a divide-by-zero. Produce tiny constants via runtime
  division by a **global**: `float b2_two_pow_23 = 8388608.0; #define FLT_EPSILON (1.0/b2_two_pow_23)`.
  See dialect doc §15.5. Literals ≥ ~1e-3 are fine.
- **Performance model is UNUSUAL — read dialect doc §16 before optimizing.** 1-cycle
  FMIN/FMAX/FABS/POW/FDIV; **no cache** (SoA/locality = zero speed); struct `a = b` is hardware
  MOVS (1 cyc/word); but **function calls cost ~10+2·nargs instr** (`b2MaxFloat`→`fmax`→FMAX
  = 28 instr for 1 instr of work) — call elimination + algorithms are the ONLY levers.
  Statement-level `asm{}` intrinsics are viable (§9.1, probe p13): `{var}` interpolates read
  AND write positions, float immediates OK, plain variable names only.

## Porting conventions (mirror the official `vector2d.h` idiom)

- A function that upstream **returned a struct** becomes `void`, taking a **result OUT-pointer
  as its LAST argument**: `b2Vec2 b2Add(b2Vec2 a, b2Vec2 b)` → `void b2Add(b2Vec2* a, b2Vec2* b, b2Vec2* result)`.
- **Scalars** (`float`/`int`/`bool`, 1 word) are still **returned by value**.
- Nested upstream expressions (`b2Add(a, b2MulSV(s,v))`) get **unrolled with named temporaries**.
- Headers carry **full implementations** (no linker / single translation unit). Guard every header.
- Use the console `math.h` names: `sqrt` not `sqrtf`, `fabs`/`fmin`/`fmax`, `atan2`, etc.
- `B2_ASSERT`/validation: omit or no-op for now.

## Status (as of 2026-07-04 — functional physics: fall, collide, rest, friction, restitution)

Toolchain + human-in-the-loop verify loop proven end-to-end. Each module below was built,
run on the emulator (clean halt), and **VERIFIED GREEN** by the user. The harness
(`harness.c`) is the cumulative regression suite — **~520 `Check()` cases, all green**
(trust the harness's own `TOTAL CHECKS` readout, not this number). The harness also numbers every check and, on RED, prints
`FIRST FAIL CHECK #N` / `TOTAL CHECKS M` via the BIOS font (`ShowInt`/`ShowFloat`, no
assets) — report N and map it to the failing `Check(` call instead of bisecting.

### ✅ Done & verified green
| Port header | Covers | Notes |
|---|---|---|
| `b2_math.h` | all of `math_functions.h` (~90 fns) + globals, length units, `b2WorldTransform`, `b2CrossVS/SV`, `FLT_*` | full |
| `b2_constants.h` | `constants.h` | full |
| `b2_collision.h` | all shared data types (shapes, proxy, mass, cast in/out, hull, simplex, distance in/out) | grows per module |
| `b2_aabb.h` | `aabb.c` (perimeter, enlarge, offset, validity, ray cast) | full |
| `b2_geometry.h` | `geometry.c` **slices 1+2**: box makers, `b2MakePolygon`, mass (circle/capsule/polygon), shape AABBs, point-in-circle/capsule; **slice 2 ray casts** `b2RayCastCircle/Capsule/Segment/Polygon` (verified green: side hits, miss, maxFraction cutoff, initial overlap, capsule endpoint-cap, one-sided cull); **`b2MakeOffsetPolygon`/`b2MakeOffsetRoundedPolygon`/`b2TransformPolygon`** (place/rotate polys, green). **Polygon radius>0 ray branch DONE (2026-07-10)** via `b2ShapeCast`; **+`b2ShapeCastCircle/Capsule/Segment/Polygon`**. | partial |
| `b2_hull.h` | `hull.c` (quickhull, recursive, validate) | full |
| `b2_distance.h` | `distance.c` **slices 1-4**: `b2SegmentDistance`, proxies, **full GJK `b2ShapeDistance`**, `b2PointInPolygon`, **`b2TimeOfImpact`** (CCD core), **`b2ShapeCast`** (conservative advancement, 2026-07-10 -- NOTE: hit fraction stops one `B2_LINEAR_SLOP` SHORT of geometric contact) | near-complete |
| `b2_manifold.h` | `manifold.c` **slices 1+2a+2b**: all circle collisions, `b2CollideCapsules`, `b2CollidePolygons` (SAT + `b2ClipPolygons` clipping), `b2MakeCapsulePolygon`, all segment/polygon/capsule wrappers, `B2_MAKE_ID`. **+ ALL chain-segment variants** (circle 2026-07-09; capsule + polygon 2026-07-10: `b2ClassifyNormal` ghost Gauss-map + `b2ClipSegments` + `b2CollideChainSegmentAndPolygon`/`AndCapsule`, cold `b2SimplexCache`). Remaining: vertex-vertex override test | near-complete |
| `b2_ctz.h` | `ctz.h`: `b2CTZ32`/`b2CLZ32` (pure-C reimpl), `b2IsPowerOf2`, `b2BoundingPowerOf2`, `b2RoundUpPowerOf2`. 64-bit variants deferred (bitset rework) | partial |
| `b2_core.h` | minimal `core.h`/`core.c`: allocator (`b2Alloc`/`b2AllocZeroInit`/`b2Free`/`b2GrowAlloc` → `misc.h` malloc family), `B2_NULL_INDEX`. Atomics/SIMD/platform omitted (add atomics when the serial scheduler needs them) | partial |
| `b2_dynamic_tree.h` | `dynamic_tree.c` **slice 1**: node pool, create/destroy, `b2FindBestSibling`, insert/remove leaf, proxy create/destroy/move, accessors, `b2DynamicTree_QueryAll`. **+`b2DynamicTree_RayCast`** (2026-07-04): segment-AABB walk + separating-axis prune + nearest-child-first; `float(...)*` callback shrinks maxFraction; `b2TreeStats` out-ptr; uint64 maskBits→int. Deferred: `b2RotateNodes` balancing, `EnlargeProxy`, box cast, `Rebuild`/SAH, validate | partial |
| `b2_id_pool.h` | `id_pool.{h,c}`: `b2CreateIdPool`/`Destroy`/`b2AllocId`/`b2FreeId`/`b2GetIdCount`/`b2GetIdCapacity`. Free list hand-rolled as a growable `int*` (upstream's `b2Array` macro uses `##`) | full |
| `b2_arena_allocator.h` | `arena_allocator.c` (b2Stack): bump allocator `b2CreateStack`/`Destroy`/`b2StackAlloc` (heap fallback)/`b2StackFree` (LIFO)/`b2GrowStack`/getters. Word-sized; SIMD-align + `char*`/`name` dropped | full |
| `b2_shape.h` | `shape.c` **slices 1+2**: `b2ComputeShapeAABB`/`b2ComputeShapeMass`/`b2ComputeShapeExtent` (type dispatch → geometry); `b2Shape` now carries id/bodyId/prev+nextShapeId/generation; `b2ShapeId`, `b2ShapeDef`+`b2DefaultShapeDef`, `b2ShapeArray`. Still deferred: material/filter, AABB/fatAABB caches, proxyKey, sensorIndex, localCentroid, event flags, the chainSegment case | partial |
| `b2_body.h` | `body.c`/`body.h` **slices 1+2** (FIRST world-bearing module): minimal `b2World` (5 fields create touches + 3 standing solver sets), `b2GrowArray` generic array helper (replaces container.h `##` macros), `b2CreateBody` (static/awake/disabled), `b2DestroyBody` + `b2RemoveBodySim` (swap-last-into-slot + repair moved body's `localIndex`; parallel `bodyState` remove-swap for awake; id freed with generation preserved), accessors (`b2GetBodyTransform`/`Quick`/`Sim`/`State`, `b2MakeBodyId`, `b2GetBodyFullId`), `b2DefaultBodyDef`. Sparse `b2Body`↔dense `b2BodySim`/`b2BodyState` indirection (`setIndex`+`localIndex`) intact. `b2BodyId` 3-word, out-pointer. **slice 3:** `b2World` gained `shapeIdPool`+`shapes`; `b2CreateShapeInternal`+`b2CreateCircleShape`/`b2CreatePolygonShape` (link shape onto body's `headShapeId` list), `b2UpdateBodyMassData` (two-pass, no scratch — `b2ComputeShapeMass` is pure), `b2DestroyShape`+`b2GetShape` (list unlink + headShapeId fixup + free id + mass recompute). **slice 3c:** shape create/destroy now insert/remove a broad-phase proxy (shape AABB at body transform → tree for body type), storing `shape->proxyKey`. Deferred: islands (stubbed no-op), sleeping-set create/empty-cleanup (untested), contact/sensor teardown, dirtyMass sync, MoveProxy on body move | partial |
| `b2_contact.h` + `b2_body.h` + `b2_collision.h` (contacts) | `contact.{c,h}` **slices 1+2**. **s1 (connectivity):** `b2ContactEdge`, cold `b2Contact`, `b2CanCollide`, `b2ContactEdgeAt` (constant-index edge selector — `edges[2]` fixed array member). In `b2_body.h`: `b2CreateContact`/`b2DestroyContact` (edge lists + `pairSet`), `b2PairQueryCallback` + `b2UpdateBroadPhasePairs`. **s2 (NARROW PHASE):** solver-side `b2Manifold`/`b2ManifoldPoint` in b2_collision.h (warm-start fields zeroed); `b2ContactSim` (manifold + invMass/friction/restitution + simFlags) in dense `set->contactSims` (added to `b2SolverSet`, init+free at all sites); `b2CreateContact` emplaces a zeroed sim (sets `localIndex`) + flips shapes to **primary order**; `b2DestroyContact` swap-removes the sim + repairs moved owner; `b2GetContactSim`. Dispatch: `b2ShapeCollisionRank`+`b2IsPrimaryOrder` (encodes the 12 `b2AddType` regs — **segment outranks polygon**, rank≠type) + `b2ComputeManifold` (if/else type-pair → green collide fns, **no fn-ptr table**); `b2UpdateContact` (world-free; marshals frame-A local manifold → world `b2Manifold`, COM-relative anchors, sets/clears `b2_simTouchingFlag`; constant-index unroll of the ≤2 points). Chain-segment dispatch complete (circle/capsule/polygon, 2026-07-10). Deferred: friction/restitution callbacks (Box2D defaults), id-matched warm start, speculative-trim, pre-solve/hit/contact events, filters/sensors/joints, constraint-graph color branch of `b2GetContactSim` | near-complete |
| `b2_body.h` (world query/move) | **slice 3d:** `b2World_OverlapAABB` — query all 3 broad-phase trees with one callback, accumulate `b2TreeStats`. DEVIATION: callback uses the tree's raw `(proxyId, shapeId, context)` signature (b2ShapeId is multi-word, can't pass by value); query filtering deferred. **slice 3e:** `b2Body_SetTransform` — update bodySim transform/center + `MoveProxy` each attached shape. **RAYCAST (2026-07-04):** `b2World_CastRayClosest(world, origin, translation, out)` → returns hit shapeId + world-space `b2CastOutput` (closest hit). Queries all 3 trees via `b2DynamicTree_RayCast`; the `float(b2RayCastInput*,int,int,void*)*` callback transforms the ray into each shape's local frame (`b2InvTransformPoint`/`b2InvRotateVector`), runs the shape ray cast, maps hit point/normal back to world, shrinks maxFraction to the closest. Verified green incl. closest-of-two + non-identity rotation. DEVIATIONS: query filter deferred; only closest returned (no all-hits callback); rounded polygons miss | partial |
| `b2_bitset.h` | `bitset.{c,h}` (full): `b2CreateBitSet`(out-ptr)/`Destroy`/`SetBitCountAndClear`/`GrowBitSet`/`InPlaceUnion`/`CountSetBits` + `b2SetBit`/`SetBitGrow`/`ClearBit`/`GetBit`. **64-bit→32-bit block rework** (one of the big three): blocks are 32-bit `int` words not `uint64_t` (/64→/32). `~` and `1<<31` confirmed to compile. Kernighan popcount replaces `b2PopCount64` | full |
| `b2_table.h` | `table.{c,h}` (full): open-addressing hash set. **uint64 key reworked to int PAIR** — API specialized to `b2AddKey`/`b2RemoveKey`/`b2ContainsKey`(set, int a, int b), canonicalized (min,max) inside; empty sentinel (0,0), occupied = `key1\|\|key2`. 32-bit fmix hash (sign-bit hex literals `0x85ebca6b`/`0xc2b2ae35` compile fine). Backward-shift deletion ports verbatim (pure int compares) | full |
| `b2_solver.h` | `solver.c` + `contact_solver.c` **integration + step pipeline + CONTACT SOLVE** (functional physics — a body falls, collides, rests): `b2IntegrateVelocities` (gravity·gravityScale + Padé damping; `invMass>0` guard), `b2IntegratePositions` (accumulate `deltaPosition`/`deltaRotation`), `b2FinalizeBodies` (fold deltas → `center`/`q`, recompute `transform.p`, **+MoveProxy**). **Constraint solve (normal impulse only, no graph):** `b2Softness`/`b2MakeSoft`, `b2ContactConstraint`/`Point`, `b2PrepareContacts` (from awake touching contactSims; static-stiffer softness), `b2WarmStartContacts` (normal+tangent), `b2SolveContacts` (speculative + soft bias push-out, accum-impulse clamp ≥0) **+ `b2SolveFrictionPoint` (friction cone, relax pass only)**. `b2Solve` = prepare → substep loop (int-vel → warm-start → solve-bias → int-pos → relax+friction) → finalize. `b2World_Step` = `pairing → collide → b2Solve`. Added `b2World.gravity`(0,−10)/`contactHertz`30/`contactDampingRatio`10/`contactSpeed`3. Write-back gated on `index!=NULL`; dummy static state `deltaRotation=identity`; point loops constant-index unrolled; friction=0.6 default. Deferred: **restitution, rolling, cross-step warm-start store, islands, constraint graph/coloring, sleeping, sub-step speed cap, motion locks, continuous/TOI, move events** | partial |
| `b2_broad_phase.h` | `broad_phase.c` **slice 1** (sim-core↔broad-phase bridge): minimal `b2BroadPhase` = 3 body-type `b2DynamicTree`s (**heap array** `trees`, not a fixed member — variable index by body type would miscompile), `b2CreateBroadPhase`/`Destroy`, `b2BroadPhase_CreateProxy`/`DestroyProxy`/`MoveProxy` packing `[proxyId\|bodyType]` proxy keys (`B2_PROXY_KEY`/`_TYPE`/`_ID`). Also owns the body-type `#define`s. **slice 2 (move buffering):** `movedProxies` (heap `b2BitSet[3]`) + `moveArray` (int dyn array) + `b2BufferMove`/`b2UnBufferMove`/`b2BroadPhase_ClearMoveBuffer`, wired into CreateProxy (non-static only)/MoveProxy/DestroyProxy. INVARIANT: bit in movedProxies[type]@proxyId ⟺ key in moveArray. Deferred: movePairs/moveResults + pairSet + `b2UpdateBroadPhasePairs` (the pairing pass), validation | partial |

### ⏭️ Resume here — READ `PLAN_FOR_OPUS.md` **PART 0** (re-audit 2026-07-06 + ranked master plan)

**★★ GAME-FACING PACKAGING COMPLETE (2026-07-11) — `PLAN_VB2_API.md` all four slices DONE & GREEN.**
See memory [[vb2-facade]].
- **`virconbox2d.h`** — umbrella header (the 17 `port/b2_*.h` includes in one). `harness2.c` +
  `showcase.c` converted. `b2_validate.h` deliberately OUT (single TU → everything included ships).
- **`vb2.h`** — the game-facing facade: one implicit `vb2_world`, **1-word `int` handles**, scalars
  in/out, one shape per body. Creators/step/read/write/material + camera + queries + touch events
  (resolved to BODY handles) + `vb2_Pin`/`vb2_Rope`/`vb2_Motor`. `vb2_GetBodyId` is the escape hatch
  back to a real `b2BodyId`. Sugar, never a wall — `vb2_world` is a plain `b2World`.
- **`template.c`** → `bin/template.v32` (`bash build.sh template`): the copy-me starter game ROM.
- **Docs:** new `docs/vb2.md` (first link in the reference map); README quickstart is now the facade.
- **DEVIATION from the plan (important): facade handles pack the GENERATION, not the bare index.**
  `b2MakeBodyId`/`b2MakeJointId` stamp whatever generation the slot CURRENTLY holds, so a handle
  rebuilt from a bare index always validates — and once the freed slot is recycled by a later create
  it silently addresses a **different body**. Plain destroy IS caught (freed-slot marker), which is
  why the naive acceptance test passes and the bug stays invisible. Handle =
  `(gen & 0x7FFF) << 16 | index1` (bit 31 clear → `-1` unambiguous); resolve builds the `b2BodyId`
  directly and masks the generation compare to the stored 15 bits. harness2's slot-recycle check is
  the one that reds under the original scheme.
- Acceptance was a **twin-world equivalence group** (stronger than the plan's known-value test): the
  same scene built through `vb2_*` and through the raw `b2` API on a live twin world, stepped 90×,
  compared with `==` — so any def field or step size the facade silently changed would show.


**★★ THE ENGINE IS COMPLETE (2026-07-10).** `mover.c` was the last upstream module never begun.
What remains is **API surface** plus the deliberately-excluded modules (constraint_graph = serial
solver; scheduler/parallel_for = no threads; recording/world_snapshot = classified OUT).

**API AUDIT (2026-07-10):** started at 264 of 365 public `B2_API` fns missing. Reproduce with:
`grep -oE "\bb2[A-Za-z0-9_]+\s*\(" box2d/include/box2d/box2d.h | ... | comm -23 - <(port fns)`.

**★★ FULL-PORT PUSH COMPLETE (2026-07-10) — the entire PORTABLE public API surface is done &
GREEN both harnesses. See memory [[public-api-port]] for the full ledger.** 264 missing → 72,
and all 72 remaining are genuinely out-of-scope for the port model (NOT deferred work).
- Batches 1-5: `142333b` shape reads + userData · `986cd54` shape setters + body breadth + world
  tuning · `fecb0d8` b2Body_SetType/Enable/Disable (solver-set transfer) · `aaf9e07` ~65 joint
  accessors · `dadf77d` joint reaction forces (persisted world->inv_h) · `9a2b003` batch 5 joint
  geometric queries (GetCurrentLength/GetSpeed/Get*Separation).
- Closing batches: `21c8537` cleanup trio (b2Shape_RayCast, b2World_GetBounds, b2Shape_GetClosestPoint)
  · `1d23e8c` all-hits b2World_CastRay/CastShape + b2World_OverlapShape + b2World_Explode +
  contact/sensor enumeration + b2Shape_AreContactEventsEnabled (+ b2GetShapeCentroid/ProjectedPerimeter
  helpers) · `ed5bfc6` b2ContactId handle + b2Contact_GetData/IsValid.
- **The 72 OUT (all documented deviations, do NOT count against 100%):** recording/snapshot (~30),
  chain aggregate (`b2Chain_*`/`b2ChainShape`, port has plain `b2CreateChain`), surface/user
  materials + `ApplyWind`, threading (`*WorkerCount`), contact recycling + `EnableSpeculative`,
  `RebuildStaticTree`, tooling (`Draw`/`GetProfile`/`GetCounters`/`GetMaxCapacity`/`DumpMemoryStats`),
  callback setters (`Set*Callback`), aggregate event getters (`Get*Events` — port uses per-kind poll
  count/get accessors instead), pre-solve events, `char` names, `*_GetWorld`/`b2World_IsValid`
  (port threads `b2World*`, no `b2WorldId` — use `b2ValidateWorld` for structure).

**★ NOTHING PORTABLE REMAINS.** The port is engine-complete AND API-complete for the Vircon32
model. Next work is elsewhere: the deliberately-excluded structural modules (constraint_graph /
scheduler / recording / world_snapshot), or game-facing packaging (amalgamated header, demo ROMs),
or perf — NOT more API breadth.

| Slice | Commit | What |
|---|---|---|
| chain vs polygon/capsule | `ca002e3` | ghost Gauss-map; boxes/capsules ride chain terrain |
| bullet vs dynamic/kinematic | `ca002e3` | deferred post-finalize CCD pass |
| `b2ShapeCast` | `1d59cf3` | last collision primitive; unblocked rounded-polygon ray cast |
| `b2World_CastShapeClosest` | `b1bc95c` | + `b2DynamicTree_BoxCast` |
| mover / character controller | `f07e38c` | `b2SolvePlanes`/`b2ClipVector` + collide/cast mover |
| query filters | `3c4b6c5` | `b2QueryFilter` through all 5 world queries |
| **shape API slice 1** | `142333b` | **pure reads + userData — unblocks the whole event surface** |

**★ SHAPE API SLICE 1 — done & GREEN both harnesses (2026-07-10, `142333b`).** There were **zero**
`b2Shape_*` fns. Every event/query surface hands back a **raw `int` shape id** (`b2ShapeId` is
multi-word → can't cross a fn boundary by value): touch/hit/sensor events, the `OverlapAABB`
callback, the `Cast*` hit records. So a game could see that *something* was hit but never identify
*what* — sensors and touch events were **dead on arrival from the game side**. Also fixed a
**silently dropped field**: `b2ShapeDef.userData` was init'd by `b2DefaultShapeDef` and copied by
`b2CreateChain`, but `b2Shape` had no `userData` member to store it in.
Added (in `b2_body.h`, where `b2GetShape` lives): `b2MakeShapeId` (raw int → generation-checked
handle), `b2Shape_IsValid`, `b2Shape_GetBody`, `GetType`, `GetDensity`/`GetFriction`/`GetRestitution`,
`GetFilter`, `IsSensor`, `AreSensorEventsEnabled`, `AreHitEventsEnabled`, `GetAABB`, the 5 geometry
getters, `TestPoint`, `Get`/`SetUserData`.
- **DEVIATION `b2Shape_GetAABB` recomputes** the tight AABB instead of returning `shape->aabb` like
  upstream: this port **pads that field by `B2_SPECULATIVE_DISTANCE`** (it doubles as the `b2Collide`
  disjoint early-out box), so the field would hand the game a box larger than the shape — and the
  fat-AABB proxy skip can leave it a step stale.
- **DEVIATION** no `b2Shape_GetWorld` (port threads `b2World*` explicitly, no `b2WorldId`).
- **Struct grew** (`b2Shape.userData`) → `harness.c` (frozen) was re-run green, not just harness2.
- Acceptance was a **dogfood**, not a round-trip: drop a box on a floor → catch the begin-touch
  event → resolve its raw `shapeIdA/B` through `b2MakeShapeId` → `b2Shape_GetBody` →
  `b2Body_GetUserData`, asserting shape tags and body tags agree. (A getter round-trip alone would
  not show the event path is usable.) Touch events are **ungated** by any per-shape flag — verified.

Two traps worth carrying forward: **`b2ShapeCast`'s hit fraction stops one `B2_LINEAR_SLOP`
SHORT of geometric contact** (hand-compute with that offset or a correct impl looks broken), and
**`b2SolvePlanes`' anti-jitter slop follows the plane NORMAL, not the axis** (normal `-x` settles
at `+0.005`). Also: proxy creation used to hardcode tree `categoryBits = 1` — a constant that was
invisible until filters first gave the parameter meaning.

**★ BOTH TIER-1 TAILS CLOSED — done & GREEN both harnesses (2026-07-10).**
- **Chain vs polygon/capsule** (`b2_manifold.h`): `b2CollideChainSegmentAndPolygon` — ghost
  Gauss-map (`b2ClassifyNormal`: skip/admit/snap) + `b2ClipSegments` + SAT with neighbour
  culling; `b2CollideChainSegmentAndCapsule` wraps it (capsule → rounded 2-gon). Wired into
  `b2ComputeManifold`. Boxes and capsules now roll/slide over chain terrain without ghost
  catches. DEVIATION: the `b2SimplexCache` is COLD every call (the port keeps no persistent
  GJK cache — `b2UpdateContact` is SAT-based); costs GJK iterations, not correctness, but in a
  degenerate tie the feature ids (used for impulse warm-start) can flip between steps.
  Dialect: used the attested-green `b2Polygon localPolyB; b2Polygon* lpB = &localPolyB;`
  pointer idiom rather than upstream's local `vertices[]`/`normals[]` arrays.
- **Bullet vs dynamic/kinematic** (`b2_solver.h`): the deferred post-finalize pass. `b2FinalizeBodies`
  pass 1 flags a fast bullet `b2_isFast` (new transient flag) and `continue`s — skipping BOTH the
  `center0`/`rotation0` baseline advance and the proxy move; pass 2 re-walks the awake set and,
  for `isFast|isBullet`, runs `b2SolveContinuous` (now also querying the kinematic + dynamic
  trees) then `b2UpdateBodyProxies`. INVARIANT: the callback rejects other bullets, so every
  target is a finalized non-bullet with `center0 == center` — the degenerate stationary `sweepA`
  is exact, not an approximation. Also added upstream's `b2ShouldBodiesCollide` check (only
  reachable now that bullets can hit dynamic bodies). The per-body proxy-update block was lifted
  verbatim out of the finalize loop into `b2UpdateBodyProxies` so both passes share it — that
  lift is the ONLY always-on change (harness.c re-run green to prove it).
- STILL DEFERRED: sensor CCD hits, pre-solve events, core-circle `fraction==0` fallback,
  bullet-vs-bullet; `b2ChainShape` aggregate / `b2ChainId` / per-chain material arrays.

Phases A–E all green. **★ P0.1 + P0.2 + P0.3 + P0.4 done & GREEN (2026-07-07)** — committed
in the nested repo (`4602642` P0.1, `71534c5` P0.2, `e64b0fd` P0.3-under-"more body checks", P0.4 this session).

**★ P0.1 WAKE PLUMBING (F2/F3/F4):** shared `b2WakeBody(world,body)`;
`b2DestroyContact`/`b2DestroyJointInternal` honor `wakeBodies` (wake endpoints at END,
upstream order; contact wakes only when touching); `b2DestroyBody`/shape teardown pass
`true` (destroying a support wakes the sleeper); `b2Body_SetTransform` wakes at entry
(PORT DEVIATION — upstream doesn't, but the port never re-evaluates sleeping contacts);
`b2CreateJoint` wakes both endpoints before placement (vs upstream's sleeping-set
placement+merge); public `b2Body_Wake`/`b2Body_IsAwake`.

**★ P0.2 DISJOINT CONTACT DESTROY (F1, the #1 fix):** `b2Collide` now iterates
**BACKWARD** (destroy swap-removes from the iterated array — going backward, the
swapped-in element is always already-processed or wake-appended); after the both-non-awake
sleep skip it destroys the contact when the two shapes' **fat** AABBs no longer overlap
(upstream `b2_simDisjoint` path, `wakeBodies=false`). The speculative-`aabb` early-out
below it still KEEPS the contact (hysteresis band). Contacts no longer accrete forever as
a body travels. NOTE: this changed the contract of one frozen harness.c check (a separated
pair used to be kept non-touching → now destroyed; `b2GetContactSim` on the freed handle
faulted — the check was rewritten to assert destroy). Also restated the `b2_solver.h`
finalize MoveProxy-skip SAFETY comment.

**★ P0.3 EMPTY SLEEPING-SET CLEANUP (F5):** `b2DestroyBody` frees the solver set (id →
`solverSetIdPool`) when the last body of a **sleeping** set is destroyed. Narrow after
P0.1 (touching sleepers wake during teardown); the real leaker was a contactless sleeper.

**★ P0.4 VALIDATE + SOAK (2026-07-07):** new `port/b2_validate.h` — `b2ValidateWorld(world)`
returns 0 clean, else a nonzero CODE for the first broken invariant (map in the header). A
reduced port of upstream `b2ValidateSolverSets`/`b2ValidateConnectivity`: id-pool-capacity ==
array-count; dense-per-set round-trips (bodySim/contactSim/jointSim/islandSim → cold record
setIndex+localIndex); dense totals == pool live counts; `pairSet.count == totalContacts`;
forward round-trip + contact/joint edge-list doubly-linked consistency. **Cut** (would false-red
on the port): constraint-graph/color block (no graph), `syncedFlags` mirror, `awakeSet.jointSims==0`
(port parks touching joints there). harness2.c gained the P0.4 group: TEETH tests (corrupt one
field → assert the matching code 22/88/70 fires → restore → re-assert clean, proving the walker
detects, not just returns 0) + a 1k-step mixed soak (12 traveling boxes settle+sleep, joint
create/destroy, mid-soak body destroy) validating EVERY step into a single Check (first fail →
`diagC`=step/`diagD`=code). Header is harness2-only; harness.c (frozen) untouched.

**★ NEW TRACK — PORTING BOX2D'S OWN UNIT TESTS (2026-07-07, user pivot).** User redirected
from P1: **port 100% of Box2D + its tests first; skip API work with no upstream equivalent.**
New ROM `boxtests.c`/`.xml` (`bash build.sh boxtests`) ports `box2d/test/*.c` (Erin Catto's unit
tests) onto the green/red contract — the canonical port-vs-Box2D check. Principle: port a test →
port whatever engine fns it exercises → green → next (tests PULL IN engine functions; the deferred
P1.1 body API gets ported when WorldTest needs it, not as a standalone slice). **7 suites GREEN,
16905 checks:** BitSet, Distance, Collision, Math (+ ported b2ComputeRotationBetweenUnitVectors &
world-pos helpers into b2_math.h), DynTree, Shape, Table. Gotchas: `HW_EPS=1e-4` for FDIV/pi/sqrt-
derived checks (console FDIV not bit-exact IEEE; FLT_EPSILON too tight); `atan2(0,0)` HARDWARE-FAULTS
(skip that sample); sampling loops coarsened 0.01→0.1. OUT (deviations): IdTest (uint64 id-packing),
Recording/Snapshot/Thread (unported/serial). **NEXT: WorldTest** (large — pulls in body API),
**ContainerTest** (adapt to b2GrowArray), then **read+classify DeterminismTest** (same-run repro may
pass on-console). Per-slice commits in the nested repo (HEAD = TableTest). See memory [[boxtests-port]].

Deferred (pre-pivot P-plan, resume after tests): **P1.1 game-facing body API**, filters (P1.2),
begin/end-touch events (P1.3), **P2.1 `b2SplitIsland`**. Findings F1–F9 with anchors + acceptance
tests are in PLAN_FOR_OPUS.md Part 0. See memory [[phase-c-islands-sleep]].

**★ Phase C islands + SLEEPING + WAKING — ALL GREEN (2026-07-05).** Bodies fall, settle, an
island falls asleep (migrates out of the awake set, solver skips it), and a collision from an
awake body WAKES the sleeping island (it knocks the pile, re-settles, re-sleeps). `b2WakeSolverSet`/
`b2DestroySolverSet` in `b2_body.h`; INLINE wake in `b2Collide` (wake only APPENDS to awake arrays
-> refetch `contactSim` after; no deferred queue). WAKE-MOMENTUM FIX: after waking, refetch
bodySimA/B + re-cache `bodySimIndexA/B`+masses so the woken body is solved as dynamic THAT step
(else the wake-step impulse is dropped -> a wrecker bounces off without moving the pile).
`sleep_demo.v32` shows the full wake<->sleep cycle. DEFERRED: C3 `b2SplitIsland` (finer islands
-- a bounced wrecker currently stays in the pile's island forever), kinematic-body sleep,
joint-onto-sleeper wake, API wakes (SetTransform/ApplyForce), and a `perf.v32` cycle-payoff run.

**★ Phase C (islands → sleeping), C1 + C2a GREEN (2026-07-05).** MERGE-ONLY islands (defer
`b2SplitIsland`), NO constraint graph (touching contacts/joints stay in `awakeSet` arrays →
sleep migration is a plain dense-array move). **C1:** new `port/b2_island.h` types + island fns
in `b2_body.h` (`b2CreateIsland`/`Merge`/`LinkContact`/`LinkJoint`/`CreateIslandForBody`/…),
wired into body create/destroy + `b2Collide` touch-transition + joint create/destroy;
`b2SolverSet.islandSims` + `b2World.islandIdPool/islands/splitIslandId/enableSleep`. Sim-invariant.
**C2a:** `b2FinalizeBodies(world,dt,inv_dt)` accumulates per-body `sleepTime`; `b2UpdateSleep`
(end of `b2Solve`, backward-iterates awake islandSims) → `b2TrySleepIsland` migrates a settled
island (all members dynamic + `sleepTime≥0.5`) into a fresh sleeping solver set; `b2Collide`
skips both-non-awake pairs. **`world.enableSleep` defaults OFF** (PORT DEVIATION — keeps the
frozen suite bit-identical; opt in with `=true`). Demo: `bin/sleep_demo.v32` (pile settles →
"[]"awake/"zz"asleep + live tally + step-cyc drop). **RESUME AT C2b (wake):** the deferred-wake
queue — `b2Collide`→`b2LinkContact`→`b2WakeSolverSet` reallocs the array `b2Collide` is iterating;
collect wake requests, process after the loop. Implement real `b2WakeSolverSet` + `b2DestroySolverSet`.
Then C3 = `b2SplitIsland`. Perf payoff (sleeping bodies skip solve) is a separate `perf.v32` measure.

**★ Phase E JOINTS COMPLETE — DONE & GREEN both harnesses + joint_demo (2026-07-05).** All 8 Box2D-v3
joint types: distance / revolute / prismatic / weld / wheel / motor / **filter** (+ the 5-type solver base).
FINISHING PASS: (1) **joint teardown** in `b2DestroyBody` (walk `headJointKey`, before contacts/shapes) —
closes the dangling-edge fault; (2) **collideConnected ENFORCED** both halves (`b2DestroyContactsBetweenBodies`
in `b2CreateJoint` + `b2ShouldBodiesCollide` in the pair query); (3) **distance spring + limit + motor** all
in `b2SolveDistanceJoint(world,base,h,inv_h,useBias)` (upstream gate; rigid `else` bit-identical → no
regression); (4) **MOTOR JOINT** (`b2_motorJoint`: relative lin/ang velocity drive, force/torque-capped, +
optional springs; `b2Mat22 linearMass` cached). COMPLETION PASS: (5) **generation-checked `b2JointId`**
handle (`{index1,world0,generation}`, out-pointer return from the 6 public `b2Create*JointDef`; `b2MakeJointId`/
`b2Joint_IsValid`/`b2DestroyJoint(b2JointId*)`; internal int creators kept as plumbing — handle path reuses
`b2GetJointSimById(id->index1-1)` since `b2GetJointSim(b2Joint*)` already exists & no overloading); (6) **filter
joint** (no payload/solve — dispatchers skip it; suppression via the collideConnected path); (7) **runtime
setter/getter API** — `b2Joint_GetType`/`Set|GetCollideConnected` + per-type `Enable*`/`Set*` (motor/limit/
spring, distance length/range, weld hertz, motor targets) + geometric getters `b2RevoluteJoint_GetAngle`/
`b2*Joint_GetTranslation`/`b2DistanceJoint_GetLength` (reaction-FORCE getters skipped — `world` doesn't
persist `inv_h`). Setters are uniform pokes into the NAMED member (no union → no type guard needed).
DEFERRED (not joint-specific gaps): joint island/sleeping participation (Phase C — sleeping unimplemented),
joint events / reaction-force queries (need persisted `world->inv_h`).
`b2World_Step` = pairing → collide → solve (TGS-soft: normal + friction + restitution + warm start,
speed cap + motion locks, **+ joints**) → finalize. Bodies fall, collide, rest, bounce, stack
(3-high), destroy cleanly, **and hang/swing from rigid distance joints**. **Phase A + B green.**

**★ Phase E — JOINTS (new module `port/b2_joint.h`), 2 slices green (2026-07-05):**
- **Slice 1 (connectivity):** `b2Softness`/`b2MakeSoft` RELOCATED from `b2_solver.h` → `b2_joint.h`
  (so `b2JointSim` embeds it ahead of `b2_body.h`, mirroring `b2ContactSim` in `b2_contact.h`;
  solver gets them back transitively). Types: `b2JointEdge`, cold `b2Joint` (island fields stub NULL),
  dense `b2JointSim` with an EMBEDDED `b2DistanceJoint` (NO union — dialect-unattested; probe or add
  named member for the 2nd type), `b2JointEdgeAt` constant-index selector. `b2SolverSet.jointSims` +
  `b2World.jointIdPool/joints`. `b2CreateJoint`/`b2DestroyJointInternal`/`b2CreateDistanceJoint`/
  `b2GetJointSim` in `b2_body.h` mirror the contact create/destroy pattern (`(jointId<<1)|edge` keys,
  swap-remove-repair). Set placement: either-disabled→disabled, neither-dynamic→static, else awake.
- **Slice 2 (solve, RIGID):** distance prepare/warm-start/solve + `b2Prepare/WarmStart/SolveJoints`
  dispatchers, wired into `b2Solve` BEFORE contacts each stage (order per `box2d/src/solver.c` serial
  path). No `b2StepContext` (world/h/inv_h explicit; states=awakeSet->bodyStates; identity dummy for
  static gated on `index==NULL`). `constraintHertz=60`/`damping=2.0`; hertz clamped `0.25*inv_h`/step.
  Verified: vertical length-hold + pendulum (length invariant mid-swing, settles straight down).
- **Revolute (hinge, point-to-point) — green (2026-07-05):** `b2RevoluteJoint` payload +
  `b2CreateRevoluteJoint` + `b2Prepare/WarmStart/SolveRevoluteJoint` (2×2 K-matrix via `b2Solve22`),
  dispatched via the joint type-switch. Local-frame ORIGINS = pivot on each body. Verified: pivot
  stays glued to anchor across a swing (hinge invariant) + arm settles hanging straight down.
- **Weld (rigid bind) — green (2026-07-05):** `b2WeldJoint` + `b2CreateWeldJoint` +
  `b2Prepare/WarmStart/SolveWeldJoint`. Revolute's 2×2 linear block + a scalar angular-lock (non-block
  `#else` path). Rigid when hertz=0 (springs = constraintSoftness); soft-weld path coded. Verified:
  a box welded at its edge to a static anchor stays put (no swing, no rotation) under gravity.
- **Prismatic (slider) — green (2026-07-05):** `b2PrismaticJoint` + `b2CreatePrismaticJoint` +
  `b2Prepare/WarmStart/SolvePrismaticJoint` + `b2PrismaticAxis`. Core 2×2 block on [perp-translation,
  relative-angle] (slides along frameA local +x, locks cross-axis + rotation). Deferred: axial spring/
  motor/limit. Verified: horizontal slider holds a body up vs -y gravity while it slides on +x.
- **Revolute motor+limit+spring — green (2026-07-05):** extended `b2SolveRevoluteJoint` with spring
  (target angle), motor (target speed, `h·maxTorque` cap), angle limits (lower/upper, `inv_h` speculation),
  gated on enable* flags. `h`/`inv_h` threaded through `b2SolveJoints`. Set fields on the jointSim to
  enable (public setters deferred). Verified: motor spins a box to ~2 rad/s; limit catches an arm at -0.5.
- **Prismatic motor+limit+spring — green (2026-07-05):** extended `b2SolvePrismaticJoint` with axial
  spring (target translation), motor (target speed, `h·maxForce` cap), limit (lower/upper translation,
  speculative, one-sided) + `a1/a2/axialMass`; gated on enable*. Verified: limit catches a vertical
  slider at translation 3 (y=7); motor drives a horizontal slider to ~3 m/s.
- **Wheel (suspension) — green (2026-07-05):** `b2WheelJoint` + `b2CreateWheelJoint` + prepare/warmstart/
  solve: perp line constraint + axial spring + rotation motor + limits, FREE rotation. Verified: wheel
  slides to limit + motor spins it freely.
- **Dynamic-dynamic coverage — green (2026-07-05, advisor catch):** all prior joint tests used a STATIC
  body A (invMassA=0 -> A-side impulse code never ran). Added dyn-dyn distance (momentum transfer) +
  dyn-dyn weld (rigid pair) tests. A-side now exercised.
- **Public def-based API + demo — green (2026-07-05):** `b2*JointDef`+`b2Default*JointDef`+
  `b2Create*JointDef(world, def*)` (b2BodyId-keyed) for all 5 types + `b2GetJointSimById` +
  `b2DestroyJoint(world, jointId)` in b2_body.h. `joint_demo.c`/`.xml` -> `bin/joint_demo.v32` (live
  revolute rope + motorized bar via the def API).
- ✅ **KNOWN GAP RESOLVED (2026-07-05):** `b2DestroyBody` now tears down a body's joints (walk
  `headJointKey` → `b2DestroyJointInternal` each, before contacts/shapes). Soak-tested green. Also
  `collideConnected` is now ENFORCED (was stored-not-acted-on). Still deferred: runtime setter fns
  (`b2*Joint_Set*`) — games configure via the def at create, or poke the sim via `b2GetJointSimById`;
  and a generation-checked multi-word `b2JointId` handle (port returns a raw int id).
- **Dialect (probe p11, since CORRECTED 2026-07-18):** named unions ARE supported (only anonymous
  inline unions fail); `b2JointSim`'s payloads were converted to `union b2JointPayload` (`sim->u`)
  on 2026-07-19, all green. See the dialect list above.
- DEFERRED: per-joint motor/limit/spring branches (independent `if`s), islands/graph, collideConnected
  filter, force/events, def-based public API. Next = more joint types (prismatic→weld→wheel→motor) or
  the deferred motor/limit/spring branches, or a public `b2*JointDef` API, or a joint demo ROM.

**★ Phase B item 7 (PROFILER ROM) done & verified (2026-07-04):** `perf.c`/`perf.xml` →
`bin/perf.v32` steps 10/20/40 falling boxes, prints per-phase cycle counts via a
frame-boundary-safe monotonic clock (`frame*250000+cycle`, emulator runs a fixed 250k
cyc/frame). **Baseline:** 40 boxes = 1,516,650 cyc/step (606% of the 250k frame budget);
**SOLVE dominates ~78%** (COLLIDE ~16%, PAIRING ~6%); cost ~linear in body count. Full table
+ reading in PLAN_FOR_OPUS.md §6 item 7. Rerun perf.v32 after each perf change to compare.
**★ Phase B item 9 (§5.5 persistent solver scratch) done & verified green (2026-07-04):**
`b2World.constraintScratch`(void*)/`constraintScratchCapacity`; `b2Solve` reuses a grow-only
scratch (no per-step `b2Alloc`/`b2Free`), freed in `b2DestroyWorld`. Both harnesses green.
Measured **−195 cyc/step, CONSTANT across 10/20/40 boxes** → the console malloc walk is only
~195 cyc, so heap traffic was never a real cost (kept for anti-fragmentation, not cycles).
**§5.7 (const precompute) DEPRIORITIZED** — floats are host-speed on the emulator, so it saves
even less than §5.5 (noise); fold into §5.6 or defer to a real-console build.
**★ Phase B item 10b (§5.6 inline the solver hot path) done & verified green (2026-07-04) — THE lever.**
Inlined vector-helper CALLS as field-explicit SCALAR math (no macros; generic b2Vec2 helpers stay as
the readable library) in the contact-solve hot path: `b2SolveNormalPoint`(2×/substep)/`b2SolveFrictionPoint`/
`b2WarmStartPoint`/`b2ApplyRestitutionPoint` + per-contact `b2RightPerp`/`b2Sub`. Pure refactor
(bit-identical), both harnesses green. **SOLVE dropped −31% (−359,840 cyc/step at 40 boxes, −23.7% of
the whole step; 40-box frame % 606→462).** New baseline in PLAN_FOR_OPUS.md §6 item 10b.
**§5.7 const-precompute DEPRIORITIZED** (floats host-speed → noise; fold into a real-console build).
**★ Phase B §5.6 COLLIDE inlining done & verified green (2026-07-04):** inlined `b2FindMaxSeparation`
(4×4 inner loop, 2×/collide) + all of `b2ClipPolygons` as scalar math on LOCAL copies (dialect-safe:
only the attested-green whole-struct variable-index copy `b2Vec2 v2 = poly2->vertices[j]`, no new
`arr[j].x` value-index read). harness.c exact-value manifold group bit-identical green. **COLLIDE −28%
across sizes (−66,915 cyc/step at 40 boxes).** 40-box step now 1,089,700 (435% frame); 10-box 241,732
(96% — first scene under one frame). **Session cumulative: 40-box −28.1% (1,516,650→1,089,700).**
New baseline in PLAN_FOR_OPUS.md §6 item 10c.
**★ Phase B item 8 (§5.2 FAT AABBs) done & verified green (2026-07-04).** `b2Shape.fatAABB`+
`aabbMargin`; tree stores fat AABB; `b2FinalizeBodies` skips `MoveProxy` while tight AABB stays
inside fat (`b2AABB_Contains`). Both harnesses green. **PAIRING 101,145→90** (resting proxies stop
re-querying) + **SOLVE −29% (−237k)** — big surprise: finalize was doing a tree MoveProxy per body
per step (~29% of SOLVE), now skipped when settled. COLLIDE +160% (the 0.05 margin makes dense
non-touching boxes pair up — zero impulse, real narrow-phase cost). Net TOTAL −6% on this worst-case
dense hot pile; ~338k gross saving shows on sparse/resting + once sleeping lands. New baseline in
PLAN_FOR_OPUS.md §6 item 8. SAFETY (in-code at finalize): skip is safe ONLY because contacts are
never destroyed on separation yet — revisit in Phase C.
**★ Phase B item 8b (DISJOINT EARLY-OUT in b2Collide) done & verified green (2026-07-04).**
`b2Shape.aabb` (tight + speculativeDistance, radius folded in — general for rounded shapes);
`b2Collide` skips `b2UpdateContact` when `b2AABB_Overlaps(shapeA->aabb, shapeB->aabb)==false`
(sets pointCount 0, clears touching flag, KEEPS the contact — safe under no-disjoint-destroy).
Provably equivalent to running the narrow phase (non-overlap ⟹ separation > 2·spec ⟹ 0 points).
**COLLIDE 443,449→204,014 (−54%); 40-box TOTAL 1,023,994→786,159 (−23%).**

**★★ SESSION CUMULATIVE (2026-07-04): 40-box step 1,516,650 → 786,159 = −48.2%** — nearly halved,
all six slices green (profiler ROM + §5.5 scratch + §5.6 solver inline + §5.6 collide inline + §5.2
fat AABBs + disjoint early-out). 10-box now 77% of frame (comfortable 60 fps); 20-box 156%; 40-box
314%. Full baselines in PLAN_FOR_OPUS.md §6 items 7/8/8b/9/10b/10c.

**★ RAYCASTS (Phase D item 15) done & verified green (2026-07-04) — first query capability.**
Shape ray casts (`b2RayCastCircle/Capsule/Segment/Polygon`, geometry slice 2) + `b2DynamicTree_RayCast`
+ **`b2World_CastRayClosest`** (world API: closest shape hit against all 3 trees, world-space out).
Verified: exact fraction/point/normal, miss, maxFraction cutoff, initial overlap, capsule endpoint-cap,
one-sided cull, closest-of-two, and the non-identity rotation round-trip. Games can now do ground
checks / line-of-sight / aim-picking. DEFERRED: query filters, all-hits callback form, rounded-polygon
ray cast (needs `b2ShapeCast`), tree box cast.
**Also green (2026-07-04):** `b2ShapeTestPoint(shape, xf, worldPoint)` — point/mouse picking (inverse-
transform + point-in-circle/capsule/polygon dispatch; segments return false). `b2TransformPolygon` +
`b2MakeOffsetPolygon`/`b2MakeOffsetRoundedPolygon` — level-building (place/rotate polygon shapes),
verified via a concrete anchor + the invariant `makeOffset == transformPolygon∘makePolygon`.
Query surface now: OverlapAABB + CastRayClosest + ShapeTestPoint (the common "what's here / along this
line / under the cursor" needs). All harness2-verified incl. non-identity rotation round-trips.
**DEMO ROM (2026-07-04):** `demo.c`/`demo.xml` → `bin/demo.v32` — asset-free LIVE animation: 6 dynamic
boxes fall + stack on a static floor at 60 fps, each body drawn as a BIOS-font marker at its
world→screen-mapped center (clear_screen + print_at + end_frame game loop; iterates the awake set's
heap bodySims). First runnable "it's real" artifact; the seed for a Phase G player-controlled demo.

**Next options (functional physics + perf + raycast all done):** (a) **Phase E joints** (revolute →
distance → prismatic → weld → motor → wheel; each self-contained on the solver base; gate on a
pendulum-period / length-hold bracket) — high game value, incremental slices; (b) **Phase G packaging**
(amalgamated `virconbox2d.h` + a `demo.c` game ROM — the real acceptance test) — proves the "usable
library" goal; (c) **structural Phase C (islands→sleeping)** — biggest scalability win but a large
multi-slice epic (64-bit constraint-graph decision pt); (d) more §5.6 inlining (diminishing). See
PLAN_FOR_OPUS.md §5–6. Recommendation: joints (breadth toward feature-complete) or the demo (proves usability).
**Phase A slice history (all green, each an incremental slice on the solver):**
- ~~**Friction**~~ ✅ done & green (tangent loop in relax pass, friction cone, warm-start tangent).
- ~~**Restitution**~~ ✅ done & green (2026-07-04). `b2ApplyRestitution`/`b2ApplyRestitutionPoint`
  post-substep pass in `b2Solve` (before finalize). Also plumbed **per-shape material**:
  `b2Shape`/`b2ShapeDef` now carry `friction` (default 0.6) + `restitution` (default 0.0),
  mixed at `b2UpdateContact` — friction `sqrt(fA*fB)` (b2MaxFloat-guarded), restitution `max(rA,rB)`.
  `world.restitutionThreshold` (default 1.0). Also fixed the **`b2Atan2(0,0)` hardware-fault guard**
  (returns 0). Green-safe: default restitution 0 + `restitution==0` early-out ⇒ existing scenes unchanged.
- ~~**2-point manifolds / stacking**~~ ✅ done & green (2026-07-04). Verified existing machinery
  under load (no new port code): a spun box settles LEVEL on the 2-point floor manifold; a
  2-box **dynamic-on-dynamic** stack settles without sinking (B−A separation held). Broad-phase
  dyn-dyn pairing confirmed (self-skip + movedProxies/pairSet dedup).
- ~~**Cross-step warm start**~~ ✅ done & green (2026-07-04). `b2StoreImpulses` (solver) writes
  solved per-point impulses back to the source contactSim manifold (needs new `contactIndex` field
  on `b2ContactConstraint` — the port's constraint array is compacted, not 1:1 with contactSims).
  `b2UpdateContact` snapshots the prior manifold's impulses+ids (constant-index) then `b2MatchWarmStart`
  (2×2 unroll) carries them into id-matching new points; `b2PreparePoint` seeds `cp` from the manifold.
  Order in `b2Solve`: substeps → restitution → store → finalize. Verified: 3-box stack holds; resting
  box shows positive stored impulse + `persisted` flags.
- ~~**Speed cap + motion locks**~~ ✅ done & green (2026-07-04). `b2IntegratePositions` zeroes
  locked velocity components + clamps linear (`world.maxLinearSpeed`=400) / angular
  (`B2_MAX_ROTATION·inv_dt`), sets `b2_isSpeedCapped`. Caps precomputed in `b2Solve`.
- ~~**Contact teardown on body/shape destroy**~~ ✅ done & green (2026-07-04, fixes §1 landmine).
  `b2DestroyShapeInternal` walks the body's contact-edge list + destroys referencing contacts;
  `b2DestroyBody` tears down contacts→shapes(+proxies)→sim. harness2 soak (20× create/destroy/step)
  green — no leaks/faults. DEFERRED: single-shape destroy on a multi-shape body; joint/chain teardown.
- **★ PHASE A COMPLETE.** Next is **Phase B (performance): the PROFILER ROM** — clone the harness
  scaffolding into `perf.c`, step a standard scene (10/20/40 falling boxes), print per-phase
  cycle counts (`get_cycle_counter()` + `ShowInt`) vs the 250k-instr/frame budget. Then fat AABBs
  (§5.2), persistent solver scratch (§5.5), constant precompute (§5.7). See PLAN_FOR_OPUS.md §5–6.
- **Then the structural pieces** (large, ⚠️): islands (`island.c`) + the constraint graph
  (`constraint_graph.c`, uint64 coloring → 32-bit rework — one of the big three) + the awake-set ↔
  graph-color contactSim migration (`b2GetContactSim`'s dropped branch, `b2Collide`'s deferred
  migration). Needed for determinism + the parallel solver shape; the serial solver works without
  it. Then sleeping, continuous/TOI, the `*_joint.c` files.
- **Also deferrable:** dynamic_tree slice 2 (rotate/rebalance, ray/box cast), manifold loose ends.

(Done 2026-06-26 session: ~~`b2ContactSim`+`b2UpdateContact`~~ ✅, ~~narrow-phase `b2Collide`~~ ✅,
~~time integration~~ ✅, ~~wired `b2World_Step` + MoveProxy~~ ✅, ~~contact constraint solve~~ ✅,
~~friction~~ ✅. — 7 slices, ~535 checks, functional physics + friction.)

**KEY de-risking result (probe, 2026-06-25):** variable-index access into a HEAP-POINTER array
of large structs is FULLY SAFE (subscript, pointer-walk, `&ptr[i].sub.member` out-param,
free-list walk). The miscompile trap is SPECIFIC to fixed array MEMBERS (`T arr[N]` inside a
struct) — those still need constant-index unrolling. (Both in the dialect doc.)

**Manifold loose ends** (small, deferrable):
1. **Vertex-vertex override coverage** — the four exact `fraction1/2 == 0.0/1.0` branches in
   `b2CollidePolygons` (corner-corner approach) are still untested; add a known-value case.
2. ~~**Chain-segment variants**~~ ✅ DONE & green (circle 2026-07-09; **capsule + polygon
   2026-07-10**). `b2CollideChainSegmentAndPolygon` (ghost Gauss-map `b2ClassifyNormal` +
   `b2ClipSegments` + SAT with neighbour culling) + the capsule wrapper. The `b2SimplexCache`
   is COLD each call (the port keeps no persistent GJK cache) — costs iterations, not correctness.
3. The solver-side `b2Manifold`/`b2ManifoldPoint` types are still deferred until a consumer needs them.

Then proceed to the next module per the dependency order below (dynamic_tree → core utils → sim core).
2. **Finish the leaf modules' remaining slices:** geometry slice 2 (ray casts:
   `b2RayCastCircle/Capsule/Segment/Polygon`), distance slice 3 (`b2ShapeCast`,
   `b2TimeOfImpact`), `b2MakeOffsetPolygon`, `b2TransformPolygon`.
3. **`dynamic_tree.c`** — broad-phase BVH (AABB tree). Self-contained-ish; uses `b2_aabb`.
4. **Core utilities:** `core.c` (map `b2Alloc/b2Free` → `malloc/free`), `timer.c`,
   `ctz.h`, `table.c` (hashing), `id_pool.c`, `arena_allocator.c`, **`bitset.c`** (⚠️ 64-bit).
5. **Simulation core (largest):** `shape.c`, `body.c`, `contact.c`, `broad_phase.c`,
   `island.c`, `solver*.c`, `constraint_graph.c` (⚠️ 64-bit bitsets), the `*_joint.c`
   files, `physics_world.c`.
6. **Infrastructure:** `scheduler.c`/`parallel_for.c` (⚠️ serialize the task system).
7. **Skippable for a first playable port:** `recording*.c`, `world_snapshot.c`, `sensor.c`
   (until needed).

### How to resume (mechanical)
1. `cd VirconBox2d && bash build.sh harness` should still produce green (sanity check the
   tree is intact).
2. Read the upstream `box2d/src/<module>.c` + its types in `box2d/include/box2d/`.
3. Port into `port/b2_<module>.h` applying the conventions above; add types to
   `b2_collision.h` as needed (use `type[n] name` for array members).
4. Add hand-computed `Check()` cases to `harness.c`, `#include` the new header, rebuild.
5. Run `Vircon32.exe bin/harness.v32`; **ask the user for the screen color.** Green → record
   in memory + this file, move on. Red → bisect.

### Known deviations (deferred, not bugs)
- `b2MakeRot`/`b2Atan2` use the console's **hardware** sin/cos/atan2, not Box2D's custom
  **deterministic** versions. `b2ComputeCosSin`/`b2ComputeRotationBetweenUnitVectors` from
  `math_functions.c` not yet ported. Matters only for cross-platform-reproducible sim.
- `b2IsValidFloat` uses the `x != x` NaN trick + a `1e36` bound built by multiplication.
- `FLT_EPSILON` is a runtime division by a global (see the float-underflow trap above);
  consider precomputing tiny constants once at startup if hot paths need it.
- `B2_ASSERT` / validation calls are omitted throughout (re-add as a no-op macro if wanted).
- GJK debug-simplex output parameters were dropped from `b2ShapeDistance`.

### Looming structural work (the big three)
1. **No 64-bit ints** — the constraint-graph coloring bitsets (`uint64_t`) must be reworked
   to arrays of 32-bit words.
2. **By-value → pointer rewrite** propagates to every call site in all 38 modules.
3. **Threaded task system → serial** — keep the `b2TaskCallback` function-pointer interface
   (function pointers DO work in v26), but run tasks inline.

## Useful prior art (Vircon32 dialect examples)

- `E:\Claude\Projects\Vircon32\ConsoleSoftware\Libraries\` — official libs. **`Vector2D/vector2d.h`
  is the canonical pointer-out vector idiom.** Also BoundingBox, BoxCollisions, Interval, PrintNumbers.
- `E:\Claude\Projects\Vircon32\CommunityContent\Libraries\` — community libs (easings, pgoodies).
- `E:\Claude\Projects\Vircon32\ConsoleSoftware\TestPrograms\` — `Test-MinimalTest`,
  `Test-MathFunctions` are good minimal references.

# CLAUDE.md

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.
