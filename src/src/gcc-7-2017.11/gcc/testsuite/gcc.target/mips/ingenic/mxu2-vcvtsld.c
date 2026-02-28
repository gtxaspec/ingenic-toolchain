/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d u1, u2, u3, u4, u5, u6, u7, u8;
  union_signed_d v1, v2, v3, v4, v5, v6, v7, v8;
  union_float_d s1, s2, s3, s4, s5, s6, s7, s8;
  int i;
  int len = 2;
  s1.x = (v2f64){(1.5), (2.5),};
  s2.x = (v2f64){(3.5), (4.5),};
  s3.x = (v2f64){(5.5), (6.5),};
  s4.x = (v2f64){(7.5), (8.5),};

  s5.x = (v2f64){(-1.5), (-2.5),};
  s6.x = (v2f64){(-3.5), (-4.5),};
  s7.x = (v2f64){(-5.5), (-6.5),};
  s8.x = (v2f64){(-7.5), (-8.5),};

  u1.x = __builtin_mxu2_vcvtsld(s1.x);
  v1.x = (v2i64){(2), (2),};
  for(i = 0; i < 2; i++)
  {
    if(u1.a[i] != v1.a[i])
      abort ();
  }

  u2.x = __builtin_mxu2_vcvtsld(s2.x);
  v2.x = (v2i64){(4), (4),};
  for(i = 0; i < 2; i++)
  {
    if(u2.a[i] != v2.a[i])
      abort ();
  }

  u3.x = __builtin_mxu2_vcvtsld(s3.x);
  v3.x = (v2i64){(6), (6),};
  for(i = 0; i < 2; i++)
  {
    if(u3.a[i] != v3.a[i])
      abort ();
  }

  u4.x = __builtin_mxu2_vcvtsld(s4.x);
  v4.x = (v2i64){(8), (8),};
  for(i = 0; i < 2; i++)
  {
    if(u4.a[i] != v4.a[i])
      abort ();
  }

  u5.x = __builtin_mxu2_vcvtsld(s5.x);
  v5.x = (v2i64){(-2), (-2),};
  for(i = 0; i < 2; i++)
  {
    if(u5.a[i] != v5.a[i])
      abort ();
  }

  u6.x = __builtin_mxu2_vcvtsld(s6.x);
  v6.x = (v2i64){(-4), (-4),};
  for(i = 0; i < 2; i++)
  {
    if(u6.a[i] != v6.a[i])
      abort ();
  }

  u7.x = __builtin_mxu2_vcvtsld(s7.x);
  v7.x = (v2i64){(-6), (-6),};
  for(i = 0; i < 2; i++)
  {
    if(u7.a[i] != v7.a[i])
      abort ();
  }

  u8.x = __builtin_mxu2_vcvtsld(s8.x);
  v8.x = (v2i64){(-8), (-8),};
  for(i = 0; i < 2; i++)
  {
    if(u8.a[i] != v8.a[i])
      abort ();
  }

  return 0;
}
