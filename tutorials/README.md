# VirconBox2D — the tutorial course

A hands-on course for writing physics games on the Vircon32 console with VirconBox2D,
the port of Erin Catto's **Box2D v3**. It assumes you can already write and build a basic
Vircon32 C program, and nothing else — no physics background, no Box2D background.

Every lesson is three files:

- `lessonN_*.md` — the lesson text. Read it alongside the code.
- `lessonN_*.c` — a complete, runnable ROM, heavily commented.
- `lessonN_*.xml` — the ROM definition (boilerplate; identical shape in every lesson).

Lessons 1–7 draw with the BIOS font, so they need **no assets** and build anywhere — the
physics side is identical either way. Lesson 8 then switches the renderer to real textured
sprites (reusing the parent project's atlas) and shows that the physics code doesn't change.

## Building and running a lesson

```bash
cd VirconBox2d/tutorials
bash build.sh lesson1_hello        #  ->  bin/lesson1_hello.v32
```

Then open the `.v32` in the emulator:

```
E:\Soft\Vircon32\Emulator\Vircon32.exe bin\lesson1_hello.v32
```

## The course

| # | Lesson | You will learn |
|---|--------|----------------|
| 1 | [Hello, Gravity](lesson1_hello.md) | The whole shape of a physics game: create, step, read, draw. Worlds, bodies, meters vs pixels, the camera. |
| 2 | [Bodies and Materials](lesson2_materials.md) | Static vs dynamic bodies, boxes / balls / lines, friction, bounce, density. Teleporting with the setters. |
| 3 | [Making Things Move](lesson3_control.md) | Reading the gamepad and driving a body: impulses vs forces vs torque vs setting velocity — and when each is the right tool. |
| 4 | [Collisions](lesson4_events.md) | Touch events, reacting to contact, destroying bodies safely, and why dead handles don't crash. |
| 5 | [Ray Casts and Picking](lesson5_raycast.md) | Ground checks done right, lasers and line of sight, finding the body under a point. |
| 6 | [Joints](lesson6_joints.md) | Pins, ropes and motors: a wrecking ball and a drivable two-wheeled car. |
| 7 | [Beyond the Facade](lesson7_beyond.md) | Dropping down to the full `b2*` API: sensors, per-body gravity, and where to go next. |
| 8 | [Sprites and Textures](lesson8_sprites.md) | Retiring the BIOS font: the texture pipeline, atlas regions, and the rotozoom recipe that glues a sprite to a body — with the `angrybirds.c` demo as the full worked game. |

Do them in order — each lesson builds on the vocabulary of the previous one, and a couple of
deliberate "bugs" (like lesson 3's infinite mid-air jump) get fixed in a later lesson.

## Where to go afterwards

- [`docs/vb2.md`](../docs/vb2.md) — the complete reference for the easy API used in this course.
- [`docs/index.md`](../docs/index.md) — the full `b2*` API reference (shapes, joints, queries, events, movers).
- [`template.c`](../template.c) — a copy-me starter ROM that condenses this whole course onto one screen.
- [`angrybirds.c`](../angrybirds.c) — *Angry Blocks*, a complete sprite-rendered slingshot game (lesson 8's big sibling).
- [`SHOWCASE.md`](../SHOWCASE.md) — advanced patterns: 30 Hz physics with 60 fps interpolated rendering, a substep governor, a GPU-primitive renderer.
