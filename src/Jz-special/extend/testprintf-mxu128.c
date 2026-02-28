#include <mxu2.h>
#include <mxuextend.h>

v16i8 test_d8;
v8i16 test_d16;
v4i32 test_d32;
v2i64 test_d64;

v16u8 test_u8;
v8u16 test_u16;
v4u32 test_u32;
v2u64 test_u64;

v4f32 test_f32;
v2f64 test_f64;

char test_char[16] = {-1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0xff};
short test_short[8] = {-1, 20, 30, 40, 50, 60, 70, 0xffff};
int test_int[4] = {-1, 20, 30, 0xffffffff};
long long test_long_long[2] = {-1, 0xffffffffffffffff};

float test_float[4] = {134.56789, 2365.45722, -0.9999, -0.001};
double test_double[2] = {134.5678912348958, -0.9999999};

int main()
{
#if 1
	test_d8 = _mx128_lu1q(test_char, 0);
	_mx128_printf("%#v16o\n", test_d8);
	_mx128_printf("%#v16x\n", test_d8);
	_mx128_printf("%v16d\n", test_d8);
	_mx128_printf("%v16u\n", test_d8);

	test_d16 = (v8i16)_mx128_lu1q(test_short, 0);
	_mx128_printf("%#v8o\n", test_d16);
	_mx128_printf("%#v8x\n", test_d16);
	_mx128_printf("%v8d\n", test_d16);
	_mx128_printf("%v8u\n", test_d16);

	test_d32 = (v4i32)_mx128_lu1q(test_int, 0);
	_mx128_printf("%#v4o\n", test_d32);
	_mx128_printf("%#v4x\n", test_d32);
	_mx128_printf("%v4d\n", test_d32);
	_mx128_printf("%v4u\n", test_d32);

	test_d64 = (v2i64)_mx128_lu1q(test_long_long, 0);
	_mx128_printf("%#v2o\n", test_d64);
	_mx128_printf("%#v2x\n", test_d64);
	_mx128_printf("%v2d\n", test_d64);
	_mx128_printf("%v2u\n", test_d64);

	test_f32 = (v4f32)_mx128_lu1q(test_float, 0);
	_mx128_printf("%v4f\n", test_f32);
	_mx128_printf("%.1v4f\n", test_f32);
	_mx128_printf("%.2v4f\n", test_f32);
	_mx128_printf("%.3v4f\n", test_f32);
	_mx128_printf("%.4v4f\n", test_f32);
	_mx128_printf("%.5v4f\n", test_f32);

	test_f64 = (v2f64)_mx128_lu1q(test_double, 0);
	_mx128_printf("%v2f\n", test_f64);
	_mx128_printf("%.7v2f\n", test_f64);
	_mx128_printf("%.8v2f\n", test_f64);
	_mx128_printf("%.9v2f\n", test_f64);
	_mx128_printf("%.10v2f\n", test_f64);
	_mx128_printf("%.11v2f\n", test_f64);
	_mx128_printf("%.12v2f\n", test_f64);
	_mx128_printf("%.13v2f\n", test_f64);
	_mx128_printf("%.14v2f\n", test_f64);

#endif

}
