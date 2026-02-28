/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b u,v1,v2, s1, s2;
  int i;
  int j,k;
  int len = 16;
  s1.x = (v16i8){(64), (64), (64), (64), (0b00001111), (0b00001111), (0b00001111), (0b00001111), (0b00011111), (0b00011111), (0b00011111), (0b00011111), (1), (1), (1), (1),};
  s2.x = (v16i8){(0), (1), (2), (3), (0), (1), (2), (3), (0), (1), (2), (3), (0), (0), (0), (0),};
  u.x = __builtin_mxu2_srar_b(s1.x, s2.x);

  for(i = 0; i < len; i++)
  {
     if(s2.a[i] != 0)
     {
        for(k = 0; k < s2.a[i]; k++)
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

  v2.x = (v16i8){(64), (32), (16), (8), (0x0f), (0x08), (0x04), (0x02), (0x1f), (0x10), (0x08), (0x04), (1), (1), (1), (1),};

  if(check_b (&u, &v1, len))
    abort ();
  if(check_b (&u, &v2, len))
    abort ();
  return 0;
}
