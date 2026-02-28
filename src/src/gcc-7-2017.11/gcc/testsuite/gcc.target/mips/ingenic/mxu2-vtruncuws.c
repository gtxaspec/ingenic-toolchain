/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{

  union_unsigned_w u1, u2, u3, u4;
  union_unsigned_w v1, v2, v3, v4;
  union_float_w s1, s2, s3, s4;
  int i;
  int len = 4;
  s1.x = (v4f32){(1.0), (2.1), (3.2), (4.3),};
  s2.x = (v4f32){(5.4), (6.5), (7.6), (8.7),};

  s3.x = (v4f32){(-1.0), (-2.1), (-3.2), (-4.3),};
  s4.x = (v4f32){(-5.4), (-6.5), (-7.6), (-8.7),};

  u1.x = __builtin_mxu2_vtruncuws(s1.x);
  v1.x = (v4u32){(1), (2), (3), (4),};
  if(check_uw (&u1, &v1, len))
    abort ();

  u2.x = __builtin_mxu2_vtruncuws(s2.x);
  v2.x = (v4u32){(5), (6), (7), (8),};
  if(check_uw (&u2, &v2, len))
    abort ();

  u3.x = __builtin_mxu2_vtruncuws(s3.x);
  v3.x = (v4u32){(0), (0), (0), (0),};
  if(check_uw (&u3, &v3, len))
    abort ();

  u4.x = __builtin_mxu2_vtruncuws(s4.x);
  v4.x = (v4u32){(0), (0), (0), (0),};
  if(check_uw (&u4, &v4, len))
    abort ();

  return 0;
}
