# Joints

A **joint** constrains how two bodies move relative to each other — a hinge, a slider, a rigid
weld, a spring. VirconBox2D implements all seven Box2D v3 joint types.

[← Shapes](shapes.md) · [Reference index](index.md) · [Queries →](queries.md)

## The pattern

Every joint is created the same way: fill a typed **definition**, call the matching
`b2Create*JointDef`, and get back a `b2JointId`.

```c
b2RevoluteJointDef def;
b2DefaultRevoluteJointDef( &def );       // always start from the default
def.bodyIdA = bodyA;
def.bodyIdB = bodyB;
// ... configure ...
b2JointId joint;
b2CreateRevoluteJointDef( &world, &def, &joint );
```

Two fields are common to every def:

- **`bodyIdA`, `bodyIdB`** — the two bodies to connect. At least one should usually be dynamic.
- **`localFrameA`, `localFrameB`** — the joint's anchor frame on each body, in that body's local
  coordinates (a `b2Transform` = position + rotation). For most joints the frame *position* is
  the pivot/anchor point and the frame *rotation* defines the joint's axis. The defaults place
  both frames at each body's origin with identity rotation.
- **`collideConnected`** — whether the two connected bodies still collide with each other
  (default false: the connected bodies pass through one another).

## Destroying

```c
void b2DestroyJoint( b2World* world, b2JointId* jointId );
```

Removes the joint and wakes both bodies. Destroying either connected body
(`b2DestroyBody`) also destroys the joint automatically.

## Handle & validity

```c
void b2MakeJointId( b2World* world, int jointId, b2JointId* result );
bool b2Joint_IsValid( b2World* world, b2JointId* id );
```

`b2MakeJointId` turns a raw int joint id (as returned by `b2Body_GetJoints`) into a checked
handle. `b2Joint_IsValid` returns false once the joint has been destroyed.

---

## Base API (any joint type)

These work on a `b2JointId` of any type.

```c
int b2Joint_GetType( b2World* world, b2JointId* id );
```
The joint's type constant (`b2_distanceJoint`, `b2_revoluteJoint`, …).

```c
void b2Joint_GetBodyA( b2World* world, b2JointId* id, b2BodyId* result );
void b2Joint_GetBodyB( b2World* world, b2JointId* id, b2BodyId* result );
```
The two connected bodies.

```c
void b2Joint_GetLocalFrameA( b2World* world, b2JointId* id, b2Transform* result );
void b2Joint_SetLocalFrameA( b2World* world, b2JointId* id, b2Transform* frame );
void b2Joint_GetLocalFrameB( b2World* world, b2JointId* id, b2Transform* result );
void b2Joint_SetLocalFrameB( b2World* world, b2JointId* id, b2Transform* frame );
```
Read or move the joint's anchor frame on each body.

```c
bool b2Joint_GetCollideConnected( b2World* world, b2JointId* id );
void b2Joint_SetCollideConnected( b2World* world, b2JointId* id, bool value );
```
Whether the two connected bodies collide with each other.

```c
void b2Joint_GetConstraintTuning( b2World* world, b2JointId* id, float* hertz, float* dampingRatio );
void b2Joint_SetConstraintTuning( b2World* world, b2JointId* id, float hertz, float dampingRatio );
```
The stiffness of the joint's *rigid* constraint (not its spring). Higher `hertz` = stiffer;
`0` uses the solver default. Rarely needed.

```c
void  b2Joint_GetConstraintForce( b2World* world, b2JointId* id, b2Vec2* result );
float b2Joint_GetConstraintTorque( b2World* world, b2JointId* id );
```
The force / torque the joint applied last step to hold its constraint — useful for "break the
joint if it's under too much stress" logic. (Reflects the last `b2World_Step`.)

```c
float b2Joint_GetLinearSeparation( b2World* world, b2JointId* id );
float b2Joint_GetAngularSeparation( b2World* world, b2JointId* id );
```
How far the joint has drifted from the constraint it enforces (0 when perfectly satisfied) — a
diagnostic for solver error under heavy load.

