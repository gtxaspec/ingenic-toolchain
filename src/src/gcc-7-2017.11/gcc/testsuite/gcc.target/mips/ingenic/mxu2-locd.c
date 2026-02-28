/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d u, v, s1;
  int i;
  int len = 2;
  s1.x = (v2i64){(0x4000000000000000), (0x8000000000000000),};
  u.x = __builtin_mxu2_loc_d(s1.x);

  v.x = (v2i64){(0), (1),};

  if(check_d (&u, &v, len))
    abort();
  return 0;
}
