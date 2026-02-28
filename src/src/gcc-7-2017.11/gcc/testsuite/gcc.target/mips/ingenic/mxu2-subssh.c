/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h u, v, s1, s2;
  int i;
  int len = 8;
  s1.x = (v8i16){(127), (-127), (32767), (-32767), (1), (1), (1), (1),};
  s2.x = (v8i16){(-127), (127), (-32767), (32767), (-1), (-1), (-1), (-1),};
  u.x = __builtin_mxu2_subss_h(s1.x, s2.x);

  v.x = (v8i16){(254), (-254), (32767), (-32768), (2), (2), (2), (2),};

  if(check_h (&u, &v, len))
    abort ();
  return 0;
}
