// PROBE 5: does a CPU hardware error reach the emulator DebugLog?
// We force sqrt of a negative (documented to trigger a hardware error).
// A global keeps the compiler from folding it at compile time.
#include "video.h"
#include "math.h"

int NegativeSource = 0;

void main()
{
    NegativeSource -= 1;            // now -1, not known at compile time
    float bad = sqrt( NegativeSource );  // should fault at runtime
    clear_screen( color_green );    // only reached if NO fault
}
