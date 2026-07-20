// =============================================================================
//   virconbox2d.h -- the whole engine in one include
// =============================================================================
//   #include "virconbox2d.h" and you have the full b2* API. The port headers
//   carry their own implementations (single translation unit, no linker) and
//   include their own dependencies behind guards, so this list is belt-and-
//   braces -- but it is the attested-green order, so keep it.
//
//   You still include the console headers your game needs (video.h, input.h,
//   time.h). math.h / string.h / misc.h come in transitively via the port.
//
//   NOT included here on purpose:
//     port/b2_validate.h -- b2ValidateWorld, the structural safety net. Single
//       TU means every included function lands in the ROM, and this one is a dev
//       tool, not game code. Add it yourself, AFTER this header, when debugging:
//           #include "virconbox2d.h"
//           #include "port/b2_validate.h"
//
//   For the game-facing sugar layer (one implicit world, int handles, scalar
//   in/out) include "vb2.h" instead -- it pulls this in for you.
// =============================================================================

#ifndef VIRCONBOX2D_H
#define VIRCONBOX2D_H

#include "port/b2_math.h"
#include "port/b2_constants.h"
#include "port/b2_aabb.h"
#include "port/b2_geometry.h"
#include "port/b2_hull.h"
#include "port/b2_distance.h"
#include "port/b2_manifold.h"
#include "port/b2_ctz.h"
#include "port/b2_core.h"
#include "port/b2_dynamic_tree.h"
#include "port/b2_id_pool.h"
#include "port/b2_arena_allocator.h"
#include "port/b2_shape.h"
#include "port/b2_body.h"
#include "port/b2_bitset.h"
#include "port/b2_table.h"
#include "port/b2_solver.h"
#include "port/b2_mover.h"

#endif
