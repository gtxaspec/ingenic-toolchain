/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_w  s1, s2;
  union_signed_w  u, v;
  int i;
  int len = 4;
  s1.x = (v4u32){(1), (60000), (1), (3),};
  s2.x = (v4u32){(10), (1), (60000), (1),};
  u.x = __builtin_mxu2_subua_w(s1.x, s2.x);

  for(i = 0; i < len; i++)
    v.a[i] = abs (s1.a[i] - s2.a[i]);

  if(check_w (&u, &v, len))
    abort ();
  return 0;
}
