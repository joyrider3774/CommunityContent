// =============================================================================
//   VIRCONBOX2D MEGADEMO  --  interactive physics showcase ROM
// =============================================================================
//   Everything the port can do today, in one asset-free cartridge, rendered
//   with REAL GPU primitives (the BIOS white-pixel rotozoom trick: solid
//   ROTATED boxes + filled circles + lines -- no font markers):
//
//     * a DRIVABLE CAR: 2 wheel joints (suspension springs + travel limits +
//       motors), gas with the D-PAD, jump the ramp
//     * a motorized SPINNER bar mid-field that bats anything that touches it
//     * a WRECKING BALL on a rigid distance-joint rope (auto-kicks once;
//       press X to kick it again) smashing a BOX TOWER
//     * SLEEPING: settled bodies dim + show "z" (world.enableSleep = true),
//       collisions wake them
//     * A drops bouncy balls / crates from the sky (oldest recycled live via
//       b2DestroyBody), B fires a LASER (b2World_CastRayClosest) with a hit
//       spark, Y INVERTS GRAVITY (wakes the world, force-field ceiling),
//       START rescues a flipped car (b2Body_SetTransform)
//     * live HUD: FPS + step cycles vs the cycle budget bar. Physics runs at
//       30 Hz over two 60 Hz display frames (BadApple double-end_frame trick,
//       500k-cycle step budget), drawn BEFORE stepping so an over-budget step
//       can never present a half-drawn frame (the old black flicker)
//
//   PORT-SEAM DISCIPLINE (matches PLAN_FOR_OPUS.md Part 0 findings): every
//   destroy / SetTransform / velocity poke / gravity flip WAKES the affected
//   sleeping sets first (workarounds for F2/F3 until P0.1 lands).
//
//   Build:  bash build.sh showcase   ->  bin/showcase.v32
// =============================================================================

#include "video.h"
#include "time.h"
#include "math.h"
#include "string.h"
#include "input.h"
#include "draw_primitives.h"
#include "virconbox2d.h"

// ---- world -> screen mapping (y-up world, 640x360 screen) -------------------
#define ORIGIN_X 320
#define ORIGIN_Y 330
#define PPM      24.0

b2World* W;              // the world, set once in main

// per-body draw colors, indexed by raw body id (parallel SCALAR arrays --
// variable-indexing a global array of structs is dialect-unattested)
#define MAX_BODIES 64
int[MAX_BODIES] gColR;
int[MAX_BODIES] gColG;
int[MAX_BODIES] gColB;

// key actors
b2BodyId gCarId;
b2BodyId gWheelIdL;
b2BodyId gWheelIdR;
b2JointId gMotorL;
b2JointId gMotorR;
b2BodyId gBallId;
float gRopeAnchorX;   // rope top, for drawing
float gRopeAnchorY;

// spawned-body ring buffer (parallel scalar arrays; cap keeps the scene hot-body
// count inside the cycle budget)
#define SPAWN_CAP 6
int[SPAWN_CAP] gSpawnIdx1;
int[SPAWN_CAP] gSpawnGen;
int gSpawnCount;
int gSpawnHead;
int gSpawnKind;

int  gFaceDir;        // last drive direction, aims the laser
bool gFlipped;        // gravity currently inverted?

// interpolation snapshot: pose of every body BEFORE the last step (the port's
// own center0/rotation0 are a TOI baseline reset to == current at finalize,
// so the demo keeps its own; scalar arrays -- dialect-safe variable indexing)
float[MAX_BODIES] gPrevX;
float[MAX_BODIES] gPrevY;
float[MAX_BODIES] gPrevC;
float[MAX_BODIES] gPrevS;

int gStepCyc;         // last physics step cycles (for the HUD bar)
int gWorkCyc;         // last draw+step cycles (for the fps readout)

// adaptive quality governor (plan §5.4/V6): substeps are the physics
// quality/cost dial. Contact storms (gravity-flip pile-ups, wreck impacts)
// can push a 4-substep step past the 500k budget -> frame slip -> stutter.
// Shed substeps when the step runs hot, restore them when it cools.
int gSubSteps;

