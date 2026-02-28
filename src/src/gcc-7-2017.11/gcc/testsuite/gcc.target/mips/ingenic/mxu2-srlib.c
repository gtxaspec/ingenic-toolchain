/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b u,v1,v2, s1;
  int i;
  int len = 16;
  int bit = 2;
  s1.x = (v16i8){(65), (65), (65), (65), (6), (6), (6), (6), (6), (6), (6), (6), (6), (6), (6), (6),};
  u.x = __builtin_mxu2_srli_b(s1.x, bit);


  for(i = 0; i < len; i++)
  {
     v1.a[i] = s1.a[i] >> bit;
  }

  v2.x = (v16i8){(16), (16), (16), (16), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};

  if(check_b (&u, &v1, len))
    abort ();
  if(check_b (&u, &v2, len))
    abort ();
  return 0;
}
