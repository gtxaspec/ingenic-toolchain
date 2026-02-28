/*
 * Copyright © 2005-2014 Rich Felker, et al.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <math.h>
#include <inttypes.h>
#include "local.h"

#define FORCE_EVAL(x) do {                   \
 if (sizeof(x) == sizeof(float)) {           \
   volatile float __x;                       \
   __x = (x);                                \
 } else if (sizeof(x) == sizeof(double)) {   \
   volatile double __x;                      \
   __x = (x);                                \
 } else {                                    \
   volatile long double __x;                 \
   __x = (x);                                \
 }                                           \
} while(0)

union fshape {
  float value;
  uint32_t bits;
};

float
nexttowardf (float x, long double y)
{
  union fshape ux;
  uint32_t e;

  if (isnan(x) || isnan(y))
    return x + y;
  if (x == y)
    return y;
  ux.value = x;
  if (x == 0) {
    ux.bits = 1;
    if (signbit(y))
      ux.bits |= 0x80000000;
  } else if (x < y) {
    if (signbit(x))
      ux.bits--;
    else
      ux.bits++;
  } else {
    if (signbit(x))
      ux.bits++;
    else
      ux.bits--;
  }
  e = ux.bits & 0x7f800000;
  /* raise overflow if ux.value is infinite and x is finite */
  if (e == 0x7f800000)
    FORCE_EVAL(x+x);
  /* raise underflow if ux.value is subnormal or zero */
  if (e == 0)
    FORCE_EVAL(x*x + ux.value*ux.value);
  return ux.value;
}
