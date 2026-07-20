// =============================================================================
//   VirconBox2D BENCHMARK ROM  (port of box2d/benchmark scene builders)
// =============================================================================
//   Ports the canonical Box2D benchmark SCENES (box2d/shared/benchmarks.c) onto
//   the console. Upstream's benchmark/main.c harness is NOT portable (POSIX
//   threads, argv parsing, file I/O, wall-clock ms via b2GetTicks); the value is
//   the scenes -- standard, recognizable physics workloads. So this is a perf
//   ROM in the mould of perf.c: build each scene, step it, and report whole-step
//   CPU cycles against the 250,000-cycle/frame budget, with a green/red
//   correctness verdict layered on top.
//
//   CORRECTNESS CONTRACT (green/red, same spirit as the harnesses):
//     GREEN  = EVERY scene validated structurally (b2ValidateWorld == 0) every
//              step AND a representative body stayed finite (b2IsValidVec2) AND a
//              clean halt. RED = some scene's VAL code != 0 or FIN == NO.
//   Cycle counts are INFORMATIONAL (displayed, never pass/fail). b2ValidateWorld
//   catches structural corruption; the finite-check catches a NaN/inf blow-up
//   that would still round-trip structurally.
//
//   ROBUST-UNDER-FAULT LAYOUT: each scene's result row is drawn AND PRESENTED
//   (end_frame) before the next scene's heavy compute begins. If scene K faults
//   (CPU halt freezes the emulator), the screen still shows rows 0..K-1 and
//   "SCENE K ..." with no row -- free bisection despite the single ROM.
//
//   DEVIATIONS (documented, like the boxtests OUT set):
//     * SCALE REDUCED. Upstream runs e.g. baseCount=100 (~5050 boxes); the
//       console runs a handful of steps of ~100-body scenes. Reported cycles are
//       therefore NOT comparable to Box2D's desktop numbers -- the deliverable is
//       "the port survives the canonical scene SHAPES, validated green," not a
//       cross-engine speed comparison.
//     * KINEMATIC scenes IN: WASHER (spinning kinematic drum flinging a box grid)
//       and JUNKYARD (kinematic pusher via b2Body_SetTargetTransform, driven
//       per-step by RunWorld). WASHER drops the unported enableHitEvents flag;
//       JUNKYARD substitutes b2ComputeCosSin with hardware cos/sin.
//     * SPINNER + RAIN IN: needed b2CreateCapsuleShape/b2CreateSegmentShape,
//       b2Body_GetLocalPoint, and collision FILTERS (all added). SPINNER's
//       b2CreateChain container is substituted with a loop of segment shapes (a
//       chain IS a segment loop; two-sided is fine for an inside-only ring).
//       RAIN ports human.c's ragdoll (11 capsule bones + revolute joints, self-
//       collision suppressed via filter groups) but drops the rolling spawn/
//       destroy column logic -- a fixed handful of ragdolls dropped onto a floor.
//     * OUT: nothing left from the benchmark set -- all scenes ported.
//     * Segment grounds are substituted with thin polygon boxes / a wide floor
//       (no b2CreateSegmentShape in the port). JOINTGRID drops the collision
//       filter (categoryBits/maskBits unported) so its grid circles are spaced to
//       not overlap and it becomes joint+contact stress rather than pure joint.
//
//   Build:  bash build.sh benchmark
// =============================================================================

#include "video.h"
#include "time.h"
#include "math.h"
#include "string.h"
#include "port/b2_math.h"
#include "port/b2_constants.h"
#include "port/b2_aabb.h"
#include "port/b2_geometry.h"
#include "port/b2_hull.h"
#include "port/b2_distance.h"
#include "port/b2_manifold.h"
#include "port/b2_ctz.h"
#include "port/b2_core.h"
#include "port/b2_dynamic_tree.h"
#include "port/b2_id_pool.h"
#include "port/b2_arena_allocator.h"
#include "port/b2_shape.h"
#include "port/b2_body.h"
#include "port/b2_bitset.h"
#include "port/b2_table.h"
#include "port/b2_joint.h"
#include "port/b2_solver.h"
#include "port/b2_validate.h"

// -----------------------------------------------------------------------------
//   Monotonic cycle clock (frame-boundary safe -- verbatim from perf.c). The
//   console budget is 250,000 cycles/frame; a multi-frame measurement needs
//   frame*250000 + cycle to stay monotonic across the reset at each frame edge.
// -----------------------------------------------------------------------------
int g_baseFrame = 0;

int CycNow()
{
    int f1 = get_frame_counter();
    int c  = get_cycle_counter();
    int f2 = get_frame_counter();
    if( f1 != f2 )
    {
        c  = get_cycle_counter();   // re-read cycle within the new frame
        f1 = f2;
    }
    return ( f1 - g_baseFrame ) * 250000 + c;
}

void ShowInt( int x, int y, int value )
{
    int[20] s;
    itoa( value, s, 10 );
    print_at( x, y, s );
}

float g_dt = 0.0;

// -----------------------------------------------------------------------------
//   Run a built world: step it `steps` times, accumulating whole-step cycles,
//   validating structure every step and keeping a tracked body finite. Outputs
//   the average cycles/step, the first nonzero validate code, and finiteness.
// -----------------------------------------------------------------------------
// Forward declaration: the Junkyard per-step driver is defined below (after the
// scene builders), but RunWorld dispatches to it by builder id.
void StepJunkyard( b2World* world, int stepIndex );

void RunWorld( b2World* world, b2BodyId* watch, int steps, int builder,
               int* outAvgCyc, int* outValCode, bool* outFinite )
{
    int valCode = 0;
    bool finite = true;

    g_baseFrame = get_frame_counter();
    int cycSum = 0;
    int t0;
    int k;
    for( k = 0; k < steps; ++k )
    {
        if( builder == 7 )  StepJunkyard( world, k );   // drive the kinematic pusher

        t0 = CycNow();
        b2World_Step( world, g_dt, 4 );
        cycSum += CycNow() - t0;

        int vc = b2ValidateWorld( world );
        if( vc != 0 && valCode == 0 )  valCode = vc;

        b2Body* body = b2GetBodyFullId( world, watch );
        b2BodySim* sim = b2GetBodySim( world, body );
        if( !b2IsValidVec2( &sim->center ) )  finite = false;
    }

    *outAvgCyc  = cycSum / steps;
    *outValCode = valCode;
    *outFinite  = finite;
}

