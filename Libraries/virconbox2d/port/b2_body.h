/* *****************************************************************************
*  VirconBox2D : b2_body.h          (port of Box2D v3 body.c / body.h -- SLICE 1)
*  --------------------------------------------------------------------------- *
*  FIRST world-bearing module. Brings up a MINIMAL b2World plus body creation   *
*  and the read accessors -- the load-bearing sparse/dense indirection that     *
*  every later module assumes:                                                  *
*    - b2Body (organizational record) lives in world->bodies, indexed by id     *
*    - b2BodySim / b2BodyState live in DENSE per-solver-set arrays              *
*    - body->setIndex + body->localIndex link the sparse record to its dense    *
*      sim/state. This indirection is the thing being ported, not incidental.   *
*                                                                              *
*  SLICE 1 scope (per the resume plan): world skeleton, the generic array-grow  *
*  helper (container.h's b2Array macros use `##`, unavailable here), b2CreateBody *
*  for the static / awake / disabled solver sets, and the accessors             *
*  (transform / sim / state / id). The sleeping-set branch is ported for        *
*  fidelity but left untested. DEFERRED to later slices: b2DestroyBody          *
*  (b2RemoveBodySim swap-and-fixup), b2UpdateBodyMassData (needs shapes attached *
*  to bodies), islands (b2CreateIslandForBody is stubbed no-op), and the whole   *
*  solver/contact/joint machinery the full b2World would otherwise pull in.     *
*                                                                              *
*  Port notes: b2BodyId is multi-word (index1/world0/generation) so it returns  *
*  via an out-pointer, like the b2WorldTransform returns. The world is passed   *
*  directly as a b2World* (no b2WorldId registry). uint32 flags -> int,         *
*  uint16 generation -> int. The debug name[] (char) is dropped, as in the      *
*  arena allocator. switch -> if/else; no ternary; no compound literals.        *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_BODY_H
    #define B2_BODY_H

    #include "b2_math.h"
    #include "b2_constants.h"
    #include "b2_core.h"
    #include "b2_id_pool.h"
    #include "b2_shape.h"
    #include "b2_broad_phase.h"
    #include "b2_contact.h"
    #include "b2_joint.h"
    #include "b2_island.h"
// *****************************************************************************


// ---- b2BodyType: b2_staticBody/kinematic/dynamic now defined in b2_broad_phase.h
//      (the broad-phase trees are keyed by body type)

// ---- solver set indices (from solver_set.h) --------------------------------
#define b2_staticSet         0
#define b2_disabledSet       1
#define b2_awakeSet          2
#define b2_firstSleepingSet  3

// ---- b2BodyFlags (subset that create() / the solver read) ------------------
#define b2_lockLinearX               1     // 0x0001
#define b2_lockLinearY               2     // 0x0002
#define b2_lockAngularZ              4     // 0x0004
#define b2_isFast                    8     // 0x0008 (TRANSIENT: this body moved far enough
                                           //  this step to need continuous collision. Set and
                                           //  cleared inside b2FinalizeBodies each step.)
#define b2_isSpeedCapped             32    // 0x0020 (set when integrate clamps a velocity)
#define b2_isBullet                  16    // 0x0010
#define b2_allowFastRotation         128   // 0x0080
#define b2_dynamicFlag               512   // 0x0200
#define b2_enableSleep               2048  // 0x0800
#define b2_bodyEnableContactRecycling 4096 // 0x1000


// A stable, generation-checked handle to a body. (Upstream packs world0/
// generation into uint16; here they are plain ints -> 3 words, so b2BodyId is
// returned through an out-pointer rather than by value.)
struct b2BodyId
{
    int index1;       // 1-based index into world->bodies (0 means null)
    int world0;       // world id
    int generation;   // must match body->generation or the id is stale
};

// Construction parameters. Initialize with b2DefaultBodyDef(). (name dropped.)
struct b2BodyDef
{
    int   type;             // b2_staticBody / b2_kinematicBody / b2_dynamicBody
    b2Pos position;
    b2Rot rotation;
    b2Vec2 linearVelocity;
    float angularVelocity;
    float linearDamping;
    float angularDamping;
    float gravityScale;
    float sleepThreshold;
    void* userData;
    bool  lockLinearX;      // upstream's nested b2MotionLocks, flattened
    bool  lockLinearY;
    bool  lockAngularZ;
    bool  enableSleep;
    bool  isAwake;
    bool  isBullet;
    bool  isEnabled;
    bool  allowFastRotation;
    bool  enableContactRecycling;
};

// Organizational body record (sparse, indexed by id). No name[].
struct b2Body
{
    void* userData;
    int   setIndex;        // which solver set holds this body's sim/state
    int   localIndex;      // dense index within that set's arrays
    int   headContactKey;
    int   contactCount;
    int   headShapeId;
    int   shapeCount;
    int   headChainId;
    int   headJointKey;
    int   jointCount;
    int   islandId;
    int   islandIndex;
    float mass;
    float inertia;
    float sleepThreshold;
    float sleepTime;
    int   bodyMoveIndex;
    int   id;
    int   flags;           // b2BodyFlags (uint32 upstream)
    int   type;            // b2BodyType
    int   generation;      // uint16 upstream
};

// Per-body integration data (dense, in the owning solver set).
struct b2BodySim
{
    b2WorldTransform transform;   // body origin transform
    b2Pos center;                 // world-space center of mass
    b2Rot rotation0;              // previous rotation (TOI)
    b2Pos center0;                // previous COM (TOI)
    b2Vec2 localCenter;           // COM relative to body origin
    b2Vec2 force;
    float torque;
    float invMass;
    float invInertia;
    float minExtent;
    float maxExtent;
    float linearDamping;
    float angularDamping;
    float gravityScale;
    int bodyId;
    int flags;
};

// Velocity/solver state (dense, ONLY in the awake set).
struct b2BodyState
{
    b2Vec2 linearVelocity;
    float angularVelocity;
    int flags;
    b2Vec2 deltaPosition;
    b2Rot deltaRotation;
};


// ---- typed dynamic arrays (replace container.h's `##` macros) ---------------
struct b2BodyArray      { b2Body*      data;  int count;  int capacity; };
struct b2BodySimArray   { b2BodySim*   data;  int count;  int capacity; };
struct b2BodyStateArray { b2BodyState* data;  int count;  int capacity; };

// A solver set: dense bodySims (all live sets) + bodyStates (awake set only) +
// contactSims (non-touching contacts for the awake set; all contacts for sleeping
// sets). jointSims / islandSims are deferred until those modules land.
struct b2SolverSet
{
    b2BodySimArray    bodySims;
    b2BodyStateArray  bodyStates;
    b2ContactSimArray contactSims;
    b2JointSimArray   jointSims;
    b2IslandSimArray  islandSims;   // islands resident in this set (Phase C)
    int setIndex;            // aligns with world->solverSetIdPool; B2_NULL_INDEX if unused
};

struct b2SolverSetArray { b2SolverSet* data;  int count;  int capacity; };

// Minimal world: only the fields b2CreateBody and the accessors touch. Add a
// field when a future slice's function actually reads it (broadPhase, stack,
// constraintGraph, contacts, joints, islands, events ... all deferred).
// Begin/end-touch event polling (P1.3, upstream physics_world.c contact events).
// A grow-array of shape-id pairs, cleared at each b2World_Step start and appended
// in b2Collide where a contact's touching flag transitions (and on disjoint
// destroy of a touching contact). Games poll after the step via the
// b2World_Get*TouchEvent* accessors below. NOTE: shape ids here are raw indices
// into world->shapes, stored in the contact's PRIMARY order (b2CreateContact may
// have flipped A/B) -- a pair is a pair; generation-checked b2ShapeId is deferred.
// DEFERRED (vs upstream): a touching contact destroyed by b2DestroyBody / shape /
// joint teardown does NOT emit an end-touch event -- only natural separation in
// b2Collide (transition or disjoint-destroy) does. Upstream fires it from inside
// b2DestroyContact; add there if a game needs "shape removed while touching".
struct b2TouchEvent
{
    int shapeIdA;
    int shapeIdB;
};
struct b2TouchEventArray { b2TouchEvent* data;  int count;  int capacity; };


// A hit event: emitted after the solve for a touching contact whose shapes opted
// in (b2ShapeDef.enableHitEvents) when the solved approach speed at a contact
// point exceeds world->hitEventThreshold. Cleared + rebuilt each b2World_Step;
// poll after the step via b2World_GetContactHitEvent*. shapeIdA/B are raw shape
// indices in the contact's PRIMARY order (same convention as b2TouchEvent). point
// is reconstructed from a body center + the manifold anchor and is approximate
// (it drags with a moved body); prefer the static body's anchor when one is static.
struct b2ContactHitEvent
{
    b2Vec2 point;         // approximate world contact point
    b2Vec2 normal;        // world normal, points A->B
    int   shapeIdA;
    int   shapeIdB;
    float approachSpeed;  // closing speed of the two points before the solve (>= threshold)
};
struct b2ContactHitEventArray { b2ContactHitEvent* data;  int count;  int capacity; };


// A sensor overlap event: a visitor shape began or ended overlapping a sensor
// shape. shapeIds are raw indices into world->shapes. Begin/end are diffed across
// steps by b2OverlapSensors and polled after the step via b2World_GetSensor*Events.
struct b2SensorTouchEvent
{
    int sensorShapeId;
    int visitorShapeId;
};
struct b2SensorTouchEventArray { b2SensorTouchEvent* data;  int count;  int capacity; };


// A snapshot of one touching contact, filled by b2Shape_GetContactData /
// b2Body_GetContactData into a caller-owned array. DEVIATION: upstream carries two
// b2ShapeId handles; the port stores raw shape indices (same convention as
// b2TouchEvent -- resolve with b2MakeShapeId). It DOES carry a generation-checked
// b2ContactId (feed it to b2Contact_GetData / b2Contact_IsValid). The manifold is
// the current world-space manifold.
struct b2ContactData
{
    b2ContactId contactId;
    int shapeIdA;
    int shapeIdB;
    b2Manifold manifold;
};


struct b2World
{
    b2IdPool bodyIdPool;
    b2BodyArray bodies;            // sparse: indexed by body id

    b2IdPool solverSetIdPool;
    b2SolverSetArray solverSets;   // dense sim/state storage per set

    b2IdPool shapeIdPool;
    b2ShapeArray shapes;           // sparse: indexed by shape id

    b2BroadPhase broadPhase;       // body-type-keyed AABB trees

    b2IdPool contactIdPool;
    b2ContactArray contacts;       // sparse: indexed by contact id

    b2IdPool jointIdPool;
    b2JointArray joints;           // sparse: indexed by joint id

    b2IdPool islandIdPool;
    b2IslandArray islands;         // sparse: indexed by island id (Phase C)
    int splitIslandId;             // island flagged for split this step (B2_NULL_INDEX; split deferred)

    bool enableSleep;              // world-level sleep toggle (Phase C)
    bool enableContinuous;         // world-level continuous/TOI toggle (default OFF -> frozen harness bit-identical)
    bool enableWarmStarting;       // world-level warm-start toggle (default ON; b2Solve skips both warm-start passes when off)
    void* userData;                // opaque game pointer (b2World_Set/GetUserData)
    float inv_h;                   // 1/substep-dt of the LAST b2World_Step, persisted so the
                                   // joint reaction-force getters can return impulse*inv_h
                                   // (upstream keeps this as world->inv_h; 0 before the first step)

    b2Vec2 gravity;                // world gravity (default (0,-10))
    float contactHertz;            // contact constraint stiffness (default 30)
    float contactDampingRatio;     // contact damping (default 10)
    float contactSpeed;            // max contact push-out speed (default 3)
    float restitutionThreshold;    // min approach speed for a bounce (default 1)
    float hitEventThreshold;       // min approach speed to emit a hit event (default 1)
    float maxLinearSpeed;          // per-body linear speed cap (default 400)
    int worldId;

    // Persistent grow-only solver scratch (PLAN_FOR_OPUS.md 5.5): the contact-
    // constraint array b2Solve needs every step. Kept across steps so b2Solve no
    // longer does a b2Alloc+b2Free (a free-list walk + split/merge) per step.
    // Typed void* because b2ContactConstraint is defined later, in b2_solver.h;
    // b2Solve assigns it into a typed pointer (void* -> T* is implicit).
    void* constraintScratch;
    int constraintScratchCapacity;   // # of b2ContactConstraint slots it can hold

    // Begin/end-touch event polls (P1.3). Cleared (count=0, capacity kept) at the
    // top of each b2World_Step; appended in b2Collide on a touching transition.
    b2TouchEventArray beginTouchEvents;
    b2TouchEventArray endTouchEvents;

    // Contact hit events (P1.3 tail). Cleared at the top of each b2World_Step;
    // appended by b2ReportHitEvents (b2_solver.h) right after b2StoreImpulses.
    b2ContactHitEventArray contactHitEvents;

    // Sensor overlap events (P1.5). Cleared at the top of each b2World_Step;
    // appended by b2OverlapSensors after the solve. sensorScratch is a reused
    // grow-only buffer holding one sensor's freshly-computed overlap set.
    b2SensorTouchEventArray sensorBeginEvents;
    b2SensorTouchEventArray sensorEndEvents;
    int* sensorScratch;
    int  sensorScratchCapacity;
};


// Append a shape-id pair to a touch-event grow array (grow-only; b2World_Step
// resets .count each step, so the backing buffer is reused across steps).
// Begin/end touch events are opt-OUT per shape and BOTH shapes must be opted in
// (upstream folds this into b2_simEnableContactEvents on the contactSim at create;
// the port tests the two shapes at the three emit sites in b2Collide instead).
// Defaults to true on every shape, so the ungated pre-P1.3 behaviour is unchanged.
bool b2ShouldReportContactEvents( b2Shape* shapeA, b2Shape* shapeB )
{
    return shapeA->enableContactEvents && shapeB->enableContactEvents;
}

void b2AddTouchEvent( b2TouchEventArray* arr, int shapeIdA, int shapeIdB )
{
    arr->data = b2GrowArray( arr->data, &arr->capacity, arr->count + 1, sizeof( b2TouchEvent ) );
    arr->data[ arr->count ].shapeIdA = shapeIdA;
    arr->data[ arr->count ].shapeIdB = shapeIdB;
    arr->count = arr->count + 1;
}


// Public begin/end-touch poll API (P1.3). Read AFTER b2World_Step; valid until
// the next step (which clears the counts). The array pointer is a heap array of
// b2TouchEvent -- variable-index it directly (evts[i].shapeIdA), which is the
// dialect-safe heap-pointer-array access. Returns NULL only when count is 0.
int b2World_GetBeginTouchEventCount( b2World* world )   { return world->beginTouchEvents.count; }
int b2World_GetEndTouchEventCount( b2World* world )     { return world->endTouchEvents.count; }
b2TouchEvent* b2World_GetBeginTouchEvents( b2World* world )  { return world->beginTouchEvents.data; }
b2TouchEvent* b2World_GetEndTouchEvents( b2World* world )    { return world->endTouchEvents.data; }


// Append a hit event (grow-only; b2World_Step resets .count each step).
void b2AddHitEvent( b2ContactHitEventArray* arr, b2ContactHitEvent* ev )
{
    arr->data = b2GrowArray( arr->data, &arr->capacity, arr->count + 1, sizeof( b2ContactHitEvent ) );
    arr->data[ arr->count ] = *ev;
    arr->count = arr->count + 1;
}

// Public hit-event poll API. Read AFTER b2World_Step; valid until the next step.
// The array is a heap array of b2ContactHitEvent -- variable-index it directly.
int b2World_GetContactHitEventCount( b2World* world )  { return world->contactHitEvents.count; }
b2ContactHitEvent* b2World_GetContactHitEvents( b2World* world )  { return world->contactHitEvents.data; }


// Append a sensor overlap event (grow-only; reset each step).
void b2AddSensorEvent( b2SensorTouchEventArray* arr, int sensorShapeId, int visitorShapeId )
{
    arr->data = b2GrowArray( arr->data, &arr->capacity, arr->count + 1, sizeof( b2SensorTouchEvent ) );
    arr->data[ arr->count ].sensorShapeId = sensorShapeId;
    arr->data[ arr->count ].visitorShapeId = visitorShapeId;
    arr->count = arr->count + 1;
}

// Public sensor overlap poll API (P1.5). Read AFTER b2World_Step; valid until the
// next step. Heap arrays -- variable-index ev[i] directly. shapeIds are raw indices.
int b2World_GetSensorBeginEventCount( b2World* world )  { return world->sensorBeginEvents.count; }
int b2World_GetSensorEndEventCount( b2World* world )    { return world->sensorEndEvents.count; }
b2SensorTouchEvent* b2World_GetSensorBeginEvents( b2World* world )  { return world->sensorBeginEvents.data; }
b2SensorTouchEvent* b2World_GetSensorEndEvents( b2World* world )    { return world->sensorEndEvents.data; }


// -----------------------------------------------------------------------------
//   World create / destroy (minimal)
//   (b2GrowArray, the generic array-grow helper, now lives in b2_core.h)
// -----------------------------------------------------------------------------
void b2CreateWorld( b2World* world )
{
    b2CreateIdPool( &world->bodyIdPool );
    world->bodies.data = NULL;
    world->bodies.count = 0;
    world->bodies.capacity = 0;

    b2CreateIdPool( &world->solverSetIdPool );
    world->solverSets.data = NULL;
    world->solverSets.count = 0;
    world->solverSets.capacity = 0;

    b2CreateIdPool( &world->shapeIdPool );
    world->shapes.data = NULL;
    world->shapes.count = 0;
    world->shapes.capacity = 0;

    b2CreateBroadPhase( &world->broadPhase );

    b2CreateIdPool( &world->contactIdPool );
    world->contacts.data = NULL;
    world->contacts.count = 0;
    world->contacts.capacity = 0;

    b2CreateIdPool( &world->jointIdPool );
    world->joints.data = NULL;
    world->joints.count = 0;
    world->joints.capacity = 0;

    world->gravity.x = 0.0;
    world->gravity.y = -10.0;
    world->contactHertz = 30.0;
    world->contactDampingRatio = 10.0;
    world->contactSpeed = 3.0;
    world->restitutionThreshold = 1.0;
    world->hitEventThreshold = 1.0;
    world->maxLinearSpeed = 400.0;
    world->worldId = 0;

    world->constraintScratch = NULL;
    world->constraintScratchCapacity = 0;

    world->beginTouchEvents.data = NULL;  world->beginTouchEvents.count = 0;  world->beginTouchEvents.capacity = 0;
    world->endTouchEvents.data = NULL;    world->endTouchEvents.count = 0;    world->endTouchEvents.capacity = 0;
    world->contactHitEvents.data = NULL;  world->contactHitEvents.count = 0;  world->contactHitEvents.capacity = 0;
    world->sensorBeginEvents.data = NULL; world->sensorBeginEvents.count = 0; world->sensorBeginEvents.capacity = 0;
    world->sensorEndEvents.data = NULL;   world->sensorEndEvents.count = 0;   world->sensorEndEvents.capacity = 0;
    world->sensorScratch = NULL;          world->sensorScratchCapacity = 0;

    // Three standing sets: static(0), disabled(1), awake(2). Each takes the
    // next solver-set id (so id == index), matching upstream b2CreateWorld.
    int i;
    for( i = 0; i < 3; ++i )
    {
        world->solverSets.data = b2GrowArray( world->solverSets.data,
                                              &world->solverSets.capacity,
                                              world->solverSets.count + 1,
                                              sizeof( b2SolverSet ) );
        b2SolverSet* set = &world->solverSets.data[ world->solverSets.count ];
        set->bodySims.data = NULL;     set->bodySims.count = 0;     set->bodySims.capacity = 0;
        set->bodyStates.data = NULL;   set->bodyStates.count = 0;   set->bodyStates.capacity = 0;
        set->contactSims.data = NULL;  set->contactSims.count = 0;  set->contactSims.capacity = 0;
        set->jointSims.data = NULL;    set->jointSims.count = 0;     set->jointSims.capacity = 0;
        set->islandSims.data = NULL;   set->islandSims.count = 0;    set->islandSims.capacity = 0;
        set->setIndex = b2AllocId( &world->solverSetIdPool );
        world->solverSets.count = world->solverSets.count + 1;
    }

    // island bookkeeping (Phase C)
    b2CreateIdPool( &world->islandIdPool );
    world->islands.data = NULL;  world->islands.count = 0;  world->islands.capacity = 0;
    world->splitIslandId = B2_NULL_INDEX;
    // PORT DEVIATION: sleep defaults OFF (upstream defaults ON). This keeps every
    // existing test/scene bit-identical (settled bodies stay in the awake set) so the
    // frozen regression suite is unaffected; a game/test opts in with world.enableSleep
    // = true. b2FinalizeBodies still accumulates sleepTime either way (harmless).
    world->enableSleep = false;
    world->enableContinuous = false;
    world->enableWarmStarting = true;
    world->userData = NULL;
    world->inv_h = 0.0;
}

void b2DestroyWorld( b2World* world )
{
    int i;
    for( i = 0; i < world->solverSets.count; ++i )
    {
        b2SolverSet* set = &world->solverSets.data[i];
        if( set->bodySims.data != NULL )
            b2Free( set->bodySims.data, set->bodySims.capacity * sizeof( b2BodySim ) );
        if( set->bodyStates.data != NULL )
            b2Free( set->bodyStates.data, set->bodyStates.capacity * sizeof( b2BodyState ) );
        if( set->contactSims.data != NULL )
            b2Free( set->contactSims.data, set->contactSims.capacity * sizeof( b2ContactSim ) );
        if( set->jointSims.data != NULL )
            b2Free( set->jointSims.data, set->jointSims.capacity * sizeof( b2JointSim ) );
        if( set->islandSims.data != NULL )
            b2Free( set->islandSims.data, set->islandSims.capacity * sizeof( b2IslandSim ) );
    }
    if( world->solverSets.data != NULL )
        b2Free( world->solverSets.data, world->solverSets.capacity * sizeof( b2SolverSet ) );
    if( world->bodies.data != NULL )
        b2Free( world->bodies.data, world->bodies.capacity * sizeof( b2Body ) );
    if( world->shapes.data != NULL )
        b2Free( world->shapes.data, world->shapes.capacity * sizeof( b2Shape ) );

    b2DestroyBroadPhase( &world->broadPhase );

    if( world->contacts.data != NULL )
        b2Free( world->contacts.data, world->contacts.capacity * sizeof( b2Contact ) );

    if( world->joints.data != NULL )
        b2Free( world->joints.data, world->joints.capacity * sizeof( b2Joint ) );

    // free any islands still live (their inline grow-arrays) + the islands array
    for( i = 0; i < world->islands.count; ++i )
    {
        b2Island* isl = &world->islands.data[i];
        if( isl->bodies != NULL )    b2Free( isl->bodies, isl->bodyCapacity );
        if( isl->contacts != NULL )  b2Free( isl->contacts, isl->contactCapacity * sizeof( b2ContactLink ) );
        if( isl->joints != NULL )    b2Free( isl->joints, isl->jointCapacity * sizeof( b2JointLink ) );
    }
    if( world->islands.data != NULL )
        b2Free( world->islands.data, world->islands.capacity * sizeof( b2Island ) );

    // persistent solver scratch (5.5). size arg is unused by the console heap
    // (b2Free just calls free), and sizeof(b2ContactConstraint) is not visible
    // here (type defined in b2_solver.h) -- pass the slot count as a marker.
    if( world->constraintScratch != NULL )
        b2Free( world->constraintScratch, world->constraintScratchCapacity );

    if( world->beginTouchEvents.data != NULL )
        b2Free( world->beginTouchEvents.data, world->beginTouchEvents.capacity * sizeof( b2TouchEvent ) );
    if( world->endTouchEvents.data != NULL )
        b2Free( world->endTouchEvents.data, world->endTouchEvents.capacity * sizeof( b2TouchEvent ) );
    if( world->contactHitEvents.data != NULL )
        b2Free( world->contactHitEvents.data, world->contactHitEvents.capacity * sizeof( b2ContactHitEvent ) );
    if( world->sensorBeginEvents.data != NULL )
        b2Free( world->sensorBeginEvents.data, world->sensorBeginEvents.capacity * sizeof( b2SensorTouchEvent ) );
    if( world->sensorEndEvents.data != NULL )
        b2Free( world->sensorEndEvents.data, world->sensorEndEvents.capacity * sizeof( b2SensorTouchEvent ) );
    if( world->sensorScratch != NULL )
        b2Free( world->sensorScratch, world->sensorScratchCapacity * sizeof( int ) );

    b2DestroyIdPool( &world->bodyIdPool );
    b2DestroyIdPool( &world->solverSetIdPool );
    b2DestroyIdPool( &world->shapeIdPool );
    b2DestroyIdPool( &world->contactIdPool );
    b2DestroyIdPool( &world->jointIdPool );
    b2DestroyIdPool( &world->islandIdPool );
}


// =============================================================================
//   ISLANDS (Phase C) -- connected-component bookkeeping. Port of the merge path
//   of box2d/src/island.c (b2SplitIsland deferred -- see b2_island.h). These keep
//   the island graph current so Phase C sleeping can migrate a whole component
//   between solver sets. In C1 they are PURE BOOKKEEPING (no simulation effect);
//   b2WakeSolverSet is a no-op stub until C2 makes sleeping real.
// =============================================================================

// Real implementations are further down (just before b2Collide, where the solver-
// set helpers are in scope). Forward-declared here; waking is driven from b2Collide's
// inline wake (with pointer refetch), NOT from b2LinkContact/b2LinkJoint.
void b2WakeSolverSet( b2World* world, int setIndex );
void b2DestroySolverSet( b2World* world, int setIndex );

// The shared wake helper (upstream body.c b2WakeBody): wakes the body's whole
// solver set if it is sleeping. Everything that must wake a body funnels through
// here -- contact/joint destroy-with-wake, b2Body_SetTransform, b2CreateJoint,
// and the public b2Body_Wake. Returns true if a wake actually happened.
// NOTE: waking moves sims/states between solver sets (setIndex/localIndex of
// every member change) -- refetch any cached b2BodySim*/b2ContactSim*/localIndex
// after calling this. Pointers into the sparse arrays (b2Body*, b2Contact*,
// b2Joint*) stay valid.
bool b2WakeBody( b2World* world, b2Body* body )
{
    if( body->setIndex >= b2_firstSleepingSet )
    {
        b2WakeSolverSet( world, body->setIndex );
        return true;
    }
    return false;
}

b2Island* b2CreateIsland( b2World* world, int setIndex )
{
    int islandId = b2AllocId( &world->islandIdPool );
    if( islandId == world->islands.count )
    {
        world->islands.data = b2GrowArray( world->islands.data, &world->islands.capacity,
                                           world->islands.count + 1, sizeof( b2Island ) );
        memset( &world->islands.data[ islandId ], 0, sizeof( b2Island ) );
        world->islands.count = world->islands.count + 1;
    }

    b2SolverSet* set = &world->solverSets.data[ setIndex ];
    b2Island* island = &world->islands.data[ islandId ];
    island->setIndex = setIndex;
    island->localIndex = set->islandSims.count;
    island->islandId = islandId;
    island->constraintRemoveCount = 0;
    island->bodies = NULL;    island->bodyCount = 0;     island->bodyCapacity = 0;
    island->contacts = NULL;  island->contactCount = 0;  island->contactCapacity = 0;
    island->joints = NULL;    island->jointCount = 0;    island->jointCapacity = 0;

    set->islandSims.data = b2GrowArray( set->islandSims.data, &set->islandSims.capacity,
                                        set->islandSims.count + 1, sizeof( b2IslandSim ) );
    set->islandSims.data[ set->islandSims.count ].islandId = islandId;
    set->islandSims.count = set->islandSims.count + 1;

    return island;
}

void b2DestroyIsland( b2World* world, int islandId )
{
    if( world->splitIslandId == islandId )
        world->splitIslandId = B2_NULL_INDEX;

    b2Island* island = &world->islands.data[ islandId ];
    b2SolverSet* set = &world->solverSets.data[ island->setIndex ];

    // swap-remove the islandSim from its set; repair the moved island's localIndex
    int localIndex = island->localIndex;
    int lastIndex = set->islandSims.count - 1;
    if( localIndex != lastIndex )
    {
        int moveIslandId = set->islandSims.data[ lastIndex ].islandId;
        set->islandSims.data[ localIndex ] = set->islandSims.data[ lastIndex ];
        world->islands.data[ moveIslandId ].localIndex = localIndex;
    }
    set->islandSims.count = set->islandSims.count - 1;

    // free the island's inline grow-arrays
    if( island->bodies != NULL )    b2Free( island->bodies, island->bodyCapacity );
    if( island->contacts != NULL )  b2Free( island->contacts, island->contactCapacity * sizeof( b2ContactLink ) );
    if( island->joints != NULL )    b2Free( island->joints, island->jointCapacity * sizeof( b2JointLink ) );
    island->bodies = NULL;    island->bodyCount = 0;     island->bodyCapacity = 0;
    island->contacts = NULL;  island->contactCount = 0;  island->contactCapacity = 0;
    island->joints = NULL;    island->jointCount = 0;    island->jointCapacity = 0;
    island->constraintRemoveCount = 0;
    island->localIndex = B2_NULL_INDEX;
    island->islandId = B2_NULL_INDEX;
    island->setIndex = B2_NULL_INDEX;

    b2FreeId( &world->islandIdPool, islandId );
}

// Merge two islands, keeping the bigger one (fewer element moves). Returns the id
// of the survivor; the smaller island is destroyed. Either id may be B2_NULL_INDEX
// (a static body has no island) -> the other is returned unchanged.
int b2MergeIslands( b2World* world, int islandIdA, int islandIdB )
{
    if( islandIdA == islandIdB )      return islandIdA;
    if( islandIdA == B2_NULL_INDEX )  return islandIdB;
    if( islandIdB == B2_NULL_INDEX )  return islandIdA;

    b2Island* islandA = &world->islands.data[ islandIdA ];
    b2Island* islandB = &world->islands.data[ islandIdB ];
    b2Island* bigIsland;
    b2Island* smallIsland;
    if( islandA->bodyCount >= islandB->bodyCount ) { bigIsland = islandA;  smallIsland = islandB; }
    else                                           { bigIsland = islandB;  smallIsland = islandA; }
    int bigIslandId = bigIsland->islandId;

    int i;
    for( i = 0; i < smallIsland->bodyCount; ++i )
    {
        int bodyId = smallIsland->bodies[i];
        b2Body* body = &world->bodies.data[ bodyId ];
        body->islandId = bigIslandId;
        body->islandIndex = bigIsland->bodyCount;
        bigIsland->bodies = b2GrowArray( bigIsland->bodies, &bigIsland->bodyCapacity,
                                         bigIsland->bodyCount + 1, 1 );
        bigIsland->bodies[ bigIsland->bodyCount ] = bodyId;
        bigIsland->bodyCount = bigIsland->bodyCount + 1;
    }
    for( i = 0; i < smallIsland->contactCount; ++i )
    {
        b2ContactLink link = smallIsland->contacts[i];
        b2Contact* contact = &world->contacts.data[ link.contactId ];
        contact->islandId = bigIslandId;
        contact->islandIndex = bigIsland->contactCount;
        bigIsland->contacts = b2GrowArray( bigIsland->contacts, &bigIsland->contactCapacity,
                                           bigIsland->contactCount + 1, sizeof( b2ContactLink ) );
        bigIsland->contacts[ bigIsland->contactCount ] = link;
        bigIsland->contactCount = bigIsland->contactCount + 1;
    }
    for( i = 0; i < smallIsland->jointCount; ++i )
    {
        b2JointLink link = smallIsland->joints[i];
        b2Joint* joint = &world->joints.data[ link.jointId ];
        joint->islandId = bigIslandId;
        joint->islandIndex = bigIsland->jointCount;
        bigIsland->joints = b2GrowArray( bigIsland->joints, &bigIsland->jointCapacity,
                                         bigIsland->jointCount + 1, sizeof( b2JointLink ) );
        bigIsland->joints[ bigIsland->jointCount ] = link;
        bigIsland->jointCount = bigIsland->jointCount + 1;
    }

    bigIsland->constraintRemoveCount = bigIsland->constraintRemoveCount + smallIsland->constraintRemoveCount;
    b2DestroyIsland( world, smallIsland->islandId );
    return bigIslandId;
}

void b2AddContactToIsland( b2World* world, int islandId, b2Contact* contact )
{
    b2Island* island = &world->islands.data[ islandId ];
    contact->islandId = islandId;
    contact->islandIndex = island->contactCount;
    b2ContactLink link;
    link.contactId = contact->contactId;
    link.bodyIdA = contact->edges[0].bodyId;
    link.bodyIdB = contact->edges[1].bodyId;
    island->contacts = b2GrowArray( island->contacts, &island->contactCapacity,
                                    island->contactCount + 1, sizeof( b2ContactLink ) );
    island->contacts[ island->contactCount ] = link;
    island->contactCount = island->contactCount + 1;
}

// Link a now-touching contact into the island graph, merging the two bodies'
// islands (a static body contributes B2_NULL_INDEX -> no merge, just add).
void b2LinkContact( b2World* world, b2Contact* contact )
{
    int bodyIdA = contact->edges[0].bodyId;
    int bodyIdB = contact->edges[1].bodyId;
    b2Body* bodyA = &world->bodies.data[ bodyIdA ];
    b2Body* bodyB = &world->bodies.data[ bodyIdB ];

    // (wake is handled by b2Collide before it calls this -- so both bodies are awake
    // here; b2CreateContact never links a sleeping pair.)
    int finalIslandId = b2MergeIslands( world, bodyA->islandId, bodyB->islandId );
    b2AddContactToIsland( world, finalIslandId, contact );
}

// Unlink a no-longer-touching (or destroyed) contact from its island. Merge-only:
// the bodies stay in the island; we just remove the contact + flag a split candidate.
void b2UnlinkContact( b2World* world, b2Contact* contact )
{
    int islandId = contact->islandId;
    b2Island* island = &world->islands.data[ islandId ];
    int removeIndex = contact->islandIndex;
    int lastIndex = island->contactCount - 1;
    if( removeIndex != lastIndex )
    {
        island->contacts[ removeIndex ] = island->contacts[ lastIndex ];
        b2Contact* moved = &world->contacts.data[ island->contacts[ removeIndex ].contactId ];
        moved->islandIndex = removeIndex;
    }
    island->contactCount = island->contactCount - 1;
    contact->islandId = B2_NULL_INDEX;
    contact->islandIndex = B2_NULL_INDEX;
    island->constraintRemoveCount = island->constraintRemoveCount + 1;
}

void b2AddJointToIsland( b2World* world, int islandId, b2Joint* joint )
{
    b2Island* island = &world->islands.data[ islandId ];
    joint->islandId = islandId;
    joint->islandIndex = island->jointCount;
    b2JointLink link;
    link.jointId = joint->jointId;
    link.bodyIdA = joint->edges[0].bodyId;
    link.bodyIdB = joint->edges[1].bodyId;
    island->joints = b2GrowArray( island->joints, &island->jointCapacity,
                                  island->jointCount + 1, sizeof( b2JointLink ) );
    island->joints[ island->jointCount ] = link;
    island->jointCount = island->jointCount + 1;
}

void b2LinkJoint( b2World* world, b2Joint* joint )
{
    int bodyIdA = joint->edges[0].bodyId;
    int bodyIdB = joint->edges[1].bodyId;
    b2Body* bodyA = &world->bodies.data[ bodyIdA ];
    b2Body* bodyB = &world->bodies.data[ bodyIdB ];

    // (DEFERRED: waking on joint-create-onto-a-sleeping-body. Games currently don't
    // create joints onto already-sleeping bodies; add a wake here when they do.)
    int finalIslandId = b2MergeIslands( world, bodyA->islandId, bodyB->islandId );
    b2AddJointToIsland( world, finalIslandId, joint );
}

