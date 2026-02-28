/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d u, v, s1, s2;
  int i;
  int len = 2;
  s1.x = (v2i64){(127), (-127),};
  s2.x = (v2i64){(-127), (127),};
  u.x = __builtin_mxu2_subss_d(s1.x, s2.x);

  v.x = (v2i64){(254), (-254),};

  if(check_d (&u, &v, len))
    abort ();
  return 0;
}
