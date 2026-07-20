# SHOWCASE.md — the MEGADEMO ROM, its architecture, and every trap it survived

`showcase.c` + `showcase.xml` → `bash build.sh showcase` → `bin/showcase.v32`.
Interactive physics showcase exercising every green subsystem of the port at
once. This doc exists so a future session (or Opus, mid-roadmap) can extend,
fix, or retune it without re-deriving the tricky parts. **Read the "port-seam
workarounds" section before touching anything** — several lines exist only to
compensate for known port gaps and must be REMOVED when those gaps close.

Written 2026-07-06, user-verified: flicker-free, 60 fps interpolated render,
graceful degradation at 100% CPU during contact storms.

---

## 1. What's in the scene

| Thing | Bodies | Demonstrates |
|---|---|---|
| Floor, 2 walls, ceiling, jump ramp | 5 static | static geometry, rotated static box (ramp) |
| **Car** (D-pad drives) | chassis + 2 wheels | wheel joints: suspension spring 4 Hz / damping 0.7, travel limit ±0.3, motors ±28 rad/s, torque 34; `collideConnected=false` keeps wheels out of the chassis |
| **Spinner** | static hub + bar | revolute joint motor (4 rad/s, 400 N·m) |
| **Wrecking ball** (X kicks; auto-kick at loop 150) | shapeless static anchor + ball (density 5) | rigid distance joint, shapeless anchor body, velocity poke + wake |
| **Tower** (5 gold boxes at x=5.3) | 5 dynamic | stacking, **sleeping** (dim + "z"), wake-on-collision |
| **Spawner** (A) | ≤ 6 recycled | live `b2DestroyBody` mid-sim, materials (restitution 0.85 balls vs 0.05 crates) |
| **Laser** (hold B) | — | `b2World_CastRayClosest`, beam + hit spark |
| **Gravity flip** (hold Y) | — | runtime gravity poke + wake-the-world; force-field line at ceiling |
| **Rescue** (Start) | — | `b2Body_SetTransform` teleport (car back to start, upright) |
| HUD | — | FPS, AWAKE/total, SUBSTEPS governor state, step-cycle bar (tick = 500k budget) |

World→screen: `ORIGIN_X 320 / ORIGIN_Y 330 / PPM 24`, y-up world. Arena spans
x ∈ [−13.3, 13.3], floor top at y=0, ceiling catcher at y≈14 (mostly
off-screen). `world.enableSleep = true` (the Phase C opt-in).

---

## 2. The renderer (asset-free GPU primitives — first ROM to do this)

No textures. Everything is the **BIOS white pixel** (texture −1, region 256 —
needs BIOS ≥ 1.1, which the emulator has) stretched/rotated by the GPU, plus
`draw_primitives.h` for lines/circles. Colors via `set_multiply_color`.

**Solid rotated box** (`DrawWorldBox`) — the core trick: stretch the pixel to
the full box size with `set_drawing_scale(2hx·PPM, 2hy·PPM)`, rotate with
`set_drawing_angle`, draw with `draw_region_rotozoomed_at`. Two subtleties:

1. **The hotspot is the box corner, not its center.** The drawing point must
   be backed out from the center along the rotated axes:
   `P = C − Rφ·(hx, hy)` in screen space.
2. **Screen y is flipped vs world y**, so a world rotation `(c, s)` becomes
   screen rotation `cos φ = c, sin φ = −s`, i.e. `set_drawing_angle(atan2(−s, c))`.
   The GPU's angle convention is *screen*-space (x right, y down) — the same
   convention `draw_line` uses internally. If boxes ever appear to
   counter-rotate, this mapping is the first suspect.
   (`atan2` is safe here: a valid `b2Rot` is never (0,0).)

**Polygons are assumed to be `b2MakeBox` boxes**: half extents are read from
`shape->polygon.vertices[2]` (== (+hx,+hy), constant index — dialect-safe).
If you ever add a non-box polygon, extend `DrawAllBodies` with an outline path
(transform each vertex, `draw_line` the edges) — do NOT variable-index
`vertices[i].x` directly (miscompile trap); copy `b2Vec2 v = poly->vertices[i];`
whole-struct first (attested-green form).