```c
float b2Joint_GetForceThreshold( b2World* world, b2JointId* id );
void  b2Joint_SetForceThreshold( b2World* world, b2JointId* id, float value );
float b2Joint_GetTorqueThreshold( b2World* world, b2JointId* id );
void  b2Joint_SetTorqueThreshold( b2World* world, b2JointId* id, float value );
```
Thresholds for joint force/torque events (breakable joints).

```c
void  b2Joint_WakeBodies( b2World* world, b2JointId* id );
void  b2Joint_SetUserData( b2World* world, b2JointId* id, void* userData );
void* b2Joint_GetUserData( b2World* world, b2JointId* id );
```
Wake both bodies; attach/read an opaque game pointer.

---

## Distance joint

Holds a fixed distance between an anchor on each body — a rigid rod, or (with the spring
enabled) a bungee. This is also the base for ropes and springs.

**`b2DistanceJointDef`:** `length`, `minLength`, `maxLength`, `hertz`, `dampingRatio`,
`enableSpring`, `enableLimit`, plus the common `bodyIdA/B`, `localFrameA/B`, `collideConnected`.
With `enableSpring = false` (default) the distance is held rigidly at `length`. With the spring
on, `hertz`/`dampingRatio` make it springy and `enableLimit` clamps it to `[minLength, maxLength]`.

```c
b2DistanceJointDef def;  b2DefaultDistanceJointDef( &def );
def.bodyIdA = anchor;  def.bodyIdB = weight;
def.length = 3.0;                      // hang 3 m below the anchor
b2JointId rope;  b2CreateDistanceJointDef( &world, &def, &rope );
```

```c
void  b2DistanceJoint_SetLength( b2World* world, b2JointId* id, float length );
float b2DistanceJoint_GetLength( b2World* world, b2JointId* id );
```
The rest length the joint tries to hold.

```c
float b2DistanceJoint_GetCurrentLength( b2World* world, b2JointId* id );
```
The *actual* current anchor-to-anchor distance (vs the rest `length`) — read live, from the
body poses.

```c
void  b2DistanceJoint_EnableSpring( b2World* world, b2JointId* id, bool enable );
bool  b2DistanceJoint_IsSpringEnabled( b2World* world, b2JointId* id );
void  b2DistanceJoint_SetSpringHertz( b2World* world, b2JointId* id, float hertz );
float b2DistanceJoint_GetSpringHertz( b2World* world, b2JointId* id );
void  b2DistanceJoint_SetSpringDampingRatio( b2World* world, b2JointId* id, float ratio );
float b2DistanceJoint_GetSpringDampingRatio( b2World* world, b2JointId* id );
```
Turn the length into a spring and tune its frequency (Hz) and damping (0 = bouncy, 1 = critically
damped).

```c
void  b2DistanceJoint_EnableLimit( b2World* world, b2JointId* id, bool enable );
bool  b2DistanceJoint_IsLimitEnabled( b2World* world, b2JointId* id );
void  b2DistanceJoint_SetLengthRange( b2World* world, b2JointId* id, float minLength, float maxLength );
float b2DistanceJoint_GetMinLength( b2World* world, b2JointId* id );
float b2DistanceJoint_GetMaxLength( b2World* world, b2JointId* id );
```
Clamp the (spring) length to a range — a rope that stretches but not past `maxLength`.

```c
void  b2DistanceJoint_EnableMotor( b2World* world, b2JointId* id, bool enable );
bool  b2DistanceJoint_IsMotorEnabled( b2World* world, b2JointId* id );
void  b2DistanceJoint_SetMotorSpeed( b2World* world, b2JointId* id, float speed );
float b2DistanceJoint_GetMotorSpeed( b2World* world, b2JointId* id );
void  b2DistanceJoint_SetMaxMotorForce( b2World* world, b2JointId* id, float force );
float b2DistanceJoint_GetMaxMotorForce( b2World* world, b2JointId* id );
float b2DistanceJoint_GetMotorForce( b2World* world, b2JointId* id );
```
Drive the length actively toward a target at `motorSpeed`, capped at `maxMotorForce`.
`GetMotorForce` reports what the motor applied last step (a winch or piston).