// =============================================================================
//   Scene builders. Each sets up `world`, returns the dynamic body count, and
//   writes a representative moving body's id to `watch` for the finite-check.
// =============================================================================

// --- LARGE PYRAMID (benchmarks.c:89) : triangular box stack, sleep off -------
int BuildLargePyramid( b2World* world, b2BodyId* watch )
{
    b2CreateWorld( world );
    world->gravity.x = 0.0;  world->gravity.y = -10.0;
    world->enableSleep = false;

    b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
    b2Polygon gb;  b2MakeBox( 100.0, 1.0, &gb );
    b2BodyDef gd;  b2DefaultBodyDef( &gd );  gd.type = b2_staticBody;
    gd.position.x = 0.0;  gd.position.y = -1.0;
    b2BodyId bg;  b2CreateBody( world, &gd, &bg );
    b2ShapeId sg;  b2CreatePolygonShape( world, &bg, &gsd, &gb, &sg );

    int baseCount = 12;                          // 12*13/2 = 78 boxes
    float a = 0.5;  float shift = 0.5;
    b2Polygon box;  b2MakeSquare( a, &box );
    b2ShapeDef sd;  b2DefaultShapeDef( &sd );  sd.density = 1.0;
    b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;

    int i;  int j;
    for( i = 0; i < baseCount; ++i )
    {
        float y = ( 2.0 * i + 1.0 ) * shift;
        for( j = i; j < baseCount; ++j )
        {
            float x = ( i + 1.0 ) * shift + 2.0 * ( j - i ) * shift - a * baseCount;
            bd.position.x = x;  bd.position.y = y;
            b2BodyId bid;  b2CreateBody( world, &bd, &bid );
            b2ShapeId sid;  b2CreatePolygonShape( world, &bid, &sd, &box, &sid );
            *watch = bid;
        }
    }
    return baseCount * ( baseCount + 1 ) / 2;
}

// --- TUMBLER (benchmarks.c:507) : revolute-motor container + box grid --------
// First COMPOUND body in the suite: the container is one dynamic body with four
// offset-box walls (exercises multi-shape b2UpdateBodyMassData accumulation).
int BuildTumbler( b2World* world, b2BodyId* watch )
{
    b2CreateWorld( world );
    world->gravity.x = 0.0;  world->gravity.y = -10.0;

    b2BodyDef grd;  b2DefaultBodyDef( &grd );
    b2BodyId ground;  b2CreateBody( world, &grd, &ground );

    b2BodyDef cd;  b2DefaultBodyDef( &cd );  cd.type = b2_dynamicBody;
    cd.position.x = 0.0;  cd.position.y = 10.0;
    b2BodyId container;  b2CreateBody( world, &cd, &container );

    b2ShapeDef csd;  b2DefaultShapeDef( &csd );  csd.density = 50.0;
    b2Rot idr = b2Rot_identity;
    b2Vec2 c;  b2Polygon w;  b2ShapeId ws;
    c.x =  10.0;  c.y = 0.0;   b2MakeOffsetBox( 0.5, 10.0, &c, &idr, &w );  b2CreatePolygonShape( world, &container, &csd, &w, &ws );
    c.x = -10.0;  c.y = 0.0;   b2MakeOffsetBox( 0.5, 10.0, &c, &idr, &w );  b2CreatePolygonShape( world, &container, &csd, &w, &ws );
    c.x = 0.0;  c.y =  10.0;   b2MakeOffsetBox( 10.0, 0.5, &c, &idr, &w );  b2CreatePolygonShape( world, &container, &csd, &w, &ws );
    c.x = 0.0;  c.y = -10.0;   b2MakeOffsetBox( 10.0, 0.5, &c, &idr, &w );  b2CreatePolygonShape( world, &container, &csd, &w, &ws );

    b2RevoluteJointDef jd;  b2DefaultRevoluteJointDef( &jd );
    jd.bodyIdA = ground;  jd.bodyIdB = container;
    jd.localFrameA.p.x = 0.0;  jd.localFrameA.p.y = 10.0;
    jd.localFrameB.p.x = 0.0;  jd.localFrameB.p.y = 0.0;
    jd.enableMotor = true;
    jd.motorSpeed = ( B2_PI / 180.0 ) * 25.0;    // 25 deg/s
    jd.maxMotorTorque = 100000000.0;             // 1e8 (no sci-notation literals)
    b2JointId jid;  b2CreateRevoluteJointDef( world, &jd, &jid );

    int gridCount = 8;                           // 8x8 = 64 tumbling boxes
    b2Polygon box;  b2MakeBox( 0.125, 0.125, &box );
    b2ShapeDef sd;  b2DefaultShapeDef( &sd );
    b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;

    float y = -0.2 * gridCount + 10.0;
    int i;  int j;
    for( i = 0; i < gridCount; ++i )
    {
        float x = -0.2 * gridCount;
        for( j = 0; j < gridCount; ++j )
        {
            bd.position.x = x;  bd.position.y = y;
            b2BodyId bid;  b2CreateBody( world, &bd, &bid );
            b2ShapeId sid;  b2CreatePolygonShape( world, &bid, &sd, &box, &sid );
            *watch = bid;
            x += 0.4;
        }
        y += 0.4;
    }
    return 1 + gridCount * gridCount;
}

