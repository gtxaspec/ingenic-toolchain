/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_unsigned_w  s1, s2;
  union_signed_d  s3;
  union_signed_d  u, v;
  int i;
  int len = 2;
  s1.x = (v4u32){(1), (3), (5), (7),};
  s2.x = (v4u32){(2), (4), (9), (8),};
  s3.x = (v2i64){(100), (100),};
  u.x = __builtin_mxu2_dsubu_d(s3.x, s1.x, s2.x);

  v.x = (v2i64){(86), (-1),};

  if(check_d (&u, &v, len))
    abort ();
  return 0;
}
