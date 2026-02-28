/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h s1;
  union_signed_h u, v1, v2;
  int i;
  int len = 8;
  unsigned char position = 3;
  s1.x = (v8i16){(0),(1),(2),(3),(1),(1),(1),(1),};
  u.x = __builtin_mxu2_repx_h(s1.x, position);

  v2.x = (v8i16){(3),(3),(3),(3),(3),(3),(3),(3),};
  for(i = 0; i < len; i++)
  {
     v1.a[i] = s1.a[position];
  }

  if(check_h (&u, &v1, len))
    abort ();
  if(check_h (&u, &v2, len))
    abort ();

  return 0;
}
