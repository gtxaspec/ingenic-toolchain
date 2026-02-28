/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_signed_b s1,s2;
  union_signed_b u, v1, v2;
  int i;
  int len = 16;
  unsigned char position = 2;
  s1.x = (v16i8){(1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  s2.x = (v16i8){(0), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15), (16),};
  u.x = __builtin_mxu2_insfmxu_b(s1.x, position, s2.x);

  v2.x = (v16i8){(1), (1), (0), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  for(i = 0; i < len; i++)
  {
     if(i != (int)position)
     {
        v1.a[i] = s1.a[i];
     }
     else
     {
        v1.a[i] = s2.a[0];
     }
  }

  if(check_b (&u, &v1, len))
    abort ();
  if(check_b (&u, &v2, len))
    abort ();

  return 0;
}
