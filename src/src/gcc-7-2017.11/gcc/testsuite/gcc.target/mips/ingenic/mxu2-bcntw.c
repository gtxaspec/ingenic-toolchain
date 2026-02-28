/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_w u, v, s;
  int i;
  int len = 4;
  s.x = (v4i32){(0b10), (0b11), (0b111), (0b110),};
  u.x = __builtin_mxu2_bcnt_w(s.x);

  v.x = (v4i32){(1), (2), (3), (2),};

  if(check_w (&u, &v, len))
   abort ();
 return 0;
}