```c
void b2DistanceJoint_SetSpringForceRange( b2World* world, b2JointId* id, float lower, float upper );
void b2DistanceJoint_GetSpringForceRange( b2World* world, b2JointId* id, float* lower, float* upper );
```
Clamp the spring's output force to a range.

---

## Revolute joint

A hinge: pins two bodies at a shared point and lets them rotate about it. The workhorse for
ragdolls, wheels-on-axles, swinging doors, and levers.

**`b2RevoluteJointDef`:** `enableSpring`, `hertz`, `dampingRatio`, `targetAngle`, `enableMotor`,
`motorSpeed`, `maxMotorTorque`, `enableLimit`, `lowerAngle`, `upperAngle` (+ common fields). Put
the pivot at the same world point on both bodies via `localFrameA/B`.

```c
b2RevoluteJointDef def;  b2DefaultRevoluteJointDef( &def );
def.bodyIdA = wall;  def.bodyIdB = door;
def.localFrameA.p = hingeLocalOnWall;    // pivot, in each body's local frame
def.localFrameB.p = hingeLocalOnDoor;
def.enableLimit = true;
def.lowerAngle = 0.0;  def.upperAngle = 1.57;   // door opens 0..90 deg
b2JointId hinge;  b2CreateRevoluteJointDef( &world, &def, &hinge );
```

```c
float b2RevoluteJoint_GetAngle( b2World* world, b2JointId* id );
```
The current relative angle between the bodies (radians).

```c
void  b2RevoluteJoint_EnableMotor( b2World* world, b2JointId* id, bool enable );
bool  b2RevoluteJoint_IsMotorEnabled( b2World* world, b2JointId* id );
void  b2RevoluteJoint_SetMotorSpeed( b2World* world, b2JointId* id, float speed );
float b2RevoluteJoint_GetMotorSpeed( b2World* world, b2JointId* id );
void  b2RevoluteJoint_SetMaxMotorTorque( b2World* world, b2JointId* id, float torque );
float b2RevoluteJoint_GetMaxMotorTorque( b2World* world, b2JointId* id );
float b2RevoluteJoint_GetMotorTorque( b2World* world, b2JointId* id );
```
Drive the hinge toward `motorSpeed` (rad/s) with up to `maxMotorTorque`. `GetMotorTorque`
reports the torque applied last step (a powered joint / servo).

```c
void  b2RevoluteJoint_EnableLimit( b2World* world, b2JointId* id, bool enable );
bool  b2RevoluteJoint_IsLimitEnabled( b2World* world, b2JointId* id );
void  b2RevoluteJoint_SetLimits( b2World* world, b2JointId* id, float lower, float upper );
float b2RevoluteJoint_GetLowerLimit( b2World* world, b2JointId* id );
float b2RevoluteJoint_GetUpperLimit( b2World* world, b2JointId* id );
```
Constrain rotation to `[lower, upper]` radians (a door that only opens so far).

```c
void  b2RevoluteJoint_EnableSpring( b2World* world, b2JointId* id, bool enable );
bool  b2RevoluteJoint_IsSpringEnabled( b2World* world, b2JointId* id );
void  b2RevoluteJoint_SetSpringHertz( b2World* world, b2JointId* id, float hertz );
float b2RevoluteJoint_GetSpringHertz( b2World* world, b2JointId* id );
void  b2RevoluteJoint_SetSpringDampingRatio( b2World* world, b2JointId* id, float ratio );
float b2RevoluteJoint_GetSpringDampingRatio( b2World* world, b2JointId* id );
void  b2RevoluteJoint_SetTargetAngle( b2World* world, b2JointId* id, float angle );
float b2RevoluteJoint_GetTargetAngle( b2World* world, b2JointId* id );
```
A rotational spring pulling toward `targetAngle` (a self-closing door, a suspension arm).

