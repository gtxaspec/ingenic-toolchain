/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void )
{
  union_float_w u, v, s1;
  int i;
  int len = 4;
  s1.x = (v4f32){(1.44), (4), (9), (16),};
  u.x = __builtin_mxu2_fsqrt_w(s1.x);

  v.x = (v4f32){(1.2), (2), (3), (4),};

  if(check_fw (&u, &v, len))
    abort ();
  return 0;
}
