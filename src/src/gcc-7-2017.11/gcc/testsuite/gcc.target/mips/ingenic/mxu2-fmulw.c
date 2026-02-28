/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_float_w u, v, s1, s2;
  int i;
  int len = 4;
  s1.x = (v4f32){(0.11), (2), (-41), (1),};
  s2.x = (v4f32){(2), (0.1), (-11), (1),};
  u.x = __builtin_mxu2_fmul_w(s1.x, s2.x);

  for(i = 0; i < len; i++)
    v.a[i] = s1.a[i] * s2.a[i];

  if(check_fw (&u, &v, len))
    abort ();
  return 0;
}
