/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_h u, v, s1, s2;
  int i;
  int len = 8;
  s1.x = (v8u16){(10), (10), (10), (10), (10), (10), (10), (10),};
  s2.x = (v8u16){(1), (2), (3), (4), (1), (1), (1), (1),};
  u.x = __builtin_mxu2_modu_h(s1.x, s2.x);

  for(i = 0; i < len; i++)
    v.a[i] = s1.a[i] % s2.a[i];

  if(check_uh (&u, &v, len))
    abort ();
  return 0;
}
