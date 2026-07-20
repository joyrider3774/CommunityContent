// =============================================================================
//   VirconBox2D tutorial -- Lesson 7: Beyond the Facade
// =============================================================================
//   Everything so far used vb2.h, the easy API. Underneath it sits the FULL
//   port of Box2D v3 -- the b2* API -- and the two are made to mix freely:
//   vb2_world IS a b2World, and any vb2 handle converts to a real b2BodyId.
//
//   This lesson mixes them three ways:
//
//     * A GOAL ZONE built with the raw API: a SENSOR shape -- it detects
//       overlap but collides with nothing. The facade can't make one; the
//       full API can.
//     * SENSOR EVENTS polled straight off the world, and their raw shape ids
//       resolved back to a body -- so only the PLAYER entering counts (shove
//       a crate in: nothing happens).
//     * MOON MODE: per-body gravity via b2Body_SetGravityScale, reached
//       through vb2_GetBodyId. The crates stay heavy; you float.
//
//   Controls:  d-pad = roll,  A = jump (grounded),  B = toggle moon mode
//
//   Build:  bash build.sh lesson7_beyond    ->  bin/lesson7_beyond.v32
// =============================================================================

#include "video.h"
#include "time.h"
#include "input.h"
#include "string.h"
#include "../vb2.h"        // pulls in the ENTIRE b2* API underneath

#define FLOOR_TOP  -7.0
#define WALL_X     15.0
#define PLAYER_R    0.7

