# Mover (character controller)

The mover is a **kinematic character controller** — a capsule you move directly (a platformer
hero, a top-down player) that slides along walls and floors instead of being pushed around by the
solver. It is not a body; it's a set of helper queries you drive yourself each frame. This gives
you precise, responsive control that rigid-body dynamics can't.

[← Events](events.md) · [Reference index](index.md)

## The idea

The character is a `b2Capsule` (two local endpoints + radius) that you position yourself. Each
frame you:

1. **Cast** the capsule along your intended motion to see how far it can travel before hitting
   something.
2. **Collide** the capsule at its position to gather the surrounding collision planes.
3. **Solve** those planes to turn a desired movement into one that slides along surfaces instead
   of penetrating them.
4. **Clip** your velocity against the same planes so you don't keep accelerating into a wall.

You keep your own position and velocity; these helpers just tell you how the environment
constrains them.

## Gather collision planes

```c
void b2World_CollideMover( b2World* world, b2Capsule* mover, b2QueryFilter* filter,
                           bool( int, b2PlaneResult*, void* )* fcn, void* context );
```

Finds every shape near the `mover` capsule and reports a **collision plane** for each through
your callback:

```c
bool MyMoverCallback( int shapeId, b2PlaneResult* result, void* context );
```

Return `true` to keep collecting. Typically your callback copies each `result->plane` into a
`b2CollisionPlane[]` you own, which you then hand to `b2SolvePlanes`. `filter` restricts which
shapes are considered (`NULL` = all).

```c
struct b2PlaneResult {
    b2Plane plane;   // the collision plane between mover and shape
    b2Vec2  point;   // contact point on the shape (shape-local)
    bool    hit;     // ignore this result if false
};
```

## Sweep the capsule

```c
float b2World_CastMover( b2World* world, b2Capsule* mover, b2Vec2* translation, b2QueryFilter* filter );
```

Sweeps `mover` along `translation` and returns the fraction `[0, 1]` of that translation it may
travel before the first hit (`1.0` = clear path). Use it to limit a step so the character stops
at a wall rather than tunneling through it.

```c
b2Vec2 wanted;  wanted.x = vx * dt;  wanted.y = vy * dt;
float f = b2World_CastMover( &world, &capsule, &wanted, NULL );
// move at most fraction f of `wanted` this frame
```

## Resolve movement against planes

```c
struct b2CollisionPlane {
    b2Plane plane;
    float   pushLimit;     // FLT_MAX = rigid wall; smaller = soft (meters)
    float   push;          // filled in by b2SolvePlanes
    bool    clipVelocity;  // whether b2ClipVector should clip against this plane
};
struct b2PlaneSolverResult {
    b2Vec2 translation;    // the resolved movement
    int    iterationCount;
};

void b2SolvePlanes( b2Vec2* targetDelta, b2CollisionPlane* planes, int count, b2PlaneSolverResult* result );
```

Takes your desired movement (`targetDelta`) and the planes you collected, and returns a
`translation` that respects all of them — sliding along walls, stopping at floors, fitting into
corners. Set each plane's `pushLimit` to `FLT_MAX` for a rigid surface, or a smaller value for a
soft/penetrable one.

> **Sign gotcha:** the solver's anti-jitter slop follows the **plane normal**, not a world axis.
> A character resting against a plane with normal `-x` settles at a small `+0.005` offset along
> that normal, not exactly on the surface. Account for this if you compare positions exactly.

## Clip velocity

```c
void b2ClipVector( b2Vec2* vector, b2CollisionPlane* planes, int count, b2Vec2* result );
```

Clips a velocity `vector` against the planes so the component pushing into a surface is removed
(the character stops accelerating into a wall but keeps its sliding speed). Run this on your
velocity after solving, using the same `planes` array. Only planes with `clipVelocity == true`
are used.

## A typical frame

```c
// 1. gather planes around the character
b2CollisionPlane planes[8];  int planeCount = 0;
// (your callback fills `planes` / `planeCount`)
b2World_CollideMover( &world, &capsule, NULL, &MyMoverCallback, &planeCount );

// 2. resolve the desired move
b2Vec2 wanted;  wanted.x = vx * dt;  wanted.y = vy * dt;
b2PlaneSolverResult solved;
b2SolvePlanes( &wanted, planes, planeCount, &solved );

// 3. advance your own position by solved.translation
position.x += solved.translation.x;
position.y += solved.translation.y;

// 4. clip velocity so you don't accumulate into walls
b2Vec2 clipped;
b2ClipVector( &velocity, planes, planeCount, &clipped );
velocity = clipped;
```

Because the mover owns its position, combine it freely with your own logic — jump arcs, coyote
time, variable gravity — while the physics world still stops it at walls and lets it ride moving
platforms.

---

[← Back to the reference index](index.md)
