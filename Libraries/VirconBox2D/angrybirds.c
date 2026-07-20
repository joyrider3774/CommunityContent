// =============================================================================
//   ANGRY BLOCKS -- an Angry-Birds-style one-level demo for VirconBox2D
// =============================================================================
//   Fling the yellow block-bird from the slingshot into the castle and squash
//   all three blue pigs before you run out of birds.
//
//   Controls:   dpad  = aim (drag the pull-back point)
//               A     = launch  /  while flying: end the shot early
//               START = restart the level
//
//   Build:  bash build.sh angrybirds     ->  bin/angrybirds.v32
//
//   Art: the "BasicPlatformer" atlas by Carra (Vircon32 console software),
//   packed unchanged; DefineRegions below picks the sprites out of it.
//
//   What this demo exercises beyond template.c: a real texture (png2vircon +
//   <textures> in the ROM XML), rotozoomed sprites driven by body transforms,
//   HIT EVENTS (b2ShapeDef.enableHitEvents path) used as gameplay damage, and
//   a full destroy-rebuild world reset.
// =============================================================================

#include "video.h"
#include "input.h"
#include "time.h"
#include "math.h"
#include "string.h"
#include "draw_primitives.h"
#include "vb2.h"

// --- texture regions (our ids; pixel coordinates are from the atlas) ---------
#define R_BIRD      0
#define R_PIG       1
#define R_CRATE     2
#define R_BRICK     3
#define R_GRASS     4
#define R_DIRT      5
#define R_REDX      6
#define R_BG        7
#define R_GRADIENT  8
#define R_WIN       9
#define R_LOSE     10

// --- world tuning (meters, y-up). Sprites are 40 px; at 20 px/m that is 2 m --
#define PPM         20.0
#define SPRITE_PX   40.0
#define GROUND_TOP  -7.0
#define SLING_X    -10.0
#define SLING_Y     -3.4
#define BIRD_R       0.9
#define PIG_HALF     0.9
#define MAX_PULL     2.6
#define MIN_PULL     0.6
#define POWER        8.0
#define KILL_SPEED   3.0
#define FALL_Y     -12.0

#define MAX_BLOCKS  12
#define MAX_PIGS     3
#define TOTAL_BIRDS  3

// --- game states --------------------------------------------------------------
#define ST_AIM   0
#define ST_FLY   1
#define ST_WIN   2
#define ST_LOSE  3

// --- level objects -------------------------------------------------------------
int[MAX_BLOCKS]   BlockBody;
float[MAX_BLOCKS] BlockHW;
float[MAX_BLOCKS] BlockHH;
int[MAX_BLOCKS]   BlockRegion;
int BlockCount;

int[MAX_PIGS]   PigBody;
float[MAX_PIGS] PoofX;        // red-X marker where a pig died
float[MAX_PIGS] PoofY;
int[MAX_PIGS]   PoofFrames;   // frames remaining, 0 = off
int PigCount;

int   Bird;         // -1 when no bird is in flight
int   BirdsLeft;
int   Score;
int   GameState;
float AimOX;        // pull offset from the sling anchor (negative x = pulled back)
float AimOY;
int   FlyFrames;
int   SlowFrames;

// -----------------------------------------------------------------------------
//   Texture regions
// -----------------------------------------------------------------------------
void DefineRegions()
{
    select_texture( 0 );

    // physics sprites get CENTER hotspots: draw at the body center, no offsets
    select_region( R_BIRD );     define_region_center( 162,182,  201,221 );   // yellow guy, idle
    select_region( R_PIG );      define_region_center( 285,182,  324,221 );   // blue X-X guy
    select_region( R_CRATE );    define_region_center( 1,342,    40,381 );    // wooden crate
    select_region( R_BRICK );    define_region_center( 81,302,   120,341 );   // stone bricks
    select_region( R_REDX );     define_region_center( 1,182,    40,221 );    // red X marker

    // scenery tiles draw from the top-left
    select_region( R_GRASS );    define_region_topleft( 41,302,  80,341 );    // grass-topped dirt
    select_region( R_DIRT );     define_region_topleft( 1,302,   40,341 );    // plain dirt
    select_region( R_BG );       define_region_topleft( 1,1,     160,180 );   // green hills
    select_region( R_GRADIENT ); define_region_topleft( 486,1,   486,360 );   // 1px sky column

    // end-screen splashes
    select_region( R_WIN );      define_region_center( 1,467,    120,580 );   // thumbs-up guy
    select_region( R_LOSE );     define_region_center( 344,184,  482,340 );   // skull + ghosts + blue guy
}

