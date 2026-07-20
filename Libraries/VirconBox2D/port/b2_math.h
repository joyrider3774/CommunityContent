/* *****************************************************************************
*  VirconBox2D : b2_math.h            (port of Box2D v3 include/box2d/math_functions.h)
*  --------------------------------------------------------------------------- *
*  Vircon32-dialect port of the Box2D vector/rotation/transform math.          *
*                                                                              *
*  Porting rules applied (see VIRCON32_C_DIALECT.md):                          *
*   - Structs are > 1 word, so they can NEVER cross a function boundary by     *
*     value. Every function that upstream returned a b2Vec2/b2Rot/b2Transform  *
*     now takes a result OUT-pointer as its LAST argument and returns void,    *
*     mirroring the official vector2d.h idiom: f( const in*, ..., out* ).      *
*   - Scalars (float/bool/int) are 1 word, so they are still returned by value.*
*   - No ternary ?: ............ rewritten as if/else.                         *
*   - No compound literals ..... rewritten as a named temp + field assigns.    *
*   - sqrtf->sqrt, fabsf->fabs, fminf->fmin, etc. (the console math.h names).  *
*   - B2_ASSERT / validation .. omitted in this slice (added later).          *
*   - Single precision only: b2Pos == b2Vec2 (no BOX2D_DOUBLE_PRECISION).      *
*                                                                              *
*  SLICE 1: core vector + rotation ops needed by everything else. This is a    *
*  partial port; remaining functions are added incrementally and verified.     *
***************************************************************************** */

// *****************************************************************************
    // start include guard
    #ifndef B2_MATH_H
    #define B2_MATH_H

    #include "math.h"
// *****************************************************************************


// float limits (the console has no <float.h>; built without sci-notation literals)
//
// CRITICAL DIALECT TRAP: this compiler's lexer AND its constant folder underflow any
// float value smaller than ~1e-6 to exactly 0.0 -- so `0.00000011920929`, and even the
// folded `1.0/8388608.0`, both emit 0x00000000. Tiny constants must therefore be produced
// by a RUNTIME division whose divisor is a GLOBAL (which the compiler cannot fold).
// 8388608 = 2^23, so 1.0 / 2^23 = 2^-23 = the true single-precision epsilon (1.1920929e-7).
float b2_two_pow_23 = 8388608.0;
#define FLT_EPSILON ( 1.0 / b2_two_pow_23 )

// ~1e36, safely below the true FLT_MAX (3.4e38); large multiplication folds fine (no underflow)
#define FLT_MAX ( 1000000000000000000.0 * 1000000000000000000.0 )


// =============================================================================
//   TYPES
// =============================================================================


// 2D vector (point or free vector)
struct b2Vec2
{
    float x, y;
};

// 2D rotation, stored as cosine/sine (like a unit complex number)
struct b2Rot
{
    float c, s;
};

// 2D rigid transform: rotation q applied, then translation p
struct b2Transform
{
    b2Vec2 p;
    b2Rot q;
};

// 2-by-2 matrix, stored by columns
struct b2Mat22
{
    b2Vec2 cx, cy;
};

// axis-aligned bounding box
struct b2AABB
{
    b2Vec2 lowerBound;
    b2Vec2 upperBound;
};


// https://en.wikipedia.org/wiki/Pi
#define B2_PI 3.14159265359


// =============================================================================
//   SCALAR HELPERS  (1 word: still returned by value)
// =============================================================================


int b2MinInt( int a, int b )
{
    return min( a, b );
}

// ---------------------------------------------------------

int b2MaxInt( int a, int b )
{
    return max( a, b );
}

// ---------------------------------------------------------

int b2AbsInt( int a )
{
    return abs( a );
}

// ---------------------------------------------------------

int b2ClampInt( int a, int lower, int upper )
{
    if( a < lower ) return lower;
    if( a > upper ) return upper;
    return a;
}

// ---------------------------------------------------------

float b2MinFloat( float a, float b )
{
    return fmin( a, b );
}

// ---------------------------------------------------------

float b2MaxFloat( float a, float b )
{
    return fmax( a, b );
}

