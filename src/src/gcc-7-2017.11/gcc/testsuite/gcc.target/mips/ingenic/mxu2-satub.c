/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_b u1, v1, u2, v2;
  union_unsigned_b s;
  int i;
  int len = 16;
  s.x = (v16u8){(127), (1), (100), (1), (10), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  u1.x = __builtin_mxu2_satu_b(s.x, 6);
  u2.x = __builtin_mxu2_satu_b(s.x, 5);

  v1.x = (v16u8){(127), (1), (100), (1), (10), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  v2.x = (v16u8){(63), (1), (63), (1), (10), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};

  if(check_ub (&u1, &v1, len))
    abort ();
  if(check_ub (&u2, &v2, len))
    abort ();
  return 0;
}
