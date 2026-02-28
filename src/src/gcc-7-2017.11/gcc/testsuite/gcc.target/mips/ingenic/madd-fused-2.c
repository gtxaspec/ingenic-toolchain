/* { dg-do compile } */
/* { dg-options "-ffast-math -mfused-madd -mmxu2" } */
/* { dg-skip-if "code quality test" { *-*-* } { "-O0" } { "" } } */
/* { dg-final { scan-assembler "nmadd.s" } } */
/* { dg-final { scan-assembler "nmadd.d" } } */
/* { dg-final { scan-assembler "nmsub.s" } } */
/* { dg-final { scan-assembler "nmsub.d" } } */
/* { dg-final { scan-assembler "madd.s" } } */
/* { dg-final { scan-assembler "madd.d" } } */
/* { dg-final { scan-assembler "msub.s" } } */
/* { dg-final { scan-assembler "msub.d" } } */
/* { dg-final { scan-assembler "fmaddw" } } */
/* { dg-final { scan-assembler "fmaddd" } } */
/* { dg-final { scan-assembler "fmsubw" } } */
/* { dg-final { scan-assembler "fmsubd" } } */


NOMIPS16 float
sub1 (float f, float g, float h)
{
  return -((f * g) + h);
}

NOMIPS16 double
sub2 (double f, double g, double h)
{
  return -((f * g) + h);
}

NOMIPS16 float
sub3 (float f, float g, float h)
{
  return -((f * g) - h);
}

NOMIPS16 double
sub4 (double f, double g, double h)
{
  return -((f * g) - h);
}

NOMIPS16 float
sub5 (float f, float g, float h)
{
  return ((f * g) + h);
}

NOMIPS16 double
sub6 (double f, double g, double h)
{
  return ((f * g) + h);
}

NOMIPS16 float
sub7 (float f, float g, float h)
{
  return ((f * g) - h);
}

NOMIPS16 double
sub8 (double f, double g, double h)
{
  return ((f * g) - h);
}

typedef float v4f32 __attribute__ ((__vector_size__ (16), aligned(16)));
typedef double v2f64 __attribute__ ((__vector_size__ (16), aligned(16)));

NOMIPS16 v4f32
sub9 (v4f32 f, v4f32 g, v4f32 h)
{
  return ((f * g) + h);
}

NOMIPS16 v2f64
sub10 (v2f64 f, v2f64 g, v2f64 h)
{
  return ((f * g) + h);
}

NOMIPS16 v4f32
sub11 (v4f32 f, v4f32 g, v4f32 h)
{
  return (h - (f * g));
}

NOMIPS16 v2f64
sub12 (v2f64 f, v2f64 g, v2f64 h)
{
  return (h - (f * g));
}
