/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d u, v, s ;
  int i;
  int len = 2;
  s.x = (v2i64){(0b10), (0b11),};
  u.x = __builtin_mxu2_bcnt_d(s.x);

  v.x = (v2i64){(1), (2),};

  if(check_d (&u, &v, len))
   abort ();
 return 0;
}
