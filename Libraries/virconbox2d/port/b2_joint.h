// =============================================================================
//   b2_joint.h  --  joint types + shared solver softness (Vircon32 port)
// =============================================================================
//   Port of the shared joint data types from box2d/src/joint.h, plus the
//   soft-constraint helper (b2Softness / b2MakeSoft) that both contacts and
//   joints use. b2Softness lived in b2_solver.h originally; it moves here so
//   b2JointSim (which embeds it) can be defined ahead of b2_body.h -- exactly
//   the way b2ContactSim lives in b2_contact.h. b2_solver.h now gets it back
//   transitively (b2_solver.h -> b2_body.h -> b2_joint.h).
//
//   SLICE 1 (connectivity only): the cold b2Joint (graph handle + edges), the
//   dense b2JointSim (solver-set resident), and the distance-joint payload.
//   Only the distance joint is embedded (NO union -- union support is unattested
//   in the dialect; add named members or probe a union when revolute lands).
//   The prepare/warm-start/solve math is DEFERRED to slice 2 (b2_solver.h).
// =============================================================================
#ifndef B2_JOINT_H
#define B2_JOINT_H

#include "b2_math.h"
#include "b2_constants.h"

// -----------------------------------------------------------------------------
//   Soft-constraint coefficients (Box2D's implicit spring-damper). Shared by the
//   contact solver and every joint. (Relocated from b2_solver.h.)
// -----------------------------------------------------------------------------
struct b2Softness
{
    float biasRate;
    float massScale;
    float impulseScale;
};

void b2MakeSoft( float hertz, float zeta, float h, b2Softness* out )
{
    if( hertz == 0.0 )
    {
        out->biasRate = 0.0;
        out->massScale = 0.0;
        out->impulseScale = 0.0;
        return;
    }
    float omega = 2.0 * B2_PI * hertz;
    float a1 = 2.0 * zeta + h * omega;
    float a2 = h * omega * a1;
    float a3 = 1.0 / ( 1.0 + a2 );
    out->biasRate = omega / a1;
    out->massScale = a2 * a3;
    out->impulseScale = a3;
}


// -----------------------------------------------------------------------------
//   Joint types. (Upstream b2JointType enum -> plain int #defines, per the
//   port's "no enum-from-int" convention.)
// -----------------------------------------------------------------------------
#define b2_distanceJoint   0
#define b2_filterJoint     1
#define b2_motorJoint      2
#define b2_prismaticJoint  3
#define b2_revoluteJoint   4
#define b2_weldJoint       5
#define b2_wheelJoint      6


// A joint edge connects a body (node) to a joint (edge) in the joint graph.
// Each joint has two, one per attached body, each living in that body's list.
struct b2JointEdge
{
    int bodyId;
    int prevKey;
    int nextKey;
};

// Distance-joint payload. Ports box2d/src/joint.h's b2DistanceJoint verbatim
// (all scalar / b2Vec2 / b2Softness -- no arrays, dialect-clean). The solver
// (slice 2) reads/writes the impulse + cached-mass fields.
struct b2DistanceJoint
{
    float length;
    float hertz;
    float dampingRatio;
    float lowerSpringForce;
    float upperSpringForce;
    float minLength;
    float maxLength;

    float maxMotorForce;
    float motorSpeed;

    float impulse;
    float lowerImpulse;
    float upperImpulse;
    float motorImpulse;

    int indexA;
    int indexB;
    b2Vec2 anchorA;
    b2Vec2 anchorB;
    b2Vec2 deltaCenter;
    b2Softness distanceSoftness;
    float axialMass;

    bool enableSpring;
    bool enableLimit;
    bool enableMotor;
};

// Revolute-joint payload. Ports box2d/src/joint.h's b2RevoluteJoint. The port
// implements the point-to-point (hinge) constraint; the spring/motor/limit fields
// are carried so those slices drop in as independent `if` blocks later.
struct b2RevoluteJoint
{
    b2Vec2 linearImpulse;
    float springImpulse;
    float motorImpulse;
    float lowerImpulse;
    float upperImpulse;
    float hertz;
    float dampingRatio;
    float targetAngle;
    float maxMotorTorque;
    float motorSpeed;
    float lowerAngle;
    float upperAngle;

    int indexA;
    int indexB;
    b2Transform frameA;
    b2Transform frameB;
    b2Vec2 deltaCenter;
    float axialMass;
    b2Softness springSoftness;

    bool enableSpring;
    bool enableMotor;
    bool enableLimit;
};

// Weld-joint payload. Ports box2d/src/joint.h's b2WeldJoint. A weld rigidly binds
// two bodies (2-D point-to-point + a scalar angular lock). Rigid when the hertz
// fields are 0 (both springs fall back to the base constraintSoftness); nonzero
// hertz makes it a soft weld (spring). Uses the non-block (#else) solve path.
struct b2WeldJoint
{
    float linearHertz;
    float linearDampingRatio;
    float angularHertz;
    float angularDampingRatio;

    b2Softness linearSpring;
    b2Softness angularSpring;
    b2Vec2 linearImpulse;
    float angularImpulse;

    int indexA;
    int indexB;
    b2Transform frameA;
    b2Transform frameB;
    b2Vec2 deltaCenter;
    float axialMass;
};

