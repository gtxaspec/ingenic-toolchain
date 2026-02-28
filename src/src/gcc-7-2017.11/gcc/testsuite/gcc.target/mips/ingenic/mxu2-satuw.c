/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_w u1, v1, u2, v2;
  union_unsigned_w s;
  int i;
  int len = 4;
  s.x = (v4u32){(127), (1), (255), (1),};
  u1.x = __builtin_mxu2_satu_w(s.x, 6);
  u2.x = __builtin_mxu2_satu_w(s.x, 5);

  v1.x = (v4u32){(127), (1), (127), (1),};
  v2.x = (v4u32){(63), (1), (63), (1),};

  if(check_uw (&u1, &v1, len))
    abort ();
  if(check_uw (&u2, &v2, len))
    abort ();
  return 0;
}
