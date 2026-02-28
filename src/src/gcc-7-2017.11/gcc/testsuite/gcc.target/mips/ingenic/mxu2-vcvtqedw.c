/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_float_d u1, v1;
  union_signed_w s1;
  int i;
  int len = 2;
  s1.x = (v4i32){(0x40000000), (0x20000000), (0x10000000), (0x08000000),};

  u1.x = __builtin_mxu2_vcvtqedw(s1.x);
  v1.x = (v2f64){(0.5), (0.125),};

  if(check_fd(&u1, &v1, len))
   abort();

  return 0;
}
