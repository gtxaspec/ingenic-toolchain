/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_signed_h s1;
  union_signed_h u, v1, v2;
  int i;
  int len = 8;
  unsigned char position = 2;
  int value = 3;
  s1.x = (v8i16){(1), (1), (1), (1), (1), (1), (1), (1),};
  u.x = __builtin_mxu2_insfcpu_h(s1.x, position, value);

  v2.x = (v8i16){(1), (1), (3), (1), (1), (1), (1), (1),};
  for(i = 0; i < len; i++)
  {
     if(i != (int)position)
     {
        v1.a[i] = s1.a[i];
     }
     else
     {
        v1.a[i] = (short)value;
     }
  }

  if(check_h (&u, &v1, len))
    abort ();
  if(check_h (&u, &v2, len))
    abort ();

  return 0;
}
