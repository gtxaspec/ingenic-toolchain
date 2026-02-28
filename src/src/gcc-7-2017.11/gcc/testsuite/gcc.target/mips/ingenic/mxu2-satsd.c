/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_signed_d u1, v1, u2, v2;
  union_signed_d s;
  int i;
  int len = 2;
  s.x = (v2i64){(255), (-255),};
  u1.x = __builtin_mxu2_sats_d(s.x, 7);
  u2.x = __builtin_mxu2_sats_d(s.x, 6);

  v1.x = (v2i64){(127), (-128),};
  v2.x = (v2i64){(63), (-64),};

  if(check_d(&u1, &v1, len))
    abort ();
  if(check_d(&u2, &v2, len))
    abort ();
  return 0;
}
