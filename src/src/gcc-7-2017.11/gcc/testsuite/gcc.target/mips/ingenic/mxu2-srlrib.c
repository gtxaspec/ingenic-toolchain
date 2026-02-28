/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b u, v1, v2, s1;
  int i;
  int j,k;
  int len = 16;
  int bit = 2;
  s1.x = (v16i8){(64), (64), (64), (64), (0b00001111), (0b00001111), (0b00001111), (0b00001111), (0b00011111), (0b00011111), (0b00011111), (0b00011111), (64), (64), (64), (64),};
  u.x = __builtin_mxu2_srlri_b(s1.x, bit);

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

  v2.x = (v16i8){(16), (16), (16), (16), (0x04), (0x04), (0x04), (0x04), (0x08), (0x08), (0x08), (0x08), (16), (16), (16), (16),};

  if(check_b (&u, &v1, len))
    abort ();
  if(check_b (&u, &v2, len))
    abort ();
  return 0;
}