// ---------------------------------------------------------

float b2AbsFloat( float a )
{
    return fabs( a );
}

// ---------------------------------------------------------

float b2ClampFloat( float a, float lower, float upper )
{
    if( a < lower ) return lower;
    if( a > upper ) return upper;
    return a;
}


// =============================================================================
//   VECTOR PROPERTIES  (scalar results: by value)
// =============================================================================


float b2Dot( b2Vec2* a, b2Vec2* b )
{
    return a->x * b->x + a->y * b->y;
}

// ---------------------------------------------------------

// 2D cross product yields a scalar
float b2Cross( b2Vec2* a, b2Vec2* b )
{
    return a->x * b->y - a->y * b->x;
}

// ---------------------------------------------------------

float b2LengthSquared( b2Vec2* v )
{
    return v->x * v->x + v->y * v->y;
}

// ---------------------------------------------------------

float b2Length( b2Vec2* v )
{
    return sqrt( v->x * v->x + v->y * v->y );
}

// ---------------------------------------------------------

float b2DistanceSquared( b2Vec2* a, b2Vec2* b )
{
    float dx = b->x - a->x;
    float dy = b->y - a->y;
    return dx * dx + dy * dy;
}

// ---------------------------------------------------------

float b2Distance( b2Vec2* a, b2Vec2* b )
{
    float dx = b->x - a->x;
    float dy = b->y - a->y;
    return sqrt( dx * dx + dy * dy );
}


// =============================================================================
//   VECTOR ARITHMETIC  (struct results: OUT-pointer, last argument)
// =============================================================================


// result = a + b
void b2Add( b2Vec2* a, b2Vec2* b, b2Vec2* result )
{
    result->x = a->x + b->x;
    result->y = a->y + b->y;
}

// ---------------------------------------------------------

// result = a - b
void b2Sub( b2Vec2* a, b2Vec2* b, b2Vec2* result )
{
    result->x = a->x - b->x;
    result->y = a->y - b->y;
}

// ---------------------------------------------------------

// result = -a
void b2Neg( b2Vec2* a, b2Vec2* result )
{
    result->x = -a->x;
    result->y = -a->y;
}

// ---------------------------------------------------------

// result = s * v
void b2MulSV( float s, b2Vec2* v, b2Vec2* result )
{
    result->x = s * v->x;
    result->y = s * v->y;
}

// ---------------------------------------------------------

// result = a + s * b
void b2MulAdd( b2Vec2* a, float s, b2Vec2* b, b2Vec2* result )
{
    result->x = a->x + s * b->x;
    result->y = a->y + s * b->y;
}

// ---------------------------------------------------------

// result = a - s * b
void b2MulSub( b2Vec2* a, float s, b2Vec2* b, b2Vec2* result )
{
    result->x = a->x - s * b->x;
    result->y = a->y - s * b->y;
}

// ---------------------------------------------------------

// component-wise multiply: result = a * b
void b2Mul( b2Vec2* a, b2Vec2* b, b2Vec2* result )
{
    result->x = a->x * b->x;
    result->y = a->y * b->y;
}

// ---------------------------------------------------------

// left-pointing perpendicular: result = { -v.y, v.x }
void b2LeftPerp( b2Vec2* v, b2Vec2* result )
{
    float vx = v->x;
    float vy = v->y;
    result->x = -vy;
    result->y =  vx;
}

// ---------------------------------------------------------

// right-pointing perpendicular: result = { v.y, -v.x }
void b2RightPerp( b2Vec2* v, b2Vec2* result )
{
    float vx = v->x;
    float vy = v->y;
    result->x =  vy;
    result->y = -vx;
}

// ---------------------------------------------------------

// cross product of a vector and a scalar: result = { s*v.y, -s*v.x }
void b2CrossVS( b2Vec2* v, float s, b2Vec2* result )
{
    float vx = v->x;
    float vy = v->y;
    result->x =  s * vy;
    result->y = -s * vx;
}

// ---------------------------------------------------------

