/* *****************************************************************************
*  VirconBox2D : b2_validate.h     (P0.4 -- invariant walker, HARNESS-ONLY)
*  --------------------------------------------------------------------------- *
*  A port of upstream b2ValidateSolverSets / b2ValidateConnectivity (physics_   *
*  world.c), reduced to the invariants the port actually maintains. It is the   *
*  safety net that makes the P1/P2 refactors cheap: call b2ValidateWorld()      *
*  after every step of a test/soak and it returns 0 while the sparse<->dense     *
*  indirection is intact, or a nonzero CODE identifying the first broken         *
*  invariant (map the code with the table below -- no bisection needed).         *
*                                                                              *
*  DELIBERATELY OMITTED vs upstream (would false-red on a correct port):         *
*    - constraint-graph / color validation: the port has NO graph; all touching *
*      contacts + joints live in the owning set's contactSims/jointSims arrays   *
*      (contact->colorIndex / joint->colorIndex are ALWAYS B2_NULL_INDEX).       *
*    - the syncedFlags body/bodySim/bodyState flag-mirror asserts: not an        *
*      enumerated P0.4 invariant and not maintained bit-identically here.        *
*    - awakeSet jointSims==0 (upstream parks awake joints in the graph; the      *
*      port keeps them in awakeSet->jointSims -> that count is legitimately >0). *
*                                                                              *
*  This header is compiled ONLY into harness builds (harness2.c). It is never    *
*  part of the library. Include AFTER b2_body.h / b2_solver.h.                   *
*                                                                              *
*  Fail-code map (returned by b2ValidateWorld):                                  *
*    1-5   idPool capacity != sparse-array count (body/contact/joint/island/set) *
*    10-13 per-set shape invariants (free-slot empty; static/awake/other states) *
*    20-23 body dense-walk round-trip (bodySim->bodyId -> body->setIndex/local)  *
*    30-34 contact dense-walk round-trip                                         *
*    40-46 joint dense-walk round-trip (+ jointSim<->edge bodyId agreement)      *
*    50-53 island dense-walk round-trip                                          *
*    60-64 total dense counts != idPool live counts                             *
*    70    pairSet count != total contact count                                 *
*    80-88 body forward round-trip + contact edge-list doubly-linked consistency *
*    89-94 joint edge-list doubly-linked consistency                            *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_VALIDATE_H
    #define B2_VALIDATE_H

    #include "b2_body.h"
    #include "b2_table.h"
// *****************************************************************************


// Returns 0 if every invariant holds, else the code of the FIRST failure
// (see the map above). Read-only: never mutates the world.
int b2ValidateWorld( b2World* world )
{
    // ---- 1-5: id-pool capacity == sparse array length -----------------------
    // Every sparse array grows to nextIndex and never shrinks (freed slots are
    // marked, not removed), so its count must equal the pool's id capacity.
    if( b2GetIdCapacity( &world->bodyIdPool )     != world->bodies.count )     return 1;
    if( b2GetIdCapacity( &world->contactIdPool )  != world->contacts.count )   return 2;
    if( b2GetIdCapacity( &world->jointIdPool )    != world->joints.count )     return 3;
    if( b2GetIdCapacity( &world->islandIdPool )   != world->islands.count )    return 4;
    if( b2GetIdCapacity( &world->solverSetIdPool ) != world->solverSets.count ) return 5;

    int totalBodyCount = 0;
    int totalContactCount = 0;
    int totalJointCount = 0;
    int totalIslandCount = 0;
    int activeSetCount = 0;

    // ---- dense-per-set walk (the primary, hole-free direction) --------------
    int setCount = world->solverSets.count;
    int setIndex;
    for( setIndex = 0; setIndex < setCount; ++setIndex )
    {
        b2SolverSet* set = &world->solverSets.data[ setIndex ];

        // 10: a free set slot must have every array empty
        if( set->setIndex == B2_NULL_INDEX )
        {
            if( set->bodySims.count != 0 )    return 10;
            if( set->bodyStates.count != 0 )  return 10;
            if( set->contactSims.count != 0 ) return 10;
            if( set->jointSims.count != 0 )   return 10;
            if( set->islandSims.count != 0 )  return 10;
            continue;
        }

        activeSetCount = activeSetCount + 1;

        // 11-13: per-set structural shape. bodyStates exist ONLY in the awake
        // set, where they parallel bodySims one-to-one. The static set holds no
        // contacts (statics never collide) and no islands.
        if( setIndex == b2_awakeSet )
        {
            if( set->bodySims.count != set->bodyStates.count ) return 11;
        }
        else
        {
            if( set->bodyStates.count != 0 ) return 12;
        }
        if( setIndex == b2_staticSet )
        {
            if( set->contactSims.count != 0 ) return 13;
            if( set->islandSims.count != 0 )  return 13;
        }

        int i;

        // bodies
        totalBodyCount = totalBodyCount + set->bodySims.count;
        for( i = 0; i < set->bodySims.count; ++i )
        {
            b2BodySim* bs = &set->bodySims.data[ i ];
            int bid = bs->bodyId;
            if( bid < 0 || bid >= world->bodies.count ) return 20;
            b2Body* body = &world->bodies.data[ bid ];
            if( body->setIndex != setIndex ) return 21;
            if( body->localIndex != i )      return 22;
            if( body->id != bid )            return 23;   // sparse slot was freed underneath
        }

        // contacts
        totalContactCount = totalContactCount + set->contactSims.count;
        for( i = 0; i < set->contactSims.count; ++i )
        {
            b2ContactSim* cs = &set->contactSims.data[ i ];
            int cid = cs->contactId;
            if( cid < 0 || cid >= world->contacts.count ) return 30;
            b2Contact* c = &world->contacts.data[ cid ];
            if( c->setIndex != setIndex )        return 31;
            if( c->localIndex != i )             return 32;
            if( c->contactId != cid )            return 33;
            if( c->colorIndex != B2_NULL_INDEX ) return 34;   // no constraint graph
        }

        // joints
        totalJointCount = totalJointCount + set->jointSims.count;
        for( i = 0; i < set->jointSims.count; ++i )
        {
            b2JointSim* js = &set->jointSims.data[ i ];
            int jid = js->jointId;
            if( jid < 0 || jid >= world->joints.count ) return 40;
            b2Joint* j = &world->joints.data[ jid ];
            if( j->setIndex != setIndex )        return 41;
            if( j->localIndex != i )             return 42;
            if( j->jointId != jid )              return 43;
            if( j->colorIndex != B2_NULL_INDEX ) return 44;
            if( js->bodyIdA != b2JointEdgeAt( j, 0 )->bodyId ) return 45;
            if( js->bodyIdB != b2JointEdgeAt( j, 1 )->bodyId ) return 46;
        }

        // islands
        totalIslandCount = totalIslandCount + set->islandSims.count;
        for( i = 0; i < set->islandSims.count; ++i )
        {
            int iid = set->islandSims.data[ i ].islandId;
            if( iid < 0 || iid >= world->islands.count ) return 50;
            b2Island* isl = &world->islands.data[ iid ];
            if( isl->setIndex != setIndex ) return 51;
            if( isl->localIndex != i )      return 52;
            if( isl->islandId != iid )      return 53;
        }
    }

    // ---- 60-64: dense totals must equal the pools' live id counts -----------
    // This is what catches a swap-remove that duplicated or dropped a record.
    if( activeSetCount    != b2GetIdCount( &world->solverSetIdPool ) ) return 60;
    if( totalBodyCount    != b2GetIdCount( &world->bodyIdPool ) )      return 61;
    if( totalContactCount != b2GetIdCount( &world->contactIdPool ) )   return 62;
    if( totalJointCount   != b2GetIdCount( &world->jointIdPool ) )     return 63;
    if( totalIslandCount  != b2GetIdCount( &world->islandIdPool ) )    return 64;

    // 70: one broad-phase pair per live contact (no graph -> single sum).
    if( totalContactCount != b2GetSetCount( &world->broadPhase.pairSet ) ) return 70;

    // ---- forward round-trip + edge-list consistency (sparse walk) -----------
    // Safe because b2DestroyBody/Contact/Joint mark freed slots id=B2_NULL_INDEX.
    int b;
    for( b = 0; b < world->bodies.count; ++b )
    {
        b2Body* body = &world->bodies.data[ b ];
        if( body->id == B2_NULL_INDEX ) continue;    // free slot
        if( body->id != b ) return 80;

        // forward: sparse -> dense -> back to this id
        if( body->setIndex < 0 || body->setIndex >= world->solverSets.count ) return 81;
        b2SolverSet* set = &world->solverSets.data[ body->setIndex ];
        if( body->localIndex < 0 || body->localIndex >= set->bodySims.count ) return 82;
        if( set->bodySims.data[ body->localIndex ].bodyId != b ) return 83;

        // contact edge list: forward-linked, back-pointers consistent, count matches
        int count = 0;
        int prevKey = B2_NULL_INDEX;
        int key = body->headContactKey;
        while( key != B2_NULL_INDEX )
        {
            int cid = key >> 1;
            int edgeIndex = key & 1;
            if( cid < 0 || cid >= world->contacts.count ) return 84;
            b2Contact* c = &world->contacts.data[ cid ];
            if( c->contactId == B2_NULL_INDEX ) return 85;   // edge points at a freed contact
            b2ContactEdge* e = b2ContactEdgeAt( c, edgeIndex );
            if( e->bodyId != b )        return 86;
            if( e->prevKey != prevKey ) return 87;           // doubly-linked back-pointer
            prevKey = key;
            key = e->nextKey;
            count = count + 1;
            if( count > world->contacts.count + 1 ) return 88;   // cycle guard
        }
        if( count != body->contactCount ) return 88;

        // joint edge list: same consistency
        count = 0;
        prevKey = B2_NULL_INDEX;
        key = body->headJointKey;
        while( key != B2_NULL_INDEX )
        {
            int jid = key >> 1;
            int edgeIndex = key & 1;
            if( jid < 0 || jid >= world->joints.count ) return 89;
            b2Joint* j = &world->joints.data[ jid ];
            if( j->jointId == B2_NULL_INDEX ) return 90;
            b2JointEdge* e = b2JointEdgeAt( j, edgeIndex );
            if( e->bodyId != b )        return 91;
            if( e->prevKey != prevKey ) return 92;
            prevKey = key;
            key = e->nextKey;
            count = count + 1;
            if( count > world->joints.count + 1 ) return 94;   // cycle guard
        }
        if( count != body->jointCount ) return 94;
    }

    return 0;
}


// *****************************************************************************
    #endif
// *****************************************************************************
