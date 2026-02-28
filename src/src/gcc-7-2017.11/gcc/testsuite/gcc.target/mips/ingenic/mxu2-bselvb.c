/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b u,v, s1, s2,s3;
  int i;
  int len = 16;
  s1.x = (v16i8){(0b1001), (0b1111), (0b1111), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  s2.x = (v16i8){(0b0111), (0), (0), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  s3.x = (v16i8){(0b1111), (0), (0b100), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  u.x = __builtin_mxu2_bselv(s1.x, s2.x, s3.x);

  v.x = (v16i8){(0b0111), (0b1111), (0b1011), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};

  if(check_b (&u, &v, len))
    abort ();
  return 0;
}
