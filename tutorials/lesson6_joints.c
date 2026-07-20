// =============================================================================
//   VirconBox2D tutorial -- Lesson 6: Joints
// =============================================================================
//   Joints CONNECT bodies. Two joints and a motor are enough for most games:
//
//     vb2_Pin  = a hinge at a world point  -- here: wheels on a car chassis
//     vb2_Rope = holds two bodies at their current distance -- a wrecking ball
//     vb2_Motor = powers a pin             -- here: the car's wheel drive
//
//   The scene: drive the car up the ramp, over the gap, into the crate stack.
//   Or don't bother -- press B to cut the wrecking ball's rope mid-swing and
//   let it do the demolition for you.
//
//   Controls:  d-pad left/right = drive,  A (hold) = brake,  B = cut the rope
//
//   Build:  bash build.sh lesson6_joints    ->  bin/lesson6_joints.v32
// =============================================================================

#include "video.h"
#include "time.h"
#include "input.h"
#include "string.h"
#include "../vb2.h"

#define FLOOR_TOP  -7.0
#define WALL_X     16.0

// the ramp
#define RAMP_X1    -4.0
#define RAMP_Y1    -7.0
#define RAMP_X2     2.0
#define RAMP_Y2    -5.6

// the wrecking ball's anchor point
#define ANCHOR_X   10.0
#define ANCHOR_Y    7.0

