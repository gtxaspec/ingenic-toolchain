/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b u, v1, v2, s1;
  int i;
  int len = 16;
  s1.x = (v16i8){(10), (10), (0), (-10), (-10), (-10), (-10), (-10), (-10), (-10), (-10), (-10), (-10), (-10), (-10), (-10),};
  u.x = __builtin_mxu2_cltz_b(s1.x);

  for(i = 0; i < len; i++)
  {
    if (s1.a[i] < 0)
    {
       v1.a[i] = 0xFF;
    }
    else
    {
       v1.a[i] = 0;
    }
  }

  v2.x = (v16i8){(0), (0), (0), (0xFF), (0xFF), (0xFF), (0xFF), (0xFF), (0xFF), (0xFF), (0xFF), (0xFF), (0xFF), (0xFF), (0xFF), (0xFF),};

  if(check_b (&u, &v1, len))
    abort ();
  if(check_b (&u, &v2, len))
    abort ();
  return 0;
}
