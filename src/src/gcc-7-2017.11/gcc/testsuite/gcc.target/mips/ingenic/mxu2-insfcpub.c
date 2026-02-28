/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_signed_b s1;
  union_signed_b u, v1, v2;
  int i;
  int len = 16;
  unsigned char position = 2;
  int value = 3;
  s1.x = (v16i8){(1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  u.x = __builtin_mxu2_insfcpu_b(s1.x, position, value);

  v2.x = (v16i8){(1), (1), (3), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1), (1),};
  for(i = 0; i < len; i++)
  {
     if(i != (int)position)
     {
        v1.a[i] = s1.a[i];
     }
     else
     {
        v1.a[i] = (char)value;
     }
  }

  if(check_b (&u, &v1, len))
    abort ();
  if(check_b (&u, &v2, len))
    abort ();
  return 0;
}
