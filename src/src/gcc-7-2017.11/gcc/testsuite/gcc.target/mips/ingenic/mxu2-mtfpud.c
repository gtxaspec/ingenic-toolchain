/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_float_d s1;
  int i;
  int len = 2;
  unsigned char position1 = 0, position2 = 1;
  double  result1, result2;
  s1.x = (v2f64){(-11.0), (12.0),};
  result1 = __builtin_mxu2_mtfpu_d(s1.x, position1);
  result2 = __builtin_mxu2_mtfpu_d(s1.x, position2);

  if(result1 != -11.0)
    abort ();
  if(result2 != 12.0)
    abort ();

  return 0;
}
