# Queries

Queries ask the world questions without stepping it: *what does this ray hit? what's inside this
box? what's the nearest thing along this sweep?* They power line-of-sight, aiming, ground checks,
area triggers, and mouse picking.

[← Joints](joints.md) · [Reference index](index.md) · [Events →](events.md)

## Filtering queries

Most queries take an optional `b2QueryFilter*`. Pass `NULL` to hit **everything**, or a filter
to restrict which shapes are considered (same category/mask logic as
[shape filters](shapes.md#collision-filtering)).

```c
struct b2QueryFilter { int categoryBits; int maskBits; };
void b2DefaultQueryFilter( b2QueryFilter* filter );
```

A query with `categoryBits = C`, `maskBits = M` sees a shape only if the shape's category is in
`M` and `C` is in the shape's mask.

## Callbacks use raw shape ids

Multi-result queries report each hit through a callback. Because a `b2ShapeId` can't be passed
to a callback by value, callbacks receive a **raw `int` shape id** plus pointer arguments. Turn
it into a usable handle with `b2MakeShapeId( &world, rawId, &handle )`, then `b2Shape_GetBody` /
`b2Body_GetUserData` to reach your game object.

---

## Ray casts

### Closest hit

```c
int b2World_CastRayClosest( b2World* world, b2Vec2* origin, b2Vec2* translation,
                            b2QueryFilter* filter, b2CastOutput* result );
```

Casts a ray from `origin` along `translation` and returns the **single closest** shape it hits.
The hit is written into `result` (`hit == false` on a miss); the return value is the **raw shape
id** of what was hit (or `B2_NULL_INDEX` on a miss). This is the everyday ray cast — ground
checks, line of sight, bullet hit-scan, aim picking.

```c
struct b2CastOutput {
    b2Vec2 normal;    // surface normal at the hit
    b2Vec2 point;     // world hit point
    float  fraction;  // 0..1 along translation where the hit occurred
    int    iterations;
    bool   hit;
};
```

```c
b2Vec2 origin;       origin.x = px;  origin.y = py;
b2Vec2 translation;  translation.x = 0.0;  translation.y = -2.0;   // 2 m downward
b2CastOutput out;
int shapeId = b2World_CastRayClosest( &world, &origin, &translation, NULL, &out );
if( out.hit )
{
    // grounded; out.point is where, out.normal is the surface
}
```

### All hits

```c
void b2World_CastRay( b2World* world, b2Vec2* origin, b2Vec2* translation, b2QueryFilter* filter,
                      float( int, b2CastOutput*, void* )* fcn, void* context );
```

Reports **every** shape along the ray through your callback:

```c
float MyRayCallback( int shapeId, b2CastOutput* hit, void* context );
```

The callback's **return value controls the ray**: return the given `hit->fraction` to keep
clipping to the closest hit, `1.0` to keep the full length (see everything), or `0.0` to stop
immediately. `context` is your opaque pointer. Use this when a ray needs to pass through or
tally multiple targets (a piercing shot, a sensor sweep).

---

## Shape casts

A shape cast is a "thick ray": it sweeps a whole shape (a point cloud + radius) along a
translation and reports what it hits first — "does the player fit through this gap?".

Build the moving shape as a `b2ShapeProxy` (world-frame points + radius):

```c
struct b2ShapeProxy { b2Vec2 points[...]; int count; float radius; };
void b2MakeProxy( b2Vec2* points, int count, float radius, b2ShapeProxy* proxy );
```

### Closest hit

```c
int b2World_CastShapeClosest( b2World* world, b2ShapeProxy* proxy, b2Vec2* translation,
                              b2QueryFilter* filter, b2CastOutput* result );
```

Sweeps `proxy` along `translation` and returns the closest shape hit (raw id + `result`), same
shape as `b2World_CastRayClosest`.

> **Note:** the hit fraction stops one `B2_LINEAR_SLOP` short of exact geometric contact — if you
> hand-verify a cast, account for that small offset or a correct result looks slightly early.

### All hits

```c
void b2World_CastShape( b2World* world, b2ShapeProxy* proxy, b2Vec2* translation, b2QueryFilter* filter,
                        float( int, b2CastOutput*, void* )* fcn, void* context );
```

The all-hits form, with the same callback contract as `b2World_CastRay`.

---

## Overlap queries

### AABB overlap

```c
void b2World_OverlapAABB( b2World* world, b2AABB* aabb, b2QueryFilter* filter,
                          bool( int, int, void* )* fcn, void* context,
                          b2TreeStats* stats );
```

Reports every shape whose broad-phase proxy overlaps `aabb`. The callback is
`bool fcn( int proxyId, int shapeId, void* context )` — return `false` to stop early. This is a
**broad-phase** test (proxy boxes, not exact geometry), so it's fast and slightly conservative —
ideal for "what's roughly in this region". `stats` receives visit counts (pass a valid pointer,
not `NULL`).

### Shape overlap

```c
void b2World_OverlapShape( b2World* world, b2ShapeProxy* proxy, b2QueryFilter* filter,
                           bool( int, void* )* fcn, void* context );
```

Reports every shape whose **actual geometry** overlaps `proxy` (world-frame). Unlike the AABB
query this is exact (GJK-confirmed), so use it when you need a true overlap test — an explosion's
affected set, a melee hitbox, a placement check. The callback is
`bool fcn( int shapeId, void* context )`; return `false` to stop.

---

## Explosions

```c
struct b2ExplosionDef {
    int    maskBits;          // categories the blast affects (-1 = all)
    b2Vec2 position;          // blast center, world space
    float  radius;            // full-impulse radius
    float  falloff;           // distance past radius over which impulse fades to zero
    float  impulsePerLength;  // impulse per unit of facing silhouette (negative = implosion)
};
void b2DefaultExplosionDef( b2ExplosionDef* def );
void b2World_Explode( b2World* world, b2ExplosionDef* def );
```

Applies an outward impulse to every dynamic shape within `radius + falloff` of `position`, scaled
by how much of each shape faces the blast and by a linear falloff past `radius`. A negative
`impulsePerLength` implodes instead. This is an immediate, one-shot effect — call it once when a
grenade goes off, not every frame.

```c
b2ExplosionDef ex;  b2DefaultExplosionDef( &ex );
ex.position = blastCenter;
ex.radius = 3.0;
ex.falloff = 2.0;
ex.impulsePerLength = 8.0;
b2World_Explode( &world, &ex );
```

## World bounds

```c
void b2World_GetBounds( b2World* world, b2AABB* result );
```

The union AABB of everything in the world (see [World](world.md#utilities)) — handy for framing a
camera to the whole scene.

---

Continue to [Events](events.md).
