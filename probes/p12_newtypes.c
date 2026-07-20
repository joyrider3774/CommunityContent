// p12 (2026-07-05): does v26.04.24 actually accept const / char / short / long / double,
// as the DevTools Readme changelog claims? The dialect doc §2 said these are REJECTED.
// VERDICT: the CHANGELOG is right, the dialect doc was STALE. This file compiles AND
// assembles clean (compile EXIT=0, assemble EXIT=0) against compile.exe v26.04.24.
//   - const decls            : ACCEPTED
//   - function-like macros   : ACCEPTED (already used in the port)
//   - char / short / long    : ACCEPTED, treated internally as int  (still 1 word / 32-bit,
//                              so NO memory or range change -- pure source compatibility)
//   - double                 : ACCEPTED, treated internally as float (single precision,
//                              so NO extra precision -- pure source compatibility)
// CAVEAT: these buy COMPATIBILITY (less editing of upstream), not CAPABILITY. Every hard
// constraint still stands: no struct-by-value across fn boundary, no anonymous union
// (named unions DO work -- p11 corrected 2026-07-18), no ternary,
// no compound literals, float-underflow<~1e-6, word-addressed memory, NULL==-1.
#include "math.h"

#define SQR(a) ((a)*(a))          // function-like macro w/ arg (should already work in v26)

const int   KFIVE = 5;            // const declaration
const float KHALF = 0.5;          // const float

double gd = 2.5;                  // double treated as float?
char   gc = 65;                   // char treated as int?
short  gs = 7;                    // short treated as int?
long   gl = 9;                    // long treated as int?

void main()
{
    double ld = gd + KHALF;       // double local + const
    char   lc = gc + 1;           // char local arithmetic
    int    m  = SQR(KFIVE);       // macro expansion -> 25
    float  r  = ld * lc * m;
    // touch r so it's not dead-code-eliminated
    if( r > 0.0 ) gs = gl;
}
