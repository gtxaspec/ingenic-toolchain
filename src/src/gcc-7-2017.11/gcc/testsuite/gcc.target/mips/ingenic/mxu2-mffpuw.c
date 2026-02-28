/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_float_w u, v;
  int i;
  int len = 4;
  int value = 9;
  u.x = __builtin_mxu2_mffpu_w(value);

  v.x = (v4f32){(9.0), (9.0), (9.0), (9.0),};

  if(check_fw (&u, &v, len))
    abort ();

  return 0;
}
