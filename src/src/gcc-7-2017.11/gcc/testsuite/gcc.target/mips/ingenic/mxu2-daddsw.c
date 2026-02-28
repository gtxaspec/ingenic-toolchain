/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h  s1, s2;
  union_signed_w  s3;
  union_signed_w  u, v;
  int i;
  int len = 4;
  s1.x = (v8i16){(1), (3), (5), (7), (-1), (3), (-5), (7),};
  s2.x = (v8i16){(2), (4), (6), (8), (2), (4), (6), (8),};
  s3.x = (v4i32){(1), (1), (1), (1),};
  u.x = __builtin_mxu2_dadds_w(s3.x, s1.x, s2.x);

  v.x = (v4i32){(15), (87), (11), (27),};

  if(check_w (&u, &v, len))
    abort ();
  return 0;
}
