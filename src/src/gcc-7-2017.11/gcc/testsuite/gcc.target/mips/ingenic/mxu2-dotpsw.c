/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h  s1, s2;
  union_signed_w  u, v;
  int i;
  int len = 4;
  s1.x = (v8i16){(32767), (32767), (5), (7), (-1) ,(3), (-5), (7),};
  s2.x = (v8i16){(32767), (32767), (6), (8), (2), (4), (6), (8),};
  u.x = __builtin_mxu2_dotps_w(s1.x, s2.x);

  v.x = (v4i32){(2147352578),(86),(10),(26),};

  if(check_w (&u, &v, len))
    abort ();
  return 0;
}
