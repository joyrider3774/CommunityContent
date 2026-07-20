// =============================================================================
//   vb2.h -- the game-facing facade over VirconBox2D
// =============================================================================
//   The b2* API is faithful to Box2D v3, which means it is verbose: multi-word
//   handles that cannot cross a function boundary by value, out-pointers for
//   every vector, a def struct per create. That is correct, and it stays -- but
//   dropping a box on a floor should not cost 25 lines.
//
//   This facade is the 90% game path:
//
//     * ONE implicit world (vb2_world), created by vb2_Init(). A console game
//       has one physics world. If you need two, use the b2* API directly.
//     * Handles are a plain 1-word int -- returnable by value, storable in your
//       own structs, comparable. -1 means "none" (and matches NULL == -1).
//     * Scalars in, scalars out. No b2Vec2 round-trips.
//     * One shape per body. The facade hides b2ShapeId entirely; the material
//       setters poke the body's first shape. Multi-shape bodies = b2* API.
//
//   It is sugar, never a wall: vb2_world is a plain b2World, so you can mix
//   b2World_* calls with facade calls freely, and a hot inner loop can hold a
//   real b2BodyId (see vb2_GetBodyId) and call b2Body_* with no facade overhead.
//
//   Usage:
//       #include "video.h"
//       #include "vb2.h"
//
//       void main()
//       {
//           vb2_Init();
//           vb2_Wall( 0.0, 0.0, 6.0, 0.5 );          // static floor
//           int ball = vb2_Ball( 0.0, 8.0, 0.5 );    // dynamic circle
//
//           while( true )
//           {
//               vb2_Step();
//               clear_screen( color_black );
//               print_at( (int)( 320 + vb2_GetX( ball ) * 20.0 ),
//                         (int)( 340 - vb2_GetY( ball ) * 20.0 ), "O" );
//               end_frame();
//           }
//       }
// =============================================================================

#ifndef VB2_H
#define VB2_H

#include "virconbox2d.h"

// -----------------------------------------------------------------------------
//   The world
// -----------------------------------------------------------------------------
b2World vb2_world;

void vb2_SetCamera( float centerX, float centerY, float pixelsPerMeter );

// Create the world. Gravity starts at (0, -10) -- meters, y-up. The camera starts
// at the world origin, screen-centered, at 20 pixels per meter. Call once.
void vb2_Init()
{
    b2CreateWorld( &vb2_world );
    vb2_SetCamera( 0.0, 0.0, 20.0 );
}

void vb2_Quit()
{
    b2DestroyWorld( &vb2_world );
}

void vb2_SetGravity( float gx, float gy )
{
    vb2_world.gravity.x = gx;
    vb2_world.gravity.y = gy;
}

// Sleeping is OFF by default in this port (it keeps the frozen regression suite
// bit-identical). A game almost always wants it ON: a settled pile then costs
// nothing to solve, which is the difference between 40 boxes fitting in the
// 250,000-cycle frame budget and not. Turn it on right after vb2_Init().
void vb2_EnableSleep( bool flag )
{
    b2World_EnableSleeping( &vb2_world, flag );
}

// One physics step: 1/60 s, 4 sub-steps -- one per displayed frame, which is the
// console's fixed rate. Games that want 30 Hz physics with interpolated drawing
// call b2World_Step themselves (see SHOWCASE.md).
void vb2_Step()
{
    b2World_Step( &vb2_world, 1.0 / 60.0, 4 );
}


// -----------------------------------------------------------------------------
//   Handles
// -----------------------------------------------------------------------------
//   A facade handle packs the slot index AND the slot's generation into one int:
//
//       bits  0..15 : index1 (1-based slot, 0 = null)
//       bits 16..30 : generation & 0x7FFF
//       bit     31  : always 0, so every live handle is a positive int and -1 is
//                     an unambiguous "none"
//
//   The generation is what makes a stale handle *detectable*. Carrying the bare
//   index would not: b2MakeBodyId stamps whatever generation the slot currently
//   holds, so a handle rebuilt from an index always looks valid -- and after the
//   slot is recycled by a later create it would silently address a DIFFERENT
//   body. Packing the generation at create time and comparing it on every resolve
//   catches exactly that. (PLAN_VB2_API.md proposed the bare index; this is the
//   one deviation from it, and it costs two shifts per call.)
//
//   The comparison is masked to the same 15 bits that were stored, so a slot
//   recycled more than 32768 times keeps working (it just loses the ability to
//   distinguish that one aliasing case, rather than breaking permanently).
// -----------------------------------------------------------------------------