// --- JOINT GRID (benchmarks.c:20) : NxN circles chained by revolute joints ----
int BuildJointGrid( b2World* world, b2BodyId* watch )
{
    b2CreateWorld( world );
    world->gravity.x = 0.0;  world->gravity.y = -10.0;
    world->enableSleep = false;

    int N = 7;                                   // 49 bodies, ~84 joints
    b2BodyId* bodies = b2Alloc( N * N * sizeof( b2BodyId ) );
    int index = 0;

    b2ShapeDef sd;  b2DefaultShapeDef( &sd );  sd.density = 1.0;
    b2Circle circle;  circle.center.x = 0.0;  circle.center.y = 0.0;  circle.radius = 0.4;
    b2RevoluteJointDef jd;  b2DefaultRevoluteJointDef( &jd );
    b2BodyDef bd;  b2DefaultBodyDef( &bd );

    int k;  int i;
    for( k = 0; k < N; ++k )
    {
        for( i = 0; i < N; ++i )
        {
            if( k >= N / 2 - 3 && k <= N / 2 + 3 && i == 0 )  bd.type = b2_staticBody;
            else                                              bd.type = b2_dynamicBody;

            bd.position.x = k;  bd.position.y = -i;
            b2BodyId body;  b2CreateBody( world, &bd, &body );
            b2ShapeId cs;  b2CreateCircleShape( world, &body, &sd, &circle, &cs );

            if( i > 0 )
            {
                jd.bodyIdA = bodies[index - 1];  jd.bodyIdB = body;
                jd.localFrameA.p.x = 0.0;  jd.localFrameA.p.y = -0.5;
                jd.localFrameB.p.x = 0.0;  jd.localFrameB.p.y =  0.5;
                b2JointId jid;  b2CreateRevoluteJointDef( world, &jd, &jid );
            }
            if( k > 0 )
            {
                jd.bodyIdA = bodies[index - N];  jd.bodyIdB = body;
                jd.localFrameA.p.x =  0.5;  jd.localFrameA.p.y = 0.0;
                jd.localFrameB.p.x = -0.5;  jd.localFrameB.p.y = 0.0;
                b2JointId jid;  b2CreateRevoluteJointDef( world, &jd, &jid );
            }

            bodies[index] = body;
            *watch = body;
            index += 1;
        }
    }
    b2Free( bodies, N * N * sizeof( b2BodyId ) );
    return N * N;
}

// --- MANY PYRAMIDS (benchmarks.c:157) : grid of small pyramids on box grounds --
void SmallPyramid( b2World* world, int baseCount, float extent, float centerX,
                   float baseY, b2ShapeDef* sd, b2BodyId* watch )
{
    b2Polygon box;  b2MakeSquare( extent, &box );
    b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
    int i;  int j;
    for( i = 0; i < baseCount; ++i )
    {
        float y = ( 2.0 * i + 1.0 ) * extent + baseY;
        for( j = i; j < baseCount; ++j )
        {
            float x = ( i + 1.0 ) * extent + 2.0 * ( j - i ) * extent + centerX - 0.5;
            bd.position.x = x;  bd.position.y = y;
            b2BodyId bid;  b2CreateBody( world, &bd, &bid );
            b2ShapeId sid;  b2CreatePolygonShape( world, &bid, sd, &box, &sid );
            *watch = bid;
        }
    }
}

int BuildManyPyramids( b2World* world, b2BodyId* watch )
{
    b2CreateWorld( world );
    world->gravity.x = 0.0;  world->gravity.y = -10.0;

    int baseCount = 6;  float extent = 0.5;
    int rowCount = 2;  int columnCount = 2;

    b2BodyDef gd;  b2DefaultBodyDef( &gd );
    b2BodyId ground;  b2CreateBody( world, &gd, &ground );
    b2ShapeDef sd;  b2DefaultShapeDef( &sd );

    float groundDeltaY = 2.0 * extent * ( baseCount + 1.0 );
    float groundWidth  = 2.0 * extent * columnCount * ( baseCount + 1.0 );
    b2Rot idr = b2Rot_identity;

    // segment grounds substituted with thin static boxes on the ground body
    float groundY = 0.0;
    int i;  int j;
    for( i = 0; i < rowCount; ++i )
    {
        b2Vec2 gc;  gc.x = 0.0;  gc.y = groundY;
        b2Polygon gb;  b2MakeOffsetBox( 0.5 * groundWidth, 0.05, &gc, &idr, &gb );
        b2ShapeId gs;  b2CreatePolygonShape( world, &ground, &sd, &gb, &gs );
        groundY += groundDeltaY;
    }

    float baseWidth = 2.0 * extent * baseCount;
    float baseY = 0.0;
    for( i = 0; i < rowCount; ++i )
    {
        for( j = 0; j < columnCount; ++j )
        {
            float centerX = -0.5 * groundWidth + j * ( baseWidth + 2.0 * extent ) + 2.0 * extent;
            SmallPyramid( world, baseCount, extent, centerX, baseY, &sd, watch );
        }
        baseY += groundDeltaY;
    }
    return rowCount * columnCount * ( baseCount * ( baseCount + 1 ) / 2 );
}

// --- SMASH (benchmarks.c:465) : a fast heavy box into a grid, zero gravity -----
int BuildSmash( b2World* world, b2BodyId* watch )
{
    b2CreateWorld( world );
    world->gravity.x = 0.0;  world->gravity.y = 0.0;

    // the smasher: 8x8 box at (-20,0) moving right at 40 m/s
    b2Polygon big;  b2MakeBox( 4.0, 4.0, &big );
    b2BodyDef sm;  b2DefaultBodyDef( &sm );  sm.type = b2_dynamicBody;
    sm.position.x = -20.0;  sm.position.y = 0.0;
    sm.linearVelocity.x = 40.0;  sm.linearVelocity.y = 0.0;
    b2BodyId smasher;  b2CreateBody( world, &sm, &smasher );
    b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );  bsd.density = 8.0;
    b2ShapeId bss;  b2CreatePolygonShape( world, &smasher, &bsd, &big, &bss );
    *watch = smasher;

    float d = 0.4;
    b2Polygon box;  b2MakeSquare( 0.5 * d, &box );
    b2ShapeDef sd;  b2DefaultShapeDef( &sd );
    b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;  bd.isAwake = false;

    int columns = 12;  int rows = 8;
    int i;  int j;
    for( i = 0; i < columns; ++i )
    {
        for( j = 0; j < rows; ++j )
        {
            bd.position.x = i * d + 10.0;
            bd.position.y = ( j - rows / 2.0 ) * d;
            b2BodyId bid;  b2CreateBody( world, &bd, &bid );
            b2ShapeId sid;  b2CreatePolygonShape( world, &bid, &sd, &box, &sid );
        }
    }
    return 1 + columns * rows;
}

