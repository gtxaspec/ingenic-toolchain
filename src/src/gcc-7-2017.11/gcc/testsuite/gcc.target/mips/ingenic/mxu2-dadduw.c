/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_h  s1, s2;
  union_unsigned_w  s3;
  union_unsigned_w  u, v;
  int i;
  int len = 4;
  s1.x = (v8u16){(1), (3), (5), (7), (1), (3), (5), (7),};
  s2.x = (v8u16){(2), (4), (6), (8), (2), (4), (6), (8),};
  s3.x = (v4u32){(1), (1), (1), (1),};
  u.x = __builtin_mxu2_daddu_w(s3.x, s1.x, s2.x);

  v.x = (v4u32){(15), (87), (15), (87),};

  if(check_uw (&u, &v, len))
    abort ();
  return 0;
}
