/* *****************************************************************************
*  VirconBox2D : b2_contact.h        (port of Box2D v3 contact.{c,h} -- SLICE 1)
*  --------------------------------------------------------------------------- *
*  COLD contact data + the body<->contact graph edges. A b2Contact exists for   *
*  each overlapping shape-pair AABB in the broad-phase; it links the two bodies *
*  via a doubly-linked edge list (the contact graph) and is registered in the   *
*  broad-phase pairSet for fast dedup.                                          *
*                                                                              *
*  SLICE 1 = connectivity only: types, b2CanCollide, and (in b2_body.h, where   *
*  b2World is visible) b2CreateContact / b2DestroyContact / b2UpdateBroadPhasePairs. *
*  DEFERRED: b2ContactSim (the solver-set side: manifold, friction/restitution,  *
*  invMass cache) and b2UpdateContact (narrow phase) -- those need b2Manifold,   *
*  the solver sets' contactSims arrays, and the friction callbacks. So this      *
*  slice creates contacts as pure connectivity records; localIndex = NULL.       *
*                                                                              *
*  TRAP: b2Contact.edges[2] is a FIXED array member and upstream indexes it by   *
*  `key & 1` (a variable) -- that miscompiles here. ALL variable-index edge       *
*  access goes through b2ContactEdgeAt(), which selects edges[0]/edges[1] with   *
*  constant indices via if/else.                                                *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_CONTACT_H
    #define B2_CONTACT_H

    #include "b2_core.h"
    #include "b2_shape.h"      // shape type constants + b2Shape geometry fields
    #include "b2_manifold.h"   // the collide functions, for the narrow phase (slice B)
// *****************************************************************************


// b2ContactFlags (cold-contact flags, low bits)
#define b2_contactTouchingFlag          1       // 0x0001
#define b2_contactHitEventFlag          2       // 0x0002
#define b2_contactEnableContactEvents   4       // 0x0004
#define b2_contactRecycleFlag           8       // 0x0008

// b2ContactSimFlags (sim-side flags, high bits) -- live in contactSim->simFlags
#define b2_simTouchingFlag         0x00010000
#define b2_simDisjoint             0x00020000
#define b2_simStartedTouching      0x00040000
#define b2_simStoppedTouching      0x00080000
#define b2_simEnableHitEvent       0x00100000
#define b2_simEnablePreSolveEvents 0x00200000

// A contact edge connects a body (node) to a contact (edge) in the contact graph.
// Each contact has two, one per attached body, each living in that body's list.
struct b2ContactEdge
{
    int bodyId;
    int prevKey;
    int nextKey;
};

// Cold contact: the persistent handle + graph connectivity. (b2ContactSim, the
// solver/narrow-phase side, is deferred.)
struct b2Contact
{
    b2ContactEdge[2] edges;
    int islandId;
    int islandIndex;
    int setIndex;
    int colorIndex;
    int localIndex;     // index into the set's contactSims (NULL in this slice)
    int shapeIdA;
    int shapeIdB;
    int contactId;
    int flags;
    int generation;
};

struct b2ContactArray { b2Contact* data;  int count;  int capacity; };


// Stable, generation-checked handle to a contact (multi-word -> out-pointer),
// mirroring b2ShapeId/b2JointId. Contacts are engine-managed and short-lived (the
// broad phase creates them and destroys them the moment the shapes separate), so a
// held handle goes stale far more often than a body/shape/joint the game owns --
// resolve it through b2Contact_IsValid before every use. Minted by the enumeration
// path (b2Body_GetContactData) into the b2ContactData it hands back.
struct b2ContactId
{
    int index1;        // 1-based index into world->contacts
    int world0;        // owning world id
    int generation;    // contact->generation snapshot at mint time
};


// The solver / narrow-phase side of a contact. Lives in a DENSE array on the
// owning solver set (set->contactSims), referenced by contact->localIndex. Holds
// the current manifold + the mixed material / inverse-mass cache the solver reads.
// DEVIATION: upstream's contact-recycling fields (cachedRotationA/B,
// cachedRelativePose, b2_simRelativeTransformValid) are dropped -- recycling is
// deferred. The B2_ENABLE_VALIDATION bodyIdA/B fields are also dropped.
struct b2ContactSim
{
    int contactId;          // back-reference to the cold b2Contact (== its id)

    int bodySimIndexA;      // transient dense bodySim indices (set by the solver; NULL here)
    int bodySimIndexB;

    int shapeIdA;
    int shapeIdB;

    float invMassA;         // inverse-mass cache (filled by the solver; 0 here)
    float invIA;
    float invMassB;
    float invIB;

    b2Manifold manifold;    // current contact manifold (world anchors)

    float friction;         // mixed friction
    float restitution;      // mixed restitution
    float rollingResistance;
    float tangentSpeed;

    int simFlags;           // b2ContactSimFlags (touching, hit-event, ...)

    b2SimplexCache cache;   // GJK warm-start cache (only the deferred chain fns use it)
};

struct b2ContactSimArray { b2ContactSim* data;  int count;  int capacity; };


// Select edge 0 or 1 with CONSTANT indices (edges[] is a fixed array member; a
// variable index would miscompile). i is 0 or 1 (a contact key's low bit).
b2ContactEdge* b2ContactEdgeAt( b2Contact* contact, int i )
{
    if( i == 0 )
        return &contact->edges[0];
    return &contact->edges[1];
}

// True if a manifold generator exists for this shape-type pair. The only missing
// combinations are segment/chain-segment vs segment/chain-segment (no segment-segment
// collision). (Upstream uses a primary/secondary register table; the primary-flip
// ordering is deferred until the narrow phase needs the manifold dispatch.)
bool b2CanCollide( int typeA, int typeB )
{
    bool aThin = ( typeA == b2_segmentShape || typeA == b2_chainSegmentShape );
    bool bThin = ( typeB == b2_segmentShape || typeB == b2_chainSegmentShape );
    if( aThin && bThin )
        return false;
    return true;
}


// -----------------------------------------------------------------------------
//   Narrow phase (SLICE B): shape-type dispatch + manifold marshalling
// -----------------------------------------------------------------------------
//   Upstream uses a 2D s_registers[type][type] table of {fcn,primary} structs.
//   The dialect has no fn-ptr-in-struct precedent, so instead we encode the same
//   two facts as functions: b2IsPrimaryOrder (the primary/secondary flag) and
//   b2ComputeManifold (the dispatch). A contact stores its shapes in PRIMARY
//   order (b2CreateContact flips), so the dispatch never needs to flip.

// Collision-dispatch rank -- NOT the raw type value: segment OUTRANKS polygon.
// Upstream's b2AddType registrations make (A,B) "primary" exactly when
// rank(A) >= rank(B) with this ordering: circle < capsule < polygon < segment <
// chainSegment. (Verified against all 12 b2AddType calls in contact.c.)
int b2ShapeCollisionRank( int type )
{
    if( type == b2_circleShape )    return 0;
    if( type == b2_capsuleShape )   return 1;
    if( type == b2_polygonShape )   return 2;
    if( type == b2_segmentShape )   return 3;
    return 4;   // b2_chainSegmentShape
}

// True if (typeA, typeB) is the primary registration order (no flip needed).
bool b2IsPrimaryOrder( int typeA, int typeB )
{
    return b2ShapeCollisionRank( typeA ) >= b2ShapeCollisionRank( typeB );
}

// Compute the frame-A local manifold for a PRIMARY-ordered shape pair, dispatching
// to the (already-green) manifold generators. xf = pose of B in A's frame.
void b2ComputeManifold( b2Shape* shapeA, b2Shape* shapeB, b2Transform* xf, b2LocalManifold* out )
{
    int ta = shapeA->type;
    int tb = shapeB->type;
    out->pointCount = 0;

    if( ta == b2_circleShape )
    {
        // primary order => B can only be a circle
        b2CollideCircles( &shapeA->circle, &shapeB->circle, xf, out );
    }
    else if( ta == b2_capsuleShape )
    {
        if( tb == b2_circleShape )
            b2CollideCapsuleAndCircle( &shapeA->capsule, &shapeB->circle, xf, out );
        else
            b2CollideCapsules( &shapeA->capsule, &shapeB->capsule, xf, out );
    }
    else if( ta == b2_segmentShape )
    {
        if( tb == b2_circleShape )
            b2CollideSegmentAndCircle( &shapeA->segment, &shapeB->circle, xf, out );
        else if( tb == b2_capsuleShape )
            b2CollideSegmentAndCapsule( &shapeA->segment, &shapeB->capsule, xf, out );
        else
            b2CollideSegmentAndPolygon( &shapeA->segment, &shapeB->polygon, xf, out );
    }
    else if( ta == b2_chainSegmentShape )
    {
        // chainSegment outranks all others, so it is always A in primary order.
        // The capsule/polygon paths run GJK and read back its simplex cache to pick
        // the closest features; the port keeps no persistent GJK cache, so a cold
        // cache is passed each call (costs iterations, not correctness -- the
        // deviation is documented at b2CollideChainSegmentAndPolygon).
        if( tb == b2_circleShape )
            b2CollideChainSegmentAndCircle( &shapeA->chainSegment, &shapeB->circle, xf, out );
        else if( tb == b2_capsuleShape )
        {
            b2SimplexCache cache;  cache.count = 0;
            b2CollideChainSegmentAndCapsule( &shapeA->chainSegment, &shapeB->capsule, xf, &cache, out );
        }
        else
        {
            b2SimplexCache cache;  cache.count = 0;
            b2CollideChainSegmentAndPolygon( &shapeA->chainSegment, &shapeB->polygon, xf, &cache, out );
        }
    }
    else   // polygon
    {
        if( tb == b2_circleShape )
            b2CollidePolygonAndCircle( &shapeA->polygon, &shapeB->circle, xf, out );
        else if( tb == b2_capsuleShape )
            b2CollidePolygonAndCapsule( &shapeA->polygon, &shapeB->capsule, xf, out );
        else
            b2CollidePolygons( &shapeA->polygon, &shapeB->polygon, xf, out );
    }
}

// Marshal one frame-A local point into a solver manifold point: rotate into world,
// offset for body B, then shift both anchors to be center-of-mass relative.
//   anchorA = rot(qA, local.point) - centerOffsetA
//   anchorB = anchorA + (pA - pB)  - centerOffsetB  (originDelta = pA - pB)
void b2MarshalManifoldPoint( b2LocalManifoldPoint* lp, b2ManifoldPoint* mp,
                             b2Transform* transformA, b2Vec2* originDelta,
                             b2Vec2* centerOffsetA, b2Vec2* centerOffsetB )
{
    b2Vec2 anchorA;
    b2RotateVector( &transformA->q, &lp->point, &anchorA );
    b2Vec2 anchorB;
    b2Add( &anchorA, originDelta, &anchorB );

    b2Sub( &anchorA, centerOffsetA, &mp->anchorA );
    b2Sub( &anchorB, centerOffsetB, &mp->anchorB );

    mp->separation = lp->separation;
    mp->baseSeparation = 0.0;
    mp->id = lp->id;

    // warm-start fields default to zero; b2MatchWarmStart carries over any stored
    // impulse from a point with the same id in the previous step's manifold.
    mp->normalImpulse = 0.0;
    mp->tangentImpulse = 0.0;
    mp->totalNormalImpulse = 0.0;
    mp->normalVelocity = 0.0;
    mp->persisted = false;
}

// Cross-step warm start: if this new point's id matches one of the (up to two)
// previous-step points, copy its stored normal/tangent impulse over so the solver
// seeds from it. Old point data is passed as scalars (constant-index snapshot taken
// before the manifold was overwritten) to avoid variable-indexing an array member.
// Manifold point ids are unique per point, so at most one old point matches.
// DEVIATION: upstream also clears the matched old point's impulse (mp1->normalImpulse=0)
// to stop a second new point re-matching it. Omitted here: ids are unique per point,
// so no old point can match twice — behaviorally equivalent.
void b2MatchWarmStart( b2ManifoldPoint* mp2, int oldCount,
                       int oldId0, float oldN0, float oldT0,
                       int oldId1, float oldN1, float oldT1 )
{
    int id2 = mp2->id;
    if( oldCount >= 1 && oldId0 == id2 )
    {
        mp2->normalImpulse = oldN0;
        mp2->tangentImpulse = oldT0;
        mp2->persisted = true;
    }
    else if( oldCount >= 2 && oldId1 == id2 )
    {
        mp2->normalImpulse = oldN1;
        mp2->tangentImpulse = oldT1;
        mp2->persisted = true;
    }
}

// Update a contact's manifold + touching status. Shapes must already be in primary
// order (as b2CreateContact stores them). transformA/B are the shapes' world poses;
// centerOffsetA/B shift anchors to be center-of-mass relative.
//
// DEVIATIONS (deferred): the world is not threaded through, so the friction /
// restitution callbacks become Box2D's defaults; pre-solve events, hit events,
// speculative trimming (enableSpeculative defaults true => dead branch), and the
// id-matched warm-start impulse copy are all omitted.
bool b2UpdateContact( b2ContactSim* contactSim,
                      b2Shape* shapeA, b2Transform* transformA, b2Vec2* centerOffsetA,
                      b2Shape* shapeB, b2Transform* transformB, b2Vec2* centerOffsetB )
{
    // snapshot the PREVIOUS manifold's impulses+ids (constant index, before we
    // overwrite them below) so cross-step warm start can carry them into the new
    // points that share an id. Held as scalars to dodge the array-member index trap.
    int   oldCount = contactSim->manifold.pointCount;
    int   oldId0 = contactSim->manifold.points[0].id;
    float oldN0  = contactSim->manifold.points[0].normalImpulse;
    float oldT0  = contactSim->manifold.points[0].tangentImpulse;
    int   oldId1 = contactSim->manifold.points[1].id;
    float oldN1  = contactSim->manifold.points[1].normalImpulse;
    float oldT1  = contactSim->manifold.points[1].tangentImpulse;

    // compute the manifold in frame A (relative pose of B in A)
    b2Transform relative;
    b2InvMulTransforms( transformA, transformB, &relative );

    b2LocalManifold local;
    local.pointCount = 0;
    b2ComputeManifold( shapeA, shapeB, &relative, &local );

    // reset the sim manifold and set the world normal + count
    contactSim->manifold.rollingImpulse = 0.0;
    b2RotateVector( &transformA->q, &local.normal, &contactSim->manifold.normal );
    contactSim->manifold.pointCount = local.pointCount;

    b2Vec2 originDelta;
    b2Sub( &transformA->p, &transformB->p, &originDelta );

    // marshal up to two points. local.points[] and manifold.points[] are fixed
    // array members of multi-word structs -> CONSTANT indices only (a runtime
    // index miscompiles). pointCount is 0/1/2, so unroll the two slots.
    if( local.pointCount >= 1 )
        b2MarshalManifoldPoint( &local.points[0], &contactSim->manifold.points[0],
                                transformA, &originDelta, centerOffsetA, centerOffsetB );
    if( local.pointCount >= 2 )
        b2MarshalManifoldPoint( &local.points[1], &contactSim->manifold.points[1],
                                transformA, &originDelta, centerOffsetA, centerOffsetB );

    // id-matched cross-step warm start: carry the snapshotted impulses forward
    if( local.pointCount >= 1 )
        b2MatchWarmStart( &contactSim->manifold.points[0], oldCount,
                          oldId0, oldN0, oldT0, oldId1, oldN1, oldT1 );
    if( local.pointCount >= 2 )
        b2MatchWarmStart( &contactSim->manifold.points[1], oldCount,
                          oldId0, oldN0, oldT0, oldId1, oldN1, oldT1 );

    // mix the two shapes' materials (upstream b2MixFriction/b2MixRestitution):
    // friction is the geometric mean, restitution the max. Custom mixing
    // callbacks are deferred -> the default rules only.
    // b2MaxFloat(0,...) guards the console sqrt against a negative operand
    // (a CPU fault, not NaN) should a caller pass negative friction.
    contactSim->friction = sqrt( b2MaxFloat( 0.0, shapeA->friction * shapeB->friction ) );
    contactSim->restitution = b2MaxFloat( shapeA->restitution, shapeB->restitution );
    contactSim->rollingResistance = 0.0;
    contactSim->tangentSpeed = 0.0;

    bool touching = local.pointCount > 0;
    if( touching )
        contactSim->simFlags = contactSim->simFlags | b2_simTouchingFlag;
    else
        contactSim->simFlags = contactSim->simFlags & ~b2_simTouchingFlag;

    // hit events: arm the flag when touching and either shape opted in. The solver
    // reads this after the solve to decide whether to emit a b2ContactHitEvent
    // (upstream contact.c b2UpdateContact). No event work happens here.
    if( touching && ( shapeA->enableHitEvents || shapeB->enableHitEvents ) )
        contactSim->simFlags = contactSim->simFlags | b2_simEnableHitEvent;
    else
        contactSim->simFlags = contactSim->simFlags & ~b2_simEnableHitEvent;

    return touching;
}


// *****************************************************************************
    #endif
// *****************************************************************************
