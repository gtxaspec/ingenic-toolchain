/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d s1;
  union_signed_d u, v1, v2;
  int i;
  int len = 2;
  unsigned char position = 1;
  s1.x = (v2i64){(0), (3),};
  u.x = __builtin_mxu2_repi_d(s1.x, 1);

  v2.x = (v2i64){(3), (3),};
  for(i = 0; i < len; i++)
  {
     v1.a[i] = s1.a[position];
  }

  if(check_d (&u, &v1, len))
    abort ();
  if(check_d (&u, &v2, len))
    abort ();

  return 0;
}
