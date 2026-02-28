/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_h  s1, s2;
  union_unsigned_w  u, v;
  int i;
  int len = 4;
  s1.x = (v8u16){(1), (3), (5), (7), (1), (3), (5), (7),};
  s2.x = (v8u16){(2), (4), (6), (8), (2), (4), (6), (8),};
  u.x = __builtin_mxu2_dotpu_w(s1.x, s2.x);

  v.x = (v4u32){(14),(86),(14),(86),};

  if(check_uw (&u, &v, len))
    abort ();
  return 0;
}
