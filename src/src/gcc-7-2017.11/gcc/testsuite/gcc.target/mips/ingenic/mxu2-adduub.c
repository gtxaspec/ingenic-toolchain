/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_b u, v, s1, s2;
  int i;
  int len = 16;
  s1.x = (v16u8){(127), (250), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  s2.x = (v16u8){(127), (250), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  u.x = __builtin_mxu2_adduu_b(s1.x, s2.x);

  v.x = (v16u8){(254), (255), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2),};

  if(check_ub (&u, &v, len))
   abort ();
 return 0;
}
