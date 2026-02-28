/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_float_w u1, u2;
  union_float_w v1, v2;
  union_signed_h s0, s1, s2, s3, s4;
  int i;
  int len = 4;
  s1.x = (v8i16){(0x4000), (0x2000), (0x1000), (0x0800),
		 (0x0400), (0x0200), (0x0100), (0x0080),};

  u1.x = __builtin_mxu2_vcvtqesh(s1.x);
  v1.x = (v4f32){(0.5), (0.125), (0.03125), (0.0078125),};

  if(check_fw(&u1, &v1, len))
    abort();

  return 0;
}