int ScreenX( float wx ) { return (int)( ORIGIN_X + wx * PPM ); }
int ScreenY( float wy ) { return (int)( ORIGIN_Y - wy * PPM ); }

void ShowInt( int x, int y, int value )
{
    int[20] s;
    itoa( value, s, 10 );
    print_at( x, y, s );
}

// monotonic cycle clock (fixed 250000 cyc/frame), frame-boundary guarded
int CycNow()
{
    int f1 = get_frame_counter();
    int c  = get_cycle_counter();
    int f2 = get_frame_counter();
    if( f1 != f2 )
    {
        c  = get_cycle_counter();
        f1 = f2;
    }
    return f1 * 250000 + c;
}

// -----------------------------------------------------------------------------
//   GPU primitive helpers (BIOS white pixel, texture -1 / region 256)
// -----------------------------------------------------------------------------
void SelectWhitePixel()
{
    asm
    {
        "out GPU_SelectedTexture, -1"
        "out GPU_SelectedRegion, 256"
    }
}

// Solid ROTATED rectangle: world center (wx,wy), half extents (hx,hy) meters,
// world rotation (c,s). The BIOS pixel is stretched to the full box size and
// rotated; the drawing point must be the box corner that maps to the pixel
// hotspot, so back it out from the center along the rotated axes.
void DrawWorldBox( float wx, float wy, float hx, float hy, float c, float s, int color )
{
    float scx = ORIGIN_X + wx * PPM;
    float scy = ORIGIN_Y - wy * PPM;
    float hxp = hx * PPM;
    float hyp = hy * PPM;

    // screen-space rotation (y flips): cos = c, sin = -s
    float px = scx - ( c * hxp + s * hyp );
    float py = scy - ( -s * hxp + c * hyp );

    set_multiply_color( color );
    set_drawing_angle( atan2( -s, c ) );          // unit rot -> never (0,0)
    set_drawing_scale( 2.0 * hxp, 2.0 * hyp );
    SelectWhitePixel();
    draw_region_rotozoomed_at( (int)px, (int)py );
}

void DrawWorldLine( float x1, float y1, float x2, float y2, int color )
{
    set_multiply_color( color );
    draw_line( ScreenX( x1 ), ScreenY( y1 ), ScreenX( x2 ), ScreenY( y2 ) );
}

// -----------------------------------------------------------------------------
//   wake / poke helpers (F2/F3 seam discipline: wake BEFORE touching)
// -----------------------------------------------------------------------------
void WakeBody( b2BodyId* id )
{
    b2Body* body = b2GetBodyFullId( W, id );
    if( body->setIndex >= b2_firstSleepingSet )
        b2WakeSolverSet( W, body->setIndex );
}

// wake + hard-set velocity (no public velocity API yet -- P1.1; poke the state)
void PokeVelocity( b2BodyId* id, float vx, float vy, float w )
{
    WakeBody( id );
    b2Body* body = b2GetBodyFullId( W, id );
    if( body->setIndex == b2_awakeSet )
    {
        b2SolverSet* aset = &W->solverSets.data[ b2_awakeSet ];
        b2BodyState* st = &aset->bodyStates.data[ body->localIndex ];
        st->linearVelocity.x = vx;
        st->linearVelocity.y = vy;
        st->angularVelocity  = w;
    }
}

void WakeAll()
{
    int si;
    for( si = b2_firstSleepingSet; si < W->solverSets.count; ++si )
    {
        b2SolverSet* s = &W->solverSets.data[ si ];
        if( s->setIndex != B2_NULL_INDEX && s->bodySims.count > 0 )
            b2WakeSolverSet( W, si );
    }
}

void SetBodyColor( b2BodyId* id, int r, int g, int b )
{
    int raw = id->index1 - 1;
    if( raw >= 0 && raw < MAX_BODIES )
    {
        gColR[raw] = r;  gColG[raw] = g;  gColB[raw] = b;
    }
}

