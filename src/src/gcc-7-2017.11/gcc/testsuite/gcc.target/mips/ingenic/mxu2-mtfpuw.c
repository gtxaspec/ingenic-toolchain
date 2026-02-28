/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_float_w s1;
  int i;
  int len = 4;
  unsigned char position1 = 1, position2 = 2, position3 =3;
  float result1, result2, result3;
  s1.x = (v4f32){(11.0), (-12.0), (13.0), (14.0),};
  result1 = __builtin_mxu2_mtfpu_w(s1.x, position1);
  result2 = __builtin_mxu2_mtfpu_w(s1.x, position2);
  result3 = __builtin_mxu2_mtfpu_w(s1.x, position3);


  if(result1 != -12.0)
    abort ();
  if(result2 != 13.0)
    abort ();
  if(result3 != 14.0)
    abort ();

  return 0;
}
