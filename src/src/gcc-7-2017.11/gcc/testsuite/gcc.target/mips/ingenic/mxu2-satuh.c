/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_h u1, v1, u2, v2;
  union_unsigned_h s;
  int i;
  int len = 4;
  s.x = (v8u16){(127), (1), (255), (1), (10), (10), (1), (1),};
  u1.x = __builtin_mxu2_satu_h(s.x, 6);
  u2.x = __builtin_mxu2_satu_h(s.x, 5);

  v1.x = (v8u16){(127), (1), (127), (1), (10), (10), (1), (1),};
  v2.x = (v8u16){(63), (1), (63), (1), (10), (10), (1), (1),};

  if(check_uh (&u1, &v1, len))
    abort ();
  if(check_uh (&u2, &v2, len))
    abort ();
  return 0;
}
