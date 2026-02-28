/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_w u, v, s1, s2;
  int i;
  int len = 4;
  s1.x = (v4i32){(127), (255), (32767), (65534),};
  s2.x = (v4i32){(-127), (-255), (-32767), (-100),};
  u.x = __builtin_mxu2_subss_w(s1.x, s2.x);

  v.x = (v4i32){(254), (510), (65534), (65634),};

  if(check_w (&u, &v, len))
    abort ();
  return 0;
}
