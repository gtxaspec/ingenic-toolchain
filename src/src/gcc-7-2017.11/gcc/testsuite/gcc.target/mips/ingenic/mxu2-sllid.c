/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d u, v1, v2, s1;
  int i;
  int len = 2;
  int bit = 2;
  s1.x = (v2i64){(0x01), (0x08),};
  u.x = __builtin_mxu2_slli_d(s1.x, bit);

  for(i = 0; i < len; i++)
  {
     v1.a[i] = s1.a[i] << bit;
  }

  v2.x = (v2i64){(0x04), (0x20),};

  if(check_d (&u, &v1, len))
    abort();
  if(check_d (&u, &v2, len))
    abort();
 return 0;
}