// -----------------------------------------------------------------------------
//   scene population helpers
// -----------------------------------------------------------------------------
void MakeStaticBox( float x, float y, float hx, float hy, float angle,
                    int r, int g, int b, b2BodyId* out )
{
    b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_staticBody;
    bd.position.x = x;  bd.position.y = y;
    b2MakeRot( angle, &bd.rotation );
    b2CreateBody( W, &bd, out );
    b2Polygon box;  b2MakeBox( hx, hy, &box );
    b2ShapeDef sd;  b2DefaultShapeDef( &sd );
    b2ShapeId sid;  b2CreatePolygonShape( W, out, &sd, &box, &sid );
    SetBodyColor( out, r, g, b );
}

// drop a body from the sky; recycle the oldest when the ring is full
void SpawnDrop( float x )
{
    if( gSpawnCount == SPAWN_CAP )
    {
        // recycle: WAKE its set first (else a body sandwiched in a sleeping
        // pile leaves the pile floating -- plan finding F2), then destroy
        b2BodyId old;
        old.index1     = gSpawnIdx1[ gSpawnHead ];
        old.world0     = 0;
        old.generation = gSpawnGen[ gSpawnHead ];
        WakeBody( &old );
        b2DestroyBody( W, &old );
        gSpawnHead = ( gSpawnHead + 1 ) % SPAWN_CAP;
        gSpawnCount = gSpawnCount - 1;
    }

    b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
    bd.position.x = x;  bd.position.y = 12.6;
    bd.linearVelocity.x = 0.0;  bd.linearVelocity.y = -2.0;
    b2BodyId nb;  b2CreateBody( W, &bd, &nb );

    b2ShapeDef sd;  b2DefaultShapeDef( &sd );

    if( gSpawnKind == 1 )
    {
        // crate
        sd.density = 1.0;  sd.friction = 0.7;  sd.restitution = 0.05;
        b2Polygon box;  b2MakeBox( 0.38, 0.38, &box );
        b2ShapeId sid;  b2CreatePolygonShape( W, &nb, &sd, &box, &sid );
        SetBodyColor( &nb, 205, 140, 70 );
    }
    else
    {
        // bouncy ball
        sd.density = 0.8;  sd.friction = 0.3;  sd.restitution = 0.85;
        b2Circle ball;  ball.center.x = 0.0;  ball.center.y = 0.0;  ball.radius = 0.34;
        b2ShapeId sid;  b2CreateCircleShape( W, &nb, &sd, &ball, &sid );
        if( gSpawnKind == 0 )  SetBodyColor( &nb, 255,  90, 190 );
        else                   SetBodyColor( &nb, 120, 255,  90 );
    }
    gSpawnKind = ( gSpawnKind + 1 ) % 3;

    int tail = ( gSpawnHead + gSpawnCount ) % SPAWN_CAP;
    gSpawnIdx1[ tail ] = nb.index1;
    gSpawnGen[ tail ]  = nb.generation;
    gSpawnCount = gSpawnCount + 1;
}

// put a flipped/stranded car back on its wheels at the start position
// (wake first -- SetTransform alone does not wake a sleeper, plan finding F3)
void RescueCar()
{
    PokeVelocity( &gCarId,    0.0, 0.0, 0.0 );
    PokeVelocity( &gWheelIdL, 0.0, 0.0, 0.0 );
    PokeVelocity( &gWheelIdR, 0.0, 0.0, 0.0 );

    b2Rot ident;  ident.c = 1.0;  ident.s = 0.0;
    b2Vec2 p;

    p.x = -11.0;  p.y = 1.6;
    b2Body_SetTransform( W, &gCarId, &p, &ident );
    p.x = -11.75; p.y = 1.05;
    b2Body_SetTransform( W, &gWheelIdL, &p, &ident );
    p.x = -10.25; p.y = 1.05;
    b2Body_SetTransform( W, &gWheelIdR, &p, &ident );
}

// -----------------------------------------------------------------------------
//   rendering
// -----------------------------------------------------------------------------

