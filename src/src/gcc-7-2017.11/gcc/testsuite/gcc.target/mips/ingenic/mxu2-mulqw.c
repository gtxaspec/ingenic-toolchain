/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"
#include <stdlib.h>
#include <stdio.h>

int main()
{
  union_signed_w u,v, s1, s2;
  int i;
  int len = 4;
  s1.x = (v4i32){(0x40000000),(0x40000000),(0x20000000),(0x20000000),};
  s2.x = (v4i32){(0x40000000),(0x20000000),(0x20000000),(0x10000000),};
  u.x = __builtin_mxu2_mulq_w(s1.x,s2.x);

  v.x = (v4i32){(0x20000000),(0x10000000),(0x8000000),(0x4000000),};
  if(check_w(&u, &v, len))
   abort();
 return 0;
}