void b2UnlinkJoint( b2World* world, b2Joint* joint )
{
    if( joint->islandId == B2_NULL_INDEX )
        return;
    int islandId = joint->islandId;
    b2Island* island = &world->islands.data[ islandId ];
    int removeIndex = joint->islandIndex;
    int lastIndex = island->jointCount - 1;
    if( removeIndex != lastIndex )
    {
        island->joints[ removeIndex ] = island->joints[ lastIndex ];
        b2Joint* moved = &world->joints.data[ island->joints[ removeIndex ].jointId ];
        moved->islandIndex = removeIndex;
    }
    island->jointCount = island->jointCount - 1;
    joint->islandId = B2_NULL_INDEX;
    joint->islandIndex = B2_NULL_INDEX;
    island->constraintRemoveCount = island->constraintRemoveCount + 1;
}

// Give a freshly-created awake/sleeping dynamic (or kinematic) body its own island.
void b2CreateIslandForBody( b2World* world, int setIndex, b2Body* body )
{
    b2Island* island = b2CreateIsland( world, setIndex );
    island->bodies = b2GrowArray( island->bodies, &island->bodyCapacity, 1, 1 );
    island->bodies[0] = body->id;
    island->bodyCount = 1;
    body->islandId = island->islandId;
    body->islandIndex = 0;
}

// Remove a body from its island (on destroy); destroy the island if it goes empty.
void b2RemoveBodyFromIsland( b2World* world, b2Body* body )
{
    if( body->islandId == B2_NULL_INDEX )
        return;
    int islandId = body->islandId;
    b2Island* island = &world->islands.data[ islandId ];
    int localIndex = body->islandIndex;
    int lastIndex = island->bodyCount - 1;
    if( localIndex != lastIndex )
    {
        int movedBodyId = island->bodies[ lastIndex ];
        island->bodies[ localIndex ] = movedBodyId;
        world->bodies.data[ movedBodyId ].islandIndex = localIndex;
    }
    island->bodyCount = island->bodyCount - 1;
    body->islandId = B2_NULL_INDEX;
    body->islandIndex = B2_NULL_INDEX;
    if( island->bodyCount == 0 )
        b2DestroyIsland( world, islandId );
}


// -----------------------------------------------------------------------------
//   b2SplitIsland (F6 / P2.1): rebuild one island into its true connected
//   components after contacts/joints were removed. Islands are otherwise MERGE-
//   ONLY, so a body that briefly touched a pile then left keeps the whole pile in
//   one mega-island that can never sleep again as a unit (one moving member holds
//   ALL of it awake). This restores upstream's split so settled sub-piles sleep on
//   their own. Ported from box2d/src/island.c b2SplitIsland (serial; scratch via
//   b2Alloc/b2Free instead of the arena). The union-find NODE for a body is its
//   body->islandIndex (its slot in THIS island's bodies[]); static bodies have
//   islandIndex == B2_NULL_INDEX and never connect two components.
// -----------------------------------------------------------------------------

// Union-find find with path halving.
int b2IslandFindParent( int* parents, int node )
{
    while( parents[node] != node )
    {
        int grandParent = parents[ parents[node] ];
        parents[node] = grandParent;
        node = grandParent;
    }
    return node;
}

// Union by rank (per-component counts are not tracked -- the port doesn't reserve).
void b2IslandUnion( int* parents, int* ranks, int node1, int node2 )
{
    int root1 = b2IslandFindParent( parents, node1 );
    int root2 = b2IslandFindParent( parents, node2 );
    if( root1 == root2 )
        return;
    if( ranks[root1] < ranks[root2] )
        parents[root1] = root2;
    else if( ranks[root1] > ranks[root2] )
        parents[root2] = root1;
    else
    {
        parents[root2] = root1;
        ranks[root1] = ranks[root1] + 1;
    }
}

void b2SplitIsland( b2World* world, int baseId )
{
    b2Island* baseIsland = &world->islands.data[ baseId ];

    // cache the base island's arrays BEFORE any b2CreateIsland reallocs
    // world->islands (which would invalidate baseIsland and its inline pointers).
    int baseBodyCount = baseIsland->bodyCount;
    int* baseBodyIds = baseIsland->bodies;
    int baseBodyCapacity = baseIsland->bodyCapacity;

    int baseContactCount = baseIsland->contactCount;
    b2ContactLink* baseContacts = baseIsland->contacts;
    int baseContactCapacity = baseIsland->contactCapacity;

    int baseJointCount = baseIsland->jointCount;
    b2JointLink* baseJoints = baseIsland->joints;
    int baseJointCapacity = baseIsland->jointCapacity;

    if( baseBodyCount == 0 )
        return;

    // union-find scratch (int == 1 word; b2Alloc takes a word count)
    int* parents = b2Alloc( baseBodyCount );
    int* ranks = b2Alloc( baseBodyCount );
    int i;
    for( i = 0; i < baseBodyCount; ++i )
    {
        parents[i] = i;
        ranks[i] = 0;
    }

    // union non-static endpoints over contacts, then joints
    for( i = 0; i < baseContactCount; ++i )
    {
        int islandIndexA = world->bodies.data[ baseContacts[i].bodyIdA ].islandIndex;
        int islandIndexB = world->bodies.data[ baseContacts[i].bodyIdB ].islandIndex;
        if( islandIndexA != B2_NULL_INDEX && islandIndexB != B2_NULL_INDEX )
            b2IslandUnion( parents, ranks, islandIndexA, islandIndexB );
    }
    for( i = 0; i < baseJointCount; ++i )
    {
        int islandIndexA = world->bodies.data[ baseJoints[i].bodyIdA ].islandIndex;
        int islandIndexB = world->bodies.data[ baseJoints[i].bodyIdB ].islandIndex;
        if( islandIndexA != B2_NULL_INDEX && islandIndexB != B2_NULL_INDEX )
            b2IslandUnion( parents, ranks, islandIndexA, islandIndexB );
    }

    b2Free( ranks, baseBodyCount );

    // flatten parent pointers and count connected components
    int componentCount = 0;
    for( i = 0; i < baseBodyCount; ++i )
    {
        parents[i] = b2IslandFindParent( parents, i );
        if( parents[i] == i )
            componentCount = componentCount + 1;
    }

    // still one component -> no split; just clear the removal count and return
    if( componentCount == 1 )
    {
        baseIsland->constraintRemoveCount = 0;
        b2Free( parents, baseBodyCount );
        return;
    }

    // detach base arrays so b2DestroyIsland won't free them (freed manually below)
    baseIsland->bodies = NULL;    baseIsland->bodyCount = 0;     baseIsland->bodyCapacity = 0;
    baseIsland->contacts = NULL;  baseIsland->contactCount = 0;  baseIsland->contactCapacity = 0;
    baseIsland->joints = NULL;    baseIsland->jointCount = 0;    baseIsland->jointCapacity = 0;
    baseIsland = NULL;            // DO NOT use past here: b2CreateIsland reallocs world->islands

    // map from a root body-index to its new island id (only set at root indices)
    int* rootMap = b2Alloc( baseBodyCount );
    for( i = 0; i < baseBodyCount; ++i )
        rootMap[i] = B2_NULL_INDEX;

    // create one fresh awake island per component (read its id immediately -- the
    // next create may realloc world->islands, so never hold the b2Island*)
    for( i = 0; i < baseBodyCount; ++i )
    {
        int root = parents[i];
        if( rootMap[root] == B2_NULL_INDEX )
        {
            b2Island* newIsland = b2CreateIsland( world, b2_awakeSet );
            rootMap[root] = newIsland->islandId;
        }
    }

    // assign bodies to their component's island (no create here -> island* safe)
    for( i = 0; i < baseBodyCount; ++i )
    {
        int bodyId = baseBodyIds[i];
        int newIslandId = rootMap[ parents[i] ];
        b2Body* body = &world->bodies.data[ bodyId ];
        b2Island* island = &world->islands.data[ newIslandId ];
        body->islandId = newIslandId;
        body->islandIndex = island->bodyCount;
        island->bodies = b2GrowArray( island->bodies, &island->bodyCapacity, island->bodyCount + 1, 1 );
        island->bodies[ island->bodyCount ] = bodyId;
        island->bodyCount = island->bodyCount + 1;
    }

    // assign contacts to the island of their non-static body
    for( i = 0; i < baseContactCount; ++i )
    {
        b2ContactLink link = baseContacts[i];
        int targetIslandId = world->bodies.data[ link.bodyIdA ].islandId;
        if( targetIslandId == B2_NULL_INDEX )
            targetIslandId = world->bodies.data[ link.bodyIdB ].islandId;
        b2Contact* contact = &world->contacts.data[ link.contactId ];
        b2Island* island = &world->islands.data[ targetIslandId ];
        contact->islandId = targetIslandId;
        contact->islandIndex = island->contactCount;
        island->contacts = b2GrowArray( island->contacts, &island->contactCapacity, island->contactCount + 1, sizeof( b2ContactLink ) );
        island->contacts[ island->contactCount ] = link;
        island->contactCount = island->contactCount + 1;
    }

    // assign joints likewise
    for( i = 0; i < baseJointCount; ++i )
    {
        b2JointLink link = baseJoints[i];
        int targetIslandId = world->bodies.data[ link.bodyIdA ].islandId;
        if( targetIslandId == B2_NULL_INDEX )
            targetIslandId = world->bodies.data[ link.bodyIdB ].islandId;
        b2Joint* joint = &world->joints.data[ link.jointId ];
        b2Island* island = &world->islands.data[ targetIslandId ];
        joint->islandId = targetIslandId;
        joint->islandIndex = island->jointCount;
        island->joints = b2GrowArray( island->joints, &island->jointCapacity, island->jointCount + 1, sizeof( b2JointLink ) );
        island->joints[ island->jointCount ] = link;
        island->jointCount = island->jointCount + 1;
    }

    // destroy the now-empty base island (arrays detached -> frees nothing of ours),
    // then free the detached arrays with the SAME units as b2DestroyIsland uses.
    b2DestroyIsland( world, baseId );
    b2Free( baseBodyIds, baseBodyCapacity );
    b2Free( baseContacts, baseContactCapacity * sizeof( b2ContactLink ) );
    b2Free( baseJoints, baseJointCapacity * sizeof( b2JointLink ) );

    b2Free( rootMap, baseBodyCount );
    b2Free( parents, baseBodyCount );
}

// Pick at most one awake island to split this step: any with pending removals,
// largest islandId for determinism. b2SplitIsland self-throttles (a still-connected
// island early-returns and clears its removal count), so eager splitting is correct
// and cheap. Caller gates this on world->enableSleep. Sets world->splitIslandId.
void b2UpdateSplitIsland( b2World* world )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    int best = B2_NULL_INDEX;
    int i;
    for( i = 0; i < awakeSet->islandSims.count; ++i )
    {
        int islandId = awakeSet->islandSims.data[i].islandId;
        b2Island* island = &world->islands.data[ islandId ];
        if( island->constraintRemoveCount > 0 && islandId > best )
            best = islandId;
    }
    world->splitIslandId = best;
}


// -----------------------------------------------------------------------------
//   Accessors (sim/state live in the owning solver set, found via the indices)
// -----------------------------------------------------------------------------
b2Body* b2GetBodyFullId( b2World* world, b2BodyId* bodyId )
{
    // id index is 1-based so that zero can represent null
    return &world->bodies.data[ bodyId->index1 - 1 ];
}

void b2GetBodyTransformQuick( b2World* world, b2Body* body, b2WorldTransform* result )
{
    b2SolverSet* set = &world->solverSets.data[ body->setIndex ];
    b2BodySim* bodySim = &set->bodySims.data[ body->localIndex ];
    *result = bodySim->transform;
}

void b2GetBodyTransform( b2World* world, int bodyId, b2WorldTransform* result )
{
    b2Body* body = &world->bodies.data[ bodyId ];
    b2GetBodyTransformQuick( world, body, result );
}

void b2MakeBodyId( b2World* world, int bodyId, b2BodyId* result )
{
    b2Body* body = &world->bodies.data[ bodyId ];
    result->index1 = bodyId + 1;
    result->world0 = world->worldId;
    result->generation = body->generation;
}

// True iff the handle still refers to the live body it was minted for. Mirrors
// b2Joint_IsValid: wrong world, out-of-range/zeroed index (index1 == 0 -> the
// deref would hit data[-1] since NULL == -1, so bounds are checked FIRST), a
// freed slot (setIndex == B2_NULL_INDEX, set by b2DestroyBody), or a generation
// bumped by a create that reused the slot all read as stale.
bool b2Body_IsValid( b2World* world, b2BodyId* id )
{
    if( id->world0 != world->worldId )                         return false;
    if( id->index1 <= 0 || id->index1 > world->bodies.count )  return false;
    b2Body* body = &world->bodies.data[ id->index1 - 1 ];
    if( body->setIndex == B2_NULL_INDEX )                      return false;   // freed slot
    if( body->generation != id->generation )                  return false;   // slot reused
    return true;
}

b2BodySim* b2GetBodySim( b2World* world, b2Body* body )
{
    b2SolverSet* set = &world->solverSets.data[ body->setIndex ];
    return &set->bodySims.data[ body->localIndex ];
}

b2BodyState* b2GetBodyState( b2World* world, b2Body* body )
{
    if( body->setIndex == b2_awakeSet )
    {
        b2SolverSet* set = &world->solverSets.data[ b2_awakeSet ];
        return &set->bodyStates.data[ body->localIndex ];
    }
    return NULL;
}


// -----------------------------------------------------------------------------
//   b2DefaultBodyDef
// -----------------------------------------------------------------------------
void b2DefaultBodyDef( b2BodyDef* def )
{
    memset( def, 0, sizeof( b2BodyDef ) );
    def->type = b2_staticBody;
    def->rotation = b2Rot_identity;
    def->sleepThreshold = 0.05 * b2GetLengthUnitsPerMeter();
    def->gravityScale = 1.0;
    def->enableSleep = true;
    def->enableContactRecycling = true;
    def->isAwake = true;
    def->isEnabled = true;
}


// -----------------------------------------------------------------------------
//   b2CreateBody  (port of body.c b2CreateBody, minus the deferred machinery)
// -----------------------------------------------------------------------------
void b2CreateBody( b2World* world, b2BodyDef* def, b2BodyId* result )
{
    bool isAwake = ( def->isAwake || def->enableSleep == false ) && def->isEnabled;

    // determine the solver set
    int setId;
    if( def->isEnabled == false )
    {
        setId = b2_disabledSet;
    }
    else if( def->type == b2_staticBody )
    {
        setId = b2_staticSet;
    }
    else if( isAwake == true )
    {
        setId = b2_awakeSet;
    }
    else
    {
        // sleeping body in its own island gets a fresh solver set (untested in slice 1)
        setId = b2AllocId( &world->solverSetIdPool );
        if( setId == world->solverSets.count )
        {
            world->solverSets.data = b2GrowArray( world->solverSets.data,
                                                  &world->solverSets.capacity,
                                                  world->solverSets.count + 1,
                                                  sizeof( b2SolverSet ) );
            b2SolverSet* ns = &world->solverSets.data[ world->solverSets.count ];
            ns->bodySims.data = NULL;     ns->bodySims.count = 0;     ns->bodySims.capacity = 0;
            ns->bodyStates.data = NULL;   ns->bodyStates.count = 0;   ns->bodyStates.capacity = 0;
            ns->contactSims.data = NULL;  ns->contactSims.count = 0;  ns->contactSims.capacity = 0;
            ns->jointSims.data = NULL;    ns->jointSims.count = 0;     ns->jointSims.capacity = 0;
            ns->islandSims.data = NULL;   ns->islandSims.count = 0;    ns->islandSims.capacity = 0;
            ns->setIndex = B2_NULL_INDEX;
            world->solverSets.count = world->solverSets.count + 1;
        }
        world->solverSets.data[setId].setIndex = setId;
    }

    int bodyId = b2AllocId( &world->bodyIdPool );

    int lockFlags = 0;
    if( def->lockLinearX )  lockFlags = lockFlags | b2_lockLinearX;
    if( def->lockLinearY )  lockFlags = lockFlags | b2_lockLinearY;
    if( def->lockAngularZ ) lockFlags = lockFlags | b2_lockAngularZ;

    // emplace a body sim in the chosen set
    b2SolverSet* set = &world->solverSets.data[ setId ];
    set->bodySims.data = b2GrowArray( set->bodySims.data,
                                      &set->bodySims.capacity,
                                      set->bodySims.count + 1,
                                      sizeof( b2BodySim ) );
    b2BodySim* bodySim = &set->bodySims.data[ set->bodySims.count ];
    set->bodySims.count = set->bodySims.count + 1;

    memset( bodySim, 0, sizeof( b2BodySim ) );
    bodySim->transform.p = def->position;
    bodySim->transform.q = def->rotation;
    bodySim->center = def->position;
    bodySim->rotation0 = bodySim->transform.q;
    bodySim->center0 = bodySim->center;
    bodySim->minExtent = B2_HUGE;
    bodySim->maxExtent = 0.0;
    bodySim->linearDamping = def->linearDamping;
    bodySim->angularDamping = def->angularDamping;
    bodySim->gravityScale = def->gravityScale;
    bodySim->bodyId = bodyId;
    bodySim->flags = lockFlags;
    if( def->isBullet )                bodySim->flags = bodySim->flags | b2_isBullet;
    if( def->allowFastRotation )       bodySim->flags = bodySim->flags | b2_allowFastRotation;
    if( def->type == b2_dynamicBody )  bodySim->flags = bodySim->flags | b2_dynamicFlag;
    if( def->enableSleep )             bodySim->flags = bodySim->flags | b2_enableSleep;
    if( def->enableContactRecycling )  bodySim->flags = bodySim->flags | b2_bodyEnableContactRecycling;

    if( setId == b2_awakeSet )
    {
        set->bodyStates.data = b2GrowArray( set->bodyStates.data,
                                            &set->bodyStates.capacity,
                                            set->bodyStates.count + 1,
                                            sizeof( b2BodyState ) );
        b2BodyState* bodyState = &set->bodyStates.data[ set->bodyStates.count ];
        set->bodyStates.count = set->bodyStates.count + 1;

        memset( bodyState, 0, sizeof( b2BodyState ) );
        bodyState->linearVelocity = def->linearVelocity;
        bodyState->angularVelocity = def->angularVelocity;
        bodyState->deltaRotation = b2Rot_identity;
        bodyState->flags = bodySim->flags;
    }

    // ensure a sparse body record exists at bodyId (fresh slots are zeroed;
    // reused slots keep their generation so stale ids stay detectable)
    if( bodyId == world->bodies.count )
    {
        world->bodies.data = b2GrowArray( world->bodies.data,
                                          &world->bodies.capacity,
                                          world->bodies.count + 1,
                                          sizeof( b2Body ) );
        memset( &world->bodies.data[ bodyId ], 0, sizeof( b2Body ) );
        world->bodies.count = world->bodies.count + 1;
    }

    b2Body* body = &world->bodies.data[ bodyId ];
    body->userData = def->userData;
    body->setIndex = setId;
    body->localIndex = set->bodySims.count - 1;
    body->generation = body->generation + 1;
    body->headShapeId = B2_NULL_INDEX;
    body->shapeCount = 0;
    body->headChainId = B2_NULL_INDEX;
    body->headContactKey = B2_NULL_INDEX;
    body->contactCount = 0;
    body->headJointKey = B2_NULL_INDEX;
    body->jointCount = 0;
    body->islandId = B2_NULL_INDEX;
    body->islandIndex = B2_NULL_INDEX;
    body->bodyMoveIndex = B2_NULL_INDEX;
    body->id = bodyId;
    body->mass = 0.0;
    body->inertia = 0.0;
    body->sleepThreshold = def->sleepThreshold;
    body->sleepTime = 0.0;
    body->type = def->type;
    body->flags = bodySim->flags;

    // dynamic/kinematic enabled bodies (awake or sleeping set) get their own island
    if( setId >= b2_awakeSet )
        b2CreateIslandForBody( world, setId, body );

    result->index1 = bodyId + 1;
    result->world0 = world->worldId;
    result->generation = body->generation;
}


// -----------------------------------------------------------------------------
//   b2RemoveBodySim  (the swap-and-fixup — where indirection bugs hide)
// -----------------------------------------------------------------------------
//   Swap the last bodySim into the freed slot, then repair the MOVED body's
//   localIndex through the sparse `bodies` array so it keeps pointing at its
//   (now relocated) sim. Mirrors body.c b2RemoveBodySim exactly.
void b2RemoveBodySim( b2BodySimArray* bodySims, b2BodyArray* bodies, int localIndex )
{
    int lastIndex = bodySims->count - 1;
    bodySims->data[ localIndex ] = bodySims->data[ lastIndex ];
    b2Body* movedBody = &bodies->data[ bodySims->data[ localIndex ].bodyId ];
    movedBody->localIndex = localIndex;
    bodySims->count = bodySims->count - 1;
}


// -----------------------------------------------------------------------------
//   b2DestroyBody  (port of body.c b2DestroyBody, minus the deferred machinery)
// -----------------------------------------------------------------------------
//   In slice 1 a body has no joints / contacts / shapes / chains / island, so
//   those teardown loops are no-ops and omitted. What remains is the part that
//   actually exercises the sparse/dense indirection: remove the sim (and, for
//   awake bodies, the parallel state) by swap, then free the id (generation is
//   preserved so stale b2BodyIds stay detectable).
// forward decls: body teardown destroys the body's joints, contacts and shapes
void b2DestroyContact( b2World* world, b2Contact* contact, bool wakeBodies );
void b2DestroyShapeInternal( b2World* world, b2Shape* shape, bool destroyContacts, bool updateBodyMass );
void b2DestroyJointInternal( b2World* world, b2Joint* joint, bool wakeBodies );

void b2DestroyBody( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );

    // Destroy the attached joints first. Walk headJointKey, reading the next key
    // before each destroy (b2DestroyJointInternal unlinks the joint from BOTH
    // bodies' lists and swap-removes its sim). wakeBodies=true (upstream body.c):
    // the OTHER endpoint of each joint/contact must wake even though this body is
    // going away -- destroy the platform under a sleeping pile and the pile must
    // wake and fall, not float. (Waking may migrate THIS body's set too; that is
    // fine -- body->setIndex is re-read fresh below.) Omitting the teardown left
    // dangling joint edges/sims -> fault when a jointed body was destroyed.
    int jointKey = body->headJointKey;
    while( jointKey != B2_NULL_INDEX )
    {
        int jointId = jointKey >> 1;
        int jointEdge = jointKey & 1;
        b2Joint* joint = &world->joints.data[ jointId ];
        jointKey = b2JointEdgeAt( joint, jointEdge )->nextKey;   // read before destroy
        b2DestroyJointInternal( world, joint, true );
    }

    // Destroy the attached contacts next (they reference this body's shapes and
    // edge lists). Walk headContactKey, reading the next key before each destroy.
    int edgeKey = body->headContactKey;
    while( edgeKey != B2_NULL_INDEX )
    {
        int contactId = edgeKey >> 1;
        int edgeIndex = edgeKey & 1;
        b2Contact* contact = &world->contacts.data[ contactId ];
        edgeKey = b2ContactEdgeAt( contact, edgeIndex )->nextKey;
        b2DestroyContact( world, contact, true );   // wake the other endpoint (see joint note above)
    }

    // Destroy the attached shapes + their broad-phase proxies. Contacts are already
    // gone, so skip per-shape contact teardown and the (pointless) mass recompute.
    int shapeId = body->headShapeId;
    while( shapeId != B2_NULL_INDEX )
    {
        b2Shape* shape = &world->shapes.data[ shapeId ];
        shapeId = shape->nextShapeId;                       // read before destroy
        b2DestroyShapeInternal( world, shape, false, false );
    }
    // (deferred) destroy attached chains

    // remove the body from its island (contacts/joints already unlinked above); the
    // island is destroyed if this was its last body.
    b2RemoveBodyFromIsland( world, body );

    // remove the body sim from the solver set that owns it
    b2SolverSet* set = &world->solverSets.data[ body->setIndex ];
    b2RemoveBodySim( &set->bodySims, &world->bodies, body->localIndex );

    // remove the parallel body state from the awake set (same localIndex)
    if( body->setIndex == b2_awakeSet )
    {
        int last = set->bodyStates.count - 1;
        if( body->localIndex != last )
            set->bodyStates.data[ body->localIndex ] = set->bodyStates.data[ last ];
        set->bodyStates.count = set->bodyStates.count - 1;
    }
    // P0.3 (F5): destroying the LAST body of a sleeping set frees the set itself
    // (id returned to solverSetIdPool). Its contacts/joints/island are already
    // gone: the teardown above destroyed them, and b2RemoveBodyFromIsland freed
    // the island (removing its islandSim from this set). Without this, a set id
    // + 5 empty arrays leaked per fully-destroyed sleeping island. Rarely hit
    // when the body has touching contacts (their destroy WAKES the set first,
    // P0.1); the leak was e.g. a contactless floating sleeper.
    else if( body->setIndex >= b2_firstSleepingSet && set->bodySims.count == 0 )
    {
        b2DestroySolverSet( world, body->setIndex );
    }

    // return the id to the pool; preserve body->generation
    b2FreeId( &world->bodyIdPool, body->id );

    body->setIndex = B2_NULL_INDEX;
    body->localIndex = B2_NULL_INDEX;
    body->id = B2_NULL_INDEX;
}


// -----------------------------------------------------------------------------
//   b2UpdateBodyMassData  (port of body.c; two-pass, no scratch buffer)
// -----------------------------------------------------------------------------
//   Recompute a body's mass / inertia / inverse-mass / localCenter from its
//   attached shapes. b2ComputeShapeMass is pure, so we walk the shape list
//   twice instead of caching per-shape mass data in a temp array (upstream
//   uses the arena; the result is identical).
void b2UpdateBodyMassData( b2World* world, b2Body* body )
{
    b2BodySim* bodySim = b2GetBodySim( world, body );

    body->mass = 0.0;
    body->inertia = 0.0;
    bodySim->invMass = 0.0;
    bodySim->invInertia = 0.0;
    bodySim->localCenter = b2Vec2_zero;
    bodySim->minExtent = B2_HUGE;
    bodySim->maxExtent = 0.0;

    int shapeId;

    // static and kinematic bodies have zero mass
    if( body->type != b2_dynamicBody )
    {
        bodySim->center = bodySim->transform.p;
        bodySim->center0 = bodySim->center;

        // kinematic bodies still need extents for sleeping to work
        if( body->type == b2_kinematicBody )
        {
            shapeId = body->headShapeId;
            while( shapeId != B2_NULL_INDEX )
            {
                b2Shape* s = &world->shapes.data[ shapeId ];
                b2ShapeExtent extent;
                b2ComputeShapeExtent( s, &b2Vec2_zero, &extent );
                bodySim->minExtent = b2MinFloat( bodySim->minExtent, extent.minExtent );
                bodySim->maxExtent = b2MaxFloat( bodySim->maxExtent, extent.maxExtent );
                shapeId = s->nextShapeId;
            }
        }
        return;
    }

    // pass 1: accumulate total mass and the mass-weighted center
    b2Vec2 localCenter = b2Vec2_zero;
    shapeId = body->headShapeId;
    while( shapeId != B2_NULL_INDEX )
    {
        b2Shape* s = &world->shapes.data[ shapeId ];
        b2MassData md;
        b2ComputeShapeMass( s, &md );
        body->mass = body->mass + md.mass;
        b2Vec2 weighted;
        b2MulAdd( &localCenter, md.mass, &md.center, &weighted );
        localCenter = weighted;
        shapeId = s->nextShapeId;
    }

    // center of mass
    if( body->mass > 0.0 )
    {
        bodySim->invMass = 1.0 / body->mass;
        b2Vec2 scaled;
        b2MulSV( bodySim->invMass, &localCenter, &scaled );
        localCenter = scaled;
    }

    // pass 2: rotational inertia about the center of mass (parallel-axis shift)
    shapeId = body->headShapeId;
    while( shapeId != B2_NULL_INDEX )
    {
        b2Shape* s = &world->shapes.data[ shapeId ];
        b2MassData md;
        b2ComputeShapeMass( s, &md );
        if( md.mass > 0.0 )
        {
            b2Vec2 offset;
            b2Sub( &localCenter, &md.center, &offset );
            float inertia = md.rotationalInertia + md.mass * b2Dot( &offset, &offset );
            body->inertia = body->inertia + inertia;
        }
        shapeId = s->nextShapeId;
    }

    if( body->inertia > 0.0 )
        bodySim->invInertia = 1.0 / body->inertia;
    else
        body->inertia = 0.0;

    // move the center of mass
    b2Pos oldCenter = bodySim->center;
    bodySim->localCenter = localCenter;
    b2TransformWorldPoint( &bodySim->transform, &bodySim->localCenter, &bodySim->center );
    bodySim->center0 = bodySim->center;

    // update center-of-mass velocity (awake bodies only)
    b2BodyState* state = b2GetBodyState( world, body );
    if( state != NULL )
    {
        b2Vec2 dc;  b2Sub( &bodySim->center, &oldCenter, &dc );   // b2SubPos == b2Sub (single precision)
        b2Vec2 deltaLinear;  b2CrossSV( state->angularVelocity, &dc, &deltaLinear );
        b2Vec2 nv;  b2Add( &state->linearVelocity, &deltaLinear, &nv );
        state->linearVelocity = nv;
    }

    // body extents relative to the center of mass
    shapeId = body->headShapeId;
    while( shapeId != B2_NULL_INDEX )
    {
        b2Shape* s = &world->shapes.data[ shapeId ];
        b2ShapeExtent extent;
        b2ComputeShapeExtent( s, &localCenter, &extent );
        bodySim->minExtent = b2MinFloat( bodySim->minExtent, extent.minExtent );
        bodySim->maxExtent = b2MaxFloat( bodySim->maxExtent, extent.maxExtent );
        shapeId = s->nextShapeId;
    }
}


// -----------------------------------------------------------------------------
//   Shape creation (attach a shape to a body)
// -----------------------------------------------------------------------------
//   Allocate a shape id, copy the geometry, and push the shape onto the body's
//   doubly-linked shape list. DEFERRED from upstream b2CreateShapeInternal:
//   broad-phase proxy, sensors, AABB/material/filter caches, dirtyMass sync.
b2Shape* b2CreateShapeInternal( b2World* world, b2Body* body, b2ShapeDef* def, void* geometry, int shapeType )
{
    int shapeId = b2AllocId( &world->shapeIdPool );

    if( shapeId == world->shapes.count )
    {
        world->shapes.data = b2GrowArray( world->shapes.data,
                                          &world->shapes.capacity,
                                          world->shapes.count + 1,
                                          sizeof( b2Shape ) );
        memset( &world->shapes.data[ shapeId ], 0, sizeof( b2Shape ) );
        world->shapes.count = world->shapes.count + 1;
    }

    b2Shape* shape = &world->shapes.data[ shapeId ];

    if( shapeType == b2_circleShape )
        shape->circle = *(b2Circle*)geometry;
    else if( shapeType == b2_capsuleShape )
        shape->capsule = *(b2Capsule*)geometry;
    else if( shapeType == b2_polygonShape )
        shape->polygon = *(b2Polygon*)geometry;
    else if( shapeType == b2_segmentShape )
        shape->segment = *(b2Segment*)geometry;
    else if( shapeType == b2_chainSegmentShape )
        shape->chainSegment = *(b2ChainSegment*)geometry;

    shape->id = shapeId;
    shape->bodyId = body->id;
    shape->type = shapeType;
    shape->density = def->density;
    shape->friction = def->friction;
    shape->restitution = def->restitution;
    shape->filter = def->filter;
    shape->enableHitEvents = def->enableHitEvents;
    shape->enableContactEvents = def->enableContactEvents;
    shape->isSensor = def->isSensor;
    shape->enableSensorEvents = def->enableSensorEvents;
    shape->sensorOverlaps = NULL;         // lazily grown by the sensor pass (crash trap: MUST init)
    shape->sensorOverlapCount = 0;
    shape->sensorOverlapCapacity = 0;
    shape->userData = def->userData;
    shape->generation = shape->generation + 1;
    shape->proxyKey = B2_NULL_INDEX;

    // fat-AABB margin (5.2): smaller for static bodies (they barely need slack),
    // the full margin for movable bodies so small motion doesn't re-move the proxy.
    if( body->type == b2_staticBody )
        shape->aabbMargin = B2_SPECULATIVE_DISTANCE;
    else
        shape->aabbMargin = B2_MAX_AABB_MARGIN;
    shape->aabb.lowerBound = b2Vec2_zero;
    shape->aabb.upperBound = b2Vec2_zero;
    shape->fatAABB.lowerBound = b2Vec2_zero;
    shape->fatAABB.upperBound = b2Vec2_zero;

    // insert a broad-phase proxy (skip disabled bodies, which aren't in the trees).
    // The tree stores the FAT AABB (tight +- margin); pairing queries against it.
    if( body->setIndex != b2_disabledSet )
    {
        b2WorldTransform xf;
        b2GetBodyTransformQuick( world, body, &xf );
        b2AABB aabb;
        b2ComputeShapeAABB( shape, &xf, &aabb );
        float sp = B2_SPECULATIVE_DISTANCE;
        shape->aabb.lowerBound.x = aabb.lowerBound.x - sp;
        shape->aabb.lowerBound.y = aabb.lowerBound.y - sp;
        shape->aabb.upperBound.x = aabb.upperBound.x + sp;
        shape->aabb.upperBound.y = aabb.upperBound.y + sp;
        float m = shape->aabbMargin;
        shape->fatAABB.lowerBound.x = aabb.lowerBound.x - m;
        shape->fatAABB.lowerBound.y = aabb.lowerBound.y - m;
        shape->fatAABB.upperBound.x = aabb.upperBound.x + m;
        shape->fatAABB.upperBound.y = aabb.upperBound.y + m;
        // The proxy carries the shape's own category bits, NOT a hardcoded 1: the
        // tree ANDs them against a query's maskBits to prune whole subtrees, so a
        // filtered ray/box cast would otherwise reject every node.
        shape->proxyKey = b2BroadPhase_CreateProxy( &world->broadPhase, body->type, &shape->fatAABB,
                                                    shape->filter.categoryBits, shape->id );
    }

    // push onto the body's doubly-linked shape list (new head)
    if( body->headShapeId != B2_NULL_INDEX )
    {
        b2Shape* headShape = &world->shapes.data[ body->headShapeId ];
        headShape->prevShapeId = shapeId;
    }
    shape->prevShapeId = B2_NULL_INDEX;
    shape->nextShapeId = body->headShapeId;
    body->headShapeId = shapeId;
    body->shapeCount = body->shapeCount + 1;

    return shape;
}

void b2CreateCircleShape( b2World* world, b2BodyId* bodyId, b2ShapeDef* def, b2Circle* circle, b2ShapeId* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2Shape* shape = b2CreateShapeInternal( world, body, def, circle, b2_circleShape );
    if( def->updateBodyMass )
        b2UpdateBodyMassData( world, body );
    result->index1 = shape->id + 1;
    result->world0 = bodyId->world0;
    result->generation = shape->generation;
}

void b2CreatePolygonShape( b2World* world, b2BodyId* bodyId, b2ShapeDef* def, b2Polygon* polygon, b2ShapeId* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2Shape* shape = b2CreateShapeInternal( world, body, def, polygon, b2_polygonShape );
    if( def->updateBodyMass )
        b2UpdateBodyMassData( world, body );
    result->index1 = shape->id + 1;
    result->world0 = bodyId->world0;
    result->generation = shape->generation;
}

// Capsule shapes: capsule collision (b2CollideCapsules/*AndCircle/Polygon*) and mass
// are already fully wired -- only this body-facing creator was missing.
void b2CreateCapsuleShape( b2World* world, b2BodyId* bodyId, b2ShapeDef* def, b2Capsule* capsule, b2ShapeId* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2Shape* shape = b2CreateShapeInternal( world, body, def, capsule, b2_capsuleShape );
    if( def->updateBodyMass )
        b2UpdateBodyMassData( world, body );
    result->index1 = shape->id + 1;
    result->world0 = bodyId->world0;
    result->generation = shape->generation;
}

