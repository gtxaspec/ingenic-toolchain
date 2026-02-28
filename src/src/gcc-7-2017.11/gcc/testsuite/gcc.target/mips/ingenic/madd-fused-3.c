/* { dg-do compile } */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "code quality test" { *-*-* } { "-O0" } { "" } } */
/* { dg-final { scan-assembler "fmaddw" } } */
/* { dg-final { scan-assembler "fmaddd" } } */
/* { dg-final { scan-assembler "fmsubw" } } */
/* { dg-final { scan-assembler "fmsubd" } } */

typedef float v4f32 __attribute__ ((__vector_size__ (16), aligned(16)));
typedef double v2f64 __attribute__ ((__vector_size__ (16), aligned(16)));

NOMIPS16 v4f32
sub1 (v4f32 f, v4f32 g, v4f32 h)
{
  return __builtin_mxu2_fmadd_w(h, f, g);
}

NOMIPS16 v2f64
sub2 (v2f64 f, v2f64 g, v2f64 h)
{
  return __builtin_mxu2_fmadd_d(h, f, g);
}

NOMIPS16 v4f32
sub3 (v4f32 f, v4f32 g, v4f32 h)
{
  return __builtin_mxu2_fmsub_w(h, f, g);
}

NOMIPS16 v2f64
sub4 (v2f64 f, v2f64 g, v2f64 h)
{
  return __builtin_mxu2_fmsub_d(h, f, g);
}
