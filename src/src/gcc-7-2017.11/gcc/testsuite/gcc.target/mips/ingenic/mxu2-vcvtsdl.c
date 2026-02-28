/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_float_d u1, u2;
  union_float_d v1, v2;
  union_signed_d s1, s2, s3, s4;
  int i;
  int len = 2;
  s1.x = (v2i64){(1), (2),};
  s2.x = (v2i64){(3), (4),};

  u1.x = __builtin_mxu2_vcvtsdl(s1.x);
  v1.x = (v2f64){(1.0), (2.0),};
  for(i = 0; i < 2; i++)
  {
    if(u1.a[i] != v1.a[i])
      abort ();
  }

  u2.x = __builtin_mxu2_vcvtsdl(s2.x);
  v2.x = (v2f64){(3.0), (4.0),};
  for(i = 0; i < 2; i++)
  {
    if(u2.a[i] != v2.a[i])
      abort ();
  }

  return 0;
}
