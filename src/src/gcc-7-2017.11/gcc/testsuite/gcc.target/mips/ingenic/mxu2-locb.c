/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b u, v, s1;
  int i;
  int len = 16;
  s1.x = (v16i8){(0x40), (0x80), (0xc0), (0xe0), (0xf0), (0xf8), (0xfc), (0xfe), (0xf0), (0xf0), (0xf0), (0xf0), (0xf0), (0xf0), (0xf0), (0xf0),};
  u.x = __builtin_mxu2_loc_b(s1.x);

  v.x = (v16i8){(0), (1), (2), (3), (4), (5), (6), (7), (4), (4), (4), (4), (4), (4), (4), (4),};

  if(check_b (&u, &v, len))
    abort ();
  return 0;
}
