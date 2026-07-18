/* *****************************************************************************
*  VirconBox2D : b2_constants.h        (port of Box2D v3 include/box2d/constants.h)
*  --------------------------------------------------------------------------- *
*  Tunable constants. Ported notes:                                            *
*   - Single-precision branch only (#if BOX2D_DOUBLE_PRECISION dropped).       *
*   - Scientific-notation literals rewritten longhand (1.0e5f -> 100000.0).    *
*   - 'f' float suffixes stripped (the console lexer rejects them).            *
*   - Length-unit-scaled constants expand to a call to b2GetLengthUnitsPerMeter*
*     so they track the runtime scale, exactly as upstream.                    *
***************************************************************************** */

// *****************************************************************************
    #ifndef B2_CONSTANTS_H
    #define B2_CONSTANTS_H

    #include "b2_math.h"
// *****************************************************************************


// detect bad values; ~100km limit is safe in single precision (1.0e5)
#define B2_HUGE ( 100000.0 * b2GetLengthUnitsPerMeter() )

// maximum parallel workers (fixed-size arrays). On Vircon32 the task system is
// serial, but the constant is kept so array sizes/types match upstream.
#define B2_MAX_WORKERS 32

// maximum tasks queued per world step
#define B2_MAX_TASKS 256

// maximum colors in the constraint graph
#define B2_GRAPH_COLOR_COUNT 24

// collision/constraint tolerance, ~0.5cm in meters
#define B2_LINEAR_SLOP ( 0.005 * b2GetLengthUnitsPerMeter() )

// maximum number of simultaneous worlds
#define B2_MAX_WORLDS 128

// maximum length of a body name (0 disables names)
#define B2_NAME_LENGTH 10

// maximum body rotation per step (numerical safety)
#define B2_MAX_ROTATION ( 0.25 * B2_PI )

// limited speculative collision distance, ~2cm
#define B2_SPECULATIVE_DISTANCE ( 4.0 * B2_LINEAR_SLOP )

// default contact recycling distance
#define B2_CONTACT_RECYCLE_DISTANCE ( 10.0 * B2_LINEAR_SLOP )

// default contact recycling world angle threshold (~11.5 degrees)
#define B2_CONTACT_RECYCLE_COS_ANGLE ( 0.98 )

// AABB fattening in the dynamic tree, ~5cm
#define B2_MAX_AABB_MARGIN ( 0.05 * b2GetLengthUnitsPerMeter() )

// for small objects the margin is limited to this fraction of the max extent
#define B2_AABB_MARGIN_FRACTION 0.125

// time a body must be still before sleeping, in seconds
#define B2_TIME_TO_SLEEP 0.5


// *****************************************************************************
    #endif
// *****************************************************************************
