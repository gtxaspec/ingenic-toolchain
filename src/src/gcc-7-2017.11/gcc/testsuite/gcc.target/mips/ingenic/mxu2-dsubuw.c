/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main ()
{
  union_unsigned_h  s1, s2;
  union_signed_w  s3;
  union_signed_w  u, v;
  int i;
  int len = 4;
  s1.x = (v8u16){(1), (3), (5), (7), (1), (3), (5), (7),};
  s2.x = (v8u16){(2), (4), (6), (8), (2), (4), (6), (8),};
  s3.x = (v4i32){(100), (100), (100), (100),};
  u.x = __builtin_mxu2_dsubu_w(s3.x, s1.x, s2.x);

  v.x = (v4i32){(86),(14),(86),(14),};

  if(check_w (&u, &v, len))
    abort ();
  return 0;
}
