/* { dg-do compile } */
/* { dg-options "-ffast-math -mmsa" } */
/* { dg-skip-if "code quality test" { *-*-* } { "-O0" } { "" } } */
/* { dg-final { scan-assembler-not "fmadd.w" } } */
/* { dg-final { scan-assembler-not "fmadd.d" } } */
/* { dg-final { scan-assembler-not "fmsub.w" } } */
/* { dg-final { scan-assembler-not "fmsub.d" } } */

typedef float v4f32 __attribute__ ((__vector_size__ (16), aligned(16)));
typedef double v2f64 __attribute__ ((__vector_size__ (16), aligned(16)));

NOMIPS16 v4f32
sub1 (v4f32 f, v4f32 g, v4f32 h)
{
  return ((f * g) + h);
}

NOMIPS16 v2f64
sub2 (v2f64 f, v2f64 g, v2f64 h)
{
  return ((f * g) + h);
}

NOMIPS16 v4f32
sub3 (v4f32 f, v4f32 g, v4f32 h)
{
  return (h - (f * g));
}

NOMIPS16 v2f64
sub4 (v2f64 f, v2f64 g, v2f64 h)
{
  return (h - (f * g));
}
