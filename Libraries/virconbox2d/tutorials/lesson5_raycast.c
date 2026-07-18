// =============================================================================
//   VirconBox2D tutorial -- Lesson 5: Ray Casts and Picking
// =============================================================================
//   Three ways to ask the world a geometric question:
//
//     * GROUND CHECK -- a short ray cast straight down. Finally fixes the
//       mid-air jump we've been living with since lesson 3.
//     * LASER CUTTER -- a long ray cast in an aimed direction. The beam stops
//       at the first thing it hits, names it, and cuts crates.
//     * SCANNER     -- vb2_BodyAt: "what body is under this point?", shown by
//       an orbiting cursor.
//
//   THE trap of this lesson: A RAY THAT STARTS INSIDE A SHAPE HITS THAT SHAPE
//   (at fraction 0). Cast from the player's center and the nearest thing the
//   ray finds is... the player. Both rays below start on the SURFACE instead.
//
//   Controls:  d-pad left/right = roll,  up/down = aim,
//              A = jump (grounded only!),  B = laser
//
//   Build:  bash build.sh lesson5_raycast    ->  bin/lesson5_raycast.v32
// =============================================================================

#include "video.h"
#include "time.h"
#include "input.h"
#include "string.h"
#include "math.h"         // cos, sin
#include "misc.h"         // rand
#include "../vb2.h"

#define FLOOR_TOP   -7.0
#define WALL_X      15.0
#define PLAYER_R     0.7
#define MAX_CRATES  10
#define LASER_LEN   20.0

int[MAX_CRATES] crates;
int player;
int floorBody;

void PrintInt( int x, int y, int value )
{
    int[16] s;
    itoa( value, s, 10 );
    print_at( x, y, s );
}

bool IsCrate( int body )
{
    int i;
    for( i = 0; i < MAX_CRATES; i++ )
        if( crates[ i ] == body )
            return true;
    return false;
}

