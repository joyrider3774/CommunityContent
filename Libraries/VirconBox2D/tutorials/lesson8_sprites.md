# Lesson 8 — Sprites and Textures

**Goal:** retire the BIOS font. This lesson draws the physics world with **real sprites from a
texture atlas** — and because sprites can rotate, you finally get to *see* what the engine has
been simulating all along: roll into the crate castle and every block tumbles with its sprite
glued on, at the exact angle physics says.

The full game built from this lesson's recipes is [`angrybirds.c`](../angrybirds.c) — *Angry
Blocks*, a complete slingshot demo in the project root (`bash build.sh angrybirds` from
`VirconBox2d/`). The lesson code is the distilled version; the second half of this text is a
guided tour of the demo.

**Files:** [`lesson8_sprites.c`](lesson8_sprites.c) · `bash build.sh lesson8_sprites` ·
controls: **d-pad** roll, **A** jump, **START** reset. Hit the pig fast to squash him.

---

## Recipe 1: the texture pipeline

Nothing about physics changes in this lesson. What changes is that the ROM now carries an
**asset**, and assets have a pipeline:

```
textures/Texture-AngryBirds.png     the source image (any PNG, up to 1024x1024)
        │  png2vircon                (tutorials/build.sh runs this for you)
        ▼
obj/Texture-AngryBirds.vtex         the console's texture format
        │  packrom                   (listed in the ROM XML)
        ▼
bin/lesson8_sprites.v32
```

The one visible difference from earlier lessons is in the XML — the `<textures>` element is no
longer empty:

```xml
<textures>
    <texture path="obj/Texture-AngryBirds.vtex" />
</textures>
```

At runtime, cartridge textures are numbered in the order the XML lists them: our single texture
is **texture 0**, and `select_texture( 0 )` makes it the one subsequent drawing uses. (The BIOS
font lives in its own separate texture, which is why `print_at` keeps working for the HUD with
no conflict.)

The atlas this course uses is the *BasicPlatformer* sheet by Carra, from the Vircon32 console
software — packed unchanged; we just point rectangles at it.

## Recipe 2: regions — one atlas, many sprites

You don't draw "a texture"; you draw a **region** — a named rectangle of it. At startup, once:

```c
select_texture( 0 );
select_region( R_CRATE );   define_region_center( 1,342,  40,381 );
select_region( R_GRASS );   define_region_topleft( 41,302, 80,341 );
```

Each region gets a slot number (the `R_*` defines are ours — pick any ids), a pixel rectangle
in the atlas, and — the important part — a **hotspot**: the point of the region that lands on
the coordinates you later draw at. Two conventions, used deliberately:

- **`define_region_center`** for anything glued to a physics body. The body's position *is* its
  center, so a center hotspot means `draw at vb2_ScreenX/Y( body position )` with **zero offset
  math** — compare the `-4`/`-5` pixel nudges every earlier lesson needed to center a glyph.
- **`define_region_topleft`** for background tiles, which you place on a pixel grid like graph
  paper.

## Recipe 3: the rotozoom — a sprite glued to a body

The single most important function in this lesson, and the one to copy into your own game:

```c
void DrawBodySprite( int body, int region, float halfW, float halfH )
{
    if( vb2_Exists( body ) == false )
        return;

    select_texture( 0 );
    select_region( region );
    set_multiply_color( color_white );

    set_drawing_angle( -vb2_GetAngle( body ) );                    // TRAP 1

    set_drawing_scale( 2.0 * halfW * PPM / SPRITE_PX,              // TRAP 2
                       2.0 * halfH * PPM / SPRITE_PX );

    draw_region_rotozoomed_at( vb2_ScreenX( vb2_GetX( body ) ),
                               vb2_ScreenY( vb2_GetY( body ) ) );
}
```

Position from the body, rotation from the body, size from the body's half-extents — the sprite
cannot drift from the physics because everything is derived per frame. The two traps:

1. **Negate the angle.** Physics angles are counter-clockwise-positive (math convention); the
   screen's y axis points down, which mirrors rotation, so drawing angles come out
   clockwise-positive. `-vb2_GetAngle( body )` reconciles them. Forget the minus and everything
   spins backwards — comical on the rolling player, subtle-and-wrong on a slowly settling crate.
2. **Scale is a ratio: wanted pixels ÷ native pixels.** The body is `2 × half` meters across,
   which is `2 × half × PPM` pixels on screen; the atlas sprites are 40 px (`SPRITE_PX`).
   A 1×1-half crate at 20 px/m: `2·1·20/40 = 1.0` — drawn 1:1. The brick lintel (halfW 3.0,
   halfH 0.4) draws stretched 3.0× wide and squashed 0.4× tall from the *same* square brick
   sprite. One sprite, any body size — that's the reuse the ratio buys you.

Note the function also bakes in lesson 4's hygiene (`vb2_Exists` guard — a dead body simply
stops being drawn) and takes the half-extents as parameters: the level code *remembers* each
block's `hw/hh/region` in parallel arrays at creation, because physics won't tell you what a
body looks like — appearance is entirely your bookkeeping.

