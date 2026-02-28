/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_w u, v;
  int i;
  int len = 4;
  int value = 9;
  u.x = __builtin_mxu2_mfcpu_w(value);

  v.x = (v4i32){(9), (9), (9), (9),};

  if(check_w (&u, &v, len))
    abort ();

  return 0;
}
