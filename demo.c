// =============================================================================
//   VirconBox2D demo ROM  (Phase G taste -- "it's real" artifact)
// =============================================================================
//   Asset-free LIVE physics demo: a column of dynamic boxes falls the full
//   height of the screen onto a static floor (the "ground") and stacks, at
//   60 fps. Vircon32 has no primitive drawing without textures, so each body is
//   a BIOS-font marker at its world->screen-mapped position (clear_screen +
//   print_at + end_frame game loop). An on-screen FPS counter is derived from
//   the real per-step cycle cost vs the 250,000-cycle frame budget.
//
//   Build:  (bash)  bash build.sh demo
//           (pwsh)  compile.exe demo.c ... -> assemble -> packrom demo.xml
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
#include "port/b2_solver.h"

// world->screen mapping: origin near the screen bottom, y-up, PPM px/meter.
// ORIGIN_Y = 351 puts the floor top (world y=0.5) at screen y ~ 340 (the ground),
// so boxes dropped high fall almost the full 360px height.
#define ORIGIN_X 320
#define ORIGIN_Y 351
#define PPM      22.0

int ScreenX( float wx )
{
    return (int)( ORIGIN_X + wx * PPM );
}

int ScreenY( float wy )
{
    return (int)( ORIGIN_Y - wy * PPM );
}

void ShowInt( int x, int y, int value )
{
    int[20] s;
    itoa( value, s, 10 );
    print_at( x, y, s );
}

// monotonic cycle clock (emulator runs a fixed 250000 cycles/frame). Frame-
// boundary-guarded so a tick between the two reads can't inject a +-250000 glitch.
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

void main()
{
    b2World world;  b2CreateWorld( &world );
    world.gravity.x = 0.0;  world.gravity.y = -10.0;

    b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

    // static floor (the ground): half-width 6, top at y = 0.5
    b2Polygon floorBox;  b2MakeBox( 6.0, 0.5, &floorBox );
    b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
    fdef.position.x = 0.0;  fdef.position.y = 0.0;
    b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
    b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

    // a tall column of 6 dynamic 1x1 boxes (slight x jitter for a lively stack)
    // dropped high so they fall the full screen height down to the ground.
    b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
    float[6] jitterX;
    jitterX[0] = 0.10;  jitterX[1] = -0.12;  jitterX[2] = 0.08;
    jitterX[3] = -0.06; jitterX[4] = 0.11;   jitterX[5] = -0.09;

    // DOGFOOD (P1.1): keep each dynamic body's PUBLIC handle in a heap array and
    // draw via b2Body_GetWorldCenter -- no reaching into world.solverSets. Heap-
    // pointer array of multi-word structs: variable index is confirmed safe.
    b2BodyId* bodyIds = NULL;
    int bodyIdCap = 0;
    int bodyIdCount = 0;

    int i;
    for( i = 0; i < 6; i++ )
    {
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.position.x = jitterX[i];
        cdef.position.y = 6.0 + i * 1.4;      // high column -> long fall to the ground
        b2BodyId bc;  b2CreateBody( &world, &cdef, &bc );
        b2ShapeId sc;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sc );
        bodyIds = b2GrowArray( bodyIds, &bodyIdCap, bodyIdCount + 1, sizeof( b2BodyId ) );
        bodyIds[ bodyIdCount ] = bc;  bodyIdCount = bodyIdCount + 1;
    }

    float dt = 1.0 / 60.0;
    int  frame = 0;
    bool launched = false;

    // live loop: one physics step per displayed frame, with a measured FPS
    while( true )
    {
        frame = frame + 1;

        // once the tower has settled, hurl a box in from the left to knock it over.
        // gravityScale 0 -> it flies straight and fast for a reliable collapse.
        if( frame == 180 && launched == false )
        {
            launched = true;
            b2BodyDef pd;  b2DefaultBodyDef( &pd );  pd.type = b2_dynamicBody;
            pd.position.x = -10.0;  pd.position.y = 2.0;   // off the floor, tower-low height
            pd.linearVelocity.x = 25.0;  pd.linearVelocity.y = 0.0;
            pd.gravityScale = 0.0;
            b2BodyId pb;  b2CreateBody( &world, &pd, &pb );
            b2ShapeId ps;  b2CreatePolygonShape( &world, &pb, &sdef, &box, &ps );
            bodyIds = b2GrowArray( bodyIds, &bodyIdCap, bodyIdCount + 1, sizeof( b2BodyId ) );
            bodyIds[ bodyIdCount ] = pb;  bodyIdCount = bodyIdCount + 1;
        }

        int t0 = CycNow();
        b2World_Step( &world, dt, 4 );
        int stepCyc = CycNow() - t0;

        // one step runs per displayed frame; the emulator caps display at 60 fps,
        // so effective fps = min(60, 15,000,000 / stepCyc) (a step over 250k cyc
        // overruns its frame and drops the rate).
        int fps = 60;
        if( stepCyc > 250000 )
            fps = 15000000 / stepCyc;

        clear_screen( color_black );
        set_multiply_color( color_white );

        print_at( 12, 10, "VIRCONBOX2D -- LIVE PHYSICS" );
        print_at( 12, 28, "FPS" );         ShowInt( 70,  28, fps );
        print_at( 130, 28, "STEP CYC" );   ShowInt( 230, 28, stepCyc );
        if( launched == false )
            print_at( 12, 46, "TOWER SETTLING..." );
        else
            print_at( 12, 46, "INCOMING BOX -> COLLAPSE!" );

        // draw the ground as a row of markers along the floor's top edge
        float fx;
        for( fx = -6.0; fx <= 6.0; fx = fx + 0.5 )
            print_at( ScreenX( fx ), ScreenY( 0.5 ), "=" );

        // draw each dynamic body via the PUBLIC API (P1.1 dogfood): iterate the
        // stored handles, ask each for its world center. Draws sleeping bodies too
        // (GetWorldCenter reads the sim in any set), unlike the old awake-only walk.
        int k;
        for( k = 0; k < bodyIdCount; k++ )
        {
            b2Vec2 wc;  b2Body_GetWorldCenter( &world, &bodyIds[k], &wc );
            print_at( ScreenX( wc.x ), ScreenY( wc.y ), "[]" );
        }

        end_frame();
    }
}