void main()
{
    vb2_Init();
    vb2_SetCamera( 0.0, 0.0, 20.0 );

    // ---- level: floor, walls, a ramp ----
    vb2_Wall( 0.0, -7.5, WALL_X + 1.0, 0.5 );
    vb2_Wall( -WALL_X - 0.5, 0.0, 0.5, 9.0 );
    vb2_Wall(  WALL_X + 0.5, 0.0, 0.5, 9.0 );
    vb2_Line( RAMP_X1, RAMP_Y1, RAMP_X2, RAMP_Y2 );

    // -------------------------------------------------------------------------
    //   THE CAR: one chassis box + two wheel balls + two pins + two motors.
    //
    //   Order matters: CREATE the bodies in their final positions FIRST, then
    //   joint them. A pin takes a WORLD point -- we pin at each wheel's center,
    //   so the wheel spins in place relative to the chassis, like an axle.
    //
    //   Jointed bodies do not collide with each other, so the wheels may
    //   overlap the chassis freely.
    // -------------------------------------------------------------------------
    int chassis = vb2_Box( -11.0, -5.7, 1.3, 0.35 );

    int wheelL = vb2_Ball( -12.0, -6.5, 0.5 );
    int wheelR = vb2_Ball( -10.0, -6.5, 0.5 );
    vb2_SetFriction( wheelL, 1.2 );        // tires need grip: torque -> traction
    vb2_SetFriction( wheelR, 1.2 );

    int axleL = vb2_Pin( chassis, wheelL, -12.0, -6.5 );
    int axleR = vb2_Pin( chassis, wheelR, -10.0, -6.5 );

    // -------------------------------------------------------------------------
    //   THE WRECKING BALL: a heavy ball roped to a static anchor. A rope locks
    //   in the distance the bodies have WHEN YOU CREATE IT -- so we place the
    //   ball out to the side, at full rope length, and it starts swinging the
    //   moment the game begins.
    //
    //   A rope needs two bodies; for "hang from a fixed point in the world",
    //   the other body is just a small static wall at the anchor.
    // -------------------------------------------------------------------------
    int anchor = vb2_Wall( ANCHOR_X, ANCHOR_Y, 0.3, 0.3 );

    int ball = vb2_Ball( 14.5, -2.5, 0.8 );      // out to the side: ~10.9 m of rope
    vb2_SetDensity( ball, 3.0 );                 // heavy -- it is a wrecking ball

    int rope = vb2_Rope( anchor, ball );

    // ---- a crate stack in the swing path ----
    int[4] crates;
    int i;
    for( i = 0; i < 4; i++ )
        crates[ i ] = vb2_Box( 8.0, FLOOR_TOP + 0.5 + i * 1.05, 0.5, 0.5 );

    select_gamepad( 0 );

    while( true )
    {
        // ---------------------------------------------------------------------
        //   Driving = setting the wheel motors every frame.
        //     speed     target spin, rad/s (negative = clockwise = rolls RIGHT)
        //     maxTorque how hard the motor may push to reach that speed
        //   Speed 0 with high torque is a BRAKE: a servo holding its angle.
        // ---------------------------------------------------------------------
        if( gamepad_right() > 0 )
        {
            vb2_Motor( axleL, -14.0, 20.0 );
            vb2_Motor( axleR, -14.0, 20.0 );
        }
        else if( gamepad_left() > 0 )
        {
            vb2_Motor( axleL, 14.0, 20.0 );
            vb2_Motor( axleR, 14.0, 20.0 );
        }
        else if( gamepad_button_a() > 0 )
        {
            vb2_Motor( axleL, 0.0, 40.0 );       // brake: hold the wheels still
            vb2_Motor( axleR, 0.0, 40.0 );
        }
        else
        {
            vb2_Motor( axleL, 0.0, 0.0 );        // no torque: free-wheeling
            vb2_Motor( axleR, 0.0, 0.0 );
        }

        // ---- cut the rope. Destroying a joint frees the bodies instantly --
        //      the ball keeps whatever velocity the swing gave it and flies.
        if( gamepad_button_b() == 1 && vb2_JointExists( rope ) )
            vb2_DestroyJoint( rope );

        vb2_Step();

        // ---------------------------------------------------------------------
        //   Draw
        // ---------------------------------------------------------------------
        clear_screen( color_black );
        set_multiply_color( color_white );

        print_at( 10,  8, "LESSON 6: JOINTS" );
        print_at( 10, 22, "DPAD DRIVE   A BRAKE   B CUT ROPE" );

        // level
        float fx;
        for( fx = -WALL_X; fx <= WALL_X; fx = fx + 0.5 )
            print_at( vb2_ScreenX( fx ), vb2_ScreenY( FLOOR_TOP ), "=" );
        float wy;
        for( wy = FLOOR_TOP; wy <= 9.0; wy = wy + 0.5 )
        {
            print_at( vb2_ScreenX( -WALL_X ), vb2_ScreenY( wy ), "|" );
            print_at( vb2_ScreenX(  WALL_X ), vb2_ScreenY( wy ), "|" );
        }
        float t;
        for( t = 0.0; t <= 1.0; t = t + 0.08 )
        {
            float rx = RAMP_X1 + ( RAMP_X2 - RAMP_X1 ) * t;
            float ry = RAMP_Y1 + ( RAMP_Y2 - RAMP_Y1 ) * t;
            print_at( vb2_ScreenX( rx ) - 4, vb2_ScreenY( ry ) - 5, "/" );
        }

        // the rope, drawn only while it exists -- joints are invisible too!
        float bx = vb2_GetX( ball );
        float by = vb2_GetY( ball );

        print_at( vb2_ScreenX( ANCHOR_X ) - 4, vb2_ScreenY( ANCHOR_Y ) - 5, "#" );
        if( vb2_JointExists( rope ) )
        {
            for( t = 0.0; t <= 1.0; t = t + 0.07 )
            {
                float lx = ANCHOR_X + ( bx - ANCHOR_X ) * t;
                float ly = ANCHOR_Y + ( by - ANCHOR_Y ) * t;
                print_at( vb2_ScreenX( lx ) - 4, vb2_ScreenY( ly ) - 5, "." );
            }
        }
        print_at( vb2_ScreenX( bx ) - 4, vb2_ScreenY( by ) - 5, "@" );

        // the car: chassis + both wheels, each drawn where physics says it is
        print_at( vb2_ScreenX( vb2_GetX( chassis ) ) - 16,
                  vb2_ScreenY( vb2_GetY( chassis ) ) - 5, "[==]" );
        print_at( vb2_ScreenX( vb2_GetX( wheelL ) ) - 4,
                  vb2_ScreenY( vb2_GetY( wheelL ) ) - 5, "o" );
        print_at( vb2_ScreenX( vb2_GetX( wheelR ) ) - 4,
                  vb2_ScreenY( vb2_GetY( wheelR ) ) - 5, "o" );

        // crates
        for( i = 0; i < 4; i++ )
            print_at( vb2_ScreenX( vb2_GetX( crates[ i ] ) ) - 8,
                      vb2_ScreenY( vb2_GetY( crates[ i ] ) ) - 5, "[]" );

        end_frame();
    }
}
