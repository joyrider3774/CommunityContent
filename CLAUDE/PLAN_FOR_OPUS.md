# VirconBox2D — Audit Report & Continuation Plan

**Handoff document for the next development agent (Opus).**

---

# PART 0 — Re-audit 2026-07-06 & CURRENT master plan (read this first)

A second full audit, performed 2026-07-06 with Phase A (solver fidelity), Phase B
(performance, −48% step cost), Phase C (islands → sleeping → waking), Phase D
raycasts, and Phase E (all 8 joint types + public def API + handles) **all green**.
Everything below Part 0 (the 2026-07-02 document) remains valid as *reference*
(dialect checklist §3, perf playbook §5, perf baselines §6, testing contract §7),
but its roadmap sections are historical — Phases A–E are DONE. **This Part 0 is
the live roadmap.** CLAUDE.md's status table describes what exists; this part
describes what to do next and why, ranked.

## 0.1 Audit verdict

**Healthy and impressive.** `bash build.sh harness2` compiles clean (2 warnings,
both meaningful — see F2). The nested git repo (`VirconBox2d/.git`) is clean with
per-slice commits. Sleep migration (`b2TrySleepIsland`, `b2_solver.h`) correctly
moves bodies + touching contacts + joints + the island with swap-remove-repair on
every array; `b2WakeSolverSet` (`b2_body.h`) is append-only (safe for the
mid-`b2Collide` wake) and the wake-momentum refetch is in place. `b2DestroyBody`
tears down joints → contacts → shapes in the right order and handles sleeping-set
sims. No dialect violations found (pattern sweep: ternary / `f` suffix /
sci-notation / `union` / `#pragma` / sub-1e-6 literals / variable-index array
members — all clean or comment-only).

The remaining defects are all in the **seams between finished phases** — exactly
where a real game (not the harness) will step. They are enumerated below as F1–F9
with file anchors, then folded into the phased plan (P0–P4).

## 0.2 Findings (ranked by how hard a real game hits them)

**F1 — Contacts are NEVER destroyed on separation. (unbounded growth — the #1 fix)**
`b2Collide` (`port/b2_body.h` ~2585) keeps every contact ever created; the
disjoint early-out skips the narrow phase but explicitly KEEPS the contact.
`b2DestroyContact` is only called from body/shape/joint teardown. Consequence: a
player body moving across a tiled level accretes one contact per tile it ever
fat-AABB-touched — `contactSims`, `pairSet`, and the per-body edge lists grow
monotonically, and the `b2Collide` loop cost grows with them. The harness never
sees this (bodies barely travel); every real game will. Upstream destroys the
contact when the two shapes' **fat** AABBs stop overlapping (`b2_simDisjoint`
path in `physics_world.c`). Port that:
  - At the end of the `b2Collide` loop body, if `b2AABB_Overlaps(shapeA->fatAABB,
    shapeB->fatAABB) == false` → destroy the contact. NOTE the port's disjoint
    early-out tests `shape->aabb` (speculative-padded tight box) for *skipping
    narrow phase*; the *destroy* test must use `fatAABB` (bigger margin) so
    create/destroy don't ping-pong at the boundary (hysteresis, same as upstream).
  - **Iteration hardening** (the landmine comment at `b2_body.h` ~2594):
    `b2DestroyContact` swap-removes from the very `contactSims` array being
    iterated. Iterate BACKWARD (`for i = count-1 .. 0`, refetching `.data` and
    clamping `i` after any wake, like `b2UpdateSleep` does), or collect doomed
    contactIds in a scratch int array and destroy after the loop. Backward is
    simpler and already has a proven template in `b2UpdateSleep`.
  - **Update the fat-AABB SAFETY comment** (`port/b2_solver.h` ~196): the
    finalize `MoveProxy` skip stays safe — a skipped move means `fatAABB` is
    unchanged and still contains the tight AABB, so a *touching* pair can't go
    fat-disjoint while resting. State that reasoning at both sites.
  - Acceptance: (a) both harnesses green; (b) NEW soak check — drag a body across
    a row of ~10 static tiles (SetTransform steps), then assert
    `b2GetIdCount(&world->contactIdPool)` returns to the touching-only count;
    (c) sleep_demo still cycles sleep↔wake (destroy of a sleeping pair's contact
    must not fire — both-non-awake pairs are skipped before the test).

**F2 — `wakeBodies` is accepted and IGNORED.** The two build warnings:
`b2DestroyContact(..., bool wakeBodies)` (`b2_body.h:1486`) and
`b2DestroyJointInternal(..., bool wakeBodies)` (`b2_body.h:1734`). Consequence:
destroy the floor under a sleeping pile → the pile's contacts vanish but the
island stays asleep, **floating in mid-air forever** (nothing ever re-runs its
manifolds: both-non-awake pairs are skipped in `b2Collide`). Fix: when
`wakeBodies` is true and an endpoint body's `setIndex >= b2_firstSleepingSet`,
call `b2WakeSolverSet` on that set (before unlinking, mirroring upstream
`contact.c`/`joint.c`). Callers: `b2DestroyShape`/`b2DestroyShapeInternal` with
`destroyContacts=true` must pass `wakeBodies=true`; `b2DestroyBody` keeps `false`
for its own body but the OTHER body of each contact/joint must wake — upstream
wakes `otherBody`; implement exactly that (wake the other endpoint's set).
Acceptance: harness2 scene — pile sleeps on a platform body → `b2DestroyBody`
(platform) → pile wakes and falls (y decreases within N steps).

**F3 — `b2Body_SetTransform` doesn't wake.** (`b2_body.h:1228`) Teleporting a
sleeping body moves its proxies + sim transform but it stays in the sleeping set:
its old resting contacts stay "touching" (skipped, never re-evaluated) and it
won't collide at the new location until something else wakes it. Fix: at entry,
if the body is in a sleeping set → `b2WakeSolverSet`. Same for the future
velocity/impulse setters (P1). Acceptance: sleep a box, SetTransform it above a
floor, step → it falls and lands (currently it hangs frozen).

**F4 — Joint created onto a sleeping body is inconsistent.** `b2CreateJoint`
(`b2_body.h` ~1640) places the jointSim by disabled/static/awake logic only — a
sleeping dynamic endpoint yields `setIndex = b2_awakeSet` for the JOINT while the
BODY (and its island) stays sleeping; `b2LinkJoint` then links islands that are
in different solver sets (the deferred-wake note at `b2_body.h:562`). The solver
will drive an awake jointSim against a body whose dense state is not in the awake
set. Fix (upstream behavior): at the top of `b2CreateJoint`, wake BOTH endpoint
bodies' sets if sleeping (`b2WakeSolverSet`), THEN place the joint. One guard,
closes the whole class. Acceptance: sleep a pile, create a distance joint from a
new awake body to a pile member, step → pile wakes, joint holds length.

**F5 — Destroying the last body of a sleeping set leaks the set.**
(`b2_body.h:912` "(deferred) empty sleeping-set cleanup") — `b2DestroySolverSet`
EXISTS now (Phase C2b) but isn't called here. Fix: after removing the sim, if
`set` is a sleeping set and `set->bodySims.count == 0` → `b2DestroySolverSet`.
(Its contacts/joints are already gone: teardown above destroyed them.)
Acceptance: soak — repeat (create pile → sleep → destroy all bodies) ×20, assert
`b2GetIdCount(&world->solverSetIdPool)` returns to 3.

**F6 — `b2SplitIsland` missing (merge-only islands).** (`b2_island.h:15`
DEVIATION note.) Islands only merge, so over a session everything the player ever
touched congeals into one mega-island that can never sleep again as a unit (one
moving member keeps ALL of it awake). This silently erodes the entire Phase C
payoff in any long-running game. The port already maintains everything the split
needs: `island->constraintRemoveCount`, and per-island `b2ContactLink`/
`b2JointLink` arrays carrying `bodyIdA/B` (deliberately cached for exactly this).
Port upstream `b2SplitIsland` (island.c) as a slice: when
`constraintRemoveCount > threshold` on the island of `world->splitIslandId`,
union-find over the island's cached links (int-array union-find, no 64-bit
anywhere), producing k new islands. Serial → run it once per step at most (end of
`b2Solve`, before `b2UpdateSleep`). Acceptance: wrecker scene from sleep_demo —
after the wrecker bounces off and comes to rest APART from the pile, assert TWO
islands (pile re-sleeps, wrecker sleeps separately); today it's one forever.