**Circles**: `draw_filled_circle` + a half-tone "spoke" line from center to
`center + R(q)·(r,0)` so rotation is visible. Cost ~1 scanline draw per pixel
of radius — fine at these sizes.

Bodies are drawn by walking the sparse `world.bodies` array (slot live iff
`body->id != B2_NULL_INDEX`) and each body's shape list; `b2GetBodySim` works
for every set (static/awake/sleeping). Sleeping ⇒ RGB divided by 3 + "z" glyph.
Per-body colors live in `gColR/G/B[64]` indexed by raw body id — parallel
**scalar** arrays because variable-indexing a global array of *structs* is
dialect-unattested.

---

## 3. Frame & timing architecture (the hard-won part)

### 3.1 The black-flicker lesson (NEVER reorder this)

The emulator presents the framebuffer at **every 60 Hz tick regardless of
where the CPU is**. If `clear_screen`+drawing straddles a tick, a half-drawn
(mostly black) frame is displayed. The original `step → clear → draw →
end_frame` loop flickered exactly when step+render exceeded 250k cycles.
**Invariant: the expensive physics step only runs while a COMPLETE picture
sits in the framebuffer.** Draw first, step after. Any future restructuring
must preserve this.

### 3.2 30 Hz physics / 60 fps interpolated render (plan item P2.6, proven here)

Each loop = one `dt = 1/30` step + **two** display frames (the BadApple
double-`end_frame` idiom):

```
input →
FRAME A: DrawScene(alpha=1.0)          // current state S_k, ~40-60k cyc
         SnapshotPoses()               // prev := S_k
         b2World_Step(dt=1/30, gSubSteps)   // S_k -> S_k+1, the expensive part
         end_frame()                   // tick presents complete frame A
FRAME B: DrawScene(alpha=0.5)          // every pose lerped S_k -> S_k+1 halfway
         end_frame()                   // tick presents the in-between frame
```

Displayed sequence: `S_k, lerp(S_k,S_k+1,½), S_k+1, …` — motion updates every
1/60 s, physics costs 30 Hz, and each step has a 500k-cycle budget.

- **You CANNOT use the port's `center0`/`rotation0` for interpolation.** They
  are an upstream-faithful TOI baseline that `b2FinalizeBodies` resets to ==
  current at the END of each step (`port/b2_solver.h` ~187). The demo keeps
  its own snapshot (`gPrevX/Y/C/S[64]`, scalar arrays), taken in
  `SnapshotPoses()` right before the step. If a future library-side interp
  helper is wanted (P2.6), it needs the same idea or a deliberate, documented
  change to when finalize advances that baseline.
- Rotation is **nlerp**: lerp `(c,s)`, renormalize (`GetPose`). Plain lerp
  visibly shrinks fast-spinning bodies (a wheel at 28 rad/s covers ~0.9
  rad/step — lerped magnitude would dip ~11%).
- `alpha = 1.0` short-circuits to the current pose, so frame A pays no interp.
- Teleports don't smear: Start-rescue runs in the input phase, *before*
  `SnapshotPoses`, so frame B never lerps across a teleport.
  `b2Body_SetTransform` also refreshes its own center0 — irrelevant here, but
  keep rescue in the input phase if you move code around.

### 3.3 Input at 30 Hz loops

Gamepad button counters tick at **60 Hz** but the loop samples every 2 frames:
"just pressed" must be `count == 1 || count == 2` (a plain `==1` misses every
other press). Held checks (`> 0`) are unaffected. If the loop rate ever
changes again, revisit every edge test.

### 3.4 The adaptive governor (why 100% CPU no longer stutters)

Contact storms (ball impact + gravity-flip pile) push a 4-substep step past
500k cycles → frame slip → stutter. Two-layer degradation:

