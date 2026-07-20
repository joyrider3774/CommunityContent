/* *****************************************************************************
*  VirconBox2D : b2_dynamic_tree.h     (port of Box2D v3 src/dynamic_tree.c)
*  --------------------------------------------------------------------------- *
*  Broad-phase dynamic AABB tree (BVH). SLICE 1: node pool, create/destroy,     *
*  proxy create/destroy/move, leaf insert/remove, and AABB query. The tree is   *
*  built on a b2Alloc'd node array indexed by runtime node ids -- a pattern a   *
*  probe confirmed is safe on this compiler (the variable-index miscompile is    *
*  specific to fixed array MEMBERS, not heap-pointer arrays).                   *
*                                                                              *
*  Port deviations:                                                            *
*   - b2DynamicTree_Create returns void via an out-pointer (the struct is       *
*     multi-word). b2AABB / b2TreeStats likewise cross boundaries by pointer.   *
*   - The two anonymous unions in b2TreeNode (children|userData, parent|next)   *
*     are split into separate fields (anonymous unions are unsupported; a named  *
*     union would work but isn't worth the churn; costs 2 words/node).           *
*   - 64-bit categoryBits / userData reduced to int (32 collision categories;   *
*     userData holds a 32-bit id). uint16 height/flags -> int.                  *
*   - b2RotateNodes (incremental rebalancing) is DEFERRED: b2InsertLeaf ignores *
*     shouldRotate, so the tree is correct but not self-balancing yet.          *
*   - Deferred entirely for now: EnlargeProxy, RayCast, BoxCast, Rebuild/SAH,   *
*     Validate, GetAreaRatio. (Query/QueryAll filtering by maskBits also TBD;   *
*     QueryAll visits all overlapping leaves.)                                  *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_DYNAMIC_TREE_H
    #define B2_DYNAMIC_TREE_H

    #include "b2_math.h"
    #include "b2_aabb.h"
    #include "b2_core.h"
// *****************************************************************************


// node flag bits (upstream enum b2TreeNodeFlags)
#define b2_allocatedNode 1
#define b2_enlargedNode  2
#define b2_leafNode      4

// default collision category (upstream B2_DEFAULT_CATEGORY_BITS = 1)
#define B2_DEFAULT_CATEGORY_BITS 1

// query traversal stack depth (upstream 1024; trees here are small)
#define B2_TREE_STACK_SIZE 256


struct b2TreeNodeChildren
{
    int child1;
    int child2;
};

// A node in the dynamic tree. Internal nodes have children; leaves have userData.
struct b2TreeNode
{
    b2AABB aabb;                    // node bounding box (4 words)
    int categoryBits;               // collision filter category bits
    b2TreeNodeChildren children;    // child indices (internal node)
    int userData;                   // user data (leaf node) -- split from upstream union
    int parent;                     // parent index (allocated node)
    int next;                       // freelist next index (free node) -- split from union
    int height;                     // node height (0 == leaf)
    int flags;                      // b2_allocatedNode | b2_enlargedNode | b2_leafNode
};

struct b2DynamicTree
{
    b2TreeNode* nodes;      // the node pool
    int root;               // root index
    int nodeCount;          // number of nodes in use
    int nodeCapacity;       // allocated node space
    int freeList;           // head of the free list
    int proxyCount;         // number of proxies (leaves)
    int* leafIndices;       // rebuild scratch (unused in slice 1)
    b2AABB* leafBoxes;      // rebuild scratch
    b2Vec2* leafCenters;    // rebuild scratch
    int* binIndices;        // rebuild scratch
    int rebuildCapacity;    // rebuild scratch capacity
};

struct b2TreeStats
{
    int nodeVisits;
    int leafVisits;
};


// -----------------------------------------------------------------------------
//   Node helpers
// -----------------------------------------------------------------------------
bool b2IsLeaf( b2TreeNode* node )
{
    return ( node->flags & b2_leafNode ) != 0;
}

bool b2IsAllocated( b2TreeNode* node )
{
    return ( node->flags & b2_allocatedNode ) != 0;
}

// Reset a node to default state (replaces upstream's designated-initializer global).
void b2SetDefaultTreeNode( b2TreeNode* node )
{
    node->aabb.lowerBound.x = 0.0;  node->aabb.lowerBound.y = 0.0;
    node->aabb.upperBound.x = 0.0;  node->aabb.upperBound.y = 0.0;
    node->categoryBits = B2_DEFAULT_CATEGORY_BITS;
    node->children.child1 = B2_NULL_INDEX;
    node->children.child2 = B2_NULL_INDEX;
    node->userData = -1;
    node->parent = B2_NULL_INDEX;
    node->next = B2_NULL_INDEX;
    node->height = 0;
    node->flags = b2_allocatedNode;
}


// -----------------------------------------------------------------------------
//   Create / destroy
// -----------------------------------------------------------------------------
void b2DynamicTree_Create( int proxyCapacity, b2DynamicTree* tree )
{
    int capacity = b2MaxInt( proxyCapacity, 16 );

    memset( tree, 0, sizeof( b2DynamicTree ) );

    tree->root = B2_NULL_INDEX;

    // maximum node count for a full binary tree is 2 * leafCount - 1
    tree->nodeCapacity = 2 * capacity - 1;
    tree->nodeCount = 0;
    tree->nodes = b2Alloc( tree->nodeCapacity * sizeof( b2TreeNode ) );
    memset( tree->nodes, 0, tree->nodeCapacity * sizeof( b2TreeNode ) );

    // build the free list
    int i;
    for( i = 0; i < tree->nodeCapacity - 1; ++i )
        tree->nodes[i].next = i + 1;
    tree->nodes[tree->nodeCapacity - 1].next = B2_NULL_INDEX;
    tree->freeList = 0;

    tree->proxyCount = 0;
    tree->leafIndices = NULL;
    tree->leafBoxes = NULL;
    tree->leafCenters = NULL;
    tree->binIndices = NULL;
    tree->rebuildCapacity = 0;
}

void b2DynamicTree_Destroy( b2DynamicTree* tree )
{
    b2Free( tree->nodes, tree->nodeCapacity * sizeof( b2TreeNode ) );
    memset( tree, 0, sizeof( b2DynamicTree ) );
}


// -----------------------------------------------------------------------------
//   Node pool allocate / free
// -----------------------------------------------------------------------------
int b2AllocateNode( b2DynamicTree* tree )
{
    // grow the pool if the free list is empty
    if( tree->freeList == B2_NULL_INDEX )
    {
        b2TreeNode* oldNodes = tree->nodes;
        int oldCapacity = tree->nodeCapacity;
        tree->nodeCapacity = tree->nodeCapacity + ( oldCapacity >> 1 );
        tree->nodes = b2Alloc( tree->nodeCapacity * sizeof( b2TreeNode ) );
        memcpy( tree->nodes, oldNodes, tree->nodeCount * sizeof( b2TreeNode ) );
        memset( tree->nodes + tree->nodeCount, 0,
                ( tree->nodeCapacity - tree->nodeCount ) * sizeof( b2TreeNode ) );
        b2Free( oldNodes, oldCapacity * sizeof( b2TreeNode ) );

        int i;
        for( i = tree->nodeCount; i < tree->nodeCapacity - 1; ++i )
            tree->nodes[i].next = i + 1;
        tree->nodes[tree->nodeCapacity - 1].next = B2_NULL_INDEX;
        tree->freeList = tree->nodeCount;
    }

    int nodeIndex = tree->freeList;
    b2TreeNode* node = tree->nodes + nodeIndex;
    tree->freeList = node->next;
    b2SetDefaultTreeNode( node );
    tree->nodeCount = tree->nodeCount + 1;
    return nodeIndex;
}

void b2FreeNode( b2DynamicTree* tree, int nodeId )
{
    tree->nodes[nodeId].next = tree->freeList;
    tree->nodes[nodeId].flags = 0;
    tree->freeList = nodeId;
    tree->nodeCount = tree->nodeCount - 1;
}


// -----------------------------------------------------------------------------
//   Sibling selection (surface-area heuristic)
// -----------------------------------------------------------------------------
int b2FindBestSibling( b2DynamicTree* tree, b2AABB* boxD )
{
    b2Vec2 centerD;  b2AABB_Center( boxD, &centerD );
    float areaD = b2Perimeter( boxD );

    b2TreeNode* nodes = tree->nodes;
    int rootIndex = tree->root;

    b2AABB rootBox = nodes[rootIndex].aabb;
    float areaBase = b2Perimeter( &rootBox );

    b2AABB tmpU;
    b2AABB_Union( &rootBox, boxD, &tmpU );
    float directCost = b2Perimeter( &tmpU );
    float inheritedCost = 0.0;

    int bestSibling = rootIndex;
    float bestCost = directCost;

    int index = rootIndex;
    while( nodes[index].height > 0 )
    {
        int child1 = nodes[index].children.child1;
        int child2 = nodes[index].children.child2;

        float cost = directCost + inheritedCost;
        if( cost < bestCost )
        {
            bestSibling = index;
            bestCost = cost;
        }

        inheritedCost = inheritedCost + ( directCost - areaBase );

        bool leaf1 = nodes[child1].height == 0;
        bool leaf2 = nodes[child2].height == 0;

        float lowerCost1 = FLT_MAX;
        b2AABB box1 = nodes[child1].aabb;
        b2AABB u1;  b2AABB_Union( &box1, boxD, &u1 );
        float directCost1 = b2Perimeter( &u1 );
        float area1 = 0.0;
        if( leaf1 )
        {
            float cost1 = directCost1 + inheritedCost;
            if( cost1 < bestCost )
            {
                bestSibling = child1;
                bestCost = cost1;
            }
        }
        else
        {
            area1 = b2Perimeter( &box1 );
            lowerCost1 = inheritedCost + directCost1 + b2MinFloat( areaD - area1, 0.0 );
        }

        float lowerCost2 = FLT_MAX;
        b2AABB box2 = nodes[child2].aabb;
        b2AABB u2;  b2AABB_Union( &box2, boxD, &u2 );
        float directCost2 = b2Perimeter( &u2 );
        float area2 = 0.0;
        if( leaf2 )
        {
            float cost2 = directCost2 + inheritedCost;
            if( cost2 < bestCost )
            {
                bestSibling = child2;
                bestCost = cost2;
            }
        }
        else
        {
            area2 = b2Perimeter( &box2 );
            lowerCost2 = inheritedCost + directCost2 + b2MinFloat( areaD - area2, 0.0 );
        }

        if( leaf1 && leaf2 )
            break;

        // can the cost possibly be decreased?
        if( bestCost <= lowerCost1 && bestCost <= lowerCost2 )
            break;

        if( lowerCost1 == lowerCost2 && leaf1 == false )
        {
            // tie: fall back to centroid distance
            b2Vec2 c1;  b2AABB_Center( &box1, &c1 );
            b2Vec2 c2;  b2AABB_Center( &box2, &c2 );
            b2Vec2 d1;  b2Sub( &c1, &centerD, &d1 );
            b2Vec2 d2;  b2Sub( &c2, &centerD, &d2 );
            lowerCost1 = b2LengthSquared( &d1 );
            lowerCost2 = b2LengthSquared( &d2 );
        }

        // descend
        if( lowerCost1 < lowerCost2 && leaf1 == false )
        {
            index = child1;
            areaBase = area1;
            directCost = directCost1;
        }
        else
        {
            index = child2;
            areaBase = area2;
            directCost = directCost2;
        }
    }

    return bestSibling;
}


// -----------------------------------------------------------------------------
//   Leaf insert / remove
// -----------------------------------------------------------------------------
void b2InsertLeaf( b2DynamicTree* tree, int leaf, bool shouldRotate )
{
    if( tree->root == B2_NULL_INDEX )
    {
        tree->root = leaf;
        tree->nodes[leaf].parent = B2_NULL_INDEX;
        return;
    }

    // Stage 1: find the best sibling
    b2AABB leafAABB = tree->nodes[leaf].aabb;
    int sibling = b2FindBestSibling( tree, &leafAABB );

    // Stage 2: create a new parent for the leaf and sibling
    int oldParent = tree->nodes[sibling].parent;
    int newParent = b2AllocateNode( tree );

    // node pointer can change after allocation -- re-read
    b2TreeNode* nodes = tree->nodes;
    nodes[newParent].parent = oldParent;
    nodes[newParent].userData = -1;
    b2AABB_Union( &leafAABB, &nodes[sibling].aabb, &nodes[newParent].aabb );
    nodes[newParent].categoryBits = nodes[leaf].categoryBits | nodes[sibling].categoryBits;
    nodes[newParent].height = nodes[sibling].height + 1;
    nodes[newParent].children.child1 = sibling;
    nodes[newParent].children.child2 = leaf;
    nodes[sibling].parent = newParent;
    nodes[leaf].parent = newParent;

    if( oldParent != B2_NULL_INDEX )
    {
        if( nodes[oldParent].children.child1 == sibling )
            nodes[oldParent].children.child1 = newParent;
        else
            nodes[oldParent].children.child2 = newParent;
    }
    else
    {
        tree->root = newParent;
    }

    // Stage 3: walk back up fixing heights and AABBs
    int index = nodes[leaf].parent;
    while( index != B2_NULL_INDEX )
    {
        int child1 = nodes[index].children.child1;
        int child2 = nodes[index].children.child2;

        b2AABB_Union( &nodes[child1].aabb, &nodes[child2].aabb, &nodes[index].aabb );
        nodes[index].categoryBits = nodes[child1].categoryBits | nodes[child2].categoryBits;
        nodes[index].height = 1 + b2MaxInt( nodes[child1].height, nodes[child2].height );
        nodes[index].flags = nodes[index].flags |
                             ( ( nodes[child1].flags | nodes[child2].flags ) & b2_enlargedNode );

        // b2RotateNodes( tree, index ) deferred -- shouldRotate ignored in slice 1
        index = nodes[index].parent;
    }
}

void b2RemoveLeaf( b2DynamicTree* tree, int leaf )
{
    if( leaf == tree->root )
    {
        tree->root = B2_NULL_INDEX;
        return;
    }

    b2TreeNode* nodes = tree->nodes;

    int parent = nodes[leaf].parent;
    int grandParent = nodes[parent].parent;
    int sibling;
    if( nodes[parent].children.child1 == leaf )
        sibling = nodes[parent].children.child2;
    else
        sibling = nodes[parent].children.child1;

    if( grandParent != B2_NULL_INDEX )
    {
        // destroy parent and connect sibling to grandParent
        if( nodes[grandParent].children.child1 == parent )
            nodes[grandParent].children.child1 = sibling;
        else
            nodes[grandParent].children.child2 = sibling;
        nodes[sibling].parent = grandParent;
        b2FreeNode( tree, parent );

        // adjust ancestor bounds
        int index = grandParent;
        while( index != B2_NULL_INDEX )
        {
            b2TreeNode* node = nodes + index;
            b2TreeNode* child1 = nodes + node->children.child1;
            b2TreeNode* child2 = nodes + node->children.child2;

            b2AABB_Union( &child1->aabb, &child2->aabb, &node->aabb );
            node->categoryBits = child1->categoryBits | child2->categoryBits;
            node->height = 1 + b2MaxInt( child1->height, child2->height );

            index = node->parent;
        }
    }
    else
    {
        tree->root = sibling;
        tree->nodes[sibling].parent = B2_NULL_INDEX;
        b2FreeNode( tree, parent );
    }
}


// -----------------------------------------------------------------------------
//   Proxy create / destroy / move
// -----------------------------------------------------------------------------
int b2DynamicTree_CreateProxy( b2DynamicTree* tree, b2AABB* aabb, int categoryBits, int userData )
{
    int proxyId = b2AllocateNode( tree );
    b2TreeNode* node = tree->nodes + proxyId;

    node->aabb = *aabb;
    node->userData = userData;
    node->categoryBits = categoryBits;
    node->height = 0;
    node->flags = b2_allocatedNode | b2_leafNode;

    b2InsertLeaf( tree, proxyId, false );   // shouldRotate deferred
    tree->proxyCount = tree->proxyCount + 1;
    return proxyId;
}

void b2DynamicTree_DestroyProxy( b2DynamicTree* tree, int proxyId )
{
    b2RemoveLeaf( tree, proxyId );
    b2FreeNode( tree, proxyId );
    tree->proxyCount = tree->proxyCount - 1;
}

void b2DynamicTree_MoveProxy( b2DynamicTree* tree, int proxyId, b2AABB* aabb )
{
    b2RemoveLeaf( tree, proxyId );
    tree->nodes[proxyId].aabb = *aabb;
    b2InsertLeaf( tree, proxyId, false );
}


// -----------------------------------------------------------------------------
//   Accessors
// -----------------------------------------------------------------------------
int b2DynamicTree_GetProxyCount( b2DynamicTree* tree )
{
    return tree->proxyCount;
}

int b2DynamicTree_GetHeight( b2DynamicTree* tree )
{
    if( tree->root == B2_NULL_INDEX )
        return 0;
    return tree->nodes[tree->root].height;
}

void b2DynamicTree_GetAABB( b2DynamicTree* tree, int proxyId, b2AABB* result )
{
    *result = tree->nodes[proxyId].aabb;
}

int b2DynamicTree_GetUserData( b2DynamicTree* tree, int proxyId )
{
    return tree->nodes[proxyId].userData;
}


// -----------------------------------------------------------------------------
//   Query: visit every leaf whose AABB overlaps the query box.
//   callback( proxyId, userData, context ) returns false to stop early.
// -----------------------------------------------------------------------------
void b2DynamicTree_QueryAll( b2DynamicTree* tree, b2AABB* aabb,
                             bool( int, int, void* )* callback, void* context,
                             b2TreeStats* result )
{
    result->nodeVisits = 0;
    result->leafVisits = 0;

    if( tree->nodeCount == 0 )
        return;

    int[B2_TREE_STACK_SIZE] stack;
    int stackCount = 0;
    stack[stackCount] = tree->root;
    stackCount = stackCount + 1;

    while( stackCount > 0 )
    {
        stackCount = stackCount - 1;
        int nodeId = stack[stackCount];

        b2TreeNode* node = tree->nodes + nodeId;
        result->nodeVisits = result->nodeVisits + 1;

        if( b2AABB_Overlaps( &node->aabb, aabb ) )
        {
            if( b2IsLeaf( node ) )
            {
                bool proceed = callback( nodeId, node->userData, context );
                result->leafVisits = result->leafVisits + 1;
                if( proceed == false )
                    return;
            }
            else
            {
                if( stackCount < B2_TREE_STACK_SIZE - 1 )
                {
                    stack[stackCount] = node->children.child1;
                    stackCount = stackCount + 1;
                    stack[stackCount] = node->children.child2;
                    stackCount = stackCount + 1;
                }
            }
        }
    }
}


// -----------------------------------------------------------------------------
//   Ray cast: visit every leaf whose segment-AABB the ray crosses, with a cheap
//   per-node separating-axis prune; nearer children first. The callback returns
//   a new maxFraction to shrink the ray (0 stops the cast; return the input's
//   maxFraction to keep going / skip this leaf). Ports dynamic_tree.c
//   b2DynamicTree_RayCast: uint64 maskBits -> int; callback returns float; the
//   b2TreeStats result is an out-pointer (2 words > 1).
// -----------------------------------------------------------------------------
void b2DynamicTree_RayCast( b2DynamicTree* tree, b2RayCastInput* input, int maskBits,
                            float( b2RayCastInput*, int, int, void* )* callback, void* context,
                            b2TreeStats* result )
{
    result->nodeVisits = 0;
    result->leafVisits = 0;

    if( tree->nodeCount == 0 )
        return;

    b2Vec2 p1 = input->origin;
    b2Vec2 d = input->translation;

    b2Vec2 r;  b2Normalize( &d, &r );
    b2Vec2 v;  b2CrossSV( 1.0, &r, &v );      // perpendicular to the segment
    b2Vec2 abs_v;  b2Abs( &v, &abs_v );

    float maxFraction = input->maxFraction;

    b2Vec2 p2;  b2MulAdd( &p1, maxFraction, &d, &p2 );

    b2AABB segmentAABB;
    segmentAABB.lowerBound.x = fmin( p1.x, p2.x );
    segmentAABB.lowerBound.y = fmin( p1.y, p2.y );
    segmentAABB.upperBound.x = fmax( p1.x, p2.x );
    segmentAABB.upperBound.y = fmax( p1.y, p2.y );

    int[B2_TREE_STACK_SIZE] stack;
    int stackCount = 0;
    stack[stackCount] = tree->root;
    stackCount = stackCount + 1;

    b2TreeNode* nodes = tree->nodes;
    b2RayCastInput subInput = *input;

    while( stackCount > 0 )
    {
        stackCount = stackCount - 1;
        int nodeId = stack[stackCount];
        if( nodeId == B2_NULL_INDEX )
            continue;

        b2TreeNode* node = nodes + nodeId;
        result->nodeVisits = result->nodeVisits + 1;

        b2AABB nodeAABB = node->aabb;

        if( ( node->categoryBits & maskBits ) == 0 )
            continue;
        if( b2AABB_Overlaps( &nodeAABB, &segmentAABB ) == false )
            continue;

        // separating axis (Gino p80): |dot(v, p1 - c)| > dot(|v|, h) -> miss
        b2Vec2 c;  b2AABB_Center( &nodeAABB, &c );
        b2Vec2 h;  b2AABB_Extents( &nodeAABB, &h );
        b2Vec2 p1mc;  b2Sub( &p1, &c, &p1mc );
        float term1 = b2AbsFloat( b2Dot( &v, &p1mc ) );
        float term2 = b2Dot( &abs_v, &h );
        if( term2 < term1 )
            continue;

        if( b2IsLeaf( node ) )
        {
            subInput.maxFraction = maxFraction;
            float value = callback( &subInput, nodeId, node->userData, context );
            result->leafVisits = result->leafVisits + 1;

            if( value == 0.0 )
                return;   // client terminated the cast

            if( 0.0 < value && value <= maxFraction )
            {
                maxFraction = value;   // shrink the ray to the closest hit so far
                b2MulAdd( &p1, maxFraction, &d, &p2 );
                segmentAABB.lowerBound.x = fmin( p1.x, p2.x );
                segmentAABB.lowerBound.y = fmin( p1.y, p2.y );
                segmentAABB.upperBound.x = fmax( p1.x, p2.x );
                segmentAABB.upperBound.y = fmax( p1.y, p2.y );
            }
        }
        else
        {
            if( stackCount < B2_TREE_STACK_SIZE - 1 )
            {
                // push both children, nearer one last (popped first)
                b2AABB a1 = nodes[ node->children.child1 ].aabb;
                b2AABB a2 = nodes[ node->children.child2 ].aabb;
                b2Vec2 c1;  b2AABB_Center( &a1, &c1 );
                b2Vec2 c2;  b2AABB_Center( &a2, &c2 );
                if( b2DistanceSquared( &c1, &p1 ) < b2DistanceSquared( &c2, &p1 ) )
                {
                    stack[stackCount] = node->children.child2;  stackCount = stackCount + 1;
                    stack[stackCount] = node->children.child1;  stackCount = stackCount + 1;
                }
                else
                {
                    stack[stackCount] = node->children.child1;  stackCount = stackCount + 1;
                    stack[stackCount] = node->children.child2;  stackCount = stackCount + 1;
                }
            }
        }
    }
}


// -----------------------------------------------------------------------------
//   b2DynamicTree_BoxCast  (sweep an AABB through the tree)
// -----------------------------------------------------------------------------
//   The broad phase of a shape cast: the caller bounds the moving shape with an
//   AABB (radius already folded in) and sweeps it. Same shape as the ray cast --
//   segment/AABB separating-axis prune, nearest-child-first descent, and the
//   callback's return value shrinks maxFraction -- except the node's half-extents
//   are INFLATED by the cast box's extents, which is what turns a ray test into a
//   swept-box test. Returning 0 from the callback terminates the walk.
//
//   PORT DEVIATIONS (same as the ray cast): uint64 maskBits -> int; the b2TreeStats
//   result is an out-pointer; the callback takes (input, proxyId, shapeId, context).
void b2DynamicTree_BoxCast( b2DynamicTree* tree, b2BoxCastInput* input, int maskBits,
                            float( b2BoxCastInput*, int, int, void* )* callback, void* context,
                            b2TreeStats* result )
{
    result->nodeVisits = 0;
    result->leafVisits = 0;

    if( tree->nodeCount == 0 )
        return;

    b2AABB originAABB = input->box;

    b2Vec2 p1;         b2AABB_Center( &originAABB, &p1 );
    b2Vec2 extension;  b2AABB_Extents( &originAABB, &extension );

    // v is perpendicular to the sweep (NOT normalized -- upstream uses the raw
    // translation here, unlike the ray cast which normalizes first)
    b2Vec2 r = input->translation;
    b2Vec2 v;      b2CrossSV( 1.0, &r, &v );
    b2Vec2 abs_v;  b2Abs( &v, &abs_v );

    float maxFraction = input->maxFraction;

    // total box swept by the cast box over [0, maxFraction]
    b2Vec2 t;  b2MulSV( maxFraction, &input->translation, &t );
    b2AABB totalAABB;
    totalAABB.lowerBound.x = fmin( originAABB.lowerBound.x, originAABB.lowerBound.x + t.x );
    totalAABB.lowerBound.y = fmin( originAABB.lowerBound.y, originAABB.lowerBound.y + t.y );
    totalAABB.upperBound.x = fmax( originAABB.upperBound.x, originAABB.upperBound.x + t.x );
    totalAABB.upperBound.y = fmax( originAABB.upperBound.y, originAABB.upperBound.y + t.y );

    int[B2_TREE_STACK_SIZE] stack;
    int stackCount = 0;
    stack[stackCount] = tree->root;
    stackCount = stackCount + 1;

    b2TreeNode* nodes = tree->nodes;
    b2BoxCastInput subInput = *input;

    while( stackCount > 0 )
    {
        stackCount = stackCount - 1;
        int nodeId = stack[stackCount];
        if( nodeId == B2_NULL_INDEX )
            continue;

        b2TreeNode* node = nodes + nodeId;
        result->nodeVisits = result->nodeVisits + 1;

        b2AABB nodeAABB = node->aabb;

        if( ( node->categoryBits & maskBits ) == 0 )
            continue;
        if( b2AABB_Overlaps( &nodeAABB, &totalAABB ) == false )
            continue;

        // separating axis (Gino p80): |dot(v, p1 - c)| > dot(|v|, h) -> miss,
        // with the node's extents grown by the cast box's extents
        b2Vec2 c;   b2AABB_Center( &nodeAABB, &c );
        b2Vec2 he;  b2AABB_Extents( &nodeAABB, &he );
        b2Vec2 h;   b2Add( &he, &extension, &h );
        b2Vec2 p1mc;  b2Sub( &p1, &c, &p1mc );
        float term1 = b2AbsFloat( b2Dot( &v, &p1mc ) );
        float term2 = b2Dot( &abs_v, &h );
        if( term2 < term1 )
            continue;

        if( b2IsLeaf( node ) )
        {
            subInput.maxFraction = maxFraction;
            float value = callback( &subInput, nodeId, node->userData, context );
            result->leafVisits = result->leafVisits + 1;

            if( value == 0.0 )
                return;   // client terminated the cast

            if( 0.0 < value && value < maxFraction )
            {
                maxFraction = value;   // shrink the sweep to the closest hit so far
                b2MulSV( maxFraction, &input->translation, &t );
                totalAABB.lowerBound.x = fmin( originAABB.lowerBound.x, originAABB.lowerBound.x + t.x );
                totalAABB.lowerBound.y = fmin( originAABB.lowerBound.y, originAABB.lowerBound.y + t.y );
                totalAABB.upperBound.x = fmax( originAABB.upperBound.x, originAABB.upperBound.x + t.x );
                totalAABB.upperBound.y = fmax( originAABB.upperBound.y, originAABB.upperBound.y + t.y );
            }
        }
        else
        {
            if( stackCount < B2_TREE_STACK_SIZE - 1 )
            {
                // push both children, nearer one last (popped first)
                b2AABB a1 = nodes[ node->children.child1 ].aabb;
                b2AABB a2 = nodes[ node->children.child2 ].aabb;
                b2Vec2 c1;  b2AABB_Center( &a1, &c1 );
                b2Vec2 c2;  b2AABB_Center( &a2, &c2 );
                if( b2DistanceSquared( &c1, &p1 ) < b2DistanceSquared( &c2, &p1 ) )
                {
                    stack[stackCount] = node->children.child2;  stackCount = stackCount + 1;
                    stack[stackCount] = node->children.child1;  stackCount = stackCount + 1;
                }
                else
                {
                    stack[stackCount] = node->children.child1;  stackCount = stackCount + 1;
                    stack[stackCount] = node->children.child2;  stackCount = stackCount + 1;
                }
            }
        }
    }
}


// *****************************************************************************
    #endif
// *****************************************************************************
