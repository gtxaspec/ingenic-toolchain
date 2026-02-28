/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_float_w u1, u2;
  union_float_w v1, v2;
  union_signed_w s1, s2, s3, s4;
  int i;
  int len = 4;
  s1.x = (v4i32){(1), (2), (3), (4),};
  s2.x = (v4i32){(5), (6), (7), (8),};

  u1.x = __builtin_mxu2_vcvtssw(s1.x);
  v1.x = (v4f32){(1.0), (2.0), (3.0), (4.0),};
  for(i = 0; i < 4; i++)
  {
    if(u1.a[i] != v1.a[i])
      abort ();
  }

  u2.x = __builtin_mxu2_vcvtssw(s2.x);
  v2.x = (v4f32){(5.0), (6.0), (7.0), (8.0),};
  for(i = 0; i < 4; i++)
  {
    if(u2.a[i] != v2.a[i])
      abort ();
  }

  return 0;
}