// --- COMPOUNDS (benchmarks.c:810) : dynamic bodies of two triangle shapes each -
int BuildCompounds( b2World* world, b2BodyId* watch )
{
    b2CreateWorld( world );
    world->gravity.x = 0.0;  world->gravity.y = -10.0;

    // simplified ground: one wide static floor (upstream's offset-box channel +
    // far segment are just a catch basin -- a floor serves the same purpose)
    b2BodyDef gd;  b2DefaultBodyDef( &gd );
    b2BodyId ground;  b2CreateBody( world, &gd, &ground );
    b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
    b2Polygon floor;  b2MakeBox( 40.0, 1.0, &floor );
    b2ShapeId fs;  b2CreatePolygonShape( world, &ground, &gsd, &floor, &fs );

    // two triangular polygons forming a compound body
    b2Vec2[3] lp;  lp[0].x = -1.0;  lp[0].y = 0.0;  lp[1].x = 0.5;  lp[1].y = 1.0;  lp[2].x = 0.0;  lp[2].y = 2.0;
    b2Hull lh;  b2ComputeHull( lp, 3, &lh );
    b2Polygon left;  b2MakePolygon( &lh, 0.0, &left );

    b2Vec2[3] rp;  rp[0].x = 1.0;  rp[0].y = 0.0;  rp[1].x = -0.5;  rp[1].y = 1.0;  rp[2].x = 0.0;  rp[2].y = 2.0;
    b2Hull rh;  b2ComputeHull( rp, 3, &rh );
    b2Polygon right;  b2MakePolygon( &rh, 0.0, &right );

    b2ShapeDef sd;  b2DefaultShapeDef( &sd );  sd.density = 1.0;  sd.friction = 0.5;
    b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;

    int columnCount = 6;  int rowCount = 8;      // 48 compound bodies (96 shapes)
    float shift = 2.0;  float extray = 0.25;  float side = 0.25;
    float centerx = shift * columnCount / 2.0 - 1.0;
    float centery = 1.15 / 2.0;  float yStart = 5.0;

    int i;  int j;
    for( i = 0; i < columnCount; ++i )
    {
        float x = i * shift - centerx;
        for( j = 0; j < rowCount; ++j )
        {
            float y = j * ( shift + extray ) + centery + yStart;
            bd.position.x = x + side;  bd.position.y = y;
            side = -side;
            b2BodyId bid;  b2CreateBody( world, &bd, &bid );
            b2ShapeId ls;  b2CreatePolygonShape( world, &bid, &sd, &left, &ls );
            b2ShapeId rs;  b2CreatePolygonShape( world, &bid, &sd, &right, &rs );
            *watch = bid;
        }
    }
    return columnCount * rowCount;
}

// --- WASHER (benchmarks.c:574) : a rotating KINEMATIC ring flings a box grid ---
// First KINEMATIC scene. The washer drum is one kinematic body (36 outer-ring hull
// quads + 4 inner spokes) spinning at 25 deg/s with a tiny linear drift; its
// constant velocity is imparted to the dynamic boxes through their contacts
// (invMass=0 -> the drum is unmoved by them). enableHitEvents is dropped (the port
// has no hit events; the benchmark doesn't read them).
int BuildWasher( b2World* world, b2BodyId* watch )
{
    b2CreateWorld( world );
    world->gravity.x = 0.0;  world->gravity.y = -10.0;

    b2BodyDef grd;  b2DefaultBodyDef( &grd );
    b2BodyId ground;  b2CreateBody( world, &grd, &ground );

    float motorSpeed = 25.0;
    b2BodyDef dd;  b2DefaultBodyDef( &dd );
    dd.type = b2_kinematicBody;
    dd.position.x = 0.0;  dd.position.y = 10.0;
    dd.angularVelocity = ( B2_PI / 180.0 ) * motorSpeed;
    dd.linearVelocity.x = 0.001;  dd.linearVelocity.y = -0.002;
    b2BodyId drum;  b2CreateBody( world, &dd, &drum );

    b2ShapeDef sd;  b2DefaultShapeDef( &sd );

    float r0 = 14.0;  float r1 = 16.0;  float r2 = 18.0;
    float angle = B2_PI / 18.0;
    b2Rot q;   q.c  = cos( angle );        q.s  = sin( angle );
    b2Rot qo;  qo.c = cos( 0.1 * angle );  qo.s = sin( 0.1 * angle );
    b2Vec2 u1;  u1.x = 1.0;  u1.y = 0.0;

    int i;
    for( i = 0; i < 36; ++i )
    {
        b2Vec2 u2;
        if( i == 35 ) { u2.x = 1.0;  u2.y = 0.0; }
        else          { b2RotateVector( &q, &u1, &u2 ); }

        b2Vec2 a1;  b2InvRotateVector( &qo, &u1, &a1 );
        b2Vec2 a2;  b2RotateVector( &qo, &u2, &a2 );

        b2Vec2[4] pts;
        b2MulSV( r1, &a1, &pts[0] );  b2MulSV( r2, &a1, &pts[1] );
        b2MulSV( r1, &a2, &pts[2] );  b2MulSV( r2, &a2, &pts[3] );
        b2Hull hull;  b2ComputeHull( pts, 4, &hull );
        b2Polygon poly;  b2MakePolygon( &hull, 0.0, &poly );
        b2ShapeId ps;  b2CreatePolygonShape( world, &drum, &sd, &poly, &ps );

        if( i % 9 == 0 )
        {
            b2Vec2[4] sp;
            b2MulSV( r0, &u1, &sp[0] );  b2MulSV( r1, &u1, &sp[1] );
            b2MulSV( r0, &u2, &sp[2] );  b2MulSV( r1, &u2, &sp[3] );
            b2Hull sh;  b2ComputeHull( sp, 4, &sh );
            b2Polygon spoke;  b2MakePolygon( &sh, 0.0, &spoke );
            b2ShapeId ss;  b2CreatePolygonShape( world, &drum, &sd, &spoke, &ss );
        }

        u1 = u2;
    }

    int gridCount = 10;                          // 100 dynamic boxes inside the drum
    float a = 0.1;
    b2Polygon box;  b2MakeSquare( a, &box );
    b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
    b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;

    float y = -1.1 * a * gridCount + 10.0;
    int j;
    for( i = 0; i < gridCount; ++i )
    {
        float x = -1.1 * a * gridCount;
        for( j = 0; j < gridCount; ++j )
        {
            bd.position.x = x;  bd.position.y = y;
            b2BodyId bid;  b2CreateBody( world, &bd, &bid );
            b2ShapeId sid;  b2CreatePolygonShape( world, &bid, &bsd, &box, &sid );
            *watch = bid;
            x += 2.1 * a;
        }
        y += 2.1 * a;
    }
    return 1 + gridCount * gridCount;
}

