/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_signed_w s1;
  union_signed_w u, v1, v2;
  int i;
  int len = 4;
  unsigned char position = 3;
  s1.x = (v4i32){(0), (1), (2), (3),};
  u.x = __builtin_mxu2_repi_w(s1.x, 3);

  v2.x = (v4i32){(3), (3), (3), (3),};
  for(i = 0; i < len; i++)
  {
     v1.a[i] = s1.a[position];
  }

  if(check_w (&u, &v1, len))
    abort ();
  if(check_w (&u, &v2, len))
    abort ();

  return 0;
}