// pose to draw: lerp between the pre-step snapshot and the current state.
// alpha 1.0 = current exactly; rotation is nlerp'd (lerp c,s + renormalize)
void GetPose( int rawId, b2BodySim* sim, float alpha,
              float* px, float* py, float* pc, float* ps )
{
    float cx = sim->center.x;
    float cy = sim->center.y;
    float qc = sim->transform.q.c;
    float qs = sim->transform.q.s;

    if( alpha < 1.0 && rawId >= 0 && rawId < MAX_BODIES )
    {
        cx = gPrevX[rawId] + ( cx - gPrevX[rawId] ) * alpha;
        cy = gPrevY[rawId] + ( cy - gPrevY[rawId] ) * alpha;
        qc = gPrevC[rawId] + ( qc - gPrevC[rawId] ) * alpha;
        qs = gPrevS[rawId] + ( qs - gPrevS[rawId] ) * alpha;
        float len2 = qc * qc + qs * qs;
        if( len2 > 0.0001 )
        {
            float len = sqrt( len2 );
            qc = qc / len;
            qs = qs / len;
        }
    }
    *px = cx;  *py = cy;  *pc = qc;  *ps = qs;
}

// record every live body's pose (called right before each physics step)
void SnapshotPoses()
{
    int i;
    for( i = 0; i < W->bodies.count && i < MAX_BODIES; ++i )
    {
        b2Body* body = &W->bodies.data[ i ];
        if( body->id == B2_NULL_INDEX )
            continue;
        b2BodySim* sim = b2GetBodySim( W, body );
        gPrevX[i] = sim->center.x;
        gPrevY[i] = sim->center.y;
        gPrevC[i] = sim->transform.q.c;
        gPrevS[i] = sim->transform.q.s;
    }
}

void DrawAllBodies( float alpha )
{
    int i;
    for( i = 0; i < W->bodies.count; ++i )
    {
        b2Body* body = &W->bodies.data[ i ];
        if( body->id == B2_NULL_INDEX )
            continue;

        b2BodySim* sim = b2GetBodySim( W, body );
        bool asleep = ( body->setIndex >= b2_firstSleepingSet );

        int r = 180;  int g = 180;  int b = 180;
        if( i < MAX_BODIES )
        {
            r = gColR[i];  g = gColG[i];  b = gColB[i];
        }
        if( asleep )
        {
            r = r / 3;  g = g / 3;  b = b / 3;
        }
        int color = make_color_rgb( r, g, b );

        float px;  float py;  float qc;  float qs;
        GetPose( i, sim, alpha, &px, &py, &qc, &qs );

        int shapeId = body->headShapeId;
        while( shapeId != B2_NULL_INDEX )
        {
            b2Shape* shape = &W->shapes.data[ shapeId ];

            if( shape->type == b2_polygonShape )
            {
                // all demo polygons are b2MakeBox boxes: vertex 2 = (+hx,+hy)
                // (body origin == centroid for every body here, so px,py works)
                b2Vec2 v2 = shape->polygon.vertices[2];
                DrawWorldBox( px, py, v2.x, v2.y, qc, qs, color );
            }
            else if( shape->type == b2_circleShape )
            {
                float rad = shape->circle.radius;
                set_multiply_color( color );
                draw_filled_circle( ScreenX( px ), ScreenY( py ), (int)( rad * PPM ) );
                // spoke so the roll/spin is visible
                int spokeCol = make_color_rgb( r / 2, g / 2, b / 2 );
                DrawWorldLine( px, py, px + qc * rad, py + qs * rad, spokeCol );
            }

            shapeId = shape->nextShapeId;
        }

        if( asleep )
        {
            set_multiply_color( color_lightgray );
            print_at( ScreenX( px ) - 4, ScreenY( py ) - 6, "z" );
        }
    }
}

