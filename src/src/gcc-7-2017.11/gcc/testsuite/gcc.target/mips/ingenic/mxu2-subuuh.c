/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_h u, v, s1, s2;
  int i;
  int len = 8;
  s1.x = (v8u16){(1), (255), (32767), (65534), (3), (3), (3), (3),};
  s2.x = (v8u16){(127), (255), (32767), (65534), (1), (1), (1), (1),};
  u.x = __builtin_mxu2_subuu_h(s1.x, s2.x);

  v.x = (v8u16){(0), (0), (0), (0), (2), (2), (2), (2),};

  if(check_uh (&u, &v, len))
    abort ();
  return 0;
}
