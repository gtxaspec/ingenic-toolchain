/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_unsigned_b  s1, s2;
  union_signed_b  u, v;
  int i;
  int len = 16;
  s1.x = (v16u8){(1), (10), (1), (3), (3), (3), (3), (3), (3), (3), (3), (3), (3), (3), (3), (3),};
  s2.x = (v16u8){(10), (1), (10), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  u.x = __builtin_mxu2_subua_b(s1.x, s2.x);

  for(i = 0; i < len; i++)
    v.a[i] = abs (s1.a[i] - s2.a[i]);

  if(check_b (&u, &v, len))
    abort ();
  return 0;
}
