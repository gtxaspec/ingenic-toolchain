/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h u, v1, v2, s1;
  int i;
  int len = 8;
  int bit = 2;
  s1.x = (v8i16){(0x01), (0x01), (0x02), (0x02), (0x04), (0x04), (0x08), (0x08),};
  u.x = __builtin_mxu2_slli_h(s1.x, bit);


  for(i = 0; i < len; i++)
  {
     v1.a[i] = s1.a[i] << bit;
  }

  v2.x = (v8i16){(0x04), (0x04), (0x08), (0x08), (0x10), (0x10), (0x20), (0x20),};

  if(check_h (&u, &v1, len))
    abort();
  if(check_h (&u, &v2, len))
    abort();
  return 0;
}