// --- JUNKYARD (benchmarks.c:708) : a KINEMATIC pusher sweeps a pile of parts ----
// Second kinematic scene, and the one that exercises b2Body_SetTargetTransform:
// each step the pusher's velocity is retargeted to oscillate along +-x. The parts
// are 5-point Fibonacci-sphere polygons dropped into a static box arena.
b2BodyId g_junkyardPusher;

int BuildJunkyard( b2World* world, b2BodyId* watch )
{
    b2CreateWorld( world );
    world->gravity.x = 0.0;  world->gravity.y = -10.0;

    b2BodyDef gd;  b2DefaultBodyDef( &gd );
    b2BodyId ground;  b2CreateBody( world, &gd, &ground );
    b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
    b2Rot idr = b2Rot_identity;

    float gridSize = 1.0;
    float gy = 0.0;  float gx = -80.0 * gridSize;
    int i;  int j;
    for( i = 0; i < 161; ++i )                    // floor
    {
        b2Vec2 c;  c.x = gx;  c.y = gy;
        b2Polygon b;  b2MakeOffsetBox( 0.55 * gridSize, 0.5 * gridSize, &c, &idr, &b );
        b2ShapeId bs;  b2CreatePolygonShape( world, &ground, &gsd, &b, &bs );
        gx += gridSize;
    }
    gy = gridSize;  gx = -80.0 * gridSize;
    for( i = 0; i < 50; ++i )                     // left wall
    {
        b2Vec2 c;  c.x = gx;  c.y = gy;
        b2Polygon b;  b2MakeOffsetBox( 0.5 * gridSize, 0.55 * gridSize, &c, &idr, &b );
        b2ShapeId bs;  b2CreatePolygonShape( world, &ground, &gsd, &b, &bs );
        gy += gridSize;
    }
    gy = gridSize;  gx = 80.0 * gridSize;
    for( i = 0; i < 50; ++i )                      // right wall
    {
        b2Vec2 c;  c.x = gx;  c.y = gy;
        b2Polygon b;  b2MakeOffsetBox( 0.5 * gridSize, 0.55 * gridSize, &c, &idr, &b );
        b2ShapeId bs;  b2CreatePolygonShape( world, &ground, &gsd, &b, &bs );
        gy += gridSize;
    }

    // one shared Fibonacci-sphere pentagon (b2ComputeCosSin substituted with cos/sin).
    // Constant-index writes only: variable-index writes into a local fixed array are
    // an unattested dialect form (see VIRCON32_C_DIALECT.md) -- unroll the 5 points.
    float radius = 0.25;
    float phi = B2_PI * ( sqrt( 5.0 ) - 1.0 );
    b2Vec2[5] pp;
    float t0 = phi * 0.0;  pp[0].x = radius * cos( t0 );  pp[0].y = radius * sin( t0 );
    float t1 = phi * 1.0;  pp[1].x = radius * cos( t1 );  pp[1].y = radius * sin( t1 );
    float t2 = phi * 2.0;  pp[2].x = radius * cos( t2 );  pp[2].y = radius * sin( t2 );
    float t3 = phi * 3.0;  pp[3].x = radius * cos( t3 );  pp[3].y = radius * sin( t3 );
    float t4 = phi * 4.0;  pp[4].x = radius * cos( t4 );  pp[4].y = radius * sin( t4 );
    b2Hull hull;  b2ComputeHull( pp, 5, &hull );
    b2Polygon part;  b2MakePolygon( &hull, 0.0, &part );

    b2ShapeDef sd;  b2DefaultShapeDef( &sd );
    b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;

    int columnCount = 30;  int rowCount = 2;      // 60 parts
    float side = -0.1;  float yStart = 15.0;
    for( i = 0; i < columnCount; ++i )
    {
        float x = 1.5 * ( 2.0 * i - columnCount ) * radius;
        for( j = 0; j < rowCount; ++j )
        {
            float y = 4.0 * j * radius + yStart;
            bd.position.x = x + side;  bd.position.y = y;
            side = -side;
            b2BodyId bid;  b2CreateBody( world, &bd, &bid );
            b2ShapeId sid;  b2CreatePolygonShape( world, &bid, &sd, &part, &sid );
            *watch = bid;
        }
    }

    // the kinematic pusher (driven each step by StepJunkyard via SetTargetTransform)
    b2BodyDef pd;  b2DefaultBodyDef( &pd );  pd.type = b2_kinematicBody;
    pd.position.x = 0.0;  pd.position.y = 0.0;
    b2CreateBody( world, &pd, &g_junkyardPusher );
    b2Vec2 pc;  pc.x = 0.0;  pc.y = 4.0;
    b2Polygon pbox;  b2MakeOffsetBox( 2.0, 4.0, &pc, &idr, &pbox );
    b2ShapeId ps;  b2CreatePolygonShape( world, &g_junkyardPusher, &sd, &pbox, &ps );

    return columnCount * rowCount + 1;
}

