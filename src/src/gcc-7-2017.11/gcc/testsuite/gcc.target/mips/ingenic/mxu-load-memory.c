/* Test builtins for MIPS MXU LD instructions */
/* { dg-do run } */
/* { dg-options "-mmxu" } */

#include <stdint.h>
#include <jzmedia.h>
#define TEST_FUNCS_1( NAME, TYPE, INS,OPT)		\
static void						\
test_##NAME(int32_t *s)					\
{							\
  TYPE b[1] = { 0x01 };					\
  TYPE *a = b;						\
  INS(xr15, a, 0, OPT);					\
  *s = S32M2I(xr15);					\
}

#define TEST_FUNCS_2(NAME, TYPE, INS, OPT)		\
static void						\
test_##NAME(int32_t *s)					\
{							\
  TYPE b[1] = { 0x01 };					\
  TYPE *a = b;						\
  INS(xr15, a, 0);					\
  *s = S32M2I(xr15);					\
}

TEST_FUNCS_1 (s8ldd, int8_t, S8LDD, 7)
TEST_FUNCS_1 (s8ldi, int8_t, S8LDI, 7)
TEST_FUNCS_1 (s16ldd, int16_t, S16LDD, 3)
TEST_FUNCS_1 (s16ldi, int16_t, S16LDI, 3)
TEST_FUNCS_1 (s32lddv, int32_t, S32LDDV, 0)
TEST_FUNCS_1 (s32lddvr, int32_t, S32LDDVR, 0)
TEST_FUNCS_1 (s32ldiv, int32_t, S32LDIV, 0)
TEST_FUNCS_1 (s32ldivr, int32_t, S32LDIVR, 0)
TEST_FUNCS_2 (s32ldi, int32_t, S32LDI, 0)
TEST_FUNCS_2 (s32ldir, int32_t, S32LDIR, 0)
TEST_FUNCS_2 (s32ldd, int32_t, S32LDD, 0)
TEST_FUNCS_2 (s32lddr, int32_t, S32LDDR, 0)

int
main(void)
{
  int32_t s;

  test_s8ldd(&s);
  if (s != 0x1010101)
     __builtin_abort ();

  test_s8ldi(&s);
  if (s != 0x1010101)
     __builtin_abort ();

  test_s16ldd(&s);
  if (s != 0x10001)
    __builtin_abort ();

  test_s16ldi(&s);
  if (s != 0x10001)
    __builtin_abort ();

  test_s32ldd(&s);
  if (s != 0x01)
    __builtin_abort ();

  test_s32lddv(&s);
  if (s != 0x01)
    __builtin_abort ();

  test_s32ldi(&s);
  if (s != 0x01)
    __builtin_abort ();

  test_s32ldiv(&s);
  if (s != 0x01)
    __builtin_abort ();

  test_s32lddr(&s);
  if (s != 0x01000000)
    __builtin_abort ();

  test_s32lddvr(&s);
  if (s != 0x01000000)
    __builtin_abort ();

  test_s32ldir(&s);
  if (s != 0x01000000)
    __builtin_abort ();

  test_s32ldivr(&s);
  if (s != 0x01000000)
    __builtin_abort ();

  return 0;
}

