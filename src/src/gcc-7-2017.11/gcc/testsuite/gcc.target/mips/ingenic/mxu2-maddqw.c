/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_w u, v, s1, s2,s3;
  int i;
  int len = 4;
  s1.x = (v4i32){(0x10000000), (0x20000000), (0x30000000), (0x40000000),};
  s2.x = (v4i32){(0x40000000), (0x40000000), (0x40000000), (0x40000000),};
  s3.x = (v4i32){(0x40000000), (0x40000000), (0x40000000), (0x40000000),};
  u.x = __builtin_mxu2_maddq_w(s1.x,s2.x,s3.x);

  v.x = (v4i32){(0x30000000),(0x40000000),(0x50000000),(0x60000000),};

  if(check_w (&u, &v, len))
    abort ();
  return 0;
}