int vb2_PackHandle( int index1, int generation )
{
    return ( ( generation & 0x7FFF ) << 16 ) | ( index1 & 0xFFFF );
}

// Resolve a handle to a real, generation-checked b2BodyId. False = stale/never
// existed (destroyed body, -1, garbage). Bounds are checked BEFORE any deref.
bool vb2_ResolveBody( int handle, b2BodyId* result )
{
    if( handle <= 0 )
        return false;

    int index1 = handle & 0xFFFF;
    int gen    = ( handle >> 16 ) & 0x7FFF;

    if( index1 <= 0 || index1 > vb2_world.bodies.count )
        return false;

    b2Body* body = &vb2_world.bodies.data[ index1 - 1 ];
    if( body->setIndex == B2_NULL_INDEX )       // freed slot
        return false;
    if( ( body->generation & 0x7FFF ) != gen )  // slot recycled under us
        return false;

    result->index1 = index1;
    result->world0 = vb2_world.worldId;
    result->generation = body->generation;      // the full generation the b2 API expects
    return true;
}

// Escape hatch: fill a real b2BodyId so a hot loop can call b2Body_* directly
// (saves the resolve + call layer). False if the handle is stale.
bool vb2_GetBodyId( int body, b2BodyId* result )
{
    return vb2_ResolveBody( body, result );
}

bool vb2_Exists( int body )
{
    b2BodyId id;
    return vb2_ResolveBody( body, &id );
}

// The body's first (and, on the facade path, only) shape. False if the handle is
// stale or the body carries no shape.
bool vb2_ResolveShape( int handle, b2ShapeId* result )
{
    b2BodyId id;
    if( vb2_ResolveBody( handle, &id ) == false )
        return false;

    b2Body* body = b2GetBodyFullId( &vb2_world, &id );
    if( body->headShapeId == B2_NULL_INDEX )
        return false;

    b2MakeShapeId( &vb2_world, body->headShapeId, result );
    return true;
}


// -----------------------------------------------------------------------------
//   Creators
// -----------------------------------------------------------------------------
//   All sizes are HALF-extents (like b2MakeBox): a 2x1-meter crate is
//   vb2_Box( x, y, 1.0, 0.5 ). Positions are the body's origin, in meters.
//   Every creator returns a handle, or -1 if the body could not be made.
// -----------------------------------------------------------------------------

int vb2_MakeBox( float x, float y, float halfW, float halfH, int type )
{
    b2BodyDef bd;  b2DefaultBodyDef( &bd );
    bd.type = type;
    bd.position.x = x;
    bd.position.y = y;

    b2BodyId id;  b2CreateBody( &vb2_world, &bd, &id );

    b2Polygon box;  b2MakeBox( halfW, halfH, &box );
    b2ShapeDef sd;  b2DefaultShapeDef( &sd );
    b2ShapeId sh;  b2CreatePolygonShape( &vb2_world, &id, &sd, &box, &sh );

    return vb2_PackHandle( id.index1, id.generation );
}

// static box -- floors, walls, platforms
int vb2_Wall( float x, float y, float halfW, float halfH )
{
    return vb2_MakeBox( x, y, halfW, halfH, b2_staticBody );
}

// dynamic box -- crates, players, debris
int vb2_Box( float x, float y, float halfW, float halfH )
{
    return vb2_MakeBox( x, y, halfW, halfH, b2_dynamicBody );
}

// dynamic circle
int vb2_Ball( float x, float y, float radius )
{
    b2BodyDef bd;  b2DefaultBodyDef( &bd );
    bd.type = b2_dynamicBody;
    bd.position.x = x;
    bd.position.y = y;

    b2BodyId id;  b2CreateBody( &vb2_world, &bd, &id );

    b2Circle circle;
    circle.center.x = 0.0;
    circle.center.y = 0.0;
    circle.radius = radius;

    b2ShapeDef sd;  b2DefaultShapeDef( &sd );
    b2ShapeId sh;  b2CreateCircleShape( &vb2_world, &id, &sd, &circle, &sh );

    return vb2_PackHandle( id.index1, id.generation );
}

