// =============================================================================
//   VirconBox2D test harness
// =============================================================================
//   Runs a battery of known-value checks against the ported b2_math.
//   Screen turns GREEN if every check passes, RED if any fails.
//   Run bin/harness.v32 in the emulator and read the color.
//
//   If it goes RED, bisect: comment out the second half of the checks,
//   rebuild, and narrow down which group fails.
// =============================================================================

#include "video.h"
#include "math.h"
#include "string.h"
#include "port/b2_math.h"
#include "port/b2_constants.h"
#include "port/b2_aabb.h"
#include "port/b2_geometry.h"
#include "port/b2_hull.h"
#include "port/b2_distance.h"
#include "port/b2_manifold.h"
#include "port/b2_ctz.h"
#include "port/b2_core.h"
#include "port/b2_dynamic_tree.h"
#include "port/b2_id_pool.h"
#include "port/b2_arena_allocator.h"
#include "port/b2_shape.h"
#include "port/b2_body.h"
#include "port/b2_bitset.h"
#include "port/b2_table.h"
#include "port/b2_solver.h"

// Probe struct mimicking b2TreeNode: scalar fields + an embedded multi-word
// b2AABB (4 words). Used to settle whether variable-index access into a
// heap-pointer array of large structs is safe (dynamic_tree depends on it).
struct PNode
{
    int id;
    int parent;
    int height;
    b2AABB box;   // 4 words -> PNode is 7 words
};

// global pass/fail accumulator
bool AllPassed = true;

// diagnostic: number every Check() call and remember the 1-based index of the
// FIRST one that failed, so a red screen can print exactly which check broke.
int checkNum  = 0;
int firstFail = 0;

// captured for the solver resting test so a RED can report the actual numbers
float diagRestY  = 0.0;
float diagRestVy = 0.0;
float diagCtrlY  = 0.0;
float diagFricVx = 0.0;
float diagFricCtrlVx = 0.0;
float diagBouncePeak = 0.0;
float diagBounceCtrl = 0.0;
float diagStackAY = 0.0;
float diagStackBY = 0.0;
float diagLevelS  = 0.0;

// float comparison with tolerance (hardware sin/cos isn't bit-exact)
bool feq( float a, float b )
{
    return fabs( a - b ) < 0.001;
}

void Check( bool condition )
{
    checkNum++;
    if( !condition )
    {
        AllPassed = false;
        if( firstFail == 0 )
            firstFail = checkNum;
    }
}

// print an integer using the BIOS font (no assets needed)
void ShowInt( int x, int y, int value )
{
    int[20] s;
    itoa( value, s, 10 );
    print_at( x, y, s );
}

// print a float using the BIOS font (handy for ad-hoc value inspection on red)
void ShowFloat( int x, int y, float value )
{
    int[30] s;
    ftoa( value, s );
    print_at( x, y, s );
}

// dynamic-tree query callback: tallies the count and userData sum of visited
// leaves (sum is order-independent, so it doesn't depend on tree shape).
int qHits;
int qSum;
bool QueryCB( int proxyId, int userData, void* context )
{
    qHits = qHits + 1;
    qSum = qSum + userData;
    return true;   // keep going
}

