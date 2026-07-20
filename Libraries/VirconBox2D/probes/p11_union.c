// p11 (2026-07-05, CORRECTED 2026-07-18): does the Vircon32 C compiler support `union`?
// VERDICT: YES for NAMED union types; NO for anonymous inline union members.
//
// The original probe tested only the anonymous inline form
//     struct S { int t; union { int x; float y; } u; };
// which fails with "fatal error: expected a type" -- and the verdict was wrongly
// generalized to "union is not supported at all". Re-probed 2026-07-18 against
// compile.exe v26.04.24: a union declared as a named type at file scope compiles,
// has true overlaid storage (sizeof == max member, not sum; members alias the same
// address in the generated asm), and works as a struct member. The compiler source
// (CCompiler/DataTypes.hpp: UnionType/UnionNode) confirms unions are a first-class type.
//
// Consequence: b2JointSim's named-member-per-joint-type layout was built on the wrong
// verdict. CONVERTED 2026-07-19 to `union b2JointPayload` (sim->u.<type>Joint):
// sizeof(b2JointSim) 212 -> 63 words, all harnesses/ROMs re-verified green.
//
// This file COMPILES (unlike the original probe). The still-unsupported form is kept
// below behind a comment as the record of what fails.

struct Two { int a; int b; };
union U2 { int x; Two pair; };   // sizeof(U2) == 2 (max member), overlaid storage
struct S { int t; U2 u; };       // sizeof(S) == 3

// STILL FAILS ("expected a type") -- anonymous inline union member:
//   struct Bad { int t; union { int x; float y; } u; };

void main()
{
    S s;
    s.u.pair.a = 7;
    int alias = s.u.x;   // reads the same word as pair.a (verified in asm)
}
