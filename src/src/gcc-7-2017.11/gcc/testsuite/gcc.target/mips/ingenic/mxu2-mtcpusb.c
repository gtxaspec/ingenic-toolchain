/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b s1;
  int i;
  int len = 16;
  unsigned char position1 = 1, position2 = 2, position3 =3;
  int result1, result2, result3;
  s1.x = (v16i8){(11), (-12), (13), (14), (15), (16), (17), (18), (19), (20), (21), (22), (23), (24), (25), (26),};
  result1 = __builtin_mxu2_mtcpus_b(s1.x, position1);
  result2 = __builtin_mxu2_mtcpus_b(s1.x, position2);
  result3 = __builtin_mxu2_mtcpus_b(s1.x, position3);

  if(result1 != -12)
    abort ();
  if(result2 != 13)
    abort ();
  if(result3 != 14)
    abort ();

  return 0;
}
