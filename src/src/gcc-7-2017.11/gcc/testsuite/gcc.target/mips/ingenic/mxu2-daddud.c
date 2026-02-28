/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_w  s1, s2;
  union_unsigned_d  s3;
  union_unsigned_d  u, v;
  int i;
  int len = 2;
  s1.x = (v4u32){(1), (3), (5), (7),};
  s2.x = (v4u32){(2), (4), (6), (8),};
  s3.x = (v2u64){(1), (1),};
  u.x = __builtin_mxu2_daddu_d(s3.x, s1.x, s2.x);

  v.x = (v2u64){(15),(87),};

  if(check_ud (&u, &v, len))
    abort ();
  return 0;
}