// Per-step driver for Junkyard: retarget the kinematic pusher along +-x.
void StepJunkyard( b2World* world, int stepIndex )
{
    float timeStep = 1.0 / 60.0;
    float time = timeStep * stepIndex;
    b2Transform target;
    target.p.x = 60.0 * sin( 0.2 * time );
    target.p.y = 0.0;
    target.q = b2Rot_identity;
    b2Body_SetTargetTransform( world, &g_junkyardPusher, &target, timeStep );
}

// --- SPINNER (benchmarks.c:357) : a motorized bar flings bodies inside a ring ---
// The upstream b2CreateChain container is substituted with a LOOP OF SEGMENT SHAPES.
// A chain IS a segment loop; the port lacks the ghost-vertex chain module, and this
// ring is inside-only, so two-sided segments are equivalent (no one-sidedness lost
// in practice). Exercises capsule/circle/square dynamic bodies + a rounded-box
// spinner bar + a revolute motor. Segments built by rotating a single point and
// keeping only prev/cur (no indexed array -> dodges the fixed-array-index trap).
int BuildSpinner( b2World* world, b2BodyId* watch )
{
    b2CreateWorld( world );
    world->gravity.x = 0.0;  world->gravity.y = -10.0;
    world->enableSleep = false;

    b2BodyDef gd;  b2DefaultBodyDef( &gd );
    b2BodyId ground;  b2CreateBody( world, &gd, &ground );
    b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );  gsd.friction = 0.1;

    int N = 90;                                  // 90-segment ring (chain substitute)
    b2Rot q;  q.c = cos( -2.0 * B2_PI / N );  q.s = sin( -2.0 * B2_PI / N );
    b2Vec2 p;  p.x = 40.0;  p.y = 0.0;
    b2Vec2 first;  first.x = p.x;  first.y = p.y + 32.0;
    b2Vec2 prev = first;
    int i;
    for( i = 1; i < N; ++i )
    {
        b2Vec2 np;  b2RotateVector( &q, &p, &np );  p = np;
        b2Vec2 cur;  cur.x = p.x;  cur.y = p.y + 32.0;
        b2Segment seg;  seg.point1 = prev;  seg.point2 = cur;
        b2ShapeId ss;  b2CreateSegmentShape( world, &ground, &gsd, &seg, &ss );
        prev = cur;
    }
    b2Segment segL;  segL.point1 = prev;  segL.point2 = first;   // close the loop
    b2ShapeId ssL;  b2CreateSegmentShape( world, &ground, &gsd, &segL, &ssL );

    // spinner bar (rounded box) + revolute motor
    b2BodyDef sbd;  b2DefaultBodyDef( &sbd );  sbd.type = b2_dynamicBody;
    sbd.position.x = 0.0;  sbd.position.y = 12.0;
    b2BodyId spinner;  b2CreateBody( world, &sbd, &spinner );
    b2Polygon bar;  b2MakeRoundedBox( 0.4, 20.0, 0.2, &bar );
    b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );  bsd.friction = 0.0;
    b2ShapeId bss;  b2CreatePolygonShape( world, &spinner, &bsd, &bar, &bss );

    b2RevoluteJointDef jd;  b2DefaultRevoluteJointDef( &jd );
    jd.bodyIdA = ground;  jd.bodyIdB = spinner;
    b2Vec2 anchor;  anchor.x = 0.0;  anchor.y = 12.0;
    b2Body_GetLocalPoint( world, &ground, &anchor, &jd.localFrameA.p );
    jd.enableMotor = true;
    jd.motorSpeed = 5.0;
    jd.maxMotorTorque = 1000000000.0;            // ~1e9 (upstream FLT_MAX; no sci lit)
    b2JointId jid;  b2CreateRevoluteJointDef( world, &jd, &jid );

    // dynamic bodies: cycle capsule / circle / square
    b2Capsule capsule;  capsule.center1.x = -0.25;  capsule.center1.y = 0.0;
    capsule.center2.x = 0.25;  capsule.center2.y = 0.0;  capsule.radius = 0.25;
    b2Circle circle;  circle.center.x = 0.0;  circle.center.y = 0.0;  circle.radius = 0.35;
    b2Polygon square;  b2MakeSquare( 0.35, &square );

    b2ShapeDef sd;  b2DefaultShapeDef( &sd );  sd.friction = 0.1;  sd.restitution = 0.1;  sd.density = 0.25;
    b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;

    int bodyCount = 48;
    float x = -23.0;  float y = 2.0;
    for( i = 0; i < bodyCount; ++i )
    {
        bd.position.x = x;  bd.position.y = y;
        b2BodyId bid;  b2CreateBody( world, &bd, &bid );
        int r = i % 3;
        if( r == 0 )      { b2ShapeId c;  b2CreateCapsuleShape( world, &bid, &sd, &capsule, &c ); }
        else if( r == 1 ) { b2ShapeId c;  b2CreateCircleShape(  world, &bid, &sd, &circle,  &c ); }
        else              { b2ShapeId c;  b2CreatePolygonShape( world, &bid, &sd, &square,  &c ); }
        *watch = bid;
        x += 0.5;
        if( x >= 23.0 ) { x = -23.0;  y += 0.5; }
    }
    return 1 + bodyCount;
}

