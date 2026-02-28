/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b u, v;
  int i;
  int len = 16;
  int value = 9;
  u.x = __builtin_mxu2_mfcpu_b(value);

  v.x = (v16i8){(9), (9), (9), (9), (9), (9), (9), (9), (9), (9), (9), (9), (9), (9), (9), (9),};

  if(check_b (&u, &v, len))
    abort ();

  return 0;
}
