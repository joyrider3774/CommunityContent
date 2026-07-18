// =============================================================================
//   VirconBox2D test harness #2  (active-development suite)
// =============================================================================
//   harness.c is the FROZEN cumulative regression baseline (green through the
//   2-point-manifold/stacking slice, 2026-07-04). This second harness holds the
//   checks for slices under active development, so day-to-day iteration edits a
//   small file. Same contract: screen turns GREEN if every check passes, RED
//   (with FIRST FAIL CHECK #N + diagnostics) if any fails.
//
//   Workflow: run harness2.v32 while iterating a new slice; once it is green,
//   re-run harness.v32 periodically to confirm no regression, and eventually
//   fold the settled checks back into harness.c if desired.
//
//   Build:  (bash)  bash build.sh harness2
//           (pwsh)  compile.exe harness2.c ...  -> assemble -> packrom harness2.xml
// =============================================================================

#include "video.h"
#include "math.h"
#include "string.h"
#include "virconbox2d.h"        // the whole engine, one include (replaces the 17-header block)
#include "port/b2_validate.h"   // dev-only structural check -- deliberately outside the umbrella
#include "vb2.h"                // game-facing facade (exercised by the vb2 group below)

// -----------------------------------------------------------------------------
//   Shared scaffolding (mirrors harness.c). Kept self-contained so the two
//   harnesses stay independent translation units.
// -----------------------------------------------------------------------------

bool AllPassed = true;
int  checkNum  = 0;
int  firstFail = 0;

// per-slice diagnostics shown on RED (add more as slices need them)
float diagA = 0.0;
float diagB = 0.0;
float diagC = 0.0;
float diagD = 0.0;

bool feq( float a, float b )
{
    return fabs( a - b ) < 0.001;
}

void Check( bool condition )
{
    checkNum++;
    if( !condition )
    {
        AllPassed = false;
        if( firstFail == 0 )
            firstFail = checkNum;
    }
}

void ShowInt( int x, int y, int value )
{
    int[20] s;
    itoa( value, s, 10 );
    print_at( x, y, s );
}

void ShowFloat( int x, int y, float value )
{
    int[30] s;
    ftoa( value, s );
    print_at( x, y, s );
}

// -----------------------------------------------------------------------------
//   Mover: b2World_CollideMover hands back one b2PlaneResult per touching shape.
//   The caller assembles them into the b2CollisionPlane array that b2SolvePlanes
//   and b2ClipVector consume. Indexed through a pointer, the attested-green idiom
//   for an array of large structs.
// -----------------------------------------------------------------------------
b2CollisionPlane[8] g_planes;
int g_planeCount = 0;

bool MoverPlaneCollect( int shapeId, b2PlaneResult* result, void* context )
{
    if( g_planeCount < 8 )
    {
        b2CollisionPlane* gp = g_planes;
        gp[ g_planeCount ].plane = result->plane;
        gp[ g_planeCount ].pushLimit = FLT_MAX;    // rigid
        gp[ g_planeCount ].push = 0.0;
        gp[ g_planeCount ].clipVelocity = true;
        g_planeCount = g_planeCount + 1;
    }
    return true;   // keep visiting
}

// Counts the shapes a b2World_OverlapAABB query actually visits.
int g_overlapCount = 0;

bool OverlapCountCB( int proxyId, int shapeId, void* context )
{
    g_overlapCount = g_overlapCount + 1;
    return true;
}

// All-hits ray/shape cast: count every hit, remember the last shape id.
int g_castCount = 0;
int g_castLastShape = -1;

float RayCastCollectCB( int shapeId, b2CastOutput* output, void* context )
{
    g_castCount = g_castCount + 1;
    g_castLastShape = shapeId;
    return 1.0;   // keep the full ray length -> report ALL hits
}

// b2World_OverlapShape: count reported shapes.
int g_ovShapeCount = 0;

bool OverlapShapeCB( int shapeId, void* context )
{
    g_ovShapeCount = g_ovShapeCount + 1;
    return true;
}

