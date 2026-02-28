/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_d s1,s2;
  union_signed_d u, v1, v2;
  int i;
  int len = 2;
  unsigned char position = 1;
  s1.x = (v2i64){(1), (1),};
  s2.x = (v2i64){(0), (2),};
  u.x = __builtin_mxu2_insfmxu_d(s1.x, position, s2.x);

  v2.x = (v2i64){(1), (0),};
  for(i = 0; i < len; i++)
  {
     if(i != (int)position)
     {
        v1.a[i] = s1.a[i];
     }
     else
     {
        v1.a[i] = s2.a[0];
     }
  }

  if(check_d (&u, &v1, len))
    abort ();
  if(check_d (&u, &v2, len))
    abort();

  return 0;
}
