/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h u, v;
  int i;
  int len = 8;
  int value = 9;
  u.x = __builtin_mxu2_mfcpu_h(value);

  v.x = (v8i16){(9), (9), (9), (9), (9), (9), (9), (9),};

  if(check_h (&u, &v, len))
    abort();

  return 0;
}
