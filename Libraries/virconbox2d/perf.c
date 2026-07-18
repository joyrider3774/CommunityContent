// =============================================================================
//   VirconBox2D profiler ROM  (Phase B item 7 -- PLAN_FOR_OPUS.md 5.1)
// =============================================================================
//   Steps a standard falling-boxes scene at three sizes (10/20/40 boxes) and
//   prints per-phase cycle counts (pairing / collide / solve) plus the total
//   per step, measured against the 250,000-cycle/frame budget. The user reads
//   the numbers off the screen exactly like the green/red harness loop.
//
//   These scenes are committed as regression BENCHMARKS: rebuild + rerun after
//   each performance change (fat AABBs, persistent scratch, const precompute)
//   and compare the numbers.
//
//   WHY the monotonic clock: get_cycle_counter() counts CPU cycles WITHIN the
//   current frame and resets to 0 every 250,000 cycles (confirmed from the
//   emulator: RunNextFrame runs exactly CyclesPerFrame=15000000/60 cycles then
//   ChangeFrame zeroes the cycle counter and bumps the frame counter -- the
//   frame advances on a fixed cycle budget whether or not the CPU waits). A
//   40-box b2Solve with 4 substeps easily exceeds 250k cycles and spans a frame
//   boundary, so a single-register delta would go garbage. Combining
//   frame*250000 + cycle gives an exact monotonic cycle clock.
//
//   Build:  (bash)  bash build.sh perf
//           (pwsh)  compile.exe perf.c ... -> assemble -> packrom perf.xml
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

// -----------------------------------------------------------------------------
//   Monotonic cycle clock (frame-boundary safe)
// -----------------------------------------------------------------------------
// The console budget is 250,000 cycles/frame. FrameCounter and CycleCounter are
// two separate hardware reads; if the frame ticks over BETWEEN them we would get
// a +-250000 phantom glitch. Re-read the cycle counter if the frame moved so a
// single consistent (frame, cycle) pair is used.
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

// -----------------------------------------------------------------------------
//   Display helpers (BIOS font, no assets -- same idiom as the harnesses)
// -----------------------------------------------------------------------------
void ShowInt( int x, int y, int value )
{
    int[20] s;
    itoa( value, s, 10 );
    print_at( x, y, s );
}

// -----------------------------------------------------------------------------
//   Standard benchmark scene: a static floor + N dynamic 1x1 boxes arranged in
//   a 5-wide grid just above it, dropped a short distance so they pile and
//   settle. Deterministic layout -> repeatable numbers across builds.
// -----------------------------------------------------------------------------
void BuildScene( b2World* world, int N )
{
    b2CreateWorld( world );
    world->gravity.x = 0.0;  world->gravity.y = -10.0;

    b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

    // wide static floor, top at y = 0.5
    b2Polygon floorBox;  b2MakeBox( 8.0, 0.5, &floorBox );
    b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
    fdef.position.x = 0.0;  fdef.position.y = 0.0;
    b2BodyId bf;  b2CreateBody( world, &fdef, &bf );
    b2ShapeId sf;  b2CreatePolygonShape( world, &bf, &sdef, &floorBox, &sf );

    // N dynamic 1x1 boxes in a 5-column grid, centred over x=0
    int cols = 5;
    float spacing = 1.05;
    int i;
    for( i = 0; i < N; i++ )
    {
        int col = i % cols;
        int row = i / cols;
        float x = ( col - 2 ) * spacing;                 // cols {-2..2} * spacing
        float y = 1.2 + row * spacing;                   // first row just above floor top

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = x;  bdef.position.y = y;
        b2BodyId bid;  b2CreateBody( world, &bdef, &bid );
        b2ShapeId sid;  b2CreatePolygonShape( world, &bid, &sdef, &box, &sid );
    }
}

// One full step, split into its three phases (mirrors b2World_Step). dt/substeps
// fixed to the console default so the numbers are comparable across scenes.
// -----------------------------------------------------------------------------
//   Measure a scene: build, warm up so contacts form and the pile settles, then
//   average per-phase cycle costs over a few representative steps.
// -----------------------------------------------------------------------------
float g_dt = 0.0;   // set in main (1.0/60.0)