// Segment shapes: two-sided segment collision (b2CollideSegmentAnd*); segments carry
// no mass (b2ComputeShapeMass returns 0). Used for static edges. For ONE-SIDED terrain
// with ghost-vertex junction culling, use b2CreateChain / b2CreateChainSegmentShape.
void b2CreateSegmentShape( b2World* world, b2BodyId* bodyId, b2ShapeDef* def, b2Segment* segment, b2ShapeId* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2Shape* shape = b2CreateShapeInternal( world, body, def, segment, b2_segmentShape );
    if( def->updateBodyMass )
        b2UpdateBodyMassData( world, body );
    result->index1 = shape->id + 1;
    result->world0 = bodyId->world0;
    result->generation = shape->generation;
}

// Chain-segment shapes: ONE-SIDED segments with ghost vertices (b2CollideChainSegment*).
// The single-segment primitive -- the caller supplies ghost1/ghost2 (usually the
// adjoining chain vertices). Carries no mass (chains are for static terrain).
void b2CreateChainSegmentShape( b2World* world, b2BodyId* bodyId, b2ShapeDef* def, b2ChainSegment* chainSegment, b2ShapeId* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2Shape* shape = b2CreateShapeInternal( world, body, def, chainSegment, b2_chainSegmentShape );
    result->index1 = shape->id + 1;
    result->world0 = bodyId->world0;
    result->generation = shape->generation;
}

// Definition for a chain of segments (minimal subset of upstream b2ChainDef).
struct b2ChainDef
{
    b2Vec2* points;      // ordered chain vertices (>= 4)
    int     count;
    bool    isLoop;      // connect the last point back to the first
    float   friction;
    float   restitution;
    b2Filter filter;
    void*   userData;
};

void b2DefaultChainDef( b2ChainDef* def )
{
    def->points = NULL;
    def->count = 0;
    def->isLoop = false;
    def->friction = 0.6;
    def->restitution = 0.0;
    def->filter.categoryBits = 1;
    def->filter.maskBits = -1;
    def->filter.groupIndex = 0;
    def->userData = NULL;
}

// Build a chain of one-sided chain-segment shapes on a (typically static) body.
// A LOOP of n points yields n collidable segments; an OPEN chain yields n-3 (its
// two endpoints serve only as ghost vertices). Each segment's ghost1/ghost2 are its
// neighbour vertices so the narrow phase culls ghost collisions at junctions.
// DEVIATION: no b2ChainShape aggregate / b2ChainId -- the segments are plain shapes
// on the body, torn down with it (b2DestroyBody walks the shape list).
void b2CreateChain( b2World* world, b2BodyId* bodyId, b2ChainDef* def )
{
    b2ShapeDef sd;  b2DefaultShapeDef( &sd );
    sd.friction = def->friction;
    sd.restitution = def->restitution;
    sd.filter = def->filter;
    sd.updateBodyMass = false;
    sd.userData = def->userData;

    int n = def->count;
    b2Vec2* pts = def->points;
    b2ChainSegment cs;
    cs.chainId = B2_NULL_INDEX;
    b2ShapeId sid;
    int i;

    if( def->isLoop )
    {
        for( i = 0; i < n; ++i )
        {
            int prev = i - 1;  if( prev < 0 )   prev = n - 1;
            int nx1 = i + 1;   if( nx1 >= n )    nx1 = nx1 - n;
            int nx2 = i + 2;   if( nx2 >= n )    nx2 = nx2 - n;
            cs.ghost1 = pts[ prev ];
            cs.segment.point1 = pts[ i ];
            cs.segment.point2 = pts[ nx1 ];
            cs.ghost2 = pts[ nx2 ];
            b2CreateChainSegmentShape( world, bodyId, &sd, &cs, &sid );
        }
    }
    else
    {
        for( i = 0; i < n - 3; ++i )
        {
            cs.ghost1 = pts[ i ];
            cs.segment.point1 = pts[ i + 1 ];
            cs.segment.point2 = pts[ i + 2 ];
            cs.ghost2 = pts[ i + 3 ];
            b2CreateChainSegmentShape( world, bodyId, &sd, &cs, &sid );
        }
    }
}


// -----------------------------------------------------------------------------
//   Shape destroy (detach a shape from its body)
// -----------------------------------------------------------------------------
//   Unlink from the body's doubly-linked shape list, free the id, and (if
//   requested) recompute the body's mass. DEFERRED: broad-phase proxy removal,
//   contact teardown, sensor teardown.
b2Shape* b2GetShape( b2World* world, b2ShapeId* shapeId )
{
    return &world->shapes.data[ shapeId->index1 - 1 ];
}

// (b2DestroyContact forward-declared above, before b2DestroyBody)

// Tear down one shape (given its record). destroyContacts walks the owning body's
// contact-edge list and destroys any contact that references this shape (so no
// dangling contactSim / stale pairSet key survives the shape). Also removes the
// broad-phase proxy and frees the shape id. updateBodyMass recomputes the body's
// mass afterward (skip it when the whole body is being destroyed).
void b2DestroyShapeInternal( b2World* world, b2Shape* shape, bool destroyContacts, bool updateBodyMass )
{
    int id = shape->id;
    b2Body* body = &world->bodies.data[ shape->bodyId ];

    // destroy any contacts that reference this shape (walk the body's edge list;
    // read the next key BEFORE destroying, since b2DestroyContact unlinks the edge)
    if( destroyContacts )
    {
        int contactKey = body->headContactKey;
        while( contactKey != B2_NULL_INDEX )
        {
            int contactId = contactKey >> 1;
            int edgeIndex = contactKey & 1;
            b2Contact* contact = &world->contacts.data[ contactId ];
            contactKey = b2ContactEdgeAt( contact, edgeIndex )->nextKey;
            if( contact->shapeIdA == id || contact->shapeIdB == id )
                b2DestroyContact( world, contact, true );   // wake: a support may vanish (upstream shape.c)
        }
    }

    // unlink from the body's doubly-linked shape list
    if( shape->prevShapeId != B2_NULL_INDEX )
        world->shapes.data[ shape->prevShapeId ].nextShapeId = shape->nextShapeId;
    if( shape->nextShapeId != B2_NULL_INDEX )
        world->shapes.data[ shape->nextShapeId ].prevShapeId = shape->prevShapeId;
    if( id == body->headShapeId )
        body->headShapeId = shape->nextShapeId;
    body->shapeCount = body->shapeCount - 1;

    // remove the broad-phase proxy
    if( shape->proxyKey != B2_NULL_INDEX )
    {
        b2BroadPhase_DestroyProxy( &world->broadPhase, shape->proxyKey );
        shape->proxyKey = B2_NULL_INDEX;
    }

    // free the sensor overlap array (only sensors ever grew it; NULL otherwise).
    // DEVIATION: a sensor destroyed while overlapping does NOT emit end events for
    // its current visitors (upstream b2DestroySensor does); the overlaps just vanish.
    if( shape->sensorOverlaps != NULL )
    {
        b2Free( shape->sensorOverlaps, shape->sensorOverlapCapacity * sizeof( int ) );
        shape->sensorOverlaps = NULL;
        shape->sensorOverlapCount = 0;
        shape->sensorOverlapCapacity = 0;
    }

    b2FreeId( &world->shapeIdPool, id );
    shape->id = B2_NULL_INDEX;

    if( updateBodyMass )
        b2UpdateBodyMassData( world, body );
}

void b2DestroyShape( b2World* world, b2ShapeId* shapeId, bool updateBodyMass )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    b2DestroyShapeInternal( world, shape, true, updateBodyMass );
}


// -----------------------------------------------------------------------------
//   b2Body_SetTransform  (move a body; keep its shape proxies in sync)
// -----------------------------------------------------------------------------
//   Update the body sim transform + center, then move each attached shape's
//   broad-phase proxy to the recomputed AABB. SIMPLIFICATION: no fatAABB/margin
//   cache (those shape fields are deferred), so we recompute the tight AABB and
//   always MoveProxy rather than only when the fat box no longer contains it.
void b2Body_SetTransform( b2World* world, b2BodyId* bodyId, b2Vec2* position, b2Rot* rotation )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );

    // PORT DEVIATION (F3): wake a sleeping body BEFORE teleporting it. Upstream
    // leaves it asleep, but upstream re-pairs/re-evaluates sleeping contacts via
    // machinery this port doesn't have -- here a sleeping teleported body would
    // keep its stale "touching" contacts and never collide at the new location.
    // Wake FIRST: it moves the body's sim between sets (b2GetBodySim after).
    b2WakeBody( world, body );

    b2BodySim* bodySim = b2GetBodySim( world, body );

    bodySim->transform.p = *position;
    bodySim->transform.q = *rotation;
    b2TransformWorldPoint( &bodySim->transform, &bodySim->localCenter, &bodySim->center );
    bodySim->rotation0 = bodySim->transform.q;
    bodySim->center0 = bodySim->center;

    int shapeId = body->headShapeId;
    while( shapeId != B2_NULL_INDEX )
    {
        b2Shape* shape = &world->shapes.data[ shapeId ];
        if( shape->proxyKey != B2_NULL_INDEX )
        {
            // explicit teleport: refresh speculative aabb, re-fatten, always move (5.2)
            b2AABB aabb;
            b2ComputeShapeAABB( shape, &bodySim->transform, &aabb );
            float sp = B2_SPECULATIVE_DISTANCE;
            shape->aabb.lowerBound.x = aabb.lowerBound.x - sp;
            shape->aabb.lowerBound.y = aabb.lowerBound.y - sp;
            shape->aabb.upperBound.x = aabb.upperBound.x + sp;
            shape->aabb.upperBound.y = aabb.upperBound.y + sp;
            float m = shape->aabbMargin;
            shape->fatAABB.lowerBound.x = aabb.lowerBound.x - m;
            shape->fatAABB.lowerBound.y = aabb.lowerBound.y - m;
            shape->fatAABB.upperBound.x = aabb.upperBound.x + m;
            shape->fatAABB.upperBound.y = aabb.upperBound.y + m;
            b2BroadPhase_MoveProxy( &world->broadPhase, shape->proxyKey, &shape->fatAABB );
        }
        shapeId = shape->nextShapeId;
    }
}


// -----------------------------------------------------------------------------
//   b2Body_Wake / b2Body_IsAwake  (public wake API, generation-checked handle)
// -----------------------------------------------------------------------------
//   b2Body_Wake wakes the body's whole sleeping solver set (island co-members
//   wake with it -- that is the Box2D contract). No-op on awake/static/disabled
//   bodies. b2Body_IsAwake: only bodies in THE awake set are simulated.
void b2Body_Wake( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2WakeBody( world, body );
}

bool b2Body_IsAwake( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return body->setIndex == b2_awakeSet;
}


// -----------------------------------------------------------------------------
//   b2Body_SetTargetTransform  (port of body.c b2Body_SetTargetTransform)
// -----------------------------------------------------------------------------
//   Drive a kinematic (or dynamic) body toward `target` over one time step by
//   setting the velocity that would carry its CENTER (and rotation) there in
//   `timeStep` seconds. The next b2World_Step then integrates that velocity into
//   the motion. This is the kinematic-mover primitive (Junkyard pusher etc.).
//   PORT NOTES: pointer args + b2Transform (the port collapses upstream's
//   double-precision b2WorldTransform/b2Pos onto b2Transform/b2Vec2). Upstream's
//   sleeping-body sleep-threshold early-out is dropped -- the port's callers
//   drive an already-awake body, and b2WakeBody guarantees a state exists.
void b2Body_SetTargetTransform( b2World* world, b2BodyId* bodyId, b2Transform* target, float timeStep )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    if( body->setIndex == b2_disabledSet )  return;
    if( body->type == b2_staticBody )       return;
    if( timeStep <= 0.0 )                   return;

    b2WakeBody( world, body );                       // ensure an awake state exists
    b2BodySim* sim = b2GetBodySim( world, body );

    // linear velocity: move the center to where `target` maps the local center
    b2Vec2 targetCenter;  b2TransformPoint( target, &sim->localCenter, &targetCenter );
    b2Vec2 delta;         b2Sub( &targetCenter, &sim->center, &delta );
    float invTimeStep = 1.0 / timeStep;
    b2Vec2 linearVelocity;  b2MulSV( invTimeStep, &delta, &linearVelocity );

    // angular velocity from the relative rotation (current -> target)
    float deltaAngle = b2RelativeAngle( &sim->transform.q, &target->q );
    float angularVelocity = invTimeStep * deltaAngle;

    b2BodyState* state = b2GetBodyState( world, body );
    state->linearVelocity = linearVelocity;
    state->angularVelocity = angularVelocity;
}


// -----------------------------------------------------------------------------
//   b2Body_GetLocalPoint  (world point -> body-local frame; body.c)
// -----------------------------------------------------------------------------
//   Used to express a joint anchor given in world coordinates in each body's
//   local frame (the human ragdoll builds every joint this way).
void b2Body_GetLocalPoint( b2World* world, b2BodyId* bodyId, b2Vec2* worldPoint, b2Vec2* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* sim = b2GetBodySim( world, body );
    b2InvTransformPoint( &sim->transform, worldPoint, result );
}


// -----------------------------------------------------------------------------
//   b2Body runtime API (P1.1 / F7) -- the game-facing accessors + mutators.
// -----------------------------------------------------------------------------
//   Turns the engine into a library: games no longer reach into
//   awakeSet->bodySims/bodyStates directly. Conventions per CLAUDE.md -- b2Vec2/
//   b2Rot/b2Transform returns become an out-pointer LAST arg; scalars return by
//   value. Read accessors hit the sim (present in every set). VELOCITY lives ONLY
//   in the awake set (b2GetBodyState -> NULL when sleeping/static): getters then
//   return ZERO; mutators/impulses/forces mirror upstream and only take effect on
//   an AWAKE body, waking first when asked (upstream body.c semantics exactly).

// -- pose / geometry (sim is valid in any set) --
void b2Body_GetPosition( b2World* world, b2BodyId* bodyId, b2Vec2* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* sim = b2GetBodySim( world, body );
    *result = sim->transform.p;
}

void b2Body_GetRotation( b2World* world, b2BodyId* bodyId, b2Rot* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* sim = b2GetBodySim( world, body );
    *result = sim->transform.q;
}

void b2Body_GetTransform( b2World* world, b2BodyId* bodyId, b2Transform* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* sim = b2GetBodySim( world, body );
    *result = sim->transform;
}

void b2Body_GetWorldCenter( b2World* world, b2BodyId* bodyId, b2Vec2* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* sim = b2GetBodySim( world, body );
    *result = sim->center;
}

// -- velocity (state, awake-only; getters return zero off the awake set) --
void b2Body_GetLinearVelocity( b2World* world, b2BodyId* bodyId, b2Vec2* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodyState* state = b2GetBodyState( world, body );
    if( state == NULL )
    {
        result->x = 0.0;  result->y = 0.0;
        return;
    }
    *result = state->linearVelocity;
}

float b2Body_GetAngularVelocity( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodyState* state = b2GetBodyState( world, body );
    if( state == NULL )  return 0.0;
    return state->angularVelocity;
}

void b2Body_SetLinearVelocity( b2World* world, b2BodyId* bodyId, b2Vec2* linearVelocity )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    if( body->type == b2_staticBody )  return;
    if( b2LengthSquared( linearVelocity ) > 0.0 )   // don't wake just to set zero
        b2WakeBody( world, body );
    b2BodyState* state = b2GetBodyState( world, body );
    if( state == NULL )  return;
    state->linearVelocity = *linearVelocity;
}

void b2Body_SetAngularVelocity( b2World* world, b2BodyId* bodyId, float angularVelocity )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    if( body->type == b2_staticBody )  return;
    if( angularVelocity != 0.0 )
        b2WakeBody( world, body );
    b2BodyState* state = b2GetBodyState( world, body );
    if( state == NULL )  return;
    state->angularVelocity = angularVelocity;
}

// -- forces (accumulate into the sim; consumed + cleared by b2IntegrateVelocities/
//    b2FinalizeBodies each step; awake-only) --
void b2Body_ApplyForce( b2World* world, b2BodyId* bodyId, b2Vec2* force, b2Vec2* point, bool wake )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    if( wake )  b2WakeBody( world, body );
    if( body->setIndex != b2_awakeSet )  return;
    b2BodySim* sim = b2GetBodySim( world, body );
    b2Add( &sim->force, force, &sim->force );
    b2Vec2 r;  b2Sub( point, &sim->center, &r );
    sim->torque = sim->torque + b2Cross( &r, force );
}

void b2Body_ApplyForceToCenter( b2World* world, b2BodyId* bodyId, b2Vec2* force, bool wake )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    if( wake )  b2WakeBody( world, body );
    if( body->setIndex != b2_awakeSet )  return;
    b2BodySim* sim = b2GetBodySim( world, body );
    b2Add( &sim->force, force, &sim->force );
}

void b2Body_ApplyTorque( b2World* world, b2BodyId* bodyId, float torque, bool wake )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    if( wake )  b2WakeBody( world, body );
    if( body->setIndex != b2_awakeSet )  return;
    b2BodySim* sim = b2GetBodySim( world, body );
    sim->torque = sim->torque + torque;
}

// -- impulses (poke the velocity state directly; awake-only) --
void b2Body_ApplyLinearImpulse( b2World* world, b2BodyId* bodyId, b2Vec2* impulse, b2Vec2* point, bool wake )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    if( wake )  b2WakeBody( world, body );
    if( body->setIndex != b2_awakeSet )  return;
    b2BodySim* sim = b2GetBodySim( world, body );
    b2BodyState* state = b2GetBodyState( world, body );
    b2MulAdd( &state->linearVelocity, sim->invMass, impulse, &state->linearVelocity );
    b2Vec2 r;  b2Sub( point, &sim->center, &r );
    state->angularVelocity = state->angularVelocity + sim->invInertia * b2Cross( &r, impulse );
}

void b2Body_ApplyLinearImpulseToCenter( b2World* world, b2BodyId* bodyId, b2Vec2* impulse, bool wake )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    if( wake )  b2WakeBody( world, body );
    if( body->setIndex != b2_awakeSet )  return;
    b2BodySim* sim = b2GetBodySim( world, body );
    b2BodyState* state = b2GetBodyState( world, body );
    b2MulAdd( &state->linearVelocity, sim->invMass, impulse, &state->linearVelocity );
}

void b2Body_ApplyAngularImpulse( b2World* world, b2BodyId* bodyId, float impulse, bool wake )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    if( wake )  b2WakeBody( world, body );
    if( body->setIndex != b2_awakeSet )  return;
    b2BodySim* sim = b2GetBodySim( world, body );
    b2BodyState* state = b2GetBodyState( world, body );
    state->angularVelocity = state->angularVelocity + sim->invInertia * impulse;
}

// -- mass + user data --
float b2Body_GetMass( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return body->mass;
}

void b2Body_SetUserData( b2World* world, b2BodyId* bodyId, void* userData )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    body->userData = userData;
}

void* b2Body_GetUserData( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return body->userData;
}


// -----------------------------------------------------------------------------
//   b2Shape_*  (public shape API -- slice 1: pure reads + user data)
// -----------------------------------------------------------------------------
//   Every event and query surface in this port hands back a RAW int shape id
//   (b2ShapeId is multi-word and cannot cross a function boundary by value): the
//   touch/hit/sensor event arrays, the b2World_OverlapAABB callback, and the
//   b2World_Cast* hit records. b2MakeShapeId turns such an id into a
//   generation-checked handle; the getters below resolve that handle to the
//   owning body, the user data, and the shape's geometry. Without these a game
//   can observe that SOMETHING was hit but never identify what.
//
//   Multi-word results (b2BodyId, b2Filter, b2AABB, the geometry structs) use the
//   OUT-pointer-as-last-argument convention; scalars return by value.
//
//   DEVIATION: no b2Shape_GetWorld -- the port threads `b2World*` explicitly
//   instead of upstream's b2WorldId, so the world is already in the caller's hand.
//   DEFERRED to slice 2 (they carry side effects, not just field reads):
//   b2Shape_SetFilter (must destroy the shape's contacts + re-buffer its proxy),
//   b2Shape_SetDensity (mass recompute), b2Shape_Set<geometry> (AABB/proxy/mass
//   recompute), b2Shape_Enable*Events. Also deferred: b2Shape_GetContactData /
//   GetSensorData (need a count+fill-buffer convention this port hasn't set),
//   b2Shape_RayCast, and upstream's newer surface-material / wind API.

// Mint a generation-checked handle from a raw shape id (mirrors b2MakeBodyId).
void b2MakeShapeId( b2World* world, int shapeId, b2ShapeId* result )
{
    b2Shape* shape = &world->shapes.data[ shapeId ];
    result->index1 = shapeId + 1;
    result->world0 = world->worldId;
    result->generation = shape->generation;
}

// True iff the handle still refers to the live shape it was minted for. Mirrors
// b2Body_IsValid: bounds are checked BEFORE the deref (index1 == 0 would read
// data[-1], since NULL == -1), then the freed-slot marker, then the generation.
bool b2Shape_IsValid( b2World* world, b2ShapeId* id )
{
    if( id->world0 != world->worldId )                         return false;
    if( id->index1 <= 0 || id->index1 > world->shapes.count )  return false;
    b2Shape* shape = &world->shapes.data[ id->index1 - 1 ];
    if( shape->id == B2_NULL_INDEX )                           return false;   // freed slot
    if( shape->generation != id->generation )                  return false;   // slot reused
    return true;
}

// -- identity --
void b2Shape_GetBody( b2World* world, b2ShapeId* shapeId, b2BodyId* result )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    b2MakeBodyId( world, shape->bodyId, result );
}

int b2Shape_GetType( b2World* world, b2ShapeId* shapeId )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    return shape->type;
}

// -- material + filter --
float b2Shape_GetDensity( b2World* world, b2ShapeId* shapeId )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    return shape->density;
}

float b2Shape_GetFriction( b2World* world, b2ShapeId* shapeId )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    return shape->friction;
}

float b2Shape_GetRestitution( b2World* world, b2ShapeId* shapeId )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    return shape->restitution;
}

void b2Shape_GetFilter( b2World* world, b2ShapeId* shapeId, b2Filter* result )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    *result = shape->filter;
}

// -- event opt-ins --
bool b2Shape_IsSensor( b2World* world, b2ShapeId* shapeId )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    return shape->isSensor;
}

bool b2Shape_AreSensorEventsEnabled( b2World* world, b2ShapeId* shapeId )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    return shape->enableSensorEvents;
}

bool b2Shape_AreHitEventsEnabled( b2World* world, b2ShapeId* shapeId )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    return shape->enableHitEvents;
}

bool b2Shape_AreContactEventsEnabled( b2World* world, b2ShapeId* shapeId )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    return shape->enableContactEvents;
}

// -- sensor overlap enumeration --
//   A sensor shape keeps the set of visitor shapes currently overlapping it
//   (shape->sensorOverlaps, maintained by b2OverlapSensors each step). GetCapacity
//   is how many to size the array for; GetData fills up to `capacity` visitor shape
//   ids and returns how many were written. DEVIATION: upstream hands back b2ShapeId
//   handles; the port writes raw shape indices (multi-word id can't be an array the
//   game indexes without the world). A non-sensor shape reports zero.
int b2Shape_GetSensorCapacity( b2World* world, b2ShapeId* shapeId )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    return shape->sensorOverlapCount;
}

int b2Shape_GetSensorData( b2World* world, b2ShapeId* shapeId, int* visitorIds, int capacity )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    int count = shape->sensorOverlapCount;
    if( count > capacity )
        count = capacity;
    int i;
    for( i = 0; i < count; ++i )
        visitorIds[i] = shape->sensorOverlaps[i];
    return count;
}

// -- geometry --
//   Returns the cached shape->aabb, matching upstream b2Shape_GetAABB exactly.
//   NOTE this box is the tight AABB padded by B2_SPECULATIVE_DISTANCE on each
//   side -- upstream builds the same field with b2ComputeFatShapeAABB(shape, xf,
//   speculativeDistance), so the padding is upstream behaviour, not a port quirk.
//   (It doubles as the b2Collide disjoint early-out box; b2UpdateBodyProxies
//   refreshes it every step for awake bodies, b2Body_SetTransform on teleport,
//   and b2CreateShapeInternal at create -- so it is never stale.) Use
//   b2ComputeShapeAABB directly if you need the unpadded box.
void b2Shape_GetAABB( b2World* world, b2ShapeId* shapeId, b2AABB* result )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    *result = shape->aabb;
}

void b2Shape_GetCircle( b2World* world, b2ShapeId* shapeId, b2Circle* result )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    *result = shape->circle;
}

void b2Shape_GetCapsule( b2World* world, b2ShapeId* shapeId, b2Capsule* result )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    *result = shape->capsule;
}

void b2Shape_GetPolygon( b2World* world, b2ShapeId* shapeId, b2Polygon* result )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    *result = shape->polygon;
}

void b2Shape_GetSegment( b2World* world, b2ShapeId* shapeId, b2Segment* result )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    *result = shape->segment;
}

void b2Shape_GetChainSegment( b2World* world, b2ShapeId* shapeId, b2ChainSegment* result )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    *result = shape->chainSegment;
}

// Is a world-space point inside this shape? (mouse/cursor picking)
bool b2Shape_TestPoint( b2World* world, b2ShapeId* shapeId, b2Vec2* point )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    b2WorldTransform xf;
    b2GetBodyTransform( world, shape->bodyId, &xf );
    return b2ShapeTestPoint( shape, &xf, point );
}

// Cast a WORLD-space ray against this ONE shape (upstream b2Shape_RayCast). Same
// per-shape logic as the b2World_CastRayClosest tree callback, minus the broad
// phase: transform the ray into the shape's local frame, dispatch to the shape ray
// cast, then map the hit point/normal back to world (a rigid transform preserves
// the fraction). result->hit == false on a miss.
void b2Shape_RayCast( b2World* world, b2ShapeId* shapeId, b2RayCastInput* input, b2CastOutput* result )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    b2WorldTransform xf;
    b2GetBodyTransform( world, shape->bodyId, &xf );

    b2RayCastInput localInput;
    b2InvTransformPoint( &xf, &input->origin, &localInput.origin );
    b2InvRotateVector( &xf.q, &input->translation, &localInput.translation );
    localInput.maxFraction = input->maxFraction;

    b2CastOutput output;
    output.normal = b2Vec2_zero;  output.point = b2Vec2_zero;
    output.fraction = 0.0;  output.iterations = 0;  output.hit = false;

    if( shape->type == b2_circleShape )
        b2RayCastCircle( &shape->circle, &localInput, &output );
    else if( shape->type == b2_capsuleShape )
        b2RayCastCapsule( &shape->capsule, &localInput, &output );
    else if( shape->type == b2_polygonShape )
        b2RayCastPolygon( &shape->polygon, &localInput, &output );
    else if( shape->type == b2_segmentShape )
        b2RayCastSegment( &shape->segment, &localInput, false, &output );

    *result = output;
    if( output.hit )
    {
        b2TransformPoint( &xf, &output.point, &result->point );     // hit -> world
        b2RotateVector( &xf.q, &output.normal, &result->normal );   // normal -> world
    }
}

// Closest point ON this shape's surface to a WORLD-space target (upstream
// b2Shape_GetClosestPoint), via GJK. The shape rides as proxy A in its LOCAL frame
// and the target as a 1-point proxy B; input.transform brings the target into the
// shape frame (rotation is irrelevant for a single point), and output.pointA -- the
// witness on the shape, in shape-local space -- is mapped back to world. NOTE if the
// target is INSIDE the shape, GJK returns distance 0 with a degenerate witness (see
// the mover note in b2_geometry.h); callers wanting a surface point should stay
// outside.
void b2Shape_GetClosestPoint( b2World* world, b2ShapeId* shapeId, b2Vec2* target, b2Vec2* result )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    b2WorldTransform xf;
    b2GetBodyTransform( world, shape->bodyId, &xf );

    b2Vec2 zero = b2Vec2_zero;
    b2DistanceInput input;
    b2MakeShapeProxy( shape, &input.proxyA );
    b2MakeProxy( &zero, 1, 0.0, &input.proxyB );
    input.transform.q = b2Rot_identity;
    b2InvTransformPoint( &xf, target, &input.transform.p );   // target -> shape-local frame
    input.useRadii = true;

    b2SimplexCache cache;  cache.count = 0;
    b2DistanceOutput output;
    b2ShapeDistance( &input, &cache, &output );

    b2TransformPoint( &xf, &output.pointA, result );          // witness -> world
}

// -- user data --
void b2Shape_SetUserData( b2World* world, b2ShapeId* shapeId, void* userData )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    shape->userData = userData;
}

void* b2Shape_GetUserData( b2World* world, b2ShapeId* shapeId )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    return shape->userData;
}

// Compute this shape's mass properties about its own origin (upstream
// b2Shape_ComputeMassData). Pure -- does not touch the body.
void b2Shape_ComputeMassData( b2World* world, b2ShapeId* shapeId, b2MassData* result )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    b2ComputeShapeMass( shape, result );
}


// -----------------------------------------------------------------------------
//   b2Shape_*  (slice 2: setters -- these carry side effects, not field pokes)
// -----------------------------------------------------------------------------

// Recompute a shape's cached boxes from a transform (upstream b2UpdateShapeAABBs).
//   shape->aabb    = tight AABB padded by B2_SPECULATIVE_DISTANCE (the b2Collide
//                    disjoint early-out box; this is also what b2Shape_GetAABB returns)
//   shape->fatAABB = tight AABB padded by shape->aabbMargin (what the tree stores)
// Mirrors the block b2CreateShapeInternal and b2Body_SetTransform each inline.
void b2UpdateShapeAABBs( b2Shape* shape, b2WorldTransform* xf )
{
    b2AABB aabb;
    b2ComputeShapeAABB( shape, xf, &aabb );

    float sp = B2_SPECULATIVE_DISTANCE;
    shape->aabb.lowerBound.x = aabb.lowerBound.x - sp;
    shape->aabb.lowerBound.y = aabb.lowerBound.y - sp;
    shape->aabb.upperBound.x = aabb.upperBound.x + sp;
    shape->aabb.upperBound.y = aabb.upperBound.y + sp;

    float m = shape->aabbMargin;
    shape->fatAABB.lowerBound.x = aabb.lowerBound.x - m;
    shape->fatAABB.lowerBound.y = aabb.lowerBound.y - m;
    shape->fatAABB.upperBound.x = aabb.upperBound.x + m;
    shape->fatAABB.upperBound.y = aabb.upperBound.y + m;
}

// A shape changed in a way that invalidates its contacts and/or its proxy
// (geometry or filter). Upstream b2ResetProxy: destroy every contact touching this
// shape, refresh the cached boxes, then either re-create the proxy (category bits
// changed -> the tree sorts on them) or just move it.
//
// PORT NOTE: b2BroadPhase_CreateProxy only seeds the move buffer for non-static
// proxies (it has no forcePairCreation parameter). Without a move-buffer entry a
// recreated proxy is never queried during pairing, so a static shape whose filter
// changed would never re-pair with an already-resting dynamic body. Buffer the
// move explicitly here -- that is exactly what upstream's forcePairCreation=true does.
void b2ResetProxy( b2World* world, b2Shape* shape, bool wakeBodies, bool destroyProxy )
{
    b2Body* body = &world->bodies.data[ shape->bodyId ];
    int shapeId = shape->id;

    // destroy every contact that references this shape (read nextKey BEFORE the
    // destroy: b2DestroyContact unlinks the edge we are standing on)
    int contactKey = body->headContactKey;
    while( contactKey != B2_NULL_INDEX )
    {
        int contactId = contactKey >> 1;
        int edgeIndex = contactKey & 1;
        b2Contact* contact = &world->contacts.data[ contactId ];
        contactKey = b2ContactEdgeAt( contact, edgeIndex )->nextKey;

        if( contact->shapeIdA == shapeId || contact->shapeIdB == shapeId )
            b2DestroyContact( world, contact, wakeBodies );
    }

    b2WorldTransform xf;
    b2GetBodyTransformQuick( world, body, &xf );

    if( shape->proxyKey != B2_NULL_INDEX )
    {
        int proxyType = B2_PROXY_TYPE( shape->proxyKey );
        b2UpdateShapeAABBs( shape, &xf );

        if( destroyProxy )
        {
            b2BroadPhase_DestroyProxy( &world->broadPhase, shape->proxyKey );
            shape->proxyKey = b2BroadPhase_CreateProxy( &world->broadPhase, proxyType, &shape->fatAABB,
                                                        shape->filter.categoryBits, shapeId );
            b2BufferMove( &world->broadPhase, shape->proxyKey );   // == forcePairCreation
        }
        else
        {
            b2BroadPhase_MoveProxy( &world->broadPhase, shape->proxyKey, &shape->fatAABB );
        }
    }
    else
    {
        // disabled body: no proxy, but keep the cached boxes coherent
        b2UpdateShapeAABBs( shape, &xf );
    }
}

// Density change -> the body's mass properties change. Early-out on no-op because
// b2UpdateBodyMassData walks every shape twice.
void b2Shape_SetDensity( b2World* world, b2ShapeId* shapeId, float density, bool updateBodyMass )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    if( density == shape->density )
        return;

    shape->density = density;

    if( updateBodyMass )
    {
        b2Body* body = &world->bodies.data[ shape->bodyId ];
        b2UpdateBodyMassData( world, body );
    }
}

// Friction/restitution are read fresh by b2UpdateContact each step (it re-mixes
// the pair), so a plain field write suffices -- no contact reset needed.
void b2Shape_SetFriction( b2World* world, b2ShapeId* shapeId, float friction )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    shape->friction = friction;
}

void b2Shape_SetRestitution( b2World* world, b2ShapeId* shapeId, float restitution )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    shape->restitution = restitution;
}

// A filter change can invalidate existing contacts (they may no longer be allowed)
// and, if the CATEGORY bits changed, the tree node's stored category -- which the
// query mask prunes whole subtrees on -- so the proxy must be recreated, not moved.
// Wakes bodies: destroying a contact under a sleeping pile must not strand it.
// DEFERRED: sensor overlap sets are not re-evaluated here; they refresh next step
// (upstream has the same note).
void b2Shape_SetFilter( b2World* world, b2ShapeId* shapeId, b2Filter* filter )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    if( filter->maskBits == shape->filter.maskBits &&
        filter->categoryBits == shape->filter.categoryBits &&
        filter->groupIndex == shape->filter.groupIndex )
        return;

    bool destroyProxy = filter->categoryBits != shape->filter.categoryBits;
    shape->filter = *filter;
    b2ResetProxy( world, shape, true, destroyProxy );
}

// -- event opt-ins (plain flag writes; read at the emit sites) --
void b2Shape_EnableContactEvents( b2World* world, b2ShapeId* shapeId, bool flag )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    shape->enableContactEvents = flag;
}

void b2Shape_EnableHitEvents( b2World* world, b2ShapeId* shapeId, bool flag )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    shape->enableHitEvents = flag;
}

void b2Shape_EnableSensorEvents( b2World* world, b2ShapeId* shapeId, bool flag )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    shape->enableSensorEvents = flag;
}

// -- geometry swap --
//   Replacing the geometry invalidates the contacts AND the proxy extent, and can
//   change the shape TYPE (so the narrow-phase dispatch picks a different collide
//   fn). Always destroy+recreate the proxy: the new box may sort elsewhere.
//   The body's mass is NOT recomputed (upstream doesn't either) -- call
//   b2Body_ApplyMassFromShapes afterwards if the shape carries density.
void b2Shape_SetCircle( b2World* world, b2ShapeId* shapeId, b2Circle* circle )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    shape->circle = *circle;
    shape->type = b2_circleShape;
    b2ResetProxy( world, shape, true, true );
}

void b2Shape_SetCapsule( b2World* world, b2ShapeId* shapeId, b2Capsule* capsule )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    shape->capsule = *capsule;
    shape->type = b2_capsuleShape;
    b2ResetProxy( world, shape, true, true );
}

void b2Shape_SetPolygon( b2World* world, b2ShapeId* shapeId, b2Polygon* polygon )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    shape->polygon = *polygon;
    shape->type = b2_polygonShape;
    b2ResetProxy( world, shape, true, true );
}