// static segment between two WORLD points -- thin ground, ramps, level edges.
// The body sits at the origin, so the segment's local points are world points.
int vb2_Line( float x1, float y1, float x2, float y2 )
{
    b2BodyDef bd;  b2DefaultBodyDef( &bd );
    bd.type = b2_staticBody;
    bd.position.x = 0.0;
    bd.position.y = 0.0;

    b2BodyId id;  b2CreateBody( &vb2_world, &bd, &id );

    b2Segment seg;
    seg.point1.x = x1;  seg.point1.y = y1;
    seg.point2.x = x2;  seg.point2.y = y2;

    b2ShapeDef sd;  b2DefaultShapeDef( &sd );
    b2ShapeId sh;  b2CreateSegmentShape( &vb2_world, &id, &sd, &seg, &sh );

    return vb2_PackHandle( id.index1, id.generation );
}

// Destroying a stale handle is a no-op, not a fault.
void vb2_Destroy( int body )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return;

    b2DestroyBody( &vb2_world, &id );
}


// -----------------------------------------------------------------------------
//   Reading a body
// -----------------------------------------------------------------------------
//   A stale handle reads as 0.0 rather than faulting, so a getter on a body that
//   was destroyed this frame is harmless. Use vb2_Exists to tell 0.0-the-value
//   from 0.0-the-body-is-gone.
// -----------------------------------------------------------------------------

float vb2_GetX( int body )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return 0.0;

    b2Vec2 p;  b2Body_GetPosition( &vb2_world, &id, &p );
    return p.x;
}

float vb2_GetY( int body )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return 0.0;

    b2Vec2 p;  b2Body_GetPosition( &vb2_world, &id, &p );
    return p.y;
}

// radians, counter-clockwise
float vb2_GetAngle( int body )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return 0.0;

    b2Rot q;  b2Body_GetRotation( &vb2_world, &id, &q );
    return b2Rot_GetAngle( &q );
}

float vb2_GetVX( int body )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return 0.0;

    b2Vec2 v;  b2Body_GetLinearVelocity( &vb2_world, &id, &v );
    return v.x;
}

float vb2_GetVY( int body )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return 0.0;

    b2Vec2 v;  b2Body_GetLinearVelocity( &vb2_world, &id, &v );
    return v.y;
}

float vb2_GetAngularVelocity( int body )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return 0.0;

    return b2Body_GetAngularVelocity( &vb2_world, &id );
}

bool vb2_IsAwake( int body )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return false;

    return b2Body_IsAwake( &vb2_world, &id );
}


// -----------------------------------------------------------------------------
//   Writing a body
// -----------------------------------------------------------------------------
//   Every mutator is a no-op on a stale handle. The impulse/force calls wake a
//   sleeping body, as you would expect from a game.
// -----------------------------------------------------------------------------

// Teleport, keeping the current rotation. Wakes the body.
void vb2_SetPosition( int body, float x, float y )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return;

    b2Rot q;  b2Body_GetRotation( &vb2_world, &id, &q );

    b2Vec2 p;  p.x = x;  p.y = y;
    b2Body_SetTransform( &vb2_world, &id, &p, &q );
}

// Rotate in place (radians), keeping the current position. Wakes the body.
void vb2_SetAngle( int body, float radians )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return;

    b2Vec2 p;  b2Body_GetPosition( &vb2_world, &id, &p );

    b2Rot q;  b2MakeRot( radians, &q );
    b2Body_SetTransform( &vb2_world, &id, &p, &q );
}

void vb2_SetVelocity( int body, float vx, float vy )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return;

    b2Vec2 v;  v.x = vx;  v.y = vy;
    b2Body_SetLinearVelocity( &vb2_world, &id, &v );
}

void vb2_SetAngularVelocity( int body, float w )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return;

    b2Body_SetAngularVelocity( &vb2_world, &id, w );
}

// An instant kick at the center of mass (kg*m/s) -- jumps, knockback, launches.
void vb2_ApplyImpulse( int body, float ix, float iy )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return;

    b2Vec2 imp;  imp.x = ix;  imp.y = iy;
    b2Body_ApplyLinearImpulseToCenter( &vb2_world, &id, &imp, true );
}

// A sustained push at the center of mass (N) -- thrust, wind. Applied for one
// step, so call it every frame you want it to act.
void vb2_ApplyForce( int body, float fx, float fy )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return;

    b2Vec2 f;  f.x = fx;  f.y = fy;
    b2Body_ApplyForceToCenter( &vb2_world, &id, &f, true );
}

