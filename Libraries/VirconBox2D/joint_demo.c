// =============================================================================
//   VirconBox2D joint demo ROM  (Phase E/G -- "joints are real" artifact)
// =============================================================================
//   Asset-free LIVE joint demo at 60 fps, built with the public def-based API
//   (b2*JointDef -> b2Create*JointDef):
//     - a 6-link ROPE (revolute chain) hanging from a ceiling anchor; every ~2.5s
//       its bottom link gets a horizontal kick so the rope whips and swings.
//     - a MOTORIZED WHEEL (revolute + motor) spinning steadily in the corner, drawn
//       with a rotating spoke so the spin is visible.
//   Vircon32 has no primitive drawing without textures, so bodies are BIOS-font
//   markers at their world->screen-mapped centers. FPS is derived from the real
//   per-step cycle cost vs the 250,000-cycle frame budget.
//
//   Build:  (bash)  bash build.sh joint_demo
//           (pwsh)  compile.exe joint_demo.c ... -> assemble -> packrom joint_demo.xml
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

// world->screen mapping: origin near screen center, y-up, PPM px/meter.
// (640x360 screen. Everything below is placed to sit fully inside it: the rope
// hangs top-right, the motor spins mid-left.)
#define ORIGIN_X 320
#define ORIGIN_Y 200
#define PPM      30.0

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

// monotonic cycle clock (fixed 250000 cyc/frame), frame-boundary guarded.
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

    // ---- ROPE: a ceiling anchor + a chain of 6 links joined by revolute joints --
    b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_staticBody;
    cdef.position.x = 2.5;  cdef.position.y = 4.5;
    b2BodyId ceiling;  b2CreateBody( &world, &cdef, &ceiling );

    b2Polygon linkBox;  b2MakeBox( 0.09, 0.3, &linkBox );   // thin vertical segment

    b2BodyId prev = ceiling;
    int i;
    for( i = 0; i < 6; i++ )
    {
        b2BodyDef ld;  b2DefaultBodyDef( &ld );  ld.type = b2_dynamicBody;
        ld.position.x = 2.5;  ld.position.y = 4.2 - i * 0.6;
        b2BodyId link;  b2CreateBody( &world, &ld, &link );
        b2ShapeId ls;  b2CreatePolygonShape( &world, &link, &sdef, &linkBox, &ls );

        // pin the previous body's bottom to this link's top (a hinge chain)
        b2RevoluteJointDef jd;  b2DefaultRevoluteJointDef( &jd );
        jd.bodyIdA = prev;
        jd.bodyIdB = link;
        if( i == 0 )  { jd.localFrameA.p.x = 0.0;  jd.localFrameA.p.y = 0.0; }   // ceiling center
        else          { jd.localFrameA.p.x = 0.0;  jd.localFrameA.p.y = -0.3; }  // prev link bottom
        jd.localFrameB.p.x = 0.0;  jd.localFrameB.p.y = 0.3;                     // this link top
        b2JointId jid;  b2CreateRevoluteJointDef( &world, &jd, &jid );           // handle unused (live demo)

        prev = link;
    }

    // ---- WHEEL: a static hub + a bar driven by a revolute motor ----------------
    // Placed DIRECTLY BELOW the rope so the spinning bar's tip sweeps up into the
    // lowest rope link once per half-turn -> it knocks the rope and the disturbance
    // ripples up the chain (this also exercises joint + contact solving together).
    b2BodyDef hd;  b2DefaultBodyDef( &hd );  hd.type = b2_staticBody;
    hd.position.x = 2.5;  hd.position.y = 0.0;
    b2BodyId hub;  b2CreateBody( &world, &hd, &hub );

    b2BodyDef wd;  b2DefaultBodyDef( &wd );  wd.type = b2_dynamicBody;
    wd.position.x = 2.5;  wd.position.y = 0.0;
    b2BodyId wheel;  b2CreateBody( &world, &wd, &wheel );
    b2Polygon bar;  b2MakeBox( 1.3, 0.16, &bar );          // long enough to reach the rope
    b2ShapeId ws;  b2CreatePolygonShape( &world, &wheel, &sdef, &bar, &ws );

    b2RevoluteJointDef wj;  b2DefaultRevoluteJointDef( &wj );
    wj.bodyIdA = hub;
    wj.bodyIdB = wheel;
    wj.enableMotor = true;
    wj.motorSpeed = 3.0;         // rad/s
    wj.maxMotorTorque = 500.0;
    b2JointId wjid;  b2CreateRevoluteJointDef( &world, &wj, &wjid );          // handle unused (live demo)

    float dt = 1.0 / 60.0;
    int  frame = 0;

    while( true )
    {
        frame = frame + 1;

        int t0 = CycNow();
        b2World_Step( &world, dt, 4 );
        int stepCyc = CycNow() - t0;

        int fps = 60;
        if( stepCyc > 250000 )
            fps = 15000000 / stepCyc;

        clear_screen( color_black );
        set_multiply_color( color_white );
        print_at( 12, 10, "VIRCONBOX2D -- MOTOR WHACKS ROPE" );
        print_at( 12, 28, "FPS" );        ShowInt( 70,  28, fps );
        print_at( 130, 28, "STEP CYC" );  ShowInt( 230, 28, stepCyc );

        // ceiling + hub markers
        print_at( ScreenX( 2.5 ), ScreenY( 4.5 ), "T" );
        print_at( ScreenX( 2.5 ), ScreenY( 0.0 ), "+" );

        // draw every awake dynamic body's center (rope links + spinning bar)
        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        int n = aset->bodySims.count;
        int k;
        for( k = 0; k < n; k++ )
        {
            b2BodySim* s = &aset->bodySims.data[k];
            print_at( ScreenX( s->center.x ), ScreenY( s->center.y ), "o" );
        }

        // wheel spoke: draw the bar's tip so the spin is visible
        b2BodySim* wsim = b2GetBodySim( &world, b2GetBodyFullId( &world, &wheel ) );
        b2Vec2 tip;  tip.x = 1.1;  tip.y = 0.0;
        b2Vec2 wtip;  b2RotateVector( &wsim->transform.q, &tip, &wtip );
        print_at( ScreenX( wsim->center.x + wtip.x ), ScreenY( wsim->center.y + wtip.y ), "*" );
        print_at( ScreenX( wsim->center.x - wtip.x ), ScreenY( wsim->center.y - wtip.y ), "*" );

        end_frame();
    }
}
