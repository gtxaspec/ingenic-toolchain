/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d u, v1, v2, s1, s2;
  int i;
  int j, k;
  int len = 2;
  s1.x = (v2i64){(0b00001111), (0b00001111),};
  s2.x = (v2i64){(0), (1),};
  u.x = __builtin_mxu2_srlr_d(s1.x, s2.x);

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

  v2.x = (v2i64){(0x0f), (0x08),};

  if(check_d (&u, &v1, len))
    abort ();
  if(check_d (&u, &v2, len))
    abort ();
  return 0;
}
