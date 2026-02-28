/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_unsigned_w s1, s2, s3;
  int i;
  int len = 4;
  int result1, result2, result3;
  s1.x = (v4u32){(1), (1), (1), (1),};
  s2.x = (v4u32){(0), (0), (1), (1),};
  s3.x = (v4u32){(0), (0), (0), (0),};
  result1 = __builtin_mxu2_bnez4w(s1.x);
  result2 = __builtin_mxu2_bnez4w(s2.x);
  result3 = __builtin_mxu2_bnez4w(s3.x);

  if(result1 != 1)
    abort ();
  if(result2 != 0)
    abort ();
  if(result3 != 0)
    abort();
 return 0;
}