void MeasureScene( int N, int* outContacts, int* outPair, int* outColl, int* outSolve )
{
    b2World world;  BuildScene( &world, N );

    int warmup  = 40;
    int measure = 4;
    int k;

    // warm up (let boxes fall, contacts form, pile settle)
    for( k = 0; k < warmup; k++ )
        b2World_Step( &world, g_dt, 4 );

    // rebase the clock so absolute cycle values during measurement stay small
    g_baseFrame = get_frame_counter();

    int pairSum  = 0;
    int collSum  = 0;
    int solveSum = 0;
    int t0;

    for( k = 0; k < measure; k++ )
    {
        t0 = CycNow();  b2UpdateBroadPhasePairs( &world );  pairSum  += CycNow() - t0;
        t0 = CycNow();  b2Collide( &world );                collSum  += CycNow() - t0;
        t0 = CycNow();  b2Solve( &world, g_dt, 4 );         solveSum += CycNow() - t0;
    }

    *outPair     = pairSum  / measure;
    *outColl     = collSum  / measure;
    *outSolve    = solveSum / measure;
    *outContacts = world.solverSets.data[ b2_awakeSet ].contactSims.count;

    b2DestroyWorld( &world );
}

// -----------------------------------------------------------------------------
void main()
{
    // black screen while the (multi-frame) measurement runs; table drawn once at
    // the end. Mirrors the harnesses: compute fully in main(), draw the verdict
    // once. A blank/garbage freeze => a fault mid-measure; a table => success.
    clear_screen( color_black );

    g_dt = 1.0 / 60.0;

    int ct10;  int pair10;  int coll10;  int solve10;
    int ct20;  int pair20;  int coll20;  int solve20;
    int ct40;  int pair40;  int coll40;  int solve40;

    MeasureScene( 10, &ct10, &pair10, &coll10, &solve10 );
    MeasureScene( 20, &ct20, &pair20, &coll20, &solve20 );
    MeasureScene( 40, &ct40, &pair40, &coll40, &solve40 );

    int tot10 = pair10 + coll10 + solve10;
    int tot20 = pair20 + coll20 + solve20;
    int tot40 = pair40 + coll40 + solve40;

    // ---- render the table once ----
    set_multiply_color( color_white );
    clear_screen( color_black );

    int cx0 = 20;    // label column
    int cx1 = 240;   // 10-box column
    int cx2 = 380;   // 20-box column
    int cx3 = 520;   // 40-box column

    print_at( cx0,  20, "VIRCONBOX2D PROFILER   BUDGET/FRAME = 250000 CYCLES" );

    print_at( cx1,  55, "10 BOX" );
    print_at( cx2,  55, "20 BOX" );
    print_at( cx3,  55, "40 BOX" );

    print_at( cx0,  85, "CONTACTS" );
    ShowInt(  cx1,  85, ct10 );   ShowInt( cx2, 85, ct20 );   ShowInt( cx3, 85, ct40 );

    print_at( cx0, 115, "PAIRING" );
    ShowInt(  cx1, 115, pair10 );  ShowInt( cx2, 115, pair20 );  ShowInt( cx3, 115, pair40 );

    print_at( cx0, 145, "COLLIDE" );
    ShowInt(  cx1, 145, coll10 );  ShowInt( cx2, 145, coll20 );  ShowInt( cx3, 145, coll40 );

    print_at( cx0, 175, "SOLVE" );
    ShowInt(  cx1, 175, solve10 );  ShowInt( cx2, 175, solve20 );  ShowInt( cx3, 175, solve40 );

    print_at( cx0, 205, "TOTAL/STEP" );
    ShowInt(  cx1, 205, tot10 );  ShowInt( cx2, 205, tot20 );  ShowInt( cx3, 205, tot40 );

    print_at( cx0, 235, "PCT OF FRAME" );
    ShowInt(  cx1, 235, tot10 / 2500 );  ShowInt( cx2, 235, tot20 / 2500 );  ShowInt( cx3, 235, tot40 / 2500 );

    print_at( cx0, 285, "(numbers = CPU cycles, averaged over 4 settled steps)" );

    // hold the table on screen
    while( true )
        end_frame();
}
