/* Copyright (c) 2009 CodeSourcery, Inc.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of CodeSourcery nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY CODESOURCERY, INC. ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL CODESOURCERY BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "arm_asm.h"
#include <string.h>
#include <stdint.h>
#include <stddef.h>

/* Standard operations for word-sized values.  */
#define WORD_REF(ADDRESS, OFFSET) \
	*((WORD_TYPE*)((char*)(ADDRESS) + (OFFSET)))
#define WORD_COPY(OUT, IN, OFFSET) \
	WORD_REF(OUT, OFFSET) = WORD_REF(IN, OFFSET)

/* On processors with NEON, we use 128-bit vectors.  Also,
   we need to include arm_neon.h to use these.  */
#if defined(__ARM_NEON__)
  #include <arm_neon.h>

  #define WORD_TYPE uint8x16_t
  #define WORD_SIZE 16
  #define MAYBE_PREFETCH(IN) __builtin_prefetch((IN), 0, 0)

/* The vector load and store functions can take up to four 64-bit
     register arguments at a time, allowing 4 * 8 = 32 bytes to be
     copied at once.  */
  #define VECTOR_COPY_SIZE 32

/* On ARM processors with 64-bit ldrd instructions, we use those,
   except on Cortex-M* where benchmarking has shown them to
   be slower.  */
#elif defined(__ARM_ARCH_5E__) || defined(__ARM_ARCH_5TE__) \
	|| defined(__ARM_ARCH_5TEJ__) || defined(_ISA_ARM_6)
  #define WORD_TYPE uint64_t
  #define WORD_SIZE 8
  #define MAYBE_PREFETCH(IN) __builtin_prefetch((IN), 0, 0)

/* On everything else, we use 32-bit loads and stores, and
   do not use prefetching.  */
#else
  #define WORD_TYPE uint32_t
  #define WORD_SIZE 4
  #define MAYBE_PREFETCH(IN)
#endif

/* On all ARM platforms, 'SHORTWORD' is a 32-bit value.  */
#define SHORTWORD_TYPE uint32_t
#define SHORTWORD_SIZE 4
#define SHORTWORD_REF(ADDRESS, OFFSET) \
	*((SHORTWORD_TYPE*)((char*)(ADDRESS) + (OFFSET)))
#define SHORTWORD_COPY(OUT, IN, OFFSET) \
	SHORTWORD_REF(OUT, OFFSET) = SHORTWORD_REF(IN, OFFSET)

/* Shifting directionality depends on endianness.  */
#ifdef __ARMEB__
#define SHORTWORD_SHIFT(IN0, IN1, OFFSET) \
	((IN0) << ((OFFSET)*8)) | ((IN1) >> (SHORTWORD_SIZE*8 - (OFFSET)*8))
#else
#define SHORTWORD_SHIFT(IN0, IN1, OFFSET) \
	((IN0) >> ((OFFSET)*8)) | ((IN1) << (SHORTWORD_SIZE*8 - (OFFSET)*8))
#endif

