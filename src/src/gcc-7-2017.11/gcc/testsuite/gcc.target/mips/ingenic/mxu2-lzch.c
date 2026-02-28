/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_signed_h u, v, s1;
  int i;
  int len = 8;
  s1.x = (v8i16){(0x8000), (0x4000), (0x2000), (0x1000), (0x0800), (0x0400), (0x0200), (0x0100),};
  u.x = __builtin_mxu2_lzc_h(s1.x);

  v.x = (v8i16){(0), (1), (2), (3), (4), (5), (6), (7),};

  if(check_h (&u, &v, len))
    abort ();
  return 0;
}
