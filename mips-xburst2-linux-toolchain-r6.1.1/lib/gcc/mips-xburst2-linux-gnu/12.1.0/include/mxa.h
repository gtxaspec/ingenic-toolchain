/* Ingenic MXA intrinsics include file.

   Copyright (C) 2015-2022 Free Software Foundation, Inc.
   Contributed by Imagination Technologies Ltd.

   This file is part of GCC.

   GCC is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published
   by the Free Software Foundation; either version 3, or (at your
   option) any later version.

   GCC is distributed in the hope that it will be useful, but WITHOUT
   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
   License for more details.

   Under Section 7 of GPL version 3, you are granted additional
   permissions described in the GCC Runtime Library Exception, version
   3.1, as published by the Free Software Foundation.

   You should have received a copy of the GNU General Public License and
   a copy of the GCC Runtime Library Exception along with this program;
   see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
   <http://www.gnu.org/licenses/>.  */

#include <msa.h>

#ifndef _MXA_H
#define _MXA_H 1

#if defined (__mips_mxa)
#define __mxa_fcmul_w __builtin_mxa_fcmul_w
#define __mxa_fexuplc_w __builtin_mxa_fexuplc_w
#define __mxa_fexuprc_w __builtin_mxa_fexuprc_w
#define __mxa_ldinss_w __builtin_mxa_ldinss_w
#define __mxa_ldins_w __builtin_mxa_ldins_w
#define __mxa_ldins_d __builtin_mxa_ldins_d
#define __mxa_stext_w __builtin_mxa_stext_w
#define __mxa_stext_d __builtin_mxa_stext_d
#define __mxa_vshfr_b __builtin_mxa_vshfr_b
#define __mxa_vsldi_b __builtin_mxa_vsldi_b
#define __mxa_bmr_v __builtin_mxa_bmr_v
#define __mxa_pcnt_v __builtin_mxa_pcnt_v
#define __mxa_bext_b __builtin_mxa_bext_b
#define __mxa_bext_h __builtin_mxa_bext_h
#define __mxa_bext_w __builtin_mxa_bext_w
#define __mxa_bexp_b __builtin_mxa_bexp_b
#define __mxa_bexp_h __builtin_mxa_bexp_h
#define __mxa_bexp_w __builtin_mxa_bexp_w
#define __mxa_bexp_2b __builtin_mxa_bexp_2b
#define __mxa_bexp_4b __builtin_mxa_bexp_4b
#define __mxa_bmu_v __builtin_mxa_bmu_v
#define __mxa_sll_v __builtin_mxa_sll_v
#define __mxa_slli_v __builtin_mxa_slli_v
#define __mxa_srl_v __builtin_mxa_srl_v
#define __mxa_srli_v __builtin_mxa_srli_v
#define __mxa_move_w __builtin_mxa_move_w
#define __mxa_movbt_b __builtin_mxa_movbt_b
#define __mxa_movbp_b __builtin_mxa_movbp_b
#define __mxa_satss_b __builtin_mxa_satss_b
#define __mxa_satss_h __builtin_mxa_satss_h
#define __mxa_satuu_b __builtin_mxa_satuu_b
#define __mxa_satuu_h __builtin_mxa_satuu_h
#define __mxa_satus_b __builtin_mxa_satus_b
#define __mxa_satus_h __builtin_mxa_satus_h
#define __mxa_addsl_h __builtin_mxa_addsl_h
#define __mxa_addsl_w __builtin_mxa_addsl_w
#define __mxa_addsr_h __builtin_mxa_addsr_h
#define __mxa_addsr_w __builtin_mxa_addsr_w
#define __mxa_addul_h __builtin_mxa_addul_h
#define __mxa_addul_w __builtin_mxa_addul_w
#define __mxa_addur_h __builtin_mxa_addur_h
#define __mxa_addur_w __builtin_mxa_addur_w
#define __mxa_accsl_h __builtin_mxa_accsl_h
#define __mxa_accsl_w __builtin_mxa_accsl_w
#define __mxa_accsr_h __builtin_mxa_accsr_h
#define __mxa_accsr_w __builtin_mxa_accsr_w
#define __mxa_accul_h __builtin_mxa_accul_h
#define __mxa_accul_w __builtin_mxa_accul_w
#define __mxa_accur_h __builtin_mxa_accur_h
#define __mxa_accur_w __builtin_mxa_accur_w
#define __mxa_subsl_h __builtin_mxa_subsl_h
#define __mxa_subsl_w __builtin_mxa_subsl_w
#define __mxa_subsr_h __builtin_mxa_subsr_h
#define __mxa_subsr_w __builtin_mxa_subsr_w
#define __mxa_subul_h __builtin_mxa_subul_h
#define __mxa_subul_w __builtin_mxa_subul_w
#define __mxa_subur_h __builtin_mxa_subur_h
#define __mxa_subur_w __builtin_mxa_subur_w
#define __mxa_mulsl_h __builtin_mxa_mulsl_h
#define __mxa_mulsl_w __builtin_mxa_mulsl_w
#define __mxa_mulsr_h __builtin_mxa_mulsr_h
#define __mxa_mulsr_w __builtin_mxa_mulsr_w
#define __mxa_mulul_h __builtin_mxa_mulul_h
#define __mxa_mulul_w __builtin_mxa_mulul_w
#define __mxa_mulur_h __builtin_mxa_mulur_h
#define __mxa_mulur_w __builtin_mxa_mulur_w
#define __mxa_cast_to_vector_float __builtin_mxa_cast_to_vector_float
#define __mxa_cast_to_vector_double __builtin_mxa_cast_to_vector_double
#define __mxa_cast_to_scalar_float __builtin_mxa_cast_to_scalar_float
#define __mxa_cast_to_scalar_double __builtin_mxa_cast_to_scalar_double