void vb2_ApplyTorque( int body, float torque )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return;

    b2Body_ApplyTorque( &vb2_world, &id, torque, true );
}

void vb2_Wake( int body )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return;

    b2Body_Wake( &vb2_world, &id );
}

float vb2_GetMass( int body )
{
    b2BodyId id;
    if( vb2_ResolveBody( body, &id ) == false )
        return 0.0;

    return b2Body_GetMass( &vb2_world, &id );
}


// -----------------------------------------------------------------------------
//   Material -- these poke the body's FIRST shape (the facade's one-shape rule)
// -----------------------------------------------------------------------------

// 0 = ice, 0.6 = default, 1+ = grippy
void vb2_SetFriction( int body, float friction )
{
    b2ShapeId sh;
    if( vb2_ResolveShape( body, &sh ) == false )
        return;

    b2Shape_SetFriction( &vb2_world, &sh, friction );
}

// 0 = dead (default), 1 = bounces back to its drop height
void vb2_SetBounce( int body, float restitution )
{
    b2ShapeId sh;
    if( vb2_ResolveShape( body, &sh ) == false )
        return;

    b2Shape_SetRestitution( &vb2_world, &sh, restitution );
}

// kg/m^2, default 1.0. Recomputes the body's mass from its shape.
void vb2_SetDensity( int body, float density )
{
    b2ShapeId sh;
    if( vb2_ResolveShape( body, &sh ) == false )
        return;

    b2Shape_SetDensity( &vb2_world, &sh, density, true );
}


// -----------------------------------------------------------------------------
//   Camera -- world (meters, y-up) <-> screen (640x360 pixels, y-down)
// -----------------------------------------------------------------------------
//   Do NOT draw with 1 pixel = 1 meter. Box2D's tolerances (a ~0.005 m contact
//   slop, a 0.05 m AABB margin) are tuned for human-sized objects, so a body a
//   few pixels wide is a body a few CENTIMETERS wide, and it will jitter. Pick a
//   scale where your objects are ~0.5-5 meters and let the camera do the rest.
//
//   vb2_Init defaults to the origin at screen center at 20 px/m -- a 32x32-pixel
//   sprite is then a 1.6 m object, which is a sane game scale.
// -----------------------------------------------------------------------------

float vb2_camX;
float vb2_camY;
float vb2_camPPM;

// centerX/centerY: the world point that lands at the middle of the screen.
// pixelsPerMeter: zoom.
void vb2_SetCamera( float centerX, float centerY, float pixelsPerMeter )
{
    vb2_camX = centerX;
    vb2_camY = centerY;
    vb2_camPPM = pixelsPerMeter;
}

int vb2_ScreenX( float worldX )
{
    return (int)( 320.0 + ( worldX - vb2_camX ) * vb2_camPPM );
}

int vb2_ScreenY( float worldY )
{
    return (int)( 180.0 - ( worldY - vb2_camY ) * vb2_camPPM );   // y flips
}

float vb2_WorldX( int screenX )
{
    return vb2_camX + ( screenX - 320.0 ) / vb2_camPPM;
}

float vb2_WorldY( int screenY )
{
    return vb2_camY - ( screenY - 180.0 ) / vb2_camPPM;
}


// -----------------------------------------------------------------------------
//   Queries -- "what is over there?"
// -----------------------------------------------------------------------------
//   A hit result is a pair (point, normal), which cannot cross the facade
//   boundary as a struct, so the last hit is kept in a static record and read
//   back with scalar accessors. There are no threads on this console, so the
//   only rule is: read the accessors before you cast again.
// -----------------------------------------------------------------------------

b2CastOutput vb2_lastHit;      // filled by vb2_RayCast
float vb2_pickX;               // scratch for the vb2_BodyAt callback
float vb2_pickY;
int   vb2_pickShape;

// Raw shape id -> facade body handle (-1 if there is no shape).
int vb2_BodyOfShape( int shapeId )
{
    if( shapeId == B2_NULL_INDEX )
        return -1;

    b2ShapeId sid;  b2MakeShapeId( &vb2_world, shapeId, &sid );
    b2BodyId  bid;  b2Shape_GetBody( &vb2_world, &sid, &bid );
    return vb2_PackHandle( bid.index1, bid.generation );
}

