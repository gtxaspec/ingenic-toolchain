/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_float_d u, v;
  int i;
  int len = 2;
  int value = 9;
  u.x = __builtin_mxu2_mffpu_d(value);

  v.x = (v2f64){(9.0), (9.0),};

  if(check_fd (&u, &v, len))
    abort ();

  return 0;
}
