/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"

int main (void)
{
  union_signed_b u1, u2;
  union_signed_b v1, v2;
  int i;
  int len = 16;
  int offset1 = 0;
  int offset2 = 2;

  char value1[20] ;
  char value2[20] ;
  u1.x = (v16i8){(0xA), (0x44), (0x9), (0x33), (0x8), (0x22), (0x7), (0x11), (0x6), (0x10), (0xA), (0x55), (0xA), (0x55), (0xA), (0x55),};
  __builtin_mxu2_su1qx(u1.x, &value1[0], 0);
  __builtin_mxu2_su1qx(u1.x, &value2[0], 2);

  for(i = 0; i < len; i++)
  {
    if(value1[i] != u1.a[i])
      abort ();
  }

  for(i = 0; i < len; i++)
  {
    if(value2[i+2] != u1.a[i])
      abort ();
  }
  return 0;
}
