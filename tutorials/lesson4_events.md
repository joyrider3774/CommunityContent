# Lesson 4 — Collisions

**Goal:** build *Crate Crusher*, the course's first real game: crates rain from the sky, you ram
them, they die, the score goes up. Along the way you learn how a game finds out **what hit
what**, and how to **destroy bodies without shooting yourself in the foot**.

**Files:** [`lesson4_events.c`](lesson4_events.c) · `bash build.sh lesson4_events` ·
controls: **d-pad** roll, **A** jump.

---

## Touch events: how you find out what happened

The engine already *resolved* every collision during `vb2_Step()` — bodies bounced, stacked,
pushed each other. Events are how it additionally *tells* you about them, so gameplay can react:

```c
int vb2_TouchCount();        // how many pairs BEGAN touching during the last step
int vb2_TouchA( int i );     // the two bodies of pair i — plain handles,
int vb2_TouchB( int i );     // comparable straight against the ones you hold
```

Three rules:

1. **Poll after `vb2_Step()`, before the next one.** Each step replaces the previous step's
   events. There are no callbacks, no interrupts — you read a little list when it suits you.
   (This "poll, don't call me" style is deliberate; it's also how upstream Box2D v3 works.)
2. **They fire on *begin* only.** A crate resting on the floor produced one event on the frame
   it landed, and none after. So "the player is currently standing on X" is not a question
   events answer — that's a ray cast (lesson 5).
3. **A and B are in no particular order.** Your crate might be `TouchA` or `TouchB`; always
   check both ways. The `other`-variable idiom in the code handles it:

```c
int other = -1;
if( a == player )  other = b;
if( b == player )  other = a;
if( other != -1 && IsCrate( other ) )  ...
```

Since handles are ints, "which crate is it?" is just an `==` scan over your own array — no
user-data pointers, no lookup tables.

## Destroying bodies: collect first, destroy second

```c
vb2_Destroy( body );
```

removes the body and its shape from the world instantly — contacts gone, done. The subtlety is
not the call; it's **when** you make it. The lesson's event loop is deliberately two passes:

```c
PASS 1 — COLLECT:  read every event, decide who dies, store the handles
PASS 2 — DESTROY:  kill the collected handles
```

Here's the failure the two-pass shape prevents. Suppose one crate lands on the player *and*
another crate hits the player in the same step — two events. If you destroy the first crate the
moment you see event 0, then event 1 — which might involve that same body from the other side —
now resolves against a destroyed body and comes back `-1`. Nothing crashes, but comparisons
silently stop matching and you **miss hits**. With collect-then-destroy the whole event list is
read against a stable world, and the problem cannot occur.

This is a rule worth generalizing: **finish reading physics state before you mutate the
world.** It will save you again with sensors, contact lists, and the full API's events.

## Dead handles: why none of this is dangerous

Lesson 2 parked unused bodies off-screen; this lesson finally *deletes* them — which raises the
classic question: what about all the copies of that handle still sitting in my arrays?

They're fine. A handle encodes not just *which slot* the body occupied but *which generation*
of that slot, so a handle to a destroyed body is recognized — forever, even after the engine
reuses the slot for a new body:

```c
vb2_Exists( dead );              // false
vb2_GetX( dead );                // 0.0     — not a crash
vb2_ApplyImpulse( dead, ... );   // no-op   — not a crash
vb2_Destroy( dead );             // no-op   — destroying twice is safe
```

So the game never scrubs handles out of its arrays. Look at how the crate slots work:

- Slots start at `-1` — which is itself just a dead handle, so *empty* and *crushed* need no
  separate bookkeeping: `!vb2_Exists( crates[i] )` covers both.
- The spawner reuses any slot whose handle is dead.
- The draw loop skips dead handles with the same test.
- The `doomed` pass guards with `vb2_Exists` before scoring, so one crate can't score twice
  even if it produced two events in one frame.

Use `vb2_Exists` when you need to *distinguish* "gone" from "value is zero" — and don't bother
guarding calls whose no-op behavior is what you want anyway.

## Housekeeping: bodies that leave the world

Nothing despawns a body that falls off your level — it just falls, forever, simulating all the
way down (and holding one of your crate slots). The lesson's last loop is the standard fix:

```c
if( vb2_Exists( crates[i] ) && vb2_GetY( crates[i] ) < -20.0 )
    vb2_Destroy( crates[i] );
```

Every game with spawning needs a version of this. Cheap, boring, essential.

## Try it

1. **Ground slam:** only crush crates when the player is falling fast — require
   `vb2_GetVY( player ) < -5.0` in the collect pass. Suddenly it's a game about jumping *on*
   things. Notice the check reads player state *at event time* — fine, since we haven't
   destroyed anything yet.
2. **Crates crush crates:** in the collect pass, also mark pairs where *both* bodies are
   crates and either is moving fast. Chain reactions.
3. **Danger crates:** every 5th spawn, remember that handle as `spiky`. If the player touches
   *that* one, reset the score. One extra `int` of bookkeeping — that's the whole cost of a new
   mechanic.
4. **Break it (educationally):** move `vb2_Destroy` up into the event loop, replacing the
   collect pass, then ram two crates in the same frame (jump into a tight pile). Watch an
   occasional hit not score. Now you've *seen* the bug the two-pass pattern prevents.
5. **Landing thump:** count events where one body is the floor (save the floor's handle — walls
   have handles too!). Flash the screen when a crate lands.

## Recap

- `vb2_TouchCount/A/B` report which **bodies** began touching last step; poll after
  `vb2_Step()`; check both A and B; begin-only.
- **Collect first, destroy second.** Never mutate the world while reading its events.
- Dead handles are permanently detectable (`vb2_Exists`) and safe in every call — design your
  arrays around that instead of scrubbing them.
- Despawn what falls out of the world.

**Next:** [Lesson 5 — Ray Casts and Picking](lesson5_raycast.md): asking the world geometric
questions — and finally fixing that mid-air jump.
