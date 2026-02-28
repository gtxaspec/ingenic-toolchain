/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_signed_h u, v, s1, s2;
  int i;
  int len = 8;
  s1.x = (v8i16){(10), (10), (10), (10), (10), (10), (10), (10),};
  s2.x = (v8i16){(1), (2), (-3), (-4), (1), (2), (3), (4),};
  u.x = __builtin_mxu2_mods_h(s1.x, s2.x);

  for(i = 0; i < len; i++)
    v.a[i] = s1.a[i] % s2.a[i];

  if(check_h (&u, &v, len))
    abort ();
  return 0;
}