void b2Shape_SetSegment( b2World* world, b2ShapeId* shapeId, b2Segment* segment )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    shape->segment = *segment;
    shape->type = b2_segmentShape;
    b2ResetProxy( world, shape, true, true );
}

void b2Shape_SetChainSegment( b2World* world, b2ShapeId* shapeId, b2ChainSegment* chainSegment )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    shape->chainSegment = *chainSegment;
    shape->type = b2_chainSegmentShape;
    b2ResetProxy( world, shape, true, true );
}


// -----------------------------------------------------------------------------
//   b2Body_*  (breadth: field reads/writes that do NOT move a body between sets)
// -----------------------------------------------------------------------------
//   The authoritative flag word is bodySim->flags; the awake set's bodyState
//   carries a MIRROR that the solver reads on the hot path. Any flag write must
//   refresh that mirror -- upstream calls this b2SyncBodyFlags.
//
//   DEVIATION: b2Body_GetName/SetName are omitted (the dialect has no `char`).
//   b2Body_GetWorld is omitted (the port threads b2World* explicitly).
//   DEFERRED: b2Body_GetContactData (needs a b2ContactData type + the
//   count/fill-buffer convention), b2Body_SetType / Enable / Disable (they move a
//   body between solver sets -- their own slice, guarded by b2ValidateWorld).
void b2SyncBodyFlags( b2World* world, b2Body* body )
{
    b2BodySim* bodySim = b2GetBodySim( world, body );
    b2BodyState* state = b2GetBodyState( world, body );
    if( state != NULL )
        state->flags = bodySim->flags;
}

int b2Body_GetType( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return body->type;
}

bool b2Body_IsEnabled( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return body->setIndex != b2_disabledSet;
}

// -- mass properties --
void b2Body_GetLocalCenter( b2World* world, b2BodyId* bodyId, b2Vec2* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* bodySim = b2GetBodySim( world, body );
    *result = bodySim->localCenter;
}

float b2Body_GetRotationalInertia( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return body->inertia;
}

void b2Body_GetMassData( b2World* world, b2BodyId* bodyId, b2MassData* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* bodySim = b2GetBodySim( world, body );
    result->mass = body->mass;
    result->center = bodySim->localCenter;
    result->rotationalInertia = body->inertia;
}

// Override the mass properties computed from the shapes. The world center is
// re-derived from the new local center; center0 follows so CCD sees no jump.
void b2Body_SetMassData( b2World* world, b2BodyId* bodyId, b2MassData* massData )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* bodySim = b2GetBodySim( world, body );

    body->mass = massData->mass;
    body->inertia = massData->rotationalInertia;
    bodySim->localCenter = massData->center;

    b2TransformWorldPoint( &bodySim->transform, &massData->center, &bodySim->center );
    bodySim->center0 = bodySim->center;

    if( body->mass > 0.0 )  bodySim->invMass = 1.0 / body->mass;
    else                    bodySim->invMass = 0.0;

    if( body->inertia > 0.0 )  bodySim->invInertia = 1.0 / body->inertia;
    else                       bodySim->invInertia = 0.0;
}

// Recompute mass/inertia/center from the attached shapes (undoes b2Body_SetMassData).
void b2Body_ApplyMassFromShapes( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2UpdateBodyMassData( world, body );
}

// -- damping / gravity scale --
float b2Body_GetLinearDamping( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return b2GetBodySim( world, body )->linearDamping;
}

void b2Body_SetLinearDamping( b2World* world, b2BodyId* bodyId, float linearDamping )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2GetBodySim( world, body )->linearDamping = linearDamping;
}

float b2Body_GetAngularDamping( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return b2GetBodySim( world, body )->angularDamping;
}

void b2Body_SetAngularDamping( b2World* world, b2BodyId* bodyId, float angularDamping )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2GetBodySim( world, body )->angularDamping = angularDamping;
}

float b2Body_GetGravityScale( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return b2GetBodySim( world, body )->gravityScale;
}

void b2Body_SetGravityScale( b2World* world, b2BodyId* bodyId, float gravityScale )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2GetBodySim( world, body )->gravityScale = gravityScale;
}

// -- sleep tuning --
float b2Body_GetSleepThreshold( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return body->sleepThreshold;
}

void b2Body_SetSleepThreshold( b2World* world, b2BodyId* bodyId, float sleepThreshold )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    body->sleepThreshold = sleepThreshold;
}

bool b2Body_IsSleepEnabled( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return ( b2GetBodySim( world, body )->flags & b2_enableSleep ) != 0;
}

// Disabling sleep on a sleeping body must wake it, or it would never run again.
void b2Body_EnableSleep( b2World* world, b2BodyId* bodyId, bool enableSleep )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );

    if( enableSleep == false )
        b2WakeBody( world, body );

    b2BodySim* bodySim = b2GetBodySim( world, body );
    if( enableSleep )  bodySim->flags = bodySim->flags | b2_enableSleep;
    else               bodySim->flags = bodySim->flags & ~b2_enableSleep;
    b2SyncBodyFlags( world, body );
}

// -- bullet / contact recycling --
bool b2Body_IsBullet( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return ( b2GetBodySim( world, body )->flags & b2_isBullet ) != 0;
}

void b2Body_SetBullet( b2World* world, b2BodyId* bodyId, bool flag )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* bodySim = b2GetBodySim( world, body );
    if( flag )  bodySim->flags = bodySim->flags | b2_isBullet;
    else        bodySim->flags = bodySim->flags & ~b2_isBullet;
    b2SyncBodyFlags( world, body );
}

bool b2Body_IsContactRecyclingEnabled( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return ( b2GetBodySim( world, body )->flags & b2_bodyEnableContactRecycling ) != 0;
}

void b2Body_EnableContactRecycling( b2World* world, b2BodyId* bodyId, bool flag )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* bodySim = b2GetBodySim( world, body );
    if( flag )  bodySim->flags = bodySim->flags | b2_bodyEnableContactRecycling;
    else        bodySim->flags = bodySim->flags & ~b2_bodyEnableContactRecycling;
    b2SyncBodyFlags( world, body );
}

// -- motion locks --
//   DEVIATION: upstream passes a b2MotionLocks struct by value; the dialect can't,
//   and b2BodyDef already flattens the three booleans, so these do too.
void b2Body_GetMotionLocks( b2World* world, b2BodyId* bodyId, bool* linearX, bool* linearY, bool* angularZ )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    int flags = b2GetBodySim( world, body )->flags;
    *linearX  = ( flags & b2_lockLinearX ) != 0;
    *linearY  = ( flags & b2_lockLinearY ) != 0;
    *angularZ = ( flags & b2_lockAngularZ ) != 0;
}

// Zero the newly-locked velocity components immediately: the solver only enforces
// the locks during integration, so a body locked mid-flight would otherwise carry
// its old velocity into the next contact solve.
void b2Body_SetMotionLocks( b2World* world, b2BodyId* bodyId, bool linearX, bool linearY, bool angularZ )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* bodySim = b2GetBodySim( world, body );

    bodySim->flags = bodySim->flags & ~( b2_lockLinearX | b2_lockLinearY | b2_lockAngularZ );
    if( linearX )   bodySim->flags = bodySim->flags | b2_lockLinearX;
    if( linearY )   bodySim->flags = bodySim->flags | b2_lockLinearY;
    if( angularZ )  bodySim->flags = bodySim->flags | b2_lockAngularZ;

    b2SyncBodyFlags( world, body );

    b2BodyState* state = b2GetBodyState( world, body );
    if( state != NULL )
    {
        if( linearX )   state->linearVelocity.x = 0.0;
        if( linearY )   state->linearVelocity.y = 0.0;
        if( angularZ )  state->angularVelocity = 0.0;
    }
}

// -- forces --
void b2Body_ClearForces( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* bodySim = b2GetBodySim( world, body );
    bodySim->force = b2Vec2_zero;
    bodySim->torque = 0.0;
}

// -- frame conversions (b2Body_GetLocalPoint lives with the older body API above) --
void b2Body_GetWorldPoint( b2World* world, b2BodyId* bodyId, b2Vec2* localPoint, b2Vec2* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* bodySim = b2GetBodySim( world, body );
    b2TransformWorldPoint( &bodySim->transform, localPoint, result );
}

void b2Body_GetWorldVector( b2World* world, b2BodyId* bodyId, b2Vec2* localVector, b2Vec2* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* bodySim = b2GetBodySim( world, body );
    b2RotateVector( &bodySim->transform.q, localVector, result );
}

void b2Body_GetLocalVector( b2World* world, b2BodyId* bodyId, b2Vec2* worldVector, b2Vec2* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodySim* bodySim = b2GetBodySim( world, body );
    b2InvRotateVector( &bodySim->transform.q, worldVector, result );
}

// Velocity of a material point on the body. Non-awake bodies have no b2BodyState
// (velocity lives only in the awake set) -> zero, same as upstream.
void b2Body_GetLocalPointVelocity( b2World* world, b2BodyId* bodyId, b2Vec2* localPoint, b2Vec2* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodyState* state = b2GetBodyState( world, body );
    if( state == NULL )
    {
        *result = b2Vec2_zero;
        return;
    }

    b2BodySim* bodySim = b2GetBodySim( world, body );
    b2Vec2 offset;   b2Sub( localPoint, &bodySim->localCenter, &offset );
    b2Vec2 r;        b2RotateVector( &bodySim->transform.q, &offset, &r );
    b2Vec2 spin;     b2CrossSV( state->angularVelocity, &r, &spin );
    b2Add( &state->linearVelocity, &spin, result );
}

void b2Body_GetWorldPointVelocity( b2World* world, b2BodyId* bodyId, b2Vec2* worldPoint, b2Vec2* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    b2BodyState* state = b2GetBodyState( world, body );
    if( state == NULL )
    {
        *result = b2Vec2_zero;
        return;
    }

    b2BodySim* bodySim = b2GetBodySim( world, body );
    b2Vec2 r;      b2Sub( worldPoint, &bodySim->center, &r );
    b2Vec2 spin;   b2CrossSV( state->angularVelocity, &r, &spin );
    b2Add( &state->linearVelocity, &spin, result );
}

// -- shape / joint / contact enumeration --
//   DEVIATION: these fill a caller-supplied RAW int id buffer and return the count
//   written, rather than upstream's b2ShapeId/b2JointId array (multi-word handles
//   can't be array-returned cheaply here). Feed the ints to b2MakeShapeId /
//   b2MakeJointId if you need generation-checked handles.
int b2Body_GetShapeCount( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return body->shapeCount;
}

int b2Body_GetShapes( b2World* world, b2BodyId* bodyId, int* shapeIds, int capacity )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    int shapeId = body->headShapeId;
    int count = 0;
    while( shapeId != B2_NULL_INDEX && count < capacity )
    {
        b2Shape* shape = &world->shapes.data[ shapeId ];
        shapeIds[ count ] = shapeId;
        count = count + 1;
        shapeId = shape->nextShapeId;
    }
    return count;
}

int b2Body_GetJointCount( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return body->jointCount;
}

int b2Body_GetJoints( b2World* world, b2BodyId* bodyId, int* jointIds, int capacity )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    int jointKey = body->headJointKey;
    int count = 0;
    while( jointKey != B2_NULL_INDEX && count < capacity )
    {
        int jointId = jointKey >> 1;
        int edgeIndex = jointKey & 1;
        b2Joint* joint = &world->joints.data[ jointId ];
        jointIds[ count ] = jointId;
        count = count + 1;
        jointKey = b2JointEdgeAt( joint, edgeIndex )->nextKey;
    }
    return count;
}

int b2Body_GetContactCapacity( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    return body->contactCount;
}

// Conservative capacity for b2Shape_GetContactData: the owning body's contact
// count (may include contacts of the body's OTHER shapes -- upstream does the same).
int b2Shape_GetContactCapacity( b2World* world, b2ShapeId* shapeId )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    b2Body* body = &world->bodies.data[ shape->bodyId ];
    return body->contactCount;
}

// Wake every body currently TOUCHING this one (upstream b2Body_WakeTouching).
// Does not wake this body -- call b2Body_Wake for that.
void b2Body_WakeTouching( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );

    int contactKey = body->headContactKey;
    while( contactKey != B2_NULL_INDEX )
    {
        int contactId = contactKey >> 1;
        int edgeIndex = contactKey & 1;
        b2Contact* contact = &world->contacts.data[ contactId ];
        contactKey = b2ContactEdgeAt( contact, edgeIndex )->nextKey;

        if( ( contact->flags & b2_contactTouchingFlag ) != 0 )
        {
            // the OTHER endpoint of this contact
            int otherEdge = edgeIndex ^ 1;
            int otherBodyId = b2ContactEdgeAt( contact, otherEdge )->bodyId;
            b2WakeBody( world, &world->bodies.data[ otherBodyId ] );
        }
    }
}

// Turn every attached shape's event opt-in on/off in one call.
void b2Body_EnableContactEvents( b2World* world, b2BodyId* bodyId, bool flag )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    int shapeId = body->headShapeId;
    while( shapeId != B2_NULL_INDEX )
    {
        b2Shape* shape = &world->shapes.data[ shapeId ];
        shape->enableContactEvents = flag;
        shapeId = shape->nextShapeId;
    }
}

void b2Body_EnableHitEvents( b2World* world, b2BodyId* bodyId, bool flag )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    int shapeId = body->headShapeId;
    while( shapeId != B2_NULL_INDEX )
    {
        b2Shape* shape = &world->shapes.data[ shapeId ];
        shape->enableHitEvents = flag;
        shapeId = shape->nextShapeId;
    }
}

// Union of the attached shapes' cached (speculative-padded) AABBs. A body with no
// shapes yields a degenerate box at its origin, as upstream does.
void b2Body_ComputeAABB( b2World* world, b2BodyId* bodyId, b2AABB* result )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );

    if( body->headShapeId == B2_NULL_INDEX )
    {
        b2WorldTransform xf;
        b2GetBodyTransformQuick( world, body, &xf );
        result->lowerBound = xf.p;
        result->upperBound = xf.p;
        return;
    }

    b2Shape* shape = &world->shapes.data[ body->headShapeId ];
    b2AABB aabb = shape->aabb;
    int shapeId = shape->nextShapeId;
    while( shapeId != B2_NULL_INDEX )
    {
        shape = &world->shapes.data[ shapeId ];
        b2AABB merged;  b2AABB_Union( &aabb, &shape->aabb, &merged );
        aabb = merged;
        shapeId = shape->nextShapeId;
    }
    *result = aabb;
}


// -----------------------------------------------------------------------------
//   Solver-set transfer  (b2Body_SetType / Enable / Disable machinery)
// -----------------------------------------------------------------------------
//   Moving a body or joint between solver sets is the one operation that can break
//   the port's central invariant: cold record (b2Body/b2Joint) .setIndex+.localIndex
//   must always address the live dense sim. Every transfer below swap-removes from
//   the source array and REPAIRS the swapped-in element's owner. A mistake here does
//   not turn the screen red -- it reads out of bounds a few steps later and the
//   console faults. b2ValidateWorld (port/b2_validate.h) is the guard; harness2
//   asserts it after each transition.

// Move one body's sim from sourceSet to targetSet (upstream solver_set.c
// b2TransferBody). The awake set is the only one carrying b2BodyState, so leaving it
// DROPS the velocity and entering it creates a zeroed state -- upstream does the same,
// which is why a body made static loses its velocity.
void b2TransferBody( b2World* world, b2SolverSet* targetSet, b2SolverSet* sourceSet, b2Body* body )
{
    if( targetSet == sourceSet )
        return;

    int sourceIndex = body->localIndex;

    // emplace a copy in the target (whole-struct copy == hardware MOVS)
    targetSet->bodySims.data = b2GrowArray( targetSet->bodySims.data, &targetSet->bodySims.capacity,
                                            targetSet->bodySims.count + 1, sizeof( b2BodySim ) );
    int targetIndex = targetSet->bodySims.count;
    targetSet->bodySims.data[ targetIndex ] = sourceSet->bodySims.data[ sourceIndex ];
    targetSet->bodySims.count = targetSet->bodySims.count + 1;

    // transient per-step flags must not survive a set change
    b2BodySim* targetSim = &targetSet->bodySims.data[ targetIndex ];
    targetSim->flags = targetSim->flags & ~( b2_isFast | b2_isSpeedCapped );

    // swap-remove from the source (repairs the moved body's localIndex)
    b2RemoveBodySim( &sourceSet->bodySims, &world->bodies, sourceIndex );

    if( sourceSet->setIndex == b2_awakeSet )
    {
        // bodyStates is parallel to bodySims: swap-remove at the SAME index
        int lastState = sourceSet->bodyStates.count - 1;
        if( sourceIndex != lastState )
            sourceSet->bodyStates.data[ sourceIndex ] = sourceSet->bodyStates.data[ lastState ];
        sourceSet->bodyStates.count = lastState;
    }
    else if( targetSet->setIndex == b2_awakeSet )
    {
        targetSet->bodyStates.data = b2GrowArray( targetSet->bodyStates.data, &targetSet->bodyStates.capacity,
                                                  targetSet->bodyStates.count + 1, sizeof( b2BodyState ) );
        b2BodyState* state = &targetSet->bodyStates.data[ targetSet->bodyStates.count ];
        targetSet->bodyStates.count = targetSet->bodyStates.count + 1;

        memset( state, 0, sizeof( b2BodyState ) );
        state->deltaRotation = b2Rot_identity;
        state->flags = targetSim->flags;
    }

    body->setIndex = targetSet->setIndex;
    body->localIndex = targetIndex;
}

// Move one joint's sim between sets. DEVIATION from upstream b2TransferJoint: with no
// constraint graph, an awake joint's sim lives in awakeSet->jointSims like any other
// set's, so both halves collapse to a plain emplace + swap-remove. colorIndex stays
// B2_NULL_INDEX throughout (the port has no colors).
void b2TransferJoint( b2World* world, b2SolverSet* targetSet, b2SolverSet* sourceSet, b2Joint* joint )
{
    if( targetSet == sourceSet )
        return;

    int localIndex = joint->localIndex;

    targetSet->jointSims.data = b2GrowArray( targetSet->jointSims.data, &targetSet->jointSims.capacity,
                                             targetSet->jointSims.count + 1, sizeof( b2JointSim ) );
    int targetIndex = targetSet->jointSims.count;
    targetSet->jointSims.data[ targetIndex ] = sourceSet->jointSims.data[ localIndex ];
    targetSet->jointSims.count = targetSet->jointSims.count + 1;

    int lastIndex = sourceSet->jointSims.count - 1;
    if( localIndex != lastIndex )
    {
        sourceSet->jointSims.data[ localIndex ] = sourceSet->jointSims.data[ lastIndex ];
        int movedId = sourceSet->jointSims.data[ localIndex ].jointId;
        world->joints.data[ movedId ].localIndex = localIndex;      // repair the moved owner
    }
    sourceSet->jointSims.count = lastIndex;

    joint->setIndex = targetSet->setIndex;
    joint->localIndex = targetIndex;
    joint->colorIndex = B2_NULL_INDEX;
}

// Destroy every contact attached to a body (read nextKey BEFORE each destroy).
void b2DestroyBodyContacts( b2World* world, b2Body* body, bool wakeBodies )
{
    int edgeKey = body->headContactKey;
    while( edgeKey != B2_NULL_INDEX )
    {
        int contactId = edgeKey >> 1;
        int edgeIndex = edgeKey & 1;
        b2Contact* contact = &world->contacts.data[ contactId ];
        edgeKey = b2ContactEdgeAt( contact, edgeIndex )->nextKey;
        b2DestroyContact( world, contact, wakeBodies );
    }
}

// Drop every shape proxy of a body out of the broad phase.
void b2DestroyBodyProxies( b2World* world, b2Body* body )
{
    int shapeId = body->headShapeId;
    while( shapeId != B2_NULL_INDEX )
    {
        b2Shape* shape = &world->shapes.data[ shapeId ];
        if( shape->proxyKey != B2_NULL_INDEX )
        {
            b2BroadPhase_DestroyProxy( &world->broadPhase, shape->proxyKey );
            shape->proxyKey = B2_NULL_INDEX;
        }
        shapeId = shape->nextShapeId;
    }
}

// (Re)insert every shape proxy of a body into the tree for `proxyType`, forcing a
// move-buffer entry so pairing sees it even for a static proxy (see b2ResetProxy).
void b2CreateBodyProxies( b2World* world, b2Body* body, int proxyType )
{
    b2WorldTransform xf;
    b2GetBodyTransformQuick( world, body, &xf );

    int shapeId = body->headShapeId;
    while( shapeId != B2_NULL_INDEX )
    {
        b2Shape* shape = &world->shapes.data[ shapeId ];

        // static bodies want the tighter margin; movable ones the full one
        if( proxyType == b2_staticBody )  shape->aabbMargin = B2_SPECULATIVE_DISTANCE;
        else                              shape->aabbMargin = B2_MAX_AABB_MARGIN;

        b2UpdateShapeAABBs( shape, &xf );
        shape->proxyKey = b2BroadPhase_CreateProxy( &world->broadPhase, proxyType, &shape->fatAABB,
                                                    shape->filter.categoryBits, shape->id );
        b2BufferMove( &world->broadPhase, shape->proxyKey );        // == forcePairCreation
        shapeId = shape->nextShapeId;
    }
}


// -----------------------------------------------------------------------------
//   b2Body_SetType / b2Body_Disable / b2Body_Enable
// -----------------------------------------------------------------------------

// Change a body's type at runtime (upstream body.c b2Body_SetType).
//
// DEVIATION: upstream parks every joint in the STATIC set mid-way "so they can be
// added to the constraint graph below and acquire consistent colors". That staging
// is graph-coloring bookkeeping for a world this port deliberately does not have.
// The staging is kept anyway -- not for colors, but because it gives every joint a
// known set to be transferred FROM in stage 7 regardless of where waking left it.
void b2Body_SetType( b2World* world, b2BodyId* bodyId, int type )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    int originalType = body->type;
    if( originalType == type )
        return;

    int jointKey;
    int jointId;
    int edgeIndex;
    b2Joint* joint;

    // Stage 1: a disabled body owns no proxies, contacts or island -- just retype it.
    if( body->setIndex == b2_disabledSet )
    {
        body->type = type;
        b2BodySim* dsim = b2GetBodySim( world, body );
        if( type == b2_dynamicBody )  dsim->flags = dsim->flags | b2_dynamicFlag;
        else                          dsim->flags = dsim->flags & ~b2_dynamicFlag;
        b2SyncBodyFlags( world, body );
        b2UpdateBodyMassData( world, body );
        return;
    }

    // Stage 2: the old contacts assumed the old type (and its tree). wakeBodies=false:
    // stage 3 wakes this body anyway, and a sleeping neighbour re-pairs when it wakes.
    b2DestroyBodyContacts( world, body, false );

    // Stage 3: wake this body (no-op if static -- static bodies never sleep)
    b2WakeBody( world, body );

    // Stage 4: unlink every joint from its island and park it in the static set.
    // Wake BOTH endpoints first: b2WakeBody above does nothing for a static body, but
    // a joint hanging off it may reach a sleeping island that must now be re-solved.
    jointKey = body->headJointKey;
    while( jointKey != B2_NULL_INDEX )
    {
        jointId = jointKey >> 1;
        edgeIndex = jointKey & 1;
        joint = &world->joints.data[ jointId ];
        jointKey = b2JointEdgeAt( joint, edgeIndex )->nextKey;

        if( joint->setIndex == b2_disabledSet )
            continue;                                  // the other endpoint is disabled

        b2WakeBody( world, &world->bodies.data[ b2JointEdgeAt( joint, 0 )->bodyId ] );
        b2WakeBody( world, &world->bodies.data[ b2JointEdgeAt( joint, 1 )->bodyId ] );

        b2UnlinkJoint( world, joint );

        // re-read joint->setIndex: the wakes above may have migrated its sim
        b2SolverSet* jointSourceSet = &world->solverSets.data[ joint->setIndex ];
        b2SolverSet* staticSet = &world->solverSets.data[ b2_staticSet ];
        b2TransferJoint( world, staticSet, jointSourceSet, joint );
    }

    // Stage 5: retype, then move the body's sim to its new home set
    body->type = type;
    b2BodySim* sim = b2GetBodySim( world, body );
    if( type == b2_dynamicBody )  sim->flags = sim->flags | b2_dynamicFlag;
    else                          sim->flags = sim->flags & ~b2_dynamicFlag;

    int targetSetId = b2_awakeSet;
    if( type == b2_staticBody )
        targetSetId = b2_staticSet;

    b2SolverSet* targetSet = &world->solverSets.data[ targetSetId ];
    b2SolverSet* sourceSet = &world->solverSets.data[ body->setIndex ];
    b2TransferBody( world, targetSet, sourceSet, body );

    // Stage 6: island participation follows the static/non-static boundary
    if( originalType == b2_staticBody )
        b2CreateIslandForBody( world, b2_awakeSet, body );
    else if( type == b2_staticBody )
        b2RemoveBodyFromIsland( world, body );

    // Stage 7: joints whose pair still involves a dynamic body go back to the awake set
    jointKey = body->headJointKey;
    while( jointKey != B2_NULL_INDEX )
    {
        jointId = jointKey >> 1;
        edgeIndex = jointKey & 1;
        joint = &world->joints.data[ jointId ];
        jointKey = b2JointEdgeAt( joint, edgeIndex )->nextKey;

        if( joint->setIndex == b2_disabledSet )
            continue;

        b2Body* bodyA = &world->bodies.data[ b2JointEdgeAt( joint, 0 )->bodyId ];
        b2Body* bodyB = &world->bodies.data[ b2JointEdgeAt( joint, 1 )->bodyId ];

        if( bodyA->type == b2_dynamicBody || bodyB->type == b2_dynamicBody )
        {
            b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
            b2SolverSet* staticSet = &world->solverSets.data[ b2_staticSet ];
            b2TransferJoint( world, awakeSet, staticSet, joint );
        }
    }

    // Stage 8: the proxies must move to the tree for the new body type
    b2DestroyBodyProxies( world, body );
    b2CreateBodyProxies( world, body, type );

    // Stage 9: relink the joints that are back in play
    jointKey = body->headJointKey;
    while( jointKey != B2_NULL_INDEX )
    {
        jointId = jointKey >> 1;
        edgeIndex = jointKey & 1;
        joint = &world->joints.data[ jointId ];
        jointKey = b2JointEdgeAt( joint, edgeIndex )->nextKey;

        int otherBodyId = b2JointEdgeAt( joint, edgeIndex ^ 1 )->bodyId;
        b2Body* otherBody = &world->bodies.data[ otherBodyId ];

        if( otherBody->setIndex == b2_disabledSet )
            continue;
        if( body->type != b2_dynamicBody && otherBody->type != b2_dynamicBody )
            continue;                                  // static-static joints have no island

        b2LinkJoint( world, joint );
    }

    b2SyncBodyFlags( world, body );
    b2UpdateBodyMassData( world, body );               // type decides whether mass exists
}

// Take a body out of simulation entirely: no proxies, no contacts, no island, and
// its joints park in the disabled set. Contacts are destroyed with wakeBodies=true --
// pulling the floor out from under a sleeping pile must wake the pile, not leave it
// floating (that is finding F2, and it applies to disable as much as destroy).
void b2Body_Disable( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    if( body->setIndex == b2_disabledSet )
        return;

    b2DestroyBodyContacts( world, body, true );

    int jointKey = body->headJointKey;
    while( jointKey != B2_NULL_INDEX )
    {
        int jointId = jointKey >> 1;
        int edgeIndex = jointKey & 1;
        b2Joint* joint = &world->joints.data[ jointId ];
        jointKey = b2JointEdgeAt( joint, edgeIndex )->nextKey;

        if( joint->setIndex == b2_disabledSet )
            continue;                                  // already parked by the other endpoint

        b2UnlinkJoint( world, joint );

        b2SolverSet* jointSet = &world->solverSets.data[ joint->setIndex ];
        b2SolverSet* disabledSet = &world->solverSets.data[ b2_disabledSet ];
        b2TransferJoint( world, disabledSet, jointSet, joint );
    }

    b2DestroyBodyProxies( world, body );
    b2RemoveBodyFromIsland( world, body );

    // re-read setIndex: the contact destroys above may have woken (and moved) this body
    int sourceSetIndex = body->setIndex;
    b2SolverSet* set = &world->solverSets.data[ sourceSetIndex ];
    b2SolverSet* disabledSet = &world->solverSets.data[ b2_disabledSet ];
    b2TransferBody( world, disabledSet, set, body );

    // A contactless sleeper never woke above, so disabling it can empty its sleeping
    // set. Reclaim it, same as b2DestroyBody does (finding F5) -- otherwise the set id
    // leaks and b2ValidateWorld's pool-vs-array count check reds.
    if( sourceSetIndex >= b2_firstSleepingSet &&
        world->solverSets.data[ sourceSetIndex ].bodySims.count == 0 )
        b2DestroySolverSet( world, sourceSetIndex );
}

// Put a disabled body back into simulation. Its joints rejoin only when BOTH
// endpoints are enabled -- a joint to a still-disabled body stays parked.
void b2Body_Enable( b2World* world, b2BodyId* bodyId )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );
    if( body->setIndex != b2_disabledSet )
        return;

    int setId = b2_awakeSet;
    if( body->type == b2_staticBody )
        setId = b2_staticSet;

    b2SolverSet* targetSet = &world->solverSets.data[ setId ];
    b2SolverSet* disabledSet = &world->solverSets.data[ b2_disabledSet ];
    b2TransferBody( world, targetSet, disabledSet, body );

    b2CreateBodyProxies( world, body, body->type );

    if( setId != b2_staticSet )
        b2CreateIslandForBody( world, setId, body );

    int jointKey = body->headJointKey;
    while( jointKey != B2_NULL_INDEX )
    {
        int jointId = jointKey >> 1;
        int edgeIndex = jointKey & 1;
        b2Joint* joint = &world->joints.data[ jointId ];
        jointKey = b2JointEdgeAt( joint, edgeIndex )->nextKey;

        b2Body* bodyA = &world->bodies.data[ b2JointEdgeAt( joint, 0 )->bodyId ];
        b2Body* bodyB = &world->bodies.data[ b2JointEdgeAt( joint, 1 )->bodyId ];

        if( bodyA->setIndex == b2_disabledSet || bodyB->setIndex == b2_disabledSet )
            continue;                                  // the other end is still disabled

        // A sleeping endpoint must wake before the joint lands: otherwise jointSetId
        // would name a SLEEPING set and b2LinkJoint would island-link across sets.
        // (Same guard b2CreateJoint applies -- finding F4.) Waking is a no-op for a
        // static body, so after this both endpoints are static or awake.
        b2WakeBody( world, bodyA );
        b2WakeBody( world, bodyB );

        int jointSetId = b2_staticSet;
        if( bodyA->setIndex != b2_staticSet )       jointSetId = bodyA->setIndex;
        else if( bodyB->setIndex != b2_staticSet )  jointSetId = bodyB->setIndex;

        b2SolverSet* jointSet = &world->solverSets.data[ jointSetId ];
        b2SolverSet* dset = &world->solverSets.data[ b2_disabledSet ];
        b2TransferJoint( world, jointSet, dset, joint );

        if( jointSetId != b2_staticSet )
            b2LinkJoint( world, joint );
    }
}


// -----------------------------------------------------------------------------
//   b2World_*  (world-level tuning get/set)
// -----------------------------------------------------------------------------
//   DEFERRED (no port equivalent / out of scope): b2World_Draw, b2World_GetProfile,
//   b2World_GetCounters, b2World_DumpMemoryStats, b2World_Explode,
//   b2World_SetCustomFilterCallback / SetPreSolveCallback / SetFrictionCallback /
//   SetRestitutionCallback, b2World_RebuildStaticTree, b2World_EnableSpeculative,
//   b2World_Set/GetWorkerCount (serial), the recording/snapshot family, and the
//   b2World_Get*Events accessors (this port exposes its own poll arrays).
void b2World_GetGravity( b2World* world, b2Vec2* result )   { *result = world->gravity; }
void b2World_SetGravity( b2World* world, b2Vec2* gravity )  { world->gravity = *gravity; }

float b2World_GetRestitutionThreshold( b2World* world )              { return world->restitutionThreshold; }
void  b2World_SetRestitutionThreshold( b2World* world, float value ) { world->restitutionThreshold = value; }

float b2World_GetHitEventThreshold( b2World* world )              { return world->hitEventThreshold; }
void  b2World_SetHitEventThreshold( b2World* world, float value ) { world->hitEventThreshold = value; }

float b2World_GetMaximumLinearSpeed( b2World* world )              { return world->maxLinearSpeed; }
void  b2World_SetMaximumLinearSpeed( b2World* world, float value ) { world->maxLinearSpeed = value; }

bool b2World_IsSleepingEnabled( b2World* world )  { return world->enableSleep; }
bool b2World_IsContinuousEnabled( b2World* world ) { return world->enableContinuous; }
bool b2World_IsWarmStartingEnabled( b2World* world ) { return world->enableWarmStarting; }

void b2World_EnableContinuous( b2World* world, bool flag )    { world->enableContinuous = flag; }
void b2World_EnableWarmStarting( b2World* world, bool flag )  { world->enableWarmStarting = flag; }

// Turning sleep OFF must wake every already-sleeping set, or those bodies would
// stay parked forever (nothing else would ever wake them). Forward iteration is
// safe: b2WakeSolverSet frees the set it wakes (leaving setIndex == B2_NULL_INDEX
// behind) but never creates a new sleeping set, and solverSets never shrinks here.
void b2World_EnableSleeping( b2World* world, bool flag )
{
    if( flag == world->enableSleep )
        return;

    world->enableSleep = flag;

    if( flag == false )
    {
        int setIndex;
        for( setIndex = b2_firstSleepingSet; setIndex < world->solverSets.count; ++setIndex )
        {
            if( world->solverSets.data[ setIndex ].setIndex != B2_NULL_INDEX )
                b2WakeSolverSet( world, setIndex );
        }
    }
}

void b2World_SetContactTuning( b2World* world, float hertz, float dampingRatio, float pushSpeed )
{
    world->contactHertz = hertz;
    world->contactDampingRatio = dampingRatio;
    world->contactSpeed = pushSpeed;
}

void  b2World_SetUserData( b2World* world, void* userData ) { world->userData = userData; }
void* b2World_GetUserData( b2World* world )                 { return world->userData; }

// Bodies actually being simulated this step (the awake set's dense sim count).
int b2World_GetAwakeBodyCount( b2World* world )
{
    return world->solverSets.data[ b2_awakeSet ].bodySims.count;
}


// -----------------------------------------------------------------------------
//   b2World_OverlapAABB  (public spatial query across all body-type trees)
// -----------------------------------------------------------------------------
//   Walk the three broad-phase trees with the user's callback and accumulate the
//   visit stats. `filter` may be NULL to see every shape.
//
//   DEVIATION: the callback uses the tree's raw signature (proxyId, shapeId, context)
//   rather than upstream's (b2ShapeId, context) -- b2ShapeId is multi-word and cannot
//   cross a function boundary by value, so the caller reconstructs it from shapeId +
//   world if needed. Filtering happens per leaf, not per node: b2DynamicTree_QueryAll
//   takes no maskBits, so whole-subtree pruning is unavailable here (correctness is
//   unaffected; only the node-visit count).
struct b2OverlapFilterContext
{
    b2World* world;
    b2QueryFilter* filter;
    bool( int, int, void* )* fcn;
    void* userContext;
};

bool b2OverlapFilterCallback( int proxyId, int shapeId, void* context )
{
    b2OverlapFilterContext* ctx = context;
    b2Shape* shape = &ctx->world->shapes.data[ shapeId ];

    if( b2ShouldQueryCollide( &shape->filter, ctx->filter ) == false )
        return true;   // filtered out -- keep visiting

    return ctx->fcn( proxyId, shapeId, ctx->userContext );
}

