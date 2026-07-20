// =============================================================================
//   VirconBox2D tutorial -- Lesson 2: Bodies and Materials
// =============================================================================
//   One scene, three experiments:
//
//     * BOUNCE ROW (left): three identical balls, restitution 0.0 / 0.5 / 0.9,
//       dropped together. Watch how differently they land.
//     * FRICTION RAMP (middle): two identical boxes on a slope. The icy one
//       (friction 0.02) slides off; the grippy one (friction 0.9) sticks.
//     * DENSITY CANNON (bottom): B fires a HEAVY ball (density 8), X fires a
//       LIGHT one (density 0.2) -- same size! -- across the floor into
//       everything. Mass doesn't change how a body FALLS, only how it PUSHES.
//
//   Controls:  B = fire heavy ball,  X = fire light ball,  A = reset scene
//
//   Build:  bash build.sh lesson2_materials    ->  bin/lesson2_materials.v32
// =============================================================================

#include "video.h"
#include "time.h"
#include "input.h"
#include "string.h"       // itoa
#include "../vb2.h"

// ---- the level, in meters. Named so drawing can't drift from physics. ----
#define FLOOR_TOP   -7.0
#define RAMP_X1     -2.0
#define RAMP_Y1      1.0
#define RAMP_X2      7.0
#define RAMP_Y2     -3.0

// Handles are plain ints, so they can live in globals like any other int.
int ballDead;   int ballHalf;   int ballSuper;      // the bounce row
int boxIce;     int boxGrip;                        // the ramp pair
int shotHeavy;  int shotLight;                      // the cannon balls
int[3] crates;                                      // a stack to knock over

// print an int at a screen position (itoa + print_at -- the console idiom)
void PrintInt( int x, int y, int value )
{
    int[16] s;
    itoa( value, s, 10 );
    print_at( x, y, s );
}

// Put every dynamic body back where it started, standing still. SetPosition
// and SetVelocity are TELEPORTS: the body just IS there now, no collision
// happens along the way. Perfect for spawning and resetting -- never use them
// for normal movement (that's lesson 3).
void ResetScene()
{
    // bounce row: same drop height, only restitution differs
    vb2_SetPosition( ballDead,  -13.0, 4.0 );
    vb2_SetPosition( ballHalf,  -10.0, 4.0 );
    vb2_SetPosition( ballSuper,  -7.0, 4.0 );

    // ramp pair: just above the slope so they drop onto it
    vb2_SetPosition( boxIce,  -1.4, 1.6 );
    vb2_SetPosition( boxGrip,  1.5, 1.2 );
    vb2_SetAngle( boxIce,  0.0 );
    vb2_SetAngle( boxGrip, 0.0 );

    // crate stack on the floor (center = floor top + half height + gaps)
    int i;
    for( i = 0; i < 3; i++ )
        vb2_SetPosition( crates[ i ], 11.0, FLOOR_TOP + 0.5 + i * 1.05 );

    // park the cannon balls on a hidden shelf, off camera to the right
    vb2_SetPosition( shotHeavy, 40.0, -6.0 );
    vb2_SetPosition( shotLight, 43.0, -6.0 );

    // zero every velocity -- a teleport keeps the old motion otherwise!
    int[10] all;
    all[0] = ballDead;   all[1] = ballHalf;  all[2] = ballSuper;
    all[3] = boxIce;     all[4] = boxGrip;
    all[5] = crates[0];  all[6] = crates[1]; all[7] = crates[2];
    all[8] = shotHeavy;  all[9] = shotLight;

    for( i = 0; i < 10; i++ )
    {
        vb2_SetVelocity( all[ i ], 0.0, 0.0 );
        vb2_SetAngularVelocity( all[ i ], 0.0 );
    }
}

