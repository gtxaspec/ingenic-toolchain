/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_float_d u, v, s1;
  int i;
  int len = 2;
  s1.x = (v2f64){(16), (1.44),};
  u.x = __builtin_mxu2_fsqrt_d(s1.x);

  v.x = (v2f64){(4), (1.2),};

  if(check_fd (&u, &v, len))
    abort ();
  return 0;
}
