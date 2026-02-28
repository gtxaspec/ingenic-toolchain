/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_d s1, s2, s3;
  int i;
  int len = 2;
  int result1, result2, result3;
  s1.x = (v2u64){(1), (1),};
  s2.x = (v2u64){(0), (1),};
  s3.x = (v2u64){(0), (0),};
  result1 = __builtin_mxu2_bnez2d(s1.x);
  result2 = __builtin_mxu2_bnez2d(s2.x);
  result3 = __builtin_mxu2_bnez2d(s3.x);

  if(result1 != 1)
    abort ();
  if(result2 != 0)
    abort();
  if(result3 != 0)
    abort();
 return 0;
}
