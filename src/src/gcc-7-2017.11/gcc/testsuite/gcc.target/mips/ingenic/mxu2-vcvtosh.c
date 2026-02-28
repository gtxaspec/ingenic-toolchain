/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{

  union_float_w u1, u2, v1, v2;
  union_signed_h s1, s2;
  int i;
  int len = 4;
  s1.x = (v8i16){(0x3c00), (0x4000), (0x4200), (0x4400), (0x4500), (0x4600), (0x4700), (0x4800),};
  s2.x = (v8i16){(0x4880), (0x4900), (0x4980), (0x4a00), (0x4a80), (0x4b00), (0x4b80), (0x4c00),};

  u1.x = __builtin_mxu2_vcvtosh(s1.x);
  v1.x = (v4f32){(2.000000), (4.000000), (6.000000), (8.000000),};

  u2.x = __builtin_mxu2_vcvtosh(s2.x);
  v2.x = (v4f32){(10.0), (12.0), (14.0), (16.0),};

  if(check_fw(&u1, &v1, len))
   abort();
  if(check_fw(&u2, &v2, len))
   abort();

  return 0;
}
