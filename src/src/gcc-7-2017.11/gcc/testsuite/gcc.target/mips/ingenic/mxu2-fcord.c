/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"
int main (void)
{
  union_float_d  s1, s2;
  union_signed_d u1 ,v1;
  int i;
  int len = 2;
  s1.x = (v2f64){(0x01), (__builtin_nan("")), };
  s2.x = (v2f64){(0x01), (0x01),};

  u1.x = __builtin_mxu2_fcor_d(s1.x,s2.x);
  v1.x = (v2i64){(-1),(0),};

  if(check_d (&u1, &v1, len))
    abort ();

  return 0;
}