void b2World_OverlapAABB( b2World* world, b2AABB* aabb, b2QueryFilter* filter,
                          bool( int, int, void* )* fcn, void* context,
                          b2TreeStats* stats )
{
    stats->nodeVisits = 0;
    stats->leafVisits = 0;

    // No filter -> hand the user's callback straight to the tree, as before.
    bool( int, int, void* )* treeFcn = fcn;
    void* treeCtx = context;

    b2OverlapFilterContext fctx;
    if( filter != NULL )
    {
        fctx.world = world;
        fctx.filter = filter;
        fctx.fcn = fcn;
        fctx.userContext = context;
        treeFcn = &b2OverlapFilterCallback;
        treeCtx = &fctx;
    }

    int i;
    for( i = 0; i < b2_bodyTypeCount; ++i )
    {
        b2TreeStats st;
        b2DynamicTree_QueryAll( &world->broadPhase.trees[i], aabb, treeFcn, treeCtx, &st );
        stats->nodeVisits = stats->nodeVisits + st.nodeVisits;
        stats->leafVisits = stats->leafVisits + st.leafVisits;
    }
}


// -----------------------------------------------------------------------------
//   b2World_CastRayClosest  (public: closest shape hit of a ray, world space)
// -----------------------------------------------------------------------------
//   Casts origin->origin+translation through the three broad-phase trees and
//   returns the CLOSEST shape hit via the out-pointer (result->hit == false on a
//   miss), plus the hit shape's id (B2_NULL_INDEX on miss). The tree ray cast
//   prunes by AABB + shrinks to the nearest hit; the callback transforms the ray
//   into each candidate shape's local frame, runs the shape ray cast, and maps
//   the hit point/normal back to world. DEVIATIONS: query filtering deferred (hits
//   `filter` may be NULL to hit every shape); only the closest hit is returned (the
//   common game need: ground check, line of sight, aim/pick). A rigid transform
//   preserves the ray fraction, so the shape-local fraction is directly the world
//   fraction.
struct b2RayCastContext
{
    b2World* world;
    b2QueryFilter* filter;   // NULL == accept every shape
    b2CastOutput best;       // closest hit so far, WORLD space
    int bestShapeId;
};

float b2RayCastClosestCallback( b2RayCastInput* input, int proxyId, int shapeId, void* context )
{
    b2RayCastContext* ctx = context;
    b2World* world = ctx->world;
    b2Shape* shape = &world->shapes.data[ shapeId ];

    if( ctx->filter != NULL && b2ShouldQueryCollide( &shape->filter, ctx->filter ) == false )
        return input->maxFraction;   // filtered out -- keep the ray length

    b2Body* body = &world->bodies.data[ shape->bodyId ];
    b2BodySim* sim = b2GetBodySim( world, body );
    b2Transform* xf = &sim->transform;

    // transform the (world-space) ray into the shape's local frame
    b2RayCastInput localInput;
    b2InvTransformPoint( xf, &input->origin, &localInput.origin );
    b2InvRotateVector( &xf->q, &input->translation, &localInput.translation );
    localInput.maxFraction = input->maxFraction;

    b2CastOutput output;
    output.normal = b2Vec2_zero;  output.point = b2Vec2_zero;
    output.fraction = 0.0;  output.iterations = 0;  output.hit = false;

    if( shape->type == b2_circleShape )
        b2RayCastCircle( &shape->circle, &localInput, &output );
    else if( shape->type == b2_capsuleShape )
        b2RayCastCapsule( &shape->capsule, &localInput, &output );
    else if( shape->type == b2_polygonShape )
        b2RayCastPolygon( &shape->polygon, &localInput, &output );
    else if( shape->type == b2_segmentShape )
        b2RayCastSegment( &shape->segment, &localInput, false, &output );

    if( output.hit && output.fraction <= input->maxFraction )
    {
        ctx->best.fraction = output.fraction;
        b2TransformPoint( xf, &output.point, &ctx->best.point );     // hit -> world
        b2RotateVector( &xf->q, &output.normal, &ctx->best.normal ); // normal -> world
        ctx->best.hit = true;
        ctx->bestShapeId = shapeId;
        return output.fraction;   // shrink the ray to this hit
    }

    return input->maxFraction;    // no hit here -> keep the ray length
}

int b2World_CastRayClosest( b2World* world, b2Vec2* origin, b2Vec2* translation,
                            b2QueryFilter* filter, b2CastOutput* result )
{
    b2RayCastContext ctx;
    ctx.world = world;
    ctx.filter = filter;
    ctx.bestShapeId = B2_NULL_INDEX;
    ctx.best.normal = b2Vec2_zero;  ctx.best.point = b2Vec2_zero;
    ctx.best.fraction = 1.0;  ctx.best.iterations = 0;  ctx.best.hit = false;

    b2RayCastInput input;
    input.origin = *origin;
    input.translation = *translation;
    input.maxFraction = 1.0;

    // The tree ANDs maskBits against each node's category bits to prune subtrees.
    int maskBits = -1;
    if( filter != NULL )
        maskBits = filter->maskBits;

    int i;
    for( i = 0; i < b2_bodyTypeCount; ++i )
    {
        b2TreeStats st;
        b2DynamicTree_RayCast( &world->broadPhase.trees[i], &input, maskBits,
                               &b2RayCastClosestCallback, &ctx, &st );
        // carry the closest fraction into the next tree so it can prune further
        if( ctx.best.hit )
            input.maxFraction = ctx.best.fraction;
    }

    *result = ctx.best;
    if( ctx.best.hit == false )
        result->fraction = 0.0;
    return ctx.bestShapeId;
}


// -----------------------------------------------------------------------------
//   b2World_CastShapeClosest  (public: closest shape hit of a SWEPT SHAPE)
// -----------------------------------------------------------------------------
//   Sweeps `proxy` (a world-frame point cloud + radius) along `translation` through
//   the three broad-phase trees and returns the CLOSEST shape it hits, via the
//   out-pointer (result->hit == false on a miss) plus the hit shape's id
//   (B2_NULL_INDEX on miss). This is the thick-ray / "does the player fit through
//   that gap" query: b2World_CastRayClosest with a shape instead of a point.
//
//   The tree walk is conservative (it sweeps the proxy's AABB); each candidate is
//   then re-tested exactly with b2ShapeCastShape in the shape's local frame, and the
//   hit point/normal are mapped back to world. A rigid transform preserves the
//   translation's length, so the shape-local fraction IS the world fraction.
//
//   NOTE the fraction stops one B2_LINEAR_SLOP short of geometric contact -- see the
//   TARGET note on b2ShapeCast in b2_distance.h.
//
//   `filter` may be NULL to hit every shape. DEVIATIONS (as for the ray cast): only
//   the closest hit is returned, not an all-hits callback; sensors are not skipped.
struct b2ShapeCastContext
{
    b2World* world;
    b2QueryFilter* filter; // NULL == accept every shape
    b2ShapeProxy proxy;    // the moving shape, WORLD frame, at its start pose
    b2Vec2 translation;    // world-space sweep
    b2CastOutput best;     // closest hit so far, WORLD space
    int bestShapeId;
};

float b2ShapeCastClosestCallback( b2BoxCastInput* input, int proxyId, int shapeId, void* context )
{
    b2ShapeCastContext* ctx = context;
    b2World* world = ctx->world;
    b2Shape* shape = &world->shapes.data[ shapeId ];

    if( ctx->filter != NULL && b2ShouldQueryCollide( &shape->filter, ctx->filter ) == false )
        return input->maxFraction;   // filtered out -- keep the sweep length

    b2Body* body = &world->bodies.data[ shape->bodyId ];
    b2BodySim* sim = b2GetBodySim( world, body );
    b2Transform* xf = &sim->transform;

    // Rebuild the cast from the ORIGINAL world proxy and take only the advancing
    // maxFraction from the tree: the tree's box is a conservative bound, so its
    // fraction must never be mistaken for the exact one.
    b2ShapeCastInput castInput;
    castInput.proxy = ctx->proxy;
    castInput.translation = ctx->translation;
    castInput.maxFraction = input->maxFraction;
    castInput.canEncroach = false;

    b2CastOutput output;
    b2ShapeCastShape( &castInput, shape, xf, &output );

    if( output.hit && output.fraction <= input->maxFraction )
    {
        ctx->best.fraction = output.fraction;
        b2TransformPoint( xf, &output.point, &ctx->best.point );      // hit -> world
        b2RotateVector( &xf->q, &output.normal, &ctx->best.normal );  // normal -> world
        ctx->best.hit = true;
        ctx->bestShapeId = shapeId;
        return output.fraction;   // shrink the sweep (0 terminates the walk)
    }

    return input->maxFraction;    // no hit here -> keep the sweep length
}

int b2World_CastShapeClosest( b2World* world, b2ShapeProxy* proxy, b2Vec2* translation,
                              b2QueryFilter* filter, b2CastOutput* result )
{
    b2ShapeCastContext ctx;
    ctx.world = world;
    ctx.filter = filter;
    ctx.proxy = *proxy;
    ctx.translation = *translation;
    ctx.bestShapeId = B2_NULL_INDEX;
    ctx.best.normal = b2Vec2_zero;  ctx.best.point = b2Vec2_zero;
    ctx.best.fraction = 1.0;  ctx.best.iterations = 0;  ctx.best.hit = false;

    if( proxy->count <= 0 )
    {
        *result = ctx.best;
        result->fraction = 0.0;
        return B2_NULL_INDEX;
    }

    // conservative bound of the moving shape at its start pose (radius folded in)
    b2BoxCastInput input;
    b2Vec2 p0 = proxy->points[0];
    input.box.lowerBound = p0;
    input.box.upperBound = p0;
    int k;
    for( k = 1; k < proxy->count; ++k )
    {
        b2Vec2 p = proxy->points[k];
        input.box.lowerBound.x = fmin( input.box.lowerBound.x, p.x );
        input.box.lowerBound.y = fmin( input.box.lowerBound.y, p.y );
        input.box.upperBound.x = fmax( input.box.upperBound.x, p.x );
        input.box.upperBound.y = fmax( input.box.upperBound.y, p.y );
    }
    float rr = proxy->radius;
    input.box.lowerBound.x = input.box.lowerBound.x - rr;
    input.box.lowerBound.y = input.box.lowerBound.y - rr;
    input.box.upperBound.x = input.box.upperBound.x + rr;
    input.box.upperBound.y = input.box.upperBound.y + rr;

    input.translation = *translation;
    input.maxFraction = 1.0;

    // The tree ANDs maskBits against each node's category bits to prune subtrees.
    int maskBits = -1;
    if( filter != NULL )
        maskBits = filter->maskBits;

    int i;
    for( i = 0; i < b2_bodyTypeCount; ++i )
    {
        b2TreeStats st;
        b2DynamicTree_BoxCast( &world->broadPhase.trees[i], &input, maskBits,
                               &b2ShapeCastClosestCallback, &ctx, &st );

        // carry the closest fraction into the next tree so it can prune further
        if( ctx.best.hit )
        {
            if( ctx.best.fraction == 0.0 )
                break;                       // initial overlap: nothing can be closer
            input.maxFraction = ctx.best.fraction;
        }
    }

    *result = ctx.best;
    if( ctx.best.hit == false )
        result->fraction = 0.0;
    return ctx.bestShapeId;
}


// -----------------------------------------------------------------------------
//   b2World_GetBounds  (union AABB of everything in the broad phase)
// -----------------------------------------------------------------------------
//   Union of the three body-type trees' root bounds -- a camera/streaming bound of
//   the whole simulation. DEVIATION: this is the FAT-AABB union (the tree stores fat
//   AABBs), so it runs a touch larger than the tight geometry -- the same deviation
//   class as b2Shape_GetAABB. An empty world returns an inverted AABB (lower > upper),
//   so a caller can detect "nothing here" by lowerBound > upperBound.
void b2World_GetBounds( b2World* world, b2AABB* result )
{
    result->lowerBound.x = B2_HUGE;   result->lowerBound.y = B2_HUGE;
    result->upperBound.x = -B2_HUGE;  result->upperBound.y = -B2_HUGE;

    int i;
    for( i = 0; i < b2_bodyTypeCount; ++i )
    {
        b2DynamicTree* tree = &world->broadPhase.trees[i];
        if( tree->root == B2_NULL_INDEX )
            continue;                     // empty tree contributes nothing
        b2AABB* r = &tree->nodes[ tree->root ].aabb;
        result->lowerBound.x = fmin( result->lowerBound.x, r->lowerBound.x );
        result->lowerBound.y = fmin( result->lowerBound.y, r->lowerBound.y );
        result->upperBound.x = fmax( result->upperBound.x, r->upperBound.x );
        result->upperBound.y = fmax( result->upperBound.y, r->upperBound.y );
    }
}


// -----------------------------------------------------------------------------
//   b2World_CastRay / b2World_CastShape  (ALL-HITS callback forms)
// -----------------------------------------------------------------------------
//   The closest-hit forms above return one shape; these hand EVERY shape the ray or
//   swept proxy touches to the user's callback. The callback receives the raw shape
//   id + the WORLD-space b2CastOutput (point/normal/fraction) and returns the new
//   maxFraction to continue with: return the given fraction to keep clipping to the
//   closest, 1.0 to see all hits, or 0.0 to stop the walk (upstream's -1-to-skip is
//   just "return input maxFraction"). Faithful to upstream's RayCastCallback: an
//   in-[0,1] return narrows the sweep across the remaining trees too.
//
//   DEVIATION (as everywhere in the port's query surface): the callback takes a raw
//   int shape id + pointer args, not a by-value b2ShapeId / b2Vec2s. `filter` may be
//   NULL to hit every shape.
struct b2WorldCastContext
{
    b2World* world;
    b2QueryFilter* filter;                     // NULL == accept every shape
    float( int, b2CastOutput*, void* )* fcn;   // user callback
    void* userContext;
    b2ShapeProxy proxy;                        // shape cast only: moving shape, world frame
    b2Vec2 translation;                        // shape cast only: world sweep
    float fraction;                            // narrowest fraction returned so far
};

float b2WorldRayCastCallback( b2RayCastInput* input, int proxyId, int shapeId, void* context )
{
    b2WorldCastContext* ctx = context;
    b2World* world = ctx->world;
    b2Shape* shape = &world->shapes.data[ shapeId ];

    if( ctx->filter != NULL && b2ShouldQueryCollide( &shape->filter, ctx->filter ) == false )
        return input->maxFraction;

    b2Body* body = &world->bodies.data[ shape->bodyId ];
    b2BodySim* sim = b2GetBodySim( world, body );
    b2Transform* xf = &sim->transform;

    b2RayCastInput localInput;
    b2InvTransformPoint( xf, &input->origin, &localInput.origin );
    b2InvRotateVector( &xf->q, &input->translation, &localInput.translation );
    localInput.maxFraction = input->maxFraction;

    b2CastOutput output;
    output.normal = b2Vec2_zero;  output.point = b2Vec2_zero;
    output.fraction = 0.0;  output.iterations = 0;  output.hit = false;

    if( shape->type == b2_circleShape )
        b2RayCastCircle( &shape->circle, &localInput, &output );
    else if( shape->type == b2_capsuleShape )
        b2RayCastCapsule( &shape->capsule, &localInput, &output );
    else if( shape->type == b2_polygonShape )
        b2RayCastPolygon( &shape->polygon, &localInput, &output );
    else if( shape->type == b2_segmentShape )
        b2RayCastSegment( &shape->segment, &localInput, false, &output );

    if( output.hit )
    {
        b2CastOutput worldOut = output;
        b2TransformPoint( xf, &output.point, &worldOut.point );
        b2RotateVector( &xf->q, &output.normal, &worldOut.normal );

        float fraction = ctx->fcn( shapeId, &worldOut, ctx->userContext );
        if( 0.0 <= fraction && fraction <= 1.0 )
            ctx->fraction = fraction;
        return fraction;
    }

    return input->maxFraction;
}

void b2World_CastRay( b2World* world, b2Vec2* origin, b2Vec2* translation, b2QueryFilter* filter,
                      float( int, b2CastOutput*, void* )* fcn, void* context )
{
    b2WorldCastContext ctx;
    ctx.world = world;
    ctx.filter = filter;
    ctx.fcn = fcn;
    ctx.userContext = context;
    ctx.fraction = 1.0;

    b2RayCastInput input;
    input.origin = *origin;
    input.translation = *translation;
    input.maxFraction = 1.0;

    int maskBits = -1;
    if( filter != NULL )
        maskBits = filter->maskBits;

    int i;
    for( i = 0; i < b2_bodyTypeCount; ++i )
    {
        b2TreeStats st;
        b2DynamicTree_RayCast( &world->broadPhase.trees[i], &input, maskBits,
                               &b2WorldRayCastCallback, &ctx, &st );
        if( ctx.fraction == 0.0 )
            break;
        input.maxFraction = ctx.fraction;
    }
}

float b2WorldShapeCastCallback( b2BoxCastInput* input, int proxyId, int shapeId, void* context )
{
    b2WorldCastContext* ctx = context;
    b2World* world = ctx->world;
    b2Shape* shape = &world->shapes.data[ shapeId ];

    if( ctx->filter != NULL && b2ShouldQueryCollide( &shape->filter, ctx->filter ) == false )
        return input->maxFraction;

    b2Body* body = &world->bodies.data[ shape->bodyId ];
    b2BodySim* sim = b2GetBodySim( world, body );
    b2Transform* xf = &sim->transform;

    b2ShapeCastInput castInput;
    castInput.proxy = ctx->proxy;
    castInput.translation = ctx->translation;
    castInput.maxFraction = input->maxFraction;
    castInput.canEncroach = false;

    b2CastOutput output;
    b2ShapeCastShape( &castInput, shape, xf, &output );

    if( output.hit )
    {
        b2CastOutput worldOut = output;
        b2TransformPoint( xf, &output.point, &worldOut.point );
        b2RotateVector( &xf->q, &output.normal, &worldOut.normal );

        float fraction = ctx->fcn( shapeId, &worldOut, ctx->userContext );
        if( 0.0 <= fraction && fraction <= 1.0 )
            ctx->fraction = fraction;
        return fraction;
    }

    return input->maxFraction;
}

void b2World_CastShape( b2World* world, b2ShapeProxy* proxy, b2Vec2* translation, b2QueryFilter* filter,
                        float( int, b2CastOutput*, void* )* fcn, void* context )
{
    b2WorldCastContext ctx;
    ctx.world = world;
    ctx.filter = filter;
    ctx.fcn = fcn;
    ctx.userContext = context;
    ctx.proxy = *proxy;
    ctx.translation = *translation;
    ctx.fraction = 1.0;

    if( proxy->count <= 0 )
        return;

    // conservative bound of the moving shape at its start pose (radius folded in)
    b2BoxCastInput input;
    b2Vec2 p0 = proxy->points[0];
    input.box.lowerBound = p0;
    input.box.upperBound = p0;
    int k;
    for( k = 1; k < proxy->count; ++k )
    {
        b2Vec2 p = proxy->points[k];
        input.box.lowerBound.x = fmin( input.box.lowerBound.x, p.x );
        input.box.lowerBound.y = fmin( input.box.lowerBound.y, p.y );
        input.box.upperBound.x = fmax( input.box.upperBound.x, p.x );
        input.box.upperBound.y = fmax( input.box.upperBound.y, p.y );
    }
    float rr = proxy->radius;
    input.box.lowerBound.x = input.box.lowerBound.x - rr;
    input.box.lowerBound.y = input.box.lowerBound.y - rr;
    input.box.upperBound.x = input.box.upperBound.x + rr;
    input.box.upperBound.y = input.box.upperBound.y + rr;
    input.translation = *translation;
    input.maxFraction = 1.0;

    int maskBits = -1;
    if( filter != NULL )
        maskBits = filter->maskBits;

    int i;
    for( i = 0; i < b2_bodyTypeCount; ++i )
    {
        b2TreeStats st;
        b2DynamicTree_BoxCast( &world->broadPhase.trees[i], &input, maskBits,
                               &b2WorldShapeCastCallback, &ctx, &st );
        if( ctx.fraction == 0.0 )
            break;
        input.maxFraction = ctx.fraction;
    }
}


// -----------------------------------------------------------------------------
//   b2World_OverlapShape  (report every shape overlapping a proxy)
// -----------------------------------------------------------------------------
//   Hands the user's callback every shape whose geometry actually overlaps `proxy`
//   (a WORLD-frame point cloud + radius). The broad phase pre-filters by AABB, then
//   b2ShapeDistance confirms a true overlap (GJK distance within 0.1*B2_LINEAR_SLOP).
//   The callback returns false to stop early. `filter` may be NULL to see everything.
//   DEVIATION: raw int shape id (not b2ShapeId); proxy is world-frame (the port has
//   no separate origin argument -- see b2World_CastShapeClosest).
struct b2WorldOverlapContext
{
    b2World* world;
    b2QueryFilter* filter;             // NULL == accept every shape
    b2ShapeProxy* proxy;               // the query shape, WORLD frame
    bool( int, void* )* fcn;           // user callback (false stops the walk)
    void* userContext;
    bool stopped;
};

bool b2WorldOverlapCallback( int proxyId, int shapeId, void* context )
{
    b2WorldOverlapContext* ctx = context;
    b2World* world = ctx->world;
    b2Shape* shape = &world->shapes.data[ shapeId ];

    if( ctx->filter != NULL && b2ShouldQueryCollide( &shape->filter, ctx->filter ) == false )
        return true;

    b2Body* body = &world->bodies.data[ shape->bodyId ];
    b2BodySim* sim = b2GetBodySim( world, body );

    b2DistanceInput input;
    input.proxyA = *ctx->proxy;                 // world frame
    b2MakeShapeProxy( shape, &input.proxyB );   // shape local
    input.transform = sim->transform;           // shape local -> world
    input.useRadii = true;

    b2SimplexCache cache;  cache.count = 0;
    b2DistanceOutput output;
    b2ShapeDistance( &input, &cache, &output );

    float tolerance = 0.1 * B2_LINEAR_SLOP;
    if( output.distance > tolerance )
        return true;                            // not actually overlapping

    bool keepGoing = ctx->fcn( shapeId, ctx->userContext );
    if( keepGoing == false )
        ctx->stopped = true;
    return keepGoing;
}

void b2World_OverlapShape( b2World* world, b2ShapeProxy* proxy, b2QueryFilter* filter,
                           bool( int, void* )* fcn, void* context )
{
    if( proxy->count <= 0 )
        return;

    // world-frame AABB of the query proxy (radius folded in)
    b2AABB aabb;
    b2Vec2 p0 = proxy->points[0];
    aabb.lowerBound = p0;
    aabb.upperBound = p0;
    int k;
    for( k = 1; k < proxy->count; ++k )
    {
        b2Vec2 p = proxy->points[k];
        aabb.lowerBound.x = fmin( aabb.lowerBound.x, p.x );
        aabb.lowerBound.y = fmin( aabb.lowerBound.y, p.y );
        aabb.upperBound.x = fmax( aabb.upperBound.x, p.x );
        aabb.upperBound.y = fmax( aabb.upperBound.y, p.y );
    }
    float rr = proxy->radius;
    aabb.lowerBound.x = aabb.lowerBound.x - rr;
    aabb.lowerBound.y = aabb.lowerBound.y - rr;
    aabb.upperBound.x = aabb.upperBound.x + rr;
    aabb.upperBound.y = aabb.upperBound.y + rr;

    b2WorldOverlapContext ctx;
    ctx.world = world;
    ctx.filter = filter;
    ctx.proxy = proxy;
    ctx.fcn = fcn;
    ctx.userContext = context;
    ctx.stopped = false;

    int i;
    for( i = 0; i < b2_bodyTypeCount; ++i )
    {
        if( ctx.stopped )
            break;
        b2TreeStats st;
        b2DynamicTree_QueryAll( &world->broadPhase.trees[i], &aabb,
                                &b2WorldOverlapCallback, &ctx, &st );
    }
}


// -----------------------------------------------------------------------------
//   b2World_Explode  (radial impulse over an area)
// -----------------------------------------------------------------------------
//   Applies an outward impulse to every DYNAMIC shape within radius+falloff of the
//   blast center, scaled by the shape's silhouette facing the blast and a linear
//   falloff past `radius`. impulsePerLength may be negative for an implosion. Faithful
//   to upstream's ExplosionCallback; runs against the dynamic tree only. NOTE waking a
//   body during the tree query only migrates solver sets -- it does not touch the tree
//   node pool being walked -- so the iteration is safe (the woken body's fresh state is
//   refetched after the wake, as upstream does).
struct b2ExplosionDef
{
    int maskBits;             // filter categories the blast affects (-1 == all)
    b2Vec2 position;          // blast center, world space
    float radius;             // full-impulse radius
    float falloff;            // distance past radius over which impulse ramps to zero
    float impulsePerLength;   // impulse per unit of facing silhouette (negative = implode)
};

void b2DefaultExplosionDef( b2ExplosionDef* def )
{
    def->maskBits = -1;
    def->position = b2Vec2_zero;
    def->radius = 0.0;
    def->falloff = 0.0;
    def->impulsePerLength = 0.0;
}

struct b2ExplosionContext
{
    b2World* world;
    b2Vec2 position;
    float radius;
    float falloff;
    float impulsePerLength;
};

bool b2ExplosionCallback( int proxyId, int shapeId, void* context )
{
    b2ExplosionContext* ctx = context;
    b2World* world = ctx->world;
    b2Shape* shape = &world->shapes.data[ shapeId ];
    b2Body* body = &world->bodies.data[ shape->bodyId ];

    b2WorldTransform xf;
    b2GetBodyTransform( world, shape->bodyId, &xf );

    // blast center in the shape's local frame (distance/direction stay precise)
    b2Vec2 localPosition;
    b2InvTransformPoint( &xf, &ctx->position, &localPosition );

    b2DistanceInput input;
    b2MakeShapeProxy( shape, &input.proxyA );
    b2MakeProxy( &localPosition, 1, 0.0, &input.proxyB );
    input.transform = b2Transform_identity;
    input.useRadii = true;

    b2SimplexCache cache;  cache.count = 0;
    b2DistanceOutput output;
    b2ShapeDistance( &input, &cache, &output );

    if( output.distance > ctx->radius + ctx->falloff )
        return true;               // out of range -- keep querying

    b2WakeBody( world, body );
    if( body->setIndex != b2_awakeSet )
        return true;               // couldn't wake (shouldn't happen for dynamic)

    b2Vec2 closestPoint = output.pointA;
    if( output.distance == 0.0 )
        b2GetShapeCentroid( shape, &closestPoint );

    b2Vec2 direction;
    b2Sub( &closestPoint, &localPosition, &direction );
    float tiny = B2_LINEAR_SLOP * B2_LINEAR_SLOP;   // coincident-point guard (runtime, no underflow)
    if( b2LengthSquared( &direction ) > tiny )
    {
        b2Vec2 n;  b2Normalize( &direction, &n );  direction = n;
    }
    else
    {
        direction.x = 1.0;  direction.y = 0.0;
    }

    b2Vec2 localLine;  b2LeftPerp( &direction, &localLine );
    float perimeter = b2GetShapeProjectedPerimeter( shape, &localLine );

    float scale = 1.0;
    if( output.distance > ctx->radius && ctx->falloff > 0.0 )
        scale = b2ClampFloat( ( ctx->radius + ctx->falloff - output.distance ) / ctx->falloff, 0.0, 1.0 );

    float magnitude = ctx->impulsePerLength * perimeter * scale;
    b2Vec2 worldDir;  b2RotateVector( &xf.q, &direction, &worldDir );
    b2Vec2 impulse;   b2MulSV( magnitude, &worldDir, &impulse );

    b2BodySim* bodySim = b2GetBodySim( world, body );
    b2BodyState* state = b2GetBodyState( world, body );

    // v += invMass * impulse
    state->linearVelocity.x = state->linearVelocity.x + bodySim->invMass * impulse.x;
    state->linearVelocity.y = state->linearVelocity.y + bodySim->invMass * impulse.y;

    // w += invInertia * cross(r, impulse), r = closestPoint - localCenter, rotated to world
    b2Vec2 rLocal;  b2Sub( &closestPoint, &bodySim->localCenter, &rLocal );
    b2Vec2 r;       b2RotateVector( &xf.q, &rLocal, &r );
    state->angularVelocity = state->angularVelocity + bodySim->invInertia * b2Cross( &r, &impulse );

    return true;
}

void b2World_Explode( b2World* world, b2ExplosionDef* def )
{
    b2ExplosionContext ctx;
    ctx.world = world;
    ctx.position = def->position;
    ctx.radius = def->radius;
    ctx.falloff = def->falloff;
    ctx.impulsePerLength = def->impulsePerLength;

    // query box: the blast extent, centered on the blast position
    float extent = def->radius + def->falloff;
    b2AABB aabb;
    aabb.lowerBound.x = def->position.x - extent;
    aabb.lowerBound.y = def->position.y - extent;
    aabb.upperBound.x = def->position.x + extent;
    aabb.upperBound.y = def->position.y + extent;

    // dynamic bodies only (upstream queries just the dynamic tree)
    b2TreeStats st;
    b2DynamicTree_QueryAll( &world->broadPhase.trees[ b2_dynamicBody ], &aabb,
                            &b2ExplosionCallback, &ctx, &st );
}


// -----------------------------------------------------------------------------
//   Mover (character controller) world queries
// -----------------------------------------------------------------------------
//   b2World_CollideMover gathers the collision planes around a capsule mover;
//   b2World_CastMover sweeps it and returns the first fraction it may travel.
//   Feed the planes to b2SolvePlanes / b2ClipVector (port/b2_mover.h).
//
//   `filter` may be NULL to see every shape.
//
//   PORT DEVIATIONS: upstream carries an `origin` for large-world precision, but
//   b2Pos == b2Vec2 here (single precision), so the origin collapses and the mover
//   is simply given in WORLD coordinates -- matching the port's other world queries.
//   The callback takes an int shapeId rather than a multi-word b2ShapeId. Sensors
//   are not skipped.

struct b2MoverContext
{
    b2World* world;
    b2QueryFilter* filter;                        // NULL == accept every shape
    b2Capsule mover;                              // WORLD frame
    bool( int, b2PlaneResult*, void* )* fcn;
    void* userContext;
};

bool b2MoverCollideCallback( int proxyId, int shapeId, void* context )
{
    b2MoverContext* ctx = context;
    b2World* world = ctx->world;
    b2Shape* shape = &world->shapes.data[ shapeId ];

    if( ctx->filter != NULL && b2ShouldQueryCollide( &shape->filter, ctx->filter ) == false )
        return true;   // filtered out -- keep visiting

    b2Body* body = &world->bodies.data[ shape->bodyId ];
    b2BodySim* sim = b2GetBodySim( world, body );

    b2PlaneResult result;
    b2CollideMover( &ctx->mover, shape, &sim->transform, &result );

    // DEEP-OVERLAP GUARD (upstream keeps this in the callback, not in the collide
    // functions): b2CollideMoverAnd* reports a hit whenever distance <= totalRadius,
    // including distance == 0, where GJK's normal degenerates to the zero vector.
    // Passing that plane to b2SolvePlanes would push the mover in a garbage direction.
    if( result.hit && b2IsNormalized( &result.plane.normal ) )
        return ctx->fcn( shapeId, &result, ctx->userContext );

    return true;
}

void b2World_CollideMover( b2World* world, b2Capsule* mover, b2QueryFilter* filter,
                           bool( int, b2PlaneResult*, void* )* fcn, void* context )
{
    b2MoverContext ctx;
    ctx.world = world;
    ctx.filter = filter;
    ctx.mover = *mover;
    ctx.fcn = fcn;
    ctx.userContext = context;

    float r = mover->radius;
    b2AABB aabb;
    aabb.lowerBound.x = fmin( mover->center1.x, mover->center2.x ) - r;
    aabb.lowerBound.y = fmin( mover->center1.y, mover->center2.y ) - r;
    aabb.upperBound.x = fmax( mover->center1.x, mover->center2.x ) + r;
    aabb.upperBound.y = fmax( mover->center1.y, mover->center2.y ) + r;

    int i;
    for( i = 0; i < b2_bodyTypeCount; ++i )
    {
        b2TreeStats st;
        b2DynamicTree_QueryAll( &world->broadPhase.trees[i], &aabb,
                                &b2MoverCollideCallback, &ctx, &st );
    }
}

// -----------------------------------------------------------------------------

struct b2MoverCastContext
{
    b2World* world;
    b2QueryFilter* filter;    // NULL == accept every shape
    b2ShapeCastInput input;   // the mover as a swept proxy, WORLD frame
    float fraction;           // closest fraction so far
};

float b2MoverCastCallback( b2BoxCastInput* input, int proxyId, int shapeId, void* context )
{
    b2MoverCastContext* ctx = context;
    b2World* world = ctx->world;
    b2Shape* shape = &world->shapes.data[ shapeId ];

    if( ctx->filter != NULL && b2ShouldQueryCollide( &shape->filter, ctx->filter ) == false )
        return ctx->fraction;   // filtered out -- keep the sweep as it stands

    b2Body* body = &world->bodies.data[ shape->bodyId ];
    b2BodySim* sim = b2GetBodySim( world, body );

    // rebuild from the original world proxy; take only the advancing fraction from
    // the tree (whose box is conservative)
    b2ShapeCastInput localInput = ctx->input;
    localInput.maxFraction = input->maxFraction;

    b2CastOutput output;
    b2ShapeCastShape( &localInput, shape, &sim->transform, &output );

    // fraction 0 means either a miss (b2ShapeCastShape zeroes it) or an initial
    // overlap; upstream ignores both, so a mover already touching a wall can still
    // slide along it rather than being pinned at fraction 0.
    if( output.fraction == 0.0 )
        return ctx->fraction;

    ctx->fraction = output.fraction;
    return output.fraction;
}

// Sweep the mover along `translation` and return the fraction of it that is free
// (1.0 if nothing is in the way). Shapes the mover already overlaps are ignored.
float b2World_CastMover( b2World* world, b2Capsule* mover, b2Vec2* translation,
                         b2QueryFilter* filter )
{
    b2MoverCastContext ctx;
    ctx.world = world;
    ctx.filter = filter;
    ctx.fraction = 1.0;
    ctx.input.proxy.points[0] = mover->center1;
    ctx.input.proxy.points[1] = mover->center2;
    ctx.input.proxy.count = 2;
    ctx.input.proxy.radius = mover->radius;
    ctx.input.translation = *translation;
    ctx.input.maxFraction = 1.0;
    ctx.input.canEncroach = true;

    float r = mover->radius;
    b2BoxCastInput treeInput;
    treeInput.box.lowerBound.x = fmin( mover->center1.x, mover->center2.x ) - r;
    treeInput.box.lowerBound.y = fmin( mover->center1.y, mover->center2.y ) - r;
    treeInput.box.upperBound.x = fmax( mover->center1.x, mover->center2.x ) + r;
    treeInput.box.upperBound.y = fmax( mover->center1.y, mover->center2.y ) + r;
    treeInput.translation = *translation;
    treeInput.maxFraction = 1.0;

    int maskBits = -1;
    if( filter != NULL )
        maskBits = filter->maskBits;

    int i;
    for( i = 0; i < b2_bodyTypeCount; ++i )
    {
        b2TreeStats st;
        b2DynamicTree_BoxCast( &world->broadPhase.trees[i], &treeInput, maskBits,
                               &b2MoverCastCallback, &ctx, &st );

        if( ctx.fraction == 0.0 )
            break;

        treeInput.maxFraction = ctx.fraction;
    }

    return ctx.fraction;
}


