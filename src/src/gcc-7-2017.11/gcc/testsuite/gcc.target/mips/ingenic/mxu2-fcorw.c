/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"
int main (void)
{
  union_float_w  s1, s2;
  union_signed_w u1 ,v1;
  int i;
  int len = 4;
  s1.x = (v4f32){(0x01), (__builtin_nan("")), (0x01), (__builtin_nan("")),};
  s2.x = (v4f32){(0x01), (0x01), (__builtin_nan("")), (__builtin_nan("")),};

  u1.x = __builtin_mxu2_fcor_w(s1.x,s2.x);
  v1.x = (v4i32){(-1),(0),(0),(0),};

  if(check_w (&u1, &v1, len))
    abort ();

  return 0;
}
