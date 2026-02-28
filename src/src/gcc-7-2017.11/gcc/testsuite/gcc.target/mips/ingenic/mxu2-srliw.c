/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_w u, v1, v2, s1;
  int i;
  int len = 4;
  int bit = 2;
  s1.x = (v4i32){(65), (65), (65), (65),};
  u.x = __builtin_mxu2_srli_w(s1.x, bit);


  for(i = 0; i < len; i++)
  {
     v1.a[i] = s1.a[i] >> bit;
  }

  v2.x = (v4i32){(16), (16), (16), (16),};

  if(check_w (&u, &v1, len))
    abort ();
  if(check_w (&u, &v2, len))
    abort ();
  return 0;
}
