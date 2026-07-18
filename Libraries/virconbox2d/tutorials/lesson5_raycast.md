# Lesson 5 — Ray Casts and Picking

**Goal:** learn to ask the world geometric questions. A **ground check** finally fixes the
mid-air jump from lesson 3, a **laser** aims, stops on the first thing in its path, names it,
and cuts crates, and a **scanner** cursor shows the "what body is at this point?" query.

**Files:** [`lesson5_raycast.c`](lesson5_raycast.c) · `bash build.sh lesson5_raycast` ·
controls: **d-pad left/right** roll, **up/down** aim, **A** jump (grounded only!), **B** laser.

---

## What a ray cast is

```c
int vb2_RayCast( float x0, float y0, float x1, float y1 );   // closest body, or -1
```

Draw an imaginary line segment from `(x0,y0)` to `(x1,y1)`; the engine returns the **first**
body that segment touches — the closest one along the ray, not just any. It's the physics
equivalent of looking: line of sight, laser beams, bullets-as-hitscan, "is there floor under
me", "is there a wall between me and the exit".

The details of the hit land in a **hit record**, read through scalar accessors:

```c
float vb2_HitX();  float vb2_HitY();     // where the ray struck, world coords
float vb2_HitNX(); float vb2_HitNY();    // the surface normal there (unit length,
                                         //   pointing back toward the ray's origin)
float vb2_HitFraction();                 // 0 = at the start … 1 = at the far end
```

One rule about the record: it holds **the most recent cast's** result, so read it before you
cast again. The lesson's code is arranged around exactly that — the ground check casts first
(and only needs the returned handle), then the laser casts and reads its `HitX/HitY/HitNX/HitNY`
immediately. If you interleaved another cast in between, the laser would draw its beam to the
wrong hit point. (`vb2_BodyAt` doesn't touch the record — only `vb2_RayCast` writes it.)

The **normal** is the direction the struck surface faces — the laser draws a `*` tick pushed
out along it. Normals are what you reflect projectiles off, align decals to, and slide
characters along. `vb2_HitFraction()` gives distance for free:
`distance = fraction × length_of_your_segment`.

## The trap: a ray that starts inside a shape hits that shape

This is the one that bites everybody. A ray beginning inside a body reports a hit on *that
body* at fraction 0. Cast from your player's **center** — the obvious thing to do — and every
question comes back answered "you":

- The laser stops instantly on the player's own surface... or rather its origin.
- The ground check is grounded *forever*, even in free fall — infinite jump, again, but by a
  subtler route.

The fix is always the same: **start the ray on the surface, not at the center.** Both rays in
this lesson do it:

```c
// laser: muzzle = center + direction * (radius + a little)
float ox = px + dirX * ( PLAYER_R + 0.05 );

// ground check: from just BELOW the ball's underside
int ground = vb2_RayCast( px, py - PLAYER_R - 0.02,
                          px, py - PLAYER_R - 0.15 );
```

## The ground check, dissected

```c
bool grounded = ( vb2_RayCast( px, py - PLAYER_R - 0.02,
                               px, py - PLAYER_R - 0.15 ) != -1 );
...
if( gamepad_button_a() == 1 && grounded )
    vb2_ApplyImpulse( player, 0.0, 7.0 * mass );
```

Why these numbers: the ray starts 2 cm below the ball's lowest point (clear of its own surface)
and probes 13 cm further down. A resting ball hovers a few millimeters above the ground (the
solver keeps a tiny slop), so the probe must reach *past* that gap — but not so far that you
count as "grounded" half a meter above a crate. A probe of ~0.1–0.2 m is the sweet spot.

Why not use touch events? Lesson 4's events fire only when contact *begins* — a player standing
still produced its floor event long ago. The ray cast asks about **now**, every frame, which is
what a jump check needs. Events are "tell me when"; queries are "tell me whether".

Note also *what* the check hits: anything — floor, a crate, another player. Jumping off a
crate's lid works with zero extra code, because the question was "is something solid under me",
not "am I touching the floor body".

## Point picking

```c
int under = vb2_BodyAt( scanX, scanY );      // the body at a world point, or -1
```

The other query shape: not "along this line" but "at this point". The orbiting cursor turns
from `+` to `()` whenever a body is under it. Pair it with the camera's inverse mapping —

```c
float wx = vb2_WorldX( screenX );
float wy = vb2_WorldY( screenY );
```

— and you have mouse-style picking for any screen position: touch a crate on screen, get its
handle. (The lesson's cursor is already in world space, so it skips that step.)

## Destroying by query result

The laser cut reuses lesson 4's `vb2_Destroy` — note it needs no collect-pass here, because
we're destroying based on *one* returned handle, not iterating an event list. The
collect-then-destroy rule protects event *iteration*; a single query result you act on
immediately is fine (the world isn't stepped between the cast and the destroy).

## Try it

1. **See the self-hit.** Change the laser origin to `px, py` (the center). The beam now dies at
   fraction 0 — the hit is the *player itself* (which the label prints as `-> WALL`, since it's
   neither crate nor floor). Change it back.
2. **Watch the fraction.** Print `(int)( vb2_HitFraction() * 100.0 )` on the HUD — beam
   distance as a percentage. Aim at a far wall vs a near crate.
3. **Laser sight only:** make the laser destroy nothing, and instead draw the beam always,
   faintly (draw every 3rd dot). Now B becomes a *railgun*: on `== 1`, cast once and destroy.
   Same query, different fire discipline.
4. **Reflect:** one bounce — after a hit, compute the reflected direction
   `r = d − 2(d·n)n` using `vb2_HitNX/NY`, and cast a second, shorter beam from the hit point
   (nudged out along the normal — the *same* inside-a-shape rule applies to the bounce!).
5. **Coyote time:** keep a counter; set it to 6 when grounded, decrement otherwise, allow the
   jump while it's positive. Six frames of forgiveness after rolling off a ledge — a classic
   feel upgrade, and it's four lines.

## Recap

- `vb2_RayCast` finds the **closest** body along a segment; the hit record
  (`HitX/Y`, `HitNX/NY`, `HitFraction`) belongs to the most recent cast — read it before
  casting again.
- **Start rays on the surface**, never at a body's center — a ray born inside a shape hits it
  at fraction 0.
- Ground check = short downward ray from below the feet, probing ~0.15 m. Queries answer
  "what's true now"; events answer "what just happened".
- `vb2_BodyAt` picks a body at a point; `vb2_WorldX/Y` converts a screen point to feed it.

**Next:** [Lesson 6 — Joints](lesson6_joints.md): connecting bodies together — a wrecking ball,
and a car you can drive.
