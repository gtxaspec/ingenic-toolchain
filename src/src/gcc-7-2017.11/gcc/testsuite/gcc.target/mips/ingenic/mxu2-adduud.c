/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_d u, v, s1, s2;
  int i;
  int len = 2;
  s1.x = (v2u64){(127), (255),};
  s2.x = (v2u64){(127), (255),};
  u.x = __builtin_mxu2_adduu_d(s1.x, s2.x);

  v.x = (v2u64){(254), (510),};

  if(check_ud (&u, &v, len))
   abort ();
 return 0;
}