// cross product of a scalar and a vector: result = { -s*v.y, s*v.x }
void b2CrossSV( float s, b2Vec2* v, b2Vec2* result )
{
    float vx = v->x;
    float vy = v->y;
    result->x = -s * vy;
    result->y =  s * vx;
}

// ---------------------------------------------------------

// Is this vector a unit vector? Used to reject the degenerate normal b2Normalize
// hands back for a zero-length vector (e.g. GJK at exactly zero distance).
bool b2IsNormalized( b2Vec2* a )
{
    float aa = b2Dot( a, a );
    return b2AbsFloat( 1.0 - aa ) < 100.0 * FLT_EPSILON;
}

// ---------------------------------------------------------

// convert to unit vector; result is zero vector if length is ~0
void b2Normalize( b2Vec2* v, b2Vec2* result )
{
    float length = sqrt( v->x * v->x + v->y * v->y );

    if( length < FLT_EPSILON )
    {
        result->x = 0.0;
        result->y = 0.0;
        return;
    }

    float invLength = 1.0 / length;
    result->x = invLength * v->x;
    result->y = invLength * v->y;
}


// =============================================================================
//   ROTATIONS
// =============================================================================


// make a rotation from an angle in radians
// NOTE: Box2D uses a custom deterministic b2ComputeCosSin here; this slice uses
// the console's hardware sin/cos. Determinism parity is a later concern.
void b2MakeRot( float radians, b2Rot* result )
{
    result->c = cos( radians );
    result->s = sin( radians );
}

// ---------------------------------------------------------

// normalize a rotation back onto the unit circle
void b2NormalizeRot( b2Rot* q, b2Rot* result )
{
    float mag = sqrt( q->s * q->s + q->c * q->c );
    float invMag = 0.0;
    if( mag > 0.0 ) invMag = 1.0 / mag;
    result->c = q->c * invMag;
    result->s = q->s * invMag;
}

// ---------------------------------------------------------

// inverse rotation: result = { c, -s }
void b2InvertRot( b2Rot* a, b2Rot* result )
{
    result->c =  a->c;
    result->s = -a->s;
}

// ---------------------------------------------------------

// compose two rotations: result = q * r
void b2MulRot( b2Rot* q, b2Rot* r, b2Rot* result )
{
    // s(q+r) = qs*rc + qc*rs ;  c(q+r) = qc*rc - qs*rs
    float s = q->s * r->c + q->c * r->s;
    float c = q->c * r->c - q->s * r->s;
    result->s = s;
    result->c = c;
}

// ---------------------------------------------------------

// transpose-multiply: result = inv(a) * b
void b2InvMulRot( b2Rot* a, b2Rot* b, b2Rot* result )
{
    float s = a->c * b->s - a->s * b->c;
    float c = a->c * b->c + a->s * b->s;
    result->s = s;
    result->c = c;
}

// ---------------------------------------------------------

// rotate a vector: result = q * v
void b2RotateVector( b2Rot* q, b2Vec2* v, b2Vec2* result )
{
    float x = q->c * v->x - q->s * v->y;
    float y = q->s * v->x + q->c * v->y;
    result->x = x;
    result->y = y;
}

// ---------------------------------------------------------

// inverse-rotate a vector: result = inv(q) * v
void b2InvRotateVector( b2Rot* q, b2Vec2* v, b2Vec2* result )
{
    float x =  q->c * v->x + q->s * v->y;
    float y = -q->s * v->x + q->c * v->y;
    result->x = x;
    result->y = y;
}


// =============================================================================
//   TRANSFORMS
// =============================================================================


// transform a point: result = t.q * p + t.p   (local -> world)
void b2TransformPoint( b2Transform* t, b2Vec2* p, b2Vec2* result )
{
    float x = ( t->q.c * p->x - t->q.s * p->y ) + t->p.x;
    float y = ( t->q.s * p->x + t->q.c * p->y ) + t->p.y;
    result->x = x;
    result->y = y;
}

// ---------------------------------------------------------

// inverse-transform a point: world -> local
void b2InvTransformPoint( b2Transform* t, b2Vec2* p, b2Vec2* result )
{
    float vx = p->x - t->p.x;
    float vy = p->y - t->p.y;
    result->x =  t->q.c * vx + t->q.s * vy;
    result->y = -t->q.s * vx + t->q.c * vy;
}

