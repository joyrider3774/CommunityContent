// =============================================================================
//   VirconBox2D tutorial -- Lesson 1: Hello, Gravity
// =============================================================================
//   The smallest possible physics game: one floor, one ball, gravity.
//
//   This program is the whole shape of every physics game you will ever write:
//
//       1. CREATE the world and the bodies in it        (once, before the loop)
//       2. STEP the simulation                          (once per frame)
//       3. READ where the bodies ended up               (after the step)
//       4. DRAW them                                    (however you like)
//
//   Build:  bash build.sh lesson1_hello    ->  bin/lesson1_hello.v32
// =============================================================================

#include "video.h"        // clear_screen, print_at, end_frame
#include "time.h"         // end_frame lives here on this console
#include "../vb2.h"       // the VirconBox2D easy API

void main()
{
    // -------------------------------------------------------------------------
    //   1. CREATE
    // -------------------------------------------------------------------------

    // Make the physics world. Gravity defaults to (0, -10): "down" is -y,
    // just like in the real world (and unlike screen coordinates!).
    vb2_Init();

    // The camera maps the physics world (meters, y UP) to the screen
    // (pixels, y DOWN). This says: put world point (0,0) at the center of the
    // 640x360 screen, and draw 20 pixels for every meter. The screen then
    // shows a 32 m x 18 m window into the world.
    vb2_SetCamera( 0.0, 0.0, 20.0 );

    // A STATIC box for the floor. Static bodies never move -- they are the
    // level. Arguments: center x, center y, HALF width, HALF height.
    // So this box is 24 m wide and 1 m tall, centered at (0, -7):
    // its top surface is the line y = -6.5.
    vb2_Wall( 0.0, -7.0, 12.0, 0.5 );

    // A DYNAMIC ball: radius 0.5 m, starting 6 m above the origin. Dynamic
    // bodies have mass and respond to gravity and collisions. The int we get
    // back is a HANDLE -- our name for this body from now on.
    int ball = vb2_Ball( 0.0, 6.0, 0.5 );

    // Make it bouncy. 0 = dead stop on landing (the default), 1 = bounces all
    // the way back up. 0.7 is a decent rubber ball.
    vb2_SetBounce( ball, 0.7 );

    // -------------------------------------------------------------------------
    //   The game loop
    // -------------------------------------------------------------------------
    while( true )
    {
        // ---- 2. STEP: advance the simulation by 1/60 of a second. The console
        //      shows 60 frames per second, so one step per frame = real time.
        vb2_Step();

        // ---- 3 + 4. READ and DRAW ----
        clear_screen( color_black );
        set_multiply_color( color_white );

        print_at( 10, 8, "LESSON 1: HELLO, GRAVITY" );

        // Draw the floor. Physics bodies are invisible -- if you don't draw
        // something where a body is, the player sees things resting on nothing.
        // We know where we put the floor, so we draw its top surface (y = -6.5).
        float fx;
        for( fx = -12.0; fx <= 12.0; fx = fx + 0.5 )
            print_at( vb2_ScreenX( fx ), vb2_ScreenY( -6.5 ), "=" );

        // Draw the ball: ask physics where it is NOW, map world -> screen,
        // put a glyph there. (The -4 / -5 nudges roughly center the glyph
        // on the point.) A real game draws a sprite instead -- this line is
        // still the only physics it needs.
        print_at( vb2_ScreenX( vb2_GetX( ball ) ) - 4,
                  vb2_ScreenY( vb2_GetY( ball ) ) - 5, "O" );

        end_frame();
    }
}