// -----------------------------------------------------------------------------
//   Contacts: create / destroy connectivity, and the broad-phase pairing pass
// -----------------------------------------------------------------------------
//   SLICE 1 = connectivity only. b2CreateContact records the cold b2Contact,
//   links it into both bodies' contact-edge lists, and registers the shape pair
//   in the broad-phase pairSet. The b2ContactSim (manifold / friction / solver
//   set) is DEFERRED, so contact->localIndex stays B2_NULL_INDEX.
void b2CreateContact( b2World* world, b2Shape* shapeA, b2Shape* shapeB )
{
    if( b2CanCollide( shapeA->type, shapeB->type ) == false )
        return;

    // Store shapes in PRIMARY type order so the narrow-phase dispatch
    // (b2ComputeManifold) always receives the pair it expects, with no flip.
    if( b2IsPrimaryOrder( shapeA->type, shapeB->type ) == false )
    {
        b2Shape* tmp = shapeA;  shapeA = shapeB;  shapeB = tmp;
    }

    b2Body* bodyA = &world->bodies.data[ shapeA->bodyId ];
    b2Body* bodyB = &world->bodies.data[ shapeB->bodyId ];

    int setIndex;
    if( bodyA->setIndex == b2_awakeSet || bodyB->setIndex == b2_awakeSet )
        setIndex = b2_awakeSet;
    else
        setIndex = b2_disabledSet;

    b2SolverSet* set = &world->solverSets.data[ setIndex ];

    int contactId = b2AllocId( &world->contactIdPool );
    if( contactId == world->contacts.count )
    {
        world->contacts.data = b2GrowArray( world->contacts.data, &world->contacts.capacity,
                                            world->contacts.count + 1, sizeof( b2Contact ) );
        memset( &world->contacts.data[ contactId ], 0, sizeof( b2Contact ) );
        world->contacts.count = world->contacts.count + 1;
    }

    int shapeIdA = shapeA->id;
    int shapeIdB = shapeB->id;

    b2Contact* contact = &world->contacts.data[ contactId ];
    contact->contactId = contactId;
    contact->generation = contact->generation + 1;
    contact->setIndex = setIndex;
    contact->colorIndex = B2_NULL_INDEX;
    contact->localIndex = set->contactSims.count;   // slot the sim lands in below
    contact->islandId = B2_NULL_INDEX;
    contact->islandIndex = B2_NULL_INDEX;
    contact->shapeIdA = shapeIdA;
    contact->shapeIdB = shapeIdB;
    contact->flags = 0;
    if( ( bodyA->flags & b2_bodyEnableContactRecycling ) != 0 &&
        ( bodyB->flags & b2_bodyEnableContactRecycling ) != 0 )
        contact->flags = contact->flags | b2_contactRecycleFlag;

    // connect to body A (edge 0)
    contact->edges[0].bodyId = shapeA->bodyId;
    contact->edges[0].prevKey = B2_NULL_INDEX;
    contact->edges[0].nextKey = bodyA->headContactKey;
    int keyA = ( contactId << 1 ) | 0;
    if( bodyA->headContactKey != B2_NULL_INDEX )
    {
        b2Contact* headContact = &world->contacts.data[ bodyA->headContactKey >> 1 ];
        b2ContactEdgeAt( headContact, bodyA->headContactKey & 1 )->prevKey = keyA;
    }
    bodyA->headContactKey = keyA;
    bodyA->contactCount = bodyA->contactCount + 1;

    // connect to body B (edge 1)
    contact->edges[1].bodyId = shapeB->bodyId;
    contact->edges[1].prevKey = B2_NULL_INDEX;
    contact->edges[1].nextKey = bodyB->headContactKey;
    int keyB = ( contactId << 1 ) | 1;
    if( bodyB->headContactKey != B2_NULL_INDEX )
    {
        b2Contact* headContact = &world->contacts.data[ bodyB->headContactKey >> 1 ];
        b2ContactEdgeAt( headContact, bodyB->headContactKey & 1 )->prevKey = keyB;
    }
    bodyB->headContactKey = keyB;
    bodyB->contactCount = bodyB->contactCount + 1;

    // register in the pair set for fast dedup
    b2AddKey( &world->broadPhase.pairSet, shapeIdA, shapeIdB );

    // emplace a zeroed b2ContactSim into the solver set. Contacts are created
    // non-touching; the narrow phase (b2UpdateContact) fills in the manifold.
    set->contactSims.data = b2GrowArray( set->contactSims.data, &set->contactSims.capacity,
                                         set->contactSims.count + 1, sizeof( b2ContactSim ) );
    b2ContactSim* contactSim = &set->contactSims.data[ set->contactSims.count ];
    set->contactSims.count = set->contactSims.count + 1;
    memset( contactSim, 0, sizeof( b2ContactSim ) );
    contactSim->contactId = contactId;
    contactSim->bodySimIndexA = B2_NULL_INDEX;
    contactSim->bodySimIndexB = B2_NULL_INDEX;
    contactSim->shapeIdA = shapeIdA;
    contactSim->shapeIdB = shapeIdB;
    contactSim->cache.count = 0;
    contactSim->simFlags = contact->flags;
}

void b2DestroyContact( b2World* world, b2Contact* contact, bool wakeBodies )
{
    int contactId = contact->contactId;
    bool touching = ( contact->flags & b2_contactTouchingFlag ) != 0;

    // unlink from the island graph if it was linked (i.e. it was touching)
    if( contact->islandId != B2_NULL_INDEX )
        b2UnlinkContact( world, contact );

    // remove the pair from the set
    b2RemoveKey( &world->broadPhase.pairSet, contact->shapeIdA, contact->shapeIdB );

    // unlink edge 0 from body A's list
    b2ContactEdge* edgeA = &contact->edges[0];
    b2Body* bodyA = &world->bodies.data[ edgeA->bodyId ];
    if( edgeA->prevKey != B2_NULL_INDEX )
    {
        b2Contact* prev = &world->contacts.data[ edgeA->prevKey >> 1 ];
        b2ContactEdgeAt( prev, edgeA->prevKey & 1 )->nextKey = edgeA->nextKey;
    }
    if( edgeA->nextKey != B2_NULL_INDEX )
    {
        b2Contact* next = &world->contacts.data[ edgeA->nextKey >> 1 ];
        b2ContactEdgeAt( next, edgeA->nextKey & 1 )->prevKey = edgeA->prevKey;
    }
    if( bodyA->headContactKey == ( ( contactId << 1 ) | 0 ) )
        bodyA->headContactKey = edgeA->nextKey;
    bodyA->contactCount = bodyA->contactCount - 1;

    // unlink edge 1 from body B's list
    b2ContactEdge* edgeB = &contact->edges[1];
    b2Body* bodyB = &world->bodies.data[ edgeB->bodyId ];
    if( edgeB->prevKey != B2_NULL_INDEX )
    {
        b2Contact* prev = &world->contacts.data[ edgeB->prevKey >> 1 ];
        b2ContactEdgeAt( prev, edgeB->prevKey & 1 )->nextKey = edgeB->nextKey;
    }
    if( edgeB->nextKey != B2_NULL_INDEX )
    {
        b2Contact* next = &world->contacts.data[ edgeB->nextKey >> 1 ];
        b2ContactEdgeAt( next, edgeB->nextKey & 1 )->prevKey = edgeB->prevKey;
    }
    if( bodyB->headContactKey == ( ( contactId << 1 ) | 1 ) )
        bodyB->headContactKey = edgeB->nextKey;
    bodyB->contactCount = bodyB->contactCount - 1;

    // remove the contactSim from its solver set: swap the LAST sim into the freed
    // slot, then repair the MOVED contact's localIndex (same pattern as
    // b2RemoveBodySim). colorIndex is always NULL here (no constraint graph yet),
    // so the contact always lives in set->contactSims (never the color array).
    b2SolverSet* set = &world->solverSets.data[ contact->setIndex ];
    int localIndex = contact->localIndex;
    int lastIndex = set->contactSims.count - 1;
    if( localIndex != lastIndex )
    {
        set->contactSims.data[ localIndex ] = set->contactSims.data[ lastIndex ];
        b2ContactSim* movedSim = &set->contactSims.data[ localIndex ];
        b2Contact* movedContact = &world->contacts.data[ movedSim->contactId ];
        movedContact->localIndex = localIndex;
    }
    set->contactSims.count = set->contactSims.count - 1;

    // free the contact id
    b2FreeId( &world->contactIdPool, contactId );
    contact->contactId = B2_NULL_INDEX;
    contact->setIndex = B2_NULL_INDEX;
    contact->localIndex = B2_NULL_INDEX;
    contact->colorIndex = B2_NULL_INDEX;

    // wake the endpoints LAST, after the contact is fully removed (upstream
    // contact.c order): a wake migrates whole sleeping sets and must not see the
    // half-unlinked contact. Only a TOUCHING contact wakes -- losing a resting
    // support must re-run the survivors' manifolds (else a sleeping pile floats
    // in mid-air forever: both-non-awake pairs are skipped in b2Collide).
    if( wakeBodies && touching )
    {
        b2WakeBody( world, bodyA );
        b2WakeBody( world, bodyB );
    }
}

// Fetch the b2ContactSim for a contact. With no constraint graph yet, a contact
// always lives in its solver set's contactSims array (the color-graph branch of
// upstream b2GetContactSim is dropped).
b2ContactSim* b2GetContactSim( b2World* world, b2Contact* contact )
{
    b2SolverSet* set = &world->solverSets.data[ contact->setIndex ];
    return &set->contactSims.data[ contact->localIndex ];
}

// Mint a generation-checked contact handle from a raw contact id (mirrors
// b2MakeShapeId). Used by the enumeration path to tag each b2ContactData.
void b2MakeContactId( b2World* world, int contactId, b2ContactId* result )
{
    b2Contact* contact = &world->contacts.data[ contactId ];
    result->index1 = contactId + 1;
    result->world0 = world->worldId;
    result->generation = contact->generation;
}

// True iff the handle still refers to the live contact it was minted for. Mirrors
// b2Shape_IsValid: bounds BEFORE the deref (index1 == 0 would read data[-1], since
// NULL == -1), then the freed-slot marker (contactId == B2_NULL_INDEX), then the
// generation. A contact separating between steps flips it invalid -- the expected,
// common case (see the b2ContactId note in b2_contact.h).
bool b2Contact_IsValid( b2World* world, b2ContactId* id )
{
    if( id->world0 != world->worldId )                          return false;
    if( id->index1 <= 0 || id->index1 > world->contacts.count ) return false;
    b2Contact* contact = &world->contacts.data[ id->index1 - 1 ];
    if( contact->contactId == B2_NULL_INDEX )                   return false;   // freed slot
    if( contact->generation != id->generation )                return false;   // slot reused
    return true;
}


// -----------------------------------------------------------------------------
//   Contact enumeration (b2Body_GetContactData / b2Shape_GetContactData)
// -----------------------------------------------------------------------------
//   Walk a body's contact-edge list and copy each TOUCHING contact into the caller's
//   b2ContactData array (up to `capacity`), returning how many were written. The
//   current world-space manifold comes off the contact's sim. Uses b2ContactEdgeAt
//   for the variable-index edge (fixed-array-member trap). DEVIATION: raw int shape
//   ids + no b2ContactId (see b2ContactData).

int b2Body_GetContactData( b2World* world, b2BodyId* bodyId, b2ContactData* data, int capacity )
{
    b2Body* body = b2GetBodyFullId( world, bodyId );

    int index = 0;
    int contactKey = body->headContactKey;
    while( contactKey != B2_NULL_INDEX && index < capacity )
    {
        int contactId = contactKey >> 1;
        int edgeIndex = contactKey & 1;
        b2Contact* contact = &world->contacts.data[ contactId ];
        contactKey = b2ContactEdgeAt( contact, edgeIndex )->nextKey;

        if( ( contact->flags & b2_contactTouchingFlag ) != 0 )
        {
            b2ContactSim* sim = b2GetContactSim( world, contact );
            b2MakeContactId( world, contactId, &data[ index ].contactId );
            data[ index ].shapeIdA = contact->shapeIdA;
            data[ index ].shapeIdB = contact->shapeIdB;
            data[ index ].manifold = sim->manifold;
            index = index + 1;
        }
    }
    return index;
}

// As above, but only contacts that involve THIS shape (either side).
int b2Shape_GetContactData( b2World* world, b2ShapeId* shapeId, b2ContactData* data, int capacity )
{
    b2Shape* shape = b2GetShape( world, shapeId );
    int sid = shape->id;
    b2Body* body = &world->bodies.data[ shape->bodyId ];

    int index = 0;
    int contactKey = body->headContactKey;
    while( contactKey != B2_NULL_INDEX && index < capacity )
    {
        int contactId = contactKey >> 1;
        int edgeIndex = contactKey & 1;
        b2Contact* contact = &world->contacts.data[ contactId ];
        contactKey = b2ContactEdgeAt( contact, edgeIndex )->nextKey;

        bool involvesShape = ( contact->shapeIdA == sid || contact->shapeIdB == sid );
        if( involvesShape && ( contact->flags & b2_contactTouchingFlag ) != 0 )
        {
            b2ContactSim* sim = b2GetContactSim( world, contact );
            b2MakeContactId( world, contactId, &data[ index ].contactId );
            data[ index ].shapeIdA = contact->shapeIdA;
            data[ index ].shapeIdB = contact->shapeIdB;
            data[ index ].manifold = sim->manifold;
            index = index + 1;
        }
    }
    return index;
}

// Resolve a contact handle to a fresh b2ContactData snapshot. Returns false (and
// leaves *result untouched) if the handle is stale -- ALWAYS check the return value,
// since a contact commonly separates between the step that handed you the id and the
// step you use it. Mirrors upstream b2Contact_GetData.
bool b2Contact_GetData( b2World* world, b2ContactId* id, b2ContactData* result )
{
    if( b2Contact_IsValid( world, id ) == false )
        return false;

    b2Contact* contact = &world->contacts.data[ id->index1 - 1 ];
    b2ContactSim* sim = b2GetContactSim( world, contact );
    result->contactId = *id;
    result->shapeIdA = contact->shapeIdA;
    result->shapeIdB = contact->shapeIdB;
    result->manifold = sim->manifold;
    return true;
}


// -----------------------------------------------------------------------------
//   Joints: create / destroy connectivity (SLICE 1)
// -----------------------------------------------------------------------------
//   Mirrors b2CreateContact / b2DestroyContact: a cold b2Joint (sparse, indexed
//   by joint id) linked into both bodies' joint-edge lists, plus a dense
//   b2JointSim emplaced in the owning solver set. Set selection is the port's
//   simplified 3-set model (no sleeping sets, no constraint graph):
//     - either body disabled            -> disabled set
//     - neither body dynamic            -> static set
//     - otherwise                       -> awake set
//   Sleeping endpoints are WOKEN at create (F4; upstream instead places into
//   sleeping sets + merges them). DEFERRED (vs upstream b2CreateJoint):
//   constraint-graph placement, validation. The prepare/warm-start/solve math
//   is slice 2 (b2_solver.h).

// Fetch the b2JointSim for a cold joint (always in its set's jointSims array --
// no constraint graph yet, so upstream's color-array branch is dropped).
b2JointSim* b2GetJointSim( b2World* world, b2Joint* joint )
{
    b2SolverSet* set = &world->solverSets.data[ joint->setIndex ];
    return &set->jointSims.data[ joint->localIndex ];
}

// Destroy every contact between bodyA and bodyB. Called when a joint is created
// with collideConnected==false (upstream joint.c b2DestroyContactsBetweenBodies).
// Walks body A's contact-edge list; the far endpoint is read with the constant-
// index-safe b2ContactEdgeAt (edges[] is a fixed array member -- a variable index
// would miscompile). This is HALF of collideConnected enforcement: it removes the
// contacts that already exist at joint-creation time; b2ShouldBodiesCollide (below)
// stops the broad phase from re-creating them each step.
void b2DestroyContactsBetweenBodies( b2World* world, int bodyIdA, int bodyIdB )
{
    b2Body* bodyA = &world->bodies.data[ bodyIdA ];
    int contactKey = bodyA->headContactKey;
    while( contactKey != B2_NULL_INDEX )
    {
        int contactId = contactKey >> 1;
        int edgeIndex = contactKey & 1;
        b2Contact* contact = &world->contacts.data[ contactId ];
        contactKey = b2ContactEdgeAt( contact, edgeIndex )->nextKey;   // read before destroy
        if( b2ContactEdgeAt( contact, edgeIndex ^ 1 )->bodyId == bodyIdB )
            b2DestroyContact( world, contact, false );                 // no need to wake
    }
}

// Should the broad phase form a contact between these two bodies? False iff a
// joint connects them with collideConnected==false. Walks body A's joint list;
// the far endpoint comes through b2JointEdgeAt(joint, edge^1) (fixed-array trap).
// (Upstream folds this into b2ShouldShapesCollide in the broad-phase pair query.)
bool b2ShouldBodiesCollide( b2World* world, int bodyIdA, int bodyIdB )
{
    b2Body* bodyA = &world->bodies.data[ bodyIdA ];
    int jointKey = bodyA->headJointKey;
    while( jointKey != B2_NULL_INDEX )
    {
        int jointId = jointKey >> 1;
        int edgeIndex = jointKey & 1;
        b2Joint* joint = &world->joints.data[ jointId ];
        int otherBodyId = b2JointEdgeAt( joint, edgeIndex ^ 1 )->bodyId;
        if( otherBodyId == bodyIdB && joint->collideConnected == false )
            return false;
        jointKey = b2JointEdgeAt( joint, edgeIndex )->nextKey;
    }
    return true;
}

// Generic joint creator. Returns the internal joint id; fills *outSim with the
// emplaced (zeroed) b2JointSim so a per-type wrapper can populate its payload.
int b2CreateJoint( b2World* world, int bodyIdA, int bodyIdB,
                   b2Transform* localFrameA, b2Transform* localFrameB,
                   int type, bool collideConnected, b2JointSim** outSim )
{
    b2Body* bodyA = &world->bodies.data[ bodyIdA ];
    b2Body* bodyB = &world->bodies.data[ bodyIdB ];

    // Wake both endpoints BEFORE placing the joint (F4). Without this a sleeping
    // dynamic endpoint yields an AWAKE jointSim driving a body whose dense state
    // is still in a sleeping set (and b2LinkJoint would merge islands across
    // sets). PORT DEVIATION: upstream instead supports placing a joint INTO a
    // sleeping set (+ sleeping-set merge); waking is the simple correct subset.
    b2WakeBody( world, bodyA );
    b2WakeBody( world, bodyB );

    // pick the owning solver set (port's 3-set model)
    int setIndex;
    if( bodyA->setIndex == b2_disabledSet || bodyB->setIndex == b2_disabledSet )
        setIndex = b2_disabledSet;
    else if( bodyA->type != b2_dynamicBody && bodyB->type != b2_dynamicBody )
        setIndex = b2_staticSet;
    else
        setIndex = b2_awakeSet;

    b2SolverSet* set = &world->solverSets.data[ setIndex ];

    int jointId = b2AllocId( &world->jointIdPool );
    if( jointId == world->joints.count )
    {
        world->joints.data = b2GrowArray( world->joints.data, &world->joints.capacity,
                                          world->joints.count + 1, sizeof( b2Joint ) );
        memset( &world->joints.data[ jointId ], 0, sizeof( b2Joint ) );
        world->joints.count = world->joints.count + 1;
    }

    b2Joint* joint = &world->joints.data[ jointId ];
    joint->jointId = jointId;
    joint->userData = NULL;
    joint->generation = joint->generation + 1;
    joint->setIndex = setIndex;
    joint->colorIndex = B2_NULL_INDEX;
    joint->localIndex = set->jointSims.count;   // slot the sim lands in below
    joint->islandId = B2_NULL_INDEX;
    joint->islandIndex = B2_NULL_INDEX;
    joint->drawScale = 1.0;
    joint->type = type;
    joint->collideConnected = collideConnected;

    // connect to body A (edge 0)
    joint->edges[0].bodyId = bodyIdA;
    joint->edges[0].prevKey = B2_NULL_INDEX;
    joint->edges[0].nextKey = bodyA->headJointKey;
    int keyA = ( jointId << 1 ) | 0;
    if( bodyA->headJointKey != B2_NULL_INDEX )
    {
        b2Joint* headJoint = &world->joints.data[ bodyA->headJointKey >> 1 ];
        b2JointEdgeAt( headJoint, bodyA->headJointKey & 1 )->prevKey = keyA;
    }
    bodyA->headJointKey = keyA;
    bodyA->jointCount = bodyA->jointCount + 1;

    // connect to body B (edge 1)
    joint->edges[1].bodyId = bodyIdB;
    joint->edges[1].prevKey = B2_NULL_INDEX;
    joint->edges[1].nextKey = bodyB->headJointKey;
    int keyB = ( jointId << 1 ) | 1;
    if( bodyB->headJointKey != B2_NULL_INDEX )
    {
        b2Joint* headJoint = &world->joints.data[ bodyB->headJointKey >> 1 ];
        b2JointEdgeAt( headJoint, bodyB->headJointKey & 1 )->prevKey = keyB;
    }
    bodyB->headJointKey = keyB;
    bodyB->jointCount = bodyB->jointCount + 1;

    // emplace a zeroed b2JointSim into the solver set
    set->jointSims.data = b2GrowArray( set->jointSims.data, &set->jointSims.capacity,
                                       set->jointSims.count + 1, sizeof( b2JointSim ) );
    b2JointSim* jointSim = &set->jointSims.data[ set->jointSims.count ];
    set->jointSims.count = set->jointSims.count + 1;
    memset( jointSim, 0, sizeof( b2JointSim ) );
    jointSim->jointId = jointId;
    jointSim->bodyIdA = bodyIdA;
    jointSim->bodyIdB = bodyIdB;
    jointSim->type = type;
    jointSim->localFrameA = *localFrameA;
    jointSim->localFrameB = *localFrameB;
    jointSim->constraintHertz = 60.0;          // b2DefaultJointDef defaults
    jointSim->constraintDampingRatio = 2.0;
    jointSim->forceThreshold = B2_HUGE;         // events/breaking deferred
    jointSim->torqueThreshold = B2_HUGE;
    jointSim->constraintSoftness.biasRate = 0.0;   // recomputed in b2PrepareJoint each step
    jointSim->constraintSoftness.massScale = 1.0;
    jointSim->constraintSoftness.impulseScale = 0.0;

    // collideConnected==false: remove any contacts that already exist between the
    // two bodies (the broad phase is stopped from re-creating them by
    // b2ShouldBodiesCollide in the pair query).
    if( collideConnected == false )
        b2DestroyContactsBetweenBodies( world, bodyIdA, bodyIdB );

    // link the joint into the island graph (only when it has a dynamic body -- i.e.
    // it landed in the awake set, not static/disabled). Merges the bodies' islands.
    if( setIndex >= b2_awakeSet )
        b2LinkJoint( world, joint );

    *outSim = jointSim;
    return jointId;
}

void b2DestroyJointInternal( b2World* world, b2Joint* joint, bool wakeBodies )
{
    int jointId = joint->jointId;

    // unlink from the island graph (merge-only: removes the joint, flags split candidate)
    if( joint->islandId != B2_NULL_INDEX )
        b2UnlinkJoint( world, joint );

    b2JointEdge* edgeA = &joint->edges[0];
    b2JointEdge* edgeB = &joint->edges[1];
    b2Body* bodyA = &world->bodies.data[ edgeA->bodyId ];
    b2Body* bodyB = &world->bodies.data[ edgeB->bodyId ];

    // unlink edge 0 from body A's joint list
    if( edgeA->prevKey != B2_NULL_INDEX )
    {
        b2Joint* prev = &world->joints.data[ edgeA->prevKey >> 1 ];
        b2JointEdgeAt( prev, edgeA->prevKey & 1 )->nextKey = edgeA->nextKey;
    }
    if( edgeA->nextKey != B2_NULL_INDEX )
    {
        b2Joint* next = &world->joints.data[ edgeA->nextKey >> 1 ];
        b2JointEdgeAt( next, edgeA->nextKey & 1 )->prevKey = edgeA->prevKey;
    }
    if( bodyA->headJointKey == ( ( jointId << 1 ) | 0 ) )
        bodyA->headJointKey = edgeA->nextKey;
    bodyA->jointCount = bodyA->jointCount - 1;

    // unlink edge 1 from body B's joint list
    if( edgeB->prevKey != B2_NULL_INDEX )
    {
        b2Joint* prev = &world->joints.data[ edgeB->prevKey >> 1 ];
        b2JointEdgeAt( prev, edgeB->prevKey & 1 )->nextKey = edgeB->nextKey;
    }
    if( edgeB->nextKey != B2_NULL_INDEX )
    {
        b2Joint* next = &world->joints.data[ edgeB->nextKey >> 1 ];
        b2JointEdgeAt( next, edgeB->nextKey & 1 )->prevKey = edgeB->prevKey;
    }
    if( bodyB->headJointKey == ( ( jointId << 1 ) | 1 ) )
        bodyB->headJointKey = edgeB->nextKey;
    bodyB->jointCount = bodyB->jointCount - 1;

    // remove the jointSim from its solver set: swap the LAST sim into the freed
    // slot, then repair the MOVED joint's localIndex (same pattern as contacts).
    b2SolverSet* set = &world->solverSets.data[ joint->setIndex ];
    int localIndex = joint->localIndex;
    int lastIndex = set->jointSims.count - 1;
    if( localIndex != lastIndex )
    {
        set->jointSims.data[ localIndex ] = set->jointSims.data[ lastIndex ];
        b2JointSim* movedSim = &set->jointSims.data[ localIndex ];
        b2Joint* movedJoint = &world->joints.data[ movedSim->jointId ];
        movedJoint->localIndex = localIndex;
    }
    set->jointSims.count = set->jointSims.count - 1;

    // free the joint id (preserve generation)
    b2FreeId( &world->jointIdPool, jointId );
    joint->setIndex = B2_NULL_INDEX;
    joint->localIndex = B2_NULL_INDEX;
    joint->colorIndex = B2_NULL_INDEX;
    joint->jointId = B2_NULL_INDEX;

    // wake the endpoints LAST, after the joint is fully removed (upstream
    // joint.c order -- see b2DestroyContact for why last).
    if( wakeBodies )
    {
        b2WakeBody( world, bodyA );
        b2WakeBody( world, bodyB );
    }
}

// Distance-joint constructor. Bodies are given by internal id (body->id). The
// local frames anchor the joint on each body (frame origin = the attach point).
// Returns the internal joint id. (Rigid by default: hertz 0 / spring off.)
int b2CreateDistanceJoint( b2World* world, int bodyIdA, int bodyIdB,
                           b2Transform* localFrameA, b2Transform* localFrameB,
                           float length, bool collideConnected )
{
    b2JointSim* sim;
    int jointId = b2CreateJoint( world, bodyIdA, bodyIdB, localFrameA, localFrameB,
                                 b2_distanceJoint, collideConnected, &sim );

    b2DistanceJoint* dj = &sim->distanceJoint;
    dj->length = b2MaxFloat( length, B2_LINEAR_SLOP );
    dj->hertz = 0.0;
    dj->dampingRatio = 0.0;
    dj->lowerSpringForce = -B2_HUGE;
    dj->upperSpringForce = B2_HUGE;
    dj->minLength = dj->length;
    dj->maxLength = dj->length;
    dj->maxMotorForce = 0.0;
    dj->motorSpeed = 0.0;
    dj->impulse = 0.0;
    dj->lowerImpulse = 0.0;
    dj->upperImpulse = 0.0;
    dj->motorImpulse = 0.0;
    dj->enableSpring = false;
    dj->enableLimit = false;
    dj->enableMotor = false;

    return jointId;
}

// Revolute-joint (hinge) constructor. The two local frames' ORIGINS are the pivot
// point on each body; the joint pins them together while allowing relative rotation.
// Returns the internal joint id. (Point-to-point only: spring/motor/limit off.)
int b2CreateRevoluteJoint( b2World* world, int bodyIdA, int bodyIdB,
                           b2Transform* localFrameA, b2Transform* localFrameB,
                           bool collideConnected )
{
    b2JointSim* sim;
    int jointId = b2CreateJoint( world, bodyIdA, bodyIdB, localFrameA, localFrameB,
                                 b2_revoluteJoint, collideConnected, &sim );

    b2RevoluteJoint* rj = &sim->revoluteJoint;
    rj->linearImpulse = b2Vec2_zero;
    rj->springImpulse = 0.0;
    rj->motorImpulse = 0.0;
    rj->lowerImpulse = 0.0;
    rj->upperImpulse = 0.0;
    rj->hertz = 0.0;
    rj->dampingRatio = 0.0;
    rj->targetAngle = 0.0;
    rj->maxMotorTorque = 0.0;
    rj->motorSpeed = 0.0;
    rj->lowerAngle = 0.0;
    rj->upperAngle = 0.0;
    rj->axialMass = 0.0;
    rj->enableSpring = false;
    rj->enableMotor = false;
    rj->enableLimit = false;

    return jointId;
}

// Weld-joint constructor. Rigidly binds bodyB to bodyA at the local-frame origins,
// locking both relative position AND relative orientation. Returns the internal
// joint id. (Rigid by default: hertz 0 -> both springs use the base constraint
// softness. Set linear/angularHertz > 0 afterward for a soft weld.)
int b2CreateWeldJoint( b2World* world, int bodyIdA, int bodyIdB,
                       b2Transform* localFrameA, b2Transform* localFrameB,
                       bool collideConnected )
{
    b2JointSim* sim;
    int jointId = b2CreateJoint( world, bodyIdA, bodyIdB, localFrameA, localFrameB,
                                 b2_weldJoint, collideConnected, &sim );

    b2WeldJoint* wj = &sim->weldJoint;
    wj->linearHertz = 0.0;
    wj->linearDampingRatio = 0.0;
    wj->angularHertz = 0.0;
    wj->angularDampingRatio = 0.0;
    wj->linearImpulse = b2Vec2_zero;
    wj->angularImpulse = 0.0;
    wj->axialMass = 0.0;

    return jointId;
}

// Prismatic-joint (slider) constructor. bodyB slides along localFrameA's +x axis
// relative to bodyA, with no relative rotation. The local-frame origins are the
// zero-translation anchor points. Returns the internal joint id. (Core slider only:
// spring/motor/limit off -- free sliding along the axis.)
int b2CreatePrismaticJoint( b2World* world, int bodyIdA, int bodyIdB,
                            b2Transform* localFrameA, b2Transform* localFrameB,
                            bool collideConnected )
{
    b2JointSim* sim;
    int jointId = b2CreateJoint( world, bodyIdA, bodyIdB, localFrameA, localFrameB,
                                 b2_prismaticJoint, collideConnected, &sim );

    b2PrismaticJoint* pj = &sim->prismaticJoint;
    pj->impulse = b2Vec2_zero;
    pj->springImpulse = 0.0;
    pj->motorImpulse = 0.0;
    pj->lowerImpulse = 0.0;
    pj->upperImpulse = 0.0;
    pj->hertz = 0.0;
    pj->dampingRatio = 0.0;
    pj->targetTranslation = 0.0;
    pj->maxMotorForce = 0.0;
    pj->motorSpeed = 0.0;
    pj->lowerTranslation = 0.0;
    pj->upperTranslation = 0.0;
    pj->enableSpring = false;
    pj->enableLimit = false;
    pj->enableMotor = false;

    return jointId;
}

// Wheel-joint (suspension) constructor. Keeps bodyB on the line through the anchor
// along localFrameA's +x axis, free to slide (optional spring/limit) and rotate
// (optional motor). Returns the internal joint id. Enable the spring + set
// hertz/dampingRatio afterward for real suspension; motor/limit likewise.
int b2CreateWheelJoint( b2World* world, int bodyIdA, int bodyIdB,
                        b2Transform* localFrameA, b2Transform* localFrameB,
                        bool collideConnected )
{
    b2JointSim* sim;
    int jointId = b2CreateJoint( world, bodyIdA, bodyIdB, localFrameA, localFrameB,
                                 b2_wheelJoint, collideConnected, &sim );

    b2WheelJoint* wj = &sim->wheelJoint;
    wj->perpImpulse = 0.0;
    wj->motorImpulse = 0.0;
    wj->springImpulse = 0.0;
    wj->lowerImpulse = 0.0;
    wj->upperImpulse = 0.0;
    wj->maxMotorTorque = 0.0;
    wj->motorSpeed = 0.0;
    wj->lowerTranslation = 0.0;
    wj->upperTranslation = 0.0;
    wj->hertz = 0.0;
    wj->dampingRatio = 0.0;
    wj->enableSpring = false;
    wj->enableMotor = false;
    wj->enableLimit = false;

    return jointId;
}

// Motor-joint constructor. Drives the two bodies' RELATIVE velocity toward a target;
// set linearVelocity/angularVelocity + max*Force/Torque on the sim afterward (or use
// the def API) to activate a drive. The local frames give the anchor point + reference
// orientation. Returns the internal joint id. (All drives off by default: the max
// force/torque caps are 0, so the joint is inert until they are set > 0.)
int b2CreateMotorJoint( b2World* world, int bodyIdA, int bodyIdB,
                        b2Transform* localFrameA, b2Transform* localFrameB,
                        bool collideConnected )
{
    b2JointSim* sim;
    int jointId = b2CreateJoint( world, bodyIdA, bodyIdB, localFrameA, localFrameB,
                                 b2_motorJoint, collideConnected, &sim );

    b2MotorJoint* mj = &sim->motorJoint;
    mj->linearVelocity = b2Vec2_zero;
    mj->maxVelocityForce = 0.0;
    mj->angularVelocity = 0.0;
    mj->maxVelocityTorque = 0.0;
    mj->linearHertz = 0.0;
    mj->linearDampingRatio = 0.0;
    mj->maxSpringForce = 0.0;
    mj->angularHertz = 0.0;
    mj->angularDampingRatio = 0.0;
    mj->maxSpringTorque = 0.0;
    mj->linearVelocityImpulse = b2Vec2_zero;
    mj->angularVelocityImpulse = 0.0;
    mj->linearSpringImpulse = b2Vec2_zero;
    mj->angularSpringImpulse = 0.0;

    return jointId;
}

// Filter-joint constructor. A "null" joint: it has NO constraint (drives nothing);
// its ONLY effect is to disable collision between its two bodies (collideConnected is
// forced false -> b2CreateJoint destroys any existing contacts, and b2ShouldBodiesCollide
// stops the broad phase re-creating them). Use it to let two bodies overlap without a
// physical link. No solve branch: the dispatchers skip b2_filterJoint (no-op each step).
int b2CreateFilterJoint( b2World* world, int bodyIdA, int bodyIdB,
                         b2Transform* localFrameA, b2Transform* localFrameB )
{
    b2JointSim* sim;
    int jointId = b2CreateJoint( world, bodyIdA, bodyIdB, localFrameA, localFrameB,
                                 b2_filterJoint, false, &sim );   // collideConnected forced false
    return jointId;
}


// -----------------------------------------------------------------------------
//   Public joint API (declarative): b2*JointDef + b2Default*JointDef +
//   b2Create*JointDef (def-based). Games configure a def and create in one call.
//   These wrap the internal int-based creators above and apply the def's tunables
//   to the jointSim. Bodies are named by b2BodyId (consistent with b2CreateBody /
//   the shape API). Each returns a generation-checked b2JointId THROUGH AN OUT-
//   POINTER (b2JointId is > 1 word -> cannot cross a function boundary by value),
//   matching how b2CreateBody hands back a b2BodyId. Pass that handle to
//   b2DestroyJoint / the runtime setters / b2Joint_IsValid.
// -----------------------------------------------------------------------------

// A stable, generation-checked handle to a joint (mirrors b2BodyId / b2ShapeId).
struct b2JointId
{
    int index1;       // 1-based index into world->joints (0 = null)
    int world0;       // world id
    int generation;   // must match joint->generation or the id is stale
};

void b2MakeJointId( b2World* world, int jointId, b2JointId* result )
{
    result->index1 = jointId + 1;
    result->world0 = world->worldId;
    result->generation = world->joints.data[ jointId ].generation;
}

// True iff the handle still refers to the live joint it was minted for. False if
// the world differs, the slot is out of range / freed (jointId == B2_NULL_INDEX),
// or the generation was bumped by a create that reused the slot. Bounds are checked
// BEFORE the deref because a zeroed handle has index1 == 0 -> data[-1] (NULL == -1).
bool b2Joint_IsValid( b2World* world, b2JointId* id )
{
    if( id->world0 != world->worldId )                     return false;
    if( id->index1 <= 0 || id->index1 > world->joints.count )  return false;
    b2Joint* joint = &world->joints.data[ id->index1 - 1 ];
    if( joint->jointId == B2_NULL_INDEX )                  return false;   // freed slot
    if( joint->generation != id->generation )             return false;   // slot reused
    return true;
}

