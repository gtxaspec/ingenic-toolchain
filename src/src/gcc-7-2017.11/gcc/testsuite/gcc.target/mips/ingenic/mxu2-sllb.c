/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b u, v1, v2, s1, s2;
  int i;
  int len = 16;
  s1.x = (v16i8){(0x01), (0x01), (0x01), (0x01), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  s2.x = (v16i8){(0), (1), (2), (3), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0), (0),};
  u.x = __builtin_mxu2_sll_b(s1.x, s2.x);


  for(i = 0; i < len; i++)
  {
     v1.a[i] = s1.a[i] << s2.a[i];
  }

  v2.x = (v16i8){(0x01), (0x02), (0x04), (0x08), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};

  if(check_b (&u, &v1, len))
    abort ();
  if(check_b (&u, &v2, len))
    abort ();
  return 0;
}
