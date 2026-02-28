/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d u, v, s1, s2;
  int i;
  int len = 2;
  s1.x = (v2i64){(1), (1),};
  s2.x = (v2i64){(1), (1),};
  u.x = __builtin_mxu2_sub_d(s1.x, s2.x);

  for(i = 0; i < len; i++)
    v.a[i] = s1.a[i] - s2.a[i];

  if(check_d (&u, &v, len))
    abort ();
  return 0;
}
