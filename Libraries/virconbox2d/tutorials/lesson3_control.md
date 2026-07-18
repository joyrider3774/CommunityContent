# Lesson 3 — Making Things Move

**Goal:** drive a ball around an arena with the gamepad, using every movement tool the API has —
torque, impulse, force, and velocity override — and learn which one to reach for in each
situation. This is the lesson that turns "a simulation" into "a game".

**Files:** [`lesson3_control.c`](lesson3_control.c) · `bash build.sh lesson3_control` ·
controls: **d-pad** roll, **A** jump, **B** jetpack, **X** dash.

> This lesson ships a bug **on purpose**: you can jump in mid-air, forever. Fixing it needs a
> *ground check*, and an honest ground check needs a ray cast — that's lesson 5. Until then,
> enjoy the flight.

---

## The four movement tools

The whole subject of this lesson fits in one table:

| Tool | Call | When it acts | Use it for |
|------|------|--------------|-----------|
| **Impulse** | `vb2_ApplyImpulse(b, ix, iy)` | Instantly, once | Jumps, recoil, explosions, knockback |
| **Force** | `vb2_ApplyForce(b, fx, fy)` | Over time — call it **every frame** you want it | Thrust, wind, magnets, car engines |
| **Torque** | `vb2_ApplyTorque(b, t)` | Over time, rotational | Rolling a ball, spinning things up |
| **Velocity override** | `vb2_SetVelocity(b, vx, vy)` | Replaces motion outright | Dashes, conveyors, cutscene moves |

And one from last lesson that is **not** a movement tool: `vb2_SetPosition` teleports. If you
move a body by setting its position every frame, it never has a velocity, so it can't push
anything, can't be pushed, and tunnels through walls. Spawn with it; never steer with it.

### Impulse: pay momentum once

An impulse is an instant change of *momentum*: `impulse = mass × Δvelocity`. The jump

```c
vb2_ApplyImpulse( player, 0.0, 6.0 * mass );
```

adds exactly 6 m/s of upward speed, whatever the ball weighs. That `* mass` is a habit worth
copying: scale pushes by `vb2_GetMass(body)` and the *feel* of your controls survives any later
change to the body's size or density. (Tune the jump by asking "how many m/s?" — with gravity
−10, a +6 m/s jump rises 6²⁄20 = 1.8 m and hangs in the air 1.2 s total.)

Impulses pair with **edge-detected** input — `gamepad_button_a() == 1` is true only on the frame
the button went *down*. If you applied the jump impulse on `> 0` (held), you'd add 6 m/s *per
frame* — 360 m/s² of acceleration — and leave the planet.

### Force: pay acceleration continuously

A force acts for one step and is forgotten, so a jetpack is a force applied **every frame the
button is held** (`> 0`, not `== 1`):

```c
if( gamepad_button_b() > 0 )
    vb2_ApplyForce( player, 0.0, 18.0 * mass );
```

Sanity-check forces against gravity: gravity pulls with `mass × 10`, so `mass × 10` of thrust
hovers exactly, and `mass × 18` climbs at a net 8 m/s². Watch the VY readout on the HUD while
you feather the button — that's force integrating into velocity, live.

### Torque: rolling, and why it needs the ground

The d-pad doesn't push the ball — it *spins* it:

```c
vb2_ApplyTorque( player, 6.0 );     // positive = counter-clockwise = rolls LEFT
```

Spin becomes motion only through **friction against the ground** (that's why the player's
friction is set to 0.9). The moment you're airborne, torque just makes the ball spin in place —
so the code adds a small direct force alongside it for air control. Try commenting that force
out: ground movement is unchanged, air control disappears. This split (torque on the ground,
force in the air) is a standard rolling-character recipe.

The sign convention trips everyone once: positive torque is counter-clockwise (the math
convention), and a counter-clockwise-spinning ball rolls **left**. Hence `+6` for left, `-6`
for right.

### Velocity override: stepping outside physics

```c
vb2_SetVelocity( player, 14.0 * facing, 0.0 );
```

The dash doesn't *add* to your motion — it **replaces** it. Falling? Not anymore; the `0.0`
vertical component erases your fall for that instant. That's exactly why it feels so snappy and
"gamey": it ignores momentum. Overrides are the right tool when the design wants a guaranteed
outcome (dash at exactly 14 m/s; conveyor carries at exactly 2 m/s) — and the wrong tool for
basic movement, where they make the body feel weightless and stop it from trading momentum
honestly with the crates.

Speaking of the crates: they're density 2 — heavier than you. Notice you *can* shove them, just
slowly (force applied over time), while dashing into them barely nudges them but stops *you* —
momentum exchange working as it should.

## The input idioms

Everything above leaned on two Vircon32 input patterns; they're worth naming:

```c
if( gamepad_button_b() > 0 )    // HELD  — for forces/torque, applied every frame
if( gamepad_button_a() == 1 )   // JUST PRESSED — for impulses and one-shot actions
```

The gamepad functions return the number of frames the control has been held (and negative
values after release), so `== 1` is a free edge detector. Call `select_gamepad( 0 )` once before
reading anything.

## Try it

1. **Break the jump on purpose:** change the jump to `> 0` and hold A. Understand what you see,
   then change it back.
2. **Hover:** change the jetpack force to exactly `10.0 * mass`. The ball should hang nearly
   still (tiny drift is the solver, not a bug). Now try `9.9` and `10.1`.
3. **Heavy player:** `vb2_SetDensity( player, 5.0 )` after creating it — then update `mass`
   (query it *after* the density change; the code already reads it once at startup, so move the
   read). Because every push is scaled by mass, the controls feel identical — but now *you*
   plow through the crates. That's the whole argument for mass-relative tuning.
4. **Ice physics:** set the player's friction to `0.05`. Torque now barely grips — roll is
   useless, and you're steering on force alone. Air control everywhere, effectively.
5. **A speed cap:** after input, if `vb2_GetVX(player)` exceeds ±12, `vb2_SetVelocity` it back
   to ±12 (keep VY!). A legitimate, common use of the override.

## Recap

- **Impulse** = instant momentum (once, `== 1`); **force/torque** = continuous acceleration
  (every frame, `> 0`); **SetVelocity** = override, use deliberately; **SetPosition** = never
  for movement.
- Scale pushes by `vb2_GetMass` so controls survive size/density changes.
- Torque needs ground friction to become motion; give rolling characters grip, and a small
  force for air control.

**Next:** [Lesson 4 — Collisions](lesson4_events.md): finding out what hit what, and making
things *die*.