// Cast a ray from (x0,y0) to (x1,y1). Returns the CLOSEST body hit, or -1 for a
// clean miss. On a hit, vb2_HitX/HitY/HitNX/HitNY/HitFraction describe it.
// Line of sight, ground checks, aiming, laser sights.
int vb2_RayCast( float x0, float y0, float x1, float y1 )
{
    b2Vec2 origin;       origin.x = x0;        origin.y = y0;
    b2Vec2 translation;  translation.x = x1 - x0;  translation.y = y1 - y0;

    int shapeId = b2World_CastRayClosest( &vb2_world, &origin, &translation, NULL, &vb2_lastHit );
    return vb2_BodyOfShape( shapeId );
}

float vb2_HitX()         { return vb2_lastHit.point.x; }
float vb2_HitY()         { return vb2_lastHit.point.y; }
float vb2_HitNX()        { return vb2_lastHit.normal.x; }   // surface normal at the hit
float vb2_HitNY()        { return vb2_lastHit.normal.y; }
float vb2_HitFraction()  { return vb2_lastHit.fraction; }   // 0 = at the origin, 1 = at the far end

// Broad-phase gives us every shape whose fat AABB covers the point; this asks
// each for a real inside/outside test and stops at the first that says yes.
bool vb2_PointPickCallback( int proxyId, int shapeId, void* context )
{
    if( vb2_pickShape != B2_NULL_INDEX )
        return false;                    // already found one -- stop walking

    b2ShapeId sid;  b2MakeShapeId( &vb2_world, shapeId, &sid );

    b2Vec2 p;  p.x = vb2_pickX;  p.y = vb2_pickY;
    if( b2Shape_TestPoint( &vb2_world, &sid, &p ) )
    {
        vb2_pickShape = shapeId;
        return false;
    }

    return true;
}

// The body under a world point, or -1. Mouse/cursor picking: pair it with
// vb2_WorldX/vb2_WorldY to turn a screen position into a body.
int vb2_BodyAt( float x, float y )
{
    vb2_pickX = x;
    vb2_pickY = y;
    vb2_pickShape = B2_NULL_INDEX;

    b2AABB box;                          // a degenerate AABB at the point
    box.lowerBound.x = x;  box.lowerBound.y = y;
    box.upperBound.x = x;  box.upperBound.y = y;

    b2TreeStats stats;
    b2World_OverlapAABB( &vb2_world, &box, NULL, &vb2_PointPickCallback, NULL, &stats );

    return vb2_BodyOfShape( vb2_pickShape );
}


// -----------------------------------------------------------------------------
//   Touch events -- "what just hit what?"
// -----------------------------------------------------------------------------
//   Poll these right AFTER vb2_Step; they are cleared by the next step. The pair
//   is body handles (the engine reports shapes; the facade resolves them for
//   you). Damage, pickups, sound triggers.
// -----------------------------------------------------------------------------

int vb2_TouchCount()
{
    return b2World_GetBeginTouchEventCount( &vb2_world );
}

int vb2_TouchA( int i )
{
    if( i < 0 || i >= b2World_GetBeginTouchEventCount( &vb2_world ) )
        return -1;

    b2TouchEvent* events = b2World_GetBeginTouchEvents( &vb2_world );
    return vb2_BodyOfShape( events[i].shapeIdA );
}

int vb2_TouchB( int i )
{
    if( i < 0 || i >= b2World_GetBeginTouchEventCount( &vb2_world ) )
        return -1;

    b2TouchEvent* events = b2World_GetBeginTouchEvents( &vb2_world );
    return vb2_BodyOfShape( events[i].shapeIdB );
}


// -----------------------------------------------------------------------------
//   Joints -- the two cases a game actually reaches for
// -----------------------------------------------------------------------------
//   A pin (hinge) and a rope (fixed distance). The other six joint types --
//   prismatic, weld, wheel, motor, filter, and the spring/limit variants of these
//   two -- are the def-based b2 API: b2DefaultWheelJointDef + b2CreateWheelJointDef.
//
//   Joint handles pack index + generation exactly like body handles, so a joint
//   handle that outlives its joint is detected rather than silently reused.
// -----------------------------------------------------------------------------

