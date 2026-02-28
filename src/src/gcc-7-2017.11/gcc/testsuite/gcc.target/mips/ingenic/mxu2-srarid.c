/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d u, v1, v2, s1;
  int i;
  int j, k;
  int len = 2;
  int bit = 2;
  s1.x = (v2i64){(0b00011111), (0b00011111),};
  u.x = __builtin_mxu2_srari_d(s1.x, bit);

  for(i = 0; i < len; i++)
  {
     if(bit != 0)
     {
        for(k = 0; k < bit; k++)
        {
           j = s1.a[i] % 2;
           v1.a[i] = s1.a[i] >> 1;
           v1.a[i] = v1.a[i] +j;
	   s1.a[i] = v1.a[i];
        }
     }
     else
     {
        v1.a[i] = s1.a[i];
     }
  }

  v2.x = (v2i64){(0x08), (0x08),};

  if(check_d(&u, &v1, len))
    abort();
  if(check_d(&u, &v2, len))
    abort();
 return 0;
}