b2JointSim* b2GetJointSimById( b2World* world, int jointId )
{
    return b2GetJointSim( world, &world->joints.data[ jointId ] );
}

// Public destroy: takes the generation-checked handle.
void b2DestroyJoint( b2World* world, b2JointId* jointId )
{
    b2DestroyJointInternal( world, &world->joints.data[ jointId->index1 - 1 ], true );
}

// ---- distance ----
struct b2DistanceJointDef
{
    b2BodyId bodyIdA;
    b2BodyId bodyIdB;
    b2Transform localFrameA;
    b2Transform localFrameB;
    float length;
    float hertz;
    float dampingRatio;
    float minLength;
    float maxLength;
    bool enableSpring;
    bool enableLimit;
    bool collideConnected;
};

void b2DefaultDistanceJointDef( b2DistanceJointDef* def )
{
    memset( def, 0, sizeof( b2DistanceJointDef ) );
    def->localFrameA.q = b2Rot_identity;
    def->localFrameB.q = b2Rot_identity;
    def->length = 1.0;
    def->maxLength = B2_HUGE;
}

void b2CreateDistanceJointDef( b2World* world, b2DistanceJointDef* def, b2JointId* out )
{
    int idA = def->bodyIdA.index1 - 1;
    int idB = def->bodyIdB.index1 - 1;
    int jid = b2CreateDistanceJoint( world, idA, idB, &def->localFrameA, &def->localFrameB,
                                     def->length, def->collideConnected );
    b2DistanceJoint* dj = &b2GetJointSimById( world, jid )->distanceJoint;
    dj->hertz = def->hertz;
    dj->dampingRatio = def->dampingRatio;
    dj->enableSpring = def->enableSpring;
    dj->enableLimit = def->enableLimit;
    if( def->enableLimit )
    {
        dj->minLength = b2MaxFloat( def->minLength, B2_LINEAR_SLOP );
        dj->maxLength = b2MaxFloat( def->minLength, def->maxLength );
    }
    b2MakeJointId( world, jid, out );
}

// ---- revolute ----
struct b2RevoluteJointDef
{
    b2BodyId bodyIdA;
    b2BodyId bodyIdB;
    b2Transform localFrameA;
    b2Transform localFrameB;
    bool enableSpring;
    float hertz;
    float dampingRatio;
    float targetAngle;
    bool enableMotor;
    float motorSpeed;
    float maxMotorTorque;
    bool enableLimit;
    float lowerAngle;
    float upperAngle;
    bool collideConnected;
};

void b2DefaultRevoluteJointDef( b2RevoluteJointDef* def )
{
    memset( def, 0, sizeof( b2RevoluteJointDef ) );
    def->localFrameA.q = b2Rot_identity;
    def->localFrameB.q = b2Rot_identity;
}

void b2CreateRevoluteJointDef( b2World* world, b2RevoluteJointDef* def, b2JointId* out )
{
    int idA = def->bodyIdA.index1 - 1;
    int idB = def->bodyIdB.index1 - 1;
    int jid = b2CreateRevoluteJoint( world, idA, idB, &def->localFrameA, &def->localFrameB,
                                     def->collideConnected );
    b2RevoluteJoint* rj = &b2GetJointSimById( world, jid )->revoluteJoint;
    rj->enableSpring = def->enableSpring;
    rj->hertz = def->hertz;
    rj->dampingRatio = def->dampingRatio;
    rj->targetAngle = def->targetAngle;
    rj->enableMotor = def->enableMotor;
    rj->motorSpeed = def->motorSpeed;
    rj->maxMotorTorque = def->maxMotorTorque;
    rj->enableLimit = def->enableLimit;
    rj->lowerAngle = def->lowerAngle;
    rj->upperAngle = def->upperAngle;
    b2MakeJointId( world, jid, out );
}

// ---- weld ----
struct b2WeldJointDef
{
    b2BodyId bodyIdA;
    b2BodyId bodyIdB;
    b2Transform localFrameA;
    b2Transform localFrameB;
    float linearHertz;
    float linearDampingRatio;
    float angularHertz;
    float angularDampingRatio;
    bool collideConnected;
};

void b2DefaultWeldJointDef( b2WeldJointDef* def )
{
    memset( def, 0, sizeof( b2WeldJointDef ) );
    def->localFrameA.q = b2Rot_identity;
    def->localFrameB.q = b2Rot_identity;
}

void b2CreateWeldJointDef( b2World* world, b2WeldJointDef* def, b2JointId* out )
{
    int idA = def->bodyIdA.index1 - 1;
    int idB = def->bodyIdB.index1 - 1;
    int jid = b2CreateWeldJoint( world, idA, idB, &def->localFrameA, &def->localFrameB,
                                 def->collideConnected );
    b2WeldJoint* wj = &b2GetJointSimById( world, jid )->weldJoint;
    wj->linearHertz = def->linearHertz;
    wj->linearDampingRatio = def->linearDampingRatio;
    wj->angularHertz = def->angularHertz;
    wj->angularDampingRatio = def->angularDampingRatio;
    b2MakeJointId( world, jid, out );
}

// ---- prismatic ----
struct b2PrismaticJointDef
{
    b2BodyId bodyIdA;
    b2BodyId bodyIdB;
    b2Transform localFrameA;
    b2Transform localFrameB;
    bool enableSpring;
    float hertz;
    float dampingRatio;
    float targetTranslation;
    bool enableMotor;
    float motorSpeed;
    float maxMotorForce;
    bool enableLimit;
    float lowerTranslation;
    float upperTranslation;
    bool collideConnected;
};

void b2DefaultPrismaticJointDef( b2PrismaticJointDef* def )
{
    memset( def, 0, sizeof( b2PrismaticJointDef ) );
    def->localFrameA.q = b2Rot_identity;
    def->localFrameB.q = b2Rot_identity;
}

void b2CreatePrismaticJointDef( b2World* world, b2PrismaticJointDef* def, b2JointId* out )
{
    int idA = def->bodyIdA.index1 - 1;
    int idB = def->bodyIdB.index1 - 1;
    int jid = b2CreatePrismaticJoint( world, idA, idB, &def->localFrameA, &def->localFrameB,
                                      def->collideConnected );
    b2PrismaticJoint* pj = &b2GetJointSimById( world, jid )->prismaticJoint;
    pj->enableSpring = def->enableSpring;
    pj->hertz = def->hertz;
    pj->dampingRatio = def->dampingRatio;
    pj->targetTranslation = def->targetTranslation;
    pj->enableMotor = def->enableMotor;
    pj->motorSpeed = def->motorSpeed;
    pj->maxMotorForce = def->maxMotorForce;
    pj->enableLimit = def->enableLimit;
    pj->lowerTranslation = def->lowerTranslation;
    pj->upperTranslation = def->upperTranslation;
    b2MakeJointId( world, jid, out );
}

// ---- wheel ----
struct b2WheelJointDef
{
    b2BodyId bodyIdA;
    b2BodyId bodyIdB;
    b2Transform localFrameA;
    b2Transform localFrameB;
    bool enableSpring;
    float hertz;
    float dampingRatio;
    bool enableMotor;
    float motorSpeed;
    float maxMotorTorque;
    bool enableLimit;
    float lowerTranslation;
    float upperTranslation;
    bool collideConnected;
};

void b2DefaultWheelJointDef( b2WheelJointDef* def )
{
    memset( def, 0, sizeof( b2WheelJointDef ) );
    def->localFrameA.q = b2Rot_identity;
    def->localFrameB.q = b2Rot_identity;
}

void b2CreateWheelJointDef( b2World* world, b2WheelJointDef* def, b2JointId* out )
{
    int idA = def->bodyIdA.index1 - 1;
    int idB = def->bodyIdB.index1 - 1;
    int jid = b2CreateWheelJoint( world, idA, idB, &def->localFrameA, &def->localFrameB,
                                  def->collideConnected );
    b2WheelJoint* wj = &b2GetJointSimById( world, jid )->wheelJoint;
    wj->enableSpring = def->enableSpring;
    wj->hertz = def->hertz;
    wj->dampingRatio = def->dampingRatio;
    wj->enableMotor = def->enableMotor;
    wj->motorSpeed = def->motorSpeed;
    wj->maxMotorTorque = def->maxMotorTorque;
    wj->enableLimit = def->enableLimit;
    wj->lowerTranslation = def->lowerTranslation;
    wj->upperTranslation = def->upperTranslation;
    b2MakeJointId( world, jid, out );
}

// ---- motor ----
struct b2MotorJointDef
{
    b2BodyId bodyIdA;
    b2BodyId bodyIdB;
    b2Transform localFrameA;
    b2Transform localFrameB;
    b2Vec2 linearVelocity;
    float maxVelocityForce;
    float angularVelocity;
    float maxVelocityTorque;
    float linearHertz;
    float linearDampingRatio;
    float maxSpringForce;
    float angularHertz;
    float angularDampingRatio;
    float maxSpringTorque;
    bool collideConnected;
};

void b2DefaultMotorJointDef( b2MotorJointDef* def )
{
    memset( def, 0, sizeof( b2MotorJointDef ) );
    def->localFrameA.q = b2Rot_identity;
    def->localFrameB.q = b2Rot_identity;
}

void b2CreateMotorJointDef( b2World* world, b2MotorJointDef* def, b2JointId* out )
{
    int idA = def->bodyIdA.index1 - 1;
    int idB = def->bodyIdB.index1 - 1;
    int jid = b2CreateMotorJoint( world, idA, idB, &def->localFrameA, &def->localFrameB,
                                  def->collideConnected );
    b2MotorJoint* mj = &b2GetJointSimById( world, jid )->motorJoint;
    mj->linearVelocity = def->linearVelocity;
    mj->maxVelocityForce = def->maxVelocityForce;
    mj->angularVelocity = def->angularVelocity;
    mj->maxVelocityTorque = def->maxVelocityTorque;
    mj->linearHertz = def->linearHertz;
    mj->linearDampingRatio = def->linearDampingRatio;
    mj->maxSpringForce = b2MaxFloat( 0.0, def->maxSpringForce );
    mj->angularHertz = def->angularHertz;
    mj->angularDampingRatio = def->angularDampingRatio;
    mj->maxSpringTorque = b2MaxFloat( 0.0, def->maxSpringTorque );
    b2MakeJointId( world, jid, out );
}

// ---- filter ----
struct b2FilterJointDef
{
    b2BodyId bodyIdA;
    b2BodyId bodyIdB;
};

void b2DefaultFilterJointDef( b2FilterJointDef* def )
{
    memset( def, 0, sizeof( b2FilterJointDef ) );
}

void b2CreateFilterJointDef( b2World* world, b2FilterJointDef* def, b2JointId* out )
{
    int idA = def->bodyIdA.index1 - 1;
    int idB = def->bodyIdB.index1 - 1;
    b2Transform f;  f.p = b2Vec2_zero;  f.q = b2Rot_identity;   // frames unused (no constraint)
    int jid = b2CreateFilterJoint( world, idA, idB, &f, &f );
    b2MakeJointId( world, jid, out );
}


// =============================================================================
//   Runtime setter / getter API (handle-based). Games configure a joint at create
//   time via the def, then poke it live through these. Each resolves the handle to
//   the live b2JointSim and mutates its payload; the change takes effect on the next
//   b2World_Step (b2PrepareJoints re-reads the fields). No type check is needed for
//   memory safety -- the port stores one NAMED member per type (not a union), so a
//   wrong-type setter writes an unused member harmlessly (still caller error). Sleeping
//   is not implemented, so upstream's "wake the bodies on change" is a no-op here.
//   Geometric getters (angle/translation/length) are exact functions of the current
//   transforms and need no solver state.
// =============================================================================

// resolve a handle to its live sim (no generation guard; call b2Joint_IsValid first
// if the handle might be stale)
b2JointSim* b2Joint_GetSim( b2World* world, b2JointId* id )
{
    return b2GetJointSimById( world, id->index1 - 1 );
}

// ---- generic ----
int  b2Joint_GetType( b2World* world, b2JointId* id ) { return b2Joint_GetSim( world, id )->type; }
bool b2Joint_GetCollideConnected( b2World* world, b2JointId* id )
{
    return world->joints.data[ id->index1 - 1 ].collideConnected;
}
void b2Joint_SetCollideConnected( b2World* world, b2JointId* id, bool value )
{
    b2Joint* joint = &world->joints.data[ id->index1 - 1 ];
    if( joint->collideConnected == value )  return;
    joint->collideConnected = value;
    // on the true->false transition, drop the contacts now (like upstream); the
    // false->true transition just lets the broad phase re-pair next step.
    if( value == false )
        b2DestroyContactsBetweenBodies( world, joint->edges[0].bodyId, joint->edges[1].bodyId );
}

// ---- distance ----
void  b2DistanceJoint_SetLength( b2World* w, b2JointId* id, float length )
{ b2DistanceJoint* j = &b2Joint_GetSim( w, id )->distanceJoint;  j->length = b2MaxFloat( length, B2_LINEAR_SLOP ); }
void  b2DistanceJoint_SetLengthRange( b2World* w, b2JointId* id, float minLength, float maxLength )
{ b2DistanceJoint* j = &b2Joint_GetSim( w, id )->distanceJoint;
  j->minLength = b2MaxFloat( minLength, B2_LINEAR_SLOP );  j->maxLength = b2MaxFloat( j->minLength, maxLength ); }
void  b2DistanceJoint_EnableSpring( b2World* w, b2JointId* id, bool e ) { b2Joint_GetSim( w, id )->distanceJoint.enableSpring = e; }
void  b2DistanceJoint_SetSpringHertz( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->distanceJoint.hertz = v; }
void  b2DistanceJoint_SetSpringDampingRatio( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->distanceJoint.dampingRatio = v; }
void  b2DistanceJoint_EnableLimit( b2World* w, b2JointId* id, bool e ) { b2Joint_GetSim( w, id )->distanceJoint.enableLimit = e; }
void  b2DistanceJoint_EnableMotor( b2World* w, b2JointId* id, bool e ) { b2Joint_GetSim( w, id )->distanceJoint.enableMotor = e; }
void  b2DistanceJoint_SetMotorSpeed( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->distanceJoint.motorSpeed = v; }
void  b2DistanceJoint_SetMaxMotorForce( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->distanceJoint.maxMotorForce = v; }
float b2DistanceJoint_GetLength( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->distanceJoint.length; }

// ---- revolute ----
void b2RevoluteJoint_EnableMotor( b2World* w, b2JointId* id, bool e ) { b2Joint_GetSim( w, id )->revoluteJoint.enableMotor = e; }
void b2RevoluteJoint_SetMotorSpeed( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->revoluteJoint.motorSpeed = v; }
void b2RevoluteJoint_SetMaxMotorTorque( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->revoluteJoint.maxMotorTorque = v; }
void b2RevoluteJoint_EnableLimit( b2World* w, b2JointId* id, bool e ) { b2Joint_GetSim( w, id )->revoluteJoint.enableLimit = e; }
void b2RevoluteJoint_SetLimits( b2World* w, b2JointId* id, float lo, float hi )
{ b2RevoluteJoint* j = &b2Joint_GetSim( w, id )->revoluteJoint;  j->lowerAngle = b2MinFloat( lo, hi );  j->upperAngle = b2MaxFloat( lo, hi ); }
void b2RevoluteJoint_EnableSpring( b2World* w, b2JointId* id, bool e ) { b2Joint_GetSim( w, id )->revoluteJoint.enableSpring = e; }
void b2RevoluteJoint_SetSpringHertz( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->revoluteJoint.hertz = v; }
void b2RevoluteJoint_SetSpringDampingRatio( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->revoluteJoint.dampingRatio = v; }
void b2RevoluteJoint_SetTargetAngle( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->revoluteJoint.targetAngle = v; }

float b2RevoluteJoint_GetAngle( b2World* world, b2JointId* id )
{
    b2JointSim* base = b2Joint_GetSim( world, id );
    b2BodySim* simA = b2GetBodySim( world, &world->bodies.data[ base->bodyIdA ] );
    b2BodySim* simB = b2GetBodySim( world, &world->bodies.data[ base->bodyIdB ] );
    b2Rot qA;  b2MulRot( &simA->transform.q, &base->localFrameA.q, &qA );
    b2Rot qB;  b2MulRot( &simB->transform.q, &base->localFrameB.q, &qB );
    b2Rot relQ;  b2InvMulRot( &qA, &qB, &relQ );
    return b2Rot_GetAngle( &relQ );
}

// ---- prismatic ----
void b2PrismaticJoint_EnableMotor( b2World* w, b2JointId* id, bool e ) { b2Joint_GetSim( w, id )->prismaticJoint.enableMotor = e; }
void b2PrismaticJoint_SetMotorSpeed( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->prismaticJoint.motorSpeed = v; }
void b2PrismaticJoint_SetMaxMotorForce( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->prismaticJoint.maxMotorForce = v; }
void b2PrismaticJoint_EnableLimit( b2World* w, b2JointId* id, bool e ) { b2Joint_GetSim( w, id )->prismaticJoint.enableLimit = e; }
void b2PrismaticJoint_SetLimits( b2World* w, b2JointId* id, float lo, float hi )
{ b2PrismaticJoint* j = &b2Joint_GetSim( w, id )->prismaticJoint;  j->lowerTranslation = b2MinFloat( lo, hi );  j->upperTranslation = b2MaxFloat( lo, hi ); }
void b2PrismaticJoint_EnableSpring( b2World* w, b2JointId* id, bool e ) { b2Joint_GetSim( w, id )->prismaticJoint.enableSpring = e; }
void b2PrismaticJoint_SetSpringHertz( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->prismaticJoint.hertz = v; }
void b2PrismaticJoint_SetSpringDampingRatio( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->prismaticJoint.dampingRatio = v; }
void b2PrismaticJoint_SetTargetTranslation( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->prismaticJoint.targetTranslation = v; }

float b2PrismaticJoint_GetTranslation( b2World* world, b2JointId* id )
{
    b2JointSim* base = b2Joint_GetSim( world, id );
    b2BodySim* simA = b2GetBodySim( world, &world->bodies.data[ base->bodyIdA ] );
    b2BodySim* simB = b2GetBodySim( world, &world->bodies.data[ base->bodyIdB ] );
    b2Rot qA;  b2MulRot( &simA->transform.q, &base->localFrameA.q, &qA );
    b2Vec2 axis;  axis.x = qA.c;  axis.y = qA.s;                 // frameA local +x in world
    b2Vec2 pA;  b2TransformPoint( &simA->transform, &base->localFrameA.p, &pA );
    b2Vec2 pB;  b2TransformPoint( &simB->transform, &base->localFrameB.p, &pB );
    b2Vec2 d;  b2Sub( &pB, &pA, &d );
    return b2Dot( &axis, &d );
}

// ---- wheel ----
void b2WheelJoint_EnableMotor( b2World* w, b2JointId* id, bool e ) { b2Joint_GetSim( w, id )->wheelJoint.enableMotor = e; }
void b2WheelJoint_SetMotorSpeed( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->wheelJoint.motorSpeed = v; }
void b2WheelJoint_SetMaxMotorTorque( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->wheelJoint.maxMotorTorque = v; }
void b2WheelJoint_EnableLimit( b2World* w, b2JointId* id, bool e ) { b2Joint_GetSim( w, id )->wheelJoint.enableLimit = e; }
void b2WheelJoint_SetLimits( b2World* w, b2JointId* id, float lo, float hi )
{ b2WheelJoint* j = &b2Joint_GetSim( w, id )->wheelJoint;  j->lowerTranslation = b2MinFloat( lo, hi );  j->upperTranslation = b2MaxFloat( lo, hi ); }
void b2WheelJoint_EnableSpring( b2World* w, b2JointId* id, bool e ) { b2Joint_GetSim( w, id )->wheelJoint.enableSpring = e; }
void b2WheelJoint_SetSpringHertz( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->wheelJoint.hertz = v; }
void b2WheelJoint_SetSpringDampingRatio( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->wheelJoint.dampingRatio = v; }

float b2WheelJoint_GetTranslation( b2World* world, b2JointId* id )
{
    b2JointSim* base = b2Joint_GetSim( world, id );
    b2BodySim* simA = b2GetBodySim( world, &world->bodies.data[ base->bodyIdA ] );
    b2BodySim* simB = b2GetBodySim( world, &world->bodies.data[ base->bodyIdB ] );
    b2Rot qA;  b2MulRot( &simA->transform.q, &base->localFrameA.q, &qA );
    b2Vec2 axis;  axis.x = qA.c;  axis.y = qA.s;
    b2Vec2 pA;  b2TransformPoint( &simA->transform, &base->localFrameA.p, &pA );
    b2Vec2 pB;  b2TransformPoint( &simB->transform, &base->localFrameB.p, &pB );
    b2Vec2 d;  b2Sub( &pB, &pA, &d );
    return b2Dot( &axis, &d );
}

// ---- weld ----
void b2WeldJoint_SetLinearHertz( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->weldJoint.linearHertz = v; }
void b2WeldJoint_SetLinearDampingRatio( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->weldJoint.linearDampingRatio = v; }
void b2WeldJoint_SetAngularHertz( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->weldJoint.angularHertz = v; }
void b2WeldJoint_SetAngularDampingRatio( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->weldJoint.angularDampingRatio = v; }

// ---- motor ----
void b2MotorJoint_SetLinearVelocity( b2World* w, b2JointId* id, b2Vec2* v ) { b2Joint_GetSim( w, id )->motorJoint.linearVelocity = *v; }
void b2MotorJoint_SetAngularVelocity( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->motorJoint.angularVelocity = v; }
void b2MotorJoint_SetMaxVelocityForce( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->motorJoint.maxVelocityForce = v; }
void b2MotorJoint_SetMaxVelocityTorque( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->motorJoint.maxVelocityTorque = v; }
void b2MotorJoint_SetLinearHertz( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->motorJoint.linearHertz = v; }
void b2MotorJoint_SetLinearDampingRatio( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->motorJoint.linearDampingRatio = v; }
void b2MotorJoint_SetAngularHertz( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->motorJoint.angularHertz = v; }
void b2MotorJoint_SetAngularDampingRatio( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->motorJoint.angularDampingRatio = v; }


// =============================================================================
//   Joint accessors (API batch 3): getters mirroring the setters above, plus the
//   common b2Joint_* base accessors. Every one here is a plain field read/write.
//
//   DEFERRED (own slice -- need machinery this doesn't touch):
//     * reaction forces: b2Joint_GetConstraintForce/Torque and the per-type
//       b2*Joint_GetMotorForce/GetMotorTorque all need `impulse * inv_h`, and the
//       port keeps inv_h as a b2World_Step local, not a persisted world field.
//     * geometric queries: b2DistanceJoint_GetCurrentLength, b2PrismaticJoint_GetSpeed,
//       b2Joint_GetLinearSeparation/GetAngularSeparation -- derived from live body
//       transforms/velocities, not stored, and need per-type bracket verification.
//     * b2Joint_GetWorld (the port threads b2World* explicitly).
// =============================================================================

// ---- b2Joint_* base ----
void b2Joint_GetBodyA( b2World* world, b2JointId* id, b2BodyId* result )
{
    b2JointSim* base = b2Joint_GetSim( world, id );
    b2MakeBodyId( world, base->bodyIdA, result );
}
void b2Joint_GetBodyB( b2World* world, b2JointId* id, b2BodyId* result )
{
    b2JointSim* base = b2Joint_GetSim( world, id );
    b2MakeBodyId( world, base->bodyIdB, result );
}

void b2Joint_GetLocalFrameA( b2World* world, b2JointId* id, b2Transform* result )
{ *result = b2Joint_GetSim( world, id )->localFrameA; }
void b2Joint_GetLocalFrameB( b2World* world, b2JointId* id, b2Transform* result )
{ *result = b2Joint_GetSim( world, id )->localFrameB; }
void b2Joint_SetLocalFrameA( b2World* world, b2JointId* id, b2Transform* frame )
{ b2Joint_GetSim( world, id )->localFrameA = *frame; }
void b2Joint_SetLocalFrameB( b2World* world, b2JointId* id, b2Transform* frame )
{ b2Joint_GetSim( world, id )->localFrameB = *frame; }

void* b2Joint_GetUserData( b2World* world, b2JointId* id )
{ return world->joints.data[ id->index1 - 1 ].userData; }
void b2Joint_SetUserData( b2World* world, b2JointId* id, void* userData )
{ world->joints.data[ id->index1 - 1 ].userData = userData; }

void b2Joint_GetConstraintTuning( b2World* world, b2JointId* id, float* hertz, float* dampingRatio )
{
    b2JointSim* base = b2Joint_GetSim( world, id );
    *hertz = base->constraintHertz;
    *dampingRatio = base->constraintDampingRatio;
}
void b2Joint_SetConstraintTuning( b2World* world, b2JointId* id, float hertz, float dampingRatio )
{
    b2JointSim* base = b2Joint_GetSim( world, id );
    base->constraintHertz = hertz;
    base->constraintDampingRatio = dampingRatio;
}

float b2Joint_GetForceThreshold( b2World* world, b2JointId* id )  { return b2Joint_GetSim( world, id )->forceThreshold; }
void  b2Joint_SetForceThreshold( b2World* world, b2JointId* id, float v ) { b2Joint_GetSim( world, id )->forceThreshold = v; }
float b2Joint_GetTorqueThreshold( b2World* world, b2JointId* id ) { return b2Joint_GetSim( world, id )->torqueThreshold; }
void  b2Joint_SetTorqueThreshold( b2World* world, b2JointId* id, float v ) { b2Joint_GetSim( world, id )->torqueThreshold = v; }

// Wake both bodies this joint connects (upstream b2Joint_WakeBodies).
void b2Joint_WakeBodies( b2World* world, b2JointId* id )
{
    b2Joint* joint = &world->joints.data[ id->index1 - 1 ];
    b2WakeBody( world, &world->bodies.data[ b2JointEdgeAt( joint, 0 )->bodyId ] );
    b2WakeBody( world, &world->bodies.data[ b2JointEdgeAt( joint, 1 )->bodyId ] );
}

// ---- distance ----
float b2DistanceJoint_GetMinLength( b2World* w, b2JointId* id )  { return b2Joint_GetSim( w, id )->distanceJoint.minLength; }
float b2DistanceJoint_GetMaxLength( b2World* w, b2JointId* id )  { return b2Joint_GetSim( w, id )->distanceJoint.maxLength; }
bool  b2DistanceJoint_IsSpringEnabled( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->distanceJoint.enableSpring; }
float b2DistanceJoint_GetSpringHertz( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->distanceJoint.hertz; }
float b2DistanceJoint_GetSpringDampingRatio( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->distanceJoint.dampingRatio; }
bool  b2DistanceJoint_IsLimitEnabled( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->distanceJoint.enableLimit; }
bool  b2DistanceJoint_IsMotorEnabled( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->distanceJoint.enableMotor; }
float b2DistanceJoint_GetMotorSpeed( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->distanceJoint.motorSpeed; }
float b2DistanceJoint_GetMaxMotorForce( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->distanceJoint.maxMotorForce; }
void  b2DistanceJoint_SetSpringForceRange( b2World* w, b2JointId* id, float lower, float upper )
{ b2DistanceJoint* j = &b2Joint_GetSim( w, id )->distanceJoint;  j->lowerSpringForce = b2MinFloat( lower, upper );  j->upperSpringForce = b2MaxFloat( lower, upper ); }
void  b2DistanceJoint_GetSpringForceRange( b2World* w, b2JointId* id, float* lower, float* upper )
{ b2DistanceJoint* j = &b2Joint_GetSim( w, id )->distanceJoint;  *lower = j->lowerSpringForce;  *upper = j->upperSpringForce; }

// ---- revolute ----
bool  b2RevoluteJoint_IsSpringEnabled( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->revoluteJoint.enableSpring; }
float b2RevoluteJoint_GetSpringHertz( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->revoluteJoint.hertz; }
float b2RevoluteJoint_GetSpringDampingRatio( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->revoluteJoint.dampingRatio; }
float b2RevoluteJoint_GetTargetAngle( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->revoluteJoint.targetAngle; }
bool  b2RevoluteJoint_IsMotorEnabled( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->revoluteJoint.enableMotor; }
float b2RevoluteJoint_GetMotorSpeed( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->revoluteJoint.motorSpeed; }
float b2RevoluteJoint_GetMaxMotorTorque( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->revoluteJoint.maxMotorTorque; }
bool  b2RevoluteJoint_IsLimitEnabled( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->revoluteJoint.enableLimit; }
float b2RevoluteJoint_GetLowerLimit( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->revoluteJoint.lowerAngle; }
float b2RevoluteJoint_GetUpperLimit( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->revoluteJoint.upperAngle; }

// ---- prismatic ----
bool  b2PrismaticJoint_IsSpringEnabled( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->prismaticJoint.enableSpring; }
float b2PrismaticJoint_GetSpringHertz( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->prismaticJoint.hertz; }
float b2PrismaticJoint_GetSpringDampingRatio( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->prismaticJoint.dampingRatio; }
float b2PrismaticJoint_GetTargetTranslation( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->prismaticJoint.targetTranslation; }
bool  b2PrismaticJoint_IsMotorEnabled( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->prismaticJoint.enableMotor; }
float b2PrismaticJoint_GetMotorSpeed( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->prismaticJoint.motorSpeed; }
float b2PrismaticJoint_GetMaxMotorForce( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->prismaticJoint.maxMotorForce; }
bool  b2PrismaticJoint_IsLimitEnabled( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->prismaticJoint.enableLimit; }
float b2PrismaticJoint_GetLowerLimit( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->prismaticJoint.lowerTranslation; }
float b2PrismaticJoint_GetUpperLimit( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->prismaticJoint.upperTranslation; }

// ---- wheel ----
bool  b2WheelJoint_IsSpringEnabled( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->wheelJoint.enableSpring; }
float b2WheelJoint_GetSpringHertz( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->wheelJoint.hertz; }
float b2WheelJoint_GetSpringDampingRatio( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->wheelJoint.dampingRatio; }
bool  b2WheelJoint_IsMotorEnabled( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->wheelJoint.enableMotor; }
float b2WheelJoint_GetMotorSpeed( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->wheelJoint.motorSpeed; }
float b2WheelJoint_GetMaxMotorTorque( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->wheelJoint.maxMotorTorque; }
bool  b2WheelJoint_IsLimitEnabled( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->wheelJoint.enableLimit; }
float b2WheelJoint_GetLowerLimit( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->wheelJoint.lowerTranslation; }
float b2WheelJoint_GetUpperLimit( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->wheelJoint.upperTranslation; }

// ---- weld ----
float b2WeldJoint_GetLinearHertz( b2World* w, b2JointId* id )  { return b2Joint_GetSim( w, id )->weldJoint.linearHertz; }
float b2WeldJoint_GetLinearDampingRatio( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->weldJoint.linearDampingRatio; }
float b2WeldJoint_GetAngularHertz( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->weldJoint.angularHertz; }
float b2WeldJoint_GetAngularDampingRatio( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->weldJoint.angularDampingRatio; }

// ---- motor ----
void  b2MotorJoint_GetLinearVelocity( b2World* w, b2JointId* id, b2Vec2* result ) { *result = b2Joint_GetSim( w, id )->motorJoint.linearVelocity; }
float b2MotorJoint_GetAngularVelocity( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->motorJoint.angularVelocity; }
float b2MotorJoint_GetMaxVelocityForce( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->motorJoint.maxVelocityForce; }
float b2MotorJoint_GetMaxVelocityTorque( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->motorJoint.maxVelocityTorque; }
float b2MotorJoint_GetLinearHertz( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->motorJoint.linearHertz; }
float b2MotorJoint_GetLinearDampingRatio( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->motorJoint.linearDampingRatio; }
float b2MotorJoint_GetAngularHertz( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->motorJoint.angularHertz; }
float b2MotorJoint_GetAngularDampingRatio( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->motorJoint.angularDampingRatio; }
void  b2MotorJoint_SetMaxSpringForce( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->motorJoint.maxSpringForce = v; }
float b2MotorJoint_GetMaxSpringForce( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->motorJoint.maxSpringForce; }
void  b2MotorJoint_SetMaxSpringTorque( b2World* w, b2JointId* id, float v ) { b2Joint_GetSim( w, id )->motorJoint.maxSpringTorque = v; }
float b2MotorJoint_GetMaxSpringTorque( b2World* w, b2JointId* id ) { return b2Joint_GetSim( w, id )->motorJoint.maxSpringTorque; }


// =============================================================================
//   Joint reaction forces (API batch 4). Every value here is impulse * inv_h,
//   where inv_h is the last step's substep rate (world->inv_h, persisted in
//   b2World_Step). Reads zero before the first step. Motor force/torque are a
//   single impulse; the whole-constraint force/torque sum the constraint's
//   impulses (and, for the axis-based joints, project onto the current axis).
//   These enable break-on-force gameplay (compare against force/torqueThreshold).
//   b2Vec2 results use the out-pointer convention.
// =============================================================================

// ---- per-type scalar motor reactions ----
float b2DistanceJoint_GetMotorForce( b2World* w, b2JointId* id )
{ return w->inv_h * b2Joint_GetSim( w, id )->distanceJoint.motorImpulse; }
float b2RevoluteJoint_GetMotorTorque( b2World* w, b2JointId* id )
{ return w->inv_h * b2Joint_GetSim( w, id )->revoluteJoint.motorImpulse; }
float b2PrismaticJoint_GetMotorForce( b2World* w, b2JointId* id )
{ return w->inv_h * b2Joint_GetSim( w, id )->prismaticJoint.motorImpulse; }
float b2WheelJoint_GetMotorTorque( b2World* w, b2JointId* id )
{ return w->inv_h * b2Joint_GetSim( w, id )->wheelJoint.motorImpulse; }

// The current world-space +x axis of a joint's frame A (its localFrameA rotated by
// body A's rotation). Prismatic/wheel project their reaction onto this + its perp.
void b2GetJointAxisA( b2World* world, b2JointSim* base, b2Vec2* result )
{
    b2WorldTransform xfA;  b2GetBodyTransform( world, base->bodyIdA, &xfA );
    b2Vec2 unitX;  unitX.x = 1.0;  unitX.y = 0.0;
    b2Vec2 localAxisA;  b2RotateVector( &base->localFrameA.q, &unitX, &localAxisA );
    b2RotateVector( &xfA.q, &localAxisA, result );
}

// ---- per-type constraint FORCE (b2Vec2, out-ptr) ----
void b2GetJointConstraintForce( b2World* world, b2Joint* joint, b2Vec2* result )
{
    b2JointSim* base = b2GetJointSim( world, joint );
    float inv_h = world->inv_h;

    if( joint->type == b2_revoluteJoint )
    {
        b2MulSV( inv_h, &base->revoluteJoint.linearImpulse, result );
    }
    else if( joint->type == b2_weldJoint )
    {
        b2MulSV( inv_h, &base->weldJoint.linearImpulse, result );
    }
    else if( joint->type == b2_motorJoint )
    {
        b2Vec2 sum;  b2Add( &base->motorJoint.linearVelocityImpulse, &base->motorJoint.linearSpringImpulse, &sum );
        b2MulSV( inv_h, &sum, result );
    }
    else if( joint->type == b2_distanceJoint )
    {
        // force along the current anchor-to-anchor axis
        b2DistanceJoint* dj = &base->distanceJoint;
        b2WorldTransform xfA;  b2GetBodyTransform( world, base->bodyIdA, &xfA );
        b2WorldTransform xfB;  b2GetBodyTransform( world, base->bodyIdB, &xfB );
        b2Vec2 pA;  b2TransformPoint( &xfA, &base->localFrameA.p, &pA );
        b2Vec2 pB;  b2TransformPoint( &xfB, &base->localFrameB.p, &pB );
        b2Vec2 d;   b2Sub( &pB, &pA, &d );
        b2Vec2 axis;  b2Normalize( &d, &axis );
        float f = ( dj->impulse + dj->lowerImpulse - dj->upperImpulse + dj->motorImpulse ) * inv_h;
        b2MulSV( f, &axis, result );
    }
    else if( joint->type == b2_prismaticJoint )
    {
        b2PrismaticJoint* pj = &base->prismaticJoint;
        b2Vec2 axisA;  b2GetJointAxisA( world, base, &axisA );
        b2Vec2 perpA;  b2LeftPerp( &axisA, &perpA );
        float perpForce  = inv_h * pj->impulse.x;
        float axialForce = inv_h * ( pj->motorImpulse + pj->lowerImpulse - pj->upperImpulse );
        b2Vec2 fp;  b2MulSV( perpForce, &perpA, &fp );
        b2Vec2 fa;  b2MulSV( axialForce, &axisA, &fa );
        b2Add( &fp, &fa, result );
    }
    else if( joint->type == b2_wheelJoint )
    {
        b2WheelJoint* wj = &base->wheelJoint;
        b2Vec2 axisA;  b2GetJointAxisA( world, base, &axisA );
        b2Vec2 perpA;  b2LeftPerp( &axisA, &perpA );
        float perpForce  = inv_h * wj->perpImpulse;
        float axialForce = inv_h * ( wj->springImpulse + wj->lowerImpulse - wj->upperImpulse );
        b2Vec2 fp;  b2MulSV( perpForce, &perpA, &fp );
        b2Vec2 fa;  b2MulSV( axialForce, &axisA, &fa );
        b2Add( &fp, &fa, result );
    }
    else
    {
        *result = b2Vec2_zero;   // filter joint (and any future no-payload type)
    }
}

