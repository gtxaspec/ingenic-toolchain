/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d u, v1, v2, s1, s2;
  int i;
  int len = 2;
  s1.x = (v2i64){(10), (10),};
  s2.x = (v2i64){(10), (4),};
  u.x = __builtin_mxu2_ceq_d(s1.x, s2.x);


  for(i = 0; i < len; i++)
  {
    if (s1.a[i] ==  s2.a[i])
    {
       v1.a[i] = 0xFFFFFFFFFFFFFFFF;
    }
    else
    {
       v1.a[i] = 0;
    }
  }

  v2.x = (v2i64){(0xFFFFFFFFFFFFFFFF), (0),};

  if(check_d (&u, &v1, len))
    abort ();
  if(check_d (&u, &v2, len))
    abort ();
  return 0;
}
