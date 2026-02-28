/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_float_w u1, u2;
  union_float_w v1, v2;
  union_float_d s1, s2, s3, s4;
  int i;
  int len = 4;
  s1.x = (v2f64){(1.0), (2.0),};
  s2.x = (v2f64){(3.0), (4.0),};
  s3.x = (v2f64){(5.0), (6.0),};
  s4.x = (v2f64){(7.0), (8.0),};

  u1.x = __builtin_mxu2_vcvtsd(s2.x, s1.x);
  v1.x = (v4f32){(1.0), (3.0), (2.0), (4.0),};
  if(check_fw (&u1, &v1, len))
     abort ();

  u2.x = __builtin_mxu2_vcvtsd(s4.x, s3.x);
  v2.x = (v4f32){(5.0), (7.0), (6.0), (8.0),};
  if(check_fw (&u2, &v2, len))
     abort ();

  return 0;
}