// ---------------------------------------------------------

// compose transforms: result = A * B
void b2MulTransforms( b2Transform* A, b2Transform* B, b2Transform* result )
{
    b2MulRot( &A->q, &B->q, &result->q );
    b2Vec2 rotated;
    b2RotateVector( &A->q, &B->p, &rotated );
    b2Add( &rotated, &A->p, &result->p );
}

// ---------------------------------------------------------

// result = inv(A) * B
void b2InvMulTransforms( b2Transform* A, b2Transform* B, b2Transform* result )
{
    b2InvMulRot( &A->q, &B->q, &result->q );
    b2Vec2 d;
    b2Sub( &B->p, &A->p, &d );
    b2InvRotateVector( &A->q, &d, &result->p );
}


// =============================================================================
//   MORE VECTOR OPERATIONS  (component-wise; struct results -> OUT-pointer)
// =============================================================================


// result = (1-t)*a + t*b
void b2Lerp( b2Vec2* a, b2Vec2* b, float t, b2Vec2* result )
{
    result->x = ( 1.0 - t ) * a->x + t * b->x;
    result->y = ( 1.0 - t ) * a->y + t * b->y;
}

// ---------------------------------------------------------

void b2Abs( b2Vec2* a, b2Vec2* result )
{
    result->x = fabs( a->x );
    result->y = fabs( a->y );
}

// ---------------------------------------------------------

void b2Min( b2Vec2* a, b2Vec2* b, b2Vec2* result )
{
    result->x = fmin( a->x, b->x );
    result->y = fmin( a->y, b->y );
}

// ---------------------------------------------------------

void b2Max( b2Vec2* a, b2Vec2* b, b2Vec2* result )
{
    result->x = fmax( a->x, b->x );
    result->y = fmax( a->y, b->y );
}

// ---------------------------------------------------------

// component-wise clamp of v into [a, b]
void b2Clamp( b2Vec2* v, b2Vec2* a, b2Vec2* b, b2Vec2* result )
{
    result->x = b2ClampFloat( v->x, a->x, b->x );
    result->y = b2ClampFloat( v->y, a->y, b->y );
}

// ---------------------------------------------------------

// normalize v, also output its length through *length
void b2GetLengthAndNormalize( float* length, b2Vec2* v, b2Vec2* result )
{
    *length = sqrt( v->x * v->x + v->y * v->y );

    if( *length < FLT_EPSILON )
    {
        result->x = 0.0;
        result->y = 0.0;
        return;
    }

    float invLength = 1.0 / *length;
    result->x = invLength * v->x;
    result->y = invLength * v->y;
}


// =============================================================================
//   MORE ROTATIONS / ANGLES
// =============================================================================


// arctangent, range [-pi, pi].
// NOTE: Box2D ships a custom deterministic b2Atan2; this slice forwards to the
// console's hardware atan2. Centralized here so a deterministic version can be
// swapped in later in one place.
// DEVIATION: the console's hardware atan2 raises a HARDWARE FAULT on (0,0)
// (silent CPU freeze, no DebugLog). Upstream b2Atan2(0,0) returns 0. Guard the
// degenerate input here so normalizing/angle-of a zeroed rot can't crash.
float b2Atan2( float y, float x )
{
    if( y == 0.0 && x == 0.0 )
        return 0.0;
    return atan2( y, x );
}

// ---------------------------------------------------------

// angle of a rotation, range [-pi, pi]
float b2Rot_GetAngle( b2Rot* q )
{
    return b2Atan2( q->s, q->c );
}

// ---------------------------------------------------------

void b2Rot_GetXAxis( b2Rot* q, b2Vec2* result )
{
    result->x = q->c;
    result->y = q->s;
}

// ---------------------------------------------------------

void b2Rot_GetYAxis( b2Rot* q, b2Vec2* result )
{
    result->x = -q->s;
    result->y =  q->c;
}

// ---------------------------------------------------------