// Prismatic-joint payload. Ports box2d/src/joint.h's b2PrismaticJoint. A prismatic
// (slider) joint constrains bodyB to translate along a single axis relative to bodyA
// with NO relative rotation. Core = a 2x2 block on [perp-translation, relative-angle];
// the spring/motor/limit act along the free axis (deferred). `impulse` is (perp, angle).
struct b2PrismaticJoint
{
    b2Vec2 impulse;
    float springImpulse;
    float motorImpulse;
    float lowerImpulse;
    float upperImpulse;
    float hertz;
    float dampingRatio;
    float targetTranslation;
    float maxMotorForce;
    float motorSpeed;
    float lowerTranslation;
    float upperTranslation;

    int indexA;
    int indexB;
    b2Transform frameA;
    b2Transform frameB;
    b2Vec2 deltaCenter;
    b2Softness springSoftness;

    bool enableSpring;
    bool enableLimit;
    bool enableMotor;
};

// Wheel-joint payload. Ports box2d/src/joint.h's b2WheelJoint. A wheel joint (car
// suspension) keeps bodyB on a line through the anchor (perpendicular constraint),
// lets it slide along that axis with an optional spring (suspension) + limits, and
// rotate freely with an optional motor (drive wheel). No angle constraint.
struct b2WheelJoint
{
    float perpImpulse;
    float motorImpulse;
    float springImpulse;
    float lowerImpulse;
    float upperImpulse;
    float maxMotorTorque;
    float motorSpeed;
    float lowerTranslation;
    float upperTranslation;
    float hertz;
    float dampingRatio;

    int indexA;
    int indexB;
    b2Transform frameA;
    b2Transform frameB;
    b2Vec2 deltaCenter;
    float perpMass;
    float motorMass;
    float axialMass;
    b2Softness springSoftness;

    bool enableSpring;
    bool enableMotor;
    bool enableLimit;
};

// Motor-joint payload. Ports box2d/src/joint.h's b2MotorJoint. A motor joint drives
// the RELATIVE velocity of the two bodies toward a target (linearVelocity / angular-
// Velocity), each capped by a max force / torque -- the kinematic-control joint (top-
// down movers, conveyor-like drives). Optional linear/angular springs (hertz>0 +
// maxSpring*>0) also pull the relative pose toward the frame offset. Point-to-point
// linear 2x2 block (b2Mat22 linearMass) + a scalar angular block, same as revolute.
struct b2MotorJoint
{
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

    b2Vec2 linearVelocityImpulse;
    float angularVelocityImpulse;
    b2Vec2 linearSpringImpulse;
    float angularSpringImpulse;

    b2Softness linearSpring;
    b2Softness angularSpring;

    int indexA;
    int indexB;
    b2Transform frameA;
    b2Transform frameB;
    b2Vec2 deltaCenter;
    b2Mat22 linearMass;
    float angularMass;
};

// The base joint sim: lives in a DENSE array on the owning solver set
// (set->jointSims), referenced by joint->localIndex. Mirrors b2ContactSim's
// role. DEVIATION: no union of joint payloads (dialect) -- the distance joint
// is embedded directly for now; more types get their own named member (or a
// probed union) when they land.
struct b2JointSim
{
    int jointId;

    int bodyIdA;
    int bodyIdB;

    int type;

    b2Transform localFrameA;
    b2Transform localFrameB;

    float invMassA;
    float invMassB;
    float invIA;
    float invIB;

    float constraintHertz;
    float constraintDampingRatio;

    b2Softness constraintSoftness;

    float forceThreshold;
    float torqueThreshold;

    // Per-type payloads. DEVIATION: upstream unions these; the Vircon32 compiler
    // rejects `union` (probe p11), so the port uses a named member per type -- a
    // joint sim is always exactly ONE type, so only its member is ever touched.
    b2DistanceJoint distanceJoint;
    b2RevoluteJoint revoluteJoint;
    b2WeldJoint weldJoint;
    b2PrismaticJoint prismaticJoint;
    b2WheelJoint wheelJoint;
    b2MotorJoint motorJoint;
};

struct b2JointSimArray { b2JointSim* data;  int count;  int capacity; };


// Cold joint: the persistent handle + graph connectivity (maps a joint id to a
// b2JointSim in the solver sets). Mirrors the cold b2Contact. Island fields are
// stubbed to B2_NULL_INDEX in slice 1 (islands deferred).
struct b2Joint
{
    void* userData;
    int setIndex;       // which solver set holds this joint's sim (NULL when free)
    int colorIndex;     // constraint-graph color (always NULL: no graph yet)
    int localIndex;     // index into the set's jointSims (NULL when free)

    b2JointEdge[2] edges;

    int jointId;
    int islandId;
    int islandIndex;

    float drawScale;

    int type;
    int generation;
    bool collideConnected;
};

struct b2JointArray { b2Joint* data;  int count;  int capacity; };


// Select edge 0 or 1 with CONSTANT indices (edges[] is a fixed array member; a
// variable index would miscompile -- same trap b2ContactEdgeAt solves). i is 0
// or 1 (a joint key's low bit).
b2JointEdge* b2JointEdgeAt( b2Joint* joint, int i )
{
    if( i == 0 )
        return &joint->edges[0];
    return &joint->edges[1];
}

#endif