// ---- per-type constraint TORQUE (scalar) ----
float b2GetJointConstraintTorque( b2World* world, b2Joint* joint )
{
    b2JointSim* base = b2GetJointSim( world, joint );
    float inv_h = world->inv_h;

    if( joint->type == b2_revoluteJoint )
    {
        b2RevoluteJoint* rj = &base->revoluteJoint;
        return inv_h * ( rj->motorImpulse + rj->lowerImpulse - rj->upperImpulse );
    }
    if( joint->type == b2_prismaticJoint )
        return inv_h * base->prismaticJoint.impulse.y;
    if( joint->type == b2_wheelJoint )
        return inv_h * base->wheelJoint.motorImpulse;
    if( joint->type == b2_weldJoint )
        return inv_h * base->weldJoint.angularImpulse;
    if( joint->type == b2_motorJoint )
        return inv_h * ( base->motorJoint.angularVelocityImpulse + base->motorJoint.angularSpringImpulse );
    return 0.0;   // distance + filter joints exert no reaction torque
}

// ---- public base wrappers ----
void b2Joint_GetConstraintForce( b2World* world, b2JointId* id, b2Vec2* result )
{
    b2Joint* joint = &world->joints.data[ id->index1 - 1 ];
    b2GetJointConstraintForce( world, joint, result );
}
float b2Joint_GetConstraintTorque( b2World* world, b2JointId* id )
{
    b2Joint* joint = &world->joints.data[ id->index1 - 1 ];
    return b2GetJointConstraintTorque( world, joint );
}


// =============================================================================
//   Joint geometric queries (API batch 5). Diagnostics derived from the LIVE body
//   transforms/velocities, not stored fields: how long a distance joint currently
//   is, how fast a prismatic is sliding, and how far a joint has drifted from the
//   constraint it enforces (linear + angular separation, per type). Ported faithful
//   to upstream joint.c; the relative-transform precision trick is dropped (it
//   subtracts a common origin that cancels in the anchor difference, and the port
//   is single-precision). NOTE upstream's separation code takes the joint axis from
//   body A's rotation ALONE (not localFrameA.q) -- matched here per-function.
// =============================================================================

// Current anchor-to-anchor distance of a distance joint (vs its rest `length`).
float b2DistanceJoint_GetCurrentLength( b2World* world, b2JointId* id )
{
    b2JointSim* base = b2Joint_GetSim( world, id );
    b2WorldTransform xfA;  b2GetBodyTransform( world, base->bodyIdA, &xfA );
    b2WorldTransform xfB;  b2GetBodyTransform( world, base->bodyIdB, &xfB );
    b2Vec2 pA;  b2TransformPoint( &xfA, &base->localFrameA.p, &pA );
    b2Vec2 pB;  b2TransformPoint( &xfB, &base->localFrameB.p, &pB );
    b2Vec2 d;   b2Sub( &pB, &pA, &d );
    return b2Length( &d );
}

// Signed sliding speed of a prismatic joint along its axis (upstream GetSpeed).
float b2PrismaticJoint_GetSpeed( b2World* world, b2JointId* id )
{
    b2JointSim* base = b2Joint_GetSim( world, id );
    b2Body* bodyA = &world->bodies.data[ base->bodyIdA ];
    b2Body* bodyB = &world->bodies.data[ base->bodyIdB ];
    b2BodySim* simA = b2GetBodySim( world, bodyA );
    b2BodySim* simB = b2GetBodySim( world, bodyB );
    b2BodyState* stA = b2GetBodyState( world, bodyA );
    b2BodyState* stB = b2GetBodyState( world, bodyB );

    b2Vec2 unitX;  unitX.x = 1.0;  unitX.y = 0.0;
    b2Vec2 localAxisA;  b2RotateVector( &base->localFrameA.q, &unitX, &localAxisA );
    b2Vec2 axisA;  b2RotateVector( &simA->transform.q, &localAxisA, &axisA );

    b2Vec2 offA;  b2Sub( &base->localFrameA.p, &simA->localCenter, &offA );
    b2Vec2 rA;    b2RotateVector( &simA->transform.q, &offA, &rA );
    b2Vec2 offB;  b2Sub( &base->localFrameB.p, &simB->localCenter, &offB );
    b2Vec2 rB;    b2RotateVector( &simB->transform.q, &offB, &rB );

    b2Vec2 dc;  b2SubPos( &simB->center, &simA->center, &dc );
    b2Vec2 rDiff;  b2Sub( &rB, &rA, &rDiff );
    b2Vec2 d;   b2Add( &dc, &rDiff, &d );

    b2Vec2 vA;  float wA;
    if( stA != NULL ) { vA = stA->linearVelocity;  wA = stA->angularVelocity; }
    else              { vA = b2Vec2_zero;          wA = 0.0; }
    b2Vec2 vB;  float wB;
    if( stB != NULL ) { vB = stB->linearVelocity;  wB = stB->angularVelocity; }
    else              { vB = b2Vec2_zero;          wB = 0.0; }

    b2Vec2 spinB;  b2CrossSV( wB, &rB, &spinB );
    b2Vec2 velB;   b2Add( &vB, &spinB, &velB );
    b2Vec2 spinA;  b2CrossSV( wA, &rA, &spinA );
    b2Vec2 velA;   b2Add( &vA, &spinA, &velA );
    b2Vec2 vRel;   b2Sub( &velB, &velA, &vRel );

    b2Vec2 wAxisA;  b2CrossSV( wA, &axisA, &wAxisA );
    return b2Dot( &d, &wAxisA ) + b2Dot( &axisA, &vRel );
}

// How far the joint's anchors have drifted apart in the constrained direction.
float b2Joint_GetLinearSeparation( b2World* world, b2JointId* id )
{
    b2Joint* joint = &world->joints.data[ id->index1 - 1 ];
    b2JointSim* base = b2GetJointSim( world, joint );

    b2WorldTransform xfA;  b2GetBodyTransform( world, base->bodyIdA, &xfA );
    b2WorldTransform xfB;  b2GetBodyTransform( world, base->bodyIdB, &xfB );
    b2Vec2 pA;  b2TransformPoint( &xfA, &base->localFrameA.p, &pA );
    b2Vec2 pB;  b2TransformPoint( &xfB, &base->localFrameB.p, &pB );
    b2Vec2 dp;  b2Sub( &pB, &pA, &dp );

    if( joint->type == b2_revoluteJoint )
        return b2Length( &dp );

    if( joint->type == b2_distanceJoint )
    {
        b2DistanceJoint* dj = &base->distanceJoint;
        float length = b2Length( &dp );
        if( dj->enableSpring )
        {
            if( dj->enableLimit )
            {
                if( length < dj->minLength )  return dj->minLength - length;
                if( length > dj->maxLength )  return length - dj->maxLength;
            }
            return 0.0;
        }
        return b2AbsFloat( length - dj->length );
    }

    if( joint->type == b2_weldJoint )
    {
        if( base->weldJoint.linearHertz == 0.0 )  return b2Length( &dp );
        return 0.0;
    }

    if( joint->type == b2_prismaticJoint || joint->type == b2_wheelJoint )
    {
        b2Vec2 unitX;  unitX.x = 1.0;  unitX.y = 0.0;
        b2Vec2 axisA;  b2RotateVector( &xfA.q, &unitX, &axisA );
        b2Vec2 perpA;  b2LeftPerp( &axisA, &perpA );
        float perpSep = b2AbsFloat( b2Dot( &perpA, &dp ) );
        float limitSep = 0.0;

        bool  enableLimit;  float lower;  float upper;
        if( joint->type == b2_prismaticJoint )
        {
            enableLimit = base->prismaticJoint.enableLimit;
            lower = base->prismaticJoint.lowerTranslation;
            upper = base->prismaticJoint.upperTranslation;
        }
        else
        {
            enableLimit = base->wheelJoint.enableLimit;
            lower = base->wheelJoint.lowerTranslation;
            upper = base->wheelJoint.upperTranslation;
        }
        if( enableLimit )
        {
            float translation = b2Dot( &axisA, &dp );
            if( translation < lower )  limitSep = lower - translation;
            if( upper < translation )  limitSep = translation - upper;
        }
        return sqrt( perpSep * perpSep + limitSep * limitSep );
    }

    return 0.0;   // motor + filter joints have no linear constraint
}

// Angular drift from the constraint (per type; upstream b2Joint_GetAngularSeparation).
float b2Joint_GetAngularSeparation( b2World* world, b2JointId* id )
{
    b2Joint* joint = &world->joints.data[ id->index1 - 1 ];
    b2JointSim* base = b2GetJointSim( world, joint );

    b2WorldTransform xfA;  b2GetBodyTransform( world, base->bodyIdA, &xfA );
    b2WorldTransform xfB;  b2GetBodyTransform( world, base->bodyIdB, &xfB );
    float relativeAngle = b2RelativeAngle( &xfA.q, &xfB.q );

    if( joint->type == b2_prismaticJoint )
        return relativeAngle;

    if( joint->type == b2_revoluteJoint )
    {
        b2RevoluteJoint* rj = &base->revoluteJoint;
        if( rj->enableLimit )
        {
            if( relativeAngle < rj->lowerAngle )  return rj->lowerAngle - relativeAngle;
            if( rj->upperAngle < relativeAngle )  return relativeAngle - rj->upperAngle;
        }
        return 0.0;
    }

    if( joint->type == b2_weldJoint )
    {
        if( base->weldJoint.angularHertz == 0.0 )  return relativeAngle;
        return 0.0;
    }

    return 0.0;   // distance + motor + wheel + filter: no angular lock reported
}


// =============================================================================
//   WAKING (Phase C2b) -- migrate a sleeping solver set back to the awake set.
//   The inverse of b2TrySleepIsland: since we're emptying the WHOLE source set, no
//   swap-remove from the source is needed -- read each sim, APPEND it to the awake
//   set, then free the source set. Bodies get a fresh zero-velocity state (they were
//   at rest) and sleepTime is reset. Waking only ever GROWS the awake arrays, so a
//   caller mid-iterating awakeSet->contactSims (b2Collide) just needs to refetch the
//   .data pointer afterward -- existing [0,i] entries never move.
// =============================================================================
void b2DestroySolverSet( b2World* world, int setIndex )
{
    b2SolverSet* set = &world->solverSets.data[ setIndex ];
    if( set->bodySims.data != NULL )    b2Free( set->bodySims.data, set->bodySims.capacity * sizeof( b2BodySim ) );
    if( set->bodyStates.data != NULL )  b2Free( set->bodyStates.data, set->bodyStates.capacity * sizeof( b2BodyState ) );
    if( set->contactSims.data != NULL ) b2Free( set->contactSims.data, set->contactSims.capacity * sizeof( b2ContactSim ) );
    if( set->jointSims.data != NULL )   b2Free( set->jointSims.data, set->jointSims.capacity * sizeof( b2JointSim ) );
    if( set->islandSims.data != NULL )  b2Free( set->islandSims.data, set->islandSims.capacity * sizeof( b2IslandSim ) );
    set->bodySims.data = NULL;    set->bodySims.count = 0;    set->bodySims.capacity = 0;
    set->bodyStates.data = NULL;  set->bodyStates.count = 0;  set->bodyStates.capacity = 0;
    set->contactSims.data = NULL; set->contactSims.count = 0; set->contactSims.capacity = 0;
    set->jointSims.data = NULL;   set->jointSims.count = 0;   set->jointSims.capacity = 0;
    set->islandSims.data = NULL;  set->islandSims.count = 0;  set->islandSims.capacity = 0;
    set->setIndex = B2_NULL_INDEX;
    b2FreeId( &world->solverSetIdPool, setIndex );
}

void b2WakeSolverSet( b2World* world, int setIndex )
{
    if( setIndex < b2_firstSleepingSet )
        return;   // only sleeping sets wake (static/disabled/awake never do)

    b2SolverSet* set = &world->solverSets.data[ setIndex ];
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    int i;

    // bodies -> awake (append sim + a fresh zero-velocity/identity state)
    for( i = 0; i < set->bodySims.count; ++i )
    {
        int bodyId = set->bodySims.data[i].bodyId;
        b2Body* body = &world->bodies.data[ bodyId ];

        awakeSet->bodySims.data = b2GrowArray( awakeSet->bodySims.data, &awakeSet->bodySims.capacity,
                                               awakeSet->bodySims.count + 1, sizeof( b2BodySim ) );
        int idx = awakeSet->bodySims.count;
        awakeSet->bodySims.data[ idx ] = set->bodySims.data[i];
        awakeSet->bodySims.count = awakeSet->bodySims.count + 1;

        awakeSet->bodyStates.data = b2GrowArray( awakeSet->bodyStates.data, &awakeSet->bodyStates.capacity,
                                                 awakeSet->bodyStates.count + 1, sizeof( b2BodyState ) );
        b2BodyState* st = &awakeSet->bodyStates.data[ idx ];
        st->linearVelocity = b2Vec2_zero;
        st->angularVelocity = 0.0;
        st->flags = 0;
        st->deltaPosition = b2Vec2_zero;
        st->deltaRotation = b2Rot_identity;
        awakeSet->bodyStates.count = awakeSet->bodyStates.count + 1;

        body->setIndex = b2_awakeSet;
        body->localIndex = idx;
        body->sleepTime = 0.0;
    }

    // touching contacts -> awake
    for( i = 0; i < set->contactSims.count; ++i )
    {
        b2Contact* contact = &world->contacts.data[ set->contactSims.data[i].contactId ];
        awakeSet->contactSims.data = b2GrowArray( awakeSet->contactSims.data, &awakeSet->contactSims.capacity,
                                                  awakeSet->contactSims.count + 1, sizeof( b2ContactSim ) );
        int idx = awakeSet->contactSims.count;
        awakeSet->contactSims.data[ idx ] = set->contactSims.data[i];
        awakeSet->contactSims.count = awakeSet->contactSims.count + 1;
        contact->setIndex = b2_awakeSet;
        contact->localIndex = idx;
    }

    // joints -> awake
    for( i = 0; i < set->jointSims.count; ++i )
    {
        b2Joint* joint = &world->joints.data[ set->jointSims.data[i].jointId ];
        awakeSet->jointSims.data = b2GrowArray( awakeSet->jointSims.data, &awakeSet->jointSims.capacity,
                                                awakeSet->jointSims.count + 1, sizeof( b2JointSim ) );
        int idx = awakeSet->jointSims.count;
        awakeSet->jointSims.data[ idx ] = set->jointSims.data[i];
        awakeSet->jointSims.count = awakeSet->jointSims.count + 1;
        joint->setIndex = b2_awakeSet;
        joint->localIndex = idx;
    }

    // islands -> awake
    for( i = 0; i < set->islandSims.count; ++i )
    {
        int islandId = set->islandSims.data[i].islandId;
        b2Island* island = &world->islands.data[ islandId ];
        awakeSet->islandSims.data = b2GrowArray( awakeSet->islandSims.data, &awakeSet->islandSims.capacity,
                                                 awakeSet->islandSims.count + 1, sizeof( b2IslandSim ) );
        int idx = awakeSet->islandSims.count;
        awakeSet->islandSims.data[ idx ].islandId = islandId;
        awakeSet->islandSims.count = awakeSet->islandSims.count + 1;
        island->setIndex = b2_awakeSet;
        island->localIndex = idx;
    }

    b2DestroySolverSet( world, setIndex );
}


// -----------------------------------------------------------------------------
//   Narrow phase: recompute manifolds + touching status for all awake contacts
// -----------------------------------------------------------------------------
//   Simplified port of b2Collide (physics_world.c). DEVIATIONS: no constraint
//   graph yet, so EVERY awake contact (touching or not) lives in
//   awakeSet->contactSims -- there is no touching<->graph-color migration, no
//   contact begin/end events. Also serial: the parallel-for + per-worker
//   contactStateBitSet are collapsed to one loop. We maintain ONLY the cold
//   contact's b2_contactTouchingFlag; the b2_simStartedTouching/StoppedTouching
//   bits are left unset (no consumer yet).
//
//   P0.2 DISJOINT DESTROY (upstream b2_simDisjoint path): a contact whose fat
//   AABBs no longer overlap is DESTROYED here, so contacts no longer accrete
//   forever as a body travels (unbounded contactSims/pairSet growth).
//
//   ITERATION SAFETY: the loop runs BACKWARD because b2DestroyContact swap-
//   removes from this very array (it moves the LAST sim into the freed slot i).
//   Backward, every slot above i is already processed, so the swapped-in sim is
//   either already-processed or was appended by a mid-loop wake (it gets its
//   narrow phase next step -- same as before, when appended entries were beyond
//   the count snapshot). Wakes only APPEND; entries [0, i] never move -- but
//   .data may realloc on append, hence the refetch after any wake.
void b2Collide( b2World* world )
{
    b2SolverSet* awakeSet = &world->solverSets.data[ b2_awakeSet ];
    int i;
    for( i = awakeSet->contactSims.count - 1; i >= 0; --i )
    {
        b2ContactSim* contactSim = &awakeSet->contactSims.data[i];
        int contactId = contactSim->contactId;
        b2Contact* contact = &world->contacts.data[ contactId ];

        // shapes are stored primary-ordered (b2CreateContact flips), so this is
        // exactly the order b2UpdateContact's dispatch expects.
        b2Shape* shapeA = &world->shapes.data[ contactSim->shapeIdA ];
        b2Shape* shapeB = &world->shapes.data[ contactSim->shapeIdB ];

        // read the PREVIOUS touching state before b2UpdateContact overwrites it
        bool wasTouching = ( contactSim->simFlags & b2_simTouchingFlag ) != 0;

        b2Body* bodyA = &world->bodies.data[ shapeA->bodyId ];
        b2Body* bodyB = &world->bodies.data[ shapeB->bodyId ];

        // Phase C: skip a contact whose BOTH bodies are non-awake (a frozen pair --
        // two sleeping bodies, or a sleeping body vs a static one). Nothing moves, so
        // the manifold can't change. A contact with an AWAKE endpoint is still run
        // (that's how an approach against a sleeper is detected -> C2b wakes it). This
        // never fires pre-sleep: dynamic bodies are awake, so dynamic/static and
        // dynamic/dynamic pairs always have an awake side.
        if( bodyA->setIndex != b2_awakeSet && bodyB->setIndex != b2_awakeSet )
            continue;

        // DISJOINT DESTROY (P0.2, upstream physics_world.c b2_simDisjoint): the
        // shapes' FAT AABBs no longer overlap -> destroy the contact. This is the
        // same fat box the broad phase pairs on (the tree stores it), so a pair
        // that stops fat-overlapping here won't be immediately re-created; only a
        // proxy MOVING back into range re-pairs it. Destroy handles everything
        // (island unlink, edge lists, pairSet, sim swap-remove into slot i --
        // backward iteration makes that safe, see loop header). wakeBodies=false
        // per upstream: at least one endpoint is awake (both-non-awake pairs were
        // skipped above), so nothing here can strand a sleeper.
        if( b2AABB_Overlaps( &shapeA->fatAABB, &shapeB->fatAABB ) == false )
        {
            // a touching contact torn down by separation is an end-touch event (P1.3)
            if( wasTouching && b2ShouldReportContactEvents( shapeA, shapeB ) )
                b2AddTouchEvent( &world->endTouchEvents, contactSim->shapeIdA, contactSim->shapeIdB );
            b2DestroyContact( world, contact, false );
            continue;
        }

        b2BodySim* bodySimA = b2GetBodySim( world, bodyA );
        b2BodySim* bodySimB = b2GetBodySim( world, bodyB );

        // transient solver caches (no solver consumer yet; wired for fidelity).
        // The dense bodySim index is only meaningful for awake bodies.
        if( bodyA->setIndex == b2_awakeSet )
            contactSim->bodySimIndexA = bodyA->localIndex;
        else
            contactSim->bodySimIndexA = B2_NULL_INDEX;
        contactSim->invMassA = bodySimA->invMass;
        contactSim->invIA = bodySimA->invInertia;

        if( bodyB->setIndex == b2_awakeSet )
            contactSim->bodySimIndexB = bodyB->localIndex;
        else
            contactSim->bodySimIndexB = B2_NULL_INDEX;
        contactSim->invMassB = bodySimB->invMass;
        contactSim->invIB = bodySimB->invInertia;

        // center-of-mass offsets (world rotation of each body's local center)
        b2Transform* transformA = &bodySimA->transform;
        b2Transform* transformB = &bodySimB->transform;
        b2Vec2 centerOffsetA;  b2RotateVector( &transformA->q, &bodySimA->localCenter, &centerOffsetA );
        b2Vec2 centerOffsetB;  b2RotateVector( &transformB->q, &bodySimB->localCenter, &centerOffsetB );

        // DISJOINT EARLY-OUT (recovers the fat-AABB COLLIDE cost): if the two shapes'
        // speculative-padded AABBs don't overlap, they are separated beyond speculative
        // distance -> b2ComputeManifold would return 0 points anyway. Skip the whole
        // narrow phase and mark not-touching. The contact is KEPT: the fat boxes still
        // overlap (checked above), so the pair is only marginally separated
        // (hysteresis band between speculative and fat margins). (Zeroing pointCount
        // also resets warm start on re-touch, which is correct for a separated pair.)
        bool touching;
        if( b2AABB_Overlaps( &shapeA->aabb, &shapeB->aabb ) == false )
        {
            contactSim->manifold.pointCount = 0;
            contactSim->simFlags = contactSim->simFlags & ~b2_simTouchingFlag;
            touching = false;
        }
        else
        {
            touching = b2UpdateContact( contactSim, shapeA, transformA, &centerOffsetA,
                                        shapeB, transformB, &centerOffsetB );
        }

        // maintain the cold contact's touching flag on a state change, and link/
        // unlink the contact in the island graph. (DEFERRED: graph migration, events.)
        if( touching && wasTouching == false )
        {
            contact->flags = contact->flags | b2_contactTouchingFlag;

            // begin-touch event (P1.3): shape ids in the contact's primary order
            if( b2ShouldReportContactEvents( shapeA, shapeB ) )
                b2AddTouchEvent( &world->beginTouchEvents, contactSim->shapeIdA, contactSim->shapeIdB );

            // C2b WAKE: if an awake body just started touching a SLEEPING one, wake the
            // sleeper's whole set first. Waking only APPENDS to awakeSet->contactSims,
            // so entries [0,i] don't move -- but the .data pointer may realloc, so we
            // refetch contactSim right after. (This iteration's cached bodySimIndex for
            // the just-woken body stays NULL for one step -> a 1-step solve glitch on
            // the waking contact only; it is correct from the next step.)
            if( bodyA->setIndex >= b2_firstSleepingSet )  b2WakeSolverSet( world, bodyA->setIndex );
            if( bodyB->setIndex >= b2_firstSleepingSet )  b2WakeSolverSet( world, bodyB->setIndex );
            contactSim = &awakeSet->contactSims.data[i];

            // A just-woken body was cached as static earlier this iteration (its sim
            // index was NULL while asleep). Refresh the cached sim indices + masses so
            // the solver treats it as DYNAMIC this step -- otherwise the wake-step
            // impulse is dropped and a fast body bounces off a just-woken pile without
            // moving it. (bodySimA/B pointed into the now-freed sleeping set -> refetch.)
            bodySimA = b2GetBodySim( world, bodyA );
            bodySimB = b2GetBodySim( world, bodyB );
            if( bodyA->setIndex == b2_awakeSet )  contactSim->bodySimIndexA = bodyA->localIndex;
            if( bodyB->setIndex == b2_awakeSet )  contactSim->bodySimIndexB = bodyB->localIndex;
            contactSim->invMassA = bodySimA->invMass;  contactSim->invIA = bodySimA->invInertia;
            contactSim->invMassB = bodySimB->invMass;  contactSim->invIB = bodySimB->invInertia;

            b2LinkContact( world, contact );
        }
        else if( touching == false && wasTouching )
        {
            contact->flags = contact->flags & ~b2_contactTouchingFlag;

            // end-touch event (P1.3): still-alive contact that stopped touching
            if( b2ShouldReportContactEvents( shapeA, shapeB ) )
                b2AddTouchEvent( &world->endTouchEvents, contactSim->shapeIdA, contactSim->shapeIdB );

            b2UnlinkContact( world, contact );
        }

        // cache baseSeparation for the next step (constant-index unroll: points[]
        // is a fixed array member of a multi-word struct)
        if( contactSim->manifold.pointCount >= 1 )
            contactSim->manifold.points[0].baseSeparation = contactSim->manifold.points[0].separation;
        if( contactSim->manifold.pointCount >= 2 )
            contactSim->manifold.points[1].baseSeparation = contactSim->manifold.points[1].separation;
    }
}


// Pair-query context threaded through the tree query (plain struct, no fn ptrs).
struct b2QueryPairContext
{
    b2World* world;
    int queryProxyKey;
    int queryShapeIndex;
    int queryTreeType;
};

// Tree-query callback: for each overlapping proxy, apply the dedup checks and,
// if it's a genuinely new collidable pair, create the contact.
bool b2PairQueryCallback( int proxyId, int shapeId, void* context )
{
    b2QueryPairContext* qc = context;
    b2World* world = qc->world;
    b2BroadPhase* bp = &world->broadPhase;

    int proxyKey = B2_PROXY_KEY( proxyId, qc->queryTreeType );
    if( proxyKey == qc->queryProxyKey )
        return true;   // a proxy can't pair with itself

    // de-dup when both proxies moved: emit the pair from only one side
    int queryProxyType = B2_PROXY_TYPE( qc->queryProxyKey );
    if( queryProxyType == b2_dynamicBody )
    {
        if( qc->queryTreeType == b2_dynamicBody && proxyKey < qc->queryProxyKey )
        {
            if( b2GetBit( &bp->movedProxies[ qc->queryTreeType ], proxyId ) )
                return true;
        }
    }
    else
    {
        if( b2GetBit( &bp->movedProxies[ qc->queryTreeType ], proxyId ) )
            return true;
    }

    // already have a contact for this shape pair?
    if( b2ContainsKey( &bp->pairSet, shapeId, qc->queryShapeIndex ) )
        return true;

    int shapeIdA;  int shapeIdB;
    if( proxyKey < qc->queryProxyKey )
    {
        shapeIdA = shapeId;             shapeIdB = qc->queryShapeIndex;
    }
    else
    {
        shapeIdA = qc->queryShapeIndex; shapeIdB = shapeId;
    }

    b2Shape* shapeA = &world->shapes.data[ shapeIdA ];
    b2Shape* shapeB = &world->shapes.data[ shapeIdB ];

    if( shapeA->bodyId == shapeB->bodyId )
        return true;   // shapes on the same body

    if( b2CanCollide( shapeA->type, shapeB->type ) == false )
        return true;

    // collision filter (P1.2): category/mask + group override. Ragdolls use a
    // negative group so a body's own bones never collide with each other.
    if( b2ShouldShapesCollide( &shapeA->filter, &shapeB->filter ) == false )
        return true;

    // collideConnected: skip the pair if a joint joins these bodies with it false.
    if( b2ShouldBodiesCollide( world, shapeA->bodyId, shapeB->bodyId ) == false )
        return true;

    // sensors never generate a physical contact -- overlap is reported separately
    // by the sensor pass (b2OverlapSensors), which produces no impulse.
    if( shapeA->isSensor || shapeB->isSensor )
        return true;

    // (deferred) custom-filter checks

    b2CreateContact( world, shapeA, shapeB );
    return true;
}

// Find new overlapping pairs for every proxy that moved this step, then clear
// the move buffer. (Single-threaded; upstream's parallel moveResults/movePairs
// emit is deferred.)
void b2UpdateBroadPhasePairs( b2World* world )
{
    b2BroadPhase* bp = &world->broadPhase;
    int moveCount = bp->moveCount;
    int i;
    for( i = 0; i < moveCount; ++i )
    {
        int proxyKey = bp->moveArray[i];
        if( proxyKey == B2_NULL_INDEX )
            continue;

        int proxyType = B2_PROXY_TYPE( proxyKey );
        int proxyId = B2_PROXY_ID( proxyKey );

        b2QueryPairContext qc;
        qc.world = world;
        qc.queryProxyKey = proxyKey;

        b2AABB fatAABB;
        b2DynamicTree_GetAABB( &bp->trees[ proxyType ], proxyId, &fatAABB );
        qc.queryShapeIndex = b2DynamicTree_GetUserData( &bp->trees[ proxyType ], proxyId );

        b2TreeStats st;
        // dynamic proxies query the kinematic + static trees too
        if( proxyType == b2_dynamicBody )
        {
            qc.queryTreeType = b2_kinematicBody;
            b2DynamicTree_QueryAll( &bp->trees[ b2_kinematicBody ], &fatAABB, &b2PairQueryCallback, &qc, &st );
            qc.queryTreeType = b2_staticBody;
            b2DynamicTree_QueryAll( &bp->trees[ b2_staticBody ], &fatAABB, &b2PairQueryCallback, &qc, &st );
        }
        // everything queries the dynamic tree
        qc.queryTreeType = b2_dynamicBody;
        b2DynamicTree_QueryAll( &bp->trees[ b2_dynamicBody ], &fatAABB, &b2PairQueryCallback, &qc, &st );
    }

    b2BroadPhase_ClearMoveBuffer( bp );
}


// -----------------------------------------------------------------------------
//   SENSORS (P1.5): overlap detection with no collision response.
// -----------------------------------------------------------------------------
//   Minimal port of upstream sensor.c. DEVIATIONS from upstream:
//   - No separate world->sensors registry / sensorIndex. The overlap set lives
//     directly on the (sparse, stable) b2Shape, and b2OverlapSensors scans all
//     shapes -- simpler, avoids the registry swap-repair; O(shapes) per step.
//   - Visitor identity is the raw shapeId only (no generation tie-break), so a
//     shape id recycled onto a new shape between steps could miss a begin/end
//     transition. Acceptable until generation-checked ids are threaded through.
//   - A sensor does not detect other sensors (visitor->isSensor skipped).

struct b2SensorQueryCtx
{
    b2World* world;
    b2Shape* sensorShape;
    b2Transform sensorTransform;
    int count;                 // # visitor ids appended to world->sensorScratch
};

// Tree-query callback: for a candidate shape whose fat AABB overlaps the sensor,
// run the exact filters + a GJK overlap test (upstream b2SensorQueryCallback), and
// append truly-overlapping visitor shape ids to world->sensorScratch.
bool b2SensorQueryCallback( int proxyId, int shapeId, void* context )
{
    b2SensorQueryCtx* qc = context;
    b2World* world = qc->world;
    b2Shape* sensorShape = qc->sensorShape;

    if( shapeId == sensorShape->id )
        return true;                              // itself

    b2Shape* other = &world->shapes.data[ shapeId ];
    if( other->id == B2_NULL_INDEX )
        return true;                              // freed slot
    if( other->enableSensorEvents == false )
        return true;
    if( other->isSensor )
        return true;                              // sensors don't detect sensors (deviation)
    if( other->bodyId == sensorShape->bodyId )
        return true;                              // same body
    if( b2ShouldShapesCollide( &sensorShape->filter, &other->filter ) == false )
        return true;

    // GJK overlap test in world space: distance ~ 0 with radii considered.
    b2WorldTransform otherTransform;
    b2GetBodyTransform( world, other->bodyId, &otherTransform );

    b2DistanceInput input;
    b2MakeShapeProxy( sensorShape, &input.proxyA );
    b2MakeShapeProxy( other, &input.proxyB );
    b2InvMulTransforms( &qc->sensorTransform, &otherTransform, &input.transform );
    input.useRadii = true;

    b2SimplexCache cache;  cache.count = 0;
    b2DistanceOutput output;
    b2ShapeDistance( &input, &cache, &output );

    if( output.distance < 10.0 * FLT_EPSILON )
    {
        world->sensorScratch = b2GrowArray( world->sensorScratch, &world->sensorScratchCapacity,
                                            qc->count + 1, sizeof( int ) );
        world->sensorScratch[ qc->count ] = shapeId;
        qc->count = qc->count + 1;
    }
    return true;
}

// Recompute every sensor's overlap set and emit begin/end events by diffing
// against last step's set. Run AFTER the solve (bodies at final transforms).
void b2OverlapSensors( b2World* world )
{
    int shapeCount = world->shapes.count;
    int s;
    for( s = 0; s < shapeCount; ++s )
    {
        b2Shape* sensorShape = &world->shapes.data[ s ];
        if( sensorShape->id == B2_NULL_INDEX )
            continue;
        if( sensorShape->isSensor == false )
            continue;

        b2Body* body = &world->bodies.data[ sensorShape->bodyId ];

        b2SensorQueryCtx qc;
        qc.world = world;
        qc.sensorShape = sensorShape;
        qc.count = 0;

        // a disabled or event-disabled sensor drops all its overlaps (-> end events)
        bool active = ( body->setIndex != b2_disabledSet ) && sensorShape->enableSensorEvents;
        if( active )
        {
            b2GetBodyTransformQuick( world, body, &qc.sensorTransform );

            b2AABB queryBounds;
            b2ComputeShapeAABB( sensorShape, &qc.sensorTransform, &queryBounds );

            b2TreeStats st;
            int t;
            for( t = 0; t < 3; ++t )
                b2DynamicTree_QueryAll( &world->broadPhase.trees[ t ], &queryBounds,
                                        &b2SensorQueryCallback, &qc, &st );
        }
        int newCount = qc.count;

        // diff the fresh set (world->sensorScratch) against last step's (on the shape).
        // Read the OLD array fully BEFORE the grow/copy below reallocs it.
        int* oldArr = sensorShape->sensorOverlaps;
        int  oldCount = sensorShape->sensorOverlapCount;
        int* newArr = world->sensorScratch;
        int i;  int j;

        for( i = 0; i < newCount; ++i )              // begin = in new, not in old
        {
            int vid = newArr[i];
            bool found = false;
            for( j = 0; j < oldCount; ++j )
                if( oldArr[j] == vid )  { found = true;  break; }
            if( found == false )
                b2AddSensorEvent( &world->sensorBeginEvents, sensorShape->id, vid );
        }
        for( i = 0; i < oldCount; ++i )              // end = in old, not in new
        {
            int vid = oldArr[i];
            bool found = false;
            for( j = 0; j < newCount; ++j )
                if( newArr[j] == vid )  { found = true;  break; }
            if( found == false )
                b2AddSensorEvent( &world->sensorEndEvents, sensorShape->id, vid );
        }

        // persist the fresh set onto the shape (grow to fit, then copy)
        sensorShape->sensorOverlaps = b2GrowArray( sensorShape->sensorOverlaps,
                                                   &sensorShape->sensorOverlapCapacity,
                                                   newCount, sizeof( int ) );
        for( i = 0; i < newCount; ++i )
            sensorShape->sensorOverlaps[i] = world->sensorScratch[i];
        sensorShape->sensorOverlapCount = newCount;
    }
}


// *****************************************************************************
    #endif
// *****************************************************************************
