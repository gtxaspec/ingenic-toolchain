/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_w u1, v1, u2, v2;
  union_signed_w s;
  int i;
  int len = 4;
  s.x = (v4i32){(127), (-127), (255), (-255),};
  u1.x = __builtin_mxu2_sats_w(s.x, 7);
  u2.x = __builtin_mxu2_sats_w(s.x, 6);

  v1.x = (v4i32){(127), (-127), (127), (-128),};
  v2.x = (v4i32){(63), (-64), (63), (-64),}; 

  if(check_w (&u1, &v1, len))
    abort ();
  if(check_w (&u2, &v2, len))
    abort ();
  return 0;
}