// -----------------------------------------------------------------------------
//   Level construction
// -----------------------------------------------------------------------------
void AddBlock( float x, float y, float hw, float hh, int region )
{
    BlockBody[ BlockCount ]   = vb2_Box( x, y, hw, hh );
    BlockHW[ BlockCount ]     = hw;
    BlockHH[ BlockCount ]     = hh;
    BlockRegion[ BlockCount ] = region;
    BlockCount = BlockCount + 1;
}

void AddPig( float x, float y )
{
    int pig = vb2_Box( x, y, PIG_HALF, PIG_HALF );

    // pigs opt in to hit events: the solver reports any solved impact on them
    // with its approach speed, which is our damage model
    b2BodyId id;
    if( vb2_GetBodyId( pig, &id ) )
        b2Body_EnableHitEvents( &vb2_world, &id, true );

    PigBody[ PigCount ]    = pig;
    PoofFrames[ PigCount ] = 0;
    PigCount = PigCount + 1;
}

void BuildLevel()
{
    vb2_Init();
    vb2_EnableSleep( true );
    vb2_SetCamera( 0.0, -2.0, PPM );

    // ground: top surface at GROUND_TOP, wider than the screen
    vb2_Wall( 0.0, GROUND_TOP - 1.0, 20.0, 1.0 );

    BlockCount = 0;
    PigCount   = 0;

    // the castle: two crate columns carrying a brick roof
    AddBlock(  6.0, -6.0,  1.0, 1.0,  R_CRATE );
    AddBlock(  6.0, -4.0,  1.0, 1.0,  R_CRATE );
    AddBlock( 10.0, -6.0,  1.0, 1.0,  R_CRATE );
    AddBlock( 10.0, -4.0,  1.0, 1.0,  R_CRATE );
    // the roof is ONE lintel resting on both columns (three separate bricks
    // would leave the middle one unsupported over the 7..9 gap -- it fell at
    // level start and squashed both pigs by itself)
    AddBlock(  8.0, -2.6,  3.0, 0.4,  R_BRICK );

    AddPig(  8.0, -6.1 );      // sheltered inside the castle
    AddPig(  8.0, -1.3 );      // sunbathing on the roof
    AddPig( 13.5, -6.1 );      // out in the open

    Bird      = -1;
    BirdsLeft = TOTAL_BIRDS;
    Score     = 0;
    GameState = ST_AIM;
    AimOX     = -1.8;
    AimOY     = -0.6;
}

// -----------------------------------------------------------------------------
//   Gameplay helpers
// -----------------------------------------------------------------------------
int AlivePigs()
{
    int alive = 0;
    int p;
    for( p = 0; p < PigCount; p++ )
        if( vb2_Exists( PigBody[p] ) )
            alive = alive + 1;
    return alive;
}

void KillPig( int p )
{
    PoofX[p] = vb2_GetX( PigBody[p] );
    PoofY[p] = vb2_GetY( PigBody[p] );
    PoofFrames[p] = 50;
    vb2_Destroy( PigBody[p] );
    Score = Score + 500;
}

// After each step: any hit event on a pig above KILL_SPEED squashes it, and a
// pig that got shoved off the ground and is falling into the void also dies.
void CheckPigs()
{
    int n = b2World_GetContactHitEventCount( &vb2_world );
    b2ContactHitEvent* events = b2World_GetContactHitEvents( &vb2_world );

    int e;
    for( e = 0; e < n; e++ )
    {
        if( events[e].approachSpeed < KILL_SPEED )
            continue;

        int a = vb2_BodyOfShape( events[e].shapeIdA );
        int b = vb2_BodyOfShape( events[e].shapeIdB );

        int p;
        for( p = 0; p < PigCount; p++ )
        {
            if( vb2_Exists( PigBody[p] ) == false )
                continue;
            if( PigBody[p] == a || PigBody[p] == b )
                KillPig( p );
        }
    }

    int p;
    for( p = 0; p < PigCount; p++ )
        if( vb2_Exists( PigBody[p] ) && vb2_GetY( PigBody[p] ) < FALL_Y )
            KillPig( p );
}

void LaunchBird()
{
    Bird = vb2_Ball( SLING_X + AimOX, SLING_Y + AimOY, BIRD_R );
    vb2_SetDensity( Bird, 2.0 );          // heavy enough to plow through crates
    vb2_SetFriction( Bird, 0.8 );
    vb2_SetBounce( Bird, 0.15 );
    vb2_SetVelocity( Bird, -AimOX * POWER, -AimOY * POWER );

    BirdsLeft  = BirdsLeft - 1;
    GameState  = ST_FLY;
    FlyFrames  = 0;
    SlowFrames = 0;
}

// -----------------------------------------------------------------------------
//   Drawing
// -----------------------------------------------------------------------------

