/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_signed_w s1,s2;
  union_signed_w u, v1, v2;
  int i;
  int len = 4;
  unsigned char position = 2;
  s1.x = (v4i32){(1), (1), (1), (1),};
  s2.x = (v4i32){(0), (2), (3), (4),};
  u.x = __builtin_mxu2_insfmxu_w(s1.x, position, s2.x);

  v2.x = (v4i32){(1), (1), (0), (1),};
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

  if(check_w (&u, &v1, len))
    abort ();
  if(check_w (&u, &v2, len))
    abort ();

  return 0;
}
