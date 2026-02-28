/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h u, v, s2, s3;
  int i;
  int len = 8;
  s2.x = (v8i16){(0x0040), (0x4000), (0x4000), (0x4000), (0x4000), (0x1000), (0x2000), (0x4000),};
  s3.x = (v8i16){(0x0040), (0x4000), (0x4000), (0x4000), (0x4000), (0x4), (0x2), (0x1),};
  u.x = __builtin_mxu2_mulqr_h(s2.x, s3.x);

  v.x = (v8i16){(0), (0x2000), (0x2000), (0x2000), (0x2000), (0x1), (0x1), (0x1),};

  if(check_h (&u, &v, len))
    abort ();
  return 0;
}
