/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{

  union_signed_h u1, u2;
  union_signed_h v1, v2;
  union_float_w s0, s1, s2, s3, s4;
  int i;
  int len = 8;
  s1.x = (v4f32){(1.0), (2.0), (3.0), (4.0),};
  s2.x = (v4f32){(5.0), (6.0), (7.0), (8.0),};
  s3.x = (v4f32){(9.0), (10.0), (11.0), (12.0),};
  s4.x = (v4f32){(13.0), (14.0), (15.0), (16.0),};

  u1.x = __builtin_mxu2_vcvths(s2.x, s1.x);
  v1.x = (v8i16){(0x3c00), (0x4500), (0x4000), (0x4600), (0x4200), (0x4700), (0x4400), (0x4800),};
  if(check_h (&u1, &v1, len))
     abort ();

  u2.x = __builtin_mxu2_vcvths(s4.x, s3.x);
  v2.x = (v8i16){(0x4880), (0x4a80), (0x4900), (0x4b00), (0x4980), (0x4b80), (0x4a00), (0x4c00),};
  if(check_h (&u2, &v2, len))
     abort ();


  return 0;
}
