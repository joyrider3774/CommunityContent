# Lesson 2 — Bodies and Materials

**Goal:** one scene, three experiments. A row of balls that bounce differently, a ramp that one
box slides off and another sticks to, and a cannon that fires two same-sized balls — one heavy,
one light — into a crate stack. By the end you'll know every kind of body the easy API creates,
and what the three material numbers actually mean.

**Files:** [`lesson2_materials.c`](lesson2_materials.c) · `bash build.sh lesson2_materials` ·
controls: **B** heavy shot, **X** light shot, **A** reset.

---

## The body catalogue

The easy API creates four kinds of body:

```c
int vb2_Wall( x, y, halfW, halfH );      // STATIC box   — never moves
int vb2_Line( x1, y1, x2, y2 );          // STATIC segment — a zero-thickness wall
int vb2_Box(  x, y, halfW, halfH );      // DYNAMIC box  — falls, collides, rotates
int vb2_Ball( x, y, radius );            // DYNAMIC circle
```

**Static** bodies are infinitely heavy and never move: floors, walls, platforms — the level.
They cost almost nothing at runtime, so use them freely.

**Segments** (`vb2_Line`) are static walls with zero thickness — ideal for slopes and terrain,
like this lesson's ramp. One caveat: they're one-dimensional, so a *very* fast small body can
tunnel through where a thick `vb2_Wall` would catch it. For the outer boundary of a level,
prefer thick walls.

**Dynamic** bodies are the movable things. Note that boxes *rotate*: drop one on a ramp and it
tips, tumbles, and comes to rest at whatever angle it lands. That's why this lesson introduces:

```c
float vb2_GetAngle( int body );          // radians, counter-clockwise
```

The grippy box on the ramp settles at the ramp's own angle (~ −24°), and the readout in the
corner proves it. Radians and counter-clockwise are the physics conventions throughout;
multiply by `57.29578` for degrees.

*(One body = one shape in the easy API. Multi-shape bodies, capsules and chains exist in the
full API — lesson 7 shows the door.)*

## The three material numbers

Each dynamic body has three knobs, set after creation:

```c
vb2_SetFriction( body, f );      // 0 = ice … 0.6 = default … 1+ = rubber
vb2_SetBounce(   body, r );      // 0 = clay (default) … 1 = perfect superball
vb2_SetDensity(  body, d );      // kg/m², default 1 — mass = density × area
```

### Friction — resisting sliding

Friction only matters where surfaces *slide* against each other. The ramp experiment isolates
it: two identical boxes, friction `0.02` vs `0.9`. The icy one accelerates down the slope and
shoots off the end; the grippy one grabs the surface and stays put. The physical rule of thumb:
a box sticks on a slope when its friction exceeds the slope's tangent (our ramp is ~24°,
tan ≈ 0.45 — so 0.9 sticks and 0.02 slides).

When two bodies touch, the engine combines their frictions as `sqrt(fA × fB)` — so ice sliding
on rubber is still slippery. That's why setting *one* body to near-zero friction is enough to
make it skate over everything.

### Bounce (restitution) — energy kept in a collision

`0` means a landing eats all vertical speed (a beanbag); `1` means it keeps all of it (bounces
back to the drop height, forever-ish). The bounce row makes the scale visible: 0.0 thuds, 0.5
takes a few decaying hops, 0.9 nearly returns to your hand.

Pairs combine as the **maximum** of the two — a superball bounces off dead concrete because
*its* 0.9 wins. So you only need to set bounce on the bouncy thing, not on every floor.

### Density — how much stuff is in there

Density × area = mass. The cannon experiment is the classic physics lecture: the heavy shot
(density 8, ~6.3 kg) and the light shot (density 0.2, ~0.16 kg) are the **same size** and fly
the **same arc** — mass does not change how a body falls (Galileo). What it changes is every
*collision*: the heavy ball plows through the bounce row and flattens the crate stack; the
light one taps the first thing it meets and bounces off.

Practical guidance: leave density at 1 for most things and adjust only for gameplay contrast
(a boulder vs a balloon). Extreme *ratios* between touching bodies (1000:1) are where any
physics engine gets shaky.

## Teleporting: the setters, and their one rule

This lesson's reset and cannon both use the write API:

```c
vb2_SetPosition( body, x, y );        // teleport, keeps rotation
vb2_SetAngle( body, radians );        // rotate in place
vb2_SetVelocity( body, vx, vy );
vb2_SetAngularVelocity( body, w );
```

`SetPosition` is a **teleport**: the body simply *is* there now. It does not travel through the
space in between, so it can't hit anything on the way, and if you park it overlapping something,
the solver will shove them apart next step. That makes teleports perfect for **spawning,
respawning and resets** — and wrong for normal movement (that's lesson 3's whole subject).

Two habits the reset function demonstrates:

- **A teleport keeps the old velocity.** Reset position without zeroing velocity and your
  "reset" ball arrives already moving. Reset both, plus angular velocity.
- **Fire = teleport to the muzzle + set velocity.** That two-line pattern is how you spawn any
  projectile from a reusable body. (Lesson 4 shows the create/destroy way.)

Also note where the parked cannonballs live: on a hidden static shelf **off-camera** — not
floating in mid-air (they'd fall) and not deleted (that's lesson 4). Bodies outside the camera
still simulate; the camera is only a window.

## Try it

1. **Ramp angle:** make the ramp steeper (change `RAMP_Y1` to `3.0`). Now even the grippy box
   slides — friction 0.9 loses to tan(33°+).
2. **Combine rules:** set the *floor's* bounce with `vb2_SetBounce` on the wall handle… wait —
   `vb2_Wall` returns a handle too, and materials work on static bodies! Make a trampoline
   floor (`0.9`) and watch even the "dead" ball bounce (max rule).
3. **Icy world:** set the floor friction to `0.0`. The crates you knock over now glide away
   forever — nothing brings them to rest horizontally except friction.
4. **A denser cannonball:** density 50. Notice it doesn't fly any *faster* — you set the same
   velocity. If you want equal *effort* to produce different speeds, that's an impulse, which
   is exactly lesson 3.
5. **Spin on launch:** add `vb2_SetAngularVelocity( shotHeavy, -30.0 )` when firing. With
   friction, spin turns into forward roll when it lands.

## Recap

- Four creators: `Wall` / `Line` (static level) and `Box` / `Ball` (dynamic things). Dynamic
  boxes rotate; read the angle with `vb2_GetAngle` (radians, CCW).
- **Friction** resists sliding (pairs mix as √(fA·fB)); **bounce** keeps collision energy
  (pairs mix as max); **density** sets mass (mass changes pushes, not falls).
- The `Set*` functions **teleport**. Use them for spawn / reset / fire; always zero velocities
  when resetting; never use them to "move" something through the world.

**Next:** [Lesson 3 — Making Things Move](lesson3_control.md): the gamepad, and the right way
to push bodies around.