1. **Substep governor**: after each step, if `stepCyc > 340k` shed one substep
   (min 2); if `< 200k` restore one (max 4). Substeps are the Box2D v3
   quality/cost dial (cost ~linear); contacts go slightly softer exactly when
   the screen is chaos. HUD shows the current value (`SUBSTEPS n`).
   Hysteresis gap (340k/200k) prevents oscillation.
2. **Frame-B skip**: after `end_frame()` #1, if the loop has already consumed
   ≥ 400k cycles (i.e. the step blew through both display slots and end_frame
   returned late), skip DrawScene(0.5) + its end_frame entirely — the display
   holds frame A one extra tick (a 30 fps moment) instead of slipping the
   whole timeline to 20 fps.

Timing uses `CycNow()` — the frame-boundary-guarded monotonic clock
(`frame*250000 + cycle`, double-read guard) from perf.c.

**Perf reality check**: ~15 hot bodies in full contact is genuinely near the
15 MHz ceiling. The port-side levers that raise it are on the plan: §0.5 V1/V2
(de-call the solver hot path) and P0.2 (contact destroy). Rerun this demo
after those land — the SUBSTEPS readout dipping less IS the measurement.

---

## 4. Port-seam workarounds — DELETE THESE WHEN THE PORT CATCHES UP

Each is tagged in-code with the plan finding it compensates for
(PLAN_FOR_OPUS.md Part 0). When a P0/P1 slice lands, sweep this file:

| Workaround in showcase.c | Compensates for | Replace with (when) |
|---|---|---|
| `WakeBody()` helper (manual `b2WakeSolverSet`) | no public wake API | `b2Body_Wake` (P1.1) |
| `PokeVelocity()` writes `bodyStates` directly | no velocity/impulse API (F7) | `b2Body_SetLinearVelocity` / `ApplyLinearImpulse` (P1.1) |
| `SpawnDrop`: `WakeBody` **before** `b2DestroyBody` | `wakeBodies` ignored (F2) — destroying a body inside a sleeping pile leaves the rest floating | delete the wake once P0.1 honors `wakeBodies` |
| `RescueCar`: `PokeVelocity(0)` **before** `SetTransform` | `SetTransform` doesn't wake (F3) | delete once P0.1 wakes in SetTransform |
| `WakeAll()` on gravity flip AND unflip | gravity change never wakes sleepers (upstream doesn't either — games are expected to wake; keep unless the port adds a gravity-wake) | probably keep |
| Motor drive calls `WakeBody(&gCarId)` when input ≠ 0 | a sleeping car's joints are in a sleeping set — motor values are poked but not solved | keep until joints auto-wake on motor enable (upstream wakes via `b2Joint_WakeBodies`; P1.1-adjacent) |
| Laser hits ANY shape incl. the car's own wheels at some angles | no query filters (F8) | pass a `b2QueryFilter` once P1.2 lands |
| No landing/impact feedback | no begin-touch events (F9) | poll `beginTouchEvents` for a flash/sound (P1.3) |

Also watch: **the demo is an unintentional soak test.** With F1 (contacts
never destroyed on separation) the contact population only grows — bounded
here because the scene has ≤ ~23 shapes (≤ a few hundred pairs), but after
P0.2 lands, the AWAKE-idle step cost should drop measurably in long sessions.
And **F5** (empty sleeping-set leak): recycling a body that fell asleep leaks
one empty solver-set slot per occurrence — harmless at demo scale, gone after
P0.3.

**Island coarseness note (P2.1)**: after the wrecker scatters the tower,
everything it touched is ONE island (merge-only islands) — the pile re-sleeps
only when ALL of it settles, and the AWAKE counter shows it. When
`b2SplitIsland` lands, expect faster/finer re-sleeping here with zero demo
changes — another built-in before/after measurement.

---

## 5. Dialect traps this file actively avoids (don't reintroduce)

- **Parallel scalar arrays** instead of arrays of structs for anything
  variable-indexed (`gColR/G/B`, `gPrevX/Y/C/S`, spawn ring `gSpawnIdx1`/
  `gSpawnGen`). Global/local FIXED arrays of scalars with variable index are
  attested green (demo.c precedent); arrays of structs are not.
- `polygon.vertices[2]` — constant index only. For loops over vertices, copy
  whole-struct into a local first.
- No ternaries, no `f` suffixes, no compound literals, out-pointer returns,
  functions defined before use (single translation unit).
- `asm{}` only via `SelectWhitePixel()` (2 lines, matches §9.1 of the dialect
  doc). If you add asm intrinsics for speed, probe p13 rules apply.
- Struct assignment (`b2BodyId` into def fields etc.) is fine — it's
  parameters/returns that can't be multi-word.
- Shapeless static bodies (rope anchor) are legal and cheap.

---

## 6. Tuning table (every magic number in one place)

| Constant | Value | Where / feel |
|---|---|---|
| PPM / origin | 24 px/m, (320, 330) | whole-arena framing |
| Car chassis | half 1.1×0.3, density 0.6, friction 0.4 | light enough to jump the ramp |
| Wheels | r 0.4, density 1.2, friction **1.4** | grip; lower ⇒ burnouts |
| Suspension | hertz 4.0, damping 0.7, limits ±0.3 | upstream car-sample values |
| Motor | speed ±28 rad/s, torque 34 | top speed ~11 m/s; raise torque for hill starts |
| Ramp | (−6.5, 0.55), half 2.0×0.2, angle +0.22 rad | jump lands near the spinner |
| Spinner | hub (1.5, 3.3), bar half 1.05×0.13, motor 4 rad/s, torque 400 | low tip y≈2.25: driving car passes under, jumping car gets batted |
| Tower | x 5.3, 5 boxes half 0.45, rows y = 0.46 + 0.91i | sleeps in ~1–2 s |
| Wrecking ball | anchor (8.6, 7.6), rope 4.6, r 0.55, density 5, kick (−11, 2.5) | arc bottom y≈3.0 hits tower rows 3–4 |
| Spawner | cap 6, drop y 12.6, alternating ball/crate/ball | cap is the hot-body budget knob — reduce to 4 if a future scene runs hot |
| Gravity flip | +7.0 up (vs −10 down) | floaty rise, hard rain |
| Governor | shed >340k, restore <200k, substeps 2..4; frame-B skip ≥400k | retune if the budget model changes (e.g. 60 Hz physics) |

---

## 7. Ideas backlog (when the port grows)

- **Contact events (P1.3)** → impact flashes; `audio.h` thuds (first sound in
  the project — ROM stays asset-free with generated waveforms? memcard? just
  use a square-wave `define_sound` if desired).
- **Filters (P1.2)** → laser ignores the car; drop "ghost" bodies that only
  collide with the floor.
- **Prismatic elevator platform + weld structures** — two joint types the
  scene doesn't show yet; an elevator the car can ride is one static rail +
  one platform + a motorized prismatic joint.
- **Kinematic moving platform (P2.5)** — the untested body type, visible.
- **b2Body API dogfood (P1.1)** — replace every internals poke in this file;
  the demo compiling clean with ZERO `solverSets`/`bodyStates` mentions is the
  acceptance test that the API is complete.
- **Chain-shape terrain (P3)** — replace the flat floor with rolling hills.
- **perf HUD+** — per-phase (pairing/collide/solve) bars once V6's
  `b2World_GetStepCycles` lands, replacing the demo's own `CycNow()` math.
- **Camera** — fixed today; a scrolling camera is pure render math (offset
  ORIGIN_X by car x), physics unaffected. Enlarge the arena when done.

## 8. Verification contract for changes

Same as the port: the user runs the ROM and reports. For the showcase the
"green" is visual: no black flicker at any point, smooth motion (no 30 Hz
stutter), SUBSTEPS returns to 4 when calm, sleeping tower dims, all six
buttons do their thing, and the cycle bar stays left of the tick except
during deliberate chaos. Any physics-behavior doubt → add a `Check()` to
harness2 instead of eyeballing it here; the showcase is a demo, not the
regression suite.