// one full display frame, everything at the interpolated pose
void DrawScene( float alpha )
{
    int fps = 60;
    if( gWorkCyc > 500000 )
        fps = 30000000 / gWorkCyc;

    clear_screen( make_color_rgb( 10, 12, 26 ) );

    // rope first (behind the ball)
    b2Body* ballBody = b2GetBodyFullId( W, &gBallId );
    b2BodySim* ballSim = b2GetBodySim( W, ballBody );
    float bpx;  float bpy;  float bqc;  float bqs;
    GetPose( gBallId.index1 - 1, ballSim, alpha, &bpx, &bpy, &bqc, &bqs );
    DrawWorldLine( gRopeAnchorX, gRopeAnchorY, bpx, bpy, make_color_rgb( 190, 190, 200 ) );

    // suspension struts (chassis anchors -> wheel centers)
    b2Body* carBody = b2GetBodyFullId( W, &gCarId );
    b2BodySim* carSim = b2GetBodySim( W, carBody );
    float cpx;  float cpy;  float cqc;  float cqs;
    GetPose( gCarId.index1 - 1, carSim, alpha, &cpx, &cpy, &cqc, &cqs );
    float axL = cpx + cqc * -0.75 - cqs * -0.55;
    float ayL = cpy + cqs * -0.75 + cqc * -0.55;
    float axR = cpx + cqc *  0.75 - cqs * -0.55;
    float ayR = cpy + cqs *  0.75 + cqc * -0.55;
    b2Body* wlB = b2GetBodyFullId( W, &gWheelIdL );  b2BodySim* wlS = b2GetBodySim( W, wlB );
    b2Body* wrB = b2GetBodyFullId( W, &gWheelIdR );  b2BodySim* wrS = b2GetBodySim( W, wrB );
    float wlx;  float wly;  float wrx;  float wry;  float wtc;  float wts;
    GetPose( gWheelIdL.index1 - 1, wlS, alpha, &wlx, &wly, &wtc, &wts );
    GetPose( gWheelIdR.index1 - 1, wrS, alpha, &wrx, &wry, &wtc, &wts );
    int strutCol = make_color_rgb( 0, 130, 160 );
    DrawWorldLine( axL, ayL, wlx, wly, strutCol );
    DrawWorldLine( axR, ayR, wrx, wry, strutCol );

    DrawAllBodies( alpha );

    // car cab (pure decoration, follows the chassis pose)
    float cabx = cpx + cqc * -0.15 - cqs * 0.45;
    float caby = cpy + cqs * -0.15 + cqc * 0.45;
    DrawWorldBox( cabx, caby, 0.45, 0.18, cqc, cqs, make_color_rgb( 90, 235, 255 ) );

    // spinner hub cap
    set_multiply_color( color_gray );
    draw_filled_circle( ScreenX( 1.5 ), ScreenY( 3.3 ), 4 );

    // laser (hold B): origin follows the interpolated car pose; the cast runs
    // against the real (current) world -- the difference is sub-pixel
    if( gamepad_button_b() > 0 )
    {
        b2Vec2 o;
        o.x = cpx;
        o.y = cpy + 0.5;
        float ang = atan2( cqs, cqc );
        if( gFaceDir > 0 )  ang = ang + 0.55;
        else                ang = ang + pi - 0.55;
        b2Vec2 tr;
        tr.x = cos( ang ) * 26.0;
        tr.y = sin( ang ) * 26.0;
        b2CastOutput hit;
        int hitShape = b2World_CastRayClosest( W, &o, &tr, NULL, &hit );
        float ex;  float ey;
        if( hitShape != B2_NULL_INDEX )
        {
            ex = hit.point.x;  ey = hit.point.y;
        }
        else
        {
            ex = o.x + tr.x;  ey = o.y + tr.y;
        }
        DrawWorldLine( o.x, o.y, ex, ey, make_color_rgb( 255, 255, 90 ) );
        if( hitShape != B2_NULL_INDEX )
        {
            set_multiply_color( color_white );
            draw_circle( ScreenX( ex ), ScreenY( ey ), 5 );
            DrawWorldLine( ex - 0.2, ey, ex + 0.2, ey, color_red );
            DrawWorldLine( ex, ey - 0.2, ex, ey + 0.2, color_red );
        }
    }

    // gravity-flip force field along the ceiling's underside
    if( gFlipped )
    {
        set_multiply_color( color_cyan );
        draw_horizontal_line( 8, ScreenY( 13.7 ), 632 );
        set_multiply_color( color_white );
        print_at( 250, 40, "!! GRAVITY INVERTED !!" );
    }

    // ---- HUD ----
    set_multiply_color( color_white );
    print_at( 8, 4, "VIRCONBOX2D MEGADEMO" );

    print_at( 8, 344, "DPAD DRIVE   A DROP   B LASER   X WRECK   Y GRAVITY   START RESCUE" );

    print_at( 232, 4, "FPS" );
    ShowInt( 262, 4, fps );
    print_at( 292, 4, "PHYS 30HZ" );

    // cycle budget bar: budget = 500k/loop (2 display frames at 30 Hz);
    // full bar = 1M cycles, white tick = the 500k budget line
    int barW = gStepCyc / 5556;                // 1,000,000 cyc -> 180 px
    if( barW > 180 )  barW = 180;
    int barCol = color_green;
    if( gStepCyc > 500000 )  barCol = color_red;
    set_multiply_color( color_darkgray );
    draw_filled_rectangle( 448, 6, 448 + 180, 14 );
    set_multiply_color( barCol );
    if( barW > 0 )
        draw_filled_rectangle( 448, 6, 448 + barW, 14 );
    set_multiply_color( color_white );
    draw_vertical_line( 448 + 90, 4, 16 );
    print_at( 380, 4, "CYCLES" );

    b2SolverSet* aset = &W->solverSets.data[ b2_awakeSet ];
    print_at( 8, 22, "AWAKE" );
    ShowInt( 56, 22, aset->bodySims.count );
    print_at( 96, 22, "OF" );
    ShowInt( 120, 22, b2GetIdCount( &W->bodyIdPool ) );
    print_at( 160, 22, "SUBSTEPS" );      // governor state: 4 = full quality
    ShowInt( 240, 22, gSubSteps );
}