// a sprite glued to a physics body: position + rotation from the transform,
// scaled so the sprite covers the body's real size
void DrawBodySprite( int body, int region, float halfW, float halfH )
{
    if( vb2_Exists( body ) == false )
        return;

    select_texture( 0 );
    select_region( region );
    set_multiply_color( color_white );
    set_drawing_angle( -vb2_GetAngle( body ) );                     // screen y is flipped
    set_drawing_scale( 2.0 * halfW * PPM / SPRITE_PX,
                       2.0 * halfH * PPM / SPRITE_PX );
    draw_region_rotozoomed_at( vb2_ScreenX( vb2_GetX( body ) ),
                               vb2_ScreenY( vb2_GetY( body ) ) );
}

// an unrotated sprite at a world position (the queued birds, the aimed bird)
void DrawSpriteWorld( float wx, float wy, int region, float scale )
{
    select_texture( 0 );
    select_region( region );
    set_multiply_color( color_white );
    set_drawing_scale( scale, scale );
    draw_region_zoomed_at( vb2_ScreenX( wx ), vb2_ScreenY( wy ) );
}

void DrawBackground()
{
    select_texture( 0 );
    set_multiply_color( color_white );

    // the 1px sky gradient column, stretched across the whole screen
    select_region( R_GRADIENT );
    set_drawing_scale( 640.0, 1.0 );
    draw_region_zoomed_at( 0, 0 );

    // the hills strip along the lower half
    select_region( R_BG );
    draw_region_at(   0, 180 );
    draw_region_at( 160, 180 );
    draw_region_at( 320, 180 );
    draw_region_at( 480, 180 );

    // the ground the bodies actually rest on: grass row + dirt row
    int gy = vb2_ScreenY( GROUND_TOP );
    int gx;
    for( gx = 0; gx < 640; gx = gx + 40 )
    {
        select_region( R_GRASS );
        draw_region_at( gx, gy );
        select_region( R_DIRT );
        draw_region_at( gx, gy + 40 );
    }
}

void DrawSlingshot( float pullX, float pullY, bool aiming )
{
    int baseX = vb2_ScreenX( SLING_X );
    int baseY = vb2_ScreenY( GROUND_TOP );
    int topY  = vb2_ScreenY( SLING_Y );

    // rubber bands from the fork tips to the pouch (drawn under the bird)
    if( aiming )
    {
        int px = vb2_ScreenX( pullX );
        int py = vb2_ScreenY( pullY );
        set_multiply_color( make_color_rgb( 120, 30, 30 ) );
        draw_line( baseX - 8, topY, px, py );
        draw_line( baseX + 8, topY, px, py );
    }

    // wooden pole + fork
    set_multiply_color( color_brown );
    draw_rectangle( baseX - 3, topY + 10, baseX + 3, baseY );
    draw_line( baseX - 1, topY + 12, baseX - 8, topY );
    draw_line( baseX + 1, topY + 12, baseX + 8, topY );
}

void DrawAimPreview( float pullX, float pullY )
{
    float vx = -AimOX * POWER;
    float vy = -AimOY * POWER;

    set_multiply_color( color_white );
    float t;
    for( t = 0.15; t < 1.4; t = t + 0.1 )
    {
        float wx = pullX + vx * t;
        float wy = pullY + vy * t - 5.0 * t * t;    // 0.5 * |g| * t^2
        int sx = vb2_ScreenX( wx );
        int sy = vb2_ScreenY( wy );
        draw_rectangle( sx - 1, sy - 1, sx + 1, sy + 1 );
    }
}

void ShowInt( int x, int y, int value )
{
    int[20] s;
    itoa( value, s, 10 );
    print_at( x, y, s );
}

