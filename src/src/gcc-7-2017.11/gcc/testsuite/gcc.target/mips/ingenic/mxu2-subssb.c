/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"
#include <stdlib.h>

int main()
{
  union_signed_b u, v, s1, s2;
  int i;
  int len = 16;
  s1.x = (v16i8){(127), (-127), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  s2.x = (v16i8){(-127), (127), (-1), (-1), (-1), (-1), (-1), (-1), (-1), (-1), (-1), (-1), (-1), (-1), (-1), (-1),};
  u.x = __builtin_mxu2_subss_b(s1.x, s2.x);

  v.x = (v16i8){(127), (-128), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2),};

  if(check_b (&u, &v, len))
    abort ();
  return 0;
}
