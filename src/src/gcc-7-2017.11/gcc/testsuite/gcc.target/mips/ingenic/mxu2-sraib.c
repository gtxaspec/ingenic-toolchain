/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b u, v1, v2, s1, s2;
  int i;
  int len = 16;
  s1.x = (v16i8){(64), (32), (16), (8), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2), (2),};
  u.x = __builtin_mxu2_srai_b(s1.x, 1);


  for(i = 0; i < len; i++)
  {
     v1.a[i] = s1.a[i] >> 1;
  }

  v2.x = (v16i8){(32), (16), (8), (4), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};

  if(check_b (&u, &v1, len))
    abort ();
  if(check_b (&u, &v2, len))
    abort ();
  return 0;
}
