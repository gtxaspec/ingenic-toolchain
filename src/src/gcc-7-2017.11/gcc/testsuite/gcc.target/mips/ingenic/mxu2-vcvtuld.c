/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{

  union_unsigned_d u1, u2, u3, u4, u5, u6, u7, u8;
  union_unsigned_d v1, v2, v3, v4, v5, v6, v7, v8;
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

  u1.x = __builtin_mxu2_vcvtuld(s1.x);
  v1.x = (v2u64){(2), (2),};
  if(check_ud (&u1, &v1, len))
    abort ();

  u2.x = __builtin_mxu2_vcvtuld(s2.x);
  v2.x = (v2u64){(4), (4),};
  if(check_ud (&u2, &v2, len))
    abort ();

  u3.x = __builtin_mxu2_vcvtuld(s3.x);
  v3.x = (v2u64){(6), (6),};
  if(check_ud (&u3, &v3, len))
    abort ();

  u4.x = __builtin_mxu2_vcvtuld(s4.x);
  v4.x = (v2u64){(8), (8),};
  if(check_ud (&u4, &v4, len))
    abort ();

  u5.x = __builtin_mxu2_vcvtuld(s5.x);
  v5.x = (v2u64){(0), (0),};
  if(check_ud (&u5, &v5, len))
    abort ();

  u6.x = __builtin_mxu2_vcvtuld(s6.x);
  v6.x = (v2u64){(0), (0),};
  if(check_ud (&u6, &v6, len))
    abort ();

  u7.x = __builtin_mxu2_vcvtuld(s7.x);
  v7.x = (v2u64){(0), (0),};
  if(check_ud (&u7, &v7, len))
    abort ();

  u8.x = __builtin_mxu2_vcvtuld(s8.x);
  v8.x = (v2u64){(0), (0),};
  if(check_ud (&u8, &v8, len))
    abort ();

  return 0;
}
