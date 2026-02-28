/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_d u1, v1, u2, v2;
  union_unsigned_d s;
  int i;
  int len = 2;
  s.x = (v2u64){(254), (1),};
  u1.x = __builtin_mxu2_satu_d(s.x, 6);
  u2.x = __builtin_mxu2_satu_d(s.x, 5);

  v1.x = (v2u64){(127), (1),};
  v2.x = (v2u64){(63), (1),};

  if(check_ud (&u1, &v1, len))
    abort();
  if(check_ud (&u2, &v2, len))
    abort();
  return 0;
}
