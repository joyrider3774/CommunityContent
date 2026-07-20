// =============================================================================
//   VirconBox2D tutorial -- Lesson 8: Sprites and Textures
// =============================================================================
//   Every lesson so far drew glyphs with the BIOS font. This one draws REAL
//   sprites from a texture atlas -- and gets rotation for free: roll into the
//   crate castle and watch every block tumble with its sprite glued on.
//
//   The three recipes this lesson exists to teach:
//
//     1. THE PIPELINE: textures/*.png -> png2vircon -> .vtex -> <textures> in
//        the ROM XML -> select_texture(0) at runtime. (build.sh does the
//        conversion; the XML does the packing.)
//
//     2. REGIONS: one atlas, many sprites. define_region_center for physics
//        sprites (hotspot at the center = draw straight at the body position),
//        define_region_topleft for background tiles.
//
//     3. THE ROTOZOOM RECIPE (DrawBodySprite below): position + angle from
//        the body, with TWO traps --
//           * NEGATE the angle: physics is CCW-positive, the screen's flipped
//             y axis makes drawing angles read clockwise
//           * scale = (body size in pixels) / (sprite's native pixels)
//
//   The full game built from these recipes is ../angrybirds.c -- read it after
//   this lesson.
//
//   Controls:  d-pad = roll,  A = jump. Squash the pig by hitting it fast.
//              START = rebuild the level.
//
//   Build:  bash build.sh lesson8_sprites    ->  bin/lesson8_sprites.v32
//   (Uses the parent project's textures/Texture-AngryBirds.png -- the
//   "BasicPlatformer" atlas by Carra.)
// =============================================================================

#include "video.h"
#include "time.h"
#include "input.h"
#include "string.h"
#include "../vb2.h"

// --- texture regions. The ids are OURS (slots we choose); the pixel rects
//     say where in the atlas each sprite lives. ---------------------------------
#define R_BIRD      0
#define R_PIG       1
#define R_CRATE     2
#define R_BRICK     3
#define R_GRASS     4
#define R_DIRT      5
#define R_REDX      6
#define R_BG        7
#define R_GRADIENT  8

// --- world tuning. The atlas sprites are 40x40 px; at 20 px/m a sprite drawn
//     1:1 covers exactly 2 m -- so a half-extent of 1.0 is the "native" size.
#define PPM         20.0
#define SPRITE_PX   40.0
#define GROUND_TOP  -7.0
#define PLAYER_R     0.9
#define KILL_SPEED   4.0

#define MAX_BLOCKS  8

int[MAX_BLOCKS]   BlockBody;
float[MAX_BLOCKS] BlockHW;      // remembered so the draw code knows how big
float[MAX_BLOCKS] BlockHH;      //   each sprite must be scaled
int[MAX_BLOCKS]   BlockRegion;
int BlockCount;

int   Player;
int   Pig;
float PoofX;                    // where the pig died (for the fading red X)
float PoofY;
int   PoofFrames;
int   Score;

// -----------------------------------------------------------------------------
//   Recipe 2: carve named sprites out of the atlas, ONCE at startup.
//   Physics sprites get CENTER hotspots -- then drawing at the body's mapped
//   position needs no offset math at all. Tiles draw from the top-left.
// -----------------------------------------------------------------------------
void DefineRegions()
{
    select_texture( 0 );        // our one cartridge texture, index 0

    select_region( R_BIRD );     define_region_center( 162,182,  201,221 );
    select_region( R_PIG );      define_region_center( 285,182,  324,221 );
    select_region( R_CRATE );    define_region_center( 1,342,    40,381 );
    select_region( R_BRICK );    define_region_center( 81,302,   120,341 );
    select_region( R_REDX );     define_region_center( 1,182,    40,221 );

    select_region( R_GRASS );    define_region_topleft( 41,302,  80,341 );
    select_region( R_DIRT );     define_region_topleft( 1,302,   40,341 );
    select_region( R_BG );       define_region_topleft( 1,1,     160,180 );
    select_region( R_GRADIENT ); define_region_topleft( 486,1,   486,360 );
}

// -----------------------------------------------------------------------------
//   Level
// -----------------------------------------------------------------------------
void AddBlock( float x, float y, float hw, float hh, int region )
{
    BlockBody[ BlockCount ]   = vb2_Box( x, y, hw, hh );
    BlockHW[ BlockCount ]     = hw;
    BlockHH[ BlockCount ]     = hh;
    BlockRegion[ BlockCount ] = region;
    BlockCount = BlockCount + 1;
}

void BuildLevel()
{
    vb2_Init();
    vb2_EnableSleep( true );
    vb2_SetCamera( 0.0, -2.0, PPM );

    vb2_Wall( 0.0, GROUND_TOP - 1.0, 20.0, 1.0 );      // ground under the tiles

    BlockCount = 0;

    // a small castle: two crate columns + one brick lintel across them
    AddBlock(  6.0, -6.0, 1.0, 1.0, R_CRATE );
    AddBlock(  6.0, -4.0, 1.0, 1.0, R_CRATE );
    AddBlock( 10.0, -6.0, 1.0, 1.0, R_CRATE );
    AddBlock( 10.0, -4.0, 1.0, 1.0, R_CRATE );
    AddBlock(  8.0, -2.6, 3.0, 0.4, R_BRICK );

    // the pig sunbathes on the lintel; knock something into him, hard
    Pig = vb2_Box( 8.0, -1.3, 0.9, 0.9 );

    Player = vb2_Ball( -10.0, -5.0, PLAYER_R );
    vb2_SetFriction( Player, 0.9 );

    PoofFrames = 0;
    Score      = 0;
}

