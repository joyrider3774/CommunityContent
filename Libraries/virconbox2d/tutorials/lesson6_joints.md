# Lesson 6 — Joints

**Goal:** connect bodies together. You'll build the two contraptions that justify a physics
engine's existence — a **car you can drive** (two pins + motors) and a **wrecking ball**
(a rope you can cut mid-swing) — out of three functions.

**Files:** [`lesson6_joints.c`](lesson6_joints.c) · `bash build.sh lesson6_joints` ·
controls: **d-pad** drive, **A** (hold) brake, **B** cut the rope.

---

## What a joint is

Everything so far *kept bodies apart* (collision). A joint does the opposite: it's a permanent
rule that **holds two bodies together** in some way, enforced by the solver every step along
with everything else. The easy API has two:

```c
int vb2_Pin(  int bodyA, int bodyB, float worldX, float worldY );  // hinge at a point
int vb2_Rope( int bodyA, int bodyB );          // keep their current distance
void vb2_Motor( int joint, float speed, float maxTorque );         // power a pin
void vb2_DestroyJoint( int joint );
bool vb2_JointExists( int joint );
```

A **pin** nails the two bodies together at one world point; they can still *rotate* around it,
but that point stays shared. It's a door hinge, an axle, a ragdoll shoulder, one link of a
bridge.

A **rope** holds the bodies at a fixed distance — specifically, **the distance they're at when
you create it**. That's why the order is always: *place the bodies first, then joint them*.
There is no length parameter; the world *is* the parameter.

Joints return handles just like bodies — plain ints, generation-checked, `-1` means none, and a
handle to a destroyed joint is safe and detectable (`vb2_JointExists`).

Two facts that surprise everyone the first time:

- **Jointed bodies don't collide with each other.** That's the default and it's almost always
  what you want — the car's wheels overlap its chassis and nobody fights about it.
- **Joints are invisible**, same as bodies. The rope in this lesson is drawn as a dotted line
  from anchor to ball — by us, from the same positions physics reports. Forget it and the
  wrecking ball looks haunted.

## The car recipe

The most-built joint contraption in 2D games, and it's ~7 lines:

```c
int chassis = vb2_Box( -11.0, -5.7, 1.3, 0.35 );
int wheelL  = vb2_Ball( -12.0, -6.5, 0.5 );
int wheelR  = vb2_Ball( -10.0, -6.5, 0.5 );
vb2_SetFriction( wheelL, 1.2 );                       // tires
vb2_SetFriction( wheelR, 1.2 );
int axleL = vb2_Pin( chassis, wheelL, -12.0, -6.5 );  // pin AT the wheel center
int axleR = vb2_Pin( chassis, wheelR, -10.0, -6.5 );
```

Pinning at each wheel's **center** makes the pin an axle: the wheel spins in place relative to
the chassis. (Pin off-center and you get a cam — sometimes also what you want.)

Then driving is a motor on each axle, set **every frame** like a force:

```c
vb2_Motor( axleL, -14.0, 20.0 );      // target spin (rad/s), max torque to get there
```

Read the two arguments as a request and a budget: *try to spin at −14 rad/s, using at most
20 N·m*. The car moves because the motor spins the wheels, the wheels grip the floor (that 1.2
friction is doing real work — try 0.1 and watch it burn out), and traction pushes the chassis.
It climbs the ramp, launches off the edge, lands — all for free.

Signs, once again: positive spin is counter-clockwise, which drives **left**; hence `-14` for
right. If your own car drives backwards, flip the sign and move on — everyone does this once.

Two more motor tricks in the input handler worth noticing:

- **Brake** = `vb2_Motor( axle, 0.0, 40.0 )` — "target speed zero, big budget". A motor holding
  a speed of zero is a *servo*: the same call holds a turret at its angle or keeps a hatch shut.
- **Free-wheel** = `vb2_Motor( axle, 0.0, 0.0 )` — zero budget means no motor at all. Without
  this else-branch the last drive command would keep pushing forever.

## The wrecking ball

```c
int anchor = vb2_Wall( ANCHOR_X, ANCHOR_Y, 0.3, 0.3 );  // a fixed point = a small static body
int ball   = vb2_Ball( 14.5, -2.5, 0.8 );               // placed at full swing, out to the side
vb2_SetDensity( ball, 3.0 );
int rope   = vb2_Rope( anchor, ball );
```

Three ideas in four lines:

1. **"Attached to the world" = attached to a static body.** Ropes and pins join two *bodies*;
   when one end should be the world itself, that end is a little static wall. (It's at the
   anchor point here, but a pin's static body can be anywhere — only the pin *point* matters.)
2. **The rope length is the creation-time distance** — the ball is deliberately placed ~10.9 m
   from the anchor, out to the side, so gravity immediately swings it through the crate stack.
   Placing it hanging straight down would make a very boring pendulum.
3. **Cutting = destroying the joint:**

```c
if( gamepad_button_b() == 1 && vb2_JointExists( rope ) )
    vb2_DestroyJoint( rope );
```

The bodies survive; only the rule connecting them dies. The ball keeps the velocity the swing
gave it — cut at the bottom of the arc for maximum sideways hurl. Note the joint handle rules
mirror body handles exactly: destroying twice would be a no-op, and `vb2_JointExists` is how
the draw code knows to stop drawing the rope.

Destroying a *body* destroys every joint attached to it automatically — you never clean up
joints of a body you `vb2_Destroy`.

## Try it

1. **Rear-wheel drive:** motor only `axleR`. The car wheelies under hard acceleration —
   torque has to go somewhere.
2. **A trailer:** one more box behind the car, pinned to the chassis at a point *between*
   them (a tow hitch — the pin doesn't have to be inside either body!). Watch it jackknife
   under braking.
3. **A pendulum chain:** three small balls, each roped to the previous, the first roped to an
   anchor. Ropes-of-ropes behave like a chain of rigid links.
4. **A drawbridge:** a long thin `vb2_Box` pinned at its left end to a static anchor, with a
   servo (`speed 0, torque 60`) holding it up. Press a button → motor off (`0, 0`) → it slams
   down under gravity, and the car can cross.
5. **Torque budget:** drop the drive torque from 20 to 4. The car still *tries* for −14 rad/s
   but can barely climb the ramp — that's the difference between the request and the budget.

## Recap

- **Pin** = hinge at a world point (axles, doors, limbs); **rope** = hold creation-time
  distance (pendulums, tow lines). **Place bodies first, then joint them.**
- Jointed bodies don't collide with each other; joints are invisible until you draw them.
- **Motor** = target speed + torque budget, set every frame. Speed 0 + big budget = brake/servo;
  budget 0 = free-wheel.
- Joint handles behave exactly like body handles: `vb2_JointExists`, safe when dead, destroyed
  automatically with their bodies.

**Next:** [Lesson 7 — Beyond the Facade](lesson7_beyond.md): the full `b2*` API underneath —
sensors, per-body gravity, and everything this course didn't need. The training wheels come off.