void main()
{
    vb2_Init();
    vb2_SetCamera( 0.0, 0.0, 20.0 );

    // ---- static level ----
    vb2_Wall( 0.0, -7.5, 15.0, 0.5 );                       // floor, top = -7.0
    vb2_Line( RAMP_X1, RAMP_Y1, RAMP_X2, RAMP_Y2 );         // the ramp: a static
                                                            // segment -- a zero-
                                                            // thickness wall, ideal
                                                            // for slopes and terrain
    vb2_Wall( 41.5, -7.0, 3.0, 0.5 );                       // hidden parking shelf

    // ---- the bounce row: identical balls, only SetBounce differs ----
    ballDead  = vb2_Ball( -13.0, 4.0, 0.6 );
    ballHalf  = vb2_Ball( -10.0, 4.0, 0.6 );
    ballSuper = vb2_Ball(  -7.0, 4.0, 0.6 );
    vb2_SetBounce( ballDead,  0.0 );      // clay:      thud
    vb2_SetBounce( ballHalf,  0.5 );      // wood-ish:  a few hops
    vb2_SetBounce( ballSuper, 0.9 );      // superball: nearly all the way back

    // ---- the ramp pair: identical boxes, only SetFriction differs ----
    boxIce  = vb2_Box( -1.4, 1.6, 0.5, 0.5 );
    boxGrip = vb2_Box(  1.5, 1.2, 0.5, 0.5 );
    vb2_SetFriction( boxIce,  0.02 );     // ice cube
    vb2_SetFriction( boxGrip, 0.9 );      // rubber block

    // ---- crates to knock over ----
    int i;
    for( i = 0; i < 3; i++ )
        crates[ i ] = vb2_Box( 11.0, FLOOR_TOP + 0.5 + i * 1.05, 0.5, 0.5 );

    // ---- the cannon balls: SAME radius, wildly different density.
    //      density is kg per square meter; mass = density x area.
    shotHeavy = vb2_Ball( 40.0, -6.0, 0.5 );
    shotLight = vb2_Ball( 43.0, -6.0, 0.5 );
    vb2_SetDensity( shotHeavy, 8.0 );     // a cannonball  (~6.3 kg)
    vb2_SetDensity( shotLight, 0.2 );     // a beach ball  (~0.16 kg)

    ResetScene();
    select_gamepad( 0 );

    while( true )
    {
        // ---- input. "== 1" is true only on the frame the button went down.
        if( gamepad_button_a() == 1 )
            ResetScene();

        if( gamepad_button_b() == 1 )
        {
            vb2_SetPosition( shotHeavy, -15.3, -5.8 );      // teleport to muzzle...
            vb2_SetVelocity( shotHeavy, 30.0, 2.0 );        // ...and launch
        }
        if( gamepad_button_x() == 1 )
        {
            vb2_SetPosition( shotLight, -15.3, -5.8 );
            vb2_SetVelocity( shotLight, 30.0, 2.0 );
        }

        vb2_Step();

        // ---------------------------------------------------------------------
        //   Draw
        // ---------------------------------------------------------------------
        clear_screen( color_black );
        set_multiply_color( color_white );

        print_at( 10,  8, "LESSON 2: BODIES AND MATERIALS" );
        print_at( 10, 22, "B HEAVY SHOT   X LIGHT SHOT   A RESET" );

        // floor
        float fx;
        for( fx = -15.0; fx <= 15.0; fx = fx + 0.5 )
            print_at( vb2_ScreenX( fx ), vb2_ScreenY( FLOOR_TOP ), "=" );

        // ramp (drawn from the same constants the segment was built from)
        float t;
        for( t = 0.0; t <= 1.0; t = t + 0.05 )
        {
            float rx = RAMP_X1 + ( RAMP_X2 - RAMP_X1 ) * t;
            float ry = RAMP_Y1 + ( RAMP_Y2 - RAMP_Y1 ) * t;
            print_at( vb2_ScreenX( rx ) - 4, vb2_ScreenY( ry ) - 5, "\\" );
        }

        // bounce row + labels under their columns
        print_at( vb2_ScreenX( vb2_GetX( ballDead ) )  - 4, vb2_ScreenY( vb2_GetY( ballDead ) )  - 5, "O" );
        print_at( vb2_ScreenX( vb2_GetX( ballHalf ) )  - 4, vb2_ScreenY( vb2_GetY( ballHalf ) )  - 5, "O" );
        print_at( vb2_ScreenX( vb2_GetX( ballSuper ) ) - 4, vb2_ScreenY( vb2_GetY( ballSuper ) ) - 5, "O" );
        print_at( vb2_ScreenX( -13.6 ), 340, "0.0" );
        print_at( vb2_ScreenX( -10.6 ), 340, "0.5" );
        print_at( vb2_ScreenX(  -7.6 ), 340, "0.9" );

        // ramp pair. GetAngle is radians, counter-clockwise; show degrees.
        print_at( vb2_ScreenX( vb2_GetX( boxIce ) )  - 8, vb2_ScreenY( vb2_GetY( boxIce ) )  - 5, "[]" );
        print_at( vb2_ScreenX( vb2_GetX( boxGrip ) ) - 8, vb2_ScreenY( vb2_GetY( boxGrip ) ) - 5, "[]" );
        print_at( 470, 8, "GRIP BOX ANGLE" );
        PrintInt( 610, 8, (int)( vb2_GetAngle( boxGrip ) * 57.29578 ) );

        // crates + cannon balls
        int c;
        for( c = 0; c < 3; c++ )
            print_at( vb2_ScreenX( vb2_GetX( crates[ c ] ) ) - 8,
                      vb2_ScreenY( vb2_GetY( crates[ c ] ) ) - 5, "[]" );

        print_at( vb2_ScreenX( vb2_GetX( shotHeavy ) ) - 4,
                  vb2_ScreenY( vb2_GetY( shotHeavy ) ) - 5, "@" );
        print_at( vb2_ScreenX( vb2_GetX( shotLight ) ) - 4,
                  vb2_ScreenY( vb2_GetY( shotLight ) ) - 5, "o" );

        end_frame();
    }
}
