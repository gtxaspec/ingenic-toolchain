/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_signed_w u1, u2,v, s1, s2,s3;
  int i;
  int len = 4;
  s1.x = (v4i32){(0x10000000), (0x40000000), (0x40000000), (0x40000000),};
  s2.x = (v4i32){(0x00000040), (0x10000000), (0x20000000), (0x40000000),};
  s3.x = (v4i32){(0x00000040), (0x4), (0x2), (0x1),};
  u2.x = __builtin_mxu2_maddqr_w(s1.x, s2.x, s3.x);

  v.x = (v4i32){(0x10000000), (0x40000001), (0x40000001), (0x40000001),};

  if(check_w (&u2, &v, len))
    abort ();
  return 0;
}
