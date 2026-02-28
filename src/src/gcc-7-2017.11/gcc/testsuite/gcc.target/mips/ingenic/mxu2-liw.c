/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_w u1, u2;
  union_signed_w v1, v2;
  int i;
  int len = 4;
  short value1 = -1;
  short value2 = 1;
  u1.x  = __builtin_mxu2_li_w(value1);
  u2.x  = __builtin_mxu2_li_w(value2);
  v1.x = (v4i32){(-1), (-1), (-1), (-1),};
  v2.x = (v4i32){(1), (1), (1), (1),};

  if(check_w (&u1, &v1, len))
    abort ();
  if(check_w (&u2, &v2, len))
    abort ();
  return 0;
}
