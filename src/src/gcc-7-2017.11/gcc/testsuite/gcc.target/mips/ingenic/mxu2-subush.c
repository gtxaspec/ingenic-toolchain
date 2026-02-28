/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"
#include <stdlib.h>

int main()
{
  union_unsigned_h  s1, s2;
  union_signed_h u,v;
  int i;
  int len = 8;
  s1.x = (v8u16){(1),(60000),(1),(3),(3),(3),(3),(3),};
  s2.x = (v8u16){(10),(1),(60000),(1),(1),(1),(1),(1),};
  u.x = __builtin_mxu2_subus_h(s1.x,s2.x);

  v.x = (v8i16){(-9),(32767),(-32768),(2),(2),(2),(2),(2),};
  if(check_h(&u, &v, len))
   abort();
 return 0;
}