#undef __builtin_mxa_ldinssu_w
#define __builtin_mxa_ldinssu_w(dest, n, base, index)			\
  ({									\
    register void *_tmp_check = (base);					\
    asm __volatile__ ("ldinssu.w %w0[%2], %3(%1)\n\t"			\
		      :"+f"((dest)), "+d"((void*)(base))		\
		      :"I"((n)), "d"((index)));				\
    dest;								\
  })

#undef __builtin_mxa_ldinssu2_w
#define __builtin_mxa_ldinssu2_w(dest, n, base, index)			\
  ({									\
    register void *_tmp_check = (base);					\
    asm __volatile__ ("ldinssu2.w %w0[%2], %3(%1)\n\t"			\
		      :"+f"((dest)), "+d"((void*)(base))		\
		      :"I"((n)), "d"((index)));				\
    dest;								\
  })

#undef __builtin_mxa_ldinsu_w
#define __builtin_mxa_ldinsu_w(dest, n, base, index)			\
  ({									\
    register void *_tmp_check = (base);					\
    asm __volatile__ ("ldinsu.w %w0[%2], %3(%1)\n\t"			\
		      :"+f"((dest)), "+d"((void*)(base))		\
		      :"I"((n)), "d"((index)));				\
    dest;								\
  })

#undef __builtin_mxa_ldinsu_d
#define __builtin_mxa_ldinsu_d(dest, n, base, index)			\
  ({									\
    register void *_tmp_check = (base);					\
    asm __volatile__ ("ldinsu.d %w0[%2], %3(%1)\n\t"			\
		      :"+f"((dest)), "+d"((void*)(base))		\
		      :"I"((n)), "d"((index)));				\
    dest;								\
  })

#undef __builtin_mxa_stextu_w
#define __builtin_mxa_stextu_w(src, n, base)				\
  ({									\
    register void *_tmp_check = (base);					\
    asm __volatile__("stextu.w %w1[%2], %0\n\t"				\
		     :"+d"((void*)(base))				\
		     :"f"((v4i32)(src)),"I"((n))			\
		     :"memory");					\
  })

#undef __builtin_mxa_stextu_d
#define __builtin_mxa_stextu_d(src, n, base)				\
  ({									\
    register void *_tmp_check = (base);					\
    asm __volatile__("stextu.d %w1[%2], %0\n\t"				\
		     :"+d"((void*)(base))				\
		     :"f"((v2i64)(src)),"I"((n))			\
		     :"memory");					\
  })

#define __mxa_ldinssu_w __builtin_mxa_ldinssu_w
#define __mxa_ldinssu2_w __builtin_mxa_ldinssu2_w
#define __mxa_ldinsu_w __builtin_mxa_ldinsu_w
#define __mxa_ldinsu_d __builtin_mxa_ldinsu_d
#define __mxa_stextu_w __builtin_mxa_stextu_w
#define __mxa_stextu_d __builtin_mxa_stextu_d
#endif /* defined (__mips_mxa) */
#endif /* _MXA_H.  */