void main()
{
    vb2_Init();
    vb2_SetCamera( 0.0, 0.0, 20.0 );

    floorBody = vb2_Wall( 0.0, -7.5, WALL_X + 1.0, 0.5 );
    vb2_Wall( -WALL_X - 0.5, 0.0, 0.5, 9.0 );
    vb2_Wall(  WALL_X + 0.5, 0.0, 0.5, 9.0 );

    player = vb2_Ball( -10.0, -5.0, PLAYER_R );
    vb2_SetFriction( player, 0.9 );
    float mass = vb2_GetMass( player );

    // a scattered field of crates to cut
    int i;
    for( i = 0; i < MAX_CRATES; i++ )
    {
        float x = ( rand() % 22 ) - 8.0;
        float y = FLOOR_TOP + 0.7 + ( rand() % 6 );
        crates[ i ] = vb2_Box( x, y, 0.6, 0.6 );
    }

    float aim = 0.6;                        // aim angle, radians. 0 = right
    int score = 0;

    select_gamepad( 0 );

    while( true )
    {
        float px = vb2_GetX( player );
        float py = vb2_GetY( player );

        // ---------------------------------------------------------------------
        //   GROUND CHECK. A short ray straight down, starting just BELOW the
        //   ball's surface (center would self-hit!), reaching 0.13 m further.
        //   Any hit means something solid is right under our feet.
        // ---------------------------------------------------------------------
        int ground = vb2_RayCast( px, py - PLAYER_R - 0.02,
                                  px, py - PLAYER_R - 0.15 );
        bool grounded = ( ground != -1 );

        // NOTE: the hit record (vb2_HitX and friends) now holds THIS cast's
        // result. We don't need it for the ground check -- but it is why the
        // laser below reads its own hit data immediately after ITS cast.

        // ---- input ----
        if( gamepad_left() > 0 )
        {
            vb2_ApplyTorque( player, 8.0 );
            vb2_ApplyForce( player, -5.0 * mass, 0.0 );
        }
        if( gamepad_right() > 0 )
        {
            vb2_ApplyTorque( player, -8.0 );
            vb2_ApplyForce( player, 5.0 * mass, 0.0 );
        }
        if( gamepad_up() > 0 )    aim = aim + 0.03;
        if( gamepad_down() > 0 )  aim = aim - 0.03;

        // THE FIX, four lessons in the making: jump only when grounded.
        if( gamepad_button_a() == 1 && grounded )
            vb2_ApplyImpulse( player, 0.0, 7.0 * mass );

        // ---------------------------------------------------------------------
        //   LASER. Direction from the aim angle; origin on the ball's SURFACE
        //   (radius + a little), so the ray can't start inside the player.
        // ---------------------------------------------------------------------
        float dirX = cos( aim );
        float dirY = sin( aim );
        float ox = px + dirX * ( PLAYER_R + 0.05 );
        float oy = py + dirY * ( PLAYER_R + 0.05 );

        bool  laserOn  = ( gamepad_button_b() > 0 );
        int   laserHit = -1;
        float beamX = ox + dirX * LASER_LEN;    // beam end if nothing is hit
        float beamY = oy + dirY * LASER_LEN;
        float normX = 0.0;
        float normY = 0.0;

        if( laserOn )
        {
            laserHit = vb2_RayCast( ox, oy, beamX, beamY );
            if( laserHit != -1 )
            {
                beamX = vb2_HitX();             // read the hit record NOW,
                beamY = vb2_HitY();             // before any other cast
                normX = vb2_HitNX();            // surface normal at the hit --
                normY = vb2_HitNY();            // unit length, points back at us
            }
        }

        vb2_Step();

        // laser cuts crates (collect-then-destroy from lesson 4 doesn't apply:
        // one ray, one victim, and we are not iterating events here)
        if( laserHit != -1 && IsCrate( laserHit ) )
        {
            vb2_Destroy( laserHit );
            score = score + 1;
        }

        // ---------------------------------------------------------------------
        //   SCANNER: vb2_BodyAt answers "what body is at this world point?".
        //   The cursor orbits the player, standing in for a mouse.
        // ---------------------------------------------------------------------
        float t = get_frame_counter() * 0.015;
        float scanX = px + cos( t ) * 4.0;
        float scanY = py + sin( t ) * 4.0;
        int under = vb2_BodyAt( scanX, scanY );

        // ---------------------------------------------------------------------
        //   Draw
        // ---------------------------------------------------------------------
        clear_screen( color_black );
        set_multiply_color( color_white );

        print_at( 10,  8, "LESSON 5: RAY CASTS" );
        print_at( 10, 22, "DPAD ROLL/AIM   A JUMP   B LASER" );
        print_at( 470,  8, "SCORE" );
        PrintInt( 540,  8, score );
        if( grounded )
            print_at( 470, 22, "GROUNDED" );

        // what the beam hit, by name -- handles make this a plain comparison
        if( laserHit != -1 )
        {
            if( IsCrate( laserHit ) )           print_at( 260, 40, "-> CRATE" );
            else if( laserHit == floorBody )    print_at( 260, 40, "-> FLOOR" );
            else                                print_at( 260, 40, "-> WALL" );
        }

        // arena
        float fx;
        for( fx = -WALL_X; fx <= WALL_X; fx = fx + 0.5 )
            print_at( vb2_ScreenX( fx ), vb2_ScreenY( FLOOR_TOP ), "=" );
        float wy;
        for( wy = FLOOR_TOP; wy <= 9.0; wy = wy + 0.5 )
        {
            print_at( vb2_ScreenX( -WALL_X ), vb2_ScreenY( wy ), "|" );
            print_at( vb2_ScreenX(  WALL_X ), vb2_ScreenY( wy ), "|" );
        }

        // the beam: dots from the muzzle to wherever it stopped, an X at the
        // hit, and a tick pushed out along the surface normal
        if( laserOn )
        {
            float s;
            for( s = 0.0; s <= 1.0; s = s + 0.04 )
            {
                float lx = ox + ( beamX - ox ) * s;
                float ly = oy + ( beamY - oy ) * s;
                print_at( vb2_ScreenX( lx ) - 4, vb2_ScreenY( ly ) - 5, "." );
            }
            if( laserHit != -1 )
            {
                print_at( vb2_ScreenX( beamX ) - 4, vb2_ScreenY( beamY ) - 5, "X" );
                print_at( vb2_ScreenX( beamX + normX * 0.8 ) - 4,
                          vb2_ScreenY( beamY + normY * 0.8 ) - 5, "*" );
            }
        }

        // the scanner cursor: brackets when it is over a body, plus when not
        if( under != -1 )
            print_at( vb2_ScreenX( scanX ) - 8, vb2_ScreenY( scanY ) - 5, "()" );
        else
            print_at( vb2_ScreenX( scanX ) - 4, vb2_ScreenY( scanY ) - 5, "+" );

        // crates + player
        for( i = 0; i < MAX_CRATES; i++ )
            if( vb2_Exists( crates[ i ] ) )
                print_at( vb2_ScreenX( vb2_GetX( crates[ i ] ) ) - 8,
                          vb2_ScreenY( vb2_GetY( crates[ i ] ) ) - 5, "[]" );

        print_at( vb2_ScreenX( px ) - 4, vb2_ScreenY( py ) - 5, "O" );

        end_frame();
    }
}
