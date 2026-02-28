/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_w u, v, s1, s2;
  int i;
  int len = 4;
  s1.x = (v4u32){(10), (10), (10), (10),};
  s2.x = (v4u32){(1), (2), (3), (4),};
  u.x = __builtin_mxu2_averu_w(s1.x, s2.x);

  for(i = 0; i < len; i++)
    v.a[i] = (s1.a[i] + s2.a[i] + 1)/2;

  if(check_uw (&u, &v, len))
   abort ();
 return 0;
}
