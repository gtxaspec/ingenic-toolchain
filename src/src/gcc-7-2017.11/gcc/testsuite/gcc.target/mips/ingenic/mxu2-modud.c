/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_unsigned_d u, v, s1, s2;
  int i;
  int len = 2;
  s1.x = (v2u64){(10), (10),};
  s2.x = (v2u64){(3), (4),};
  u.x = __builtin_mxu2_modu_d(s1.x, s2.x);

  for(i = 0; i < len; i++)
    v.a[i] = s1.a[i] % s2.a[i];

  if(check_ud (&u, &v, len))
    abort ();
  return 0;
}
