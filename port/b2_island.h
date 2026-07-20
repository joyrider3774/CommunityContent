// =============================================================================
//   b2_island.h  --  island (connected-component) data types (Vircon32 port)
// =============================================================================
//   Port of the island data types from box2d/src/island.h. An island is the
//   connected component of awake dynamic bodies joined by TOUCHING contacts and
//   joints (static bodies anchor but are never island members). Islands are the
//   unit of SLEEP: when every member body has been slow long enough, the whole
//   island migrates to a sleeping solver set and stops being simulated.
//
//   The functions (b2CreateIsland / b2LinkContact / b2MergeIslands / ...) live in
//   b2_body.h because they need the fully-defined b2World; only the TYPES are here
//   so b2SolverSet (which embeds islandSims) and b2World (which owns the islands
//   array) can see them.
//
//   SPLIT (P2.1, 2026-07-09): b2SplitIsland IS now ported (b2_body.h). When an
//   awake island accumulates removals (b2UnlinkContact/Joint bump
//   constraintRemoveCount), b2UpdateSplitIsland flags it and b2SplitIsland rebuilds
//   it into its true connected components via union-find, so a settled sub-pile
//   sleeps on its own instead of being held awake by a separated neighbour. Gated
//   on world->enableSleep (default OFF -> sleep-off scenes are bit-identical, the
//   frozen harness never runs the split). DEVIATION from upstream: the port splits
//   eagerly (any island with removeCount>0) rather than only near-sleep islands --
//   b2SplitIsland self-throttles (still-connected -> no-op + clears the count), so
//   this is correctness-equivalent, just runs the union-find a bit more often.
// =============================================================================
#ifndef B2_ISLAND_H
#define B2_ISLAND_H

#include "b2_constants.h"

// Cached contact endpoints stored in the island for contiguous iteration (so the
// deferred split's union-find never needs to touch b2Contact). Plain ints.
struct b2ContactLink
{
    int contactId;
    int bodyIdA;
    int bodyIdB;
};

struct b2JointLink
{
    int jointId;
    int bodyIdA;
    int bodyIdB;
};

// A persistent island: the connected component of awake bodies + their touching
// contacts + joints. bodies / contacts / joints are grow-only arrays (b2GrowArray;
// inline data/count/capacity triples rather than upstream's b2Array macro).
struct b2Island
{
    int setIndex;               // which solver set holds this island (B2_NULL_INDEX if free)
    int localIndex;             // index within that set's islandSims
    int islandId;
    int constraintRemoveCount;  // # contacts/joints removed -> split candidate (split deferred)

    int* bodies;                int bodyCount;     int bodyCapacity;
    b2ContactLink* contacts;    int contactCount;  int contactCapacity;
    b2JointLink*   joints;      int jointCount;    int jointCapacity;
};

struct b2IslandArray { b2Island* data;  int count;  int capacity; };

// The per-set island handle used to migrate islands across solver sets on sleep/wake.
struct b2IslandSim { int islandId; };

struct b2IslandSimArray { b2IslandSim* data;  int count;  int capacity; };

#endif