// -----------------------------------------------------------------------------
//   Main
// -----------------------------------------------------------------------------
void main()
{
    DefineRegions();
    BuildLevel();
    select_gamepad( 0 );

    while( true )
    {
        // ---------------------------------------------------------------------
        //   Input
        // ---------------------------------------------------------------------
        if( gamepad_button_start() == 1 )
        {
            vb2_Quit();
            BuildLevel();
        }

        if( GameState == ST_AIM )
        {
            if( gamepad_left()  > 0 )  AimOX = AimOX - 0.05;
            if( gamepad_right() > 0 )  AimOX = AimOX + 0.05;
            if( gamepad_up()    > 0 )  AimOY = AimOY + 0.05;
            if( gamepad_down()  > 0 )  AimOY = AimOY - 0.05;

            // keep the pull behind the sling and inside the band's reach
            if( AimOX > -0.2 )  AimOX = -0.2;
            if( AimOY >  2.4 )  AimOY =  2.4;
            if( AimOY < -2.4 )  AimOY = -2.4;

            float d = sqrt( AimOX * AimOX + AimOY * AimOY );
            if( d > MAX_PULL )
            {
                AimOX = AimOX * MAX_PULL / d;
                AimOY = AimOY * MAX_PULL / d;
            }
            if( d < MIN_PULL )
            {
                AimOX = AimOX * MIN_PULL / d;
                AimOY = AimOY * MIN_PULL / d;
            }

            if( gamepad_button_a() == 1 )
                LaunchBird();
        }

        // ---------------------------------------------------------------------
        //   Physics + consequences
        // ---------------------------------------------------------------------
        vb2_Step();
        CheckPigs();

        // a leftover collapse can still win it, even after a LOSE screen
        if( GameState != ST_WIN && AlivePigs() == 0 )
        {
            Score = Score + BirdsLeft * 1000;      // unused birds are bonus
            GameState = ST_WIN;
        }

        if( GameState == ST_FLY )
        {
            FlyFrames = FlyFrames + 1;

            float bvx = vb2_GetVX( Bird );
            float bvy = vb2_GetVY( Bird );
            if( bvx * bvx + bvy * bvy < 0.16 )
                SlowFrames = SlowFrames + 1;
            else
                SlowFrames = 0;

            float bx = vb2_GetX( Bird );
            float by = vb2_GetY( Bird );

            bool shotOver = false;
            if( vb2_Exists( Bird ) == false )              shotOver = true;
            else if( bx > 22.0 || bx < -22.0 )             shotOver = true;
            else if( by < FALL_Y )                         shotOver = true;
            else if( vb2_IsAwake( Bird ) == false )        shotOver = true;
            else if( SlowFrames > 45 )                     shotOver = true;
            else if( FlyFrames > 600 )                     shotOver = true;

            if( gamepad_button_a() == 1 && FlyFrames > 20 )
                shotOver = true;

            if( shotOver )
            {
                vb2_Destroy( Bird );
                Bird = -1;

                if( BirdsLeft == 0 )
                    GameState = ST_LOSE;
                else
                    GameState = ST_AIM;
            }
        }

        // ---------------------------------------------------------------------
        //   Draw
        // ---------------------------------------------------------------------
        DrawBackground();

        float pullX = SLING_X + AimOX;
        float pullY = SLING_Y + AimOY;

        DrawSlingshot( pullX, pullY, GameState == ST_AIM );

        if( GameState == ST_AIM )
        {
            DrawAimPreview( pullX, pullY );
            DrawSpriteWorld( pullX, pullY, R_BIRD, 2.0 * BIRD_R * PPM / SPRITE_PX );
        }

        // the queued birds, waiting their turn by the slingshot
        int spares = BirdsLeft;
        if( GameState == ST_AIM )
            spares = spares - 1;
        int q;
        for( q = 0; q < spares; q++ )
            DrawSpriteWorld( SLING_X - 2.4 - q * 2.0, GROUND_TOP + 0.9, R_BIRD, 0.9 );

        // every physics body gets its sprite
        int i;
        for( i = 0; i < BlockCount; i++ )
            DrawBodySprite( BlockBody[i], BlockRegion[i], BlockHW[i], BlockHH[i] );

        int p;
        for( p = 0; p < PigCount; p++ )
            DrawBodySprite( PigBody[p], R_PIG, PIG_HALF, PIG_HALF );

        if( Bird != -1 )
            DrawBodySprite( Bird, R_BIRD, BIRD_R, BIRD_R );

        // fading red X where a pig died
        for( p = 0; p < PigCount; p++ )
        {
            if( PoofFrames[p] <= 0 )
                continue;
            PoofFrames[p] = PoofFrames[p] - 1;
            select_texture( 0 );
            select_region( R_REDX );
            set_multiply_color( make_color_rgba( 255, 255, 255, PoofFrames[p] * 5 ) );
            draw_region_at( vb2_ScreenX( PoofX[p] ), vb2_ScreenY( PoofY[p] ) );
        }

        // ---- HUD ----
        set_multiply_color( color_white );
        print_at(   8,  4, "ANGRY BLOCKS" );
        print_at( 168,  4, "SCORE" );   ShowInt( 232,  4, Score );
        print_at( 340,  4, "BIRDS" );   ShowInt( 404,  4, BirdsLeft );
        print_at( 470,  4, "PIGS" );    ShowInt( 524,  4, AlivePigs() );
        print_at(   8, 340, "DPAD AIM   A LAUNCH   START RESTART" );

        if( GameState == ST_WIN )
        {
            DrawSpriteWorld( 0.0, 0.5, R_WIN, 1.0 );
            print_at( 260, 230, "LEVEL CLEAR!" );
            print_at( 215, 254, "PRESS START TO PLAY AGAIN" );
        }
        else if( GameState == ST_LOSE )
        {
            DrawSpriteWorld( 0.0, 0.5, R_LOSE, 1.0 );
            print_at( 220, 244, "OUT OF BIRDS - PRESS START" );
        }

        end_frame();
    }
}
