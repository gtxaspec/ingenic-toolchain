/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"



int main (void)
{
  union_signed_w u1, u2;
  union_signed_w v1, v2;
  union_float_d s0, s1, s2, s3, s4;
  int i;
  int len = 4;
  s1.x = (v2f64){(0.5), (0.25),};
  s2.x = (v2f64){(0.5), (0.25),};

  u1.x = __builtin_mxu2_vcvtqwd(s2.x, s1.x);
  v1.x = (v4i32){(0x40000000), (0x40000000), (0x20000000), (0x20000000),};
  if(check_w (&u1, &v1, len))
     abort ();

  return 0;
}
