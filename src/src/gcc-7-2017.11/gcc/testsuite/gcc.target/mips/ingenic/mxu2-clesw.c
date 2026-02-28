/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_w u, v1, v2, s1, s2;
  int i;
  int len = 4;
  s1.x = (v4i32){(10), (10), (10), (10),};
  s2.x = (v4i32){(-10), (0), (10), (40),};
  u.x = __builtin_mxu2_cles_w(s1.x, s2.x);

  for(i = 0; i < len; i++)
  {
    if (s1.a[i] <=  s2.a[i])
    {
       v1.a[i] = 0xFFFFFFFF;
    }
    else
    {
       v1.a[i] = 0;
    }
  }

  v2.x = (v4i32){(0), (0), (0xFFFFFFFF), (0xFFFFFFFF),};

  if(check_w (&u, &v1, len))
    abort ();
  if(check_w (&u, &v2, len))
    abort ();
  return 0;
}
