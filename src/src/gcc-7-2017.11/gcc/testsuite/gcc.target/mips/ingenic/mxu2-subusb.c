/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"
#include <stdlib.h>

int main()
{
  union_unsigned_b  s1, s2;
  union_signed_b u,v;
  int i;
  int len = 16;
  s1.x = (v16u8){(1),(250),(1),(3),(3),(3),(3),(3),(3),(3),(3),(3),(3),(3),(3),(3),};
  s2.x = (v16u8){(10),(1),(250),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),};
  u.x = __builtin_mxu2_subus_b(s1.x,s2.x);

  v.x = (v16i8){(-9),(127),(-128),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),};
  if(check_b(&u, &v, len))
   abort();
 return 0;
}
