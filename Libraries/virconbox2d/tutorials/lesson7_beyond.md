# Lesson 7 — Beyond the Facade

**Goal:** take the training wheels off. `vb2.h` is a facade over a complete port of **Box2D v3**
— the `b2*` API — and the two mix freely in the same program. This lesson builds a **sensor goal
zone** (something the facade can't make), polls **sensor events** raw, and gives the player
**personal moon gravity**, each demonstrating one rung of the ladder down.

**Files:** [`lesson7_beyond.c`](lesson7_beyond.c) · `bash build.sh lesson7_beyond` ·
controls: **d-pad** roll, **A** jump, **B** toggle moon mode. Roll into the dotted zone —
**GOAL!** Shove a crate in — nothing, and that's the point.

---

## The one fact that makes mixing possible

```c
b2World vb2_world;      // this is what vb2_Init() creates
```

The facade's implicit world is an **ordinary `b2World`**. Every `b2*` function that wants a
world takes `&vb2_world`, and it operates on the *same* bodies your `vb2_*` calls made. There's
no boundary to cross — the facade is sugar, not a wall. You already have the full API included:
`vb2.h` pulls in `virconbox2d.h`, the whole engine.

So the question is never "facade *or* full API" — it's "which call do I need right now". This
lesson's game is 90% facade; three features reach down.

## The `b2*` conventions, all in one snippet

The full API is faithful to upstream Box2D v3, adapted to this console's rules. The sensor-zone
creation shows every convention at once:

```c
b2BodyDef zoneDef;
b2DefaultBodyDef( &zoneDef );          // 1. defs: fill a struct, then create
zoneDef.position.x = ZONE_X;
zoneDef.position.y = ZONE_Y;

b2BodyId zoneBody;                     // 2. handles are STRUCTS you keep storage for
b2CreateBody( &vb2_world, &zoneDef, &zoneBody );
//            ^^^^^^^^^^            ^^^^^^^^^^
//            3. world passed        4. results come back through an
//               explicitly             OUT-POINTER, always the last arg

b2Polygon zoneBox;
b2MakeBox( ZONE_HALF, ZONE_HALF, &zoneBox );

b2ShapeDef zoneShapeDef;
b2DefaultShapeDef( &zoneShapeDef );
zoneShapeDef.isSensor = true;
b2ShapeId zoneShape;
b2CreatePolygonShape( &vb2_world, &zoneBody, &zoneShapeDef, &zoneBox, &zoneShape );
```

Unpacking the numbered points:

1. **Defs.** Creation goes through a def struct: `b2Default*Def` fills sane defaults, you
   override fields, then create. The def is where the options live that the facade hardcodes —
   `isSensor`, collision filters, initial velocity, damping, `isBullet`, axis locks…
2. **Multi-word handles.** `b2BodyId` / `b2ShapeId` / `b2JointId` are structs. The console's
   compiler cannot pass a multi-word struct across a function boundary *by value* — which is
   exactly why the full API threads pointers everywhere, and why the facade exists.
3. **Explicit world.** No hidden globals in the `b2*` layer; every call says which world.
4. **Out-pointers.** Any function that would *return* a struct instead takes a result pointer
   as its **last argument**. `b2MakeBox` above is the same pattern for geometry.

Also note: bodies made by the raw API and bodies made by the facade coexist — the zone body
here lives happily alongside `vb2_Ball` players. And the def defaults to a **static** body,
which is what a fixed trigger zone wants.

## Sensors: collision detection without collision

```c
zoneShapeDef.isSensor = true;
```

A sensor shape detects overlap but produces **no physical response** — things pass through it.
It's the standard building block for pickups, checkpoints, damage zones, "player entered the
room". The facade's `vb2_TouchCount` never reports sensors (they don't *touch*, they *overlap*),
so their events come from the world directly:

```c
int n = b2World_GetSensorBeginEventCount( &vb2_world );
b2SensorTouchEvent* events = b2World_GetSensorBeginEvents( &vb2_world );
```

Same contract you learned in lesson 4 — poll after the step, valid until the next one, and
finish reading before you mutate the world. The difference: events at this level carry **raw
`int` shape ids**, and turning one into something you can compare takes two hops:

```c
b2ShapeId visitorShape;
b2MakeShapeId( &vb2_world, events[e].visitorShapeId, &visitorShape );  // int -> checked handle

b2BodyId visitorBody;
b2Shape_GetBody( &vb2_world, &visitorShape, &visitorBody );            // shape -> its body

if( visitorBody.index1 == playerId.index1 )   ...                     // compare identities
```

That resolve chain — *raw id → shape handle → body handle → compare* — is the skeleton of all
event handling in the full API (begin/end touch, hit events with impact speed, sensor
begin/end). It's also precisely the work `vb2_TouchA` was doing for you in lesson 4. The crates
prove the filtering works: push one into the zone and the event fires, but its body index isn't
the player's, so no goal.

## The escape hatch: facade handle → real handle

```c
b2BodyId playerId;
vb2_GetBodyId( player, &playerId );                          // int -> b2BodyId

b2Body_SetGravityScale( &vb2_world, &playerId, 0.3 );        // moon mode, this body only
```

`vb2_GetBodyId` converts any facade handle into a real, generation-checked `b2BodyId` — after
which all ~100 `b2Body_*` functions apply to that body. Per-body gravity scale has no facade
equivalent because it doesn't need one: two lines reach it. The same hatch gets you
`b2Body_SetBullet` (continuous collision for fast projectiles), axis locks, damping, and more.

It's also the performance hatch: each facade call resolves the int handle on entry. Irrelevant
at tutorial scale, but a loop touching hundreds of bodies per frame can hold the `b2BodyId`
once and call `b2Body_*` directly.

## What else is down there

A map of what the full API adds, with the doc page for each — all under [`docs/`](../docs/index.md):

| You want | Look for | Page |
|----------|----------|------|
| Capsules, multi-shape bodies, chain terrain | `b2CreateCapsuleShape`, `b2CreateChain` | [shapes.md](../docs/shapes.md) |
| "Bullets pass through allies" | collision filters (`b2Filter`) | [shapes.md](../docs/shapes.md) |
| Impact sounds scaled by hit force | hit events (`enableHitEvents`) | [events.md](../docs/events.md) |
| End-of-touch, contact manifolds | begin/end touch, `b2Body_GetContactData` | [events.md](../docs/events.md) |
| All-hits rays, shape casts, region queries | `b2World_CastRay`, `b2World_OverlapShape` | [queries.md](../docs/queries.md) |
| Springs, sliders, welds, suspension | the other five joint types | [joints.md](../docs/joints.md) |
| A non-bouncy platformer character | the mover (`b2SolvePlanes`) | [mover.md](../docs/mover.md) |
| Fast objects tunneling through walls | `isBullet` + continuous collision | [bodies.md](../docs/bodies.md), [world.md](../docs/world.md) |

Two performance notes worth carrying out of the course:

- **`vb2_EnableSleep( true )`, early.** Settled bodies drop out of the solver entirely. It's
  off by default (a port-history decision, not advice), and on the console's 250,000-cycle
  frame budget it's often the difference between a scene fitting in a frame and not.
- If your scene outgrows the budget anyway, the next tool is 30 Hz physics with 60 fps
  interpolated rendering — the pattern lives in [`SHOWCASE.md`](../SHOWCASE.md).

And one language note: this console's C dialect has real limits you'll meet when writing bigger
game code (no ternary `?:`, no compound literals, no `unions`, word-addressed `sizeof`, no `f`
suffix on float literals…). The catalogue is [`VIRCON32_C_DIALECT.md`](../../VIRCON32_C_DIALECT.md)
— skim it before your first long debugging session, not after.

## Try it

1. **An end event:** poll `b2World_GetSensorEndEventCount/Events` too, and print "LEFT ZONE"
   when the player exits. Same resolve chain.
2. **A kill zone:** second sensor under a pit; player entering → `vb2_SetPosition` back to
   spawn. Sensor + teleport = respawn logic.
3. **Crate goals only:** flip the comparison — count crates *pushed* into the zone instead of
   the player entering. You already hold the crate handles; convert each with `vb2_GetBodyId`
   and compare indices.
4. **Bullet time... err, bullet crates:** `b2Body_SetBullet` on a crate, then
   `vb2_SetVelocity` it to 60 m/s at a wall. Without the bullet flag it may tunnel; with it,
   continuous collision catches the hit.
5. **Graduate:** open [`template.c`](../template.c) — the course's patterns condensed into one
   copy-me starter ROM — and start your game from it.

## Recap

- `vb2_world` **is** a `b2World`; facade and full API operate on the same bodies, freely mixed.
- Full-API conventions: def structs, explicit `&vb2_world`, struct handles, out-pointer
  results (always the last argument).
- **Sensors** overlap without colliding; their events carry raw shape ids — resolve with
  `b2MakeShapeId` → `b2Shape_GetBody`, then compare body indices.
- `vb2_GetBodyId` is the escape hatch to everything `b2Body_*`.
- You now know the whole loop: create → step → read → draw; materials; impulses vs forces;
  events; queries; joints; and the door to the rest.

**Next:** [Lesson 8 — Sprites and Textures](lesson8_sprites.md): the physics is done — now
make it *look* like a game. Real textured sprites, glued to the bodies.