_PTR
_DEFUN (memcpy, (OUT, IN, N),
	_PTR OUT _AND
	_CONST _PTR IN _AND
	size_t N)
{
  void* OUT0 = OUT;

#if defined(PREFER_SIZE_OVER_SPEED) || defined(__OPTIMIZE_SIZE__)
  const char* OUT_end = (char*)OUT + N;
  while ((char*)OUT < OUT_end) {
    *((char*)OUT) = *((char*)IN);
    OUT++;
    IN++;
  }

  return OUT0;
#else
  /* Handle short strings and immediately return.  */
  if (__builtin_expect(N < SHORTWORD_SIZE, 1)) {
    size_t i = 0;
    while (i < N) {
      ((char*)OUT)[i] = ((char*)IN)[i];
      i++;
    }
    return OUT;
  }

  const char* OUT_end = (char*)OUT + N;

  /* Align OUT to SHORTWORD_SIZE.  */
  while ((uintptr_t)OUT % SHORTWORD_SIZE != 0) {
    *(char*) (OUT++) = *(char*) (IN++);
  }

#if defined(__ARM_NEON__)
  /* Pre-fetch hints help significantly when data is not in
     cache.  They do not hurt (much) when data _is_ in cache. */
  __builtin_prefetch((IN), 0, 0);
  __builtin_prefetch((IN + 64), 0, 0);
  __builtin_prefetch((IN + 128), 0, 0);

  /* Each vld/vst pair handle 32 bytes at a time and can load
     and store data at any offset.

     This first loop is unrolled four times, so handles 128
     bytes per iteration.
  */
  while (VECTOR_COPY_SIZE * 4 <= (OUT_end - (char*)OUT)) {
    asm volatile (
      "pld [%0, #192] \n\t"
      "pld [%0, #256] \n\t"
      "vld1.8 {d0-d3}, [%0]! \n\t"
      "vst1.8 {d0-d3}, [%1]! \n\t"
      "vld1.8 {d4-d7}, [%0]! \n\t"
      "vst1.8 {d4-d7}, [%1]! \n\t"
      "vld1.8 {d8-d11}, [%0]! \n\t"
      "vst1.8 {d8-d11}, [%1]! \n\t"
      "vld1.8 {d12-d15}, [%0]! \n\t"
      "vst1.8 {d12-d15}, [%1]!"
      : "+r" (IN), "+r" (OUT)
      :: "memory",
       "d0", "d1", "d2", "d3",
       "d4", "d5", "d6", "d7",
       "d8", "d9", "d10", "d11",
       "d12", "d13", "d14", "d15");
  }

  /* Unrolled twice, 32 * 2 = 64 bytes per iteration */
  while (VECTOR_COPY_SIZE * 2 <= (OUT_end - (char*)OUT)) {
    asm volatile (
      "vld1.8 {d0-d3}, [%0]! \n\t"
      "vst1.8 {d0-d3}, [%1]! \n\t"
      "vld1.8 {d4-d7}, [%0]! \n\t"
      "vst1.8 {d4-d7}, [%1]!"
      : "+r" (IN), "+r" (OUT)
      :: "memory",
       "d0", "d1", "d2", "d3",
       "d4", "d5", "d6", "d7");
  }

  /* Last whole group of 32 bytes */
  if (VECTOR_COPY_SIZE <= (OUT_end - (char*)OUT)) {
    asm volatile (
      "vld1.8 {d0-d3}, [%0]! \n\t"
      "vst1.8 {d0-d3}, [%1]!"
      : "+r" (IN), "+r" (OUT)
      :: "memory", "d0", "d1", "d2", "d3" );
  }

  /* The remainder are handled in a generic C loop below */

#else /* !defined(__ARM_NEON__) */

  if ((uintptr_t) IN % SHORTWORD_SIZE == 0) {

#if WORD_SIZE > SHORTWORD_SIZE
    /* Align OUT to WORD_SIZE in steps of SHORTWORD_SIZE.  */
    if (__builtin_expect(OUT_end - (char*)OUT >= WORD_SIZE, 0)) {
      while ((uintptr_t)OUT % WORD_SIZE != 0) {
        SHORTWORD_COPY(OUT, IN, 0);
        OUT += SHORTWORD_SIZE;
        IN += SHORTWORD_SIZE;
      }

      if ((uintptr_t) IN % WORD_SIZE == 0) {
#endif /* WORD_SIZE > SHORTWORD_SIZE */

        /* Note: 16-times unrolling is about 20% faster than 4-times
           unrolling on both ARM Cortex-A8 and Cortex-M3.  */
        MAYBE_PREFETCH(IN + 64);
        MAYBE_PREFETCH(IN + 128);
        MAYBE_PREFETCH(IN + 192);
        while (OUT_end - (char*)OUT >= WORD_SIZE * 16) {
          MAYBE_PREFETCH(IN + 256);
          MAYBE_PREFETCH(IN + 320);
          WORD_COPY(OUT, IN, 0);
          WORD_COPY(OUT, IN, WORD_SIZE * 1);
          WORD_COPY(OUT, IN, WORD_SIZE * 2);
          WORD_COPY(OUT, IN, WORD_SIZE * 3);
          WORD_COPY(OUT, IN, WORD_SIZE * 4);
          WORD_COPY(OUT, IN, WORD_SIZE * 5);
          WORD_COPY(OUT, IN, WORD_SIZE * 6);
          WORD_COPY(OUT, IN, WORD_SIZE * 7);
          WORD_COPY(OUT, IN, WORD_SIZE * 8);
          WORD_COPY(OUT, IN, WORD_SIZE * 9);
          WORD_COPY(OUT, IN, WORD_SIZE * 10);
          WORD_COPY(OUT, IN, WORD_SIZE * 11);
          WORD_COPY(OUT, IN, WORD_SIZE * 12);
          WORD_COPY(OUT, IN, WORD_SIZE * 13);
          WORD_COPY(OUT, IN, WORD_SIZE * 14);
          WORD_COPY(OUT, IN, WORD_SIZE * 15);
          OUT += WORD_SIZE * 16;
          IN += WORD_SIZE * 16;
        }
        while (WORD_SIZE * 4 <= OUT_end - (char*)OUT) {
          WORD_COPY(OUT, IN, 0);
          WORD_COPY(OUT, IN, WORD_SIZE * 1);
          WORD_COPY(OUT, IN, WORD_SIZE * 2);
          WORD_COPY(OUT, IN, WORD_SIZE * 3);
          OUT += WORD_SIZE * 4;
          IN += WORD_SIZE * 4;
        }
        while (WORD_SIZE <= OUT_end - (char*)OUT) {
          WORD_COPY(OUT, IN, 0);
          OUT += WORD_SIZE;
          IN += WORD_SIZE;
        }

#if WORD_SIZE > SHORTWORD_SIZE
      } else { /* if IN is not WORD_SIZE aligned */
        while (SHORTWORD_SIZE * 4 <= OUT_end - (char*)OUT) {
          SHORTWORD_COPY(OUT, IN, 0);
          SHORTWORD_COPY(OUT, IN, SHORTWORD_SIZE * 1);
          SHORTWORD_COPY(OUT, IN, SHORTWORD_SIZE * 2);
          SHORTWORD_COPY(OUT, IN, SHORTWORD_SIZE * 3);
          OUT += SHORTWORD_SIZE * 4;
          IN += SHORTWORD_SIZE * 4;
        }
      } /* end if IN is not WORD_SIZE aligned */
    } /* end if N >= WORD_SIZE */

    while (SHORTWORD_SIZE <= OUT_end - (char*)OUT) {
      SHORTWORD_COPY(OUT, IN, 0);
      OUT += SHORTWORD_SIZE;
      IN += SHORTWORD_SIZE;
    }
#endif /* WORD_SIZE > SHORTWORD_SIZE */

  } else { /* if IN is not SHORTWORD_SIZE aligned */
    ptrdiff_t misalign = (uintptr_t)IN % SHORTWORD_SIZE;

    SHORTWORD_TYPE temp1, temp2;
    temp1 = SHORTWORD_REF(IN, -misalign);

    /* Benchmarking indicates that unrolling this loop doesn't
       produce a measurable performance improvement on ARM.  */
    while (SHORTWORD_SIZE <= OUT_end - (char*)OUT) {
      IN += SHORTWORD_SIZE;
      temp2 = SHORTWORD_REF(IN, -misalign);
      SHORTWORD_REF(OUT, 0) = SHORTWORD_SHIFT(temp1, temp2, misalign);
      temp1 = temp2;
      OUT += SHORTWORD_SIZE;
    }

  } /* end if IN is not SHORTWORD_SIZE aligned */
#endif /* not defined(__ARM_NEON__) */

  while ((char*)OUT < OUT_end) {
    *((char*)OUT) = *((char*)IN);
    OUT++;
    IN++;
  }

  return OUT0;
#endif
}
