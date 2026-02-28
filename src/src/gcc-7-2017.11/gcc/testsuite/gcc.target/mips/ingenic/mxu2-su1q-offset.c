/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-do compile } */
/* { dg-options " -mmxu2" } */
/* { dg-skip-if "" { *-*-*} { "-O0" "-O2" } { } } */

#include <mxu2.h>
extern void barrier(void);

int x = 0;
void test()
{
  int vec_sel[512] = {0x03020100,};
  v8u16 vector[512], R1, R2;

  asm("lu1q  %0, %1"
      :"=q"((vector[x]))
      :"m"((vec_sel[0])):"memory");
  barrier();
  
  asm("lu1q  %0, %1"
      :"=q"((R1))
      :"m"((vector[x])):"memory");
  barrier();
  
  asm("sa1q  %0, %1\n\t"
      ::"q"((R1)),"m"((vector[x])):"memory");
}

/* { dg-final { scan-assembler "addiu\t\\\$2,.*\tsu1q\t.*\\(\\\$2\\)" } } */
/* { dg-final { scan-assembler "\t(su1q|su1qx)\t.*\n\tjal\tbarrier" } } */
/* { dg-final { scan-assembler-not "jal\tbarrier\n\t(sulq|su1qx)\t" } } */