## Layers, and where `clear_screen` went

The draw section is ordered back-to-front (painter's algorithm), and — look closely — **there
is no `clear_screen` in this ROM.** The background covers every pixel, so clearing first would
be wasted work on a fixed cycle budget:

```
sky gradient  →  hills  →  grass/dirt tiles  →  bodies  →  effects  →  HUD
```

Three background tricks worth stealing:

- **The 1-px gradient:** the atlas has a 1×360 column of sky gradient; drawn with
  `set_drawing_scale( 640.0, 1.0 )` it becomes the whole sky for the cost of one region draw.
- **Tiles anchored to physics:** the grass row is drawn at `vb2_ScreenY( GROUND_TOP )` — the
  *same constant the floor body was built from*, so the visible ground and the physical ground
  cannot disagree. This is lesson 1's "draw every body you create" rule, now with art.
- **The fade-out poof:** the red X where the pig died fades by lowering the **alpha of the
  multiply color** each frame: `set_multiply_color( make_color_rgba( 255,255,255, a ) )`. The
  multiply color tints/fades whatever you draw — white means "as-is", which is why every draw
  helper resets it. (Its position was read *before* `vb2_Destroy` — after, it would read 0,0.)

## The full game: a tour of `angrybirds.c`

The demo is these recipes plus gameplay, ~500 lines. Reading it after this lesson, you'll
recognize almost everything; here's what it adds, and where:

- **`DefineRegions` / `DrawBodySprite` / `DrawBackground`** — the same three functions, plus
  end-screen splash regions (`R_WIN`, `R_LOSE`).
- **Hit events as a damage model** (`AddPig`, `CheckPigs`) — the graduate version of this
  lesson's "is the player moving fast" check. Pigs opt in via the lesson-7 escape hatch
  (`vb2_GetBodyId` → `b2Body_EnableHitEvents`), and after each step the world reports every
  solved impact **with its approach speed**: `b2World_GetContactHitEvents`. That kills a pig
  hit by a *falling brick* just as dead as one hit by the bird — no player-velocity hack, the
  solver measured the actual impact. Raw shape ids are resolved with `vb2_BodyOfShape`.
- **The aim preview** (`DrawAimPreview`) — the dotted arc is just the launch velocity plugged
  into projectile math, `y = v·t − ½·10·t²`, drawn as rectangles. It matches the real flight
  because both use the same gravity.
- **A full reset** (`vb2_Quit()` + `BuildLevel()`) — the slate-wiping alternative to lesson 2's
  reposition-everything reset: tear the whole world down and build it again from scratch. This
  lesson's START button does the same.
- **Game states** (`ST_AIM/FLY/WIN/LOSE`) and the "shot is over" heuristics — including using
  `vb2_IsAwake( Bird ) == false` as "it has come to rest": sleep (lesson 7's performance note)
  doubling as gameplay logic.
- **Primitive overlays** — the slingshot and rubber bands are `draw_line`/`draw_rectangle` from
  `draw_primitives.h`, layered between background and bird. Sprites, primitives and BIOS text
  all compose freely.

## Try it

1. **Spin the wrong way:** remove the minus from `set_drawing_angle`. Roll left, watch the
   sprite spin right. Put it back — now you've seen trap 1 and will never debug it blind.
2. **A giant crate:** add `AddBlock( 0.0, -5.0, 2.0, 2.0, R_CRATE )`. No draw code changes —
   the scale ratio handles it. Check it *feels* heavier too (4× the area = 4× the mass).
3. **Tint damage:** give the pig 2 HP — first fast hit sets a flag and draws him with
   `set_multiply_color( make_color_rgb( 255,120,120 ) )` in the pig's draw call; second kills.
   One multiply color = a whole damage-feedback system.
4. **A night level:** multiply-color the *background* draws with a dim blue-grey instead of
   white. Same atlas, new mood.
5. **Graduate for real:** build and play the demo — `cd .. && bash build.sh angrybirds` — then
   change its castle in `BuildLevel` (add a second tower; note the lintel comment about why the
   roof is ONE brick). Then steal its slingshot for your own game.

## Recap

- Assets: PNG → `png2vircon` → `.vtex` → `<textures>` in the XML → `select_texture( n )` in
  load order. The BIOS font stays available alongside.
- Regions name rectangles of the atlas; **center hotspots for body sprites** (no offset math),
  top-left for tiles.
- The rotozoom recipe: position/angle/size all derived from the body every frame — **negate
  the angle**, **scale = wanted px ÷ native px**.
- Draw back-to-front; a full-screen background replaces `clear_screen`; the multiply color
  tints and fades anything.
- Appearance is your bookkeeping (parallel `hw/hh/region` arrays) — physics doesn't know what
  things look like.
- [`angrybirds.c`](../angrybirds.c) is this lesson at full scale: hit-event damage, aim
  preview, world reset, game states. Read it, then raid it.
