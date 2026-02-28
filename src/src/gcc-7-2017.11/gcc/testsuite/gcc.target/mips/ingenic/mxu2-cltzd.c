/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d u, v1, v2, s1;
  int i;
  int len = 2;
  s1.x = (v2i64){(10), (0),};
  u.x = __builtin_mxu2_cltz_d(s1.x);

  for(i = 0; i < len; i++)
  {
    if (s1.a[i] < 0)
    {
       v1.a[i] = 0xFFFFFFFFFFFFFFFF;
    }
    else
    {
       v1.a[i] = 0;
    }
  }

  v2.x = (v2i64){(0), (0),};

  if(check_d (&u, &v1, len))
    abort ();
  if(check_d (&u, &v2, len))
    abort ();
  return 0;
}
