/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_w u, v, s1, s2;
  int i;
  int len = 4;
  s1.x = (v4u32){(127), (255), (32767), (65534),};
  s2.x = (v4u32){(127), (255), (32767), (100),};
  u.x = __builtin_mxu2_adduu_w(s1.x, s2.x);

  v.x = (v4u32){(254), (510), (65534), (65634),};

  if(check_uw (&u, &v, len))
   abort ();
 return 0;
}
