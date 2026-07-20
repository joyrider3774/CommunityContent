// *****************************************************************************
//                                                                             *
//   b2_mover.h  --  port of box2d/src/mover.c                                 *
//                                                                             *
//   The character-controller kernel: given the collision planes gathered by    *
//   b2World_CollideMover, resolve where the mover may actually go, and clip    *
//   its velocity against the surfaces it ended up touching.                    *
//                                                                             *
//   Usage each frame:                                                          *
//     1. b2World_CollideMover  -> collect b2PlaneResults into b2CollisionPlanes *
//     2. b2SolvePlanes( targetDelta, planes, count, &result )                  *
//     3. move the mover by result.translation                                  *
//     4. b2ClipVector( velocity, planes, count, &velocity )                    *
//                                                                             *
//   Port idiom: upstream returns b2PlaneSolverResult / b2Vec2 by value; both   *
//   are > 1 word, so they become OUT-pointers as the last argument. The        *
//   b2CollisionPlane array is mutated in place through a pointer walk.         *
//                                                                             *
// *****************************************************************************
    #ifndef B2_MOVER_H
    #define B2_MOVER_H

    #include "b2_math.h"
    #include "b2_constants.h"
    #include "b2_collision.h"
// *****************************************************************************


// Find the translation nearest `targetDelta` that satisfies every collision plane.
//
// A 20-iteration relaxation: each pass pushes the running delta out of any plane it
// violates, accumulating a per-plane push clamped to [0, pushLimit] so that planes
// cannot pull the mover back in. Converges when the total push in a pass drops below
// one linear slop. Writes each plane's `push`, which b2ClipVector then reads.
//
// The `+ B2_LINEAR_SLOP` on the separation is deliberate: it leaves the mover a slop
// clear of the surface rather than exactly on it, which stops the mover jittering
// between touching and not touching on successive frames.
void b2SolvePlanes( b2Vec2* targetDelta, b2CollisionPlane* planes, int count,
                    b2PlaneSolverResult* result )
{
    int i;
    for( i = 0; i < count; ++i )
        planes[i].push = 0.0;

    b2Vec2 delta = *targetDelta;
    float tolerance = B2_LINEAR_SLOP;

    int iteration;
    for( iteration = 0; iteration < 20; ++iteration )
    {
        float totalPush = 0.0;

        int planeIndex;
        for( planeIndex = 0; planeIndex < count; ++planeIndex )
        {
            b2CollisionPlane* plane = planes + planeIndex;

            // add slop to prevent jitter
            float separation = b2PlaneSeparation( &plane->plane, &delta ) + B2_LINEAR_SLOP;
            // if( separation > 0.0 )
            //     continue;                    // (left commented out upstream too)

            float push = -separation;

            // clamp the accumulated push so a plane can only push, never pull
            float accumulatedPush = plane->push;
            plane->push = b2ClampFloat( plane->push + push, 0.0, plane->pushLimit );
            push = plane->push - accumulatedPush;

            b2MulAdd( &delta, push, &plane->plane.normal, &delta );

            // track the total push for convergence
            totalPush = totalPush + b2AbsFloat( push );
        }

        if( totalPush < tolerance )
            break;
    }

    result->translation = delta;
    result->iterationCount = iteration;
}


// Remove the components of `vector` that drive into any plane the solver actually
// pushed against (push != 0) and that asks for velocity clipping. This is what stops
// a character accumulating speed into a wall while still letting it slide along.
//
// Only the INWARD component is removed (b2MinFloat with 0), so motion away from a
// surface is untouched.
void b2ClipVector( b2Vec2* vector, b2CollisionPlane* planes, int count, b2Vec2* result )
{
    b2Vec2 v = *vector;

    int planeIndex;
    for( planeIndex = 0; planeIndex < count; ++planeIndex )
    {
        b2CollisionPlane* plane = planes + planeIndex;
        if( plane->push == 0.0 || plane->clipVelocity == false )
            continue;

        float s = b2MinFloat( 0.0, b2Dot( &v, &plane->plane.normal ) );
        b2MulSub( &v, s, &plane->plane.normal, &v );
    }

    *result = v;
}


// *****************************************************************************
    #endif
// *****************************************************************************
