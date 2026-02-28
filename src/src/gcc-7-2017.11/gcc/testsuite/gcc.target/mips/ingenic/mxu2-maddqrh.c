/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h u1, u2, v, s1, s2,s3;
  int i;
  int len = 8;
  s1.x = (v8i16){(0x1000), (0xA000), (0x3000), (0x4000), (0x5000), (0x4000), (0x4000), (0x4000),};
  s2.x = (v8i16){(0x0040), (0xC000), (0x4000), (0x4000), (0x4000), (0x1000), (0x2000), (0x4000),};
  s3.x = (v8i16){(0x0040), (0x4000), (0x4000), (0x4000), (0x4000), (0x4), (0x2), (0x1),};
  u2.x = __builtin_mxu2_maddqr_h(s1.x, s2.x, s3.x);

  v.x = (v8i16){(0x1000),(0x8000),(0x5000),(0x6000),(0x7000),(0x4001),(0x4001),(0x4001),};

  if(check_h (&u2, &v, len))
    abort ();
  return 0;
}