// -----------------------------------------------------------------------------
//   Recipe 3: a sprite glued to a physics body. THE function of this lesson.
// -----------------------------------------------------------------------------
void DrawBodySprite( int body, int region, float halfW, float halfH )
{
    if( vb2_Exists( body ) == false )
        return;

    select_texture( 0 );
    select_region( region );
    set_multiply_color( color_white );

    // TRAP 1: negate the body angle. Physics angles are counter-clockwise,
    // but with the screen's y axis pointing DOWN, drawing angles come out
    // clockwise. Forget the minus and sprites spin the wrong way.
    set_drawing_angle( -vb2_GetAngle( body ) );

    // TRAP 2: scale = wanted pixels / native pixels. The body is 2*half
    // meters across = 2*half*PPM pixels on screen; the sprite is SPRITE_PX.
    set_drawing_scale( 2.0 * halfW * PPM / SPRITE_PX,
                       2.0 * halfH * PPM / SPRITE_PX );

    draw_region_rotozoomed_at( vb2_ScreenX( vb2_GetX( body ) ),
                               vb2_ScreenY( vb2_GetY( body ) ) );
}

// -----------------------------------------------------------------------------
//   The background, back-to-front (painter's algorithm). Note there is NO
//   clear_screen anywhere in this ROM: the sky gradient + tiles cover every
//   pixel, so clearing would be wasted work.
// -----------------------------------------------------------------------------
void DrawBackground()
{
    select_texture( 0 );
    set_multiply_color( color_white );

    // a 1-pixel-wide sky gradient column, stretched over the whole screen
    select_region( R_GRADIENT );
    set_drawing_scale( 640.0, 1.0 );
    draw_region_zoomed_at( 0, 0 );

    // the hills strip, tiled 4 times across the lower half
    select_region( R_BG );
    draw_region_at(   0, 180 );
    draw_region_at( 160, 180 );
    draw_region_at( 320, 180 );
    draw_region_at( 480, 180 );

    // the visible ground: a grass row where the physics floor's top is,
    // and a dirt row under it
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

void PrintInt( int x, int y, int value )
{
    int[16] s;
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
        if( gamepad_button_start() == 1 )
        {
            vb2_Quit();                    // tear the world down completely...
            BuildLevel();                  // ...and rebuild it: a full reset
        }

        // ---- lesson 3/5 controls: roll, and jump when grounded ----
        float px = vb2_GetX( Player );
        float py = vb2_GetY( Player );
        float mass = vb2_GetMass( Player );

        int ground = vb2_RayCast( px, py - PLAYER_R - 0.02,
                                  px, py - PLAYER_R - 0.15 );

        if( gamepad_left() > 0 )
        {
            vb2_ApplyTorque( Player, 10.0 );
            vb2_ApplyForce( Player, -6.0 * mass, 0.0 );
        }
        if( gamepad_right() > 0 )
        {
            vb2_ApplyTorque( Player, -10.0 );
            vb2_ApplyForce( Player, 6.0 * mass, 0.0 );
        }
        if( gamepad_button_a() == 1 && ground != -1 )
            vb2_ApplyImpulse( Player, 0.0, 7.5 * mass );

        vb2_Step();

        // ---- squash check (lesson 4 pattern): the pig dies to a FAST touch.
        //      Speed is read at event time; one victim, so no collect pass.
        if( vb2_Exists( Pig ) )
        {
            float vx = vb2_GetVX( Player );
            float vy = vb2_GetVY( Player );
            bool fast = ( vx * vx + vy * vy > KILL_SPEED * KILL_SPEED );

            int e;
            for( e = 0; e < vb2_TouchCount(); e++ )
            {
                int a = vb2_TouchA( e );
                int b = vb2_TouchB( e );
                bool pigHit = ( a == Pig || b == Pig );
                bool byPlayer = ( a == Player || b == Player );

                if( pigHit && byPlayer && fast )
                {
                    PoofX = vb2_GetX( Pig );      // read BEFORE destroying
                    PoofY = vb2_GetY( Pig );
                    PoofFrames = 50;
                    vb2_Destroy( Pig );
                    Score = Score + 500;
                }
            }
        }

        // ---------------------------------------------------------------------
        //   Draw, back to front: background, bodies, effects, HUD.
        // ---------------------------------------------------------------------
        DrawBackground();

        int i;
        for( i = 0; i < BlockCount; i++ )
            DrawBodySprite( BlockBody[i], BlockRegion[i], BlockHW[i], BlockHH[i] );

        DrawBodySprite( Pig, R_PIG, 0.9, 0.9 );
        DrawBodySprite( Player, R_BIRD, PLAYER_R, PLAYER_R );

        // the death poof: the red X fades out by dropping the alpha of the
        // multiply color a little every frame
        if( PoofFrames > 0 )
        {
            PoofFrames = PoofFrames - 1;
            select_texture( 0 );
            select_region( R_REDX );
            set_multiply_color( make_color_rgba( 255, 255, 255, PoofFrames * 5 ) );
            draw_region_at( vb2_ScreenX( PoofX ), vb2_ScreenY( PoofY ) );
        }

        // HUD last, on top of everything. print_at still works: the BIOS font
        // is its own texture, untouched by our atlas.
        set_multiply_color( color_white );
        print_at( 8, 4, "LESSON 8: SPRITES" );
        print_at( 470, 4, "SCORE" );
        PrintInt( 540, 4, Score );
        print_at( 8, 340, "DPAD ROLL   A JUMP   START RESET" );

        end_frame();
    }
}
