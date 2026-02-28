/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_float_d  s1, s2, s3, s4, s5, s6, s7, s8, s9, s10;
  union_signed_d u1 ,u2, u3, u4, u5, u6, u7, u8, u9, u10;
  union_signed_d v1, v2, v3, v4, v5, v6, v7, v8, v9, v10;
  int i;
  int len = 2;
  s1.x = (v2f64){(1/0.0), (32.0),};
  s2.x = (v2f64){(1e-310), (0.0),};
  s3.x = (v2f64){(-1/0.0), (-32.0),};
  s4.x = (v2f64){(-(1e-310)), (-0.0),};
  s5.x = (v2f64){(__builtin_nan("")), (8.0),};

  u1.x = __builtin_mxu2_fclass_d(s1.x);
  u2.x = __builtin_mxu2_fclass_d(s2.x);
  u3.x = __builtin_mxu2_fclass_d(s3.x);
  u4.x = __builtin_mxu2_fclass_d(s4.x);
  u5.x = __builtin_mxu2_fclass_d(s5.x);

  v1.x = (v2i64){(0x40), (0x80),};
  v2.x = (v2i64){(0x100), (0x200),};
  v3.x = (v2i64){(0x04), (0x08),};
  v4.x = (v2i64){(0x10), (0x20),};
  v5.x = (v2i64){(0x01), (0x80),};

  if(check_d (&u1, &v1, len))
    abort ();
  if(check_d (&u2, &v2, len))
    abort ();
  if(check_d (&u3, &v3, len))
    abort ();
  return 0;
}