---

## Prismatic joint

A slider: the bodies keep the same orientation but translate along one axis (defined by
`localFrameA`'s x-axis). Elevators, pistons, sliding doors.

**`b2PrismaticJointDef`:** `enableSpring`, `hertz`, `dampingRatio`, `targetTranslation`,
`enableMotor`, `motorSpeed`, `maxMotorForce`, `enableLimit`, `lowerTranslation`,
`upperTranslation` (+ common fields).

```c
b2PrismaticJointDef def;  b2DefaultPrismaticJointDef( &def );
def.bodyIdA = frame;  def.bodyIdB = platform;
def.enableMotor = true;  def.motorSpeed = 2.0;  def.maxMotorForce = 500.0;
def.enableLimit = true;  def.lowerTranslation = 0.0;  def.upperTranslation = 4.0;
b2JointId lift;  b2CreatePrismaticJointDef( &world, &def, &lift );
```

```c
float b2PrismaticJoint_GetTranslation( b2World* world, b2JointId* id );
float b2PrismaticJoint_GetSpeed( b2World* world, b2JointId* id );
```
Current position and signed sliding speed along the axis (live, from the body state).

```c
void  b2PrismaticJoint_EnableMotor( b2World* world, b2JointId* id, bool enable );
bool  b2PrismaticJoint_IsMotorEnabled( b2World* world, b2JointId* id );
void  b2PrismaticJoint_SetMotorSpeed( b2World* world, b2JointId* id, float speed );
float b2PrismaticJoint_GetMotorSpeed( b2World* world, b2JointId* id );
void  b2PrismaticJoint_SetMaxMotorForce( b2World* world, b2JointId* id, float force );
float b2PrismaticJoint_GetMaxMotorForce( b2World* world, b2JointId* id );
float b2PrismaticJoint_GetMotorForce( b2World* world, b2JointId* id );
```
Drive the slider along its axis at `motorSpeed` (m/s), capped at `maxMotorForce`.

```c
void  b2PrismaticJoint_EnableLimit( b2World* world, b2JointId* id, bool enable );
bool  b2PrismaticJoint_IsLimitEnabled( b2World* world, b2JointId* id );
void  b2PrismaticJoint_SetLimits( b2World* world, b2JointId* id, float lower, float upper );
float b2PrismaticJoint_GetLowerLimit( b2World* world, b2JointId* id );
float b2PrismaticJoint_GetUpperLimit( b2World* world, b2JointId* id );
```
Clamp travel to `[lower, upper]` along the axis (the ends of an elevator shaft).

```c
void  b2PrismaticJoint_EnableSpring( b2World* world, b2JointId* id, bool enable );
bool  b2PrismaticJoint_IsSpringEnabled( b2World* world, b2JointId* id );
void  b2PrismaticJoint_SetSpringHertz( b2World* world, b2JointId* id, float hertz );
float b2PrismaticJoint_GetSpringHertz( b2World* world, b2JointId* id );
void  b2PrismaticJoint_SetSpringDampingRatio( b2World* world, b2JointId* id, float ratio );
float b2PrismaticJoint_GetSpringDampingRatio( b2World* world, b2JointId* id );
void  b2PrismaticJoint_SetTargetTranslation( b2World* world, b2JointId* id, float translation );
float b2PrismaticJoint_GetTargetTranslation( b2World* world, b2JointId* id );
```
A spring pulling the slider toward `targetTranslation`.

---

## Weld joint

Rigidly binds two bodies as if they were one — no relative translation or rotation. With the
hertz values set > 0 the bind becomes a stiff spring instead of perfectly rigid.

**`b2WeldJointDef`:** `linearHertz`, `linearDampingRatio`, `angularHertz`, `angularDampingRatio`
(+ common fields). All hertz `0` (default) = perfectly rigid.

```c
b2WeldJointDef def;  b2DefaultWeldJointDef( &def );
def.bodyIdA = a;  def.bodyIdB = b;
b2JointId weld;  b2CreateWeldJointDef( &world, &def, &weld );
```

```c
void  b2WeldJoint_SetLinearHertz( b2World* world, b2JointId* id, float hertz );
float b2WeldJoint_GetLinearHertz( b2World* world, b2JointId* id );
void  b2WeldJoint_SetLinearDampingRatio( b2World* world, b2JointId* id, float ratio );
float b2WeldJoint_GetLinearDampingRatio( b2World* world, b2JointId* id );
```
Softness of the positional bind (0 hertz = rigid).

```c
void  b2WeldJoint_SetAngularHertz( b2World* world, b2JointId* id, float hertz );
float b2WeldJoint_GetAngularHertz( b2World* world, b2JointId* id );
void  b2WeldJoint_SetAngularDampingRatio( b2World* world, b2JointId* id, float ratio );
float b2WeldJoint_GetAngularDampingRatio( b2World* world, b2JointId* id );
```
Softness of the orientation bind (0 hertz = rigid). Non-zero hertz gives a "breakable/wobbly
weld" feel.

---

## Wheel joint

A suspension: the wheel body can spin freely and travel along a suspension axis (a spring), but
is otherwise held to the chassis. This is the car-wheel joint.

**`b2WheelJointDef`:** `enableSpring`, `hertz`, `dampingRatio`, `enableMotor`, `motorSpeed`,
`maxMotorTorque`, `enableLimit`, `lowerTranslation`, `upperTranslation` (+ common fields). The
spring acts along the suspension axis; the motor drives the wheel's rotation.

```c
b2WheelJointDef def;  b2DefaultWheelJointDef( &def );
def.bodyIdA = chassis;  def.bodyIdB = wheel;
def.enableSpring = true;  def.hertz = 4.0;  def.dampingRatio = 0.7;   // suspension
def.enableMotor = true;   def.motorSpeed = -20.0;  def.maxMotorTorque = 40.0;  // drive
b2JointId axle;  b2CreateWheelJointDef( &world, &def, &axle );
```

```c
float b2WheelJoint_GetTranslation( b2World* world, b2JointId* id );
```
Current suspension travel along the axis.

```c
void  b2WheelJoint_EnableSpring( b2World* world, b2JointId* id, bool enable );
bool  b2WheelJoint_IsSpringEnabled( b2World* world, b2JointId* id );
void  b2WheelJoint_SetSpringHertz( b2World* world, b2JointId* id, float hertz );
float b2WheelJoint_GetSpringHertz( b2World* world, b2JointId* id );
void  b2WheelJoint_SetSpringDampingRatio( b2World* world, b2JointId* id, float ratio );
float b2WheelJoint_GetSpringDampingRatio( b2World* world, b2JointId* id );
```
The suspension spring's frequency and damping.

```c
void  b2WheelJoint_EnableMotor( b2World* world, b2JointId* id, bool enable );
bool  b2WheelJoint_IsMotorEnabled( b2World* world, b2JointId* id );
void  b2WheelJoint_SetMotorSpeed( b2World* world, b2JointId* id, float speed );
float b2WheelJoint_GetMotorSpeed( b2World* world, b2JointId* id );
void  b2WheelJoint_SetMaxMotorTorque( b2World* world, b2JointId* id, float torque );
float b2WheelJoint_GetMaxMotorTorque( b2World* world, b2JointId* id );
float b2WheelJoint_GetMotorTorque( b2World* world, b2JointId* id );
```
Spin the wheel at `motorSpeed` (rad/s) with up to `maxMotorTorque` — the engine.

```c
void  b2WheelJoint_EnableLimit( b2World* world, b2JointId* id, bool enable );
bool  b2WheelJoint_IsLimitEnabled( b2World* world, b2JointId* id );
void  b2WheelJoint_SetLimits( b2World* world, b2JointId* id, float lower, float upper );
float b2WheelJoint_GetLowerLimit( b2World* world, b2JointId* id );
float b2WheelJoint_GetUpperLimit( b2World* world, b2JointId* id );
```
Clamp the suspension travel.

---

## Motor joint

Drives body B toward a target *velocity* relative to body A (rather than a fixed geometric
constraint) — useful for top-down character movement, conveyor-like drives, or actively posing
a body without a rigid link. It has no limits; it applies capped force/torque to reach the
target velocities.

**`b2MotorJointDef`:** `linearVelocity`, `maxVelocityForce`, `angularVelocity`,
`maxVelocityTorque`, plus spring terms `linearHertz`/`linearDampingRatio`/`maxSpringForce` and
`angularHertz`/`angularDampingRatio`/`maxSpringTorque` (+ common fields).

```c
b2MotorJointDef def;  b2DefaultMotorJointDef( &def );
def.bodyIdA = ground;  def.bodyIdB = character;
def.maxVelocityForce = 1000.0;
b2JointId drive;  b2CreateMotorJointDef( &world, &def, &drive );
// each frame, steer:
b2Vec2 v;  v.x = 5.0;  v.y = 0.0;
b2MotorJoint_SetLinearVelocity( &world, &drive, &v );
```

```c
void b2MotorJoint_SetLinearVelocity( b2World* world, b2JointId* id, b2Vec2* velocity );
void b2MotorJoint_GetLinearVelocity( b2World* world, b2JointId* id, b2Vec2* result );
void  b2MotorJoint_SetMaxVelocityForce( b2World* world, b2JointId* id, float force );
float b2MotorJoint_GetMaxVelocityForce( b2World* world, b2JointId* id );
```
Target relative linear velocity and the force cap used to reach it.

```c
void  b2MotorJoint_SetAngularVelocity( b2World* world, b2JointId* id, float velocity );
float b2MotorJoint_GetAngularVelocity( b2World* world, b2JointId* id );
void  b2MotorJoint_SetMaxVelocityTorque( b2World* world, b2JointId* id, float torque );
float b2MotorJoint_GetMaxVelocityTorque( b2World* world, b2JointId* id );
```
Target relative angular velocity and its torque cap.

```c
void  b2MotorJoint_SetLinearHertz( b2World* world, b2JointId* id, float hertz );
float b2MotorJoint_GetLinearHertz( b2World* world, b2JointId* id );
void  b2MotorJoint_SetLinearDampingRatio( b2World* world, b2JointId* id, float ratio );
float b2MotorJoint_GetLinearDampingRatio( b2World* world, b2JointId* id );
void  b2MotorJoint_SetMaxSpringForce( b2World* world, b2JointId* id, float force );
float b2MotorJoint_GetMaxSpringForce( b2World* world, b2JointId* id );
```
An optional positional spring layered on the velocity drive (pull B toward A's frame).

```c
void  b2MotorJoint_SetAngularHertz( b2World* world, b2JointId* id, float hertz );
float b2MotorJoint_GetAngularHertz( b2World* world, b2JointId* id );
void  b2MotorJoint_SetAngularDampingRatio( b2World* world, b2JointId* id, float ratio );
float b2MotorJoint_GetAngularDampingRatio( b2World* world, b2JointId* id );
void  b2MotorJoint_SetMaxSpringTorque( b2World* world, b2JointId* id, float torque );
float b2MotorJoint_GetMaxSpringTorque( b2World* world, b2JointId* id );
```
The angular counterpart of the spring.

---

## Filter joint

```c
void b2DefaultFilterJointDef( b2FilterJointDef* def );
void b2CreateFilterJointDef( b2World* world, b2FilterJointDef* def, b2JointId* out );
```

A filter joint has no constraint and no motion effect — its only job is to make its two bodies
**not collide** with each other (the same as `collideConnected = false`, but without any
physical link). Use it to disable collision between two specific bodies that aren't otherwise
joined.

---

Continue to [Queries](queries.md).
