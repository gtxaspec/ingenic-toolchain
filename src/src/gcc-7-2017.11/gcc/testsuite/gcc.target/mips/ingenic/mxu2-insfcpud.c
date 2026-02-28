/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-options "-mmxu2" } */
/* { dg-skip-if "" { *-*-* } { "-O0" } } */

#include "mxu2.h"
#include "mxu2-check.h"

int main()
{
  union_signed_d s1;
  union_signed_d u, v1, v2;
  int i;
  int len = 2;
  unsigned char position = 1;
  long long value = 10;
  s1.x = (v2i64){(1), (1),};
  u.x = __builtin_mxu2_insfcpu_d(s1.x, position, value);

  v2.x = (v2i64){(1), (10),};
  for(i = 0; i < len; i++)
  {
     if(i != (int)position)
     {
        v1.a[i] = s1.a[i];
     }
     else
     {
        v1.a[i] = value;
     }
  }

  if(check_d (&u, &v1, len))
    abort ();
  if(check_d (&u, &v2, len))
    abort ();

  return 0;
}
