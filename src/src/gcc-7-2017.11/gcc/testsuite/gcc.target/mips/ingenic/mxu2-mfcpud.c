/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d u, v;
  int i;
  int len = 2;
  int value = 9;
  u.x = __builtin_mxu2_mfcpu_d(value);

  v.x = (v2i64){(9), (9),};

  if(check_d (&u, &v, len))
    abort ();

  return 0;
}