// relative angle from a to b (i.e. angle of inv(a)*b)
float b2RelativeAngle( b2Rot* a, b2Rot* b )
{
    float s = a->c * b->s - a->s * b->c;
    float c = a->c * b->c + a->s * b->s;
    return b2Atan2( s, c );
}

// ---------------------------------------------------------

// wrap any angle into [-pi, pi]
float b2UnwindAngle( float radians )
{
    float twoPi = 2.0 * B2_PI;
    float turns = round( radians / twoPi );
    return radians - turns * twoPi;
}

// ---------------------------------------------------------

// integrate a rotation by a small angular displacement, then renormalize
void b2IntegrateRotation( b2Rot* q1, float deltaAngle, b2Rot* result )
{
    float c2 = q1->c - deltaAngle * q1->s;
    float s2 = q1->s + deltaAngle * q1->c;
    float mag = sqrt( s2 * s2 + c2 * c2 );
    float invMag = 0.0;
    if( mag > 0.0 ) invMag = 1.0 / mag;
    result->c = c2 * invMag;
    result->s = s2 * invMag;
}

// ---------------------------------------------------------

// angular velocity needed to rotate from q1 to q2 over inverse-timestep inv_h
float b2ComputeAngularVelocity( b2Rot* q1, b2Rot* q2, float inv_h )
{
    return inv_h * ( q2->s * q1->c - q2->c * q1->s );
}

// ---------------------------------------------------------

// normalized linear interpolation between rotations
void b2NLerp( b2Rot* q1, b2Rot* q2, float t, b2Rot* result )
{
    float omt = 1.0 - t;
    float c = omt * q1->c + t * q2->c;
    float s = omt * q1->s + t * q2->s;
    float mag = sqrt( s * s + c * c );
    float invMag = 0.0;
    if( mag > 0.0 ) invMag = 1.0 / mag;
    result->c = c * invMag;
    result->s = s * invMag;
}

// ---------------------------------------------------------

// is this rotation (approximately) unit length?
bool b2IsNormalizedRot( b2Rot* q )
{
    float qq = q->s * q->s + q->c * q->c;
    return 1.0 - 0.0006 < qq && qq < 1.0 + 0.0006;
}

// ---------------------------------------------------------

// build a rotation directly from a unit vector
void b2MakeRotFromUnitVector( b2Vec2* unitVector, b2Rot* result )
{
    result->c = unitVector->x;
    result->s = unitVector->y;
}


// =============================================================================
//   2x2 MATRIX
// =============================================================================


// result = A * v
void b2MulMV( b2Mat22* A, b2Vec2* v, b2Vec2* result )
{
    float x = A->cx.x * v->x + A->cy.x * v->y;
    float y = A->cx.y * v->x + A->cy.y * v->y;
    result->x = x;
    result->y = y;
}

// ---------------------------------------------------------

// result = inverse of A (zero determinant yields a zero-scaled matrix)
void b2GetInverse22( b2Mat22* A, b2Mat22* result )
{
    float a = A->cx.x;
    float b = A->cy.x;
    float c = A->cx.y;
    float d = A->cy.y;

    float det = a * d - b * c;
    if( det != 0.0 ) det = 1.0 / det;

    result->cx.x =  det * d;
    result->cx.y = -det * c;
    result->cy.x = -det * b;
    result->cy.y =  det * a;
}

// ---------------------------------------------------------

// solve A * x = b for x
void b2Solve22( b2Mat22* A, b2Vec2* b, b2Vec2* result )
{
    float a11 = A->cx.x;
    float a12 = A->cy.x;
    float a21 = A->cx.y;
    float a22 = A->cy.y;

    float det = a11 * a22 - a12 * a21;
    if( det != 0.0 ) det = 1.0 / det;

    float x = det * ( a22 * b->x - a12 * b->y );
    float y = det * ( a11 * b->y - a21 * b->x );
    result->x = x;
    result->y = y;
}


// =============================================================================
//   AXIS-ALIGNED BOUNDING BOX
// =============================================================================


