// probe p13 (2026-07-06): inline `asm{}` blocks as scalar intrinsics.
// QUESTION: can the port use statement-level asm blocks (the official math.h
// mechanism) to replace call-based fmin/fmax/fabs/sqrt in hot paths?
// VERIFIED BY COMPILATION (compile.exe v26.04.24, clean, see .asm):
//   - `{var}` interpolation works BOTH directions: `mov R0, {x}` (read) and
//     `mov {x}, R0` (write-back). The compiler substitutes the variable's
//     memory address textually (EmitAssemblyBlock, EmitNonExpressionNodes.cpp:844).
//   - float IMMEDIATES work as instruction operands: `fmax R0, 0.0` compiles.
//   - {var} only resolves PLAIN variable names (locals/globals/params) -- NOT
//     member/deref expressions. Copy `p->field` into a local first.
//   - Clobber rule: R0 is free between statements (compiler reloads from memory
//     each statement); push/pop any other register you touch (math.h style).
// MEASURED COST (from the emitted .asm, 1 instr ~= 1 cycle):
//   form 1  b2MaxFloat(x,0.0) call chain (b2MaxFloat -> fmax -> FMAX): 28 instr
//   form 2  inline if/else:                                            3-5 instr
//   form 3  asm intrinsic (below):                                     3 instr
// STATUS: compiled green; RUN ON EMULATOR (green/red) before relying on form 3.
#include "math.h"

float b2MaxFloat( float a, float b )
{
    return fmax( a, b );
}

float ga;
float gb;
float gr1;
float gr2;
float gr3;

void main( void )
{
    ga = 3.0;
    gb = 4.0;

    // form 1: double call (the port's current hot-path form)
    gr1 = b2MaxFloat( ga + 1.0, 0.0 );

    // form 2: inline if/else
    float ni = gb + 1.0;
    if( ni < 0.0 ) ni = 0.0;
    gr2 = ni;

    // form 3: asm intrinsic on a local
    float nj = gb + 2.0;
    asm
    {
        "mov R0, {nj}"
        "fmax R0, 0.0"
        "mov {nj}, R0"
    }
    gr3 = nj;

    // expected: gr1 == 4.0, gr2 == 5.0, gr3 == 6.0  (all clamps are no-ops here;
    // add a negative-input variant when wiring the green/red check)
}
