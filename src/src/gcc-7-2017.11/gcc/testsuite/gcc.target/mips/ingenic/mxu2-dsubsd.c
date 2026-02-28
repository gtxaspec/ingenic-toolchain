/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_w  s1, s2;
  union_signed_d  s3;
  union_signed_d  u, v;
  int i;
  int len = 2;
  s1.x = (v4i32){(1), (3), (5), (7),};
  s2.x = (v4i32){(2), (4), (6), (8),};
  s3.x = (v2i64){(100), (100),};
  u.x = __builtin_mxu2_dsubs_d(s3.x, s1.x, s2.x);

  v.x = (v2i64){(86), (14),};

  if(check_d (&u, &v, len))
    abort ();
  return 0;
}
