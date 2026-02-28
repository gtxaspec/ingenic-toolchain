/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_signed_h u1, v1, u2, v2;
  union_signed_h s;
  int i;
  int len = 8;
  s.x = (v8i16){(127), (-127), (255), (-255), (10), (-10), (1), (1),};
  u1.x = __builtin_mxu2_sats_h(s.x, 7);
  u2.x = __builtin_mxu2_sats_h(s.x, 6);

  v1.x = (v8i16){(127), (-127), (127), (-128), (10), (-10), (1), (1),};
  v2.x = (v8i16){(63), (-64), (63), (-64), (10), (-10), (1), (1),};

  if(check_h (&u1, &v1, len))
    abort ();
  if(check_h (&u2, &v2, len))
    abort ();
  return 0;
}
