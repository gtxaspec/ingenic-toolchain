/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h u, v, s1, s2;
  int i;
  int len = 8;
  s1.x = (v8i16){(0x4000), (0x4000), (0x2000), (0x2000), (0x1000), (0x1000), (0x800), (0x800),};
  s2.x = (v8i16){(0x4000), (0x2000), (0x2000), (0x1000), (0x1000), (0x800), (0x800), (0x400),};
  u.x = __builtin_mxu2_mulq_h(s1.x, s2.x);

  v.x = (v8i16){(0x2000), (0x1000), (0x800), (0x400), (0x200), (0x100), (0x80), (0x40),};
  if(check_h (&u, &v, len))
    abort ();
  return 0;
}
