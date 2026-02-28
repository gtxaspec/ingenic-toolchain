/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"
#include <stdlib.h>

int main (void)
{
  union_signed_b u, v1, v2, s1, s2;
  int i;
  int len = 16;
  s1.x = (v16i8){(-10), (10), (10), (10), (10), (10), (10), (10), (10), (10), (10), (10), (10), (10), (10), (10),};
  s2.x = (v16i8){(-10), (10), (3), (4), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  u.x = __builtin_mxu2_ceq_b(s1.x, s2.x);

  for(i = 0; i < len; i++)
  {
    if (s1.a[i] ==  s2.a[i])
    {
       v1.a[i] = 0xFF;
    }
    else
    {
       v1.a[i] = 0;
    }
  }

  v2.x = (v16i8){(0xFF), (0xFF), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0),};

  if(check_b (&u, &v1, len))
    abort ();
  if(check_b (&u, &v2, len))
    abort ();
  return 0;
}
