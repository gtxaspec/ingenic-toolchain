/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_w u, v, s1;
  int i;
  int len = 4;
  s1.x = (v4i32){(0x40000000), (0x80000000), (0xc0000000), (0xe0000000),};
  u.x = __builtin_mxu2_loc_w(s1.x);

  v.x = (v4i32){(0), (1), (2), (3),};

  if(check_w (&u, &v, len))
    abort ();
  return 0;
}