void main()
{
    b2World world;
    W = &world;
    b2CreateWorld( W );
    world.gravity.x = 0.0;
    world.gravity.y = -10.0;
    world.enableSleep = true;          // Phase C, opt-in

    int i;
    for( i = 0; i < MAX_BODIES; ++i )
    {
        gColR[i] = 180;  gColG[i] = 180;  gColB[i] = 180;
    }
    gSpawnCount = 0;  gSpawnHead = 0;  gSpawnKind = 0;
    gFaceDir = 1;     gFlipped = false;
    gStepCyc = 0;     gWorkCyc = 0;
    gSubSteps = 4;

    select_gamepad( 0 );

    // ---- arena --------------------------------------------------------------
    b2BodyId tmp;
    MakeStaticBox(   0.0, -0.5, 13.6, 0.5, 0.0,  70,  85, 105, &tmp );   // floor
    MakeStaticBox( -13.1,  2.2,  0.4, 2.7, 0.0,  70,  85, 105, &tmp );   // left wall
    MakeStaticBox(  13.1,  2.2,  0.4, 2.7, 0.0,  70,  85, 105, &tmp );   // right wall
    MakeStaticBox(   0.0, 14.1, 13.6, 0.4, 0.0,  70,  85, 105, &tmp );   // ceiling (off-screen catcher)
    MakeStaticBox(  -6.5,  0.55, 2.0, 0.2, 0.22, 110, 150, 185, &tmp );  // jump ramp

    // ---- car: chassis + 2 suspension wheels (wheel joints w/ spring+motor) ---
    {
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = -11.0;  bd.position.y = 1.6;
        b2CreateBody( W, &bd, &gCarId );
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );
        sd.density = 0.6;  sd.friction = 0.4;
        b2Polygon chassis;  b2MakeBox( 1.1, 0.3, &chassis );
        b2ShapeId sid;  b2CreatePolygonShape( W, &gCarId, &sd, &chassis, &sid );
        SetBodyColor( &gCarId, 0, 205, 255 );

        b2Circle wc;  wc.center.x = 0.0;  wc.center.y = 0.0;  wc.radius = 0.4;
        b2ShapeDef wsd;  b2DefaultShapeDef( &wsd );
        wsd.density = 1.2;  wsd.friction = 1.4;         // grippy tires

        b2BodyDef wbdL;  b2DefaultBodyDef( &wbdL );  wbdL.type = b2_dynamicBody;
        wbdL.position.x = -11.75;  wbdL.position.y = 1.05;
        b2CreateBody( W, &wbdL, &gWheelIdL );
        b2ShapeId wsL;  b2CreateCircleShape( W, &gWheelIdL, &wsd, &wc, &wsL );
        SetBodyColor( &gWheelIdL, 230, 230, 240 );

        b2BodyDef wbdR;  b2DefaultBodyDef( &wbdR );  wbdR.type = b2_dynamicBody;
        wbdR.position.x = -10.25;  wbdR.position.y = 1.05;
        b2CreateBody( W, &wbdR, &gWheelIdR );
        b2ShapeId wsR;  b2CreateCircleShape( W, &gWheelIdR, &wsd, &wc, &wsR );
        SetBodyColor( &gWheelIdR, 230, 230, 240 );

        // suspension axis = frameA local +x rotated to point UP (90 deg)
        b2WheelJointDef wj;  b2DefaultWheelJointDef( &wj );
        wj.bodyIdA = gCarId;
        wj.bodyIdB = gWheelIdL;
        wj.localFrameA.p.x = -0.75;  wj.localFrameA.p.y = -0.55;
        wj.localFrameA.q.c = 0.0;    wj.localFrameA.q.s = 1.0;
        wj.enableSpring = true;   wj.hertz = 4.0;  wj.dampingRatio = 0.7;
        wj.enableLimit  = true;   wj.lowerTranslation = -0.3;  wj.upperTranslation = 0.3;
        wj.enableMotor  = true;   wj.motorSpeed = 0.0;  wj.maxMotorTorque = 34.0;
        b2CreateWheelJointDef( W, &wj, &gMotorL );

        wj.bodyIdB = gWheelIdR;
        wj.localFrameA.p.x = 0.75;
        b2CreateWheelJointDef( W, &wj, &gMotorR );
    }

    // ---- spinner: motorized revolute bar on a static hub ---------------------
    {
        b2BodyDef hd;  b2DefaultBodyDef( &hd );  hd.type = b2_staticBody;
        hd.position.x = 1.5;  hd.position.y = 3.3;
        b2BodyId hub;  b2CreateBody( W, &hd, &hub );

        b2BodyDef sdd;  b2DefaultBodyDef( &sdd );  sdd.type = b2_dynamicBody;
        sdd.position.x = 1.5;  sdd.position.y = 3.3;
        b2BodyId bar;  b2CreateBody( W, &sdd, &bar );
        b2ShapeDef bsd;  b2DefaultShapeDef( &bsd );
        b2Polygon barBox;  b2MakeBox( 1.05, 0.13, &barBox );
        b2ShapeId bsid;  b2CreatePolygonShape( W, &bar, &bsd, &barBox, &bsid );
        SetBodyColor( &bar, 255, 130, 0 );

        b2RevoluteJointDef rj;  b2DefaultRevoluteJointDef( &rj );
        rj.bodyIdA = hub;
        rj.bodyIdB = bar;
        rj.enableMotor = true;
        rj.motorSpeed = 4.0;
        rj.maxMotorTorque = 400.0;
        b2JointId rjid;  b2CreateRevoluteJointDef( W, &rj, &rjid );
    }

    // ---- box tower (it will settle and fall ASLEEP -- watch it dim) ----------
    for( i = 0; i < 5; ++i )
    {
        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 5.3;
        bd.position.y = 0.46 + i * 0.91;
        b2BodyId bb;  b2CreateBody( W, &bd, &bb );
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );
        b2Polygon box;  b2MakeBox( 0.45, 0.45, &box );
        b2ShapeId sid;  b2CreatePolygonShape( W, &bb, &sd, &box, &sid );
        if( i % 2 == 0 )  SetBodyColor( &bb, 245, 205, 60 );
        else              SetBodyColor( &bb, 225, 165, 40 );
    }

    // ---- wrecking ball on a rigid distance-joint rope -------------------------
    {
        gRopeAnchorX = 8.6;  gRopeAnchorY = 7.6;

        b2BodyDef ad;  b2DefaultBodyDef( &ad );  ad.type = b2_staticBody;
        ad.position.x = gRopeAnchorX;  ad.position.y = gRopeAnchorY;
        b2BodyId anchor;  b2CreateBody( W, &ad, &anchor );   // shapeless anchor

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 8.6;  bd.position.y = 3.0;
        b2CreateBody( W, &bd, &gBallId );
        b2ShapeDef sd;  b2DefaultShapeDef( &sd );
        sd.density = 5.0;  sd.friction = 0.4;  sd.restitution = 0.1;
        b2Circle ball;  ball.center.x = 0.0;  ball.center.y = 0.0;  ball.radius = 0.55;
        b2ShapeId sid;  b2CreateCircleShape( W, &gBallId, &sd, &ball, &sid );
        SetBodyColor( &gBallId, 255, 70, 70 );

        b2DistanceJointDef dj;  b2DefaultDistanceJointDef( &dj );
        dj.bodyIdA = anchor;
        dj.bodyIdB = gBallId;
        dj.length = 4.6;
        b2JointId djid;  b2CreateDistanceJointDef( W, &dj, &djid );
    }

    // ---- main loop ------------------------------------------------------------
    // PHYSICS AT 30 HZ, RENDER AT 60 FPS WITH INTERPOLATION (plan item P2.6):
    // each loop = one dt=1/30 step + TWO display frames. Frame A draws the
    // current state, frame B draws every pose lerped HALFWAY toward the next
    // state (SnapshotPoses + GetPose), so motion updates every 60 Hz frame
    // while physics pays only 30 Hz. Loop order stays DRAW-THEN-STEP (the
    // flicker fix): the emulator presents the framebuffer at every 60 Hz tick
    // regardless of where the CPU is, so the step only ever runs while a
    // COMPLETE picture sits in the buffer.
    float dt = 1.0 / 30.0;
    int frame = 0;

    while( true )
    {
        frame = frame + 1;

        // ---- input ----
        float motorSpd = 0.0;
        if( gamepad_left()  > 0 )  { motorSpd =  28.0;  gFaceDir = -1; }
        if( gamepad_right() > 0 )  { motorSpd = -28.0;  gFaceDir =  1; }
        if( motorSpd != 0.0 )
            WakeBody( &gCarId );                    // asleep car ignores its motor
        b2WheelJoint_SetMotorSpeed( W, &gMotorL, motorSpd );
        b2WheelJoint_SetMotorSpeed( W, &gMotorR, motorSpd );

        // button counters tick at 60 Hz but this loop samples every 2 frames,
        // so "just pressed" is a counter value of 1 OR 2 (plain ==1 can miss)
        int btnA = gamepad_button_a();
        if( btnA == 1 || btnA == 2 )
        {
            // cycle drop points over the arena
            float dropX = -2.5 + 2.1 * ( frame % 5 ) - 2.0;
            SpawnDrop( dropX );
        }

        int btnX = gamepad_button_x();
        if( btnX == 1 || btnX == 2 || frame == 150 )    // attract-mode auto kick
            PokeVelocity( &gBallId, -11.0, 2.5, 0.0 );

        if( gamepad_button_y() > 0 )
        {
            if( gFlipped == false )
            {
                gFlipped = true;
                WakeAll();                          // gravity change won't wake (F2-class)
                world.gravity.y = 7.0;
            }
        }
        else if( gFlipped )
        {
            gFlipped = false;
            WakeAll();
            world.gravity.y = -10.0;
        }

        int btnS = gamepad_button_start();
        if( btnS == 1 || btnS == 2 )
            RescueCar();

        // ---- FRAME A: draw the current state (alpha = 1), then step while the
        // complete picture sits in the framebuffer (flicker-safe order) ----
        int t0 = CycNow();
        DrawScene( 1.0 );

        SnapshotPoses();                  // prev := current, for frame B's lerp
        int t1 = CycNow();
        b2World_Step( W, dt, gSubSteps );
        int t2 = CycNow();
        gStepCyc = t2 - t1;
        gWorkCyc = t2 - t0;

        // adaptive governor: shed a substep while the step runs hot, win it
        // back when it cools (hysteresis gap so it doesn't oscillate)
        if( gStepCyc > 340000 && gSubSteps > 2 )
            gSubSteps = gSubSteps - 1;
        else if( gStepCyc < 200000 && gSubSteps < 4 )
            gSubSteps = gSubSteps + 1;

        end_frame();

        // ---- FRAME B: draw every pose halfway between the old and the new
        // state -> 60 fps motion from 30 Hz physics. If the step already
        // consumed BOTH display slots (end_frame returned a whole frame late),
        // skip the interpolated frame entirely: the display gracefully holds
        // frame A (a 30 fps moment) instead of slipping to 20 fps. ----
        if( CycNow() - t0 < 400000 )
        {
            DrawScene( 0.5 );
            end_frame();
        }
    }
}