// does a fully contain b?
bool b2AABB_Contains( b2AABB* a, b2AABB* b )
{
    bool s = true;
    s = s && a->lowerBound.x <= b->lowerBound.x;
    s = s && a->lowerBound.y <= b->lowerBound.y;
    s = s && b->upperBound.x <= a->upperBound.x;
    s = s && b->upperBound.y <= a->upperBound.y;
    return s;
}

// ---------------------------------------------------------

void b2AABB_Center( b2AABB* a, b2Vec2* result )
{
    result->x = 0.5 * ( a->lowerBound.x + a->upperBound.x );
    result->y = 0.5 * ( a->lowerBound.y + a->upperBound.y );
}

// ---------------------------------------------------------

void b2AABB_Extents( b2AABB* a, b2Vec2* result )
{
    result->x = 0.5 * ( a->upperBound.x - a->lowerBound.x );
    result->y = 0.5 * ( a->upperBound.y - a->lowerBound.y );
}

// ---------------------------------------------------------

void b2AABB_Union( b2AABB* a, b2AABB* b, b2AABB* result )
{
    result->lowerBound.x = fmin( a->lowerBound.x, b->lowerBound.x );
    result->lowerBound.y = fmin( a->lowerBound.y, b->lowerBound.y );
    result->upperBound.x = fmax( a->upperBound.x, b->upperBound.x );
    result->upperBound.y = fmax( a->upperBound.y, b->upperBound.y );
}

// ---------------------------------------------------------

bool b2AABB_Overlaps( b2AABB* a, b2AABB* b )
{
    if( b->lowerBound.x > a->upperBound.x ) return false;
    if( b->lowerBound.y > a->upperBound.y ) return false;
    if( a->lowerBound.x > b->upperBound.x ) return false;
    if( a->lowerBound.y > b->upperBound.y ) return false;
    return true;
}


// =============================================================================
//   PLANE
// =============================================================================


// separation = dot(normal, point) - offset
struct b2Plane
{
    b2Vec2 normal;
    float offset;
};

// ---------------------------------------------------------

float b2PlaneSeparation( b2Plane* plane, b2Vec2* point )
{
    return b2Dot( &plane->normal, point ) - plane->offset;
}


// =============================================================================
//   SIMULATION HELPERS
// =============================================================================


// one-dimensional mass-spring-damper; returns the new velocity
float b2SpringDamper( float hertz, float dampingRatio, float position, float velocity, float timeStep )
{
    float omega = 2.0 * B2_PI * hertz;
    float omegaH = omega * timeStep;
    return ( velocity - omega * omegaH * position )
         / ( 1.0 + 2.0 * dampingRatio * omegaH + omegaH * omegaH );
}


// =============================================================================
//   VALIDITY CHECKS
// =============================================================================


// a finite, non-NaN float.
// NaN is detected via the self-inequality trick; "infinity" is approximated as
// exceeding a very large finite bound (built by multiplication since this
// compiler has no scientific-notation literals).
bool b2IsValidFloat( float a )
{
    if( a != a ) return false;          // NaN is not equal to itself

    float big = 1000000000.0;
    big = big * big;                    // 1e18
    big = big * big;                    // 1e36  (< FLT_MAX ~ 3.4e38)

    if( a >  big ) return false;
    if( a < -big ) return false;
    return true;
}

// ---------------------------------------------------------

bool b2IsValidVec2( b2Vec2* v )
{
    return b2IsValidFloat( v->x ) && b2IsValidFloat( v->y );
}

// ---------------------------------------------------------

bool b2IsValidRotation( b2Rot* q )
{
    if( !b2IsValidFloat( q->c ) ) return false;
    if( !b2IsValidFloat( q->s ) ) return false;
    return b2IsNormalizedRot( q );
}


// =============================================================================
//   CONSTANT VALUES  (upstream "static const" globals)
// =============================================================================
//   These are plain globals (the dialect has no 'static'). In the single
//   translation unit they are defined exactly once.


b2Vec2 b2Vec2_zero = { 0.0, 0.0 };
b2Rot  b2Rot_identity = { 1.0, 0.0 };
b2Transform b2Transform_identity = { { 0.0, 0.0 }, { 1.0, 0.0 } };
b2Mat22 b2Mat22_zero = { { 0.0, 0.0 }, { 0.0, 0.0 } };


