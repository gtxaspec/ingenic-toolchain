/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_h  s1, s2;
  union_signed_h  u, v;
  int i;
  int len = 8;
  s1.x = (v8u16){(1), (60), (1), (3), (3), (3), (3), (3),};
  s2.x = (v8u16){(10), (1), (60), (1), (1), (1), (1), (1),};
  u.x = __builtin_mxu2_subua_h(s1.x, s2.x);

  for(i = 0; i < len; i++)
    v.a[i] = abs (s1.a[i] - s2.a[i]);

  if(check_h (&u, &v, len))
    abort ();
  return 0;
}
