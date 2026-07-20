# Lesson 1 — Hello, Gravity

**Goal:** drop a bouncy ball onto a floor. About 25 lines of real code — but they contain the
entire shape of every physics game you will ever write.

**Files:** [`lesson1_hello.c`](lesson1_hello.c) · build with `bash build.sh lesson1_hello` · run
`bin/lesson1_hello.v32` in the emulator.

---

## What a physics engine actually does

Without a physics engine, "a ball falls and bounces" means you write the ball's velocity,
acceleration, collision test against the floor, and bounce response yourself. That's manageable
for one ball — and becomes a research project the moment you want two balls that can hit *each
other*, or a stack of crates that doesn't sink into the ground.

A physics engine flips the arrangement. You *describe* the scene — "there is a floor here, a
ball there, gravity points down" — and then, sixty times a second, you say **step**, and the
engine moves everything one tick forward: applies gravity, detects collisions, resolves them,
handles friction and bounce. Your game never computes any motion. It only ever asks, after each
step, "so where is everything now?" and draws that.

That gives every physics game the same skeleton:

```
CREATE the world and bodies          (once)
loop forever:
    STEP the simulation              (advance 1/60 s)
    READ where bodies are now
    DRAW them
```

Keep that skeleton in your head; all seven lessons are just this loop with more interesting
things created before it and more interesting reactions inside it.

## The three lines that create a world

```c
vb2_Init();
vb2_Wall( 0.0, -7.0, 12.0, 0.5 );
int ball = vb2_Ball( 0.0, 6.0, 0.5 );
```

`vb2_Init()` creates **the world** — the container that owns every body, and knows the gravity
(default `(0, -10)`, i.e. downward at roughly Earth strength). A console game has exactly one
world, so the library keeps it implicit: you never pass it around.

`vb2_Wall(x, y, halfW, halfH)` creates a **static body**: a box that never moves, no matter what
hits it. Static bodies are your level — floors, walls, platforms. Note the *half*-extents: this
call makes a box 24 m wide and 1 m tall (more on that convention below).

`vb2_Ball(x, y, radius)` creates a **dynamic body**: a circle with mass, which falls under
gravity and collides with everything. The `int` it returns is a **handle** — your name for that
body from now on. You'll pass it to every function that asks or does something about the ball:

```c
vb2_SetBounce( ball, 0.7 );      // make it bouncy: 0 = thud, 1 = superball
```

Handles are plain ints on purpose: store them in your own structs and arrays, return them from
functions, compare them with `==`. `-1` means "no body".

## Meters, not pixels — the single most important habit

The physics world is measured in **meters**, with **y pointing up**. The screen is measured in
**pixels**, with **y pointing down**. These are different spaces, and your game constantly
translates between them. The translator is the camera:

```c
vb2_SetCamera( 0.0, 0.0, 20.0 );   // world (0,0) at screen center, 20 px per meter
```

and the four mapping functions — this lesson uses two of them:

```c
print_at( vb2_ScreenX( vb2_GetX( ball ) ),
          vb2_ScreenY( vb2_GetY( ball ) ), "O" );
```

`vb2_GetX/GetY` ask physics where the ball is (meters). `vb2_ScreenX/ScreenY` convert to pixels —
including flipping the y axis, so you never think about it.

> **Why not just work in pixels — 1 pixel = 1 meter?** Because Box2D's internal tolerances (how
> deep bodies may overlap before being pushed apart, ~0.005 m; how much slop the broad-phase
> allows, 0.05 m) are tuned for *human-sized objects*. A crate 20 *pixels* wide is fine; a crate
> 20 *centimeters* wide jitters and behaves badly. **Keep your objects between about 0.5 m and
> 5 m, and let the camera scale them up.** At this lesson's 20 px/m, the 640×360 screen shows a
> 32 m × 18 m window — a comfortable size for a screenful of gameplay.

## Half-extents

Every box in this library is specified by its **center** and its **half**-width/height, matching
Box2D itself. It reads oddly at first, but it earns its keep: the center is also the body's
position, so "is the crate left of me?" is one comparison, and drawing a sprite centered on the
body needs no offset math.

So the floor,

```c
vb2_Wall( 0.0, -7.0, 12.0, 0.5 );
```

is centered at `(0, -7)`, extends 12 m each way horizontally and 0.5 m each way vertically —
its top surface is the line `y = -6.5`. That's the line the code draws `=` along, and the line
the ball comes to rest on.

## Draw everything you create

Physics bodies are invisible. The engine will happily bounce your ball off a floor you never
drew — and the player will see a ball bouncing on nothing. The floor-drawing loop in this lesson
exists to make that point:

```c
float fx;
for( fx = -12.0; fx <= 12.0; fx = fx + 0.5 )
    print_at( vb2_ScreenX( fx ), vb2_ScreenY( -6.5 ), "=" );
```

We *know* where we put the floor, so we draw it from the same constants we built it from. Later,
when you forget this (everyone does once), the symptom is an "invisible wall" — remember this
lesson.

The lessons all draw with the BIOS font (`print_at`) so they need zero assets. A real game draws
sprites — but notice that the *only* thing the renderer ever needs from physics is
`vb2_GetX / vb2_GetY` (and, from lesson 2 on, `vb2_GetAngle`) plus the screen mapping. Physics
doesn't know or care what things look like.

## Step ↔ frame

```c
vb2_Step();     // advance the world by 1/60 s, once per frame
```

The Vircon32 displays exactly 60 frames per second, and `vb2_Step()` advances the world exactly
1/60 s, so calling it once per frame makes simulation time equal wall-clock time. Under the hood
each step runs 4 solver sub-steps — that's what makes stacks stable — but you never see that.

One rule: **step first, then read, then draw** (in this loop: step → `vb2_GetX` → `print_at`).
If you draw before stepping, you show where things were a frame ago.

## Try it

Run the ROM, then experiment — each of these is a one-line change:

1. **Gravity:** add `vb2_SetGravity( 0.0, -1.65 );` after `vb2_Init()` — moon gravity. Try
   `(3.0, -10.0)` for a constant wind.
2. **Bounce:** change `0.7` to `0.0` (dead drop), `0.95` (superball), `1.0` (bounces forever —
   almost: tiny numeric losses eventually win).
3. **Size:** make the ball radius `2.0`. Notice the *glyph* doesn't grow — physics and rendering
   are separate, and our renderer draws a fixed "O" regardless. Sprites have the same issue;
   always draw at the body's actual size.
4. **Zoom:** change the camera to `vb2_SetCamera( 0.0, 0.0, 40.0 )`. Same world, twice as large
   on screen. This is also how you'd do a camera that follows the player — feed its position as
   the center every frame.
5. **Miss the floor:** start the ball at `x = 20.0`. It falls past the floor's edge and drops
   forever. Nothing "catches" bodies that leave your level — lesson 4 shows how to notice and
   despawn them.

## Recap

- A physics game is **create → loop { step → read → draw }**.
- **Static** bodies are the level; **dynamic** bodies move. Handles are plain ints; `-1` = none.
- The world is **meters, y-up**; the screen is **pixels, y-down**; `vb2_SetCamera` +
  `vb2_ScreenX/Y` translate. Keep objects 0.5–5 m.
- Boxes take **half**-extents, centered on the body's position.
- Draw every body you create.

**Next:** [Lesson 2 — Bodies and Materials](lesson2_materials.md): more shapes, and what
friction, bounce and density actually do.
