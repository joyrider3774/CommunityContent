// =============================================================================
//   VirconBox2D tutorial -- Lesson 3: Making Things Move
// =============================================================================
//   A player ball you drive around a little level, demonstrating each way of
//   making a dynamic body move -- and when each one is the right tool:
//
//     TORQUE   (hold, every frame)  d-pad     -- roll along the ground
//     FORCE    (hold, every frame)  B         -- jetpack thrust
//     IMPULSE  (once, on press)     A         -- jump kick
//     VELOCITY (override)           X         -- dash at a fixed speed
//
//   KNOWN BUG, ON PURPOSE: you can jump in mid-air, forever. Fixing that needs
//   a GROUND CHECK, which needs a ray cast -- that's lesson 5. Enjoy flying.
//
//   Build:  bash build.sh lesson3_control    ->  bin/lesson3_control.v32
// =============================================================================

#include "video.h"
#include "time.h"
#include "input.h"
#include "string.h"
#include "../vb2.h"

#define FLOOR_TOP  -7.0
#define WALL_X     15.0
#define PLAYER_R    0.6

void PrintInt( int x, int y, int value )
{
    int[16] s;
    itoa( value, s, 10 );
    print_at( x, y, s );
}

void main()
{
    vb2_Init();
    vb2_SetCamera( 0.0, 0.0, 20.0 );

    // ---- a closed arena: floor + two walls (thick, so nothing escapes) ----
    vb2_Wall( 0.0, -7.5, WALL_X + 1.0, 0.5 );
    vb2_Wall( -WALL_X - 0.5, 0.0, 0.5, 8.0 );
    vb2_Wall(  WALL_X + 0.5, 0.0, 0.5, 8.0 );

    // ---- the player: a ball. Grippy, so torque turns into rolling. ----
    int player = vb2_Ball( -10.0, -5.0, PLAYER_R );
    vb2_SetFriction( player, 0.9 );

    // The ball's mass, from density (1) x area. We scale pushes by this, so
    // the controls would FEEL the same if you changed the ball's size/density.
    float mass = vb2_GetMass( player );

    // ---- crates to shove around (heavier than the player -- lean into them!)
    int[5] crates;
    int i;
    for( i = 0; i < 5; i++ )
    {
        crates[ i ] = vb2_Box( 6.0 + i * 1.6, FLOOR_TOP + 0.6, 0.6, 0.6 );
        vb2_SetDensity( crates[ i ], 2.0 );
    }

    int facing = 1;                       // last horizontal direction, for the dash

    select_gamepad( 0 );

    while( true )
    {
        // ---------------------------------------------------------------------
        //   Input -> physics. Two input idioms:
        //     gamepad_x() >  0   held down       (forces/torque: apply EVERY frame)
        //     gamepad_x() == 1   just pressed    (impulses: apply ONCE)
        // ---------------------------------------------------------------------

        // ---- TORQUE: rolling. Positive torque spins counter-clockwise, which
        //      rolls the ball LEFT. It only moves the ball while touching the
        //      ground -- spin needs friction to become motion. So we also add a
        //      small direct FORCE for air control.
        if( gamepad_left() > 0 )
        {
            vb2_ApplyTorque( player, 6.0 );
            vb2_ApplyForce( player, -4.0 * mass, 0.0 );
            facing = -1;
        }
        if( gamepad_right() > 0 )
        {
            vb2_ApplyTorque( player, -6.0 );
            vb2_ApplyForce( player, 4.0 * mass, 0.0 );
            facing = 1;
        }

        // ---- IMPULSE: the jump. An impulse is an instant change of momentum:
        //      impulse = mass x (change in velocity). This one adds ~6 m/s of
        //      upward speed, once, on the frame A goes down.
        //      (Yes, it works in mid-air. Lesson 5 fixes that with a ray cast.)
        if( gamepad_button_a() == 1 )
            vb2_ApplyImpulse( player, 0.0, 6.0 * mass );

        // ---- FORCE: the jetpack. A force acts for ONE step, so hold it: call
        //      it every frame you want thrust. Gravity pulls with mass x 10,
        //      so mass x 18 climbs, mass x 10 would hover exactly.
        if( gamepad_button_b() > 0 )
            vb2_ApplyForce( player, 0.0, 18.0 * mass );

        // ---- SET VELOCITY: the dash. Not a push -- an OVERRIDE. Whatever the
        //      ball was doing, it is now moving at exactly 14 m/s sideways.
        //      Feels snappy and "gamey" precisely because it ignores physics;
        //      use it deliberately (dashes, conveyors), not for basic movement.
        if( gamepad_button_x() == 1 )
            vb2_SetVelocity( player, 14.0 * facing, 0.0 );

        vb2_Step();

        // ---------------------------------------------------------------------
        //   Draw
        // ---------------------------------------------------------------------
        clear_screen( color_black );
        set_multiply_color( color_white );

        print_at( 10,  8, "LESSON 3: MAKING THINGS MOVE" );
        print_at( 10, 22, "DPAD ROLL   A JUMP   B JETPACK   X DASH" );

        // HUD: live velocity, so you can SEE what each control does to it
        print_at( 470,  8, "VX" );
        PrintInt( 500,  8, (int)vb2_GetVX( player ) );
        print_at( 560,  8, "VY" );
        PrintInt( 590,  8, (int)vb2_GetVY( player ) );

        // the arena
        float fx;
        for( fx = -WALL_X; fx <= WALL_X; fx = fx + 0.5 )
            print_at( vb2_ScreenX( fx ), vb2_ScreenY( FLOOR_TOP ), "=" );
        float wy;
        for( wy = FLOOR_TOP; wy <= 8.0; wy = wy + 0.5 )
        {
            print_at( vb2_ScreenX( -WALL_X ), vb2_ScreenY( wy ), "|" );
            print_at( vb2_ScreenX(  WALL_X ), vb2_ScreenY( wy ), "|" );
        }

        // crates + player
        int c;
        for( c = 0; c < 5; c++ )
            print_at( vb2_ScreenX( vb2_GetX( crates[ c ] ) ) - 8,
                      vb2_ScreenY( vb2_GetY( crates[ c ] ) ) - 5, "[]" );

        print_at( vb2_ScreenX( vb2_GetX( player ) ) - 4,
                  vb2_ScreenY( vb2_GetY( player ) ) - 5, "O" );

        end_frame();
    }
}
