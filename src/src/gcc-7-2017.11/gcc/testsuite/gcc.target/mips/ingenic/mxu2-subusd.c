/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */

#include "mxu2.h"
#include "mxu2-check.h"
#include <stdlib.h>

int main()
{
  union_unsigned_d  s1, s2;
  union_signed_d u,v;
  int i;
  int len = 2;
  s1.x = (v2u64){(1),(60000),};
  s2.x = (v2u64){(10),(1),};
  u.x = __builtin_mxu2_subus_d(s1.x,s2.x);

  v.x = (v2i64){(-9),(59999),};
  if(check_d(&u, &v, len))
   abort();
 return 0;
}
