/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"
#include <stdlib.h>

int main()
{
  union_signed_w u, v1, v2, s1, s2;
  int i;
  int len = 4;
  s1.x = (v4i32){(0x01), (0x01), (0x01), (0x01),};
  s2.x = (v4i32){(0), (1), (2), (3),};
  u.x = __builtin_mxu2_sll_w(s1.x, s2.x);

  for(i = 0; i < len; i++)
  {
     v1.a[i] = s1.a[i] << s2.a[i];
  }

  v2.x = (v4i32){(0x01), (0x02), (0x04), (0x08),};

  if(check_w (&u, &v1, len))
    abort ();
  if(check_w (&u, &v2, len))
    abort ();
  return 0;
}
