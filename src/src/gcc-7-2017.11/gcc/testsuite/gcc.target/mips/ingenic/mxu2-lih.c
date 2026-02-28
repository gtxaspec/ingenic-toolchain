/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h u1, u2;
  union_signed_h v1, v2;
  int i;
  int len = 8;
  short value1 = -1;
  short value2 = 1;
  u1.x = __builtin_mxu2_li_h(value1);
  u2.x = __builtin_mxu2_li_h(value2);
  v1.x = (v8i16){(-1), (-1), (-1), (-1), (-1), (-1), (-1), (-1),};
  v2.x = (v8i16){(1), (1), (1), (1), (1), (1), (1), (1),};

  if(check_h (&u1, &v1, len))
    abort ();
  if(check_h (&u2, &v2, len))
    abort ();
  return 0;
}
