/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h u1, u2;
  union_signed_h v1, v2;
  union_float_w s0, s1, s2, s3, s4;
  int i;
  int len = 8;
  s1.x = (v4f32){(0.5), (0.25), (0.125), (0.0625),};
  s2.x = (v4f32){(0.5), (0.25), (0.125), (0.0625),};

  u1.x = __builtin_mxu2_vcvtqhs(s2.x, s1.x);
  v1.x = (v8i16){(0x4000), (0x4000), (0x2000), (0x2000), (0x1000), (0x1000), (0x0800), (0x0800),};

  if(check_h (&u1, &v1, len))
     abort ();

  return 0;
}