// -----------------------------------------------------------------------------
//   Active-development checks. New slices append their groups here.
// -----------------------------------------------------------------------------
void main()
{
    // ---- seed sanity: confirm the shared scaffolding + a world step run here ----
    // (a dynamic circle rests on a static floor, same as harness.c slice 3 -- so
    //  a green harness2 proves the split build is wired before new slices land)
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 0.5;
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.position.x = 0.0;  cdef.position.y = 2.0;
        b2BodyId bc;  b2CreateBody( &world, &cdef, &bc );
        b2ShapeId sc;  b2CreateCircleShape( &world, &bc, &sdef, &cir, &sc );

        b2Body* body = b2GetBodyFullId( &world, &bc );
        b2BodySim* bsim = b2GetBodySim( &world, body );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 120; k++ )  b2World_Step( &world, dt, 4 );
        diagA = bsim->center.y;
        Check( bsim->center.y > 0.85 && bsim->center.y < 1.15 );   // rested on the floor

        b2DestroyWorld( &world );
    }

    // ---- cross-step warm start: impulses are stored back to the manifold ----
    // A flat box resting on the floor: after settling, b2StoreImpulses must have
    // written a positive support impulse into the awake contactSim's manifold, and
    // the contact points must be flagged persisted (id-matched across steps).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );      // top at 0.5
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );                // rests at y=1.0
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.position.x = 0.0;  cdef.position.y = 1.05;
        b2BodyId bb;  b2CreateBody( &world, &cdef, &bb );
        b2ShapeId sb;  b2CreatePolygonShape( &world, &bb, &sdef, &box, &sb );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 60; k++ )  b2World_Step( &world, dt, 4 );

        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        Check( aset->contactSims.count >= 1 );                     // the box-floor contact exists
        b2ContactSim* cs = &aset->contactSims.data[0];
        Check( cs->manifold.pointCount == 2 );                     // flat box -> 2 contact points
        diagB = cs->manifold.points[0].normalImpulse;
        Check( cs->manifold.points[0].normalImpulse > 0.0 );       // support impulse stored
        Check( cs->manifold.points[1].normalImpulse > 0.0 );
        Check( cs->manifold.points[0].persisted == true );         // id-matched across steps
        Check( cs->manifold.points[1].persisted == true );

        b2DestroyWorld( &world );
    }

    // ---- warm start keeps a 3-box stack stable (dyn-on-dyn, no islands) ----
    // A 3-high stack is the real warm-start stressor: without cross-step impulse
    // carry it tends to sink/jitter; with it the stack holds near its rest heights.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );      // top at 0.5
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );                // 1x1 boxes

        b2BodyDef ad;  b2DefaultBodyDef( &ad );  ad.type = b2_dynamicBody;
        ad.position.x = 0.0;  ad.position.y = 1.10;                 // -> rest ~1.0
        b2BodyId ba;  b2CreateBody( &world, &ad, &ba );
        b2ShapeId sa;  b2CreatePolygonShape( &world, &ba, &sdef, &box, &sa );

        b2BodyDef bdd;  b2DefaultBodyDef( &bdd );  bdd.type = b2_dynamicBody;
        bdd.position.x = 0.0;  bdd.position.y = 2.15;               // -> rest ~2.0
        b2BodyId bbID;  b2CreateBody( &world, &bdd, &bbID );
        b2ShapeId sbID;  b2CreatePolygonShape( &world, &bbID, &sdef, &box, &sbID );

        b2BodyDef cd;  b2DefaultBodyDef( &cd );  cd.type = b2_dynamicBody;
        cd.position.x = 0.0;  cd.position.y = 3.20;                 // -> rest ~3.0
        b2BodyId bcID;  b2CreateBody( &world, &cd, &bcID );
        b2ShapeId scID;  b2CreatePolygonShape( &world, &bcID, &sdef, &box, &scID );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 300; k++ )  b2World_Step( &world, dt, 4 );

        b2BodySim* simA = b2GetBodySim( &world, b2GetBodyFullId( &world, &ba ) );
        b2BodySim* simB = b2GetBodySim( &world, b2GetBodyFullId( &world, &bbID ) );
        b2Body* bodyC = b2GetBodyFullId( &world, &bcID );
        b2BodySim* simC = b2GetBodySim( &world, bodyC );
        b2BodyState* stC = b2GetBodyState( &world, bodyC );
        diagC = simC->center.y;
        diagD = stC->linearVelocity.y;

        Check( simA->center.y > 0.85 && simA->center.y < 1.15 );    // A on floor
        Check( simB->center.y > 1.75 && simB->center.y < 2.20 );    // B on A
        Check( simC->center.y > 2.65 && simC->center.y < 3.25 );    // C on B (stack held)
        Check( simB->center.y - simA->center.y > 0.85 );            // A/B not interpenetrated
        Check( simC->center.y - simB->center.y > 0.85 );            // B/C not interpenetrated
        Check( fabs( simA->transform.q.s ) < 0.12 );                // all boxes level
        Check( fabs( simB->transform.q.s ) < 0.12 );
        Check( fabs( simC->transform.q.s ) < 0.12 );
        Check( fabs( stC->linearVelocity.y ) < 0.6 );              // settled (low residual)

        b2DestroyWorld( &world );
    }

    // ---- speed cap: a huge velocity is clamped to world.maxLinearSpeed ----
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;    // isolate the cap
        world.maxLinearSpeed = 400.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 0.5;
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.position.x = 0.0;  cdef.position.y = 0.0;
        cdef.linearVelocity.x = 5000.0;  cdef.linearVelocity.y = 0.0;   // way over the cap
        b2BodyId bc;  b2CreateBody( &world, &cdef, &bc );
        b2ShapeId sc;  b2CreateCircleShape( &world, &bc, &sdef, &cir, &sc );

        b2World_Step( &world, 1.0 / 60.0, 1 );

        b2Body* body = b2GetBodyFullId( &world, &bc );
        b2BodyState* st = b2GetBodyState( &world, body );
        diagA = st->linearVelocity.x;
        Check( st->linearVelocity.x > 399.0 && st->linearVelocity.x < 401.0 );  // clamped to 400
        Check( ( st->flags & b2_isSpeedCapped ) != 0 );                          // cap flag set

        b2DestroyWorld( &world );
    }

    // ---- motion lock (linearX): the locked axis never moves, others do ----
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 0.5;
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.position.x = 5.0;  cdef.position.y = 10.0;
        cdef.linearVelocity.x = 30.0;  cdef.linearVelocity.y = 0.0;   // would drift in x
        cdef.lockLinearX = true;                                       // but x is locked
        b2BodyId bc;  b2CreateBody( &world, &cdef, &bc );
        b2ShapeId sc;  b2CreateCircleShape( &world, &bc, &sdef, &cir, &sc );

        int k;  for( k = 0; k < 30; k++ )  b2World_Step( &world, 1.0 / 60.0, 4 );

        b2Body* body = b2GetBodyFullId( &world, &bc );
        b2BodySim* sim = b2GetBodySim( &world, body );
        b2BodyState* st = b2GetBodyState( &world, body );
        diagB = sim->center.x;
        Check( feq( sim->center.x, 5.0 ) );              // x locked -> no drift despite v.x=30
        Check( feq( st->linearVelocity.x, 0.0 ) );       // locked velocity component zeroed
        Check( sim->center.y < 9.0 );                    // y NOT locked -> fell under gravity

        b2DestroyWorld( &world );
    }

    // ---- motion lock (angularZ): a spun body cannot rotate ----
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.position.x = 0.0;  cdef.position.y = 0.0;
        cdef.angularVelocity = 10.0;                     // big spin
        cdef.lockAngularZ = true;                        // but rotation is locked
        b2BodyId bc;  b2CreateBody( &world, &cdef, &bc );
        b2ShapeId sc;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sc );

        int k;  for( k = 0; k < 30; k++ )  b2World_Step( &world, 1.0 / 60.0, 4 );

        b2Body* body = b2GetBodyFullId( &world, &bc );
        b2BodySim* sim = b2GetBodySim( &world, body );
        b2BodyState* st = b2GetBodyState( &world, body );
        diagC = sim->transform.q.s;
        Check( feq( sim->transform.q.s, 0.0 ) );         // stayed at identity rotation
        Check( feq( st->angularVelocity, 0.0 ) );        // locked angular velocity zeroed

        b2DestroyWorld( &world );
    }

    // ---- contact teardown: destroying a SHAPE destroys its contacts ----
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.position.x = 0.0;  cdef.position.y = 0.98;   // slightly overlapping -> contact fast
        b2BodyId bc;  b2CreateBody( &world, &cdef, &bc );
        b2ShapeId sc;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sc );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 20; k++ )  b2World_Step( &world, dt, 4 );

        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        Check( b2GetSetCount( &world.broadPhase.pairSet ) == 1 );   // one pair registered
        Check( aset->contactSims.count == 1 );                     // one contactSim

        b2DestroyShape( &world, &sc, true );                       // tear the box shape down

        Check( b2GetSetCount( &world.broadPhase.pairSet ) == 0 );   // pair key removed
        Check( aset->contactSims.count == 0 );                     // contactSim gone
        b2Body* boxBody = b2GetBodyFullId( &world, &bc );
        Check( boxBody->headContactKey == B2_NULL_INDEX );         // body's contact list empty
        Check( boxBody->headShapeId == B2_NULL_INDEX );            // shape unlinked

        b2World_Step( &world, dt, 4 );                             // must not fault
        Check( true );

        b2DestroyWorld( &world );
    }

    // ---- contact teardown: destroying a BODY frees its shapes/proxies/contacts ----
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.position.x = 0.0;  cdef.position.y = 0.98;
        b2BodyId bc;  b2CreateBody( &world, &cdef, &bc );
        b2ShapeId sc;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sc );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 20; k++ )  b2World_Step( &world, dt, 4 );

        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        Check( b2DynamicTree_GetProxyCount( &world.broadPhase.trees[ b2_dynamicBody ] ) == 1 );
        Check( b2DynamicTree_GetProxyCount( &world.broadPhase.trees[ b2_staticBody ] ) == 1 );
        Check( b2GetSetCount( &world.broadPhase.pairSet ) == 1 );

        b2DestroyBody( &world, &bc );                              // destroy the whole box body

        Check( b2DynamicTree_GetProxyCount( &world.broadPhase.trees[ b2_dynamicBody ] ) == 0 ); // proxy freed
        Check( b2DynamicTree_GetProxyCount( &world.broadPhase.trees[ b2_staticBody ] ) == 1 );  // floor intact
        Check( b2GetSetCount( &world.broadPhase.pairSet ) == 0 );  // pair gone
        Check( aset->contactSims.count == 0 );                    // contactSim gone
        Check( b2GetIdCount( &world.bodyIdPool ) == 1 );          // only the floor body remains

        b2World_Step( &world, dt, 4 );                            // must not fault
        Check( true );

        b2DestroyWorld( &world );
    }

    // ---- soak: repeated create -> collide -> destroy leaves no leak / no fault ----
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        float dt = 1.0 / 60.0;  int n, k;
        for( n = 0; n < 20; n++ )
        {
            b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
            b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
            cdef.position.x = 0.0;  cdef.position.y = 0.98;
            b2BodyId bc;  b2CreateBody( &world, &cdef, &bc );
            b2ShapeId sc;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sc );

            for( k = 0; k < 5; k++ )  b2World_Step( &world, dt, 4 );   // form + solve the contact
            b2DestroyBody( &world, &bc );                             // destroy mid-life
            for( k = 0; k < 2; k++ )  b2World_Step( &world, dt, 4 );   // step with it gone
        }

        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        Check( b2GetSetCount( &world.broadPhase.pairSet ) == 0 );     // no leaked pairs
        Check( b2GetIdCount( &world.contactIdPool ) == 0 );          // no leaked contacts
        Check( aset->contactSims.count == 0 );                       // no leaked sims
        Check( b2GetIdCount( &world.bodyIdPool ) == 1 );             // only the floor remains
        Check( b2GetIdCount( &world.shapeIdPool ) == 1 );            // only the floor shape remains
        Check( b2DynamicTree_GetProxyCount( &world.broadPhase.trees[ b2_dynamicBody ] ) == 0 );

        b2DestroyWorld( &world );
    }

    // ---- shape ray casts (geometry slice 2): known-value hits/misses ----
    {
        b2CastOutput out;
        b2RayCastInput in;

        // (1) ray hits a circle head-on: center (5,0) r=1, ray (0,0)->(10,0)
        b2Circle c1;  c1.center.x = 5.0;  c1.center.y = 0.0;  c1.radius = 1.0;
        in.origin.x = 0.0;  in.origin.y = 0.0;
        in.translation.x = 10.0;  in.translation.y = 0.0;  in.maxFraction = 1.0;
        b2RayCastCircle( &c1, &in, &out );
        Check( out.hit == true );
        Check( feq( out.fraction, 0.4 ) );        // hit at x=4 over a length-10 ray
        Check( feq( out.point.x, 4.0 ) && feq( out.point.y, 0.0 ) );
        Check( feq( out.normal.x, -1.0 ) && feq( out.normal.y, 0.0 ) );

        // (2) ray misses a circle offset in y: center (5,5) r=1
        b2Circle c2;  c2.center.x = 5.0;  c2.center.y = 5.0;  c2.radius = 1.0;
        b2RayCastCircle( &c2, &in, &out );
        Check( out.hit == false );

        // (3) maxFraction cutoff: same head-on circle but ray too short
        in.maxFraction = 0.2;
        b2RayCastCircle( &c1, &in, &out );
        Check( out.hit == false );               // hit is at fraction 0.4 > 0.2
        in.maxFraction = 1.0;

        // (4) initial overlap: ray starts inside the circle -> hit at origin
        b2Circle c3;  c3.center.x = 0.0;  c3.center.y = 0.0;  c3.radius = 1.0;
        b2RayCastCircle( &c3, &in, &out );
        Check( out.hit == true );
        Check( feq( out.point.x, 0.0 ) && feq( out.point.y, 0.0 ) );

        // (5) ray hits a box (radius-0 polygon): box [-1,1]^2, ray (-5,0)->(10,0)
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );
        in.origin.x = -5.0;  in.origin.y = 0.0;
        in.translation.x = 10.0;  in.translation.y = 0.0;  in.maxFraction = 1.0;
        b2RayCastPolygon( &box, &in, &out );
        Check( out.hit == true );
        Check( feq( out.fraction, 0.4 ) );        // left face at x=-1
        Check( feq( out.point.x, -1.0 ) && feq( out.point.y, 0.0 ) );
        Check( feq( out.normal.x, -1.0 ) && feq( out.normal.y, 0.0 ) );

        // (6) ray hits a vertical segment at x=2, ray (0,0)->(10,0)
        b2Segment seg;  seg.point1.x = 2.0;  seg.point1.y = -3.0;
        seg.point2.x = 2.0;  seg.point2.y = 3.0;
        in.origin.x = 0.0;  in.origin.y = 0.0;
        in.translation.x = 10.0;  in.translation.y = 0.0;  in.maxFraction = 1.0;
        b2RayCastSegment( &seg, &in, false, &out );
        Check( out.hit == true );
        Check( feq( out.fraction, 0.2 ) );        // x=2 over a length-10 ray
        Check( feq( out.point.x, 2.0 ) && feq( out.point.y, 0.0 ) );
        Check( feq( out.normal.x, -1.0 ) && feq( out.normal.y, 0.0 ) );  // faces the ray

        // (7) ray hits a vertical capsule side: c1 (5,-2), c2 (5,2), r=1
        b2Capsule cap;  cap.center1.x = 5.0;  cap.center1.y = -2.0;
        cap.center2.x = 5.0;  cap.center2.y = 2.0;  cap.radius = 1.0;
        b2RayCastCapsule( &cap, &in, &out );
        Check( out.hit == true );
        Check( feq( out.fraction, 0.4 ) );        // side at x=4
        Check( feq( out.point.x, 4.0 ) && feq( out.point.y, 0.0 ) );
        Check( feq( out.normal.x, -1.0 ) && feq( out.normal.y, 0.0 ) );

        // (8) capsule ENDPOINT-CAP path: aim down the axis at the top cap (v2).
        // qa > capsuleLength -> delegates to a circle at v2 (5,2) r=1.
        in.origin.x = 5.0;  in.origin.y = 6.0;
        in.translation.x = 0.0;  in.translation.y = -10.0;  in.maxFraction = 1.0;
        b2RayCastCapsule( &cap, &in, &out );
        Check( out.hit == true );
        Check( feq( out.fraction, 0.3 ) );        // top of cap at y=3 over length 10
        Check( feq( out.point.x, 5.0 ) && feq( out.point.y, 3.0 ) );
        Check( feq( out.normal.x, 0.0 ) && feq( out.normal.y, 1.0 ) );

        // (9) polygon INITIAL-OVERLAP path: ray starts inside the box -> hit at origin
        b2Polygon box2;  b2MakeBox( 1.0, 1.0, &box2 );
        in.origin.x = 0.0;  in.origin.y = 0.0;
        in.translation.x = 10.0;  in.translation.y = 0.0;  in.maxFraction = 1.0;
        b2RayCastPolygon( &box2, &in, &out );
        Check( out.hit == true );
        Check( feq( out.point.x, 0.0 ) && feq( out.point.y, 0.0 ) );

        // (10) one-sided segment BACK-FACE cull: the same ray that hits two-sided
        // (check 6) is culled when approaching from the segment's left side.
        b2Segment seg2;  seg2.point1.x = 2.0;  seg2.point1.y = -3.0;
        seg2.point2.x = 2.0;  seg2.point2.y = 3.0;
        in.origin.x = 0.0;  in.origin.y = 0.0;
        in.translation.x = 10.0;  in.translation.y = 0.0;  in.maxFraction = 1.0;
        b2RayCastSegment( &seg2, &in, true, &out );
        Check( out.hit == false );                // culled (back face)
        b2RayCastSegment( &seg2, &in, false, &out );
        Check( out.hit == true );                 // but two-sided still hits
    }

    // ---- b2World_CastRayClosest: ray through the broad phase -> closest hit ----
    {
        b2World world;  b2CreateWorld( &world );
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        // static box body at world (5,0), half-extents (1,1) -> world span x[4,6]
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_staticBody;
        bd.position.x = 5.0;  bd.position.y = 0.0;
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeId sb;  b2CreatePolygonShape( &world, &bb, &sdef, &box, &sb );

        b2Vec2 origin;  origin.x = 0.0;  origin.y = 0.0;
        b2Vec2 trans;   trans.x = 10.0;  trans.y = 0.0;
        b2CastOutput out;
        int hitId = b2World_CastRayClosest( &world, &origin, &trans, NULL, &out );

        Check( out.hit == true );
        Check( hitId == sb.index1 - 1 );          // the box shape was hit
        Check( feq( out.fraction, 0.4 ) );        // left face at world x=4
        Check( feq( out.point.x, 4.0 ) && feq( out.point.y, 0.0 ) );
        Check( feq( out.normal.x, -1.0 ) && feq( out.normal.y, 0.0 ) );

        // parallel ray above the box -> clean miss
        origin.y = 5.0;
        b2World_CastRayClosest( &world, &origin, &trans, NULL, &out );
        Check( out.hit == false );

        b2DestroyWorld( &world );
    }

    // ---- b2World_CastRayClosest picks the NEARER of two shapes ----
    {
        b2World world;  b2CreateWorld( &world );
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        // far box at (5,0)
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_staticBody;
        bd.position.x = 5.0;  bd.position.y = 0.0;
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &bb, &sdef, &box, &sbx );

        // near circle at (2,0) r=0.5 -> left edge at world x=1.5
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;
        b2BodyDef cd;  b2DefaultBodyDef( &cd );  cd.type = b2_staticBody;
        cd.position.x = 2.0;  cd.position.y = 0.0;
        b2BodyId bc;  b2CreateBody( &world, &cd, &bc );
        b2ShapeId scc;  b2CreateCircleShape( &world, &bc, &sdef, &cir, &scc );

        b2Vec2 origin;  origin.x = 0.0;  origin.y = 0.0;
        b2Vec2 trans;   trans.x = 10.0;  trans.y = 0.0;
        b2CastOutput out;
        int hitId = b2World_CastRayClosest( &world, &origin, &trans, NULL, &out );

        Check( out.hit == true );
        Check( hitId == scc.index1 - 1 );         // the NEARER circle, not the box
        Check( feq( out.fraction, 0.15 ) );       // world x=1.5 over length 10
        Check( feq( out.point.x, 1.5 ) && feq( out.point.y, 0.0 ) );
        Check( feq( out.normal.x, -1.0 ) && feq( out.normal.y, 0.0 ) );

        b2DestroyWorld( &world );
    }

    // ---- world ray cast exercises the ROTATION round-trip (non-identity q) ----
    // Body at origin rotated +90deg (c=0,s=1); circle local center (2,0) r=0.5 ->
    // world center (0,2). Ray straight down at x=0 from (0,5). If the local-frame
    // rotation were ignored/wrong-signed the circle would sit off the x=0 line and
    // the ray would MISS -> this is a discriminating check of b2Inv/RotateVector.
    {
        b2World world;  b2CreateWorld( &world );
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Circle cir;  cir.center.x = 2.0;  cir.center.y = 0.0;  cir.radius = 0.5;
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_staticBody;
        bd.position.x = 0.0;  bd.position.y = 0.0;
        bd.rotation.c = 0.0;  bd.rotation.s = 1.0;      // +90 degrees
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeId sc;  b2CreateCircleShape( &world, &bb, &sdef, &cir, &sc );

        b2Vec2 origin;  origin.x = 0.0;  origin.y = 5.0;
        b2Vec2 trans;   trans.x = 0.0;  trans.y = -10.0;   // straight down
        b2CastOutput out;
        int hitId = b2World_CastRayClosest( &world, &origin, &trans, NULL, &out );

        Check( out.hit == true );
        Check( hitId == sc.index1 - 1 );
        Check( feq( out.fraction, 0.25 ) );               // top of circle at world y=2.5
        Check( feq( out.point.x, 0.0 ) && feq( out.point.y, 2.5 ) );
        Check( feq( out.normal.x, 0.0 ) && feq( out.normal.y, 1.0 ) );

        b2DestroyWorld( &world );
    }

    // ---- b2TransformPolygon / b2MakeOffsetPolygon (place & rotate polygons) ----
    {
        // (a) translate a box by (10,0): vertices shift, normals unchanged (identity rot)
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );
        b2Transform xf;  xf.p.x = 10.0;  xf.p.y = 0.0;  xf.q.c = 1.0;  xf.q.s = 0.0;
        b2Polygon tp;  b2TransformPolygon( &xf, &box, &tp );
        Check( feq( tp.vertices[0].x, 9.0 )  && feq( tp.vertices[0].y, -1.0 ) );
        Check( feq( tp.vertices[2].x, 11.0 ) && feq( tp.vertices[2].y,  1.0 ) );
        Check( feq( tp.centroid.x, 10.0 ) && feq( tp.centroid.y, 0.0 ) );
        Check( feq( tp.normals[3].x, -1.0 ) && feq( tp.normals[3].y, 0.0 ) );

        // (b) invariant: makeOffset(hull,pos,rot) == transformPolygon(makePolygon(hull),{pos,rot})
        b2Hull hull;
        hull.count = 4;
        hull.points[0].x = -1.0;  hull.points[0].y = -1.0;
        hull.points[1].x =  1.0;  hull.points[1].y = -1.0;
        hull.points[2].x =  1.0;  hull.points[2].y =  1.0;
        hull.points[3].x = -1.0;  hull.points[3].y =  1.0;

        b2Vec2 pos;  pos.x = 3.0;  pos.y = -2.0;
        b2Rot  rot;  rot.c = 0.0;  rot.s = 1.0;      // +90 degrees

        b2Polygon P;  b2MakePolygon( &hull, 0.0, &P );
        b2Polygon Q;  b2MakeOffsetPolygon( &hull, &pos, &rot, &Q );
        b2Transform xf2;  xf2.p = pos;  xf2.q = rot;
        b2Polygon R;  b2TransformPolygon( &xf2, &P, &R );

        Check( feq( Q.vertices[0].x, R.vertices[0].x ) && feq( Q.vertices[0].y, R.vertices[0].y ) );
        Check( feq( Q.vertices[1].x, R.vertices[1].x ) && feq( Q.vertices[1].y, R.vertices[1].y ) );
        Check( feq( Q.vertices[2].x, R.vertices[2].x ) && feq( Q.vertices[2].y, R.vertices[2].y ) );
        Check( feq( Q.vertices[3].x, R.vertices[3].x ) && feq( Q.vertices[3].y, R.vertices[3].y ) );
        Check( feq( Q.normals[0].x, R.normals[0].x ) && feq( Q.normals[0].y, R.normals[0].y ) );
        Check( feq( Q.normals[2].x, R.normals[2].x ) && feq( Q.normals[2].y, R.normals[2].y ) );
        Check( feq( Q.centroid.x, R.centroid.x ) && feq( Q.centroid.y, R.centroid.y ) );

        // (c) concrete anchor: point (-1,-1) under pos(3,-2)+rot90 -> (1,-1)+pos = (4,-3)
        Check( feq( Q.vertices[0].x, 4.0 ) && feq( Q.vertices[0].y, -3.0 ) );
    }

    // ---- b2ShapeTestPoint (point/mouse picking): world point inside a shape? ----
    {
        // circle r=1 at world (5,0)
        b2Shape sh;  sh.type = b2_circleShape;
        sh.circle.center.x = 0.0;  sh.circle.center.y = 0.0;  sh.circle.radius = 1.0;
        b2Transform xf;  xf.p.x = 5.0;  xf.p.y = 0.0;  xf.q.c = 1.0;  xf.q.s = 0.0;
        b2Vec2 pt;  pt.x = 5.5;  pt.y = 0.0;
        Check( b2ShapeTestPoint( &sh, &xf, &pt ) == true );     // inside
        pt.x = 7.0;
        Check( b2ShapeTestPoint( &sh, &xf, &pt ) == false );    // outside

        // box [-1,1]^2 at origin
        b2Shape sb;  sb.type = b2_polygonShape;  b2MakeBox( 1.0, 1.0, &sb.polygon );
        b2Transform xf2;  xf2.p.x = 0.0;  xf2.p.y = 0.0;  xf2.q.c = 1.0;  xf2.q.s = 0.0;
        b2Vec2 p2;  p2.x = 0.5;  p2.y = 0.5;
        Check( b2ShapeTestPoint( &sb, &xf2, &p2 ) == true );
        p2.x = 2.0;  p2.y = 2.0;
        Check( b2ShapeTestPoint( &sb, &xf2, &p2 ) == false );

        // rotation round-trip: circle local center (2,0) on a +90deg body -> world (0,2)
        b2Shape sc;  sc.type = b2_circleShape;
        sc.circle.center.x = 2.0;  sc.circle.center.y = 0.0;  sc.circle.radius = 0.5;
        b2Transform xf3;  xf3.p.x = 0.0;  xf3.p.y = 0.0;  xf3.q.c = 0.0;  xf3.q.s = 1.0;
        b2Vec2 p3;  p3.x = 0.0;  p3.y = 2.0;
        Check( b2ShapeTestPoint( &sc, &xf3, &p3 ) == true );    // inside rotated circle
        p3.x = 2.0;  p3.y = 0.0;                                 // where it'd be if rot ignored
        Check( b2ShapeTestPoint( &sc, &xf3, &p3 ) == false );
    }

    // ---- JOINTS slice 1: distance-joint connectivity (create/destroy/edges) ----
    // No solve yet -- this exercises the cold b2Joint + dense b2JointSim storage,
    // the body joint-edge lists, solver-set placement, swap-remove-repair, and id
    // pool bookkeeping (mirrors the contact-connectivity discipline).
    {
        b2World world;  b2CreateWorld( &world );
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        // static anchor at (0,5)
        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 5.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        // two dynamic bodies hanging below
        b2BodyDef d0def;  b2DefaultBodyDef( &d0def );  d0def.type = b2_dynamicBody;
        d0def.position.x = 0.0;  d0def.position.y = 2.0;
        b2BodyId d0;  b2CreateBody( &world, &d0def, &d0 );
        int d0Id = b2GetBodyFullId( &world, &d0 )->id;

        b2BodyDef d1def;  b2DefaultBodyDef( &d1def );  d1def.type = b2_dynamicBody;
        d1def.position.x = 1.0;  d1def.position.y = 2.0;
        b2BodyId d1;  b2CreateBody( &world, &d1def, &d1 );
        int d1Id = b2GetBodyFullId( &world, &d1 )->id;

        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;  fA.q.c = 1.0;  fA.q.s = 0.0;
        b2Transform fB;  fB.p.x = 0.0;  fB.p.y = 0.0;  fB.q.c = 1.0;  fB.q.s = 0.0;

        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];

        // create joint 0: anchor(static) <-> d0(dynamic) -> awake set
        int j0 = b2CreateDistanceJoint( &world, anchorId, d0Id, &fA, &fB, 3.0, false );
        Check( aset->jointSims.count == 1 );                         // one sim emplaced
        Check( b2GetIdCount( &world.jointIdPool ) == 1 );            // one live joint id
        b2Joint* cj0 = &world.joints.data[ j0 ];
        Check( cj0->setIndex == b2_awakeSet );                       // dynamic involved -> awake
        Check( cj0->type == b2_distanceJoint );
        Check( cj0->localIndex == 0 );
        b2JointSim* s0 = b2GetJointSim( &world, cj0 );
        Check( s0->bodyIdA == anchorId && s0->bodyIdB == d0Id );     // frame order preserved
        Check( s0->type == b2_distanceJoint );
        Check( feq( s0->distanceJoint.length, 3.0 ) );              // rigid length stored
        Check( s0->distanceJoint.enableSpring == false );

        // both bodies see the joint on their edge lists
        b2Body* anchorBody = &world.bodies.data[ anchorId ];
        b2Body* d0Body = &world.bodies.data[ d0Id ];
        Check( anchorBody->jointCount == 1 );
        Check( d0Body->jointCount == 1 );
        Check( anchorBody->headJointKey == ( ( j0 << 1 ) | 0 ) );    // anchor is edge 0
        Check( d0Body->headJointKey == ( ( j0 << 1 ) | 1 ) );       // d0 is edge 1

        // create joint 1: anchor <-> d1  (anchor now carries two joints)
        int j1 = b2CreateDistanceJoint( &world, anchorId, d1Id, &fA, &fB, 3.0, false );
        Check( aset->jointSims.count == 2 );
        Check( b2GetIdCount( &world.jointIdPool ) == 2 );
        Check( anchorBody->jointCount == 2 );
        // anchor's list head is now j1's edge0, whose next is j0's edge0
        Check( anchorBody->headJointKey == ( ( j1 << 1 ) | 0 ) );
        b2Joint* cj1 = &world.joints.data[ j1 ];
        Check( b2JointEdgeAt( cj1, 0 )->nextKey == ( ( j0 << 1 ) | 0 ) );
        Check( b2JointEdgeAt( cj0, 0 )->prevKey == ( ( j1 << 1 ) | 0 ) );

        // destroy joint 0: swap-remove repairs the moved (j1) sim's localIndex
        b2DestroyJointInternal( &world, cj0, false );
        Check( aset->jointSims.count == 1 );
        Check( b2GetIdCount( &world.jointIdPool ) == 1 );
        Check( anchorBody->jointCount == 1 );
        Check( d0Body->jointCount == 0 );                           // d0 unlinked
        Check( cj1->localIndex == 0 );                              // j1 moved into slot 0
        Check( aset->jointSims.data[ 0 ].jointId == j1 );           // and its sim points back
        Check( anchorBody->headJointKey == ( ( j1 << 1 ) | 0 ) );   // list head repaired

        // destroy joint 1: everything returns to empty
        b2DestroyJointInternal( &world, cj1, false );
        Check( aset->jointSims.count == 0 );
        Check( b2GetIdCount( &world.jointIdPool ) == 0 );
        Check( anchorBody->jointCount == 0 );
        Check( world.bodies.data[ d1Id ].jointCount == 0 );

        // static<->static joint lands in the static set, not the awake set
        b2BodyDef s2def;  b2DefaultBodyDef( &s2def );  s2def.type = b2_staticBody;
        s2def.position.x = 2.0;  s2def.position.y = 5.0;
        b2BodyId s2;  b2CreateBody( &world, &s2def, &s2 );
        int s2Id = b2GetBodyFullId( &world, &s2 )->id;
        int jStatic = b2CreateDistanceJoint( &world, anchorId, s2Id, &fA, &fB, 2.0, false );
        Check( world.joints.data[ jStatic ].setIndex == b2_staticSet );
        Check( world.solverSets.data[ b2_staticSet ].jointSims.count == 1 );
        Check( aset->jointSims.count == 0 );                        // not in the awake set
        b2DestroyJointInternal( &world, &world.joints.data[ jStatic ], false );

        b2DestroyWorld( &world );
    }

    // ---- JOINTS slice 1: create/destroy soak leaves no leak / no fault ----
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 5.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef ddef;  b2DefaultBodyDef( &ddef );  ddef.type = b2_dynamicBody;
        ddef.position.x = 0.0;  ddef.position.y = 2.0;
        b2BodyId dbody;  b2CreateBody( &world, &ddef, &dbody );
        int dId = b2GetBodyFullId( &world, &dbody )->id;

        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;  fA.q.c = 1.0;  fA.q.s = 0.0;

        int n;
        for( n = 0; n < 20; n++ )
        {
            int jid = b2CreateDistanceJoint( &world, anchorId, dId, &fA, &fA, 3.0, false );
            b2DestroyJointInternal( &world, &world.joints.data[ jid ], false );
        }

        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        Check( b2GetIdCount( &world.jointIdPool ) == 0 );           // no leaked joint ids
        Check( aset->jointSims.count == 0 );                        // no leaked sims
        Check( b2GetBodyFullId( &world, &anchor )->jointCount == 0 );
        Check( b2GetBodyFullId( &world, &dbody )->jointCount == 0 );

        b2DestroyWorld( &world );
    }

    // ---- JOINTS slice 2: rigid distance joint holds LENGTH (vertical drop) ----
    // Static anchor above; a dynamic body released BELOW the rest length is pulled
    // UP to exactly `length` below the anchor and hangs there. Contact-free (the
    // anchor is shapeless, the body's lone circle pairs with nothing) so this
    // isolates the joint math from the contact solver.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 5.0;         // 5 below anchor (> length 3)
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        int bodyIdInt = b2GetBodyFullId( &world, &body )->id;
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;
        b2ShapeId scir;  b2CreateCircleShape( &world, &body, &sdef, &cir, &scir );

        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;  fA.q.c = 1.0;  fA.q.s = 0.0;
        b2Transform fB;  fB.p.x = 0.0;  fB.p.y = 0.0;  fB.q.c = 1.0;  fB.q.s = 0.0;
        b2CreateDistanceJoint( &world, anchorId, bodyIdInt, &fA, &fB, 3.0, false );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 300; k++ )  b2World_Step( &world, dt, 4 );

        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &body ) );
        float dx = sim->center.x - 0.0;
        float dy = sim->center.y - 10.0;
        float dist = sqrt( dx * dx + dy * dy );
        diagA = sim->center.y;
        diagB = dist;

        Check( sim->center.y > 6.7 && sim->center.y < 7.3 );   // hangs ~3 below anchor(10)
        Check( fabs( sim->center.x ) < 0.2 );                  // straight down, no x drift
        Check( dist > 2.85 && dist < 3.15 );                   // rest length preserved
        Check( sim->center.y > 6.0 );                          // was PULLED UP from y=5

        b2DestroyWorld( &world );
    }

    // ---- JOINTS slice 2: pendulum -- length preserved THROUGH the swing ----
    // Body starts at rest length but offset horizontally, so gravity makes it
    // swing. A rigid joint must keep |body - anchor| == length at every step
    // (mid-arc, not just at rest), then it settles hanging straight down.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 3.0;  bdef.position.y = 10.0;        // horizontal, distance 3 = length
        bdef.linearDamping = 0.7;   // a rigid joint adds NO tangential damping; this
                                    // lets the swing settle so the "hangs down" asserts
                                    // are meaningful (length-invariance holds regardless)
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        int bodyIdInt = b2GetBodyFullId( &world, &body )->id;
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;
        b2ShapeId scir;  b2CreateCircleShape( &world, &body, &sdef, &cir, &scir );

        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;  fA.q.c = 1.0;  fA.q.s = 0.0;
        b2CreateDistanceJoint( &world, anchorId, bodyIdInt, &fA, &fA, 3.0, false );

        float dt = 1.0 / 60.0;  int k;
        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &body ) );

        // mid-swing (~0.5s in): the body has moved off its start but the joint
        // must still hold the length within a tight tolerance.
        float minDist = 100.0;  float maxDist = 0.0;
        for( k = 0; k < 40; k++ )
        {
            b2World_Step( &world, dt, 4 );
            float dx = sim->center.x;  float dy = sim->center.y - 10.0;
            float d = sqrt( dx * dx + dy * dy );
            if( d < minDist )  minDist = d;
            if( d > maxDist )  maxDist = d;
        }
        diagC = minDist;  diagD = maxDist;
        Check( sim->center.y < 9.5 );          // it actually swung DOWN (moved off start)
        Check( minDist > 2.7 );                // length never collapsed
        Check( maxDist < 3.3 );                // length never stretched

        // let it settle -> hangs straight down at (0,7)
        for( k = 0; k < 500; k++ )  b2World_Step( &world, dt, 4 );
        float ex = sim->center.x;  float ey = sim->center.y - 10.0;
        float edist = sqrt( ex * ex + ey * ey );
        Check( fabs( sim->center.x ) < 0.3 );  // settled under the anchor
        Check( sim->center.y > 6.6 && sim->center.y < 7.4 );
        Check( edist > 2.85 && edist < 3.15 ); // final length correct

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: revolute (hinge) pins a pivot while the arm swings freely ----
    // A horizontal box-"arm" is pinned at its LEFT edge to a static anchor. Under
    // gravity it rotates about the pivot like a pendulum; the joint must keep the
    // arm's pivot point coincident with the anchor at all times, then it settles
    // hanging straight down. Contact-free (anchor shapeless; arm pairs with nothing).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        // arm: box half-extents (1, 0.25), centered at (1,10) -> left edge at (0,10)
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 1.0;  bdef.position.y = 10.0;
        bdef.angularDamping = 2.0;   // settle the swing fast (hinge adds no damping);
                                     // damping never moves the equilibrium, only reaches it sooner
        b2BodyId arm;  b2CreateBody( &world, &bdef, &arm );
        int armId = b2GetBodyFullId( &world, &arm )->id;
        b2Polygon armBox;  b2MakeBox( 1.0, 0.25, &armBox );
        b2ShapeId sarm;  b2CreatePolygonShape( &world, &arm, &sdef, &armBox, &sarm );

        // pin anchor point (anchor center) to the arm's left-edge-center (-1,0)
        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;   fA.q.c = 1.0;  fA.q.s = 0.0;
        b2Transform fB;  fB.p.x = -1.0; fB.p.y = 0.0;   fB.q.c = 1.0;  fB.q.s = 0.0;
        b2CreateRevoluteJoint( &world, anchorId, armId, &fA, &fB, false );

        b2Vec2 localPivot;  localPivot.x = -1.0;  localPivot.y = 0.0;
        float dt = 1.0 / 60.0;  int k;
        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &arm ) );

        // during the swing the pivot must stay glued to the anchor at (0,10)
        float maxPivotErr = 0.0;
        for( k = 0; k < 60; k++ )
        {
            b2World_Step( &world, dt, 4 );
            b2Vec2 pw;  b2TransformPoint( &sim->transform, &localPivot, &pw );
            float ex = pw.x - 0.0;  float ey = pw.y - 10.0;
            float e = sqrt( ex * ex + ey * ey );
            if( e > maxPivotErr )  maxPivotErr = e;
        }
        diagA = maxPivotErr;
        diagB = sim->transform.q.s;
        Check( maxPivotErr < 0.05 );          // hinge held the pivot throughout the swing
        Check( sim->center.y < 9.5 );         // the arm actually rotated/fell

        // settle -> arm hangs straight down: center 1 below the pivot at (0,9),
        // rotated -90deg (local +x now points down: q.c~0, q.s~-1)
        for( k = 0; k < 700; k++ )  b2World_Step( &world, dt, 4 );
        b2Vec2 pw2;  b2TransformPoint( &sim->transform, &localPivot, &pw2 );
        diagC = sim->center.y;
        diagD = sim->center.x;
        Check( sqrt( (pw2.x)*(pw2.x) + (pw2.y-10.0)*(pw2.y-10.0) ) < 0.05 ); // pivot still glued
        Check( fabs( sim->center.x ) < 0.2 );                 // COM under the pivot
        Check( sim->center.y > 8.7 && sim->center.y < 9.3 );  // ~1 below pivot(10)
        Check( sim->transform.q.c < 0.15 && sim->transform.q.c > -0.15 ); // rotated ~ -90deg
        Check( sim->transform.q.s < -0.85 );

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: weld rigidly binds a body (no fall, no rotation) ----
    // A box is welded to a static anchor at an OFFSET (anchor point at the box's
    // left edge). Unlike a revolute (which would swing the box down to hang under
    // the pivot), the weld locks BOTH position and orientation, so under gravity the
    // box stays put at its start pose. center.x staying ~2 (not swinging to ~0) is
    // the discriminator between weld and hinge. Contact-free.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        // box arm centered at (2,10); left edge (local -2,0) sits at the anchor
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 2.0;  bdef.position.y = 10.0;
        bdef.linearDamping = 0.5;  bdef.angularDamping = 0.5;   // settle any transient ring
        b2BodyId arm;  b2CreateBody( &world, &bdef, &arm );
        int armId = b2GetBodyFullId( &world, &arm )->id;
        b2Polygon armBox;  b2MakeBox( 2.0, 0.25, &armBox );
        b2ShapeId sarm;  b2CreatePolygonShape( &world, &arm, &sdef, &armBox, &sarm );

        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;   fA.q.c = 1.0;  fA.q.s = 0.0;
        b2Transform fB;  fB.p.x = -2.0; fB.p.y = 0.0;   fB.q.c = 1.0;  fB.q.s = 0.0;
        b2CreateWeldJoint( &world, anchorId, armId, &fA, &fB, false );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 200; k++ )  b2World_Step( &world, dt, 4 );

        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &arm ) );
        b2Vec2 localPivot;  localPivot.x = -2.0;  localPivot.y = 0.0;
        b2Vec2 pw;  b2TransformPoint( &sim->transform, &localPivot, &pw );
        float pinErr = sqrt( (pw.x)*(pw.x) + (pw.y - 10.0)*(pw.y - 10.0) );
        diagA = sim->center.x;
        diagB = sim->center.y;
        diagC = sim->transform.q.s;
        diagD = pinErr;

        Check( sim->center.x > 1.8 && sim->center.x < 2.2 );   // did NOT swing (weld, not hinge)
        Check( sim->center.y > 9.7 && sim->center.y < 10.3 );  // did NOT fall
        Check( sim->transform.q.c > 0.95 );                    // orientation locked (identity)
        Check( fabs( sim->transform.q.s ) < 0.15 );            // no rotation
        Check( pinErr < 0.05 );                                // anchor point held at (0,10)

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: prismatic (slider) locks cross-axis + rotation, slides on axis ----
    // Horizontal slider (axis = +x) between a static anchor and a dynamic body.
    // Gravity has BOTH components (5,-10): the perpendicular lock holds the body UP
    // against the -y pull (y stays ~10) while the body slides freely right along +x
    // under the +x pull; rotation stays locked. y-held + x-slides + no-rotation
    // uniquely identifies a slider (weld wouldn't slide; revolute would rotate). Contact-free.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 5.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 10.0;
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        int bodyIdInt = b2GetBodyFullId( &world, &body )->id;
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;
        b2ShapeId scir;  b2CreateCircleShape( &world, &body, &sdef, &cir, &scir );

        // both frames identity -> axis = +x (horizontal), reference angle 0 (no rotation)
        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;  fA.q.c = 1.0;  fA.q.s = 0.0;
        b2Transform fB;  fB.p.x = 0.0;  fB.p.y = 0.0;  fB.q.c = 1.0;  fB.q.s = 0.0;
        b2CreatePrismaticJoint( &world, anchorId, bodyIdInt, &fA, &fB, false );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 60; k++ )  b2World_Step( &world, dt, 4 );

        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &body ) );
        diagA = sim->center.x;
        diagB = sim->center.y;
        diagC = sim->transform.q.s;

        Check( fabs( sim->center.y - 10.0 ) < 0.3 );   // perp lock holds it UP vs -y gravity
        Check( sim->center.x > 1.0 );                  // but it slides freely right on +x
        Check( sim->transform.q.c > 0.98 );            // rotation locked (identity)
        Check( fabs( sim->transform.q.s ) < 0.1 );

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: revolute MOTOR drives the hinge to a target spin speed ----
    // A box pinned at its center to a static anchor (no gravity). The motor drives
    // the relative angular velocity toward motorSpeed; with a high torque cap the
    // body spins up to ~motorSpeed within a few steps.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;   // isolate the motor
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 0.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        int bodyIdInt = b2GetBodyFullId( &world, &body )->id;
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &body, &sdef, &box, &sbx );

        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;  fA.q.c = 1.0;  fA.q.s = 0.0;
        int jid = b2CreateRevoluteJoint( &world, anchorId, bodyIdInt, &fA, &fA, false );
        b2JointSim* jsim = b2GetJointSim( &world, &world.joints.data[ jid ] );
        jsim->revoluteJoint.enableMotor = true;
        jsim->revoluteJoint.motorSpeed = 2.0;
        jsim->revoluteJoint.maxMotorTorque = 100.0;

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 60; k++ )  b2World_Step( &world, dt, 4 );

        b2Body* bb = b2GetBodyFullId( &world, &body );
        b2BodyState* st = b2GetBodyState( &world, bb );
        b2BodySim* sim = b2GetBodySim( &world, bb );
        diagA = st->angularVelocity;
        diagB = sim->transform.q.s;
        Check( st->angularVelocity > 1.7 && st->angularVelocity < 2.3 );  // motor reached ~2 rad/s
        Check( fabs( sim->transform.q.s ) > 0.3 );                        // and it actually rotated

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: revolute LIMIT stops a swinging arm before it hangs ----
    // An arm pinned at its left edge swings down under gravity but is caught by the
    // lower angle limit at -0.5 rad, resting there instead of hanging at ~-1.57.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 1.0;  bdef.position.y = 10.0;
        bdef.angularDamping = 1.0;   // settle against the limit
        b2BodyId arm;  b2CreateBody( &world, &bdef, &arm );
        int armId = b2GetBodyFullId( &world, &arm )->id;
        b2Polygon armBox;  b2MakeBox( 1.0, 0.25, &armBox );
        b2ShapeId sarm;  b2CreatePolygonShape( &world, &arm, &sdef, &armBox, &sarm );

        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;   fA.q.c = 1.0;  fA.q.s = 0.0;
        b2Transform fB;  fB.p.x = -1.0; fB.p.y = 0.0;   fB.q.c = 1.0;  fB.q.s = 0.0;
        int jid = b2CreateRevoluteJoint( &world, anchorId, armId, &fA, &fB, false );
        b2JointSim* jsim = b2GetJointSim( &world, &world.joints.data[ jid ] );
        jsim->revoluteJoint.enableLimit = true;
        jsim->revoluteJoint.lowerAngle = -0.5;
        jsim->revoluteJoint.upperAngle = 0.5;

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 400; k++ )  b2World_Step( &world, dt, 4 );

        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &arm ) );
        // joint angle == arm rotation angle (anchor is identity) = atan2(q.s,q.c)
        float angle = atan2( sim->transform.q.s, sim->transform.q.c );
        diagC = angle;
        diagD = sim->transform.q.s;
        Check( angle > -0.65 && angle < -0.35 );   // caught at the -0.5 lower limit
        Check( sim->transform.q.s > -0.6 );        // did NOT hang down to ~-1.57 (q.s ~ -1)

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: prismatic LIMIT stops a sliding body at a translation bound ----
    // A vertical slider (axis points down): the body slides down under gravity but
    // is caught by the upper translation limit at 3, resting 3 below the anchor (y=7)
    // instead of falling forever.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 10.0;
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        int bodyIdInt = b2GetBodyFullId( &world, &body )->id;
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;
        b2ShapeId scir;  b2CreateCircleShape( &world, &body, &sdef, &cir, &scir );

        // frames rotated -90deg so the slide axis (frame +x) points DOWN (0,-1)
        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;  fA.q.c = 0.0;  fA.q.s = -1.0;
        b2Transform fB;  fB.p.x = 0.0;  fB.p.y = 0.0;  fB.q.c = 0.0;  fB.q.s = -1.0;
        int jid = b2CreatePrismaticJoint( &world, anchorId, bodyIdInt, &fA, &fB, false );
        b2JointSim* jsim = b2GetJointSim( &world, &world.joints.data[ jid ] );
        jsim->prismaticJoint.enableLimit = true;
        jsim->prismaticJoint.lowerTranslation = -1.0;
        jsim->prismaticJoint.upperTranslation = 3.0;   // stop 3 below the anchor

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 300; k++ )  b2World_Step( &world, dt, 4 );

        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &body ) );
        diagA = sim->center.y;
        diagB = sim->center.x;
        Check( sim->center.y > 6.7 && sim->center.y < 7.3 );  // caught at translation 3 (y=7)
        Check( fabs( sim->center.x ) < 0.2 );                 // stayed on the axis
        Check( sim->center.y < 8.0 );                         // it DID slide down (not held at 10)

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: prismatic MOTOR drives a body along the axis ----
    // Horizontal slider, no gravity: the motor drives the axial speed to 3 m/s, so
    // the body slides right at ~3 m/s.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 0.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        int bodyIdInt = b2GetBodyFullId( &world, &body )->id;
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;
        b2ShapeId scir;  b2CreateCircleShape( &world, &body, &sdef, &cir, &scir );

        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;  fA.q.c = 1.0;  fA.q.s = 0.0;   // axis = +x
        int jid = b2CreatePrismaticJoint( &world, anchorId, bodyIdInt, &fA, &fA, false );
        b2JointSim* jsim = b2GetJointSim( &world, &world.joints.data[ jid ] );
        jsim->prismaticJoint.enableMotor = true;
        jsim->prismaticJoint.motorSpeed = 3.0;
        jsim->prismaticJoint.maxMotorForce = 100.0;

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 60; k++ )  b2World_Step( &world, dt, 4 );

        b2Body* bb = b2GetBodyFullId( &world, &body );
        b2BodyState* st = b2GetBodyState( &world, bb );
        b2BodySim* sim = b2GetBodySim( &world, bb );
        diagC = st->linearVelocity.x;
        diagD = sim->center.x;
        Check( st->linearVelocity.x > 2.7 && st->linearVelocity.x < 3.3 );  // motor reached ~3 m/s
        Check( sim->center.x > 2.0 );                                       // slid right along axis
        Check( fabs( sim->center.y ) < 0.1 );                              // perp lock held y

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: wheel (suspension) -- perp line + limit + FREE spinning motor ----
    // Vertical axis. The body slides down under gravity, caught by the upper limit
    // (rests 2 below the anchor); the perpendicular constraint keeps it on the x=0
    // line; and the motor spins the wheel freely (a prismatic would LOCK rotation --
    // that free spin is the wheel-vs-slider discriminator).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 10.0;
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        int bodyIdInt = b2GetBodyFullId( &world, &body )->id;
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &body, &sdef, &box, &sbx );

        // frameA rotated -90deg -> slide axis points DOWN; frameB.q irrelevant (no angle constraint)
        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;  fA.q.c = 0.0;  fA.q.s = -1.0;
        b2Transform fB;  fB.p.x = 0.0;  fB.p.y = 0.0;  fB.q.c = 1.0;  fB.q.s = 0.0;
        int jid = b2CreateWheelJoint( &world, anchorId, bodyIdInt, &fA, &fB, false );
        b2JointSim* jsim = b2GetJointSim( &world, &world.joints.data[ jid ] );
        jsim->wheelJoint.enableLimit = true;
        jsim->wheelJoint.lowerTranslation = -1.0;
        jsim->wheelJoint.upperTranslation = 2.0;   // rest 2 below the anchor (y=8)
        jsim->wheelJoint.enableMotor = true;
        jsim->wheelJoint.motorSpeed = 2.0;
        jsim->wheelJoint.maxMotorTorque = 100.0;

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 300; k++ )  b2World_Step( &world, dt, 4 );

        b2Body* bb = b2GetBodyFullId( &world, &body );
        b2BodySim* sim = b2GetBodySim( &world, bb );
        b2BodyState* st = b2GetBodyState( &world, bb );
        diagA = sim->center.y;
        diagB = sim->center.x;
        diagC = st->angularVelocity;
        Check( sim->center.y > 7.6 && sim->center.y < 8.4 );   // slid down, caught at limit (y=8)
        Check( fabs( sim->center.x ) < 0.2 );                  // perp line constraint held x=0
        Check( st->angularVelocity > 1.7 && st->angularVelocity < 2.3 );  // wheel spins FREELY (motor)

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: DYNAMIC-DYNAMIC coverage (exercises the body-A side!) ----
    // Every joint test above uses a STATIC anchor as body A, whose invMass/invI = 0,
    // so the A-side impulse application (vA/wA updates + write-back) was a no-op and
    // never actually ran. These two scenes pin two DYNAMIC bodies together so the
    // A-side math is exercised, and check momentum conservation.

    // (1) rigid distance joint, no gravity: shove B along the axis -> it must yank A
    //     into motion; equal masses => both converge to the COM speed (1).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;

        b2BodyDef ad;  b2DefaultBodyDef( &ad );  ad.type = b2_dynamicBody;
        ad.position.x = 0.0;  ad.position.y = 0.0;
        b2BodyId bA;  b2CreateBody( &world, &ad, &bA );
        int idA = b2GetBodyFullId( &world, &bA )->id;
        b2ShapeId sA;  b2CreateCircleShape( &world, &bA, &sdef, &cir, &sA );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 3.0;  bd.position.y = 0.0;
        bd.linearVelocity.x = 2.0;  bd.linearVelocity.y = 0.0;   // shove B away along +x
        b2BodyId bB;  b2CreateBody( &world, &bd, &bB );
        int idB = b2GetBodyFullId( &world, &bB )->id;
        b2ShapeId sB;  b2CreateCircleShape( &world, &bB, &sdef, &cir, &sB );

        b2Transform f;  f.p.x = 0.0;  f.p.y = 0.0;  f.q.c = 1.0;  f.q.s = 0.0;
        b2CreateDistanceJoint( &world, idA, idB, &f, &f, 3.0, false );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 40; k++ )  b2World_Step( &world, dt, 4 );

        b2BodyState* stA = b2GetBodyState( &world, b2GetBodyFullId( &world, &bA ) );
        b2BodyState* stB = b2GetBodyState( &world, b2GetBodyFullId( &world, &bB ) );
        b2BodySim*   siA = b2GetBodySim( &world, b2GetBodyFullId( &world, &bA ) );
        diagA = stA->linearVelocity.x;
        diagB = stB->linearVelocity.x;
        Check( stA->linearVelocity.x > 0.7 && stA->linearVelocity.x < 1.3 );  // A YANKED (A-side ran!)
        Check( stB->linearVelocity.x > 0.7 && stB->linearVelocity.x < 1.3 );  // B decelerated
        Check( fabs( stA->linearVelocity.x - stB->linearVelocity.x ) < 0.3 ); // moving together
        Check( siA->center.x > 0.1 );                                         // A actually displaced

        b2DestroyWorld( &world );
    }

    // (2) rigid weld, no gravity: shove B along the connecting line -> the pair moves
    //     as one rigid body (equal masses => both at COM speed 0.5), no rotation.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;

        b2BodyDef ad;  b2DefaultBodyDef( &ad );  ad.type = b2_dynamicBody;
        ad.position.x = 0.0;  ad.position.y = 0.0;
        b2BodyId bA;  b2CreateBody( &world, &ad, &bA );
        int idA = b2GetBodyFullId( &world, &bA )->id;
        b2ShapeId sA;  b2CreateCircleShape( &world, &bA, &sdef, &cir, &sA );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 2.0;  bd.position.y = 0.0;
        bd.linearVelocity.x = 1.0;  bd.linearVelocity.y = 0.0;   // shove B along +x
        b2BodyId bB;  b2CreateBody( &world, &bd, &bB );
        int idB = b2GetBodyFullId( &world, &bB )->id;
        b2ShapeId sB;  b2CreateCircleShape( &world, &bB, &sdef, &cir, &sB );

        // weld anchored at the midpoint (1,0): A's local (1,0) and B's local (-1,0)
        b2Transform fA;  fA.p.x = 1.0;  fA.p.y = 0.0;   fA.q.c = 1.0;  fA.q.s = 0.0;
        b2Transform fB;  fB.p.x = -1.0; fB.p.y = 0.0;   fB.q.c = 1.0;  fB.q.s = 0.0;
        b2CreateWeldJoint( &world, idA, idB, &fA, &fB, false );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 40; k++ )  b2World_Step( &world, dt, 4 );

        b2BodyState* stA = b2GetBodyState( &world, b2GetBodyFullId( &world, &bA ) );
        b2BodyState* stB = b2GetBodyState( &world, b2GetBodyFullId( &world, &bB ) );
        b2BodySim*   siA = b2GetBodySim( &world, b2GetBodyFullId( &world, &bA ) );
        b2BodySim*   siB = b2GetBodySim( &world, b2GetBodyFullId( &world, &bB ) );
        diagC = stA->linearVelocity.x;
        diagD = stB->linearVelocity.x;
        Check( stA->linearVelocity.x > 0.35 && stA->linearVelocity.x < 0.65 ); // A dragged to ~0.5
        Check( stB->linearVelocity.x > 0.35 && stB->linearVelocity.x < 0.65 ); // B slowed to ~0.5
        Check( fabs( stA->linearVelocity.x - stB->linearVelocity.x ) < 0.15 ); // rigid: same velocity
        Check( fabs( siB->center.x - siA->center.x - 2.0 ) < 0.2 );            // separation held ~2
        Check( fabs( siA->transform.q.s ) < 0.1 );                            // no spurious rotation

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: public def-based API (b2*JointDef -> b2Create*JointDef) ----
    // Build a motorized revolute the DECLARATIVE way and confirm the def config
    // flows through to the sim + solve (the box spins up to the def's motorSpeed).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 0.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &body, &sdef, &box, &sbx );

        b2RevoluteJointDef jd;  b2DefaultRevoluteJointDef( &jd );
        jd.bodyIdA = anchor;
        jd.bodyIdB = body;
        jd.enableMotor = true;
        jd.motorSpeed = 2.0;
        jd.maxMotorTorque = 100.0;
        b2JointId jid;  b2CreateRevoluteJointDef( &world, &jd, &jid );

        // def config landed on the sim (handle -> int index -> sim)
        Check( b2Joint_IsValid( &world, &jid ) == true );
        b2JointSim* js = b2GetJointSimById( &world, jid.index1 - 1 );
        Check( js->type == b2_revoluteJoint );
        Check( js->revoluteJoint.enableMotor == true );
        Check( feq( js->revoluteJoint.motorSpeed, 2.0 ) );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 60; k++ )  b2World_Step( &world, dt, 4 );

        b2BodyState* st = b2GetBodyState( &world, b2GetBodyFullId( &world, &body ) );
        diagA = st->angularVelocity;
        Check( st->angularVelocity > 1.7 && st->angularVelocity < 2.3 );   // def motor spun it

        // the public destroy wrapper cleans up AND invalidates the handle
        b2DestroyJoint( &world, &jid );
        Check( b2GetIdCount( &world.jointIdPool ) == 0 );
        Check( b2Joint_IsValid( &world, &jid ) == false );                 // freed slot -> stale

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: distance SPRING -- a hanging body settles STRETCHED past rest ----
    // enableSpring routes b2SolveDistanceJoint to the soft path. For a soft spring of
    // frequency f the steady-state stretch of a hanging mass is x = g/w^2 (mass-independent),
    // w = 2*pi*f. Here f=1 Hz, g=10 -> x ~= 10/(2*pi)^2 ~= 0.253 -> length ~= 3.25 (NOT the
    // rigid 3.0). That the length exceeds 3.0 is the discriminator that the spring path ran.
    {
        b2World world;  b2CreateWorld( &world );
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int idAnc = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 7.0;                 // start at rest length 3
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        int idBody = b2GetBodyFullId( &world, &body )->id;
        b2ShapeId sb;  b2CreateCircleShape( &world, &body, &sdef, &cir, &sb );

        b2Transform f;  f.p.x = 0.0;  f.p.y = 0.0;  f.q.c = 1.0;  f.q.s = 0.0;
        int jid = b2CreateDistanceJoint( &world, idAnc, idBody, &f, &f, 3.0, false );
        b2DistanceJoint* dj = &b2GetJointSimById( &world, jid )->distanceJoint;
        dj->enableSpring = true;
        dj->hertz = 1.0;
        dj->dampingRatio = 0.7;

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 300; k++ )  b2World_Step( &world, dt, 4 );

        b2BodySim*   sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &body ) );
        b2BodyState* st  = b2GetBodyState( &world, b2GetBodyFullId( &world, &body ) );
        float length = 10.0 - sim->center.y;             // anchor at y=10, body below
        diagA = length;
        Check( length > 3.05 && length < 3.60 );         // stretched to soft-spring equilibrium
        Check( fabs( st->linearVelocity.y ) < 0.6 );     // settled

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: distance LIMIT (rope) -- upper length limit catches a falling body ----
    // enableSpring + enableLimit with a VERY soft spring (0.25 Hz -> natural length ~5) so the
    // maxLength=3 limit is what actually holds it. Exercises the limit (upper) branch.
    {
        b2World world;  b2CreateWorld( &world );
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int idAnc = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 9.0;                 // start length 1 (= rest/min)
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        int idBody = b2GetBodyFullId( &world, &body )->id;
        b2ShapeId sb;  b2CreateCircleShape( &world, &body, &sdef, &cir, &sb );

        b2Transform f;  f.p.x = 0.0;  f.p.y = 0.0;  f.q.c = 1.0;  f.q.s = 0.0;
        int jid = b2CreateDistanceJoint( &world, idAnc, idBody, &f, &f, 1.0, false );
        b2DistanceJoint* dj = &b2GetJointSimById( &world, jid )->distanceJoint;
        dj->enableSpring = true;
        dj->hertz = 0.25;
        dj->dampingRatio = 0.7;
        dj->enableLimit = true;
        dj->minLength = 1.0;
        dj->maxLength = 3.0;

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 500; k++ )  b2World_Step( &world, dt, 4 );

        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &body ) );
        float length = 10.0 - sim->center.y;
        diagB = length;
        Check( length > 2.6 && length < 3.4 );           // caught by the upper (maxLength) limit

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: collideConnected==false suppresses contact between jointed bodies ----
    // Tests BOTH halves: (b) creating the joint destroys the EXISTING contact, and
    // (a) the broad phase does not re-create it on later steps. Two overlapping dynamic
    // circles: step once so the contact forms, then join with collideConnected=false.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;

        b2BodyDef ad;  b2DefaultBodyDef( &ad );  ad.type = b2_dynamicBody;
        ad.position.x = 0.0;  ad.position.y = 0.0;
        b2BodyId bA;  b2CreateBody( &world, &ad, &bA );
        int idA = b2GetBodyFullId( &world, &bA )->id;
        b2ShapeId sA;  b2CreateCircleShape( &world, &bA, &sdef, &cir, &sA );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.5;  bd.position.y = 0.0;                     // overlaps A (centers 0.5 < 1.0)
        b2BodyId bB;  b2CreateBody( &world, &bd, &bB );
        int idB = b2GetBodyFullId( &world, &bB )->id;
        b2ShapeId sB;  b2CreateCircleShape( &world, &bB, &sdef, &cir, &sB );

        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        float dt = 1.0 / 60.0;
        b2World_Step( &world, dt, 4 );                                // pairing forms the contact
        diagC = aset->contactSims.count;
        Check( aset->contactSims.count >= 1 );                        // contact exists before the joint

        b2Transform f;  f.p.x = 0.0;  f.p.y = 0.0;  f.q.c = 1.0;  f.q.s = 0.0;
        b2CreateDistanceJoint( &world, idA, idB, &f, &f, 1.0, false );  // collideConnected = false
        Check( aset->contactSims.count == 0 );                        // (b) existing contact destroyed

        int k;  for( k = 0; k < 20; k++ )  b2World_Step( &world, dt, 4 );
        diagD = aset->contactSims.count;
        Check( aset->contactSims.count == 0 );                        // (a) not re-created by broad phase

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: b2DestroyBody tears down attached joints (soak, no dangling edges) ----
    // Formerly a KNOWN GAP: destroying a jointed body left its joint edges/sims dangling
    // -> fault. Repeatedly hang a fresh body from a static anchor, step, then destroy the
    // (jointed) body. If teardown is broken this FAULTS (ROM never reaches green). The
    // pools returning clean after each iteration proves the joint went with the body.
    {
        b2World world;  b2CreateWorld( &world );
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int idAnc = b2GetBodyFullId( &world, &anchor )->id;

        float dt = 1.0 / 60.0;
        bool clean = true;
        int iter;
        for( iter = 0; iter < 10; iter++ )
        {
            b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
            bdef.position.x = 0.0;  bdef.position.y = 7.0;
            b2BodyId body;  b2CreateBody( &world, &bdef, &body );
            int idBody = b2GetBodyFullId( &world, &body )->id;
            b2ShapeId sb;  b2CreateCircleShape( &world, &body, &sdef, &cir, &sb );

            b2Transform f;  f.p.x = 0.0;  f.p.y = 0.0;  f.q.c = 1.0;  f.q.s = 0.0;
            b2CreateDistanceJoint( &world, idAnc, idBody, &f, &f, 3.0, true );

            int k;  for( k = 0; k < 5; k++ )  b2World_Step( &world, dt, 4 );

            b2DestroyBody( &world, &body );                           // must tear down the joint
            if( b2GetIdCount( &world.jointIdPool ) != 0 )  clean = false;   // joint id reclaimed
        }
        Check( clean );                                              // every joint torn down w/ its body
        Check( b2GetIdCount( &world.jointIdPool ) == 0 );            // no leaked joint ids
        // reaching here at all means no fault across 10 create/join/step/destroy cycles

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: motor joint ANGULAR drive (kinematic-control spin) ----
    // Motor joint pins a box's center to a static anchor and drives the relative
    // angular velocity toward angularVelocity, capped by maxVelocityTorque. Like the
    // revolute motor but via the motor-joint solver's angular-velocity block.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 0.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int anchorId = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        int bodyIdInt = b2GetBodyFullId( &world, &body )->id;
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &body, &sdef, &box, &sbx );

        b2Transform fA;  fA.p.x = 0.0;  fA.p.y = 0.0;  fA.q.c = 1.0;  fA.q.s = 0.0;
        int jid = b2CreateMotorJoint( &world, anchorId, bodyIdInt, &fA, &fA, false );
        b2JointSim* jsim = b2GetJointSim( &world, &world.joints.data[ jid ] );
        jsim->motorJoint.angularVelocity = 2.0;
        jsim->motorJoint.maxVelocityTorque = 100.0;

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 60; k++ )  b2World_Step( &world, dt, 4 );

        b2Body* bb = b2GetBodyFullId( &world, &body );
        b2BodyState* st = b2GetBodyState( &world, bb );
        b2BodySim* sim = b2GetBodySim( &world, bb );
        diagA = st->angularVelocity;
        diagB = sim->transform.q.s;
        Check( st->angularVelocity > 1.7 && st->angularVelocity < 2.3 );  // motor reached ~2 rad/s
        Check( fabs( sim->transform.q.s ) > 0.3 );                        // and it actually rotated

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: motor joint LINEAR drive via the def API (kinematic mover) ----
    // Declarative motor joint drives a body's anchor velocity toward linearVelocity
    // (3,0), capped by maxVelocityForce. With no gravity the body reaches ~3 m/s +x.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 0.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &body, &sdef, &box, &sbx );

        b2MotorJointDef jd;  b2DefaultMotorJointDef( &jd );
        jd.bodyIdA = anchor;
        jd.bodyIdB = body;
        jd.linearVelocity.x = 3.0;  jd.linearVelocity.y = 0.0;
        jd.maxVelocityForce = 100.0;
        b2JointId jid;  b2CreateMotorJointDef( &world, &jd, &jid );

        b2JointSim* js = b2GetJointSimById( &world, jid.index1 - 1 );
        Check( js->type == b2_motorJoint );
        Check( feq( js->motorJoint.maxVelocityForce, 100.0 ) );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 60; k++ )  b2World_Step( &world, dt, 4 );

        b2BodyState* st = b2GetBodyState( &world, b2GetBodyFullId( &world, &body ) );
        b2BodySim*   sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &body ) );
        diagC = st->linearVelocity.x;
        diagD = sim->center.x;
        Check( st->linearVelocity.x > 2.6 && st->linearVelocity.x < 3.4 );  // driven to ~3 m/s
        Check( sim->center.x > 0.5 );                                       // and actually moved +x

        b2DestroyJoint( &world, &jid );                                     // motor joint destroys clean
        Check( b2GetIdCount( &world.jointIdPool ) == 0 );

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: b2JointId generation check detects a stale handle after slot reuse ----
    // Create A (handle hA), destroy it, create B -- the LIFO id pool hands back A's slot,
    // and B's create bumps that slot's generation. hA must then read INVALID via the
    // GENERATION mismatch specifically (the freed-slot check alone can't catch this: once
    // B occupies the slot, jointId != NULL again -- only the generation differs).
    {
        b2World world;  b2CreateWorld( &world );
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 7.0;
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        b2ShapeId sb;  b2CreateCircleShape( &world, &body, &sdef, &cir, &sb );

        b2DistanceJointDef jd;  b2DefaultDistanceJointDef( &jd );
        jd.bodyIdA = anchor;  jd.bodyIdB = body;  jd.length = 3.0;

        b2JointId hA;  b2CreateDistanceJointDef( &world, &jd, &hA );
        Check( b2Joint_IsValid( &world, &hA ) == true );
        b2DestroyJoint( &world, &hA );
        Check( b2Joint_IsValid( &world, &hA ) == false );          // freed slot

        b2JointId hB;  b2CreateDistanceJointDef( &world, &jd, &hB );
        Check( hB.index1 == hA.index1 );                           // LIFO reused A's exact slot...
        Check( hB.generation != hA.generation );                   // ...with a bumped generation
        Check( b2Joint_IsValid( &world, &hB ) == true );           // new handle valid
        Check( b2Joint_IsValid( &world, &hA ) == false );          // OLD handle stale via generation

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: filter joint lets two bodies overlap without colliding ----
    // A filter joint has no constraint; its only effect is to suppress collision between
    // its two bodies. Same overlapping-pair setup as the collideConnected test.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;

        b2BodyDef ad;  b2DefaultBodyDef( &ad );  ad.type = b2_dynamicBody;
        ad.position.x = 0.0;  ad.position.y = 0.0;
        b2BodyId bA;  b2CreateBody( &world, &ad, &bA );
        b2ShapeId sA;  b2CreateCircleShape( &world, &bA, &sdef, &cir, &sA );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.5;  bd.position.y = 0.0;                     // overlaps A
        b2BodyId bB;  b2CreateBody( &world, &bd, &bB );
        b2ShapeId sB;  b2CreateCircleShape( &world, &bB, &sdef, &cir, &sB );

        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        float dt = 1.0 / 60.0;
        b2World_Step( &world, dt, 4 );                                // contact forms
        Check( aset->contactSims.count >= 1 );

        b2FilterJointDef fj;  b2DefaultFilterJointDef( &fj );
        fj.bodyIdA = bA;  fj.bodyIdB = bB;
        b2JointId fh;  b2CreateFilterJointDef( &world, &fj, &fh );
        Check( b2Joint_GetType( &world, &fh ) == b2_filterJoint );
        Check( aset->contactSims.count == 0 );                        // filter joint dropped the contact

        int k;  for( k = 0; k < 20; k++ )  b2World_Step( &world, dt, 4 );
        Check( aset->contactSims.count == 0 );                        // stays suppressed

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: distance MOTOR drives the length rate (closes the untested branch) ----
    // enableSpring routes to the soft path; a near-zero spring (0.1 Hz) lets the motor
    // dominate. motorSpeed drives dL/dt -> the body is pushed outward along the axis.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 0.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );
        int idAnc = b2GetBodyFullId( &world, &anchor )->id;

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 3.0;  bdef.position.y = 0.0;                 // length 3 along +x
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        int idBody = b2GetBodyFullId( &world, &body )->id;
        b2ShapeId sb;  b2CreateCircleShape( &world, &body, &sdef, &cir, &sb );

        b2Transform f;  f.p.x = 0.0;  f.p.y = 0.0;  f.q.c = 1.0;  f.q.s = 0.0;
        int jid = b2CreateDistanceJoint( &world, idAnc, idBody, &f, &f, 3.0, false );
        b2DistanceJoint* dj = &b2GetJointSimById( &world, jid )->distanceJoint;
        dj->enableSpring = true;  dj->hertz = 0.1;  dj->dampingRatio = 0.1;   // near-free
        dj->enableMotor = true;   dj->motorSpeed = 2.0;  dj->maxMotorForce = 1000.0;

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 40; k++ )  b2World_Step( &world, dt, 4 );

        b2BodySim*   sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &body ) );
        b2BodyState* st  = b2GetBodyState( &world, b2GetBodyFullId( &world, &body ) );
        diagA = sim->center.x;                          // ~= distance from anchor at origin
        diagB = st->linearVelocity.x;
        Check( sim->center.x > 3.6 );                   // motor drove it outward (spring-only holds ~3)
        Check( st->linearVelocity.x > 1.2 && st->linearVelocity.x < 2.6 );  // ~motorSpeed

        b2DestroyWorld( &world );
    }

    // ---- JOINTS: runtime setter/getter API mutates a live joint ----
    // Create a revolute with the motor OFF, then turn it on at RUNTIME via the setters;
    // it must spin up. GetType + the geometric GetAngle read back the live joint.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 0.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId body;  b2CreateBody( &world, &bdef, &body );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &body, &sdef, &box, &sbx );

        b2RevoluteJointDef jd;  b2DefaultRevoluteJointDef( &jd );
        jd.bodyIdA = anchor;  jd.bodyIdB = body;               // motor OFF in the def
        b2JointId h;  b2CreateRevoluteJointDef( &world, &jd, &h );
        Check( b2Joint_GetType( &world, &h ) == b2_revoluteJoint );

        // enable + configure the motor at runtime through the setter API
        b2RevoluteJoint_EnableMotor( &world, &h, true );
        b2RevoluteJoint_SetMotorSpeed( &world, &h, 2.0 );
        b2RevoluteJoint_SetMaxMotorTorque( &world, &h, 100.0 );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 60; k++ )  b2World_Step( &world, dt, 4 );

        b2BodyState* st = b2GetBodyState( &world, b2GetBodyFullId( &world, &body ) );
        diagC = st->angularVelocity;
        Check( st->angularVelocity > 1.7 && st->angularVelocity < 2.3 );   // setter-enabled motor spun it
        float ang = b2RevoluteJoint_GetAngle( &world, &h );
        diagD = ang;
        Check( fabs( ang ) > 0.3 );                                       // geometric getter reads rotation

        b2DestroyWorld( &world );
    }

    // ---- PHASE C1: islands form per-body, merge on contact, free on destroy ----
    // (a) three separated dynamic bodies each get their own island at create time;
    // (b) stacking two dynamic boxes merges them into ONE island via their contact;
    // (c) destroying the bodies frees the islands (pool returns to 0).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;

        b2BodyDef d;  b2DefaultBodyDef( &d );  d.type = b2_dynamicBody;
        d.position.x = 0.0;   d.position.y = 0.0;   b2BodyId b0;  b2CreateBody( &world, &d, &b0 );
        d.position.x = 10.0;  d.position.y = 0.0;   b2BodyId b1;  b2CreateBody( &world, &d, &b1 );
        d.position.x = 20.0;  d.position.y = 0.0;   b2BodyId b2;  b2CreateBody( &world, &d, &b2 );
        b2ShapeId s0;  b2CreateCircleShape( &world, &b0, &sdef, &cir, &s0 );
        b2ShapeId s1;  b2CreateCircleShape( &world, &b1, &sdef, &cir, &s1 );
        b2ShapeId s2;  b2CreateCircleShape( &world, &b2, &sdef, &cir, &s2 );

        diagA = b2GetIdCount( &world.islandIdPool );
        Check( b2GetIdCount( &world.islandIdPool ) == 3 );          // one island per separated body
        b2Body* bb0 = b2GetBodyFullId( &world, &b0 );
        b2Body* bb1 = b2GetBodyFullId( &world, &b1 );
        Check( bb0->islandId != B2_NULL_INDEX );
        Check( bb0->islandId != bb1->islandId );                    // distinct islands

        int k;  for( k = 0; k < 20; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        Check( b2GetIdCount( &world.islandIdPool ) == 3 );          // no contacts -> still 3

        b2DestroyBody( &world, &b0 );
        b2DestroyBody( &world, &b1 );
        b2DestroyBody( &world, &b2 );
        Check( b2GetIdCount( &world.islandIdPool ) == 0 );          // islands freed with bodies

        b2DestroyWorld( &world );
    }

    // (b) contact merge: two dynamic boxes settle into a stack -> one island
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floor, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef ad;  b2DefaultBodyDef( &ad );  ad.type = b2_dynamicBody;
        ad.position.x = 0.0;  ad.position.y = 1.0;   b2BodyId ba;  b2CreateBody( &world, &ad, &ba );
        ad.position.y = 2.0;                          b2BodyId bb;  b2CreateBody( &world, &ad, &bb );
        b2ShapeId sa;  b2CreatePolygonShape( &world, &ba, &sdef, &box, &sa );
        b2ShapeId sbb; b2CreatePolygonShape( &world, &bb, &sdef, &box, &sbb );

        Check( b2GetIdCount( &world.islandIdPool ) == 2 );          // static floor has no island; 2 dyn boxes
        int k;  for( k = 0; k < 200; k++ )  b2World_Step( &world, 1.0/60.0, 4 );

        b2Body* pa = b2GetBodyFullId( &world, &ba );
        b2Body* pb = b2GetBodyFullId( &world, &bb );
        diagB = b2GetIdCount( &world.islandIdPool );
        Check( b2GetIdCount( &world.islandIdPool ) == 1 );          // A-B contact merged them
        Check( pa->islandId == pb->islandId );                      // same island
        b2Island* isl = &world.islands.data[ pa->islandId ];
        diagC = isl->bodyCount;
        Check( isl->bodyCount == 2 );                               // island holds both dynamic bodies
        Check( isl->contactCount >= 1 );                            // at least the A-B touching contact

        b2DestroyWorld( &world );
    }

    // ---- PHASE C2a: a settled body's island falls asleep (migrates to a sleeping set) ----
    // Sleep is opt-in (default off). A box settles on a static floor; after ~0.5s of
    // being slow its one-body island migrates out of the awake set into a sleeping set,
    // and it stays frozen there (the sleeping set is never integrated).
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;                          // opt in (default OFF)
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floor, &sf );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 1.0;
        b2BodyId bc;  b2CreateBody( &world, &bd, &bc );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sbx );

        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        Check( b2GetBodyFullId( &world, &bc )->setIndex == b2_awakeSet );   // starts awake
        Check( aset->bodySims.count == 1 );

        int k;  for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );

        aset = &world.solverSets.data[ b2_awakeSet ];      // RE-FETCH: solverSets grew (sleeping set)
        b2Body* body = b2GetBodyFullId( &world, &bc );
        diagA = body->setIndex;
        diagB = aset->bodySims.count;
        Check( body->setIndex >= b2_firstSleepingSet );    // migrated to a sleeping set
        Check( aset->bodySims.count == 0 );                // no awake dynamic bodies left
        Check( aset->islandSims.count == 0 );              // island left the awake set

        b2BodySim* sim = b2GetBodySim( &world, body );     // sim still reachable in its sleeping set
        diagC = sim->center.y;
        Check( sim->center.y > 0.9 && sim->center.y < 1.1 );   // resting on the floor
        float restY = sim->center.y;

        for( k = 0; k < 60; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        b2Body* body2 = b2GetBodyFullId( &world, &bc );
        b2BodySim* sim2 = b2GetBodySim( &world, body2 );
        Check( body2->setIndex >= b2_firstSleepingSet );   // still asleep
        Check( fabs( sim2->center.y - restY ) < 0.001 );   // frozen: no drift, no fall-through

        b2DestroyWorld( &world );
    }

    // ---- PHASE C2b: dropping a body on a SLEEPING pile wakes it, then it re-sleeps ----
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floor, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 1.0;
        b2BodyId b1;  b2CreateBody( &world, &bd, &b1 );
        b2ShapeId s1;  b2CreatePolygonShape( &world, &b1, &sdef, &box, &s1 );

        int k;  for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        Check( b2GetBodyFullId( &world, &b1 )->setIndex >= b2_firstSleepingSet );   // asleep

        // SLIDE a fast wrecker box horizontally into the sleeping one (floor level)
        bd.position.x = -3.0;  bd.position.y = 1.0;
        bd.linearVelocity.x = 10.0;  bd.linearVelocity.y = 0.0;
        b2BodyId b2b;  b2CreateBody( &world, &bd, &b2b );
        b2ShapeId s2;  b2CreatePolygonShape( &world, &b2b, &sdef, &box, &s2 );
        bd.linearVelocity.x = 0.0;   // reset def for any later use

        for( k = 0; k < 40; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        b2BodySim* sim1 = b2GetBodySim( &world, b2GetBodyFullId( &world, &b1 ) );
        diagA = b2GetBodyFullId( &world, &b1 )->setIndex;
        diagD = sim1->center.x;
        Check( b2GetBodyFullId( &world, &b1 )->setIndex == b2_awakeSet );           // WOKEN by impact
        Check( sim1->center.x > 0.2 );      // and PUSHED right: wake-step impulse landed (not dropped)

        // both settle into a stack and fall asleep again
        for( k = 0; k < 260; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        diagB = b2GetBodyFullId( &world, &b1 )->setIndex;
        diagC = b2GetBodyFullId( &world, &b2b )->setIndex;
        Check( b2GetBodyFullId( &world, &b1 )->setIndex >= b2_firstSleepingSet );   // re-slept
        Check( b2GetBodyFullId( &world, &b2b )->setIndex >= b2_firstSleepingSet );

        b2DestroyWorld( &world );
    }

    // =========================================================================
    // P0.1 WAKE PLUMBING (2026-07-07): honor wakeBodies on contact/joint destroy,
    // wake on SetTransform, wake both endpoints in b2CreateJoint, public
    // b2Body_Wake / b2Body_IsAwake. (PLAN_FOR_OPUS.md Part 0, F2/F3/F4.)
    // =========================================================================

    // ---- P0.1a public wake API: b2Body_Wake / b2Body_IsAwake round-trip ----
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floor, &sf );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 1.0;
        b2BodyId bc;  b2CreateBody( &world, &bd, &bc );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sbx );

        Check( b2Body_IsAwake( &world, &bc ) );                       // starts awake
        int k;  for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        Check( !b2Body_IsAwake( &world, &bc ) );                      // settled -> asleep

        b2Body_Wake( &world, &bc );
        b2Body* body = b2GetBodyFullId( &world, &bc );
        diagA = body->setIndex;
        Check( b2Body_IsAwake( &world, &bc ) );                       // woken by public API
        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        Check( aset->bodySims.count == 1 );                           // sim migrated back
        Check( aset->bodySims.count == aset->bodyStates.count );      // state array in lockstep

        for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        Check( !b2Body_IsAwake( &world, &bc ) );                      // re-sleeps cleanly

        b2DestroyWorld( &world );
    }

    // ---- P0.1b (F2) destroying a support body WAKES the sleeper resting on it ----
    // A box sleeps on a static platform; destroying the platform must wake the box
    // (its touching contact is destroyed with wakeBodies=true) so it falls to the
    // floor -- previously it floated in mid-air forever.
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floor, &sf );

        fdef.position.x = 0.0;  fdef.position.y = 2.0;                // platform top at 2.25
        b2BodyId bp;  b2CreateBody( &world, &fdef, &bp );
        b2Polygon plat;  b2MakeBox( 1.5, 0.25, &plat );
        b2ShapeId sp;  b2CreatePolygonShape( &world, &bp, &sdef, &plat, &sp );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 2.75;                   // resting on the platform
        b2BodyId bc;  b2CreateBody( &world, &bd, &bc );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sbx );

        int k;  for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        Check( !b2Body_IsAwake( &world, &bc ) );                      // asleep on the platform

        b2DestroyBody( &world, &bp );                                 // pull the platform away
        Check( b2Body_IsAwake( &world, &bc ) );                       // WOKEN by the destroy

        for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &bc ) );
        diagB = sim->center.y;
        Check( sim->center.y > 0.85 && sim->center.y < 1.15 );        // fell + landed on the floor

        b2DestroyWorld( &world );
    }

    // ---- P0.1c (F3) b2Body_SetTransform wakes a sleeping body ----
    // Teleport a sleeper to a new spot above the floor: it must wake, fall, and
    // land there -- previously it hung frozen at the new location.
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floor, &sf );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 1.0;
        b2BodyId bc;  b2CreateBody( &world, &bd, &bc );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sbx );

        int k;  for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        Check( !b2Body_IsAwake( &world, &bc ) );                      // asleep at origin

        b2Vec2 newPos;  newPos.x = 3.0;  newPos.y = 3.0;
        b2Rot newRot;   newRot.c = 1.0;  newRot.s = 0.0;
        b2Body_SetTransform( &world, &bc, &newPos, &newRot );
        Check( b2Body_IsAwake( &world, &bc ) );                       // WOKEN by the teleport

        for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &bc ) );
        diagC = sim->center.x;
        diagD = sim->center.y;
        Check( sim->center.x > 2.7 && sim->center.x < 3.3 );          // stayed at the new x
        Check( sim->center.y > 0.85 && sim->center.y < 1.15 );        // fell + landed on the floor

        b2DestroyWorld( &world );
    }

    // ---- P0.1d (F4) creating a joint onto a sleeping body wakes it ----
    // A light box B is jointed (rigid distance, length 3) onto a sleeping box A.
    // A must wake at create; the joint must then hold B hanging above A.
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floor, &sf );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 1.0;
        b2BodyId ba;  b2CreateBody( &world, &bd, &ba );
        b2Polygon boxA;  b2MakeBox( 0.5, 0.5, &boxA );
        b2ShapeId sa;  b2CreatePolygonShape( &world, &ba, &sdef, &boxA, &sa );

        int k;  for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        Check( !b2Body_IsAwake( &world, &ba ) );                      // A asleep on the floor

        // small (light) hanger directly above A at joint length -> no initial jolt
        bd.position.x = 0.0;  bd.position.y = 4.0;
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2Polygon boxB;  b2MakeBox( 0.3, 0.3, &boxB );
        b2ShapeId sb;  b2CreatePolygonShape( &world, &bb, &sdef, &boxB, &sb );

        b2DistanceJointDef jd;  b2DefaultDistanceJointDef( &jd );
        jd.bodyIdA = ba;  jd.bodyIdB = bb;
        jd.length = 3.0;
        b2JointId jid;  b2CreateDistanceJointDef( &world, &jd, &jid );
        Check( b2Body_IsAwake( &world, &ba ) );                       // A WOKEN by joint create
        Check( b2Body_IsAwake( &world, &bb ) );

        for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        b2BodySim* simA = b2GetBodySim( &world, b2GetBodyFullId( &world, &ba ) );
        b2BodySim* simB = b2GetBodySim( &world, b2GetBodyFullId( &world, &bb ) );
        float dx = simB->center.x - simA->center.x;
        float dy = simB->center.y - simA->center.y;
        float dist = sqrt( dx*dx + dy*dy );
        diagA = dist;
        diagB = simA->center.y;
        Check( dist > 2.8 && dist < 3.2 );                            // joint holds length
        Check( simA->center.y > 0.85 && simA->center.y < 1.15 );      // A still seated on the floor

        b2DestroyWorld( &world );
    }

    // ---- P0.1e (F2 joint flavor) destroying a joint wakes its sleeping endpoints ----
    // A box hangs at rest from a static anchor by a rigid distance joint until its
    // island sleeps (joint migrates to the sleeping set with it). b2DestroyJoint
    // must wake it so it falls to the floor.
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floor, &sf );

        fdef.position.x = 0.0;  fdef.position.y = 6.0;                // shapeless static anchor
        b2BodyId banchor;  b2CreateBody( &world, &fdef, &banchor );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 3.0;                    // exactly at joint length
        b2BodyId bc;  b2CreateBody( &world, &bd, &bc );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sbx );

        b2DistanceJointDef jd;  b2DefaultDistanceJointDef( &jd );
        jd.bodyIdA = banchor;  jd.bodyIdB = bc;
        jd.length = 3.0;
        b2JointId jid;  b2CreateDistanceJointDef( &world, &jd, &jid );

        int k;  for( k = 0; k < 300; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        b2Body* body = b2GetBodyFullId( &world, &bc );
        diagC = body->setIndex;
        Check( !b2Body_IsAwake( &world, &bc ) );                      // hanging at rest -> asleep

        b2DestroyJoint( &world, &jid );                               // cut the rope
        Check( b2Body_IsAwake( &world, &bc ) );                       // WOKEN by joint destroy

        for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &bc ) );
        diagD = sim->center.y;
        Check( sim->center.y > 0.85 && sim->center.y < 1.15 );        // fell + landed on the floor

        b2DestroyWorld( &world );
    }

    // =========================================================================
    // P0.2 DISJOINT CONTACT DESTROY (2026-07-07): a contact whose fat AABBs stop
    // overlapping is destroyed in b2Collide (upstream b2_simDisjoint path), with
    // backward-iteration hardening. Before this, contacts accreted forever as a
    // body traveled. (PLAN_FOR_OPUS.md Part 0, F1.)
    // =========================================================================

    // ---- P0.2a travel soak: dragging a body across 10 tiles doesn't accrete contacts ----
    // A box is teleported tile-by-tile across a row of 10 static tiles (stepping in
    // between so it lands + pairs each time). With the accretion bug the contact id
    // pool ends holding ~one contact per tile ever visited (>= 8); with disjoint
    // destroy it returns to the touching-only count at the final tile (<= 3).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        // 10 static 1x1 tiles at x = 0..9, tops at y = 0.5
        b2Polygon tile;  b2MakeBox( 0.5, 0.5, &tile );
        int t;
        for( t = 0; t < 10; ++t )
        {
            b2BodyDef td;  b2DefaultBodyDef( &td );  td.type = b2_staticBody;
            td.position.x = t;  td.position.y = 0.0;
            b2BodyId bt;  b2CreateBody( &world, &td, &bt );
            b2ShapeId st;  b2CreatePolygonShape( &world, &bt, &sdef, &tile, &st );
        }

        // dynamic box (0.4 half-extent) settles on tile 0
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 1.2;
        b2BodyId bc;  b2CreateBody( &world, &bd, &bc );
        b2Polygon box;  b2MakeBox( 0.4, 0.4, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sbx );

        int k;  for( k = 0; k < 60; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        int c0 = b2GetIdCount( &world.contactIdPool );
        diagA = c0;
        Check( c0 >= 1 && c0 <= 3 );                     // resting: touching-only contact count

        // drag it across the row, letting it land + pair at each tile
        for( t = 1; t < 10; ++t )
        {
            b2Vec2 p;  p.x = t;  p.y = 0.95;
            b2Rot r;   r.c = 1.0;  r.s = 0.0;
            b2Body_SetTransform( &world, &bc, &p, &r );
            for( k = 0; k < 10; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        }
        for( k = 0; k < 30; k++ )  b2World_Step( &world, 1.0/60.0, 4 );

        int c1 = b2GetIdCount( &world.contactIdPool );
        diagB = c1;
        Check( c1 <= 3 );                                // stale tile contacts were destroyed
        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &bc ) );
        diagC = sim->center.x;
        diagD = sim->center.y;
        Check( sim->center.x > 8.7 && sim->center.x < 9.3 );   // resting on the last tile
        Check( sim->center.y > 0.75 && sim->center.y < 1.05 );

        // drag it back to tile 0 and re-check: create/destroy cycle is stable
        for( t = 8; t >= 0; --t )
        {
            b2Vec2 p;  p.x = t;  p.y = 0.95;
            b2Rot r;   r.c = 1.0;  r.s = 0.0;
            b2Body_SetTransform( &world, &bc, &p, &r );
            for( k = 0; k < 10; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        }
        for( k = 0; k < 30; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        int c2 = b2GetIdCount( &world.contactIdPool );
        Check( c2 <= 3 );                                // still bounded after the round trip

        b2DestroyWorld( &world );
    }

    // ---- P0.2b separation destroy + re-touch: bounce apart, come back, still solid ----
    // Two dynamic boxes rest side by side (touching). One is teleported far away
    // (contact destroyed), then teleported back above the other: they must re-pair,
    // collide, and stack -- proving destroy didn't corrupt edge lists / pairSet and
    // the pair re-creates cleanly.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floor, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 1.0;
        b2BodyId b1;  b2CreateBody( &world, &bd, &b1 );
        b2ShapeId s1;  b2CreatePolygonShape( &world, &b1, &sdef, &box, &s1 );
        bd.position.x = 1.0;  bd.position.y = 1.0;                 // side by side, touching
        b2BodyId b2b;  b2CreateBody( &world, &bd, &b2b );
        b2ShapeId s2;  b2CreatePolygonShape( &world, &b2b, &sdef, &box, &s2 );

        int k;  for( k = 0; k < 60; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        int cBefore = b2GetIdCount( &world.contactIdPool );        // floor x2 + side pair
        Check( cBefore >= 2 && cBefore <= 4 );

        // teleport box 2 far away -> its contacts (floor + side) must be destroyed
        b2Vec2 p;  p.x = 6.0;  p.y = 1.0;
        b2Rot r;   r.c = 1.0;  r.s = 0.0;
        b2Body_SetTransform( &world, &b2b, &p, &r );
        for( k = 0; k < 10; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        int cApart = b2GetIdCount( &world.contactIdPool );
        diagA = cApart;
        Check( cApart >= 1 && cApart <= 3 );                       // side pair gone, floors remain

        // teleport it back ON TOP of box 1 -> re-pair, collide, stack
        p.x = 0.0;  p.y = 2.5;
        b2Body_SetTransform( &world, &b2b, &p, &r );
        for( k = 0; k < 90; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        b2BodySim* sim1 = b2GetBodySim( &world, b2GetBodyFullId( &world, &b1 ) );
        b2BodySim* sim2 = b2GetBodySim( &world, b2GetBodyFullId( &world, &b2b ) );
        diagB = sim2->center.y;
        diagC = sim2->center.y - sim1->center.y;
        Check( sim2->center.y - sim1->center.y > 0.9 );            // stacked, not sunk through
        Check( sim2->center.y - sim1->center.y < 1.1 );

        b2DestroyWorld( &world );
    }

    // =========================================================================
    // P0.3 EMPTY SLEEPING-SET CLEANUP (2026-07-07): destroying the last body of
    // a sleeping set frees the set (id back to solverSetIdPool). Previously the
    // set id + arrays leaked. (PLAN_FOR_OPUS.md Part 0, F5.)
    // =========================================================================

    // ---- P0.3a contactless floating sleeper: destroy frees the sleeping set ----
    // Zero gravity, zero velocity: the box sleeps with NO contacts (so no wake
    // fires during teardown -- the exact leak path). Destroy must return the
    // solver-set id pool to the 3 standing sets.
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 5.0;
        b2BodyId bc;  b2CreateBody( &world, &bd, &bc );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeId sbx;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sbx );

        Check( b2GetIdCount( &world.solverSetIdPool ) == 3 );      // static/disabled/awake
        int k;  for( k = 0; k < 60; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        diagA = b2GetBodyFullId( &world, &bc )->setIndex;
        Check( !b2Body_IsAwake( &world, &bc ) );                   // slept (motionless, no contacts)
        Check( b2GetIdCount( &world.solverSetIdPool ) == 4 );      // + its sleeping set

        b2DestroyBody( &world, &bc );
        diagB = b2GetIdCount( &world.solverSetIdPool );
        Check( b2GetIdCount( &world.solverSetIdPool ) == 3 );      // sleeping set freed
        Check( b2GetIdCount( &world.islandIdPool ) == 0 );         // island freed too

        b2World_Step( &world, 1.0/60.0, 4 );                       // must not fault
        Check( true );

        b2DestroyWorld( &world );
    }

    // ---- P0.3b soak: (create -> sleep -> destroy) x10 leaks nothing ----
    // Alternates the contactless sleeper with a 2-box pile on a floor (whose
    // first destroy WAKES the set via P0.1 contact teardown -- both paths must
    // return every pool to baseline).
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floor, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        int n, k;
        for( n = 0; n < 10; n++ )
        {
            // 2-box pile settles + sleeps
            b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
            bd.position.x = 0.0;  bd.position.y = 1.0;
            b2BodyId b1;  b2CreateBody( &world, &bd, &b1 );
            b2ShapeId s1;  b2CreatePolygonShape( &world, &b1, &sdef, &box, &s1 );
            bd.position.x = 0.0;  bd.position.y = 2.0;
            b2BodyId b2b;  b2CreateBody( &world, &bd, &b2b );
            b2ShapeId s2;  b2CreatePolygonShape( &world, &b2b, &sdef, &box, &s2 );

            for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
            b2DestroyBody( &world, &b2b );     // wakes the set (touching contacts)
            b2DestroyBody( &world, &b1 );
            for( k = 0; k < 5; k++ )  b2World_Step( &world, 1.0/60.0, 4 );
        }

        diagC = b2GetIdCount( &world.solverSetIdPool );
        diagD = world.solverSets.count;
        Check( b2GetIdCount( &world.solverSetIdPool ) == 3 );      // all sleeping sets freed
        Check( world.solverSets.count <= 4 );                      // set slots reused, not accreted
        Check( b2GetIdCount( &world.bodyIdPool ) == 1 );           // only the floor
        Check( b2GetIdCount( &world.contactIdPool ) == 0 );
        Check( b2GetIdCount( &world.islandIdPool ) == 0 );

        b2DestroyWorld( &world );
    }

    // =====================================================================
    //   P0.4 -- b2ValidateWorld invariant walker
    // =====================================================================

    // ---- teeth: prove the validator DETECTS corruption (not just return 0) ----
    // Build a settled 2-box stack on a floor (guarantees bodies + touching
    // contacts), confirm clean, then poke ONE field wrong per invariant class,
    // assert the matching nonzero code fires, restore, assert clean again.
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = false;
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floor, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 1.0;
        b2BodyId b1;  b2CreateBody( &world, &bd, &b1 );
        b2ShapeId s1;  b2CreatePolygonShape( &world, &b1, &sdef, &box, &s1 );
        bd.position.x = 0.0;  bd.position.y = 2.0;
        b2BodyId b2b;  b2CreateBody( &world, &bd, &b2b );
        b2ShapeId s2;  b2CreatePolygonShape( &world, &b2b, &sdef, &box, &s2 );

        int k;
        for( k = 0; k < 150; k++ )  b2World_Step( &world, 1.0/60.0, 4 );

        // clean on a real, settled post-step world
        Check( b2ValidateWorld( &world ) == 0 );

        b2Body* body = b2GetBodyFullId( &world, &b1 );

        // (1) round-trip: bump the body's dense localIndex -> code 22
        int savedLocal = body->localIndex;
        body->localIndex = savedLocal + 1;
        diagA = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 22 );
        body->localIndex = savedLocal;                  // restore
        Check( b2ValidateWorld( &world ) == 0 );

        // (2) edge-list consistency: inflate a body's contactCount -> code 88
        int savedCC = body->contactCount;
        body->contactCount = savedCC + 1;
        diagB = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 88 );
        body->contactCount = savedCC;                   // restore
        Check( b2ValidateWorld( &world ) == 0 );

        // (3) count family: desync the broad-phase pair count -> code 70
        world.broadPhase.pairSet.count = world.broadPhase.pairSet.count + 1;
        Check( b2ValidateWorld( &world ) == 70 );
        world.broadPhase.pairSet.count = world.broadPhase.pairSet.count - 1;   // restore
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // ---- 1k-step mixed-scene SOAK: validate every step, one Check ------------
    // Exercises travel, sleep, wake, joint create/destroy, body destroy against
    // the invariant walker. Accumulate first failure (step + code) into diags so
    // a red is diagnosable without bisection or inflating checkNum by 1000.
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;               // stress sleep/wake set migration
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        // static floor
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2Polygon floor;  b2MakeBox( 20.0, 0.5, &floor );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floor, &sf );

        // a static anchor for transient joints
        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = -6.0;  adef.position.y = 6.0;
        b2BodyId ba;  b2CreateBody( &world, &adef, &ba );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );

        bool soakClean = true;
        int  badStep = 0;
        int  badCode = 0;
        int  step;
        int  spawnCount = 0;
        b2BodyId pendulum;  bool haveJoint = false;
        int jointId = -1;

        for( step = 0; step < 1000; step++ )
        {
            // spawn a traveling box every 40 steps (travels + settles + sleeps)
            if( ( step % 40 ) == 0 && spawnCount < 12 )
            {
                b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
                bd.position.x = -4.0 + spawnCount;
                bd.position.y = 8.0;
                bd.linearVelocity.x = 1.0;  bd.linearVelocity.y = 0.0;
                b2BodyId nb;  b2CreateBody( &world, &bd, &nb );
                b2ShapeId ns;  b2CreatePolygonShape( &world, &nb, &sdef, &box, &ns );
                spawnCount++;

                // keep the most-recent spawn as a joint endpoint we later destroy
                pendulum = nb;
            }

            // create a distance joint at step 100, destroy it at step 400
            if( step == 100 )
            {
                b2DistanceJointDef jd;  b2DefaultDistanceJointDef( &jd );
                jd.bodyIdA = ba;  jd.bodyIdB = pendulum;
                jd.length = 3.0;
                b2JointId jj;  b2CreateDistanceJointDef( &world, &jd, &jj );
                jointId = jj.index1 - 1;
                haveJoint = true;
            }
            if( step == 400 && haveJoint )
            {
                b2JointId jid;  jid.index1 = jointId + 1;  jid.world0 = world.worldId;
                b2Joint* jp = &world.joints.data[ jointId ];
                jid.generation = jp->generation;
                b2DestroyJoint( &world, &jid );
                haveJoint = false;
            }

            // destroy a settled body mid-soak (wakes / repairs indirection)
            if( step == 600 )
            {
                b2BodyId victim;  b2MakeBodyId( &world, 2, &victim );  // an early spawn
                b2Body* vb = &world.bodies.data[ 2 ];
                if( vb->id == 2 )  b2DestroyBody( &world, &victim );
            }

            b2World_Step( &world, 1.0/60.0, 4 );

            int c = b2ValidateWorld( &world );
            if( c != 0 && badStep == 0 )
            {
                soakClean = false;
                badStep = step;
                badCode = c;
            }
        }

        diagC = badStep;
        diagD = badCode;
        Check( soakClean );                       // invariants held every step
        Check( b2ValidateWorld( &world ) == 0 );  // and at the end

        b2DestroyWorld( &world );
    }

    // ---- CAPSULE as a BODY SHAPE: a capsule falls and rests on a floor ----
    // Capsule collision/mass were already wired, but a capsule attached to a body
    // via b2CreateCapsuleShape had never run end-to-end. A horizontal capsule
    // (radius 0.25) dropped onto a floor whose top is y=0.5 must rest with its
    // center at y = 0.5 + 0.25 = 0.75.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef gd;  b2DefaultBodyDef( &gd );  gd.type = b2_staticBody;
        gd.position.x = 0.0;  gd.position.y = 0.0;
        b2BodyId ground;  b2CreateBody( &world, &gd, &ground );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeId fs;  b2CreatePolygonShape( &world, &ground, &sdef, &floor, &fs );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 5.0;
        b2BodyId cap;  b2CreateBody( &world, &bd, &cap );
        b2Capsule capsule;
        capsule.center1.x = -0.5;  capsule.center1.y = 0.0;
        capsule.center2.x =  0.5;  capsule.center2.y = 0.0;
        capsule.radius = 0.25;
        b2ShapeId cs;  b2CreateCapsuleShape( &world, &cap, &sdef, &capsule, &cs );

        float dt = 1.0 / 60.0;  int k;  int worstVal = 0;
        for( k = 0; k < 120; k++ )
        {
            b2World_Step( &world, dt, 4 );
            int vc = b2ValidateWorld( &world );
            if( vc != 0 && worstVal == 0 )  worstVal = vc;
        }
        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &cap ) );
        diagA = worstVal;
        diagB = sim->center.y;
        Check( worstVal == 0 );
        Check( fabs( sim->center.y - 0.75 ) < 0.05 );   // rests on the floor top
        b2DestroyWorld( &world );
    }

    // ---- SEGMENT as a BODY SHAPE: a circle rests on a segment edge ----
    // b2CreateSegmentShape is brand new; segment COLLISION was wired but a segment
    // attached to a body had never run through the solver. A horizontal segment
    // (-5,0)->(5,0) on a static body; a circle (r=0.5) dropped from y=5 must rest
    // with its center at y=0.5 (segment is two-sided; body rests on top). If the
    // circle leaked through, it would fall to a large-but-finite y and the
    // benchmark's validate/finite checks alone would never notice.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2BodyDef gd;  b2DefaultBodyDef( &gd );  gd.type = b2_staticBody;
        gd.position.x = 0.0;  gd.position.y = 0.0;
        b2BodyId ground;  b2CreateBody( &world, &gd, &ground );
        b2Segment seg;  seg.point1.x = -5.0;  seg.point1.y = 0.0;
        seg.point2.x = 5.0;  seg.point2.y = 0.0;
        b2ShapeId ss;  b2CreateSegmentShape( &world, &ground, &sdef, &seg, &ss );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 5.0;
        b2BodyId ball;  b2CreateBody( &world, &bd, &ball );
        b2Circle cir;  cir.center.x = 0.0;  cir.center.y = 0.0;  cir.radius = 0.5;
        b2ShapeId cs;  b2CreateCircleShape( &world, &ball, &sdef, &cir, &cs );

        float dt = 1.0 / 60.0;  int k;  int worstVal = 0;
        for( k = 0; k < 120; k++ )
        {
            b2World_Step( &world, dt, 4 );
            int vc = b2ValidateWorld( &world );
            if( vc != 0 && worstVal == 0 )  worstVal = vc;
        }
        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &ball ) );
        Check( worstVal == 0 );
        Check( fabs( sim->center.y - 0.5 ) < 0.05 );   // rests on the segment, no leak-through
        b2DestroyWorld( &world );
    }

    // ---- FILTERS: category/mask + group index gate contact creation ----
    // Three overlapping dynamic box pairs, no gravity, one step each: (1) DEFAULT
    // filters -> a contact forms; (2) category/mask that exclude each other -> NO
    // contact; (3) same NEGATIVE groupIndex -> NO contact (group overrides mask).
    // The benchmark (Rain) cannot see this -- a broken filter just self-collides,
    // stays finite, and greens; only this count check proves filtering works.
    {
        // (1) default filters -> contact exists
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 0.0;
        b2BodyId a1;  b2CreateBody( &world, &bd, &a1 );
        b2ShapeId as1;  b2CreatePolygonShape( &world, &a1, &sd, &box, &as1 );
        bd.position.x = 0.1;
        b2BodyId b1;  b2CreateBody( &world, &bd, &b1 );
        b2ShapeId bs1;  b2CreatePolygonShape( &world, &b1, &sd, &box, &bs1 );
        b2World_Step( &world, 1.0/60.0, 4 );
        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        diagC = aset->contactSims.count;
        Check( aset->contactSims.count == 1 );   // default: they collide
        b2DestroyWorld( &world );
    }
    {
        // (2) mutually-excluding category/mask -> no contact
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;

        b2ShapeDef sdA;  b2DefaultShapeDef( &sdA );
        sdA.filter.categoryBits = 2;  sdA.filter.maskBits = 4;   // A is cat2, sees only cat4
        b2ShapeDef sdB;  b2DefaultShapeDef( &sdB );
        sdB.filter.categoryBits = 8;  sdB.filter.maskBits = 1;   // B is cat8, sees only cat1
        bd.position.x = 0.0;  bd.position.y = 0.0;
        b2BodyId a2;  b2CreateBody( &world, &bd, &a2 );
        b2ShapeId as2;  b2CreatePolygonShape( &world, &a2, &sdA, &box, &as2 );
        bd.position.x = 0.1;
        b2BodyId b2b;  b2CreateBody( &world, &bd, &b2b );
        b2ShapeId bs2;  b2CreatePolygonShape( &world, &b2b, &sdB, &box, &bs2 );
        b2World_Step( &world, 1.0/60.0, 4 );
        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        Check( aset->contactSims.count == 0 );   // filtered apart
        b2DestroyWorld( &world );
    }
    {
        // (3) same negative group index -> no contact (group overrides mask)
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );  sd.filter.groupIndex = -7;
        bd.position.x = 0.0;  bd.position.y = 0.0;
        b2BodyId a3;  b2CreateBody( &world, &bd, &a3 );
        b2ShapeId as3;  b2CreatePolygonShape( &world, &a3, &sd, &box, &as3 );
        bd.position.x = 0.1;
        b2BodyId b3;  b2CreateBody( &world, &bd, &b3 );
        b2ShapeId bs3;  b2CreatePolygonShape( &world, &b3, &sd, &box, &bs3 );
        b2World_Step( &world, 1.0/60.0, 4 );
        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        diagD = aset->contactSims.count;
        Check( aset->contactSims.count == 0 );   // same negative group never collides
        b2DestroyWorld( &world );
    }

    // ---- KINEMATIC: a moving kinematic body pushes a resting dynamic body ----
    // First real exercise of the kinematic body path end-to-end (create -> island ->
    // integrate -> broad-phase pairing -> contact solve). A kinematic box sweeps
    // right at a CONSTANT 4 m/s through a dynamic box at rest (no gravity). Two
    // independent invariants: (1) the kinematic body's own motion is EXACT and
    // UNPERTURBED by the contact -- invMass=0, so after 1 s it has moved exactly
    // 4 m (-2 -> +2), the contact impulse must not budge it; (2) the dynamic box was
    // actually PUSHED forward (validate/finite alone can't see this -- a kinematic
    // that generated no contacts would pass those but fail this).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );

        b2BodyDef kd;  b2DefaultBodyDef( &kd );  kd.type = b2_kinematicBody;
        kd.position.x = -2.0;  kd.position.y = 0.0;
        kd.linearVelocity.x = 4.0;  kd.linearVelocity.y = 0.0;
        b2BodyId kin;  b2CreateBody( &world, &kd, &kin );
        b2ShapeId ks;  b2CreatePolygonShape( &world, &kin, &sdef, &box, &ks );

        b2BodyDef dd;  b2DefaultBodyDef( &dd );  dd.type = b2_dynamicBody;
        dd.position.x = 0.0;  dd.position.y = 0.0;
        b2BodyId dyn;  b2CreateBody( &world, &dd, &dyn );
        b2ShapeId ds;  b2CreatePolygonShape( &world, &dyn, &sdef, &box, &ds );

        float dx0 = b2GetBodySim( &world, b2GetBodyFullId( &world, &dyn ) )->center.x;

        float dt = 1.0 / 60.0;  int k;  int worstVal = 0;
        for( k = 0; k < 60; k++ )
        {
            b2World_Step( &world, dt, 4 );
            int vc = b2ValidateWorld( &world );
            if( vc != 0 && worstVal == 0 )  worstVal = vc;
        }

        b2BodySim* ksim = b2GetBodySim( &world, b2GetBodyFullId( &world, &kin ) );
        b2BodySim* dsim = b2GetBodySim( &world, b2GetBodyFullId( &world, &dyn ) );
        diagA = worstVal;
        diagB = ksim->center.x;
        diagC = dsim->center.x;
        Check( worstVal == 0 );                                     // structurally clean every step
        Check( ksim->center.x > 1.99 && ksim->center.x < 2.01 );    // kinematic: exact constant-velocity sweep, unmoved by contact
        Check( b2IsValidVec2( &dsim->center ) );                    // finite
        Check( dsim->center.x > dx0 + 1.0 );                        // dynamic box was actually pushed forward

        b2DestroyWorld( &world );
    }

    // ---- KINEMATIC: b2Body_SetTargetTransform drives a body to a target ----
    // Set a kinematic body's velocity so one step of dt carries its center to
    // (3,0). After the step the center must land there and it must have stayed
    // upright (target rotation = identity -> zero angular velocity).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );

        b2BodyDef kd;  b2DefaultBodyDef( &kd );  kd.type = b2_kinematicBody;
        kd.position.x = 0.0;  kd.position.y = 0.0;
        b2BodyId kin;  b2CreateBody( &world, &kd, &kin );
        b2ShapeId ks;  b2CreatePolygonShape( &world, &kin, &sdef, &box, &ks );

        float dt = 1.0 / 60.0;
        b2Transform target;
        target.p.x = 3.0;  target.p.y = 0.0;  target.q = b2Rot_identity;
        b2Body_SetTargetTransform( &world, &kin, &target, dt );

        // velocity was set to delta / dt = 3 / (1/60) = 180 m/s +x
        b2BodyState* st = b2GetBodyState( &world, b2GetBodyFullId( &world, &kin ) );
        diagD = st->linearVelocity.x;
        Check( st->linearVelocity.x > 179.0 && st->linearVelocity.x < 181.0 );
        Check( fabs( st->angularVelocity ) < 0.001 );

        b2World_Step( &world, dt, 4 );

        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &kin ) );
        Check( fabs( sim->center.x - 3.0 ) < 0.05 );   // landed on target x
        Check( fabs( sim->center.y ) < 0.01 );         // no y drift
        Check( fabs( sim->transform.q.s ) < 0.01 );    // stayed upright
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // ==== P1.3 begin/end-touch event polling ====================================
    // A box dropped on the floor produces EXACTLY ONE begin-touch event over the
    // whole drop-and-settle (not one per bounce/flicker across the speculative
    // band), then ZERO events while resting, then EXACTLY ONE end-touch event when
    // lifted away -- tested at two lift distances (far = disjoint-destroy path,
    // near = touching->false transition path), both of which are the new code.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );      // top at 0.5
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );                // rests at y=1.0
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.position.x = 0.0;  cdef.position.y = 2.0;
        b2BodyId bb;  b2CreateBody( &world, &cdef, &bb );
        b2ShapeId sb;  b2CreatePolygonShape( &world, &bb, &sdef, &box, &sb );

        float dt = 1.0 / 60.0;  int k;

        // drop & settle: sum begin events across every step -> must be exactly one
        int beginTotal = 0;
        for( k = 0; k < 120; k++ )
        {
            b2World_Step( &world, dt, 4 );
            beginTotal = beginTotal + b2World_GetBeginTouchEventCount( &world );
        }
        diagA = beginTotal;
        Check( beginTotal == 1 );                                   // exactly one landing

        // resting: no further events on the next steps (no flicker)
        int restEvents = 0;
        for( k = 0; k < 30; k++ )
        {
            b2World_Step( &world, dt, 4 );
            restEvents = restEvents + b2World_GetBeginTouchEventCount( &world );
            restEvents = restEvents + b2World_GetEndTouchEventCount( &world );
        }
        Check( restEvents == 0 );                                   // silent while resting

        // NEAR lift: raise a little so shapes separate past speculative but fat
        // AABBs still overlap -> the touching->false transition path.
        b2Vec2 nearPos;  nearPos.x = 0.0;  nearPos.y = 1.35;
        b2Body_SetTransform( &world, &bb, &nearPos, &b2Rot_identity );
        int endNear = 0;
        for( k = 0; k < 5; k++ )
        {
            b2World_Step( &world, dt, 4 );
            endNear = endNear + b2World_GetEndTouchEventCount( &world );
        }
        diagB = endNear;
        Check( endNear == 1 );                                      // exactly one end (near)

        // re-land so there is a touching contact to break with the far lift
        b2Vec2 downPos;  downPos.x = 0.0;  downPos.y = 1.0;
        b2Body_SetTransform( &world, &bb, &downPos, &b2Rot_identity );
        for( k = 0; k < 40; k++ )  b2World_Step( &world, dt, 4 );

        // FAR lift: teleport far away so fat AABBs no longer overlap -> the
        // disjoint-destroy path must also emit exactly one end event.
        b2Vec2 farPos;  farPos.x = 0.0;  farPos.y = 20.0;
        b2Body_SetTransform( &world, &bb, &farPos, &b2Rot_identity );
        int endFar = 0;
        for( k = 0; k < 5; k++ )
        {
            b2World_Step( &world, dt, 4 );
            endFar = endFar + b2World_GetEndTouchEventCount( &world );
        }
        diagC = endFar;
        Check( endFar == 1 );                                       // exactly one end (far)

        // the event pair names the box+floor shapes (order-agnostic: primary order)
        // -- re-land, capture the begin pair, assert set-membership.
        b2Vec2 back;  back.x = 0.0;  back.y = 2.0;
        b2Body_SetTransform( &world, &bb, &back, &b2Rot_identity );
        int gotPair = 0;
        for( k = 0; k < 120 && gotPair == 0; k++ )
        {
            b2World_Step( &world, dt, 4 );
            if( b2World_GetBeginTouchEventCount( &world ) == 1 )
            {
                b2TouchEvent* ev = b2World_GetBeginTouchEvents( &world );
                int a = ev[0].shapeIdA;  int b = ev[0].shapeIdB;
                if( ( a == sf.index1 - 1 && b == sb.index1 - 1 ) ||
                    ( a == sb.index1 - 1 && b == sf.index1 - 1 ) )
                    gotPair = 1;
            }
        }
        Check( gotPair == 1 );                                      // pair == {floor, box}

        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // ==== P1.1 body runtime API (F7) ===========================================
    // Getters read the sim; user data round-trips; mass matches a 1x1 unit-density
    // box (=1.0).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 3.0;  bd.position.y = 5.0;
        b2BodyId bid;  b2CreateBody( &world, &bd, &bid );
        b2ShapeId sid;  b2CreatePolygonShape( &world, &bid, &sdef, &box, &sid );

        b2Vec2 p;  b2Body_GetPosition( &world, &bid, &p );
        Check( feq( p.x, 3.0 ) && feq( p.y, 5.0 ) );               // origin position
        b2Vec2 c;  b2Body_GetWorldCenter( &world, &bid, &c );
        Check( feq( c.x, 3.0 ) && feq( c.y, 5.0 ) );               // COM (centered box)
        b2Rot r;  b2Body_GetRotation( &world, &bid, &r );
        Check( feq( r.c, 1.0 ) && feq( r.s, 0.0 ) );               // identity rotation
        b2Transform xf;  b2Body_GetTransform( &world, &bid, &xf );
        Check( feq( xf.p.x, 3.0 ) && feq( xf.p.y, 5.0 ) );
        diagA = b2Body_GetMass( &world, &bid );
        Check( feq( diagA, 1.0 ) );                                // 1x1 * density 1

        int marker = 1234;
        void* mp = &marker;
        b2Body_SetUserData( &world, &bid, mp );
        Check( b2Body_GetUserData( &world, &bid ) == mp );          // round-trip

        b2DestroyWorld( &world );
    }

    // SetLinearVelocity is read back and carries the body; angular too.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 0.0;
        b2BodyId bid;  b2CreateBody( &world, &bd, &bid );
        b2ShapeId sid;  b2CreatePolygonShape( &world, &bid, &sdef, &box, &sid );

        b2Vec2 v;  v.x = 4.0;  v.y = 0.0;
        b2Body_SetLinearVelocity( &world, &bid, &v );
        b2Vec2 got;  b2Body_GetLinearVelocity( &world, &bid, &got );
        Check( feq( got.x, 4.0 ) && feq( got.y, 0.0 ) );           // read-back
        b2Body_SetAngularVelocity( &world, &bid, 2.0 );
        Check( feq( b2Body_GetAngularVelocity( &world, &bid ), 2.0 ) );

        float dt = 1.0 / 60.0;
        b2World_Step( &world, dt, 1 );
        b2Vec2 p;  b2Body_GetPosition( &world, &bid, &p );
        Check( p.x > 0.06 );                                        // moved +x (~4*dt)

        b2DestroyWorld( &world );
    }

    // ApplyForce integrates to dt*invMass*F in one step, and the accumulator is
    // CLEARED afterward (a second step without re-applying doesn't add more).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        b2BodyId bid;  b2CreateBody( &world, &bd, &bid );
        b2ShapeId sid;  b2CreatePolygonShape( &world, &bid, &sdef, &box, &sid );

        float dt = 1.0 / 60.0;
        b2Vec2 F;  F.x = 12.0;  F.y = 0.0;                          // invMass=1
        b2Body_ApplyForceToCenter( &world, &bid, &F, true );
        b2World_Step( &world, dt, 1 );
        b2Vec2 v1;  b2Body_GetLinearVelocity( &world, &bid, &v1 );
        diagB = v1.x;
        Check( feq( v1.x, dt * 12.0 ) );                            // dt*invMass*F = 0.2

        b2World_Step( &world, dt, 1 );                              // no re-apply
        b2Vec2 v2;  b2Body_GetLinearVelocity( &world, &bid, &v2 );
        Check( feq( v2.x, v1.x ) );                                 // force was cleared

        b2DestroyWorld( &world );
    }

    // Impulses poke velocity directly (immediate, no step). Read invMass/invI off
    // the sim so the expected values are exact regardless of box mass.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        b2BodyId bid;  b2CreateBody( &world, &bd, &bid );
        b2ShapeId sid;  b2CreatePolygonShape( &world, &bid, &sdef, &box, &sid );
        b2BodySim* sim = b2GetBodySim( &world, b2GetBodyFullId( &world, &bid ) );
        float invMass = sim->invMass;  float invI = sim->invInertia;

        b2Vec2 imp;  imp.x = 2.0;  imp.y = 0.0;
        b2Body_ApplyLinearImpulseToCenter( &world, &bid, &imp, true );
        b2Vec2 v;  b2Body_GetLinearVelocity( &world, &bid, &v );
        Check( feq( v.x, invMass * 2.0 ) && feq( v.y, 0.0 ) );      // v = invMass*imp

        b2Body_ApplyAngularImpulse( &world, &bid, 0.5, true );
        diagC = b2Body_GetAngularVelocity( &world, &bid );
        Check( feq( diagC, invI * 0.5 ) );                          // w = invI*imp

        b2DestroyWorld( &world );
    }

    // THE F7 acceptance path: an impulse WAKES a sleeping body. Requires sleep ON
    // and the body actually asleep first (assert it) -- else b2WakeBody is a no-op
    // and this would pass without touching the wake logic.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        world.enableSleep = true;                                   // opt in (default OFF)
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 1.0;                  // already at rest height
        b2BodyId bid;  b2CreateBody( &world, &bd, &bid );
        b2ShapeId sid;  b2CreatePolygonShape( &world, &bid, &sdef, &box, &sid );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 150; k++ )  b2World_Step( &world, dt, 4 );  // settle -> sleep
        Check( b2Body_IsAwake( &world, &bid ) == false );          // load-bearing: asleep

        b2Vec2 imp;  imp.x = 0.0;  imp.y = 5.0;
        b2Body_ApplyLinearImpulseToCenter( &world, &bid, &imp, true );
        Check( b2Body_IsAwake( &world, &bid ) == true );           // impulse woke it
        b2Vec2 v;  b2Body_GetLinearVelocity( &world, &bid, &v );
        diagD = v.y;
        Check( v.y > 4.0 && v.y < 6.0 );                           // ~invMass*5 = 5

        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // HIT EVENTS (P1.3 tail): a fast box striking a floor emits a b2ContactHitEvent
    // when the shape opted in; NONE when it did not (load-bearing negative), and
    // NONE while resting slowly (threshold gate).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );      // top at 0.5
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeDef fsd;  b2DefaultShapeDef( &fsd );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &fsd, &floorBox, &sf );

        // dynamic box dropped from a height -> impact speed ~10 m/s >> threshold 1
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 6.0;
        b2BodyId bid;  b2CreateBody( &world, &bd, &bid );
        b2ShapeDef hsd;  b2DefaultShapeDef( &hsd );
        hsd.enableHitEvents = true;                                 // opt IN
        b2ShapeId sid;  b2CreatePolygonShape( &world, &bid, &hsd, &box, &sid );

        float dt = 1.0 / 60.0;  int k;
        int   hitCount = 0;
        float maxSpeed = 0.0;
        float hitNormalY = 0.0;
        int   pairOk = 0;
        for( k = 0; k < 120; k++ )
        {
            b2World_Step( &world, dt, 4 );
            int n = b2World_GetContactHitEventCount( &world );
            if( n > 0 )
            {
                b2ContactHitEvent* ev = b2World_GetContactHitEvents( &world );
                hitCount = hitCount + n;
                if( ev[0].approachSpeed > maxSpeed )  maxSpeed = ev[0].approachSpeed;
                hitNormalY = ev[0].normal.y;
                int a = ev[0].shapeIdA;  int b = ev[0].shapeIdB;
                if( ( a == sf.index1 - 1 && b == sid.index1 - 1 ) ||
                    ( a == sid.index1 - 1 && b == sf.index1 - 1 ) )
                    pairOk = 1;
            }
        }
        diagA = hitCount;
        diagB = maxSpeed;
        diagC = hitNormalY;
        Check( hitCount >= 1 );                                     // an impact fired at least one
        Check( maxSpeed > 2.0 );                                    // real closing speed, past threshold
        Check( fabs( hitNormalY ) > 0.9 );                         // near-vertical hit normal
        Check( pairOk == 1 );                                      // event names {floor, box}

        // now RESTING: no more hit events on the settled box (slow contact < threshold)
        int restHits = 0;
        for( k = 0; k < 30; k++ )
        {
            b2World_Step( &world, dt, 4 );
            restHits = restHits + b2World_GetContactHitEventCount( &world );
        }
        Check( restHits == 0 );                                     // silent while resting

        Check( b2ValidateWorld( &world ) == 0 );
        b2DestroyWorld( &world );
    }

    // LOAD-BEARING NEGATIVE: identical fast impact, but the shape did NOT opt in
    // (default enableHitEvents == false) -> ZERO hit events. Without this an
    // always-on flag would pass the positive test above.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );               // enableHitEvents = false

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 6.0;
        b2BodyId bid;  b2CreateBody( &world, &bd, &bid );
        b2ShapeId sid;  b2CreatePolygonShape( &world, &bid, &sdef, &box, &sid );

        float dt = 1.0 / 60.0;  int k;
        int hits = 0;
        for( k = 0; k < 120; k++ )
        {
            b2World_Step( &world, dt, 4 );
            hits = hits + b2World_GetContactHitEventCount( &world );
        }
        diagD = hits;
        Check( hits == 0 );                                        // no opt-in -> no events

        Check( b2ValidateWorld( &world ) == 0 );
        b2DestroyWorld( &world );
    }

    // SENSORS (P1.5): a sensor detects overlap (begin/end) with NO collision push.
    // Motion is driven by SetTransform (gravity 0) so overlap is exactly controlled.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;

        b2Polygon sbox;  b2MakeBox( 1.0, 1.0, &sbox );             // sensor covers [-1,1]
        b2BodyDef sdefb;  b2DefaultBodyDef( &sdefb );  sdefb.type = b2_staticBody;
        b2BodyId bs;  b2CreateBody( &world, &sdefb, &bs );
        b2ShapeDef ssd;  b2DefaultShapeDef( &ssd );  ssd.isSensor = true;
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bs, &ssd, &sbox, &sf );

        b2Polygon vbox;  b2MakeBox( 0.5, 0.5, &vbox );
        b2BodyDef vdef;  b2DefaultBodyDef( &vdef );  vdef.type = b2_dynamicBody;
        vdef.position.x = 10.0;  vdef.position.y = 0.0;            // starts far away
        b2BodyId bv;  b2CreateBody( &world, &vdef, &bv );
        b2ShapeDef vsd;  b2DefaultShapeDef( &vsd );                // enableSensorEvents default true
        b2ShapeId sv;  b2CreatePolygonShape( &world, &bv, &vsd, &vbox, &sv );

        float dt = 1.0 / 60.0;  int k;

        // far apart -> no events
        b2World_Step( &world, dt, 4 );
        Check( b2World_GetSensorBeginEventCount( &world ) == 0 );
        Check( b2World_GetSensorEndEventCount( &world ) == 0 );

        // move visitor INTO the sensor -> exactly one begin, correct (directed) pair
        b2Vec2 inPos;  inPos.x = 0.0;  inPos.y = 0.0;
        b2Body_SetTransform( &world, &bv, &inPos, &b2Rot_identity );
        b2World_Step( &world, dt, 4 );
        diagA = b2World_GetSensorBeginEventCount( &world );
        Check( diagA == 1 );                                       // entry
        Check( b2World_GetSensorEndEventCount( &world ) == 0 );
        b2SensorTouchEvent* be = b2World_GetSensorBeginEvents( &world );
        Check( be[0].sensorShapeId == sf.index1 - 1 && be[0].visitorShapeId == sv.index1 - 1 );

        // stay overlapping -> LOAD-BEARING: no re-fire (proves the cross-step diff,
        // not "any overlap re-fires each step")
        int repeat = 0;
        for( k = 0; k < 10; k++ )
        {
            b2World_Step( &world, dt, 4 );
            repeat = repeat + b2World_GetSensorBeginEventCount( &world );
            repeat = repeat + b2World_GetSensorEndEventCount( &world );
        }
        Check( repeat == 0 );                                      // silent while persistently overlapping

        // move visitor OUT -> exactly one end
        b2Vec2 outPos;  outPos.x = 10.0;  outPos.y = 0.0;
        b2Body_SetTransform( &world, &bv, &outPos, &b2Rot_identity );
        b2World_Step( &world, dt, 4 );
        diagB = b2World_GetSensorEndEventCount( &world );
        Check( diagB == 1 );                                       // exit
        Check( b2World_GetSensorBeginEventCount( &world ) == 0 );
        b2SensorTouchEvent* ee = b2World_GetSensorEndEvents( &world );
        Check( ee[0].sensorShapeId == sf.index1 - 1 && ee[0].visitorShapeId == sv.index1 - 1 );

        Check( b2ValidateWorld( &world ) == 0 );
        b2DestroyWorld( &world );
    }

    // LOAD-BEARING NEGATIVE: two OVERLAPPING non-sensor shapes -> zero sensor events
    // (proves isSensor gates the pass, not mere overlap).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );                  // neither is a sensor

        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );
        b2BodyDef ad;  b2DefaultBodyDef( &ad );  ad.type = b2_staticBody;
        b2BodyId ba;  b2CreateBody( &world, &ad, &ba );
        b2ShapeId sa;  b2CreatePolygonShape( &world, &ba, &sd, &box, &sa );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.5;  bd.position.y = 0.0;                 // overlaps A
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeId sb2;  b2CreatePolygonShape( &world, &bb, &sd, &box, &sb2 );

        float dt = 1.0 / 60.0;  int k;
        int sensorEv = 0;
        for( k = 0; k < 20; k++ )
        {
            b2World_Step( &world, dt, 4 );
            sensorEv = sensorEv + b2World_GetSensorBeginEventCount( &world );
            sensorEv = sensorEv + b2World_GetSensorEndEventCount( &world );
        }
        diagC = sensorEv;
        Check( sensorEv == 0 );                                    // no sensor -> no sensor events

        Check( b2ValidateWorld( &world ) == 0 );
        b2DestroyWorld( &world );
    }

    // SOAK: create/destroy an overlapping sensor+visitor x20; the shape-destroy path
    // frees the overlap array + reuses shape slots -> must not fault or leak.
    // (b2ValidateWorld does not know about sensor arrays; reaching green proves the
    // free/reuse path is crash-free.)
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        int r;
        for( r = 0; r < 20; r++ )
        {
            b2Polygon sbox;  b2MakeBox( 1.0, 1.0, &sbox );
            b2BodyDef sdb;  b2DefaultBodyDef( &sdb );  sdb.type = b2_staticBody;
            b2BodyId bs;  b2CreateBody( &world, &sdb, &bs );
            b2ShapeDef ssd;  b2DefaultShapeDef( &ssd );  ssd.isSensor = true;
            b2ShapeId sf;  b2CreatePolygonShape( &world, &bs, &ssd, &sbox, &sf );

            b2Polygon vbox;  b2MakeBox( 0.5, 0.5, &vbox );
            b2BodyDef vdb;  b2DefaultBodyDef( &vdb );  vdb.type = b2_dynamicBody;
            vdb.position.x = 0.0;  vdb.position.y = 0.0;           // overlapping the sensor
            b2BodyId bv;  b2CreateBody( &world, &vdb, &bv );
            b2ShapeDef vsd;  b2DefaultShapeDef( &vsd );
            b2ShapeId sv;  b2CreatePolygonShape( &world, &bv, &vsd, &vbox, &sv );

            b2World_Step( &world, 1.0 / 60.0, 4 );                 // one begin recorded on the sensor
            b2DestroyBody( &world, &bv );
            b2DestroyBody( &world, &bs );                          // frees the sensor's overlap array
        }
        Check( b2ValidateWorld( &world ) == 0 );
        b2DestroyWorld( &world );
    }

    // b2SplitIsland (F6 / P2.1): a merged island splits into its true components
    // once the connecting contact is removed, so a settled sub-pile sleeps on its
    // own. P and Q are stacked (deterministic merge to ONE island); lifting Q away
    // breaks contact(P,Q) -> removeCount>0 -> split into TWO islands.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        world.enableSleep = true;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );      // top at 0.5
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef pd;  b2DefaultBodyDef( &pd );  pd.type = b2_dynamicBody;
        pd.position.x = 0.0;  pd.position.y = 1.0;                  // P rests on floor
        b2BodyId bp;  b2CreateBody( &world, &pd, &bp );
        b2ShapeId sp;  b2CreatePolygonShape( &world, &bp, &sdef, &box, &sp );

        b2BodyDef qd;  b2DefaultBodyDef( &qd );  qd.type = b2_dynamicBody;
        qd.position.x = 0.0;  qd.position.y = 2.0;                  // Q stacked on P
        b2BodyId bq;  b2CreateBody( &world, &qd, &bq );
        b2ShapeId sq;  b2CreatePolygonShape( &world, &bq, &sdef, &box, &sq );

        float dt = 1.0 / 60.0;  int k;

        // settle -> P+Q touch -> MERGE into one island -> sleep
        for( k = 0; k < 200; k++ )  b2World_Step( &world, dt, 4 );
        Check( b2Body_IsAwake( &world, &bp ) == false );           // both asleep
        Check( b2Body_IsAwake( &world, &bq ) == false );
        diagA = b2GetIdCount( &world.islandIdPool );
        Check( diagA == 1 );                                       // merged: ONE island

        // lift Q far away -> contact(P,Q) disjoint-destroys -> removeCount>0 -> SPLIT
        b2Vec2 qpos;  qpos.x = 3.0;  qpos.y = 1.0;                 // re-lands elsewhere on floor
        b2Body_SetTransform( &world, &bq, &qpos, &b2Rot_identity );
        for( k = 0; k < 200; k++ )  b2World_Step( &world, dt, 4 );
        diagB = b2GetIdCount( &world.islandIdPool );
        Check( diagB == 2 );                                       // split: TWO islands
        Check( b2Body_IsAwake( &world, &bp ) == false );           // both re-settled asleep
        Check( b2Body_IsAwake( &world, &bq ) == false );
        Check( b2ValidateWorld( &world ) == 0 );

        // LOAD-BEARING: split put P and Q in SEPARATE sleeping sets. Wake P; Q must
        // STAY asleep. Had the split silently failed (still one island -> one
        // sleeping set), waking P would drag Q awake too.
        b2Vec2 imp;  imp.x = 0.0;  imp.y = 5.0;
        b2Body_ApplyLinearImpulseToCenter( &world, &bp, &imp, true );
        Check( b2Body_IsAwake( &world, &bp ) == true );            // P woke
        Check( b2Body_IsAwake( &world, &bq ) == false );           // Q unaffected -> distinct islands
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // CHAIN SHAPES (slice 1): one-sided chain-segment terrain vs circles.
    // Ground point1=(5,0)->point2=(-5,0) so RightPerp(edge) points UP -> the
    // collidable side faces up; ghosts collinear (flat extension).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ChainSegment cs;
        cs.ghost1.x = 15.0;   cs.ghost1.y = 0.0;
        cs.segment.point1.x = 5.0;    cs.segment.point1.y = 0.0;
        cs.segment.point2.x = -5.0;   cs.segment.point2.y = 0.0;
        cs.ghost2.x = -15.0;  cs.ghost2.y = 0.0;
        cs.chainId = -1;
        b2ShapeId gseg;  b2CreateChainSegmentShape( &world, &bg, &gsd, &cs, &gseg );

        b2Circle ball;  ball.center.x = 0.0;  ball.center.y = 0.0;  ball.radius = 0.5;
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 3.0;
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreateCircleShape( &world, &bb, &bsd, &ball, &bs );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 200; k++ )  b2World_Step( &world, dt, 4 );
        b2Vec2 pAbove;  b2Body_GetPosition( &world, &bb, &pAbove );
        diagA = pAbove.y;
        Check( pAbove.y > 0.35 && pAbove.y < 0.65 );            // dropped from above -> rests (r=0.5)
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // ONE-SIDED (load-bearing): a ball rising from BELOW passes THROUGH the same
    // ground -- the defining chain-segment property (a two-sided segment would
    // bounce it back down).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ChainSegment cs;
        cs.ghost1.x = 15.0;   cs.ghost1.y = 0.0;
        cs.segment.point1.x = 5.0;    cs.segment.point1.y = 0.0;
        cs.segment.point2.x = -5.0;   cs.segment.point2.y = 0.0;
        cs.ghost2.x = -15.0;  cs.ghost2.y = 0.0;
        cs.chainId = -1;
        b2ShapeId gseg;  b2CreateChainSegmentShape( &world, &bg, &gsd, &cs, &gseg );

        b2Circle ball;  ball.center.x = 0.0;  ball.center.y = 0.0;  ball.radius = 0.5;
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = -3.0;
        bd.linearVelocity.x = 0.0;  bd.linearVelocity.y = 15.0;   // rising toward the ground
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreateCircleShape( &world, &bb, &bsd, &ball, &bs );

        float dt = 1.0 / 60.0;  int k;
        float maxY = -3.0;
        for( k = 0; k < 120; k++ )
        {
            b2World_Step( &world, dt, 4 );
            b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
            if( p.y > maxY )  maxY = p.y;
        }
        diagB = maxY;
        Check( maxY > 2.0 );                                   // passed through (a 2-sided seg would block it)
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // b2CreateChain: an OPEN 4-point chain builds 1 collidable segment (n-3); a
    // ball dropped on it rests -> the create API + ghost wiring make working terrain.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2Vec2[4] pts;
        pts[0].x = 15.0;   pts[0].y = 0.0;                     // ghost end
        pts[1].x = 5.0;    pts[1].y = 0.0;                     // -> segment point1
        pts[2].x = -5.0;   pts[2].y = 0.0;                     // -> segment point2
        pts[3].x = -15.0;  pts[3].y = 0.0;                     // ghost end

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ChainDef cd;  b2DefaultChainDef( &cd );
        cd.points = pts;  cd.count = 4;  cd.isLoop = false;
        b2CreateChain( &world, &bg, &cd );

        b2Circle ball;  ball.center.x = 0.0;  ball.center.y = 0.0;  ball.radius = 0.5;
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 3.0;
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreateCircleShape( &world, &bb, &bsd, &ball, &bs );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 200; k++ )  b2World_Step( &world, dt, 4 );
        b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
        diagC = p.y;
        Check( p.y > 0.35 && p.y < 0.65 );                     // rests on the chain-built segment
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // b2CreateChain LOOP branch (modular ghost wiring): a CCW square loop makes a
    // container with INWARD-facing normals; a ball dropped inside rests on the
    // bottom edge (y = -5 + 0.5). Exercises the wraparound prev/nx1/nx2 indexing.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2Vec2[4] loop;
        loop[0].x = 5.0;   loop[0].y = -5.0;                   // CCW: bottom edge right->left
        loop[1].x = -5.0;  loop[1].y = -5.0;
        loop[2].x = -5.0;  loop[2].y = 5.0;
        loop[3].x = 5.0;   loop[3].y = 5.0;

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ChainDef cd;  b2DefaultChainDef( &cd );
        cd.points = loop;  cd.count = 4;  cd.isLoop = true;
        b2CreateChain( &world, &bg, &cd );

        b2Circle ball;  ball.center.x = 0.0;  ball.center.y = 0.0;  ball.radius = 0.5;
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 0.0;             // inside the container
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreateCircleShape( &world, &bb, &bsd, &ball, &bs );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 200; k++ )  b2World_Step( &world, dt, 4 );
        b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
        diagD = p.y;
        Check( p.y > -4.7 && p.y < -4.3 );                     // rests on the loop's bottom edge
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // TIME OF IMPACT (continuous slice 1): a swept box vs a static wall box.
    // HIT with an analytic fraction (face-type separation -- the branch the solver
    // bullet path will hit). Bullet half-extent 0.5 sweeps center x:-5..+5; wall
    // half 0.5 at origin. Contact when cB+0.5 = -0.5, i.e. cB=-1 -> f=0.4, minus a
    // slop-sized gap (target = -linearSlop) so f lands a hair under 0.4.
    {
        b2Vec2[4] corners;
        corners[0].x = -0.5;  corners[0].y = -0.5;
        corners[1].x =  0.5;  corners[1].y = -0.5;
        corners[2].x =  0.5;  corners[2].y =  0.5;
        corners[3].x = -0.5;  corners[3].y =  0.5;

        b2TOIInput in;
        b2MakeProxy( corners, 4, 0.0, &in.proxyA );
        b2MakeProxy( corners, 4, 0.0, &in.proxyB );
        in.sweepA.localCenter = b2Vec2_zero;
        in.sweepA.c1.x = 0.0;  in.sweepA.c1.y = 0.0;
        in.sweepA.c2.x = 0.0;  in.sweepA.c2.y = 0.0;
        in.sweepA.q1 = b2Rot_identity;  in.sweepA.q2 = b2Rot_identity;
        in.sweepB.localCenter = b2Vec2_zero;
        in.sweepB.c1.x = -5.0;  in.sweepB.c1.y = 0.0;
        in.sweepB.c2.x =  5.0;  in.sweepB.c2.y = 0.0;
        in.sweepB.q1 = b2Rot_identity;  in.sweepB.q2 = b2Rot_identity;
        in.maxFraction = 1.0;

        b2TOIOutput out;
        b2TimeOfImpact( &in, &out );
        diagA = out.fraction;
        Check( out.state == b2_toiStateHit );
        Check( out.fraction > 0.38 && out.fraction < 0.40 );   // ~0.3995 (0.4 minus slop)
    }

    // OVERLAPPED: bullet starts coincident with the wall -> state overlapped, f=0.
    {
        b2Vec2[4] corners;
        corners[0].x = -0.5;  corners[0].y = -0.5;
        corners[1].x =  0.5;  corners[1].y = -0.5;
        corners[2].x =  0.5;  corners[2].y =  0.5;
        corners[3].x = -0.5;  corners[3].y =  0.5;

        b2TOIInput in;
        b2MakeProxy( corners, 4, 0.0, &in.proxyA );
        b2MakeProxy( corners, 4, 0.0, &in.proxyB );
        in.sweepA.localCenter = b2Vec2_zero;
        in.sweepA.c1 = b2Vec2_zero;  in.sweepA.c2 = b2Vec2_zero;
        in.sweepA.q1 = b2Rot_identity;  in.sweepA.q2 = b2Rot_identity;
        in.sweepB.localCenter = b2Vec2_zero;
        in.sweepB.c1.x = 0.0;  in.sweepB.c1.y = 0.0;           // starts ON the wall
        in.sweepB.c2.x = 5.0;  in.sweepB.c2.y = 0.0;
        in.sweepB.q1 = b2Rot_identity;  in.sweepB.q2 = b2Rot_identity;
        in.maxFraction = 1.0;

        b2TOIOutput out;
        b2TimeOfImpact( &in, &out );
        diagB = out.fraction;
        Check( out.state == b2_toiStateOverlapped );
        Check( out.fraction == 0.0 );
    }

    // MISS (separated): maxFraction too small to reach the wall -> f == maxFraction.
    {
        b2Vec2[4] corners;
        corners[0].x = -0.5;  corners[0].y = -0.5;
        corners[1].x =  0.5;  corners[1].y = -0.5;
        corners[2].x =  0.5;  corners[2].y =  0.5;
        corners[3].x = -0.5;  corners[3].y =  0.5;

        b2TOIInput in;
        b2MakeProxy( corners, 4, 0.0, &in.proxyA );
        b2MakeProxy( corners, 4, 0.0, &in.proxyB );
        in.sweepA.localCenter = b2Vec2_zero;
        in.sweepA.c1 = b2Vec2_zero;  in.sweepA.c2 = b2Vec2_zero;
        in.sweepA.q1 = b2Rot_identity;  in.sweepA.q2 = b2Rot_identity;
        in.sweepB.localCenter = b2Vec2_zero;
        in.sweepB.c1.x = -5.0;  in.sweepB.c1.y = 0.0;
        in.sweepB.c2.x =  5.0;  in.sweepB.c2.y = 0.0;          // would hit at f=0.4...
        in.sweepB.q1 = b2Rot_identity;  in.sweepB.q2 = b2Rot_identity;
        in.maxFraction = 0.2;                                  // ...but stop at f=0.2 (x=-3)

        b2TOIOutput out;
        b2TimeOfImpact( &in, &out );
        diagC = out.fraction;
        Check( out.state == b2_toiStateSeparated );
        Check( out.fraction > 0.19 && out.fraction < 0.21 );   // == maxFraction
    }

    // ROTATIONAL sweep (exercises b2GetSweepTransform q1->q2 interpolation): the
    // bullet translates toward the wall while rotating 90 deg -> still a hit in (0,1).
    {
        b2Vec2[4] corners;
        corners[0].x = -0.5;  corners[0].y = -0.5;
        corners[1].x =  0.5;  corners[1].y = -0.5;
        corners[2].x =  0.5;  corners[2].y =  0.5;
        corners[3].x = -0.5;  corners[3].y =  0.5;

        b2TOIInput in;
        b2MakeProxy( corners, 4, 0.0, &in.proxyA );
        b2MakeProxy( corners, 4, 0.0, &in.proxyB );
        in.sweepA.localCenter = b2Vec2_zero;
        in.sweepA.c1 = b2Vec2_zero;  in.sweepA.c2 = b2Vec2_zero;
        in.sweepA.q1 = b2Rot_identity;  in.sweepA.q2 = b2Rot_identity;
        in.sweepB.localCenter = b2Vec2_zero;
        in.sweepB.c1.x = -5.0;  in.sweepB.c1.y = 0.0;
        in.sweepB.c2.x =  5.0;  in.sweepB.c2.y = 0.0;
        in.sweepB.q1 = b2Rot_identity;
        in.sweepB.q2.c = 0.0;  in.sweepB.q2.s = 1.0;           // 90 deg (normalized)
        in.maxFraction = 1.0;

        b2TOIOutput out;
        b2TimeOfImpact( &in, &out );
        diagD = out.fraction;
        Check( out.state == b2_toiStateHit );
        Check( out.fraction > 0.0 && out.fraction < 1.0 );
    }

    // CONTINUOUS / TOI (slice 2): a fast body tunnels through a thin wall WITHOUT
    // continuous, and is STOPPED by it WITH continuous -- the defining CCD behavior.
    // Bullet 0.25 half-box at 600 m/s -> 10 units in one 1/60 step, straight through
    // a 0.1-half thin wall at x=0.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;            // enableContinuous OFF (default)

        b2Polygon wallBox;  b2MakeBox( 0.1, 2.0, &wallBox );
        b2BodyDef wdef;  b2DefaultBodyDef( &wdef );  wdef.type = b2_staticBody;
        b2BodyId bw;  b2CreateBody( &world, &wdef, &bw );
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bw, &wsd, &wallBox, &ws );

        b2Polygon bulletBox;  b2MakeBox( 0.25, 0.25, &bulletBox );
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = -5.0;  bdef.position.y = 0.0;
        bdef.linearVelocity.x = 600.0;  bdef.linearVelocity.y = 0.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &bulletBox, &bs );

        b2World_Step( &world, 1.0 / 60.0, 4 );
        b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
        diagA = p.x;
        // 600 m/s is clamped to maxLinearSpeed 400 -> ~6.67 units/step -> x~1.67,
        // still fully past the wall (right face 0.1 + bullet half 0.25 = 0.35).
        Check( p.x > 1.0 );                                       // TUNNELED past the wall

        b2DestroyWorld( &world );
    }
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        world.enableContinuous = true;                            // opt IN

        b2Polygon wallBox;  b2MakeBox( 0.1, 2.0, &wallBox );
        b2BodyDef wdef;  b2DefaultBodyDef( &wdef );  wdef.type = b2_staticBody;
        b2BodyId bw;  b2CreateBody( &world, &wdef, &bw );
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bw, &wsd, &wallBox, &ws );

        b2Polygon bulletBox;  b2MakeBox( 0.25, 0.25, &bulletBox );
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = -5.0;  bdef.position.y = 0.0;
        bdef.linearVelocity.x = 600.0;  bdef.linearVelocity.y = 0.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &bulletBox, &bs );

        float dt = 1.0 / 60.0;  int k;
        float maxX = -5.0;
        for( k = 0; k < 5; k++ )
        {
            b2World_Step( &world, dt, 4 );
            b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
            if( p.x > maxX )  maxX = p.x;
        }
        // The CCD guarantee is NO TUNNEL: the bullet is clamped to the wall's near
        // face (~-0.35) on impact and never crosses. (Its exact resting x is a
        // solver artifact of the ~400 m/s impact -- it gets knocked back to ~-1.1;
        // continuous only owns "did not pass through", which is maxX.)
        diagB = maxX;
        Check( maxX < 0.5 );                                      // never got through (tunnel would be x>1)
        b2Vec2 pf;  b2Body_GetPosition( &world, &bb, &pf );
        diagC = pf.x;
        Check( pf.x < 0.5 );                                      // stayed on the near side of the wall
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // =========================================================================
    // CHAIN SHAPES (slice 2): chain segments vs POLYGONS and CAPSULES.
    // Same ground winding as the slice-1 circle tests: point1=(5,0)->point2=(-5,0)
    // so RightPerp(edge) faces UP and the collidable side is the top.
    // =========================================================================

    // A BOX dropped from above rests on a chain segment (b2CollideChainSegmentAndPolygon).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ChainSegment cs;
        cs.ghost1.x = 15.0;   cs.ghost1.y = 0.0;
        cs.segment.point1.x = 5.0;    cs.segment.point1.y = 0.0;
        cs.segment.point2.x = -5.0;   cs.segment.point2.y = 0.0;
        cs.ghost2.x = -15.0;  cs.ghost2.y = 0.0;
        cs.chainId = -1;
        b2ShapeId gseg;  b2CreateChainSegmentShape( &world, &bg, &gsd, &cs, &gseg );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 3.0;
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 200; k++ )  b2World_Step( &world, dt, 4 );
        b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
        diagA = p.y;
        Check( p.y > 0.35 && p.y < 0.65 );                     // rests flat on the segment
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // ONE-SIDED for polygons too: a box rising from BELOW passes THROUGH.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ChainSegment cs;
        cs.ghost1.x = 15.0;   cs.ghost1.y = 0.0;
        cs.segment.point1.x = 5.0;    cs.segment.point1.y = 0.0;
        cs.segment.point2.x = -5.0;   cs.segment.point2.y = 0.0;
        cs.ghost2.x = -15.0;  cs.ghost2.y = 0.0;
        cs.chainId = -1;
        b2ShapeId gseg;  b2CreateChainSegmentShape( &world, &bg, &gsd, &cs, &gseg );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = -3.0;
        bd.linearVelocity.x = 0.0;  bd.linearVelocity.y = 15.0;
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        float dt = 1.0 / 60.0;  int k;
        float maxY = -3.0;
        for( k = 0; k < 120; k++ )
        {
            b2World_Step( &world, dt, 4 );
            b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
            if( p.y > maxY )  maxY = p.y;
        }
        diagB = maxY;
        Check( maxY > 2.0 );                                   // passed through (2-sided would block)
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // A CAPSULE dropped from above rests on a chain segment
    // (b2CollideChainSegmentAndCapsule -> the capsule becomes a rounded 2-gon).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ChainSegment cs;
        cs.ghost1.x = 15.0;   cs.ghost1.y = 0.0;
        cs.segment.point1.x = 5.0;    cs.segment.point1.y = 0.0;
        cs.segment.point2.x = -5.0;   cs.segment.point2.y = 0.0;
        cs.ghost2.x = -15.0;  cs.ghost2.y = 0.0;
        cs.chainId = -1;
        b2ShapeId gseg;  b2CreateChainSegmentShape( &world, &bg, &gsd, &cs, &gseg );

        b2Capsule cap;
        cap.center1.x = -0.3;  cap.center1.y = 0.0;
        cap.center2.x =  0.3;  cap.center2.y = 0.0;
        cap.radius = 0.25;
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 3.0;
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreateCapsuleShape( &world, &bb, &bsd, &cap, &bs );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 200; k++ )  b2World_Step( &world, dt, 4 );
        b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
        diagC = p.y;
        Check( p.y > 0.15 && p.y < 0.35 );                     // rests on its radius (0.25)
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // GHOST COLLISION (load-bearing -- this is the whole point of the Gauss map).
    // A 5-point open chain gives TWO collinear segments meeting at a junction at
    // x = 0. A frictionless box slides across that junction. With correct ghost
    // culling it glides straight through; a ghost collision at the shared vertex
    // would either stop it dead or kick it upward.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2Vec2[5] pts;
        pts[0].x = 15.0;   pts[0].y = 0.0;                     // ghost end
        pts[1].x = 5.0;    pts[1].y = 0.0;                     // seg0 point1
        pts[2].x = 0.0;    pts[2].y = 0.0;                     // JUNCTION (seg0 p2 / seg1 p1)
        pts[3].x = -5.0;   pts[3].y = 0.0;                     // seg1 point2
        pts[4].x = -15.0;  pts[4].y = 0.0;                     // ghost end

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ChainDef cd;  b2DefaultChainDef( &cd );
        cd.points = pts;  cd.count = 5;  cd.isLoop = false;
        cd.friction = 0.0;                                     // frictionless: it must keep sliding
        b2CreateChain( &world, &bg, &cd );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 3.0;  bd.position.y = 0.5;             // resting on the chain
        bd.linearVelocity.x = -6.0;  bd.linearVelocity.y = 0.0;
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );  bsd.friction = 0.0;
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        float dt = 1.0 / 60.0;  int k;
        float maxY = 0.5;
        float minY = 0.5;
        for( k = 0; k < 60; k++ )                              // 1 s at -6 m/s -> x: 3 -> -3
        {
            b2World_Step( &world, dt, 4 );
            b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
            if( p.y > maxY )  maxY = p.y;
            if( p.y < minY )  minY = p.y;
        }
        b2Vec2 pf;  b2Body_GetPosition( &world, &bb, &pf );
        diagA = pf.x;
        diagB = maxY;
        diagC = minY;
        Check( pf.x < -2.0 );                                  // crossed the junction, never caught
        Check( maxY < 0.6 );                                   // no upward kick from a ghost vertex
        Check( minY > 0.4 );                                   // never sank through
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // A box inside a CCW square chain LOOP rests on the bottom edge. Exercises the
    // polygon path against real convex corners + the loop's modular ghost wiring.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2Vec2[4] loop;
        loop[0].x = 5.0;   loop[0].y = -5.0;                   // CCW: inward-facing normals
        loop[1].x = -5.0;  loop[1].y = -5.0;
        loop[2].x = -5.0;  loop[2].y = 5.0;
        loop[3].x = 5.0;   loop[3].y = 5.0;

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ChainDef cd;  b2DefaultChainDef( &cd );
        cd.points = loop;  cd.count = 4;  cd.isLoop = true;
        b2CreateChain( &world, &bg, &cd );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 0.0;
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 200; k++ )  b2World_Step( &world, dt, 4 );
        b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
        diagD = p.y;
        Check( p.y > -4.7 && p.y < -4.3 );                     // rests on the loop's bottom edge
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // =========================================================================
    // CONTINUOUS (slice 3): BULLET vs MOVING bodies, via the deferred post-finalize
    // pass. A bullet sweeps the kinematic + dynamic trees, which is only sound once
    // every non-bullet body has finalized and refit its proxy.
    // =========================================================================

    // CONTROL: bullet vs a DYNAMIC thin wall with continuous OFF -> tunnels straight
    // through. Establishes that the wall is genuinely thin enough to be missed.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;            // enableContinuous OFF (default)

        b2Polygon wallBox;  b2MakeBox( 0.1, 2.0, &wallBox );
        b2BodyDef wdef;  b2DefaultBodyDef( &wdef );  wdef.type = b2_dynamicBody;
        b2BodyId bw;  b2CreateBody( &world, &wdef, &bw );
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );  wsd.density = 500.0;   // heavy: barely recoils
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bw, &wsd, &wallBox, &ws );

        b2Polygon bulletBox;  b2MakeBox( 0.25, 0.25, &bulletBox );
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.isBullet = true;
        bdef.position.x = -5.0;  bdef.position.y = 0.0;
        bdef.linearVelocity.x = 600.0;  bdef.linearVelocity.y = 0.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &bulletBox, &bs );

        b2World_Step( &world, 1.0 / 60.0, 4 );
        b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
        diagA = p.x;
        Check( p.x > 1.0 );                                       // TUNNELED through the dynamic wall

        b2DestroyWorld( &world );
    }

    // THE FIX: same scene with continuous ON. The bullet is deferred to pass 2, sweeps
    // the DYNAMIC tree, finds the wall and is clamped to its near face. Without the
    // deferred pass the dynamic tree would be queried mid-finalize and this would fail
    // (or, before this slice, the dynamic tree was never queried at all -> tunnel).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        world.enableContinuous = true;                            // opt IN

        b2Polygon wallBox;  b2MakeBox( 0.1, 2.0, &wallBox );
        b2BodyDef wdef;  b2DefaultBodyDef( &wdef );  wdef.type = b2_dynamicBody;
        b2BodyId bw;  b2CreateBody( &world, &wdef, &bw );
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );  wsd.density = 500.0;
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bw, &wsd, &wallBox, &ws );

        b2Polygon bulletBox;  b2MakeBox( 0.25, 0.25, &bulletBox );
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.isBullet = true;
        bdef.position.x = -5.0;  bdef.position.y = 0.0;
        bdef.linearVelocity.x = 600.0;  bdef.linearVelocity.y = 0.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &bulletBox, &bs );

        float dt = 1.0 / 60.0;  int k;
        float maxX = -5.0;
        for( k = 0; k < 5; k++ )
        {
            b2World_Step( &world, dt, 4 );
            b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
            if( p.x > maxX )  maxX = p.x;
        }
        // As with the static case, CCD only owns "did not pass through" = maxX; the
        // bullet's resting x afterwards is a solver artifact of the ~400 m/s impact.
        diagB = maxX;
        Check( maxX < 0.5 );                                      // never crossed the dynamic wall
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // A bullet vs a KINEMATIC wall (the other tree the deferred pass unlocks).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        world.enableContinuous = true;

        b2Polygon wallBox;  b2MakeBox( 0.1, 2.0, &wallBox );
        b2BodyDef wdef;  b2DefaultBodyDef( &wdef );  wdef.type = b2_kinematicBody;
        b2BodyId bw;  b2CreateBody( &world, &wdef, &bw );
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bw, &wsd, &wallBox, &ws );

        b2Polygon bulletBox;  b2MakeBox( 0.25, 0.25, &bulletBox );
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.isBullet = true;
        bdef.position.x = -5.0;  bdef.position.y = 0.0;
        bdef.linearVelocity.x = 600.0;  bdef.linearVelocity.y = 0.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &bulletBox, &bs );

        float dt = 1.0 / 60.0;  int k;
        float maxX = -5.0;
        for( k = 0; k < 5; k++ )
        {
            b2World_Step( &world, dt, 4 );
            b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
            if( p.x > maxX )  maxX = p.x;
        }
        diagC = maxX;
        Check( maxX < 0.5 );                                      // never crossed the kinematic wall
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // REGRESSION: a body flagged isBullet must still be stopped by STATIC geometry.
    // It now takes the deferred pass rather than the inline call, so the static path
    // is re-proved through the new code.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;
        world.enableContinuous = true;

        b2Polygon wallBox;  b2MakeBox( 0.1, 2.0, &wallBox );
        b2BodyDef wdef;  b2DefaultBodyDef( &wdef );  wdef.type = b2_staticBody;
        b2BodyId bw;  b2CreateBody( &world, &wdef, &bw );
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bw, &wsd, &wallBox, &ws );

        b2Polygon bulletBox;  b2MakeBox( 0.25, 0.25, &bulletBox );
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.isBullet = true;
        bdef.position.x = -5.0;  bdef.position.y = 0.0;
        bdef.linearVelocity.x = 600.0;  bdef.linearVelocity.y = 0.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &bulletBox, &bs );

        float dt = 1.0 / 60.0;  int k;
        float maxX = -5.0;
        for( k = 0; k < 5; k++ )
        {
            b2World_Step( &world, dt, 4 );
            b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
            if( p.x > maxX )  maxX = p.x;
        }
        diagD = maxX;
        Check( maxX < 0.5 );                                      // static path still stops a bullet
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // FLAG-CLEAR GUARD: a bullet that is fast for the first few steps (slammed down at
    // 30 m/s -> 0.5/step > 0.5*minExtent) and then comes to rest must settle normally.
    // This exercises b2_isFast being SET and later CLEARED: a stale flag would keep
    // re-sweeping the resting body through pass 2 every step.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        world.enableContinuous = true;

        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        gdef.position.x = 0.0;  gdef.position.y = -0.5;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.isBullet = true;
        bdef.position.x = 0.0;  bdef.position.y = 3.0;
        bdef.linearVelocity.x = 0.0;  bdef.linearVelocity.y = -30.0;   // fast at first
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 200; k++ )  b2World_Step( &world, dt, 4 );
        b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
        diagA = p.y;
        Check( p.y > 0.35 && p.y < 0.65 );                        // rests normally on the floor
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // =========================================================================
    // SHAPE CAST (distance slice 4): b2ShapeCast + the four geometry wrappers,
    // and the rounded-polygon ray cast it unblocks.
    //
    // The hit fraction stops a hair BEFORE geometric contact: the GJK loop runs on
    // CORE shapes (useRadii = false) and terminates at
    //     target = max( linearSlop, totalRadius - linearSlop ),  linearSlop = 0.005
    // so every expected fraction below carries that -0.005 offset. Values are hand
    // computed; tolerances are loose enough for the console's non-IEEE FDIV.
    // =========================================================================

    // Cast a POINT at a circle of radius 0.5 sitting at the origin, from (-5,0) along
    // +x by 10. Contact would be at centre distance 0.5 -> fraction 0.45; the cast
    // stops at core distance 0.495 -> fraction 0.4505. Surface point is (-0.5, 0).
    {
        b2Circle c;  c.center.x = 0.0;  c.center.y = 0.0;  c.radius = 0.5;

        b2Vec2 origin;  origin.x = -5.0;  origin.y = 0.0;
        b2ShapeCastInput in;
        b2MakeProxy( &origin, 1, 0.0, &in.proxy );
        in.translation.x = 10.0;  in.translation.y = 0.0;
        in.maxFraction = 1.0;
        in.canEncroach = false;

        b2CastOutput out;  b2ShapeCastCircle( &c, &in, &out );
        diagA = out.fraction;
        Check( out.hit == true );
        Check( fabs( out.fraction - 0.4505 ) < 0.01 );
        Check( fabs( out.point.x + 0.5 ) < 0.02 && fabs( out.point.y ) < 0.02 );
        Check( fabs( out.normal.x + 1.0 ) < 0.01 && fabs( out.normal.y ) < 0.01 );
    }

    // Cast a POINT at a radius-0 box [-1,1]^2. target = 0.005 -> fraction 0.3995,
    // just short of the exact ray-cast answer 0.4 (checked earlier in this file).
    {
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );

        b2Vec2 origin;  origin.x = -5.0;  origin.y = 0.0;
        b2ShapeCastInput in;
        b2MakeProxy( &origin, 1, 0.0, &in.proxy );
        in.translation.x = 10.0;  in.translation.y = 0.0;
        in.maxFraction = 1.0;
        in.canEncroach = false;

        b2CastOutput out;  b2ShapeCastPolygon( &box, &in, &out );
        diagB = out.fraction;
        Check( out.hit == true );
        Check( fabs( out.fraction - 0.3995 ) < 0.01 );
        Check( fabs( out.point.x + 1.0 ) < 0.02 );
        Check( fabs( out.normal.x + 1.0 ) < 0.01 );
    }

    // MISS by maxFraction: the same cast cut off at 0.2, before the 0.3995 impact.
    {
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );

        b2Vec2 origin;  origin.x = -5.0;  origin.y = 0.0;
        b2ShapeCastInput in;
        b2MakeProxy( &origin, 1, 0.0, &in.proxy );
        in.translation.x = 10.0;  in.translation.y = 0.0;
        in.maxFraction = 0.2;
        in.canEncroach = false;

        b2CastOutput out;  b2ShapeCastPolygon( &box, &in, &out );
        Check( out.hit == false );                             // impact lies beyond the cast
    }

    // MISS by receding: translation points AWAY from the box (denominator >= 0).
    {
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );

        b2Vec2 origin;  origin.x = -5.0;  origin.y = 0.0;
        b2ShapeCastInput in;
        b2MakeProxy( &origin, 1, 0.0, &in.proxy );
        in.translation.x = -10.0;  in.translation.y = 0.0;
        in.maxFraction = 1.0;
        in.canEncroach = false;

        b2CastOutput out;  b2ShapeCastPolygon( &box, &in, &out );
        Check( out.hit == false );                             // never closes on the box
    }

    // INITIAL OVERLAP: the point starts inside the circle's radius. Upstream's header
    // says "initially touching is a miss" but the CODE returns hit with fraction 0 and
    // a midpoint; the port matches the code. c1 = (0.5,0), c2 = (0.1,0) -> point (0.3,0).
    {
        b2Circle c;  c.center.x = 0.0;  c.center.y = 0.0;  c.radius = 0.5;

        b2Vec2 origin;  origin.x = 0.1;  origin.y = 0.0;
        b2ShapeCastInput in;
        b2MakeProxy( &origin, 1, 0.0, &in.proxy );
        in.translation.x = 10.0;  in.translation.y = 0.0;
        in.maxFraction = 1.0;
        in.canEncroach = false;

        b2CastOutput out;  b2ShapeCastCircle( &c, &in, &out );
        diagC = out.point.x;
        Check( out.hit == true );
        Check( out.fraction == 0.0 );                          // overlap -> zero fraction
        Check( fabs( out.point.x - 0.3 ) < 0.02 );             // midpoint of the two witnesses
    }

    // canEncroach (A^B against the check above): a point starting 0.4 from the circle
    // centre is already inside target 0.495, so canEncroach = false reports overlap
    // (fraction 0). With canEncroach = true the target is pulled in to 0.395 and the
    // cast really sweeps -> a small POSITIVE fraction and a real normal.
    {
        b2Circle c;  c.center.x = 0.0;  c.center.y = 0.0;  c.radius = 0.5;

        b2Vec2 origin;  origin.x = 0.4;  origin.y = 0.0;
        b2ShapeCastInput in;
        b2MakeProxy( &origin, 1, 0.0, &in.proxy );
        in.translation.x = -10.0;  in.translation.y = 0.0;     // toward the circle centre
        in.maxFraction = 1.0;

        in.canEncroach = false;
        b2CastOutput noEnc;  b2ShapeCastCircle( &c, &in, &noEnc );
        Check( noEnc.hit == true );
        Check( noEnc.fraction == 0.0 );                        // treated as initial overlap

        in.canEncroach = true;
        b2CastOutput enc;  b2ShapeCastCircle( &c, &in, &enc );
        diagD = enc.fraction;
        Check( enc.hit == true );
        Check( enc.fraction > 0.0 && enc.fraction < 0.01 );    // swept ~0.0005 instead
        Check( fabs( enc.normal.x - 1.0 ) < 0.01 );            // A->B normal, +x
    }

    // Segment wrapper: segment x=0 from y=-1..1, point cast from (-5,0) by +10.
    // totalRadius 0 -> target 0.005 -> fraction 0.4995.
    {
        b2Segment s;
        s.point1.x = 0.0;  s.point1.y = -1.0;
        s.point2.x = 0.0;  s.point2.y =  1.0;

        b2Vec2 origin;  origin.x = -5.0;  origin.y = 0.0;
        b2ShapeCastInput in;
        b2MakeProxy( &origin, 1, 0.0, &in.proxy );
        in.translation.x = 10.0;  in.translation.y = 0.0;
        in.maxFraction = 1.0;
        in.canEncroach = false;

        b2CastOutput out;  b2ShapeCastSegment( &s, &in, &out );
        Check( out.hit == true );
        Check( fabs( out.fraction - 0.4995 ) < 0.01 );
    }

    // Capsule wrapper: vertical capsule radius 0.3 -> target 0.295 -> fraction 0.4705,
    // surface point (-0.3, 0).
    {
        b2Capsule cap;
        cap.center1.x = 0.0;  cap.center1.y = -1.0;
        cap.center2.x = 0.0;  cap.center2.y =  1.0;
        cap.radius = 0.3;

        b2Vec2 origin;  origin.x = -5.0;  origin.y = 0.0;
        b2ShapeCastInput in;
        b2MakeProxy( &origin, 1, 0.0, &in.proxy );
        in.translation.x = 10.0;  in.translation.y = 0.0;
        in.maxFraction = 1.0;
        in.canEncroach = false;

        b2CastOutput out;  b2ShapeCastCapsule( &cap, &in, &out );
        Check( out.hit == true );
        Check( fabs( out.fraction - 0.4705 ) < 0.01 );
        Check( fabs( out.point.x + 0.3 ) < 0.02 );
    }

    // A MOVING BOX, not just a point -- the "does the player fit through" case. A 1x1
    // box centred at (-5,0) sweeps +x at the box [-1,1]^2. Its right face starts at
    // -4.5, so the core gap is 3.5 -> fraction (3.5-0.005)/10 = 0.3495.
    {
        b2Polygon wall;  b2MakeBox( 1.0, 1.0, &wall );

        b2Vec2[4] bpts;
        bpts[0].x = -5.5;  bpts[0].y = -0.5;
        bpts[1].x = -4.5;  bpts[1].y = -0.5;
        bpts[2].x = -4.5;  bpts[2].y =  0.5;
        bpts[3].x = -5.5;  bpts[3].y =  0.5;

        b2ShapeCastInput in;
        b2MakeProxy( bpts, 4, 0.0, &in.proxy );
        in.translation.x = 10.0;  in.translation.y = 0.0;
        in.maxFraction = 1.0;
        in.canEncroach = false;

        b2CastOutput out;  b2ShapeCastPolygon( &wall, &in, &out );
        diagA = out.fraction;
        Check( out.hit == true );
        Check( fabs( out.fraction - 0.3495 ) < 0.01 );
        Check( fabs( out.normal.x + 1.0 ) < 0.01 );            // wall's left face
    }

    // ROUNDED-POLYGON RAY CAST -- the path b2ShapeCast unblocks. Before this slice
    // b2RayCastPolygon returned hit = false for any radius > 0. Core box [-1,1]^2 with
    // radius 0.25: target = 0.245, core gap 4 -> fraction 0.3755, surface x = -1.25.
    {
        b2Polygon rbox;  b2MakeRoundedBox( 1.0, 1.0, 0.25, &rbox );

        b2RayCastInput in;
        in.origin.x = -5.0;  in.origin.y = 0.0;
        in.translation.x = 10.0;  in.translation.y = 0.0;
        in.maxFraction = 1.0;

        b2CastOutput out;  b2RayCastPolygon( &rbox, &in, &out );
        diagB = out.fraction;
        diagC = out.point.x;
        Check( out.hit == true );                              // was FALSE before this slice
        Check( fabs( out.fraction - 0.3755 ) < 0.01 );
        Check( fabs( out.point.x + 1.25 ) < 0.02 );            // on the rounded left face
        Check( fabs( out.normal.x + 1.0 ) < 0.01 );
    }

    // A rounded-polygon ray that MISSES (passes above the rounded box entirely).
    {
        b2Polygon rbox;  b2MakeRoundedBox( 1.0, 1.0, 0.25, &rbox );

        b2RayCastInput in;
        in.origin.x = -5.0;  in.origin.y = 3.0;
        in.translation.x = 10.0;  in.translation.y = 0.0;
        in.maxFraction = 1.0;

        b2CastOutput out;  b2RayCastPolygon( &rbox, &in, &out );
        Check( out.hit == false );
    }

    // =========================================================================
    // b2World_CastShapeClosest: sweep a shape against the whole world.
    // Tree box cast (b2DynamicTree_BoxCast) -> exact per-shape b2ShapeCastShape in
    // the candidate's local frame -> closest hit, mapped back to world.
    // Fractions carry the same one-linearSlop offset as b2ShapeCast.
    // =========================================================================

    // Sweep a 1x1 box (half 0.5, centred at (-5,0)) at a static wall box [-1,1]^2,
    // translation (10,0). The moving box's right face starts at -4.5, so the core gap
    // is 3.5 -> fraction (3.5 - 0.005)/10 = 0.3495. Hit point on the wall's left face.
    {
        b2World world;  b2CreateWorld( &world );

        b2Polygon wall;  b2MakeBox( 1.0, 1.0, &wall );
        b2BodyDef wdef;  b2DefaultBodyDef( &wdef );  wdef.type = b2_staticBody;
        b2BodyId bw;  b2CreateBody( &world, &wdef, &bw );
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bw, &wsd, &wall, &ws );

        b2Vec2[4] bpts;
        bpts[0].x = -5.5;  bpts[0].y = -0.5;
        bpts[1].x = -4.5;  bpts[1].y = -0.5;
        bpts[2].x = -4.5;  bpts[2].y =  0.5;
        bpts[3].x = -5.5;  bpts[3].y =  0.5;
        b2ShapeProxy proxy;  b2MakeProxy( bpts, 4, 0.0, &proxy );

        b2Vec2 tr;  tr.x = 10.0;  tr.y = 0.0;
        b2CastOutput out;
        int hitShape = b2World_CastShapeClosest( &world, &proxy, &tr, NULL, &out );

        diagA = out.fraction;
        Check( out.hit == true );
        Check( hitShape == ws.index1 - 1 );                    // the wall's shape
        Check( fabs( out.fraction - 0.3495 ) < 0.01 );
        Check( fabs( out.point.x + 1.0 ) < 0.03 );             // wall's left face
        Check( fabs( out.normal.x + 1.0 ) < 0.01 );
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // A CIRCLE proxy (1 point, radius 0.5) swept at the same wall. totalRadius 0.5 ->
    // target 0.495; core gap from (-5,0) to the face at -1 is 4 -> fraction 0.3505.
    {
        b2World world;  b2CreateWorld( &world );

        b2Polygon wall;  b2MakeBox( 1.0, 1.0, &wall );
        b2BodyDef wdef;  b2DefaultBodyDef( &wdef );  wdef.type = b2_staticBody;
        b2BodyId bw;  b2CreateBody( &world, &wdef, &bw );
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bw, &wsd, &wall, &ws );

        b2Vec2 centre;  centre.x = -5.0;  centre.y = 0.0;
        b2ShapeProxy proxy;  b2MakeProxy( &centre, 1, 0.5, &proxy );

        b2Vec2 tr;  tr.x = 10.0;  tr.y = 0.0;
        b2CastOutput out;
        int hitShape = b2World_CastShapeClosest( &world, &proxy, &tr, NULL, &out );

        diagB = out.fraction;
        Check( out.hit == true );
        Check( hitShape == ws.index1 - 1 );
        Check( fabs( out.fraction - 0.3505 ) < 0.01 );
        Check( fabs( out.normal.x + 1.0 ) < 0.01 );

        b2DestroyWorld( &world );
    }

    // MISS: the same swept box passes well above the wall.
    {
        b2World world;  b2CreateWorld( &world );

        b2Polygon wall;  b2MakeBox( 1.0, 1.0, &wall );
        b2BodyDef wdef;  b2DefaultBodyDef( &wdef );  wdef.type = b2_staticBody;
        b2BodyId bw;  b2CreateBody( &world, &wdef, &bw );
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bw, &wsd, &wall, &ws );

        b2Vec2[4] bpts;
        bpts[0].x = -5.5;  bpts[0].y = 4.5;
        bpts[1].x = -4.5;  bpts[1].y = 4.5;
        bpts[2].x = -4.5;  bpts[2].y = 5.5;
        bpts[3].x = -5.5;  bpts[3].y = 5.5;
        b2ShapeProxy proxy;  b2MakeProxy( bpts, 4, 0.0, &proxy );

        b2Vec2 tr;  tr.x = 10.0;  tr.y = 0.0;
        b2CastOutput out;
        int hitShape = b2World_CastShapeClosest( &world, &proxy, &tr, NULL, &out );

        Check( out.hit == false );
        Check( hitShape == B2_NULL_INDEX );

        b2DestroyWorld( &world );
    }

    // CLOSEST-OF-TWO: two walls in the sweep's path -> the NEAR one wins, and the
    // fraction is the near one's. (Proves the maxFraction shrink actually prunes.)
    {
        b2World world;  b2CreateWorld( &world );

        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );

        b2BodyDef n;  b2DefaultBodyDef( &n );  n.type = b2_staticBody;
        n.position.x = 0.0;  n.position.y = 0.0;
        b2BodyId bn;  b2CreateBody( &world, &n, &bn );
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );
        b2ShapeId nearShape;  b2CreatePolygonShape( &world, &bn, &sd, &box, &nearShape );

        b2BodyDef f;  b2DefaultBodyDef( &f );  f.type = b2_staticBody;
        f.position.x = 6.0;  f.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &f, &bf );
        b2ShapeId farShape;  b2CreatePolygonShape( &world, &bf, &sd, &box, &farShape );

        b2Vec2 centre;  centre.x = -5.0;  centre.y = 0.0;
        b2ShapeProxy proxy;  b2MakeProxy( &centre, 1, 0.0, &proxy );   // a point

        b2Vec2 tr;  tr.x = 20.0;  tr.y = 0.0;
        b2CastOutput out;
        int hitShape = b2World_CastShapeClosest( &world, &proxy, &tr, NULL, &out );

        // point proxy: totalRadius 0 -> target 0.005; core gap to the near face = 4
        diagC = out.fraction;
        Check( out.hit == true );
        Check( hitShape == nearShape.index1 - 1 );             // NEAR wall, not far
        Check( fabs( out.fraction - ( 4.0 - 0.005 ) / 20.0 ) < 0.01 );

        b2DestroyWorld( &world );
    }

    // ROTATED BODY (the load-bearing world-layer test): the candidate's pose is not
    // the identity, so the proxy must be pulled into its local frame and the hit
    // mapped back out. A 2.0 x 0.5 half-box rotated +90 deg at (3,0) presents a face
    // at world x = 2.5, spanning y in [-2,2]. Sweep a 0.25-half box from (-5,0) by
    // (20,0): its right face starts at -4.75, core gap 7.25 -> fraction 0.36225.
    {
        b2World world;  b2CreateWorld( &world );

        b2Polygon wall;  b2MakeBox( 2.0, 0.5, &wall );
        b2BodyDef wdef;  b2DefaultBodyDef( &wdef );  wdef.type = b2_staticBody;
        wdef.position.x = 3.0;  wdef.position.y = 0.0;
        wdef.rotation.c = 0.0;  wdef.rotation.s = 1.0;         // +90 degrees
        b2BodyId bw;  b2CreateBody( &world, &wdef, &bw );
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bw, &wsd, &wall, &ws );

        b2Vec2[4] bpts;
        bpts[0].x = -5.25;  bpts[0].y = -0.25;
        bpts[1].x = -4.75;  bpts[1].y = -0.25;
        bpts[2].x = -4.75;  bpts[2].y =  0.25;
        bpts[3].x = -5.25;  bpts[3].y =  0.25;
        b2ShapeProxy proxy;  b2MakeProxy( bpts, 4, 0.0, &proxy );

        b2Vec2 tr;  tr.x = 20.0;  tr.y = 0.0;
        b2CastOutput out;
        int hitShape = b2World_CastShapeClosest( &world, &proxy, &tr, NULL, &out );

        diagD = out.fraction;
        Check( out.hit == true );
        Check( hitShape == ws.index1 - 1 );
        Check( fabs( out.fraction - 0.36225 ) < 0.01 );
        Check( fabs( out.point.x - 2.5 ) < 0.05 );             // WORLD-space face
        Check( fabs( out.normal.x + 1.0 ) < 0.01 );            // WORLD-space normal
        Check( fabs( out.normal.y ) < 0.01 );

        b2DestroyWorld( &world );
    }

    // The DYNAMIC tree is queried too, not just the static one.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;

        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );
        b2BodyDef ddef;  b2DefaultBodyDef( &ddef );  ddef.type = b2_dynamicBody;
        b2BodyId bd;  b2CreateBody( &world, &ddef, &bd );
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );
        b2ShapeId ds;  b2CreatePolygonShape( &world, &bd, &sd, &box, &ds );

        b2Vec2 centre;  centre.x = -5.0;  centre.y = 0.0;
        b2ShapeProxy proxy;  b2MakeProxy( &centre, 1, 0.0, &proxy );

        b2Vec2 tr;  tr.x = 10.0;  tr.y = 0.0;
        b2CastOutput out;
        int hitShape = b2World_CastShapeClosest( &world, &proxy, &tr, NULL, &out );

        Check( out.hit == true );
        Check( hitShape == ds.index1 - 1 );                    // found in the dynamic tree
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // =========================================================================
    // MOVER / CHARACTER CONTROLLER (port of mover.c + the geometry/world halves).
    // KERNEL CHECKS FIRST (b2SolvePlanes / b2ClipVector / b2CollideMoverAnd*), then
    // the two world queries, so a red points at the layer that broke it.
    //
    // b2SolvePlanes is a 20-iteration relaxation -- verify its geometric FIXED POINT,
    // never the iteration path. It adds B2_LINEAR_SLOP (0.005) to each separation to
    // stop jitter, so the mover settles one slop INTO the plane, not exactly on it.
    // =========================================================================

    // One rigid ground plane (normal +y through the origin). A target delta driving
    // 1.0 straight down resolves to -0.005: pushed out until separation + slop == 0.
    {
        b2CollisionPlane[1] planes;
        planes[0].plane.normal.x = 0.0;  planes[0].plane.normal.y = 1.0;
        planes[0].plane.offset = 0.0;
        planes[0].pushLimit = FLT_MAX;                     // rigid
        planes[0].push = 0.0;
        planes[0].clipVelocity = true;

        b2Vec2 target;  target.x = 0.0;  target.y = -1.0;
        b2PlaneSolverResult res;
        b2SolvePlanes( &target, planes, 1, &res );

        diagA = res.translation.y;
        Check( fabs( res.translation.x ) < 0.001 );        // no sideways drift
        Check( fabs( res.translation.y + 0.005 ) < 0.002 );// settles one slop in
        Check( fabs( planes[0].push - 0.995 ) < 0.01 );    // the push it needed
    }

    // Two orthogonal rigid planes (a corner): ground normal +y, wall normal -x. A
    // target driving into BOTH resolves to the corner, one slop into each.
    {
        b2CollisionPlane[2] planes;
        planes[0].plane.normal.x = 0.0;   planes[0].plane.normal.y = 1.0;
        planes[0].plane.offset = 0.0;
        planes[0].pushLimit = FLT_MAX;  planes[0].push = 0.0;  planes[0].clipVelocity = true;
        planes[1].plane.normal.x = -1.0;  planes[1].plane.normal.y = 0.0;
        planes[1].plane.offset = 0.0;
        planes[1].pushLimit = FLT_MAX;  planes[1].push = 0.0;  planes[1].clipVelocity = true;

        b2Vec2 target;  target.x = 1.0;  target.y = -1.0;   // into the ground AND the wall
        b2PlaneSolverResult res;
        b2SolvePlanes( &target, planes, 2, &res );

        // Each axis ends one slop INSIDE its plane -- but "inside" is along the MINUS
        // normal, so the wall (normal -x) settles at x = +0.005 while the ground
        // (normal +y) settles at y = -0.005. Sign follows the normal, not the axis.
        diagB = res.translation.x;
        Check( fabs( res.translation.x - 0.005 ) < 0.01 );
        Check( fabs( res.translation.y + 0.005 ) < 0.01 );
        Check( planes[0].push > 0.0 && planes[1].push > 0.0 );
    }

    // pushLimit makes a plane SOFT: it can only give back 0.5 of the 1.0 penetration.
    {
        b2CollisionPlane[1] planes;
        planes[0].plane.normal.x = 0.0;  planes[0].plane.normal.y = 1.0;
        planes[0].plane.offset = 0.0;
        planes[0].pushLimit = 0.5;                         // soft
        planes[0].push = 0.0;
        planes[0].clipVelocity = true;

        b2Vec2 target;  target.x = 0.0;  target.y = -1.0;
        b2PlaneSolverResult res;
        b2SolvePlanes( &target, planes, 1, &res );

        Check( fabs( planes[0].push - 0.5 ) < 0.01 );      // clamped at the limit
        Check( fabs( res.translation.y + 0.5 ) < 0.01 );   // still 0.5 penetrating
    }

    // b2ClipVector: remove only the INWARD component, only for pushed clipping planes.
    {
        b2CollisionPlane[1] planes;
        planes[0].plane.normal.x = 0.0;  planes[0].plane.normal.y = 1.0;
        planes[0].plane.offset = 0.0;
        planes[0].pushLimit = FLT_MAX;
        planes[0].push = 0.995;                            // the solver pushed here
        planes[0].clipVelocity = true;

        b2Vec2 into;  into.x = 3.0;  into.y = -4.0;        // sliding right, driving down
        b2Vec2 clipped;  b2ClipVector( &into, planes, 1, &clipped );
        Check( feq( clipped.x, 3.0 ) );                    // tangential speed kept
        Check( feq( clipped.y, 0.0 ) );                    // inward speed removed

        b2Vec2 away;  away.x = 3.0;  away.y = 4.0;         // leaving the surface
        b2Vec2 keep;  b2ClipVector( &away, planes, 1, &keep );
        Check( feq( keep.x, 3.0 ) && feq( keep.y, 4.0 ) ); // untouched

        planes[0].clipVelocity = false;                    // opted out of clipping
        b2Vec2 unclipped;  b2ClipVector( &into, planes, 1, &unclipped );
        Check( feq( unclipped.y, -4.0 ) );

        planes[0].clipVelocity = true;
        planes[0].push = 0.0;                              // solver never pushed here
        b2Vec2 nopush;  b2ClipVector( &into, planes, 1, &nopush );
        Check( feq( nopush.y, -4.0 ) );
    }

    // b2CollideMoverAndPolygon: a capsule mover overlapping a box's top face. Box top
    // is y = 0.5; the mover's lower cap centre is at y = 0.8 with radius 0.5, so the
    // core gap is 0.3 against a combined radius of 0.5 -> penetration (offset) 0.2.
    {
        b2Polygon ground;  b2MakeBox( 5.0, 0.5, &ground );

        b2Capsule mover;
        mover.center1.x = 0.0;  mover.center1.y = 0.8;
        mover.center2.x = 0.0;  mover.center2.y = 1.8;
        mover.radius = 0.5;

        b2PlaneResult pr;
        b2CollideMoverAndPolygon( &mover, &ground, &pr );

        diagC = pr.plane.offset;
        Check( pr.hit == true );
        Check( fabs( pr.plane.normal.x ) < 0.01 );
        Check( fabs( pr.plane.normal.y - 1.0 ) < 0.01 );   // pushes the mover UP
        Check( fabs( pr.plane.offset - 0.2 ) < 0.01 );     // penetration depth
        Check( fabs( pr.point.y - 0.5 ) < 0.02 );          // witness on the box's top
    }

    // A mover clear of the box registers no plane.
    {
        b2Polygon ground;  b2MakeBox( 5.0, 0.5, &ground );
        b2Capsule mover;
        mover.center1.x = 0.0;  mover.center1.y = 3.0;
        mover.center2.x = 0.0;  mover.center2.y = 4.0;
        mover.radius = 0.5;

        b2PlaneResult pr;
        b2CollideMoverAndPolygon( &mover, &ground, &pr );
        Check( pr.hit == false );
    }

    // END TO END: b2World_CollideMover gathers the planes, b2SolvePlanes resolves the
    // mover out of the ground. Same geometry as above -> one plane, and a zero target
    // delta resolves to +0.195 (0.2 penetration minus the anti-jitter slop).
    {
        b2World world;  b2CreateWorld( &world );

        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        b2Capsule mover;
        mover.center1.x = 0.0;  mover.center1.y = 0.8;
        mover.center2.x = 0.0;  mover.center2.y = 1.8;
        mover.radius = 0.5;

        g_planeCount = 0;
        b2World_CollideMover( &world, &mover, NULL, &MoverPlaneCollect, NULL );

        Check( g_planeCount == 1 );                        // exactly the ground
        Check( fabs( g_planes[0].plane.normal.y - 1.0 ) < 0.01 );
        Check( fabs( g_planes[0].plane.offset - 0.2 ) < 0.01 );

        b2Vec2 target;  target.x = 0.0;  target.y = 0.0;   // "don't move me, just fix me"
        b2PlaneSolverResult res;
        b2SolvePlanes( &target, g_planes, g_planeCount, &res );

        diagD = res.translation.y;
        Check( fabs( res.translation.y - 0.195 ) < 0.01 ); // lifted clear, minus a slop
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // A mover free of everything gathers no planes at all.
    {
        b2World world;  b2CreateWorld( &world );

        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        b2Capsule mover;
        mover.center1.x = 0.0;  mover.center1.y = 5.0;
        mover.center2.x = 0.0;  mover.center2.y = 6.0;
        mover.radius = 0.5;

        g_planeCount = 0;
        b2World_CollideMover( &world, &mover, NULL, &MoverPlaneCollect, NULL );
        Check( g_planeCount == 0 );

        b2DestroyWorld( &world );
    }

    // ROTATED BODY (load-bearing for b2CollideMover): the normal must be rotated back
    // out of the shape's local frame. A 5.0 x 0.5 half-box turned +90 deg at the origin
    // becomes a vertical wall spanning x in [-0.5, 0.5]. Its local "top" face (local
    // normal (0,1)) is now the wall's LEFT face, world normal (-1,0). A mover overlapping
    // that face from the left must be pushed further left.
    //
    // Drop the back-rotation and this reports the LOCAL normal (0,1) instead, so the
    // check discriminates cleanly.
    {
        b2World world;  b2CreateWorld( &world );

        b2Polygon slab;  b2MakeBox( 5.0, 0.5, &slab );
        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        gdef.rotation.c = 0.0;  gdef.rotation.s = 1.0;     // +90 degrees
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &slab, &gs );

        b2Capsule mover;                                   // 0.3 from the face, r = 0.5
        mover.center1.x = -0.8;  mover.center1.y = 0.0;
        mover.center2.x = -0.8;  mover.center2.y = 1.0;
        mover.radius = 0.5;

        g_planeCount = 0;
        b2World_CollideMover( &world, &mover, NULL, &MoverPlaneCollect, NULL );

        Check( g_planeCount == 1 );
        diagC = g_planes[0].plane.normal.x;
        Check( fabs( g_planes[0].plane.normal.x + 1.0 ) < 0.01 );   // WORLD normal -x
        Check( fabs( g_planes[0].plane.normal.y ) < 0.01 );         // not the local (0,1)
        Check( fabs( g_planes[0].plane.offset - 0.2 ) < 0.01 );

        b2DestroyWorld( &world );
    }

    // b2CollideMoverAndCapsule: horizontal capsule ground (r = 0.5, surface y = 0.5).
    // Core distance from its axis to the mover's lower cap centre is 0.8, combined
    // radius 1.0 -> penetration 0.2.
    {
        b2Capsule ground;
        ground.center1.x = -5.0;  ground.center1.y = 0.0;
        ground.center2.x =  5.0;  ground.center2.y = 0.0;
        ground.radius = 0.5;

        b2Capsule mover;
        mover.center1.x = 0.0;  mover.center1.y = 0.8;
        mover.center2.x = 0.0;  mover.center2.y = 1.8;
        mover.radius = 0.5;

        b2PlaneResult pr;
        b2CollideMoverAndCapsule( &mover, &ground, &pr );
        Check( pr.hit == true );
        Check( fabs( pr.plane.normal.y - 1.0 ) < 0.01 );
        Check( fabs( pr.plane.offset - 0.2 ) < 0.01 );
    }

    // b2CollideMoverAndSegment: a segment has NO radius, so the combined radius is the
    // mover's alone (0.5). Core distance 0.3 -> penetration 0.2.
    {
        b2Segment ground;
        ground.point1.x = -5.0;  ground.point1.y = 0.0;
        ground.point2.x =  5.0;  ground.point2.y = 0.0;

        b2Capsule mover;
        mover.center1.x = 0.0;  mover.center1.y = 0.3;
        mover.center2.x = 0.0;  mover.center2.y = 1.3;
        mover.radius = 0.5;

        b2PlaneResult pr;
        b2CollideMoverAndSegment( &mover, &ground, &pr );
        Check( pr.hit == true );
        Check( fabs( pr.plane.normal.y - 1.0 ) < 0.01 );
        Check( fabs( pr.plane.offset - 0.2 ) < 0.01 );

        // clear of it: 0.8 > the mover's 0.5 radius, and a segment adds none
        mover.center1.y = 0.8;  mover.center2.y = 1.8;
        b2CollideMoverAndSegment( &mover, &ground, &pr );
        Check( pr.hit == false );
    }

    // b2World_CastMover: a vertical capsule (r = 0.5) swept +x by 10 at a wall whose
    // left face is x = 4.5. Core gap 4.5, target = 0.5 - slop = 0.495 -> f = 0.4005.
    {
        b2World world;  b2CreateWorld( &world );

        b2Polygon wall;  b2MakeBox( 0.5, 5.0, &wall );
        b2BodyDef wdef;  b2DefaultBodyDef( &wdef );  wdef.type = b2_staticBody;
        wdef.position.x = 5.0;  wdef.position.y = 0.0;
        b2BodyId bw;  b2CreateBody( &world, &wdef, &bw );
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bw, &wsd, &wall, &ws );

        b2Capsule mover;
        mover.center1.x = 0.0;  mover.center1.y = -0.5;
        mover.center2.x = 0.0;  mover.center2.y =  0.5;
        mover.radius = 0.5;

        b2Vec2 tr;  tr.x = 10.0;  tr.y = 0.0;
        float f = b2World_CastMover( &world, &mover, &tr, NULL );

        diagA = f;
        Check( fabs( f - 0.4005 ) < 0.01 );

        b2DestroyWorld( &world );
    }

    // Nothing in the way -> the whole sweep is free.
    {
        b2World world;  b2CreateWorld( &world );

        b2Capsule mover;
        mover.center1.x = 0.0;  mover.center1.y = -0.5;
        mover.center2.x = 0.0;  mover.center2.y =  0.5;
        mover.radius = 0.5;

        b2Vec2 tr;  tr.x = 10.0;  tr.y = 0.0;
        float f = b2World_CastMover( &world, &mover, &tr, NULL );
        Check( feq( f, 1.0 ) );

        b2DestroyWorld( &world );
    }

    // A shape the mover already OVERLAPS is ignored -- otherwise a character standing
    // on the ground could never take a step along it. Mover sunk into the ground,
    // swept sideways: the ground must not pin the fraction at 0.
    {
        b2World world;  b2CreateWorld( &world );

        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        b2Capsule mover;
        mover.center1.x = 0.0;  mover.center1.y = 0.8;     // overlapping the ground
        mover.center2.x = 0.0;  mover.center2.y = 1.8;
        mover.radius = 0.5;

        b2Vec2 tr;  tr.x = 3.0;  tr.y = 0.0;               // step sideways
        float f = b2World_CastMover( &world, &mover, &tr, NULL );
        Check( feq( f, 1.0 ) );                            // free to slide

        b2DestroyWorld( &world );
    }

    // =========================================================================
    // QUERY FILTERS (b2QueryFilter + b2ShouldQueryCollide), threaded through all
    // five world queries. A NULL filter means "see everything" (the old behavior).
    //
    // b2ShouldQueryCollide is a handshake that must pass in BOTH directions:
    //     (shape.categoryBits & query.maskBits) && (shape.maskBits & query.categoryBits)
    // There is no groupIndex override -- a query has no group.
    //
    // Scene for the ray tests: a NEAR box (category 2) whose left face is x = -1, and
    // a FAR box (category 1) whose left face is x = 5. Ray (-5,0) -> +x by 20, so the
    // near box is fraction 0.2 and the far box is 0.5.
    // =========================================================================

    // No filter -> the nearer box wins, as before this slice.
    {
        b2World world;  b2CreateWorld( &world );
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );

        b2BodyDef nd;  b2DefaultBodyDef( &nd );  nd.type = b2_staticBody;
        nd.position.x = 0.0;  nd.position.y = 0.0;
        b2BodyId bn;  b2CreateBody( &world, &nd, &bn );
        b2ShapeDef nsd;  b2DefaultShapeDef( &nsd );  nsd.filter.categoryBits = 2;
        b2ShapeId nearShape;  b2CreatePolygonShape( &world, &bn, &nsd, &box, &nearShape );

        b2BodyDef fd;  b2DefaultBodyDef( &fd );  fd.type = b2_staticBody;
        fd.position.x = 6.0;  fd.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fd, &bf );
        b2ShapeDef fsd;  b2DefaultShapeDef( &fsd );  fsd.filter.categoryBits = 1;
        b2ShapeId farShape;  b2CreatePolygonShape( &world, &bf, &fsd, &box, &farShape );

        b2Vec2 o;  o.x = -5.0;  o.y = 0.0;
        b2Vec2 tr;  tr.x = 20.0;  tr.y = 0.0;

        b2CastOutput out;
        int hitId = b2World_CastRayClosest( &world, &o, &tr, NULL, &out );
        Check( out.hit == true );
        Check( hitId == nearShape.index1 - 1 );
        Check( feq( out.fraction, 0.2 ) );

        // THE CATEGORY-BITS TEST. A query accepting only category 2 must find the near
        // box. This is precisely what a hardcoded proxy categoryBits of 1 would break:
        // the tree ANDs maskBits (2) against each node's category bits, so with every
        // proxy claiming category 1 the whole tree would prune away and this would MISS.
        b2QueryFilter onlyNear;  onlyNear.categoryBits = 1;  onlyNear.maskBits = 2;
        hitId = b2World_CastRayClosest( &world, &o, &tr, &onlyNear, &out );
        diagA = out.fraction;
        Check( out.hit == true );
        Check( hitId == nearShape.index1 - 1 );
        Check( feq( out.fraction, 0.2 ) );

        // Accepting only category 1 SKIPS the nearer box and finds the far one.
        b2QueryFilter onlyFar;  onlyFar.categoryBits = 1;  onlyFar.maskBits = 1;
        hitId = b2World_CastRayClosest( &world, &o, &tr, &onlyFar, &out );
        diagB = out.fraction;
        Check( out.hit == true );
        Check( hitId == farShape.index1 - 1 );                 // near box filtered out
        Check( feq( out.fraction, 0.5 ) );

        // Accepting a category nothing has -> a clean miss.
        b2QueryFilter none;  none.categoryBits = 1;  none.maskBits = 4;
        hitId = b2World_CastRayClosest( &world, &o, &tr, &none, &out );
        Check( out.hit == false );
        Check( hitId == B2_NULL_INDEX );

        // b2DefaultQueryFilter (category 1, mask all) behaves exactly like NULL.
        b2QueryFilter def;  b2DefaultQueryFilter( &def );
        hitId = b2World_CastRayClosest( &world, &o, &tr, &def, &out );
        Check( out.hit == true );
        Check( hitId == nearShape.index1 - 1 );

        b2DestroyWorld( &world );
    }

    // THE OTHER DIRECTION of the handshake: a shape can refuse a query too. This box
    // has categoryBits 1 but maskBits 2, i.e. it only answers queries in category 2.
    {
        b2World world;  b2CreateWorld( &world );
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_staticBody;
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );
        sd.filter.categoryBits = 1;
        sd.filter.maskBits = 2;                                // only sees category 2
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bb, &sd, &box, &ws );

        b2Vec2 o;  o.x = -5.0;  o.y = 0.0;
        b2Vec2 tr;  tr.x = 20.0;  tr.y = 0.0;
        b2CastOutput out;

        // query is category 1: shape.maskBits(2) & query.categoryBits(1) == 0 -> refused
        b2QueryFilter cat1;  cat1.categoryBits = 1;  cat1.maskBits = -1;
        int hitId = b2World_CastRayClosest( &world, &o, &tr, &cat1, &out );
        Check( out.hit == false );

        // query is category 2: both directions pass -> hit
        b2QueryFilter cat2;  cat2.categoryBits = 2;  cat2.maskBits = -1;
        hitId = b2World_CastRayClosest( &world, &o, &tr, &cat2, &out );
        Check( out.hit == true );
        Check( hitId == ws.index1 - 1 );

        b2DestroyWorld( &world );
    }

    // b2World_OverlapAABB honours the filter (and NULL still sees everything).
    {
        b2World world;  b2CreateWorld( &world );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );

        b2BodyDef ad;  b2DefaultBodyDef( &ad );  ad.type = b2_staticBody;
        ad.position.x = -2.0;  ad.position.y = 0.0;
        b2BodyId ba;  b2CreateBody( &world, &ad, &ba );
        b2ShapeDef asd;  b2DefaultShapeDef( &asd );  asd.filter.categoryBits = 1;
        b2ShapeId as;  b2CreatePolygonShape( &world, &ba, &asd, &box, &as );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_staticBody;
        bd.position.x = 2.0;  bd.position.y = 0.0;
        b2BodyId bb;  b2CreateBody( &world, &bd, &bb );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );  bsd.filter.categoryBits = 2;
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        b2AABB q;
        q.lowerBound.x = -5.0;  q.lowerBound.y = -5.0;
        q.upperBound.x =  5.0;  q.upperBound.y =  5.0;
        b2TreeStats st;

        g_overlapCount = 0;
        b2World_OverlapAABB( &world, &q, NULL, &OverlapCountCB, NULL, &st );
        Check( g_overlapCount == 2 );                          // NULL sees both

        b2QueryFilter only2;  only2.categoryBits = 1;  only2.maskBits = 2;
        g_overlapCount = 0;
        b2World_OverlapAABB( &world, &q, &only2, &OverlapCountCB, NULL, &st );
        Check( g_overlapCount == 1 );                          // just the category-2 box

        b2QueryFilter none;  none.categoryBits = 1;  none.maskBits = 4;
        g_overlapCount = 0;
        b2World_OverlapAABB( &world, &q, &none, &OverlapCountCB, NULL, &st );
        Check( g_overlapCount == 0 );

        b2DestroyWorld( &world );
    }

    // b2World_CastShapeClosest honours the filter: sweep past a category-2 box that
    // the filter rejects and land on the category-1 box behind it.
    {
        b2World world;  b2CreateWorld( &world );
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );

        b2BodyDef nd;  b2DefaultBodyDef( &nd );  nd.type = b2_staticBody;
        b2BodyId bn;  b2CreateBody( &world, &nd, &bn );
        b2ShapeDef nsd;  b2DefaultShapeDef( &nsd );  nsd.filter.categoryBits = 2;
        b2ShapeId nearShape;  b2CreatePolygonShape( &world, &bn, &nsd, &box, &nearShape );

        b2BodyDef fd;  b2DefaultBodyDef( &fd );  fd.type = b2_staticBody;
        fd.position.x = 6.0;  fd.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fd, &bf );
        b2ShapeDef fsd;  b2DefaultShapeDef( &fsd );  fsd.filter.categoryBits = 1;
        b2ShapeId farShape;  b2CreatePolygonShape( &world, &bf, &fsd, &box, &farShape );

        b2Vec2 centre;  centre.x = -5.0;  centre.y = 0.0;
        b2ShapeProxy proxy;  b2MakeProxy( &centre, 1, 0.0, &proxy );
        b2Vec2 tr;  tr.x = 20.0;  tr.y = 0.0;

        b2CastOutput out;
        b2QueryFilter onlyFar;  onlyFar.categoryBits = 1;  onlyFar.maskBits = 1;
        int hitShape = b2World_CastShapeClosest( &world, &proxy, &tr, &onlyFar, &out );

        diagC = out.fraction;
        Check( out.hit == true );
        Check( hitShape == farShape.index1 - 1 );              // passed through the near box
        Check( fabs( out.fraction - ( 10.0 - 0.005 ) / 20.0 ) < 0.01 );

        b2DestroyWorld( &world );
    }

    // b2World_CastMover honours the filter: a mover that ignores category-2 geometry
    // sweeps straight through the wall.
    {
        b2World world;  b2CreateWorld( &world );

        b2Polygon wall;  b2MakeBox( 0.5, 5.0, &wall );
        b2BodyDef wdef;  b2DefaultBodyDef( &wdef );  wdef.type = b2_staticBody;
        wdef.position.x = 5.0;  wdef.position.y = 0.0;
        b2BodyId bw;  b2CreateBody( &world, &wdef, &bw );
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );  wsd.filter.categoryBits = 2;
        b2ShapeId ws;  b2CreatePolygonShape( &world, &bw, &wsd, &wall, &ws );

        b2Capsule mover;
        mover.center1.x = 0.0;  mover.center1.y = -0.5;
        mover.center2.x = 0.0;  mover.center2.y =  0.5;
        mover.radius = 0.5;
        b2Vec2 tr;  tr.x = 10.0;  tr.y = 0.0;

        float blocked = b2World_CastMover( &world, &mover, &tr, NULL );
        diagD = blocked;
        Check( fabs( blocked - 0.4005 ) < 0.01 );              // NULL -> stopped by the wall

        b2QueryFilter only1;  only1.categoryBits = 1;  only1.maskBits = 1;
        float unblocked = b2World_CastMover( &world, &mover, &tr, &only1 );
        Check( feq( unblocked, 1.0 ) );                             // wall is category 2 -> ignored

        b2DestroyWorld( &world );
    }

    // b2World_CollideMover honours the filter: no planes from filtered-out geometry.
    {
        b2World world;  b2CreateWorld( &world );

        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );  gsd.filter.categoryBits = 2;
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        b2Capsule mover;
        mover.center1.x = 0.0;  mover.center1.y = 0.8;
        mover.center2.x = 0.0;  mover.center2.y = 1.8;
        mover.radius = 0.5;

        g_planeCount = 0;
        b2World_CollideMover( &world, &mover, NULL, &MoverPlaneCollect, NULL );
        Check( g_planeCount == 1 );                            // NULL -> the ground is there

        b2QueryFilter only1;  only1.categoryBits = 1;  only1.maskBits = 1;
        g_planeCount = 0;
        b2World_CollideMover( &world, &mover, &only1, &MoverPlaneCollect, NULL );
        Check( g_planeCount == 0 );                            // ground is category 2

        b2DestroyWorld( &world );
    }

    // ---- SHAPE API slice 1: pure reads + user data ----
    // Round-trip every getter against values planted in the b2ShapeDef, then prove
    // the handle validity rules, then DOGFOOD: resolve a raw begin-touch event
    // shape id back to its body + user data (the gap that made events unusable).
    {
        b2World world;  b2CreateWorld( &world );

        int   floorTag = 11;   void* pFloor = &floorTag;
        int   boxTag   = 22;   void* pBox   = &boxTag;

        // static floor: a polygon carrying non-default material + filter + userData
        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );
        gdef.type = b2_staticBody;
        gdef.userData = pFloor;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );

        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        gsd.userData = pFloor;
        gsd.density = 2.0;  gsd.friction = 0.25;  gsd.restitution = 0.5;
        gsd.filter.categoryBits = 4;  gsd.filter.maskBits = 12;  gsd.filter.groupIndex = -3;
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        Check( b2Shape_GetType( &world, &gs ) == b2_polygonShape );
        Check( feq( b2Shape_GetDensity( &world, &gs ), 2.0 ) );
        Check( feq( b2Shape_GetFriction( &world, &gs ), 0.25 ) );
        Check( feq( b2Shape_GetRestitution( &world, &gs ), 0.5 ) );

        b2Filter f;  b2Shape_GetFilter( &world, &gs, &f );
        Check( f.categoryBits == 4 );
        Check( f.maskBits == 12 );
        Check( f.groupIndex == -3 );

        Check( b2Shape_IsSensor( &world, &gs ) == false );
        Check( b2Shape_AreSensorEventsEnabled( &world, &gs ) == true );   // def default
        Check( b2Shape_AreHitEventsEnabled( &world, &gs ) == false );

        // the field that was silently dropped before this slice
        Check( b2Shape_GetUserData( &world, &gs ) == pFloor );

        // shape -> body -> body user data
        b2BodyId owner;  b2Shape_GetBody( &world, &gs, &owner );
        Check( b2Body_IsValid( &world, &owner ) );
        Check( b2Body_GetUserData( &world, &owner ) == pFloor );

        // AABB of a 20 x 1 box at the origin. Upstream semantics: the tight box
        // padded by B2_SPECULATIVE_DISTANCE (0.02) on each side.
        b2AABB gab;  b2Shape_GetAABB( &world, &gs, &gab );
        Check( feq( gab.lowerBound.x, -10.02 ) );
        Check( feq( gab.lowerBound.y,  -0.52 ) );
        Check( feq( gab.upperBound.x,  10.02 ) );
        Check( feq( gab.upperBound.y,   0.52 ) );

        b2Vec2 pIn;   pIn.x = 0.0;   pIn.y = 0.0;
        b2Vec2 pOut;  pOut.x = 0.0;  pOut.y = 5.0;
        Check( b2Shape_TestPoint( &world, &gs, &pIn ) == true );
        Check( b2Shape_TestPoint( &world, &gs, &pOut ) == false );

        b2Polygon gpoly;  b2Shape_GetPolygon( &world, &gs, &gpoly );
        Check( gpoly.count == 4 );

        // dynamic circle at (0,5), r = 0.5 -- geometry getter + transformed AABB
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );
        cdef.type = b2_dynamicBody;
        cdef.position.x = 0.0;  cdef.position.y = 5.0;
        b2BodyId bc;  b2CreateBody( &world, &cdef, &bc );

        b2Circle circ;  circ.center.x = 0.0;  circ.center.y = 0.0;  circ.radius = 0.5;
        b2ShapeDef csd;  b2DefaultShapeDef( &csd );
        csd.isSensor = true;
        csd.enableHitEvents = true;
        csd.enableSensorEvents = false;
        b2ShapeId cs;  b2CreateCircleShape( &world, &bc, &csd, &circ, &cs );

        Check( b2Shape_GetType( &world, &cs ) == b2_circleShape );
        Check( b2Shape_IsSensor( &world, &cs ) == true );
        Check( b2Shape_AreHitEventsEnabled( &world, &cs ) == true );
        Check( b2Shape_AreSensorEventsEnabled( &world, &cs ) == false );
        Check( b2Shape_GetUserData( &world, &cs ) == NULL );          // def default

        b2Circle gotc;  b2Shape_GetCircle( &world, &cs, &gotc );
        Check( feq( gotc.radius, 0.5 ) );

        b2AABB cab;  b2Shape_GetAABB( &world, &cs, &cab );            // AABB follows the body
        Check( feq( cab.lowerBound.y, 4.48 ) );
        Check( feq( cab.upperBound.y, 5.52 ) );

        // SetUserData round-trip on a shape created without one
        b2Shape_SetUserData( &world, &cs, pBox );
        Check( b2Shape_GetUserData( &world, &cs ) == pBox );

        // -- handle validity rules --
        Check( b2Shape_IsValid( &world, &cs ) == true );

        b2ShapeId badGen = cs;   badGen.generation = cs.generation + 1;
        Check( b2Shape_IsValid( &world, &badGen ) == false );         // slot reused

        b2ShapeId badWorld = cs; badWorld.world0 = cs.world0 + 1;
        Check( b2Shape_IsValid( &world, &badWorld ) == false );       // wrong world

        b2ShapeId zeroed = cs;   zeroed.index1 = 0;
        Check( b2Shape_IsValid( &world, &zeroed ) == false );         // bounds before deref

        b2DestroyShape( &world, &cs, true );
        Check( b2Shape_IsValid( &world, &cs ) == false );             // freed slot
        Check( b2Shape_IsValid( &world, &gs ) == true );              // sibling untouched

        b2DestroyWorld( &world );
    }

    // DOGFOOD: a raw begin-touch event shape id is now resolvable to a body + tag.
    // Before this slice a game could see THAT something landed but not WHAT.
    {
        b2World world;  b2CreateWorld( &world );

        int   floorTag = 11;   void* pFloor = &floorTag;
        int   boxTag   = 22;   void* pBox   = &boxTag;

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );
        gdef.type = b2_staticBody;
        gdef.userData = pFloor;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );  gsd.userData = pFloor;
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 2.0;
        bdef.userData = pBox;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );  bsd.userData = pBox;
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        // step until the box lands and reports its begin-touch event
        int  i;
        bool resolved = false;
        for( i = 0; i < 120; ++i )
        {
            b2World_Step( &world, 0.01666666, 4 );

            if( b2World_GetBeginTouchEventCount( &world ) == 1 )
            {
                b2TouchEvent* ev = b2World_GetBeginTouchEvents( &world );

                // the event carries RAW int shape ids -- mint handles, then resolve
                b2ShapeId sidA;  b2MakeShapeId( &world, ev->shapeIdA, &sidA );
                b2ShapeId sidB;  b2MakeShapeId( &world, ev->shapeIdB, &sidB );
                Check( b2Shape_IsValid( &world, &sidA ) );
                Check( b2Shape_IsValid( &world, &sidB ) );

                void* uA = b2Shape_GetUserData( &world, &sidA );
                void* uB = b2Shape_GetUserData( &world, &sidB );

                // one participant is the floor, the other the box (order is the
                // narrow phase's primary order -- assert the SET, not the slots)
                bool tagged = false;
                if( uA == pFloor && uB == pBox )  tagged = true;
                if( uA == pBox && uB == pFloor )  tagged = true;
                Check( tagged );

                // and each shape resolves to the body that owns it: this world tags
                // body and shape with the SAME pointer, so the tags must agree
                b2BodyId ownA;  b2Shape_GetBody( &world, &sidA, &ownA );
                b2BodyId ownB;  b2Shape_GetBody( &world, &sidB, &ownB );
                Check( b2Body_GetUserData( &world, &ownA ) == uA );
                Check( b2Body_GetUserData( &world, &ownB ) == uB );
                Check( ownA.index1 != ownB.index1 );   // two distinct bodies

                resolved = true;
                i = 120;
            }
        }
        Check( resolved );

        b2DestroyWorld( &world );
    }

    // ---- SHAPE API slice 2: setters with side effects ----
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );        // 1 x 1 -> area 1
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        // material setters are plain field writes (re-mixed per step by b2UpdateContact)
        b2Shape_SetFriction( &world, &bs, 0.125 );
        b2Shape_SetRestitution( &world, &bs, 0.75 );
        Check( feq( b2Shape_GetFriction( &world, &bs ), 0.125 ) );
        Check( feq( b2Shape_GetRestitution( &world, &bs ), 0.75 ) );

        // density change with updateBodyMass -> the body's mass follows (area 1)
        Check( feq( b2Body_GetMass( &world, &bb ), 1.0 ) );
        b2Shape_SetDensity( &world, &bs, 3.0, true );
        Check( feq( b2Shape_GetDensity( &world, &bs ), 3.0 ) );
        Check( feq( b2Body_GetMass( &world, &bb ), 3.0 ) );

        // ...and NOT when updateBodyMass is false
        b2Shape_SetDensity( &world, &bs, 5.0, false );
        Check( feq( b2Body_GetMass( &world, &bb ), 3.0 ) );
        b2Body_ApplyMassFromShapes( &world, &bb );            // explicit recompute
        Check( feq( b2Body_GetMass( &world, &bb ), 5.0 ) );

        // event opt-ins
        b2Shape_EnableHitEvents( &world, &bs, true );
        Check( b2Shape_AreHitEventsEnabled( &world, &bs ) == true );
        b2Shape_EnableSensorEvents( &world, &bs, false );
        Check( b2Shape_AreSensorEventsEnabled( &world, &bs ) == false );
        b2Shape_EnableContactEvents( &world, &bs, false );
        b2Shape_EnableContactEvents( &world, &bs, true );

        // geometry swap: polygon -> circle changes the TYPE and the cached AABB
        b2Circle nc;  nc.center.x = 0.0;  nc.center.y = 0.0;  nc.radius = 2.0;
        b2Shape_SetCircle( &world, &bs, &nc );
        diagD = b2ValidateWorld( &world );                    // b2ResetProxy destroys contacts
        Check( b2ValidateWorld( &world ) == 0 );
        Check( b2Shape_GetType( &world, &bs ) == b2_circleShape );
        b2Circle gotc;  b2Shape_GetCircle( &world, &bs, &gotc );
        Check( feq( gotc.radius, 2.0 ) );

        b2AABB ab;  b2Shape_GetAABB( &world, &bs, &ab );      // r=2 + 0.02 speculative
        Check( feq( ab.lowerBound.x, -2.02 ) );
        Check( feq( ab.upperBound.y,  2.02 ) );

        // geometry swap leaves mass alone until asked (upstream contract)
        Check( feq( b2Body_GetMass( &world, &bb ), 5.0 ) );

        b2DestroyWorld( &world );
    }

    // b2Shape_SetFilter destroys the contacts it invalidates: a resting box whose
    // filter stops matching the floor must fall THROUGH it.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 2.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        int k;
        for( k = 0; k < 120; ++k )  b2World_Step( &world, 0.01666666, 4 );

        b2Vec2 rest;  b2Body_GetPosition( &world, &bb, &rest );
        diagA = rest.y;
        Check( rest.y > 0.9 );                                // settled on the floor (~1.0)

        // category 2 / mask 2 vs the floor's category 1 -> no longer collide
        b2Filter nf;  nf.categoryBits = 2;  nf.maskBits = 2;  nf.groupIndex = 0;
        b2Shape_SetFilter( &world, &bs, &nf );

        // b2ResetProxy just destroyed a contact (swap-remove + localIndex repair) and
        // rebuilt a proxy. A position check alone would not catch a mis-repaired
        // index -- that surfaces as an out-of-bounds freeze, not a red.
        diagD = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 0 );

        b2Filter got;  b2Shape_GetFilter( &world, &bs, &got );
        Check( got.categoryBits == 2 );
        Check( got.maskBits == 2 );

        for( k = 0; k < 60; ++k )  b2World_Step( &world, 0.01666666, 4 );
        Check( b2ValidateWorld( &world ) == 0 );

        b2Vec2 after;  b2Body_GetPosition( &world, &bb, &after );
        diagB = after.y;
        Check( after.y < -0.5 );                              // fell through the floor

        b2DestroyWorld( &world );
    }

    // ---- BODY API breadth: field reads/writes that don't move solver sets ----
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.x = 3.0;  bdef.position.y = 4.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        Check( b2Body_GetType( &world, &bb ) == b2_dynamicBody );
        Check( b2Body_IsEnabled( &world, &bb ) == true );

        // -- mass data round-trip --
        b2MassData md;  b2Body_GetMassData( &world, &bb, &md );
        Check( feq( md.mass, 1.0 ) );

        b2MassData set;  set.mass = 5.0;  set.center.x = 0.0;  set.center.y = 0.0;
        set.rotationalInertia = 3.0;
        b2Body_SetMassData( &world, &bb, &set );
        Check( feq( b2Body_GetMass( &world, &bb ), 5.0 ) );
        Check( feq( b2Body_GetRotationalInertia( &world, &bb ), 3.0 ) );

        b2Body_ApplyMassFromShapes( &world, &bb );
        Check( feq( b2Body_GetMass( &world, &bb ), 1.0 ) );   // back to the shape-derived mass

        b2Vec2 lc;  b2Body_GetLocalCenter( &world, &bb, &lc );
        Check( feq( lc.x, 0.0 ) && feq( lc.y, 0.0 ) );

        // -- damping / gravity scale round-trips --
        b2Body_SetLinearDamping( &world, &bb, 0.25 );
        Check( feq( b2Body_GetLinearDamping( &world, &bb ), 0.25 ) );
        b2Body_SetAngularDamping( &world, &bb, 0.5 );
        Check( feq( b2Body_GetAngularDamping( &world, &bb ), 0.5 ) );
        b2Body_SetGravityScale( &world, &bb, 2.0 );
        Check( feq( b2Body_GetGravityScale( &world, &bb ), 2.0 ) );

        // -- flag round-trips (each must reach bodySim->flags AND the state mirror) --
        Check( b2Body_IsBullet( &world, &bb ) == false );
        b2Body_SetBullet( &world, &bb, true );
        Check( b2Body_IsBullet( &world, &bb ) == true );
        b2Body_SetBullet( &world, &bb, false );
        Check( b2Body_IsBullet( &world, &bb ) == false );

        b2Body_SetSleepThreshold( &world, &bb, 0.75 );
        Check( feq( b2Body_GetSleepThreshold( &world, &bb ), 0.75 ) );

        b2Body_EnableSleep( &world, &bb, false );             // wakes the body (b2WakeBody)
        Check( b2ValidateWorld( &world ) == 0 );
        Check( b2Body_IsSleepEnabled( &world, &bb ) == false );
        b2Body_EnableSleep( &world, &bb, true );
        Check( b2Body_IsSleepEnabled( &world, &bb ) == true );

        b2Body_EnableContactRecycling( &world, &bb, true );
        Check( b2Body_IsContactRecyclingEnabled( &world, &bb ) == true );

        bool lx;  bool ly;  bool az;
        b2Body_GetMotionLocks( &world, &bb, &lx, &ly, &az );
        Check( lx == false && ly == false && az == false );

        // -- frame conversions (identity rotation: world = origin + local) --
        b2Vec2 lp;  lp.x = 1.0;  lp.y = 0.0;
        b2Vec2 wp;  b2Body_GetWorldPoint( &world, &bb, &lp, &wp );
        Check( feq( wp.x, 4.0 ) && feq( wp.y, 4.0 ) );

        b2Vec2 wv;  b2Body_GetWorldVector( &world, &bb, &lp, &wv );
        Check( feq( wv.x, 1.0 ) && feq( wv.y, 0.0 ) );        // vectors ignore translation

        b2Vec2 back;  b2Body_GetLocalVector( &world, &bb, &wv, &back );
        Check( feq( back.x, 1.0 ) && feq( back.y, 0.0 ) );

        // -- point velocity: v + w x r, with r measured from the center of mass --
        b2Vec2 lv;  lv.x = 1.0;  lv.y = 0.0;
        b2Body_SetLinearVelocity( &world, &bb, &lv );
        b2Body_SetAngularVelocity( &world, &bb, 2.0 );

        b2Vec2 above;  above.x = 3.0;  above.y = 5.0;         // center is (3,4) -> r = (0,1)
        b2Vec2 pv;  b2Body_GetWorldPointVelocity( &world, &bb, &above, &pv );
        Check( feq( pv.x, -1.0 ) );                           // 1 + 2*(-1) = -1
        Check( feq( pv.y,  0.0 ) );

        b2Vec2 lpt;  lpt.x = 0.0;  lpt.y = 1.0;
        b2Vec2 lpv;  b2Body_GetLocalPointVelocity( &world, &bb, &lpt, &lpv );
        Check( feq( lpv.x, -1.0 ) );                          // same point, local frame
        Check( feq( lpv.y,  0.0 ) );

        // -- enumeration --
        Check( b2Body_GetShapeCount( &world, &bb ) == 1 );
        int[4] shapeBuf;
        Check( b2Body_GetShapes( &world, &bb, shapeBuf, 4 ) == 1 );
        b2ShapeId round;  b2MakeShapeId( &world, shapeBuf[0], &round );
        Check( b2Shape_IsValid( &world, &round ) );
        Check( round.index1 == bs.index1 );                   // it is the shape we made

        Check( b2Body_GetJointCount( &world, &bb ) == 0 );
        Check( b2Body_GetContactCapacity( &world, &bb ) == 0 );

        // -- ComputeAABB: union of the shapes' cached (padded) boxes --
        b2AABB bab;  b2Body_ComputeAABB( &world, &bb, &bab );
        Check( feq( bab.lowerBound.x, 2.48 ) );               // 3 - 0.5 - 0.02
        Check( feq( bab.upperBound.y, 4.52 ) );               // 4 + 0.5 + 0.02

        // -- ClearForces --
        b2Vec2 force;  force.x = 10.0;  force.y = 0.0;
        b2Body_ApplyForceToCenter( &world, &bb, &force, true );
        b2Body_ClearForces( &world, &bb );
        b2Body_SetLinearVelocity( &world, &bb, &b2Vec2_zero );
        b2Body_SetAngularVelocity( &world, &bb, 0.0 );
        b2Body_SetGravityScale( &world, &bb, 0.0 );           // isolate the force
        b2World_Step( &world, 0.01666666, 4 );
        b2Vec2 v;  b2Body_GetLinearVelocity( &world, &bb, &v );
        Check( feq( v.x, 0.0 ) );                             // cleared force did nothing

        b2DestroyWorld( &world );
    }

    // Motion locks and gravityScale are enforced by the solver, not just stored.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.y = 10.0;
        b2BodyId lockedBody;  b2CreateBody( &world, &bdef, &lockedBody );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId ls;  b2CreatePolygonShape( &world, &lockedBody, &bsd, &box, &ls );

        bdef.position.x = 5.0;                                // keep the two boxes apart
        b2BodyId freeBody;  b2CreateBody( &world, &bdef, &freeBody );
        b2ShapeId fs;  b2CreatePolygonShape( &world, &freeBody, &bsd, &box, &fs );

        b2Body_SetMotionLocks( &world, &lockedBody, false, true, false );   // lock Y
        bool lx;  bool ly;  bool az;
        b2Body_GetMotionLocks( &world, &lockedBody, &lx, &ly, &az );
        Check( lx == false && ly == true && az == false );

        b2Body_SetGravityScale( &world, &freeBody, 0.0 );     // free body ignores gravity

        int k;
        for( k = 0; k < 60; ++k )  b2World_Step( &world, 0.01666666, 4 );

        b2Vec2 lp;  b2Body_GetPosition( &world, &lockedBody, &lp );
        b2Vec2 fp;  b2Body_GetPosition( &world, &freeBody, &fp );
        Check( feq( lp.y, 10.0 ) );                           // Y locked -> never fell
        Check( feq( fp.y, 10.0 ) );                           // gravityScale 0 -> never fell

        b2DestroyWorld( &world );
    }

    // b2Body_EnableContactEvents(false) silences begin/end touch events for the body.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.y = 2.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        b2Body_EnableContactEvents( &world, &bb, false );     // one side opting out is enough

        int k;
        int beginTotal = 0;
        for( k = 0; k < 120; ++k )
        {
            b2World_Step( &world, 0.01666666, 4 );
            beginTotal = beginTotal + b2World_GetBeginTouchEventCount( &world );
        }
        diagC = beginTotal;
        Check( beginTotal == 0 );                             // landed, but silently

        b2Vec2 rest;  b2Body_GetPosition( &world, &bb, &rest );
        Check( rest.y > 0.9 );                                // it really did land

        b2DestroyWorld( &world );
    }

    // ---- WORLD API: tuning get/set ----
    {
        b2World world;  b2CreateWorld( &world );

        b2Vec2 g;  b2World_GetGravity( &world, &g );
        Check( feq( g.x, 0.0 ) && feq( g.y, -10.0 ) );        // b2CreateWorld default

        b2Vec2 zero;  zero.x = 0.0;  zero.y = 0.0;
        b2World_SetGravity( &world, &zero );
        b2World_GetGravity( &world, &g );
        Check( feq( g.y, 0.0 ) );

        b2World_SetRestitutionThreshold( &world, 2.5 );
        Check( feq( b2World_GetRestitutionThreshold( &world ), 2.5 ) );
        b2World_SetHitEventThreshold( &world, 4.0 );
        Check( feq( b2World_GetHitEventThreshold( &world ), 4.0 ) );
        b2World_SetMaximumLinearSpeed( &world, 123.0 );
        Check( feq( b2World_GetMaximumLinearSpeed( &world ), 123.0 ) );

        Check( b2World_IsWarmStartingEnabled( &world ) == true );   // default ON
        b2World_EnableWarmStarting( &world, false );
        Check( b2World_IsWarmStartingEnabled( &world ) == false );
        b2World_EnableWarmStarting( &world, true );

        Check( b2World_IsContinuousEnabled( &world ) == false );    // port default OFF
        b2World_EnableContinuous( &world, true );
        Check( b2World_IsContinuousEnabled( &world ) == true );
        b2World_EnableContinuous( &world, false );

        b2World_SetContactTuning( &world, 45.0, 5.0, 6.0 );
        Check( feq( world.contactHertz, 45.0 ) );
        Check( feq( world.contactDampingRatio, 5.0 ) );
        Check( feq( world.contactSpeed, 6.0 ) );

        int tag = 7;  void* pTag = &tag;
        Check( b2World_GetUserData( &world ) == NULL );
        b2World_SetUserData( &world, pTag );
        Check( b2World_GetUserData( &world ) == pTag );

        // gravity really is zero now: a free body must not fall
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.y = 5.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        Check( b2World_GetAwakeBodyCount( &world ) == 1 );

        int k;
        for( k = 0; k < 60; ++k )  b2World_Step( &world, 0.01666666, 4 );
        b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
        Check( feq( p.y, 5.0 ) );

        b2DestroyWorld( &world );
    }

    // b2World_EnableSleeping(false) must WAKE bodies that are already asleep,
    // and b2Body_SetAwake(false) must be able to put an island down on demand.
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.y = 1.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        int k;
        for( k = 0; k < 240; ++k )  b2World_Step( &world, 0.01666666, 4 );
        Check( b2Body_IsAwake( &world, &bb ) == false );      // settled and slept
        Check( b2World_GetAwakeBodyCount( &world ) == 0 );

        // Each transition below moves sims between solver sets. Validate the
        // setIndex/localIndex <-> dense-position invariant after every one: a bad
        // repair would freeze the console some steps later, not turn the screen red.
        b2World_EnableSleeping( &world, false );              // must wake the sleeper
        diagD = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 0 );
        Check( b2World_IsSleepingEnabled( &world ) == false );
        Check( b2Body_IsAwake( &world, &bb ) == true );

        // ...and it stays awake now that sleep is off
        for( k = 0; k < 240; ++k )  b2World_Step( &world, 0.01666666, 4 );
        Check( b2Body_IsAwake( &world, &bb ) == true );

        // re-enable, settle, then force it down with b2Body_SetAwake(false)
        b2World_EnableSleeping( &world, true );
        b2Body_SetAwake( &world, &bb, false );
        diagD = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 0 );
        Check( b2Body_IsAwake( &world, &bb ) == false );

        b2Body_SetAwake( &world, &bb, true );                 // and back up
        diagD = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 0 );
        Check( b2Body_IsAwake( &world, &bb ) == true );

        for( k = 0; k < 60; ++k )  b2World_Step( &world, 0.01666666, 4 );
        Check( b2ValidateWorld( &world ) == 0 );              // still coherent after stepping

        b2DestroyWorld( &world );
    }

    // ---- BODY SET-TRANSFER API: SetType / Disable / Enable ----
    // Every transition below moves sims between solver sets. b2ValidateWorld after
    // each one: a mis-repaired localIndex faults the console rather than reddening it.

    // static -> dynamic: the body must start falling AND land (its proxy has to move
    // from the static tree to the dynamic tree, or it will never pair with the floor).
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        b2BodyDef sdef;  b2DefaultBodyDef( &sdef );  sdef.type = b2_staticBody;
        sdef.position.y = 5.0;
        b2BodyId bb;  b2CreateBody( &world, &sdef, &bb );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        Check( b2Body_GetType( &world, &bb ) == b2_staticBody );
        Check( feq( b2Body_GetMass( &world, &bb ), 0.0 ) );   // static bodies have no mass

        int k;
        for( k = 0; k < 30; ++k )  b2World_Step( &world, 0.01666666, 4 );
        b2Vec2 p;  b2Body_GetPosition( &world, &bb, &p );
        Check( feq( p.y, 5.0 ) );                             // static -> hangs in the air

        b2Body_SetType( &world, &bb, b2_dynamicBody );
        diagD = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 0 );
        Check( b2Body_GetType( &world, &bb ) == b2_dynamicBody );
        Check( feq( b2Body_GetMass( &world, &bb ), 1.0 ) );   // mass recomputed from shapes
        Check( b2World_GetAwakeBodyCount( &world ) == 1 );

        for( k = 0; k < 180; ++k )  b2World_Step( &world, 0.01666666, 4 );
        Check( b2ValidateWorld( &world ) == 0 );

        b2Body_GetPosition( &world, &bb, &p );
        diagA = p.y;
        Check( p.y > 0.9 && p.y < 1.1 );                      // fell and landed on the floor

        b2DestroyWorld( &world );
    }

    // dynamic -> static freezes a body mid-flight; dynamic -> kinematic ignores gravity
    // but still honours a velocity.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.y = 20.0;
        b2BodyId frozen;  b2CreateBody( &world, &bdef, &frozen );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId fs;  b2CreatePolygonShape( &world, &frozen, &bsd, &box, &fs );

        bdef.position.x = 10.0;
        b2BodyId kin;  b2CreateBody( &world, &bdef, &kin );
        b2ShapeId ks;  b2CreatePolygonShape( &world, &kin, &bsd, &box, &ks );

        int k;
        for( k = 0; k < 30; ++k )  b2World_Step( &world, 0.01666666, 4 );

        b2Vec2 mid;  b2Body_GetPosition( &world, &frozen, &mid );
        Check( mid.y < 19.9 );                                // it was falling

        b2Body_SetType( &world, &frozen, b2_staticBody );
        diagD = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 0 );
        Check( b2Body_GetType( &world, &frozen ) == b2_staticBody );

        b2Body_SetType( &world, &kin, b2_kinematicBody );
        Check( b2ValidateWorld( &world ) == 0 );
        b2Vec2 kv;  kv.x = 2.0;  kv.y = 0.0;
        b2Body_SetLinearVelocity( &world, &kin, &kv );

        b2Vec2 kStart;  b2Body_GetPosition( &world, &kin, &kStart );

        for( k = 0; k < 60; ++k )  b2World_Step( &world, 0.01666666, 4 );
        Check( b2ValidateWorld( &world ) == 0 );

        b2Vec2 after;  b2Body_GetPosition( &world, &frozen, &after );
        Check( feq( after.y, mid.y ) );                       // static -> frozen exactly

        b2Vec2 kEnd;  b2Body_GetPosition( &world, &kin, &kEnd );
        diagB = kEnd.x - kStart.x;
        Check( kEnd.x - kStart.x > 1.8 );                     // kinematic drove ~2 m in 1 s
        Check( feq( kEnd.y, kStart.y ) );                     // ...and ignored gravity

        b2DestroyWorld( &world );
    }

    // Disable removes a body from simulation (no proxies, no contacts); Enable puts it
    // back and MUST force pair creation, or the re-enabled box falls through the floor.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.y = 2.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        int k;
        for( k = 0; k < 120; ++k )  b2World_Step( &world, 0.01666666, 4 );
        b2Vec2 rest;  b2Body_GetPosition( &world, &bb, &rest );
        Check( rest.y > 0.9 );                                // settled
        Check( b2Body_GetContactCapacity( &world, &bb ) > 0 );

        b2Body_Disable( &world, &bb );
        diagD = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 0 );
        Check( b2Body_IsEnabled( &world, &bb ) == false );
        Check( b2Body_GetContactCapacity( &world, &bb ) == 0 );   // contacts destroyed
        Check( b2World_GetAwakeBodyCount( &world ) == 0 );        // no longer simulated

        for( k = 0; k < 60; ++k )  b2World_Step( &world, 0.01666666, 4 );
        b2Vec2 held;  b2Body_GetPosition( &world, &bb, &held );
        Check( feq( held.y, rest.y ) );                       // disabled -> never integrated

        b2Body_Enable( &world, &bb );
        diagD = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 0 );
        Check( b2Body_IsEnabled( &world, &bb ) == true );
        Check( b2World_GetAwakeBodyCount( &world ) == 1 );

        for( k = 0; k < 120; ++k )  b2World_Step( &world, 0.01666666, 4 );
        Check( b2ValidateWorld( &world ) == 0 );

        b2Vec2 again;  b2Body_GetPosition( &world, &bb, &again );
        diagC = again.y;
        Check( again.y > 0.9 );                               // still on the floor, not through it
        Check( b2Body_GetContactCapacity( &world, &bb ) > 0 );    // re-paired (forced move buffer)

        // enabling twice is a no-op, not a corruption
        b2Body_Enable( &world, &bb );
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // A joint survives disable/enable of one endpoint: it parks in the disabled set
    // and comes back linked, holding its length again.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.y = 7.0;
        b2BodyId bob;  b2CreateBody( &world, &bdef, &bob );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bob, &bsd, &box, &bs );

        b2DistanceJointDef jd;  b2DefaultDistanceJointDef( &jd );
        jd.bodyIdA = anchor;  jd.bodyIdB = bob;  jd.length = 3.0;
        b2JointId jh;  b2CreateDistanceJointDef( &world, &jd, &jh );

        int k;
        for( k = 0; k < 120; ++k )  b2World_Step( &world, 0.01666666, 4 );
        b2Vec2 hang;  b2Body_GetPosition( &world, &bob, &hang );
        Check( feq( hang.y, 7.0 ) );                          // hanging 3 m below the anchor
        Check( b2Body_GetJointCount( &world, &bob ) == 1 );

        b2Body_Disable( &world, &bob );                       // joint parks in the disabled set
        diagD = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 0 );
        Check( b2Body_IsEnabled( &world, &bob ) == false );

        for( k = 0; k < 60; ++k )  b2World_Step( &world, 0.01666666, 4 );
        Check( b2ValidateWorld( &world ) == 0 );              // solver must not touch it

        b2Body_Enable( &world, &bob );
        diagD = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 0 );

        for( k = 0; k < 120; ++k )  b2World_Step( &world, 0.01666666, 4 );
        Check( b2ValidateWorld( &world ) == 0 );

        b2Vec2 again;  b2Body_GetPosition( &world, &bob, &again );
        diagA = again.y;
        Check( feq( again.y, 7.0 ) );                         // joint re-linked and still holds

        b2DestroyJoint( &world, &jh );
        Check( b2ValidateWorld( &world ) == 0 );
        b2DestroyWorld( &world );
    }

    // Disabling a CONTACTLESS sleeper must reclaim its (now empty) sleeping solver set,
    // or the set id leaks and b2ValidateWorld's pool-vs-array count check reds.
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        // a body far from everything, with gravity off: it sleeps without ever touching
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.x = 50.0;  bdef.position.y = 50.0;
        bdef.gravityScale = 0.0;
        b2BodyId lonely;  b2CreateBody( &world, &bdef, &lonely );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId ls;  b2CreatePolygonShape( &world, &lonely, &bsd, &box, &ls );

        int k;
        for( k = 0; k < 120; ++k )  b2World_Step( &world, 0.01666666, 4 );
        Check( b2Body_IsAwake( &world, &lonely ) == false );  // slept, zero contacts
        Check( b2Body_GetContactCapacity( &world, &lonely ) == 0 );

        b2Body_Disable( &world, &lonely );
        diagD = b2ValidateWorld( &world );
        Check( b2ValidateWorld( &world ) == 0 );              // sleeping set reclaimed
        Check( b2Body_IsEnabled( &world, &lonely ) == false );

        b2Body_Enable( &world, &lonely );
        Check( b2ValidateWorld( &world ) == 0 );
        Check( b2Body_IsAwake( &world, &lonely ) == true );   // comes back awake

        for( k = 0; k < 120; ++k )  b2World_Step( &world, 0.01666666, 4 );
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // ---- JOINT ACCESSORS (API batch 3): getters + base b2Joint_* ----
    // Pure field reads: create a joint with known def values / set via the existing
    // setters, then read them straight back. No stepping needed.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.userData = &world;                               // any non-NULL tag
        b2BodyId ba;  b2CreateBody( &world, &adef, &ba );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.y = -3.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        // -- distance: def in, getters out --
        b2DistanceJointDef dd;  b2DefaultDistanceJointDef( &dd );
        dd.bodyIdA = ba;  dd.bodyIdB = bb;  dd.length = 3.0;
        dd.minLength = 1.0;  dd.maxLength = 5.0;
        dd.enableSpring = true;  dd.hertz = 4.0;  dd.dampingRatio = 0.5;
        dd.enableLimit = true;
        b2JointId dj;  b2CreateDistanceJointDef( &world, &dd, &dj );
        // the distance def carries no motor fields -> set them via the setters
        b2DistanceJoint_EnableMotor( &world, &dj, true );
        b2DistanceJoint_SetMotorSpeed( &world, &dj, 2.0 );
        b2DistanceJoint_SetMaxMotorForce( &world, &dj, 20.0 );

        Check( feq( b2DistanceJoint_GetMinLength( &world, &dj ), 1.0 ) );
        Check( feq( b2DistanceJoint_GetMaxLength( &world, &dj ), 5.0 ) );
        Check( b2DistanceJoint_IsSpringEnabled( &world, &dj ) == true );
        Check( feq( b2DistanceJoint_GetSpringHertz( &world, &dj ), 4.0 ) );
        Check( feq( b2DistanceJoint_GetSpringDampingRatio( &world, &dj ), 0.5 ) );
        Check( b2DistanceJoint_IsLimitEnabled( &world, &dj ) == true );
        Check( b2DistanceJoint_IsMotorEnabled( &world, &dj ) == true );
        Check( feq( b2DistanceJoint_GetMotorSpeed( &world, &dj ), 2.0 ) );
        Check( feq( b2DistanceJoint_GetMaxMotorForce( &world, &dj ), 20.0 ) );
        Check( feq( b2DistanceJoint_GetLength( &world, &dj ), 3.0 ) );   // pre-existing getter

        // spring-force range via the new set/get pair (unordered args -> canonicalized)
        b2DistanceJoint_SetSpringForceRange( &world, &dj, 8.0, -8.0 );
        float lo;  float hi;
        b2DistanceJoint_GetSpringForceRange( &world, &dj, &lo, &hi );
        Check( feq( lo, -8.0 ) && feq( hi, 8.0 ) );

        // -- base b2Joint_* accessors on the distance joint --
        Check( b2Joint_GetType( &world, &dj ) == b2_distanceJoint );

        b2BodyId gotA;  b2Joint_GetBodyA( &world, &dj, &gotA );
        b2BodyId gotB;  b2Joint_GetBodyB( &world, &dj, &gotB );
        Check( gotA.index1 == ba.index1 );
        Check( gotB.index1 == bb.index1 );

        // constraint tuning / thresholds round-trip
        b2Joint_SetConstraintTuning( &world, &dj, 55.0, 3.0 );
        float ch;  float cd;
        b2Joint_GetConstraintTuning( &world, &dj, &ch, &cd );
        Check( feq( ch, 55.0 ) && feq( cd, 3.0 ) );

        b2Joint_SetForceThreshold( &world, &dj, 100.0 );
        Check( feq( b2Joint_GetForceThreshold( &world, &dj ), 100.0 ) );
        b2Joint_SetTorqueThreshold( &world, &dj, 200.0 );
        Check( feq( b2Joint_GetTorqueThreshold( &world, &dj ), 200.0 ) );

        int tag = 9;  void* pTag = &tag;
        Check( b2Joint_GetUserData( &world, &dj ) == NULL );
        b2Joint_SetUserData( &world, &dj, pTag );
        Check( b2Joint_GetUserData( &world, &dj ) == pTag );

        // local frame set/get round-trip
        b2Transform lf;  lf.p.x = 1.0;  lf.p.y = 2.0;  lf.q = b2Rot_identity;
        b2Joint_SetLocalFrameA( &world, &dj, &lf );
        b2Transform gf;  b2Joint_GetLocalFrameA( &world, &dj, &gf );
        Check( feq( gf.p.x, 1.0 ) && feq( gf.p.y, 2.0 ) );

        b2DestroyWorld( &world );
    }

    // -- revolute / prismatic / wheel / weld / motor getters (set via setters) --
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        b2BodyId ba;  b2CreateBody( &world, &adef, &ba );
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 1.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        // revolute
        b2RevoluteJointDef rd;  b2DefaultRevoluteJointDef( &rd );
        rd.bodyIdA = ba;  rd.bodyIdB = bb;
        b2JointId rj;  b2CreateRevoluteJointDef( &world, &rd, &rj );

        b2RevoluteJoint_EnableSpring( &world, &rj, true );
        b2RevoluteJoint_SetSpringHertz( &world, &rj, 3.0 );
        b2RevoluteJoint_SetSpringDampingRatio( &world, &rj, 0.7 );
        b2RevoluteJoint_SetTargetAngle( &world, &rj, 0.5 );
        b2RevoluteJoint_EnableMotor( &world, &rj, true );
        b2RevoluteJoint_SetMotorSpeed( &world, &rj, 1.5 );
        b2RevoluteJoint_SetMaxMotorTorque( &world, &rj, 12.0 );
        b2RevoluteJoint_EnableLimit( &world, &rj, true );
        b2RevoluteJoint_SetLimits( &world, &rj, -0.3, 0.9 );

        Check( b2RevoluteJoint_IsSpringEnabled( &world, &rj ) == true );
        Check( feq( b2RevoluteJoint_GetSpringHertz( &world, &rj ), 3.0 ) );
        Check( feq( b2RevoluteJoint_GetSpringDampingRatio( &world, &rj ), 0.7 ) );
        Check( feq( b2RevoluteJoint_GetTargetAngle( &world, &rj ), 0.5 ) );
        Check( b2RevoluteJoint_IsMotorEnabled( &world, &rj ) == true );
        Check( feq( b2RevoluteJoint_GetMotorSpeed( &world, &rj ), 1.5 ) );
        Check( feq( b2RevoluteJoint_GetMaxMotorTorque( &world, &rj ), 12.0 ) );
        Check( b2RevoluteJoint_IsLimitEnabled( &world, &rj ) == true );
        Check( feq( b2RevoluteJoint_GetLowerLimit( &world, &rj ), -0.3 ) );
        Check( feq( b2RevoluteJoint_GetUpperLimit( &world, &rj ), 0.9 ) );
        b2DestroyJoint( &world, &rj );

        // prismatic
        b2PrismaticJointDef pd;  b2DefaultPrismaticJointDef( &pd );
        pd.bodyIdA = ba;  pd.bodyIdB = bb;
        b2JointId pj;  b2CreatePrismaticJointDef( &world, &pd, &pj );

        b2PrismaticJoint_EnableSpring( &world, &pj, true );
        b2PrismaticJoint_SetSpringHertz( &world, &pj, 2.5 );
        b2PrismaticJoint_SetSpringDampingRatio( &world, &pj, 0.4 );
        b2PrismaticJoint_SetTargetTranslation( &world, &pj, 1.25 );
        b2PrismaticJoint_EnableMotor( &world, &pj, true );
        b2PrismaticJoint_SetMotorSpeed( &world, &pj, 3.0 );
        b2PrismaticJoint_SetMaxMotorForce( &world, &pj, 15.0 );
        b2PrismaticJoint_EnableLimit( &world, &pj, true );
        b2PrismaticJoint_SetLimits( &world, &pj, 0.0, 4.0 );

        Check( b2PrismaticJoint_IsSpringEnabled( &world, &pj ) == true );
        Check( feq( b2PrismaticJoint_GetSpringHertz( &world, &pj ), 2.5 ) );
        Check( feq( b2PrismaticJoint_GetSpringDampingRatio( &world, &pj ), 0.4 ) );
        Check( feq( b2PrismaticJoint_GetTargetTranslation( &world, &pj ), 1.25 ) );
        Check( b2PrismaticJoint_IsMotorEnabled( &world, &pj ) == true );
        Check( feq( b2PrismaticJoint_GetMotorSpeed( &world, &pj ), 3.0 ) );
        Check( feq( b2PrismaticJoint_GetMaxMotorForce( &world, &pj ), 15.0 ) );
        Check( b2PrismaticJoint_IsLimitEnabled( &world, &pj ) == true );
        Check( feq( b2PrismaticJoint_GetLowerLimit( &world, &pj ), 0.0 ) );
        Check( feq( b2PrismaticJoint_GetUpperLimit( &world, &pj ), 4.0 ) );
        b2DestroyJoint( &world, &pj );

        // wheel
        b2WheelJointDef wd;  b2DefaultWheelJointDef( &wd );
        wd.bodyIdA = ba;  wd.bodyIdB = bb;
        b2JointId wj;  b2CreateWheelJointDef( &world, &wd, &wj );

        b2WheelJoint_EnableSpring( &world, &wj, true );
        b2WheelJoint_SetSpringHertz( &world, &wj, 5.0 );
        b2WheelJoint_SetSpringDampingRatio( &world, &wj, 0.9 );
        b2WheelJoint_EnableMotor( &world, &wj, true );
        b2WheelJoint_SetMotorSpeed( &world, &wj, 4.5 );
        b2WheelJoint_SetMaxMotorTorque( &world, &wj, 8.0 );
        b2WheelJoint_EnableLimit( &world, &wj, true );
        b2WheelJoint_SetLimits( &world, &wj, -2.0, 2.0 );

        Check( b2WheelJoint_IsSpringEnabled( &world, &wj ) == true );
        Check( feq( b2WheelJoint_GetSpringHertz( &world, &wj ), 5.0 ) );
        Check( feq( b2WheelJoint_GetSpringDampingRatio( &world, &wj ), 0.9 ) );
        Check( b2WheelJoint_IsMotorEnabled( &world, &wj ) == true );
        Check( feq( b2WheelJoint_GetMotorSpeed( &world, &wj ), 4.5 ) );
        Check( feq( b2WheelJoint_GetMaxMotorTorque( &world, &wj ), 8.0 ) );
        Check( b2WheelJoint_IsLimitEnabled( &world, &wj ) == true );
        Check( feq( b2WheelJoint_GetLowerLimit( &world, &wj ), -2.0 ) );
        Check( feq( b2WheelJoint_GetUpperLimit( &world, &wj ), 2.0 ) );
        b2DestroyJoint( &world, &wj );

        // weld
        b2WeldJointDef wld;  b2DefaultWeldJointDef( &wld );
        wld.bodyIdA = ba;  wld.bodyIdB = bb;
        b2JointId weldj;  b2CreateWeldJointDef( &world, &wld, &weldj );

        b2WeldJoint_SetLinearHertz( &world, &weldj, 6.0 );
        b2WeldJoint_SetLinearDampingRatio( &world, &weldj, 0.3 );
        b2WeldJoint_SetAngularHertz( &world, &weldj, 7.0 );
        b2WeldJoint_SetAngularDampingRatio( &world, &weldj, 0.6 );

        Check( feq( b2WeldJoint_GetLinearHertz( &world, &weldj ), 6.0 ) );
        Check( feq( b2WeldJoint_GetLinearDampingRatio( &world, &weldj ), 0.3 ) );
        Check( feq( b2WeldJoint_GetAngularHertz( &world, &weldj ), 7.0 ) );
        Check( feq( b2WeldJoint_GetAngularDampingRatio( &world, &weldj ), 0.6 ) );
        b2DestroyJoint( &world, &weldj );

        // motor
        b2MotorJointDef mdf;  b2DefaultMotorJointDef( &mdf );
        mdf.bodyIdA = ba;  mdf.bodyIdB = bb;
        b2JointId mj;  b2CreateMotorJointDef( &world, &mdf, &mj );

        b2Vec2 mlv;  mlv.x = 1.0;  mlv.y = 2.0;
        b2MotorJoint_SetLinearVelocity( &world, &mj, &mlv );
        b2MotorJoint_SetAngularVelocity( &world, &mj, 3.0 );
        b2MotorJoint_SetMaxVelocityForce( &world, &mj, 40.0 );
        b2MotorJoint_SetMaxVelocityTorque( &world, &mj, 50.0 );
        b2MotorJoint_SetLinearHertz( &world, &mj, 2.0 );
        b2MotorJoint_SetLinearDampingRatio( &world, &mj, 0.8 );
        b2MotorJoint_SetAngularHertz( &world, &mj, 4.0 );
        b2MotorJoint_SetAngularDampingRatio( &world, &mj, 0.2 );
        b2MotorJoint_SetMaxSpringForce( &world, &mj, 60.0 );
        b2MotorJoint_SetMaxSpringTorque( &world, &mj, 70.0 );

        b2Vec2 gmlv;  b2MotorJoint_GetLinearVelocity( &world, &mj, &gmlv );
        Check( feq( gmlv.x, 1.0 ) && feq( gmlv.y, 2.0 ) );
        Check( feq( b2MotorJoint_GetAngularVelocity( &world, &mj ), 3.0 ) );
        Check( feq( b2MotorJoint_GetMaxVelocityForce( &world, &mj ), 40.0 ) );
        Check( feq( b2MotorJoint_GetMaxVelocityTorque( &world, &mj ), 50.0 ) );
        Check( feq( b2MotorJoint_GetLinearHertz( &world, &mj ), 2.0 ) );
        Check( feq( b2MotorJoint_GetLinearDampingRatio( &world, &mj ), 0.8 ) );
        Check( feq( b2MotorJoint_GetAngularHertz( &world, &mj ), 4.0 ) );
        Check( feq( b2MotorJoint_GetAngularDampingRatio( &world, &mj ), 0.2 ) );
        Check( feq( b2MotorJoint_GetMaxSpringForce( &world, &mj ), 60.0 ) );
        Check( feq( b2MotorJoint_GetMaxSpringTorque( &world, &mj ), 70.0 ) );
        b2DestroyJoint( &world, &mj );

        b2DestroyWorld( &world );
    }

    // b2Joint_WakeBodies wakes a sleeping endpoint.
    {
        b2World world;  b2CreateWorld( &world );
        world.enableSleep = true;

        b2BodyDef gdef;  b2DefaultBodyDef( &gdef );  gdef.type = b2_staticBody;
        b2BodyId bg;  b2CreateBody( &world, &gdef, &bg );
        b2Polygon ground;  b2MakeBox( 10.0, 0.5, &ground );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &bg, &gsd, &ground, &gs );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.y = 5.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.y = 1.0;
        b2BodyId bb;  b2CreateBody( &world, &bdef, &bb );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bb, &bsd, &box, &bs );

        b2DistanceJointDef jd;  b2DefaultDistanceJointDef( &jd );
        jd.bodyIdA = anchor;  jd.bodyIdB = bb;  jd.length = 4.0;
        jd.enableSpring = true;  jd.hertz = 1.0;  jd.dampingRatio = 2.0;
        b2JointId jh;  b2CreateDistanceJointDef( &world, &jd, &jh );

        int k;
        for( k = 0; k < 300; ++k )  b2World_Step( &world, 0.01666666, 4 );
        Check( b2Body_IsAwake( &world, &bb ) == false );      // settled asleep

        b2Joint_WakeBodies( &world, &jh );
        Check( b2Body_IsAwake( &world, &bb ) == true );
        Check( b2ValidateWorld( &world ) == 0 );

        b2DestroyWorld( &world );
    }

    // ---- JOINT REACTION FORCES (API batch 4) ----
    // The physics-exact anchor test: at equilibrium a rigid distance joint holds a
    // hanging weight, so its constraint-force magnitude equals that weight (m*g),
    // independent of any solver detail. mass 1, g 10 -> |force| ~ 10 N, ~vertical.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.y = 7.0;
        b2BodyId bob;  b2CreateBody( &world, &bdef, &bob );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );          // density 1 -> mass 1
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bob, &bsd, &box, &bs );
        Check( feq( b2Body_GetMass( &world, &bob ), 1.0 ) );

        b2DistanceJointDef jd;  b2DefaultDistanceJointDef( &jd );
        jd.bodyIdA = anchor;  jd.bodyIdB = bob;  jd.length = 3.0;   // rigid (no spring)
        b2JointId jh;  b2CreateDistanceJointDef( &world, &jd, &jh );

        // before the first step inv_h is 0 -> every reaction reads zero
        b2Vec2 pre;  b2Joint_GetConstraintForce( &world, &jh, &pre );
        Check( feq( pre.x, 0.0 ) && feq( pre.y, 0.0 ) );

        int k;
        for( k = 0; k < 240; ++k )  b2World_Step( &world, 0.01666666, 4 );

        b2Vec2 rest;  b2Body_GetPosition( &world, &bob, &rest );
        Check( fabs( rest.y - 7.0 ) < 0.05 );                 // hanging ~3 m below the anchor

        b2Vec2 f;  b2Joint_GetConstraintForce( &world, &jh, &f );
        float mag = b2Length( &f );
        diagA = mag;
        diagB = f.x;
        Check( mag > 8.0 && mag < 12.0 );                     // ~ m*g = 10 N
        Check( fabs( f.x ) < 1.0 );                           // ~vertical (the joint is vertical)

        // a distance joint exerts no reaction torque
        Check( feq( b2Joint_GetConstraintTorque( &world, &jh ), 0.0 ) );

        b2DestroyWorld( &world );
    }

    // A saturated revolute motor's reaction torque never exceeds its cap and is
    // substantial while it drives a load.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.gravityScale = 0.0;                              // isolate the motor
        b2BodyId arm;  b2CreateBody( &world, &bdef, &arm );
        b2Polygon box;  b2MakeBox( 2.0, 0.25, &box );         // an arm with real inertia
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &arm, &bsd, &box, &bs );

        b2RevoluteJointDef rd;  b2DefaultRevoluteJointDef( &rd );
        rd.bodyIdA = anchor;  rd.bodyIdB = arm;
        rd.enableMotor = true;  rd.motorSpeed = 100.0;        // unreachable -> stays saturated
        rd.maxMotorTorque = 5.0;
        b2JointId rj;  b2CreateRevoluteJointDef( &world, &rd, &rj );

        int k;
        for( k = 0; k < 3; ++k )  b2World_Step( &world, 0.01666666, 4 );

        float tq = b2RevoluteJoint_GetMotorTorque( &world, &rj );
        diagC = tq;
        Check( fabs( tq ) > 1.0 );                            // really driving the load
        Check( fabs( tq ) < 5.5 );                            // never exceeds maxMotorTorque

        // the same value is the joint's whole reaction torque (motor is its only source)
        Check( feq( b2Joint_GetConstraintTorque( &world, &rj ), tq ) );

        b2DestroyWorld( &world );
    }

    // ---- JOINT GEOMETRIC QUERIES (API batch 5) ----
    // Diagnostics from live transforms. Verified on the clean cases: a settled rigid
    // joint has ~zero separation; a hanging distance joint reports its actual length.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.y = 10.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.y = 7.0;
        b2BodyId bob;  b2CreateBody( &world, &bdef, &bob );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &bob, &bsd, &box, &bs );

        b2DistanceJointDef jd;  b2DefaultDistanceJointDef( &jd );
        jd.bodyIdA = anchor;  jd.bodyIdB = bob;  jd.length = 3.0;   // rigid
        b2JointId jh;  b2CreateDistanceJointDef( &world, &jd, &jh );

        int k;
        for( k = 0; k < 240; ++k )  b2World_Step( &world, 0.01666666, 4 );

        float len = b2DistanceJoint_GetCurrentLength( &world, &jh );
        diagA = len;
        Check( fabs( len - 3.0 ) < 0.05 );                    // actually 3 m apart
        Check( b2Joint_GetLinearSeparation( &world, &jh ) < 0.05 );          // rigid -> no drift
        Check( feq( b2Joint_GetAngularSeparation( &world, &jh ), 0.0 ) );     // distance: no angular

        b2DestroyWorld( &world );
    }

    // Revolute point-to-point: linear separation ~0 at rest (anchors coincide),
    // and angular separation 0 with no limit.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        adef.position.x = 0.0;  adef.position.y = 5.0;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0;  bdef.position.y = 5.0;
        b2BodyId arm;  b2CreateBody( &world, &bdef, &arm );
        b2Polygon box;  b2MakeBox( 1.0, 0.2, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &arm, &bsd, &box, &bs );

        b2RevoluteJointDef rd;  b2DefaultRevoluteJointDef( &rd );
        rd.bodyIdA = anchor;  rd.bodyIdB = arm;               // both frames at the shared origin
        b2JointId rj;  b2CreateRevoluteJointDef( &world, &rd, &rj );

        int k;
        for( k = 0; k < 120; ++k )  b2World_Step( &world, 0.01666666, 4 );

        Check( b2Joint_GetLinearSeparation( &world, &rj ) < 0.05 );   // pivot stays glued
        Check( feq( b2Joint_GetAngularSeparation( &world, &rj ), 0.0 ) );  // no limit -> 0
        b2DestroyWorld( &world );
    }

    // Prismatic slide speed: a body driven along the axis reports a nonzero speed
    // while moving, ~0 once it settles against a limit.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef adef;  b2DefaultBodyDef( &adef );  adef.type = b2_staticBody;
        b2BodyId anchor;  b2CreateBody( &world, &adef, &anchor );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.gravityScale = 0.0;
        b2BodyId slider;  b2CreateBody( &world, &bdef, &slider );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bs;  b2CreatePolygonShape( &world, &slider, &bsd, &box, &bs );

        b2PrismaticJointDef pd;  b2DefaultPrismaticJointDef( &pd );   // axis = frameA +x
        pd.bodyIdA = anchor;  pd.bodyIdB = slider;
        pd.enableMotor = true;  pd.motorSpeed = 3.0;  pd.maxMotorForce = 100.0;
        b2JointId pj;  b2CreatePrismaticJointDef( &world, &pd, &pj );

        int k;
        for( k = 0; k < 30; ++k )  b2World_Step( &world, 0.01666666, 4 );

        float speed = b2PrismaticJoint_GetSpeed( &world, &pj );
        diagB = speed;
        Check( fabs( speed - 3.0 ) < 0.5 );                   // driven to the motor speed
        b2DestroyWorld( &world );
    }

    // ---- SHAPE/WORLD QUERY CLEANUP (final API batch) ----
    // b2Shape_RayCast, b2World_GetBounds, b2Shape_GetClosestPoint. Static box of
    // half-extent 1 at the origin, so the geometry is hand-checkable.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_staticBody;
        b2BodyId body;  b2CreateBody( &world, &bd, &body );
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );          // [-1,1] x [-1,1]
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );
        b2ShapeId shp;  b2CreatePolygonShape( &world, &body, &sd, &box, &shp );

        // ray from (-3,0) toward +x hits the left face at x=-1: fraction 2/6.
        b2RayCastInput ri;
        ri.origin.x = -3.0;  ri.origin.y = 0.0;
        ri.translation.x = 6.0;  ri.translation.y = 0.0;
        ri.maxFraction = 1.0;
        b2CastOutput ro;
        b2Shape_RayCast( &world, &shp, &ri, &ro );
        diagA = ro.fraction;
        Check( ro.hit );
        Check( feq( ro.fraction, 2.0 / 6.0 ) );
        Check( feq( ro.point.x, -1.0 ) && fabs( ro.point.y ) < 0.01 );
        Check( feq( ro.normal.x, -1.0 ) && fabs( ro.normal.y ) < 0.01 );

        // parallel ray at y=3 misses the box entirely.
        b2RayCastInput rm = ri;  rm.origin.y = 3.0;
        b2CastOutput rmo;
        b2Shape_RayCast( &world, &shp, &rm, &rmo );
        Check( rmo.hit == false );

        // world bounds contain the box (fat AABB -> a touch larger, so inequalities).
        b2AABB bounds;
        b2World_GetBounds( &world, &bounds );
        Check( bounds.lowerBound.x <= -1.0 && bounds.lowerBound.y <= -1.0 );
        Check( bounds.upperBound.x >=  1.0 && bounds.upperBound.y >=  1.0 );

        // closest surface point to (3,0) outside the box is the right face at (1,0).
        b2Vec2 target;  target.x = 3.0;  target.y = 0.0;
        b2Vec2 cp;
        b2Shape_GetClosestPoint( &world, &shp, &target, &cp );
        diagB = cp.x;
        Check( feq( cp.x, 1.0 ) && fabs( cp.y ) < 0.01 );

        b2DestroyWorld( &world );
    }

    // ---- PORTABLE-DEFERRED API BATCH (all-hits queries, explode, enumeration) ----

    // b2Shape_AreContactEventsEnabled reads the per-shape opt-in flag.
    {
        b2World world;  b2CreateWorld( &world );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_staticBody;
        b2BodyId body;  b2CreateBody( &world, &bd, &body );
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );
        b2ShapeId shp;  b2CreatePolygonShape( &world, &body, &sd, &box, &shp );

        Check( b2Shape_AreContactEventsEnabled( &world, &shp ) == true );   // default on
        b2Shape_EnableContactEvents( &world, &shp, false );
        Check( b2Shape_AreContactEventsEnabled( &world, &shp ) == false );
        b2DestroyWorld( &world );
    }

    // Sensor enumeration: a visitor overlapping a sensor shows up in its overlap set.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;

        b2Polygon sbox;  b2MakeBox( 1.0, 1.0, &sbox );
        b2BodyDef sdb;  b2DefaultBodyDef( &sdb );  sdb.type = b2_staticBody;
        b2BodyId bs;  b2CreateBody( &world, &sdb, &bs );
        b2ShapeDef ssd;  b2DefaultShapeDef( &ssd );  ssd.isSensor = true;
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bs, &ssd, &sbox, &sf );

        b2Polygon vbox;  b2MakeBox( 0.5, 0.5, &vbox );
        b2BodyDef vdef;  b2DefaultBodyDef( &vdef );  vdef.type = b2_dynamicBody;
        b2BodyId bv;  b2CreateBody( &world, &vdef, &bv );            // at origin -> overlapping
        b2ShapeDef vsd;  b2DefaultShapeDef( &vsd );
        b2ShapeId sv;  b2CreatePolygonShape( &world, &bv, &vsd, &vbox, &sv );

        b2World_Step( &world, 1.0 / 60.0, 4 );                       // runs b2OverlapSensors

        Check( b2Shape_GetSensorCapacity( &world, &sf ) == 1 );
        int[4] ids;
        int n = b2Shape_GetSensorData( &world, &sf, ids, 4 );
        Check( n == 1 );
        Check( ids[0] == sv.index1 - 1 );                           // the visitor's raw shape id
        b2DestroyWorld( &world );
    }

    // Contact enumeration: a box resting on a floor yields one touching contact,
    // visible from both the body and the floor shape.
    {
        b2World world;  b2CreateWorld( &world );

        b2BodyDef gd;  b2DefaultBodyDef( &gd );  gd.type = b2_staticBody;
        b2BodyId ground;  b2CreateBody( &world, &gd, &ground );
        b2Polygon floor;  b2MakeBox( 10.0, 0.5, &floor );
        b2ShapeDef gsd;  b2DefaultShapeDef( &gsd );
        b2ShapeId gs;  b2CreatePolygonShape( &world, &ground, &gsd, &floor, &gs );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.y = 1.0;                                         // half 0.5 rests on floor top y=0.5
        b2BodyId box;  b2CreateBody( &world, &bd, &box );
        b2Polygon bp;  b2MakeBox( 0.5, 0.5, &bp );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2ShapeId bshape;  b2CreatePolygonShape( &world, &box, &bsd, &bp, &bshape );

        int k;
        for( k = 0; k < 60; ++k )  b2World_Step( &world, 1.0 / 60.0, 4 );

        b2ContactData[4] cd;
        int nb = b2Body_GetContactData( &world, &box, cd, 4 );
        diagC = nb;
        Check( nb == 1 );                                           // box-floor contact
        Check( cd[0].manifold.pointCount >= 1 );                    // a real manifold

        int ns = b2Shape_GetContactData( &world, &gs, cd, 4 );
        Check( ns == 1 );                                           // same contact, floor's view

        // b2ContactId handle: valid now, resolves to the same contact...
        Check( b2Contact_IsValid( &world, &cd[0].contactId ) == true );
        b2ContactData one;
        Check( b2Contact_GetData( &world, &cd[0].contactId, &one ) == true );
        Check( one.shapeIdA == cd[0].shapeIdA && one.shapeIdB == cd[0].shapeIdB );

        // ...and goes STALE once the contact is destroyed (box removed).
        b2DestroyBody( &world, &box );
        Check( b2Contact_IsValid( &world, &cd[0].contactId ) == false );
        Check( b2Contact_GetData( &world, &cd[0].contactId, &one ) == false );

        b2DestroyWorld( &world );
    }

    // All-hits ray cast: a ray crossing two static boxes reports both.
    {
        b2World world;  b2CreateWorld( &world );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_staticBody;
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );

        bd.position.x = 0.0;  b2BodyId b1;  b2CreateBody( &world, &bd, &b1 );
        b2ShapeId s1;  b2CreatePolygonShape( &world, &b1, &sd, &box, &s1 );
        bd.position.x = 3.0;  b2BodyId b2b;  b2CreateBody( &world, &bd, &b2b );
        b2ShapeId s2;  b2CreatePolygonShape( &world, &b2b, &sd, &box, &s2 );

        g_castCount = 0;  g_castLastShape = -1;
        b2Vec2 org;  org.x = -3.0;  org.y = 0.0;
        b2Vec2 tr;   tr.x = 10.0;  tr.y = 0.0;
        b2World_CastRay( &world, &org, &tr, NULL, &RayCastCollectCB, NULL );
        diagD = g_castCount;
        Check( g_castCount == 2 );                                  // both boxes hit
        b2DestroyWorld( &world );
    }

    // All-hits shape cast: a proxy swept into one static box reports it.
    {
        b2World world;  b2CreateWorld( &world );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_staticBody;
        bd.position.x = 3.0;  b2BodyId body;  b2CreateBody( &world, &bd, &body );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );
        b2ShapeId shp;  b2CreatePolygonShape( &world, &body, &sd, &box, &shp );

        b2Vec2[4] scorners;
        scorners[0].x = -0.2;  scorners[0].y = -0.2;
        scorners[1].x =  0.2;  scorners[1].y = -0.2;
        scorners[2].x =  0.2;  scorners[2].y =  0.2;
        scorners[3].x = -0.2;  scorners[3].y =  0.2;
        b2ShapeProxy sqp;  b2MakeProxy( scorners, 4, 0.0, &sqp );

        g_castCount = 0;
        b2Vec2 str;  str.x = 10.0;  str.y = 0.0;                    // sweep +x into the box
        b2World_CastShape( &world, &sqp, &str, NULL, &RayCastCollectCB, NULL );
        Check( g_castCount == 1 );
        b2DestroyWorld( &world );
    }

    // b2World_OverlapShape: a proxy box overlapping the shape reports it; a far one does not.
    {
        b2World world;  b2CreateWorld( &world );
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_staticBody;
        b2BodyId body;  b2CreateBody( &world, &bd, &body );
        b2Polygon box;  b2MakeBox( 1.0, 1.0, &box );
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );
        b2ShapeId shp;  b2CreatePolygonShape( &world, &body, &sd, &box, &shp );

        b2Vec2[4] corners;
        corners[0].x = -0.2;  corners[0].y = -0.2;
        corners[1].x =  0.2;  corners[1].y = -0.2;
        corners[2].x =  0.2;  corners[2].y =  0.2;
        corners[3].x = -0.2;  corners[3].y =  0.2;
        b2ShapeProxy qp;  b2MakeProxy( corners, 4, 0.0, &qp );

        g_ovShapeCount = 0;
        b2World_OverlapShape( &world, &qp, NULL, &OverlapShapeCB, NULL );
        Check( g_ovShapeCount == 1 );                               // overlaps the box

        b2Vec2[4] farc;
        farc[0].x = 99.8;   farc[0].y = 99.8;
        farc[1].x = 100.2;  farc[1].y = 99.8;
        farc[2].x = 100.2;  farc[2].y = 100.2;
        farc[3].x = 99.8;   farc[3].y = 100.2;
        b2ShapeProxy qp2;  b2MakeProxy( farc, 4, 0.0, &qp2 );
        g_ovShapeCount = 0;
        b2World_OverlapShape( &world, &qp2, NULL, &OverlapShapeCB, NULL );
        Check( g_ovShapeCount == 0 );                               // far away -> nothing
        b2DestroyWorld( &world );
    }

    // b2World_Explode: a dynamic body offset from the blast is pushed radially outward.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 3.0;  bd.position.y = 0.0;
        b2BodyId body;  b2CreateBody( &world, &bd, &body );
        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );
        b2ShapeId shp;  b2CreatePolygonShape( &world, &body, &sd, &box, &shp );

        b2ExplosionDef ed;  b2DefaultExplosionDef( &ed );
        ed.position.x = 0.0;  ed.position.y = 0.0;
        ed.radius = 5.0;  ed.falloff = 1.0;  ed.impulsePerLength = 10.0;
        b2World_Explode( &world, &ed );

        b2Vec2 v;  b2Body_GetLinearVelocity( &world, &body, &v );
        diagA = v.x;
        Check( v.x > 0.5 );                                         // pushed away from the origin (+x)
        Check( fabs( v.y ) < 0.5 );
        b2DestroyWorld( &world );
    }

    // =========================================================================
    //   vb2 FACADE (S2) -- the game-facing sugar layer
    // =========================================================================
    //   The load-bearing claim is EQUIVALENCE: the facade must be sugar, not a
    //   second physics path. So the core test builds the same scene twice -- once
    //   through vb2_*, once through the raw b2 API on a twin world -- steps both
    //   90 times, and demands the results match EXACTLY (==, not feq). Anything
    //   the facade silently changed (a def field, a step size) shows up here.
    //
    //   The other load-bearing claim is that a stale handle is DETECTED. The
    //   slot-recycle case below is the one that a bare-index handle (as first
    //   planned) would get wrong: it would resolve to whichever body later took
    //   the freed slot. The facade packs the generation into the int to catch it.
    // =========================================================================
    {
        // --- twin world: the same scene through the raw b2 API, same order ---
        b2World tw;  b2CreateWorld( &tw );
        b2ShapeDef tsd;  b2DefaultShapeDef( &tsd );

        b2BodyDef tfd;  b2DefaultBodyDef( &tfd );  tfd.type = b2_staticBody;
        tfd.position.x = 0.0;  tfd.position.y = 0.0;
        b2BodyId tfloor;  b2CreateBody( &tw, &tfd, &tfloor );
        b2Polygon tfpoly;  b2MakeBox( 6.0, 0.5, &tfpoly );
        b2ShapeId tfsh;  b2CreatePolygonShape( &tw, &tfloor, &tsd, &tfpoly, &tfsh );

        b2BodyDef tbd;  b2DefaultBodyDef( &tbd );  tbd.type = b2_dynamicBody;
        tbd.position.x = 0.3;  tbd.position.y = 5.0;
        b2BodyId tbox;  b2CreateBody( &tw, &tbd, &tbox );
        b2Polygon tbpoly;  b2MakeBox( 0.5, 0.5, &tbpoly );
        b2ShapeId tbsh;  b2CreatePolygonShape( &tw, &tbox, &tsd, &tbpoly, &tbsh );

        // --- facade world: the same scene in four lines ---
        vb2_Init();
        int vfloor = vb2_Wall( 0.0, 0.0, 6.0, 0.5 );
        int vbox   = vb2_Box( 0.3, 5.0, 0.5, 0.5 );

        Check( vb2_Exists( vfloor ) == true );
        Check( vb2_Exists( vbox ) == true );

        // drop both: 90 steps is well past the ~54 the fall takes, so it has settled
        int vs;
        for( vs = 0; vs < 90; vs++ )
        {
            b2World_Step( &tw, 1.0 / 60.0, 4 );
            vb2_Step();
        }

        b2Vec2 tp;  b2Body_GetPosition( &tw, &tbox, &tp );
        b2Rot  tq;  b2Body_GetRotation( &tw, &tbox, &tq );
        b2Vec2 tv;  b2Body_GetLinearVelocity( &tw, &tbox, &tv );

        diagA = vb2_GetX( vbox );   // on RED here: facade x ...
        diagB = tp.x;               // ... vs twin x

        Check( vb2_GetX( vbox ) == tp.x );
        Check( vb2_GetY( vbox ) == tp.y );
        Check( vb2_GetAngle( vbox ) == b2Rot_GetAngle( &tq ) );
        Check( vb2_GetVX( vbox ) == tv.x );
        Check( vb2_GetVY( vbox ) == tv.y );
        Check( vb2_GetAngularVelocity( vbox ) == b2Body_GetAngularVelocity( &tw, &tbox ) );
        Check( vb2_GetMass( vbox ) == b2Body_GetMass( &tw, &tbox ) );

        // and it actually came to rest on the floor rather than falling through or
        // hanging in the air. Nominal center is 1.0 (floor top 0.5 + half-height 0.5),
        // but a soft contact rests ~one b2_linearSlop INTO the floor, so this is a
        // band, not an equality -- the exactness proof is the twin == above.
        Check( vb2_GetY( vbox ) > 0.90 && vb2_GetY( vbox ) < 1.05 );
        Check( fabs( vb2_GetX( vbox ) - 0.3 ) < 0.01 );    // a flat drop does not drift sideways
        Check( vb2_GetX( vfloor ) == 0.0 );

        b2DestroyWorld( &tw );

        // ----- stale handles: gone means gone, and reads are harmless -----
        int tmp = vb2_Box( 20.0, 20.0, 0.5, 0.5 );
        Check( vb2_Exists( tmp ) == true );
        vb2_Destroy( tmp );
        Check( vb2_Exists( tmp ) == false );
        Check( vb2_GetX( tmp ) == 0.0 );          // reads 0, does not fault
        Check( vb2_GetMass( tmp ) == 0.0 );
        vb2_SetVelocity( tmp, 9.0, 9.0 );          // writes are no-ops, not faults
        vb2_Destroy( tmp );                        // double destroy is a no-op
        Check( vb2_Exists( -1 ) == false );
        Check( vb2_Exists( 0 ) == false );

        // ----- SLOT RECYCLE: the case a bare-index handle gets wrong -----
        // The next create reuses tmp's freed slot and bumps its generation, so
        // `fresh` shares tmp's index but differs in the packed generation.
        int fresh = vb2_Box( 21.0, 21.0, 0.5, 0.5 );
        diagC = fresh;
        diagD = tmp;
        Check( ( fresh & 0xFFFF ) == ( tmp & 0xFFFF ) );   // same slot ...
        Check( fresh != tmp );                             // ... but NOT the same handle
        Check( vb2_Exists( fresh ) == true );
        Check( vb2_Exists( tmp ) == false );               // the dead handle stays dead
        Check( feq( vb2_GetX( fresh ), 21.0 ) );
        Check( vb2_GetX( tmp ) == 0.0 );                   // and never reads `fresh`

        // ----- material setters poke the body's first shape -----
        int mat = vb2_Box( 30.0, 30.0, 0.5, 0.5 );
        vb2_SetFriction( mat, 0.25 );
        vb2_SetBounce( mat, 0.8 );
        vb2_SetDensity( mat, 4.0 );

        b2ShapeId msh;
        Check( vb2_ResolveShape( mat, &msh ) == true );
        Check( feq( b2Shape_GetFriction( &vb2_world, &msh ), 0.25 ) );
        Check( feq( b2Shape_GetRestitution( &vb2_world, &msh ), 0.8 ) );
        Check( feq( b2Shape_GetDensity( &vb2_world, &msh ), 4.0 ) );
        Check( feq( vb2_GetMass( mat ), 4.0 ) );           // 1x1 box at density 4 -> mass 4

        // ----- writes -----
        int kick = vb2_Box( 40.0, 40.0, 0.5, 0.5 );        // 1x1, density 1 -> mass 1
        vb2_SetVelocity( kick, 3.0, 0.0 );
        Check( feq( vb2_GetVX( kick ), 3.0 ) );
        vb2_ApplyImpulse( kick, 0.0, 2.0 );                // mass 1 -> +2 m/s in y
        Check( feq( vb2_GetVY( kick ), 2.0 ) );
        vb2_SetAngularVelocity( kick, 1.5 );
        Check( feq( vb2_GetAngularVelocity( kick ), 1.5 ) );
        vb2_SetPosition( kick, 41.0, 42.0 );
        Check( feq( vb2_GetX( kick ), 41.0 ) );
        Check( feq( vb2_GetY( kick ), 42.0 ) );
        vb2_SetAngle( kick, 0.5 );
        Check( feq( vb2_GetAngle( kick ), 0.5 ) );
        Check( feq( vb2_GetX( kick ), 41.0 ) );            // SetAngle kept the position
        vb2_SetAngle( kick, 0.0 );
        vb2_SetPosition( kick, 41.0, 42.0 );
        Check( feq( vb2_GetAngle( kick ), 0.0 ) );         // SetPosition kept the rotation

        // ----- the other two creators -----
        int ball = vb2_Ball( 50.0, 50.0, 2.0 );
        b2ShapeId bsh;
        Check( vb2_ResolveShape( ball, &bsh ) == true );
        Check( b2Shape_GetType( &vb2_world, &bsh ) == b2_circleShape );
        b2Circle bcirc;  b2Shape_GetCircle( &vb2_world, &bsh, &bcirc );
        Check( feq( bcirc.radius, 2.0 ) );

        int line = vb2_Line( -5.0, 1.0, 5.0, 1.0 );
        b2ShapeId lsh;
        Check( vb2_ResolveShape( line, &lsh ) == true );
        Check( b2Shape_GetType( &vb2_world, &lsh ) == b2_segmentShape );
        b2Segment lseg;  b2Shape_GetSegment( &vb2_world, &lsh, &lseg );
        Check( feq( lseg.point1.x, -5.0 ) );               // local == world: the body is at the origin
        Check( feq( lseg.point2.x, 5.0 ) );
        b2BodyId lid;
        Check( vb2_GetBodyId( line, &lid ) == true );      // the escape hatch hands back a real handle
        Check( b2Body_GetType( &vb2_world, &lid ) == b2_staticBody );

        // ----- world tuning -----
        vb2_SetGravity( 0.0, -20.0 );
        Check( vb2_world.gravity.y == -20.0 );
        vb2_EnableSleep( true );
        Check( b2World_IsSleepingEnabled( &vb2_world ) == true );

        // the facade left the world structurally sound
        vb2_Step();
        Check( b2ValidateWorld( &vb2_world ) == 0 );

        vb2_Quit();
    }

    // =========================================================================
    //   vb2 FACADE (S3 + S4) -- camera, queries, touch events, joints
    // =========================================================================
    {
        vb2_Init();

        // ----- S3: camera. world is meters/y-up, screen is 640x360/y-down -----
        vb2_SetCamera( 0.0, 0.0, 20.0 );
        Check( vb2_ScreenX( 0.0 ) == 320 );                  // origin at screen center
        Check( vb2_ScreenY( 0.0 ) == 180 );
        Check( vb2_ScreenX( 1.0 ) == 340 );                  // +1 m right = +20 px right
        Check( vb2_ScreenY( 1.0 ) == 160 );                  // +1 m UP = -20 px (y flips)
        Check( feq( vb2_WorldX( vb2_ScreenX( 3.25 ) ), 3.25 ) );    // round trip
        Check( feq( vb2_WorldY( vb2_ScreenY( -2.5 ) ), -2.5 ) );

        vb2_SetCamera( 10.0, 5.0, 40.0 );                    // off-center, zoomed in
        Check( vb2_ScreenX( 10.0 ) == 320 );                 // the camera point is centered
        Check( vb2_ScreenY( 5.0 ) == 180 );
        Check( vb2_ScreenX( 11.0 ) == 360 );                 // +1 m = +40 px now
        Check( feq( vb2_WorldY( vb2_ScreenY( 6.5 ) ), 6.5 ) );
        vb2_SetCamera( 0.0, 0.0, 20.0 );

        // ----- S4: ray cast -----
        int gfloor = vb2_Wall( 0.0, 0.0, 10.0, 0.5 );
        int gbox   = vb2_Box( 0.0, 3.0, 0.5, 0.5 );

        // straight down through the box: it is hit before the floor behind it
        int hit = vb2_RayCast( 0.0, 6.0, 0.0, -6.0 );
        Check( hit == gbox );                                 // closest body, not the floor
        Check( feq( vb2_HitY(), 3.5 ) );                      // the box's top edge (3 + 0.5)
        Check( feq( vb2_HitX(), 0.0 ) );
        Check( feq( vb2_HitNY(), 1.0 ) );                     // surface normal faces the ray
        Check( feq( vb2_HitFraction(), 2.5 / 12.0 ) );        // 2.5 m into a 12 m ray
        Check( vb2_RayCast( -20.0, 20.0, -15.0, 20.0 ) == -1 );   // clean miss

        // ----- S4: point pick -----
        Check( vb2_BodyAt( 0.0, 3.0 ) == gbox );
        Check( vb2_BodyAt( 0.0, 0.0 ) == gfloor );
        Check( vb2_BodyAt( 50.0, 50.0 ) == -1 );              // empty space

        // ----- S4: touch events. The engine reports SHAPES; the facade must hand
        //       back the two BODIES, which is the whole point of the resolve. -----
        int touchA = -1;
        int touchB = -1;
        int ts;
        for( ts = 0; ts < 120; ts++ )                         // the box falls ~2 m -> ~38 steps
        {
            vb2_Step();
            if( vb2_TouchCount() > 0 )
            {
                touchA = vb2_TouchA( 0 );
                touchB = vb2_TouchB( 0 );
                break;
            }
        }
        Check( vb2_TouchCount() > 0 );                        // the landing was reported
        Check( ( touchA == gbox && touchB == gfloor ) || ( touchA == gfloor && touchB == gbox ) );
        Check( vb2_TouchA( 99 ) == -1 );                      // out of range reads -1, not a fault
        Check( vb2_TouchB( -1 ) == -1 );

        // ----- S4: pin (hinge) -----
        int ganchor = vb2_Wall( -20.0, 10.0, 0.1, 0.1 );      // static pivot post
        int garm    = vb2_Box( -19.0, 10.0, 1.0, 0.1 );       // 2 m bar, hinged at its left end
        int gpin = vb2_Pin( ganchor, garm, -20.0, 10.0 );
        Check( gpin != -1 );
        Check( vb2_JointExists( gpin ) == true );
        Check( vb2_Pin( ganchor, 12345, 0.0, 0.0 ) == -1 );   // a stale body handle -> no joint

        int js;
        for( js = 0; js < 60; js++ )
            vb2_Step();

        // The hinge invariant: whatever the arm swung to, its local (-1,0) -- the
        // pivot end -- is still at the world anchor.
        b2BodyId garmId;
        Check( vb2_GetBodyId( garm, &garmId ) == true );
        b2Vec2 localPivot;  localPivot.x = -1.0;  localPivot.y = 0.0;
        b2Vec2 worldPivot;  b2Body_GetWorldPoint( &vb2_world, &garmId, &localPivot, &worldPivot );
        if( AllPassed )                                       // keep an earlier block's diag
        {
            diagC = worldPivot.x;
            diagD = worldPivot.y;
        }
        Check( fabs( worldPivot.x - ( -20.0 ) ) < 0.05 );
        Check( fabs( worldPivot.y - 10.0 ) < 0.05 );
        Check( vb2_GetY( garm ) < 9.9 );                      // and it really did swing down

        // ----- S4: motor drives the pin -----
        vb2_Motor( gpin, 3.0, 1000.0 );
        int ms;
        for( ms = 0; ms < 60; ms++ )
            vb2_Step();
        Check( vb2_GetAngularVelocity( garm ) > 1.0 );        // spinning the way we asked

        // ----- S4: rope holds the distance it was created at -----
        int ghook   = vb2_Wall( 30.0, 20.0, 0.1, 0.1 );
        int gweight = vb2_Box( 30.0, 17.0, 0.5, 0.5 );        // 3 m below the hook
        int grope = vb2_Rope( ghook, gweight );
        Check( grope != -1 );

        int rs;
        for( rs = 0; rs < 90; rs++ )
            vb2_Step();

        float rdx = vb2_GetX( gweight ) - 30.0;
        float rdy = vb2_GetY( gweight ) - 20.0;
        Check( fabs( sqrt( rdx * rdx + rdy * rdy ) - 3.0 ) < 0.05 );   // still 3 m from the hook
        vb2_Motor( grope, 5.0, 100.0 );                       // a rope has no motor -> ignored

        // ----- S4: joint teardown + stale joint handles -----
        vb2_DestroyJoint( gpin );
        Check( vb2_JointExists( gpin ) == false );
        vb2_DestroyJoint( gpin );                             // double destroy is a no-op
        vb2_Motor( gpin, 1.0, 1.0 );                          // driving a dead joint is a no-op
        Check( vb2_JointExists( -1 ) == false );

        vb2_Step();
        Check( b2ValidateWorld( &vb2_world ) == 0 );

        vb2_Quit();
    }

    // ----- verdict -----
    if( AllPassed )
    {
        clear_screen( color_green );
    }
    else
    {
        clear_screen( color_red );
        print_at(  60, 100, "FIRST FAIL CHECK #" );  ShowInt( 280, 100, firstFail );
        print_at(  60, 130, "TOTAL CHECKS" );        ShowInt( 280, 130, checkNum );
        print_at(  60, 170, "DIAG A" );  ShowFloat( 240, 170, diagA );
        print_at(  60, 200, "DIAG B" );  ShowFloat( 240, 200, diagB );
        print_at(  60, 230, "DIAG C" );  ShowFloat( 240, 230, diagC );
        print_at(  60, 260, "DIAG D" );  ShowFloat( 240, 260, diagD );
    }
}
