/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h u, v, s ;
  int i;
  int len = 8;
  s.x = (v8i16){(0b10), (0b11), (0b111), (0b110), (0b1000), (0b10), (0b10), (0b10),};
  u.x = __builtin_mxu2_bcnt_h(s.x);

  v.x = (v8i16){(1), (2), (3), (2), (1), (1), (1), (1),};

  if(check_h (&u, &v, len))
   abort ();
 return 0;
}
