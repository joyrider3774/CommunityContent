/* *****************************************************************************
*  VirconBox2D : b2_solver.h     (port of Box2D v3 solver.c -- INTEGRATION slice)
*  --------------------------------------------------------------------------- *
*  The first piece of the solver: time integration of the awake dynamic bodies. *
*  b2IntegrateVelocities applies gravity + damping to each b2BodyState; the      *
*  position pass accumulates a deltaPosition/deltaRotation; b2FinalizeBodies     *
*  folds those deltas back into the bodySim center/transform.                    *
*                                                                              *
*  SLICE = integration only. b2World_Step here runs ONLY integration (no broad- *
*  phase pairing, no narrow phase, no constraint solve), so a free dynamic body  *
*  falls under gravity. The contact constraint solve (contact_solver.c + the     *
*  constraint graph + islands) is the next, much larger slice.                   *
*                                                                              *
*  DEVIATIONS (deferred): sub-stepping (one full-dt step here), the speed-cap    *
*  clamp + motion-lock flags in the position pass, sleep, continuous/TOI, move   *
*  events, islands, and the parallel-for (collapsed to one serial loop).         *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_SOLVER_H
    #define B2_SOLVER_H

    #include "b2_math.h"
    #include "b2_body.h"     // b2World, b2BodySim, b2BodyState, the awake set
// *****************************************************************************


// Apply gravity + damping to every awake body's velocity, integrating by h.
// (Semi-implicit Euler: velocity is updated before position.) Static/kinematic
// bodies have invMass==0 so gravityScale is forced to 0 -- they don't fall.
void b2IntegrateVelocities( b2World* world, float h )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    b2BodySim*   sims   = awakeSet->bodySims.data;
    b2BodyState* states = awakeSet->bodyStates.data;
    int count = awakeSet->bodyStates.count;
    b2Vec2 gravity = world->gravity;

    int i;
    for( i = 0; i < count; ++i )
    {
        b2BodySim*   sim   = &sims[i];
        b2BodyState* state = &states[i];

        b2Vec2 v = state->linearVelocity;
        float  w = state->angularVelocity;

        // Padé approximation of exponential damping: factor = 1 / (1 + h*c)
        float linearDamping  = 1.0 / ( 1.0 + h * sim->linearDamping );
        float angularDamping = 1.0 / ( 1.0 + h * sim->angularDamping );

        float gravityScale;
        if( sim->invMass > 0.0 )
            gravityScale = sim->gravityScale;
        else
            gravityScale = 0.0;

        // linearVelocityDelta = h*invMass*force + h*gravityScale*gravity
        b2Vec2 fTerm;  b2MulSV( h * sim->invMass, &sim->force, &fTerm );
        b2Vec2 gTerm;  b2MulSV( h * gravityScale, &gravity, &gTerm );
        b2Vec2 lvd;    b2Add( &fTerm, &gTerm, &lvd );
        float  avd = h * sim->invInertia * sim->torque;

        // v = lvd + linearDamping * v ;  w = avd + angularDamping * w
        b2Vec2 newV;  b2MulAdd( &lvd, linearDamping, &v, &newV );
        state->linearVelocity = newV;
        state->angularVelocity = avd + angularDamping * w;
    }
}

// Max rotation permitted per full step (keeps the rotation integration stable);
// scaled by inv_dt to a per-second angular cap. (upstream constants.h)
#define B2_MAX_ROTATION ( 0.25 * B2_PI )

// Apply motion locks + speed caps to each awake body's velocity, then accumulate
// the position/rotation deltas by h. maxLinearSpeed / maxAngularSpeed are the
// per-second caps (angular = B2_MAX_ROTATION * inv_dt), precomputed once in b2Solve.
void b2IntegratePositions( b2World* world, float h, float maxLinearSpeed, float maxAngularSpeed )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    b2BodyState* states = awakeSet->bodyStates.data;
    int count = awakeSet->bodyStates.count;

    float maxLinearSpeedSquared  = maxLinearSpeed  * maxLinearSpeed;
    float maxAngularSpeedSquared = maxAngularSpeed * maxAngularSpeed;

    int i;
    for( i = 0; i < count; ++i )
    {
        b2BodyState* state = &states[i];

        b2Vec2 v = state->linearVelocity;
        float  w = state->angularVelocity;

        // motion locks: zero the locked components (a final "constraint")
        if( ( state->flags & b2_lockLinearX ) != 0 )  v.x = 0.0;
        if( ( state->flags & b2_lockLinearY ) != 0 )  v.y = 0.0;
        if( ( state->flags & b2_lockAngularZ ) != 0 ) w = 0.0;

        // clamp to the max linear speed
        if( b2Dot( &v, &v ) > maxLinearSpeedSquared )
        {
            float ratio = maxLinearSpeed / b2Length( &v );
            b2Vec2 cv;  b2MulSV( ratio, &v, &cv );  v = cv;
            state->flags = state->flags | b2_isSpeedCapped;
        }

        // clamp to the max angular speed (unless this body may spin fast)
        if( w * w > maxAngularSpeedSquared && ( state->flags & b2_allowFastRotation ) == 0 )
        {
            float ratio = maxAngularSpeed / fabs( w );
            w = w * ratio;
            state->flags = state->flags | b2_isSpeedCapped;
        }

        state->linearVelocity = v;
        state->angularVelocity = w;

        // deltaPosition += h * linearVelocity
        b2Vec2 dp;  b2MulAdd( &state->deltaPosition, h, &state->linearVelocity, &dp );
        state->deltaPosition = dp;

        // deltaRotation = integrate(deltaRotation, h * angularVelocity)
        b2Rot dr;  b2IntegrateRotation( &state->deltaRotation, h * state->angularVelocity, &dr );
        state->deltaRotation = dr;
    }
}

// Fold the accumulated deltas into each awake bodySim: advance the center by
// deltaPosition, compose the rotation, then recompute the origin transform from
// the (moved) center and localCenter. Resets the deltas + applied force/torque.
//
// FORWARD LANDMINE: this moves center/transform.p but does NOT move the body's
// broad-phase proxy. Fine for an integration-only step, but when b2World_Step
// gains the collide/solve stages, every moved body must b2BroadPhase_MoveProxy
// (here or in a post-step pass) or the broad phase goes stale.
// (DEFERRED here: sleep, continuous/TOI, move events, islands.)
// -----------------------------------------------------------------------------
//   Continuous collision (CCD, slice 2): sweep fast bodies + clamp to first impact
// -----------------------------------------------------------------------------
//   Port of solver.c b2SolveContinuous / b2ContinuousQueryCallback, serialized (no
//   atomics, no deferred bullet array). A "fast" dynamic body (moved more than half
//   its min extent this step) sweeps its shapes against the static tree (plus the
//   kinematic + dynamic trees when it is a bullet) via b2TimeOfImpact and is clamped
//   back to the earliest impact fraction so it can't tunnel through thin geometry.
//   DEVIATIONS: no sensor continuous hits, no pre-solve events, no core-circle
//   fallback for fraction==0, no chain-parallel early-out. Gated on
//   world->enableContinuous (default OFF -> frozen harness untouched).

struct b2ContinuousContext
{
    b2World* world;
    b2Shape* fastShape;
    int   fastBodyId;
    b2Sweep sweep;      // the fast body's world-frame sweep this step
    float fraction;     // running minimum TOI fraction (starts at 1)
};

// Tree-query callback: TOI the fast shape's sweep against one candidate shape,
// shrinking ctx->fraction to the earliest solid impact.
bool b2ContinuousQueryCallback( int proxyId, int shapeId, void* context )
{
    b2ContinuousContext* ctx = context;
    b2World* world = ctx->world;
    b2Shape* fastShape = ctx->fastShape;

    if( shapeId == fastShape->id )
        return true;                                  // itself
    b2Shape* shape = &world->shapes.data[ shapeId ];
    if( shape->id == B2_NULL_INDEX )
        return true;                                  // freed slot
    if( shape->bodyId == fastShape->bodyId )
        return true;                                  // same body
    if( shape->isSensor )
        return true;                                  // sensors don't stop CCD (deviation)
    if( b2ShouldShapesCollide( &fastShape->filter, &shape->filter ) == false )
        return true;

    b2Body* body = &world->bodies.data[ shape->bodyId ];
    b2BodySim* bodySim = b2GetBodySim( world, body );
    if( ( bodySim->flags & b2_isBullet ) != 0 )
        return true;                                  // don't sweep against other bullets
    if( b2ShouldBodiesCollide( world, shape->bodyId, fastShape->bodyId ) == false )
        return true;                                  // joint with collideConnected = false

    // TOI: candidate (A) is stationary over the step; fast shape (B) sweeps.
    // This degenerate sweepA is exact, not an approximation: a static body never
    // moves, and every MOVING target reaching here has already been finalized (its
    // center0 == center, rotation0 == transform.q), because bullets -- the only
    // sweepers that see moving targets -- run in a pass AFTER b2FinalizeBodies has
    // published every non-bullet pose. Other bullets are rejected just above, so a
    // target is never an un-finalized body.
    b2TOIInput input;
    b2MakeShapeProxy( shape, &input.proxyA );
    b2MakeShapeProxy( fastShape, &input.proxyB );
    input.sweepA.localCenter = bodySim->localCenter;
    input.sweepA.c1 = bodySim->center;
    input.sweepA.c2 = bodySim->center;
    input.sweepA.q1 = bodySim->transform.q;
    input.sweepA.q2 = bodySim->transform.q;
    input.sweepB = ctx->sweep;
    input.maxFraction = ctx->fraction;

    b2TOIOutput output;
    b2TimeOfImpact( &input, &output );

    if( output.fraction > 0.0 && output.fraction < ctx->fraction )
        ctx->fraction = output.fraction;

    return true;
}

// Sweep a fast body's shapes and, on impact, clamp the body back to the earliest
// TOI fraction (position only; velocity is handled by next step's contact solve).
void b2SolveContinuous( b2World* world, b2Body* fastBody, b2BodySim* fastBodySim )
{
    b2Sweep sweep;
    sweep.localCenter = fastBodySim->localCenter;
    sweep.c1 = fastBodySim->center0;            // pre-step COM (still valid: not yet advanced)
    sweep.c2 = fastBodySim->center;             // post-integration COM
    sweep.q1 = fastBodySim->rotation0;
    sweep.q2 = fastBodySim->transform.q;

    b2ContinuousContext ctx;
    ctx.world = world;
    ctx.fastBodyId = fastBody->id;
    ctx.sweep = sweep;
    ctx.fraction = 1.0;

    // A plain fast body sweeps only against the (never-moving) static tree. A BULLET
    // additionally sweeps the kinematic + dynamic trees -- which is sound only because
    // b2FinalizeBodies defers bullets to a second pass, after every other awake body
    // has finalized and refit its proxy. Called inline, those trees would still hold
    // last step's positions for bodies not yet finalized.
    bool isBullet = ( fastBodySim->flags & b2_isBullet ) != 0;

    b2Transform xf1;  b2GetSweepTransform( &sweep, 0.0, &xf1 );
    b2Transform xf2;  b2GetSweepTransform( &sweep, 1.0, &xf2 );

    int shapeId = fastBody->headShapeId;
    while( shapeId != B2_NULL_INDEX )
    {
        b2Shape* fastShape = &world->shapes.data[ shapeId ];
        shapeId = fastShape->nextShapeId;
        if( fastShape->isSensor )
            continue;

        ctx.fastShape = fastShape;

        // swept AABB = union of the shape's start and end boxes
        b2AABB box1;  b2ComputeShapeAABB( fastShape, &xf1, &box1 );
        b2AABB box2;  b2ComputeShapeAABB( fastShape, &xf2, &box2 );
        b2AABB swept;
        swept.lowerBound.x = b2MinFloat( box1.lowerBound.x, box2.lowerBound.x );
        swept.lowerBound.y = b2MinFloat( box1.lowerBound.y, box2.lowerBound.y );
        swept.upperBound.x = b2MaxFloat( box1.upperBound.x, box2.upperBound.x );
        swept.upperBound.y = b2MaxFloat( box1.upperBound.y, box2.upperBound.y );

        b2TreeStats st;
        b2DynamicTree_QueryAll( &world->broadPhase.trees[ b2_staticBody ], &swept,
                                &b2ContinuousQueryCallback, &ctx, &st );

        if( isBullet )
        {
            b2DynamicTree_QueryAll( &world->broadPhase.trees[ b2_kinematicBody ], &swept,
                                    &b2ContinuousQueryCallback, &ctx, &st );
            b2DynamicTree_QueryAll( &world->broadPhase.trees[ b2_dynamicBody ], &swept,
                                    &b2ContinuousQueryCallback, &ctx, &st );
        }
    }

    if( ctx.fraction < 1.0 )
    {
        // clamp the body to the impact pose (interpolate the sweep to the fraction)
        float f = ctx.fraction;
        b2Rot q;   b2NLerp( &sweep.q1, &sweep.q2, f, &q );
        b2Vec2 c;  b2Lerp( &sweep.c1, &sweep.c2, f, &c );
        b2Vec2 rc;  b2RotateVector( &q, &sweep.localCenter, &rc );

        fastBodySim->transform.q = q;
        fastBodySim->transform.p.x = c.x - rc.x;
        fastBodySim->transform.p.y = c.y - rc.y;
        fastBodySim->center = c;
        fastBodySim->rotation0 = q;
        fastBodySim->center0 = c;
    }
    else
    {
        // no impact: advance the TOI baseline to the full-step pose
        fastBodySim->center0 = fastBodySim->center;
        fastBodySim->rotation0 = fastBodySim->transform.q;
    }
}


// Move the broad-phase proxy of each shape attached to `sim`'s body to follow the
// body, but ONLY when the shape's tight AABB has escaped its stored fat AABB (5.2).
// A resting/slow body keeps its tight AABB inside the fat one -> no MoveProxy, so it
// is never re-buffered and next step's pairing never re-queries it. When it does
// escape, re-fatten (tight +- margin) and move.
//
// SAFETY vs the P0.2 disjoint-destroy (b2Collide destroys a contact when the shapes'
// fat AABBs stop overlapping): the skip stays safe. A skipped move means this shape's
// fatAABB is UNCHANGED and still contains the tight AABB, so a touching/resting pair's
// fat boxes cannot go disjoint while neither proxy moves -- the destroy only fires
// when a body actually travels (its fat box is re-centered on escape). New pairs are
// still found because the APPROACHING body moves and queries.
//
// Lifted out of b2FinalizeBodies so the deferred bullet pass can call it too, once
// continuous collision has clamped the bullet to its impact pose.
void b2UpdateBodyProxies( b2World* world, b2BodySim* sim )
{
    b2Body* body = &world->bodies.data[ sim->bodyId ];
    int shapeId = body->headShapeId;
    while( shapeId != B2_NULL_INDEX )
    {
        b2Shape* shape = &world->shapes.data[ shapeId ];
        if( shape->proxyKey != B2_NULL_INDEX )
        {
            b2AABB aabb;
            b2ComputeShapeAABB( shape, &sim->transform, &aabb );

            // speculative-padded tight AABB for the disjoint early-out (b2Collide).
            // Refreshed every step (cheap) so the early-out sees current positions.
            float sp = B2_SPECULATIVE_DISTANCE;
            shape->aabb.lowerBound.x = aabb.lowerBound.x - sp;
            shape->aabb.lowerBound.y = aabb.lowerBound.y - sp;
            shape->aabb.upperBound.x = aabb.upperBound.x + sp;
            shape->aabb.upperBound.y = aabb.upperBound.y + sp;

            if( b2AABB_Contains( &shape->fatAABB, &aabb ) == false )
            {
                float m = shape->aabbMargin;
                shape->fatAABB.lowerBound.x = aabb.lowerBound.x - m;
                shape->fatAABB.lowerBound.y = aabb.lowerBound.y - m;
                shape->fatAABB.upperBound.x = aabb.upperBound.x + m;
                shape->fatAABB.upperBound.y = aabb.upperBound.y + m;
                b2BroadPhase_MoveProxy( &world->broadPhase, shape->proxyKey, &shape->fatAABB );
            }
        }
        shapeId = shape->nextShapeId;
    }
}


void b2FinalizeBodies( b2World* world, float dt, float inv_dt )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    b2BodySim*   sims   = awakeSet->bodySims.data;
    b2BodyState* states = awakeSet->bodyStates.data;
    int count = awakeSet->bodyStates.count;

    int i;
    for( i = 0; i < count; ++i )
    {
        b2BodySim*   sim   = &sims[i];
        b2BodyState* state = &states[i];

        // b2_isFast is transient: clear it up front so a body that was a deferred
        // bullet last step but is slow this step is not re-swept by pass 2.
        sim->flags = sim->flags & ~b2_isFast;

        // center += deltaPosition
        b2Vec2 newCenter;  b2Add( &sim->center, &state->deltaPosition, &newCenter );
        sim->center = newCenter;

        // q = normalize( deltaRotation * q )
        b2Rot composed;  b2MulRot( &state->deltaRotation, &sim->transform.q, &composed );
        b2Rot newQ;      b2NormalizeRot( &composed, &newQ );
        sim->transform.q = newQ;

        // --- sleep bookkeeping (Phase C): accumulate or reset the body's sleepTime ---
        // sleepVelocity folds true velocity (farthest-point) and position correction.
        // Must run BEFORE the state deltas are cleared just below.
        b2Body* sbody = &world->bodies.data[ sim->bodyId ];
        b2Vec2 v = state->linearVelocity;
        float maxVelocity = b2Length( &v ) + fabs( state->angularVelocity ) * sim->maxExtent;
        b2Vec2 dpos = state->deltaPosition;
        float maxDeltaPosition = b2Length( &dpos ) + fabs( state->deltaRotation.s ) * sim->maxExtent;
        float sleepVelocity = b2MaxFloat( maxVelocity, 0.5 * inv_dt * maxDeltaPosition );
        if( world->enableSleep == false || ( sim->flags & b2_enableSleep ) == 0 || sleepVelocity > sbody->sleepThreshold )
            sbody->sleepTime = 0.0;
        else
            sbody->sleepTime = sbody->sleepTime + dt;

        // reset state deltas
        state->deltaPosition = b2Vec2_zero;
        state->deltaRotation = b2Rot_identity;

        // transform.p = center - rotate(q, localCenter)
        b2Vec2 rc;   b2RotateVector( &sim->transform.q, &sim->localCenter, &rc );
        b2Vec2 nrc;  b2Neg( &rc, &nrc );
        b2Vec2 newP; b2Add( &sim->center, &nrc, &newP );
        sim->transform.p = newP;

        // reset applied force/torque
        sim->force = b2Vec2_zero;
        sim->torque = 0.0;

        // Continuous collision (opt-in): a fast dynamic body (moved > half its min
        // extent) sweeps against the world and is clamped to the first impact so it
        // can't tunnel. b2SolveContinuous advances the TOI baseline (center0/rotation0)
        // itself -- and needs center0 STILL at the pre-step value here, so this must
        // run before that baseline is touched. Slow bodies just advance the baseline.
        //
        // A fast BULLET is DEFERRED to pass 2 below: it must sweep against moving
        // bodies, whose broad-phase proxies are only trustworthy once every body has
        // finalized. Deferring leaves its center0/rotation0 at the pre-step pose (the
        // sweep origin pass 2 needs) and its proxies unmoved (pass 2 moves them).
        float maxMotion = b2MaxFloat( maxDeltaPosition, maxVelocity * dt );
        bool isFast = world->enableContinuous && sbody->type == b2_dynamicBody
                      && maxMotion > 0.5 * sim->minExtent;
        if( isFast )
        {
            sim->flags = sim->flags | b2_isFast;
            if( ( sim->flags & b2_isBullet ) != 0 )
                continue;                            // pass 2 owns this body entirely
            b2SolveContinuous( world, sbody, sim );
        }
        else
        {
            sim->center0 = sim->center;
            sim->rotation0 = sim->transform.q;
        }

        b2UpdateBodyProxies( world, sim );
    }

    // ---- PASS 2: deferred bullet continuous collision ----
    // Every non-bullet body above has now published its final pose and refit its
    // proxy, so the kinematic and dynamic trees are current and a bullet may sweep
    // against them. (Upstream defers all bullets for exactly this reason.) Bullets
    // reject each other inside the query callback, so a bullet's own stale proxy --
    // still unmoved at this point -- is never read as a target. Nothing here grows
    // the awake arrays, so `sims` stays valid.
    for( i = 0; i < count; ++i )
    {
        b2BodySim* sim = &sims[i];
        if( ( sim->flags & ( b2_isFast | b2_isBullet ) ) != ( b2_isFast | b2_isBullet ) )
            continue;

        b2Body* sbody = &world->bodies.data[ sim->bodyId ];
        b2SolveContinuous( world, sbody, sim );
        b2UpdateBodyProxies( world, sim );
    }
}

// -----------------------------------------------------------------------------
//   Contact constraint solve (port of contact_solver.c -- NORMAL IMPULSE ONLY)
// -----------------------------------------------------------------------------
//   TGS-soft solver, serial, no constraint graph: constraints are built directly
//   from the awake set's touching contactSims into a step-local array. This slice
//   does the NON-PENETRATION (normal) constraint only -- enough for a body to rest
//   on a floor. DEFERRED: friction, restitution, rolling resistance, cross-step
//   warm starting (b2StoreImpulses), islands, and the constraint graph / coloring.
//   (tangentMass + relativeVelocity are still computed so the deferred friction /
//   restitution slices drop in without reworking prepare.)

// b2Softness / b2MakeSoft moved to b2_joint.h (so b2JointSim can embed it,
// ahead of b2_body.h). They arrive here transitively via b2_body.h.

// One solved contact point: fixed anchors + cached masses/impulses.
struct b2ContactConstraintPoint
{
    b2Vec2 anchorA;
    b2Vec2 anchorB;
    float baseSeparation;
    float relativeVelocity;
    float normalImpulse;
    float tangentImpulse;
    float totalNormalImpulse;
    float normalMass;
    float tangentMass;
};

// A per-contact constraint. indexA/B are base-1 (0 == static/null), pointing into
// the awake bodyStates; invMass/invI are cached to avoid touching the bodySim.
struct b2ContactConstraint
{
    int contactIndex;       // source awakeSet->contactSims index (for b2StoreImpulses).
                            // DEVIATION: needed because the port skips non-touching
                            // contacts, so this array is not 1:1 with contactSims.
    int indexA;             // base-1 awake bodyState index (0 = static)
    int indexB;
    b2ContactConstraintPoint[2] points;
    b2Vec2 normal;
    float invMassA;
    float invMassB;
    float invIA;
    float invIB;
    float friction;
    float restitution;
    float tangentSpeed;
    b2Softness softness;
    int pointCount;
};


// ---- prepare: build one constraint point from a manifold point ----
void b2PreparePoint( b2ManifoldPoint* mp, b2ContactConstraintPoint* cp,
                     b2Vec2* normal, b2Vec2* tangent,
                     float mA, float mB, float iA, float iB,
                     b2Vec2* vA, float wA, b2Vec2* vB, float wB )
{
    cp->normalImpulse = mp->normalImpulse;   // seed from cross-step warm start
    cp->tangentImpulse = mp->tangentImpulse;
    cp->totalNormalImpulse = 0.0;

    b2Vec2 rA = mp->anchorA;
    b2Vec2 rB = mp->anchorB;
    cp->anchorA = rA;
    cp->anchorB = rB;

    // baseSeparation = separation - dot(rB - rA, normal)
    b2Vec2 rBmA;  b2Sub( &rB, &rA, &rBmA );
    cp->baseSeparation = mp->separation - b2Dot( &rBmA, normal );

    float rnA = b2Cross( &rA, normal );
    float rnB = b2Cross( &rB, normal );
    float kNormal = mA + mB + iA * rnA * rnA + iB * rnB * rnB;
    if( kNormal > 0.0 ) cp->normalMass = 1.0 / kNormal; else cp->normalMass = 0.0;

    float rtA = b2Cross( &rA, tangent );
    float rtB = b2Cross( &rB, tangent );
    float kTangent = mA + mB + iA * rtA * rtA + iB * rtB * rtB;
    if( kTangent > 0.0 ) cp->tangentMass = 1.0 / kTangent; else cp->tangentMass = 0.0;

    // relative normal velocity (kept for the deferred restitution slice)
    b2Vec2 crA;  b2CrossSV( wA, &rA, &crA );  b2Vec2 vrA;  b2Add( vA, &crA, &vrA );
    b2Vec2 crB;  b2CrossSV( wB, &rB, &crB );  b2Vec2 vrB;  b2Add( vB, &crB, &vrB );
    b2Vec2 dvr;  b2Sub( &vrB, &vrA, &dvr );
    cp->relativeVelocity = b2Dot( normal, &dvr );
}

// Build the constraint array from the awake set's TOUCHING contacts. Returns the
// number of constraints actually built (non-touching contacts are skipped).
int b2PrepareContacts( b2World* world, b2ContactConstraint* constraints,
                       b2Softness* contactSoftness, b2Softness* staticSoftness )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    b2ContactSim* contacts = awakeSet->contactSims.data;
    b2BodyState* states = awakeSet->bodyStates.data;
    int count = awakeSet->contactSims.count;

    int k = 0;
    int i;
    for( i = 0; i < count; ++i )
    {
        b2ContactSim* contactSim = &contacts[i];
        int pointCount = contactSim->manifold.pointCount;
        if( pointCount == 0 )
            continue;   // non-touching contacts are not constrained

        int indexA = contactSim->bodySimIndexA;     // -1 if static
        int indexB = contactSim->bodySimIndexB;

        b2ContactConstraint* constraint = &constraints[k];
        k = k + 1;

        constraint->contactIndex = i;               // remember source contactSim
        constraint->indexA = indexA + 1;            // base-1; 0 == static/null
        constraint->indexB = indexB + 1;
        constraint->normal = contactSim->manifold.normal;
        constraint->friction = contactSim->friction;
        constraint->restitution = contactSim->restitution;
        constraint->tangentSpeed = contactSim->tangentSpeed;
        constraint->pointCount = pointCount;
        constraint->invMassA = contactSim->invMassA;
        constraint->invIA = contactSim->invIA;
        constraint->invMassB = contactSim->invMassB;
        constraint->invIB = contactSim->invIB;

        // stiffer softness when either body is static (avoid push-through)
        if( indexA == B2_NULL_INDEX || indexB == B2_NULL_INDEX )
            constraint->softness = *staticSoftness;
        else
            constraint->softness = *contactSoftness;

        b2Vec2 vA = b2Vec2_zero;  float wA = 0.0;
        if( indexA != B2_NULL_INDEX ) { vA = states[indexA].linearVelocity;  wA = states[indexA].angularVelocity; }
        b2Vec2 vB = b2Vec2_zero;  float wB = 0.0;
        if( indexB != B2_NULL_INDEX ) { vB = states[indexB].linearVelocity;  wB = states[indexB].angularVelocity; }

        b2Vec2 normal = constraint->normal;
        b2Vec2 tangent;  b2RightPerp( &normal, &tangent );

        // constant-index unroll (points[] is a fixed array member of a multi-word struct)
        if( pointCount >= 1 )
            b2PreparePoint( &contactSim->manifold.points[0], &constraint->points[0],
                            &normal, &tangent, constraint->invMassA, constraint->invMassB,
                            constraint->invIA, constraint->invIB, &vA, wA, &vB, wB );
        if( pointCount >= 2 )
            b2PreparePoint( &contactSim->manifold.points[1], &constraint->points[1],
                            &normal, &tangent, constraint->invMassA, constraint->invMassB,
                            constraint->invIA, constraint->invIB, &vA, wA, &vB, wB );
    }
    return k;
}


// ---- warm start: re-apply the accumulated normal + tangent impulse ----
void b2WarmStartPoint( b2ContactConstraintPoint* cp, b2Vec2* normal, b2Vec2* tangent,
                       float mA, float iA, float mB, float iB,
                       b2Vec2* vA, float* wA, b2Vec2* vB, float* wB )
{
    // HOT PATH (5.6): vector helpers inlined as scalar math to kill call overhead.
    // Reference (readable) form is the b2MulSV/b2Add/b2Cross/b2MulSub/b2MulAdd
    // sequence this replaces. Semantics identical.
    float rAx = cp->anchorA.x;  float rAy = cp->anchorA.y;
    float rBx = cp->anchorB.x;  float rBy = cp->anchorB.y;

    // P = normalImpulse*normal + tangentImpulse*tangent
    float Px = cp->normalImpulse * normal->x + cp->tangentImpulse * tangent->x;
    float Py = cp->normalImpulse * normal->y + cp->tangentImpulse * tangent->y;
    cp->totalNormalImpulse = cp->totalNormalImpulse + cp->normalImpulse;

    // b2Cross(r,P) = r.x*P.y - r.y*P.x ; vA -= mA*P ; vB += mB*P
    *wA = *wA - iA * ( rAx * Py - rAy * Px );
    vA->x = vA->x - mA * Px;   vA->y = vA->y - mA * Py;
    *wB = *wB + iB * ( rBx * Py - rBy * Px );
    vB->x = vB->x + mB * Px;   vB->y = vB->y + mB * Py;
}

void b2WarmStartContacts( b2World* world, b2ContactConstraint* constraints, int count )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    b2BodyState* states = awakeSet->bodyStates.data;

    b2BodyState dummy;
    dummy.linearVelocity = b2Vec2_zero;  dummy.angularVelocity = 0.0;  dummy.flags = 0;
    dummy.deltaPosition = b2Vec2_zero;   dummy.deltaRotation = b2Rot_identity;

    int i;
    for( i = 0; i < count; ++i )
    {
        b2ContactConstraint* c = &constraints[i];
        int idxA = c->indexA - 1;
        int idxB = c->indexB - 1;
        b2BodyState* stateA;  if( idxA == B2_NULL_INDEX ) stateA = &dummy; else stateA = &states[idxA];
        b2BodyState* stateB;  if( idxB == B2_NULL_INDEX ) stateB = &dummy; else stateB = &states[idxB];

        b2Vec2 vA = stateA->linearVelocity;  float wA = stateA->angularVelocity;
        b2Vec2 vB = stateB->linearVelocity;  float wB = stateB->angularVelocity;
        b2Vec2 normal = c->normal;
        // tangent = b2RightPerp(normal) = { normal.y, -normal.x } (inlined)
        b2Vec2 tangent;  tangent.x = normal.y;  tangent.y = -normal.x;

        if( c->pointCount >= 1 )
            b2WarmStartPoint( &c->points[0], &normal, &tangent, c->invMassA, c->invIA, c->invMassB, c->invIB, &vA, &wA, &vB, &wB );
        if( c->pointCount >= 2 )
            b2WarmStartPoint( &c->points[1], &normal, &tangent, c->invMassA, c->invIA, c->invMassB, c->invIB, &vA, &wA, &vB, &wB );

        if( idxA != B2_NULL_INDEX ) { stateA->linearVelocity = vA;  stateA->angularVelocity = wA; }
        if( idxB != B2_NULL_INDEX ) { stateB->linearVelocity = vB;  stateB->angularVelocity = wB; }
    }
}


// ---- solve: one normal-impulse iteration (with bias for push-out, or relax) ----
void b2SolveNormalPoint( b2ContactConstraintPoint* cp, b2Vec2* normal,
                         float mA, float iA, float mB, float iB,
                         b2Vec2* dp, b2Rot* dqA, b2Rot* dqB,
                         b2Softness* softness, float inv_h, float contactSpeed, bool useBias,
                         b2Vec2* vA, float* wA, b2Vec2* vB, float* wB )
{
    // HOT PATH (5.6): the two normal-impulse iterations per substep are the single
    // most-executed solver code. Vector helpers inlined as scalar math (identical
    // semantics; reference form is the b2RotateVector/b2Sub/b2Add/b2Dot/b2CrossSV/
    // b2MulSV/b2MulSub/b2MulAdd/b2Cross sequence this replaces).
    float rAx = cp->anchorA.x;  float rAy = cp->anchorA.y;
    float rBx = cp->anchorB.x;  float rBy = cp->anchorB.y;

    // current separation: s = baseSeparation + dot(dp + rot(dqB,rB) - rot(dqA,rA), normal)
    // rot(q,v) = { q.c*v.x - q.s*v.y, q.s*v.x + q.c*v.y }
    float rdBx = dqB->c * rBx - dqB->s * rBy;
    float rdBy = dqB->s * rBx + dqB->c * rBy;
    float rdAx = dqA->c * rAx - dqA->s * rAy;
    float rdAy = dqA->s * rAx + dqA->c * rAy;
    float dsx = dp->x + ( rdBx - rdAx );
    float dsy = dp->y + ( rdBy - rdAy );
    float s = cp->baseSeparation + ( dsx * normal->x + dsy * normal->y );

    float velocityBias = 0.0;
    float massScale = 1.0;
    float impulseScale = 0.0;
    if( s > 0.0 )
    {
        velocityBias = s * inv_h;          // speculative (still separated)
    }
    else if( useBias )
    {
        float b = softness->massScale * softness->biasRate * s;
        velocityBias = b2MaxFloat( b, -contactSpeed );
        massScale = softness->massScale;
        impulseScale = softness->impulseScale;
    }

    // relative normal velocity at the contact
    // vr = v + (w x r) ; (w x r) = { -w*r.y, w*r.x }
    float vrAx = vA->x - (*wA) * rAy;   float vrAy = vA->y + (*wA) * rAx;
    float vrBx = vB->x - (*wB) * rBy;   float vrBy = vB->y + (*wB) * rBx;
    float dvrx = vrBx - vrAx;
    float dvry = vrBy - vrAy;
    float vn = dvrx * normal->x + dvry * normal->y;

    // incremental normal impulse, accumulated impulse clamped >= 0
    float impulse = -cp->normalMass * ( massScale * vn + velocityBias ) - impulseScale * cp->normalImpulse;
    float newImpulse = cp->normalImpulse + impulse;
    if( newImpulse < 0.0 ) newImpulse = 0.0;
    impulse = newImpulse - cp->normalImpulse;
    cp->normalImpulse = newImpulse;
    cp->totalNormalImpulse = cp->totalNormalImpulse + impulse;

    // apply P = impulse * normal
    float Px = impulse * normal->x;
    float Py = impulse * normal->y;
    vA->x = vA->x - mA * Px;   vA->y = vA->y - mA * Py;
    *wA = *wA - iA * ( rAx * Py - rAy * Px );
    vB->x = vB->x + mB * Px;   vB->y = vB->y + mB * Py;
    *wB = *wB + iB * ( rBx * Py - rBy * Px );
}

// ---- friction: tangential impulse, clamped to the friction cone ----
void b2SolveFrictionPoint( b2ContactConstraintPoint* cp, b2Vec2* tangent,
                           float friction, float tangentSpeed,
                           float mA, float iA, float mB, float iB,
                           b2Vec2* vA, float* wA, b2Vec2* vB, float* wB )
{
    // HOT PATH (5.6): vector helpers inlined as scalar math (identical semantics).
    float rAx = cp->anchorA.x;  float rAy = cp->anchorA.y;
    float rBx = cp->anchorB.x;  float rBy = cp->anchorB.y;

    // relative tangent velocity at the contact: vr = v + (w x r), (w x r)={-w*r.y, w*r.x}
    float vrAx = vA->x - (*wA) * rAy;   float vrAy = vA->y + (*wA) * rAx;
    float vrBx = vB->x - (*wB) * rBy;   float vrBy = vB->y + (*wB) * rBx;
    float dvrx = vrBx - vrAx;
    float dvry = vrBy - vrAy;
    float vt = ( dvrx * tangent->x + dvry * tangent->y ) - tangentSpeed;

    // incremental tangent impulse, accumulated impulse clamped to +-friction*normal
    float impulse = cp->tangentMass * ( -vt );
    float maxFriction = friction * cp->normalImpulse;
    float newImpulse = b2ClampFloat( cp->tangentImpulse + impulse, -maxFriction, maxFriction );
    impulse = newImpulse - cp->tangentImpulse;
    cp->tangentImpulse = newImpulse;

    // apply P = impulse * tangent
    float Px = impulse * tangent->x;
    float Py = impulse * tangent->y;
    vA->x = vA->x - mA * Px;   vA->y = vA->y - mA * Py;
    *wA = *wA - iA * ( rAx * Py - rAy * Px );
    vB->x = vB->x + mB * Px;   vB->y = vB->y + mB * Py;
    *wB = *wB + iB * ( rBx * Py - rBy * Px );
}

void b2SolveContacts( b2World* world, b2ContactConstraint* constraints, int count,
                      float inv_h, bool useBias )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    b2BodyState* states = awakeSet->bodyStates.data;
    float contactSpeed = world->contactSpeed;

    b2BodyState dummy;
    dummy.linearVelocity = b2Vec2_zero;  dummy.angularVelocity = 0.0;  dummy.flags = 0;
    dummy.deltaPosition = b2Vec2_zero;   dummy.deltaRotation = b2Rot_identity;

    int i;
    for( i = 0; i < count; ++i )
    {
        b2ContactConstraint* c = &constraints[i];
        int idxA = c->indexA - 1;
        int idxB = c->indexB - 1;
        b2BodyState* stateA;  if( idxA == B2_NULL_INDEX ) stateA = &dummy; else stateA = &states[idxA];
        b2BodyState* stateB;  if( idxB == B2_NULL_INDEX ) stateB = &dummy; else stateB = &states[idxB];

        b2Vec2 vA = stateA->linearVelocity;  float wA = stateA->angularVelocity;
        b2Vec2 vB = stateB->linearVelocity;  float wB = stateB->angularVelocity;
        b2Rot dqA = stateA->deltaRotation;
        b2Rot dqB = stateB->deltaRotation;
        // dp = stateB.deltaPosition - stateA.deltaPosition (b2Sub inlined)
        b2Vec2 dp;
        dp.x = stateB->deltaPosition.x - stateA->deltaPosition.x;
        dp.y = stateB->deltaPosition.y - stateA->deltaPosition.y;

        b2Vec2 normal = c->normal;
        // tangent = b2RightPerp(normal) = { normal.y, -normal.x } (inlined)
        b2Vec2 tangent;  tangent.x = normal.y;  tangent.y = -normal.x;

        // non-penetration (normal) impulses
        if( c->pointCount >= 1 )
            b2SolveNormalPoint( &c->points[0], &normal, c->invMassA, c->invIA, c->invMassB, c->invIB,
                                &dp, &dqA, &dqB, &c->softness, inv_h, contactSpeed, useBias,
                                &vA, &wA, &vB, &wB );
        if( c->pointCount >= 2 )
            b2SolveNormalPoint( &c->points[1], &normal, c->invMassA, c->invIA, c->invMassB, c->invIB,
                                &dp, &dqA, &dqB, &c->softness, inv_h, contactSpeed, useBias,
                                &vA, &wA, &vB, &wB );

        // friction (relax pass only, matching upstream), after the normal solve so
        // maxFriction uses the freshly-updated normalImpulse
        if( useBias == false )
        {
            if( c->pointCount >= 1 )
                b2SolveFrictionPoint( &c->points[0], &tangent, c->friction, c->tangentSpeed,
                                      c->invMassA, c->invIA, c->invMassB, c->invIB, &vA, &wA, &vB, &wB );
            if( c->pointCount >= 2 )
                b2SolveFrictionPoint( &c->points[1], &tangent, c->friction, c->tangentSpeed,
                                      c->invMassA, c->invIA, c->invMassB, c->invIB, &vA, &wA, &vB, &wB );
        }

        if( idxA != B2_NULL_INDEX ) { stateA->linearVelocity = vA;  stateA->angularVelocity = wA; }
        if( idxB != B2_NULL_INDEX ) { stateB->linearVelocity = vB;  stateB->angularVelocity = wB; }
    }
}


// ---- restitution: one bounce impulse for a point (post-substep pass) ----
// Uses the approach velocity captured at prepare (cp->relativeVelocity) to add
// back a rebound. Skipped for points that never actually collided (speculative
// points with no accumulated impulse) or whose approach was below threshold.
void b2ApplyRestitutionPoint( b2ContactConstraintPoint* cp, b2Vec2* normal,
                              float restitution, float threshold,
                              float mA, float iA, float mB, float iB,
                              b2Vec2* vA, float* wA, b2Vec2* vB, float* wB )
{
    // separating (or slow) approach, or no collision impulse -> no bounce
    if( cp->relativeVelocity > -threshold || cp->totalNormalImpulse == 0.0 )
        return;

    // HOT PATH (5.6): vector helpers inlined as scalar math (identical semantics).
    float rAx = cp->anchorA.x;  float rAy = cp->anchorA.y;
    float rBx = cp->anchorB.x;  float rBy = cp->anchorB.y;

    // relative normal velocity at the contact: vr = v + (w x r), (w x r)={-w*r.y, w*r.x}
    float vrAx = vA->x - (*wA) * rAy;   float vrAy = vA->y + (*wA) * rAx;
    float vrBx = vB->x - (*wB) * rBy;   float vrBy = vB->y + (*wB) * rBx;
    float dvrx = vrBx - vrAx;
    float dvry = vrBy - vrAy;
    float vn = dvrx * normal->x + dvry * normal->y;

    // target rebound velocity = restitution * approach speed
    float impulse = -cp->normalMass * ( vn + restitution * cp->relativeVelocity );

    // accumulated impulse clamped >= 0
    float newImpulse = b2MaxFloat( cp->normalImpulse + impulse, 0.0 );
    impulse = newImpulse - cp->normalImpulse;
    cp->normalImpulse = newImpulse;
    cp->totalNormalImpulse = cp->totalNormalImpulse + impulse;

    // apply P = impulse * normal
    float Px = impulse * normal->x;
    float Py = impulse * normal->y;
    vA->x = vA->x - mA * Px;   vA->y = vA->y - mA * Py;
    *wA = *wA - iA * ( rAx * Py - rAy * Px );
    vB->x = vB->x + mB * Px;   vB->y = vB->y + mB * Py;
    *wB = *wB + iB * ( rBx * Py - rBy * Px );
}

// Restitution pass over all constraints (runs once, after the sub-step loop).
// Constraints with restitution 0 are skipped, so this is a no-op unless a shape
// opts in -- the existing (restitution-free) scenes are unaffected.
void b2ApplyRestitution( b2World* world, b2ContactConstraint* constraints, int count )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    b2BodyState* states = awakeSet->bodyStates.data;
    float threshold = world->restitutionThreshold;

    b2BodyState dummy;
    dummy.linearVelocity = b2Vec2_zero;  dummy.angularVelocity = 0.0;  dummy.flags = 0;
    dummy.deltaPosition = b2Vec2_zero;   dummy.deltaRotation = b2Rot_identity;

    int i;
    for( i = 0; i < count; ++i )
    {
        b2ContactConstraint* c = &constraints[i];
        if( c->restitution == 0.0 )
            continue;

        int idxA = c->indexA - 1;
        int idxB = c->indexB - 1;
        b2BodyState* stateA;  if( idxA == B2_NULL_INDEX ) stateA = &dummy; else stateA = &states[idxA];
        b2BodyState* stateB;  if( idxB == B2_NULL_INDEX ) stateB = &dummy; else stateB = &states[idxB];

        b2Vec2 vA = stateA->linearVelocity;  float wA = stateA->angularVelocity;
        b2Vec2 vB = stateB->linearVelocity;  float wB = stateB->angularVelocity;
        b2Vec2 normal = c->normal;

        if( c->pointCount >= 1 )
            b2ApplyRestitutionPoint( &c->points[0], &normal, c->restitution, threshold,
                                     c->invMassA, c->invIA, c->invMassB, c->invIB, &vA, &wA, &vB, &wB );
        if( c->pointCount >= 2 )
            b2ApplyRestitutionPoint( &c->points[1], &normal, c->restitution, threshold,
                                     c->invMassA, c->invIA, c->invMassB, c->invIB, &vA, &wA, &vB, &wB );

        if( idxA != B2_NULL_INDEX ) { stateA->linearVelocity = vA;  stateA->angularVelocity = wA; }
        if( idxB != B2_NULL_INDEX ) { stateB->linearVelocity = vB;  stateB->angularVelocity = wB; }
    }
}


// ---- store impulses: copy solved impulses back to the manifold for next step ----
// Writes each constraint's per-point impulses into its source contactSim manifold
// so the NEXT step's b2UpdateContact can id-match + carry them (cross-step warm
// start). Uses contactIndex because the constraint array is compacted vs contactSims.
void b2StoreImpulses( b2World* world, b2ContactConstraint* constraints, int count )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    b2ContactSim* contacts = awakeSet->contactSims.data;

    int i;
    for( i = 0; i < count; ++i )
    {
        b2ContactConstraint* c = &constraints[i];
        b2Manifold* manifold = &contacts[ c->contactIndex ].manifold;

        // constant-index unroll (points[] is a fixed array member of a multi-word struct)
        if( c->pointCount >= 1 )
        {
            manifold->points[0].normalImpulse = c->points[0].normalImpulse;
            manifold->points[0].tangentImpulse = c->points[0].tangentImpulse;
            manifold->points[0].totalNormalImpulse = c->points[0].totalNormalImpulse;
            manifold->points[0].normalVelocity = c->points[0].relativeVelocity;
        }
        if( c->pointCount >= 2 )
        {
            manifold->points[1].normalImpulse = c->points[1].normalImpulse;
            manifold->points[1].tangentImpulse = c->points[1].tangentImpulse;
            manifold->points[1].totalNormalImpulse = c->points[1].totalNormalImpulse;
            manifold->points[1].normalVelocity = c->points[1].relativeVelocity;
        }
    }
}


// =============================================================================
//   JOINT SOLVE (slice 2)  --  distance joint, RIGID branch only
// =============================================================================
//   Port of b2Prepare/WarmStart/SolveDistanceJoint + the b2PrepareJoint hertz
//   clamp. Serial: iterate the awake set's jointSims directly (no constraint
//   graph, no b2StepContext -- world/h/inv_h passed explicitly; states =
//   awakeSet->bodyStates.data; a local identity dummy stands in for static/null
//   bodies, gated by index == B2_NULL_INDEX exactly like the contact solver).
//   Stage order matches the serial overflow path in box2d/src/solver.c: joints
//   are prepared/warm-started/solved BEFORE contacts each stage.
//   DEFERRED: spring / limit / motor branches (enableSpring defaults false, so
//   the rigid `else` branch always runs), non-distance joint types, cross-step
//   force reporting, events. Add the spring/limit/motor `if` blocks and more
//   joint types as later slices; they drop in without reworking this scaffold.

// Fill a b2BodyState with the static/identity dummy values.
void b2InitDummyBodyState( b2BodyState* dummy )
{
    dummy->linearVelocity = b2Vec2_zero;
    dummy->angularVelocity = 0.0;
    dummy->flags = 0;
    dummy->deltaPosition = b2Vec2_zero;
    dummy->deltaRotation = b2Rot_identity;
}

void b2PrepareDistanceJoint( b2World* world, b2JointSim* base, float h )
{
    int idA = base->bodyIdA;
    int idB = base->bodyIdB;
    b2Body* bodyA = &world->bodies.data[ idA ];
    b2Body* bodyB = &world->bodies.data[ idB ];
    b2SolverSet* setA = &world->solverSets.data[ bodyA->setIndex ];
    b2SolverSet* setB = &world->solverSets.data[ bodyB->setIndex ];
    b2BodySim* bodySimA = &setA->bodySims.data[ bodyA->localIndex ];
    b2BodySim* bodySimB = &setB->bodySims.data[ bodyB->localIndex ];

    float mA = bodySimA->invMass;
    float iA = bodySimA->invInertia;
    float mB = bodySimB->invMass;
    float iB = bodySimB->invInertia;
    base->invMassA = mA;  base->invMassB = mB;  base->invIA = iA;  base->invIB = iB;

    b2DistanceJoint* joint = &base->u.distanceJoint;
    if( bodyA->setIndex == b2_awakeSet )  joint->indexA = bodyA->localIndex;  else joint->indexA = B2_NULL_INDEX;
    if( bodyB->setIndex == b2_awakeSet )  joint->indexB = bodyB->localIndex;  else joint->indexB = B2_NULL_INDEX;

    // initial anchors in world space (relative to center of mass)
    b2Vec2 lfpA;  b2Sub( &base->localFrameA.p, &bodySimA->localCenter, &lfpA );
    b2RotateVector( &bodySimA->transform.q, &lfpA, &joint->anchorA );
    b2Vec2 lfpB;  b2Sub( &base->localFrameB.p, &bodySimB->localCenter, &lfpB );
    b2RotateVector( &bodySimB->transform.q, &lfpB, &joint->anchorB );
    b2Sub( &bodySimB->center, &bodySimA->center, &joint->deltaCenter );

    b2Vec2 rA = joint->anchorA;
    b2Vec2 rB = joint->anchorB;
    b2Vec2 rBmA;        b2Sub( &rB, &rA, &rBmA );
    b2Vec2 separation;  b2Add( &rBmA, &joint->deltaCenter, &separation );
    b2Vec2 axis;        b2Normalize( &separation, &axis );

    float crA = b2Cross( &rA, &axis );
    float crB = b2Cross( &rB, &axis );
    float k = mA + mB + iA * crA * crA + iB * crB * crB;
    if( k > 0.0 )  joint->axialMass = 1.0 / k;  else joint->axialMass = 0.0;

    b2MakeSoft( joint->hertz, joint->dampingRatio, h, &joint->distanceSoftness );
    // warm starting is always on in this port -> keep the accumulated impulses.
}

void b2WarmStartDistanceJoint( b2World* world, b2JointSim* base )
{
    b2BodyState* states = world->solverSets.data[ b2_awakeSet ].bodyStates.data;
    b2BodyState dummy;  b2InitDummyBodyState( &dummy );

    float mA = base->invMassA;  float mB = base->invMassB;
    float iA = base->invIA;     float iB = base->invIB;

    b2DistanceJoint* joint = &base->u.distanceJoint;
    b2BodyState* stateA;  if( joint->indexA == B2_NULL_INDEX ) stateA = &dummy;  else stateA = &states[ joint->indexA ];
    b2BodyState* stateB;  if( joint->indexB == B2_NULL_INDEX ) stateB = &dummy;  else stateB = &states[ joint->indexB ];

    b2Vec2 rA;  b2RotateVector( &stateA->deltaRotation, &joint->anchorA, &rA );
    b2Vec2 rB;  b2RotateVector( &stateB->deltaRotation, &joint->anchorB, &rB );

    // axis from the current separation
    b2Vec2 dpDiff;  b2Sub( &stateB->deltaPosition, &stateA->deltaPosition, &dpDiff );
    b2Vec2 rDiff;   b2Sub( &rB, &rA, &rDiff );
    b2Vec2 ds;      b2Add( &dpDiff, &rDiff, &ds );
    b2Vec2 separation;  b2Add( &joint->deltaCenter, &ds, &separation );
    b2Vec2 axis;    b2Normalize( &separation, &axis );

    float axialImpulse = joint->impulse + joint->lowerImpulse - joint->upperImpulse + joint->motorImpulse;
    b2Vec2 P;  b2MulSV( axialImpulse, &axis, &P );

    if( joint->indexA != B2_NULL_INDEX )
    {
        b2Vec2 nv;  b2MulSub( &stateA->linearVelocity, mA, &P, &nv );  stateA->linearVelocity = nv;
        stateA->angularVelocity = stateA->angularVelocity - iA * b2Cross( &rA, &P );
    }
    if( joint->indexB != B2_NULL_INDEX )
    {
        b2Vec2 nv;  b2MulAdd( &stateB->linearVelocity, mB, &P, &nv );  stateB->linearVelocity = nv;
        stateB->angularVelocity = stateB->angularVelocity + iB * b2Cross( &rB, &P );
    }
}

void b2SolveDistanceJoint( b2World* world, b2JointSim* base, float h, float inv_h, bool useBias )
{
    b2BodyState* states = world->solverSets.data[ b2_awakeSet ].bodyStates.data;
    b2BodyState dummy;  b2InitDummyBodyState( &dummy );

    float mA = base->invMassA;  float mB = base->invMassB;
    float iA = base->invIA;     float iB = base->invIB;

    b2DistanceJoint* joint = &base->u.distanceJoint;
    b2BodyState* stateA;  if( joint->indexA == B2_NULL_INDEX ) stateA = &dummy;  else stateA = &states[ joint->indexA ];
    b2BodyState* stateB;  if( joint->indexB == B2_NULL_INDEX ) stateB = &dummy;  else stateB = &states[ joint->indexB ];

    b2Vec2 vA = stateA->linearVelocity;  float wA = stateA->angularVelocity;
    b2Vec2 vB = stateB->linearVelocity;  float wB = stateB->angularVelocity;

    // current anchors + separation
    b2Vec2 rA;  b2RotateVector( &stateA->deltaRotation, &joint->anchorA, &rA );
    b2Vec2 rB;  b2RotateVector( &stateB->deltaRotation, &joint->anchorB, &rB );
    b2Vec2 dpDiff;  b2Sub( &stateB->deltaPosition, &stateA->deltaPosition, &dpDiff );
    b2Vec2 rDiff;   b2Sub( &rB, &rA, &rDiff );
    b2Vec2 ds;      b2Add( &dpDiff, &rDiff, &ds );
    b2Vec2 separation;  b2Add( &joint->deltaCenter, &ds, &separation );
    float length = b2Length( &separation );
    b2Vec2 axis;    b2Normalize( &separation, &axis );

    // Soft path when the spring is enabled AND it isn't a rigid-length limit
    // (minLength < maxLength, or no limit at all). Otherwise fall to the rigid
    // else -- which is bit-identical to the pre-spring port, so existing distance
    // tests can't regress. (Ported verbatim from box2d/src/distance_joint.c.)
    if( joint->enableSpring && ( joint->minLength < joint->maxLength || joint->enableLimit == false ) )
    {
        // spring (soft equality to rest length)
        if( joint->hertz > 0.0 )
        {
            b2Vec2 vBmvA;   b2Sub( &vB, &vA, &vBmvA );
            b2Vec2 crB;     b2CrossSV( wB, &rB, &crB );
            b2Vec2 crA;     b2CrossSV( wA, &rA, &crA );
            b2Vec2 crDiff;  b2Sub( &crB, &crA, &crDiff );
            b2Vec2 vr;      b2Add( &vBmvA, &crDiff, &vr );
            float Cdot = b2Dot( &axis, &vr );
            float C = length - joint->length;
            float bias = joint->distanceSoftness.biasRate * C;
            float m = joint->distanceSoftness.massScale * joint->axialMass;
            float oldImpulse = joint->impulse;
            float impulse = -m * ( Cdot + bias ) - joint->distanceSoftness.impulseScale * oldImpulse;
            joint->impulse = b2ClampFloat( joint->impulse + impulse,
                                           joint->lowerSpringForce * h, joint->upperSpringForce * h );
            impulse = joint->impulse - oldImpulse;

            b2Vec2 P;  b2MulSV( impulse, &axis, &P );
            b2Vec2 nvA;  b2MulSub( &vA, mA, &P, &nvA );  vA = nvA;  wA = wA - iA * b2Cross( &rA, &P );
            b2Vec2 nvB;  b2MulAdd( &vB, mB, &P, &nvB );  vB = nvB;  wB = wB + iB * b2Cross( &rB, &P );
        }

        // motor (drive the length rate toward motorSpeed, force-limited)
        if( joint->enableMotor )
        {
            b2Vec2 vBmvA;   b2Sub( &vB, &vA, &vBmvA );
            b2Vec2 crB;     b2CrossSV( wB, &rB, &crB );
            b2Vec2 crA;     b2CrossSV( wA, &rA, &crA );
            b2Vec2 crDiff;  b2Sub( &crB, &crA, &crDiff );
            b2Vec2 vr;      b2Add( &vBmvA, &crDiff, &vr );
            float Cdot = b2Dot( &axis, &vr );
            float impulse = joint->axialMass * ( joint->motorSpeed - Cdot );
            float oldImpulse = joint->motorImpulse;
            float maxImpulse = h * joint->maxMotorForce;
            joint->motorImpulse = b2ClampFloat( joint->motorImpulse + impulse, -maxImpulse, maxImpulse );
            impulse = joint->motorImpulse - oldImpulse;

            b2Vec2 P;  b2MulSV( impulse, &axis, &P );
            b2Vec2 nvA;  b2MulSub( &vA, mA, &P, &nvA );  vA = nvA;  wA = wA - iA * b2Cross( &rA, &P );
            b2Vec2 nvB;  b2MulAdd( &vB, mB, &P, &nvB );  vB = nvB;  wB = wB + iB * b2Cross( &rB, &P );
        }

        // limits (min / max length, speculative when not yet violated)
        if( joint->enableLimit )
        {
            // lower limit: length >= minLength
            {
                b2Vec2 vBmvA;   b2Sub( &vB, &vA, &vBmvA );
                b2Vec2 crB;     b2CrossSV( wB, &rB, &crB );
                b2Vec2 crA;     b2CrossSV( wA, &rA, &crA );
                b2Vec2 crDiff;  b2Sub( &crB, &crA, &crDiff );
                b2Vec2 vr;      b2Add( &vBmvA, &crDiff, &vr );
                float Cdot = b2Dot( &axis, &vr );
                float C = length - joint->minLength;
                float bias = 0.0;
                float massCoeff = 1.0;
                float impulseCoeff = 0.0;
                if( C > 0.0 )
                    bias = C * inv_h;              // speculative
                else if( useBias )
                {
                    bias = base->constraintSoftness.biasRate * C;
                    massCoeff = base->constraintSoftness.massScale;
                    impulseCoeff = base->constraintSoftness.impulseScale;
                }
                float impulse = -massCoeff * joint->axialMass * ( Cdot + bias ) - impulseCoeff * joint->lowerImpulse;
                float newImpulse = b2MaxFloat( 0.0, joint->lowerImpulse + impulse );
                impulse = newImpulse - joint->lowerImpulse;
                joint->lowerImpulse = newImpulse;

                b2Vec2 P;  b2MulSV( impulse, &axis, &P );
                b2Vec2 nvA;  b2MulSub( &vA, mA, &P, &nvA );  vA = nvA;  wA = wA - iA * b2Cross( &rA, &P );
                b2Vec2 nvB;  b2MulAdd( &vB, mB, &P, &nvB );  vB = nvB;  wB = wB + iB * b2Cross( &rB, &P );
            }
            // upper limit: length <= maxLength (impulse pulls the anchors together)
            {
                b2Vec2 vAmvB;   b2Sub( &vA, &vB, &vAmvB );
                b2Vec2 crA;     b2CrossSV( wA, &rA, &crA );
                b2Vec2 crB;     b2CrossSV( wB, &rB, &crB );
                b2Vec2 crDiff;  b2Sub( &crA, &crB, &crDiff );
                b2Vec2 vr;      b2Add( &vAmvB, &crDiff, &vr );
                float Cdot = b2Dot( &axis, &vr );
                float C = joint->maxLength - length;
                float bias = 0.0;
                float massCoeff = 1.0;
                float impulseCoeff = 0.0;
                if( C > 0.0 )
                    bias = C * inv_h;              // speculative
                else if( useBias )
                {
                    bias = base->constraintSoftness.biasRate * C;
                    massCoeff = base->constraintSoftness.massScale;
                    impulseCoeff = base->constraintSoftness.impulseScale;
                }
                float impulse = -massCoeff * joint->axialMass * ( Cdot + bias ) - impulseCoeff * joint->upperImpulse;
                float newImpulse = b2MaxFloat( 0.0, joint->upperImpulse + impulse );
                impulse = newImpulse - joint->upperImpulse;
                joint->upperImpulse = newImpulse;

                b2Vec2 P;  b2MulSV( -impulse, &axis, &P );
                b2Vec2 nvA;  b2MulSub( &vA, mA, &P, &nvA );  vA = nvA;  wA = wA - iA * b2Cross( &rA, &P );
                b2Vec2 nvB;  b2MulAdd( &vB, mB, &P, &nvB );  vB = nvB;  wB = wB + iB * b2Cross( &rB, &P );
            }
        }
    }
    else
    {
        // RIGID constraint (enableSpring == false). Cdot = dot(axis, vr).
        b2Vec2 vBmvA;   b2Sub( &vB, &vA, &vBmvA );
        b2Vec2 crB;     b2CrossSV( wB, &rB, &crB );
        b2Vec2 crA;     b2CrossSV( wA, &rA, &crA );
        b2Vec2 crDiff;  b2Sub( &crB, &crA, &crDiff );
        b2Vec2 vr;      b2Add( &vBmvA, &crDiff, &vr );
        float Cdot = b2Dot( &axis, &vr );

        float C = length - joint->length;
        float bias = 0.0;
        float massScale = 1.0;
        float impulseScale = 0.0;
        if( useBias )
        {
            bias = base->constraintSoftness.biasRate * C;
            massScale = base->constraintSoftness.massScale;
            impulseScale = base->constraintSoftness.impulseScale;
        }

        float impulse = -massScale * joint->axialMass * ( Cdot + bias ) - impulseScale * joint->impulse;
        joint->impulse = joint->impulse + impulse;

        b2Vec2 P;  b2MulSV( impulse, &axis, &P );
        b2Vec2 nvA;  b2MulSub( &vA, mA, &P, &nvA );  vA = nvA;
        wA = wA - iA * b2Cross( &rA, &P );
        b2Vec2 nvB;  b2MulAdd( &vB, mB, &P, &nvB );  vB = nvB;
        wB = wB + iB * b2Cross( &rB, &P );
    }

    if( joint->indexA != B2_NULL_INDEX ) { stateA->linearVelocity = vA;  stateA->angularVelocity = wA; }
    if( joint->indexB != B2_NULL_INDEX ) { stateB->linearVelocity = vB;  stateB->angularVelocity = wB; }
}

// =============================================================================
//   REVOLUTE JOINT (hinge)  --  point-to-point + spring / motor / angle limits
// =============================================================================
//   Port of b2Prepare/WarmStart/SolveRevoluteJoint. The 2x2 point-to-point block
//   pins the two anchor frames (the hinge); the axial spring/motor/limit blocks
//   (gated on enableSpring/enableMotor/enableLimit, all default false) drive or
//   bound the hinge angle. All four impulses are warm-started. Enable a feature by
//   setting the b2RevoluteJoint fields on the jointSim (motorSpeed/maxMotorTorque,
//   lower/upperAngle, hertz/dampingRatio/targetAngle); public setter API deferred.

void b2PrepareRevoluteJoint( b2World* world, b2JointSim* base, float h )
{
    int idA = base->bodyIdA;
    int idB = base->bodyIdB;
    b2Body* bodyA = &world->bodies.data[ idA ];
    b2Body* bodyB = &world->bodies.data[ idB ];
    b2SolverSet* setA = &world->solverSets.data[ bodyA->setIndex ];
    b2SolverSet* setB = &world->solverSets.data[ bodyB->setIndex ];
    b2BodySim* bodySimA = &setA->bodySims.data[ bodyA->localIndex ];
    b2BodySim* bodySimB = &setB->bodySims.data[ bodyB->localIndex ];

    float mA = bodySimA->invMass;
    float iA = bodySimA->invInertia;
    float mB = bodySimB->invMass;
    float iB = bodySimB->invInertia;
    base->invMassA = mA;  base->invMassB = mB;  base->invIA = iA;  base->invIB = iB;

    b2RevoluteJoint* joint = &base->u.revoluteJoint;
    if( bodyA->setIndex == b2_awakeSet )  joint->indexA = bodyA->localIndex;  else joint->indexA = B2_NULL_INDEX;
    if( bodyB->setIndex == b2_awakeSet )  joint->indexB = bodyB->localIndex;  else joint->indexB = B2_NULL_INDEX;

    // world-space anchor frames, relative to center of mass
    b2MulRot( &bodySimA->transform.q, &base->localFrameA.q, &joint->frameA.q );
    b2Vec2 lfpA;  b2Sub( &base->localFrameA.p, &bodySimA->localCenter, &lfpA );
    b2RotateVector( &bodySimA->transform.q, &lfpA, &joint->frameA.p );
    b2MulRot( &bodySimB->transform.q, &base->localFrameB.q, &joint->frameB.q );
    b2Vec2 lfpB;  b2Sub( &base->localFrameB.p, &bodySimB->localCenter, &lfpB );
    b2RotateVector( &bodySimB->transform.q, &lfpB, &joint->frameB.p );

    b2Sub( &bodySimB->center, &bodySimA->center, &joint->deltaCenter );

    float k = iA + iB;
    if( k > 0.0 )  joint->axialMass = 1.0 / k;  else joint->axialMass = 0.0;

    b2MakeSoft( joint->hertz, joint->dampingRatio, h, &joint->springSoftness );
    // warm starting is always on -> keep accumulated impulses.
}

void b2WarmStartRevoluteJoint( b2World* world, b2JointSim* base )
{
    b2BodyState* states = world->solverSets.data[ b2_awakeSet ].bodyStates.data;
    b2BodyState dummy;  b2InitDummyBodyState( &dummy );

    float mA = base->invMassA;  float mB = base->invMassB;
    float iA = base->invIA;     float iB = base->invIB;

    b2RevoluteJoint* joint = &base->u.revoluteJoint;
    b2BodyState* stateA;  if( joint->indexA == B2_NULL_INDEX ) stateA = &dummy;  else stateA = &states[ joint->indexA ];
    b2BodyState* stateB;  if( joint->indexB == B2_NULL_INDEX ) stateB = &dummy;  else stateB = &states[ joint->indexB ];

    b2Vec2 rA;  b2RotateVector( &stateA->deltaRotation, &joint->frameA.p, &rA );
    b2Vec2 rB;  b2RotateVector( &stateB->deltaRotation, &joint->frameB.p, &rB );

    // axial impulse is 0 in the point-to-point-only build (motor/spring/limit off)
    float axialImpulse = joint->springImpulse + joint->motorImpulse + joint->lowerImpulse - joint->upperImpulse;

    if( joint->indexA != B2_NULL_INDEX )
    {
        b2Vec2 nv;  b2MulSub( &stateA->linearVelocity, mA, &joint->linearImpulse, &nv );  stateA->linearVelocity = nv;
        stateA->angularVelocity = stateA->angularVelocity - iA * ( b2Cross( &rA, &joint->linearImpulse ) + axialImpulse );
    }
    if( joint->indexB != B2_NULL_INDEX )
    {
        b2Vec2 nv;  b2MulAdd( &stateB->linearVelocity, mB, &joint->linearImpulse, &nv );  stateB->linearVelocity = nv;
        stateB->angularVelocity = stateB->angularVelocity + iB * ( b2Cross( &rB, &joint->linearImpulse ) + axialImpulse );
    }
}

void b2SolveRevoluteJoint( b2World* world, b2JointSim* base, float h, float inv_h, bool useBias )
{
    b2BodyState* states = world->solverSets.data[ b2_awakeSet ].bodyStates.data;
    b2BodyState dummy;  b2InitDummyBodyState( &dummy );

    float mA = base->invMassA;  float mB = base->invMassB;
    float iA = base->invIA;     float iB = base->invIB;

    b2RevoluteJoint* joint = &base->u.revoluteJoint;
    b2BodyState* stateA;  if( joint->indexA == B2_NULL_INDEX ) stateA = &dummy;  else stateA = &states[ joint->indexA ];
    b2BodyState* stateB;  if( joint->indexB == B2_NULL_INDEX ) stateB = &dummy;  else stateB = &states[ joint->indexB ];

    b2Vec2 vA = stateA->linearVelocity;  float wA = stateA->angularVelocity;
    b2Vec2 vB = stateB->linearVelocity;  float wB = stateB->angularVelocity;

    // relative rotation of the two frames (for spring / motor / limit)
    b2Rot qA;    b2MulRot( &stateA->deltaRotation, &joint->frameA.q, &qA );
    b2Rot qB;    b2MulRot( &stateB->deltaRotation, &joint->frameB.q, &qB );
    b2Rot relQ;  b2InvMulRot( &qA, &qB, &relQ );
    bool fixedRotation = ( iA + iB == 0.0 );

    // --- spring: drive the hinge angle toward targetAngle ---
    if( joint->enableSpring && fixedRotation == false )
    {
        float jointAngle = b2Rot_GetAngle( &relQ );
        float C = b2UnwindAngle( jointAngle - joint->targetAngle );
        float sbias = joint->springSoftness.biasRate * C;
        float smassScale = joint->springSoftness.massScale;
        float simpulseScale = joint->springSoftness.impulseScale;
        float Cdot = wB - wA;
        float impulse = -smassScale * joint->axialMass * ( Cdot + sbias ) - simpulseScale * joint->springImpulse;
        joint->springImpulse = joint->springImpulse + impulse;
        wA = wA - iA * impulse;
        wB = wB + iB * impulse;
    }

    // --- motor: drive the hinge speed toward motorSpeed (torque-limited) ---
    if( joint->enableMotor && fixedRotation == false )
    {
        float Cdot = wB - wA - joint->motorSpeed;
        float impulse = -joint->axialMass * Cdot;
        float oldImpulse = joint->motorImpulse;
        float maxImpulse = h * joint->maxMotorTorque;
        joint->motorImpulse = b2ClampFloat( joint->motorImpulse + impulse, -maxImpulse, maxImpulse );
        impulse = joint->motorImpulse - oldImpulse;
        wA = wA - iA * impulse;
        wB = wB + iB * impulse;
    }

    // --- angle limits ---
    if( joint->enableLimit && fixedRotation == false )
    {
        float jointAngle = b2Rot_GetAngle( &relQ );

        // lower limit
        {
            float C = jointAngle - joint->lowerAngle;
            float lbias = 0.0;  float lmassScale = 1.0;  float limpulseScale = 0.0;
            if( C > 0.0 )
                lbias = C * inv_h;                       // speculative
            else if( useBias )
            {
                lbias = base->constraintSoftness.biasRate * C;
                lmassScale = base->constraintSoftness.massScale;
                limpulseScale = base->constraintSoftness.impulseScale;
            }
            float Cdot = wB - wA;
            float oldImpulse = joint->lowerImpulse;
            float impulse = -lmassScale * joint->axialMass * ( Cdot + lbias ) - limpulseScale * oldImpulse;
            joint->lowerImpulse = b2MaxFloat( oldImpulse + impulse, 0.0 );
            impulse = joint->lowerImpulse - oldImpulse;
            wA = wA - iA * impulse;
            wB = wB + iB * impulse;
        }

        // upper limit (signs flipped so C stays positive when satisfied)
        {
            float C = joint->upperAngle - jointAngle;
            float ubias = 0.0;  float umassScale = 1.0;  float uimpulseScale = 0.0;
            if( C > 0.0 )
                ubias = C * inv_h;                       // speculative
            else if( useBias )
            {
                ubias = base->constraintSoftness.biasRate * C;
                umassScale = base->constraintSoftness.massScale;
                uimpulseScale = base->constraintSoftness.impulseScale;
            }
            float Cdot = wA - wB;                         // sign flipped
            float oldImpulse = joint->upperImpulse;
            float impulse = -umassScale * joint->axialMass * ( Cdot + ubias ) - uimpulseScale * oldImpulse;
            joint->upperImpulse = b2MaxFloat( oldImpulse + impulse, 0.0 );
            impulse = joint->upperImpulse - oldImpulse;
            wA = wA + iA * impulse;                       // sign flipped
            wB = wB - iB * impulse;
        }
    }

    // --- point-to-point (hinge) constraint: J = [-I -skew(rA) I skew(rB)] ---
    b2Vec2 rA;  b2RotateVector( &stateA->deltaRotation, &joint->frameA.p, &rA );
    b2Vec2 rB;  b2RotateVector( &stateB->deltaRotation, &joint->frameB.p, &rB );

    // Cdot = (vB + wB x rB) - (vA + wA x rA)
    b2Vec2 crB;   b2CrossSV( wB, &rB, &crB );
    b2Vec2 vBpc;  b2Add( &vB, &crB, &vBpc );
    b2Vec2 crA;   b2CrossSV( wA, &rA, &crA );
    b2Vec2 vApc;  b2Add( &vA, &crA, &vApc );
    b2Vec2 Cdot;  b2Sub( &vBpc, &vApc, &Cdot );

    b2Vec2 bias = b2Vec2_zero;
    float massScale = 1.0;
    float impulseScale = 0.0;
    if( useBias )
    {
        // separation = (dcB - dcA) + (rB - rA) + deltaCenter
        b2Vec2 dcDiff;  b2Sub( &stateB->deltaPosition, &stateA->deltaPosition, &dcDiff );
        b2Vec2 rDiff;   b2Sub( &rB, &rA, &rDiff );
        b2Vec2 sep1;    b2Add( &dcDiff, &rDiff, &sep1 );
        b2Vec2 separation;  b2Add( &sep1, &joint->deltaCenter, &separation );
        b2MulSV( base->constraintSoftness.biasRate, &separation, &bias );
        massScale = base->constraintSoftness.massScale;
        impulseScale = base->constraintSoftness.impulseScale;
    }

    // K = J * invM * J^T (2x2)
    b2Mat22 K;
    K.cx.x = mA + mB + rA.y * rA.y * iA + rB.y * rB.y * iB;
    K.cy.x = -rA.y * rA.x * iA - rB.y * rB.x * iB;
    K.cx.y = K.cy.x;
    K.cy.y = mA + mB + rA.x * rA.x * iA + rB.x * rB.x * iB;

    b2Vec2 rhs;  b2Add( &Cdot, &bias, &rhs );
    b2Vec2 b;    b2Solve22( &K, &rhs, &b );

    b2Vec2 impulse;
    impulse.x = -massScale * b.x - impulseScale * joint->linearImpulse.x;
    impulse.y = -massScale * b.y - impulseScale * joint->linearImpulse.y;
    joint->linearImpulse.x = joint->linearImpulse.x + impulse.x;
    joint->linearImpulse.y = joint->linearImpulse.y + impulse.y;

    b2Vec2 nvA;  b2MulSub( &vA, mA, &impulse, &nvA );  vA = nvA;
    wA = wA - iA * b2Cross( &rA, &impulse );
    b2Vec2 nvB;  b2MulAdd( &vB, mB, &impulse, &nvB );  vB = nvB;
    wB = wB + iB * b2Cross( &rB, &impulse );

    if( joint->indexA != B2_NULL_INDEX ) { stateA->linearVelocity = vA;  stateA->angularVelocity = wA; }
    if( joint->indexB != B2_NULL_INDEX ) { stateB->linearVelocity = vB;  stateB->angularVelocity = wB; }
}


// =============================================================================
//   WELD JOINT  --  rigid 2-D point-to-point + scalar angular lock
// =============================================================================
//   Port of b2Prepare/WarmStart/SolveWeldJoint (the non-block #else path -- the
//   3x3 block solve is disabled upstream too). The linear block is identical to
//   the revolute point-to-point; the added angular block locks relative rotation.
//   Rigid weld: linearHertz==angularHertz==0 -> both springs use the base
//   constraintSoftness. Nonzero hertz (soft weld / spring) is supported by the
//   same code (the spring softness is built in prepare).

void b2PrepareWeldJoint( b2World* world, b2JointSim* base, float h )
{
    int idA = base->bodyIdA;
    int idB = base->bodyIdB;
    b2Body* bodyA = &world->bodies.data[ idA ];
    b2Body* bodyB = &world->bodies.data[ idB ];
    b2SolverSet* setA = &world->solverSets.data[ bodyA->setIndex ];
    b2SolverSet* setB = &world->solverSets.data[ bodyB->setIndex ];
    b2BodySim* bodySimA = &setA->bodySims.data[ bodyA->localIndex ];
    b2BodySim* bodySimB = &setB->bodySims.data[ bodyB->localIndex ];

    float mA = bodySimA->invMass;
    float iA = bodySimA->invInertia;
    float mB = bodySimB->invMass;
    float iB = bodySimB->invInertia;
    base->invMassA = mA;  base->invMassB = mB;  base->invIA = iA;  base->invIB = iB;

    b2WeldJoint* joint = &base->u.weldJoint;
    if( bodyA->setIndex == b2_awakeSet )  joint->indexA = bodyA->localIndex;  else joint->indexA = B2_NULL_INDEX;
    if( bodyB->setIndex == b2_awakeSet )  joint->indexB = bodyB->localIndex;  else joint->indexB = B2_NULL_INDEX;

    b2MulRot( &bodySimA->transform.q, &base->localFrameA.q, &joint->frameA.q );
    b2Vec2 lfpA;  b2Sub( &base->localFrameA.p, &bodySimA->localCenter, &lfpA );
    b2RotateVector( &bodySimA->transform.q, &lfpA, &joint->frameA.p );
    b2MulRot( &bodySimB->transform.q, &base->localFrameB.q, &joint->frameB.q );
    b2Vec2 lfpB;  b2Sub( &base->localFrameB.p, &bodySimB->localCenter, &lfpB );
    b2RotateVector( &bodySimB->transform.q, &lfpB, &joint->frameB.p );

    b2Sub( &bodySimB->center, &bodySimA->center, &joint->deltaCenter );

    float ka = iA + iB;
    if( ka > 0.0 )  joint->axialMass = 1.0 / ka;  else joint->axialMass = 0.0;

    if( joint->linearHertz == 0.0 )
        joint->linearSpring = base->constraintSoftness;
    else
        b2MakeSoft( joint->linearHertz, joint->linearDampingRatio, h, &joint->linearSpring );

    if( joint->angularHertz == 0.0 )
        joint->angularSpring = base->constraintSoftness;
    else
        b2MakeSoft( joint->angularHertz, joint->angularDampingRatio, h, &joint->angularSpring );
}

void b2WarmStartWeldJoint( b2World* world, b2JointSim* base )
{
    b2BodyState* states = world->solverSets.data[ b2_awakeSet ].bodyStates.data;
    b2BodyState dummy;  b2InitDummyBodyState( &dummy );

    float mA = base->invMassA;  float mB = base->invMassB;
    float iA = base->invIA;     float iB = base->invIB;

    b2WeldJoint* joint = &base->u.weldJoint;
    b2BodyState* stateA;  if( joint->indexA == B2_NULL_INDEX ) stateA = &dummy;  else stateA = &states[ joint->indexA ];
    b2BodyState* stateB;  if( joint->indexB == B2_NULL_INDEX ) stateB = &dummy;  else stateB = &states[ joint->indexB ];

    b2Vec2 rA;  b2RotateVector( &stateA->deltaRotation, &joint->frameA.p, &rA );
    b2Vec2 rB;  b2RotateVector( &stateB->deltaRotation, &joint->frameB.p, &rB );

    if( joint->indexA != B2_NULL_INDEX )
    {
        b2Vec2 nv;  b2MulSub( &stateA->linearVelocity, mA, &joint->linearImpulse, &nv );  stateA->linearVelocity = nv;
        stateA->angularVelocity = stateA->angularVelocity - iA * ( b2Cross( &rA, &joint->linearImpulse ) + joint->angularImpulse );
    }
    if( joint->indexB != B2_NULL_INDEX )
    {
        b2Vec2 nv;  b2MulAdd( &stateB->linearVelocity, mB, &joint->linearImpulse, &nv );  stateB->linearVelocity = nv;
        stateB->angularVelocity = stateB->angularVelocity + iB * ( b2Cross( &rB, &joint->linearImpulse ) + joint->angularImpulse );
    }
}

void b2SolveWeldJoint( b2World* world, b2JointSim* base, bool useBias )
{
    b2BodyState* states = world->solverSets.data[ b2_awakeSet ].bodyStates.data;
    b2BodyState dummy;  b2InitDummyBodyState( &dummy );

    float mA = base->invMassA;  float mB = base->invMassB;
    float iA = base->invIA;     float iB = base->invIB;

    b2WeldJoint* joint = &base->u.weldJoint;
    b2BodyState* stateA;  if( joint->indexA == B2_NULL_INDEX ) stateA = &dummy;  else stateA = &states[ joint->indexA ];
    b2BodyState* stateB;  if( joint->indexB == B2_NULL_INDEX ) stateB = &dummy;  else stateB = &states[ joint->indexB ];

    b2Vec2 vA = stateA->linearVelocity;  float wA = stateA->angularVelocity;
    b2Vec2 vB = stateB->linearVelocity;  float wB = stateB->angularVelocity;

    // --- angular constraint: C = relative angle of the two frames ---
    {
        b2Rot qA;   b2MulRot( &stateA->deltaRotation, &joint->frameA.q, &qA );
        b2Rot qB;   b2MulRot( &stateB->deltaRotation, &joint->frameB.q, &qB );
        b2Rot relQ; b2InvMulRot( &qA, &qB, &relQ );
        float jointAngle = b2Rot_GetAngle( &relQ );

        float bias = 0.0;
        float massScale = 1.0;
        float impulseScale = 0.0;
        if( useBias || joint->angularHertz > 0.0 )
        {
            bias = joint->angularSpring.biasRate * jointAngle;
            massScale = joint->angularSpring.massScale;
            impulseScale = joint->angularSpring.impulseScale;
        }

        float Cdot = wB - wA;
        float impulse = -massScale * joint->axialMass * ( Cdot + bias ) - impulseScale * joint->angularImpulse;
        joint->angularImpulse = joint->angularImpulse + impulse;

        wA = wA - iA * impulse;
        wB = wB + iB * impulse;
    }

    // --- linear constraint: 2x2 point-to-point (same K as revolute) ---
    {
        b2Vec2 rA;  b2RotateVector( &stateA->deltaRotation, &joint->frameA.p, &rA );
        b2Vec2 rB;  b2RotateVector( &stateB->deltaRotation, &joint->frameB.p, &rB );

        b2Vec2 bias = b2Vec2_zero;
        float massScale = 1.0;
        float impulseScale = 0.0;
        if( useBias || joint->linearHertz > 0.0 )
        {
            b2Vec2 dcDiff;  b2Sub( &stateB->deltaPosition, &stateA->deltaPosition, &dcDiff );
            b2Vec2 rDiff;   b2Sub( &rB, &rA, &rDiff );
            b2Vec2 sep1;    b2Add( &dcDiff, &rDiff, &sep1 );
            b2Vec2 C;       b2Add( &sep1, &joint->deltaCenter, &C );
            b2MulSV( joint->linearSpring.biasRate, &C, &bias );
            massScale = joint->linearSpring.massScale;
            impulseScale = joint->linearSpring.impulseScale;
        }

        b2Vec2 crB;   b2CrossSV( wB, &rB, &crB );
        b2Vec2 vBpc;  b2Add( &vB, &crB, &vBpc );
        b2Vec2 crA;   b2CrossSV( wA, &rA, &crA );
        b2Vec2 vApc;  b2Add( &vA, &crA, &vApc );
        b2Vec2 Cdot;  b2Sub( &vBpc, &vApc, &Cdot );

        b2Mat22 K;
        K.cx.x = mA + mB + rA.y * rA.y * iA + rB.y * rB.y * iB;
        K.cy.x = -rA.y * rA.x * iA - rB.y * rB.x * iB;
        K.cx.y = K.cy.x;
        K.cy.y = mA + mB + rA.x * rA.x * iA + rB.x * rB.x * iB;

        b2Vec2 rhs;  b2Add( &Cdot, &bias, &rhs );
        b2Vec2 b;    b2Solve22( &K, &rhs, &b );

        b2Vec2 impulse;
        impulse.x = -massScale * b.x - impulseScale * joint->linearImpulse.x;
        impulse.y = -massScale * b.y - impulseScale * joint->linearImpulse.y;
        joint->linearImpulse.x = joint->linearImpulse.x + impulse.x;
        joint->linearImpulse.y = joint->linearImpulse.y + impulse.y;

        b2Vec2 nvA;  b2MulSub( &vA, mA, &impulse, &nvA );  vA = nvA;
        wA = wA - iA * b2Cross( &rA, &impulse );
        b2Vec2 nvB;  b2MulAdd( &vB, mB, &impulse, &nvB );  vB = nvB;
        wB = wB + iB * b2Cross( &rB, &impulse );
    }

    if( joint->indexA != B2_NULL_INDEX ) { stateA->linearVelocity = vA;  stateA->angularVelocity = wA; }
    if( joint->indexB != B2_NULL_INDEX ) { stateB->linearVelocity = vB;  stateB->angularVelocity = wB; }
}


// =============================================================================
//   PRISMATIC JOINT (slider)  --  perp+angular block + axial spring/motor/limit
// =============================================================================
//   Port of b2Prepare/WarmStart/SolvePrismaticJoint. The final 2x2 block locks the
//   perpendicular translation + relative rotation (bodyB slides freely along bodyA's
//   local +x). The axial spring/motor/limit blocks (gated on enableSpring/Motor/
//   Limit, default off) drive or bound the slide. Enable by setting the
//   b2PrismaticJoint fields on the jointSim (public setter API deferred).
//   axisA = localFrameA.q applied to (1,0), then turned by deltaRotationA.

void b2PreparePrismaticJoint( b2World* world, b2JointSim* base, float h )
{
    int idA = base->bodyIdA;
    int idB = base->bodyIdB;
    b2Body* bodyA = &world->bodies.data[ idA ];
    b2Body* bodyB = &world->bodies.data[ idB ];
    b2SolverSet* setA = &world->solverSets.data[ bodyA->setIndex ];
    b2SolverSet* setB = &world->solverSets.data[ bodyB->setIndex ];
    b2BodySim* bodySimA = &setA->bodySims.data[ bodyA->localIndex ];
    b2BodySim* bodySimB = &setB->bodySims.data[ bodyB->localIndex ];

    float mA = bodySimA->invMass;
    float iA = bodySimA->invInertia;
    float mB = bodySimB->invMass;
    float iB = bodySimB->invInertia;
    base->invMassA = mA;  base->invMassB = mB;  base->invIA = iA;  base->invIB = iB;

    b2PrismaticJoint* joint = &base->u.prismaticJoint;
    if( bodyA->setIndex == b2_awakeSet )  joint->indexA = bodyA->localIndex;  else joint->indexA = B2_NULL_INDEX;
    if( bodyB->setIndex == b2_awakeSet )  joint->indexB = bodyB->localIndex;  else joint->indexB = B2_NULL_INDEX;

    b2MulRot( &bodySimA->transform.q, &base->localFrameA.q, &joint->frameA.q );
    b2Vec2 lfpA;  b2Sub( &base->localFrameA.p, &bodySimA->localCenter, &lfpA );
    b2RotateVector( &bodySimA->transform.q, &lfpA, &joint->frameA.p );
    b2MulRot( &bodySimB->transform.q, &base->localFrameB.q, &joint->frameB.q );
    b2Vec2 lfpB;  b2Sub( &base->localFrameB.p, &bodySimB->localCenter, &lfpB );
    b2RotateVector( &bodySimB->transform.q, &lfpB, &joint->frameB.p );

    b2Sub( &bodySimB->center, &bodySimA->center, &joint->deltaCenter );

    b2MakeSoft( joint->hertz, joint->dampingRatio, h, &joint->springSoftness );
}

// current world axis (frameA +x turned by A's delta rotation), into *axisA
void b2PrismaticAxis( b2PrismaticJoint* joint, b2Rot* dqA, b2Vec2* axisA )
{
    b2Vec2 xhat;  xhat.x = 1.0;  xhat.y = 0.0;
    b2Vec2 a0;    b2RotateVector( &joint->frameA.q, &xhat, &a0 );
    b2RotateVector( dqA, &a0, axisA );
}

void b2WarmStartPrismaticJoint( b2World* world, b2JointSim* base )
{
    b2BodyState* states = world->solverSets.data[ b2_awakeSet ].bodyStates.data;
    b2BodyState dummy;  b2InitDummyBodyState( &dummy );

    float mA = base->invMassA;  float mB = base->invMassB;
    float iA = base->invIA;     float iB = base->invIB;

    b2PrismaticJoint* joint = &base->u.prismaticJoint;
    b2BodyState* stateA;  if( joint->indexA == B2_NULL_INDEX ) stateA = &dummy;  else stateA = &states[ joint->indexA ];
    b2BodyState* stateB;  if( joint->indexB == B2_NULL_INDEX ) stateB = &dummy;  else stateB = &states[ joint->indexB ];

    b2Vec2 rA;  b2RotateVector( &stateA->deltaRotation, &joint->frameA.p, &rA );
    b2Vec2 rB;  b2RotateVector( &stateB->deltaRotation, &joint->frameB.p, &rB );

    // d = (dpB - dpA) + deltaCenter + (rB - rA)
    b2Vec2 dpDiff;  b2Sub( &stateB->deltaPosition, &stateA->deltaPosition, &dpDiff );
    b2Vec2 dc1;     b2Add( &dpDiff, &joint->deltaCenter, &dc1 );
    b2Vec2 rDiff;   b2Sub( &rB, &rA, &rDiff );
    b2Vec2 d;       b2Add( &dc1, &rDiff, &d );

    b2Vec2 axisA;  b2PrismaticAxis( joint, &stateA->deltaRotation, &axisA );
    b2Vec2 rAd;    b2Add( &rA, &d, &rAd );
    float a1 = b2Cross( &rAd, &axisA );
    float a2 = b2Cross( &rB, &axisA );
    float axialImpulse = joint->springImpulse + joint->motorImpulse + joint->lowerImpulse - joint->upperImpulse;

    b2Vec2 perpA;  b2LeftPerp( &axisA, &perpA );
    float s1 = b2Cross( &rAd, &perpA );
    float s2 = b2Cross( &rB, &perpA );
    float perpImpulse = joint->impulse.x;
    float angleImpulse = joint->impulse.y;

    // P = axialImpulse*axisA + perpImpulse*perpA
    b2Vec2 P;  P.x = axialImpulse * axisA.x + perpImpulse * perpA.x;
               P.y = axialImpulse * axisA.y + perpImpulse * perpA.y;
    float LA = axialImpulse * a1 + perpImpulse * s1 + angleImpulse;
    float LB = axialImpulse * a2 + perpImpulse * s2 + angleImpulse;

    if( joint->indexA != B2_NULL_INDEX )
    {
        b2Vec2 nv;  b2MulSub( &stateA->linearVelocity, mA, &P, &nv );  stateA->linearVelocity = nv;
        stateA->angularVelocity = stateA->angularVelocity - iA * LA;
    }
    if( joint->indexB != B2_NULL_INDEX )
    {
        b2Vec2 nv;  b2MulAdd( &stateB->linearVelocity, mB, &P, &nv );  stateB->linearVelocity = nv;
        stateB->angularVelocity = stateB->angularVelocity + iB * LB;
    }
}

void b2SolvePrismaticJoint( b2World* world, b2JointSim* base, float h, float inv_h, bool useBias )
{
    b2BodyState* states = world->solverSets.data[ b2_awakeSet ].bodyStates.data;
    b2BodyState dummy;  b2InitDummyBodyState( &dummy );

    float mA = base->invMassA;  float mB = base->invMassB;
    float iA = base->invIA;     float iB = base->invIB;

    b2PrismaticJoint* joint = &base->u.prismaticJoint;
    b2BodyState* stateA;  if( joint->indexA == B2_NULL_INDEX ) stateA = &dummy;  else stateA = &states[ joint->indexA ];
    b2BodyState* stateB;  if( joint->indexB == B2_NULL_INDEX ) stateB = &dummy;  else stateB = &states[ joint->indexB ];

    b2Vec2 vA = stateA->linearVelocity;  float wA = stateA->angularVelocity;
    b2Vec2 vB = stateB->linearVelocity;  float wB = stateB->angularVelocity;

    b2Rot qA;   b2MulRot( &stateA->deltaRotation, &joint->frameA.q, &qA );
    b2Rot qB;   b2MulRot( &stateB->deltaRotation, &joint->frameB.q, &qB );
    b2Rot relQ; b2InvMulRot( &qA, &qB, &relQ );

    b2Vec2 rA;  b2RotateVector( &stateA->deltaRotation, &joint->frameA.p, &rA );
    b2Vec2 rB;  b2RotateVector( &stateB->deltaRotation, &joint->frameB.p, &rB );

    b2Vec2 dpDiff;  b2Sub( &stateB->deltaPosition, &stateA->deltaPosition, &dpDiff );
    b2Vec2 dc1;     b2Add( &dpDiff, &joint->deltaCenter, &dc1 );
    b2Vec2 rDiff;   b2Sub( &rB, &rA, &rDiff );
    b2Vec2 d;       b2Add( &dc1, &rDiff, &d );

    b2Vec2 axisA;  b2PrismaticAxis( joint, &stateA->deltaRotation, &axisA );

    // axial scalars (torque arms) for the spring/motor/limit constraints along axisA
    float translation = b2Dot( &axisA, &d );
    b2Vec2 rAdA;  b2Add( &rA, &d, &rAdA );
    float a1 = b2Cross( &rAdA, &axisA );
    float a2 = b2Cross( &rB, &axisA );
    float ka = mA + mB + iA * a1 * a1 + iB * a2 * a2;
    float axialMass;  if( ka > 0.0 ) axialMass = 1.0 / ka;  else axialMass = 0.0;

    // --- axial spring: drive translation toward targetTranslation ---
    if( joint->enableSpring )
    {
        float C = translation - joint->targetTranslation;
        float sbias = joint->springSoftness.biasRate * C;
        float smassScale = joint->springSoftness.massScale;
        float simpulseScale = joint->springSoftness.impulseScale;

        b2Vec2 vBmA;  b2Sub( &vB, &vA, &vBmA );
        float Cdot = b2Dot( &axisA, &vBmA ) + a2 * wB - a1 * wA;
        float deltaImpulse = -smassScale * axialMass * ( Cdot + sbias ) - simpulseScale * joint->springImpulse;
        joint->springImpulse = joint->springImpulse + deltaImpulse;

        b2Vec2 P;  b2MulSV( deltaImpulse, &axisA, &P );
        float LA = deltaImpulse * a1;  float LB = deltaImpulse * a2;
        b2Vec2 nvA;  b2MulSub( &vA, mA, &P, &nvA );  vA = nvA;  wA = wA - iA * LA;
        b2Vec2 nvB;  b2MulAdd( &vB, mB, &P, &nvB );  vB = nvB;  wB = wB + iB * LB;
    }

    // --- axial motor: drive translation speed toward motorSpeed (force-capped) ---
    if( joint->enableMotor )
    {
        b2Vec2 vBmA;  b2Sub( &vB, &vA, &vBmA );
        float Cdot = b2Dot( &axisA, &vBmA ) + a2 * wB - a1 * wA;
        float impulse = axialMass * ( joint->motorSpeed - Cdot );
        float oldImpulse = joint->motorImpulse;
        float maxImpulse = h * joint->maxMotorForce;
        joint->motorImpulse = b2ClampFloat( joint->motorImpulse + impulse, -maxImpulse, maxImpulse );
        impulse = joint->motorImpulse - oldImpulse;

        b2Vec2 P;  b2MulSV( impulse, &axisA, &P );
        float LA = impulse * a1;  float LB = impulse * a2;
        b2Vec2 nvA;  b2MulSub( &vA, mA, &P, &nvA );  vA = nvA;  wA = wA - iA * LA;
        b2Vec2 nvB;  b2MulAdd( &vB, mB, &P, &nvB );  vB = nvB;  wB = wB + iB * LB;
    }

    // --- axial limits (lower / upper translation) ---
    if( joint->enableLimit )
    {
        float speculativeDistance = 0.25 * ( joint->upperTranslation - joint->lowerTranslation );

        // lower limit
        {
            float C = translation - joint->lowerTranslation;
            if( C < speculativeDistance )
            {
                float lbias = 0.0;  float lmassScale = 1.0;  float limpulseScale = 0.0;
                if( C > 0.0 )
                {
                    float safe = b2GetLengthUnitsPerMeter();
                    lbias = b2MinFloat( C, safe ) * inv_h;   // speculative
                }
                else if( useBias )
                {
                    lbias = base->constraintSoftness.biasRate * C;
                    lmassScale = base->constraintSoftness.massScale;
                    limpulseScale = base->constraintSoftness.impulseScale;
                }
                float oldImpulse = joint->lowerImpulse;
                b2Vec2 vBmA;  b2Sub( &vB, &vA, &vBmA );
                float Cdot = b2Dot( &axisA, &vBmA ) + a2 * wB - a1 * wA;
                float deltaImpulse = -axialMass * lmassScale * ( Cdot + lbias ) - limpulseScale * oldImpulse;
                joint->lowerImpulse = b2MaxFloat( oldImpulse + deltaImpulse, 0.0 );
                deltaImpulse = joint->lowerImpulse - oldImpulse;

                b2Vec2 P;  b2MulSV( deltaImpulse, &axisA, &P );
                float LA = deltaImpulse * a1;  float LB = deltaImpulse * a2;
                b2Vec2 nvA;  b2MulSub( &vA, mA, &P, &nvA );  vA = nvA;  wA = wA - iA * LA;
                b2Vec2 nvB;  b2MulAdd( &vB, mB, &P, &nvB );  vB = nvB;  wB = wB + iB * LB;
            }
            else
                joint->lowerImpulse = 0.0;
        }

        // upper limit (signs flipped so C stays positive when satisfied)
        {
            float C = joint->upperTranslation - translation;
            if( C < speculativeDistance )
            {
                float ubias = 0.0;  float umassScale = 1.0;  float uimpulseScale = 0.0;
                if( C > 0.0 )
                {
                    float safe = b2GetLengthUnitsPerMeter();
                    ubias = b2MinFloat( C, safe ) * inv_h;   // speculative
                }
                else if( useBias )
                {
                    ubias = base->constraintSoftness.biasRate * C;
                    umassScale = base->constraintSoftness.massScale;
                    uimpulseScale = base->constraintSoftness.impulseScale;
                }
                float oldImpulse = joint->upperImpulse;
                b2Vec2 vAmB;  b2Sub( &vA, &vB, &vAmB );       // sign flipped
                float Cdot = b2Dot( &axisA, &vAmB ) + a1 * wA - a2 * wB;
                float deltaImpulse = -axialMass * umassScale * ( Cdot + ubias ) - uimpulseScale * oldImpulse;
                joint->upperImpulse = b2MaxFloat( oldImpulse + deltaImpulse, 0.0 );
                deltaImpulse = joint->upperImpulse - oldImpulse;

                b2Vec2 P;  b2MulSV( deltaImpulse, &axisA, &P );
                float LA = deltaImpulse * a1;  float LB = deltaImpulse * a2;
                b2Vec2 nvA;  b2MulAdd( &vA, mA, &P, &nvA );  vA = nvA;  wA = wA + iA * LA;  // sign flipped
                b2Vec2 nvB;  b2MulSub( &vB, mB, &P, &nvB );  vB = nvB;  wB = wB - iB * LB;
            }
            else
                joint->upperImpulse = 0.0;
        }
    }

    // --- block: perpendicular translation (x) + relative angle (y) ---
    b2Vec2 perpA;  b2LeftPerp( &axisA, &perpA );
    b2Vec2 rAd;    b2Add( &d, &rA, &rAd );
    float s1 = b2Cross( &rAd, &perpA );
    float s2 = b2Cross( &rB, &perpA );

    b2Vec2 Cdot;
    b2Vec2 vBmA;  b2Sub( &vB, &vA, &vBmA );
    Cdot.x = b2Dot( &perpA, &vBmA ) + s2 * wB - s1 * wA;
    Cdot.y = wB - wA;

    b2Vec2 bias = b2Vec2_zero;
    float massScale = 1.0;
    float impulseScale = 0.0;
    if( useBias )
    {
        b2Vec2 C;
        C.x = b2Dot( &perpA, &d );
        C.y = b2Rot_GetAngle( &relQ );
        b2MulSV( base->constraintSoftness.biasRate, &C, &bias );
        massScale = base->constraintSoftness.massScale;
        impulseScale = base->constraintSoftness.impulseScale;
    }

    float k11 = mA + mB + iA * s1 * s1 + iB * s2 * s2;
    float k12 = iA * s1 + iB * s2;
    float k22 = iA + iB;
    if( k22 == 0.0 )  k22 = 1.0;   // fixed-rotation bodies

    b2Mat22 K;
    K.cx.x = k11;  K.cy.x = k12;
    K.cx.y = k12;  K.cy.y = k22;

    b2Vec2 rhs;  b2Add( &Cdot, &bias, &rhs );
    b2Vec2 b;    b2Solve22( &K, &rhs, &b );

    b2Vec2 deltaImpulse;
    deltaImpulse.x = -massScale * b.x - impulseScale * joint->impulse.x;
    deltaImpulse.y = -massScale * b.y - impulseScale * joint->impulse.y;
    joint->impulse.x = joint->impulse.x + deltaImpulse.x;
    joint->impulse.y = joint->impulse.y + deltaImpulse.y;

    b2Vec2 P;  b2MulSV( deltaImpulse.x, &perpA, &P );
    float LA = deltaImpulse.x * s1 + deltaImpulse.y;
    float LB = deltaImpulse.x * s2 + deltaImpulse.y;

    b2Vec2 nvA;  b2MulSub( &vA, mA, &P, &nvA );  vA = nvA;
    wA = wA - iA * LA;
    b2Vec2 nvB;  b2MulAdd( &vB, mB, &P, &nvB );  vB = nvB;
    wB = wB + iB * LB;

    if( joint->indexA != B2_NULL_INDEX ) { stateA->linearVelocity = vA;  stateA->angularVelocity = wA; }
    if( joint->indexB != B2_NULL_INDEX ) { stateB->linearVelocity = vB;  stateB->angularVelocity = wB; }
}


// =============================================================================
//   WHEEL JOINT (suspension)  --  perp line + axial spring/motor/limit, free spin
// =============================================================================
//   Port of b2Prepare/WarmStart/SolveWheelJoint. Keeps bodyB on the line through the
//   anchor (perpendicular constraint), lets it slide along axisA with an optional
//   spring (suspension, C = translation toward 0) + limits, and rotate freely with
//   an optional motor. NO angle constraint (unlike prismatic). Enable spring/motor/
//   limit + set the fields on the jointSim; public setter API deferred.

void b2PrepareWheelJoint( b2World* world, b2JointSim* base, float h )
{
    int idA = base->bodyIdA;
    int idB = base->bodyIdB;
    b2Body* bodyA = &world->bodies.data[ idA ];
    b2Body* bodyB = &world->bodies.data[ idB ];
    b2SolverSet* setA = &world->solverSets.data[ bodyA->setIndex ];
    b2SolverSet* setB = &world->solverSets.data[ bodyB->setIndex ];
    b2BodySim* bodySimA = &setA->bodySims.data[ bodyA->localIndex ];
    b2BodySim* bodySimB = &setB->bodySims.data[ bodyB->localIndex ];

    float mA = bodySimA->invMass;
    float iA = bodySimA->invInertia;
    float mB = bodySimB->invMass;
    float iB = bodySimB->invInertia;
    base->invMassA = mA;  base->invMassB = mB;  base->invIA = iA;  base->invIB = iB;

    b2WheelJoint* joint = &base->u.wheelJoint;
    if( bodyA->setIndex == b2_awakeSet )  joint->indexA = bodyA->localIndex;  else joint->indexA = B2_NULL_INDEX;
    if( bodyB->setIndex == b2_awakeSet )  joint->indexB = bodyB->localIndex;  else joint->indexB = B2_NULL_INDEX;

    b2MulRot( &bodySimA->transform.q, &base->localFrameA.q, &joint->frameA.q );
    b2Vec2 lfpA;  b2Sub( &base->localFrameA.p, &bodySimA->localCenter, &lfpA );
    b2RotateVector( &bodySimA->transform.q, &lfpA, &joint->frameA.p );
    b2MulRot( &bodySimB->transform.q, &base->localFrameB.q, &joint->frameB.q );
    b2Vec2 lfpB;  b2Sub( &base->localFrameB.p, &bodySimB->localCenter, &lfpB );
    b2RotateVector( &bodySimB->transform.q, &lfpB, &joint->frameB.p );

    b2Sub( &bodySimB->center, &bodySimA->center, &joint->deltaCenter );

    b2Vec2 rA = joint->frameA.p;
    b2Vec2 rB = joint->frameB.p;
    b2Vec2 rBmA;  b2Sub( &rB, &rA, &rBmA );
    b2Vec2 d;     b2Add( &joint->deltaCenter, &rBmA, &d );

    b2Vec2 xhat;  xhat.x = 1.0;  xhat.y = 0.0;
    b2Vec2 axisA;  b2RotateVector( &joint->frameA.q, &xhat, &axisA );
    b2Vec2 perpA;  b2LeftPerp( &axisA, &perpA );

    b2Vec2 dRa;  b2Add( &d, &rA, &dRa );
    float s1 = b2Cross( &dRa, &perpA );
    float s2 = b2Cross( &rB, &perpA );
    float kp = mA + mB + iA * s1 * s1 + iB * s2 * s2;
    if( kp > 0.0 )  joint->perpMass = 1.0 / kp;  else joint->perpMass = 0.0;

    float a1 = b2Cross( &dRa, &axisA );
    float a2 = b2Cross( &rB, &axisA );
    float ka = mA + mB + iA * a1 * a1 + iB * a2 * a2;
    if( ka > 0.0 )  joint->axialMass = 1.0 / ka;  else joint->axialMass = 0.0;

    b2MakeSoft( joint->hertz, joint->dampingRatio, h, &joint->springSoftness );

    float km = iA + iB;
    if( km > 0.0 )  joint->motorMass = 1.0 / km;  else joint->motorMass = 0.0;
}

void b2WarmStartWheelJoint( b2World* world, b2JointSim* base )
{
    b2BodyState* states = world->solverSets.data[ b2_awakeSet ].bodyStates.data;
    b2BodyState dummy;  b2InitDummyBodyState( &dummy );

    float mA = base->invMassA;  float mB = base->invMassB;
    float iA = base->invIA;     float iB = base->invIB;

    b2WheelJoint* joint = &base->u.wheelJoint;
    b2BodyState* stateA;  if( joint->indexA == B2_NULL_INDEX ) stateA = &dummy;  else stateA = &states[ joint->indexA ];
    b2BodyState* stateB;  if( joint->indexB == B2_NULL_INDEX ) stateB = &dummy;  else stateB = &states[ joint->indexB ];

    b2Vec2 rA;  b2RotateVector( &stateA->deltaRotation, &joint->frameA.p, &rA );
    b2Vec2 rB;  b2RotateVector( &stateB->deltaRotation, &joint->frameB.p, &rB );

    b2Vec2 dpDiff;  b2Sub( &stateB->deltaPosition, &stateA->deltaPosition, &dpDiff );
    b2Vec2 dc1;     b2Add( &dpDiff, &joint->deltaCenter, &dc1 );
    b2Vec2 rDiff;   b2Sub( &rB, &rA, &rDiff );
    b2Vec2 d;       b2Add( &dc1, &rDiff, &d );

    b2Vec2 xhat;  xhat.x = 1.0;  xhat.y = 0.0;
    b2Vec2 axis0;  b2RotateVector( &joint->frameA.q, &xhat, &axis0 );
    b2Vec2 axisA;  b2RotateVector( &stateA->deltaRotation, &axis0, &axisA );
    b2Vec2 perpA;  b2LeftPerp( &axisA, &perpA );

    b2Vec2 dRa;  b2Add( &d, &rA, &dRa );
    float a1 = b2Cross( &dRa, &axisA );
    float a2 = b2Cross( &rB, &axisA );
    float s1 = b2Cross( &dRa, &perpA );
    float s2 = b2Cross( &rB, &perpA );

    float axialImpulse = joint->springImpulse + joint->lowerImpulse - joint->upperImpulse;

    // P = axialImpulse*axisA + perpImpulse*perpA
    b2Vec2 P;  P.x = axialImpulse * axisA.x + joint->perpImpulse * perpA.x;
               P.y = axialImpulse * axisA.y + joint->perpImpulse * perpA.y;
    float LA = axialImpulse * a1 + joint->perpImpulse * s1 + joint->motorImpulse;
    float LB = axialImpulse * a2 + joint->perpImpulse * s2 + joint->motorImpulse;

    if( joint->indexA != B2_NULL_INDEX )
    {
        b2Vec2 nv;  b2MulSub( &stateA->linearVelocity, mA, &P, &nv );  stateA->linearVelocity = nv;
        stateA->angularVelocity = stateA->angularVelocity - iA * LA;
    }
    if( joint->indexB != B2_NULL_INDEX )
    {
        b2Vec2 nv;  b2MulAdd( &stateB->linearVelocity, mB, &P, &nv );  stateB->linearVelocity = nv;
        stateB->angularVelocity = stateB->angularVelocity + iB * LB;
    }
}

void b2SolveWheelJoint( b2World* world, b2JointSim* base, float h, float inv_h, bool useBias )
{
    b2BodyState* states = world->solverSets.data[ b2_awakeSet ].bodyStates.data;
    b2BodyState dummy;  b2InitDummyBodyState( &dummy );

    float mA = base->invMassA;  float mB = base->invMassB;
    float iA = base->invIA;     float iB = base->invIB;

    b2WheelJoint* joint = &base->u.wheelJoint;
    b2BodyState* stateA;  if( joint->indexA == B2_NULL_INDEX ) stateA = &dummy;  else stateA = &states[ joint->indexA ];
    b2BodyState* stateB;  if( joint->indexB == B2_NULL_INDEX ) stateB = &dummy;  else stateB = &states[ joint->indexB ];

    b2Vec2 vA = stateA->linearVelocity;  float wA = stateA->angularVelocity;
    b2Vec2 vB = stateB->linearVelocity;  float wB = stateB->angularVelocity;

    bool fixedRotation = ( iA + iB == 0.0 );

    b2Vec2 rA;  b2RotateVector( &stateA->deltaRotation, &joint->frameA.p, &rA );
    b2Vec2 rB;  b2RotateVector( &stateB->deltaRotation, &joint->frameB.p, &rB );

    b2Vec2 dpDiff;  b2Sub( &stateB->deltaPosition, &stateA->deltaPosition, &dpDiff );
    b2Vec2 dc1;     b2Add( &dpDiff, &joint->deltaCenter, &dc1 );
    b2Vec2 rDiff;   b2Sub( &rB, &rA, &rDiff );
    b2Vec2 d;       b2Add( &dc1, &rDiff, &d );

    b2Vec2 xhat;  xhat.x = 1.0;  xhat.y = 0.0;
    b2Vec2 axis0;  b2RotateVector( &joint->frameA.q, &xhat, &axis0 );
    b2Vec2 axisA;  b2RotateVector( &stateA->deltaRotation, &axis0, &axisA );
    float translation = b2Dot( &axisA, &d );

    b2Vec2 dRa;  b2Add( &d, &rA, &dRa );
    float a1 = b2Cross( &dRa, &axisA );
    float a2 = b2Cross( &rB, &axisA );

    // --- motor (drive wheel spin) ---
    if( joint->enableMotor && fixedRotation == false )
    {
        float Cdot = wB - wA - joint->motorSpeed;
        float impulse = -joint->motorMass * Cdot;
        float oldImpulse = joint->motorImpulse;
        float maxImpulse = h * joint->maxMotorTorque;
        joint->motorImpulse = b2ClampFloat( joint->motorImpulse + impulse, -maxImpulse, maxImpulse );
        impulse = joint->motorImpulse - oldImpulse;
        wA = wA - iA * impulse;
        wB = wB + iB * impulse;
    }

    // --- suspension spring (C = translation toward 0), applied even during relax ---
    if( joint->enableSpring )
    {
        float C = translation;
        float sbias = joint->springSoftness.biasRate * C;
        float smassScale = joint->springSoftness.massScale;
        float simpulseScale = joint->springSoftness.impulseScale;
        b2Vec2 vBmA;  b2Sub( &vB, &vA, &vBmA );
        float Cdot = b2Dot( &axisA, &vBmA ) + a2 * wB - a1 * wA;
        float impulse = -smassScale * joint->axialMass * ( Cdot + sbias ) - simpulseScale * joint->springImpulse;
        joint->springImpulse = joint->springImpulse + impulse;

        b2Vec2 P;  b2MulSV( impulse, &axisA, &P );
        float LA = impulse * a1;  float LB = impulse * a2;
        b2Vec2 nvA;  b2MulSub( &vA, mA, &P, &nvA );  vA = nvA;  wA = wA - iA * LA;
        b2Vec2 nvB;  b2MulAdd( &vB, mB, &P, &nvB );  vB = nvB;  wB = wB + iB * LB;
    }

    // --- axial limits ---
    if( joint->enableLimit )
    {
        // lower
        {
            float C = translation - joint->lowerTranslation;
            float lbias = 0.0;  float lmassScale = 1.0;  float limpulseScale = 0.0;
            if( C > 0.0 )
                lbias = C * inv_h;
            else if( useBias )
            {
                lbias = base->constraintSoftness.biasRate * C;
                lmassScale = base->constraintSoftness.massScale;
                limpulseScale = base->constraintSoftness.impulseScale;
            }
            b2Vec2 vBmA;  b2Sub( &vB, &vA, &vBmA );
            float Cdot = b2Dot( &axisA, &vBmA ) + a2 * wB - a1 * wA;
            float impulse = -lmassScale * joint->axialMass * ( Cdot + lbias ) - limpulseScale * joint->lowerImpulse;
            float oldImpulse = joint->lowerImpulse;
            joint->lowerImpulse = b2MaxFloat( oldImpulse + impulse, 0.0 );
            impulse = joint->lowerImpulse - oldImpulse;

            b2Vec2 P;  b2MulSV( impulse, &axisA, &P );
            float LA = impulse * a1;  float LB = impulse * a2;
            b2Vec2 nvA;  b2MulSub( &vA, mA, &P, &nvA );  vA = nvA;  wA = wA - iA * LA;
            b2Vec2 nvB;  b2MulAdd( &vB, mB, &P, &nvB );  vB = nvB;  wB = wB + iB * LB;
        }
        // upper (signs flipped)
        {
            float C = joint->upperTranslation - translation;
            float ubias = 0.0;  float umassScale = 1.0;  float uimpulseScale = 0.0;
            if( C > 0.0 )
                ubias = C * inv_h;
            else if( useBias )
            {
                ubias = base->constraintSoftness.biasRate * C;
                umassScale = base->constraintSoftness.massScale;
                uimpulseScale = base->constraintSoftness.impulseScale;
            }
            b2Vec2 vAmB;  b2Sub( &vA, &vB, &vAmB );
            float Cdot = b2Dot( &axisA, &vAmB ) + a1 * wA - a2 * wB;
            float impulse = -umassScale * joint->axialMass * ( Cdot + ubias ) - uimpulseScale * joint->upperImpulse;
            float oldImpulse = joint->upperImpulse;
            joint->upperImpulse = b2MaxFloat( oldImpulse + impulse, 0.0 );
            impulse = joint->upperImpulse - oldImpulse;

            b2Vec2 P;  b2MulSV( impulse, &axisA, &P );
            float LA = impulse * a1;  float LB = impulse * a2;
            b2Vec2 nvA;  b2MulAdd( &vA, mA, &P, &nvA );  vA = nvA;  wA = wA + iA * LA;
            b2Vec2 nvB;  b2MulSub( &vB, mB, &P, &nvB );  vB = nvB;  wB = wB - iB * LB;
        }
    }

    // --- point-to-line (perpendicular) constraint ---
    {
        b2Vec2 perpA;  b2LeftPerp( &axisA, &perpA );

        float bias = 0.0;  float massScale = 1.0;  float impulseScale = 0.0;
        if( useBias )
        {
            float C = b2Dot( &perpA, &d );
            bias = base->constraintSoftness.biasRate * C;
            massScale = base->constraintSoftness.massScale;
            impulseScale = base->constraintSoftness.impulseScale;
        }

        float s1 = b2Cross( &dRa, &perpA );
        float s2 = b2Cross( &rB, &perpA );
        b2Vec2 vBmA;  b2Sub( &vB, &vA, &vBmA );
        float Cdot = b2Dot( &perpA, &vBmA ) + s2 * wB - s1 * wA;

        float impulse = -massScale * joint->perpMass * ( Cdot + bias ) - impulseScale * joint->perpImpulse;
        joint->perpImpulse = joint->perpImpulse + impulse;

        b2Vec2 P;  b2MulSV( impulse, &perpA, &P );
        float LA = impulse * s1;  float LB = impulse * s2;
        b2Vec2 nvA;  b2MulSub( &vA, mA, &P, &nvA );  vA = nvA;  wA = wA - iA * LA;
        b2Vec2 nvB;  b2MulAdd( &vB, mB, &P, &nvB );  vB = nvB;  wB = wB + iB * LB;
    }

    if( joint->indexA != B2_NULL_INDEX ) { stateA->linearVelocity = vA;  stateA->angularVelocity = wA; }
    if( joint->indexB != B2_NULL_INDEX ) { stateB->linearVelocity = vB;  stateB->angularVelocity = wB; }
}


// =============================================================================
//   MOTOR JOINT  --  drive relative velocity to a target (kinematic control)
// =============================================================================
//   Port of b2Prepare/WarmStart/SolveMotorJoint. Point-to-point linear 2x2 block
//   + scalar angular block (like revolute), but instead of pinning position it
//   drives the RELATIVE velocity toward (linearVelocity, angularVelocity), each
//   capped by max*Force/Torque. Optional linear/angular springs (hertz>0 AND
//   maxSpring*>0) additionally pull the relative pose toward the frame offset.
//   Motor solve ignores useBias (velocity control is unbiased); it needs only h.

void b2PrepareMotorJoint( b2World* world, b2JointSim* base, float h )
{
    int idA = base->bodyIdA;
    int idB = base->bodyIdB;
    b2Body* bodyA = &world->bodies.data[ idA ];
    b2Body* bodyB = &world->bodies.data[ idB ];
    b2SolverSet* setA = &world->solverSets.data[ bodyA->setIndex ];
    b2SolverSet* setB = &world->solverSets.data[ bodyB->setIndex ];
    b2BodySim* bodySimA = &setA->bodySims.data[ bodyA->localIndex ];
    b2BodySim* bodySimB = &setB->bodySims.data[ bodyB->localIndex ];

    float mA = bodySimA->invMass;
    float iA = bodySimA->invInertia;
    float mB = bodySimB->invMass;
    float iB = bodySimB->invInertia;
    base->invMassA = mA;  base->invMassB = mB;  base->invIA = iA;  base->invIB = iB;

    b2MotorJoint* joint = &base->u.motorJoint;
    if( bodyA->setIndex == b2_awakeSet )  joint->indexA = bodyA->localIndex;  else joint->indexA = B2_NULL_INDEX;
    if( bodyB->setIndex == b2_awakeSet )  joint->indexB = bodyB->localIndex;  else joint->indexB = B2_NULL_INDEX;

    // world-space anchor frames, relative to center of mass
    b2MulRot( &bodySimA->transform.q, &base->localFrameA.q, &joint->frameA.q );
    b2Vec2 lfpA;  b2Sub( &base->localFrameA.p, &bodySimA->localCenter, &lfpA );
    b2RotateVector( &bodySimA->transform.q, &lfpA, &joint->frameA.p );
    b2MulRot( &bodySimB->transform.q, &base->localFrameB.q, &joint->frameB.q );
    b2Vec2 lfpB;  b2Sub( &base->localFrameB.p, &bodySimB->localCenter, &lfpB );
    b2RotateVector( &bodySimB->transform.q, &lfpB, &joint->frameB.p );

    b2Sub( &bodySimB->center, &bodySimA->center, &joint->deltaCenter );

    b2Vec2 rA = joint->frameA.p;
    b2Vec2 rB = joint->frameB.p;

    b2MakeSoft( joint->linearHertz, joint->linearDampingRatio, h, &joint->linearSpring );
    b2MakeSoft( joint->angularHertz, joint->angularDampingRatio, h, &joint->angularSpring );

    // linear effective-mass matrix, inverted once (reused as joint->linearMass)
    b2Mat22 kl;
    kl.cx.x = mA + mB + rA.y * rA.y * iA + rB.y * rB.y * iB;
    kl.cx.y = -rA.y * rA.x * iA - rB.y * rB.x * iB;
    kl.cy.x = kl.cx.y;
    kl.cy.y = mA + mB + rA.x * rA.x * iA + rB.x * rB.x * iB;
    b2GetInverse22( &kl, &joint->linearMass );

    float ka = iA + iB;
    if( ka > 0.0 )  joint->angularMass = 1.0 / ka;  else joint->angularMass = 0.0;
    // warm starting always on -> keep accumulated impulses.
}

void b2WarmStartMotorJoint( b2World* world, b2JointSim* base )
{
    b2BodyState* states = world->solverSets.data[ b2_awakeSet ].bodyStates.data;
    b2BodyState dummy;  b2InitDummyBodyState( &dummy );

    float mA = base->invMassA;  float mB = base->invMassB;
    float iA = base->invIA;     float iB = base->invIB;

    b2MotorJoint* joint = &base->u.motorJoint;
    b2BodyState* stateA;  if( joint->indexA == B2_NULL_INDEX ) stateA = &dummy;  else stateA = &states[ joint->indexA ];
    b2BodyState* stateB;  if( joint->indexB == B2_NULL_INDEX ) stateB = &dummy;  else stateB = &states[ joint->indexB ];

    b2Vec2 rA;  b2RotateVector( &stateA->deltaRotation, &joint->frameA.p, &rA );
    b2Vec2 rB;  b2RotateVector( &stateB->deltaRotation, &joint->frameB.p, &rB );

    b2Vec2 linearImpulse;  b2Add( &joint->linearVelocityImpulse, &joint->linearSpringImpulse, &linearImpulse );
    float angularImpulse = joint->angularVelocityImpulse + joint->angularSpringImpulse;

    if( joint->indexA != B2_NULL_INDEX )
    {
        b2Vec2 nv;  b2MulSub( &stateA->linearVelocity, mA, &linearImpulse, &nv );  stateA->linearVelocity = nv;
        stateA->angularVelocity = stateA->angularVelocity - iA * ( b2Cross( &rA, &linearImpulse ) + angularImpulse );
    }
    if( joint->indexB != B2_NULL_INDEX )
    {
        b2Vec2 nv;  b2MulAdd( &stateB->linearVelocity, mB, &linearImpulse, &nv );  stateB->linearVelocity = nv;
        stateB->angularVelocity = stateB->angularVelocity + iB * ( b2Cross( &rB, &linearImpulse ) + angularImpulse );
    }
}

void b2SolveMotorJoint( b2World* world, b2JointSim* base, float h )
{
    b2BodyState* states = world->solverSets.data[ b2_awakeSet ].bodyStates.data;
    b2BodyState dummy;  b2InitDummyBodyState( &dummy );

    float mA = base->invMassA;  float mB = base->invMassB;
    float iA = base->invIA;     float iB = base->invIB;

    b2MotorJoint* joint = &base->u.motorJoint;
    b2BodyState* stateA;  if( joint->indexA == B2_NULL_INDEX ) stateA = &dummy;  else stateA = &states[ joint->indexA ];
    b2BodyState* stateB;  if( joint->indexB == B2_NULL_INDEX ) stateB = &dummy;  else stateB = &states[ joint->indexB ];

    b2Vec2 vA = stateA->linearVelocity;  float wA = stateA->angularVelocity;
    b2Vec2 vB = stateB->linearVelocity;  float wB = stateB->angularVelocity;

    // angular spring (pull relative angle toward the frame offset)
    if( joint->maxSpringTorque > 0.0 && joint->angularHertz > 0.0 )
    {
        b2Rot qA;  b2MulRot( &stateA->deltaRotation, &joint->frameA.q, &qA );
        b2Rot qB;  b2MulRot( &stateB->deltaRotation, &joint->frameB.q, &qB );
        b2Rot relQ;  b2InvMulRot( &qA, &qB, &relQ );
        float c = b2Rot_GetAngle( &relQ );
        float bias = joint->angularSpring.biasRate * c;
        float massScale = joint->angularSpring.massScale;
        float impulseScale = joint->angularSpring.impulseScale;
        float cdot = wB - wA;
        float maxImpulse = h * joint->maxSpringTorque;
        float oldImpulse = joint->angularSpringImpulse;
        float impulse = -massScale * joint->angularMass * ( cdot + bias ) - impulseScale * oldImpulse;
        joint->angularSpringImpulse = b2ClampFloat( oldImpulse + impulse, -maxImpulse, maxImpulse );
        impulse = joint->angularSpringImpulse - oldImpulse;
        wA = wA - iA * impulse;
        wB = wB + iB * impulse;
    }

    // angular velocity motor (drive wB - wA toward angularVelocity)
    if( joint->maxVelocityTorque > 0.0 )
    {
        float cdot = wB - wA - joint->angularVelocity;
        float impulse = -joint->angularMass * cdot;
        float maxImpulse = h * joint->maxVelocityTorque;
        float oldImpulse = joint->angularVelocityImpulse;
        joint->angularVelocityImpulse = b2ClampFloat( oldImpulse + impulse, -maxImpulse, maxImpulse );
        impulse = joint->angularVelocityImpulse - oldImpulse;
        wA = wA - iA * impulse;
        wB = wB + iB * impulse;
    }

    b2Vec2 rA;  b2RotateVector( &stateA->deltaRotation, &joint->frameA.p, &rA );
    b2Vec2 rB;  b2RotateVector( &stateB->deltaRotation, &joint->frameB.p, &rB );

    // linear spring (pull relative position toward the frame offset)
    if( joint->maxSpringForce > 0.0 && joint->linearHertz > 0.0 )
    {
        b2Vec2 dcDiff;  b2Sub( &stateB->deltaPosition, &stateA->deltaPosition, &dcDiff );
        b2Vec2 rDiff;   b2Sub( &rB, &rA, &rDiff );
        b2Vec2 c0;  b2Add( &dcDiff, &rDiff, &c0 );
        b2Vec2 c;   b2Add( &c0, &joint->deltaCenter, &c );
        b2Vec2 bias;  b2MulSV( joint->linearSpring.biasRate, &c, &bias );
        float massScale = joint->linearSpring.massScale;
        float impulseScale = joint->linearSpring.impulseScale;

        b2Vec2 crB;  b2CrossSV( wB, &rB, &crB );
        b2Vec2 vBt;  b2Add( &vB, &crB, &vBt );
        b2Vec2 crA;  b2CrossSV( wA, &rA, &crA );
        b2Vec2 vAt;  b2Add( &vA, &crA, &vAt );
        b2Vec2 cdot;  b2Sub( &vBt, &vAt, &cdot );
        b2Vec2 cdotb;  b2Add( &cdot, &bias, &cdotb );

        // recompute the effective mass (upstream does this here; kept for fidelity)
        b2Mat22 kl;
        kl.cx.x = mA + mB + rA.y * rA.y * iA + rB.y * rB.y * iB;
        kl.cx.y = -rA.y * rA.x * iA - rB.y * rB.x * iB;
        kl.cy.x = kl.cx.y;
        kl.cy.y = mA + mB + rA.x * rA.x * iA + rB.x * rB.x * iB;
        b2GetInverse22( &kl, &joint->linearMass );

        b2Vec2 b;  b2MulMV( &joint->linearMass, &cdotb, &b );
        b2Vec2 oldImpulse = joint->linearSpringImpulse;
        b2Vec2 impulse;
        impulse.x = -massScale * b.x - impulseScale * oldImpulse.x;
        impulse.y = -massScale * b.y - impulseScale * oldImpulse.y;

        float maxImpulse = h * joint->maxSpringForce;
        joint->linearSpringImpulse.x = joint->linearSpringImpulse.x + impulse.x;
        joint->linearSpringImpulse.y = joint->linearSpringImpulse.y + impulse.y;
        if( b2LengthSquared( &joint->linearSpringImpulse ) > maxImpulse * maxImpulse )
        {
            b2Vec2 n;  b2Normalize( &joint->linearSpringImpulse, &n );
            joint->linearSpringImpulse.x = n.x * maxImpulse;
            joint->linearSpringImpulse.y = n.y * maxImpulse;
        }
        impulse.x = joint->linearSpringImpulse.x - oldImpulse.x;
        impulse.y = joint->linearSpringImpulse.y - oldImpulse.y;

        b2Vec2 nvA;  b2MulSub( &vA, mA, &impulse, &nvA );  vA = nvA;  wA = wA - iA * b2Cross( &rA, &impulse );
        b2Vec2 nvB;  b2MulAdd( &vB, mB, &impulse, &nvB );  vB = nvB;  wB = wB + iB * b2Cross( &rB, &impulse );
    }

    // linear velocity motor (drive relative anchor velocity toward linearVelocity)
    if( joint->maxVelocityForce > 0.0 )
    {
        b2Vec2 crB;  b2CrossSV( wB, &rB, &crB );
        b2Vec2 vBt;  b2Add( &vB, &crB, &vBt );
        b2Vec2 crA;  b2CrossSV( wA, &rA, &crA );
        b2Vec2 vAt;  b2Add( &vA, &crA, &vAt );
        b2Vec2 cdot0;  b2Sub( &vBt, &vAt, &cdot0 );
        b2Vec2 cdot;   b2Sub( &cdot0, &joint->linearVelocity, &cdot );
        b2Vec2 b;  b2MulMV( &joint->linearMass, &cdot, &b );
        b2Vec2 impulse;  impulse.x = -b.x;  impulse.y = -b.y;

        b2Vec2 oldImpulse = joint->linearVelocityImpulse;
        float maxImpulse = h * joint->maxVelocityForce;
        joint->linearVelocityImpulse.x = joint->linearVelocityImpulse.x + impulse.x;
        joint->linearVelocityImpulse.y = joint->linearVelocityImpulse.y + impulse.y;
        if( b2LengthSquared( &joint->linearVelocityImpulse ) > maxImpulse * maxImpulse )
        {
            b2Vec2 n;  b2Normalize( &joint->linearVelocityImpulse, &n );
            joint->linearVelocityImpulse.x = n.x * maxImpulse;
            joint->linearVelocityImpulse.y = n.y * maxImpulse;
        }
        impulse.x = joint->linearVelocityImpulse.x - oldImpulse.x;
        impulse.y = joint->linearVelocityImpulse.y - oldImpulse.y;

        b2Vec2 nvA;  b2MulSub( &vA, mA, &impulse, &nvA );  vA = nvA;  wA = wA - iA * b2Cross( &rA, &impulse );
        b2Vec2 nvB;  b2MulAdd( &vB, mB, &impulse, &nvB );  vB = nvB;  wB = wB + iB * b2Cross( &rB, &impulse );
    }

    if( joint->indexA != B2_NULL_INDEX ) { stateA->linearVelocity = vA;  stateA->angularVelocity = wA; }
    if( joint->indexB != B2_NULL_INDEX ) { stateB->linearVelocity = vB;  stateB->angularVelocity = wB; }
}


// ---- per-stage dispatchers over the awake set's jointSims (type switch) ----
void b2PrepareJoints( b2World* world, float h, float inv_h )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    int count = awakeSet->jointSims.count;
    int i;
    for( i = 0; i < count; ++i )
    {
        b2JointSim* base = &awakeSet->jointSims.data[i];

        // b2PrepareJoint: clamp the constraint hertz to the sub-step rate, then
        // build the position-correction softness the rigid solve reads.
        float hertz = b2MinFloat( base->constraintHertz, 0.25 * inv_h );
        b2MakeSoft( hertz, base->constraintDampingRatio, h, &base->constraintSoftness );

        if( base->type == b2_distanceJoint )
            b2PrepareDistanceJoint( world, base, h );
        else if( base->type == b2_revoluteJoint )
            b2PrepareRevoluteJoint( world, base, h );
        else if( base->type == b2_weldJoint )
            b2PrepareWeldJoint( world, base, h );
        else if( base->type == b2_prismaticJoint )
            b2PreparePrismaticJoint( world, base, h );
        else if( base->type == b2_wheelJoint )
            b2PrepareWheelJoint( world, base, h );
        else if( base->type == b2_motorJoint )
            b2PrepareMotorJoint( world, base, h );
    }
}

void b2WarmStartJoints( b2World* world )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    int count = awakeSet->jointSims.count;
    int i;
    for( i = 0; i < count; ++i )
    {
        b2JointSim* base = &awakeSet->jointSims.data[i];
        if( base->type == b2_distanceJoint )
            b2WarmStartDistanceJoint( world, base );
        else if( base->type == b2_revoluteJoint )
            b2WarmStartRevoluteJoint( world, base );
        else if( base->type == b2_weldJoint )
            b2WarmStartWeldJoint( world, base );
        else if( base->type == b2_prismaticJoint )
            b2WarmStartPrismaticJoint( world, base );
        else if( base->type == b2_wheelJoint )
            b2WarmStartWheelJoint( world, base );
        else if( base->type == b2_motorJoint )
            b2WarmStartMotorJoint( world, base );
    }
}

void b2SolveJoints( b2World* world, float h, float inv_h, bool useBias )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    int count = awakeSet->jointSims.count;
    int i;
    for( i = 0; i < count; ++i )
    {
        b2JointSim* base = &awakeSet->jointSims.data[i];
        if( base->type == b2_distanceJoint )
            b2SolveDistanceJoint( world, base, h, inv_h, useBias );
        else if( base->type == b2_revoluteJoint )
            b2SolveRevoluteJoint( world, base, h, inv_h, useBias );
        else if( base->type == b2_weldJoint )
            b2SolveWeldJoint( world, base, useBias );
        else if( base->type == b2_prismaticJoint )
            b2SolvePrismaticJoint( world, base, h, inv_h, useBias );
        else if( base->type == b2_wheelJoint )
            b2SolveWheelJoint( world, base, h, inv_h, useBias );
        else if( base->type == b2_motorJoint )
            b2SolveMotorJoint( world, base, h );
    }
}


// The solve stage: prepare constraints, then the TGS-soft sub-step loop
// (integrate velocities -> warm start -> solve w/ bias -> integrate positions ->
// relax), then restitution, then store impulses (cross-step warm start), then
// finalize, then update sleep (Phase C). DEFERRED: constraint graph, island split.

// =============================================================================
//   SLEEPING (Phase C2a) -- migrate a settled island to a sleeping solver set.
//   Port of solver_set.c b2TrySleepIsland MINUS the constraint graph: the port's
//   touching contacts/joints live directly in awakeSet->contactSims/jointSims, so
//   migration is a plain dense-array move (awake -> sleep) with the same swap-remove
//   + moved-owner-localIndex-repair pattern b2DestroyBody uses. Non-touching contacts
//   of the sleeping bodies are LEFT in the awake set (b2Collide skips a contact when
//   both bodies are non-awake) rather than upstream's disabled-set dance. Merge-only:
//   the constraintRemoveCount split guard is dropped (we don't split; sleeping a
//   coarse all-slow island is still correct).
// =============================================================================
void b2TrySleepIsland( b2World* world, int islandId )
{
    b2Island* island = &world->islands.data[ islandId ];

    // create a fresh sleeping solver set (grow the solverSets array if needed)
    int sleepSetId = b2AllocId( &world->solverSetIdPool );
    if( sleepSetId == world->solverSets.count )
    {
        world->solverSets.data = b2GrowArray( world->solverSets.data, &world->solverSets.capacity,
                                              world->solverSets.count + 1, sizeof( b2SolverSet ) );
        world->solverSets.count = world->solverSets.count + 1;
    }
    b2SolverSet* sleepSet = &world->solverSets.data[ sleepSetId ];
    sleepSet->bodySims.data = NULL;    sleepSet->bodySims.count = 0;    sleepSet->bodySims.capacity = 0;
    sleepSet->bodyStates.data = NULL;  sleepSet->bodyStates.count = 0;  sleepSet->bodyStates.capacity = 0;
    sleepSet->contactSims.data = NULL; sleepSet->contactSims.count = 0; sleepSet->contactSims.capacity = 0;
    sleepSet->jointSims.data = NULL;   sleepSet->jointSims.count = 0;   sleepSet->jointSims.capacity = 0;
    sleepSet->islandSims.data = NULL;  sleepSet->islandSims.count = 0;  sleepSet->islandSims.capacity = 0;
    sleepSet->setIndex = sleepSetId;

    // re-fetch awakeSet AFTER the solverSets grow (the array may have reallocated)
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];

    int i;
    // move bodies awake -> sleep (sim moves, state is dropped)
    for( i = 0; i < island->bodyCount; ++i )
    {
        int bodyId = island->bodies[i];
        b2Body* body = &world->bodies.data[ bodyId ];
        int awakeBodyIndex = body->localIndex;

        sleepSet->bodySims.data = b2GrowArray( sleepSet->bodySims.data, &sleepSet->bodySims.capacity,
                                               sleepSet->bodySims.count + 1, sizeof( b2BodySim ) );
        int sleepBodyIndex = sleepSet->bodySims.count;
        sleepSet->bodySims.data[ sleepBodyIndex ] = awakeSet->bodySims.data[ awakeBodyIndex ];   // struct copy
        sleepSet->bodySims.count = sleepSet->bodySims.count + 1;

        // remove the sim from the awake set (repairs the moved body's localIndex)
        b2RemoveBodySim( &awakeSet->bodySims, &world->bodies, awakeBodyIndex );
        // remove the parallel awake state at the same slot (swap last in)
        int lastState = awakeSet->bodyStates.count - 1;
        if( awakeBodyIndex != lastState )
            awakeSet->bodyStates.data[ awakeBodyIndex ] = awakeSet->bodyStates.data[ lastState ];
        awakeSet->bodyStates.count = awakeSet->bodyStates.count - 1;

        body->setIndex = sleepSetId;
        body->localIndex = sleepBodyIndex;
    }

    // move touching contacts awake -> sleep
    for( i = 0; i < island->contactCount; ++i )
    {
        b2Contact* contact = &world->contacts.data[ island->contacts[i].contactId ];
        int awakeIndex = contact->localIndex;

        sleepSet->contactSims.data = b2GrowArray( sleepSet->contactSims.data, &sleepSet->contactSims.capacity,
                                                  sleepSet->contactSims.count + 1, sizeof( b2ContactSim ) );
        int sleepIndex = sleepSet->contactSims.count;
        sleepSet->contactSims.data[ sleepIndex ] = awakeSet->contactSims.data[ awakeIndex ];
        sleepSet->contactSims.count = sleepSet->contactSims.count + 1;

        int lastC = awakeSet->contactSims.count - 1;
        if( awakeIndex != lastC )
        {
            awakeSet->contactSims.data[ awakeIndex ] = awakeSet->contactSims.data[ lastC ];
            b2Contact* movedC = &world->contacts.data[ awakeSet->contactSims.data[ awakeIndex ].contactId ];
            movedC->localIndex = awakeIndex;
        }
        awakeSet->contactSims.count = awakeSet->contactSims.count - 1;

        contact->setIndex = sleepSetId;
        contact->localIndex = sleepIndex;
    }

    // move joints awake -> sleep
    for( i = 0; i < island->jointCount; ++i )
    {
        b2Joint* joint = &world->joints.data[ island->joints[i].jointId ];
        int awakeIndex = joint->localIndex;

        sleepSet->jointSims.data = b2GrowArray( sleepSet->jointSims.data, &sleepSet->jointSims.capacity,
                                                sleepSet->jointSims.count + 1, sizeof( b2JointSim ) );
        int sleepIndex = sleepSet->jointSims.count;
        sleepSet->jointSims.data[ sleepIndex ] = awakeSet->jointSims.data[ awakeIndex ];
        sleepSet->jointSims.count = sleepSet->jointSims.count + 1;

        int lastJ = awakeSet->jointSims.count - 1;
        if( awakeIndex != lastJ )
        {
            awakeSet->jointSims.data[ awakeIndex ] = awakeSet->jointSims.data[ lastJ ];
            b2Joint* movedJ = &world->joints.data[ awakeSet->jointSims.data[ awakeIndex ].jointId ];
            movedJ->localIndex = awakeIndex;
        }
        awakeSet->jointSims.count = awakeSet->jointSims.count - 1;

        joint->setIndex = sleepSetId;
        joint->localIndex = sleepIndex;
    }

    // move the island itself awake -> sleep (islandSims swap-remove + moved repair)
    int islandIndex = island->localIndex;
    sleepSet->islandSims.data = b2GrowArray( sleepSet->islandSims.data, &sleepSet->islandSims.capacity,
                                             sleepSet->islandSims.count + 1, sizeof( b2IslandSim ) );
    sleepSet->islandSims.data[ sleepSet->islandSims.count ].islandId = islandId;
    sleepSet->islandSims.count = sleepSet->islandSims.count + 1;

    int lastI = awakeSet->islandSims.count - 1;
    if( islandIndex != lastI )
    {
        int movedIslandId = awakeSet->islandSims.data[ lastI ].islandId;
        awakeSet->islandSims.data[ islandIndex ] = awakeSet->islandSims.data[ lastI ];
        world->islands.data[ movedIslandId ].localIndex = islandIndex;
    }
    awakeSet->islandSims.count = awakeSet->islandSims.count - 1;

    island->setIndex = sleepSetId;
    island->localIndex = 0;

    if( world->splitIslandId == islandId )
        world->splitIslandId = B2_NULL_INDEX;
}

// Force a body awake or asleep (upstream b2Body_SetAwake). Lives here rather than
// with the rest of the body API because putting a body to sleep means sleeping its
// whole ISLAND -- b2TrySleepIsland is defined above, in this header.
//   awake == true  : wake the body's sleeping set (no-op if already awake/static).
//   awake == false : try to sleep the island it belongs to. b2TrySleepIsland still
//                    applies its own predicate (all members dynamic), so this is a
//                    request, not a guarantee -- same as upstream.
void b2Body_SetAwake( b2World* world, b2BodyId* bodyId, bool awake )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );

    if( awake )
    {
        b2WakeBody( world, body );
        return;
    }

    if( body->setIndex == b2_awakeSet && body->islandId != B2_NULL_INDEX )
        b2TrySleepIsland( world, body->islandId );
}

// Put every awake island whose bodies have ALL been slow for >= B2_TIME_TO_SLEEP to
// sleep. Iterate the awake islandSims BACKWARD because b2TrySleepIsland swap-removes
// the slept island from that very array (advisor's mutate-during-iterate hazard #2).
// A non-dynamic (kinematic) member keeps its island awake (kinematic sleep deferred).
void b2UpdateSleep( b2World* world )
{
    if( world->enableSleep == false )
        return;

    int i = world->solverSets.data[ b2_awakeSet ].islandSims.count - 1;
    while( i >= 0 )
    {
        // re-fetch the awake set each pass -- b2TrySleepIsland may have reallocated
        // world->solverSets (adding a sleeping set)
        b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
        if( i >= awakeSet->islandSims.count )
        {
            i = awakeSet->islandSims.count - 1;
            continue;
        }
        int islandId = awakeSet->islandSims.data[i].islandId;
        b2Island* island = &world->islands.data[ islandId ];

        bool canSleep = ( island->bodyCount > 0 );
        int j;
        for( j = 0; j < island->bodyCount; ++j )
        {
            b2Body* body = &world->bodies.data[ island->bodies[j] ];
            if( body->type != b2_dynamicBody )        { canSleep = false;  break; }  // kinematic keeps it awake
            if( body->sleepTime < B2_TIME_TO_SLEEP )  { canSleep = false;  break; }
        }
        if( canSleep )
            b2TrySleepIsland( world, islandId );

        i = i - 1;
    }
}


// Emit a b2ContactHitEvent for each awake touching contact whose shapes opted in
// (b2_simEnableHitEvent, armed in b2UpdateContact) and whose solved approach speed
// at a contact point exceeds world->hitEventThreshold. Ported from the "Report hit
// events" block of upstream solver.c, minus the constraint-graph / worker-bitset
// fast path -- the port scans the awake set's dense contactSims directly. Reads the
// manifold data b2StoreImpulses just wrote back (normalVelocity + totalNormalImpulse),
// so it MUST run after b2StoreImpulses. b2Manifold.points is a fixed array member ->
// the two points are examined with CONSTANT indices (a variable index miscompiles).
void b2ReportHitEvents( b2World* world )
{
    float threshold = world->hitEventThreshold;
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    int count = awakeSet->contactSims.count;

    int i;
    for( i = 0; i < count; ++i )
    {
        b2ContactSim* contactSim = &awakeSet->contactSims.data[i];

        if( ( contactSim->simFlags & b2_simEnableHitEvent ) == 0 )
            continue;

        // pick the point with the largest approach speed past the threshold, requiring
        // a real (non-speculative) impulse. Unroll the <= 2 points (constant index).
        float bestSpeed = threshold;
        int   bestPoint = -1;           // -1 = none, else the winning point index 0/1
        int   pointCount = contactSim->manifold.pointCount;

        if( pointCount >= 1 )
        {
            float speed = -contactSim->manifold.points[0].normalVelocity;
            if( speed > bestSpeed && contactSim->manifold.points[0].totalNormalImpulse > 0.0 )
            {
                bestSpeed = speed;
                bestPoint = 0;
            }
        }
        if( pointCount >= 2 )
        {
            float speed = -contactSim->manifold.points[1].normalVelocity;
            if( speed > bestSpeed && contactSim->manifold.points[1].totalNormalImpulse > 0.0 )
            {
                bestSpeed = speed;
                bestPoint = 1;
            }
        }

        if( bestPoint == -1 )
            continue;

        // reconstruct the world point from a body center + the matching anchor;
        // prefer the static body's anchor so a fast body hitting the world stays exact.
        b2Shape* shapeA = &world->shapes.data[ contactSim->shapeIdA ];
        b2Shape* shapeB = &world->shapes.data[ contactSim->shapeIdB ];
        b2Body* bodyA = &world->bodies.data[ shapeA->bodyId ];
        b2Body* bodyB = &world->bodies.data[ shapeB->bodyId ];

        b2Vec2 anchor;
        b2Pos* center;
        if( bodyA->type != b2_staticBody && bodyB->type == b2_staticBody )
        {
            if( bestPoint == 0 )  anchor = contactSim->manifold.points[0].anchorB;
            else                  anchor = contactSim->manifold.points[1].anchorB;
            b2BodySim* simB = b2GetBodySim( world, bodyB );
            center = &simB->center;
        }
        else
        {
            if( bestPoint == 0 )  anchor = contactSim->manifold.points[0].anchorA;
            else                  anchor = contactSim->manifold.points[1].anchorA;
            b2BodySim* simA = b2GetBodySim( world, bodyA );
            center = &simA->center;
        }

        b2ContactHitEvent ev;
        b2Add( center, &anchor, &ev.point );
        ev.normal = contactSim->manifold.normal;
        ev.shapeIdA = contactSim->shapeIdA;
        ev.shapeIdB = contactSim->shapeIdB;
        ev.approachSpeed = bestSpeed;

        b2AddHitEvent( &world->contactHitEvents, &ev );
    }
}


void b2Solve( b2World* world, float dt, int subStepCount )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    int contactCapacity = awakeSet->contactSims.count;

    if( subStepCount < 1 )
        subStepCount = 1;
    float h = dt / subStepCount;
    float inv_h;
    if( h > 0.0 ) inv_h = 1.0 / h; else inv_h = 0.0;
    world->inv_h = inv_h;          // persist for the joint reaction-force getters

    // per-second speed caps for the position integrator (angular scales by inv_dt)
    float inv_dt;  if( dt > 0.0 ) inv_dt = 1.0 / dt; else inv_dt = 0.0;
    float maxLinearSpeed  = world->maxLinearSpeed;
    float maxAngularSpeed = B2_MAX_ROTATION * inv_dt;

    // soft params (contact hertz clamped so it stays stable for the sub-step rate)
    float contactHertz = b2MinFloat( world->contactHertz, 0.125 * inv_h );
    b2Softness contactSoftness;  b2MakeSoft( contactHertz, world->contactDampingRatio, h, &contactSoftness );
    b2Softness staticSoftness;   b2MakeSoft( 2.0 * contactHertz, world->contactDampingRatio, h, &staticSoftness );

    // Persistent grow-only solver scratch (5.5): reuse world->constraintScratch
    // instead of a b2Alloc+b2Free every step (the console malloc walks a free-list
    // and splits/merges -- real cycles + fragmentation). Grow only when a step
    // needs more constraint slots than ever before.
    b2ContactConstraint* constraints = NULL;
    int constraintCount = 0;
    if( contactCapacity > 0 )
    {
        if( contactCapacity > world->constraintScratchCapacity )
        {
            if( world->constraintScratch != NULL )
                b2Free( world->constraintScratch, world->constraintScratchCapacity * sizeof( b2ContactConstraint ) );
            world->constraintScratch = b2Alloc( contactCapacity * sizeof( b2ContactConstraint ) );
            world->constraintScratchCapacity = contactCapacity;
        }
        constraints = world->constraintScratch;
        constraintCount = b2PrepareContacts( world, constraints, &contactSoftness, &staticSoftness );
    }

    // Joints (slice 2): prepared unconditionally (independent of contacts). Stage
    // order per box2d/src/solver.c serial path -- joints BEFORE contacts each stage.
    b2PrepareJoints( world, h, inv_h );

    int sub;
    for( sub = 0; sub < subStepCount; ++sub )
    {
        b2IntegrateVelocities( world, h );
        if( world->enableWarmStarting )
        {
            b2WarmStartJoints( world );
            b2WarmStartContacts( world, constraints, constraintCount );
        }
        b2SolveJoints( world, h, inv_h, true );
        b2SolveContacts( world, constraints, constraintCount, inv_h, true );
        b2IntegratePositions( world, h, maxLinearSpeed, maxAngularSpeed );
        b2SolveJoints( world, h, inv_h, false );                                // relax
        b2SolveContacts( world, constraints, constraintCount, inv_h, false );   // relax
    }

    b2ApplyRestitution( world, constraints, constraintCount );   // bounce pass
    b2StoreImpulses( world, constraints, constraintCount );      // cross-step warm start
    b2ReportHitEvents( world );                                  // emit hit events (reads stored manifold data)
    b2FinalizeBodies( world, dt, inv_dt );                       // + per-body sleepTime
    if( world->enableSleep )                                     // split before sleep so sub-islands can settle apart
    {
        b2UpdateSplitIsland( world );
        if( world->splitIslandId != B2_NULL_INDEX )
        {
            b2SplitIsland( world, world->splitIslandId );
            world->splitIslandId = B2_NULL_INDEX;
        }
    }
    b2UpdateSleep( world );                                      // migrate settled islands to sleep

    // NOTE: constraints points into world->constraintScratch (persistent, 5.5) --
    // it is NOT freed here; it is released once in b2DestroyWorld.
}


// Advance the simulation by dt. Pipeline (upstream order): broad-phase pairing
// (consumes proxies moved last step -> new contacts) -> narrow phase (manifolds +
// touching) -> b2Solve (prepare + sub-stepped integrate/solve + finalize+MoveProxy).
// The constraint solve does normal + friction + restitution impulses (no cross-step warm-store yet).
//
// Timing note: pairing runs BEFORE bodies move, so a contact is created the step
// AFTER two proxies first overlap (the move is buffered in finalize and consumed
// by the next step's pairing).
void b2World_Step( b2World* world, float dt, int subStepCount )
{
    if( dt <= 0.0 )
        return;

    // clear last step's touch events (P1.3); b2Collide appends this step's
    world->beginTouchEvents.count = 0;
    world->endTouchEvents.count = 0;
    world->contactHitEvents.count = 0;
    world->sensorBeginEvents.count = 0;
    world->sensorEndEvents.count = 0;

    b2UpdateBroadPhasePairs( world );   // find new pairs from last step's moves
    b2Collide( world );                 // recompute manifolds + touching status
    b2Solve( world, dt, subStepCount ); // prepare + sub-step integrate/solve + finalize
    b2OverlapSensors( world );          // sensor overlap detection + begin/end events
}


// *****************************************************************************
    #endif
// *****************************************************************************
