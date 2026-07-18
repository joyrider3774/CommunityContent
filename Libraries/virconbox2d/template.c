// =============================================================================
//   VirconBox2D -- new game template
// =============================================================================
//   Copy this file and start deleting. It is the whole vb2 facade on one screen:
//   a world, a level, a player you drive, crates to shove around, a ray-cast
//   laser, a ray-cast ground check, and a draw loop.
//
//   Controls:  d-pad left/right = roll,  A = jump (only when grounded),
//              B = spawn a crate at the cursor,  START = fire the laser.
//
//   Build:  bash build.sh template     ->  bin/template.v32
//
//   The renderer here is BIOS text, so this ROM needs no assets and builds
//   anywhere. Your game will draw sprites instead -- the only thing it needs from
//   physics is vb2_GetX / vb2_GetY / vb2_GetAngle and the vb2_ScreenX/Y mapping.
//
//   THREE THINGS THIS TEMPLATE EXISTS TO TEACH (each cost a bug to learn):
//
//     1. DRAW EVERY BODY YOU CREATE. A body you forget to draw is an invisible
//        wall that the player will walk into and swear at. The ramp below is a
//        segment -- there is nothing to see unless you draw it yourself.
//
//     2. A RAY THAT STARTS INSIDE A SHAPE HITS THAT SHAPE. Casting from the
//        player's center means the closest thing the ray finds is the player.
//        Start the ray on the surface: center + direction * (radius + a little).
//        This is why both the laser and the ground check offset their origin.
//
//     3. DON'T DRAW AT 1 PIXEL = 1 METER. Box2D's tolerances (a ~0.005 m contact
//        slop, a 0.05 m AABB margin) are tuned for human-sized objects, so a body
//        a few pixels wide is a body a few CENTIMETERS wide, and it will jitter.
//        Keep your objects 0.5-5 m and let the camera scale them up.
// =============================================================================

#include "video.h"
#include "input.h"
#include "time.h"
#include "math.h"
#include "string.h"
#include "vb2.h"

#define MAX_CRATES  24

// the level, in meters (y-up). Everything below is derived from these, so the
// drawing and the physics can't drift apart.
#define FLOOR_TOP   -7.5
#define WALL_X      15.0
#define RAMP_X1     -9.0
#define RAMP_Y1     -7.5
#define RAMP_X2     -2.0
#define RAMP_Y2     -4.5
#define PLAYER_R    0.6

