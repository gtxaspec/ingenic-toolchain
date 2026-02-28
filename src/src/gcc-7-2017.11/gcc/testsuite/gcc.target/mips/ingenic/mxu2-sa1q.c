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
  char value1[32];
  char *v;
  v = malloc(sizeof(char) * 80);
  v = (char *)((unsigned int)v + 0x10);
  v = (char *)((unsigned int)v & (~(0xF)));

  u1.x = (v16i8){(0xA), (0x44), (0x9), (0x33), (0x8), (0x22), (0x7), (0x11), (0x6), (0x10), (0xA), (0x55), (0xA), (0x55), (0xA), (0x55),};
  __builtin_mxu2_sa1q(u1.x ,v , 0);

  for(i = 0; i < len; i++)
  {
     if(*(v + i) != u1.a[i])
	abort ();
  }
  return 0;
}