// --- RAIN ragdoll (human.c CreateHuman) : capsule bones + revolute joints -------
// Adds one bone: a dynamic capsule body + a revolute joint to its parent bone.
// `bones` is a HEAP b2BodyId array -> variable-index reads/writes are safe (the
// miscompile trap is only for fixed-array struct MEMBERS). Struct assignment of a
// multi-word b2BodyId (jd.bodyIdA = bones[parent]) is a MOVS copy, not a by-value
// arg, so it is legal. frameAAngle != 0 rotates the parent frame (arm joints).
void AddBone( b2World* world, b2BodyId* bones, int index, int parent,
              b2Vec2* base, float s, float posY, float c1y, float c2y, float radius,
              float frictionScale, float maxTorque, float hertz, float dampingRatio,
              float linDamp, float pivotY, float lower, float upper, float frameAAngle,
              b2ShapeDef* shapeDef, bool addFoot, b2ShapeDef* footDef, b2Polygon* footPoly )
{
    b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
    bd.sleepThreshold = 0.1;  bd.linearDamping = linDamp;
    b2Vec2 off;  off.x = 0.0;  off.y = posY * s;
    b2OffsetPos( base, &off, &bd.position );
    b2BodyId body;  b2CreateBody( world, &bd, &body );
    bones[index] = body;

    b2Capsule cap;  cap.center1.x = 0.0;  cap.center1.y = c1y * s;
    cap.center2.x = 0.0;  cap.center2.y = c2y * s;  cap.radius = radius * s;
    b2ShapeId cs;  b2CreateCapsuleShape( world, &body, shapeDef, &cap, &cs );
    if( addFoot ) { b2ShapeId fs;  b2CreatePolygonShape( world, &body, footDef, footPoly, &fs ); }

    if( parent >= 0 )
    {
        b2Vec2 poff;  poff.x = 0.0;  poff.y = pivotY * s;
        b2Vec2 pivot;  b2OffsetPos( base, &poff, &pivot );
        b2RevoluteJointDef jd;  b2DefaultRevoluteJointDef( &jd );
        jd.bodyIdA = bones[parent];
        jd.bodyIdB = body;
        b2Body_GetLocalPoint( world, &bones[parent], &pivot, &jd.localFrameA.p );
        b2Body_GetLocalPoint( world, &body, &pivot, &jd.localFrameB.p );
        if( frameAAngle != 0.0 )  b2MakeRot( frameAAngle, &jd.localFrameA.q );
        jd.enableLimit = true;   jd.lowerAngle = lower;  jd.upperAngle = upper;
        jd.enableMotor = true;   jd.maxMotorTorque = frictionScale * maxTorque;
        jd.enableSpring = hertz > 0.0;  jd.hertz = hertz;  jd.dampingRatio = dampingRatio;
        b2JointId jid;  b2CreateRevoluteJointDef( world, &jd, &jid );
    }
}

// One ragdoll: 11 capsule bones + a foot polygon on each lower leg, all joined by
// revolute joints with angle limits + motor friction + a soft spring. filter.group =
// -groupIndex so a human's own bones never self-collide (this is what the FILTERS
// slice unlocks); feet use maskBits=1 so they only touch the ground.
void CreateHuman( b2World* world, b2Vec2* base, float s, float frictionTorque,
                  float hertz, float dampingRatio, int groupIndex, b2BodyId* bones )
{
    b2ShapeDef sd;  b2DefaultShapeDef( &sd );  sd.friction = 0.2;
    sd.filter.groupIndex = -groupIndex;  sd.filter.categoryBits = 2;  sd.filter.maskBits = ( 1 | 2 );
    b2ShapeDef fd;  b2DefaultShapeDef( &fd );  fd.friction = 0.05;
    fd.filter.groupIndex = -groupIndex;  fd.filter.categoryBits = 2;  fd.filter.maskBits = 1;

    // foot polygon (constant-index point writes)
    b2Vec2[4] fp;
    fp[0].x = -0.03 * s;  fp[0].y = -0.185 * s;
    fp[1].x =  0.11 * s;  fp[1].y = -0.185 * s;
    fp[2].x =  0.11 * s;  fp[2].y = -0.16 * s;
    fp[3].x = -0.03 * s;  fp[3].y = -0.14 * s;
    b2Hull fh;  b2ComputeHull( fp, 4, &fh );
    b2Polygon foot;  b2MakePolygon( &fh, 0.015 * s, &foot );

    float mt = frictionTorque * s;
    float P = B2_PI;
    //        idx par  posY   c1y     c2y    rad   fScl  mt  hz  damp  linD  pivY   lower      upper      frameA  addFoot
    AddBone( world, bones,  0, -1, base, s, 0.95, -0.02,  0.02, 0.095, 1.00, mt, hertz, dampingRatio, 0.0, 0.0,  0.0,       0.0,       0.0, &sd, false, &fd, &foot );
    AddBone( world, bones,  1,  0, base, s, 1.20, -0.135, 0.135,0.09,  0.50, mt, hertz, dampingRatio, 0.0, 1.00, -0.25*P,   0.0,       0.0, &sd, false, &fd, &foot );
    AddBone( world, bones,  2,  1, base, s, 1.475,-0.038, 0.039,0.075, 0.25, mt, hertz, dampingRatio, 0.1, 1.40, -0.3*P,    0.1*P,     0.0, &sd, false, &fd, &foot );
    AddBone( world, bones,  3,  0, base, s, 0.775,-0.125, 0.125,0.06,  1.00, mt, hertz, dampingRatio, 0.0, 0.90, -0.05*P,   0.4*P,     0.0, &sd, false, &fd, &foot );
    AddBone( world, bones,  4,  3, base, s, 0.475,-0.155, 0.125,0.045, 0.50, mt, hertz, dampingRatio, 0.0, 0.625,-0.5*P,   -0.02*P,    0.0, &sd, true,  &fd, &foot );
    AddBone( world, bones,  5,  0, base, s, 0.775,-0.125, 0.125,0.06,  1.00, mt, hertz, dampingRatio, 0.0, 0.90, -0.05*P,   0.4*P,     0.0, &sd, false, &fd, &foot );
    AddBone( world, bones,  6,  5, base, s, 0.475,-0.155, 0.125,0.045, 0.50, mt, hertz, dampingRatio, 0.0, 0.625,-0.5*P,   -0.02*P,    0.0, &sd, true,  &fd, &foot );
    AddBone( world, bones,  7,  1, base, s, 1.225,-0.125, 0.125,0.035, 0.50, mt, hertz, dampingRatio, 0.0, 1.35, -0.1*P,    0.8*P,     0.0, &sd, false, &fd, &foot );
    AddBone( world, bones,  8,  7, base, s, 0.975,-0.125, 0.125,0.03,  0.10, mt, hertz, dampingRatio, 0.1, 1.10, -0.2*P,    0.3*P, 0.25*P, &sd, false, &fd, &foot );
    AddBone( world, bones,  9,  1, base, s, 1.225,-0.125, 0.125,0.035, 0.50, mt, hertz, dampingRatio, 0.0, 1.35, -0.1*P,    0.8*P,     0.0, &sd, false, &fd, &foot );
    AddBone( world, bones, 10,  9, base, s, 0.975,-0.125, 0.125,0.03,  0.10, mt, hertz, dampingRatio, 0.1, 1.10, -0.2*P,    0.3*P, 0.25*P, &sd, false, &fd, &foot );
}

