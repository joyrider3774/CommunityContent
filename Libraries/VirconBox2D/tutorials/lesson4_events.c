// =============================================================================
//   VirconBox2D tutorial -- Lesson 4: Collisions
// =============================================================================
//   CRATE CRUSHER, the first actual game of the course. Crates rain from the
//   sky; ram them to crush them; score goes up. Crates you miss pile up and
//   get in your way.
//
//   New in this lesson:
//     * touch events:   vb2_TouchCount / vb2_TouchA / vb2_TouchB
//     * destroying:     vb2_Destroy, vb2_Exists, and dead-handle safety
//     * THE pattern:    collect what should die first, THEN destroy it --
//                       never destroy bodies while you're still reading events
//
//   Controls:  d-pad = roll,  A = jump (still works mid-air; lesson 5 fixes it)
//
//   Build:  bash build.sh lesson4_events    ->  bin/lesson4_events.v32
// =============================================================================

#include "video.h"
#include "time.h"
#include "input.h"
#include "string.h"
#include "misc.h"         // rand
#include "../vb2.h"

#define FLOOR_TOP   -7.0
#define WALL_X      15.0
#define PLAYER_R     0.7
#define MAX_CRATES  12
#define SPAWN_EVERY 45    // frames between crate drops

int[MAX_CRATES] crates;   // each slot: a crate handle, or a DEAD handle.
                          // Dead handles are safe -- vb2_Exists tells them apart.
int player;

void PrintInt( int x, int y, int value )
{
    int[16] s;
    itoa( value, s, 10 );
    print_at( x, y, s );
}

// Is this handle one of our crates? Handles are ints: just compare.
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

    // arena
    vb2_Wall( 0.0, -7.5, WALL_X + 1.0, 0.5 );
    vb2_Wall( -WALL_X - 0.5, 0.0, 0.5, 9.0 );
    vb2_Wall(  WALL_X + 0.5, 0.0, 0.5, 9.0 );

    // player
    player = vb2_Ball( 0.0, -5.0, PLAYER_R );
    vb2_SetFriction( player, 0.9 );
    float mass = vb2_GetMass( player );

    // Start every crate slot as -1 ("no body"). -1 is itself a dead handle:
    // vb2_Exists( -1 ) is false, so empty and destroyed slots look the same.
    int i;
    for( i = 0; i < MAX_CRATES; i++ )
        crates[ i ] = -1;

    int score = 0;
    int crushFlash = 0;                    // frames left to show "CRUSHED!"
    int spawnTimer = SPAWN_EVERY;

    select_gamepad( 0 );

    while( true )
    {
        // ---------------------------------------------------------------------
        //   Spawn: every SPAWN_EVERY frames, drop a crate into a FREE slot.
        //   A slot is free when the handle in it no longer names a live body --
        //   whether it started as -1 or its crate was crushed long ago.
        // ---------------------------------------------------------------------
        spawnTimer = spawnTimer - 1;
        if( spawnTimer <= 0 )
        {
            spawnTimer = SPAWN_EVERY;
            for( i = 0; i < MAX_CRATES; i++ )
                if( !vb2_Exists( crates[ i ] ) )
                {
                    float x = ( rand() % 25 ) - 12.0;
                    crates[ i ] = vb2_Box( x, 10.0, 0.6, 0.6 );
                    break;
                }
        }

        // ---- input (lesson 3's controls, condensed) ----
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
        if( gamepad_button_a() == 1 )
            vb2_ApplyImpulse( player, 0.0, 7.0 * mass );

        vb2_Step();

        // ---------------------------------------------------------------------
        //   Collisions. Touch events are valid from this step until the next
        //   vb2_Step() clears them -- poll them NOW, right after stepping.
        //
        //   PASS 1 -- COLLECT: read every event, decide who dies, remember them.
        //   PASS 2 -- DESTROY: kill the collected bodies.
        //
        //   Why two passes? Destroying a body while events are still being read
        //   makes any LATER event that involves it resolve to -1 -- you would
        //   silently miss hits. Collect first and the problem cannot happen.
        // ---------------------------------------------------------------------
        int[MAX_CRATES] doomed;
        int doomedCount = 0;

        int e;
        for( e = 0; e < vb2_TouchCount(); e++ )
        {
            int a = vb2_TouchA( e );       // the two BODIES that began touching
            int b = vb2_TouchB( e );

            // we want "player touched a crate", either way around
            int other = -1;
            if( a == player )  other = b;
            if( b == player )  other = a;

            if( other != -1 && IsCrate( other ) )
            {
                doomed[ doomedCount ] = other;
                doomedCount = doomedCount + 1;
            }
        }

        for( i = 0; i < doomedCount; i++ )
            if( vb2_Exists( doomed[ i ] ) )    // guard: same crate twice in one frame
            {
                vb2_Destroy( doomed[ i ] );
                score = score + 1;
                crushFlash = 20;
            }

        // Housekeeping: a crate that somehow escaped the arena falls forever
        // and never frees its slot. Destroy anything that gets too low.
        for( i = 0; i < MAX_CRATES; i++ )
            if( vb2_Exists( crates[ i ] ) && vb2_GetY( crates[ i ] ) < -20.0 )
                vb2_Destroy( crates[ i ] );

        // ---------------------------------------------------------------------
        //   Draw
        // ---------------------------------------------------------------------
        clear_screen( color_black );
        set_multiply_color( color_white );

        print_at( 10,  8, "LESSON 4: CRATE CRUSHER" );
        print_at( 10, 22, "RAM THE FALLING CRATES" );
        print_at( 470, 8, "SCORE" );
        PrintInt( 540, 8, score );

        if( crushFlash > 0 )
        {
            crushFlash = crushFlash - 1;
            print_at( 290, 40, "CRUSHED!" );
        }

        float fx;
        for( fx = -WALL_X; fx <= WALL_X; fx = fx + 0.5 )
            print_at( vb2_ScreenX( fx ), vb2_ScreenY( FLOOR_TOP ), "=" );
        float wy;
        for( wy = FLOOR_TOP; wy <= 9.0; wy = wy + 0.5 )
        {
            print_at( vb2_ScreenX( -WALL_X ), vb2_ScreenY( wy ), "|" );
            print_at( vb2_ScreenX(  WALL_X ), vb2_ScreenY( wy ), "|" );
        }

        // Draw only the crates that still exist. A dead handle in the array is
        // fine -- we just skip it. (Even calling vb2_GetX on it would only
        // return 0.0, never crash. That is the point of generation-checked
        // handles.)
        for( i = 0; i < MAX_CRATES; i++ )
            if( vb2_Exists( crates[ i ] ) )
                print_at( vb2_ScreenX( vb2_GetX( crates[ i ] ) ) - 8,
                          vb2_ScreenY( vb2_GetY( crates[ i ] ) ) - 5, "[]" );

        print_at( vb2_ScreenX( vb2_GetX( player ) ) - 4,
                  vb2_ScreenY( vb2_GetY( player ) ) - 5, "O" );

        end_frame();
    }
}