void main()
{
    // -------------------------------------------------------------------------
    //   Setup
    // -------------------------------------------------------------------------
    vb2_Init();
    vb2_EnableSleep( true );          // settled crates stop costing solve time

    // 20 px/m, centered a little below the origin so the floor sits low on screen.
    // The 640x360 screen then shows 32 m x 18 m of world.
    vb2_SetCamera( 0.0, -3.0, 20.0 );

    // static level. NOTE the half-extents: vb2_Wall( centerX, centerY, halfW, halfH ).
    vb2_Wall( 0.0, FLOOR_TOP - 0.5, WALL_X + 0.5, 0.5 );          // floor
    vb2_Wall( -WALL_X - 0.5, -3.0, 0.5, 5.0 );                    // left wall
    vb2_Wall(  WALL_X + 0.5, -3.0, 0.5, 5.0 );                    // right wall
    vb2_Line( RAMP_X1, RAMP_Y1, RAMP_X2, RAMP_Y2 );               // a ramp, as a thin segment

    // the player: a ball rolls, so drive it with torque and give it grip
    int player = vb2_Ball( -12.0, -6.0, PLAYER_R );
    vb2_SetFriction( player, 0.9 );
    vb2_SetBounce( player, 0.2 );

    // a stack of crates, resting ON the floor (center = floor top + half height)
    int[MAX_CRATES] crates;
    int crateCount = 0;

    int i;
    for( i = 0; i < 5; i++ )
    {
        crates[ crateCount ] = vb2_Box( 7.0, FLOOR_TOP + 0.5 + i * 1.1, 0.5, 0.5 );
        crateCount = crateCount + 1;
    }

    // -------------------------------------------------------------------------
    //   Game loop -- one physics step per displayed frame
    // -------------------------------------------------------------------------
    select_gamepad( 0 );

    while( true )
    {
        float px = vb2_GetX( player );
        float py = vb2_GetY( player );

        // ---- the aim cursor: a point orbiting the player, standing in for a
        //      mouse. Clamped INSIDE the level, so a crate can never be spawned
        //      through the floor or a wall (where it would fall out of the world).
        float t = get_frame_counter() * 0.02;
        float aimX = px + cos( t ) * 6.0;
        float aimY = py + sin( t ) * 6.0;

        if( aimY < FLOOR_TOP + 0.6 )    aimY = FLOOR_TOP + 0.6;
        if( aimX < -WALL_X + 0.6 )      aimX = -WALL_X + 0.6;
        if( aimX >  WALL_X - 0.6 )      aimX =  WALL_X - 0.6;

        // direction player -> cursor, as a unit vector
        float aimDX = aimX - px;
        float aimDY = aimY - py;
        float aimLen = sqrt( aimDX * aimDX + aimDY * aimDY );
        if( aimLen < 0.001 )
            aimLen = 1.0;                                  // degenerate: don't divide by ~0
        aimDX = aimDX / aimLen;
        aimDY = aimDY / aimLen;

        // ---- ground check: a short ray straight down, starting just BELOW the
        //      ball's surface. From the center it would only ever hit the ball.
        int ground = vb2_RayCast( px, py - PLAYER_R - 0.02,
                                  px, py - PLAYER_R - 0.15 );
        bool grounded = ( ground != -1 );

        // ---- input ----
        if( gamepad_left() > 0 )
            vb2_ApplyTorque( player, 6.0 );                // +torque spins it left
        if( gamepad_right() > 0 )
            vb2_ApplyTorque( player, -6.0 );

        if( gamepad_button_a() == 1 && grounded )          // ==1: the frame it went down
            vb2_ApplyImpulse( player, 0.0, 5.0 );

        if( gamepad_button_b() == 1 && crateCount < MAX_CRATES )
        {
            crates[ crateCount ] = vb2_Box( aimX, aimY, 0.4, 0.4 );
            crateCount = crateCount + 1;
        }

        // ---- the laser: cast from the ball's SURFACE, not its center ----
        bool laserOn = ( gamepad_button_start() > 0 );
        float laserX = aimX;
        float laserY = aimY;
        float laserOX = px + aimDX * ( PLAYER_R + 0.05 );
        float laserOY = py + aimDY * ( PLAYER_R + 0.05 );
        int laserHit = -1;

        if( laserOn )
        {
            laserHit = vb2_RayCast( laserOX, laserOY, aimX, aimY );
            if( laserHit != -1 )
            {
                laserX = vb2_HitX();      // the beam stops at the surface it struck
                laserY = vb2_HitY();
            }
        }

        // ---- physics: one step, 1/60 s ----
        vb2_Step();

        // ---- collisions from this step. Poll AFTER the step; the next one clears
        //      them. Here we just count the player's; a real game would play a
        //      thud, deal damage, pop a pickup.
        int bumps = 0;
        int e;
        for( e = 0; e < vb2_TouchCount(); e++ )
        {
            if( vb2_TouchA( e ) == player || vb2_TouchB( e ) == player )
                bumps = bumps + 1;
        }

        // ---------------------------------------------------------------------
        //   Draw
        // ---------------------------------------------------------------------
        clear_screen( color_black );
        set_multiply_color( color_white );

        print_at( 10,  8, "VIRCONBOX2D TEMPLATE" );
        print_at( 10, 22, "DPAD ROLL   A JUMP   B CRATE   START LASER" );
        if( grounded )
            print_at( 500, 8, "GROUNDED" );
        if( bumps > 0 )
            print_at( 500, 22, "BUMP!" );

        // ---- the STATIC level. Draw every body you made, or it is an invisible
        //      wall. (We know where we put these, so we draw them from the same
        //      constants the bodies were built from.)
        float fx;
        for( fx = -WALL_X; fx <= WALL_X; fx = fx + 0.5 )
            print_at( vb2_ScreenX( fx ), vb2_ScreenY( FLOOR_TOP ), "=" );

        float wy;
        for( wy = FLOOR_TOP; wy <= 2.0; wy = wy + 0.5 )
        {
            print_at( vb2_ScreenX( -WALL_X ), vb2_ScreenY( wy ), "|" );
            print_at( vb2_ScreenX(  WALL_X ), vb2_ScreenY( wy ), "|" );
        }

        float rs;                                          // THE RAMP -- the bug this template had
        for( rs = 0.0; rs <= 1.0; rs = rs + 0.04 )
        {
            float rx = RAMP_X1 + ( RAMP_X2 - RAMP_X1 ) * rs;
            float ry = RAMP_Y1 + ( RAMP_Y2 - RAMP_Y1 ) * rs;
            print_at( vb2_ScreenX( rx ) - 4, vb2_ScreenY( ry ) - 5, "/" );
        }

        // ---- the aim cursor ----
        print_at( vb2_ScreenX( aimX ) - 4, vb2_ScreenY( aimY ) - 5, "+" );

        // ---- the laser beam, as a dotted line from the ball's surface ----
        if( laserOn )
        {
            float s;
            for( s = 0.0; s <= 1.0; s = s + 0.04 )
            {
                float lx = laserOX + ( laserX - laserOX ) * s;
                float ly = laserOY + ( laserY - laserOY ) * s;
                print_at( vb2_ScreenX( lx ) - 4, vb2_ScreenY( ly ) - 5, "." );
            }
            if( laserHit != -1 )
                print_at( vb2_ScreenX( laserX ) - 4, vb2_ScreenY( laserY ) - 5, "X" );
        }

        // ---- the DYNAMIC bodies. This is the only physics a renderer needs: ask
        //      each body where it is, map it to the screen, draw your sprite.
        int c;
        for( c = 0; c < crateCount; c++ )
        {
            int crate = crates[ c ];
            print_at( vb2_ScreenX( vb2_GetX( crate ) ) - 8,
                      vb2_ScreenY( vb2_GetY( crate ) ) - 5, "[]" );
        }

        print_at( vb2_ScreenX( px ) - 4, vb2_ScreenY( py ) - 5, "O" );

        end_frame();
    }
}