int BuildRain( b2World* world, b2BodyId* watch )
{
    b2CreateWorld( world );
    world->gravity.x = 0.0;  world->gravity.y = -10.0;

    // wide static floor (upstream builds a strip grid; a floor is the same catch)
    b2BodyDef gd;  b2DefaultBodyDef( &gd );
    b2BodyId ground;  b2CreateBody( world, &gd, &ground );
    b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
    b2Polygon floor;  b2MakeBox( 20.0, 0.5, &floor );
    b2ShapeId fs;  b2CreatePolygonShape( world, &ground, &gsd, &floor, &fs );

    int humanCount = 4;                          // 4 ragdolls = 44 bodies, 40 joints
    b2BodyId* bones = b2Alloc( 11 * sizeof( b2BodyId ) );
    int h;
    for( h = 0; h < humanCount; ++h )
    {
        b2Vec2 base;  base.x = -6.0 + 4.0 * h;  base.y = 4.0 + 2.0 * h;
        CreateHuman( world, &base, 1.0, 0.05, 5.0, 0.5, h + 1, bones );
        *watch = bones[0];                       // watch this human's hip
    }
    b2Free( bones, 11 * sizeof( b2BodyId ) );
    return 1 + humanCount * 11;
}

// =============================================================================
//   Row rendering + running verdict
// =============================================================================
bool g_allPass = true;

int LX_NAME = 20;
int LX_BODY = 200;
int LX_CYC  = 300;
int LX_PCT  = 440;
int LX_VAL  = 500;
int LX_FIN  = 560;

void DrawRow( int y, int* name, int bodies, int cyc, int valCode, bool finite )
{
    print_at( LX_NAME, y, name );
    ShowInt(  LX_BODY, y, bodies );
    ShowInt(  LX_CYC,  y, cyc );
    ShowInt(  LX_PCT,  y, cyc / 2500 );          // percent of the 250k frame budget
    ShowInt(  LX_VAL,  y, valCode );
    if( finite )  print_at( LX_FIN, y, "Y" );
    else          print_at( LX_FIN, y, "N" );
    if( valCode != 0 || !finite )  g_allPass = false;
}

// one full slice: build -> run -> destroy -> draw its row -> present.
void Bench( int y, int* name, int steps, int builder )
{
    b2World world;
    b2BodyId watch;
    int bodies = 0;

    if( builder == 0 )  bodies = BuildLargePyramid( &world, &watch );
    if( builder == 1 )  bodies = BuildTumbler(      &world, &watch );
    if( builder == 2 )  bodies = BuildJointGrid(    &world, &watch );
    if( builder == 3 )  bodies = BuildManyPyramids( &world, &watch );
    if( builder == 4 )  bodies = BuildSmash(        &world, &watch );
    if( builder == 5 )  bodies = BuildCompounds(    &world, &watch );
    if( builder == 6 )  bodies = BuildWasher(       &world, &watch );
    if( builder == 7 )  bodies = BuildJunkyard(     &world, &watch );
    if( builder == 8 )  bodies = BuildSpinner(      &world, &watch );
    if( builder == 9 )  bodies = BuildRain(         &world, &watch );

    int avgCyc;  int valCode;  bool finite;
    RunWorld( &world, &watch, steps, builder, &avgCyc, &valCode, &finite );
    b2DestroyWorld( &world );

    DrawRow( y, name, bodies, avgCyc, valCode, finite );
    end_frame();                                 // present rows so far (fault-safe)
}

// -----------------------------------------------------------------------------
void main()
{
    clear_screen( color_black );
    set_multiply_color( color_white );
    g_dt = 1.0 / 60.0;

    print_at( LX_NAME, 20, "VIRCONBOX2D BENCHMARK   BUDGET/FRAME = 250000 CYC" );
    print_at( LX_NAME, 50, "SCENE" );
    print_at( LX_BODY, 50, "BODY" );
    print_at( LX_CYC,  50, "CYC/STEP" );
    print_at( LX_PCT,  50, "PCT" );
    print_at( LX_VAL,  50, "VAL" );
    print_at( LX_FIN,  50, "F" );
    end_frame();

    int steps = 20;
    Bench(  78, "LARGE PYRAMID", steps, 0 );
    Bench( 100, "TUMBLER",       steps, 1 );
    Bench( 122, "JOINT GRID",    steps, 2 );
    Bench( 144, "MANY PYRAMIDS", steps, 3 );
    Bench( 166, "SMASH",         steps, 4 );
    Bench( 188, "COMPOUNDS",     steps, 5 );
    Bench( 210, "WASHER",        steps, 6 );
    Bench( 232, "JUNKYARD",      steps, 7 );
    Bench( 254, "SPINNER",       steps, 8 );
    Bench( 276, "RAIN",          steps, 9 );

    // ---- final verdict ----
    // Keep the black table (the cycle numbers are the whole point) and signal
    // pass/fail by TINTING the verdict line, rather than clearing the screen.
    print_at( LX_NAME, 306, "VERDICT" );
    if( g_allPass )
    {
        set_multiply_color( color_green );
        print_at( LX_BODY, 306, "ALL SCENES PASS" );
    }
    else
    {
        set_multiply_color( color_red );
        print_at( LX_BODY, 306, "FAIL -- SEE VAL / F COLUMNS" );
    }

    while( true )
        end_frame();
}
