/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"
#include <stdlib.h>

int main (void)
{
  union_signed_w u, v, s1, s2;
  int i;
  int len = 4;
  s1.x = (v4i32){(1), (1), (1), (1),};
  s2.x = (v4i32){(-1), (-1), (1), (1),};
  u.x = __builtin_mxu2_addas_w(s1.x, s2.x);

  for(i = 0; i < len; i++)
    v.a[i]= abs (s1.a[i]) + abs (s2.a[i]);

  if(check_w (&u, &v, len))
   abort ();
 return 0;
}
