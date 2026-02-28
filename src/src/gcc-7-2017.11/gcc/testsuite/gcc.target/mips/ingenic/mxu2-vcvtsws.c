/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{

  union_signed_w u1, u2, u3, u4;
  union_signed_w v1, v2, v3, v4;
  union_float_w s1, s2, s3, s4;
  int i;
  int len = 4;
  s1.x = (v4f32){(1.0), (2.1), (3.2), (4.3),};
  s2.x = (v4f32){(5.4), (6.5), (7.6), (8.7),};

  s3.x = (v4f32){(-1.0), (-2.1), (-3.2), (-4.3),};
  s4.x = (v4f32){(-5.4), (-6.5), (-7.6), (-8.7),};

  u1.x = __builtin_mxu2_vcvtsws(s1.x);
  v1.x = (v4i32){(1), (2), (3), (4),};
  for(i = 0; i < 4; i++)
  {
    if(u1.a[i] != v1.a[i])
      abort ();
  }

  u2.x = __builtin_mxu2_vcvtsws(s2.x);
  v2.x = (v4i32){(5), (6), (8), (9),};
  for(i = 0; i < 4; i++)
  {
    if(u2.a[i] != v2.a[i])
      abort ();
  }

  u3.x = __builtin_mxu2_vcvtsws(s3.x);
  v3.x = (v4i32){(-1), (-2), (-3), (-4),};
  for(i = 0; i < 4; i++)
  {
    if(u3.a[i] != v3.a[i])
      abort ();
  }

  u4.x = __builtin_mxu2_vcvtsws(s4.x);
  v4.x = (v4i32){(-5), (-6), (-8), (-9),};
  for(i = 0; i < 4; i++)
  {
    if(u4.a[i] != v4.a[i])
      abort ();
  }

  return 0;
}
