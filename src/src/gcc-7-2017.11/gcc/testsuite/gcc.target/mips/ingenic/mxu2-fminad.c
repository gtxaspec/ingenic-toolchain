/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_float_d u, v, s1, s2;
  int i;
  int len = 2;
  s1.x = (v2f64){(1.0), (2.0),};
  s2.x = (v2f64){(-2.0), (-1.0),};
  u.x = __builtin_mxu2_fmina_d(s1.x, s2.x);

  for(i = 0; i < len; i++)
  {
     if(fabs (s1.a[i]) < fabs (s2.a[i]))
       v.a[i] = s1.a[i];
     else
       v.a[i] = s2.a[i];
  }

  if(check_fd (&u, &v, len))
    abort ();
  return 0;
}
