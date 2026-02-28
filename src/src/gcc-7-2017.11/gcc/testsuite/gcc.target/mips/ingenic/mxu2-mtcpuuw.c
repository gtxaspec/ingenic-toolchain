/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_w s1;
  int i;
  int len = 4;
  unsigned char position1 = 1, position2 = 2, position3 =3;
  unsigned int result1, result2, result3;
  s1.x = (v4i32){(11), (-12), (13), (14),};
  result1 = __builtin_mxu2_mtcpuu_w(s1.x, position1);
  result2 = __builtin_mxu2_mtcpuu_w(s1.x, position2);
  result3 = __builtin_mxu2_mtcpuu_w(s1.x, position3);

  if(result1 != (unsigned int)(-12))
    abort ();
  if(result2 != 13)
    abort ();
  if(result3 != 14)
    abort ();

  return 0;
}
