/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b u, v, s;
  int i;
  int len = 16;
  s.x = (v16i8){(0b1001), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  u.x = __builtin_mxu2_orib(s.x, 0b1100);

  for(i = 0; i < len; i++)
    v.a[i] = s.a[i] | 0b1100;

  if(check_b (&u, &v, len))
    abort ();
  return 0;
}
