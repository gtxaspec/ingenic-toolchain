/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_b  s1, s2;
  union_unsigned_h  s3;
  union_unsigned_h  u, v;
  int i;
  int len = 8;
  s1.x = (v16u8){(1), (3), (5), (7), (1), (3), (5), (7), (1), (1), (1), (1), (1), (1), (1), (1),};
  s2.x = (v16u8){(2), (4), (6), (8), (2), (4), (6), (8), (1), (1), (1), (1), (1), (1), (1), (1),};
  s3.x = (v8u16){(1), (1), (1), (1), (1), (1), (1), (1),};
  u.x = __builtin_mxu2_daddu_h(s3.x, s1.x, s2.x);

  v.x = (v8u16){(15),(87),(15),(87),(3),(3),(3),(3),};

  if(check_uh (&u, &v, len))
    abort ();
  return 0;
}
