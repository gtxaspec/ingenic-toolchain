/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b u1, v1, u2, v2;
  union_signed_b s;
  int i;
  int len = 16;
  s.x = (v16i8){(127), (-127), (100), (-100), (10), (-10), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  u1.x = __builtin_mxu2_sats_b(s.x, 7);
  u2.x = __builtin_mxu2_sats_b(s.x, 6);

  v1.x = (v16i8){(127), (-127), (100), (-100), (10), (-10), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  v2.x = (v16i8){(63), (-64), (63), (-64), (10), (-10), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};

  if(check_b (&u1, &v1, len))
    abort ();
  if(check_b (&u2, &v2, len))
    abort ();
  return 0;
}
