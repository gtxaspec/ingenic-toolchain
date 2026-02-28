/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_unsigned_h  s1, s2;
  union_signed_h  u, v1, v2;
  int i;
  int len = 8;
  s1.x = (v8u16){(20), (10), (10), (10), (10), (10), (10), (10),};
  s2.x = (v8u16){(10), (0), (10), (40), (14), (51), (61), (17),};
  u.x = __builtin_mxu2_cltu_h(s1.x, s2.x);


  for(i = 0; i < len; i++)
  {
    if (s1.a[i] < s2.a[i])
    {
       v1.a[i] = 0xFFFF;
    }
    else
    {
       v1.a[i] = 0;
    }
  }

  v2.x = (v8i16){(0), (0), (0), (0xFFFF), (0xFFFF), (0xFFFF), (0xFFFF), (0xFFFF),};

  if(check_h (&u, &v1, len))
    abort ();
  if(check_h (&u, &v2, len))
    abort ();
  return 0;
}
