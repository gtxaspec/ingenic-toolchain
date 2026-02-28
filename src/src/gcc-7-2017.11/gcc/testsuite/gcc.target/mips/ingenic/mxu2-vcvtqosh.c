/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_float_w u1, v1;
  union_signed_h s1;
  int i;
  int len = 4;
  s1.x = (v8i16){(0x4000), (0x2000), (0x1000), (0x0800), (0x0400), (0x0200), (0x0100), (0x0080),};

  u1.x = __builtin_mxu2_vcvtqosh(s1.x);
  v1.x = (v4f32){(0.25), (0.0625), (0.015625), (0.00390625),};

  if(check_fw(&u1, &v1, len))
   abort();

  return 0;
}