// =============================================================================
//   LENGTH UNITS
// =============================================================================


// Box2D's internal tolerances are tuned for meters. A game using other units
// (e.g. pixels) sets this once at startup; see upstream b2SetLengthUnitsPerMeter.
float b2_lengthUnitsPerMeter = 1.0;

float b2GetLengthUnitsPerMeter()
{
    return b2_lengthUnitsPerMeter;
}

// ---------------------------------------------------------

void b2SetLengthUnitsPerMeter( float lengthUnits )
{
    b2_lengthUnitsPerMeter = lengthUnits;
}


// =============================================================================
//   WORLD POSITION  (single precision: b2Pos is just b2Vec2)
// =============================================================================


typedef b2Vec2 b2Pos;

// a world transform; in single precision it is identical to b2Transform
typedef b2Transform b2WorldTransform;

// transform a local point to a world position (single precision: == b2TransformPoint)
void b2TransformWorldPoint( b2WorldTransform* t, b2Vec2* p, b2Pos* result )
{
    float rx = t->q.c * p->x - t->q.s * p->y;
    float ry = t->q.s * p->x + t->q.c * p->y;
    result->x = t->p.x + rx;
    result->y = t->p.y + ry;
}

// narrow a world coordinate to float. With large-world (double) mode off these
// are plain pass-throughs (upstream takes a double; the console has no double).
float b2RoundDownFloat( float x )
{
    return x;
}

// ---------------------------------------------------------

float b2RoundUpFloat( float x )
{
    return x;
}

// ---------------------------------------------------------

// b2Pos <-> b2Vec2 conversions (no-ops in single precision)
void b2ToPos( b2Vec2* v, b2Pos* result )
{
    result->x = v->x;
    result->y = v->y;
}

// ---------------------------------------------------------

void b2ToVec2( b2Pos* p, b2Vec2* result )
{
    result->x = p->x;
    result->y = p->y;
}

// ---------------------------------------------------------

// The rotation carrying unit vector v1 onto unit vector v2 (Box2D's build-from-
// dot/cross form). Ports math_functions.c b2ComputeRotationBetweenUnitVectors;
// the two length asserts are dropped. Fills the deviation-list gap.
void b2ComputeRotationBetweenUnitVectors( b2Vec2* v1, b2Vec2* v2, b2Rot* result )
{
    b2Rot rot;
    rot.c = b2Dot( v1, v2 );
    rot.s = b2Cross( v1, v2 );
    b2NormalizeRot( &rot, result );
}

// ---------------------------------------------------------

// World-position validity + boundary helpers. In single precision b2Pos ==
// b2Vec2 and b2WorldTransform == b2Transform, so these delegate to the float
// versions (the double/large-world path folds away).
bool b2IsValidPosition( b2Pos* p )
{
    return b2IsValidVec2( p );
}

bool b2IsValidWorldTransform( b2WorldTransform* t )
{
    if( b2IsValidVec2( &t->p ) == false )
        return false;
    return b2IsValidRotation( &t->q );
}

// result = p + d
void b2OffsetPos( b2Pos* p, b2Vec2* d, b2Pos* result )
{
    result->x = p->x + d->x;
    result->y = p->y + d->y;
}

// result = a - b
void b2SubPos( b2Pos* a, b2Pos* b, b2Vec2* result )
{
    result->x = a->x - b->x;
    result->y = a->y - b->y;
}

// world position -> local point (single precision: == b2InvTransformPoint)
void b2InvTransformWorldPoint( b2WorldTransform* t, b2Pos* p, b2Vec2* result )
{
    b2InvTransformPoint( t, p, result );
}

// relative transform of frame B in frame A (single precision: == b2InvMulTransforms)
void b2InvMulWorldTransforms( b2WorldTransform* A, b2WorldTransform* B, b2Transform* result )
{
    b2InvMulTransforms( A, B, result );
}


// *****************************************************************************
    // end include guard
    #endif
// *****************************************************************************
