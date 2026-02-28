/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_float_w s1;
  union_float_w u, v1, v2;
  int i;
  int len = 4;
  unsigned char position = 2;
  float value = 3.0;
  s1.x = (v4f32){(1.0), (1.0), (1.0), (1.0),};
  u.x = __builtin_mxu2_insffpu_w(s1.x, position, value);

  v2.x = (v4f32){(1.0), (1.0), (3.0), (1.0),};
  for(i = 0; i < len; i++)
  {
     if(i != (int)position)
     {
        v1.a[i] = s1.a[i];
     }
     else
     {
        v1.a[i] = value;
     }
  }

  if(check_fw (&u, &v1, len))
    abort ();
  if(check_fw (&u, &v2, len))
    abort ();

  return 0;
}