**F7 — No body runtime API (games can't be written against the library).**
The only public body mutator is `b2Body_SetTransform`; demos reach into
`awakeSet->bodySims.data[k]` directly (see `demo.c:158-162`). `b2BodySim` already
has `force`/`torque` fields that `b2IntegrateVelocities` consumes and finalize
clears (`b2_solver.h:59-62,185-186`) — the plumbing exists, only accessors are
missing. Add (all wake-on-write via F2/F3's helper; out-pointer convention):
  - `b2Body_GetPosition/GetRotation/GetTransform/GetWorldCenter` (read sim)
  - `b2Body_GetLinearVelocity/SetLinearVelocity/GetAngularVelocity/SetAngularVelocity`
    (state lives ONLY in awake set → wake first, then poke; getters on a sleeping
    body return zero — document it)
  - `b2Body_ApplyForce[ToCenter]/ApplyTorque` (accumulate into `sim->force/torque`
    + wake), `b2Body_ApplyLinearImpulse[ToCenter]/ApplyAngularImpulse` (poke state
    velocity directly: `v += invMass*imp`, `w += invI*cross(r,imp)` + wake)
  - `b2Body_Wake` (public `b2WakeSolverSet` wrapper), `b2Body_IsAwake`,
    `b2Body_GetMass`, `b2Body_SetUserData/GetUserData`.
  Acceptance: harness2 — impulse on a sleeping body wakes it and produces the
  hand-computed velocity; force integrates to `f*h*invMass` after one step; and
  rewrite `demo.c`'s kick + draw loop to use ONLY the public API (dogfood test).

**F8 — Collision filters missing.** Every shape collides with everything;
`b2Filter` (categoryBits/maskBits/groupIndex — all int, no 64-bit issue) is not
ported; the pair query's should-collide check only consults joints
(`b2ShouldBodiesCollide`, `b2_body.h:1614`), and queries/raycasts hit every
shape. Games need this on day one (player vs enemy vs sensor layers). Small
slice: add `b2Filter filter` to `b2Shape`/`b2ShapeDef`, port
`b2ShouldShapesCollide` (int compares), call it in `b2PairQueryCallback`, and add
an optional `b2QueryFilter` to `b2World_OverlapAABB`/`b2World_CastRayClosest`/
`b2ShapeTestPoint`. NOTE: changing a filter at runtime upstream re-runs pairing
for that shape (`b2Shape_SetFilter` destroys its contacts + re-buffers the
proxy) — port that too or defer the runtime setter explicitly.

**F9 — Begin/end-touch events unreadable.** `b2_simStartedTouching/
StoppedTouching` bits exist but are never set (`b2_body.h` ~2592 comment), and
there is no polling surface. Games need "did I land / did I get hit" every frame.
Per §6.21's decision: POLLING arrays, not callbacks — `b2World` gets
`beginTouchEvents`/`endTouchEvents` grow-arrays of `{shapeIdA, shapeIdB}`
(+ generation-checked ids later), cleared at step start, appended in `b2Collide`
where the touching flag transitions, read by the game after `b2World_Step`.
~40 lines. Acceptance: drop a box on the floor → exactly one begin event that
step; lift it (SetTransform) → one end event.

**Deliberate non-goals confirmed still right:** cross-machine determinism
(hardware trig — documented), constraint-graph coloring (serial solver doesn't
need it; sleeping already works without it), threaded scheduler, SIMD solver
lanes, `recording*/world_snapshot/timer` modules.

## 0.3 The plan, phased (P0 → P4; each slice green-gated as ever)

Slice discipline unchanged (Part 1 §7 binding): one slice → `Check()`s in
harness2 → build → **user reports screen color** → commit → update CLAUDE.md +
memory. Sizes: S ≈ half a session, M ≈ a session, L ≈ multi-session.

### P0 — Correctness at the phase seams (do these first, in this order)
| # | Slice | Size | Anchors |
|---|---|---|---|
| P0.1 | **Wake plumbing**: honor `wakeBodies` (F2) + wake in `SetTransform` (F3) + wake both endpoints in `b2CreateJoint` (F4) + `b2Body_Wake/IsAwake` (part of F7). One shared helper `b2WakeBody(world, b2Body*)`. | M | b2_body.h:1486,1734,1228,1640,562 |
| P0.2 | **Disjoint contact destroy** (F1) + backward-iterate hardening + SAFETY comment updates. The biggest single fix in the repo. | M | b2_body.h:~2585-2710, b2_solver.h:~196 |
| P0.3 | **Empty sleeping-set cleanup** (F5). | S | b2_body.h:912 |
| P0.4 | **Soak + invariant harness group**: 1k-step mixed scene (travel, sleep, wake, joint create/destroy, body destroy) asserting id-pool counts return to baseline; plus a `b2ValidateWorld()` DEBUG walker — for every body: `bodies[id].localIndex` round-trips through its set's `bodySims[localIndex].bodyId == id`; same for contacts/joints/islands; edge-list doubly-linked consistency; `pairSet` count == contact count. Compile it only into harness builds. This is the safety net that makes P1/P2 refactors cheap — port of upstream `b2ValidateSolverSets`. | M | new: port/b2_validate.h |

### P1 — The game-facing API (turns the engine into a library)
| # | Slice | Size | Notes |
|---|---|---|---|
| P1.1 | **Body runtime API** (F7). Rewrite `demo.c` against it as the acceptance test. | M | force/torque plumbing already live |
| P1.2 | **Collision filters** (F8). | S–M | runtime `b2Shape_SetFilter` may defer |
| P1.3 | **Begin/end-touch event polling** (F9). | S | poll arrays, no callbacks |
| P1.4 | **`enableSleep` default flip to ON** for the library (upstream parity): add explicit `world.enableSleep = false` to `harness.c` scenes built before sleep existed (keeps the frozen suite bit-identical), then default ON in `b2CreateWorld`. Re-verify BOTH harnesses. | S | b2_body.h:291 |
| P1.5 | **Sensors** (poll API like P1.3): `isSensor` shapes generate overlap events, no impulses. Port the minimal `sensor.c` overlap pass, skip telemetry. | M | Phase F item |

### P2 — Scalability for real scenes
| # | Slice | Size | Notes |
|---|---|---|---|
| P2.1 | **`b2SplitIsland`** (F6). Union-find over cached links; run ≤1/step. | M–L | all inputs already cached |
| P2.2 | **Perf re-baseline with sleep ON**: rerun perf.v32; add a "settle-then-sleep" benchmark scene to the committed table (the §6 tables are all sleep-OFF worst cases). Quantify the Phase C payoff that motivated it. | S | perf.c |
| P2.3 | Remaining **§5.6 inlining** (integrate/finalize/prepare loops) — only if P2.2 shows them hot; use the address-of-into-local-pointer form for array-member writes (Part 1 §6.10c notes). **PLUS the Vircon-specific de-call pass (§0.5 V1/V2): scalar min/max/abs/sqrt call elimination in the solver hot lines** — probe p13 first. | S–M | §0.5; probes/p13_asm_intrinsics.c |
| P2.4 | **Static-tree quality**: `b2DynamicTree_Rebuild` (SAH) called once post-level-load + optional `b2RotateNodes`. Matters for tile-heavy levels. | M | §5.9 |
| P2.5 | **Kinematic bodies end-to-end**: moving-platform scene (kinematic velocity API from P1.1, carries a dynamic box, sleep interaction per `b2UpdateSleep`'s kinematic guard). Probably works already — TEST it, fix what reds. | S | b2_solver.h:2433 |
| P2.6 | **30 Hz + interpolation recipe**: worked example in the demo (store prev transform, lerp for draw — `rotation0`/`center0` already exist), documented in the packaged header. | S | §5.4 |

### P3 — Feature completeness (pull-based; do when a game asks)
- **`b2ShapeCast` + `b2TimeOfImpact`** (distance slice 3) → unlocks bullets/
  continuous AND the deferred rounded-polygon raycast (b2_geometry.h:748). L.
- **Chain shapes** + the 3 chain-segment collide fns (types exist; needs
  `b2ChainSegment` + `b2SimplexCache` arg plumbing + `b2DestroyBody`'s deferred
  chain teardown). M–L.
- **Vertex-vertex manifold override coverage** (the 4 `fraction==0/1` branches in
  `b2CollidePolygons`) — known-value checks only. S.
- **Single-shape destroy on a multi-shape body** — test exists path untested. S.
- **All-hits raycast callback form** + tree box cast. S–M.
- **Reaction-force getters for joints** (persist `world->inv_h` at step end —
  trivial field + getters; unlocks break-on-force gameplay). S.

### P4 — Packaging (Phase G; the finish line)
| # | Slice | Notes |
|---|---|---|
| P4.1 | **Amalgamated `virconbox2d.h`**: one include, dependency-ordered; doc header = budget table (from §6 baselines + P2.2), heap guidance (`malloc_end_address` before first malloc), meter-scale guidance, determinism caveat, sleep-default note, API tier list (public vs internal). |
| P4.2 | **Demo GAME ROM** (real acceptance test): player-controlled body (P1.1 impulses), tile level (P2.4), stacks that sleep visibly, raycast aim line, begin-touch landing sound-free flash, cycle-counter HUD. Gamepad input via `input.h`. **SEED EXISTS (2026-07-06): `VirconBox2d/showcase.c` — drivable wheel-joint car, spinner, wrecking ball, sleeping tower, spawner, laser, gravity flip; GPU-primitive renderer, 30 Hz physics + 60 fps interpolated render, adaptive substep governor. `VirconBox2d/SHOWCASE.md` documents its architecture, the timing/flicker invariants, and the port-seam workarounds to delete as P0/P1 land (it also dogfoods P2.6 interpolation and V6 budget-governing).** |
| P4.3 | **Docs refresh**: CLAUDE.md status table has grown into a scroll — compress finished phases to one line each pointing at Part 1 history + git log; keep only "current state + resume pointer" detailed. Fix stale bits (check counts, "~2600 lines" note). |
| P4.4 | **Repo hygiene**: keep the per-slice commit cadence (already good); consider `git init` at repo ROOT so CLAUDE.md/PLAN/dialect doc are versioned too (currently only `VirconBox2d/` is tracked); tag `v0.1-functional` at P0 completion. |

### Recommended execution order
**P0.1 → P0.2 → P0.3 → P0.4 → P1.1 → P1.2 → P1.3 → P1.4 → P2.1 → P2.2 → P4.2
(early draft) → P1.5 → P2.4/P2.5/P2.6 → P4.1 → P4.3/P4.4**, with P3 items pulled
in when the demo game needs them. Rationale: P0 makes existing features *true*;
P1 makes them *usable*; P2.1+P2.2 make sleep *durable and measured*; the demo
game then exercises everything and drives the rest by need.

## 0.3b Road to 100% — status overlay + ranked checklist (2026-07-07)

Overlay on 0.3 with what has actually landed since it was written, plus the ranked
remaining work. **Completion feel: a *usable* single-threaded engine is ~85–90%
done; a *feature-complete* single-threaded port is TIER 1 below (~5–6 focused
sessions, continuous/TOI the largest). TIER 3 is intentionally out of scope for a
Vircon32 target — do not count it against "100%".** Raw upstream is 34.3k lines /
38 `.c`; the core simulation is complete and verified.

### ✅ Landed & green since the 0.3 plan (do NOT redo)
- [x] **P0.1–P0.4** — wake plumbing, disjoint contact destroy, empty sleeping-set
      cleanup, `b2ValidateWorld` + soak harness group. (green, committed)
- [x] **P1.2 Collision filters** — `b2Filter{category/mask/group}` + `b2ShouldShapesCollide`
      gating the pair query; harness2 3-world discrimination check. (2026-07-07)
- [x] **Kinematic bodies end-to-end** (was P2.5) — integrate/pair/solve verified;
      `b2Body_SetTargetTransform`; harness2 push + target checks. (2026-07-07)
- [x] **Capsule + segment BODY shapes** (`b2CreateCapsuleShape`/`b2CreateSegmentShape`),
      `b2Body_GetLocalPoint`; capsule/segment rest checks in harness2. (2026-07-07)
- [x] **Boxtests track complete** (9 upstream test suites green or classified OUT).
- [x] **Benchmark ROM: ALL 10 scenes green** (LargePyramid/Tumbler/JointGrid/
      ManyPyramids/Smash/Compounds/Washer/Junkyard/Spinner/Rain). Spinner's chain is
      substituted with a segment loop; Rain ports human.c's ragdoll.

### TIER 1 — real physics features (THE road to feature-complete; ranked)
- [ ] **1. Continuous / TOI** — `b2ShapeCast` + `b2TimeOfImpact` (distance.c tail) +
      the solver continuous/bullet path (solver.c). **L. Biggest correctness gap** —
      fast/bullet bodies tunnel through thin walls without it. Also unlocks the
      deferred rounded-polygon raycast (b2_geometry.h:748). (= P3 item 1)
- [x] **2. Begin/end-touch events** (P1.3) — ✅ DONE & GREEN 2026-07-07 (commit
      db7f593). `b2World.beginTouchEvents`/`endTouchEvents` grow-arrays, cleared at
      `b2World_Step` start, appended in `b2Collide` at all 3 transition sites
      (begin; end-on-separate; end-on-disjoint-destroy, wasTouching-guarded). Poll via
      `b2World_Get{Begin,End}TouchEvent{Count,s}`. DEFERRED: **hit events** (impulse-
      magnitude events) + end-on-teardown (b2DestroyContact) + generation-checked ids.
- [ ] **3. `b2SplitIsland`** (P2.1, F6) — union-find over cached links, ≤1/step. **M.**
      Today merge-only: a bounced body stays in its old island forever (sleep works,
      just coarser). All inputs already cached.
- [ ] **4. Sensors** (P1.5) — `isSensor` shapes generate overlap events, no impulses;
      port minimal `sensor.c` overlap pass. **M.** Self-contained.
- [ ] **5. Real chain shapes** — `b2ChainSegment` type + the 3 chain-segment collide
      fns (ghost vertices, one-sided) + `b2SimplexCache` plumbing + chain teardown in
      `b2DestroyBody`. **M–L.** Removes the Spinner segment-loop substitution; needed
      for smooth one-sided terrain. (= P3 item 2)
- [~] **6. Body runtime API breadth** (P1.1, F7) — ✅ CORE DONE & GREEN 2026-07-08
      (commit 09bd816): `b2Body_GetPosition/GetRotation/GetTransform/GetWorldCenter`,
      `Get/SetLinearVelocity`, `Get/SetAngularVelocity`, `ApplyForce[ToCenter]`,
      `ApplyTorque`, `ApplyLinearImpulse[ToCenter]`, `ApplyAngularImpulse`, `GetMass`,
      `Set/GetUserData` (all wake-aware, upstream body.c semantics). demo.c rewritten
      to draw via `b2Body_GetWorldCenter` (no more solverSets reach-in). STILL PULL-
      BASED: remaining `b2Body_Set*` (SetType/SetGravityScale/SetFixedRotation/…),
      `b2Body_GetContacts`/shape enumeration, and joint reaction-force getters
      (persist `world->inv_h`) — port each when the demo game needs it.

### TIER 2 — quality / perf (not correctness; do when measured or asked)
- [ ] **enableSleep default ON** (P1.4) — flip default, keep frozen harness bit-identical. S.
- [ ] **dynamic_tree Rebuild (SAH) + RotateNodes** (P2.4) — static-tree quality for
      tile-heavy levels. M.
- [ ] **Remaining §5.6 inlining + §0.5 de-call pass** (P2.3) — only if perf re-baseline
      (P2.2) shows the loops hot. S–M.
- [ ] **Manifold vertex-vertex override coverage** (4 `fraction==0/1` branches) — known-
      value checks only. S.
- [ ] **Single-shape destroy on a multi-shape body**; **all-hits raycast callback** +
      tree box cast. S each.

### TIER 3 — INTENTIONAL non-goals for this target (NOT counted toward 100%)
- Parallel scheduler + constraint graph (scheduler.c/parallel_for.c/constraint_graph.c)
  — serialized on purpose; the single-threaded solver is correct without them. Only
  needed for threading + bit-exact cross-platform determinism.
- Recording / replay / snapshot (recording*.c/world_snapshot.c, ~4.9k lines) — tooling.
- Deterministic trig (`b2ComputeCosSin`) — cross-platform reproducibility; console uses
  hardware trig (documented deviation).
- `timer.c` — replaced by the console cycle clock.

### TIER 4 — packaging (finish line, P4)
- [ ] Amalgamated `virconbox2d.h` (P4.1); Demo GAME ROM (P4.2, seed = showcase.c);
      docs refresh (P4.3); repo hygiene / root `git init` + tag (P4.4).

**Suggested next:** TIER 1 item 1 (**continuous/TOI**) — the most visible correctness
hole for a game — or item 2 (**touch events**) as a cheaper high-value warm-up.


## 0.4 Standing engineering rules (unchanged, binding — abbreviated)
1. Probe uncertain dialect constructs in `probes/` BEFORE building on them.
2. One slice, one green gate. Never stack unverified slices. Commit per green.
3. Physics checks assert BRACKETS, not exact floats (hardware trig).
4. Every deviation gets a `DEVIATION:`/`DEFERRED:` comment at the site.
5. When mutating an array you iterate: backward-iterate + refetch `.data`, or
   collect-then-apply. (Wake APPENDS are safe; destroys are not.)
6. Anything that can put a body to sleep/wake must keep the invariant:
   body/contact/joint/island `setIndex`+`localIndex` ↔ dense-array position.
   P0.4's `b2ValidateWorld` exists to check exactly this after every step.
7. Domain-guard every new `sqrt/asin/acos/atan2/log` call — the console FAULTS
   instead of returning NaN, and the screen just freezes.

## 0.5 Vircon-SPECIFIC optimizations (ISA-verified 2026-07-06)

Sourced from the actual console spec + toolchain sources
(`ComputerSoftware/VirconDefinitions/Enumerations.hpp` opcodes,
`DevelopmentTools/CCompiler` emitter, `DevTools/include/math.h`/`misc.h`) and an
empirical codegen probe (`probes/p13_asm_intrinsics.c` — compiled clean; run it
green once before building on V1's form 3). Numbers below are instruction counts
read off the emitted `.asm` (1 instr ≈ 1 cycle).

**ISA facts that matter to a physics engine:**
- `FMIN/FMAX/FABS`, `IMIN/IMAX/IABS`, `FLR/CEIL/ROUND`, `SIN/ACOS/ATAN2/LOG/POW`
  are all **single 1-cycle instructions**. There is **no SQRT opcode** — `sqrt`
  is `POW(x, 0.5)`; no COS — `cos` is `FADD π/2; SIN` (2 instr).
- `MOVS/SETS/CMPS` = hardware memcpy/memset/memcmp at **1 cycle/word**
  (self-repeating instruction, `V32CPUProcessors.cpp:376`).
- But the C library exposes ALL of these as **functions** (`asm{}` bodies in
  `math.h`), and the compiler **never inlines**, so every `fmax()` call is
  ~10 + 2·nargs instructions of pure call overhead around a 1-cycle op. The
  port's wrappers double it: `b2MaxFloat → fmax → FMAX` measured **28 instr**
  for 1 instr of work.

**V1 — De-call scalar min/max/abs/clamp in the hot paths.** (S, measure with
perf.v32) The port has ~18 such calls in `b2_solver.h`; the ones that matter:
`b2SolveNormalPoint` accumulate-clamp (`b2_solver.h:632` — the hottest line in
the engine: 2 pts × contacts × substeps × 2 passes), `b2PrepareContacts:480`,
`b2FinalizeBodies:165-168` (2 `fabs` + a max + a `b2Length` per body per step),
speed-cap `:111`, and the joint limit clamps (`:925,954,1146,1167,1599,1632,
1901,1925` — hot when joints are active). Three forms, cheapest first:
  - **if/else rewrite** (28 → 3-5 instr, zero risk, no probe needed):
    `float ni = old + impulse; if( ni < 0.0 ) ni = 0.0;`
  - **`asm{}` intrinsic** (28 → 3 instr): `asm { "mov R0, {ni}"  "fmax R0, 0.0"
    "mov {ni}, R0" }`. Probe p13 verified: `{var}` interpolates BOTH read and
    write positions (textual address substitution), float immediates work as
    operands (`fmax R0, 0.0` compiles), but `{var}` takes **plain variable names
    only** (not `p->field` — copy to a local first, which hot paths already do);
    clobber rule: R0 free between statements, push/pop anything else (math.h style).
  - Keep the readable `b2MaxFloat` etc. for all cold paths — this is a hot-path-
    only edit, same policy as the §5.6 inlining that bought −31% SOLVE.

**V2 — asm-intrinsic `sqrt` at the hot call sites.** (S) `sqrt()` is a function
wrapping `POW` (~15 instr overhead/call). Hot sites: `b2Length` inside
`b2FinalizeBodies` (per body per step), `b2Normalize` in manifold/joint prep,
GJK distance. Inline as `asm { "push R1"  "mov R0, {x}"  "mov R1, 0.5"
"pow R0, R1"  "pop R1"  "mov {x}, R0" }` (domain guard stays — negative input
FAULTS).

**V3 — Already optimal, do NOT touch (verified):** multi-word struct assignment
compiles to hardware `MOVS` (`EmitAssignment`, `EmitBinaryOperationNodes.cpp:
1516-1533`) and `memcpy`/`memset` are `MOVS`/`SETS` — so swap-remove struct
copies cost ~sizeof-in-words cycles and whole-struct assignment BEATS
field-by-field copying beyond ~3 fields. Keep using plain `a = b` for structs.

**V4 — Anti-optimizations (do not spend sessions on these):**
  - **No cache exists.** Every memory access is 1 cycle. SoA layouts, hot/cold
    struct splitting, and iteration-order locality buy **zero** speed here
    (only RAM footprint). Classic-hardware intuition does not transfer.
  - **Floats are 1-cycle hardware, including FDIV** (host FPU on the emulator,
    which IS the reference platform). No fixed-point port, no division-avoidance
    transforms, no `1/x` caching for speed. (§5.7's deprioritization confirmed.)
  - **IMUL/IDIV are 1 cycle** — no shift/strength-reduction tricks needed.
  - The only wins that exist on this machine are **algorithmic** (sleep, fewer
    pairs, fewer narrow-phase runs) and **call elimination** (inlining, V1/V2).

**V5 — Embedded ROM data for static levels.** (M, pairs with P2.4/P4.2) The
cartridge can embed binary data as C arrays (`embedded` — zero RAM, zero init
cycles, read directly from ROM address space). Two uses: (a) pre-baked level
geometry — polygons/hulls computed at ROM build time instead of `b2MakePolygon`
at load; (b) **offline-baked static broad-phase tree**: build the static tree's
node array on the host (any SAH builder) and embed it, making load instant AND
better-balanced than incremental insertion — this can REPLACE the P2.4
`b2DynamicTree_Rebuild` port for games with static levels. Needs a small host-
side bake step in the game's build, and `b2DynamicTree` gaining a "wrap
read-only embedded nodes" constructor. Very fantasy-console idiomatic.

**V6 — Step-budget introspection API.** (S) The perf ROM already computes
per-phase cycles from `get_cycle_counter()`; persist the last step's totals on
`b2World` (`world->lastStepCycles`, per-phase) behind a `#define B2_PROFILE`
and expose `b2World_GetStepCycles()`. Games then adapt at runtime (drop
substeps / switch to 30 Hz when near the 250k budget) instead of shipping tuned
constants. Costs a few counter reads per step; compile out for release.

**Sizing note:** V1+V2 land inside SOLVE's remaining ~580k (40-box); the call
sites listed run O(points × substeps × 2) ≈ 500-1000 times/step in that scene,
so expect a few % of SOLVE — worthwhile, but AFTER the P0 correctness slices;
fold into P2.3 and measure with perf.v32 as always.

---

# PART 1 — Original audit & reference (2026-07-02; roadmap sections historical)

Written 2026-07-02 after a full audit of the tree against `VIRCON32_C_DIALECT.md`,
the upstream `box2d/` sources, the official Vircon32 libraries
(`E:\Claude\Projects\Vircon32\ConsoleSoftware\Libraries\`), and the console
specification/emulator sources (`E:\Claude\Projects\Vircon32\ComputerSoftware\`).

Read `CLAUDE.md` and `VIRCON32_C_DIALECT.md` **first** — they are the project
contract. This document adds: the audit verdict, every caveat known to date
(including new ones found in this audit), a performance/optimization playbook
grounded in the real hardware budget, and a phased roadmap with acceptance
tests so the port becomes a **usable game library**, not just a green harness.

---

## 1. Audit verdict (2026-07-02)

**The codebase is healthy.** Verified this session:

- **Build is green.** `compile → assemble → packrom` produced a fresh
  `bin/harness.v32` (227 KB ROM) with **warnings only** (unused args/vars —
  benign, mostly deliberate signature-mirroring like `b2Free(mem, size)`).
- **Zero dialect violations** found by pattern audit across all 20 port
  headers: no ternaries, no `f` float suffixes, no scientific notation, no
  `#pragma`/`#if`/`#elif`/`##`, no `char`/`double`/`unsigned`/64-bit types, no
  sub-1e-6 float literals, no console-absent math names (`sqrtf` etc.), no
  by-value multi-word struct crossing a function boundary. All hits were in
  comments.
- **Structural review** of the load-bearing modules (`b2_solver.h`,
  `b2_body.h`, `b2_broad_phase.h`, `b2_core.h`, `b2_contact.h` interfaces)
  confirms the sparse/dense indirection (`b2Body` ↔ `b2BodySim`/`b2BodyState`
  via `setIndex`+`localIndex`), swap-remove-and-repair patterns, primary-order
  contact storage, and the move-buffer invariant are all implemented as
  documented and match upstream semantics.
- **Friction pass placement verified against upstream**: Box2D v3's overflow
  solver also solves friction only in the relax (`useBias == false`) pass
  (`box2d/src/contact_solver.c:344`). The port matches.
- The harness contains **~508 `Check()` calls** (CLAUDE.md says 425/~535 in
  two places — stale; trust the harness itself). All green as of the last
  user-verified run.

### Discrepancies / small defects found (fix early, all cheap)

1. **`b2Atan2` can hard-fault the CPU.** `port/b2_math.h:537` forwards
   directly to the console's hardware `atan2`, and the console spec says
   `atan2(0,0)` raises a **hardware error** (CPU fault, invisible in
   DebugLog). Upstream `b2Atan2(0,0)` returns 0. Guard it:
   `if( y == 0.0 && x == 0.0 ) return 0.0;` — one line, removes a whole class
   of invisible crashes (e.g. normalizing a zero vector into `b2MakeRot`,
   `b2Rot_GetAngle` on a zeroed rot). Add a harness check.
   Audit siblings: all `sqrt` calls in `b2_math.h` take sums of squares
   (safe); re-audit any future `sqrt`/`asin`/`acos`/`log` port for domain
   guards — the console faults instead of returning NaN.
2. **Stale comment**: `b2World_Step` header comment (`port/b2_solver.h:572`)
   says "NORMAL-IMPULSE ONLY (no friction...)" — friction is implemented and
   green. Update when next touching the file.
3. **Doc drift**: CLAUDE.md's check counts and the `b2_broad_phase.h` header
   comment ("DEFERRED: ... pairSet") lag reality (pairSet + move buffering are
   in and used). Keep CLAUDE.md's status table updated per slice — it is the
   next session's memory.
4. **`b2AllocZeroInit` arg order**: `calloc( size, 1 )` — works (count×size),
   but flip to `calloc( 1, size )`-equivalent semantics doesn't matter here;
   leave it, just don't "fix" it blindly: console `calloc(count, size)`
   zeroes count*size **words**.

### Landmines already flagged in code comments (respect them)

- **`b2Collide` iterates `awakeSet->contactSims` while stable** only because
  disjoint-destroy/graph-migration are deferred (`port/b2_body.h:1032`). When
  those land, snapshot the array or iterate backward.
- **`b2DestroyBody` does not tear down shapes/contacts** yet — destroying a
  body that has shapes leaks proxies and leaves dangling `contactSim`s.
  Fine for the harness; must be fixed in Phase A/C before games use it.
- **`b2FinalizeBodies` moves every awake body's proxies every step**
  (no fat AABB) — correct but has a big performance consequence (§5.2).

---

## 2. The hardware envelope (what "usable in games" actually means)

From `ComputerSoftware/VirconDefinitions/Constants.hpp` and the spec:

| Resource | Value | Consequence for Box2D |
|---|---|---|
| CPU | **15,000,000 cycles/s**, ~1 instruction/cycle | **250,000 instructions per frame** at 60 fps. This is the wall. |
| RAM | 4 MWords (16 MB) | Globals < 1 MW, default heap 2 MW, stack 1 MW. |
| Heap | `malloc` range **1–3 MW** by default | Enlarge by writing `malloc_start_address`/`malloc_end_address` **before the first `malloc`** (ignored after). A big world + trees + constraint arrays will want this. |
| Video | 640×360 @ 60 fps, GPU draws independently | Rendering costs GPU quota, not CPU cycles — physics owns almost the whole CPU frame. |
| Timer | `get_cycle_counter()` (cycles within current frame), `get_frame_counter()`, `end_frame()` in `time.h` | **In-ROM profiling is possible** — see §5.1. |
| Compiler | `-O1/-O2/-O3` accepted but **ignored** | No inlining, no CSE, no strength reduction. Every `b2Add(&a,&b,&r)` is a real call. Hand-optimization is the only optimization. |

Budget intuition: a naive ported `b2World_Step` costs on the order of
thousands of instructions **per body-contact per substep** (each vec-op is a
function call with register-marshalled pointer args). With 4 substeps,
expect **a few dozen active bodies** to be the practical ceiling at 60 fps,
more if physics runs at 30 Hz (§5.4) or bodies sleep (§5.3). This is fine for
the target (fantasy-console games), but it means **sleeping and the
fat-AABB broad phase are not optional polish — they are the difference
between a demo and a library**.

"All console modes" = the library must be a plain include (`#include
"virconbox2d.h"`) usable by any cartridge program (games at 60 fps, apps,
BIOS-built programs via `compile -b`), with no assets required, no fixed
memory addresses claimed other than heap use, and documented heap/CPU cost so
games can budget around it. There are no video-mode variants to worry about;
packaging + budget discipline is the whole story (§7).

---

## 3. Dialect caveats — the complete checklist

Everything in `VIRCON32_C_DIALECT.md` applies. The ones that have actually
drawn blood, plus audit additions, in priority order:

### Hard compile errors (you'll notice immediately)
1. **No multi-word struct by value across a function boundary** (params AND
   returns). Out-pointer as LAST arg; scalars return by value.
2. **No ternary `?:`**, no comma operator, no compound literals `(T){...}`,
   no `#pragma`, no `#if`/`#elif`, no `#`/`##`, no variadics, no
   `char`/`double`/`unsigned`/`short`/`long`, no `static`/`volatile`, no
   bit-fields, no ANONYMOUS inline `union` members (NAMED union types DO work —
   p11 corrected 2026-07-18; b2JointSim converted to `union b2JointPayload`
   2026-07-19, green), no `int arr[10];` declarations (write `int[10] arr;`).
3. `#include "quotes-only"`. Headers carry full implementations; single
   translation unit; include guards mandatory.

### Silent traps (these are the dangerous ones)
4. **Float literals below ~1e-6 silently become 0.0** (lexer AND constant
   folder — `1.0/8388608.0` as a literal expression also folds to 0).
   Produce tiny constants via runtime division by a **global**
   (`FLT_EPSILON` pattern, dialect doc §15.5). Anything ≥ ~1e-3 is safe.
5. **Fixed array MEMBERS (`T arr[N]` inside a struct) indexed by a variable
   miscompile.** Constant-index unroll them (see the `points[0]`/`points[1]`
   unrolls in `b2_solver.h`/`b2_body.h`, `edges[2]` via `b2ContactEdgeAt`).
   Heap-pointer arrays of large structs indexed by variables are
   **probe-confirmed safe** (that's why `b2BroadPhase.trees` is a heap array,
   not a member array). When porting upstream code with `points[i]` loops,
   this is the #1 rewrite to remember.
6. **`sizeof` and `memcpy`/`memset`/`memcmp` count 32-bit WORDS, not bytes.**
   Never write `* 4`, never assume byte packing. `uint8_t` fields widen to a
   full word — struct memory is ~4× upstream in "bytes" terms.
7. **`NULL == -1`, not 0.** `memset(...,0,...)` does NOT produce null
   pointers. Zeroed structs have *valid-looking* pointer fields — always
   explicitly assign `NULL` / `B2_NULL_INDEX` after `memset` (the port
   already does this; keep doing it).
8. **`>>` is a LOGICAL shift** (zero-fill). Upstream code that arithmetic-
   shifts negative ints (rare, but hashing/key-packing code does exist)
   behaves differently. The contact-key packing (`contactId << 1 | edge`,
   `key >> 1`) is safe because ids are non-negative.
9. **No unsigned semantics.** Hash functions, wraparound arithmetic, and
   `<`-comparisons on values with the sign bit set change meaning. The ported
   fmix32 hash in `b2_table.h` was verified green, but any NEW hash/bit code
   needs a harness check with sign-bit-set inputs.
10. **Hardware math faults instead of NaN**: `sqrt(x<0)`, `log(x<=0)`,
    `asin/acos(|x|>1)`, `atan2(0,0)`, `tan` at poles → **CPU fault**, no
    DebugLog entry, screen just freezes. Guard every domain edge at the port
    boundary (see §1 defect 1). `acos` inputs from dot products need
    clamping to [-1,1] — floating error alone can fault.
11. **`int* a, b;` makes BOTH pointers** (type applies to the whole
    declaration list).
12. **Enum → int converts implicitly; int → enum does NOT.** The port uses
    `#define` + `int` instead of enums — keep that convention.
13. Compiler reports **only the first error**, and "not-compiled" `#ifdef`
    regions are still lexed (must stay lexically valid).
14. **`f` suffix on float literals is a hard error** (`2.0f`) — strip when
    copying upstream code. Same for `1e-5` notation — write longhand.

### Behavioral deviations to keep in mind (not bugs)
- `b2MakeRot`/`b2Atan2`/`sin`/`cos` use **hardware** trig → not bit-identical
  to upstream's deterministic polynomial versions, and not necessarily
  identical across emulator hosts (float ops depend on host FPU). **On one
  machine the sim is repeatable**; cross-machine determinism is NOT
  guaranteed. Don't chase upstream's cross-platform determinism goal — it's
  unreachable with hardware trig and costs performance to fake. Document it.
- `B2_ASSERT`/validation omitted; GJK debug output dropped;
  `b2IsValidFloat` uses `x != x` + a multiplicative 1e36 bound.

---

## 4. Current state (what exists, verified green)

20 port headers, one cumulative harness (~508 checks), all green. Full
functional physics: `b2World_Step = b2UpdateBroadPhasePairs → b2Collide →
b2Solve(prepare → substeps[intVel → warmStart → solveBias → intPos → relax
+friction] → finalize+MoveProxy)`. A dynamic circle falls onto a static floor,
rests, and friction stops sliding. CLAUDE.md's table has per-module detail;
the short version of what is REAL today:

- **Math/geometry/collision layer: essentially complete** for circles,
  capsules, polygons, segments (GJK distance, SAT manifolds with clipping,
  masses, AABBs, hulls, raycast-on-AABB). Missing: shape ray casts,
  `b2ShapeCast`/`b2TimeOfImpact`, chain segments, vertex-vertex manifold
  override coverage.
- **Broad phase: functional** (3 trees, proxy create/move/destroy, move
  buffer, pairSet dedup, pairing pass). Missing: tree balancing
  (`b2RotateNodes`), `EnlargeProxy`/fat AABBs, tree ray/box casts,
  `Rebuild`/SAH.
- **Sim core: functional but thin.** Bodies (create/destroy/transform,
  mass), shapes (circle/polygon create/destroy with proxies), contacts
  (connectivity + sims + narrow phase), serial TGS-soft solver with normal +
  friction impulses. Missing: restitution, cross-step warm start, islands,
  constraint graph, sleeping, joints, sensors, events, filters, continuous.
- **Infra: done where needed** — id pools, bitset (32-bit rework), hash set
  (int-pair rework), arena allocator, ctz/clz, allocator, grow-array.

The three **structural** reworks identified at project start remain the big
rocks: (1) 64-bit → 32-bit bitset work is DONE for `b2_bitset.h`/`b2_table.h`
but still pending for constraint-graph coloring; (2) by-value → pointer
rewrite is DONE and proven; (3) threaded → serial is trivially done so far
(loops), with the `b2TaskCallback` interface decision still open for later.

---

## 5. Performance playbook (ranked by expected payoff)

The compiler does **zero optimization**, so all wins are algorithmic or
manual. Do these in this order; measure before/after each (§5.1).

### 5.1 Build the profiler FIRST (small, unlocks everything)
`get_cycle_counter()` reads the cycles elapsed within the current frame.
Make a `perf.c` ROM (clone of harness scaffolding) that steps a standard
scene (e.g. 10/20/40 boxes falling into a pyramid) and prints per-phase
cycle counts with `ShowInt` (BIOS font, no assets): pairing, collide, solve,
finalize — plus total per step vs the 250,000 budget line. The user reads
numbers off the screen just like the green/red loop. Keep the scenes in the
repo as regression benchmarks. Without this, every "optimization" below is
guesswork. (Caveat from `time.h`: intra-frame cycle timing is approximate on
emulators — treat 5–10% swings as noise. A step that exceeds one frame still
finishes; the frame just takes longer than 1/60 s — the emulator does not
abort mid-step.)

### 5.2 Fat AABBs + move-only-when-necessary (biggest broad-phase win)
Today `b2FinalizeBodies` recomputes a tight AABB and calls
`b2BroadPhase_MoveProxy` for **every shape of every awake body every step**.
Every MoveProxy = tree remove+insert (allocator-touching, log-depth walks)
AND a `b2BufferMove` → next step's pairing re-queries the whole tree for that
proxy. Upstream avoids ~90% of this with the fat AABB: store
`shape->fatAABB` (tight + `b2_aabbMargin`), and in finalize only MoveProxy
when the new tight AABB escapes the stored fat one. Port the
`aabbMargin`/`fatAABB`/`enlargedAABB` fields and the containment check.
Expect this to be the single largest constant-factor win for scenes with
resting-ish bodies (i.e. all games).

### 5.3 Sleeping (biggest algorithmic win — Phase C)
A sleeping stack costs ~zero: no integration, no solve, proxies never move,
pairing never re-queries. Islands + sleep transitions (Phase C) are what
turn "40 bodies max, always hot" into "hundreds of bodies, dozens hot".
Prioritize Phase C over joints for this reason.

### 5.4 Step-rate and substep tuning (free, per-game knobs)
- Run physics at **30 Hz** (`dt = 1/30`, step every other frame) and render
  with interpolation (store previous transform, lerp for drawing — the
  `rotation0`/`center0` fields already exist). Halves the physics budget
  share. Document as the recommended mode for heavy scenes.
- `subStepCount` is the quality/cost dial: 4 is upstream default; 2 is fine
  for non-stacking scenes. Cost is ~linear in substeps.
- Consider capping `contactHertz` relative to substep rate (already done:
  `min(hertz, 0.125/h)`).

### 5.5 Kill per-step heap traffic
`b2Solve` does `b2Alloc`/`b2Free` of the constraint array every step
(`port/b2_solver.h:548,565`). The console malloc is a linked-list walker —
per-step alloc/free of a growing block is both cycles and fragmentation.
Keep a persistent, grow-only scratch buffer in `b2World` (or finally use the
already-green `b2_arena_allocator.h` b2Stack, created once with a sane size).
Same policy for any future per-step temporaries (island scratch, etc.).

### 5.6 Macro-inline the hot vector math (measure first)
Every `b2Add/b2Sub/b2MulSV/b2Dot/b2Cross...` is a real function call
(~call+prologue+loads+ret ≈ 10–20 instructions of overhead around ~5 of
work). Function-like macros ARE supported. For the inner solver loops
(`b2SolveNormalPoint`, `b2SolveFrictionPoint`, warm start), a macro variant
(`B2_DOT(ax,ay,bx,by)`, or field-explicit inline math on locals) can
plausibly cut solver cost 30–50%. Do it **only** in the proven-hot paths,
only after the profiler exists, and keep the function versions as the
readable reference (macro use = deliberate optimization, commented as such).
Watch macro-arg double-evaluation (no statement-expressions here).

### 5.7 Precompute runtime-divided constants once
`FLT_EPSILON` is a division **every evaluation** (`1.0 / b2_two_pow_23`), and
it appears inside loops (GJK, normalize guards). Add a `b2InitConstants()`
called once by `b2CreateWorld` that fills globals (`b2_flt_epsilon`,
`b2_linearSlop`-derived tolerances, `staticSoftness` for the common dt), and
switch the macros to read the global. Divisions are also worth hunting in
inner loops generally (hardware float div is one instruction but slower than
mul on real-console implementations; on the emulator it's host-speed — don't
over-rotate, measure).

### 5.8 Memory-layout economies (only if RAM pressure appears)
Structs are word-per-field (a `bool` costs a word). `b2ContactSim` carries a
full `b2Manifold` (2 points × ~12 fields). Swap-removes `memcpy` whole
structs (word-counted, so cheap-ish, but nonzero). If heap pressure or copy
cost shows up: shrink `b2Manifold` points to the fields the solver actually
reads, pack flags into one int (already the style), and bump
`malloc_end_address` before first alloc for big worlds. `embedded` ROM
arrays are available for static level geometry (pre-baked polygons/hulls
loaded at compile time — zero RAM, zero init cost).

### 5.9 Static-tree quality
Many static shapes inserted incrementally → unbalanced static tree → slow
queries every pairing pass. Port `b2DynamicTree_Rebuild` (SAH) in Phase D and
call it once after level load. Cheap insurance for level-heavy games.

---

## 6. Roadmap — phased, each phase green-gated

Keep the discipline: one slice → new `Check()`s → build → **user reports
screen color** → update CLAUDE.md status + memory. Never stack two unverified
slices. The check numbering + `FIRST FAIL CHECK #N` display replaces
bisection — map N to the `Check(` call.

### Phase A — Solver fidelity (small slices, immediate)
1. ~~**`b2Atan2(0,0)` guard + stale-comment cleanup**~~ ✅ done & green (2026-07-04).
   Guard returns 0; 5 harness checks (incl. `b2Rot_GetAngle` of zeroed rot).
2. ~~**Restitution**~~ ✅ done & green (2026-07-04). `b2ApplyRestitution` post-substep
   pass + per-shape `friction`/`restitution` material plumbing (mixed at
   `b2UpdateContact`: friction `sqrt`, restitution `max`), `restitutionThreshold`=1.0.
   Test: restitution-0.8 ball peak-after-impact bracket [1.20,1.80] vs restitution-0
   control <1.10. Default restitution 0 keeps all prior scenes unchanged.
3. ~~**2-point manifolds under load**~~ ✅ done & green (2026-07-04). Spun box
   settles level on the 2-point floor manifold; 2-box dyn-on-dyn stack settles
   without sinking (B−A separation held). Verified existing machinery, no new
   port code. NOTE: harness split here (see §7) — `harness.c` is the frozen
   regression baseline through this slice; `harness2.c` holds active-dev checks
   from item 4 on. Run `harness2.v32` while iterating; re-run `harness.v32`
   periodically for the full regression.
4. ~~**Cross-step warm start (`b2StoreImpulses`)**~~ ✅ done & green (2026-07-04).
   `b2StoreImpulses` writes impulses back to the source contactSim manifold
   (new `contactIndex` on the constraint bridges the compacted array);
   `b2UpdateContact` snapshots prior impulses+ids and `b2MatchWarmStart` (2×2
   unroll) carries them into id-matched new points; `b2PreparePoint` seeds from
   the manifold. In `harness2.c`: 3-box stack holds + resting box shows positive
   stored impulse + `persisted`. (harness2.c is the active-dev suite now.)
5. ~~**Speed cap + motion locks**~~ ✅ done & green (2026-07-04). `b2IntegratePositions`
   now zeroes locked velocity components (`b2_lockLinearX/Y`/`b2_lockAngularZ`) and
   clamps linear→`world.maxLinearSpeed`(400) / angular→`B2_MAX_ROTATION·inv_dt`
   (sets `b2_isSpeedCapped`). Caps precomputed in `b2Solve`. harness2 checks all 3.
6. ~~**Contact teardown on body/shape destroy**~~ ✅ done & green (2026-07-04).
   `b2DestroyShapeInternal(world, shape, destroyContacts, updateBodyMass)` walks the
   body's contact-edge list and destroys any contact referencing the shape;
   `b2DestroyBody` tears down contacts → shapes(+proxies) → sim (was a no-op before).
   harness2 soak test: 20× create/collide/destroy/step, pairSet + contactIdPool +
   contactSims + bodyIdPool + shapeIdPool + dynamic-tree proxies all return to 0/1.
   Verified `b2BroadPhase_DestroyProxy` unbuffers the move (no stale-proxy freeze).
   DEFERRED: destroying ONE shape of a multi-shape body (filter path untested);
   joint/chain teardown still stubbed.

**★ PHASE A COMPLETE — all 6 solver-fidelity items green (2026-07-04).**
Functional physics now has: friction, restitution (per-shape material mixing),
2-point manifolds/stacking, cross-step warm start, speed cap + motion locks, and
safe body/shape/contact teardown. Harness split: `harness.c` = frozen regression
baseline; `harness2.c` = active-dev suite (items 2–6 checks live here).
**Resume at Phase B item 7 (profiler ROM) below.**

### Phase B — Performance foundations
7. ~~**Profiler ROM** (§5.1) + benchmark scenes committed.~~ ✅ done & verified
   (2026-07-04). `VirconBox2d/perf.c` + `perf.xml` → `bin/perf.v32`: 10/20/40 falling
   boxes (5-wide grid over a floor, 40 warmup + 4 measured steps), prints per-phase
   cycle counts via a frame-boundary-safe monotonic clock (`frame*250000+cycle`).
   **BASELINE (CPU cycles, avg/settled-step; budget = 250000/frame):**

   | Phase | 10 box | 20 box | 40 box |
   |---|--:|--:|--:|
   | CONTACTS | 10 | 20 | 40 |
   | PAIRING | 16,577 | 40,745 | 101,145 |
   | COLLIDE | 59,202 | 118,512 | 237,492 |
   | **SOLVE** | **272,758** | **562,478** | **1,178,013** |
   | TOTAL/STEP | 348,537 | 721,735 | 1,516,650 |
   | % of frame | 139% | 288% | 606% |

   **Read of the data:** (a) cost is ~linear in body count (10→40 ≈ 4.35×) — broad
   phase is not blowing up, good. (b) **SOLVE dominates: ~78% of every step.**
   COLLIDE ~16%, PAIRING ~6%. (c) Even 10 all-hot boxes exceed one frame (139%) —
   these are worst-case never-sleeping scenes; real games rely on sleeping (Phase C)
   + fat AABBs to keep most bodies cold. (d) The biggest measured lever is the
   **solver hot path** — §5.6 (macro-inline vector math, 30–50%) + §5.5 (kill the
   per-step `b2Alloc`/`b2Free`) + §5.7 (precompute constants) all land inside SOLVE.
8. ~~**Fat AABBs / EnlargeProxy** (§5.2).~~ ✅ **done & verified green (2026-07-04).**
   `b2Shape` gained `fatAABB` + `aabbMargin` (dynamic = `B2_MAX_AABB_MARGIN` 0.05, static =
   `B2_SPECULATIVE_DISTANCE`); tree stores the fat AABB; `b2FinalizeBodies` only `MoveProxy`s
   when the tight AABB escapes the stored fat one (`b2AABB_Contains`); `b2CreateShapeInternal`
   + `b2Body_SetTransform` re-fatten. Both harnesses green (behavioral, not bit-identical).
   SAFETY NOTE (in-code at the finalize site): skipping the move can't lose a resting contact
   ONLY because this port never destroys contacts on separation (the deferred `b2_simDisjoint`
   early-out) — REVISIT when Phase C adds disjoint-destroy/migration.

   **Measured (40 boxes, vs post-§5.6-collide):** PAIRING 101,145→**90** (proxies stop
   re-querying); **SOLVE 817,978→580,455 (−29%!)** — the big surprise: `b2FinalizeBodies`
   (inside SOLVE) was doing a tree remove+insert `MoveProxy` for EVERY body EVERY step (~29% of
   SOLVE), now skipped for settled bodies. COLLIDE 170,577→443,449 (+160%): the 0.05 margin makes
   near-but-not-touching boxes in a DENSE pile form non-touching pairs (CONTACTS 40→128) that each
   run a manifold — zero impulse (SOLVE unaffected by them) but real narrow-phase cost. Net TOTAL
   1,089,700→**1,023,994 (−6.0%)** on this worst-case dense all-hot pile; the ~338k gross saving
   (PAIRING + finalize-MoveProxy) shows fully on sparse/resting scenes + once sleeping lands.

   **NEW BASELINE (post §5.5 + §5.6 + fat AABBs):**

   | Phase | 10 box | 20 box | 40 box |
   |---|--:|--:|--:|
   | PAIRING | 90 | 90 | 90 |
   | COLLIDE | 92,029 | 209,105 | 443,449 |
   | SOLVE | 145,491 | 290,479 | 580,455 |
   | TOTAL/STEP | 237,610 | 499,674 | 1,023,994 |
   | % of frame | 95% | 199% | 409% |

8b. ~~**Disjoint early-out in `b2Collide`**~~ ✅ **done & verified green (2026-07-04).**
   Added `b2Shape.aabb` (tight + `B2_SPECULATIVE_DISTANCE`, refreshed every finalize + on create/
   SetTransform; radius is folded in via `b2ComputePolygonFatAABB` so it's general for rounded
   shapes). `b2Collide` tests `b2AABB_Overlaps(shapeA->aabb, shapeB->aabb)`; if disjoint it sets
   `pointCount=0` + clears `b2_simTouchingFlag` and SKIPS `b2UpdateContact` (keeps the contact --
   safe under no-disjoint-destroy). Provably equivalent to running the narrow phase: non-overlap
   ⟹ tight separation > 2·spec ⟹ `b2CollidePolygons` returns 0 anyway (2× cushion). Both harnesses
   green. **Measured: COLLIDE 443,449→204,014 (−54%, recovers the fat-AABB pair cost); 40-box TOTAL
   1,023,994→786,159 (−23%).**

   **NEW BASELINE (post §5.5 + §5.6 + fat AABBs + disjoint early-out):**

   | Phase | 10 box | 20 box | 40 box |
   |---|--:|--:|--:|
   | PAIRING | 90 | 90 | 90 |
   | COLLIDE | 48,679 | 100,439 | 204,014 |
   | SOLVE | 145,891 | 291,279 | 582,055 |
   | TOTAL/STEP | 194,660 | 391,808 | 786,159 |
   | % of frame | 77% | 156% | 314% |

   **★ SESSION CUMULATIVE (2026-07-04): 40-box step 1,516,650 → 786,159 = −48.2%** (profiler +
   §5.5 + §5.6 solver + §5.6 collide + fat AABBs + disjoint early-out, all green). 10-box now 77%
   (comfortable 60 fps); 20-box 156%; 40-box 314%.

   **Remaining broad-phase headroom / benchmark note:** COLLIDE (204k) is still ~34k above its
   pre-fat level because the fat margin keeps ~88 extra non-touching contacts alive (CONTACTS 128
   vs 40) that each pay a cheap per-step overlap test + one-time create. A fully-settled/sleeping
   scene (Phase C) removes them entirely. The perf grid spacing (1.05) also manufactures some;
   a wider-spaced benchmark would show a cleaner fat-AABB picture — benchmark follow-up, don't
   retrofit (keep the committed baseline comparable across slices).
9. ~~**Persistent solver scratch** (§5.5).~~ ✅ done & verified green (2026-07-04).
   `b2World` gained `constraintScratch`(void*)/`constraintScratchCapacity`; `b2Solve`
   reuses a grow-only scratch instead of `b2Alloc`+`b2Free` per step; freed once in
   `b2DestroyWorld`. Both harnesses stay green. **Measured: −195 cycles/step, CONSTANT
   across 10/20/40 boxes** (one malloc+free removed). => the console `malloc` free-list
   walk is only ~195 cyc here, so per-step heap traffic was never a real cost. Kept for
   the long-session anti-fragmentation benefit, not cycles.
10. **Constant precompute at world create** (§5.7). **DEPRIORITIZED after measuring §5.5.**
   On this emulator floats are host-speed, so precomputing `FLT_EPSILON` (a single divide,
   used world-independently by aabb/distance/manifold — risky to gate on world-create) and
   the softness (`b2MakeSoft` ×2/step ≈ 20 float ops) saves even LESS than §5.5's 195 cyc
   (i.e. noise). Fold into §5.6 (same hot-path edit, measurable together) OR skip until a
   real-console build where float div actually costs. Not worth cache fields + invalidation now.
10b. ~~**Inline the solver hot path** (§5.6)~~ ✅ **done & verified green (2026-07-04) — THE lever.**
   Inlined the vector-helper CALLS (b2RotateVector/b2Sub/b2Add/b2Dot/b2CrossSV/b2MulSV/
   b2MulSub/b2MulAdd/b2Cross/b2RightPerp) as field-explicit SCALAR math (no macros → no
   double-eval risk; the generic b2Vec2 helpers stay as the readable library) inside the
   contact-solve hot path: `b2SolveNormalPoint` (2×/substep — hottest), `b2SolveFrictionPoint`,
   `b2WarmStartPoint`, `b2ApplyRestitutionPoint`, + the per-contact `b2RightPerp`/`b2Sub` in
   `b2SolveContacts`/`b2WarmStartContacts`. Pure refactor (bit-identical), both harnesses green.
   **Measured SOLVE drop: −33%/−32%/−31% (10/20/40 boxes) = −359,840 cyc/step at 40 boxes,
   −23.7% of the whole step.** 40-box step: 1,516,455→1,156,615 cyc (606%→462% of frame).

   **NEW BASELINE (post §5.5+§5.6, CPU cyc, avg/settled-step):**

   | Phase | 10 box | 20 box | 40 box |
   |---|--:|--:|--:|
   | PAIRING | 16,577 | 40,745 | 101,145 |
   | COLLIDE | 59,202 | 118,512 | 237,492 |
   | SOLVE | 182,603 | 382,363 | 817,978 |
   | TOTAL/STEP | 258,382 | 541,620 | 1,156,615 |
   | % of frame | 103% | 216% | 462% |

10c. ~~**Inline the COLLIDE hot path** (§5.6 cont.)~~ ✅ **done & verified green (2026-07-04).**
   Inlined `b2FindMaxSeparation` (its 4×4 inner loop, called 2×/collide — densest) and all of
   `b2ClipPolygons` as scalar math. DIALECT-SAFE: only touched LOCAL b2Vec2 copies + the
   attested-green whole-struct variable-index copy form (`b2Vec2 v2 = poly2->vertices[j]`, same
   as b2ClipPolygons' pre-existing `v11 = poly1->vertices[i11]`); NO new `arr[j].x` value-index
   read introduced. harness.c's exact-value box-box manifold group green (bit-identical) +
   harness2 stacking green. **Measured COLLIDE drop: −28% across 10/20/40 boxes (−66,915 cyc/step
   at 40 boxes).** 40-box step now 1,089,700 cyc (435% of frame); 10-box now 241,732 (96% — the
   first scene to fit inside one frame). **Session cumulative: 40-box 1,516,650→1,089,700 = −28.1%.**

   **NEW BASELINE (post §5.5 + §5.6 solver + §5.6 collide):**

   | Phase | 10 box | 20 box | 40 box |
   |---|--:|--:|--:|
   | PAIRING | 16,577 | 40,745 | 101,145 |
   | COLLIDE | 42,552 | 85,172 | 170,577 |
   | SOLVE | 182,603 | 382,363 | 817,978 |
   | TOTAL/STEP | 241,732 | 508,280 | 1,089,700 |
   | % of frame | 96% | 203% | 435% |

   **Remaining §5.6 headroom (follow-up, same technique):** SOLVE's per-body-per-substep integrate
   passes (`b2IntegrateVelocities`/`b2IntegratePositions`) + `b2FinalizeBodies` + once-per-step
   `b2PrepareContacts`/`b2PreparePoint`; and `b2CollidePolygons`'s driver loops (localPoly build's
   `b2Sub`/`b2TransformPoint`/`b2RotateVector`, origin-undo `b2Add`) — those touch array-member
   WRITES so use the address-of-into-local-pointer form (`b2Vec2* dst=&lpA->vertices[i]; dst->x=...`),
   not direct `arr[i].x=` stores. Diminishing vs the two big loops already done.
   NOTE: the vertex-vertex branch of `b2CollidePolygons` (4 `fraction==0/1` cases) is still UNTESTED
   (pre-existing loose end) — this slice neither covers nor breaks it.

### Phase C — Structural (the big rocks; unlocks sleeping)
11. **Islands** (`island.c`): union of touching dynamic bodies; serial, so
    port the linking/splitting logic without the parallel machinery.
12. **Constraint graph** (`constraint_graph.c`): the coloring bitsets are
    `uint64_t` → rework to `b2BitSet` (already 32-bit, already green). Note:
    on a serial solver, coloring exists for determinism/ordering, not
    parallelism — consider the **simpler alternative**: keep the current
    "solve straight from awake contactSims" path and implement only the
    contact→island bookkeeping needed for sleeping. Decide based on how much
    `solver_set.c`/sleep-transition code assumes graph colors. Do not port
    SIMD-wide `contact_solver.c` paths — the scalar overflow path (already
    ported) is the model.
13. **Sleeping** (`solver_set.c` transitions): sleepTime accumulation,
    island-wide sleep, wake on contact/impulse/user set, sleeping-set
    create/destroy (the untested branch in `b2CreateBody` finally gets
    exercised). Tests: stack falls asleep (velocities exactly zero, profiler
    shows near-zero step cost), wakes on new collision.
14. **`b2Collide` iteration hardening** (the landmine at `b2_body.h:1032`)
    lands together with 11–13, since migration/destroy paths appear here.

### Phase D — Queries & continuous
15. ~~Shape ray casts + tree ray cast + world ray cast~~ ✅ **done & verified green
    (2026-07-04, pulled ahead of Phase C).** Shape casts `b2RayCastCircle/Capsule/
    Segment/Polygon` (geometry slice 2; polygon radius==0 fast path, radius>0 DEFERRED
    → needs `b2ShapeCast`). `b2DynamicTree_RayCast` (segment-AABB walk + separating-axis
    prune + nearest-child-first; `float(...)*` callback shrinks maxFraction; maskBits int;
    `b2TreeStats` out-ptr). `b2World_CastRayClosest(world, origin, translation, out)` →
    hit shapeId + world-space `b2CastOutput`; transforms the ray into each shape's local
    frame, dispatches by type, maps hit back to world, shrinks across trees. Harness2
    known-value coverage: exact fraction/point/normal for all 4 shape types, miss,
    maxFraction cutoff, initial overlap, capsule endpoint-cap, one-sided segment cull,
    closest-of-two, non-identity-rotation round-trip. DEFERRED: query filters (hits every
    shape), all-hits callback form (only closest), tree BOX cast, rounded-polygon cast.
16. `b2ShapeCast` + `b2TimeOfImpact` (distance slice 3), then bullets/
    continuous. Optional for many games; gate on demand.
17. `b2DynamicTree_Rebuild` (SAH) + `b2RotateNodes` balancing (§5.9).
18. ~~`b2MakeOffsetPolygon`/`b2MakeOffsetRoundedPolygon`, `b2TransformPolygon`~~ ✅ done &
    green (2026-07-04). Level-building helpers (place/rotate polygon shapes). Verified via a
    concrete anchor + the invariant `makeOffset(hull,pos,rot) == transformPolygon(makePolygon(hull))`.
    Remaining geometry (segment/chain makers) still as-needed.

### Phase E — Joints (port order adjusted: **distance FIRST** as the infra slice,
then revolute → prismatic → weld → motor → wheel; each is self-contained given the
solver base). Constraint softness machinery already exists (`b2Softness`). Joint
sims join the same awake-set pattern as contacts. Gate each on a known-value
harness scene (pendulum period bracket, distance-joint length hold, etc.).

**★ Slice 1 (joint CONNECTIVITY) done & verified green (2026-07-05).** New port
header `port/b2_joint.h`: `b2Softness`/`b2MakeSoft` RELOCATED here from `b2_solver.h`
(so `b2JointSim` can embed it ahead of `b2_body.h`, mirroring `b2ContactSim` in
`b2_contact.h`; `b2_solver.h` gets them back transitively — no behavior change).
Types: `b2JointEdge`, cold `b2Joint` (sparse, island fields stubbed NULL), dense
`b2JointSim` with an EMBEDDED `b2DistanceJoint` (NO union — dialect-unattested),
`b2JointEdgeAt` constant-index selector (`edges[2]` fixed-array-member trap).
`b2SolverSet` gained `jointSims`; `b2World` gained `jointIdPool`/`joints` (init/free
mirrored at all sites). `b2CreateJoint`/`b2DestroyJointInternal`/`b2CreateDistanceJoint`/
`b2GetJointSim` in `b2_body.h` mirror the contact create/destroy pattern (edge-list
linking with `(jointId<<1)|edge` keys, swap-remove-repair, id pool w/ preserved
generation). Set placement: either-disabled→disabled, neither-dynamic→static, else
awake. DEFERRED: island link, collideConnected contact-destroy (Phase F), constraint
graph, prepare/warm-start/solve (slice 2). harness2 groups: connectivity walk (emplace,
2-joints-on-one-anchor edge linking, swap-remove localIndex repair, static↔static→
static set) + 20× create/destroy soak (no leaks). Both harnesses green.

**★ Slice 2 (distance-joint SOLVE, rigid) done & verified green (2026-07-05).**
`b2PrepareDistanceJoint`/`b2WarmStartDistanceJoint`/`b2SolveDistanceJoint` + the
`b2PrepareJoints`/`b2WarmStartJoints`/`b2SolveJoints` type-switch dispatchers in
`b2_solver.h`, wired into `b2Solve`: joints prepared unconditionally, then per substep
warm-start/solve joints BEFORE contacts and relax joints before contacts (stage order per
`box2d/src/solver.c` serial overflow path lines 1074-1165). No `b2StepContext` — world/h/
inv_h passed explicitly; `states = awakeSet->bodyStates.data`; a local identity dummy
stands in for static/null bodies (gated on `index==B2_NULL_INDEX`, like the contact
solver). `constraintHertz=60`/`constraintDampingRatio=2.0` set at create; `b2PrepareJoints`
clamps hertz to `0.25*inv_h` and rebuilds `constraintSoftness` each step. RIGID branch only
(spring/limit/motor are independent `if` blocks, deferred; `enableSpring` defaults false so
rigid always runs). Tests (contact-free to isolate joint math): vertical length-hold (body
pulled up to hang exactly `length` below a static anchor) + pendulum (length invariant
mid-swing + settles straight down; `linearDamping=0.7` added since a rigid joint adds NO
tangential damping). Both harnesses green.

**DISTANCE JOINT COMPLETE (rigid).**

**★ REVOLUTE JOINT (hinge, point-to-point) done & verified green (2026-07-05).** Union
probe p11 → NO union support, so `b2JointSim` uses a NAMED member per type (`distanceJoint`,
`revoluteJoint`). Added `b2RevoluteJoint` payload + `b2CreateRevoluteJoint` (local-frame
origins = the pivot on each body) + `b2Prepare/WarmStart/SolveRevoluteJoint` — the 2×2
K-matrix point-to-point solve via `b2Solve22` — dispatched through the joint type-switch.
DEFERRED: motor / angle-limit / spring (independent `if` blocks, default off; add as a slice).
Test (contact-free): a box arm pinned at its left edge to a static anchor holds the pivot glued
to the anchor across the whole swing (hinge invariant, maxErr<0.05) and settles hanging straight
down (COM ~1 below pivot, q≈(0,-1)); `angularDamping=2.0` to settle fast.

**JOINT SCAFFOLD PROVEN — distance (rigid) + revolute (hinge) green.** Each new joint type is
now: add a named payload member + `b2Create*Joint` + prepare/warm-start/solve + a dispatcher
branch. Next: prismatic → weld → wheel → motor; OR the deferred per-joint motor/limit/spring
branches (ropes, powered hinges); OR a public `b2*JointDef`+defaults API; OR a joint demo ROM.

**★ PHASE E ESSENTIALLY COMPLETE (2026-07-05) — 5 joint types + full features + public API + demo,
all green.** Added this session, each green-gated:
- **weld** (rigid bind: 2×2 linear + scalar angular lock), **prismatic** (slider: perp+angular 2×2 +
  axial spring/motor/limit), **wheel** (suspension: perp line + axial spring + rotation motor + limits,
  free spin). Plus **revolute AND prismatic motor+limit+spring** branches (powered/limited hinges &
  sliders). `h`/`inv_h` threaded through `b2SolveJoints` for the motor torque-cap + limit speculation.
- **Dynamic-dynamic tests** (advisor catch): every prior joint test used a static body A (invMassA=0 →
  the A-side impulse code never executed). Added dyn-dyn distance (momentum transfer) + weld tests.
- **Public def API**: `b2*JointDef` + `b2Default*JointDef` + `b2Create*JointDef(world, def*)` for all 5
  types (b2BodyId-keyed) + `b2GetJointSimById` + `b2DestroyJoint`. Returns int jointId.
- **`joint_demo.c`/`.xml` → `bin/joint_demo.v32`**: live revolute rope (periodic whip) + motorized
  spinning bar, built with the def API, BIOS-font markers at 60 fps.
- Dialect finding: **`union` unsupported** (probe p11) → `b2JointSim` uses a named member per type.
- ⚠️ **KNOWN GAP**: `b2DestroyBody` tears down contacts/shapes but NOT joints — a jointed body destroyed
  leaves dangling joint edges/sims (likely fault). Fix (walk `headJointKey`, `b2DestroyJointInternal`
  each) before games destroy jointed bodies. Runtime setter fns + motor/filter joints deferred.

### Phase F — Filters, sensors, chains, events
19. Collision filters (`b2Filter` — categoryBits/maskBits/groupIndex; the
    query-filter check deferred in `b2World_OverlapAABB` and pairing).
20. Chain shapes + the three chain-segment collide functions (needs
    `b2ChainSegment` + `b2SimplexCache` arg plumbing — types exist).
21. Sensors, begin/end touch events, hit events — as a **polling API**
    (arrays the game reads post-step), not callbacks-during-step, to keep
    the solver reentrancy-free.

### Phase G — Packaging as a console library ("all modes" goal)
22. **Amalgamated public header** `virconbox2d.h` that includes the port
    headers in dependency order + a small doc header (heap advice, budget
    table from the profiler, LengthUnitsPerMeter guidance: keep world coords
    in meters ~0.1–10 sized bodies, scale to pixels only when drawing —
    e.g. 16 px per meter — never simulate in pixel units; Box2D tolerances
    assume meter scale).
23. **Demo game ROM** (the real acceptance test): player-controlled body,
    a level of static geometry, stacks, a raycast use, sleeping visible,
    running at 60 fps with cycle counter on screen. Lives in the repo next
    to `harness.c` as `demo.c` + its own xml.
24. Optional: `b2WorldId`-style multi-world registry (currently `b2World*`
    is passed directly — fine for the console; revisit only if API parity
    matters). Skip `recording*.c`, `world_snapshot.c`, `sensor.c` telemetry,
    `timer.c` (host-time), `scheduler.c`/`parallel_for.c` (serial loops
    already replace them) unless a concrete need appears.

**Remaining upstream mass** (for sizing): `physics_world.c` (112 KB — port
piecemeal per feature, never wholesale), `contact_solver.c` (80 KB but ~75%
is SIMD lanes — ignore), `solver.c` (71 KB — staging/parallel scaffolding
mostly done or skippable), `shape.c`/`body.c` (58 KB each — accessors land
with features), `dynamic_tree.c` (52 KB — slice 2 pending), `joint*.c`
(~160 KB total), `island.c` (24 KB), `solver_set.c` (20 KB),
`constraint_graph.c` (11 KB), `sensor.c` (12 KB).

---

## 7. Testing & verification contract (unchanged, binding)

- Screenshots/computer-use are **off**. The loop is: add checks → build →
  **ask the user to run the ROM and report the screen color** (and on red,
  the `FIRST FAIL CHECK #N` / values shown via `ShowInt`/`ShowFloat`).
- Do not build autonomous readback (memcard/DebugLog are proven dead ends).
- Never delete or renumber existing checks casually — the harness is the
  regression suite. Append new groups; keep `AllPassed` AND-ing.
- If the harness grows past ROM/compile-time comfort, split into
  `harness2.c` sharing the port headers (build.sh already parameterized),
  but only when forced — one cumulative suite has caught every regression
  so far.
- Physics-behavior checks: assert **brackets** (`y > 0.49 && y < 0.51`),
  not exact floats — hardware trig and accumulated float differ from
  upstream references. Compute expectations from first principles or from
  running upstream Box2D on the same scene, then widen for tolerance.
- For each new module: probe uncertain dialect constructs in `probes/`
  BEFORE building the slice on them (that discipline found the array-member
  miscompile and the float underflow — the two silent killers).

---

## 8. Risk register

| Risk | Likelihood | Mitigation |
|---|---|---|
| A dialect miscompile not yet discovered (beyond array-member indexing) | Medium | Probe-first discipline; keep slices small so red screens localize. |
| 250k cycles/frame too tight for target scenes | Medium | §5 playbook order: profiler → fat AABB → sleeping → 30 Hz mode → macro-inlining. Set expectations per-scene with the benchmark ROMs. |
| Constraint-graph port balloons (uint64 + solver_set entanglement) | Medium | Phase C decision point (§6.12): islands+sleep without full coloring if colors buy nothing on a serial solver. |
| Heap fragmentation over long play sessions (console malloc is a list allocator) | Low-Med | Persistent buffers (§5.5), grow-only arrays (already the style), heap enlargement guidance, soak-test ROM stepping 10k+ frames. |
| Hardware-fault class bugs (domain errors) reaching users | Medium | §1 guard sweep; add adversarial harness checks (zero vectors, degenerate polygons, huge velocities). Faults freeze silently — they will be blamed on the library. |
| Emulator/compiler version drift (tools are v26.04.24) | Low | Pin tool paths in build.sh (done); note version in CLAUDE.md; re-run probes after any tool update. |
| Determinism expectations (replays/lockstep netplay) | Low | Document single-machine repeatability only (§3); deterministic soft-float trig is possible later but expensive — explicit non-goal for now. |

---

## 9. Mechanical resume procedure (per session)

1. `cd VirconBox2d && bash build.sh harness` — must compile clean (green
   sanity build; if the Bash tool misbehaves, run the three tools via
   PowerShell exactly as `build.sh` does).
2. Pick the next roadmap item; read the upstream `.c`/`.h` in `box2d/`
   (read-only reference), port into `port/b2_<module>.h` per the conventions
   (out-pointer returns, unrolled temporaries, constant-index array-member
   access, word-counted memory, include guards).
3. Add hand-computed `Check()` cases; rebuild; **user verifies color**.
4. On green: update CLAUDE.md status table + the memory directory; tick the
   roadmap item here. On red: read `FIRST FAIL CHECK #N` off the screen and
   fix before anything else.
5. Leave breadcrumbs: every deliberate deviation from upstream gets a
   `DEVIATION:`/`DEFERRED:` comment at the site (existing style — grep for
   those words to inventory debt).
