// =============================================================================
//   VirconBox2D sleep demo ROM  (Phase C2a taste -- "islands sleep" artifact)
// =============================================================================
//   Asset-free LIVE physics demo showcasing SLEEPING: a column of dynamic boxes
//   falls onto a static floor, stacks, and -- once each island has been slow for
//   ~0.5s -- its bodies migrate to a sleeping solver set and stop being simulated.
//   Awake bodies are drawn "[]", sleeping bodies "zz" (iterated straight out of the
//   sleeping sets), with a live AWAKE / ASLEEP tally + the per-step cycle cost so
//   you can watch the step get CHEAPER as the pile falls asleep.
//
//   NOTE: waking (C2b) isn't built yet, so this demo never drops a body onto a
//   sleeping pile -- it just lets the column settle and sleep.
//
//   Build:  bash build.sh sleep_demo
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

#define ORIGIN_X 320
#define ORIGIN_Y 351
#define PPM      22.0

int ScreenX( float wx ) { return (int)( ORIGIN_X + wx * PPM ); }
int ScreenY( float wy ) { return (int)( ORIGIN_Y - wy * PPM ); }

void ShowInt( int x, int y, int value )
{
    int[20] s;
    itoa( value, s, 10 );
    print_at( x, y, s );
}

int CycNow()
{
    int f1 = get_frame_counter();
    int c  = get_cycle_counter();
    int f2 = get_frame_counter();
    if( f1 != f2 ) { c = get_cycle_counter();  f1 = f2; }
    return f1 * 250000 + c;
}

void main()
{
    b2World world;  b2CreateWorld( &world );
    world.gravity.x = 0.0;  world.gravity.y = -10.0;
    world.enableSleep = true;                         // opt in -- the whole point

    b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

    // static floor (the ground): half-width 9, top at y = 0.5 (wide so a knocked pile
    // + the wrecker stay ON it and can come to rest -> re-sleep)
    b2Polygon floorBox;  b2MakeBox( 9.0, 0.5, &floorBox );
    b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
    fdef.position.x = 0.0;  fdef.position.y = 0.0;
    b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
    b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

    // a column of 5 dynamic 1x1 boxes with slight x jitter, dropped to stack + settle
    b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
    float[5] jitterX;
    jitterX[0] = 0.10;  jitterX[1] = -0.12;  jitterX[2] = 0.08;
    jitterX[3] = -0.06; jitterX[4] = 0.11;
    int i;
    for( i = 0; i < 5; i++ )
    {
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.position.x = jitterX[i];
        cdef.position.y = 3.0 + i * 1.2;
        b2BodyId bc;  b2CreateBody( &world, &cdef, &bc );
        b2ShapeId sc;  b2CreatePolygonShape( &world, &bc, &sdef, &box, &sc );
    }

    float dt = 1.0 / 60.0;
    int  frame = 0;
    int  launched = 0;      // how many wrecking boxes hurled so far

    while( true )
    {
        frame = frame + 1;

        // once the pile has fallen asleep, slide a box in fast along the floor to smash
        // it -> the collision WAKES the sleeping island; it knocks the stack, then the
        // whole lot re-settles on the wide floor and re-sleeps. Normal gravity + floor-
        // level launch so the wrecker itself also comes to REST (merge-only islands keep
        // it in the pile's island, so it must settle too for the island to sleep again).
        b2SolverSet* awk = &world.solverSets.data[ b2_awakeSet ];
        if( awk->bodySims.count == 0 && frame > 120 && launched < 3 &&
            ( frame % 200 ) == 0 )
        {
            launched = launched + 1;
            b2BodyDef pd;  b2DefaultBodyDef( &pd );  pd.type = b2_dynamicBody;
            pd.position.x = -8.0;  pd.position.y = 1.0;
            pd.linearVelocity.x = 12.0;  pd.linearVelocity.y = 0.0;
            b2BodyId pb;  b2CreateBody( &world, &pd, &pb );
            b2ShapeId ps;  b2CreatePolygonShape( &world, &pb, &sdef, &box, &ps );
        }

        int t0 = CycNow();
        b2World_Step( &world, dt, 4 );
        int stepCyc = CycNow() - t0;

        clear_screen( color_black );
        set_multiply_color( color_white );
        print_at( 12, 10, "VIRCONBOX2D -- ISLANDS SLEEP" );
        print_at( 12, 28, "STEP CYC" );  ShowInt( 110, 28, stepCyc );

        // ground
        float fx;
        for( fx = -9.0; fx <= 9.0; fx = fx + 0.5 )
            print_at( ScreenX( fx ), ScreenY( 0.5 ), "=" );

        // awake dynamic bodies (awake set) -> "[]"
        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        int awake = aset->bodySims.count;
        int k;
        for( k = 0; k < awake; k++ )
        {
            b2BodySim* s = &aset->bodySims.data[k];
            print_at( ScreenX( s->center.x ), ScreenY( s->center.y ), "[]" );
        }

        // sleeping bodies (every set from b2_firstSleepingSet up) -> "zz"
        int asleep = 0;
        int setIdx;
        for( setIdx = b2_firstSleepingSet; setIdx < world.solverSets.count; setIdx = setIdx + 1 )
        {
            b2SolverSet* ss = &world.solverSets.data[ setIdx ];
            if( ss->setIndex == B2_NULL_INDEX )      // freed slot (none until C2b wake)
                continue;
            int m = ss->bodySims.count;
            asleep = asleep + m;
            for( k = 0; k < m; k++ )
            {
                b2BodySim* s = &ss->bodySims.data[k];
                print_at( ScreenX( s->center.x ), ScreenY( s->center.y ), "zz" );
            }
        }

        set_multiply_color( color_white );
        print_at( 12, 46, "AWAKE" );   ShowInt( 80,  46, awake );
        print_at( 140, 46, "ASLEEP" ); ShowInt( 220, 46, asleep );
        if( awake == 0 && asleep > 0 )
            print_at( 12, 64, "PILE ASLEEP -- STEP IS CHEAP (WRECKER INCOMING)" );
        else if( awake > 0 && asleep > 0 )
            print_at( 12, 64, "SMASH! WOKEN -> RE-SETTLING" );
        else
            print_at( 12, 64, "SETTLING -> ISLANDS SLEEP AT ~0.5S REST" );

        end_frame();
    }
}
