/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_h u, v1, v2, s1;
  int i;
  int len = 8;
  s1.x = (v8i16){(0), (0), (10), (10), (10), (10), (10), (10),};
  u.x = __builtin_mxu2_cnez_h(s1.x);

  for(i = 0; i < len; i++)
  {
    if (s1.a[i] != 0)
    {
       v1.a[i] = 0xFFFF;
    }
    else
    {
       v1.a[i] = 0;
    }
  }

  v2.x = (v8i16){(0), (0), (0xFFFF), (0xFFFF), (0xFFFF), (0xFFFF), (0xFFFF), (0xFFFF),};

  if(check_h (&u, &v1, len))
    abort ();
  if(check_h (&u, &v2, len))
    abort ();
  return 0;
}