// the goal zone, in meters
#define ZONE_X     12.0
#define ZONE_Y     -5.5
#define ZONE_HALF   1.5

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

    vb2_Wall( 0.0, -7.5, WALL_X + 1.0, 0.5 );
    vb2_Wall( -WALL_X - 0.5, 0.0, 0.5, 9.0 );
    vb2_Wall(  WALL_X + 0.5, 0.0, 0.5, 9.0 );

    int player = vb2_Ball( -10.0, -5.0, PLAYER_R );
    vb2_SetFriction( player, 0.9 );
    float mass = vb2_GetMass( player );

    // crates -- pushable into the zone, to prove only the PLAYER triggers it
    int[3] crates;
    int i;
    for( i = 0; i < 3; i++ )
        crates[ i ] = vb2_Box( 2.0 + i * 1.4, FLOOR_TOP + 0.6, 0.6, 0.6 );

    // -------------------------------------------------------------------------
    //   RAW API #1: the sensor zone. Note the b2* conventions, all at once:
    //
    //     * the world is passed EXPLICITLY: &vb2_world (the facade's world is
    //       an ordinary b2World -- that is the whole trick)
    //     * every create starts from a DEF struct, filled by a b2Default*Def
    //     * results come back through OUT-POINTERS (multi-word structs cannot
    //       cross a function boundary by value on this console)
    //     * handles like b2BodyId / b2ShapeId are structs you keep storage for
    // -------------------------------------------------------------------------
    b2BodyDef zoneDef;
    b2DefaultBodyDef( &zoneDef );              // type defaults to static
    zoneDef.position.x = ZONE_X;
    zoneDef.position.y = ZONE_Y;

    b2BodyId zoneBody;
    b2CreateBody( &vb2_world, &zoneDef, &zoneBody );

    b2Polygon zoneBox;
    b2MakeBox( ZONE_HALF, ZONE_HALF, &zoneBox );

    b2ShapeDef zoneShapeDef;
    b2DefaultShapeDef( &zoneShapeDef );
    zoneShapeDef.isSensor = true;              // detect overlap, collide with nothing

    b2ShapeId zoneShape;
    b2CreatePolygonShape( &vb2_world, &zoneBody, &zoneShapeDef, &zoneBox, &zoneShape );

    // -------------------------------------------------------------------------
    //   RAW API #2: the escape hatch. A facade handle converts to a real,
    //   generation-checked b2BodyId -- then every b2Body_* function applies.
    // -------------------------------------------------------------------------
    b2BodyId playerId;
    vb2_GetBodyId( player, &playerId );

    bool moon = false;
    int goals = 0;
    int goalFlash = 0;

    select_gamepad( 0 );

    while( true )
    {
        float px = vb2_GetX( player );
        float py = vb2_GetY( player );

        // lesson 5's grounded jump + lesson 3's roll
        int ground = vb2_RayCast( px, py - PLAYER_R - 0.02,
                                  px, py - PLAYER_R - 0.15 );
        bool grounded = ( ground != -1 );

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
        if( gamepad_button_a() == 1 && grounded )
            vb2_ApplyImpulse( player, 0.0, 7.0 * mass );

        // ---- moon mode: gravity scale on the PLAYER ONLY. There is no facade
        //      call for this -- and none needed: convert the handle once, call
        //      the full API.
        if( gamepad_button_b() == 1 )
        {
            moon = !moon;
            if( moon )
                b2Body_SetGravityScale( &vb2_world, &playerId, 0.3 );
            else
                b2Body_SetGravityScale( &vb2_world, &playerId, 1.0 );
        }

        vb2_Step();

        // ---------------------------------------------------------------------
        //   RAW API #3: sensor events. Same poll-after-step contract as
        //   vb2_TouchCount, but the events carry RAW shape ids (plain ints).
        //   Resolving one takes two hops:
        //       raw int -> b2ShapeId   (b2MakeShapeId)
        //       b2ShapeId -> b2BodyId  (b2Shape_GetBody)
        //   Then "is it the player?" is an index compare.
        // ---------------------------------------------------------------------
        int n = b2World_GetSensorBeginEventCount( &vb2_world );
        b2SensorTouchEvent* events = b2World_GetSensorBeginEvents( &vb2_world );

        int e;
        for( e = 0; e < n; e++ )
        {
            b2ShapeId visitorShape;
            b2MakeShapeId( &vb2_world, events[ e ].visitorShapeId, &visitorShape );

            b2BodyId visitorBody;
            b2Shape_GetBody( &vb2_world, &visitorShape, &visitorBody );

            if( visitorBody.index1 == playerId.index1 )    // a crate would fail this
            {
                goals = goals + 1;
                goalFlash = 40;
            }
        }

        // ---------------------------------------------------------------------
        //   Draw
        // ---------------------------------------------------------------------
        clear_screen( color_black );
        set_multiply_color( color_white );

        print_at( 10,  8, "LESSON 7: BEYOND THE FACADE" );
        print_at( 10, 22, "DPAD ROLL   A JUMP   B MOON MODE" );
        print_at( 470,  8, "GOALS" );
        PrintInt( 540,  8, goals );
        if( moon )
            print_at( 470, 22, "MOON 0.3G" );
        if( goalFlash > 0 )
        {
            goalFlash = goalFlash - 1;
            print_at( 290, 40, "GOAL!" );
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

        // the zone: a dotted outline (a sensor is invisible like everything else)
        float d;
        for( d = -ZONE_HALF; d <= ZONE_HALF; d = d + 0.5 )
        {
            print_at( vb2_ScreenX( ZONE_X + d ) - 4, vb2_ScreenY( ZONE_Y + ZONE_HALF ) - 5, "." );
            print_at( vb2_ScreenX( ZONE_X + d ) - 4, vb2_ScreenY( ZONE_Y - ZONE_HALF ) - 5, "." );
            print_at( vb2_ScreenX( ZONE_X - ZONE_HALF ) - 4, vb2_ScreenY( ZONE_Y + d ) - 5, "." );
            print_at( vb2_ScreenX( ZONE_X + ZONE_HALF ) - 4, vb2_ScreenY( ZONE_Y + d ) - 5, "." );
        }

        for( i = 0; i < 3; i++ )
            print_at( vb2_ScreenX( vb2_GetX( crates[ i ] ) ) - 8,
                      vb2_ScreenY( vb2_GetY( crates[ i ] ) ) - 5, "[]" );

        print_at( vb2_ScreenX( px ) - 4, vb2_ScreenY( py ) - 5, "O" );

        end_frame();
    }
}