bool vb2_ResolveJoint( int handle, b2JointId* result )
{
    if( handle <= 0 )
        return false;

    int index1 = handle & 0xFFFF;
    int gen    = ( handle >> 16 ) & 0x7FFF;

    if( index1 <= 0 || index1 > vb2_world.joints.count )
        return false;

    b2Joint* joint = &vb2_world.joints.data[ index1 - 1 ];
    if( joint->jointId == B2_NULL_INDEX )
        return false;
    if( ( joint->generation & 0x7FFF ) != gen )
        return false;

    result->index1 = index1;
    result->world0 = vb2_world.worldId;
    result->generation = joint->generation;
    return true;
}

bool vb2_JointExists( int joint )
{
    b2JointId id;
    return vb2_ResolveJoint( joint, &id );
}

// Hinge two bodies together at a world point: doors, ragdoll limbs, wheels on a
// chassis, a swinging bridge. Both bodies keep rotating freely about it.
// Returns a joint handle, or -1 if either body handle was stale.
int vb2_Pin( int bodyA, int bodyB, float worldX, float worldY )
{
    b2BodyId idA;  b2BodyId idB;
    if( vb2_ResolveBody( bodyA, &idA ) == false )  return -1;
    if( vb2_ResolveBody( bodyB, &idB ) == false )  return -1;

    b2Vec2 anchor;  anchor.x = worldX;  anchor.y = worldY;

    // the same world point expressed in each body's own frame
    b2Vec2 localA;  b2Body_GetLocalPoint( &vb2_world, &idA, &anchor, &localA );
    b2Vec2 localB;  b2Body_GetLocalPoint( &vb2_world, &idB, &anchor, &localB );

    b2RevoluteJointDef def;  b2DefaultRevoluteJointDef( &def );
    def.bodyIdA = idA;
    def.bodyIdB = idB;
    def.localFrameA.p = localA;
    def.localFrameA.q = b2Rot_identity;
    def.localFrameB.p = localB;
    def.localFrameB.q = b2Rot_identity;

    b2JointId jid;  b2CreateRevoluteJointDef( &vb2_world, &def, &jid );
    return vb2_PackHandle( jid.index1, jid.generation );
}

// Hold two bodies a fixed distance apart -- their CURRENT distance, so place them
// first, then rope them. Chains, tethers, pendulums, a hanging sign.
int vb2_Rope( int bodyA, int bodyB )
{
    b2BodyId idA;  b2BodyId idB;
    if( vb2_ResolveBody( bodyA, &idA ) == false )  return -1;
    if( vb2_ResolveBody( bodyB, &idB ) == false )  return -1;

    b2Vec2 pA;  b2Body_GetPosition( &vb2_world, &idA, &pA );
    b2Vec2 pB;  b2Body_GetPosition( &vb2_world, &idB, &pB );

    b2Vec2 d;  b2Sub( &pB, &pA, &d );
    float length = b2Length( &d );

    b2DistanceJointDef def;  b2DefaultDistanceJointDef( &def );
    def.bodyIdA = idA;
    def.bodyIdB = idB;
    def.localFrameA.p = b2Vec2_zero;     // anchored at each body's origin
    def.localFrameA.q = b2Rot_identity;
    def.localFrameB.p = b2Vec2_zero;
    def.localFrameB.q = b2Rot_identity;
    def.length = length;
    def.minLength = length;
    def.maxLength = length;

    b2JointId jid;  b2CreateDistanceJointDef( &vb2_world, &def, &jid );
    return vb2_PackHandle( jid.index1, jid.generation );
}

// Drive a pin: spin bodyB about the hinge at `speed` rad/s, using at most
// `maxTorque` N*m to get there. Wheels, propellers, powered joints. A speed of 0
// with a high maxTorque makes the hinge hold its angle (a servo).
// Silently ignores a rope (only a pin has a motor).
void vb2_Motor( int joint, float speed, float maxTorque )
{
    b2JointId id;
    if( vb2_ResolveJoint( joint, &id ) == false )
        return;
    if( b2Joint_GetType( &vb2_world, &id ) != b2_revoluteJoint )
        return;

    b2RevoluteJoint_EnableMotor( &vb2_world, &id, true );
    b2RevoluteJoint_SetMotorSpeed( &vb2_world, &id, speed );
    b2RevoluteJoint_SetMaxMotorTorque( &vb2_world, &id, maxTorque );
}

void vb2_DestroyJoint( int joint )
{
    b2JointId id;
    if( vb2_ResolveJoint( joint, &id ) == false )
        return;

    b2DestroyJoint( &vb2_world, &id );
}

#endif
