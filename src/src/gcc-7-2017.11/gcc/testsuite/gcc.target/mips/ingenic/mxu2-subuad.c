/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_d  s1, s2;
  union_signed_d  u,v;
  int i;
  int len = 2;
  s1.x = (v2u64){(1), (60000),};
  s2.x = (v2u64){(10), (1),};
  u.x = __builtin_mxu2_subua_d(s1.x, s2.x);

  for(i = 0; i < len; i++)
    v.a[i] = abs (s1.a[i] - s2.a[i]);

  if(check_d (&u, &v, len))
    abort ();
  return 0;
}