void main()
{
    // scratch vectors/rotations reused across checks
    b2Vec2 a, b, r;
    b2Rot  q, qr;

    // ----- scalar helpers -----
    Check( feq( b2MinFloat( 2.0, 5.0 ), 2.0 ) );
    Check( feq( b2MaxFloat( 2.0, 5.0 ), 5.0 ) );
    Check( feq( b2AbsFloat( -3.0 ), 3.0 ) );
    Check( feq( b2ClampFloat(  7.0, 0.0, 5.0 ), 5.0 ) );
    Check( feq( b2ClampFloat( -2.0, 0.0, 5.0 ), 0.0 ) );
    Check( feq( b2ClampFloat(  3.0, 0.0, 5.0 ), 3.0 ) );
    Check( b2MinInt( 2, 5 ) == 2 );
    Check( b2MaxInt( 2, 5 ) == 5 );
    Check( b2AbsInt( -4 ) == 4 );
    Check( b2ClampInt( 9, 0, 5 ) == 5 );

    // ----- vector properties -----
    a.x = 3.0; a.y = 4.0;
    b.x = 1.0; b.y = 2.0;
    Check( feq( b2Dot( &a, &b ), 11.0 ) );
    Check( feq( b2LengthSquared( &a ), 25.0 ) );
    Check( feq( b2Length( &a ), 5.0 ) );

    a.x = 1.0; a.y = 0.0;
    b.x = 0.0; b.y = 1.0;
    Check( feq( b2Cross( &a, &b ), 1.0 ) );

    a.x = 0.0; a.y = 0.0;
    b.x = 3.0; b.y = 4.0;
    Check( feq( b2DistanceSquared( &a, &b ), 25.0 ) );
    Check( feq( b2Distance( &a, &b ), 5.0 ) );

    // ----- vector arithmetic -----
    a.x = 1.0; a.y = 2.0;
    b.x = 3.0; b.y = 4.0;
    b2Add( &a, &b, &r );
    Check( feq( r.x, 4.0 ) && feq( r.y, 6.0 ) );

    a.x = 5.0; a.y = 7.0;
    b.x = 1.0; b.y = 2.0;
    b2Sub( &a, &b, &r );
    Check( feq( r.x, 4.0 ) && feq( r.y, 5.0 ) );

    a.x = 1.0; a.y = -2.0;
    b2Neg( &a, &r );
    Check( feq( r.x, -1.0 ) && feq( r.y, 2.0 ) );

    a.x = 3.0; a.y = 4.0;
    b2MulSV( 2.0, &a, &r );
    Check( feq( r.x, 6.0 ) && feq( r.y, 8.0 ) );

    a.x = 1.0; a.y = 2.0;
    b.x = 1.0; b.y = 1.0;
    b2MulAdd( &a, 3.0, &b, &r );
    Check( feq( r.x, 4.0 ) && feq( r.y, 5.0 ) );

    a.x = 5.0; a.y = 5.0;
    b.x = 1.0; b.y = 1.0;
    b2MulSub( &a, 2.0, &b, &r );
    Check( feq( r.x, 3.0 ) && feq( r.y, 3.0 ) );

    a.x = 2.0; a.y = 3.0;
    b.x = 4.0; b.y = 5.0;
    b2Mul( &a, &b, &r );
    Check( feq( r.x, 8.0 ) && feq( r.y, 15.0 ) );

    a.x = 1.0; a.y = 0.0;
    b2LeftPerp( &a, &r );
    Check( feq( r.x, 0.0 ) && feq( r.y, 1.0 ) );
    b2RightPerp( &a, &r );
    Check( feq( r.x, 0.0 ) && feq( r.y, -1.0 ) );

    a.x = 3.0; a.y = 4.0;
    b2Normalize( &a, &r );
    Check( feq( r.x, 0.6 ) && feq( r.y, 0.8 ) );

    // ----- rotations -----
    // q90 = 90 degrees, built directly: cos=0, sin=1
    q.c = 0.0; q.s = 1.0;

    a.x = 1.0; a.y = 0.0;
    b2RotateVector( &q, &a, &r );
    Check( feq( r.x, 0.0 ) && feq( r.y, 1.0 ) );

    a.x = 0.0; a.y = 1.0;
    b2InvRotateVector( &q, &a, &r );
    Check( feq( r.x, 1.0 ) && feq( r.y, 0.0 ) );

    b2MulRot( &q, &q, &qr );            // 90 * 90 = 180 -> {c:-1, s:0}
    Check( feq( qr.c, -1.0 ) && feq( qr.s, 0.0 ) );

    b2InvMulRot( &q, &q, &qr );         // inv(90)*90 = 0 -> {c:1, s:0}
    Check( feq( qr.c, 1.0 ) && feq( qr.s, 0.0 ) );

    b2InvertRot( &q, &qr );             // {c:0, s:-1}
    Check( feq( qr.c, 0.0 ) && feq( qr.s, -1.0 ) );

    qr.c = 3.0; qr.s = 4.0;             // non-unit -> normalize to {0.6,0.8}
    b2NormalizeRot( &qr, &q );
    Check( feq( q.c, 0.6 ) && feq( q.s, 0.8 ) );

    b2MakeRot( 0.0, &q );               // {c:1, s:0}
    Check( feq( q.c, 1.0 ) && feq( q.s, 0.0 ) );

    b2MakeRot( B2_PI / 2.0, &q );       // ~{c:0, s:1}
    Check( feq( q.c, 0.0 ) && feq( q.s, 1.0 ) );

    // ----- transforms -----
    b2Transform t;
    t.p.x = 10.0; t.p.y = 20.0;
    t.q.c = 0.0;  t.q.s = 1.0;          // 90 degrees
    a.x = 1.0; a.y = 0.0;
    b2TransformPoint( &t, &a, &r );     // rotate {1,0} by 90 = {0,1}, + {10,20}
    Check( feq( r.x, 10.0 ) && feq( r.y, 21.0 ) );

    a.x = 10.0; a.y = 21.0;
    b2InvTransformPoint( &t, &a, &r );  // inverse -> {1,0}
    Check( feq( r.x, 1.0 ) && feq( r.y, 0.0 ) );

    // compose transforms: A{p(10,20),90deg} * B{p(1,0),0deg}
    b2Transform tA, tB, tC;
    tA.p.x = 10.0; tA.p.y = 20.0; tA.q.c = 0.0; tA.q.s = 1.0;
    tB.p.x = 1.0;  tB.p.y = 0.0;  tB.q.c = 1.0; tB.q.s = 0.0;
    b2MulTransforms( &tA, &tB, &tC );   // p -> {10,21}, q -> {0,1}
    Check( feq( tC.p.x, 10.0 ) && feq( tC.p.y, 21.0 ) );
    Check( feq( tC.q.c, 0.0 ) && feq( tC.q.s, 1.0 ) );

    tB.p.x = 10.0; tB.p.y = 21.0; tB.q.c = 0.0; tB.q.s = 1.0;
    b2InvMulTransforms( &tA, &tB, &tC ); // p -> {1,0}, q -> {1,0}
    Check( feq( tC.p.x, 1.0 ) && feq( tC.p.y, 0.0 ) );
    Check( feq( tC.q.c, 1.0 ) && feq( tC.q.s, 0.0 ) );

    // ----- component-wise vector ops -----
    a.x = 0.0; a.y = 0.0;
    b.x = 10.0; b.y = 20.0;
    b2Lerp( &a, &b, 0.5, &r );
    Check( feq( r.x, 5.0 ) && feq( r.y, 10.0 ) );

    a.x = -3.0; a.y = 4.0;
    b2Abs( &a, &r );
    Check( feq( r.x, 3.0 ) && feq( r.y, 4.0 ) );

    a.x = 1.0; a.y = 5.0;
    b.x = 3.0; b.y = 2.0;
    b2Min( &a, &b, &r );
    Check( feq( r.x, 1.0 ) && feq( r.y, 2.0 ) );
    b2Max( &a, &b, &r );
    Check( feq( r.x, 3.0 ) && feq( r.y, 5.0 ) );

    {
        b2Vec2 lo, hi, v;
        v.x = 7.0;  v.y = -1.0;
        lo.x = 0.0; lo.y = 0.0;
        hi.x = 5.0; hi.y = 5.0;
        b2Clamp( &v, &lo, &hi, &r );
        Check( feq( r.x, 5.0 ) && feq( r.y, 0.0 ) );
    }

    a.x = 3.0; a.y = 4.0;
    float len;
    b2GetLengthAndNormalize( &len, &a, &r );
    Check( feq( len, 5.0 ) && feq( r.x, 0.6 ) && feq( r.y, 0.8 ) );

    // ----- angles -----
    Check( feq( b2Atan2( 1.0, 0.0 ), B2_PI / 2.0 ) );
    Check( feq( b2Atan2( 0.0, 1.0 ), 0.0 ) );

    q.c = 0.0; q.s = 1.0;
    Check( feq( b2Rot_GetAngle( &q ), B2_PI / 2.0 ) );
    b2Rot_GetXAxis( &q, &r );
    Check( feq( r.x, 0.0 ) && feq( r.y, 1.0 ) );
    b2Rot_GetYAxis( &q, &r );
    Check( feq( r.x, -1.0 ) && feq( r.y, 0.0 ) );

    {
        b2Rot ra, rb;
        ra.c = 1.0; ra.s = 0.0;
        rb.c = 0.0; rb.s = 1.0;
        Check( feq( b2RelativeAngle( &ra, &rb ), B2_PI / 2.0 ) );
    }

    Check( feq( b2UnwindAngle( 2.5 * B2_PI ), B2_PI / 2.0 ) );

    q.c = 1.0; q.s = 0.0;
    b2IntegrateRotation( &q, 0.0, &qr );      // stays at identity, normalized
    Check( feq( qr.c, 1.0 ) && feq( qr.s, 0.0 ) );

    {
        b2Rot q0, q1;
        q0.c = 1.0; q0.s = 0.0;
        q1.c = 0.0; q1.s = 1.0;
        b2NLerp( &q0, &q1, 0.5, &qr );        // -> {0.7071, 0.7071}
        Check( feq( qr.c, 0.70710678 ) && feq( qr.s, 0.70710678 ) );
    }

    q.c = 0.0; q.s = 1.0;
    Check( b2IsNormalizedRot( &q ) == true );
    q.c = 3.0; q.s = 4.0;
    Check( b2IsNormalizedRot( &q ) == false );

    a.x = 0.0; a.y = 1.0;
    b2MakeRotFromUnitVector( &a, &qr );
    Check( feq( qr.c, 0.0 ) && feq( qr.s, 1.0 ) );

    // ----- 2x2 matrix -----
    {
        b2Mat22 m;
        m.cx.x = 2.0; m.cx.y = 0.0;
        m.cy.x = 0.0; m.cy.y = 3.0;
        a.x = 1.0; a.y = 1.0;
        b2MulMV( &m, &a, &r );                // {2,3}
        Check( feq( r.x, 2.0 ) && feq( r.y, 3.0 ) );

        b2Mat22 mi;
        m.cx.x = 2.0; m.cx.y = 0.0;
        m.cy.x = 0.0; m.cy.y = 4.0;
        b2GetInverse22( &m, &mi );            // diag {0.5, 0.25}
        Check( feq( mi.cx.x, 0.5 ) && feq( mi.cy.y, 0.25 ) );
        Check( feq( mi.cx.y, 0.0 ) && feq( mi.cy.x, 0.0 ) );

        m.cx.x = 1.0; m.cx.y = 0.0;
        m.cy.x = 0.0; m.cy.y = 1.0;
        b.x = 3.0; b.y = 4.0;
        b2Solve22( &m, &b, &r );              // {3,4}
        Check( feq( r.x, 3.0 ) && feq( r.y, 4.0 ) );
    }

    // ----- AABB -----
    {
        b2AABB box1, box2, box3, box4, boxr;
        box1.lowerBound.x = 0.0;  box1.lowerBound.y = 0.0;
        box1.upperBound.x = 10.0; box1.upperBound.y = 10.0;
        box2.lowerBound.x = 2.0;  box2.lowerBound.y = 2.0;
        box2.upperBound.x = 5.0;  box2.upperBound.y = 5.0;
        Check( b2AABB_Contains( &box1, &box2 ) == true );
        Check( b2AABB_Contains( &box2, &box1 ) == false );

        b2AABB_Center( &box1, &r );
        Check( feq( r.x, 5.0 ) && feq( r.y, 5.0 ) );
        b2AABB_Extents( &box1, &r );
        Check( feq( r.x, 5.0 ) && feq( r.y, 5.0 ) );

        box3.lowerBound.x = 5.0;  box3.lowerBound.y = 5.0;
        box3.upperBound.x = 15.0; box3.upperBound.y = 15.0;
        b2AABB_Union( &box1, &box3, &boxr );  // {0,0}..{15,15}
        Check( feq( boxr.lowerBound.x, 0.0 ) && feq( boxr.lowerBound.y, 0.0 ) );
        Check( feq( boxr.upperBound.x, 15.0 ) && feq( boxr.upperBound.y, 15.0 ) );

        Check( b2AABB_Overlaps( &box1, &box2 ) == true );
        box4.lowerBound.x = 20.0; box4.lowerBound.y = 20.0;
        box4.upperBound.x = 30.0; box4.upperBound.y = 30.0;
        Check( b2AABB_Overlaps( &box1, &box4 ) == false );
    }

    // ----- plane -----
    {
        b2Plane plane;
        plane.normal.x = 1.0; plane.normal.y = 0.0;
        plane.offset = 5.0;
        b.x = 8.0; b.y = 3.0;
        Check( feq( b2PlaneSeparation( &plane, &b ), 3.0 ) );
    }

    // ----- spring-damper (hertz 0 -> returns velocity unchanged) -----
    Check( feq( b2SpringDamper( 0.0, 1.0, 5.0, 7.0, 0.016 ), 7.0 ) );

    // ----- AABB module (b2_aabb.h) -----
    {
        b2AABB bx, by, bres;
        b2CastOutput out;

        bx.lowerBound.x = 0.0;  bx.lowerBound.y = 0.0;
        bx.upperBound.x = 10.0; bx.upperBound.y = 10.0;
        Check( feq( b2Perimeter( &bx ), 40.0 ) );

        // enlarge {0,0..5,5} with {-1,-1..8,8} -> grows (true), then no change (false)
        bx.lowerBound.x = 0.0;  bx.lowerBound.y = 0.0;
        bx.upperBound.x = 5.0;  bx.upperBound.y = 5.0;
        by.lowerBound.x = -1.0; by.lowerBound.y = -1.0;
        by.upperBound.x = 8.0;  by.upperBound.y = 8.0;
        Check( b2EnlargeAABB( &bx, &by ) == true );
        Check( feq( bx.lowerBound.x, -1.0 ) && feq( bx.upperBound.y, 8.0 ) );
        Check( b2EnlargeAABB( &bx, &by ) == false );

        // offset {1,1..2,2} by origin {10,20} -> {11,21..12,22}
        bx.lowerBound.x = 1.0; bx.lowerBound.y = 1.0;
        bx.upperBound.x = 2.0; bx.upperBound.y = 2.0;
        b.x = 10.0; b.y = 20.0;
        b2OffsetAABB( &bx, &b, &bres );
        Check( feq( bres.lowerBound.x, 11.0 ) && feq( bres.lowerBound.y, 21.0 ) );
        Check( feq( bres.upperBound.x, 12.0 ) && feq( bres.upperBound.y, 22.0 ) );

        // validity
        bx.lowerBound.x = 0.0;  bx.lowerBound.y = 0.0;
        bx.upperBound.x = 10.0; bx.upperBound.y = 10.0;
        Check( b2IsValidAABB( &bx ) == true );
        by.lowerBound.x = 10.0; by.lowerBound.y = 10.0;
        by.upperBound.x = 0.0;  by.upperBound.y = 0.0;
        Check( b2IsValidAABB( &by ) == false );

        // ray cast HIT: horizontal ray through left face at x=0, y=5
        {
            b2Vec2 p1, p2;
            p1.x = -5.0; p1.y = 5.0;
            p2.x =  5.0; p2.y = 5.0;
            b2AABB_RayCast( &bx, &p1, &p2, &out );
            Check( out.hit == true );
            Check( feq( out.fraction, 0.5 ) );
            Check( feq( out.point.x, 0.0 ) && feq( out.point.y, 5.0 ) );
            Check( feq( out.normal.x, -1.0 ) && feq( out.normal.y, 0.0 ) );
        }

        // ray cast MISS: ray passes above the box
        {
            b2Vec2 p1, p2;
            p1.x = -5.0; p1.y = 20.0;
            p2.x =  5.0; p2.y = 20.0;
            b2AABB_RayCast( &bx, &p1, &p2, &out );
            Check( out.hit == false );
        }

        // ray cast HIT (VERTICAL ray): exercises the x-parallel branch where
        // absD.x == 0 -- the exact path whose epsilon guard must not divide by 0
        {
            b2Vec2 p1, p2;
            p1.x = 5.0; p1.y = -5.0;
            p2.x = 5.0; p2.y = 15.0;
            b2AABB_RayCast( &bx, &p1, &p2, &out );
            Check( out.hit == true );
            Check( feq( out.fraction, 0.25 ) );
            Check( feq( out.point.x, 5.0 ) && feq( out.point.y, 0.0 ) );
            Check( feq( out.normal.x, 0.0 ) && feq( out.normal.y, -1.0 ) );
        }
    }

    // ----- FLT_EPSILON must be a small NONZERO value (regression: lexer
    //       underflows tiny literals to 0.0, which broke epsilon guards) -----
    Check( FLT_EPSILON > 0.0 );
    Check( FLT_EPSILON < 0.001 );

    // zero-vector normalize must hit the guard and return {0,0}, not divide by 0
    {
        b2Vec2 zero, nresult;
        zero.x = 0.0; zero.y = 0.0;
        b2Normalize( &zero, &nresult );
        Check( feq( nresult.x, 0.0 ) && feq( nresult.y, 0.0 ) );
    }

    // ----- constants sanity -----
    Check( B2_MAX_WORKERS == 32 );
    Check( feq( b2GetLengthUnitsPerMeter(), 1.0 ) );
    Check( feq( B2_LINEAR_SLOP, 0.005 ) );

    // ----- geometry module (b2_geometry.h) -----
    {
        b2Polygon poly;
        b2MassData md;
        b2AABB aabb;

        // box maker
        b2MakeBox( 2.0, 1.0, &poly );
        Check( poly.count == 4 );
        Check( feq( poly.vertices[0].x, -2.0 ) && feq( poly.vertices[0].y, -1.0 ) );
        Check( feq( poly.vertices[2].x,  2.0 ) && feq( poly.vertices[2].y,  1.0 ) );
        Check( feq( poly.normals[1].x, 1.0 ) && feq( poly.normals[1].y, 0.0 ) );
        Check( feq( poly.radius, 0.0 ) );
        Check( feq( poly.centroid.x, 0.0 ) && feq( poly.centroid.y, 0.0 ) );

        // circle mass: density 3, radius 2 -> mass = 12*pi, I = 24*pi, center {0,0}
        {
            b2Circle circ;
            circ.center.x = 0.0; circ.center.y = 0.0; circ.radius = 2.0;
            b2ComputeCircleMass( &circ, 3.0, &md );
            Check( feq( md.mass, 12.0 * B2_PI ) );
            Check( feq( md.rotationalInertia, 24.0 * B2_PI ) );
            Check( feq( md.center.x, 0.0 ) && feq( md.center.y, 0.0 ) );

            // circle AABB at identity -> {-2,-2..2,2}
            b2ComputeCircleAABB( &circ, &b2Transform_identity, &aabb );
            Check( feq( aabb.lowerBound.x, -2.0 ) && feq( aabb.lowerBound.y, -2.0 ) );
            Check( feq( aabb.upperBound.x,  2.0 ) && feq( aabb.upperBound.y,  2.0 ) );

            // circle AABB translated by (10,20) -> {8,18..12,22}
            b2Transform xft;
            xft.p.x = 10.0; xft.p.y = 20.0; xft.q.c = 1.0; xft.q.s = 0.0;
            b2ComputeCircleAABB( &circ, &xft, &aabb );
            Check( feq( aabb.lowerBound.x, 8.0 ) && feq( aabb.lowerBound.y, 18.0 ) );
            Check( feq( aabb.upperBound.x, 12.0 ) && feq( aabb.upperBound.y, 22.0 ) );

            // point in circle
            b2Vec2 pt;
            pt.x = 1.0; pt.y = 1.0;
            Check( b2PointInCircle( &circ, &pt ) == true );
            pt.x = 3.0; pt.y = 0.0;
            Check( b2PointInCircle( &circ, &pt ) == false );
        }

        // capsule mass: center1{-1,0} center2{1,0} r=1 density 1
        //   length 2 -> circleMass=pi, boxMass=4, mass=pi+4, center {0,0}
        {
            b2Capsule cap;
            cap.center1.x = -1.0; cap.center1.y = 0.0;
            cap.center2.x =  1.0; cap.center2.y = 0.0;
            cap.radius = 1.0;
            b2ComputeCapsuleMass( &cap, 1.0, &md );
            Check( feq( md.mass, B2_PI + 4.0 ) );
            Check( feq( md.center.x, 0.0 ) && feq( md.center.y, 0.0 ) );

            // capsule AABB at identity -> {-2,-1..2,1}
            b2ComputeCapsuleAABB( &cap, &b2Transform_identity, &aabb );
            Check( feq( aabb.lowerBound.x, -2.0 ) && feq( aabb.lowerBound.y, -1.0 ) );
            Check( feq( aabb.upperBound.x,  2.0 ) && feq( aabb.upperBound.y,  1.0 ) );

            // point in capsule
            b2Vec2 pt;
            pt.x = 0.0; pt.y = 0.5;
            Check( b2PointInCapsule( &cap, &pt ) == true );
            pt.x = 3.0; pt.y = 0.0;
            Check( b2PointInCapsule( &cap, &pt ) == false );
        }

        // polygon mass of box(2,1) density 1: mass=8, center{0,0}, I=40/3
        b2ComputePolygonMass( &poly, 1.0, &md );
        Check( feq( md.mass, 8.0 ) );
        Check( feq( md.center.x, 0.0 ) && feq( md.center.y, 0.0 ) );
        Check( feq( md.rotationalInertia, 40.0 / 3.0 ) );

        // polygon AABB of box(2,1) at identity -> {-2,-1..2,1}
        b2ComputePolygonAABB( &poly, &b2Transform_identity, &aabb );
        Check( feq( aabb.lowerBound.x, -2.0 ) && feq( aabb.lowerBound.y, -1.0 ) );
        Check( feq( aabb.upperBound.x,  2.0 ) && feq( aabb.upperBound.y,  1.0 ) );

        // segment AABB: {0,0}->{3,4} at identity -> {0,0..3,4}
        {
            b2Segment seg;
            seg.point1.x = 0.0; seg.point1.y = 0.0;
            seg.point2.x = 3.0; seg.point2.y = 4.0;
            b2ComputeSegmentAABB( &seg, &b2Transform_identity, &aabb );
            Check( feq( aabb.lowerBound.x, 0.0 ) && feq( aabb.lowerBound.y, 0.0 ) );
            Check( feq( aabb.upperBound.x, 3.0 ) && feq( aabb.upperBound.y, 4.0 ) );
        }
    }

    // ----- hull module (b2_hull.h) -----
    {
        b2Vec2[8] pts;
        b2Hull hull;

        // square corners -> 4-point valid hull
        pts[0].x = -1.0; pts[0].y = -1.0;
        pts[1].x =  1.0; pts[1].y = -1.0;
        pts[2].x =  1.0; pts[2].y =  1.0;
        pts[3].x = -1.0; pts[3].y =  1.0;
        b2ComputeHull( pts, 4, &hull );
        Check( hull.count == 4 );
        Check( b2ValidateHull( &hull ) == true );

        // square + interior point -> interior dropped, still 4
        pts[4].x = 0.0; pts[4].y = 0.0;
        b2ComputeHull( pts, 5, &hull );
        Check( hull.count == 4 );

        // square + collinear bottom-edge midpoint -> merged away, still 4
        pts[0].x = -1.0; pts[0].y = -1.0;
        pts[1].x =  1.0; pts[1].y = -1.0;
        pts[2].x =  1.0; pts[2].y =  1.0;
        pts[3].x = -1.0; pts[3].y =  1.0;
        pts[4].x =  0.0; pts[4].y = -1.0;
        b2ComputeHull( pts, 5, &hull );
        Check( hull.count == 4 );

        // 3 collinear points -> failed (empty) hull
        {
            b2Vec2[8] line3;
            line3[0].x = 0.0; line3[0].y = 0.0;
            line3[1].x = 1.0; line3[1].y = 0.0;
            line3[2].x = 2.0; line3[2].y = 0.0;
            b2Hull bad;
            b2ComputeHull( line3, 3, &bad );
            Check( bad.count == 0 );
        }

        // b2MakePolygon from the square hull
        pts[0].x = -1.0; pts[0].y = -1.0;
        pts[1].x =  1.0; pts[1].y = -1.0;
        pts[2].x =  1.0; pts[2].y =  1.0;
        pts[3].x = -1.0; pts[3].y =  1.0;
        b2ComputeHull( pts, 4, &hull );
        {
            b2Polygon poly;
            b2MakePolygon( &hull, 0.1, &poly );
            Check( poly.count == 4 );
            Check( feq( poly.radius, 0.1 ) );
            Check( feq( poly.centroid.x, 0.0 ) && feq( poly.centroid.y, 0.0 ) );
        }
    }

    // ----- distance module slice 1 (b2_distance.h) -----
    {
        b2SegmentDistanceResult sdr;
        b2Vec2 sp1, sq1, sp2, sq2;

        // two parallel horizontal segments, distance 1 apart
        sp1.x = 0.0; sp1.y = 0.0;  sq1.x = 2.0; sq1.y = 0.0;
        sp2.x = 0.0; sp2.y = 1.0;  sq2.x = 2.0; sq2.y = 1.0;
        b2SegmentDistance( &sp1, &sq1, &sp2, &sq2, &sdr );
        Check( feq( sdr.distanceSquared, 1.0 ) );
        Check( feq( sdr.closest1.x, 0.0 ) && feq( sdr.closest1.y, 0.0 ) );
        Check( feq( sdr.closest2.x, 0.0 ) && feq( sdr.closest2.y, 1.0 ) );

        // perpendicular segments crossing at the origin -> distance 0
        sp1.x = -1.0; sp1.y = 0.0;  sq1.x = 1.0; sq1.y = 0.0;
        sp2.x = 0.0; sp2.y = -1.0;  sq2.x = 0.0; sq2.y = 1.0;
        b2SegmentDistance( &sp1, &sq1, &sp2, &sq2, &sdr );
        Check( feq( sdr.distanceSquared, 0.0 ) );
        Check( feq( sdr.fraction1, 0.5 ) && feq( sdr.fraction2, 0.5 ) );
        Check( feq( sdr.closest1.x, 0.0 ) && feq( sdr.closest1.y, 0.0 ) );

        // degenerate segment (a point) at {0,3} vs horizontal segment on x-axis
        sp1.x = 0.0; sp1.y = 3.0;  sq1.x = 0.0; sq1.y = 3.0;
        sp2.x = -1.0; sp2.y = 0.0; sq2.x = 1.0; sq2.y = 0.0;
        b2SegmentDistance( &sp1, &sq1, &sp2, &sq2, &sdr );
        Check( feq( sdr.distanceSquared, 9.0 ) );
        Check( feq( sdr.fraction2, 0.5 ) );
        Check( feq( sdr.closest2.x, 0.0 ) && feq( sdr.closest2.y, 0.0 ) );

        // proxy construction
        b2Vec2[3] ppts;
        ppts[0].x = 1.0; ppts[0].y = 2.0;
        ppts[1].x = 3.0; ppts[1].y = 4.0;
        ppts[2].x = 5.0; ppts[2].y = 6.0;
        b2ShapeProxy proxy;
        b2MakeProxy( ppts, 3, 0.5, &proxy );
        Check( proxy.count == 3 );
        Check( feq( proxy.radius, 0.5 ) );
        Check( feq( proxy.points[1].x, 3.0 ) && feq( proxy.points[1].y, 4.0 ) );

        // offset proxy: translate by (10,20), identity rotation
        b2Vec2 ppos;  ppos.x = 10.0; ppos.y = 20.0;
        b2Rot prot;   prot.c = 1.0;  prot.s = 0.0;
        b2MakeOffsetProxy( ppts, 3, 0.0, &ppos, &prot, &proxy );
        Check( feq( proxy.points[0].x, 11.0 ) && feq( proxy.points[0].y, 22.0 ) );
        Check( feq( proxy.points[2].x, 15.0 ) && feq( proxy.points[2].y, 26.0 ) );
    }

    // ----- distance slice 2: GJK (b2ShapeDistance) -----
    {
        b2Vec2[4] boxA;
        boxA[0].x = -1.0; boxA[0].y = -1.0;
        boxA[1].x =  1.0; boxA[1].y = -1.0;
        boxA[2].x =  1.0; boxA[2].y =  1.0;
        boxA[3].x = -1.0; boxA[3].y =  1.0;

        b2DistanceInput din;
        b2SimplexCache cache;
        b2DistanceOutput dout;

        // two unit boxes separated by 3 along x (A right edge x=1, B left edge x=4)
        b2MakeProxy( boxA, 4, 0.0, &din.proxyA );
        b2MakeProxy( boxA, 4, 0.0, &din.proxyB );
        din.transform.p.x = 5.0; din.transform.p.y = 0.0;
        din.transform.q.c = 1.0; din.transform.q.s = 0.0;
        din.useRadii = false;
        cache.count = 0;
        b2ShapeDistance( &din, &cache, &dout );
        Check( feq( dout.distance, 3.0 ) );

        // overlapping boxes (B shifted by 1) -> distance 0
        din.transform.p.x = 1.0; din.transform.p.y = 0.0;
        cache.count = 0;
        b2ShapeDistance( &din, &cache, &dout );
        Check( feq( dout.distance, 0.0 ) );

        // two circles (single-point proxies) radius 1, centers 5 apart, with radii
        // -> surface distance = 5 - 1 - 1 = 3
        b2Vec2[1] cA;  cA[0].x = 0.0; cA[0].y = 0.0;
        b2Vec2[1] cB;  cB[0].x = 5.0; cB[0].y = 0.0;
        b2MakeProxy( cA, 1, 1.0, &din.proxyA );
        b2MakeProxy( cB, 1, 1.0, &din.proxyB );
        din.transform = b2Transform_identity;
        din.useRadii = true;
        cache.count = 0;
        b2ShapeDistance( &din, &cache, &dout );
        Check( feq( dout.distance, 3.0 ) );

        // point-in-polygon via GJK
        b2Polygon pg;
        b2MakeBox( 2.0, 1.0, &pg );
        b2Vec2 q;
        q.x = 0.0; q.y = 0.0;
        Check( b2PointInPolygon( &pg, &q ) == true );
        q.x = 5.0; q.y = 5.0;
        Check( b2PointInPolygon( &pg, &q ) == false );
    }

    // ----- manifold: circle vs circle -----
    {
        b2Circle  ca, cb;
        b2LocalManifold man;
        b2Transform xf = b2Transform_identity;

        // overlapping: A(0,0) r2, B(3,0) r2 -> normal (1,0), point (1.5,0), sep -1
        ca.center.x = 0.0; ca.center.y = 0.0; ca.radius = 2.0;
        cb.center.x = 3.0; cb.center.y = 0.0; cb.radius = 2.0;
        b2CollideCircles( &ca, &cb, &xf, &man );
        Check( man.pointCount == 1 );
        Check( feq( man.normal.x, 1.0 ) && feq( man.normal.y, 0.0 ) );
        Check( feq( man.points[0].point.x, 1.5 ) && feq( man.points[0].point.y, 0.0 ) );
        Check( feq( man.points[0].separation, -1.0 ) );

        // beyond speculative: A(0,0) r1, B(5,0) r1 -> no contact
        ca.radius = 1.0;  cb.center.x = 5.0;  cb.radius = 1.0;
        b2CollideCircles( &ca, &cb, &xf, &man );
        Check( man.pointCount == 0 );
    }

    // ----- manifold: capsule vs circle -----
    {
        b2Capsule cap;
        b2Circle  cir;
        b2LocalManifold man;
        b2Transform xf = b2Transform_identity;

        cap.center1.x = -2.0; cap.center1.y = 0.0;
        cap.center2.x =  2.0; cap.center2.y = 0.0;
        cap.radius = 1.0;

        // interior region: circle (0,1.5) r1 -> normal (0,1), point (0,0.75), sep -0.5
        cir.center.x = 0.0; cir.center.y = 1.5; cir.radius = 1.0;
        b2CollideCapsuleAndCircle( &cap, &cir, &xf, &man );
        Check( man.pointCount == 1 );
        Check( feq( man.normal.x, 0.0 ) && feq( man.normal.y, 1.0 ) );
        Check( feq( man.points[0].point.x, 0.0 ) && feq( man.points[0].point.y, 0.75 ) );
        Check( feq( man.points[0].separation, -0.5 ) );

        // p1 endcap region: circle (-4,0) r1 -> normal (-1,0), point (-3,0), sep 0
        cir.center.x = -4.0; cir.center.y = 0.0;
        b2CollideCapsuleAndCircle( &cap, &cir, &xf, &man );
        Check( man.pointCount == 1 );
        Check( feq( man.normal.x, -1.0 ) && feq( man.normal.y, 0.0 ) );
        Check( feq( man.points[0].point.x, -3.0 ) && feq( man.points[0].point.y, 0.0 ) );
        Check( feq( man.points[0].separation, 0.0 ) );
    }

    // ----- manifold: polygon vs circle (all three regions) -----
    {
        b2Polygon box;
        b2Circle  cir;
        b2LocalManifold man;
        b2Transform xf = b2Transform_identity;
        b2MakeBox( 2.0, 1.0, &box );   // half 2 x 1, vertices CCW from (-2,-1)
        cir.radius = 1.0;

        // edge-interior region: circle (0,1.5) over top face
        // -> normal (0,1), point (0,0.75), sep -0.5
        cir.center.x = 0.0; cir.center.y = 1.5;
        b2CollidePolygonAndCircle( &box, &cir, &xf, &man );
        Check( man.pointCount == 1 );
        Check( feq( man.normal.x, 0.0 ) && feq( man.normal.y, 1.0 ) );
        Check( feq( man.points[0].point.x, 0.0 ) && feq( man.points[0].point.y, 0.75 ) );
        Check( feq( man.points[0].separation, -0.5 ) );

        // v1 vertex region: circle beyond corner (-2,-1) at (-2.5,-1.5)
        // -> normal (-0.7071,-0.7071), point (-1.8964,-0.8964), sep -0.2929
        cir.center.x = -2.5; cir.center.y = -1.5;
        b2CollidePolygonAndCircle( &box, &cir, &xf, &man );
        Check( man.pointCount == 1 );
        Check( feq( man.normal.x, -0.70711 ) && feq( man.normal.y, -0.70711 ) );
        Check( feq( man.points[0].point.x, -1.89645 ) && feq( man.points[0].point.y, -0.89645 ) );
        Check( feq( man.points[0].separation, -0.29289 ) );

        // v2 vertex region: circle beyond corner (2,1) at (2.5,1.5)
        // -> normal (0.7071,0.7071), point (1.8964,0.8964), sep -0.2929
        cir.center.x = 2.5; cir.center.y = 1.5;
        b2CollidePolygonAndCircle( &box, &cir, &xf, &man );
        Check( man.pointCount == 1 );
        Check( feq( man.normal.x, 0.70711 ) && feq( man.normal.y, 0.70711 ) );
        Check( feq( man.points[0].point.x, 1.89645 ) && feq( man.points[0].point.y, 0.89645 ) );
        Check( feq( man.points[0].separation, -0.29289 ) );

        // beyond speculative: circle far above the box -> no contact
        cir.center.x = 0.0; cir.center.y = 5.0;
        b2CollidePolygonAndCircle( &box, &cir, &xf, &man );
        Check( man.pointCount == 0 );
    }

    // ----- manifold: capsule vs capsule -----
    {
        b2Capsule capA, capB;
        b2LocalManifold man;
        b2Transform xf = b2Transform_identity;

        capA.center1.x = -2.0; capA.center1.y = 0.0;
        capA.center2.x =  2.0; capA.center2.y = 0.0;
        capA.radius = 1.0;

        // parallel, overlapping: B core at y=1.0 r0.5 -> 2-point manifold,
        // normal (0,1), points (-2,0.75)/(2,0.75), sep -0.5 each
        capB.center1.x = -2.0; capB.center1.y = 1.0;
        capB.center2.x =  2.0; capB.center2.y = 1.0;
        capB.radius = 0.5;
        b2CollideCapsules( &capA, &capB, &xf, &man );
        Check( man.pointCount == 2 );
        Check( feq( man.normal.x, 0.0 ) && feq( man.normal.y, 1.0 ) );
        Check( feq( man.points[0].point.x, -2.0 ) && feq( man.points[0].point.y, 0.75 ) );
        Check( feq( man.points[1].point.x,  2.0 ) && feq( man.points[1].point.y, 0.75 ) );
        Check( feq( man.points[0].separation, -0.5 ) && feq( man.points[1].separation, -0.5 ) );

        // collinear, end overlap: B core (3.5,0)-(7,0) r1 -> single point
        // normal (1,0), point (2.75,0), sep -0.5
        capB.center1.x = 3.5; capB.center1.y = 0.0;
        capB.center2.x = 7.0; capB.center2.y = 0.0;
        capB.radius = 1.0;
        b2CollideCapsules( &capA, &capB, &xf, &man );
        Check( man.pointCount == 1 );
        Check( feq( man.normal.x, 1.0 ) && feq( man.normal.y, 0.0 ) );
        Check( feq( man.points[0].point.x, 2.75 ) && feq( man.points[0].point.y, 0.0 ) );
        Check( feq( man.points[0].separation, -0.5 ) );

        // collinear, far apart: B core (5,0)-(9,0) r1 -> no contact
        capB.center1.x = 5.0;  capB.center2.x = 9.0;
        b2CollideCapsules( &capA, &capB, &xf, &man );
        Check( man.pointCount == 0 );
    }

    // ----- manifold: segment wrappers -----
    {
        b2Segment seg;
        b2Circle  cir;
        b2Capsule cap;
        b2LocalManifold man;
        b2Transform xf = b2Transform_identity;

        seg.point1.x = -2.0; seg.point1.y = 0.0;
        seg.point2.x =  2.0; seg.point2.y = 0.0;

        // segment (r0) vs circle (0,0.5) r1: cA=(0,0), cB=(0,-0.5)
        // -> normal (0,1), point (0,-0.25), sep -0.5
        cir.center.x = 0.0; cir.center.y = 0.5; cir.radius = 1.0;
        b2CollideSegmentAndCircle( &seg, &cir, &xf, &man );
        Check( man.pointCount == 1 );
        Check( feq( man.normal.x, 0.0 ) && feq( man.normal.y, 1.0 ) );
        Check( feq( man.points[0].point.x, 0.0 ) && feq( man.points[0].point.y, -0.25 ) );
        Check( feq( man.points[0].separation, -0.5 ) );

        // segment (r0) vs parallel capsule core y=0.4 r0.5 -> 2 points
        // normal (0,1), points (-2,-0.05)/(2,-0.05), sep -0.1 each
        cap.center1.x = -2.0; cap.center1.y = 0.4;
        cap.center2.x =  2.0; cap.center2.y = 0.4;
        cap.radius = 0.5;
        b2CollideSegmentAndCapsule( &seg, &cap, &xf, &man );
        Check( man.pointCount == 2 );
        Check( feq( man.normal.x, 0.0 ) && feq( man.normal.y, 1.0 ) );
        Check( feq( man.points[0].point.x, -2.0 ) && feq( man.points[0].point.y, -0.05 ) );
        Check( feq( man.points[1].point.x,  2.0 ) && feq( man.points[1].point.y, -0.05 ) );
        Check( feq( man.points[0].separation, -0.1 ) && feq( man.points[1].separation, -0.1 ) );
    }

    // ----- manifold: polygon collisions -----
    {
        b2Polygon boxA, boxB;
        b2Capsule cap;
        b2Segment seg;
        b2LocalManifold man;
        b2Transform xf = b2Transform_identity;

        // box/box overlap: A=box(2,1) at origin, B=box(1,1) shifted up (0,1.5).
        // A top y=1, B bottom y=0.5 -> overlap 0.5; normal (0,1); contacts at
        // x=+-1 (B width), y midpoint 0.75; sep -0.5 each.
        b2MakeBox( 2.0, 1.0, &boxA );
        b2MakeBox( 1.0, 1.0, &boxB );
        xf = b2Transform_identity;  xf.p.x = 0.0;  xf.p.y = 1.5;
        b2CollidePolygons( &boxA, &boxB, &xf, &man );
        Check( man.pointCount == 2 );
        Check( feq( man.normal.x, 0.0 ) && feq( man.normal.y, 1.0 ) );
        Check( feq( man.points[0].point.x,  1.0 ) && feq( man.points[0].point.y, 0.75 ) );
        Check( feq( man.points[1].point.x, -1.0 ) && feq( man.points[1].point.y, 0.75 ) );
        Check( feq( man.points[0].separation, -0.5 ) && feq( man.points[1].separation, -0.5 ) );

        // box/box far apart -> no contact
        xf.p.x = 0.0;  xf.p.y = 5.0;
        b2CollidePolygons( &boxA, &boxB, &xf, &man );
        Check( man.pointCount == 0 );

        // polygon/capsule: box(2,1) at origin, capsule core (-1,0)-(1,0) r0.5
        // shifted up (0,1.2). A top y=1, capsule surface y=0.7 -> overlap 0.3;
        // normal (0,1); contacts x=+-1, y midpoint 0.85; sep -0.3 each.
        cap.center1.x = -1.0; cap.center1.y = 0.0;
        cap.center2.x =  1.0; cap.center2.y = 0.0;
        cap.radius = 0.5;
        xf.p.x = 0.0;  xf.p.y = 1.2;
        b2CollidePolygonAndCapsule( &boxA, &cap, &xf, &man );
        Check( man.pointCount == 2 );
        Check( feq( man.normal.x, 0.0 ) && feq( man.normal.y, 1.0 ) );
        Check( feq( man.points[0].point.x,  1.0 ) && feq( man.points[0].point.y, 0.85 ) );
        Check( feq( man.points[1].point.x, -1.0 ) && feq( man.points[1].point.y, 0.85 ) );
        Check( feq( man.points[0].separation, -0.3 ) && feq( man.points[1].separation, -0.3 ) );

        // segment/polygon: segment (-2,0)-(2,0), box(1,1) shifted down (0,-0.5).
        // box top y=0.5 pokes above segment y=0 -> normal points A->B = (0,-1);
        // contacts x=-1 then +1, y midpoint 0.25; sep -0.5 each.
        seg.point1.x = -2.0; seg.point1.y = 0.0;
        seg.point2.x =  2.0; seg.point2.y = 0.0;
        xf.p.x = 0.0;  xf.p.y = -0.5;
        b2CollideSegmentAndPolygon( &seg, &boxB, &xf, &man );
        Check( man.pointCount == 2 );
        Check( feq( man.normal.x, 0.0 ) && feq( man.normal.y, -1.0 ) );
        Check( feq( man.points[0].point.x, -1.0 ) && feq( man.points[0].point.y, 0.25 ) );
        Check( feq( man.points[1].point.x,  1.0 ) && feq( man.points[1].point.y, 0.25 ) );
        Check( feq( man.points[0].separation, -0.5 ) && feq( man.points[1].separation, -0.5 ) );

        // flip=true coverage: call b2ClipPolygons directly (axis-aligned boxes
        // always give separationA==separationB -> flip=false through the SAT path,
        // so the flip=true branch -- b2Neg(normal), swapped point order/ids -- is
        // otherwise untested). boxB(1x1) shifted to (0,1.5) so its bottom edge is
        // the reference, boxA top edge is incident. No origin shift in ClipPolygons.
        boxB.vertices[0].y = boxB.vertices[0].y + 1.5;
        boxB.vertices[1].y = boxB.vertices[1].y + 1.5;
        boxB.vertices[2].y = boxB.vertices[2].y + 1.5;
        boxB.vertices[3].y = boxB.vertices[3].y + 1.5;
        b2ClipPolygons( &boxA, &boxB, 2, 0, true, &man );
        Check( man.pointCount == 2 );
        Check( feq( man.normal.x, 0.0 ) && feq( man.normal.y, 1.0 ) );
        Check( feq( man.points[0].point.x,  1.0 ) && feq( man.points[0].point.y, 0.75 ) );
        Check( feq( man.points[1].point.x, -1.0 ) && feq( man.points[1].point.y, 0.75 ) );
        Check( feq( man.points[0].separation, -0.5 ) && feq( man.points[1].separation, -0.5 ) );
    }

    // ----- core: bit utilities (ctz.h) -----
    Check( b2CTZ32( 8 ) == 3 );
    Check( b2CTZ32( 1 ) == 0 );
    Check( b2CTZ32( 0 ) == 32 );
    Check( b2CTZ32( 96 ) == 5 );        // 0b1100000, lowest set bit at 5
    Check( b2CLZ32( 1 ) == 31 );
    Check( b2CLZ32( 0 ) == 32 );
    Check( b2CLZ32( 256 ) == 23 );      // bit 8 set -> 31-8 leading zeros
    Check( b2CLZ32( 4 ) == 29 );
    Check( b2IsPowerOf2( 8 ) == true );
    Check( b2IsPowerOf2( 6 ) == false );
    Check( b2RoundUpPowerOf2( 5 ) == 8 );
    Check( b2RoundUpPowerOf2( 8 ) == 8 );
    Check( b2RoundUpPowerOf2( 17 ) == 32 );
    Check( b2RoundUpPowerOf2( 1 ) == 1 );
    Check( b2BoundingPowerOf2( 5 ) == 3 );
    Check( b2BoundingPowerOf2( 1 ) == 1 );

    // ----- core: allocator (b2_core.h) -----
    {
        int* p = b2Alloc( 4 );
        p[0] = 42;  p[1] = -7;  p[2] = 1000;  p[3] = 5;
        Check( p[0] == 42 && p[1] == -7 && p[2] == 1000 && p[3] == 5 );
        b2Free( p, 4 );

        int* z = b2AllocZeroInit( 3 );
        Check( z[0] == 0 && z[1] == 0 && z[2] == 0 );
        b2Free( z, 3 );

        // grow preserves existing contents
        int* g = b2Alloc( 2 );
        g[0] = 11;  g[1] = 22;
        g = b2GrowAlloc( g, 2, 5 );
        Check( g[0] == 11 && g[1] == 22 );
        b2Free( g, 5 );
    }

    // ----- PROBE: variable-index access into a heap-pointer array of large
    //   (7-word) structs. This is the core access pattern of dynamic_tree and
    //   every sim-core module (bodies/shapes/contacts). Each sub-check is
    //   separated so FIRST FAIL CHECK # tells us exactly which pattern breaks.
    {
        int N = 6;
        PNode* arr = b2Alloc( N * sizeof( PNode ) );
        int i;

        // (A) write scalar + nested-struct members at a variable index
        for( i = 0; i < N; ++i )
        {
            arr[i].id = i;
            arr[i].parent = i * 2;
            arr[i].height = i + 100;
            arr[i].box.lowerBound.x = i * 1.0;
            arr[i].box.upperBound.y = i * 1.0 + 0.5;
        }
        // (A) read them back at a variable index (subscript form  arr[i].f)
        bool okA = true;
        for( i = 0; i < N; ++i )
        {
            if( arr[i].id != i )                                 okA = false;
            if( arr[i].parent != i * 2 )                         okA = false;
            if( arr[i].height != i + 100 )                       okA = false;
            if( !feq( arr[i].box.lowerBound.x, i * 1.0 ) )       okA = false;
            if( !feq( arr[i].box.upperBound.y, i * 1.0 + 0.5 ) ) okA = false;
        }
        Check( okA );

        // (B) read them back via pointer-walk ( (arr+i)->f ), upstream's form
        bool okB = true;
        for( i = 0; i < N; ++i )
        {
            PNode* n = arr + i;
            if( n->id != i )                               okB = false;
            if( n->parent != i * 2 )                       okB = false;
            if( !feq( n->box.upperBound.y, i * 1.0 + 0.5 ) ) okB = false;
        }
        Check( okB );

        // (C) write via a function out-param to &arr[i].member at variable index
        //   (this exact form -- but on an array *member* -- miscompiled in the
        //   manifold undo loop; here the base is a heap pointer)
        for( i = 0; i < N; ++i )
        {
            b2Vec2 a;  a.x = i;    a.y = i;
            b2Vec2 b;  b.x = 1.0;  b.y = 2.0;
            b2Add( &a, &b, &arr[i].box.lowerBound );
        }
        bool okC = true;
        for( i = 0; i < N; ++i )
        {
            if( !feq( arr[i].box.lowerBound.x, i + 1.0 ) ) okC = false;
            if( !feq( arr[i].box.lowerBound.y, i + 2.0 ) ) okC = false;
        }
        Check( okC );

        // (D) free-list style: store next-index in a scalar field, walk it
        for( i = 0; i < N - 1; ++i )
            arr[i].parent = i + 1;
        arr[N - 1].parent = -1;
        int walk = 0;
        int steps = 0;
        while( walk != -1 )
        {
            walk = arr[walk].parent;
            steps = steps + 1;
        }
        Check( steps == N );   // visited all N then hit -1

        b2Free( arr, N * sizeof( PNode ) );
    }

    // ----- dynamic tree: build, query, move, destroy -----
    {
        b2DynamicTree tree;
        b2DynamicTree_Create( 16, &tree );

        b2AABB box;
        // P0 [0,0]-[1,1] data 100
        box.lowerBound.x = 0.0; box.lowerBound.y = 0.0; box.upperBound.x = 1.0; box.upperBound.y = 1.0;
        int p0 = b2DynamicTree_CreateProxy( &tree, &box, 1, 100 );
        // P1 [5,5]-[6,6] data 200
        box.lowerBound.x = 5.0; box.lowerBound.y = 5.0; box.upperBound.x = 6.0; box.upperBound.y = 6.0;
        int p1 = b2DynamicTree_CreateProxy( &tree, &box, 1, 200 );
        // P2 [10,0]-[11,1] data 300
        box.lowerBound.x = 10.0; box.lowerBound.y = 0.0; box.upperBound.x = 11.0; box.upperBound.y = 1.0;
        int p2 = b2DynamicTree_CreateProxy( &tree, &box, 1, 300 );
        // P3 [0,10]-[1,11] data 400
        box.lowerBound.x = 0.0; box.lowerBound.y = 10.0; box.upperBound.x = 1.0; box.upperBound.y = 11.0;
        int p3 = b2DynamicTree_CreateProxy( &tree, &box, 1, 400 );

        Check( b2DynamicTree_GetProxyCount( &tree ) == 4 );
        Check( b2DynamicTree_GetHeight( &tree ) >= 2 );   // 4 leaves -> height >= 2

        b2AABB q;
        b2TreeStats st;

        // query [4,4]-[7,7] -> only P1 (200)
        q.lowerBound.x = 4.0; q.lowerBound.y = 4.0; q.upperBound.x = 7.0; q.upperBound.y = 7.0;
        qHits = 0; qSum = 0;
        b2DynamicTree_QueryAll( &tree, &q, &QueryCB, NULL, &st );
        Check( qHits == 1 && qSum == 200 );
        Check( st.leafVisits == 1 && st.nodeVisits >= 1 );

        // query [0,0]-[6,6] -> P0 + P1 = 300
        q.lowerBound.x = 0.0; q.lowerBound.y = 0.0; q.upperBound.x = 6.0; q.upperBound.y = 6.0;
        qHits = 0; qSum = 0;
        b2DynamicTree_QueryAll( &tree, &q, &QueryCB, NULL, &st );
        Check( qHits == 2 && qSum == 300 );

        // query enclosing all -> 100+200+300+400 = 1000
        q.lowerBound.x = -1.0; q.lowerBound.y = -1.0; q.upperBound.x = 12.0; q.upperBound.y = 12.0;
        qHits = 0; qSum = 0;
        b2DynamicTree_QueryAll( &tree, &q, &QueryCB, NULL, &st );
        Check( qHits == 4 && qSum == 1000 );

        // query empty region -> nothing
        q.lowerBound.x = 20.0; q.lowerBound.y = 20.0; q.upperBound.x = 21.0; q.upperBound.y = 21.0;
        qHits = 0; qSum = 0;
        b2DynamicTree_QueryAll( &tree, &q, &QueryCB, NULL, &st );
        Check( qHits == 0 && qSum == 0 );

        // GetAABB round-trips P2's box
        b2AABB got;
        b2DynamicTree_GetAABB( &tree, p2, &got );
        Check( feq( got.lowerBound.x, 10.0 ) && feq( got.upperBound.y, 1.0 ) );

        // move P2 into the [4,4]-[7,7] region; now that query sees P1 + P2 = 500
        box.lowerBound.x = 5.0; box.lowerBound.y = 5.0; box.upperBound.x = 5.5; box.upperBound.y = 5.5;
        b2DynamicTree_MoveProxy( &tree, p2, &box );
        q.lowerBound.x = 4.0; q.lowerBound.y = 4.0; q.upperBound.x = 7.0; q.upperBound.y = 7.0;
        qHits = 0; qSum = 0;
        b2DynamicTree_QueryAll( &tree, &q, &QueryCB, NULL, &st );
        Check( qHits == 2 && qSum == 500 );

        // destroy P0; proxy count drops, enclosing query loses 100
        b2DynamicTree_DestroyProxy( &tree, p0 );
        Check( b2DynamicTree_GetProxyCount( &tree ) == 3 );
        q.lowerBound.x = -1.0; q.lowerBound.y = -1.0; q.upperBound.x = 12.0; q.upperBound.y = 12.0;
        qHits = 0; qSum = 0;
        b2DynamicTree_QueryAll( &tree, &q, &QueryCB, NULL, &st );
        Check( qHits == 3 && qSum == 900 );   // 200 + 300 + 400

        b2DynamicTree_Destroy( &tree );
    }

    // ----- dynamic tree: force node-pool growth (realloc + pointer re-read) -----
    {
        b2DynamicTree tree;
        b2DynamicTree_Create( 16, &tree );   // nodeCapacity = 31; 20 leaves need ~39 nodes -> regrow

        int i;
        for( i = 0; i < 20; ++i )
        {
            b2AABB box;
            box.lowerBound.x = i * 1.0;       box.lowerBound.y = 0.0;
            box.upperBound.x = i * 1.0 + 0.5; box.upperBound.y = 0.5;
            b2DynamicTree_CreateProxy( &tree, &box, 1, i );
        }

        Check( b2DynamicTree_GetProxyCount( &tree ) == 20 );

        // enclosing query must see all 20 leaves -> sum 0..19 = 190 (validates the
        // whole refit survived the realloc + the nodes-pointer re-read)
        b2AABB q;
        q.lowerBound.x = -1.0; q.lowerBound.y = -1.0; q.upperBound.x = 100.0; q.upperBound.y = 100.0;
        b2TreeStats st;
        qHits = 0; qSum = 0;
        b2DynamicTree_QueryAll( &tree, &q, &QueryCB, NULL, &st );
        Check( qHits == 20 && qSum == 190 );

        b2DynamicTree_Destroy( &tree );
    }

    // ----- id pool: alloc / free / reuse / growth -----
    {
        b2IdPool pool;
        b2CreateIdPool( &pool );

        // fresh ids hand out 0,1,2
        Check( b2AllocId( &pool ) == 0 );
        Check( b2AllocId( &pool ) == 1 );
        Check( b2AllocId( &pool ) == 2 );
        Check( b2GetIdCount( &pool ) == 3 );
        Check( b2GetIdCapacity( &pool ) == 3 );

        // free one, then it gets reused (LIFO)
        b2FreeId( &pool, 1 );
        Check( b2GetIdCount( &pool ) == 2 );
        Check( b2AllocId( &pool ) == 1 );
        Check( b2GetIdCount( &pool ) == 3 );

        b2DestroyIdPool( &pool );
    }

    // ----- id pool: force free-array growth past initial capacity 32 -----
    {
        b2IdPool pool;
        b2CreateIdPool( &pool );

        int i;
        for( i = 0; i < 40; ++i )
            b2AllocId( &pool );          // ids 0..39
        Check( b2GetIdCapacity( &pool ) == 40 );
        Check( b2GetIdCount( &pool ) == 40 );

        for( i = 0; i < 40; ++i )
            b2FreeId( &pool, i );        // free all -> freeArray grows beyond 32
        Check( b2GetIdCount( &pool ) == 0 );
        Check( pool.capacity >= 40 );

        // realloc reuses the freed ids LIFO: last freed (39) comes back first
        Check( b2AllocId( &pool ) == 39 );
        Check( b2AllocId( &pool ) == 38 );
        Check( b2GetIdCount( &pool ) == 2 );

        b2DestroyIdPool( &pool );
    }

    // ----- arena (stack) allocator: bump / LIFO free / heap fallback -----
    {
        b2Stack s;
        b2CreateStack( 64, &s );           // 64-word buffer
        Check( b2GetStackCapacity( &s ) == 64 );
        Check( b2GetStackAllocation( &s ) == 0 );

        // two nested in-buffer allocations
        int* a = b2StackAlloc( &s, 10 );
        a[0] = 11;  a[9] = 99;
        Check( b2GetStackAllocation( &s ) == 10 );
        int* b = b2StackAlloc( &s, 20 );
        b[0] = 7;  b[19] = 8;
        Check( b2GetStackAllocation( &s ) == 30 );
        Check( a[0] == 11 && a[9] == 99 && b[0] == 7 && b[19] == 8 );

        // LIFO free
        b2StackFree( &s, b );
        Check( b2GetStackAllocation( &s ) == 10 );
        b2StackFree( &s, a );
        Check( b2GetStackAllocation( &s ) == 0 );
        Check( b2GetMaxStackAllocation( &s ) == 30 );

        // request bigger than the buffer -> heap fallback, still usable
        int* big = b2StackAlloc( &s, 100 );
        big[0] = 5;  big[99] = 6;
        Check( b2GetStackAllocation( &s ) == 100 );
        Check( big[0] == 5 && big[99] == 6 );
        b2StackFree( &s, big );
        Check( b2GetStackAllocation( &s ) == 0 );
        Check( b2GetMaxStackAllocation( &s ) == 100 );

        // grow buffer toward the high-water mark (stack is idle)
        b2GrowStack( &s );
        Check( b2GetStackCapacity( &s ) >= 100 );

        b2DestroyStack( &s );
    }

    // ----- shape: type-dispatching compute helpers (sim-core slice 1) -----
    {
        b2Shape sh;
        b2MassData smd;
        b2AABB sab;
        b2ShapeExtent sext;
        b2Vec2 lc;  lc.x = 0.0;  lc.y = 0.0;

        // circle: density 3, radius 2, center origin
        sh.type = b2_circleShape;
        sh.density = 3.0;
        sh.circle.center.x = 0.0;  sh.circle.center.y = 0.0;  sh.circle.radius = 2.0;
        b2ComputeShapeMass( &sh, &smd );
        Check( feq( smd.mass, 12.0 * B2_PI ) );             // pi r^2 * density = 4*3*pi
        b2ComputeShapeAABB( &sh, &b2Transform_identity, &sab );
        Check( feq( sab.lowerBound.x, -2.0 ) && feq( sab.upperBound.y, 2.0 ) );
        b2ComputeShapeExtent( &sh, &lc, &sext );
        Check( feq( sext.minExtent, 2.0 ) && feq( sext.maxExtent, 2.0 ) );

        // polygon: unit-density box(2,1) -> area 8, mass 8
        sh.type = b2_polygonShape;
        sh.density = 1.0;
        b2MakeBox( 2.0, 1.0, &sh.polygon );
        b2ComputeShapeMass( &sh, &smd );
        Check( feq( smd.mass, 8.0 ) );
        b2ComputeShapeAABB( &sh, &b2Transform_identity, &sab );
        Check( feq( sab.lowerBound.x, -2.0 ) && feq( sab.lowerBound.y, -1.0 ) );
        Check( feq( sab.upperBound.x,  2.0 ) && feq( sab.upperBound.y,  1.0 ) );
        b2ComputeShapeExtent( &sh, &lc, &sext );
        Check( feq( sext.minExtent, 1.0 ) );                // nearest face at offset 1
        Check( feq( sext.maxExtent, sqrt( 5.0 ) ) );        // corner (2,1) distance

        // segment dispatch -> AABB spans the endpoints
        sh.type = b2_segmentShape;
        sh.segment.point1.x = -3.0; sh.segment.point1.y = 0.0;
        sh.segment.point2.x =  3.0; sh.segment.point2.y = 0.0;
        b2ComputeShapeAABB( &sh, &b2Transform_identity, &sab );
        Check( feq( sab.lowerBound.x, -3.0 ) && feq( sab.upperBound.x, 3.0 ) );
    }

    // ----- body: world + create + accessors (sim-core slice 2) -----
    {
        b2World world;
        b2CreateWorld( &world );

        b2BodyDef def;
        b2WorldTransform xf;
        b2BodyId idA, idB, idD, idD2;

        // two static bodies at distinct positions
        b2DefaultBodyDef( &def );
        def.position.x = 3.0; def.position.y = 4.0;
        b2CreateBody( &world, &def, &idA );

        b2DefaultBodyDef( &def );
        def.position.x = 7.0; def.position.y = 8.0;
        b2CreateBody( &world, &def, &idB );

        // transforms round-trip THROUGH setIndex->set->localIndex->bodySim for both
        // (a single body could pass with localIndex stuck at 0; two catches it)
        b2GetBodyTransform( &world, idA.index1 - 1, &xf );
        Check( feq( xf.p.x, 3.0 ) && feq( xf.p.y, 4.0 ) );
        b2GetBodyTransform( &world, idB.index1 - 1, &xf );
        Check( feq( xf.p.x, 7.0 ) && feq( xf.p.y, 8.0 ) );

        b2Body* bA = b2GetBodyFullId( &world, &idA );
        b2Body* bB = b2GetBodyFullId( &world, &idB );
        Check( bA->setIndex == b2_staticSet && bA->localIndex == 0 );
        Check( bB->setIndex == b2_staticSet && bB->localIndex == 1 );
        Check( bA->type == b2_staticBody );
        Check( bA->generation == 1 && idA.generation == 1 );

        // static bodies have no solver state
        Check( b2GetBodyState( &world, bA ) == NULL );

        // a dynamic, awake body: position/rotation/velocity round-trip; awake set
        b2DefaultBodyDef( &def );
        def.type = b2_dynamicBody;
        def.position.x = 1.0; def.position.y = 2.0;
        def.rotation.c = 0.0; def.rotation.s = 1.0;   // 90 deg
        def.linearVelocity.x = 5.0; def.linearVelocity.y = 6.0;
        def.angularVelocity = 7.0;
        b2CreateBody( &world, &def, &idD );

        b2Body* bD = b2GetBodyFullId( &world, &idD );
        Check( bD->setIndex == b2_awakeSet && bD->localIndex == 0 );
        Check( ( bD->flags & b2_dynamicFlag ) != 0 );

        b2BodySim* simD = b2GetBodySim( &world, bD );
        Check( feq( simD->transform.p.x, 1.0 ) && feq( simD->transform.p.y, 2.0 ) );
        Check( feq( simD->transform.q.c, 0.0 ) && feq( simD->transform.q.s, 1.0 ) );
        Check( feq( simD->center.x, 1.0 ) && feq( simD->center.y, 2.0 ) );
        Check( simD->bodyId == bD->id );

        // awake body HAS solver state, velocity round-trips, deltaRotation identity
        b2BodyState* stD = b2GetBodyState( &world, bD );
        Check( stD != NULL );
        Check( feq( stD->linearVelocity.x, 5.0 ) && feq( stD->linearVelocity.y, 6.0 ) );
        Check( feq( stD->angularVelocity, 7.0 ) );
        Check( feq( stD->deltaRotation.c, 1.0 ) && feq( stD->deltaRotation.s, 0.0 ) );

        // second dynamic body -> awake localIndex advances
        b2DefaultBodyDef( &def );
        def.type = b2_dynamicBody;
        def.position.x = -1.0; def.position.y = -2.0;
        b2CreateBody( &world, &def, &idD2 );
        b2Body* bD2 = b2GetBodyFullId( &world, &idD2 );
        Check( bD2->setIndex == b2_awakeSet && bD2->localIndex == 1 );
        b2GetBodyTransform( &world, idD2.index1 - 1, &xf );
        Check( feq( xf.p.x, -1.0 ) && feq( xf.p.y, -2.0 ) );

        // b2MakeBodyId reconstructs a matching handle
        b2BodyId mk;
        b2MakeBodyId( &world, bD->id, &mk );
        Check( mk.index1 == idD.index1 && mk.generation == idD.generation );

        b2DestroyWorld( &world );
    }

    // ----- body: destroy (swap-and-fixup) (sim-core slice 2) -----
    {
        b2World world;
        b2CreateWorld( &world );

        b2BodyDef def;
        b2WorldTransform xf;
        b2BodyId s0, s1, s2, d0, d1, d2, nu;

        // (A) static set: 3 bodies, destroy the MIDDLE one. The last (S2) must
        //     swap into slot 1 and its localIndex must be repaired to 1.
        b2DefaultBodyDef( &def );
        def.position.x = 10.0; def.position.y = 0.0;
        b2CreateBody( &world, &def, &s0 );
        def.position.x = 20.0; def.position.y = 0.0;
        b2CreateBody( &world, &def, &s1 );
        def.position.x = 30.0; def.position.y = 0.0;
        b2CreateBody( &world, &def, &s2 );
        Check( b2GetIdCount( &world.bodyIdPool ) == 3 );

        b2DestroyBody( &world, &s1 );
        Check( b2GetIdCount( &world.bodyIdPool ) == 2 );

        // S2 relocated into the freed slot; transform still round-trips through
        // the repaired localIndex (this is the discriminating check)
        b2Body* bS2 = b2GetBodyFullId( &world, &s2 );
        Check( bS2->localIndex == 1 );
        b2GetBodyTransform( &world, s2.index1 - 1, &xf );
        Check( feq( xf.p.x, 30.0 ) && feq( xf.p.y, 0.0 ) );

        // S0 untouched at slot 0
        b2Body* bS0 = b2GetBodyFullId( &world, &s0 );
        Check( bS0->localIndex == 0 );
        b2GetBodyTransform( &world, s0.index1 - 1, &xf );
        Check( feq( xf.p.x, 10.0 ) && feq( xf.p.y, 0.0 ) );

        // destroyed record nulled but generation preserved
        b2Body* bS1 = &world.bodies.data[ s1.index1 - 1 ];
        Check( bS1->setIndex == B2_NULL_INDEX && bS1->id == B2_NULL_INDEX );

        // id recycles LIFO; reused slot bumps generation (1 -> 2) so the old id is stale
        b2DefaultBodyDef( &def );
        def.position.x = 99.0; def.position.y = 0.0;
        b2CreateBody( &world, &def, &nu );
        Check( nu.index1 == s1.index1 );        // same slot reused
        Check( nu.generation == s1.generation + 1 );
        b2GetBodyTransform( &world, nu.index1 - 1, &xf );
        Check( feq( xf.p.x, 99.0 ) );

        // (B) awake set: 3 dynamic bodies w/ distinct velocities, destroy the FIRST.
        //     The parallel bodyState must swap in lockstep with the sim.
        b2DefaultBodyDef( &def );  def.type = b2_dynamicBody;
        def.position.x = 1.0; def.linearVelocity.x = 1.0; b2CreateBody( &world, &def, &d0 );
        def.position.x = 2.0; def.linearVelocity.x = 2.0; b2CreateBody( &world, &def, &d1 );
        def.position.x = 3.0; def.linearVelocity.x = 3.0; b2CreateBody( &world, &def, &d2 );

        b2DestroyBody( &world, &d0 );

        // D2 (last) relocated into slot 0; both its transform AND its state moved
        b2Body* bD2 = b2GetBodyFullId( &world, &d2 );
        Check( bD2->localIndex == 0 );
        b2BodySim* simD2 = b2GetBodySim( &world, bD2 );
        Check( feq( simD2->transform.p.x, 3.0 ) );
        b2BodyState* stD2 = b2GetBodyState( &world, bD2 );
        Check( stD2 != NULL && feq( stD2->linearVelocity.x, 3.0 ) );

        // D1 still intact (its velocity didn't get clobbered by the swap)
        b2Body* bD1 = b2GetBodyFullId( &world, &d1 );
        b2BodyState* stD1 = b2GetBodyState( &world, bD1 );
        Check( feq( stD1->linearVelocity.x, 2.0 ) );

        b2DestroyWorld( &world );
    }

    // ----- shape: attach-to-body + mass data (sim-core slice 3) -----
    {
        b2World world;
        b2CreateWorld( &world );

        b2BodyDef bdef;
        b2ShapeDef sdef;
        b2BodyId bid, bid2;
        b2ShapeId sidA, sidB, sidC;
        b2Circle cir;

        // (1) single CENTERED circle on a dynamic body: exact plumbing cross-check.
        //     (offset 0 makes mass/inertia coincide with the shape's own values.)
        b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.x = 4.0; bdef.position.y = 1.0;
        bdef.angularVelocity = 0.0;          // isolate the COM-shift velocity term
        b2CreateBody( &world, &bdef, &bid );

        b2DefaultShapeDef( &sdef );
        sdef.density = 3.0;
        cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 2.0;
        b2CreateCircleShape( &world, &bid, &sdef, &cir, &sidA );

        b2Body* body = b2GetBodyFullId( &world, &bid );
        b2BodySim* sim = b2GetBodySim( &world, body );

        // shape linked into the body
        Check( body->shapeCount == 1 );
        Check( body->headShapeId == sidA.index1 - 1 );
        Check( sidA.index1 == 1 && sidA.generation == 1 );

        // mass / localCenter / COM (checked before inertia so a FIRST FAIL on
        // inertia still confirms create+link+accumulation passed)
        b2Shape probe;
        probe.type = b2_circleShape; probe.density = 3.0;
        probe.circle.center.x = 0.0; probe.circle.center.y = 0.0; probe.circle.radius = 2.0;
        b2MassData md;
        b2ComputeShapeMass( &probe, &md );
        Check( feq( body->mass, md.mass ) );
        Check( feq( sim->invMass, 1.0 / body->mass ) );
        Check( feq( sim->localCenter.x, 0.0 ) && feq( sim->localCenter.y, 0.0 ) );
        Check( feq( sim->center.x, 4.0 ) && feq( sim->center.y, 1.0 ) );
        // exact inertia (offset 0 -> body inertia == shape rotationalInertia)
        Check( feq( body->inertia, md.rotationalInertia ) );
        Check( feq( sim->invInertia, 1.0 / body->inertia ) );

        // (2) two circles at DISTINCT centers (0,0) and (2,0): discriminates the
        //     mass-weighting/division and the second (parallel-axis) loop.
        b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.x = 10.0; bdef.position.y = 5.0;
        bdef.angularVelocity = 0.0;
        b2CreateBody( &world, &bdef, &bid2 );

        b2DefaultShapeDef( &sdef );
        sdef.density = 1.0;
        cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 1.0;
        b2CreateCircleShape( &world, &bid2, &sdef, &cir, &sidB );
        cir.center.x = 2.0; cir.center.y = 0.0; cir.radius = 1.0;
        b2CreateCircleShape( &world, &bid2, &sdef, &cir, &sidC );

        b2Body* body2 = b2GetBodyFullId( &world, &bid2 );
        b2BodySim* sim2 = b2GetBodySim( &world, body2 );

        // list: two shapes, head is the most-recently added (C), linked back to B
        Check( body2->shapeCount == 2 );
        Check( body2->headShapeId == sidC.index1 - 1 );
        Check( world.shapes.data[ sidC.index1 - 1 ].nextShapeId == sidB.index1 - 1 );
        Check( world.shapes.data[ sidB.index1 - 1 ].prevShapeId == sidC.index1 - 1 );

        // mass sums both; localCenter is the mass-weighted midpoint (1,0); COM transforms
        Check( feq( body2->mass, 2.0 * B2_PI ) );           // pi*r^2*density per circle
        Check( feq( sim2->localCenter.x, 1.0 ) && feq( sim2->localCenter.y, 0.0 ) );
        Check( feq( sim2->center.x, 11.0 ) && feq( sim2->center.y, 5.0 ) );

        b2DestroyWorld( &world );
    }

    // ----- shape: destroy + list unlink (sim-core slice 3b) -----
    {
        b2World world;
        b2CreateWorld( &world );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.angularVelocity = 0.0;
        b2BodyId bid;  b2CreateBody( &world, &bdef, &bid );

        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        sdef.density = 1.0;
        b2Circle cir;  cir.radius = 1.0;
        b2ShapeId sa, sb, sc;
        cir.center.x = -2.0; cir.center.y = 0.0;  b2CreateCircleShape( &world, &bid, &sdef, &cir, &sa );
        cir.center.x =  0.0; cir.center.y = 0.0;  b2CreateCircleShape( &world, &bid, &sdef, &cir, &sb );
        cir.center.x =  2.0; cir.center.y = 0.0;  b2CreateCircleShape( &world, &bid, &sdef, &cir, &sc );

        b2Body* body = b2GetBodyFullId( &world, &bid );
        Check( body->shapeCount == 3 );
        Check( feq( body->mass, 3.0 * B2_PI ) );
        Check( b2GetIdCount( &world.shapeIdPool ) == 3 );

        // destroy the MIDDLE-of-list shape (sb): exercises both prev and next fixup
        b2DestroyShape( &world, &sb, true );

        Check( body->shapeCount == 2 );
        Check( feq( body->mass, 2.0 * B2_PI ) );
        Check( b2GetIdCount( &world.shapeIdPool ) == 2 );

        // list relinked around the hole: head = C -> A -> null
        int idA = sa.index1 - 1;
        int idC = sc.index1 - 1;
        Check( body->headShapeId == idC );
        Check( world.shapes.data[ idC ].nextShapeId == idA );
        Check( world.shapes.data[ idA ].prevShapeId == idC );
        Check( world.shapes.data[ idA ].nextShapeId == B2_NULL_INDEX );

        // freed shape slot nulled
        Check( world.shapes.data[ sb.index1 - 1 ].id == B2_NULL_INDEX );

        b2DestroyWorld( &world );
    }

    // ----- broad-phase: shape proxies in the body-type trees (sim-core slice 3c) -----
    {
        b2World world;
        b2CreateWorld( &world );

        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 1.0;
        b2TreeStats st;
        b2AABB q;

        // static body at (5,5) + unit circle -> proxy in the STATIC tree
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.position.x = 5.0; bdef.position.y = 5.0;
        b2BodyId sbody;  b2CreateBody( &world, &bdef, &sbody );
        b2ShapeId sshape;  b2CreateCircleShape( &world, &sbody, &sdef, &cir, &sshape );

        int sid = sshape.index1 - 1;
        b2Shape* shp = b2GetShape( &world, &sshape );
        Check( shp->proxyKey != B2_NULL_INDEX );
        Check( B2_PROXY_TYPE( shp->proxyKey ) == b2_staticBody );

        // query the static tree over (5,5) -> finds exactly our shape
        q.lowerBound.x = 4.0; q.lowerBound.y = 4.0; q.upperBound.x = 6.0; q.upperBound.y = 6.0;
        qHits = 0; qSum = 0;
        b2DynamicTree_QueryAll( &world.broadPhase.trees[ b2_staticBody ], &q, &QueryCB, NULL, &st );
        Check( qHits == 1 && qSum == sid );

        // a far-away region finds nothing
        q.lowerBound.x = 50.0; q.lowerBound.y = 50.0; q.upperBound.x = 51.0; q.upperBound.y = 51.0;
        qHits = 0; qSum = 0;
        b2DynamicTree_QueryAll( &world.broadPhase.trees[ b2_staticBody ], &q, &QueryCB, NULL, &st );
        Check( qHits == 0 );

        // dynamic body + shape -> proxy lands in the DYNAMIC tree
        b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.x = -3.0; bdef.position.y = 0.0;
        b2BodyId dbody;  b2CreateBody( &world, &bdef, &dbody );
        b2ShapeId dshape;  b2CreateCircleShape( &world, &dbody, &sdef, &cir, &dshape );
        int did = dshape.index1 - 1;
        Check( B2_PROXY_TYPE( b2GetShape( &world, &dshape )->proxyKey ) == b2_dynamicBody );

        q.lowerBound.x = -4.0; q.lowerBound.y = -1.0; q.upperBound.x = -2.0; q.upperBound.y = 1.0;
        qHits = 0; qSum = 0;
        b2DynamicTree_QueryAll( &world.broadPhase.trees[ b2_dynamicBody ], &q, &QueryCB, NULL, &st );
        Check( qHits == 1 && qSum == did );

        // the dynamic shape's region is empty in the STATIC tree (proxies don't cross trees)
        qHits = 0; qSum = 0;
        b2DynamicTree_QueryAll( &world.broadPhase.trees[ b2_staticBody ], &q, &QueryCB, NULL, &st );
        Check( qHits == 0 );

        // destroy the static shape -> its proxy leaves the static tree
        b2DestroyShape( &world, &sshape, true );
        q.lowerBound.x = 4.0; q.lowerBound.y = 4.0; q.upperBound.x = 6.0; q.upperBound.y = 6.0;
        qHits = 0; qSum = 0;
        b2DynamicTree_QueryAll( &world.broadPhase.trees[ b2_staticBody ], &q, &QueryCB, NULL, &st );
        Check( qHits == 0 );
        Check( b2GetShape( &world, &sshape )->proxyKey == B2_NULL_INDEX );

        b2DestroyWorld( &world );
    }

    // ----- world: overlap query across all body-type trees (sim-core slice 3d) -----
    {
        b2World world;
        b2CreateWorld( &world );

        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 1.0;
        b2BodyDef bdef;

        // static shape at (0,0)
        b2DefaultBodyDef( &bdef );
        bdef.position.x = 0.0; bdef.position.y = 0.0;
        b2BodyId b_s;  b2CreateBody( &world, &bdef, &b_s );
        b2ShapeId sh_s;  b2CreateCircleShape( &world, &b_s, &sdef, &cir, &sh_s );

        // dynamic shape at (1,0)
        b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 1.0; bdef.position.y = 0.0;
        b2BodyId b_d;  b2CreateBody( &world, &bdef, &b_d );
        b2ShapeId sh_d;  b2CreateCircleShape( &world, &b_d, &sdef, &cir, &sh_d );

        // dynamic shape far away at (20,0)
        b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 20.0; bdef.position.y = 0.0;
        b2BodyId b_f;  b2CreateBody( &world, &bdef, &b_f );
        b2ShapeId sh_f;  b2CreateCircleShape( &world, &b_f, &sdef, &cir, &sh_f );

        // query [-1,-1]-[2,1] hits the static (0,0) + dynamic (1,0) shapes in ONE call,
        // across DIFFERENT trees; the far (20,0) shape is excluded
        b2AABB qb;
        qb.lowerBound.x = -1.0; qb.lowerBound.y = -1.0; qb.upperBound.x = 2.0; qb.upperBound.y = 1.0;
        b2TreeStats wst;
        qHits = 0; qSum = 0;
        b2World_OverlapAABB( &world, &qb, NULL, &QueryCB, NULL, &wst );
        Check( qHits == 2 );
        Check( qSum == ( sh_s.index1 - 1 ) + ( sh_d.index1 - 1 ) );   // 0 + 1
        Check( wst.leafVisits >= 2 );

        // query covering everything finds all 3
        qb.lowerBound.x = -2.0; qb.lowerBound.y = -2.0; qb.upperBound.x = 22.0; qb.upperBound.y = 2.0;
        qHits = 0; qSum = 0;
        b2World_OverlapAABB( &world, &qb, NULL, &QueryCB, NULL, &wst );
        Check( qHits == 3 );

        b2DestroyWorld( &world );
    }

    // ----- body: SetTransform moves the broad-phase proxy (sim-core slice 3e) -----
    {
        b2World world;
        b2CreateWorld( &world );

        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0; bdef.position.y = 0.0;
        b2BodyId bid;  b2CreateBody( &world, &bdef, &bid );

        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 1.0;
        b2ShapeId sid;  b2CreateCircleShape( &world, &bid, &sdef, &cir, &sid );
        int shp = sid.index1 - 1;

        b2AABB q;
        b2TreeStats st;

        // initially found near the origin
        q.lowerBound.x = -1.0; q.lowerBound.y = -1.0; q.upperBound.x = 1.0; q.upperBound.y = 1.0;
        qHits = 0; qSum = 0;
        b2World_OverlapAABB( &world, &q, NULL, &QueryCB, NULL, &st );
        Check( qHits == 1 && qSum == shp );

        // move the body to (10,10)
        b2Vec2 np;  np.x = 10.0; np.y = 10.0;
        b2Body_SetTransform( &world, &bid, &np, &b2Rot_identity );

        b2Body* body = b2GetBodyFullId( &world, &bid );
        b2BodySim* sim = b2GetBodySim( &world, body );
        Check( feq( sim->transform.p.x, 10.0 ) && feq( sim->transform.p.y, 10.0 ) );

        // old region now empty (proxy moved), new region finds it
        qHits = 0; qSum = 0;
        b2World_OverlapAABB( &world, &q, NULL, &QueryCB, NULL, &st );   // q still the origin box
        Check( qHits == 0 );

        q.lowerBound.x = 9.0; q.lowerBound.y = 9.0; q.upperBound.x = 11.0; q.upperBound.y = 11.0;
        qHits = 0; qSum = 0;
        b2World_OverlapAABB( &world, &q, NULL, &QueryCB, NULL, &st );
        Check( qHits == 1 && qSum == shp );

        b2DestroyWorld( &world );
    }

    // ----- bitset (32-bit block rework of the uint64 original) -----
    {
        b2BitSet bs;
        b2CreateBitSet( 64, &bs );
        b2SetBitCountAndClear( &bs, 70 );          // blockCount = ceil(70/32) = 3
        Check( b2CountSetBits( &bs ) == 0 );

        b2SetBit( &bs, 5 );
        b2SetBit( &bs, 31 );                        // top bit of block 0 (1<<31)
        b2SetBit( &bs, 32 );                        // first bit of block 1
        b2SetBit( &bs, 69 );                        // block 2
        Check( b2GetBit( &bs, 5 ) && b2GetBit( &bs, 31 ) && b2GetBit( &bs, 32 ) && b2GetBit( &bs, 69 ) );
        Check( b2GetBit( &bs, 6 ) == false && b2GetBit( &bs, 30 ) == false );
        Check( b2CountSetBits( &bs ) == 4 );

        b2ClearBit( &bs, 31 );
        Check( b2GetBit( &bs, 31 ) == false && b2CountSetBits( &bs ) == 3 );

        // out-of-range get is false; set beyond capacity grows
        Check( b2GetBit( &bs, 500 ) == false );
        b2SetBitGrow( &bs, 200 );
        Check( b2GetBit( &bs, 200 ) == true && b2CountSetBits( &bs ) == 4 );

        b2DestroyBitSet( &bs );

        // union of two equal-size sets
        b2BitSet ua, ub;
        b2CreateBitSet( 64, &ua );  b2SetBitCountAndClear( &ua, 64 );  // blockCount 2
        b2CreateBitSet( 64, &ub );  b2SetBitCountAndClear( &ub, 64 );
        b2SetBit( &ua, 3 );  b2SetBit( &ua, 40 );
        b2SetBit( &ub, 40 ); b2SetBit( &ub, 50 );   // 40 overlaps
        b2InPlaceUnion( &ua, &ub );
        Check( b2GetBit( &ua, 3 ) && b2GetBit( &ua, 40 ) && b2GetBit( &ua, 50 ) );
        Check( b2CountSetBits( &ua ) == 3 );
        b2DestroyBitSet( &ua );  b2DestroyBitSet( &ub );
    }

    // ----- table: shape-pair hash set (uint64 key reworked to int pair) -----
    {
        b2HashSet set;
        b2CreateSet( 16, &set );
        Check( b2GetSetCount( &set ) == 0 );

        // add returns false first time, true on duplicate; canonicalization (a,b)==(b,a)
        Check( b2AddKey( &set, 3, 7 ) == false );
        Check( b2AddKey( &set, 7, 3 ) == true );      // same pair, reversed
        Check( b2ContainsKey( &set, 7, 3 ) == true );
        Check( b2GetSetCount( &set ) == 1 );

        // a pair with a zero id is live (key1==0 but key2>=1)
        Check( b2AddKey( &set, 0, 5 ) == false );
        Check( b2ContainsKey( &set, 5, 0 ) == true );
        Check( b2ContainsKey( &set, 1, 2 ) == false );

        // insert enough distinct pairs to force a grow past capacity 16 (full rehash)
        int i;
        for( i = 0; i < 12; ++i )
            b2AddKey( &set, 100, 200 + i );          // 12 pairs (100,200)..(100,211)
        Check( b2GetSetCount( &set ) == 14 );        // 2 earlier + 12
        Check( b2GetSetCapacity( &set ) > 16 );      // grew

        // every key still present after the rehash
        bool allPresent = b2ContainsKey( &set, 3, 7 ) && b2ContainsKey( &set, 0, 5 );
        for( i = 0; i < 12; ++i )
            if( b2ContainsKey( &set, 100, 200 + i ) == false ) allPresent = false;
        Check( allPresent );

        // remove a subset; backward-shift must keep every surviving key reachable
        Check( b2RemoveKey( &set, 100, 203 ) == true );
        Check( b2RemoveKey( &set, 100, 207 ) == true );
        Check( b2RemoveKey( &set, 3, 7 ) == true );
        Check( b2RemoveKey( &set, 999, 998 ) == false );   // absent
        Check( b2GetSetCount( &set ) == 11 );

        Check( b2ContainsKey( &set, 100, 203 ) == false && b2ContainsKey( &set, 100, 207 ) == false );
        Check( b2ContainsKey( &set, 3, 7 ) == false );
        bool survivorsOk = b2ContainsKey( &set, 0, 5 );
        for( i = 0; i < 12; ++i )
            if( i != 3 && i != 7 )
                if( b2ContainsKey( &set, 100, 200 + i ) == false ) survivorsOk = false;
        Check( survivorsOk );

        b2DestroySet( &set );
    }

    // ----- broad-phase move buffering (contact pipeline: pair-finding prep) -----
    {
        b2BroadPhase bp;
        b2CreateBroadPhase( &bp );
        b2AABB box;
        box.lowerBound.x = 0.0; box.lowerBound.y = 0.0; box.upperBound.x = 1.0; box.upperBound.y = 1.0;

        // dynamic proxy is buffered; static proxy is NOT (the static gate)
        int pd = b2BroadPhase_CreateProxy( &bp, b2_dynamicBody, &box, 1, 10 );
        int ps = b2BroadPhase_CreateProxy( &bp, b2_staticBody,  &box, 1, 11 );
        Check( bp.moveCount == 1 );
        Check( bp.moveArray[0] == pd );
        Check( b2GetBit( &bp.movedProxies[ b2_dynamicBody ], B2_PROXY_ID( pd ) ) == true );
        Check( b2GetBit( &bp.movedProxies[ b2_staticBody ], B2_PROXY_ID( ps ) ) == false );

        // second dynamic proxy -> two moved
        int pd2 = b2BroadPhase_CreateProxy( &bp, b2_dynamicBody, &box, 1, 12 );
        Check( bp.moveCount == 2 );

        // moving pd again does NOT duplicate it (dedup via the bit)
        b2BroadPhase_MoveProxy( &bp, pd, &box );
        Check( bp.moveCount == 2 );

        // destroy pd: removed from moveArray + bit cleared; pd2 survives the swap
        b2BroadPhase_DestroyProxy( &bp, pd );
        Check( bp.moveCount == 1 );
        Check( b2GetBit( &bp.movedProxies[ b2_dynamicBody ], B2_PROXY_ID( pd ) ) == false );
        Check( bp.moveArray[0] == pd2 );                                              // swapped down
        Check( b2GetBit( &bp.movedProxies[ b2_dynamicBody ], B2_PROXY_ID( pd2 ) ) == true );

        // end-of-step clear resets the buffer and the bits
        b2BroadPhase_ClearMoveBuffer( &bp );
        Check( bp.moveCount == 0 );
        Check( b2GetBit( &bp.movedProxies[ b2_dynamicBody ], B2_PROXY_ID( pd2 ) ) == false );

        b2DestroyBroadPhase( &bp );
    }

    // ----- contacts: broad-phase pairing + contact connectivity -----
    {
        b2World world;
        b2CreateWorld( &world );

        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 1.0;
        b2BodyDef bdef;

        // two dynamic bodies with overlapping circles at (0,0) and (1,0)
        b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 0.0; bdef.position.y = 0.0;
        b2BodyId b0;  b2CreateBody( &world, &bdef, &b0 );
        b2ShapeId s0;  b2CreateCircleShape( &world, &b0, &sdef, &cir, &s0 );

        bdef.position.x = 1.0; bdef.position.y = 0.0;
        b2BodyId b1;  b2CreateBody( &world, &bdef, &b1 );
        b2ShapeId s1;  b2CreateCircleShape( &world, &b1, &sdef, &cir, &s1 );

        // a far dynamic body (no overlap)
        bdef.position.x = 50.0; bdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &bdef, &bf );
        b2ShapeId sf;  b2CreateCircleShape( &world, &bf, &sdef, &cir, &sf );

        // pairing pass: exactly one contact (b0<->b1), far body untouched.
        // (the both-moved dedup fires when the pass reaches the second proxy.)
        b2UpdateBroadPhasePairs( &world );
        Check( world.contacts.count == 1 );
        Check( b2GetIdCount( &world.contactIdPool ) == 1 );

        b2Body* body0 = b2GetBodyFullId( &world, &b0 );
        b2Body* body1 = b2GetBodyFullId( &world, &b1 );
        b2Body* bodyF = b2GetBodyFullId( &world, &bf );
        Check( body0->contactCount == 1 && body1->contactCount == 1 );
        Check( bodyF->contactCount == 0 );

        int sa = s0.index1 - 1;
        int sb = s1.index1 - 1;
        b2Contact* c = &world.contacts.data[0];
        Check( ( c->shapeIdA == sa && c->shapeIdB == sb ) ||
               ( c->shapeIdA == sb && c->shapeIdB == sa ) );
        Check( b2ContainsKey( &world.broadPhase.pairSet, sa, sb ) == true );
        Check( world.broadPhase.moveCount == 0 );   // buffer cleared by the pass

        // slice A: the contact now owns a (zeroed, non-touching) b2ContactSim in
        // the awake set, reachable through contact->localIndex.
        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        Check( aset->contactSims.count == 1 );
        Check( c->localIndex == 0 );
        b2ContactSim* csim = b2GetContactSim( &world, c );
        Check( csim->contactId == c->contactId );
        Check( csim->shapeIdA == c->shapeIdA && csim->shapeIdB == c->shapeIdB );
        Check( csim->manifold.pointCount == 0 );          // created non-touching
        Check( csim->bodySimIndexA == B2_NULL_INDEX );

        // move b0 (re-buffers its proxy); pairSet dedup must NOT duplicate the contact
        b2Vec2 np;  np.x = 0.1; np.y = 0.0;
        b2Body_SetTransform( &world, &b0, &np, &b2Rot_identity );
        b2UpdateBroadPhasePairs( &world );
        Check( world.contacts.count == 1 );
        Check( body0->contactCount == 1 );

        // destroy the contact: edge lists, pairSet, counts, AND the contactSim unwind
        b2DestroyContact( &world, c, true );
        Check( body0->contactCount == 0 && body1->contactCount == 0 );
        Check( b2ContainsKey( &world.broadPhase.pairSet, sa, sb ) == false );
        Check( body0->headContactKey == B2_NULL_INDEX );
        Check( aset->contactSims.count == 0 );           // sim removed too

        b2DestroyWorld( &world );
    }

    // ----- contacts slice A: contactSim swap-remove + localIndex repair -----
    {
        b2World world;
        b2CreateWorld( &world );

        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 1.0;
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;

        // three mutually-overlapping dynamic circles -> all 3 pairs collide
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId b0;  b2CreateBody( &world, &bdef, &b0 );
        b2ShapeId s0;  b2CreateCircleShape( &world, &b0, &sdef, &cir, &s0 );
        bdef.position.x = 1.0;  bdef.position.y = 0.0;
        b2BodyId b1;  b2CreateBody( &world, &bdef, &b1 );
        b2ShapeId s1;  b2CreateCircleShape( &world, &b1, &sdef, &cir, &s1 );
        bdef.position.x = 0.5;  bdef.position.y = 0.8;
        b2BodyId b2id;  b2CreateBody( &world, &bdef, &b2id );
        b2ShapeId s2;  b2CreateCircleShape( &world, &b2id, &sdef, &cir, &s2 );

        b2UpdateBroadPhasePairs( &world );
        Check( world.contacts.count == 3 );

        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        Check( aset->contactSims.count == 3 );

        // destroy the contact whose sim sits at slot 0 (a NON-last slot, so the
        // last sim must swap down into it and its owner's localIndex be repaired).
        int victimId = aset->contactSims.data[0].contactId;
        b2Contact* victim = &world.contacts.data[ victimId ];
        Check( victim->localIndex == 0 );
        int movedId = aset->contactSims.data[ aset->contactSims.count - 1 ].contactId;

        b2DestroyContact( &world, victim, true );
        Check( aset->contactSims.count == 2 );

        // the moved contact's sim now lives at slot 0 and round-trips through it
        b2Contact* moved = &world.contacts.data[ movedId ];
        Check( moved->localIndex == 0 );
        Check( b2GetContactSim( &world, moved )->contactId == movedId );
        // victim's handle fully released
        Check( victim->localIndex == B2_NULL_INDEX );
        Check( victim->setIndex == B2_NULL_INDEX );

        b2DestroyWorld( &world );
    }

    // ----- contacts slice B: narrow phase (dispatch + flip + marshalling) -----

    // (1) primary-order predicate -- locks the segment-OUTRANKS-polygon ordering.
    //     primary <=> rank(A) >= rank(B), rank{circle0,capsule1,polygon2,segment3,chain4}
    Check( b2IsPrimaryOrder( b2_circleShape,  b2_circleShape )  == true );
    Check( b2IsPrimaryOrder( b2_capsuleShape, b2_circleShape )  == true );
    Check( b2IsPrimaryOrder( b2_circleShape,  b2_capsuleShape ) == false );
    Check( b2IsPrimaryOrder( b2_capsuleShape, b2_capsuleShape ) == true );
    Check( b2IsPrimaryOrder( b2_polygonShape, b2_circleShape )  == true );
    Check( b2IsPrimaryOrder( b2_circleShape,  b2_polygonShape ) == false );
    Check( b2IsPrimaryOrder( b2_polygonShape, b2_capsuleShape ) == true );
    Check( b2IsPrimaryOrder( b2_capsuleShape, b2_polygonShape ) == false );
    Check( b2IsPrimaryOrder( b2_polygonShape, b2_polygonShape ) == true );
    Check( b2IsPrimaryOrder( b2_segmentShape, b2_polygonShape ) == true );   // segment > polygon
    Check( b2IsPrimaryOrder( b2_polygonShape, b2_segmentShape ) == false );  // the swap
    Check( b2IsPrimaryOrder( b2_segmentShape, b2_circleShape )  == true );
    Check( b2IsPrimaryOrder( b2_segmentShape, b2_capsuleShape ) == true );
    Check( b2IsPrimaryOrder( b2_chainSegmentShape, b2_polygonShape ) == true );
    Check( b2IsPrimaryOrder( b2_polygonShape, b2_chainSegmentShape ) == false );

    // (2) flip integration: create a polygon-vs-circle contact with the shapes
    //     passed circle-FIRST (non-primary). b2CreateContact must store polygon as A.
    {
        b2World world;
        b2CreateWorld( &world );
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId bp;  b2CreateBody( &world, &bdef, &bp );
        b2ShapeId sp;  b2CreatePolygonShape( &world, &bp, &sdef, &box, &sp );

        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 0.5;
        bdef.position.x = 0.6;  bdef.position.y = 0.0;
        b2BodyId bc;  b2CreateBody( &world, &bdef, &bc );
        b2ShapeId sc;  b2CreateCircleShape( &world, &bc, &sdef, &cir, &sc );

        int polyId = sp.index1 - 1;
        int circId = sc.index1 - 1;
        b2Shape* shP = &world.shapes.data[ polyId ];
        b2Shape* shC = &world.shapes.data[ circId ];

        // pass circle first -> the flip must reorder to polygon-first
        b2CreateContact( &world, shC, shP );
        b2Contact* c = &world.contacts.data[0];
        Check( c->shapeIdA == polyId );   // polygon stored as A despite circle-first call
        Check( c->shapeIdB == circId );

        b2DestroyWorld( &world );
    }

    // (3) marshalling: b2UpdateContact is world-free, so drive it with stack shapes.
    {
        b2Shape shA;  shA.type = b2_circleShape;
        shA.circle.center.x = 0.0;  shA.circle.center.y = 0.0;  shA.circle.radius = 1.0;
        b2Shape shB;  shB.type = b2_circleShape;
        shB.circle.center.x = 0.0;  shB.circle.center.y = 0.0;  shB.circle.radius = 1.0;

        b2ContactSim sim;
        b2Vec2 zero;  zero.x = 0.0;  zero.y = 0.0;

        // (3a) dispatch sanity: identity poses, centers 1.5 apart -> sep -0.5, n=(1,0)
        b2Transform tA;  tA.p.x = 0.0;  tA.p.y = 0.0;  tA.q = b2Rot_identity;
        b2Transform tB;  tB.p.x = 1.5;  tB.p.y = 0.0;  tB.q = b2Rot_identity;
        memset( &sim, 0, sizeof( b2ContactSim ) );
        bool touching = b2UpdateContact( &sim, &shA, &tA, &zero, &shB, &tB, &zero );
        Check( touching == true );
        Check( sim.manifold.pointCount == 1 );
        Check( feq( sim.manifold.normal.x, 1.0 ) && feq( sim.manifold.normal.y, 0.0 ) );
        Check( feq( sim.manifold.points[0].separation, -0.5 ) );
        Check( ( sim.simFlags & b2_simTouchingFlag ) != 0 );

        // (3b) marshalling math: rotation on A + nonzero center offsets, cross-checked
        //      against the green primitive (exercises rotate / originDelta / com-shift).
        b2Rot qA;  b2MakeRot( 0.5, &qA );
        tA.p.x = 3.0;  tA.p.y = -2.0;  tA.q = qA;
        tB.p.x = 4.2;  tB.p.y = -1.0;  tB.q = b2Rot_identity;
        b2Vec2 offA;  offA.x = 0.3;  offA.y = 0.1;
        b2Vec2 offB;  offB.x = -0.2; offB.y = 0.4;
        memset( &sim, 0, sizeof( b2ContactSim ) );
        b2UpdateContact( &sim, &shA, &tA, &offA, &shB, &tB, &offB );

        b2Transform rel;     b2InvMulTransforms( &tA, &tB, &rel );
        b2LocalManifold lm;  lm.pointCount = 0;
        b2CollideCircles( &shA.circle, &shB.circle, &rel, &lm );
        Check( sim.manifold.pointCount == lm.pointCount );

        b2Vec2 expN;  b2RotateVector( &qA, &lm.normal, &expN );
        Check( feq( sim.manifold.normal.x, expN.x ) && feq( sim.manifold.normal.y, expN.y ) );

        b2Vec2 ra;     b2RotateVector( &qA, &lm.points[0].point, &ra );
        b2Vec2 expAA;  b2Sub( &ra, &offA, &expAA );
        Check( feq( sim.manifold.points[0].anchorA.x, expAA.x ) &&
               feq( sim.manifold.points[0].anchorA.y, expAA.y ) );

        b2Vec2 od;     b2Sub( &tA.p, &tB.p, &od );
        b2Vec2 rb;     b2Add( &ra, &od, &rb );
        b2Vec2 expAB;  b2Sub( &rb, &offB, &expAB );
        Check( feq( sim.manifold.points[0].anchorB.x, expAB.x ) &&
               feq( sim.manifold.points[0].anchorB.y, expAB.y ) );
        Check( feq( sim.manifold.points[0].separation, lm.points[0].separation ) );

        // (3c) non-touching: separate far -> touching false, count 0, flag cleared
        tB.p.x = 50.0;  tB.p.y = 0.0;  tB.q = b2Rot_identity;
        sim.simFlags = b2_simTouchingFlag;            // pre-set to prove it clears
        bool t2 = b2UpdateContact( &sim, &shA, &tA, &zero, &shB, &tB, &zero );
        Check( t2 == false );
        Check( sim.manifold.pointCount == 0 );
        Check( ( sim.simFlags & b2_simTouchingFlag ) == 0 );
    }

    // ----- contacts slice C: narrow-phase step loop (b2Collide) -----
    // dynamic circle overlapping a STATIC circle ("ball on floor") -- this also
    // exercises the static-body bodySimIndex=NULL branch + b2GetBodySim on the
    // static set (an all-dynamic pair would never hit it).
    {
        b2World world;
        b2CreateWorld( &world );
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 1.0;
        b2BodyDef bdef;

        b2DefaultBodyDef( &bdef );  bdef.type = b2_staticBody;
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId bs;  b2CreateBody( &world, &bdef, &bs );
        b2ShapeId ss;  b2CreateCircleShape( &world, &bs, &sdef, &cir, &ss );

        b2DefaultBodyDef( &bdef );  bdef.type = b2_dynamicBody;
        bdef.position.x = 1.5;  bdef.position.y = 0.0;
        b2BodyId bd;  b2CreateBody( &world, &bdef, &bd );
        b2ShapeId sd;  b2CreateCircleShape( &world, &bd, &sdef, &cir, &sd );

        // dynamic proxy queries the static tree -> exactly one contact, non-touching
        b2UpdateBroadPhasePairs( &world );
        Check( world.contacts.count == 1 );
        b2Contact* c = &world.contacts.data[0];
        Check( ( c->flags & b2_contactTouchingFlag ) == 0 );
        b2ContactSim* csim = b2GetContactSim( &world, c );
        Check( csim->manifold.pointCount == 0 );

        // narrow phase: contact starts touching, manifold computed
        b2Collide( &world );
        Check( ( c->flags & b2_contactTouchingFlag ) != 0 );    // started touching
        csim = b2GetContactSim( &world, c );
        Check( csim->manifold.pointCount == 1 );
        Check( ( csim->simFlags & b2_simTouchingFlag ) != 0 );
        Check( feq( csim->manifold.points[0].separation, -0.5 ) );        // 1.5 - 1 - 1
        Check( feq( csim->manifold.points[0].baseSeparation, -0.5 ) );    // cached for next step

        // exactly one body is static: invMass 0 + bodySimIndex NULL (proves the
        // NULL branch ran and b2GetBodySim read a valid transform from the static set)
        bool aStatic = csim->bodySimIndexA == B2_NULL_INDEX;
        bool bStatic = csim->bodySimIndexB == B2_NULL_INDEX;
        Check( aStatic != bStatic );
        if( aStatic )
            Check( feq( csim->invMassA, 0.0 ) && csim->invMassB > 0.0 );
        else
            Check( feq( csim->invMassB, 0.0 ) && csim->invMassA > 0.0 );

        // move the dynamic body far away -> fat AABBs disjoint -> the contact is
        // DESTROYED by b2Collide (P0.2 2026-07-07, upstream b2_simDisjoint path).
        // CONTRACT CHANGE: this check originally asserted the contact was KEPT
        // non-touching (the old no-disjoint-destroy deviation); do NOT call
        // b2GetContactSim on c after this -- the handle is freed.
        b2Vec2 faraway;  faraway.x = 50.0;  faraway.y = 0.0;
        b2Body_SetTransform( &world, &bd, &faraway, &b2Rot_identity );
        b2Collide( &world );
        Check( c->contactId == B2_NULL_INDEX );                 // slot freed
        Check( b2GetIdCount( &world.contactIdPool ) == 0 );     // id returned to the pool
        b2SolverSet* aset = &world.solverSets.data[ b2_awakeSet ];
        Check( aset->contactSims.count == 0 );                  // sim removed from the awake set
        b2Body* bodyD = b2GetBodyFullId( &world, &bd );
        Check( bodyD->headContactKey == B2_NULL_INDEX && bodyD->contactCount == 0 );

        b2DestroyWorld( &world );
    }

    // ----- solver slice 1: time integration (free bodies move) -----

    // (1) linear fall: centered circle, gravity only, cross-checked against an
    //     in-harness semi-implicit Euler reference (the same discrete scheme).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 1.0;
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.linearDamping = 0.0;  bdef.angularDamping = 0.0;  bdef.gravityScale = 1.0;
        bdef.position.x = 0.0;  bdef.position.y = 5.0;
        b2BodyId bd;  b2CreateBody( &world, &bdef, &bd );
        b2ShapeId sd;  b2CreateCircleShape( &world, &bd, &sdef, &cir, &sd );

        float h = 0.1;  int N = 10;  int k;
        float vref = 0.0;  float pref = 5.0;
        for( k = 0; k < N; k++ ) { vref = vref + ( -10.0 ) * h;  pref = pref + vref * h; }

        for( k = 0; k < N; k++ )  b2World_Step( &world, h, 1 );

        b2Body* body = b2GetBodyFullId( &world, &bd );
        b2BodySim* bsim = b2GetBodySim( &world, body );
        b2BodyState* bst = b2GetBodyState( &world, body );
        Check( feq( bsim->center.y, pref ) );
        Check( feq( bsim->transform.p.y, pref ) );      // localCenter 0 => p == center
        Check( feq( bsim->center.x, 0.0 ) );
        Check( feq( bst->linearVelocity.y, vref ) );

        b2DestroyWorld( &world );
    }

    // (2) pure rotation: initial angular velocity, no gravity/damping/torque -> w
    //     constant; transform.q must match a reference built with the SAME
    //     b2IntegrateRotation primitive (a normalized approximation).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;

        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 1.0;
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.gravityScale = 0.0;  bdef.angularDamping = 0.0;
        bdef.angularVelocity = 2.0;
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId bd;  b2CreateBody( &world, &bdef, &bd );
        b2ShapeId sd;  b2CreateCircleShape( &world, &bd, &sdef, &cir, &sd );

        float h = 0.05;  int N = 8;  int k;
        b2Rot qref = b2Rot_identity;     // mirror the engine: dR from identity, compose, normalize
        for( k = 0; k < N; k++ )
        {
            b2Rot dR;    b2IntegrateRotation( &b2Rot_identity, h * 2.0, &dR );
            b2Rot comp;  b2MulRot( &dR, &qref, &comp );
            b2Rot nq;    b2NormalizeRot( &comp, &nq );
            qref = nq;
        }

        for( k = 0; k < N; k++ )  b2World_Step( &world, h, 1 );

        b2Body* body = b2GetBodyFullId( &world, &bd );
        b2BodySim* bsim = b2GetBodySim( &world, body );
        Check( feq( bsim->transform.q.c, qref.c ) && feq( bsim->transform.q.s, qref.s ) );
        Check( feq( bsim->transform.p.x, 0.0 ) && feq( bsim->transform.p.y, 0.0 ) );  // no translation

        b2DestroyWorld( &world );
    }

    // (3) offset COM: localCenter != 0 makes the finalize line
    //     transform.p = center - rotate(q, localCenter) load-bearing (q stays identity).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.5; cir.radius = 1.0;   // offset COM
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.linearDamping = 0.0;  bdef.gravityScale = 1.0;
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId bd;  b2CreateBody( &world, &bdef, &bd );
        b2ShapeId sd;  b2CreateCircleShape( &world, &bd, &sdef, &cir, &sd );

        b2Body* body = b2GetBodyFullId( &world, &bd );
        b2BodySim* bsim = b2GetBodySim( &world, body );
        Check( feq( bsim->localCenter.y, 0.5 ) );   // single offset circle -> COM at its center
        Check( feq( bsim->center.y, 0.5 ) );        // origin 0 + localCenter
        Check( feq( bsim->transform.p.y, 0.0 ) );   // origin

        float h = 0.1;  int N = 10;  int k;
        float vref = 0.0;  float pref = 0.5;        // COM starts at 0.5
        for( k = 0; k < N; k++ ) { vref = vref + ( -10.0 ) * h;  pref = pref + vref * h; }

        for( k = 0; k < N; k++ )  b2World_Step( &world, h, 1 );

        bsim = b2GetBodySim( &world, body );
        Check( feq( bsim->center.y, pref ) );                       // COM fell
        Check( feq( bsim->transform.p.y, bsim->center.y - 0.5 ) );  // origin trails COM by localCenter

        b2DestroyWorld( &world );
    }

    // ----- solver slice 2: b2World_Step pipeline (collide + move-proxy wired) -----

    // (a) a stepped body's broad-phase proxy follows it (b2FinalizeBodies MoveProxy)
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;   // move by velocity only

        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 1.0;
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );
        bdef.type = b2_dynamicBody;
        bdef.linearVelocity.x = 50.0;  bdef.linearVelocity.y = 0.0;
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId bd;  b2CreateBody( &world, &bdef, &bd );
        b2ShapeId sd;  b2CreateCircleShape( &world, &bd, &sdef, &cir, &sd );

        b2World_Step( &world, 0.1, 1 );    // body center -> x = 5

        b2Shape* shape = &world.shapes.data[ sd.index1 - 1 ];
        int ptype = B2_PROXY_TYPE( shape->proxyKey );
        int pid   = B2_PROXY_ID( shape->proxyKey );
        b2AABB pa;  b2DynamicTree_GetAABB( &world.broadPhase.trees[ ptype ], pid, &pa );
        Check( pa.lowerBound.x <= 5.0 && pa.upperBound.x >= 5.0 );   // proxy contains new pos
        Check( pa.lowerBound.x > 0.5 );                              // and left the origin

        b2DestroyWorld( &world );
    }

    // (b) a body moving into another forms a contact ONE step after the proxies
    //     first overlap (pairing runs before the move), then collide makes it touch.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = 0.0;

        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 1.0;
        b2BodyDef bdef;  b2DefaultBodyDef( &bdef );

        // stationary target at (2.5, 0)
        bdef.type = b2_dynamicBody;
        bdef.linearVelocity.x = 0.0;  bdef.linearVelocity.y = 0.0;
        bdef.position.x = 2.5;  bdef.position.y = 0.0;
        b2BodyId bt;  b2CreateBody( &world, &bdef, &bt );
        b2ShapeId st;  b2CreateCircleShape( &world, &bt, &sdef, &cir, &st );

        // mover at origin heading right at +1 unit/step
        bdef.linearVelocity.x = 10.0;  bdef.linearVelocity.y = 0.0;
        bdef.position.x = 0.0;  bdef.position.y = 0.0;
        b2BodyId bm;  b2CreateBody( &world, &bdef, &bm );
        b2ShapeId sm;  b2CreateCircleShape( &world, &bm, &sdef, &cir, &sm );

        Check( world.contacts.count == 0 );        // far apart, no overlap

        b2World_Step( &world, 0.1, 1 );            // pairing(no overlap) then mover -> x=1
        Check( world.contacts.count == 0 );        // pairing ran before the move

        b2World_Step( &world, 0.1, 1 );            // pairing now sees the overlap -> contact
        Check( world.contacts.count == 1 );
        b2Contact* c = &world.contacts.data[0];
        Check( ( c->flags & b2_contactTouchingFlag ) != 0 );   // collide made it touching

        b2DestroyWorld( &world );
    }

    // ----- solver slice 3: contact constraint solve (a circle rests on a floor) -----
    // The solver has no clean closed form, so assert INVARIANTS, with a free-fall
    // control body (no floor) to guard against "the solver just zeros velocity".
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        // static box floor at origin: spans y[-0.5, 0.5], top at y = 0.5
        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        // dynamic circle radius 0.5 dropped from y = 2.0 -> should rest at y ~ 1.0
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 0.5;
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.linearDamping = 0.0;  cdef.gravityScale = 1.0;
        cdef.position.x = 0.0;  cdef.position.y = 2.0;
        b2BodyId bc;  b2CreateBody( &world, &cdef, &bc );
        b2ShapeId sc;  b2CreateCircleShape( &world, &bc, &sdef, &cir, &sc );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 120; k++ )  b2World_Step( &world, dt, 4 );

        b2Body* body = b2GetBodyFullId( &world, &bc );
        b2BodySim* bsim = b2GetBodySim( &world, body );
        b2BodyState* bst = b2GetBodyState( &world, body );
        diagRestY = bsim->center.y;
        diagRestVy = bst->linearVelocity.y;
        Check( bsim->center.y < 1.5 );                 // it fell
        Check( bsim->center.y > 0.85 );                // didn't sink through the floor
        Check( bsim->center.y < 2.01 );                // didn't launch above the start
        Check( fabs( bst->linearVelocity.y ) < 0.5 );  // settled (came to rest)

        b2DestroyWorld( &world );

        // control: same circle, NO floor -> keeps falling far below the rest height
        b2World w2;  b2CreateWorld( &w2 );
        w2.gravity.x = 0.0;  w2.gravity.y = -10.0;
        b2ShapeDef sd2;  b2DefaultShapeDef( &sd2 );
        b2Circle c2;  c2.center.x = 0.0; c2.center.y = 0.0; c2.radius = 0.5;
        b2BodyDef cd2;  b2DefaultBodyDef( &cd2 );  cd2.type = b2_dynamicBody;
        cd2.position.x = 0.0;  cd2.position.y = 2.0;
        b2BodyId bc2;  b2CreateBody( &w2, &cd2, &bc2 );
        b2ShapeId sc2;  b2CreateCircleShape( &w2, &bc2, &sd2, &c2, &sc2 );

        for( k = 0; k < 120; k++ )  b2World_Step( &w2, dt, 4 );

        b2Body* body2 = b2GetBodyFullId( &w2, &bc2 );
        b2BodySim* bsim2 = b2GetBodySim( &w2, body2 );
        diagCtrlY = bsim2->center.y;
        Check( bsim2->center.y < -5.0 );               // no floor -> kept falling

        b2DestroyWorld( &w2 );
    }

    // ----- solver slice 4: friction (a sliding box is braked by the floor) -----
    // Also the FIRST 2-point (box-on-box polygon) manifold solved under load.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon floorBox;  b2MakeBox( 20.0, 0.5, &floorBox );   // long floor, top at 0.5
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );              // rests with center at y=1.0
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.linearDamping = 0.0;
        cdef.position.x = 0.0;  cdef.position.y = 1.05;
        cdef.linearVelocity.x = 5.0;  cdef.linearVelocity.y = 0.0;
        b2BodyId bb;  b2CreateBody( &world, &cdef, &bb );
        b2ShapeId sb;  b2CreatePolygonShape( &world, &bb, &sdef, &box, &sb );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 150; k++ )  b2World_Step( &world, dt, 4 );

        b2Body* body = b2GetBodyFullId( &world, &bb );
        b2BodyState* bst = b2GetBodyState( &world, body );
        b2BodySim* bsim = b2GetBodySim( &world, body );
        diagFricVx = bst->linearVelocity.x;
        Check( fabs( bst->linearVelocity.x ) < 0.5 );   // friction braked the slide
        Check( bsim->center.y > 0.85 );                 // still resting on the floor (2-pt manifold)

        b2DestroyWorld( &world );

        // control: same box + horizontal velocity but NO floor -> no contact, no
        // friction -> horizontal velocity is preserved (only gravity acts on y).
        b2World w2;  b2CreateWorld( &w2 );
        w2.gravity.x = 0.0;  w2.gravity.y = -10.0;
        b2ShapeDef sd2;  b2DefaultShapeDef( &sd2 );
        b2Polygon box2;  b2MakeBox( 0.5, 0.5, &box2 );
        b2BodyDef cd2;  b2DefaultBodyDef( &cd2 );  cd2.type = b2_dynamicBody;
        cd2.linearDamping = 0.0;
        cd2.position.x = 0.0;  cd2.position.y = 1.05;
        cd2.linearVelocity.x = 5.0;  cd2.linearVelocity.y = 0.0;
        b2BodyId bb2;  b2CreateBody( &w2, &cd2, &bb2 );
        b2ShapeId sb2;  b2CreatePolygonShape( &w2, &bb2, &sd2, &box2, &sb2 );

        for( k = 0; k < 150; k++ )  b2World_Step( &w2, dt, 4 );

        b2Body* body2 = b2GetBodyFullId( &w2, &bb2 );
        b2BodyState* bst2 = b2GetBodyState( &w2, body2 );
        diagFricCtrlVx = bst2->linearVelocity.x;
        Check( bst2->linearVelocity.x > 4.5 );          // no friction -> vx preserved

        b2DestroyWorld( &w2 );
    }

    // ----- b2Atan2 degenerate-input guard (hardware atan2 faults on (0,0)) -----
    // The guard must return 0 for (0,0) instead of faulting the CPU, and stay
    // correct for ordinary inputs.
    Check( feq( b2Atan2( 0.0, 0.0 ), 0.0 ) );          // guarded degenerate case
    Check( feq( b2Atan2( 1.0, 0.0 ), B2_PI / 2.0 ) );  // +y axis
    Check( feq( b2Atan2( 0.0, 1.0 ), 0.0 ) );          // +x axis
    Check( feq( b2Atan2( 1.0, 1.0 ), B2_PI / 4.0 ) );  // 45 deg
    // b2Rot_GetAngle of a zeroed rot would hit atan2(0,0); must not fault
    {
        b2Rot zr;  zr.c = 0.0;  zr.s = 0.0;
        Check( feq( b2Rot_GetAngle( &zr ), 0.0 ) );
    }

    // ----- solver slice 5: restitution (a ball bounces back off the floor) -----
    // A transient, not a steady state: track the PEAK height reached after first
    // impact, and compare against a restitution=0 control that must not rebound.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;

        // static floor, top at y = 0.5
        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeDef sfd;  b2DefaultShapeDef( &sfd );  sfd.restitution = 0.8;
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sfd, &floorBox, &sf );

        // bouncy circle radius 0.5 dropped from y = 2.0 (rest height ~1.0)
        b2Circle cir;  cir.center.x = 0.0; cir.center.y = 0.0; cir.radius = 0.5;
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.position.x = 0.0;  cdef.position.y = 2.0;
        b2ShapeDef scd;  b2DefaultShapeDef( &scd );  scd.restitution = 0.8;
        b2BodyId bc;  b2CreateBody( &world, &cdef, &bc );
        b2ShapeId sc;  b2CreateCircleShape( &world, &bc, &scd, &cir, &sc );

        b2Body* body = b2GetBodyFullId( &world, &bc );
        b2BodySim* bsim = b2GetBodySim( &world, body );

        float dt = 1.0 / 60.0;  int k;
        float peak = 0.0;  bool impacted = false;
        for( k = 0; k < 120; k++ )
        {
            b2World_Step( &world, dt, 4 );
            float y = bsim->center.y;
            if( y < 1.05 ) impacted = true;              // reached the floor
            if( impacted && y > peak ) peak = y;         // rebound apex after impact
        }
        diagBouncePeak = peak;
        Check( peak > 1.20 );   // it bounced back up well above rest height
        Check( peak < 1.80 );   // but not more than the ~0.64 rebound + slop

        b2DestroyWorld( &world );

        // control: restitution 0 -> no bounce, never rises above the rest height
        b2World w2;  b2CreateWorld( &w2 );
        w2.gravity.x = 0.0;  w2.gravity.y = -10.0;
        b2Polygon fb2;  b2MakeBox( 5.0, 0.5, &fb2 );
        b2BodyDef fd2;  b2DefaultBodyDef( &fd2 );  fd2.type = b2_staticBody;
        fd2.position.x = 0.0;  fd2.position.y = 0.0;
        b2BodyId bf2;  b2CreateBody( &w2, &fd2, &bf2 );
        b2ShapeDef sfd2;  b2DefaultShapeDef( &sfd2 );   // restitution 0
        b2ShapeId sf2;  b2CreatePolygonShape( &w2, &bf2, &sfd2, &fb2, &sf2 );

        b2Circle c2;  c2.center.x = 0.0; c2.center.y = 0.0; c2.radius = 0.5;
        b2BodyDef cd2;  b2DefaultBodyDef( &cd2 );  cd2.type = b2_dynamicBody;
        cd2.position.x = 0.0;  cd2.position.y = 2.0;
        b2ShapeDef scd2;  b2DefaultShapeDef( &scd2 );   // restitution 0
        b2BodyId bc2;  b2CreateBody( &w2, &cd2, &bc2 );
        b2ShapeId sc2;  b2CreateCircleShape( &w2, &bc2, &scd2, &c2, &sc2 );

        b2Body* body2 = b2GetBodyFullId( &w2, &bc2 );
        b2BodySim* bsim2 = b2GetBodySim( &w2, body2 );

        float peak2 = 0.0;  bool impacted2 = false;
        for( k = 0; k < 120; k++ )
        {
            b2World_Step( &w2, dt, 4 );
            float y = bsim2->center.y;
            if( y < 1.05 ) impacted2 = true;
            if( impacted2 && y > peak2 ) peak2 = y;
        }
        diagBounceCtrl = peak2;
        Check( peak2 < 1.10 );   // no restitution -> no rebound above rest

        b2DestroyWorld( &w2 );
    }

    // ----- solver slice 6a: a tilted box settles LEVEL on a 2-point manifold -----
    // Give the box an initial spin; the two floor contact points must apply a
    // restoring torque so it comes to rest flat (a 1-point manifold couldn't).
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );   // top at y = 0.5
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );             // rests with center at y=1.0
        b2BodyDef cdef;  b2DefaultBodyDef( &cdef );  cdef.type = b2_dynamicBody;
        cdef.position.x = 0.0;  cdef.position.y = 1.10;
        cdef.angularVelocity = 1.5;                              // initial spin to be damped
        b2BodyId bb;  b2CreateBody( &world, &cdef, &bb );
        b2ShapeId sb;  b2CreatePolygonShape( &world, &bb, &sdef, &box, &sb );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 180; k++ )  b2World_Step( &world, dt, 4 );

        b2Body* body = b2GetBodyFullId( &world, &bb );
        b2BodySim* bsim = b2GetBodySim( &world, body );
        b2BodyState* bst = b2GetBodyState( &world, body );
        diagLevelS = bsim->transform.q.s;
        Check( bsim->center.y > 0.9 && bsim->center.y < 1.1 );   // rests at the right height
        Check( fabs( bsim->transform.q.s ) < 0.08 );             // came to rest LEVEL (sin ~ 0)
        Check( fabs( bst->angularVelocity ) < 0.3 );             // spin damped out

        b2DestroyWorld( &world );
    }

    // ----- solver slice 6b: a 2-box stack settles without sinking (dyn-on-dyn) -----
    // Exercises dynamic-dynamic contacts + the 2-point unroll under real load.
    {
        b2World world;  b2CreateWorld( &world );
        world.gravity.x = 0.0;  world.gravity.y = -10.0;
        b2ShapeDef sdef;  b2DefaultShapeDef( &sdef );

        b2Polygon floorBox;  b2MakeBox( 5.0, 0.5, &floorBox );   // top at y = 0.5
        b2BodyDef fdef;  b2DefaultBodyDef( &fdef );  fdef.type = b2_staticBody;
        fdef.position.x = 0.0;  fdef.position.y = 0.0;
        b2BodyId bf;  b2CreateBody( &world, &fdef, &bf );
        b2ShapeId sf;  b2CreatePolygonShape( &world, &bf, &sdef, &floorBox, &sf );

        b2Polygon box;  b2MakeBox( 0.5, 0.5, &box );             // 1x1 boxes

        // box A rests on the floor (center ~1.0); box B rests on A (center ~2.0)
        b2BodyDef ad;  b2DefaultBodyDef( &ad );  ad.type = b2_dynamicBody;
        ad.position.x = 0.0;  ad.position.y = 1.10;
        b2BodyId ba;  b2CreateBody( &world, &ad, &ba );
        b2ShapeId sa;  b2CreatePolygonShape( &world, &ba, &sdef, &box, &sa );

        b2BodyDef bd;  b2DefaultBodyDef( &bd );  bd.type = b2_dynamicBody;
        bd.position.x = 0.0;  bd.position.y = 2.15;
        b2BodyId bbID;  b2CreateBody( &world, &bd, &bbID );
        b2ShapeId sbID;  b2CreatePolygonShape( &world, &bbID, &sdef, &box, &sbID );

        float dt = 1.0 / 60.0;  int k;
        for( k = 0; k < 240; k++ )  b2World_Step( &world, dt, 4 );

        b2Body* bodyA = b2GetBodyFullId( &world, &ba );
        b2BodySim* simA = b2GetBodySim( &world, bodyA );
        b2Body* bodyB = b2GetBodyFullId( &world, &bbID );
        b2BodySim* simB = b2GetBodySim( &world, bodyB );
        diagStackAY = simA->center.y;
        diagStackBY = simB->center.y;

        Check( simA->center.y > 0.85 && simA->center.y < 1.15 );  // A rests on floor
        Check( simB->center.y > 1.75 && simB->center.y < 2.20 );  // B rests on A (didn't sink through)
        Check( simB->center.y - simA->center.y > 0.85 );          // boxes stay separated (~1.0 apart)
        Check( fabs( simA->transform.q.s ) < 0.10 );              // A level
        Check( fabs( simB->transform.q.s ) < 0.10 );              // B level

        b2DestroyWorld( &world );
    }

    // ----- validity -----
    Check( b2IsValidFloat( 5.0 ) == true );
    a.x = 1.0; a.y = 2.0;
    Check( b2IsValidVec2( &a ) == true );
    q.c = 0.0; q.s = 1.0;
    Check( b2IsValidRotation( &q ) == true );
    q.c = 3.0; q.s = 4.0;
    Check( b2IsValidRotation( &q ) == false );

    // ----- verdict -----
    if( AllPassed )
    {
        clear_screen( color_green );
    }
    else
    {
        // red screen + the 1-based index of the first failed check, and the
        // total number of checks, so failures can be pinpointed without bisection
        clear_screen( color_red );
        print_at(  60, 100, "FIRST FAIL CHECK #" );
        ShowInt(  280, 100, firstFail );
        print_at(  60, 130, "TOTAL CHECKS" );
        ShowInt(  280, 130, checkNum );
        // solver resting-test diagnostics (meaningful when a solver check failed)
        // left column: earlier solver diagnostics
        print_at(  60, 170, "REST Y" );      ShowFloat( 240, 170, diagRestY );
        print_at(  60, 200, "REST VY" );     ShowFloat( 240, 200, diagRestVy );
        print_at(  60, 230, "CTRL Y" );      ShowFloat( 240, 230, diagCtrlY );
        print_at(  60, 260, "FRIC VX" );     ShowFloat( 240, 260, diagFricVx );
        print_at(  60, 290, "FRIC CTRL" );   ShowFloat( 240, 290, diagFricCtrlVx );
        print_at(  60, 320, "BOUNCE PEAK" ); ShowFloat( 240, 320, diagBouncePeak );
        print_at(  60, 350, "BOUNCE CTRL" ); ShowFloat( 240, 350, diagBounceCtrl );
        // right column: this slice's stacking/level diagnostics
        print_at( 380, 170, "STACK AY" );    ShowFloat( 540, 170, diagStackAY );
        print_at( 380, 200, "STACK BY" );    ShowFloat( 540, 200, diagStackBY );
        print_at( 380, 230, "LEVEL S" );     ShowFloat( 540, 230, diagLevelS );
    }
}
