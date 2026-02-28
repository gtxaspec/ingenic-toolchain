#ifndef _MXU2_CHECK_H
#include <stdlib.h>
#include <math.h>

typedef union
{
   v16i8 x;
   char a[16];
} union_signed_b;

typedef union
{
   v8i16 x;
   short a[8];
} union_signed_h;

typedef union
{
   v4i32 x;
   int a[4];
} union_signed_w;

typedef union
{
   v2i64 x;
   long long a[2];
} union_signed_d;

typedef union
{
   v16u8 x;
   unsigned char a[16];
} union_unsigned_b;

typedef union
{
   v8u16 x;
   unsigned short a[8];
} union_unsigned_h;

typedef union
{
   v4u32 x;
   unsigned int a[4];
} union_unsigned_w;

typedef union
{
   v2u64 x;
   unsigned long long a[2];
} union_unsigned_d;

typedef union
{
   v4f32 x;
   float a[4];
} union_float_w;

typedef union
{
   v2f64 x;
   double a[2];
} union_float_d;

int check_fw(union_float_w* x, union_float_w* y, int len)
{
   int ret = 0;
   int i;
   for (i = 0; i < len ; i++)
   {
     if (fabsf (x->a[i] - y->a[i]) > 0.0000001f)
      {
	ret = 1;
      }
   }
   return ret;
}

int check_fd(union_float_d* x, union_float_d* y, int len)
{
   int ret = 0;
   int i;
   for(i = 0; i < len; i++)
   {
     if (fabs (x->a[i] - y->a[i]) > 0.0000001f)
      {
	ret = 1;
      }
   }
   return ret;
}



int check_ub(union_unsigned_b* x, union_unsigned_b* y, int len)
{
   int ret=0;
   int i;
   for(i = 0; i < len; i++)
   {
      if(x->a[i] != y->a[i])
      {
	ret = 1;
      }
   }
   return ret;
}

int check_uh(union_unsigned_h* x, union_unsigned_h* y, int len)
{
   int ret=0;
   int i;
   for(i = 0; i < len; i++)
   {
      if(x->a[i] != y->a[i])
      {
	ret = 1;
      }
   }
   return ret;
}

int check_uw(union_unsigned_w* x, union_unsigned_w* y, int len)
{
   int ret=0;
   int i;
   for(i = 0; i < len; i++)
   {
      if(x->a[i]!=y->a[i])
      {
	ret = 1;
      }
   }
   return ret;
}

int check_ud(union_unsigned_d* x, union_unsigned_d* y, int len)
{
   int ret=0;
   int i;
   for(i = 0; i < len; i++)
   {
      if(x->a[i] != y->a[i])
      {
	ret = 1;
      }
   }
   return ret;
}

int check_b(union_signed_b* x, union_signed_b* y, int len)
{
   int ret=0;
   int i;
   for(i = 0; i < len; i++)
   {
      if(x->a[i] != y->a[i])
      {
	ret = 1;
      }
   }
   return ret;
}

int check_h(union_signed_h* x, union_signed_h* y, int len)
{
   int ret=0;
   int i;
   for(i = 0; i<len; i++)
   {
      if(x->a[i] != y->a[i])
      {
	ret = 1;
      }
   }
   return ret;
}

int check_w(union_signed_w* x, union_signed_w* y, int len)
{
   int ret=0;
   int i;
   for(i = 0; i < len; i++)
   {
      if(x->a[i] != y->a[i])
      {
	ret = 1;
      }
   }
   return ret;
}

int check_d(union_signed_d* x, union_signed_d* y, int len)
{
   int ret=0;
   int i;
   for(i = 0; i < len; i++)
   {
      if(x->a[i] != y->a[i])
      {
	ret = 1;
      }
   }
   return ret;
}
#endif
