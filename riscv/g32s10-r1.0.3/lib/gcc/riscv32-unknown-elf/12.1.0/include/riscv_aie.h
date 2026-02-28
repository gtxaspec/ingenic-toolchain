/* Machine description for RISC-V vector operations.
   Copyright (C) 2019 Free Software Foundation, Inc.
   Contributed by Tianyang Liu (rick.tyliu@ingenic.com).

   This file is part of GCC.

   GCC is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3, or (at your option)
   any later version.

   GCC is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with GCC; see the file COPYING3.  If not see
   <http://www.gnu.org/licenses/>.  */

#ifndef _RISCV_AIE_H
#define _RISCV_AIE_H

/* set by aie-vector-bits, scalable is 0. */
#define __AIE_VECTOR_BITS __RISCV_FEATURE_AIE_BITS

typedef signed int *                  _m32i_ptr;
typedef unsigned int *                _m32u_ptr;
typedef signed long long *            _m64i_ptr;
typedef unsigned long long *          _m64u_ptr;

typedef __builtin_riscv_aie_uint128 * _m128u_ptr;
typedef __builtin_riscv_aie_uint256 * _m256u_ptr;


/* AIE-VECTOR1.0 built-in function.  */
/* vundefined() */
#define vundefined_b8 __builtin_ingenicaie_vundefined_b8
#define vundefined_b16 __builtin_ingenicaie_vundefined_b16
#define vundefined_b32 __builtin_ingenicaie_vundefined_b32

#define vundefined_u8 __builtin_ingenicaie_vundefined_u8
#define vundefined_i8 __builtin_ingenicaie_vundefined_i8
#define vundefined_u16 __builtin_ingenicaie_vundefined_u16
#define vundefined_i16 __builtin_ingenicaie_vundefined_i16
#define vundefined_u32 __builtin_ingenicaie_vundefined_u32
#define vundefined_i32 __builtin_ingenicaie_vundefined_i32
#define vundefined_u64 __builtin_ingenicaie_vundefined_u64
#define vundefined_i64 __builtin_ingenicaie_vundefined_i64
#define vundefined_u128 __builtin_ingenicaie_vundefined_u128
#define vundefined_i128 __builtin_ingenicaie_vundefined_i128
#define vundefined_u256 __builtin_ingenicaie_vundefined_u256
#define vundefined_i256 __builtin_ingenicaie_vundefined_i256
#define vundefined_f32 __builtin_ingenicaie_vundefined_f32


/* read vlenb */
//extern int __builtin_ingenicaie_readvl();
#define _aie_readvl __builtin_ingenicaie_readvl

/* psubs */
//extern int __builtin_ingenicaie_psubs(int, int);
#define _aie_psubs __builtin_ingenicaie_psubs

/* load/store addr update.  */
#if  (__AIE_VECTOR_BITS == 0)
#define _aie_addr_upd __builtin_ingenicaie_addr_update_vla
#else
#define _aie_addr_upd __builtin_ingenicaie_addr_update_vls
#endif
#define _aie_addr_upd_offset __builtin_ingenicaie_addr_update_offset

/* ffsihw: int32 -> fp32 -> fp16 */
//extern aie_vfloat16_t _aie_ffsiwh_m(mask, maskoff, aie_vint32_t)
#define _aie_ffsihw __builtin_ingenicaie_ffsihw
#define _aie_ffsihw_m __builtin_ingenicaie_ffsihw_mask

#define __builtin_ingenicaie_ffsihw_mask(ppr, maskoff, vrs)     \
        __builtin_ingenicaie_fcvthw_mask(ppr, maskoff,          \
			__builtin_ingenicaie_ffsiw(vrs))

#define __builtin_ingenicaie_ffsihw(vrs)     \
        __builtin_ingenicaie_fcvthw(__builtin_ingenicaie_ffsiw(vrs))


#if (__AIE_VECTOR_BITS != 0)
#define _aie_fcvthw_ext __builtin_ingenicaie_fcvthw_ext

#define __builtin_ingenicaie_fcvthw_ext(vrs)               \
       (aie_vfloat16_t)                                    \
       __builtin_ingenicaie_gt2w(                          \
                vundefined_i32(),                          \
                0,                                         \
		(aie_vint32_t)                             \
                __builtin_ingenicaie_gth(                  \
                        (aie_vint8_t)                      \
                        __builtin_ingenicaie_fcvthw(vrs)), \
                0)

#define _aie_fcvtwh_ext __builtin_ingenicaie_fcvtwh_ext

#define __builtin_ingenicaie_fcvtwh_ext(vrs)       \
        (aie_vfloat32_t)                           \
        __builtin_ingenicaie_fcvtwh(               \
                (aie_vfloat16_t)                   \
                __builtin_ingenicaie_extshl(       \
                        (aie_vint16_t)vrs))
#else

#define _aie_fcvthw_ext(vf32) __extension__ ({ \
	aie_vfloat16_t tmp0 = __builtin_ingenicaie_fcvthw (vf32); \
	aie_vint8_t  tmp1 = *(aie_vint8_t*)(&tmp0); \
	aie_vint8_t  tmp2 = __builtin_ingenicaie_gth(tmp1); \
	aie_vint32_t tmp3 = *(aie_vint32_t*)(&tmp2); \
	aie_vint32_t tmp4 = __builtin_ingenicaie_gt2w (vundefined_i32 (), 0, tmp3, 0); \
	aie_vfloat16_t vf16 = *(aie_vfloat16_t*)(&tmp4); \
	vf16; \
})

#define _aie_fcvtwh_ext(vf16) __extension__ ({ \
	aie_vint16_t   tmp0 = *(aie_vint16_t*)(&vf16); \
	aie_vint32_t   tmp1 = __builtin_ingenicaie_extshl (tmp0); \
	aie_vfloat16_t tmp2 = *(aie_vfloat16_t*)(&tmp1); \
	aie_vfloat32_t vf32 = __builtin_ingenicaie_fcvtwh (tmp2); \
	vf32; \
})
#endif


/* mask operations */
//extern aie_vbool8_t __builtin_ingenicaie_pnot_b8(aie_vbool8_t);
#define _aie_pnot_b8 __builtin_ingenicaie_pnot_b8
//extern aie_vbool16_t __builtin_ingenicaie_pnot_b16(aie_vbool16_t);
#define _aie_pnot_b16 __builtin_ingenicaie_pnot_b16
//extern aie_vbool32_t __builtin_ingenicaie_pnot_b32(aie_vbool32_t);
#define _aie_pnot_b32 __builtin_ingenicaie_pnot_b32

//extern aie_vbool8_t __builtin_ingenicaie_pand_b8(aie_vbool8_t, aie_vbool8_t);
#define _aie_pand_b8 __builtin_ingenicaie_pand_b8
//extern aie_vbool16_t __builtin_ingenicaie_pand_b16(aie_vbool16_t, aie_vbool16_t);
#define _aie_pand_b16 __builtin_ingenicaie_pand_b16
//extern aie_vbool32_t __builtin_ingenicaie_pand_b32(aie_vbool32_t, aie_vbool32_t);
#define _aie_pand_b32 __builtin_ingenicaie_pand_b32
//extern aie_vbool8_t __builtin_ingenicaie_pnand_b8(aie_vbool8_t, aie_vbool8_t);
#define _aie_pnand_b8 __builtin_ingenicaie_pnand_b8
//extern aie_vbool16_t __builtin_ingenicaie_pnand_b16(aie_vbool16_t, aie_vbool16_t);
#define _aie_pnand_b16 __builtin_ingenicaie_pnand_b16
//extern aie_vbool32_t __builtin_ingenicaie_pnand_b32(aie_vbool32_t, aie_vbool32_t);
#define _aie_pnand_b32 __builtin_ingenicaie_pnand_b32
//extern aie_vbool8_t __builtin_ingenicaie_pandn_b8(aie_vbool8_t, aie_vbool8_t);
#define _aie_pandn_b8 __builtin_ingenicaie_pandn_b8
//extern aie_vbool16_t __builtin_ingenicaie_pandn_b16(aie_vbool16_t, aie_vbool16_t);
#define _aie_pandn_b16 __builtin_ingenicaie_pandn_b16
//extern aie_vbool32_t __builtin_ingenicaie_pandn_b32(aie_vbool32_t, aie_vbool32_t);
#define _aie_pandn_b32 __builtin_ingenicaie_pandn_b32

//extern aie_vbool8_t __builtin_ingenicaie_por_b8(aie_vbool8_t, aie_vbool8_t);
#define _aie_por_b8 __builtin_ingenicaie_por_b8
//extern aie_vbool16_t __builtin_ingenicaie_por_b16(aie_vbool16_t, aie_vbool16_t);
#define _aie_por_b16 __builtin_ingenicaie_por_b16
//extern aie_vbool32_t __builtin_ingenicaie_por_b32(aie_vbool32_t, aie_vbool32_t);
#define _aie_por_b32 __builtin_ingenicaie_por_b32
//extern aie_vbool8_t __builtin_ingenicaie_pnor_b8(aie_vbool8_t, aie_vbool8_t);
#define _aie_pnor_b8 __builtin_ingenicaie_pnor_b8
//extern aie_vbool16_t __builtin_ingenicaie_pnor_b16(aie_vbool16_t, aie_vbool16_t);
#define _aie_pnor_b16 __builtin_ingenicaie_pnor_b16
//extern aie_vbool32_t __builtin_ingenicaie_pnor_b32(aie_vbool32_t, aie_vbool32_t);
#define _aie_pnor_b32 __builtin_ingenicaie_pnor_b32
//extern aie_vbool8_t __builtin_ingenicaie_porn_b8(aie_vbool8_t, aie_vbool8_t);
#define _aie_porn_b8 __builtin_ingenicaie_porn_b8
//extern aie_vbool16_t __builtin_ingenicaie_porn_b16(aie_vbool16_t, aie_vbool16_t);
#define _aie_porn_b16 __builtin_ingenicaie_porn_b16
//extern aie_vbool32_t __builtin_ingenicaie_porn_b32(aie_vbool32_t, aie_vbool32_t);
#define _aie_porn_b32 __builtin_ingenicaie_porn_b32

//extern aie_vbool8_t __builtin_ingenicaie_pxor_b8(aie_vbool8_t, aie_vbool8_t);
#define _aie_pxor_b8 __builtin_ingenicaie_pxor_b8
//extern aie_vbool16_t __builtin_ingenicaie_pxor_b16(aie_vbool16_t, aie_vbool16_t);
#define _aie_pxor_b16 __builtin_ingenicaie_pxor_b16
//extern aie_vbool32_t __builtin_ingenicaie_pxor_b32(aie_vbool32_t, aie_vbool32_t);
#define _aie_pxor_b32 __builtin_ingenicaie_pxor_b32
//extern aie_vbool8_t __builtin_ingenicaie_pxnor_b8(aie_vbool8_t, aie_vbool8_t);
#define _aie_pxnor_b8 __builtin_ingenicaie_pxnor_b8
//extern aie_vbool16_t __builtin_ingenicaie_pxnor_b16(aie_vbool16_t, aie_vbool16_t);
#define _aie_pxnor_b16 __builtin_ingenicaie_pxnor_b16
//extern aie_vbool32_t __builtin_ingenicaie_pxnor_b32(aie_vbool32_t, aie_vbool32_t);
#define _aie_pxnor_b32 __builtin_ingenicaie_pxnor_b32

//extern int __builtin_ingenicaie_pcpop_b8_mask(aie_vbool8_t, aie_vbool8_t);
#define _aie_pcpop_b8 __builtin_ingenicaie_pcpop_b8
#define _aie_pcpop_b8_m __builtin_ingenicaie_pcpop_b8_mask
//extern int __builtin_ingenicaie_pcpop_b16_mask(aie_vbool16_t, aie_vbool16_t);
#define _aie_pcpop_b16 __builtin_ingenicaie_pcpop_b16
#define _aie_pcpop_b16_m __builtin_ingenicaie_pcpop_b16_mask
//extern int __builtin_ingenicaie_pcpop_b32_mask(aie_vbool32_t, aie_vbool32_t);
#define _aie_pcpop_b32 __builtin_ingenicaie_pcpop_b32
#define _aie_pcpop_b32_m __builtin_ingenicaie_pcpop_b32_mask
//extern int __builtin_ingenicaie_pfirst_b8_mask(aie_vbool8_t, aie_vbool8_t);
#define _aie_pfirst_b8 __builtin_ingenicaie_pfirst_b8
#define _aie_pfirst_b8_m __builtin_ingenicaie_pfirst_b8_mask
//extern int __builtin_ingenicaie_pfirst_b16_mask(aie_vbool16_t, aie_vbool16_t);
#define _aie_pfirst_b16 __builtin_ingenicaie_pfirst_b16
#define _aie_pfirst_b16_m __builtin_ingenicaie_pfirst_b16_mask
//extern int __builtin_ingenicaie_pfirst_b32_mask(aie_vbool32_t, aie_vbool32_t);
#define _aie_pfirst_b32 __builtin_ingenicaie_pfirst_b32
#define _aie_pfirst_b32_m __builtin_ingenicaie_pfirst_b32_mask

//extern aie_vbool8_t __builtin_ingenicaie_psbf_b8_mask(aie_vbool8_t, aie_vbool8_t, aie_vbool8_t);
#define _aie_psbf_b8 __builtin_ingenicaie_psbf_b8
#define _aie_psbf_b8_m __builtin_ingenicaie_psbf_b8_mask
//extern aie_vbool16_t __builtin_ingenicaie_psbf_b16_mask(aie_vbool16_t, aie_vbool16_t, aie_vbool16_t);
#define _aie_psbf_b16 __builtin_ingenicaie_psbf_b16
#define _aie_psbf_b16_m __builtin_ingenicaie_psbf_b16_mask
//extern aie_vbool32_t __builtin_ingenicaie_psbf_b32_mask(aie_vbool32_t, aie_vbool32_t, aie_vbool32_t);
#define _aie_psbf_b32 __builtin_ingenicaie_psbf_b32
#define _aie_psbf_b32_m __builtin_ingenicaie_psbf_b32_mask
//extern aie_vbool8_t __builtin_ingenicaie_psif_b8_mask(aie_vbool8_t, aie_vbool8_t, aie_vbool8_t);
#define _aie_psif_b8 __builtin_ingenicaie_psif_b8
#define _aie_psif_b8_m __builtin_ingenicaie_psif_b8_mask
//extern aie_vbool16_t __builtin_ingenicaie_psif_b16_mask(aie_vbool16_t, aie_vbool16_t, aie_vbool16_t);
#define _aie_psif_b16 __builtin_ingenicaie_psif_b16
#define _aie_psif_b16_m __builtin_ingenicaie_psif_b16_mask
//extern aie_vbool32_t __builtin_ingenicaie_psif_b32_mask(aie_vbool32_t, aie_vbool32_t, aie_vbool32_t);
#define _aie_psif_b32 __builtin_ingenicaie_psif_b32
#define _aie_psif_b32_m __builtin_ingenicaie_psif_b32_mask
//extern aie_vbool8_t __builtin_ingenicaie_psof_b8_mask(aie_vbool8_t, aie_vbool8_t, aie_vbool8_t);
#define _aie_psof_b8 __builtin_ingenicaie_psof_b8
#define _aie_psof_b8_m __builtin_ingenicaie_psof_b8_mask
//extern aie_vbool16_t __builtin_ingenicaie_psof_b16_mask(aie_vbool16_t, aie_vbool16_t, aie_vbool16_t);
#define _aie_psof_b16 __builtin_ingenicaie_psof_b16
#define _aie_psof_b16_m __builtin_ingenicaie_psof_b16_mask
//extern aie_vbool32_t __builtin_ingenicaie_psof_b32_mask(aie_vbool32_t, aie_vbool32_t, aie_vbool32_t);
#define _aie_psof_b32 __builtin_ingenicaie_psof_b32
#define _aie_psof_b32_m __builtin_ingenicaie_psof_b32_mask

//extern aie_vint8_t __builtin_ingenicaie_piotab_mask(mask, maskedoff, aie_vbool8_t);
#define _aie_piotab __builtin_ingenicaie_piotab
#define _aie_piotab_m __builtin_ingenicaie_piotab_mask
//extern aie_vint16_t __builtin_ingenicaie_piotah_mask(mask, maskedoff, aie_vbool16_t);
#define _aie_piotah __builtin_ingenicaie_piotah
#define _aie_piotah_m __builtin_ingenicaie_piotah_mask
//extern aie_vint32_t __builtin_ingenicaie_piotaw_mask(mask, maskedoff, aie_vbool32_t);
#define _aie_piotaw __builtin_ingenicaie_piotaw
#define _aie_piotaw_m __builtin_ingenicaie_piotaw_mask

//extern aie_vint8_t __builtin_ingenicaie_pidb_mask(mask, maskedoff);
#define _aie_pidb __builtin_ingenicaie_pidb
#define _aie_pidb_m __builtin_ingenicaie_pidb_mask
//extern aie_vint16_t __builtin_ingenicaie_pidh_mask(mask, maskedoff);
#define _aie_pidh __builtin_ingenicaie_pidh
#define _aie_pidh_m __builtin_ingenicaie_pidh_mask
//extern aie_vint32_t __builtin_ingenicaie_pidw_mask(mask, maskedoff);
#define _aie_pidw __builtin_ingenicaie_pidw
#define _aie_pidw_m __builtin_ingenicaie_pidw_mask

//extern aie_vbool8_t __builtin_ingenicaie_pdec_b8(int);
#define _aie_pdec_b8 __builtin_ingenicaie_pdec_b8
//extern aie_vbool16_t __builtin_ingenicaie_pdec_b16(int);
#define _aie_pdec_b16 __builtin_ingenicaie_pdec_b16
//extern aie_vbool32_t __builtin_ingenicaie_pdec_b32(int);
#define _aie_pdec_b32 __builtin_ingenicaie_pdec_b32

//extern aie_vbool8_t __builtin_ingenicaie_pld_b8(aie_vbool8_t *, int);
#define _aie_pld_b8 __builtin_ingenicaie_pld_b8
//extern aie_vbool16_t __builtin_ingenicaie_pld_b16(aie_vbool16_t *, int);
#define _aie_pld_b16 __builtin_ingenicaie_pld_b16
//extern aie_vbool32_t __builtin_ingenicaie_pld_b32(aie_vbool32_t *, int);
#define _aie_pld_b32 __builtin_ingenicaie_pld_b32
//extern void __builtin_ingenicaie_psd_b8(aie_vbool8_t, aie_vbool8_t *, int);
#define _aie_psd_b8 __builtin_ingenicaie_psd_b8
//extern void __builtin_ingenicaie_psd_b16(aie_vbool16_t, aie_vbool16_t *, int);
#define _aie_psd_b16 __builtin_ingenicaie_psd_b16
//extern void __builtin_ingenicaie_psd_b32(aie_vbool32_t, aie_vbool32_t *, int);
#define _aie_psd_b32 __builtin_ingenicaie_psd_b32


/* Compare */
//extern aie_vint8_t __builtin_ingenicaie_ceqb(aie_vint8_t, aie_vint8_t);
#define _aie_ceqb __builtin_ingenicaie_ceqb
//extern aie_vint16_t __builtin_ingenicaie_ceqh(aie_vint16_t, aie_vint16_t);
#define _aie_ceqh __builtin_ingenicaie_ceqh
//extern aie_vint32_t __builtin_ingenicaie_ceqw(aie_vint32_t, aie_vint32_t);
#define _aie_ceqw __builtin_ingenicaie_ceqw
//extern aie_vint8_t __builtin_ingenicaie_ceqzb(aie_vint8_t);
#define _aie_ceqzb __builtin_ingenicaie_ceqzb
//extern aie_vint16_t __builtin_ingenicaie_ceqzh(aie_vint16_t);
#define _aie_ceqzh __builtin_ingenicaie_ceqzh
//extern aie_vint32_t __builtin_ingenicaie_ceqzw(aie_vint32_t);
#define _aie_ceqzw __builtin_ingenicaie_ceqzw

//extern aie_vint8_t __builtin_ingenicaie_clesb(aie_vint8_t, aie_vint8_t);
#define _aie_clesb __builtin_ingenicaie_clesb
//extern aie_vint16_t __builtin_ingenicaie_clesh(aie_vint16_t, aie_vint16_t);
#define _aie_clesh __builtin_ingenicaie_clesh
//extern aie_vint32_t __builtin_ingenicaie_clesw(aie_vint32_t, aie_vint32_t);
#define _aie_clesw __builtin_ingenicaie_clesw

//extern aie_vint8_t __builtin_ingenicaie_cleub(aie_vuint8_t, aie_vuint8_t);
#define _aie_cleub __builtin_ingenicaie_cleub
//extern aie_vint16_t __builtin_ingenicaie_cleuh(aie_vuint16_t, aie_vuint16_t);
#define _aie_cleuh __builtin_ingenicaie_cleuh
//extern aie_vint32_t __builtin_ingenicaie_cleuw(aie_vuint32_t, aie_vuint32_t);
#define _aie_cleuw __builtin_ingenicaie_cleuw

//extern aie_vint8_t __builtin_ingenicaie_clezb(aie_vint8_t);
#define _aie_clezb __builtin_ingenicaie_clezb
//extern aie_vint16_t __builtin_ingenicaie_clezh(aie_vint16_t);
#define _aie_clezh __builtin_ingenicaie_clezh
//extern aie_vint32_t __builtin_ingenicaie_clezw(aie_vint32_t);
#define _aie_clezw __builtin_ingenicaie_clezw

//extern aie_vint8_t __builtin_ingenicaie_cltsb(aie_vint8_t, aie_vint8_t);
#define _aie_cltsb __builtin_ingenicaie_cltsb
//extern aie_vint16_t __builtin_ingenicaie_cltsh(aie_vint16_t, aie_vint16_t);
#define _aie_cltsh __builtin_ingenicaie_cltsh
//extern aie_vint32_t __builtin_ingenicaie_cltsw(aie_vint32_t, aie_vint32_t);
#define _aie_cltsw __builtin_ingenicaie_cltsw

//extern aie_vint8_t __builtin_ingenicaie_cltub(aie_vuint8_t, aie_vuint8_t);
#define _aie_cltub __builtin_ingenicaie_cltub
//extern aie_vint16_t __builtin_ingenicaie_cltuh(aie_vuint16_t, aie_vuint16_t);
#define _aie_cltuh __builtin_ingenicaie_cltuh
//extern aie_vint32_t __builtin_ingenicaie_cltuw(aie_vuint32_t, aie_vuint32_t);
#define _aie_cltuw __builtin_ingenicaie_cltuw

//extern aie_vint8_t __builtin_ingenicaie_cltzb(aie_vint8_t);
#define _aie_cltzb __builtin_ingenicaie_cltzb
//extern aie_vint16_t __builtin_ingenicaie_cltzh(aie_vint16_t);
#define _aie_cltzh __builtin_ingenicaie_cltzh
//extern aie_vint32_t __builtin_ingenicaie_cltzw(aie_vint32_t);
#define _aie_cltzw __builtin_ingenicaie_cltzw

//extern aie_vbool8_t __builtin_ingenicaie_pceqb_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_pceqb __builtin_ingenicaie_pceqb
#define _aie_pceqb_m __builtin_ingenicaie_pceqb_mask
//extern aie_vbool16_t __builtin_ingenicaie_pceqh_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_pceqh __builtin_ingenicaie_pceqh
#define _aie_pceqh_m __builtin_ingenicaie_pceqh_mask
//extern aie_vbool32_t __builtin_ingenicaie_pceqw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_pceqw __builtin_ingenicaie_pceqw
#define _aie_pceqw_m __builtin_ingenicaie_pceqw_mask
//extern aie_vbool8_t __builtin_ingenicaie_pceqzb_mask(mask, maskedoff, aie_vint8_t);
#define _aie_pceqzb __builtin_ingenicaie_pceqzb
#define _aie_pceqzb_m __builtin_ingenicaie_pceqzb_mask
//extern aie_vbool16_t __builtin_ingenicaie_pceqzh_mask(mask, maskedoff, aie_vint16_t);
#define _aie_pceqzh __builtin_ingenicaie_pceqzh
#define _aie_pceqzh_m __builtin_ingenicaie_pceqzh_mask
//extern aie_vbool32_t __builtin_ingenicaie_pceqzw_mask(mask, maskedoff, aie_vint32_t);
#define _aie_pceqzw __builtin_ingenicaie_pceqzw
#define _aie_pceqzw_m __builtin_ingenicaie_pceqzw_mask

//extern aie_vbool8_t __builtin_ingenicaie_pcneb_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_pcneb __builtin_ingenicaie_pcneb
#define _aie_pcneb_m __builtin_ingenicaie_pcneb_mask
//extern aie_vbool16_t __builtin_ingenicaie_pcneh_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_pcneh __builtin_ingenicaie_pcneh
#define _aie_pcneh_m __builtin_ingenicaie_pcneh_mask
//extern aie_vbool32_t __builtin_ingenicaie_pcnew_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_pcnew __builtin_ingenicaie_pcnew
#define _aie_pcnew_m __builtin_ingenicaie_pcnew_mask
//extern aie_vbool8_t __builtin_ingenicaie_pcnezb_mask(mask, maskedoff, aie_vint8_t);
#define _aie_pcnezb __builtin_ingenicaie_pcnezb
#define _aie_pcnezb_m __builtin_ingenicaie_pcnezb_mask
//extern aie_vbool16_t __builtin_ingenicaie_pcnezh_mask(mask, maskedoff, aie_vint16_t);
#define _aie_pcnezh __builtin_ingenicaie_pcnezh
#define _aie_pcnezh_m __builtin_ingenicaie_pcnezh_mask
//extern aie_vbool32_t __builtin_ingenicaie_pcnezw_mask(mask, maskedoff, aie_vint32_t);
#define _aie_pcnezw __builtin_ingenicaie_pcnezw
#define _aie_pcnezw_m __builtin_ingenicaie_pcnezw_mask

//extern aie_vbool8_t __builtin_ingenicaie_pclesb_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_pclesb __builtin_ingenicaie_pclesb
#define _aie_pclesb_m __builtin_ingenicaie_pclesb_mask
//extern aie_vbool16_t __builtin_ingenicaie_pclesh_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_pclesh __builtin_ingenicaie_pclesh
#define _aie_pclesh_m __builtin_ingenicaie_pclesh_mask
//extern aie_vbool32_t __builtin_ingenicaie_pclesw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_pclesw __builtin_ingenicaie_pclesw
#define _aie_pclesw_m __builtin_ingenicaie_pclesw_mask

//extern aie_vbool8_t __builtin_ingenicaie_pcleub_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_pcleub __builtin_ingenicaie_pcleub
#define _aie_pcleub_m __builtin_ingenicaie_pcleub_mask
//extern aie_vbool16_t __builtin_ingenicaie_pcleuh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_pcleuh __builtin_ingenicaie_pcleuh
#define _aie_pcleuh_m __builtin_ingenicaie_pcleuh_mask
//extern aie_vbool32_t __builtin_ingenicaie_pcleuw_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_pcleuw __builtin_ingenicaie_pcleuw
#define _aie_pcleuw_m __builtin_ingenicaie_pcleuw_mask

//extern aie_vbool8_t __builtin_ingenicaie_pclezb_mask(mask, maskedoff, aie_vint8_t);
#define _aie_pclezb __builtin_ingenicaie_pclezb
#define _aie_pclezb_m __builtin_ingenicaie_pclezb_mask
//extern aie_vbool16_t __builtin_ingenicaie_pclezh_mask(mask, maskedoff, aie_vint16_t);
#define _aie_pclezh __builtin_ingenicaie_pclezh
#define _aie_pclezh_m __builtin_ingenicaie_pclezh_mask
//extern aie_vbool32_t __builtin_ingenicaie_pclezw_mask(mask, maskedoff, aie_vint32_t);
#define _aie_pclezw __builtin_ingenicaie_pclezw
#define _aie_pclezw_m __builtin_ingenicaie_pclezw_mask

//extern aie_vbool8_t __builtin_ingenicaie_pcltsb_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_pcltsb __builtin_ingenicaie_pcltsb
#define _aie_pcltsb_m __builtin_ingenicaie_pcltsb_mask
//extern aie_vbool16_t __builtin_ingenicaie_pcltsh_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_pcltsh __builtin_ingenicaie_pcltsh
#define _aie_pcltsh_m __builtin_ingenicaie_pcltsh_mask
//extern aie_vbool32_t __builtin_ingenicaie_pcltsw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_pcltsw __builtin_ingenicaie_pcltsw
#define _aie_pcltsw_m __builtin_ingenicaie_pcltsw_mask

//extern aie_vbool8_t __builtin_ingenicaie_pcltub_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_pcltub __builtin_ingenicaie_pcltub
#define _aie_pcltub_m __builtin_ingenicaie_pcltub_mask
//extern aie_vbool16_t __builtin_ingenicaie_pcltuh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_pcltuh __builtin_ingenicaie_pcltuh
#define _aie_pcltuh_m __builtin_ingenicaie_pcltuh_mask
//extern aie_vbool32_t __builtin_ingenicaie_pcltuw_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_pcltuw __builtin_ingenicaie_pcltuw
#define _aie_pcltuw_m __builtin_ingenicaie_pcltuw_mask

//extern aie_vbool8_t __builtin_ingenicaie_pcltzb_mask(mask, maskedoff, aie_vint8_t);
#define _aie_pcltzb __builtin_ingenicaie_pcltzb
#define _aie_pcltzb_m __builtin_ingenicaie_pcltzb_mask
//extern aie_vbool16_t __builtin_ingenicaie_pcltzh_mask(mask, maskedoff, aie_vint16_t);
#define _aie_pcltzh __builtin_ingenicaie_pcltzh
#define _aie_pcltzh_m __builtin_ingenicaie_pcltzh_mask
//extern aie_vbool32_t __builtin_ingenicaie_pcltzw_mask(mask, maskedoff, aie_vint32_t);
#define _aie_pcltzw __builtin_ingenicaie_pcltzw
#define _aie_pcltzw_m __builtin_ingenicaie_pcltzw_mask


/* Integer Arithmetic */
//extern aie_vint8_t __builtin_ingenicaie_addb_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_addb __builtin_ingenicaie_addb
#define _aie_addb_m __builtin_ingenicaie_addb_mask
//extern aie_vint16_t __builtin_ingenicaie_addh_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_addh __builtin_ingenicaie_addh
#define _aie_addh_m __builtin_ingenicaie_addh_mask
//extern aie_vint32_t __builtin_ingenicaie_addw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_addw __builtin_ingenicaie_addw
#define _aie_addw_m __builtin_ingenicaie_addw_mask

//extern aie_vint8_t __builtin_ingenicaie_subb_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_subb __builtin_ingenicaie_subb
#define _aie_subb_m __builtin_ingenicaie_subb_mask
//extern aie_vint16_t __builtin_ingenicaie_subh_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_subh __builtin_ingenicaie_subh
#define _aie_subh_m __builtin_ingenicaie_subh_mask
//extern aie_vint32_t __builtin_ingenicaie_subw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_subw __builtin_ingenicaie_subw
#define _aie_subw_m __builtin_ingenicaie_subw_mask

//extern aie_vint16_t __builtin_ingenicaie_waddsbl_mask(mask, maskedoff, aie_vint16_t, aie_vint8_t);
#define _aie_waddsbl __builtin_ingenicaie_waddsbl
#define _aie_waddsbl_m __builtin_ingenicaie_waddsbl_mask
//extern aie_vint16_t __builtin_ingenicaie_waddsbh_mask(mask, maskedoff, aie_vint16_t, aie_vint8_t);
#define _aie_waddsbh __builtin_ingenicaie_waddsbh
#define _aie_waddsbh_m __builtin_ingenicaie_waddsbh_mask
//extern aie_vint32_t __builtin_ingenicaie_waddshl_mask(mask, maskedoff, aie_vint32_t, aie_vint16_t);
#define _aie_waddshl __builtin_ingenicaie_waddshl
#define _aie_waddshl_m __builtin_ingenicaie_waddshl_mask
//extern aie_vint32_t __builtin_ingenicaie_waddshh_mask(mask, maskedoff, aie_vint32_t, aie_vint16_t);
#define _aie_waddshh __builtin_ingenicaie_waddshh
#define _aie_waddshh_m __builtin_ingenicaie_waddshh_mask
//extern aie_vuint16_t __builtin_ingenicaie_waddubl_mask(mask, maskedoff, aie_vuint16_t, aie_vuint8_t);
#define _aie_waddubl __builtin_ingenicaie_waddubl
#define _aie_waddubl_m __builtin_ingenicaie_waddubl_mask
//extern aie_vuint16_t __builtin_ingenicaie_waddubh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint8_t);
#define _aie_waddubh __builtin_ingenicaie_waddubh
#define _aie_waddubh_m __builtin_ingenicaie_waddubh_mask
//extern aie_vuint32_t __builtin_ingenicaie_wadduhl_mask(mask, maskedoff, aie_vuint32_t, aie_vuint16_t);
#define _aie_wadduhl __builtin_ingenicaie_wadduhl
#define _aie_wadduhl_m __builtin_ingenicaie_wadduhl_mask
//extern aie_vuint32_t __builtin_ingenicaie_wadduhh_mask(mask, maskedoff, aie_vuint32_t, aie_vuint16_t);
#define _aie_wadduhh __builtin_ingenicaie_wadduhh
#define _aie_wadduhh_m __builtin_ingenicaie_wadduhh_mask

//extern aie_vint16_t __builtin_ingenicaie_wsubsbl_mask(mask, maskedoff, aie_vint16_t, aie_vint8_t);
#define _aie_wsubsbl __builtin_ingenicaie_wsubsbl
#define _aie_wsubsbl_m __builtin_ingenicaie_wsubsbl_mask
//extern aie_vint16_t __builtin_ingenicaie_wsubsbh_mask(mask, maskedoff, aie_vint16_t, aie_vint8_t);
#define _aie_wsubsbh __builtin_ingenicaie_wsubsbh
#define _aie_wsubsbh_m __builtin_ingenicaie_wsubsbh_mask
//extern aie_vint32_t __builtin_ingenicaie_wsubshl_mask(mask, maskedoff, aie_vint32_t, aie_vint16_t);
#define _aie_wsubshl __builtin_ingenicaie_wsubshl
#define _aie_wsubshl_m __builtin_ingenicaie_wsubshl_mask
//extern aie_vint32_t __builtin_ingenicaie_wsubshh_mask(mask, maskedoff, aie_vint32_t, aie_vint16_t);
#define _aie_wsubshh __builtin_ingenicaie_wsubshh
#define _aie_wsubshh_m __builtin_ingenicaie_wsubshh_mask
//extern aie_vuint16_t __builtin_ingenicaie_wsububl_mask(mask, maskedoff, aie_vuint16_t, aie_vuint8_t);
#define _aie_wsububl __builtin_ingenicaie_wsububl
#define _aie_wsububl_m __builtin_ingenicaie_wsububl_mask
//extern aie_vuint16_t __builtin_ingenicaie_wsububh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint8_t);
#define _aie_wsububh __builtin_ingenicaie_wsububh
#define _aie_wsububh_m __builtin_ingenicaie_wsububh_mask
//extern aie_vuint32_t __builtin_ingenicaie_wsubuhl_mask(mask, maskedoff, aie_vuint32_t, aie_vuint16_t);
#define _aie_wsubuhl __builtin_ingenicaie_wsubuhl
#define _aie_wsubuhl_m __builtin_ingenicaie_wsubuhl_mask
//extern aie_vuint32_t __builtin_ingenicaie_wsubuhh_mask(mask, maskedoff, aie_vuint32_t, aie_vuint16_t);
#define _aie_wsubuhh __builtin_ingenicaie_wsubuhh
#define _aie_wsubuhh_m __builtin_ingenicaie_wsubuhh_mask

//extern aie_vint8_t __builtin_ingenicaie_absb_mask(mask, maskedoff, aie_vint8_t);
#define _aie_absb __builtin_ingenicaie_absb
#define _aie_absb_m __builtin_ingenicaie_absb_mask
//extern aie_vint16_t __builtin_ingenicaie_absh_mask(mask, maskedoff, aie_vint16_t);
#define _aie_absh __builtin_ingenicaie_absh
#define _aie_absh_m __builtin_ingenicaie_absh_mask
//extern aie_vint32_t __builtin_ingenicaie_absw_mask(mask, maskedoff, aie_vint32_t);
#define _aie_absw __builtin_ingenicaie_absw
#define _aie_absw_m __builtin_ingenicaie_absw_mask

//extern aie_vint8_t __builtin_ingenicaie_mulb_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_mulb __builtin_ingenicaie_mulb
#define _aie_mulb_m __builtin_ingenicaie_mulb_mask
//extern aie_vint16_t __builtin_ingenicaie_mulh_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_mulh __builtin_ingenicaie_mulh
#define _aie_mulh_m __builtin_ingenicaie_mulh_mask
//extern aie_vint32_t __builtin_ingenicaie_mulw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_mulw __builtin_ingenicaie_mulw
#define _aie_mulw_m __builtin_ingenicaie_mulw_mask

//extern aie_vint16_t __builtin_ingenicaie_smulbe_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_smulbe __builtin_ingenicaie_smulbe
#define _aie_smulbe_m __builtin_ingenicaie_smulbe_mask
//extern aie_vint16_t __builtin_ingenicaie_smulbo_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_smulbo __builtin_ingenicaie_smulbo
#define _aie_smulbo_m __builtin_ingenicaie_smulbo_mask
//extern aie_vint32_t __builtin_ingenicaie_smulhe_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_smulhe __builtin_ingenicaie_smulhe
#define _aie_smulhe_m __builtin_ingenicaie_smulhe_mask
//extern aie_vint32_t __builtin_ingenicaie_smulho_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_smulho __builtin_ingenicaie_smulho
#define _aie_smulho_m __builtin_ingenicaie_smulho_mask
//extern aie_vuint16_t __builtin_ingenicaie_umulbe_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_umulbe __builtin_ingenicaie_umulbe
#define _aie_umulbe_m __builtin_ingenicaie_umulbe_mask
//extern aie_vuint16_t __builtin_ingenicaie_umulbo_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_umulbo __builtin_ingenicaie_umulbo
#define _aie_umulbo_m __builtin_ingenicaie_umulbo_mask
//extern aie_vuint32_t __builtin_ingenicaie_umulhe_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_umulhe __builtin_ingenicaie_umulhe
#define _aie_umulhe_m __builtin_ingenicaie_umulhe_mask
//extern aie_vuint32_t __builtin_ingenicaie_umulho_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_umulho __builtin_ingenicaie_umulho
#define _aie_umulho_m __builtin_ingenicaie_umulho_mask

//extern aie_vint16_t __builtin_ingenicaie_wsmulbl_mask(mask, maskedoff, aie_vint16_t, aie_vint8_t);
#define _aie_wsmulbl __builtin_ingenicaie_wsmulbl
#define _aie_wsmulbl_m __builtin_ingenicaie_wsmulbl_mask
//extern aie_vint16_t __builtin_ingenicaie_wsmulbh_mask(mask, maskedoff, aie_vint16_t, aie_vint8_t);
#define _aie_wsmulbh __builtin_ingenicaie_wsmulbh
#define _aie_wsmulbh_m __builtin_ingenicaie_wsmulbh_mask
//extern aie_vint32_t __builtin_ingenicaie_wsmulhl_mask(mask, maskedoff, aie_vint32_t, aie_vint16_t);
#define _aie_wsmulhl __builtin_ingenicaie_wsmulhl
#define _aie_wsmulhl_m __builtin_ingenicaie_wsmulhl_mask
//extern aie_vint32_t __builtin_ingenicaie_wsmulhh_mask(mask, maskedoff, aie_vint32_t, aie_vint16_t);
#define _aie_wsmulhh __builtin_ingenicaie_wsmulhh
#define _aie_wsmulhh_m __builtin_ingenicaie_wsmulhh_mask
//extern aie_vuint16_t __builtin_ingenicaie_wumulbl_mask(mask, maskedoff, aie_vuint16_t, aie_vuint8_t);
#define _aie_wumulbl __builtin_ingenicaie_wumulbl
#define _aie_wumulbl_m __builtin_ingenicaie_wumulbl_mask
//extern aie_vuint16_t __builtin_ingenicaie_wumulbh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint8_t);
#define _aie_wumulbh __builtin_ingenicaie_wumulbh
#define _aie_wumulbh_m __builtin_ingenicaie_wumulbh_mask
//extern aie_vuint32_t __builtin_ingenicaie_wumulhl_mask(mask, maskedoff, aie_vuint32_t, aie_vuint16_t);
#define _aie_wumulhl __builtin_ingenicaie_wumulhl
#define _aie_wumulhl_m __builtin_ingenicaie_wumulhl_mask
//extern aie_vuint32_t __builtin_ingenicaie_wumulhh_mask(mask, maskedoff, aie_vuint32_t, aie_vuint16_t);
#define _aie_wumulhh __builtin_ingenicaie_wumulhh
#define _aie_wumulhh_m __builtin_ingenicaie_wumulhh_mask

//extern aie_vint32_t __builtin_ingenicaie_mlaw_mask(mask, aie_vint32_t, aie_vint32_t, aie_vint32_t);
#define _aie_mlaw __builtin_ingenicaie_mlaw
#define _aie_mlaw_m __builtin_ingenicaie_mlaw_mask
//extern aie_vint32_t __builtin_ingenicaie_mlsw_mask(mask, aie_vint32_t, aie_vint32_t, aie_vint32_t);
#define _aie_mlsw __builtin_ingenicaie_mlsw
#define _aie_mlsw_m __builtin_ingenicaie_mlsw_mask
//extern aie_vint32_t __builtin_ingenicaie_smlahe_mask(mask, aie_vint32_t, aie_vint16_t, aie_vint16_t);
#define _aie_smlahe __builtin_ingenicaie_smlahe
#define _aie_smlahe_m __builtin_ingenicaie_smlahe_mask
//extern aie_vint32_t __builtin_ingenicaie_smlaho_mask(mask, aie_vint32_t, aie_vint16_t, aie_vint16_t);
#define _aie_smlaho __builtin_ingenicaie_smlaho
#define _aie_smlaho_m __builtin_ingenicaie_smlaho_mask

//extern aie_vint32_t __builtin_ingenicaie_smlshe_mask(mask, aie_vint32_t, aie_vint16_t, aie_vint16_t);
#define _aie_smlshe __builtin_ingenicaie_smlshe
#define _aie_smlshe_m __builtin_ingenicaie_smlshe_mask
//extern aie_vint32_t __builtin_ingenicaie_smlsho_mask(mask, aie_vint32_t, aie_vint16_t, aie_vint16_t);
#define _aie_smlsho __builtin_ingenicaie_smlsho
#define _aie_smlsho_m __builtin_ingenicaie_smlsho_mask

//extern aie_vint32_t __builtin_ingenicaie_wsmlahl_mask(mask, aie_vint32_t, aie_vint32_t, aie_vint16_t);
#define _aie_wsmlahl __builtin_ingenicaie_wsmlahl
#define _aie_wsmlahl_m __builtin_ingenicaie_wsmlahl_mask
//extern aie_vint32_t __builtin_ingenicaie_wsmlahh_mask(mask, aie_vint32_t, aie_vint32_t, aie_vint16_t);
#define _aie_wsmlahh __builtin_ingenicaie_wsmlahh
#define _aie_wsmlahh_m __builtin_ingenicaie_wsmlahh_mask
//extern aie_vint32_t __builtin_ingenicaie_wsmlshl_mask(mask, aie_vint32_t, aie_vint32_t, aie_vint16_t);
#define _aie_wsmlshl __builtin_ingenicaie_wsmlshl
#define _aie_wsmlshl_m __builtin_ingenicaie_wsmlshl_mask
//extern aie_vint32_t __builtin_ingenicaie_wsmlshh_mask(mask, aie_vint32_t, aie_vint32_t, aie_vint16_t);
#define _aie_wsmlshh __builtin_ingenicaie_wsmlshh
#define _aie_wsmlshh_m __builtin_ingenicaie_wsmlshh_mask

//extern aie_vint8_t __builtin_ingenicaie_maxab_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_maxab __builtin_ingenicaie_maxab
#define _aie_maxab_m __builtin_ingenicaie_maxab_mask
//extern aie_vint16_t __builtin_ingenicaie_maxah_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_maxah __builtin_ingenicaie_maxah
#define _aie_maxah_m __builtin_ingenicaie_maxah_mask
//extern aie_vint32_t __builtin_ingenicaie_maxaw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_maxaw __builtin_ingenicaie_maxaw
#define _aie_maxaw_m __builtin_ingenicaie_maxaw_mask

//extern aie_vint8_t __builtin_ingenicaie_maxsb_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_maxsb __builtin_ingenicaie_maxsb
#define _aie_maxsb_m __builtin_ingenicaie_maxsb_mask
//extern aie_vint16_t __builtin_ingenicaie_maxsh_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_maxsh __builtin_ingenicaie_maxsh
#define _aie_maxsh_m __builtin_ingenicaie_maxsh_mask
//extern aie_vint32_t __builtin_ingenicaie_maxsw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_maxsw __builtin_ingenicaie_maxsw
#define _aie_maxsw_m __builtin_ingenicaie_maxsw_mask

//extern aie_vuint8_t __builtin_ingenicaie_maxub_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_maxub __builtin_ingenicaie_maxub
#define _aie_maxub_m __builtin_ingenicaie_maxub_mask
//extern aie_vuint16_t __builtin_ingenicaie_maxuh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_maxuh __builtin_ingenicaie_maxuh
#define _aie_maxuh_m __builtin_ingenicaie_maxuh_mask
//extern aie_vuint32_t __builtin_ingenicaie_maxuw_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_maxuw __builtin_ingenicaie_maxuw
#define _aie_maxuw_m __builtin_ingenicaie_maxuw_mask
//extern aie_vuint8_t __builtin_ingenicaie_maxu2bi_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_maxu2bi __builtin_ingenicaie_maxu2bi
#define _aie_maxu2bi_m __builtin_ingenicaie_maxu2bi_mask
//extern aie_vuint8_t __builtin_ingenicaie_maxu4bi_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_maxu4bi __builtin_ingenicaie_maxu4bi
#define _aie_maxu4bi_m __builtin_ingenicaie_maxu4bi_mask

//extern aie_vint8_t __builtin_ingenicaie_minab_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_minab __builtin_ingenicaie_minab
#define _aie_minab_m __builtin_ingenicaie_minab_mask
//extern aie_vint16_t __builtin_ingenicaie_minah_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_minah __builtin_ingenicaie_minah
#define _aie_minah_m __builtin_ingenicaie_minah_mask
//extern aie_vint32_t __builtin_ingenicaie_minaw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_minaw __builtin_ingenicaie_minaw
#define _aie_minaw_m __builtin_ingenicaie_minaw_mask

//extern aie_vint8_t __builtin_ingenicaie_minsb_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_minsb __builtin_ingenicaie_minsb
#define _aie_minsb_m __builtin_ingenicaie_minsb_mask
//extern aie_vint16_t __builtin_ingenicaie_minsh_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_minsh __builtin_ingenicaie_minsh
#define _aie_minsh_m __builtin_ingenicaie_minsh_mask
//extern aie_vint32_t __builtin_ingenicaie_minsw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_minsw __builtin_ingenicaie_minsw
#define _aie_minsw_m __builtin_ingenicaie_minsw_mask

//extern aie_vuint8_t __builtin_ingenicaie_minub_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_minub __builtin_ingenicaie_minub
#define _aie_minub_m __builtin_ingenicaie_minub_mask
//extern aie_vuint16_t __builtin_ingenicaie_minuh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_minuh __builtin_ingenicaie_minuh
#define _aie_minuh_m __builtin_ingenicaie_minuh_mask
//extern aie_vuint32_t __builtin_ingenicaie_minuw_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_minuw __builtin_ingenicaie_minuw
#define _aie_minuw_m __builtin_ingenicaie_minuw_mask
//extern aie_vuint8_t __builtin_ingenicaie_minu2bi_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_minu2bi __builtin_ingenicaie_minu2bi
#define _aie_minu2bi_m __builtin_ingenicaie_minu2bi_mask
//extern aie_vuint8_t __builtin_ingenicaie_minu4bi_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_minu4bi __builtin_ingenicaie_minu4bi
#define _aie_minu4bi_m __builtin_ingenicaie_minu4bi_mask

//extern aie_vint16_t __builtin_ingenicaie_satsshb_mask(mask, maskedoff, aie_vint16_t);
#define _aie_satsshb __builtin_ingenicaie_satsshb
#define _aie_satsshb_m __builtin_ingenicaie_satsshb_mask
//extern aie_vint32_t __builtin_ingenicaie_satsswb_mask(mask, maskedoff, aie_vint32_t);
#define _aie_satsswb __builtin_ingenicaie_satsswb
#define _aie_satsswb_m __builtin_ingenicaie_satsswb_mask
//extern aie_vint32_t __builtin_ingenicaie_satsswh_mask(mask, maskedoff, aie_vint32_t);
#define _aie_satsswh __builtin_ingenicaie_satsswh
#define _aie_satsswh_m __builtin_ingenicaie_satsswh_mask

//extern aie_vuint8_t __builtin_ingenicaie_satsub2bi_mask(mask, maskedoff, aie_vint8_t);
#define _aie_satsub2bi __builtin_ingenicaie_satsub2bi
#define _aie_satsub2bi_m __builtin_ingenicaie_satsub2bi_mask
//extern aie_vuint8_t __builtin_ingenicaie_satsub4bi_mask(mask, maskedoff, aie_vint8_t);
#define _aie_satsub4bi __builtin_ingenicaie_satsub4bi
#define _aie_satsub4bi_m __builtin_ingenicaie_satsub4bi_mask

//extern aie_vuint16_t __builtin_ingenicaie_satsuh2bi_mask(mask, maskedoff, aie_vint16_t);
#define _aie_satsuh2bi __builtin_ingenicaie_satsuh2bi
#define _aie_satsuh2bi_m __builtin_ingenicaie_satsuh2bi_mask
//extern aie_vuint16_t __builtin_ingenicaie_satsuh4bi_mask(mask, maskedoff, aie_vint16_t);
#define _aie_satsuh4bi __builtin_ingenicaie_satsuh4bi
#define _aie_satsuh4bi_m __builtin_ingenicaie_satsuh4bi_mask
//extern aie_vuint16_t __builtin_ingenicaie_satsuhb_mask(mask, maskedoff, aie_vint16_t);
#define _aie_satsuhb __builtin_ingenicaie_satsuhb
#define _aie_satsuhb_m __builtin_ingenicaie_satsuhb_mask

//extern aie_vuint32_t __builtin_ingenicaie_satsuw2bi_mask(mask, maskedoff, aie_vint32_t);
#define _aie_satsuw2bi __builtin_ingenicaie_satsuw2bi
#define _aie_satsuw2bi_m __builtin_ingenicaie_satsuw2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_satsuw4bi_mask(mask, maskedoff, aie_vint32_t);
#define _aie_satsuw4bi __builtin_ingenicaie_satsuw4bi
#define _aie_satsuw4bi_m __builtin_ingenicaie_satsuw4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_satsuwb_mask(mask, maskedoff, aie_vint32_t);
#define _aie_satsuwb __builtin_ingenicaie_satsuwb
#define _aie_satsuwb_m __builtin_ingenicaie_satsuwb_mask
//extern aie_vuint32_t __builtin_ingenicaie_satsuwh_mask(mask, maskedoff, aie_vint32_t);
#define _aie_satsuwh __builtin_ingenicaie_satsuwh
#define _aie_satsuwh_m __builtin_ingenicaie_satsuwh_mask

//extern aie_vuint8_t __builtin_ingenicaie_satuub2bi_mask(mask, maskedoff, aie_vuint8_t);
#define _aie_satuub2bi __builtin_ingenicaie_satuub2bi
#define _aie_satuub2bi_m __builtin_ingenicaie_satuub2bi_mask
//extern aie_vuint8_t __builtin_ingenicaie_satuub4bi_mask(mask, maskedoff, aie_vuint8_t);
#define _aie_satuub4bi __builtin_ingenicaie_satuub4bi
#define _aie_satuub4bi_m __builtin_ingenicaie_satuub4bi_mask
//extern aie_vuint16_t __builtin_ingenicaie_satuuh2bi_mask(mask, maskedoff, aie_vuint16_t);
#define _aie_satuuh2bi __builtin_ingenicaie_satuuh2bi
#define _aie_satuuh2bi_m __builtin_ingenicaie_satuuh2bi_mask
//extern aie_vuint16_t __builtin_ingenicaie_satuuh4bi_mask(mask, maskedoff, aie_vuint16_t);
#define _aie_satuuh4bi __builtin_ingenicaie_satuuh4bi
#define _aie_satuuh4bi_m __builtin_ingenicaie_satuuh4bi_mask
//extern aie_vuint16_t __builtin_ingenicaie_satuuhb_mask(mask, maskedoff, aie_vuint16_t);
#define _aie_satuuhb __builtin_ingenicaie_satuuhb
#define _aie_satuuhb_m __builtin_ingenicaie_satuuhb_mask
//extern aie_vuint32_t __builtin_ingenicaie_satuuw4bi_mask(mask, maskedoff, aie_vuint32_t);
#define _aie_satuuw4bi __builtin_ingenicaie_satuuw4bi
#define _aie_satuuw4bi_m __builtin_ingenicaie_satuuw4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_satuuwb_mask(mask, maskedoff, aie_vuint32_t);
#define _aie_satuuwb __builtin_ingenicaie_satuuwb
#define _aie_satuuwb_m __builtin_ingenicaie_satuuwb_mask
//extern aie_vuint32_t __builtin_ingenicaie_satuuwh_mask(mask, maskedoff, aie_vuint32_t);
#define _aie_satuuwh __builtin_ingenicaie_satuuwh
#define _aie_satuuwh_m __builtin_ingenicaie_satuuwh_mask

//extern aie_vint8_t __builtin_ingenicaie_tocb_mask(mask, maskedoff, aie_vint8_t);
#define _aie_tocb __builtin_ingenicaie_tocb
#define _aie_tocb_m __builtin_ingenicaie_tocb_mask
//extern aie_vint16_t __builtin_ingenicaie_toch_mask(mask, maskedoff, aie_vint16_t);
#define _aie_toch __builtin_ingenicaie_toch
#define _aie_toch_m __builtin_ingenicaie_toch_mask
//extern aie_vint32_t __builtin_ingenicaie_tocw_mask(mask, maskedoff, aie_vint32_t);
#define _aie_tocw __builtin_ingenicaie_tocw
#define _aie_tocw_m __builtin_ingenicaie_tocw_mask


/* Bitwise */
//extern aie_vuint8_t __builtin_ingenicaie_andib_mask(mask, maskedoff, aie_vuint8_t, unsigned int);
#define _aie_andib __builtin_ingenicaie_andib
#define _aie_andib_m __builtin_ingenicaie_andib_mask
//extern aie_vuint8_t __builtin_ingenicaie_orib_mask(mask, maskedoff, aie_vuint8_t, unsigned int);
#define _aie_orib __builtin_ingenicaie_orib
#define _aie_orib_m __builtin_ingenicaie_orib_mask
//extern aie_vuint8_t __builtin_ingenicaie_xorib_mask(mask, maskedoff, aie_vuint8_t, unsigned int);
#define _aie_xorib __builtin_ingenicaie_xorib
#define _aie_xorib_m __builtin_ingenicaie_xorib_mask

//extern aie_vuint8_t __builtin_ingenicaie_andb_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_andb __builtin_ingenicaie_andb
#define _aie_andb_m __builtin_ingenicaie_andb_mask
//extern aie_vuint16_t __builtin_ingenicaie_andh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_andh __builtin_ingenicaie_andh
#define _aie_andh_m __builtin_ingenicaie_andh_mask
//extern aie_vuint32_t __builtin_ingenicaie_andw_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_andw __builtin_ingenicaie_andw
#define _aie_andw_m __builtin_ingenicaie_andw_mask
//extern aie_vuint8_t __builtin_ingenicaie_andnb_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_andnb __builtin_ingenicaie_andnb
#define _aie_andnb_m __builtin_ingenicaie_andnb_mask
//extern aie_vuint16_t __builtin_ingenicaie_andnh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_andnh __builtin_ingenicaie_andnh
#define _aie_andnh_m __builtin_ingenicaie_andnh_mask
//extern aie_vuint32_t __builtin_ingenicaie_andnw_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_andnw __builtin_ingenicaie_andnw
#define _aie_andnw_m __builtin_ingenicaie_andnw_mask

//extern aie_vuint8_t __builtin_ingenicaie_orb_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_orb __builtin_ingenicaie_orb
#define _aie_orb_m __builtin_ingenicaie_orb_mask
//extern aie_vuint16_t __builtin_ingenicaie_orh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_orh __builtin_ingenicaie_orh
#define _aie_orh_m __builtin_ingenicaie_orh_mask
//extern aie_vuint32_t __builtin_ingenicaie_orw_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_orw __builtin_ingenicaie_orw
#define _aie_orw_m __builtin_ingenicaie_orw_mask
//extern aie_vuint8_t __builtin_ingenicaie_ornb_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_ornb __builtin_ingenicaie_ornb
#define _aie_ornb_m __builtin_ingenicaie_ornb_mask
//extern aie_vuint16_t __builtin_ingenicaie_ornh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_ornh __builtin_ingenicaie_ornh
#define _aie_ornh_m __builtin_ingenicaie_ornh_mask
//extern aie_vuint32_t __builtin_ingenicaie_ornw_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_ornw __builtin_ingenicaie_ornw
#define _aie_ornw_m __builtin_ingenicaie_ornw_mask

//extern aie_vuint8_t __builtin_ingenicaie_xorb_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_xorb __builtin_ingenicaie_xorb
#define _aie_xorb_m __builtin_ingenicaie_xorb_mask
//extern aie_vuint16_t __builtin_ingenicaie_xorh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_xorh __builtin_ingenicaie_xorh
#define _aie_xorh_m __builtin_ingenicaie_xorh_mask
//extern aie_vuint32_t __builtin_ingenicaie_xorw_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_xorw __builtin_ingenicaie_xorw
#define _aie_xorw_m __builtin_ingenicaie_xorw_mask
//extern aie_vuint8_t __builtin_ingenicaie_xornb_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_xornb __builtin_ingenicaie_xornb
#define _aie_xornb_m __builtin_ingenicaie_xornb_mask
//extern aie_vuint16_t __builtin_ingenicaie_xornh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_xornh __builtin_ingenicaie_xornh
#define _aie_xornh_m __builtin_ingenicaie_xornh_mask
//extern aie_vuint32_t __builtin_ingenicaie_xornw_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_xornw __builtin_ingenicaie_xornw
#define _aie_xornw_m __builtin_ingenicaie_xornw_mask

//extern aie_vuint8_t __builtin_ingenicaie_eselb_mask(mask, aie_vuint8_t, aie_vuint8_t);
#define _aie_eselb __builtin_ingenicaie_eselb
//extern aie_vuint16_t __builtin_ingenicaie_eselh_mask(mask, aie_vuint16_t, aie_vuint16_t);
#define _aie_eselh __builtin_ingenicaie_eselh
//extern aie_vuint32_t __builtin_ingenicaie_eselw_mask(mask, aie_vuint32_t, aie_vuint32_t);
#define _aie_eselw __builtin_ingenicaie_eselw

// macro
#define _aie_andv _aie_andb
#define _aie_andnv _aie_andnb
#define _aie_orv _aie_orb
#define _aie_ornv _aie_ornb
#define _aie_xorv _aie_xorb
#define _aie_xornv _aie_xornb

//extern aie_vuint8_t __builtin_ingenicaie_bselv(aie_vuint8_t, aie_vuint8_t, aie_vuint8_t);
#define _aie_bselv __builtin_ingenicaie_bselv


/* Floating Point Arithmetic */
//extern aie_vfloat32_t __builtin_ingenicaie_fmaddw_mask(mask, aie_vfloat32_t, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fmaddw __builtin_ingenicaie_fmaddw
#define _aie_fmaddw_m __builtin_ingenicaie_fmaddw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fmsubw_mask(mask, aie_vfloat32_t, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fmsubw __builtin_ingenicaie_fmsubw
#define _aie_fmsubw_m __builtin_ingenicaie_fmsubw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fnmaddw_mask(mask, aie_vfloat32_t, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fnmaddw __builtin_ingenicaie_fnmaddw
#define _aie_fnmaddw_m __builtin_ingenicaie_fnmaddw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fnmsubw_mask(mask, aie_vfloat32_t, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fnmsubw __builtin_ingenicaie_fnmsubw
#define _aie_fnmsubw_m __builtin_ingenicaie_fnmsubw_mask

//extern aie_vfloat32_t __builtin_ingenicaie_faddw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_faddw __builtin_ingenicaie_faddw
#define _aie_faddw_m __builtin_ingenicaie_faddw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fsubw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fsubw __builtin_ingenicaie_fsubw
#define _aie_fsubw_m __builtin_ingenicaie_fsubw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fmaxw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fmaxw __builtin_ingenicaie_fmaxw
#define _aie_fmaxw_m __builtin_ingenicaie_fmaxw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fminw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fminw __builtin_ingenicaie_fminw
#define _aie_fminw_m __builtin_ingenicaie_fminw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fmulw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fmulw __builtin_ingenicaie_fmulw
#define _aie_fmulw_m __builtin_ingenicaie_fmulw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fcmulrw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fcmulrw __builtin_ingenicaie_fcmulrw
#define _aie_fcmulrw_m __builtin_ingenicaie_fcmulrw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fcmuliw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fcmuliw __builtin_ingenicaie_fcmuliw
#define _aie_fcmuliw_m __builtin_ingenicaie_fcmuliw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fcaddw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fcaddw __builtin_ingenicaie_fcaddw
#define _aie_fcaddw_m __builtin_ingenicaie_fcaddw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fmaxaw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fmaxaw __builtin_ingenicaie_fmaxaw
#define _aie_fmaxaw_m __builtin_ingenicaie_fmaxaw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fminaw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fminaw __builtin_ingenicaie_fminaw
#define _aie_fminaw_m __builtin_ingenicaie_fminaw_mask
//extern aie_vint32_t __builtin_ingenicaie_fclassw_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie_fclassw __builtin_ingenicaie_fclassw
#define _aie_fclassw_m __builtin_ingenicaie_fclassw_mask

//extern aie_vfloat16_t __builtin_ingenicaie_faddh_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_faddh __builtin_ingenicaie_faddh
#define _aie_faddh_m __builtin_ingenicaie_faddh_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fsubh_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_fsubh __builtin_ingenicaie_fsubh
#define _aie_fsubh_m __builtin_ingenicaie_fsubh_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fmaxh_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_fmaxh __builtin_ingenicaie_fmaxh
#define _aie_fmaxh_m __builtin_ingenicaie_fmaxh_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fminh_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_fminh __builtin_ingenicaie_fminh
#define _aie_fminh_m __builtin_ingenicaie_fminh_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fmulh_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_fmulh __builtin_ingenicaie_fmulh
#define _aie_fmulh_m __builtin_ingenicaie_fmulh_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fcmulrh_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_fcmulrh __builtin_ingenicaie_fcmulrh
#define _aie_fcmulrh_m __builtin_ingenicaie_fcmulrh_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fcmulih_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_fcmulih __builtin_ingenicaie_fcmulih
#define _aie_fcmulih_m __builtin_ingenicaie_fcmulih_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fcaddh_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_fcaddh __builtin_ingenicaie_fcaddh
#define _aie_fcaddh_m __builtin_ingenicaie_fcaddh_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fmaxah_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_fmaxah __builtin_ingenicaie_fmaxah
#define _aie_fmaxah_m __builtin_ingenicaie_fmaxah_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fminah_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_fminah __builtin_ingenicaie_fminah
#define _aie_fminah_m __builtin_ingenicaie_fminah_mask
//extern aie_vint16_t __builtin_ingenicaie_fclassh_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie_fclassh __builtin_ingenicaie_fclassh
#define _aie_fclassh_m __builtin_ingenicaie_fclassh_mask

/* Floating Point Compare */
//extern aie_vint32_t __builtin_ingenicaie_fceqw(aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fceqw __builtin_ingenicaie_fceqw
//extern aie_vint32_t __builtin_ingenicaie_fclew(aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fclew __builtin_ingenicaie_fclew
//extern aie_vint32_t __builtin_ingenicaie_fcltw(aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fcltw __builtin_ingenicaie_fcltw
//extern aie_vint32_t __builtin_ingenicaie_fcorw(aie_vfloat32_t, aie_vfloat32_t);
#define _aie_fcorw __builtin_ingenicaie_fcorw

//extern aie_vbool32_t __builtin_ingenicaie_pfceqw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_pfceqw __builtin_ingenicaie_pfceqw
#define _aie_pfceqw_m __builtin_ingenicaie_pfceqw_mask
//extern aie_vbool32_t __builtin_ingenicaie_pfcnew_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_pfcnew __builtin_ingenicaie_pfcnew
#define _aie_pfcnew_m __builtin_ingenicaie_pfcnew_mask
//extern aie_vbool32_t __builtin_ingenicaie_pfclew_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_pfclew __builtin_ingenicaie_pfclew
#define _aie_pfclew_m __builtin_ingenicaie_pfclew_mask
//extern aie_vbool32_t __builtin_ingenicaie_pfcltw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_pfcltw __builtin_ingenicaie_pfcltw
#define _aie_pfcltw_m __builtin_ingenicaie_pfcltw_mask
//extern aie_vbool32_t __builtin_ingenicaie_pfcorw_mask(mask, maskedoff, aie_vfloat32_t, aie_vfloat32_t);
#define _aie_pfcorw __builtin_ingenicaie_pfcorw
#define _aie_pfcorw_m __builtin_ingenicaie_pfcorw_mask

//extern aie_vbool16_t __builtin_ingenicaie_pfceqh_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_pfceqh __builtin_ingenicaie_pfceqh
#define _aie_pfceqh_m __builtin_ingenicaie_pfceqh_mask
//extern aie_vbool16_t __builtin_ingenicaie_pfcneh_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_pfcneh __builtin_ingenicaie_pfcneh
#define _aie_pfcneh_m __builtin_ingenicaie_pfcneh_mask
//extern aie_vbool16_t __builtin_ingenicaie_pfcleh_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_pfcleh __builtin_ingenicaie_pfcleh
#define _aie_pfcleh_m __builtin_ingenicaie_pfcleh_mask
//extern aie_vbool16_t __builtin_ingenicaie_pfclth_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_pfclth __builtin_ingenicaie_pfclth
#define _aie_pfclth_m __builtin_ingenicaie_pfclth_mask
//extern aie_vbool16_t __builtin_ingenicaie_pfcorh_mask(mask, maskedoff, aie_vfloat16_t, aie_vfloat16_t);
#define _aie_pfcorh __builtin_ingenicaie_pfcorh
#define _aie_pfcorh_m __builtin_ingenicaie_pfcorh_mask

/*Floating Point Conversion */
//extern aie_vfloat32_t __builtin_ingenicaie_ffsiw_mask(mask, maskedoff, aie_vint32_t);
#define _aie_ffsiw __builtin_ingenicaie_ffsiw
#define _aie_ffsiw_m __builtin_ingenicaie_ffsiw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_ffuiw_mask(mask, maskedoff, aie_vuint32_t);
#define _aie_ffuiw __builtin_ingenicaie_ffuiw
#define _aie_ffuiw_m __builtin_ingenicaie_ffuiw_mask
//extern aie_vint32_t __builtin_ingenicaie_ftsiw_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie_ftsiw __builtin_ingenicaie_ftsiw
#define _aie_ftsiw_m __builtin_ingenicaie_ftsiw_mask
//extern aie_vuint32_t __builtin_ingenicaie_ftuiw_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie_ftuiw __builtin_ingenicaie_ftuiw
#define _aie_ftuiw_m __builtin_ingenicaie_ftuiw_mask
//extern aie_vint32_t __builtin_ingenicaie_frintw_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie_frintw __builtin_ingenicaie_frintw
#define _aie_frintw_m __builtin_ingenicaie_frintw_mask
//extern aie_vint32_t __builtin_ingenicaie_ftruncsw_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie_ftruncsw __builtin_ingenicaie_ftruncsw
#define _aie_ftruncsw_m __builtin_ingenicaie_ftruncsw_mask
//extern aie_vuint32_t __builtin_ingenicaie_ftruncuw_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie_ftruncuw __builtin_ingenicaie_ftruncuw
#define _aie_ftruncuw_m __builtin_ingenicaie_ftruncuw_mask

//extern aie_vfloat16_t __builtin_ingenicaie_ffsih_mask(mask, maskedoff, aie_vint16_t);
#define _aie_ffsih __builtin_ingenicaie_ffsih
#define _aie_ffsih_m __builtin_ingenicaie_ffsih_mask
//extern aie_vfloat16_t __builtin_ingenicaie_ffuih_mask(mask, maskedoff, aie_vuint16_t);
#define _aie_ffuih __builtin_ingenicaie_ffuih
#define _aie_ffuih_m __builtin_ingenicaie_ffuih_mask
//extern aie_vint16_t __builtin_ingenicaie_ftsih_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie_ftsih __builtin_ingenicaie_ftsih
#define _aie_ftsih_m __builtin_ingenicaie_ftsih_mask
//extern aie_vuint16_t __builtin_ingenicaie_ftuih_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie_ftuih __builtin_ingenicaie_ftuih
#define _aie_ftuih_m __builtin_ingenicaie_ftuih_mask
//extern aie_vint16_t __builtin_ingenicaie_frinth_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie_frinth __builtin_ingenicaie_frinth
#define _aie_frinth_m __builtin_ingenicaie_frinth_mask
//extern aie_vint16_t __builtin_ingenicaie_ftruncsh_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie_ftruncsh __builtin_ingenicaie_ftruncsh
#define _aie_ftruncsh_m __builtin_ingenicaie_ftruncsh_mask
//extern aie_vuint16_t __builtin_ingenicaie_ftruncuh_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie_ftruncuh __builtin_ingenicaie_ftruncuh
#define _aie_ftruncuh_m __builtin_ingenicaie_ftruncuh_mask

//extern aie_vfloat16_t __builtin_ingenicaie_fcvthw_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie_fcvthw __builtin_ingenicaie_fcvthw
#define _aie_fcvthw_m __builtin_ingenicaie_fcvthw_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fcvtwh_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie_fcvtwh __builtin_ingenicaie_fcvtwh
#define _aie_fcvtwh_m __builtin_ingenicaie_fcvtwh_mask

/* Shift */
//extern aie_vint8_t __builtin_ingenicaie_sllb_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_sllb __builtin_ingenicaie_sllb
#define _aie_sllb_m __builtin_ingenicaie_sllb_mask
//extern aie_vint16_t __builtin_ingenicaie_sllh_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_sllh __builtin_ingenicaie_sllh
#define _aie_sllh_m __builtin_ingenicaie_sllh_mask
//extern aie_vint32_t __builtin_ingenicaie_sllw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_sllw __builtin_ingenicaie_sllw
#define _aie_sllw_m __builtin_ingenicaie_sllw_mask

//extern aie_vint8_t __builtin_ingenicaie_sllib_mask(mask, maskedoff, aie_vint8_t, unsigned int);
#define _aie_sllib __builtin_ingenicaie_sllib
#define _aie_sllib_m __builtin_ingenicaie_sllib_mask
//extern aie_vint16_t __builtin_ingenicaie_sllih_mask(mask, maskedoff, aie_vint16_t, unsigned int);
#define _aie_sllih __builtin_ingenicaie_sllih
#define _aie_sllih_m __builtin_ingenicaie_sllih_mask
//extern aie_vint32_t __builtin_ingenicaie_slliw_mask(mask, maskedoff, aie_vint32_t, unsigned int);
#define _aie_slliw __builtin_ingenicaie_slliw
#define _aie_slliw_m __builtin_ingenicaie_slliw_mask

//extern aie_vint8_t __builtin_ingenicaie_srab_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_srab __builtin_ingenicaie_srab
#define _aie_srab_m __builtin_ingenicaie_srab_mask
//extern aie_vint16_t __builtin_ingenicaie_srah_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_srah __builtin_ingenicaie_srah
#define _aie_srah_m __builtin_ingenicaie_srah_mask
//extern aie_vint32_t __builtin_ingenicaie_sraw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_sraw __builtin_ingenicaie_sraw
#define _aie_sraw_m __builtin_ingenicaie_sraw_mask

//extern aie_vint8_t __builtin_ingenicaie_sraib_mask(mask, maskedoff, aie_vint8_t, unsigned int);
#define _aie_sraib __builtin_ingenicaie_sraib
#define _aie_sraib_m __builtin_ingenicaie_sraib_mask
//extern aie_vint16_t __builtin_ingenicaie_sraih_mask(mask, maskedoff, aie_vint16_t, unsigned int);
#define _aie_sraih __builtin_ingenicaie_sraih
#define _aie_sraih_m __builtin_ingenicaie_sraih_mask
//extern aie_vint32_t __builtin_ingenicaie_sraiw_mask(mask, maskedoff, aie_vint32_t, unsigned int);
#define _aie_sraiw __builtin_ingenicaie_sraiw
#define _aie_sraiw_m __builtin_ingenicaie_sraiw_mask

//extern aie_vint8_t __builtin_ingenicaie_srarb_mask(mask, maskedoff, aie_vint8_t, aie_vint8_t);
#define _aie_srarb __builtin_ingenicaie_srarb
#define _aie_srarb_m __builtin_ingenicaie_srarb_mask
//extern aie_vint16_t __builtin_ingenicaie_srarh_mask(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_srarh __builtin_ingenicaie_srarh
#define _aie_srarh_m __builtin_ingenicaie_srarh_mask
//extern aie_vint32_t __builtin_ingenicaie_srarw_mask(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_srarw __builtin_ingenicaie_srarw
#define _aie_srarw_m __builtin_ingenicaie_srarw_mask

//extern aie_vint8_t __builtin_ingenicaie_srarib_mask(mask, maskedoff, aie_vint8_t, unsigned int);
#define _aie_srarib __builtin_ingenicaie_srarib
#define _aie_srarib_m __builtin_ingenicaie_srarib_mask
//extern aie_vint16_t __builtin_ingenicaie_srarih_mask(mask, maskedoff, aie_vint16_t, unsigned int);
#define _aie_srarih __builtin_ingenicaie_srarih
#define _aie_srarih_m __builtin_ingenicaie_srarih_mask
//extern aie_vint32_t __builtin_ingenicaie_srariw_mask(mask, maskedoff, aie_vint32_t, unsigned int);
#define _aie_srariw __builtin_ingenicaie_srariw
#define _aie_srariw_m __builtin_ingenicaie_srariw_mask

//extern aie_vuint8_t __builtin_ingenicaie_srlb_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_srlb __builtin_ingenicaie_srlb
#define _aie_srlb_m __builtin_ingenicaie_srlb_mask
//extern aie_vuint16_t __builtin_ingenicaie_srlh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_srlh __builtin_ingenicaie_srlh
#define _aie_srlh_m __builtin_ingenicaie_srlh_mask
//extern aie_vuint32_t __builtin_ingenicaie_srlw_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_srlw __builtin_ingenicaie_srlw
#define _aie_srlw_m __builtin_ingenicaie_srlw_mask

//extern aie_vuint8_t __builtin_ingenicaie_srlib_mask(mask, maskedoff, aie_vuint8_t, unsigned int);
#define _aie_srlib __builtin_ingenicaie_srlib
#define _aie_srlib_m __builtin_ingenicaie_srlib_mask
//extern aie_vuint16_t __builtin_ingenicaie_srlih_mask(mask, maskedoff, aie_vuint16_t, unsigned int);
#define _aie_srlih __builtin_ingenicaie_srlih
#define _aie_srlih_m __builtin_ingenicaie_srlih_mask
//extern aie_vuint32_t __builtin_ingenicaie_srliw_mask(mask, maskedoff, aie_vuint32_t, unsigned int);
#define _aie_srliw __builtin_ingenicaie_srliw
#define _aie_srliw_m __builtin_ingenicaie_srliw_mask

//extern aie_vuint8_t __builtin_ingenicaie_srlrb_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_srlrb __builtin_ingenicaie_srlrb
#define _aie_srlrb_m __builtin_ingenicaie_srlrb_mask
//extern aie_vuint16_t __builtin_ingenicaie_srlrh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_srlrh __builtin_ingenicaie_srlrh
#define _aie_srlrh_m __builtin_ingenicaie_srlrh_mask
//extern aie_vuint32_t __builtin_ingenicaie_srlrw_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_srlrw __builtin_ingenicaie_srlrw
#define _aie_srlrw_m __builtin_ingenicaie_srlrw_mask

//extern aie_vuint8_t __builtin_ingenicaie_srlrib_mask(mask, maskedoff, aie_vuint8_t, unsigned int);
#define _aie_srlrib __builtin_ingenicaie_srlrib
#define _aie_srlrib_m __builtin_ingenicaie_srlrib_mask
//extern aie_vuint16_t __builtin_ingenicaie_srlrih_mask(mask, maskedoff, aie_vuint16_t, unsigned int);
#define _aie_srlrih __builtin_ingenicaie_srlrih
#define _aie_srlrih_m __builtin_ingenicaie_srlrih_mask
//extern aie_vuint32_t __builtin_ingenicaie_srlriw_mask(mask, maskedoff, aie_vuint32_t, unsigned int);
#define _aie_srlriw __builtin_ingenicaie_srlriw
#define _aie_srlriw_m __builtin_ingenicaie_srlriw_mask


/* Element Shuffle/Permute  */
//extern aie_vint8_t __builtin_ingenicaie_gt1bi_mask(mask, maskedoff, aie_vint8_t);
#define _aie_gt1bi __builtin_ingenicaie_gt1bi
#define _aie_gt1bi_m __builtin_ingenicaie_gt1bi_mask
//extern aie_vint8_t __builtin_ingenicaie_gt2bi_mask(mask, maskedoff, aie_vint8_t);
#define _aie_gt2bi __builtin_ingenicaie_gt2bi
#define _aie_gt2bi_m __builtin_ingenicaie_gt2bi_mask
//extern aie_vint8_t __builtin_ingenicaie_gt4bi_mask(mask, maskedoff, aie_vint8_t);
#define _aie_gt4bi __builtin_ingenicaie_gt4bi
#define _aie_gt4bi_m __builtin_ingenicaie_gt4bi_mask
//extern aie_vint8_t __builtin_ingenicaie_gtb_mask(mask, maskedoff, aie_vint8_t);
#define _aie_gtb __builtin_ingenicaie_gtb
#define _aie_gtb_m __builtin_ingenicaie_gtb_mask
//extern aie_vint8_t __builtin_ingenicaie_gth_mask(mask, maskedoff, aie_vint8_t);
#define _aie_gth __builtin_ingenicaie_gth
#define _aie_gth_m __builtin_ingenicaie_gth_mask

//extern aie_vint32_t __builtin_ingenicaie_gt2w_mask(mask, aie_vint32_t, unsigned int, aie_vint32_t, unsigned int);
#define _aie_gt2w __builtin_ingenicaie_gt2w
#define _aie_gt2w_m __builtin_ingenicaie_gt2w_mask

//extern aie_vuint64_t __builtin_ingenicaie_extuwll_mask(mask, aie_vuint64_t, aie_vuint32_t, unsigned int);
#define _aie_extuwll __builtin_ingenicaie_extuwll
#define _aie_extuwll_m __builtin_ingenicaie_extuwll_mask
//extern aie_vuint64_t __builtin_ingenicaie_extuwlh_mask(mask, aie_vuint64_t, aie_vuint32_t, unsigned int);
#define _aie_extuwlh __builtin_ingenicaie_extuwlh
#define _aie_extuwlh_m __builtin_ingenicaie_extuwlh_mask
//extern aie_vuint64_t __builtin_ingenicaie_extuwhl_mask(mask, aie_vuint64_t, aie_vuint32_t, unsigned int);
#define _aie_extuwhl __builtin_ingenicaie_extuwhl
#define _aie_extuwhl_m __builtin_ingenicaie_extuwhl_mask
//extern aie_vuint64_t __builtin_ingenicaie_extuwhh_mask(mask, aie_vuint64_t, aie_vuint32_t, unsigned int);
#define _aie_extuwhh __builtin_ingenicaie_extuwhh
#define _aie_extuwhh_m __builtin_ingenicaie_extuwhh_mask

//extern aie_vuint8_t __builtin_ingenicaie_extu1bil_mask(mask, maskedoff, aie_vuint8_t);
#define _aie_extu1bil __builtin_ingenicaie_extu1bil
#define _aie_extu1bil_m __builtin_ingenicaie_extu1bil_mask
//extern aie_vuint8_t __builtin_ingenicaie_extu2bil_mask(mask, maskedoff, aie_vuint8_t);
#define _aie_extu2bil __builtin_ingenicaie_extu2bil
#define _aie_extu2bil_m __builtin_ingenicaie_extu2bil_mask
//extern aie_vuint8_t __builtin_ingenicaie_extu4bil_mask(mask, maskedoff, aie_vuint8_t);
#define _aie_extu4bil __builtin_ingenicaie_extu4bil
#define _aie_extu4bil_m __builtin_ingenicaie_extu4bil_mask
//extern aie_vuint16_t __builtin_ingenicaie_extubl_mask(mask, maskedoff, aie_vuint8_t);
#define _aie_extubl __builtin_ingenicaie_extubl
#define _aie_extubl_m __builtin_ingenicaie_extubl_mask
//extern aie_vuint32_t __builtin_ingenicaie_extuhl_mask(mask, maskedoff, aie_vuint16_t);
#define _aie_extuhl __builtin_ingenicaie_extuhl
#define _aie_extuhl_m __builtin_ingenicaie_extuhl_mask

//extern aie_vuint8_t __builtin_ingenicaie_extu1bih_mask(mask, maskedoff, aie_vuint8_t);
#define _aie_extu1bih __builtin_ingenicaie_extu1bih
#define _aie_extu1bih_m __builtin_ingenicaie_extu1bih_mask
//extern aie_vuint8_t __builtin_ingenicaie_extu2bih_mask(mask, maskedoff, aie_vuint8_t);
#define _aie_extu2bih __builtin_ingenicaie_extu2bih
#define _aie_extu2bih_m __builtin_ingenicaie_extu2bih_mask
//extern aie_vuint8_t __builtin_ingenicaie_extu4bih_mask(mask, maskedoff, aie_vuint8_t);
#define _aie_extu4bih __builtin_ingenicaie_extu4bih
#define _aie_extu4bih_m __builtin_ingenicaie_extu4bih_mask
//extern aie_vuint16_t __builtin_ingenicaie_extubh_mask(mask, maskedoff, aie_vuint8_t);
#define _aie_extubh __builtin_ingenicaie_extubh
#define _aie_extubh_m __builtin_ingenicaie_extubh_mask
//extern aie_vuint32_t __builtin_ingenicaie_extuhh_mask(mask, maskedoff, aie_vuint16_t);
#define _aie_extuhh __builtin_ingenicaie_extuhh
#define _aie_extuhh_m __builtin_ingenicaie_extuhh_mask

//extern aie_vint8_t __builtin_ingenicaie_exts1bil_mask(mask, maskedoff, aie_vint8_t);
#define _aie_exts1bil __builtin_ingenicaie_exts1bil
#define _aie_exts1bil_m __builtin_ingenicaie_exts1bil_mask
//extern aie_vint8_t __builtin_ingenicaie_exts2bil_mask(mask, maskedoff, aie_vint8_t);
#define _aie_exts2bil __builtin_ingenicaie_exts2bil
#define _aie_exts2bil_m __builtin_ingenicaie_exts2bil_mask
//extern aie_vint8_t __builtin_ingenicaie_exts4bil_mask(mask, maskedoff, aie_vint8_t);
#define _aie_exts4bil __builtin_ingenicaie_exts4bil
#define _aie_exts4bil_m __builtin_ingenicaie_exts4bil_mask
//extern aie_vint16_t __builtin_ingenicaie_extsbl_mask(mask, maskedoff, aie_vint8_t);
#define _aie_extsbl __builtin_ingenicaie_extsbl
#define _aie_extsbl_m __builtin_ingenicaie_extsbl_mask
//extern aie_vint32_t __builtin_ingenicaie_extshl_mask(mask, maskedoff, aie_vint16_t);
#define _aie_extshl __builtin_ingenicaie_extshl
#define _aie_extshl_m __builtin_ingenicaie_extshl_mask

//extern aie_vint8_t __builtin_ingenicaie_exts1bih_mask(mask, maskedoff, aie_vint8_t);
#define _aie_exts1bih __builtin_ingenicaie_exts1bih
#define _aie_exts1bih_m __builtin_ingenicaie_exts1bih_mask
//extern aie_vint8_t __builtin_ingenicaie_exts2bih_mask(mask, maskedoff, aie_vint8_t);
#define _aie_exts2bih __builtin_ingenicaie_exts2bih
#define _aie_exts2bih_m __builtin_ingenicaie_exts2bih_mask
//extern aie_vint8_t __builtin_ingenicaie_exts4bih_mask(mask, maskedoff, aie_vint8_t);
#define _aie_exts4bih __builtin_ingenicaie_exts4bih
#define _aie_exts4bih_m __builtin_ingenicaie_exts4bih_mask
//extern aie_vint16_t __builtin_ingenicaie_extsbh_mask(mask, maskedoff, aie_vint8_t);
#define _aie_extsbh __builtin_ingenicaie_extsbh
#define _aie_extsbh_m __builtin_ingenicaie_extsbh_mask
//extern aie_vint32_t __builtin_ingenicaie_extshh_mask(mask, maskedoff, aie_vint16_t);
#define _aie_extshh __builtin_ingenicaie_extshh
#define _aie_extshh_m __builtin_ingenicaie_extshh_mask

//extern aie_vuint32_t __builtin_ingenicaie_extu3bw_mask(mask, maskedoff, aie_vuint8_t);
#define _aie_extu3bw __builtin_ingenicaie_extu3bw
#define _aie_extu3bw_m __builtin_ingenicaie_extu3bw_mask

//extern aie_vuint32_t __builtin_ingenicaie_gshufw_mask(mask, aie_vuint32_t, aie_vuint32_t, aie_vuint32_t, int);
#define _aie_gshufw __builtin_ingenicaie_gshufw
#define _aie_gshufw_m __builtin_ingenicaie_gshufw_mask
//extern aie_vuint8_t __builtin_ingenicaie_gshufwb_mask(mask, aie_vuint8_t, aie_vuint32_t, aie_vuint8_t, int);
#define _aie_gshufwb __builtin_ingenicaie_gshufwb
#define _aie_gshufwb_m __builtin_ingenicaie_gshufwb_mask
//extern aie_vuint8_t __builtin_ingenicaie_gshufwb_2_mask(mask, aie_vuint8_t, aie_vuint32_t, aie_vuint8_t, int);
#define _aie_gshufwb_2 __builtin_ingenicaie_gshufwb_2
#define _aie_gshufwb_2_m __builtin_ingenicaie_gshufwb_2_mask
//extern aie_vuint8_t __builtin_ingenicaie_gshufvb_mask(mask, aie_vuint8_t, aie_vuint8_t, aie_vuint8_t);
#define _aie_gshufvb __builtin_ingenicaie_gshufvb
#define _aie_gshufvb_m __builtin_ingenicaie_gshufvb_mask

//extern aie_vuint8_t __builtin_ingenicaie_ilve2bi_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_ilve2bi __builtin_ingenicaie_ilve2bi
#define _aie_ilve2bi_m __builtin_ingenicaie_ilve2bi_mask
//extern aie_vuint8_t __builtin_ingenicaie_ilve4bi_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_ilve4bi __builtin_ingenicaie_ilve4bi
#define _aie_ilve4bi_m __builtin_ingenicaie_ilve4bi_mask
//extern aie_vuint8_t __builtin_ingenicaie_ilveb_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_ilveb __builtin_ingenicaie_ilveb
#define _aie_ilveb_m __builtin_ingenicaie_ilveb_mask
//extern aie_vuint16_t __builtin_ingenicaie_ilveh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_ilveh __builtin_ingenicaie_ilveh
#define _aie_ilveh_m __builtin_ingenicaie_ilveh_mask
//extern aie_vuint32_t __builtin_ingenicaie_ilvew_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_ilvew __builtin_ingenicaie_ilvew
#define _aie_ilvew_m __builtin_ingenicaie_ilvew_mask
//extern aie_vuint64_t __builtin_ingenicaie_ilved_mask(mask, maskedoff, aie_vuint64_t, aie_vuint64_t);
#define _aie_ilved __builtin_ingenicaie_ilved
#define _aie_ilved_m __builtin_ingenicaie_ilved_mask

//extern aie_vuint8_t __builtin_ingenicaie_ilvo2bi_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_ilvo2bi __builtin_ingenicaie_ilvo2bi
#define _aie_ilvo2bi_m __builtin_ingenicaie_ilvo2bi_mask
//extern aie_vuint8_t __builtin_ingenicaie_ilvo4bi_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_ilvo4bi __builtin_ingenicaie_ilvo4bi
#define _aie_ilvo4bi_m __builtin_ingenicaie_ilvo4bi_mask
//extern aie_vuint8_t __builtin_ingenicaie_ilvob_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_ilvob __builtin_ingenicaie_ilvob
#define _aie_ilvob_m __builtin_ingenicaie_ilvob_mask
//extern aie_vuint16_t __builtin_ingenicaie_ilvoh_mask(mask, maskedoff, aie_vuint16_t, aie_vuint16_t);
#define _aie_ilvoh __builtin_ingenicaie_ilvoh
#define _aie_ilvoh_m __builtin_ingenicaie_ilvoh_mask
//extern aie_vuint32_t __builtin_ingenicaie_ilvow_mask(mask, maskedoff, aie_vuint32_t, aie_vuint32_t);
#define _aie_ilvow __builtin_ingenicaie_ilvow
#define _aie_ilvow_m __builtin_ingenicaie_ilvow_mask
//extern aie_vuint64_t __builtin_ingenicaie_ilvod_mask(mask, maskedoff, aie_vuint64_t, aie_vuint64_t);
#define _aie_ilvod __builtin_ingenicaie_ilvod
#define _aie_ilvod_m __builtin_ingenicaie_ilvod_mask

//extern aie_vuint8_t __builtin_ingenicaie_bshli_mask(mask, maskedoff, aie_vuint8_t, int);
#define _aie_bshli __builtin_ingenicaie_bshli
#define _aie_bshli_m __builtin_ingenicaie_bshli_mask
//extern aie_vuint8_t __builtin_ingenicaie_bshri_mask(mask, maskedoff, aie_vuint8_t, int);
#define _aie_bshri __builtin_ingenicaie_bshri
#define _aie_bshri_m __builtin_ingenicaie_bshri_mask
//extern aie_vuint8_t __builtin_ingenicaie_bshl_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_bshl __builtin_ingenicaie_bshl
#define _aie_bshl_m __builtin_ingenicaie_bshl_mask
//extern aie_vuint8_t __builtin_ingenicaie_bshr_mask(mask, maskedoff, aie_vuint8_t, aie_vuint8_t);
#define _aie_bshr __builtin_ingenicaie_bshr
#define _aie_bshr_m __builtin_ingenicaie_bshr_mask


/* Register Load and Misc.  */
//extern aie_vint16_t __builtin_ingenicaie_lih(int);
#define _aie_lih __builtin_ingenicaie_lih
//extern aie_vint32_t __builtin_ingenicaie_liw(int);
#define _aie_liw __builtin_ingenicaie_liw
//extern aie_vint16_t __builtin_ingenicaie_liwh(aie_vint16_t, int);
#define _aie_liwh __builtin_ingenicaie_liwh
//extern aie_vwr32_t __builtin_ingenicaie_liwr(int);
#define _aie_liwr __builtin_ingenicaie_liwr

//extern aie_vint8_t __builtin_ingenicaie_mfcpub_mask(mask, maskedoff, signed char);
#define _aie_mfcpub __builtin_ingenicaie_mfcpub
#define _aie_mfcpub_m __builtin_ingenicaie_mfcpub_mask

//extern aie_vint16_t __builtin_ingenicaie_mfcpuh_mask(mask, maskedoff, short);
#define _aie_mfcpuh __builtin_ingenicaie_mfcpuh
#define _aie_mfcpuh_m __builtin_ingenicaie_mfcpuh_mask

//extern aie_vint32_t __builtin_ingenicaie_mfcpuw_mask(mask, maskedoff, int);
#define _aie_mfcpuw __builtin_ingenicaie_mfcpuw
#define _aie_mfcpuw_m __builtin_ingenicaie_mfcpuw_mask

//extern aie_vint32_t __builtin_ingenicaie_sumz_mask(mask, maskedoff, int);
#define _aie_sumz __builtin_ingenicaie_sumz
#define _aie_sumz_m __builtin_ingenicaie_sumz_mask
/*Ignore: mfsum.  */
//extern aie_vint32_t __builtin_ingenicaie_mfsumz_mask(mask, maskedoff, aie_vint32_t *);
#define _aie_mfsumz __builtin_ingenicaie_mfsumz
#define _aie_mfsumz_m __builtin_ingenicaie_mfsumz_mask
/*Ignore: mtsum.  */
//extern aie_vint32_t __builtin_ingenicaie_mxsum(mask, maskedoff, aie_vint32_t, aie_vint32_t *);
#define _aie_mxsum __builtin_ingenicaie_mxsum
#define _aie_mxsum_m __builtin_ingenicaie_mxsum_mask

//extern aie_vint32_t __builtin_ingenicaie_cmvw(mask, aie_vint32_t, aie_vint32_t, aie_vint32_t, int);
#define _aie_cmvw __builtin_ingenicaie_cmvw
#define _aie_cmvw_m __builtin_ingenicaie_cmvw_mask
//extern aie_vint16_t __builtin_ingenicaie_pmaph(mask, maskedoff, aie_vint16_t, aie_vint16_t);
#define _aie_pmaph __builtin_ingenicaie_pmaph
#define _aie_pmaph_m __builtin_ingenicaie_pmaph_mask
//extern aie_vint32_t __builtin_ingenicaie_pmapw(mask, maskedoff, aie_vint32_t, aie_vint32_t);
#define _aie_pmapw __builtin_ingenicaie_pmapw
#define _aie_pmapw_m __builtin_ingenicaie_pmapw_mask


/* Load && Store.  */
//extern aie_vuint8_t __builtin_ingenicaie_lavb_mask(mask, maskedoff, aie_vint8_t *, int);
#define _aie_lavb __builtin_ingenicaie_lavb
#define _aie_lavb_m __builtin_ingenicaie_lavb_mask
//extern aie_vuint16_t __builtin_ingenicaie_lavh_mask(mask, maskedoff, aie_vint16_t *, int);
#define _aie_lavh __builtin_ingenicaie_lavh
#define _aie_lavh_m __builtin_ingenicaie_lavh_mask
//extern aie_vuint32_t __builtin_ingenicaie_lavw_mask(mask, maskedoff, aie_vint32_t *, int);
#define _aie_lavw __builtin_ingenicaie_lavw
#define _aie_lavw_m __builtin_ingenicaie_lavw_mask
//extern void __builtin_ingenicaie_savb_mask(mask, aie_vuint8_t, aie_vint8_t *, int);
#define _aie_savb __builtin_ingenicaie_savb
#define _aie_savb_m __builtin_ingenicaie_savb_mask
//extern void __builtin_ingenicaie_savh_mask(mask, aie_vuint16_t, aie_vint16_t *, int);
#define _aie_savh __builtin_ingenicaie_savh
#define _aie_savh_m __builtin_ingenicaie_savh_mask
//extern void __builtin_ingenicaie_savw_mask(mask, aie_vuint32_t, aie_vint32_t *, int);
#define _aie_savw __builtin_ingenicaie_savw
#define _aie_savw_m __builtin_ingenicaie_savw_mask

/* Load && Store update.  */
#define _aie_luvb(base) __extension__ ({ \
		aie_vuint8_t tmp = __builtin_ingenicaie_lavb(base, 0); \
		base = _aie_addr_upd(base); \
		tmp; })
#define _aie_luvb_m(ppr, maskoff, base) __extension__ ({ \
		aie_vuint8_t tmp = __builtin_ingenicaie_lavb_mask(ppr, maskoff, base, 0); \
		base = _aie_addr_upd(base); \
		tmp; })
#define _aie_luvh(base) __extension__ ({ \
		aie_vuint16_t tmp = __builtin_ingenicaie_lavh(base, 0); \
		base = _aie_addr_upd(base); \
		tmp; })
#define _aie_luvh_m(ppr, maskoff, base) __extension__ ({ \
		aie_vuint16_t tmp = __builtin_ingenicaie_lavh_mask(ppr, maskoff, base, 0); \
		base = _aie_addr_upd(base); \
		tmp; })
#define _aie_luvw(base) __extension__ ({ \
		aie_vuint32_t tmp = __builtin_ingenicaie_lavw(base, 0); \
		base = _aie_addr_upd(base); \
		tmp; })
#define _aie_luvw_m(ppr, maskoff, base) __extension__ ({ \
		aie_vuint32_t tmp = __builtin_ingenicaie_lavw_mask(ppr, maskoff, base, 0); \
		base = _aie_addr_upd(base); \
		tmp; })

#define _aie_suvb(vrp, base) __extension__ ({ \
		__builtin_ingenicaie_savb(vrp, base, 0); \
		base = _aie_addr_upd(base); \
		(void)0;})
#define _aie_suvb_m(ppr, vrp, base) __extension__ ({ \
		__builtin_ingenicaie_savb_mask(ppr, vrp, base, 0); \
		base = _aie_addr_upd(base); \
		(void)0;})
#define _aie_suvh(vrp, base) __extension__ ({ \
		__builtin_ingenicaie_savh(vrp, base, 0); \
		base = _aie_addr_upd(base); \
		(void)0;})
#define _aie_suvh_m(ppr, vrp, base) __extension__ ({ \
		__builtin_ingenicaie_savh_mask(ppr, vrp, base, 0); \
		base = _aie_addr_upd(base); \
		(void)0;})
#define _aie_suvw(vrp, base) __extension__ ({ \
		__builtin_ingenicaie_savw(vrp, base, 0); \
		base = _aie_addr_upd(base); \
		(void)0;})
#define _aie_suvw_m(ppr, vrp, base) __extension__ ({ \
		__builtin_ingenicaie_savw_mask(ppr, vrp, base, 0); \
		base = _aie_addr_upd(base); \
		(void)0;})


#define _aie_luw_internal(vrp, n, base) __extension__ ({ \
		aie_vuint32_t tmp = __builtin_ingenicaie_law(vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 4); \
		tmp; })
#define _aie_luw_m_internal(ppr, vrp, n, base) __extension__ ({ \
		aie_vuint32_t tmp = __builtin_ingenicaie_law_mask(ppr, vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 4); \
		tmp; })
#define _aie_lud_internal(vrp, n, base) __extension__ ({ \
		aie_vuint64_t tmp = __builtin_ingenicaie_lad(vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 8); \
		tmp; })
#define _aie_lud_m_internal(ppr, vrp, n, base) __extension__ ({ \
		aie_vuint64_t tmp = __builtin_ingenicaie_lad_mask(ppr, vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 8); \
		tmp; })
#define _aie_luq_internal(vrp, n, base) __extension__ ({ \
		aie_vuint128_t tmp = __builtin_ingenicaie_laq(vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 16); \
		tmp; })
#define _aie_luq_m_internal(ppr, vrp, n, base) __extension__ ({ \
		aie_vuint128_t tmp = __builtin_ingenicaie_laq_mask(ppr, vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 16); \
		tmp; })
#define _aie_luo_internal(vrp, n, base) __extension__ ({ \
		aie_vuint256_t tmp = __builtin_ingenicaie_lao(vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 32); \
		tmp; })
#define _aie_luo_m_internal(ppr, vrp, n, base) __extension__ ({ \
		aie_vuint256_t tmp = __builtin_ingenicaie_lao_mask(ppr, vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 32); \
		tmp; })

#define _aie_suw_internal(vrp, n, base) __extension__ ({ \
		__builtin_ingenicaie_saw(vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 4); \
		(void)0;})
#define _aie_suw_m_internal(ppr, vrp, n, base) __extension__ ({ \
		__builtin_ingenicaie_saw_mask(ppr, vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 4); \
		(void)0;})
#define _aie_sud_internal(vrp, n, base) __extension__ ({ \
		__builtin_ingenicaie_sad(vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 8); \
		(void)0;})
#define _aie_sud_m_internal(ppr, vrp, n, base) __extension__ ({ \
		__builtin_ingenicaie_sad_mask(ppr, vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 8); \
		(void)0;})
#define _aie_suq_internal(vrp, n, base) __extension__ ({ \
		__builtin_ingenicaie_saq(vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 16); \
		(void)0;})
#define _aie_suq_m_internal(ppr, vrp, n, base) __extension__ ({ \
		__builtin_ingenicaie_saq_mask(ppr, vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 16); \
		(void)0;})
#define _aie_suo_internal(vrp, n, base) __extension__ ({ \
		__builtin_ingenicaie_sao(vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 32); \
		(void)0;})
#define _aie_suo_m_internal(ppr, vrp, n, base) __extension__ ({ \
		__builtin_ingenicaie_sao_mask(ppr, vrp, n, base, 0); \
		base = _aie_addr_upd_offset(base, 32); \
		(void)0;})


#define ARGS_LIST  vrp, n, p, base
#define ARGS_M_LIST  ppr, vrp, n, p, base
#define LOAD_UPDATE(TYPE, FMT, vrp, n, p, base, size) __extension__ ({ \
		TYPE tmp = __builtin_ingenicaie_la##FMT(vrp, n, p, base); \
		base = _aie_addr_upd_offset(base, size); \
		tmp; })

#define LOAD_MASK_UPDATE(TYPE, FMT, ppr, vrp, n, p, base, size) __extension__ ({ \
		TYPE tmp = __builtin_ingenicaie_la##FMT##_mask(ppr, vrp, n, p, base); \
		base = _aie_addr_upd_offset(base, size); \
		tmp; })

#define _aie_luw2b_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint32_t, w2b, vrp, n, p, base, 4)
#define _aie_luw2h_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint32_t, w2h, vrp, n, p, base, 4)
#define _aie_luw4b_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint32_t, w4b, vrp, n, p, base, 4)
#define _aie_luw4h_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint32_t, w4h, vrp, n, p, base, 4)
#define _aie_luw8b_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint32_t, w8b, vrp, n, p, base, 4)
#define _aie_luw8h_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint32_t, w8h, vrp, n, p, base, 4)
#define _aie_luw16b_internal(vrp, n, p, base)  LOAD_UPDATE(aie_vuint32_t, w16b, vrp, n, p, base, 4)
#define _aie_luw16h_internal(vrp, n, p, base)  LOAD_UPDATE(aie_vuint32_t, w16h, vrp, n, p, base, 4)
#define _aie_luw2b_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint32_t, w2b, ppr, vrp, n, p, base, 4)
#define _aie_luw2h_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint32_t, w2h, ppr, vrp, n, p, base, 4)
#define _aie_luw4b_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint32_t, w4b, ppr, vrp, n, p, base, 4)
#define _aie_luw4h_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint32_t, w4h, ppr, vrp, n, p, base, 4)
#define _aie_luw8b_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint32_t, w8b, ppr, vrp, n, p, base, 4)
#define _aie_luw8h_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint32_t, w8h, ppr, vrp, n, p, base, 4)
#define _aie_luw16b_m_internal(ppr, vrp, n, p, base) LOAD_MASK_UPDATE(aie_vuint32_t, w16b, ppr, vrp, n, p, base, 4)
#define _aie_luw16h_m_internal(ppr, vrp, n, p, base) LOAD_MASK_UPDATE(aie_vuint32_t, w16h, ppr, vrp, n, p, base, 4)

#define _aie_lud2b_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint64_t, d2b, vrp, n, p, base, 8)
#define _aie_lud2h_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint64_t, d2h, vrp, n, p, base, 8)
#define _aie_lud2w_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint64_t, d2w, vrp, n, p, base, 8)
#define _aie_lud4b_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint64_t, d4b, vrp, n, p, base, 8)
#define _aie_lud4h_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint64_t, d4h, vrp, n, p, base, 8)
#define _aie_lud4w_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint64_t, d4w, vrp, n, p, base, 8)
#define _aie_lud8b_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint64_t, d8b, vrp, n, p, base, 8)
#define _aie_lud8h_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint64_t, d8h, vrp, n, p, base, 8)
#define _aie_lud8w_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint64_t, d8w, vrp, n, p, base, 8)
#define _aie_lud2b_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint64_t, d2b, ppr, vrp, n, p, base, 8)
#define _aie_lud2h_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint64_t, d2h, ppr, vrp, n, p, base, 8)
#define _aie_lud2w_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint64_t, d2w, ppr, vrp, n, p, base, 8)
#define _aie_lud4b_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint64_t, d4b, ppr, vrp, n, p, base, 8)
#define _aie_lud4h_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint64_t, d4h, ppr, vrp, n, p, base, 8)
#define _aie_lud4w_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint64_t, d4w, ppr, vrp, n, p, base, 8)
#define _aie_lud8b_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint64_t, d8b, ppr, vrp, n, p, base, 8)
#define _aie_lud8h_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint64_t, d8h, ppr, vrp, n, p, base, 8)
#define _aie_lud8w_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint64_t, d8w, ppr, vrp, n, p, base, 8)

#define _aie_luq2b_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint128_t, q2b, vrp, n, p, base, 16)
#define _aie_luq2h_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint128_t, q2h, vrp, n, p, base, 16)
#define _aie_luq2w_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint128_t, q2w, vrp, n, p, base, 16)
#define _aie_luq2d_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint128_t, q2d, vrp, n, p, base, 16)
#define _aie_luq4b_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint128_t, q4b, vrp, n, p, base, 16)
#define _aie_luq4h_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint128_t, q4h, vrp, n, p, base, 16)
#define _aie_luq4w_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint128_t, q4w, vrp, n, p, base, 16)
#define _aie_luq4d_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint128_t, q4d, vrp, n, p, base, 16)
#define _aie_luq2b_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint128_t, q2b, ppr, vrp, n, p, base, 16)
#define _aie_luq2h_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint128_t, q2h, ppr, vrp, n, p, base, 16)
#define _aie_luq2w_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint128_t, q2w, ppr, vrp, n, p, base, 16)
#define _aie_luq2d_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint128_t, q2d, ppr, vrp, n, p, base, 16)
#define _aie_luq4b_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint128_t, q4b, ppr, vrp, n, p, base, 16)
#define _aie_luq4h_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint128_t, q4h, ppr, vrp, n, p, base, 16)
#define _aie_luq4w_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint128_t, q4w, ppr, vrp, n, p, base, 16)
#define _aie_luq4d_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint128_t, q4d, ppr, vrp, n, p, base, 16)

#define _aie_luo2b_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint256_t, o2b, vrp, n, p, base, 32)
#define _aie_luo2h_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint256_t, o2h, vrp, n, p, base, 32)
#define _aie_luo2w_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint256_t, o2w, vrp, n, p, base, 32)
#define _aie_luo2d_internal(vrp, n, p, base)   LOAD_UPDATE(aie_vuint256_t, o2d, vrp, n, p, base, 32)
#define _aie_luo2b_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint256_t, o2b, ppr, vrp, n, p, base, 32)
#define _aie_luo2h_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint256_t, o2h, ppr, vrp, n, p, base, 32)
#define _aie_luo2w_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint256_t, o2w, ppr, vrp, n, p, base, 32)
#define _aie_luo2d_m_internal(ppr, vrp, n, p, base)  LOAD_MASK_UPDATE(aie_vuint256_t, o2d, ppr, vrp, n, p, base, 32)


#define STORE_UPDATE(FMT, vrp, n, p, base, size) __extension__ ({ \
		__builtin_ingenicaie_sa##FMT(vrp, n, p, base); \
		base = _aie_addr_upd_offset(base, size); \
		(void)0;})

#define STORE_MASK_UPDATE(FMT, ppr, vrp, n, p, base, size) __extension__ ({ \
		__builtin_ingenicaie_sa##FMT##_mask(ppr, vrp, n, p, base); \
		base = _aie_addr_upd_offset(base, size); \
		(void)0;})

#define _aie_sud2w_internal(vrp, n, p, base)   STORE_UPDATE(d2w, vrp, n, p, base, 8)
#define _aie_sud4w_internal(vrp, n, p, base)   STORE_UPDATE(d4w, vrp, n, p, base, 8)
#define _aie_sud8w_internal(vrp, n, p, base)   STORE_UPDATE(d8w, vrp, n, p, base, 8)
#define _aie_sud2w_m_internal(ppr, vrp, n, p, base)  STORE_MASK_UPDATE(d2w, ppr, vrp, n, p, base, 8)
#define _aie_sud4w_m_internal(ppr, vrp, n, p, base)  STORE_MASK_UPDATE(d4w, ppr, vrp, n, p, base, 8)
#define _aie_sud8w_m_internal(ppr, vrp, n, p, base)  STORE_MASK_UPDATE(d8w, ppr, vrp, n, p, base, 8)

#define _aie_suq2w_internal(vrp, n, p, base)   STORE_UPDATE(q2w, vrp, n, p, base, 16)
#define _aie_suq2d_internal(vrp, n, p, base)   STORE_UPDATE(q2d, vrp, n, p, base, 16)
#define _aie_suq4w_internal(vrp, n, p, base)   STORE_UPDATE(q4w, vrp, n, p, base, 16)
#define _aie_suq4d_internal(vrp, n, p, base)   STORE_UPDATE(q4d, vrp, n, p, base, 16)
#define _aie_suq2w_m_internal(ppr, vrp, n, p, base)  STORE_MASK_UPDATE(q2w, ppr, vrp, n, p, base, 16)
#define _aie_suq2d_m_internal(ppr, vrp, n, p, base)  STORE_MASK_UPDATE(q2d, ppr, vrp, n, p, base, 16)
#define _aie_suq4w_m_internal(ppr, vrp, n, p, base)  STORE_MASK_UPDATE(q4w, ppr, vrp, n, p, base, 16)
#define _aie_suq4d_m_internal(ppr, vrp, n, p, base)  STORE_MASK_UPDATE(q4d, ppr, vrp, n, p, base, 16)

#define _aie_suo2w_internal(vrp, n, p, base)   STORE_UPDATE(o2w, vrp, n, p, base, 32)
#define _aie_suo2d_internal(vrp, n, p, base)   STORE_UPDATE(o2d, vrp, n, p, base, 32)
#define _aie_suo2q_internal(vrp, n, p, base)   STORE_UPDATE(o2q, vrp, n, p, base, 32)
#define _aie_suo2w_m_internal(ppr, vrp, n, p, base)  STORE_MASK_UPDATE(o2w, ppr, vrp, n, p, base, 32)
#define _aie_suo2d_m_internal(ppr, vrp, n, p, base)  STORE_MASK_UPDATE(o2d, ppr, vrp, n, p, base, 32)
#define _aie_suo2q_m_internal(ppr, vrp, n, p, base)  STORE_MASK_UPDATE(o2q, ppr, vrp, n, p, base, 32)

#undef ARGS_LIST
#undef ARGS_M_LIST

/* LUTW/LUTR.  */
//extern void __builtin_ingenicaie_lutw(aie_vint8_t, int);
#define _aie_lutw __builtin_ingenicaie_lutw
//extern void __builtin_ingenicaie_lutr(aie_vint8_t, int);
#define _aie_lutr __builtin_ingenicaie_lutr


/* Neural Networks Accelerate.  */
//extern void __builtin_ingenicaie_nnrwr(aie_vwr32_t,  int);
#define _aie_nnrwr __builtin_ingenicaie_nnrwr
//extern aie_vint32_t __builtin_ingenicaie_nnrrd(int);
#define _aie_nnrrd __builtin_ingenicaie_nnrrd
//extern void __builtin_ingenicaie_nndwr(aie_vint32_t,  int);
#define _aie_nndwr __builtin_ingenicaie_nndwr
//extern aie_vint32_t __builtin_ingenicaie_nndrd(int);
#define _aie_nndrd __builtin_ingenicaie_nndrd
//extern void __builtin_ingenicaie_nncmd(int);
#define _aie_nncmd __builtin_ingenicaie_nncmd
//extern void __builtin_ingenicaie_nnmac(aie_vwr32_t,  int);
#define _aie_nnmac __builtin_ingenicaie_nnmac


#if (__AIE_VECTOR_BITS == 512)
/* AIE512 special built-in function.  */

/* Integer Arithmetic */
//extern aie_vuint32_t __builtin_ingenicaie_sr1sum2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr1sum2bi __builtin_ingenicaie_sr1sum2bi
#define _aie512_sr1sum2bi_m __builtin_ingenicaie_sr1sum2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2sum2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr2sum2bi __builtin_ingenicaie_sr2sum2bi
#define _aie512_sr2sum2bi_m __builtin_ingenicaie_sr2sum2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4sum2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr4sum2bi __builtin_ingenicaie_sr4sum2bi
#define _aie512_sr4sum2bi_m __builtin_ingenicaie_sr4sum2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8sum2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr8sum2bi __builtin_ingenicaie_sr8sum2bi
#define _aie512_sr8sum2bi_m __builtin_ingenicaie_sr8sum2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr16sum2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr16sum2bi __builtin_ingenicaie_sr16sum2bi
#define _aie512_sr16sum2bi_m __builtin_ingenicaie_sr16sum2bi_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1sum4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr1sum4bi __builtin_ingenicaie_sr1sum4bi
#define _aie512_sr1sum4bi_m __builtin_ingenicaie_sr1sum4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2sum4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr2sum4bi __builtin_ingenicaie_sr2sum4bi
#define _aie512_sr2sum4bi_m __builtin_ingenicaie_sr2sum4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4sum4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr4sum4bi __builtin_ingenicaie_sr4sum4bi
#define _aie512_sr4sum4bi_m __builtin_ingenicaie_sr4sum4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8sum4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr8sum4bi __builtin_ingenicaie_sr8sum4bi
#define _aie512_sr8sum4bi_m __builtin_ingenicaie_sr8sum4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr16sum4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr16sum4bi __builtin_ingenicaie_sr16sum4bi
#define _aie512_sr16sum4bi_m __builtin_ingenicaie_sr16sum4bi_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1sumub_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr1sumub __builtin_ingenicaie_sr1sumub
#define _aie512_sr1sumub_m __builtin_ingenicaie_sr1sumub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2sumub_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr2sumub __builtin_ingenicaie_sr2sumub
#define _aie512_sr2sumub_m __builtin_ingenicaie_sr2sumub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4sumub_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr4sumub __builtin_ingenicaie_sr4sumub
#define _aie512_sr4sumub_m __builtin_ingenicaie_sr4sumub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8sumub_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr8sumub __builtin_ingenicaie_sr8sumub
#define _aie512_sr8sumub_m __builtin_ingenicaie_sr8sumub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr16sumub_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie512_sr16sumub __builtin_ingenicaie_sr16sumub
#define _aie512_sr16sumub_m __builtin_ingenicaie_sr16sumub_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1sumuh_mask(mask, aie_vuint32_t, int, aie_vuint16_t);
#define _aie512_sr1sumuh __builtin_ingenicaie_sr1sumuh
#define _aie512_sr1sumuh_m __builtin_ingenicaie_sr1sumuh_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2sumuh_mask(mask, aie_vuint32_t, int, aie_vuint16_t);
#define _aie512_sr2sumuh __builtin_ingenicaie_sr2sumuh
#define _aie512_sr2sumuh_m __builtin_ingenicaie_sr2sumuh_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4sumuh_mask(mask, aie_vuint32_t, int, aie_vuint16_t);
#define _aie512_sr4sumuh __builtin_ingenicaie_sr4sumuh
#define _aie512_sr4sumuh_m __builtin_ingenicaie_sr4sumuh_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8sumuh_mask(mask, aie_vuint32_t, int, aie_vuint16_t);
#define _aie512_sr8sumuh __builtin_ingenicaie_sr8sumuh
#define _aie512_sr8sumuh_m __builtin_ingenicaie_sr8sumuh_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr16sumuh_mask(mask, aie_vuint32_t, int, aie_vuint16_t);
#define _aie512_sr16sumuh __builtin_ingenicaie_sr16sumuh
#define _aie512_sr16sumuh_m __builtin_ingenicaie_sr16sumuh_mask

//extern aie_vint32_t  __builtin_ingenicaie_sr1sumsb_mask(mask, aie_vint32_t, int, aie_vint8_t);
#define _aie512_sr1sumsb __builtin_ingenicaie_sr1sumsb
#define  _aie512_sr1sumsb_m __builtin_ingenicaie_sr1sumsb_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr2sumsb_mask(mask, aie_vint32_t, int, aie_vint8_t);
#define _aie512_sr2sumsb __builtin_ingenicaie_sr2sumsb
#define  _aie512_sr2sumsb_m __builtin_ingenicaie_sr2sumsb_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr4sumsb_mask(mask, aie_vint32_t, int, aie_vint8_t);
#define _aie512_sr4sumsb __builtin_ingenicaie_sr4sumsb
#define  _aie512_sr4sumsb_m __builtin_ingenicaie_sr4sumsb_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr8sumsb_mask(mask, aie_vint32_t, int, aie_vint8_t);
#define _aie512_sr8sumsb __builtin_ingenicaie_sr8sumsb
#define  _aie512_sr8sumsb_m __builtin_ingenicaie_sr8sumsb_mask
//extern aie_vint32_t __builtin_ingenicaie_sr16sumsb_mask(mask, aie_vint32_t, int, aie_vint8_t);
#define _aie512_sr16sumsb __builtin_ingenicaie_sr16sumsb
#define _aie512_sr16sumsb_m __builtin_ingenicaie_sr16sumsb_mask

//extern aie_vint32_t  __builtin_ingenicaie_sr1sumsh_mask(mask, aie_vint32_t, int, aie_vint16_t);
#define _aie512_sr1sumsh __builtin_ingenicaie_sr1sumsh
#define  _aie512_sr1sumsh_m __builtin_ingenicaie_sr1sumsh_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr2sumsh_mask(mask, aie_vint32_t, int, aie_vint16_t);
#define _aie512_sr2sumsh __builtin_ingenicaie_sr2sumsh
#define  _aie512_sr2sumsh_m __builtin_ingenicaie_sr2sumsh_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr4sumsh_mask(mask, aie_vint32_t, int, aie_vint16_t);
#define _aie512_sr4sumsh __builtin_ingenicaie_sr4sumsh
#define  _aie512_sr4sumsh_m __builtin_ingenicaie_sr4sumsh_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr8sumsh_mask(mask, aie_vint32_t, int, aie_vint16_t);
#define _aie512_sr8sumsh __builtin_ingenicaie_sr8sumsh
#define  _aie512_sr8sumsh_m __builtin_ingenicaie_sr8sumsh_mask
//extern aie_vint32_t __builtin_ingenicaie_sr16sumsh_mask(mask, aie_vint32_t, int, aie_vint16_t);
#define _aie512_sr16sumsh __builtin_ingenicaie_sr16sumsh
#define _aie512_sr16sumsh_m __builtin_ingenicaie_sr16sumsh_mask

//extern aie_vint32_t  __builtin_ingenicaie_sr1sumw_mask(mask, aie_vint32_t, int, aie_vint32_t);
#define _aie512_sr1sumw __builtin_ingenicaie_sr1sumw
#define  _aie512_sr1sumw_m __builtin_ingenicaie_sr1sumw_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr2sumw_mask(mask, aie_vint32_t, int, aie_vint32_t);
#define _aie512_sr2sumw __builtin_ingenicaie_sr2sumw
#define  _aie512_sr2sumw_m __builtin_ingenicaie_sr2sumw_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr4sumw_mask(mask, aie_vint32_t, int, aie_vint32_t);
#define _aie512_sr4sumw __builtin_ingenicaie_sr4sumw
#define  _aie512_sr4sumw_m __builtin_ingenicaie_sr4sumw_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr8sumw_mask(mask, aie_vint32_t, int, aie_vint32_t);
#define _aie512_sr8sumw __builtin_ingenicaie_sr8sumw
#define  _aie512_sr8sumw_m __builtin_ingenicaie_sr8sumw_mask
//extern aie_vint32_t __builtin_ingenicaie_sr16sumw_mask(mask, aie_vint32_t, int, aie_vint32_t);
#define _aie512_sr16sumw __builtin_ingenicaie_sr16sumw
#define _aie512_sr16sumw_m __builtin_ingenicaie_sr16sumw_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1mac2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr1mac2bi __builtin_ingenicaie_sr1mac2bi
#define _aie512_sr1mac2bi_m __builtin_ingenicaie_sr1mac2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2mac2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr2mac2bi __builtin_ingenicaie_sr2mac2bi
#define _aie512_sr2mac2bi_m __builtin_ingenicaie_sr2mac2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4mac2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr4mac2bi __builtin_ingenicaie_sr4mac2bi
#define _aie512_sr4mac2bi_m __builtin_ingenicaie_sr4mac2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8mac2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr8mac2bi __builtin_ingenicaie_sr8mac2bi
#define _aie512_sr8mac2bi_m __builtin_ingenicaie_sr8mac2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr16mac2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr16mac2bi __builtin_ingenicaie_sr16mac2bi
#define _aie512_sr16mac2bi_m __builtin_ingenicaie_sr16mac2bi_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1mac4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr1mac4bi __builtin_ingenicaie_sr1mac4bi
#define _aie512_sr1mac4bi_m __builtin_ingenicaie_sr1mac4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2mac4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr2mac4bi __builtin_ingenicaie_sr2mac4bi
#define _aie512_sr2mac4bi_m __builtin_ingenicaie_sr2mac4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4mac4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr4mac4bi __builtin_ingenicaie_sr4mac4bi
#define _aie512_sr4mac4bi_m __builtin_ingenicaie_sr4mac4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8mac4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr8mac4bi __builtin_ingenicaie_sr8mac4bi
#define _aie512_sr8mac4bi_m __builtin_ingenicaie_sr8mac4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr16mac4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr16mac4bi __builtin_ingenicaie_sr16mac4bi
#define _aie512_sr16mac4bi_m __builtin_ingenicaie_sr16mac4bi_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr1macuub __builtin_ingenicaie_sr1macuub
#define _aie512_sr1macuub_m __builtin_ingenicaie_sr1macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr2macuub __builtin_ingenicaie_sr2macuub
#define _aie512_sr2macuub_m __builtin_ingenicaie_sr2macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr4macuub __builtin_ingenicaie_sr4macuub
#define _aie512_sr4macuub_m __builtin_ingenicaie_sr4macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr8macuub __builtin_ingenicaie_sr8macuub
#define _aie512_sr8macuub_m __builtin_ingenicaie_sr8macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr16macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie512_sr16macuub __builtin_ingenicaie_sr16macuub
#define _aie512_sr16macuub_m __builtin_ingenicaie_sr16macuub_mask

//extern aie_vint32_t __builtin_ingenicaie_sr1macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t, int);
#define _aie512_sr1macsub __builtin_ingenicaie_sr1macsub
#define _aie512_sr1macsub_m __builtin_ingenicaie_sr1macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_sr2macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t, int);
#define _aie512_sr2macsub __builtin_ingenicaie_sr2macsub
#define _aie512_sr2macsub_m __builtin_ingenicaie_sr2macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_sr4macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t, int);
#define _aie512_sr4macsub __builtin_ingenicaie_sr4macsub
#define _aie512_sr4macsub_m __builtin_ingenicaie_sr4macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_sr8macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t, int);
#define _aie512_sr8macsub __builtin_ingenicaie_sr8macsub
#define _aie512_sr8macsub_m __builtin_ingenicaie_sr8macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_sr16macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t, int);
#define _aie512_sr16macsub __builtin_ingenicaie_sr16macsub
#define _aie512_sr16macsub_m __builtin_ingenicaie_sr16macsub_mask

//extern aie_vint32_t __builtin_ingenicaie_sr1macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t, int);
#define _aie512_sr1macssb __builtin_ingenicaie_sr1macssb
#define _aie512_sr1macssb_m __builtin_ingenicaie_sr1macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_sr2macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t, int);
#define _aie512_sr2macssb __builtin_ingenicaie_sr2macssb
#define _aie512_sr2macssb_m __builtin_ingenicaie_sr2macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_sr4macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t, int);
#define _aie512_sr4macssb __builtin_ingenicaie_sr4macssb
#define _aie512_sr4macssb_m __builtin_ingenicaie_sr4macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_sr8macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t, int);
#define _aie512_sr8macssb __builtin_ingenicaie_sr8macssb
#define _aie512_sr8macssb_m __builtin_ingenicaie_sr8macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_sr16macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t, int);
#define _aie512_sr16macssb __builtin_ingenicaie_sr16macssb
#define _aie512_sr16macssb_m __builtin_ingenicaie_sr16macssb_mask

//extern aie_vint32_t __builtin_ingenicaie_sr1macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t, int);
#define _aie512_sr1macssh __builtin_ingenicaie_sr1macssh
#define _aie512_sr1macssh_m __builtin_ingenicaie_sr1macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_sr2macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t, int);
#define _aie512_sr2macssh __builtin_ingenicaie_sr2macssh
#define _aie512_sr2macssh_m __builtin_ingenicaie_sr2macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_sr4macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t, int);
#define _aie512_sr4macssh __builtin_ingenicaie_sr4macssh
#define _aie512_sr4macssh_m __builtin_ingenicaie_sr4macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_sr8macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t, int);
#define _aie512_sr8macssh __builtin_ingenicaie_sr8macssh
#define _aie512_sr8macssh_m __builtin_ingenicaie_sr8macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_sr16macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t, int);
#define _aie512_sr16macssh __builtin_ingenicaie_sr16macssh
#define _aie512_sr16macssh_m __builtin_ingenicaie_sr16macssh_mask

//extern aie_vuint32_t __builtin_ingenicaie_s1macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t);
#define _aie512_s1macuub __builtin_ingenicaie_s1macuub
#define _aie512_s1macuub_m __builtin_ingenicaie_s1macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_s2macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t);
#define _aie512_s2macuub __builtin_ingenicaie_s2macuub
#define _aie512_s2macuub_m __builtin_ingenicaie_s2macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_s4macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t);
#define _aie512_s4macuub __builtin_ingenicaie_s4macuub
#define _aie512_s4macuub_m __builtin_ingenicaie_s4macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_s8macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t);
#define _aie512_s8macuub __builtin_ingenicaie_s8macuub
#define _aie512_s8macuub_m __builtin_ingenicaie_s8macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_s16macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t);
#define _aie512_s16macuub __builtin_ingenicaie_s16macuub
#define _aie512_s16macuub_m __builtin_ingenicaie_s16macuub_mask

//extern aie_vint32_t __builtin_ingenicaie_s1macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t);
#define _aie512_s1macsub __builtin_ingenicaie_s1macsub
#define _aie512_s1macsub_m __builtin_ingenicaie_s1macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_s2macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t);
#define _aie512_s2macsub __builtin_ingenicaie_s2macsub
#define _aie512_s2macsub_m __builtin_ingenicaie_s2macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_s4macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t);
#define _aie512_s4macsub __builtin_ingenicaie_s4macsub
#define _aie512_s4macsub_m __builtin_ingenicaie_s4macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_s8macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t);
#define _aie512_s8macsub __builtin_ingenicaie_s8macsub
#define _aie512_s8macsub_m __builtin_ingenicaie_s8macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_s16macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t);
#define _aie512_s16macsub __builtin_ingenicaie_s16macsub
#define _aie512_s16macsub_m __builtin_ingenicaie_s16macsub_mask

//extern aie_vint32_t __builtin_ingenicaie_s1macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t);
#define _aie512_s1macssb __builtin_ingenicaie_s1macssb
#define _aie512_s1macssb_m __builtin_ingenicaie_s1macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_s2macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t);
#define _aie512_s2macssb __builtin_ingenicaie_s2macssb
#define _aie512_s2macssb_m __builtin_ingenicaie_s2macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_s4macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t);
#define _aie512_s4macssb __builtin_ingenicaie_s4macssb
#define _aie512_s4macssb_m __builtin_ingenicaie_s4macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_s8macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t);
#define _aie512_s8macssb __builtin_ingenicaie_s8macssb
#define _aie512_s8macssb_m __builtin_ingenicaie_s8macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_s16macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t);
#define _aie512_s16macssb __builtin_ingenicaie_s16macssb
#define _aie512_s16macssb_m __builtin_ingenicaie_s16macssb_mask

//extern aie_vint32_t __builtin_ingenicaie_s1macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t);
#define _aie512_s1macssh __builtin_ingenicaie_s1macssh
#define _aie512_s1macssh_m __builtin_ingenicaie_s1macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_s2macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t);
#define _aie512_s2macssh __builtin_ingenicaie_s2macssh
#define _aie512_s2macssh_m __builtin_ingenicaie_s2macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_s4macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t);
#define _aie512_s4macssh __builtin_ingenicaie_s4macssh
#define _aie512_s4macssh_m __builtin_ingenicaie_s4macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_s8macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t);
#define _aie512_s8macssh __builtin_ingenicaie_s8macssh
#define _aie512_s8macssh_m __builtin_ingenicaie_s8macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_s16macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t);
#define _aie512_s16macssh __builtin_ingenicaie_s16macssh
#define _aie512_s16macssh_m __builtin_ingenicaie_s16macssh_mask


/* Floating Point Arithmetic */
//extern aie_vfloat32_t __builtin_ingenicaie_fxas1w_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie512_fxas1w __builtin_ingenicaie_fxas1w
#define _aie512_fxas1w_m __builtin_ingenicaie_fxas1w_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fxas2w_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie512_fxas2w __builtin_ingenicaie_fxas2w
#define _aie512_fxas2w_m __builtin_ingenicaie_fxas2w_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fxas4w_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie512_fxas4w __builtin_ingenicaie_fxas4w
#define _aie512_fxas4w_m __builtin_ingenicaie_fxas4w_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fxas8w_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie512_fxas8w __builtin_ingenicaie_fxas8w
#define _aie512_fxas8w_m __builtin_ingenicaie_fxas8w_mask

//extern aie_vfloat16_t __builtin_ingenicaie_fxas1h_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie512_fxas1h __builtin_ingenicaie_fxas1h
#define _aie512_fxas1h_m __builtin_ingenicaie_fxas1h_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fxas2h_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie512_fxas2h __builtin_ingenicaie_fxas2h
#define _aie512_fxas2h_m __builtin_ingenicaie_fxas2h_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fxas4h_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie512_fxas4h __builtin_ingenicaie_fxas4h
#define _aie512_fxas4h_m __builtin_ingenicaie_fxas4h_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fxas8h_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie512_fxas8h __builtin_ingenicaie_fxas8h
#define _aie512_fxas8h_m __builtin_ingenicaie_fxas8h_mask

/* Element Shuffle/Permute  */
//extern aie_vint32_t __builtin_ingenicaie_gt4w_mask(mask, aie_vint32_t, unsigned int, aie_vint32_t, unsigned int);
#define _aie512_gt4w __builtin_ingenicaie_gt4w
#define _aie512_gt4w_m __builtin_ingenicaie_gt4w_mask
//extern aie_vint32_t __builtin_ingenicaie_gt8w_mask(mask, aie_vint32_t, unsigned int, aie_vint32_t, unsigned int);
#define _aie512_gt8w __builtin_ingenicaie_gt8w
#define _aie512_gt8w_m __builtin_ingenicaie_gt8w_mask
//extern aie_vint64_t __builtin_ingenicaie_gt2d_mask(mask, aie_vint64_t, unsigned int, aie_vint64_t, unsigned int);
#define _aie512_gt2d __builtin_ingenicaie_gt2d
#define _aie512_gt2d_m __builtin_ingenicaie_gt2d_mask
//extern aie_vint64_t __builtin_ingenicaie_gt4d_mask(mask, aie_vint64_t, unsigned int, aie_vint64_t, unsigned int);
#define _aie512_gt4d __builtin_ingenicaie_gt4d
#define _aie512_gt4d_m __builtin_ingenicaie_gt4d_mask
//extern aie_vint128_t __builtin_ingenicaie_gt2q_mask(mask, aie_vint128_t, unsigned int, aie_vint128_t, unsigned int);
#define _aie512_gt2q __builtin_ingenicaie_gt2q
#define _aie512_gt2q_m __builtin_ingenicaie_gt2q_mask

//extern aie_vuint64_t __builtin_ingenicaie_extudll_mask(mask, aie_vuint64_t, aie_vuint64_t, unsigned int);
#define _aie512_extudll __builtin_ingenicaie_extudll
#define _aie512_extudll_m __builtin_ingenicaie_extudll_mask
//extern aie_vuint64_t __builtin_ingenicaie_extudlh_mask(mask, aie_vuint64_t, aie_vuint64_t, unsigned int);
#define _aie512_extudlh __builtin_ingenicaie_extudlh
#define _aie512_extudlh_m __builtin_ingenicaie_extudlh_mask
//extern aie_vuint64_t __builtin_ingenicaie_extudhl_mask(mask, aie_vuint64_t, aie_vuint64_t, unsigned int);
#define _aie512_extudhl __builtin_ingenicaie_extudhl
#define _aie512_extudhl_m __builtin_ingenicaie_extudhl_mask
//extern aie_vuint64_t __builtin_ingenicaie_extudhh_mask(mask, aie_vuint64_t, aie_vuint64_t, unsigned int);
#define _aie512_extudhh __builtin_ingenicaie_extudhh
#define _aie512_extudhh_m __builtin_ingenicaie_extudhh_mask

//extern aie_vuint128_t __builtin_ingenicaie_extuqll_mask(mask, aie_vuint128_t, aie_vuint128_t, unsigned int);
#define _aie512_extuqll __builtin_ingenicaie_extuqll
#define _aie512_extuqll_m __builtin_ingenicaie_extuqll_mask
//extern aie_vuint128_t __builtin_ingenicaie_extuqlh_mask(mask, aie_vuint128_t, aie_vuint128_t, unsigned int);
#define _aie512_extuqlh __builtin_ingenicaie_extuqlh
#define _aie512_extuqlh_m __builtin_ingenicaie_extuqlh_mask
//extern aie_vuint128_t __builtin_ingenicaie_extuqhl_mask(mask, aie_vuint128_t, aie_vuint128_t, unsigned int);
#define _aie512_extuqhl __builtin_ingenicaie_extuqhl
#define _aie512_extuqhl_m __builtin_ingenicaie_extuqhl_mask
//extern aie_vuint128_t __builtin_ingenicaie_extuqhh_mask(mask, aie_vuint128_t, aie_vuint128_t, unsigned int);
#define _aie512_extuqhh __builtin_ingenicaie_extuqhh
#define _aie512_extuqhh_m __builtin_ingenicaie_extuqhh_mask

//extern aie_vuint128_t __builtin_ingenicaie_extuoll_mask(mask, aie_vuint128_t, aie_vuint128_t, unsigned int);
#define _aie512_extuoll __builtin_ingenicaie_extuoll
#define _aie512_extuoll_m __builtin_ingenicaie_extuoll_mask
//extern aie_vuint128_t __builtin_ingenicaie_extuolh_mask(mask, aie_vuint128_t, aie_vuint128_t, unsigned int);
#define _aie512_extuolh __builtin_ingenicaie_extuolh
#define _aie512_extuolh_m __builtin_ingenicaie_extuolh_mask
//extern aie_vuint128_t __builtin_ingenicaie_extuohl_mask(mask, aie_vuint128_t, aie_vuint128_t, unsigned int);
#define _aie512_extuohl __builtin_ingenicaie_extuohl
#define _aie512_extuohl_m __builtin_ingenicaie_extuohl_mask
//extern aie_vuint128_t __builtin_ingenicaie_extuohh_mask(mask, aie_vuint128_t, aie_vuint128_t, unsigned int);
#define _aie512_extuohh __builtin_ingenicaie_extuohh
#define _aie512_extuohh_m __builtin_ingenicaie_extuohh_mask

//extern aie_vuint32_t __builtin_ingenicaie_shufw2_mask(mask, maskedoff, aie_vuint32_t);
#define _aie512_shufw2 __builtin_ingenicaie_shufw2
#define _aie512_shufw2_m __builtin_ingenicaie_shufw2_mask
//extern aie_vuint32_t __builtin_ingenicaie_shufw4_mask(mask, maskedoff, aie_vuint32_t);
#define _aie512_shufw4 __builtin_ingenicaie_shufw4
#define _aie512_shufw4_m __builtin_ingenicaie_shufw4_mask
//extern aie_vuint32_t __builtin_ingenicaie_shufw8_mask(mask, maskedoff, aie_vuint32_t);
#define _aie512_shufw8 __builtin_ingenicaie_shufw8
#define _aie512_shufw8_m __builtin_ingenicaie_shufw8_mask
//extern aie_vuint64_t __builtin_ingenicaie_shufd2_mask(mask, maskedoff, aie_vuint64_t);
#define _aie512_shufd2 __builtin_ingenicaie_shufd2
#define _aie512_shufd2_m __builtin_ingenicaie_shufd2_mask
//extern aie_vuint64_t __builtin_ingenicaie_shufd4_mask(mask, maskedoff, aie_vuint64_t);
#define _aie512_shufd4 __builtin_ingenicaie_shufd4
#define _aie512_shufd4_m __builtin_ingenicaie_shufd4_mask
//extern aie_vuint128_t __builtin_ingenicaie_shufq2_mask(mask, maskedoff, aie_vuint128_t);
#define _aie512_shufq2 __builtin_ingenicaie_shufq2
#define _aie512_shufq2_m __builtin_ingenicaie_shufq2_mask

//extern aie_vuint128_t __builtin_ingenicaie_ilveq_mask(mask, maskedoff, aie_vuint128_t, aie_vuint128_t);
#define _aie512_ilveq __builtin_ingenicaie_ilveq
#define _aie512_ilveq_m __builtin_ingenicaie_ilveq_mask
//extern aie_vuint256_t __builtin_ingenicaie_ilveo_mask(mask, maskedoff, aie_vuint256_t, aie_vuint256_t);
#define _aie512_ilveo __builtin_ingenicaie_ilveo
#define _aie512_ilveo_m __builtin_ingenicaie_ilveo_mask

//extern aie_vuint128_t __builtin_ingenicaie_ilvoq_mask(mask, maskedoff, aie_vuint128_t, aie_vuint128_t);
#define _aie512_ilvoq __builtin_ingenicaie_ilvoq
#define _aie512_ilvoq_m __builtin_ingenicaie_ilvoq_mask
//extern aie_vuint256_t __builtin_ingenicaie_ilvoo_mask(mask, maskedoff, aie_vuint256_t, aie_vuint256_t);
#define _aie512_ilvoo __builtin_ingenicaie_ilvoo
#define _aie512_ilvoo_m __builtin_ingenicaie_ilvoo_mask

//extern aie_vuint8_t __builtin_ingenicaie_repib_mask(mask, maskedoff, aie_vuint8_t, int);
#define _aie512_repib __builtin_ingenicaie_repib
#define _aie512_repib_m __builtin_ingenicaie_repib_mask
//extern aie_vuint16_t __builtin_ingenicaie_repih_mask(mask, maskedoff, aie_vuint16_t, int);
#define _aie512_repih __builtin_ingenicaie_repih
#define _aie512_repih_m __builtin_ingenicaie_repih_mask
//extern aie_vuint32_t __builtin_ingenicaie_repiw_mask(mask, maskedoff, aie_vuint32_t, int);
#define _aie512_repiw __builtin_ingenicaie_repiw
#define _aie512_repiw_m __builtin_ingenicaie_repiw_mask
//extern aie_vuint64_t __builtin_ingenicaie_repid_mask(mask, maskedoff, aie_vuint64_t, int);
#define _aie512_repid __builtin_ingenicaie_repid
#define _aie512_repid_m __builtin_ingenicaie_repid_mask
//extern aie_vuint128_t __builtin_ingenicaie_repiq_mask(mask, maskedoff, aie_vuint128_t, int);
#define _aie512_repiq __builtin_ingenicaie_repiq
#define _aie512_repiq_m __builtin_ingenicaie_repiq_mask
//extern aie_vuint256_t __builtin_ingenicaie_repio_mask(mask, maskedoff, aie_vuint256_t, int);
#define _aie512_repio __builtin_ingenicaie_repio
#define _aie512_repio_m __builtin_ingenicaie_repio_mask

//extern aie_vuint32_t __builtin_ingenicaie_movw(aie_vuint32_t, int, aie_vuint32_t, int);
#define _aie512_movw __builtin_ingenicaie_movw
//extern aie_vuint64_t __builtin_ingenicaie_movd(aie_vuint64_t, int, aie_vuint64_t, int);
#define _aie512_movd __builtin_ingenicaie_movd
//extern aie_vuint128_t __builtin_ingenicaie_movq(aie_vuint128_t, int, aie_vuint128_t, int);
#define _aie512_movq __builtin_ingenicaie_movq
//extern aie_vuint256_t __builtin_ingenicaie_movo(aie_vuint256_t, int, aie_vuint256_t, int);
#define _aie512_movo __builtin_ingenicaie_movo


/* Load && Store.  */
//extern aie_vuint32_t __builtin_ingenicaie_law_mask(mask, aie_vuint32_t, int, _m32u_ptr, int);
#define _aie512_law __builtin_ingenicaie_law
#define _aie512_law_m __builtin_ingenicaie_law_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad_mask(mask, aie_vuint64_t, int, _m64u_ptr, int);
#define _aie512_lad __builtin_ingenicaie_lad
#define _aie512_lad_m __builtin_ingenicaie_lad_mask
//extern aie_vuint128_t __builtin_ingenicaie_laq_mask(mask, aie_vuint128_t, int, _m128u_ptr, int);
#define _aie512_laq __builtin_ingenicaie_laq
#define _aie512_laq_m __builtin_ingenicaie_laq_mask
//extern aie_vuint256_t __builtin_ingenicaie_lao_mask(mask, aie_vuint256_t, int, _m256u_ptr, int);
#define _aie512_lao __builtin_ingenicaie_lao
#define _aie512_lao_m __builtin_ingenicaie_lao_mask

//extern void __builtin_ingenicaie_saw_mask(mask, aie_vuint32_t, int, _m32u_ptr, int);
#define _aie512_saw __builtin_ingenicaie_saw
#define _aie512_saw_m __builtin_ingenicaie_saw_mask
//extern void __builtin_ingenicaie_sad_mask(mask, aie_vuint64_t, int, _m64u_ptr, int);
#define _aie512_sad __builtin_ingenicaie_sad
#define _aie512_sad_m __builtin_ingenicaie_sad_mask
//extern void __builtin_ingenicaie_saq_mask(mask, aie_vuint128_t, int, _m128u_ptr, int);
#define _aie512_saq __builtin_ingenicaie_saq
#define _aie512_saq_m __builtin_ingenicaie_saq_mask
//extern void __builtin_ingenicaie_sao_mask(mask, aie_vuint256_t, int, _m256u_ptr, int);
#define _aie512_sao __builtin_ingenicaie_sao
#define _aie512_sao_m __builtin_ingenicaie_sao_mask

//extern aie_vuint32_t __builtin_ingenicaie_law2b_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_law2b __builtin_ingenicaie_law2b
#define _aie512_law2b_m __builtin_ingenicaie_law2b_mask
//extern aie_vuint32_t __builtin_ingenicaie_law2h_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_law2h __builtin_ingenicaie_law2h
#define _aie512_law2h_m __builtin_ingenicaie_law2h_mask
//extern aie_vuint32_t __builtin_ingenicaie_law4b_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_law4b __builtin_ingenicaie_law4b
#define _aie512_law4b_m __builtin_ingenicaie_law4b_mask
//extern aie_vuint32_t __builtin_ingenicaie_law4h_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_law4h __builtin_ingenicaie_law4h
#define _aie512_law4h_m __builtin_ingenicaie_law4h_mask
//extern aie_vuint32_t __builtin_ingenicaie_law8b_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_law8b __builtin_ingenicaie_law8b
#define _aie512_law8b_m __builtin_ingenicaie_law8b_mask
//extern aie_vuint32_t __builtin_ingenicaie_law8h_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_law8h __builtin_ingenicaie_law8h
#define _aie512_law8h_m __builtin_ingenicaie_law8h_mask
//extern aie_vuint32_t __builtin_ingenicaie_law16b_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_law16b __builtin_ingenicaie_law16b
#define _aie512_law16b_m __builtin_ingenicaie_law16b_mask
//extern aie_vuint32_t __builtin_ingenicaie_law16h_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_law16h __builtin_ingenicaie_law16h
#define _aie512_law16h_m __builtin_ingenicaie_law16h_mask

//extern aie_vuint64_t __builtin_ingenicaie_lad2b_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lad2b __builtin_ingenicaie_lad2b
#define _aie512_lad2b_m __builtin_ingenicaie_lad2b_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad2h_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lad2h __builtin_ingenicaie_lad2h
#define _aie512_lad2h_m __builtin_ingenicaie_lad2h_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad2w_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lad2w __builtin_ingenicaie_lad2w
#define _aie512_lad2w_m __builtin_ingenicaie_lad2w_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad4b_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lad4b __builtin_ingenicaie_lad4b
#define _aie512_lad4b_m __builtin_ingenicaie_lad4b_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad4h_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lad4h __builtin_ingenicaie_lad4h
#define _aie512_lad4h_m __builtin_ingenicaie_lad4h_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad4w_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lad4w __builtin_ingenicaie_lad4w
#define _aie512_lad4w_m __builtin_ingenicaie_lad4w_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad8b_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lad8b __builtin_ingenicaie_lad8b
#define _aie512_lad8b_m __builtin_ingenicaie_lad8b_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad8h_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lad8h __builtin_ingenicaie_lad8h
#define _aie512_lad8h_m __builtin_ingenicaie_lad8h_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad8w_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lad8w __builtin_ingenicaie_lad8w
#define _aie512_lad8w_m __builtin_ingenicaie_lad8w_mask

//extern aie_vuint128_t __builtin_ingenicaie_laq2b_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_laq2b __builtin_ingenicaie_laq2b
#define _aie512_laq2b_m __builtin_ingenicaie_laq2b_mask
//extern aie_vuint128_t __builtin_ingenicaie_laq2h_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_laq2h __builtin_ingenicaie_laq2h
#define _aie512_laq2h_m __builtin_ingenicaie_laq2h_mask
//extern aie_vuint128_t __builtin_ingenicaie_laq2w_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_laq2w __builtin_ingenicaie_laq2w
#define _aie512_laq2w_m __builtin_ingenicaie_laq2w_mask
//extern aie_vuint128_t __builtin_ingenicaie_laq2d_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_laq2d __builtin_ingenicaie_laq2d
#define _aie512_laq2d_m __builtin_ingenicaie_laq2d_mask
//extern aie_vuint128_t __builtin_ingenicaie_laq4b_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_laq4b __builtin_ingenicaie_laq4b
#define _aie512_laq4b_m __builtin_ingenicaie_laq4b_mask
//extern aie_vuint128_t __builtin_ingenicaie_laq4h_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_laq4h __builtin_ingenicaie_laq4h
#define _aie512_laq4h_m __builtin_ingenicaie_laq4h_mask
//extern aie_vuint128_t __builtin_ingenicaie_laq4w_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_laq4w __builtin_ingenicaie_laq4w
#define _aie512_laq4w_m __builtin_ingenicaie_laq4w_mask
//extern aie_vuint128_t __builtin_ingenicaie_laq4d_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_laq4d __builtin_ingenicaie_laq4d
#define _aie512_laq4d_m __builtin_ingenicaie_laq4d_mask

//extern aie_vuint256_t __builtin_ingenicaie_lao2b_mask(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_lao2b __builtin_ingenicaie_lao2b
#define _aie512_lao2b_m __builtin_ingenicaie_lao2b_mask
//extern aie_vuint256_t __builtin_ingenicaie_lao2h_mask(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_lao2h __builtin_ingenicaie_lao2h
#define _aie512_lao2h_m __builtin_ingenicaie_lao2h_mask
//extern aie_vuint256_t __builtin_ingenicaie_lao2w_mask(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_lao2w __builtin_ingenicaie_lao2w
#define _aie512_lao2w_m __builtin_ingenicaie_lao2w_mask
//extern aie_vuint256_t __builtin_ingenicaie_lao2d_mask(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_lao2d __builtin_ingenicaie_lao2d
#define _aie512_lao2d_m __builtin_ingenicaie_lao2d_mask
//extern aie_vuint256_t __builtin_ingenicaie_lao2q_mask(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_lao2q __builtin_ingenicaie_lao2q
#define _aie512_lao2q_m __builtin_ingenicaie_lao2q_mask

//extern void __builtin_ingenicaie_sad2w_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_sad2w __builtin_ingenicaie_sad2w
#define _aie512_sad2w_m __builtin_ingenicaie_sad2w_mask
//extern void __builtin_ingenicaie_sad4w_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_sad4w __builtin_ingenicaie_sad4w
#define _aie512_sad4w_m __builtin_ingenicaie_sad4w_mask
//extern void __builtin_ingenicaie_sad8w_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_sad8w __builtin_ingenicaie_sad8w
#define _aie512_sad8w_m __builtin_ingenicaie_sad8w_mask

//extern void __builtin_ingenicaie_saq2w_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_saq2w __builtin_ingenicaie_saq2w
#define _aie512_saq2w_m __builtin_ingenicaie_saq2w_mask
//extern void __builtin_ingenicaie_saq2d_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_saq2d __builtin_ingenicaie_saq2d
#define _aie512_saq2d_m __builtin_ingenicaie_saq2d_mask
//extern void __builtin_ingenicaie_saq4w_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_saq4w __builtin_ingenicaie_saq4w
#define _aie512_saq4w_m __builtin_ingenicaie_saq4w_mask
//extern void __builtin_ingenicaie_saq4d_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_saq4d __builtin_ingenicaie_saq4d
#define _aie512_saq4d_m __builtin_ingenicaie_saq4d_mask

//extern void __builtin_ingenicaie_sao2w_mask(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_sao2w __builtin_ingenicaie_sao2w
#define _aie512_sao2w_m __builtin_ingenicaie_sao2w_mask
//extern void __builtin_ingenicaie_sao2d_mask(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_sao2d __builtin_ingenicaie_sao2d
#define _aie512_sao2d_m __builtin_ingenicaie_sao2d_mask
//extern void __builtin_ingenicaie_sao2q_mask(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_sao2q __builtin_ingenicaie_sao2q
#define _aie512_sao2q_m __builtin_ingenicaie_sao2q_mask


/* Load && Store Update.  */
//extern aie_vuint32_t _aie_luw_m_internal(mask, aie_vuint32_t, int, _m32u_ptr, int);
#define _aie512_luw _aie_luw_internal
#define _aie512_luw_m _aie_luw_m_internal
//extern aie_vuint64_t _aie_lud_m_internal(mask, aie_vuint64_t, int, _m64u_ptr, int);
#define _aie512_lud _aie_lud_internal
#define _aie512_lud_m _aie_lud_m_internal
//extern aie_vuint128_t _aie_luq_m_internal(mask, aie_vuint128_t, int, _m128u_ptr, int);
#define _aie512_luq _aie_luq_internal
#define _aie512_luq_m _aie_luq_m_internal
//extern aie_vuint256_t _aie_luo_m_internal(mask, aie_vuint256_t, int, _m256u_ptr, int);
#define _aie512_luo _aie_luo_internal
#define _aie512_luo_m _aie_luo_m_internal

//extern void _aie_suw_m_internal(mask, aie_vuint32_t, int, _m32u_ptr, int);
#define _aie512_suw _aie_suw_internal
#define _aie512_suw_m _aie_suw_m_internal
//extern void _aie_sud_m_internal(mask, aie_vuint64_t, int, _m64u_ptr, int);
#define _aie512_sud _aie_sud_internal
#define _aie512_sud_m _aie_sud_m_internal
//extern void _aie_suq_m_internal(mask, aie_vuint128_t, int, _m128u_ptr, int);
#define _aie512_suq _aie_suq_internal
#define _aie512_suq_m _aie_suq_m_internal
//extern void _aie_suo_m_internal(mask, aie_vuint256_t, int, _m256u_ptr, int);
#define _aie512_suo _aie_suo_internal
#define _aie512_suo_m _aie_suo_m_internal

//extern aie_vuint32_t _aie_luw2b_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_luw2b _aie_luw2b_internal
#define _aie512_luw2b_m _aie_luw2b_m_internal
//extern aie_vuint32_t _aie_luw2h_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_luw2h _aie_luw2h_internal
#define _aie512_luw2h_m _aie_luw2h_m_internal
//extern aie_vuint32_t _aie_luw4b_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_luw4b _aie_luw4b_internal
#define _aie512_luw4b_m _aie_luw4b_m_internal
//extern aie_vuint32_t _aie_luw4h_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_luw4h _aie_luw4h_internal
#define _aie512_luw4h_m _aie_luw4h_m_internal
//extern aie_vuint32_t _aie_luw8b_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_luw8b _aie_luw8b_internal
#define _aie512_luw8b_m _aie_luw8b_m_internal
//extern aie_vuint32_t _aie_luw8h_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_luw8h _aie_luw8h_internal
#define _aie512_luw8h_m _aie_luw8h_m_internal
//extern aie_vuint32_t _aie_luw16b_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_luw16b _aie_luw16b_internal
#define _aie512_luw16b_m _aie_luw16b_m_internal
//extern aie_vuint32_t _aie_luw16h_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie512_luw16h _aie_luw16h_internal
#define _aie512_luw16h_m _aie_luw16h_m_internal

//extern aie_vuint64_t _aie_lud2b_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lud2b _aie_lud2b_internal
#define _aie512_lud2b_m _aie_lud2b_m_internal
//extern aie_vuint64_t _aie_lud2h_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lud2h _aie_lud2h_internal
#define _aie512_lud2h_m _aie_lud2h_m_internal
//extern aie_vuint64_t _aie_lud2w_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lud2w _aie_lud2w_internal
#define _aie512_lud2w_m _aie_lud2w_m_internal
//extern aie_vuint64_t _aie_lud4b_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lud4b _aie_lud4b_internal
#define _aie512_lud4b_m _aie_lud4b_m_internal
//extern aie_vuint64_t _aie_lud4h_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lud4h _aie_lud4h_internal
#define _aie512_lud4h_m _aie_lud4h_m_internal
//extern aie_vuint64_t _aie_lud4w_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lud4w _aie_lud4w_internal
#define _aie512_lud4w_m _aie_lud4w_m_internal
//extern aie_vuint64_t _aie_lud8b_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lud8b _aie_lud8b_internal
#define _aie512_lud8b_m _aie_lud8b_m_internal
//extern aie_vuint64_t _aie_lud8h_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lud8h _aie_lud8h_internal
#define _aie512_lud8h_m _aie_lud8h_m_internal
//extern aie_vuint64_t _aie_lud8w_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_lud8w _aie_lud8w_internal
#define _aie512_lud8w_m _aie_lud8w_m_internal

//extern aie_vuint128_t _aie_luq2b_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_luq2b _aie_luq2b_internal
#define _aie512_luq2b_m _aie_luq2b_m_internal
//extern aie_vuint128_t _aie_luq2h_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_luq2h _aie_luq2h_internal
#define _aie512_luq2h_m _aie_luq2h_m_internal
//extern aie_vuint128_t _aie_luq2w_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_luq2w _aie_luq2w_internal
#define _aie512_luq2w_m _aie_luq2w_m_internal
//extern aie_vuint128_t _aie_luq2d_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_luq2d _aie_luq2d_internal
#define _aie512_luq2d_m _aie_luq2d_m_internal
//extern aie_vuint128_t _aie_luq4b_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_luq4b _aie_luq4b_internal
#define _aie512_luq4b_m _aie_luq4b_m_internal
//extern aie_vuint128_t _aie_luq4h_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_luq4h _aie_luq4h_internal
#define _aie512_luq4h_m _aie_luq4h_m_internal
//extern aie_vuint128_t _aie_luq4w_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_luq4w _aie_luq4w_internal
#define _aie512_luq4w_m _aie_luq4w_m_internal
//extern aie_vuint128_t _aie_luq4d_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_luq4d _aie_luq4d_internal
#define _aie512_luq4d_m _aie_luq4d_m_internal

//extern aie_vuint256_t _aie_luo2b_m_internal(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_luo2b _aie_luo2b_internal
#define _aie512_luo2b_m _aie_luo2b_m_internal
//extern aie_vuint256_t _aie_luo2h_m_internal(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_luo2h _aie_luo2h_internal
#define _aie512_luo2h_m _aie_luo2h_m_internal
//extern aie_vuint256_t _aie_luo2w_m_internal(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_luo2w _aie_luo2w_internal
#define _aie512_luo2w_m _aie_luo2w_m_internal
//extern aie_vuint256_t _aie_luo2d_m_internal(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_luo2d _aie_luo2d_internal
#define _aie512_luo2d_m _aie_luo2d_m_internal
//extern aie_vuint256_t _aie_luo2q_m_internal(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_luo2q _aie_luo2q_internal
#define _aie512_luo2q_m _aie_luo2q_m_internal

//extern void _aie_sud2w_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_sud2w _aie_sud2w_internal
#define _aie512_sud2w_m _aie_sud2w_m_internal
//extern void _aie_sud4w_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_sud4w _aie_sud4w_internal
#define _aie512_sud4w_m _aie_sud4w_m_internal
//extern void _aie_sud8w_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie512_sud8w _aie_sud8w_internal
#define _aie512_sud8w_m _aie_sud8w_m_internal

//extern void _aie_suq2w_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_suq2w _aie_suq2w_internal
#define _aie512_suq2w_m _aie_suq2w_m_internal
//extern void _aie_suq2d_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_suq2d _aie_suq2d_internal
#define _aie512_suq2d_m _aie_suq2d_m_internal
//extern void _aie_suq4w_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_suq4w _aie_suq4w_internal
#define _aie512_suq4w_m _aie_suq4w_m_internal
//extern void _aie_suq4d_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie512_suq4d _aie_suq4d_internal
#define _aie512_suq4d_m _aie_suq4d_m_internal

//extern void _aie_suo2w_m_internal(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_suo2w _aie_suo2w_internal
#define _aie512_suo2w_m _aie_suo2w_m_internal
//extern void _aie_suo2d_m_internal(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_suo2d _aie_suo2d_internal
#define _aie512_suo2d_m _aie_suo2d_m_internal
//extern void _aie_suo2q_m_internal(mask, aie_vuint256_t, int, int, _m256u_ptr);
#define _aie512_suo2q _aie_suo2q_internal
#define _aie512_suo2q_m _aie_suo2q_m_internal


#elif (__AIE_VECTOR_BITS == 256)

/* AIE256 special built-in function.  */

/* Integer Arithmetic */
//extern aie_vuint32_t __builtin_ingenicaie_sr1sum2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie256_sr1sum2bi __builtin_ingenicaie_sr1sum2bi
#define _aie256_sr1sum2bi_m __builtin_ingenicaie_sr1sum2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2sum2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie256_sr2sum2bi __builtin_ingenicaie_sr2sum2bi
#define _aie256_sr2sum2bi_m __builtin_ingenicaie_sr2sum2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4sum2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie256_sr4sum2bi __builtin_ingenicaie_sr4sum2bi
#define _aie256_sr4sum2bi_m __builtin_ingenicaie_sr4sum2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8sum2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie256_sr8sum2bi __builtin_ingenicaie_sr8sum2bi
#define _aie256_sr8sum2bi_m __builtin_ingenicaie_sr8sum2bi_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1sum4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie256_sr1sum4bi __builtin_ingenicaie_sr1sum4bi
#define _aie256_sr1sum4bi_m __builtin_ingenicaie_sr1sum4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2sum4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie256_sr2sum4bi __builtin_ingenicaie_sr2sum4bi
#define _aie256_sr2sum4bi_m __builtin_ingenicaie_sr2sum4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4sum4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie256_sr4sum4bi __builtin_ingenicaie_sr4sum4bi
#define _aie256_sr4sum4bi_m __builtin_ingenicaie_sr4sum4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8sum4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie256_sr8sum4bi __builtin_ingenicaie_sr8sum4bi
#define _aie256_sr8sum4bi_m __builtin_ingenicaie_sr8sum4bi_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1sumub_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie256_sr1sumub __builtin_ingenicaie_sr1sumub
#define _aie256_sr1sumub_m __builtin_ingenicaie_sr1sumub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2sumub_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie256_sr2sumub __builtin_ingenicaie_sr2sumub
#define _aie256_sr2sumub_m __builtin_ingenicaie_sr2sumub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4sumub_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie256_sr4sumub __builtin_ingenicaie_sr4sumub
#define _aie256_sr4sumub_m __builtin_ingenicaie_sr4sumub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8sumub_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie256_sr8sumub __builtin_ingenicaie_sr8sumub
#define _aie256_sr8sumub_m __builtin_ingenicaie_sr8sumub_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1sumuh_mask(mask, aie_vuint32_t, int, aie_vuint16_t);
#define _aie256_sr1sumuh __builtin_ingenicaie_sr1sumuh
#define _aie256_sr1sumuh_m __builtin_ingenicaie_sr1sumuh_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2sumuh_mask(mask, aie_vuint32_t, int, aie_vuint16_t);
#define _aie256_sr2sumuh __builtin_ingenicaie_sr2sumuh
#define _aie256_sr2sumuh_m __builtin_ingenicaie_sr2sumuh_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4sumuh_mask(mask, aie_vuint32_t, int, aie_vuint16_t);
#define _aie256_sr4sumuh __builtin_ingenicaie_sr4sumuh
#define _aie256_sr4sumuh_m __builtin_ingenicaie_sr4sumuh_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8sumuh_mask(mask, aie_vuint32_t, int, aie_vuint16_t);
#define _aie256_sr8sumuh __builtin_ingenicaie_sr8sumuh
#define _aie256_sr8sumuh_m __builtin_ingenicaie_sr8sumuh_mask

//extern aie_vint32_t  __builtin_ingenicaie_sr1sumsb_mask(mask, aie_vint32_t, int, aie_vint8_t);
#define _aie256_sr1sumsb __builtin_ingenicaie_sr1sumsb
#define  _aie256_sr1sumsb_m __builtin_ingenicaie_sr1sumsb_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr2sumsb_mask(mask, aie_vint32_t, int, aie_vint8_t);
#define _aie256_sr2sumsb __builtin_ingenicaie_sr2sumsb
#define  _aie256_sr2sumsb_m __builtin_ingenicaie_sr2sumsb_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr4sumsb_mask(mask, aie_vint32_t, int, aie_vint8_t);
#define _aie256_sr4sumsb __builtin_ingenicaie_sr4sumsb
#define  _aie256_sr4sumsb_m __builtin_ingenicaie_sr4sumsb_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr8sumsb_mask(mask, aie_vint32_t, int, aie_vint8_t);
#define _aie256_sr8sumsb __builtin_ingenicaie_sr8sumsb
#define  _aie256_sr8sumsb_m __builtin_ingenicaie_sr8sumsb_mask

//extern aie_vint32_t  __builtin_ingenicaie_sr1sumsh_mask(mask, aie_vint32_t, int, aie_vint16_t);
#define _aie256_sr1sumsh __builtin_ingenicaie_sr1sumsh
#define  _aie256_sr1sumsh_m __builtin_ingenicaie_sr1sumsh_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr2sumsh_mask(mask, aie_vint32_t, int, aie_vint16_t);
#define _aie256_sr2sumsh __builtin_ingenicaie_sr2sumsh
#define  _aie256_sr2sumsh_m __builtin_ingenicaie_sr2sumsh_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr4sumsh_mask(mask, aie_vint32_t, int, aie_vint16_t);
#define _aie256_sr4sumsh __builtin_ingenicaie_sr4sumsh
#define  _aie256_sr4sumsh_m __builtin_ingenicaie_sr4sumsh_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr8sumsh_mask(mask, aie_vint32_t, int, aie_vint16_t);
#define _aie256_sr8sumsh __builtin_ingenicaie_sr8sumsh
#define  _aie256_sr8sumsh_m __builtin_ingenicaie_sr8sumsh_mask

//extern aie_vint32_t  __builtin_ingenicaie_sr1sumw_mask(mask, aie_vint32_t, int, aie_vint32_t);
#define _aie256_sr1sumw __builtin_ingenicaie_sr1sumw
#define  _aie256_sr1sumw_m __builtin_ingenicaie_sr1sumw_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr2sumw_mask(mask, aie_vint32_t, int, aie_vint32_t);
#define _aie256_sr2sumw __builtin_ingenicaie_sr2sumw
#define  _aie256_sr2sumw_m __builtin_ingenicaie_sr2sumw_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr4sumw_mask(mask, aie_vint32_t, int, aie_vint32_t);
#define _aie256_sr4sumw __builtin_ingenicaie_sr4sumw
#define  _aie256_sr4sumw_m __builtin_ingenicaie_sr4sumw_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr8sumw_mask(mask, aie_vint32_t, int, aie_vint32_t);
#define _aie256_sr8sumw __builtin_ingenicaie_sr8sumw
#define  _aie256_sr8sumw_m __builtin_ingenicaie_sr8sumw_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1mac2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie256_sr1mac2bi __builtin_ingenicaie_sr1mac2bi
#define _aie256_sr1mac2bi_m __builtin_ingenicaie_sr1mac2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2mac2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie256_sr2mac2bi __builtin_ingenicaie_sr2mac2bi
#define _aie256_sr2mac2bi_m __builtin_ingenicaie_sr2mac2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4mac2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie256_sr4mac2bi __builtin_ingenicaie_sr4mac2bi
#define _aie256_sr4mac2bi_m __builtin_ingenicaie_sr4mac2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8mac2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie256_sr8mac2bi __builtin_ingenicaie_sr8mac2bi
#define _aie256_sr8mac2bi_m __builtin_ingenicaie_sr8mac2bi_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1mac4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie256_sr1mac4bi __builtin_ingenicaie_sr1mac4bi
#define _aie256_sr1mac4bi_m __builtin_ingenicaie_sr1mac4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2mac4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie256_sr2mac4bi __builtin_ingenicaie_sr2mac4bi
#define _aie256_sr2mac4bi_m __builtin_ingenicaie_sr2mac4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4mac4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie256_sr4mac4bi __builtin_ingenicaie_sr4mac4bi
#define _aie256_sr4mac4bi_m __builtin_ingenicaie_sr4mac4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8mac4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie256_sr8mac4bi __builtin_ingenicaie_sr8mac4bi
#define _aie256_sr8mac4bi_m __builtin_ingenicaie_sr8mac4bi_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie256_sr1macuub __builtin_ingenicaie_sr1macuub
#define _aie256_sr1macuub_m __builtin_ingenicaie_sr1macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie256_sr2macuub __builtin_ingenicaie_sr2macuub
#define _aie256_sr2macuub_m __builtin_ingenicaie_sr2macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie256_sr4macuub __builtin_ingenicaie_sr4macuub
#define _aie256_sr4macuub_m __builtin_ingenicaie_sr4macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr8macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie256_sr8macuub __builtin_ingenicaie_sr8macuub
#define _aie256_sr8macuub_m __builtin_ingenicaie_sr8macuub_mask

//extern aie_vint32_t __builtin_ingenicaie_sr1macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t, int);
#define _aie256_sr1macsub __builtin_ingenicaie_sr1macsub
#define _aie256_sr1macsub_m __builtin_ingenicaie_sr1macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_sr2macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t, int);
#define _aie256_sr2macsub __builtin_ingenicaie_sr2macsub
#define _aie256_sr2macsub_m __builtin_ingenicaie_sr2macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_sr4macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t, int);
#define _aie256_sr4macsub __builtin_ingenicaie_sr4macsub
#define _aie256_sr4macsub_m __builtin_ingenicaie_sr4macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_sr8macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t, int);
#define _aie256_sr8macsub __builtin_ingenicaie_sr8macsub
#define _aie256_sr8macsub_m __builtin_ingenicaie_sr8macsub_mask

//extern aie_vint32_t __builtin_ingenicaie_sr1macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t, int);
#define _aie256_sr1macssb __builtin_ingenicaie_sr1macssb
#define _aie256_sr1macssb_m __builtin_ingenicaie_sr1macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_sr2macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t, int);
#define _aie256_sr2macssb __builtin_ingenicaie_sr2macssb
#define _aie256_sr2macssb_m __builtin_ingenicaie_sr2macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_sr4macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t, int);
#define _aie256_sr4macssb __builtin_ingenicaie_sr4macssb
#define _aie256_sr4macssb_m __builtin_ingenicaie_sr4macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_sr8macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t, int);
#define _aie256_sr8macssb __builtin_ingenicaie_sr8macssb
#define _aie256_sr8macssb_m __builtin_ingenicaie_sr8macssb_mask

//extern aie_vint32_t __builtin_ingenicaie_sr1macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t, int);
#define _aie256_sr1macssh __builtin_ingenicaie_sr1macssh
#define _aie256_sr1macssh_m __builtin_ingenicaie_sr1macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_sr2macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t, int);
#define _aie256_sr2macssh __builtin_ingenicaie_sr2macssh
#define _aie256_sr2macssh_m __builtin_ingenicaie_sr2macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_sr4macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t, int);
#define _aie256_sr4macssh __builtin_ingenicaie_sr4macssh
#define _aie256_sr4macssh_m __builtin_ingenicaie_sr4macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_sr8macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t, int);
#define _aie256_sr8macssh __builtin_ingenicaie_sr8macssh
#define _aie256_sr8macssh_m __builtin_ingenicaie_sr8macssh_mask

//extern aie_vuint32_t __builtin_ingenicaie_s1macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t);
#define _aie256_s1macuub __builtin_ingenicaie_s1macuub
#define _aie256_s1macuub_m __builtin_ingenicaie_s1macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_s2macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t);
#define _aie256_s2macuub __builtin_ingenicaie_s2macuub
#define _aie256_s2macuub_m __builtin_ingenicaie_s2macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_s4macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t);
#define _aie256_s4macuub __builtin_ingenicaie_s4macuub
#define _aie256_s4macuub_m __builtin_ingenicaie_s4macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_s8macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t);
#define _aie256_s8macuub __builtin_ingenicaie_s8macuub
#define _aie256_s8macuub_m __builtin_ingenicaie_s8macuub_mask

//extern aie_vint32_t __builtin_ingenicaie_s1macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t);
#define _aie256_s1macsub __builtin_ingenicaie_s1macsub
#define _aie256_s1macsub_m __builtin_ingenicaie_s1macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_s2macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t);
#define _aie256_s2macsub __builtin_ingenicaie_s2macsub
#define _aie256_s2macsub_m __builtin_ingenicaie_s2macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_s4macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t);
#define _aie256_s4macsub __builtin_ingenicaie_s4macsub
#define _aie256_s4macsub_m __builtin_ingenicaie_s4macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_s8macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t);
#define _aie256_s8macsub __builtin_ingenicaie_s8macsub
#define _aie256_s8macsub_m __builtin_ingenicaie_s8macsub_mask

//extern aie_vint32_t __builtin_ingenicaie_s1macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t);
#define _aie256_s1macssb __builtin_ingenicaie_s1macssb
#define _aie256_s1macssb_m __builtin_ingenicaie_s1macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_s2macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t);
#define _aie256_s2macssb __builtin_ingenicaie_s2macssb
#define _aie256_s2macssb_m __builtin_ingenicaie_s2macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_s4macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t);
#define _aie256_s4macssb __builtin_ingenicaie_s4macssb
#define _aie256_s4macssb_m __builtin_ingenicaie_s4macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_s8macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t);
#define _aie256_s8macssb __builtin_ingenicaie_s8macssb
#define _aie256_s8macssb_m __builtin_ingenicaie_s8macssb_mask

//extern aie_vint32_t __builtin_ingenicaie_s1macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t);
#define _aie256_s1macssh __builtin_ingenicaie_s1macssh
#define _aie256_s1macssh_m __builtin_ingenicaie_s1macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_s2macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t);
#define _aie256_s2macssh __builtin_ingenicaie_s2macssh
#define _aie256_s2macssh_m __builtin_ingenicaie_s2macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_s4macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t);
#define _aie256_s4macssh __builtin_ingenicaie_s4macssh
#define _aie256_s4macssh_m __builtin_ingenicaie_s4macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_s8macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t);
#define _aie256_s8macssh __builtin_ingenicaie_s8macssh
#define _aie256_s8macssh_m __builtin_ingenicaie_s8macssh_mask


/* Floating Point Arithmetic */
//extern aie_vfloat32_t __builtin_ingenicaie_fxas1w_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie256_fxas1w __builtin_ingenicaie_fxas1w
#define _aie256_fxas1w_m __builtin_ingenicaie_fxas1w_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fxas2w_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie256_fxas2w __builtin_ingenicaie_fxas2w
#define _aie256_fxas2w_m __builtin_ingenicaie_fxas2w_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fxas4w_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie256_fxas4w __builtin_ingenicaie_fxas4w
#define _aie256_fxas4w_m __builtin_ingenicaie_fxas4w_mask

//extern aie_vfloat16_t __builtin_ingenicaie_fxas1h_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie256_fxas1h __builtin_ingenicaie_fxas1h
#define _aie256_fxas1h_m __builtin_ingenicaie_fxas1h_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fxas2h_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie256_fxas2h __builtin_ingenicaie_fxas2h
#define _aie256_fxas2h_m __builtin_ingenicaie_fxas2h_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fxas4h_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie256_fxas4h __builtin_ingenicaie_fxas4h
#define _aie256_fxas4h_m __builtin_ingenicaie_fxas4h_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fxas8h_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie256_fxas8h __builtin_ingenicaie_fxas8h
#define _aie256_fxas8h_m __builtin_ingenicaie_fxas8h_mask

/* Element Shuffle/Permute  */
//extern aie_vint32_t __builtin_ingenicaie_gt4w_mask(mask, aie_vint32_t, unsigned int, aie_vint32_t, unsigned int);
#define _aie256_gt4w __builtin_ingenicaie_gt4w
#define _aie256_gt4w_m __builtin_ingenicaie_gt4w_mask
//extern aie_vint64_t __builtin_ingenicaie_gt2d_mask(mask, aie_vint64_t, unsigned int, aie_vint64_t, unsigned int);
#define _aie256_gt2d __builtin_ingenicaie_gt2d
#define _aie256_gt2d_m __builtin_ingenicaie_gt2d_mask

//extern aie_vuint64_t __builtin_ingenicaie_extudll_mask(mask, aie_vuint64_t, aie_vuint64_t, unsigned int);
#define _aie256_extudll __builtin_ingenicaie_extudll
#define _aie256_extudll_m __builtin_ingenicaie_extudll_mask
//extern aie_vuint64_t __builtin_ingenicaie_extudlh_mask(mask, aie_vuint64_t, aie_vuint64_t, unsigned int);
#define _aie256_extudlh __builtin_ingenicaie_extudlh
#define _aie256_extudlh_m __builtin_ingenicaie_extudlh_mask
//extern aie_vuint64_t __builtin_ingenicaie_extudhl_mask(mask, aie_vuint64_t, aie_vuint64_t, unsigned int);
#define _aie256_extudhl __builtin_ingenicaie_extudhl
#define _aie256_extudhl_m __builtin_ingenicaie_extudhl_mask
//extern aie_vuint64_t __builtin_ingenicaie_extudhh_mask(mask, aie_vuint64_t, aie_vuint64_t, unsigned int);
#define _aie256_extudhh __builtin_ingenicaie_extudhh
#define _aie256_extudhh_m __builtin_ingenicaie_extudhh_mask

//extern aie_vuint128_t __builtin_ingenicaie_extuqll_mask(mask, aie_vuint128_t, aie_vuint128_t, unsigned int);
#define _aie256_extuqll __builtin_ingenicaie_extuqll
#define _aie256_extuqll_m __builtin_ingenicaie_extuqll_mask
//extern aie_vuint128_t __builtin_ingenicaie_extuqlh_mask(mask, aie_vuint128_t, aie_vuint128_t, unsigned int);
#define _aie256_extuqlh __builtin_ingenicaie_extuqlh
#define _aie256_extuqlh_m __builtin_ingenicaie_extuqlh_mask
//extern aie_vuint128_t __builtin_ingenicaie_extuqhl_mask(mask, aie_vuint128_t, aie_vuint128_t, unsigned int);
#define _aie256_extuqhl __builtin_ingenicaie_extuqhl
#define _aie256_extuqhl_m __builtin_ingenicaie_extuqhl_mask
//extern aie_vuint128_t __builtin_ingenicaie_extuqhh_mask(mask, aie_vuint128_t, aie_vuint128_t, unsigned int);
#define _aie256_extuqhh __builtin_ingenicaie_extuqhh
#define _aie256_extuqhh_m __builtin_ingenicaie_extuqhh_mask

//extern aie_vuint32_t __builtin_ingenicaie_shufw2_mask(mask, maskedoff, aie_vuint32_t);
#define _aie256_shufw2 __builtin_ingenicaie_shufw2
#define _aie256_shufw2_m __builtin_ingenicaie_shufw2_mask
//extern aie_vuint32_t __builtin_ingenicaie_shufw4_mask(mask, maskedoff, aie_vuint32_t);
#define _aie256_shufw4 __builtin_ingenicaie_shufw4
#define _aie256_shufw4_m __builtin_ingenicaie_shufw4_mask
//extern aie_vuint64_t __builtin_ingenicaie_shufd2_mask(mask, maskedoff, aie_vuint64_t);
#define _aie256_shufd2 __builtin_ingenicaie_shufd2
#define _aie256_shufd2_m __builtin_ingenicaie_shufd2_mask

//extern aie_vuint128_t __builtin_ingenicaie_ilveq_mask(mask, maskedoff, aie_vuint128_t, aie_vuint128_t);
#define _aie256_ilveq __builtin_ingenicaie_ilveq
#define _aie256_ilveq_m __builtin_ingenicaie_ilveq_mask

//extern aie_vuint128_t __builtin_ingenicaie_ilvoq_mask(mask, maskedoff, aie_vuint128_t, aie_vuint128_t);
#define _aie256_ilvoq __builtin_ingenicaie_ilvoq
#define _aie256_ilvoq_m __builtin_ingenicaie_ilvoq_mask

//extern aie_vuint8_t __builtin_ingenicaie_repib_mask(mask, maskedoff, aie_vuint8_t, int);
#define _aie256_repib __builtin_ingenicaie_repib
#define _aie256_repib_m __builtin_ingenicaie_repib_mask
//extern aie_vuint16_t __builtin_ingenicaie_repih_mask(mask, maskedoff, aie_vuint16_t, int);
#define _aie256_repih __builtin_ingenicaie_repih
#define _aie256_repih_m __builtin_ingenicaie_repih_mask
//extern aie_vuint32_t __builtin_ingenicaie_repiw_mask(mask, maskedoff, aie_vuint32_t, int);
#define _aie256_repiw __builtin_ingenicaie_repiw
#define _aie256_repiw_m __builtin_ingenicaie_repiw_mask
//extern aie_vuint64_t __builtin_ingenicaie_repid_mask(mask, maskedoff, aie_vuint64_t, int);
#define _aie256_repid __builtin_ingenicaie_repid
#define _aie256_repid_m __builtin_ingenicaie_repid_mask
//extern aie_vuint128_t __builtin_ingenicaie_repiq_mask(mask, maskedoff, aie_vuint128_t, int);
#define _aie256_repiq __builtin_ingenicaie_repiq
#define _aie256_repiq_m __builtin_ingenicaie_repiq_mask

//extern aie_vuint32_t __builtin_ingenicaie_movw(aie_vuint32_t, int, aie_vuint32_t, int);
#define _aie256_movw __builtin_ingenicaie_movw
//extern aie_vuint64_t __builtin_ingenicaie_movd(aie_vuint64_t, int, aie_vuint64_t, int);
#define _aie256_movd __builtin_ingenicaie_movd
//extern aie_vuint128_t __builtin_ingenicaie_movq(aie_vuint128_t, int, aie_vuint128_t, int);
#define _aie256_movq __builtin_ingenicaie_movq


/* Load && Store.  */
//extern aie_vuint32_t __builtin_ingenicaie_law_mask(mask, aie_vuint32_t, int, _m32u_ptr, int);
#define _aie256_law __builtin_ingenicaie_law
#define _aie256_law_m __builtin_ingenicaie_law_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad_mask(mask, aie_vuint64_t, int, _m64u_ptr, int);
#define _aie256_lad __builtin_ingenicaie_lad
#define _aie256_lad_m __builtin_ingenicaie_lad_mask
//extern aie_vuint128_t __builtin_ingenicaie_laq_mask(mask, aie_vuint128_t, int, _m128u_ptr, int);
#define _aie256_laq __builtin_ingenicaie_laq
#define _aie256_laq_m __builtin_ingenicaie_laq_mask

//extern void __builtin_ingenicaie_saw_mask(mask, aie_vuint32_t, int, _m32u_ptr, int);
#define _aie256_saw __builtin_ingenicaie_saw
#define _aie256_saw_m __builtin_ingenicaie_saw_mask
//extern void __builtin_ingenicaie_sad_mask(mask, aie_vuint64_t, int, _m64u_ptr, int);
#define _aie256_sad __builtin_ingenicaie_sad
#define _aie256_sad_m __builtin_ingenicaie_sad_mask
//extern void __builtin_ingenicaie_saq_mask(mask, aie_vuint128_t, int, _m128u_ptr, int);
#define _aie256_saq __builtin_ingenicaie_saq
#define _aie256_saq_m __builtin_ingenicaie_saq_mask

//extern aie_vuint32_t __builtin_ingenicaie_law2b_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie256_law2b __builtin_ingenicaie_law2b
#define _aie256_law2b_m __builtin_ingenicaie_law2b_mask
//extern aie_vuint32_t __builtin_ingenicaie_law2h_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie256_law2h __builtin_ingenicaie_law2h
#define _aie256_law2h_m __builtin_ingenicaie_law2h_mask
//extern aie_vuint32_t __builtin_ingenicaie_law4b_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie256_law4b __builtin_ingenicaie_law4b
#define _aie256_law4b_m __builtin_ingenicaie_law4b_mask
//extern aie_vuint32_t __builtin_ingenicaie_law4h_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie256_law4h __builtin_ingenicaie_law4h
#define _aie256_law4h_m __builtin_ingenicaie_law4h_mask
//extern aie_vuint32_t __builtin_ingenicaie_law8b_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie256_law8b __builtin_ingenicaie_law8b
#define _aie256_law8b_m __builtin_ingenicaie_law8b_mask
//extern aie_vuint32_t __builtin_ingenicaie_law8h_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie256_law8h __builtin_ingenicaie_law8h
#define _aie256_law8h_m __builtin_ingenicaie_law8h_mask

//extern aie_vuint64_t __builtin_ingenicaie_lad2b_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_lad2b __builtin_ingenicaie_lad2b
#define _aie256_lad2b_m __builtin_ingenicaie_lad2b_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad2h_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_lad2h __builtin_ingenicaie_lad2h
#define _aie256_lad2h_m __builtin_ingenicaie_lad2h_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad2w_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_lad2w __builtin_ingenicaie_lad2w
#define _aie256_lad2w_m __builtin_ingenicaie_lad2w_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad4b_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_lad4b __builtin_ingenicaie_lad4b
#define _aie256_lad4b_m __builtin_ingenicaie_lad4b_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad4h_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_lad4h __builtin_ingenicaie_lad4h
#define _aie256_lad4h_m __builtin_ingenicaie_lad4h_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad4w_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_lad4w __builtin_ingenicaie_lad4w
#define _aie256_lad4w_m __builtin_ingenicaie_lad4w_mask

//extern aie_vuint128_t __builtin_ingenicaie_laq2b_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie256_laq2b __builtin_ingenicaie_laq2b
#define _aie256_laq2b_m __builtin_ingenicaie_laq2b_mask
//extern aie_vuint128_t __builtin_ingenicaie_laq2h_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie256_laq2h __builtin_ingenicaie_laq2h
#define _aie256_laq2h_m __builtin_ingenicaie_laq2h_mask
//extern aie_vuint128_t __builtin_ingenicaie_laq2w_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie256_laq2w __builtin_ingenicaie_laq2w
#define _aie256_laq2w_m __builtin_ingenicaie_laq2w_mask
//extern aie_vuint128_t __builtin_ingenicaie_laq2d_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie256_laq2d __builtin_ingenicaie_laq2d
#define _aie256_laq2d_m __builtin_ingenicaie_laq2d_mask

//extern void __builtin_ingenicaie_sad2w_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_sad2w __builtin_ingenicaie_sad2w
#define _aie256_sad2w_m __builtin_ingenicaie_sad2w_mask
//extern void __builtin_ingenicaie_sad4w_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_sad4w __builtin_ingenicaie_sad4w
#define _aie256_sad4w_m __builtin_ingenicaie_sad4w_mask

//extern void __builtin_ingenicaie_saq2w_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie256_saq2w __builtin_ingenicaie_saq2w
#define _aie256_saq2w_m __builtin_ingenicaie_saq2w_mask
//extern void __builtin_ingenicaie_saq2d_mask(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie256_saq2d __builtin_ingenicaie_saq2d
#define _aie256_saq2d_m __builtin_ingenicaie_saq2d_mask


/* Load && Store Update.  */
//extern aie_vuint32_t _aie_luw_m_internal(mask, aie_vuint32_t, int, _m32u_ptr, int);
#define _aie256_luw _aie_luw_internal
#define _aie256_luw_m _aie_luw_m_internal
//extern aie_vuint64_t _aie_lud_m_internal(mask, aie_vuint64_t, int, _m64u_ptr, int);
#define _aie256_lud _aie_lud_internal
#define _aie256_lud_m _aie_lud_m_internal
//extern aie_vuint128_t _aie_luq_m_internal(mask, aie_vuint128_t, int, _m128u_ptr, int);
#define _aie256_luq _aie_luq_internal
#define _aie256_luq_m _aie_luq_m_internal

//extern void _aie_suw_m_internal(mask, aie_vuint32_t, int, _m32u_ptr, int);
#define _aie256_suw _aie_suw_internal
#define _aie256_suw_m _aie_suw_m_internal
//extern void _aie_sud_m_internal(mask, aie_vuint64_t, int, _m64u_ptr, int);
#define _aie256_sud _aie_sud_internal
#define _aie256_sud_m _aie_sud_m_internal
//extern void _aie_suq_m_internal(mask, aie_vuint128_t, int, _m128u_ptr, int);
#define _aie256_suq _aie_suq_internal
#define _aie256_suq_m _aie_suq_m_internal

//extern aie_vuint32_t _aie_luw2b_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie256_luw2b _aie_luw2b_internal
#define _aie256_luw2b_m _aie_luw2b_m_internal
//extern aie_vuint32_t _aie_luw2h_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie256_luw2h _aie_luw2h_internal
#define _aie256_luw2h_m _aie_luw2h_m_internal
//extern aie_vuint32_t _aie_luw4b_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie256_luw4b _aie_luw4b_internal
#define _aie256_luw4b_m _aie_luw4b_m_internal
//extern aie_vuint32_t _aie_luw4h_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie256_luw4h _aie_luw4h_internal
#define _aie256_luw4h_m _aie_luw4h_m_internal
//extern aie_vuint32_t _aie_luw8b_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie256_luw8b _aie_luw8b_internal
#define _aie256_luw8b_m _aie_luw8b_m_internal
//extern aie_vuint32_t _aie_luw8h_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie256_luw8h _aie_luw8h_internal
#define _aie256_luw8h_m _aie_luw8h_m_internal

//extern aie_vuint64_t _aie_lud2b_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_lud2b _aie_lud2b_internal
#define _aie256_lud2b_m _aie_lud2b_m_internal
//extern aie_vuint64_t _aie_lud2h_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_lud2h _aie_lud2h_internal
#define _aie256_lud2h_m _aie_lud2h_m_internal
//extern aie_vuint64_t _aie_lud2w_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_lud2w _aie_lud2w_internal
#define _aie256_lud2w_m _aie_lud2w_m_internal
//extern aie_vuint64_t _aie_lud4b_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_lud4b _aie_lud4b_internal
#define _aie256_lud4b_m _aie_lud4b_m_internal
//extern aie_vuint64_t _aie_lud4h_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_lud4h _aie_lud4h_internal
#define _aie256_lud4h_m _aie_lud4h_m_internal
//extern aie_vuint64_t _aie_lud4w_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_lud4w _aie_lud4w_internal
#define _aie256_lud4w_m _aie_lud4w_m_internal

//extern aie_vuint128_t _aie_luq2b_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie256_luq2b _aie_luq2b_internal
#define _aie256_luq2b_m _aie_luq2b_m_internal
//extern aie_vuint128_t _aie_luq2h_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie256_luq2h _aie_luq2h_internal
#define _aie256_luq2h_m _aie_luq2h_m_internal
//extern aie_vuint128_t _aie_luq2w_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie256_luq2w _aie_luq2w_internal
#define _aie256_luq2w_m _aie_luq2w_m_internal
//extern aie_vuint128_t _aie_luq2d_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie256_luq2d _aie_luq2d_internal
#define _aie256_luq2d_m _aie_luq2d_m_internal

//extern void _aie_sud2w_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_sud2w _aie_sud2w_internal
#define _aie256_sud2w_m _aie_sud2w_m_internal
//extern void _aie_sud4w_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie256_sud4w _aie_sud4w_internal
#define _aie256_sud4w_m _aie_sud4w_m_internal

//extern void _aie_suq2w_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie256_suq2w _aie_suq2w_internal
#define _aie256_suq2w_m _aie_suq2w_m_internal
//extern void _aie_suq2d_m_internal(mask, aie_vuint128_t, int, int, _m128u_ptr);
#define _aie256_suq2d _aie_suq2d_internal
#define _aie256_suq2d_m _aie_suq2d_m_internal

#elif (__AIE_VECTOR_BITS == 128)

/* AIE128 special built-in function.  */

/* Integer Arithmetic */
//extern aie_vuint32_t __builtin_ingenicaie_sr1sum2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie128_sr1sum2bi __builtin_ingenicaie_sr1sum2bi
#define _aie128_sr1sum2bi_m __builtin_ingenicaie_sr1sum2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2sum2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie128_sr2sum2bi __builtin_ingenicaie_sr2sum2bi
#define _aie128_sr2sum2bi_m __builtin_ingenicaie_sr2sum2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4sum2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie128_sr4sum2bi __builtin_ingenicaie_sr4sum2bi
#define _aie128_sr4sum2bi_m __builtin_ingenicaie_sr4sum2bi_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1sum4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie128_sr1sum4bi __builtin_ingenicaie_sr1sum4bi
#define _aie128_sr1sum4bi_m __builtin_ingenicaie_sr1sum4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2sum4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie128_sr2sum4bi __builtin_ingenicaie_sr2sum4bi
#define _aie128_sr2sum4bi_m __builtin_ingenicaie_sr2sum4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4sum4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie128_sr4sum4bi __builtin_ingenicaie_sr4sum4bi
#define _aie128_sr4sum4bi_m __builtin_ingenicaie_sr4sum4bi_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1sumub_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie128_sr1sumub __builtin_ingenicaie_sr1sumub
#define _aie128_sr1sumub_m __builtin_ingenicaie_sr1sumub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2sumub_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie128_sr2sumub __builtin_ingenicaie_sr2sumub
#define _aie128_sr2sumub_m __builtin_ingenicaie_sr2sumub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4sumub_mask(mask, aie_vuint32_t, int, aie_vuint8_t);
#define _aie128_sr4sumub __builtin_ingenicaie_sr4sumub
#define _aie128_sr4sumub_m __builtin_ingenicaie_sr4sumub_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1sumuh_mask(mask, aie_vuint32_t, int, aie_vuint16_t);
#define _aie128_sr1sumuh __builtin_ingenicaie_sr1sumuh
#define _aie128_sr1sumuh_m __builtin_ingenicaie_sr1sumuh_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2sumuh_mask(mask, aie_vuint32_t, int, aie_vuint16_t);
#define _aie128_sr2sumuh __builtin_ingenicaie_sr2sumuh
#define _aie128_sr2sumuh_m __builtin_ingenicaie_sr2sumuh_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4sumuh_mask(mask, aie_vuint32_t, int, aie_vuint16_t);
#define _aie128_sr4sumuh __builtin_ingenicaie_sr4sumuh
#define _aie128_sr4sumuh_m __builtin_ingenicaie_sr4sumuh_mask

//extern aie_vint32_t  __builtin_ingenicaie_sr1sumsb_mask(mask, aie_vint32_t, int, aie_vint8_t);
#define _aie128_sr1sumsb __builtin_ingenicaie_sr1sumsb
#define  _aie128_sr1sumsb_m __builtin_ingenicaie_sr1sumsb_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr2sumsb_mask(mask, aie_vint32_t, int, aie_vint8_t);
#define _aie128_sr2sumsb __builtin_ingenicaie_sr2sumsb
#define  _aie128_sr2sumsb_m __builtin_ingenicaie_sr2sumsb_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr4sumsb_mask(mask, aie_vint32_t, int, aie_vint8_t);
#define _aie128_sr4sumsb __builtin_ingenicaie_sr4sumsb
#define  _aie128_sr4sumsb_m __builtin_ingenicaie_sr4sumsb_mask

//extern aie_vint32_t  __builtin_ingenicaie_sr1sumsh_mask(mask, aie_vint32_t, int, aie_vint16_t);
#define _aie128_sr1sumsh __builtin_ingenicaie_sr1sumsh
#define  _aie128_sr1sumsh_m __builtin_ingenicaie_sr1sumsh_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr2sumsh_mask(mask, aie_vint32_t, int, aie_vint16_t);
#define _aie128_sr2sumsh __builtin_ingenicaie_sr2sumsh
#define  _aie128_sr2sumsh_m __builtin_ingenicaie_sr2sumsh_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr4sumsh_mask(mask, aie_vint32_t, int, aie_vint16_t);
#define _aie128_sr4sumsh __builtin_ingenicaie_sr4sumsh
#define  _aie128_sr4sumsh_m __builtin_ingenicaie_sr4sumsh_mask

//extern aie_vint32_t  __builtin_ingenicaie_sr1sumw_mask(mask, aie_vint32_t, int, aie_vint32_t);
#define _aie128_sr1sumw __builtin_ingenicaie_sr1sumw
#define  _aie128_sr1sumw_m __builtin_ingenicaie_sr1sumw_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr2sumw_mask(mask, aie_vint32_t, int, aie_vint32_t);
#define _aie128_sr2sumw __builtin_ingenicaie_sr2sumw
#define  _aie128_sr2sumw_m __builtin_ingenicaie_sr2sumw_mask
//extern aie_vint32_t  __builtin_ingenicaie_sr4sumw_mask(mask, aie_vint32_t, int, aie_vint32_t);
#define _aie128_sr4sumw __builtin_ingenicaie_sr4sumw
#define  _aie128_sr4sumw_m __builtin_ingenicaie_sr4sumw_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1mac2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie128_sr1mac2bi __builtin_ingenicaie_sr1mac2bi
#define _aie128_sr1mac2bi_m __builtin_ingenicaie_sr1mac2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2mac2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie128_sr2mac2bi __builtin_ingenicaie_sr2mac2bi
#define _aie128_sr2mac2bi_m __builtin_ingenicaie_sr2mac2bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4mac2bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie128_sr4mac2bi __builtin_ingenicaie_sr4mac2bi
#define _aie128_sr4mac2bi_m __builtin_ingenicaie_sr4mac2bi_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1mac4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie128_sr1mac4bi __builtin_ingenicaie_sr1mac4bi
#define _aie128_sr1mac4bi_m __builtin_ingenicaie_sr1mac4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2mac4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie128_sr2mac4bi __builtin_ingenicaie_sr2mac4bi
#define _aie128_sr2mac4bi_m __builtin_ingenicaie_sr2mac4bi_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4mac4bi_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie128_sr4mac4bi __builtin_ingenicaie_sr4mac4bi
#define _aie128_sr4mac4bi_m __builtin_ingenicaie_sr4mac4bi_mask

//extern aie_vuint32_t __builtin_ingenicaie_sr1macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie128_sr1macuub __builtin_ingenicaie_sr1macuub
#define _aie128_sr1macuub_m __builtin_ingenicaie_sr1macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr2macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie128_sr2macuub __builtin_ingenicaie_sr2macuub
#define _aie128_sr2macuub_m __builtin_ingenicaie_sr2macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_sr4macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t, int);
#define _aie128_sr4macuub __builtin_ingenicaie_sr4macuub
#define _aie128_sr4macuub_m __builtin_ingenicaie_sr4macuub_mask

//extern aie_vint32_t __builtin_ingenicaie_sr1macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t, int);
#define _aie128_sr1macsub __builtin_ingenicaie_sr1macsub
#define _aie128_sr1macsub_m __builtin_ingenicaie_sr1macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_sr2macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t, int);
#define _aie128_sr2macsub __builtin_ingenicaie_sr2macsub
#define _aie128_sr2macsub_m __builtin_ingenicaie_sr2macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_sr4macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t, int);
#define _aie128_sr4macsub __builtin_ingenicaie_sr4macsub
#define _aie128_sr4macsub_m __builtin_ingenicaie_sr4macsub_mask

//extern aie_vint32_t __builtin_ingenicaie_sr1macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t, int);
#define _aie128_sr1macssb __builtin_ingenicaie_sr1macssb
#define _aie128_sr1macssb_m __builtin_ingenicaie_sr1macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_sr2macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t, int);
#define _aie128_sr2macssb __builtin_ingenicaie_sr2macssb
#define _aie128_sr2macssb_m __builtin_ingenicaie_sr2macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_sr4macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t, int);
#define _aie128_sr4macssb __builtin_ingenicaie_sr4macssb
#define _aie128_sr4macssb_m __builtin_ingenicaie_sr4macssb_mask

//extern aie_vint32_t __builtin_ingenicaie_sr1macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t, int);
#define _aie128_sr1macssh __builtin_ingenicaie_sr1macssh
#define _aie128_sr1macssh_m __builtin_ingenicaie_sr1macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_sr2macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t, int);
#define _aie128_sr2macssh __builtin_ingenicaie_sr2macssh
#define _aie128_sr2macssh_m __builtin_ingenicaie_sr2macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_sr4macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t, int);
#define _aie128_sr4macssh __builtin_ingenicaie_sr4macssh
#define _aie128_sr4macssh_m __builtin_ingenicaie_sr4macssh_mask

//extern aie_vuint32_t __builtin_ingenicaie_s1macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t);
#define _aie128_s1macuub __builtin_ingenicaie_s1macuub
#define _aie128_s1macuub_m __builtin_ingenicaie_s1macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_s2macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t);
#define _aie128_s2macuub __builtin_ingenicaie_s2macuub
#define _aie128_s2macuub_m __builtin_ingenicaie_s2macuub_mask
//extern aie_vuint32_t __builtin_ingenicaie_s4macuub_mask(mask, aie_vuint32_t, int, aie_vuint8_t, aie_vuint8_t);
#define _aie128_s4macuub __builtin_ingenicaie_s4macuub
#define _aie128_s4macuub_m __builtin_ingenicaie_s4macuub_mask

//extern aie_vint32_t __builtin_ingenicaie_s1macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t);
#define _aie128_s1macsub __builtin_ingenicaie_s1macsub
#define _aie128_s1macsub_m __builtin_ingenicaie_s1macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_s2macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t);
#define _aie128_s2macsub __builtin_ingenicaie_s2macsub
#define _aie128_s2macsub_m __builtin_ingenicaie_s2macsub_mask
//extern aie_vint32_t __builtin_ingenicaie_s4macsub_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vuint8_t);
#define _aie128_s4macsub __builtin_ingenicaie_s4macsub
#define _aie128_s4macsub_m __builtin_ingenicaie_s4macsub_mask

//extern aie_vint32_t __builtin_ingenicaie_s1macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t);
#define _aie128_s1macssb __builtin_ingenicaie_s1macssb
#define _aie128_s1macssb_m __builtin_ingenicaie_s1macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_s2macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t);
#define _aie128_s2macssb __builtin_ingenicaie_s2macssb
#define _aie128_s2macssb_m __builtin_ingenicaie_s2macssb_mask
//extern aie_vint32_t __builtin_ingenicaie_s4macssb_mask(mask, aie_vint32_t, int, aie_vint8_t, aie_vint8_t);
#define _aie128_s4macssb __builtin_ingenicaie_s4macssb
#define _aie128_s4macssb_m __builtin_ingenicaie_s4macssb_mask

//extern aie_vint32_t __builtin_ingenicaie_s1macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t);
#define _aie128_s1macssh __builtin_ingenicaie_s1macssh
#define _aie128_s1macssh_m __builtin_ingenicaie_s1macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_s2macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t);
#define _aie128_s2macssh __builtin_ingenicaie_s2macssh
#define _aie128_s2macssh_m __builtin_ingenicaie_s2macssh_mask
//extern aie_vint32_t __builtin_ingenicaie_s4macssh_mask(mask, aie_vint32_t, int, aie_vint16_t, aie_vint16_t);
#define _aie128_s4macssh __builtin_ingenicaie_s4macssh
#define _aie128_s4macssh_m __builtin_ingenicaie_s4macssh_mask

/* Floating Point Arithmetic */
//extern aie_vfloat32_t __builtin_ingenicaie_fxas1w_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie128_fxas1w __builtin_ingenicaie_fxas1w
#define _aie128_fxas1w_m __builtin_ingenicaie_fxas1w_mask
//extern aie_vfloat32_t __builtin_ingenicaie_fxas2w_mask(mask, maskedoff, aie_vfloat32_t);
#define _aie128_fxas2w __builtin_ingenicaie_fxas2w
#define _aie128_fxas2w_m __builtin_ingenicaie_fxas2w_mask

//extern aie_vfloat16_t __builtin_ingenicaie_fxas1h_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie128_fxas1h __builtin_ingenicaie_fxas1h
#define _aie128_fxas1h_m __builtin_ingenicaie_fxas1h_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fxas2h_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie128_fxas2h __builtin_ingenicaie_fxas2h
#define _aie128_fxas2h_m __builtin_ingenicaie_fxas2h_mask
//extern aie_vfloat16_t __builtin_ingenicaie_fxas4h_mask(mask, maskedoff, aie_vfloat16_t);
#define _aie128_fxas4h __builtin_ingenicaie_fxas4h
#define _aie128_fxas4h_m __builtin_ingenicaie_fxas4h_mask

/* Element Shuffle/Permute  */
//extern aie_vuint64_t __builtin_ingenicaie_extudll_mask(mask, aie_vuint64_t, aie_vuint64_t, unsigned int);
#define _aie128_extudll __builtin_ingenicaie_extudll
#define _aie128_extudll_m __builtin_ingenicaie_extudll_mask
//extern aie_vuint64_t __builtin_ingenicaie_extudlh_mask(mask, aie_vuint64_t, aie_vuint64_t, unsigned int);
#define _aie128_extudlh __builtin_ingenicaie_extudlh
#define _aie128_extudlh_m __builtin_ingenicaie_extudlh_mask
//extern aie_vuint64_t __builtin_ingenicaie_extudhl_mask(mask, aie_vuint64_t, aie_vuint64_t, unsigned int);
#define _aie128_extudhl __builtin_ingenicaie_extudhl
#define _aie128_extudhl_m __builtin_ingenicaie_extudhl_mask
//extern aie_vuint64_t __builtin_ingenicaie_extudhh_mask(mask, aie_vuint64_t, aie_vuint64_t, unsigned int);
#define _aie128_extudhh __builtin_ingenicaie_extudhh
#define _aie128_extudhh_m __builtin_ingenicaie_extudhh_mask

//extern aie_vuint32_t __builtin_ingenicaie_shufw2_mask(mask, maskedoff, aie_vuint32_t);
#define _aie128_shufw2 __builtin_ingenicaie_shufw2
#define _aie128_shufw2_m __builtin_ingenicaie_shufw2_mask

//extern aie_vuint8_t __builtin_ingenicaie_repib_mask(mask, maskedoff, aie_vuint8_t, int);
#define _aie128_repib __builtin_ingenicaie_repib
#define _aie128_repib_m __builtin_ingenicaie_repib_mask
//extern aie_vuint16_t __builtin_ingenicaie_repih_mask(mask, maskedoff, aie_vuint16_t, int);
#define _aie128_repih __builtin_ingenicaie_repih
#define _aie128_repih_m __builtin_ingenicaie_repih_mask
//extern aie_vuint32_t __builtin_ingenicaie_repiw_mask(mask, maskedoff, aie_vuint32_t, int);
#define _aie128_repiw __builtin_ingenicaie_repiw
#define _aie128_repiw_m __builtin_ingenicaie_repiw_mask
//extern aie_vuint64_t __builtin_ingenicaie_repid_mask(mask, maskedoff, aie_vuint64_t, int);
#define _aie128_repid __builtin_ingenicaie_repid
#define _aie128_repid_m __builtin_ingenicaie_repid_mask

//extern aie_vuint32_t __builtin_ingenicaie_movw(aie_vuint32_t, int, aie_vuint32_t, int);
#define _aie128_movw __builtin_ingenicaie_movw
//extern aie_vuint64_t __builtin_ingenicaie_movd(aie_vuint64_t, int, aie_vuint64_t, int);
#define _aie128_movd __builtin_ingenicaie_movd

/* Load && Store.  */
//extern aie_vuint32_t __builtin_ingenicaie_law_mask(mask, aie_vuint32_t, int, _m32u_ptr, int);
#define _aie128_law __builtin_ingenicaie_law
#define _aie128_law_m __builtin_ingenicaie_law_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad_mask(mask, aie_vuint64_t, int, _m64u_ptr, int);
#define _aie128_lad __builtin_ingenicaie_lad
#define _aie128_lad_m __builtin_ingenicaie_lad_mask

//extern void __builtin_ingenicaie_saw_mask(mask, aie_vuint32_t, int, _m32u_ptr, int);
#define _aie128_saw __builtin_ingenicaie_saw
#define _aie128_saw_m __builtin_ingenicaie_saw_mask
//extern void __builtin_ingenicaie_sad_mask(mask, aie_vuint64_t, int, _m64u_ptr, int);
#define _aie128_sad __builtin_ingenicaie_sad
#define _aie128_sad_m __builtin_ingenicaie_sad_mask

//extern aie_vuint32_t __builtin_ingenicaie_law2b_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie128_law2b __builtin_ingenicaie_law2b
#define _aie128_law2b_m __builtin_ingenicaie_law2b_mask
//extern aie_vuint32_t __builtin_ingenicaie_law2h_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie128_law2h __builtin_ingenicaie_law2h
#define _aie128_law2h_m __builtin_ingenicaie_law2h_mask
//extern aie_vuint32_t __builtin_ingenicaie_law4b_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie128_law4b __builtin_ingenicaie_law4b
#define _aie128_law4b_m __builtin_ingenicaie_law4b_mask
//extern aie_vuint32_t __builtin_ingenicaie_law4h_mask(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie128_law4h __builtin_ingenicaie_law4h
#define _aie128_law4h_m __builtin_ingenicaie_law4h_mask

//extern aie_vuint64_t __builtin_ingenicaie_lad2b_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie128_lad2b __builtin_ingenicaie_lad2b
#define _aie128_lad2b_m __builtin_ingenicaie_lad2b_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad2h_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie128_lad2h __builtin_ingenicaie_lad2h
#define _aie128_lad2h_m __builtin_ingenicaie_lad2h_mask
//extern aie_vuint64_t __builtin_ingenicaie_lad2w_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie128_lad2w __builtin_ingenicaie_lad2w
#define _aie128_lad2w_m __builtin_ingenicaie_lad2w_mask

//extern void __builtin_ingenicaie_sad2w_mask(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie128_sad2w __builtin_ingenicaie_sad2w
#define _aie128_sad2w_m __builtin_ingenicaie_sad2w_mask

/* Load && Store Update.  */
//extern aie_vuint32_t _aie_luw_m_internal(mask, aie_vuint32_t, int, _m32u_ptr, int);
#define _aie128_luw _aie_luw_internal
#define _aie128_luw_m _aie_luw_m_internal
//extern aie_vuint64_t _aie_lud_m_internal(mask, aie_vuint64_t, int, _m64u_ptr, int);
#define _aie128_lud _aie_lud_internal
#define _aie128_lud_m _aie_lud_m_internal

//extern void _aie_suw_m_internal(mask, aie_vuint32_t, int, _m32u_ptr, int);
#define _aie128_suw _aie_suw_internal
#define _aie128_suw_m _aie_suw_m_internal
//extern void _aie_sud_m_internal(mask, aie_vuint64_t, int, _m64u_ptr, int);
#define _aie128_sud _aie_sud_internal
#define _aie128_sud_m _aie_sud_m_internal

//extern aie_vuint32_t _aie_luw2b_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie128_luw2b _aie_luw2b_internal
#define _aie128_luw2b_m _aie_luw2b_m_internal
//extern aie_vuint32_t _aie_luw2h_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie128_luw2h _aie_luw2h_internal
#define _aie128_luw2h_m _aie_luw2h_m_internal
//extern aie_vuint32_t _aie_luw4b_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie128_luw4b _aie_luw4b_internal
#define _aie128_luw4b_m _aie_luw4b_m_internal
//extern aie_vuint32_t _aie_luw4h_m_internal(mask, aie_vuint32_t, int, int, _m32u_ptr);
#define _aie128_luw4h _aie_luw4h_internal
#define _aie128_luw4h_m _aie_luw4h_m_internal

//extern aie_vuint64_t _aie_lud2b_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie128_lud2b _aie_lud2b_internal
#define _aie128_lud2b_m _aie_lud2b_m_internal
//extern aie_vuint64_t _aie_lud2h_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie128_lud2h _aie_lud2h_internal
#define _aie128_lud2h_m _aie_lud2h_m_internal
//extern aie_vuint64_t _aie_lud2w_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie128_lud2w _aie_lud2w_internal
#define _aie128_lud2w_m _aie_lud2w_m_internal

//extern void _aie_sud2w_m_internal(mask, aie_vuint64_t, int, int, _m64u_ptr);
#define _aie128_sud2w _aie_sud2w_internal
#define _aie128_sud2w_m _aie_sud2w_m_internal
#endif

/* Intrinsic alias.  */

#if (__AIE_VECTOR_BITS == 512)
#define _aie512_readvl _aie_readvl
#define _aie512_psubs _aie_psubs
#define _aie512_addr_upd _aie_addr_upd
#define _aie512_addr_upd_offset _aie_addr_upd_offset
#define _aie512_fcvthw_ext _aie_fcvthw_ext
#define _aie512_fcvtwh_ext _aie_fcvtwh_ext
#define _aie512_pnot_b8 _aie_pnot_b8
#define _aie512_pnot_b16 _aie_pnot_b16
#define _aie512_pnot_b32 _aie_pnot_b32
#define _aie512_pand_b8 _aie_pand_b8
#define _aie512_pand_b16 _aie_pand_b16
#define _aie512_pand_b32 _aie_pand_b32
#define _aie512_pnand_b8 _aie_pnand_b8
#define _aie512_pnand_b16 _aie_pnand_b16
#define _aie512_pnand_b32 _aie_pnand_b32
#define _aie512_pandn_b8 _aie_pandn_b8
#define _aie512_pandn_b16 _aie_pandn_b16
#define _aie512_pandn_b32 _aie_pandn_b32
#define _aie512_por_b8 _aie_por_b8
#define _aie512_por_b16 _aie_por_b16
#define _aie512_por_b32 _aie_por_b32
#define _aie512_pnor_b8 _aie_pnor_b8
#define _aie512_pnor_b16 _aie_pnor_b16
#define _aie512_pnor_b32 _aie_pnor_b32
#define _aie512_porn_b8 _aie_porn_b8
#define _aie512_porn_b16 _aie_porn_b16
#define _aie512_porn_b32 _aie_porn_b32
#define _aie512_pxor_b8 _aie_pxor_b8
#define _aie512_pxor_b16 _aie_pxor_b16
#define _aie512_pxor_b32 _aie_pxor_b32
#define _aie512_pxnor_b8 _aie_pxnor_b8
#define _aie512_pxnor_b16 _aie_pxnor_b16
#define _aie512_pxnor_b32 _aie_pxnor_b32
#define _aie512_pcpop_b8 _aie_pcpop_b8
#define _aie512_pcpop_b8_m _aie_pcpop_b8_m
#define _aie512_pcpop_b16 _aie_pcpop_b16
#define _aie512_pcpop_b16_m _aie_pcpop_b16_m
#define _aie512_pcpop_b32 _aie_pcpop_b32
#define _aie512_pcpop_b32_m _aie_pcpop_b32_m
#define _aie512_pfirst_b8 _aie_pfirst_b8
#define _aie512_pfirst_b8_m _aie_pfirst_b8_m
#define _aie512_pfirst_b16 _aie_pfirst_b16
#define _aie512_pfirst_b16_m _aie_pfirst_b16_m
#define _aie512_pfirst_b32 _aie_pfirst_b32
#define _aie512_pfirst_b32_m _aie_pfirst_b32_m
#define _aie512_psbf_b8 _aie_psbf_b8
#define _aie512_psbf_b8_m _aie_psbf_b8_m
#define _aie512_psbf_b16 _aie_psbf_b16
#define _aie512_psbf_b16_m _aie_psbf_b16_m
#define _aie512_psbf_b32 _aie_psbf_b32
#define _aie512_psbf_b32_m _aie_psbf_b32_m
#define _aie512_psif_b8 _aie_psif_b8
#define _aie512_psif_b8_m _aie_psif_b8_m
#define _aie512_psif_b16 _aie_psif_b16
#define _aie512_psif_b16_m _aie_psif_b16_m
#define _aie512_psif_b32 _aie_psif_b32
#define _aie512_psif_b32_m _aie_psif_b32_m
#define _aie512_psof_b8 _aie_psof_b8
#define _aie512_psof_b8_m _aie_psof_b8_m
#define _aie512_psof_b16 _aie_psof_b16
#define _aie512_psof_b16_m _aie_psof_b16_m
#define _aie512_psof_b32 _aie_psof_b32
#define _aie512_psof_b32_m _aie_psof_b32_m
#define _aie512_piotab _aie_piotab
#define _aie512_piotab_m _aie_piotab_m
#define _aie512_piotah _aie_piotah
#define _aie512_piotah_m _aie_piotah_m
#define _aie512_piotaw _aie_piotaw
#define _aie512_piotaw_m _aie_piotaw_m
#define _aie512_pidb _aie_pidb
#define _aie512_pidb_m _aie_pidb_m
#define _aie512_pidh _aie_pidh
#define _aie512_pidh_m _aie_pidh_m
#define _aie512_pidw _aie_pidw
#define _aie512_pidw_m _aie_pidw_m
#define _aie512_pdec_b8 _aie_pdec_b8
#define _aie512_pdec_b16 _aie_pdec_b16
#define _aie512_pdec_b32 _aie_pdec_b32
#define _aie512_pld_b8 _aie_pld_b8
#define _aie512_pld_b16 _aie_pld_b16
#define _aie512_pld_b32 _aie_pld_b32
#define _aie512_psd_b8 _aie_psd_b8
#define _aie512_psd_b16 _aie_psd_b16
#define _aie512_psd_b32 _aie_psd_b32
#define _aie512_ceqb _aie_ceqb
#define _aie512_ceqh _aie_ceqh
#define _aie512_ceqw _aie_ceqw
#define _aie512_ceqzb _aie_ceqzb
#define _aie512_ceqzh _aie_ceqzh
#define _aie512_ceqzw _aie_ceqzw
#define _aie512_clesb _aie_clesb
#define _aie512_clesh _aie_clesh
#define _aie512_clesw _aie_clesw
#define _aie512_cleub _aie_cleub
#define _aie512_cleuh _aie_cleuh
#define _aie512_cleuw _aie_cleuw
#define _aie512_clezb _aie_clezb
#define _aie512_clezh _aie_clezh
#define _aie512_clezw _aie_clezw
#define _aie512_cltsb _aie_cltsb
#define _aie512_cltsh _aie_cltsh
#define _aie512_cltsw _aie_cltsw
#define _aie512_cltub _aie_cltub
#define _aie512_cltuh _aie_cltuh
#define _aie512_cltuw _aie_cltuw
#define _aie512_cltzb _aie_cltzb
#define _aie512_cltzh _aie_cltzh
#define _aie512_cltzw _aie_cltzw
#define _aie512_pceqb _aie_pceqb
#define _aie512_pceqb_m _aie_pceqb_m
#define _aie512_pceqh _aie_pceqh
#define _aie512_pceqh_m _aie_pceqh_m
#define _aie512_pceqw _aie_pceqw
#define _aie512_pceqw_m _aie_pceqw_m
#define _aie512_pceqzb _aie_pceqzb
#define _aie512_pceqzb_m _aie_pceqzb_m
#define _aie512_pceqzh _aie_pceqzh
#define _aie512_pceqzh_m _aie_pceqzh_m
#define _aie512_pceqzw _aie_pceqzw
#define _aie512_pceqzw_m _aie_pceqzw_m
#define _aie512_pcneb _aie_pcneb
#define _aie512_pcneb_m _aie_pcneb_m
#define _aie512_pcneh _aie_pcneh
#define _aie512_pcneh_m _aie_pcneh_m
#define _aie512_pcnew _aie_pcnew
#define _aie512_pcnew_m _aie_pcnew_m
#define _aie512_pcnezb _aie_pcnezb
#define _aie512_pcnezb_m _aie_pcnezb_m
#define _aie512_pcnezh _aie_pcnezh
#define _aie512_pcnezh_m _aie_pcnezh_m
#define _aie512_pcnezw _aie_pcnezw
#define _aie512_pcnezw_m _aie_pcnezw_m
#define _aie512_pclesb _aie_pclesb
#define _aie512_pclesb_m _aie_pclesb_m
#define _aie512_pclesh _aie_pclesh
#define _aie512_pclesh_m _aie_pclesh_m
#define _aie512_pclesw _aie_pclesw
#define _aie512_pclesw_m _aie_pclesw_m
#define _aie512_pcleub _aie_pcleub
#define _aie512_pcleub_m _aie_pcleub_m
#define _aie512_pcleuh _aie_pcleuh
#define _aie512_pcleuh_m _aie_pcleuh_m
#define _aie512_pcleuw _aie_pcleuw
#define _aie512_pcleuw_m _aie_pcleuw_m
#define _aie512_pclezb _aie_pclezb
#define _aie512_pclezb_m _aie_pclezb_m
#define _aie512_pclezh _aie_pclezh
#define _aie512_pclezh_m _aie_pclezh_m
#define _aie512_pclezw _aie_pclezw
#define _aie512_pclezw_m _aie_pclezw_m
#define _aie512_pcltsb _aie_pcltsb
#define _aie512_pcltsb_m _aie_pcltsb_m
#define _aie512_pcltsh _aie_pcltsh
#define _aie512_pcltsh_m _aie_pcltsh_m
#define _aie512_pcltsw _aie_pcltsw
#define _aie512_pcltsw_m _aie_pcltsw_m
#define _aie512_pcltub _aie_pcltub
#define _aie512_pcltub_m _aie_pcltub_m
#define _aie512_pcltuh _aie_pcltuh
#define _aie512_pcltuh_m _aie_pcltuh_m
#define _aie512_pcltuw _aie_pcltuw
#define _aie512_pcltuw_m _aie_pcltuw_m
#define _aie512_pcltzb _aie_pcltzb
#define _aie512_pcltzb_m _aie_pcltzb_m
#define _aie512_pcltzh _aie_pcltzh
#define _aie512_pcltzh_m _aie_pcltzh_m
#define _aie512_pcltzw _aie_pcltzw
#define _aie512_pcltzw_m _aie_pcltzw_m
#define _aie512_addb _aie_addb
#define _aie512_addb_m _aie_addb_m
#define _aie512_addh _aie_addh
#define _aie512_addh_m _aie_addh_m
#define _aie512_addw _aie_addw
#define _aie512_addw_m _aie_addw_m
#define _aie512_subb _aie_subb
#define _aie512_subb_m _aie_subb_m
#define _aie512_subh _aie_subh
#define _aie512_subh_m _aie_subh_m
#define _aie512_subw _aie_subw
#define _aie512_subw_m _aie_subw_m
#define _aie512_waddsbl _aie_waddsbl
#define _aie512_waddsbl_m _aie_waddsbl_m
#define _aie512_waddsbh _aie_waddsbh
#define _aie512_waddsbh_m _aie_waddsbh_m
#define _aie512_waddshl _aie_waddshl
#define _aie512_waddshl_m _aie_waddshl_m
#define _aie512_waddshh _aie_waddshh
#define _aie512_waddshh_m _aie_waddshh_m
#define _aie512_waddubl _aie_waddubl
#define _aie512_waddubl_m _aie_waddubl_m
#define _aie512_waddubh _aie_waddubh
#define _aie512_waddubh_m _aie_waddubh_m
#define _aie512_wadduhl _aie_wadduhl
#define _aie512_wadduhl_m _aie_wadduhl_m
#define _aie512_wadduhh _aie_wadduhh
#define _aie512_wadduhh_m _aie_wadduhh_m
#define _aie512_wsubsbl _aie_wsubsbl
#define _aie512_wsubsbl_m _aie_wsubsbl_m
#define _aie512_wsubsbh _aie_wsubsbh
#define _aie512_wsubsbh_m _aie_wsubsbh_m
#define _aie512_wsubshl _aie_wsubshl
#define _aie512_wsubshl_m _aie_wsubshl_m
#define _aie512_wsubshh _aie_wsubshh
#define _aie512_wsubshh_m _aie_wsubshh_m
#define _aie512_wsububl _aie_wsububl
#define _aie512_wsububl_m _aie_wsububl_m
#define _aie512_wsububh _aie_wsububh
#define _aie512_wsububh_m _aie_wsububh_m
#define _aie512_wsubuhl _aie_wsubuhl
#define _aie512_wsubuhl_m _aie_wsubuhl_m
#define _aie512_wsubuhh _aie_wsubuhh
#define _aie512_wsubuhh_m _aie_wsubuhh_m
#define _aie512_absb _aie_absb
#define _aie512_absb_m _aie_absb_m
#define _aie512_absh _aie_absh
#define _aie512_absh_m _aie_absh_m
#define _aie512_absw _aie_absw
#define _aie512_absw_m _aie_absw_m
#define _aie512_mulb _aie_mulb
#define _aie512_mulb_m _aie_mulb_m
#define _aie512_mulh _aie_mulh
#define _aie512_mulh_m _aie_mulh_m
#define _aie512_mulw _aie_mulw
#define _aie512_mulw_m _aie_mulw_m
#define _aie512_smulbe _aie_smulbe
#define _aie512_smulbe_m _aie_smulbe_m
#define _aie512_smulbo _aie_smulbo
#define _aie512_smulbo_m _aie_smulbo_m
#define _aie512_smulhe _aie_smulhe
#define _aie512_smulhe_m _aie_smulhe_m
#define _aie512_smulho _aie_smulho
#define _aie512_smulho_m _aie_smulho_m
#define _aie512_umulbe _aie_umulbe
#define _aie512_umulbe_m _aie_umulbe_m
#define _aie512_umulbo _aie_umulbo
#define _aie512_umulbo_m _aie_umulbo_m
#define _aie512_umulhe _aie_umulhe
#define _aie512_umulhe_m _aie_umulhe_m
#define _aie512_umulho _aie_umulho
#define _aie512_umulho_m _aie_umulho_m
#define _aie512_wsmulbl _aie_wsmulbl
#define _aie512_wsmulbl_m _aie_wsmulbl_m
#define _aie512_wsmulbh _aie_wsmulbh
#define _aie512_wsmulbh_m _aie_wsmulbh_m
#define _aie512_wsmulhl _aie_wsmulhl
#define _aie512_wsmulhl_m _aie_wsmulhl_m
#define _aie512_wsmulhh _aie_wsmulhh
#define _aie512_wsmulhh_m _aie_wsmulhh_m
#define _aie512_wumulbl _aie_wumulbl
#define _aie512_wumulbl_m _aie_wumulbl_m
#define _aie512_wumulbh _aie_wumulbh
#define _aie512_wumulbh_m _aie_wumulbh_m
#define _aie512_wumulhl _aie_wumulhl
#define _aie512_wumulhl_m _aie_wumulhl_m
#define _aie512_wumulhh _aie_wumulhh
#define _aie512_wumulhh_m _aie_wumulhh_m
#define _aie512_mlaw _aie_mlaw
#define _aie512_mlaw_m _aie_mlaw_m
#define _aie512_mlsw _aie_mlsw
#define _aie512_mlsw_m _aie_mlsw_m
#define _aie512_smlahe _aie_smlahe
#define _aie512_smlahe_m _aie_smlahe_m
#define _aie512_smlaho _aie_smlaho
#define _aie512_smlaho_m _aie_smlaho_m
#define _aie512_smlshe _aie_smlshe
#define _aie512_smlshe_m _aie_smlshe_m
#define _aie512_smlsho _aie_smlsho
#define _aie512_smlsho_m _aie_smlsho_m
#define _aie512_wsmlahl _aie_wsmlahl
#define _aie512_wsmlahl_m _aie_wsmlahl_m
#define _aie512_wsmlahh _aie_wsmlahh
#define _aie512_wsmlahh_m _aie_wsmlahh_m
#define _aie512_wsmlshl _aie_wsmlshl
#define _aie512_wsmlshl_m _aie_wsmlshl_m
#define _aie512_wsmlshh _aie_wsmlshh
#define _aie512_wsmlshh_m _aie_wsmlshh_m
#define _aie512_maxab _aie_maxab
#define _aie512_maxab_m _aie_maxab_m
#define _aie512_maxah _aie_maxah
#define _aie512_maxah_m _aie_maxah_m
#define _aie512_maxaw _aie_maxaw
#define _aie512_maxaw_m _aie_maxaw_m
#define _aie512_maxsb _aie_maxsb
#define _aie512_maxsb_m _aie_maxsb_m
#define _aie512_maxsh _aie_maxsh
#define _aie512_maxsh_m _aie_maxsh_m
#define _aie512_maxsw _aie_maxsw
#define _aie512_maxsw_m _aie_maxsw_m
#define _aie512_maxub _aie_maxub
#define _aie512_maxub_m _aie_maxub_m
#define _aie512_maxuh _aie_maxuh
#define _aie512_maxuh_m _aie_maxuh_m
#define _aie512_maxuw _aie_maxuw
#define _aie512_maxuw_m _aie_maxuw_m
#define _aie512_maxu2bi _aie_maxu2bi
#define _aie512_maxu2bi_m _aie_maxu2bi_m
#define _aie512_maxu4bi _aie_maxu4bi
#define _aie512_maxu4bi_m _aie_maxu4bi_m
#define _aie512_minab _aie_minab
#define _aie512_minab_m _aie_minab_m
#define _aie512_minah _aie_minah
#define _aie512_minah_m _aie_minah_m
#define _aie512_minaw _aie_minaw
#define _aie512_minaw_m _aie_minaw_m
#define _aie512_minsb _aie_minsb
#define _aie512_minsb_m _aie_minsb_m
#define _aie512_minsh _aie_minsh
#define _aie512_minsh_m _aie_minsh_m
#define _aie512_minsw _aie_minsw
#define _aie512_minsw_m _aie_minsw_m
#define _aie512_minub _aie_minub
#define _aie512_minub_m _aie_minub_m
#define _aie512_minuh _aie_minuh
#define _aie512_minuh_m _aie_minuh_m
#define _aie512_minuw _aie_minuw
#define _aie512_minuw_m _aie_minuw_m
#define _aie512_minu2bi _aie_minu2bi
#define _aie512_minu2bi_m _aie_minu2bi_m
#define _aie512_minu4bi _aie_minu4bi
#define _aie512_minu4bi_m _aie_minu4bi_m
#define _aie512_satsshb _aie_satsshb
#define _aie512_satsshb_m _aie_satsshb_m
#define _aie512_satsswb _aie_satsswb
#define _aie512_satsswb_m _aie_satsswb_m
#define _aie512_satsswh _aie_satsswh
#define _aie512_satsswh_m _aie_satsswh_m
#define _aie512_satsub2bi _aie_satsub2bi
#define _aie512_satsub2bi_m _aie_satsub2bi_m
#define _aie512_satsub4bi _aie_satsub4bi
#define _aie512_satsub4bi_m _aie_satsub4bi_m
#define _aie512_satsuh2bi _aie_satsuh2bi
#define _aie512_satsuh2bi_m _aie_satsuh2bi_m
#define _aie512_satsuh4bi _aie_satsuh4bi
#define _aie512_satsuh4bi_m _aie_satsuh4bi_m
#define _aie512_satsuhb _aie_satsuhb
#define _aie512_satsuhb_m _aie_satsuhb_m
#define _aie512_satsuw2bi _aie_satsuw2bi
#define _aie512_satsuw2bi_m _aie_satsuw2bi_m
#define _aie512_satsuw4bi _aie_satsuw4bi
#define _aie512_satsuw4bi_m _aie_satsuw4bi_m
#define _aie512_satsuwb _aie_satsuwb
#define _aie512_satsuwb_m _aie_satsuwb_m
#define _aie512_satsuwh _aie_satsuwh
#define _aie512_satsuwh_m _aie_satsuwh_m
#define _aie512_satuub2bi _aie_satuub2bi
#define _aie512_satuub2bi_m _aie_satuub2bi_m
#define _aie512_satuub4bi _aie_satuub4bi
#define _aie512_satuub4bi_m _aie_satuub4bi_m
#define _aie512_satuuh2bi _aie_satuuh2bi
#define _aie512_satuuh2bi_m _aie_satuuh2bi_m
#define _aie512_satuuh4bi _aie_satuuh4bi
#define _aie512_satuuh4bi_m _aie_satuuh4bi_m
#define _aie512_satuuhb _aie_satuuhb
#define _aie512_satuuhb_m _aie_satuuhb_m
#define _aie512_satuuw4bi _aie_satuuw4bi
#define _aie512_satuuw4bi_m _aie_satuuw4bi_m
#define _aie512_satuuwb _aie_satuuwb
#define _aie512_satuuwb_m _aie_satuuwb_m
#define _aie512_satuuwh _aie_satuuwh
#define _aie512_satuuwh_m _aie_satuuwh_m
#define _aie512_tocb _aie_tocb
#define _aie512_tocb_m _aie_tocb_m
#define _aie512_toch _aie_toch
#define _aie512_toch_m _aie_toch_m
#define _aie512_tocw _aie_tocw
#define _aie512_tocw_m _aie_tocw_m
#define _aie512_andib _aie_andib
#define _aie512_andib_m _aie_andib_m
#define _aie512_orib _aie_orib
#define _aie512_orib_m _aie_orib_m
#define _aie512_xorib _aie_xorib
#define _aie512_xorib_m _aie_xorib_m
#define _aie512_andb _aie_andb
#define _aie512_andb_m _aie_andb_m
#define _aie512_andh _aie_andh
#define _aie512_andh_m _aie_andh_m
#define _aie512_andw _aie_andw
#define _aie512_andw_m _aie_andw_m
#define _aie512_andnb _aie_andnb
#define _aie512_andnb_m _aie_andnb_m
#define _aie512_andnh _aie_andnh
#define _aie512_andnh_m _aie_andnh_m
#define _aie512_andnw _aie_andnw
#define _aie512_andnw_m _aie_andnw_m
#define _aie512_orb _aie_orb
#define _aie512_orb_m _aie_orb_m
#define _aie512_orh _aie_orh
#define _aie512_orh_m _aie_orh_m
#define _aie512_orw _aie_orw
#define _aie512_orw_m _aie_orw_m
#define _aie512_ornb _aie_ornb
#define _aie512_ornb_m _aie_ornb_m
#define _aie512_ornh _aie_ornh
#define _aie512_ornh_m _aie_ornh_m
#define _aie512_ornw _aie_ornw
#define _aie512_ornw_m _aie_ornw_m
#define _aie512_xorb _aie_xorb
#define _aie512_xorb_m _aie_xorb_m
#define _aie512_xorh _aie_xorh
#define _aie512_xorh_m _aie_xorh_m
#define _aie512_xorw _aie_xorw
#define _aie512_xorw_m _aie_xorw_m
#define _aie512_xornb _aie_xornb
#define _aie512_xornb_m _aie_xornb_m
#define _aie512_xornh _aie_xornh
#define _aie512_xornh_m _aie_xornh_m
#define _aie512_xornw _aie_xornw
#define _aie512_xornw_m _aie_xornw_m
#define _aie512_eselb _aie_eselb
#define _aie512_eselh _aie_eselh
#define _aie512_eselw _aie_eselw
#define _aie512_andv _aie_andb
#define _aie512_andnv _aie_andnb
#define _aie512_orv _aie_orb
#define _aie512_ornv _aie_ornb
#define _aie512_xorv _aie_xorb
#define _aie512_xornv _aie_xornb
#define _aie512_bselv _aie_bselv
#define _aie512_faddw _aie_faddw
#define _aie512_faddw_m _aie_faddw_m
#define _aie512_fsubw _aie_fsubw
#define _aie512_fsubw_m _aie_fsubw_m
#define _aie512_fmaddw _aie_fmaddw
#define _aie512_fmaddw_m _aie_fmaddw_m
#define _aie512_fmsubw _aie_fmsubw
#define _aie512_fmsubw_m _aie_fmsubw_m
#define _aie512_fnmaddw _aie_fnmaddw
#define _aie512_fnmaddw_m _aie_fnmaddw_m
#define _aie512_fnmsubw _aie_fnmsubw
#define _aie512_fnmsubw_m _aie_fnmsubw_m
#define _aie512_fmaxw _aie_fmaxw
#define _aie512_fmaxw_m _aie_fmaxw_m
#define _aie512_fminw _aie_fminw
#define _aie512_fminw_m _aie_fminw_m
#define _aie512_fmulw _aie_fmulw
#define _aie512_fmulw_m _aie_fmulw_m
#define _aie512_fcmulrw _aie_fcmulrw
#define _aie512_fcmulrw_m _aie_fcmulrw_m
#define _aie512_fcmuliw _aie_fcmuliw
#define _aie512_fcmuliw_m _aie_fcmuliw_m
#define _aie512_fcaddw _aie_fcaddw
#define _aie512_fcaddw_m _aie_fcaddw_m
#define _aie512_fmaxaw _aie_fmaxaw
#define _aie512_fmaxaw_m _aie_fmaxaw_m
#define _aie512_fminaw _aie_fminaw
#define _aie512_fminaw_m _aie_fminaw_m
#define _aie512_fclassw _aie_fclassw
#define _aie512_fclassw_m _aie_fclassw_m
#define _aie512_faddh _aie_faddh
#define _aie512_faddh_m _aie_faddh_m
#define _aie512_fsubh _aie_fsubh
#define _aie512_fsubh_m _aie_fsubh_m
#define _aie512_fmaxh _aie_fmaxh
#define _aie512_fmaxh_m _aie_fmaxh_m
#define _aie512_fminh _aie_fminh
#define _aie512_fminh_m _aie_fminh_m
#define _aie512_fmulh _aie_fmulh
#define _aie512_fmulh_m _aie_fmulh_m
#define _aie512_fcmulrh _aie_fcmulrh
#define _aie512_fcmulrh_m _aie_fcmulrh_m
#define _aie512_fcmulih _aie_fcmulih
#define _aie512_fcmulih_m _aie_fcmulih_m
#define _aie512_fcaddh _aie_fcaddh
#define _aie512_fcaddh_m _aie_fcaddh_m
#define _aie512_fmaxah _aie_fmaxah
#define _aie512_fmaxah_m _aie_fmaxah_m
#define _aie512_fminah _aie_fminah
#define _aie512_fminah_m _aie_fminah_m
#define _aie512_fclassh _aie_fclassh
#define _aie512_fclassh_m _aie_fclassh_m
#define _aie512_fceqw _aie_fceqw
#define _aie512_fclew _aie_fclew
#define _aie512_fcltw _aie_fcltw
#define _aie512_fcorw _aie_fcorw
#define _aie512_pfceqh _aie_pfceqh
#define _aie512_pfceqh_m _aie_pfceqh_m
#define _aie512_pfceqw _aie_pfceqw
#define _aie512_pfceqw_m _aie_pfceqw_m
#define _aie512_pfcneh _aie_pfcneh
#define _aie512_pfcneh_m _aie_pfcneh_m
#define _aie512_pfcnew _aie_pfcnew
#define _aie512_pfcnew_m _aie_pfcnew_m
#define _aie512_pfcleh _aie_pfcleh
#define _aie512_pfcleh_m _aie_pfcleh_m
#define _aie512_pfclew _aie_pfclew
#define _aie512_pfclew_m _aie_pfclew_m
#define _aie512_pfclth _aie_pfclth
#define _aie512_pfclth_m _aie_pfclth_m
#define _aie512_pfcltw _aie_pfcltw
#define _aie512_pfcltw_m _aie_pfcltw_m
#define _aie512_pfcorh _aie_pfcorh
#define _aie512_pfcorh_m _aie_pfcorh_m
#define _aie512_pfcorw _aie_pfcorw
#define _aie512_pfcorw_m _aie_pfcorw_m
#define _aie512_ffsiw _aie_ffsiw
#define _aie512_ffsiw_m _aie_ffsiw_m
#define _aie512_ffuiw _aie_ffuiw
#define _aie512_ffuiw_m _aie_ffuiw_m
#define _aie512_ftsiw _aie_ftsiw
#define _aie512_ftsiw_m _aie_ftsiw_m
#define _aie512_ftuiw _aie_ftuiw
#define _aie512_ftuiw_m _aie_ftuiw_m
#define _aie512_frintw _aie_frintw
#define _aie512_frintw_m _aie_frintw_m
#define _aie512_ftruncsw _aie_ftruncsw
#define _aie512_ftruncsw_m _aie_ftruncsw_m
#define _aie512_ftruncuw _aie_ftruncuw
#define _aie512_ftruncuw_m _aie_ftruncuw_m
#define _aie512_ffsih _aie_ffsih
#define _aie512_ffsih_m _aie_ffsih_m
#define _aie512_ffuih _aie_ffuih
#define _aie512_ffuih_m _aie_ffuih_m
#define _aie512_ftsih _aie_ftsih
#define _aie512_ftsih_m _aie_ftsih_m
#define _aie512_ftuih _aie_ftuih
#define _aie512_ftuih_m _aie_ftuih_m
#define _aie512_frinth _aie_frinth
#define _aie512_frinth_m _aie_frinth_m
#define _aie512_ftruncsh _aie_ftruncsh
#define _aie512_ftruncsh_m _aie_ftruncsh_m
#define _aie512_ftruncuh _aie_ftruncuh
#define _aie512_ftruncuh_m _aie_ftruncuh_m
#define _aie512_fcvthw _aie_fcvthw
#define _aie512_fcvthw_m _aie_fcvthw_m
#define _aie512_fcvtwh _aie_fcvtwh
#define _aie512_fcvtwh_m _aie_fcvtwh_m
#define _aie512_sllb _aie_sllb
#define _aie512_sllb_m _aie_sllb_m
#define _aie512_sllh _aie_sllh
#define _aie512_sllh_m _aie_sllh_m
#define _aie512_sllw _aie_sllw
#define _aie512_sllw_m _aie_sllw_m
#define _aie512_sllib _aie_sllib
#define _aie512_sllib_m _aie_sllib_m
#define _aie512_sllih _aie_sllih
#define _aie512_sllih_m _aie_sllih_m
#define _aie512_slliw _aie_slliw
#define _aie512_slliw_m _aie_slliw_m
#define _aie512_srab _aie_srab
#define _aie512_srab_m _aie_srab_m
#define _aie512_srah _aie_srah
#define _aie512_srah_m _aie_srah_m
#define _aie512_sraw _aie_sraw
#define _aie512_sraw_m _aie_sraw_m
#define _aie512_sraib _aie_sraib
#define _aie512_sraib_m _aie_sraib_m
#define _aie512_sraih _aie_sraih
#define _aie512_sraih_m _aie_sraih_m
#define _aie512_sraiw _aie_sraiw
#define _aie512_sraiw_m _aie_sraiw_m
#define _aie512_srarb _aie_srarb
#define _aie512_srarb_m _aie_srarb_m
#define _aie512_srarh _aie_srarh
#define _aie512_srarh_m _aie_srarh_m
#define _aie512_srarw _aie_srarw
#define _aie512_srarw_m _aie_srarw_m
#define _aie512_srarib _aie_srarib
#define _aie512_srarib_m _aie_srarib_m
#define _aie512_srarih _aie_srarih
#define _aie512_srarih_m _aie_srarih_m
#define _aie512_srariw _aie_srariw
#define _aie512_srariw_m _aie_srariw_m
#define _aie512_srlb _aie_srlb
#define _aie512_srlb_m _aie_srlb_m
#define _aie512_srlh _aie_srlh
#define _aie512_srlh_m _aie_srlh_m
#define _aie512_srlw _aie_srlw
#define _aie512_srlw_m _aie_srlw_m
#define _aie512_srlib _aie_srlib
#define _aie512_srlib_m _aie_srlib_m
#define _aie512_srlih _aie_srlih
#define _aie512_srlih_m _aie_srlih_m
#define _aie512_srliw _aie_srliw
#define _aie512_srliw_m _aie_srliw_m
#define _aie512_srlrb _aie_srlrb
#define _aie512_srlrb_m _aie_srlrb_m
#define _aie512_srlrh _aie_srlrh
#define _aie512_srlrh_m _aie_srlrh_m
#define _aie512_srlrw _aie_srlrw
#define _aie512_srlrw_m _aie_srlrw_m
#define _aie512_srlrib _aie_srlrib
#define _aie512_srlrib_m _aie_srlrib_m
#define _aie512_srlrih _aie_srlrih
#define _aie512_srlrih_m _aie_srlrih_m
#define _aie512_srlriw _aie_srlriw
#define _aie512_srlriw_m _aie_srlriw_m
#define _aie512_gt1bi _aie_gt1bi
#define _aie512_gt1bi_m _aie_gt1bi_m
#define _aie512_gt2bi _aie_gt2bi
#define _aie512_gt2bi_m _aie_gt2bi_m
#define _aie512_gt4bi _aie_gt4bi
#define _aie512_gt4bi_m _aie_gt4bi_m
#define _aie512_gtb _aie_gtb
#define _aie512_gtb_m _aie_gtb_m
#define _aie512_gth _aie_gth
#define _aie512_gth_m _aie_gth_m
#define _aie512_gt2w _aie_gt2w
#define _aie512_gt2w_m _aie_gt2w_m
#define _aie512_extuwll _aie_extuwll
#define _aie512_extuwll_m _aie_extuwll_m
#define _aie512_extuwlh _aie_extuwlh
#define _aie512_extuwlh_m _aie_extuwlh_m
#define _aie512_extuwhl _aie_extuwhl
#define _aie512_extuwhl_m _aie_extuwhl_m
#define _aie512_extuwhh _aie_extuwhh
#define _aie512_extuwhh_m _aie_extuwhh_m
#define _aie512_extu1bil _aie_extu1bil
#define _aie512_extu1bil_m _aie_extu1bil_m
#define _aie512_extu2bil _aie_extu2bil
#define _aie512_extu2bil_m _aie_extu2bil_m
#define _aie512_extu4bil _aie_extu4bil
#define _aie512_extu4bil_m _aie_extu4bil_m
#define _aie512_extubl _aie_extubl
#define _aie512_extubl_m _aie_extubl_m
#define _aie512_extuhl _aie_extuhl
#define _aie512_extuhl_m _aie_extuhl_m
#define _aie512_extu1bih _aie_extu1bih
#define _aie512_extu1bih_m _aie_extu1bih_m
#define _aie512_extu2bih _aie_extu2bih
#define _aie512_extu2bih_m _aie_extu2bih_m
#define _aie512_extu4bih _aie_extu4bih
#define _aie512_extu4bih_m _aie_extu4bih_m
#define _aie512_extubh _aie_extubh
#define _aie512_extubh_m _aie_extubh_m
#define _aie512_extuhh _aie_extuhh
#define _aie512_extuhh_m _aie_extuhh_m
#define _aie512_exts1bil _aie_exts1bil
#define _aie512_exts1bil_m _aie_exts1bil_m
#define _aie512_exts2bil _aie_exts2bil
#define _aie512_exts2bil_m _aie_exts2bil_m
#define _aie512_exts4bil _aie_exts4bil
#define _aie512_exts4bil_m _aie_exts4bil_m
#define _aie512_extsbl _aie_extsbl
#define _aie512_extsbl_m _aie_extsbl_m
#define _aie512_extshl _aie_extshl
#define _aie512_extshl_m _aie_extshl_m
#define _aie512_exts1bih _aie_exts1bih
#define _aie512_exts1bih_m _aie_exts1bih_m
#define _aie512_exts2bih _aie_exts2bih
#define _aie512_exts2bih_m _aie_exts2bih_m
#define _aie512_exts4bih _aie_exts4bih
#define _aie512_exts4bih_m _aie_exts4bih_m
#define _aie512_extsbh _aie_extsbh
#define _aie512_extsbh_m _aie_extsbh_m
#define _aie512_extshh _aie_extshh
#define _aie512_extshh_m _aie_extshh_m
#define _aie512_extu3bw _aie_extu3bw
#define _aie512_extu3bw_m _aie_extu3bw_m
#define _aie512_gshufw _aie_gshufw
#define _aie512_gshufw_m _aie_gshufw_m
#define _aie512_gshufwb _aie_gshufwb
#define _aie512_gshufwb_m _aie_gshufwb_m
#define _aie512_gshufwb_2 _aie_gshufwb_2
#define _aie512_gshufwb_2_m _aie_gshufwb_2_m
#define _aie512_gshufvb _aie_gshufvb
#define _aie512_gshufvb_m _aie_gshufvb_m
#define _aie512_ilve2bi _aie_ilve2bi
#define _aie512_ilve2bi_m _aie_ilve2bi_m
#define _aie512_ilve4bi _aie_ilve4bi
#define _aie512_ilve4bi_m _aie_ilve4bi_m
#define _aie512_ilveb _aie_ilveb
#define _aie512_ilveb_m _aie_ilveb_m
#define _aie512_ilveh _aie_ilveh
#define _aie512_ilveh_m _aie_ilveh_m
#define _aie512_ilvew _aie_ilvew
#define _aie512_ilvew_m _aie_ilvew_m
#define _aie512_ilved _aie_ilved
#define _aie512_ilved_m _aie_ilved_m
#define _aie512_ilvo2bi _aie_ilvo2bi
#define _aie512_ilvo2bi_m _aie_ilvo2bi_m
#define _aie512_ilvo4bi _aie_ilvo4bi
#define _aie512_ilvo4bi_m _aie_ilvo4bi_m
#define _aie512_ilvob _aie_ilvob
#define _aie512_ilvob_m _aie_ilvob_m
#define _aie512_ilvoh _aie_ilvoh
#define _aie512_ilvoh_m _aie_ilvoh_m
#define _aie512_ilvow _aie_ilvow
#define _aie512_ilvow_m _aie_ilvow_m
#define _aie512_ilvod _aie_ilvod
#define _aie512_ilvod_m _aie_ilvod_m
#define _aie512_bshli _aie_bshli
#define _aie512_bshli_m _aie_bshli_m
#define _aie512_bshri _aie_bshri
#define _aie512_bshri_m _aie_bshri_m
#define _aie512_bshl _aie_bshl
#define _aie512_bshl_m _aie_bshl_m
#define _aie512_bshr _aie_bshr
#define _aie512_bshr_m _aie_bshr_m
#define _aie512_lih _aie_lih
#define _aie512_liw _aie_liw
#define _aie512_liwh _aie_liwh
#define _aie512_liwr _aie_liwr
#define _aie512_mfcpub _aie_mfcpub
#define _aie512_mfcpub_m _aie_mfcpub_m
#define _aie512_mfcpuh _aie_mfcpuh
#define _aie512_mfcpuh_m _aie_mfcpuh_m
#define _aie512_mfcpuw _aie_mfcpuw
#define _aie512_mfcpuw_m _aie_mfcpuw_m
#define _aie512_sumz _aie_sumz
#define _aie512_sumz_m _aie_sumz_m
#define _aie512_mfsumz _aie_mfsumz
#define _aie512_mfsumz_m _aie_mfsumz_m
#define _aie512_mxsum _aie_mxsum
#define _aie512_mxsum_m _aie_mxsum_m
#define _aie512_cmvw _aie_cmvw
#define _aie512_cmvw_m _aie_cmvw_m
#define _aie512_pmaph _aie_pmaph
#define _aie512_pmaph_m _aie_pmaph_m
#define _aie512_pmapw _aie_pmapw
#define _aie512_pmapw_m _aie_pmapw_m
#define _aie512_lavb _aie_lavb
#define _aie512_lavb_m _aie_lavb_m
#define _aie512_lavh _aie_lavh
#define _aie512_lavh_m _aie_lavh_m
#define _aie512_lavw _aie_lavw
#define _aie512_lavw_m _aie_lavw_m
#define _aie512_savb _aie_savb
#define _aie512_savb_m _aie_savb_m
#define _aie512_savh _aie_savh
#define _aie512_savh_m _aie_savh_m
#define _aie512_savw _aie_savw
#define _aie512_savw_m _aie_savw_m
#define _aie512_luvb _aie_luvb
#define _aie512_luvb_m _aie_luvb_m
#define _aie512_luvh _aie_luvh
#define _aie512_luvh_m _aie_luvh_m
#define _aie512_luvw _aie_luvw
#define _aie512_luvw_m _aie_luvw_m
#define _aie512_suvb _aie_suvb
#define _aie512_suvb_m _aie_suvb_m
#define _aie512_suvh _aie_suvh
#define _aie512_suvh_m _aie_suvh_m
#define _aie512_suvw _aie_suvw
#define _aie512_suvw_m _aie_suvw_m
#define _aie512_lutw _aie_lutw
#define _aie512_lutr _aie_lutr
#define _aie512_nnrwr _aie_nnrwr
#define _aie512_nnrrd _aie_nnrrd
#define _aie512_nndwr _aie_nndwr
#define _aie512_nndrd _aie_nndrd
#define _aie512_nncmd _aie_nncmd
#define _aie512_nnmac _aie_nnmac
#elif (__AIE_VECTOR_BITS == 256)
#define _aie256_readvl _aie_readvl
#define _aie256_psubs _aie_psubs
#define _aie256_addr_upd _aie_addr_upd
#define _aie256_addr_upd_offset _aie_addr_upd_offset
#define _aie256_fcvthw_ext _aie_fcvthw_ext
#define _aie256_fcvtwh_ext _aie_fcvtwh_ext
#define _aie256_pnot_b8 _aie_pnot_b8
#define _aie256_pnot_b16 _aie_pnot_b16
#define _aie256_pnot_b32 _aie_pnot_b32
#define _aie256_pand_b8 _aie_pand_b8
#define _aie256_pand_b16 _aie_pand_b16
#define _aie256_pand_b32 _aie_pand_b32
#define _aie256_pnand_b8 _aie_pnand_b8
#define _aie256_pnand_b16 _aie_pnand_b16
#define _aie256_pnand_b32 _aie_pnand_b32
#define _aie256_pandn_b8 _aie_pandn_b8
#define _aie256_pandn_b16 _aie_pandn_b16
#define _aie256_pandn_b32 _aie_pandn_b32
#define _aie256_por_b8 _aie_por_b8
#define _aie256_por_b16 _aie_por_b16
#define _aie256_por_b32 _aie_por_b32
#define _aie256_pnor_b8 _aie_pnor_b8
#define _aie256_pnor_b16 _aie_pnor_b16
#define _aie256_pnor_b32 _aie_pnor_b32
#define _aie256_porn_b8 _aie_porn_b8
#define _aie256_porn_b16 _aie_porn_b16
#define _aie256_porn_b32 _aie_porn_b32
#define _aie256_pxor_b8 _aie_pxor_b8
#define _aie256_pxor_b16 _aie_pxor_b16
#define _aie256_pxor_b32 _aie_pxor_b32
#define _aie256_pxnor_b8 _aie_pxnor_b8
#define _aie256_pxnor_b16 _aie_pxnor_b16
#define _aie256_pxnor_b32 _aie_pxnor_b32
#define _aie256_pcpop_b8 _aie_pcpop_b8
#define _aie256_pcpop_b8_m _aie_pcpop_b8_m
#define _aie256_pcpop_b16 _aie_pcpop_b16
#define _aie256_pcpop_b16_m _aie_pcpop_b16_m
#define _aie256_pcpop_b32 _aie_pcpop_b32
#define _aie256_pcpop_b32_m _aie_pcpop_b32_m
#define _aie256_pfirst_b8 _aie_pfirst_b8
#define _aie256_pfirst_b8_m _aie_pfirst_b8_m
#define _aie256_pfirst_b16 _aie_pfirst_b16
#define _aie256_pfirst_b16_m _aie_pfirst_b16_m
#define _aie256_pfirst_b32 _aie_pfirst_b32
#define _aie256_pfirst_b32_m _aie_pfirst_b32_m
#define _aie256_psbf_b8 _aie_psbf_b8
#define _aie256_psbf_b8_m _aie_psbf_b8_m
#define _aie256_psbf_b16 _aie_psbf_b16
#define _aie256_psbf_b16_m _aie_psbf_b16_m
#define _aie256_psbf_b32 _aie_psbf_b32
#define _aie256_psbf_b32_m _aie_psbf_b32_m
#define _aie256_psif_b8 _aie_psif_b8
#define _aie256_psif_b8_m _aie_psif_b8_m
#define _aie256_psif_b16 _aie_psif_b16
#define _aie256_psif_b16_m _aie_psif_b16_m
#define _aie256_psif_b32 _aie_psif_b32
#define _aie256_psif_b32_m _aie_psif_b32_m
#define _aie256_psof_b8 _aie_psof_b8
#define _aie256_psof_b8_m _aie_psof_b8_m
#define _aie256_psof_b16 _aie_psof_b16
#define _aie256_psof_b16_m _aie_psof_b16_m
#define _aie256_psof_b32 _aie_psof_b32
#define _aie256_psof_b32_m _aie_psof_b32_m
#define _aie256_piotab _aie_piotab
#define _aie256_piotab_m _aie_piotab_m
#define _aie256_piotah _aie_piotah
#define _aie256_piotah_m _aie_piotah_m
#define _aie256_piotaw _aie_piotaw
#define _aie256_piotaw_m _aie_piotaw_m
#define _aie256_pidb _aie_pidb
#define _aie256_pidb_m _aie_pidb_m
#define _aie256_pidh _aie_pidh
#define _aie256_pidh_m _aie_pidh_m
#define _aie256_pidw _aie_pidw
#define _aie256_pidw_m _aie_pidw_m
#define _aie256_pdec_b8 _aie_pdec_b8
#define _aie256_pdec_b16 _aie_pdec_b16
#define _aie256_pdec_b32 _aie_pdec_b32
#define _aie256_pld_b8 _aie_pld_b8
#define _aie256_pld_b16 _aie_pld_b16
#define _aie256_pld_b32 _aie_pld_b32
#define _aie256_psd_b8 _aie_psd_b8
#define _aie256_psd_b16 _aie_psd_b16
#define _aie256_psd_b32 _aie_psd_b32
#define _aie256_ceqb _aie_ceqb
#define _aie256_ceqh _aie_ceqh
#define _aie256_ceqw _aie_ceqw
#define _aie256_ceqzb _aie_ceqzb
#define _aie256_ceqzh _aie_ceqzh
#define _aie256_ceqzw _aie_ceqzw
#define _aie256_clesb _aie_clesb
#define _aie256_clesh _aie_clesh
#define _aie256_clesw _aie_clesw
#define _aie256_cleub _aie_cleub
#define _aie256_cleuh _aie_cleuh
#define _aie256_cleuw _aie_cleuw
#define _aie256_clezb _aie_clezb
#define _aie256_clezh _aie_clezh
#define _aie256_clezw _aie_clezw
#define _aie256_cltsb _aie_cltsb
#define _aie256_cltsh _aie_cltsh
#define _aie256_cltsw _aie_cltsw
#define _aie256_cltub _aie_cltub
#define _aie256_cltuh _aie_cltuh
#define _aie256_cltuw _aie_cltuw
#define _aie256_cltzb _aie_cltzb
#define _aie256_cltzh _aie_cltzh
#define _aie256_cltzw _aie_cltzw
#define _aie256_pceqb _aie_pceqb
#define _aie256_pceqb_m _aie_pceqb_m
#define _aie256_pceqh _aie_pceqh
#define _aie256_pceqh_m _aie_pceqh_m
#define _aie256_pceqw _aie_pceqw
#define _aie256_pceqw_m _aie_pceqw_m
#define _aie256_pceqzb _aie_pceqzb
#define _aie256_pceqzb_m _aie_pceqzb_m
#define _aie256_pceqzh _aie_pceqzh
#define _aie256_pceqzh_m _aie_pceqzh_m
#define _aie256_pceqzw _aie_pceqzw
#define _aie256_pceqzw_m _aie_pceqzw_m
#define _aie256_pcneb _aie_pcneb
#define _aie256_pcneb_m _aie_pcneb_m
#define _aie256_pcneh _aie_pcneh
#define _aie256_pcneh_m _aie_pcneh_m
#define _aie256_pcnew _aie_pcnew
#define _aie256_pcnew_m _aie_pcnew_m
#define _aie256_pcnezb _aie_pcnezb
#define _aie256_pcnezb_m _aie_pcnezb_m
#define _aie256_pcnezh _aie_pcnezh
#define _aie256_pcnezh_m _aie_pcnezh_m
#define _aie256_pcnezw _aie_pcnezw
#define _aie256_pcnezw_m _aie_pcnezw_m
#define _aie256_pclesb _aie_pclesb
#define _aie256_pclesb_m _aie_pclesb_m
#define _aie256_pclesh _aie_pclesh
#define _aie256_pclesh_m _aie_pclesh_m
#define _aie256_pclesw _aie_pclesw
#define _aie256_pclesw_m _aie_pclesw_m
#define _aie256_pcleub _aie_pcleub
#define _aie256_pcleub_m _aie_pcleub_m
#define _aie256_pcleuh _aie_pcleuh
#define _aie256_pcleuh_m _aie_pcleuh_m
#define _aie256_pcleuw _aie_pcleuw
#define _aie256_pcleuw_m _aie_pcleuw_m
#define _aie256_pclezb _aie_pclezb
#define _aie256_pclezb_m _aie_pclezb_m
#define _aie256_pclezh _aie_pclezh
#define _aie256_pclezh_m _aie_pclezh_m
#define _aie256_pclezw _aie_pclezw
#define _aie256_pclezw_m _aie_pclezw_m
#define _aie256_pcltsb _aie_pcltsb
#define _aie256_pcltsb_m _aie_pcltsb_m
#define _aie256_pcltsh _aie_pcltsh
#define _aie256_pcltsh_m _aie_pcltsh_m
#define _aie256_pcltsw _aie_pcltsw
#define _aie256_pcltsw_m _aie_pcltsw_m
#define _aie256_pcltub _aie_pcltub
#define _aie256_pcltub_m _aie_pcltub_m
#define _aie256_pcltuh _aie_pcltuh
#define _aie256_pcltuh_m _aie_pcltuh_m
#define _aie256_pcltuw _aie_pcltuw
#define _aie256_pcltuw_m _aie_pcltuw_m
#define _aie256_pcltzb _aie_pcltzb
#define _aie256_pcltzb_m _aie_pcltzb_m
#define _aie256_pcltzh _aie_pcltzh
#define _aie256_pcltzh_m _aie_pcltzh_m
#define _aie256_pcltzw _aie_pcltzw
#define _aie256_pcltzw_m _aie_pcltzw_m
#define _aie256_addb _aie_addb
#define _aie256_addb_m _aie_addb_m
#define _aie256_addh _aie_addh
#define _aie256_addh_m _aie_addh_m
#define _aie256_addw _aie_addw
#define _aie256_addw_m _aie_addw_m
#define _aie256_subb _aie_subb
#define _aie256_subb_m _aie_subb_m
#define _aie256_subh _aie_subh
#define _aie256_subh_m _aie_subh_m
#define _aie256_subw _aie_subw
#define _aie256_subw_m _aie_subw_m
#define _aie256_waddsbl _aie_waddsbl
#define _aie256_waddsbl_m _aie_waddsbl_m
#define _aie256_waddsbh _aie_waddsbh
#define _aie256_waddsbh_m _aie_waddsbh_m
#define _aie256_waddshl _aie_waddshl
#define _aie256_waddshl_m _aie_waddshl_m
#define _aie256_waddshh _aie_waddshh
#define _aie256_waddshh_m _aie_waddshh_m
#define _aie256_waddubl _aie_waddubl
#define _aie256_waddubl_m _aie_waddubl_m
#define _aie256_waddubh _aie_waddubh
#define _aie256_waddubh_m _aie_waddubh_m
#define _aie256_wadduhl _aie_wadduhl
#define _aie256_wadduhl_m _aie_wadduhl_m
#define _aie256_wadduhh _aie_wadduhh
#define _aie256_wadduhh_m _aie_wadduhh_m
#define _aie256_wsubsbl _aie_wsubsbl
#define _aie256_wsubsbl_m _aie_wsubsbl_m
#define _aie256_wsubsbh _aie_wsubsbh
#define _aie256_wsubsbh_m _aie_wsubsbh_m
#define _aie256_wsubshl _aie_wsubshl
#define _aie256_wsubshl_m _aie_wsubshl_m
#define _aie256_wsubshh _aie_wsubshh
#define _aie256_wsubshh_m _aie_wsubshh_m
#define _aie256_wsububl _aie_wsububl
#define _aie256_wsububl_m _aie_wsububl_m
#define _aie256_wsububh _aie_wsububh
#define _aie256_wsububh_m _aie_wsububh_m
#define _aie256_wsubuhl _aie_wsubuhl
#define _aie256_wsubuhl_m _aie_wsubuhl_m
#define _aie256_wsubuhh _aie_wsubuhh
#define _aie256_wsubuhh_m _aie_wsubuhh_m
#define _aie256_absb _aie_absb
#define _aie256_absb_m _aie_absb_m
#define _aie256_absh _aie_absh
#define _aie256_absh_m _aie_absh_m
#define _aie256_absw _aie_absw
#define _aie256_absw_m _aie_absw_m
#define _aie256_mulb _aie_mulb
#define _aie256_mulb_m _aie_mulb_m
#define _aie256_mulh _aie_mulh
#define _aie256_mulh_m _aie_mulh_m
#define _aie256_mulw _aie_mulw
#define _aie256_mulw_m _aie_mulw_m
#define _aie256_smulbe _aie_smulbe
#define _aie256_smulbe_m _aie_smulbe_m
#define _aie256_smulbo _aie_smulbo
#define _aie256_smulbo_m _aie_smulbo_m
#define _aie256_smulhe _aie_smulhe
#define _aie256_smulhe_m _aie_smulhe_m
#define _aie256_smulho _aie_smulho
#define _aie256_smulho_m _aie_smulho_m
#define _aie256_umulbe _aie_umulbe
#define _aie256_umulbe_m _aie_umulbe_m
#define _aie256_umulbo _aie_umulbo
#define _aie256_umulbo_m _aie_umulbo_m
#define _aie256_umulhe _aie_umulhe
#define _aie256_umulhe_m _aie_umulhe_m
#define _aie256_umulho _aie_umulho
#define _aie256_umulho_m _aie_umulho_m
#define _aie256_wsmulbl _aie_wsmulbl
#define _aie256_wsmulbl_m _aie_wsmulbl_m
#define _aie256_wsmulbh _aie_wsmulbh
#define _aie256_wsmulbh_m _aie_wsmulbh_m
#define _aie256_wsmulhl _aie_wsmulhl
#define _aie256_wsmulhl_m _aie_wsmulhl_m
#define _aie256_wsmulhh _aie_wsmulhh
#define _aie256_wsmulhh_m _aie_wsmulhh_m
#define _aie256_wumulbl _aie_wumulbl
#define _aie256_wumulbl_m _aie_wumulbl_m
#define _aie256_wumulbh _aie_wumulbh
#define _aie256_wumulbh_m _aie_wumulbh_m
#define _aie256_wumulhl _aie_wumulhl
#define _aie256_wumulhl_m _aie_wumulhl_m
#define _aie256_wumulhh _aie_wumulhh
#define _aie256_wumulhh_m _aie_wumulhh_m
#define _aie256_mlaw _aie_mlaw
#define _aie256_mlaw_m _aie_mlaw_m
#define _aie256_mlsw _aie_mlsw
#define _aie256_mlsw_m _aie_mlsw_m
#define _aie256_smlahe _aie_smlahe
#define _aie256_smlahe_m _aie_smlahe_m
#define _aie256_smlaho _aie_smlaho
#define _aie256_smlaho_m _aie_smlaho_m
#define _aie256_smlshe _aie_smlshe
#define _aie256_smlshe_m _aie_smlshe_m
#define _aie256_smlsho _aie_smlsho
#define _aie256_smlsho_m _aie_smlsho_m
#define _aie256_wsmlahl _aie_wsmlahl
#define _aie256_wsmlahl_m _aie_wsmlahl_m
#define _aie256_wsmlahh _aie_wsmlahh
#define _aie256_wsmlahh_m _aie_wsmlahh_m
#define _aie256_wsmlshl _aie_wsmlshl
#define _aie256_wsmlshl_m _aie_wsmlshl_m
#define _aie256_wsmlshh _aie_wsmlshh
#define _aie256_wsmlshh_m _aie_wsmlshh_m
#define _aie256_maxab _aie_maxab
#define _aie256_maxab_m _aie_maxab_m
#define _aie256_maxah _aie_maxah
#define _aie256_maxah_m _aie_maxah_m
#define _aie256_maxaw _aie_maxaw
#define _aie256_maxaw_m _aie_maxaw_m
#define _aie256_maxsb _aie_maxsb
#define _aie256_maxsb_m _aie_maxsb_m
#define _aie256_maxsh _aie_maxsh
#define _aie256_maxsh_m _aie_maxsh_m
#define _aie256_maxsw _aie_maxsw
#define _aie256_maxsw_m _aie_maxsw_m
#define _aie256_maxub _aie_maxub
#define _aie256_maxub_m _aie_maxub_m
#define _aie256_maxuh _aie_maxuh
#define _aie256_maxuh_m _aie_maxuh_m
#define _aie256_maxuw _aie_maxuw
#define _aie256_maxuw_m _aie_maxuw_m
#define _aie256_maxu2bi _aie_maxu2bi
#define _aie256_maxu2bi_m _aie_maxu2bi_m
#define _aie256_maxu4bi _aie_maxu4bi
#define _aie256_maxu4bi_m _aie_maxu4bi_m
#define _aie256_minab _aie_minab
#define _aie256_minab_m _aie_minab_m
#define _aie256_minah _aie_minah
#define _aie256_minah_m _aie_minah_m
#define _aie256_minaw _aie_minaw
#define _aie256_minaw_m _aie_minaw_m
#define _aie256_minsb _aie_minsb
#define _aie256_minsb_m _aie_minsb_m
#define _aie256_minsh _aie_minsh
#define _aie256_minsh_m _aie_minsh_m
#define _aie256_minsw _aie_minsw
#define _aie256_minsw_m _aie_minsw_m
#define _aie256_minub _aie_minub
#define _aie256_minub_m _aie_minub_m
#define _aie256_minuh _aie_minuh
#define _aie256_minuh_m _aie_minuh_m
#define _aie256_minuw _aie_minuw
#define _aie256_minuw_m _aie_minuw_m
#define _aie256_minu2bi _aie_minu2bi
#define _aie256_minu2bi_m _aie_minu2bi_m
#define _aie256_minu4bi _aie_minu4bi
#define _aie256_minu4bi_m _aie_minu4bi_m
#define _aie256_satsshb _aie_satsshb
#define _aie256_satsshb_m _aie_satsshb_m
#define _aie256_satsswb _aie_satsswb
#define _aie256_satsswb_m _aie_satsswb_m
#define _aie256_satsswh _aie_satsswh
#define _aie256_satsswh_m _aie_satsswh_m
#define _aie256_satsub2bi _aie_satsub2bi
#define _aie256_satsub2bi_m _aie_satsub2bi_m
#define _aie256_satsub4bi _aie_satsub4bi
#define _aie256_satsub4bi_m _aie_satsub4bi_m
#define _aie256_satsuh2bi _aie_satsuh2bi
#define _aie256_satsuh2bi_m _aie_satsuh2bi_m
#define _aie256_satsuh4bi _aie_satsuh4bi
#define _aie256_satsuh4bi_m _aie_satsuh4bi_m
#define _aie256_satsuhb _aie_satsuhb
#define _aie256_satsuhb_m _aie_satsuhb_m
#define _aie256_satsuw2bi _aie_satsuw2bi
#define _aie256_satsuw2bi_m _aie_satsuw2bi_m
#define _aie256_satsuw4bi _aie_satsuw4bi
#define _aie256_satsuw4bi_m _aie_satsuw4bi_m
#define _aie256_satsuwb _aie_satsuwb
#define _aie256_satsuwb_m _aie_satsuwb_m
#define _aie256_satsuwh _aie_satsuwh
#define _aie256_satsuwh_m _aie_satsuwh_m
#define _aie256_satuub2bi _aie_satuub2bi
#define _aie256_satuub2bi_m _aie_satuub2bi_m
#define _aie256_satuub4bi _aie_satuub4bi
#define _aie256_satuub4bi_m _aie_satuub4bi_m
#define _aie256_satuuh2bi _aie_satuuh2bi
#define _aie256_satuuh2bi_m _aie_satuuh2bi_m
#define _aie256_satuuh4bi _aie_satuuh4bi
#define _aie256_satuuh4bi_m _aie_satuuh4bi_m
#define _aie256_satuuhb _aie_satuuhb
#define _aie256_satuuhb_m _aie_satuuhb_m
#define _aie256_satuuw4bi _aie_satuuw4bi
#define _aie256_satuuw4bi_m _aie_satuuw4bi_m
#define _aie256_satuuwb _aie_satuuwb
#define _aie256_satuuwb_m _aie_satuuwb_m
#define _aie256_satuuwh _aie_satuuwh
#define _aie256_satuuwh_m _aie_satuuwh_m
#define _aie256_tocb _aie_tocb
#define _aie256_tocb_m _aie_tocb_m
#define _aie256_toch _aie_toch
#define _aie256_toch_m _aie_toch_m
#define _aie256_tocw _aie_tocw
#define _aie256_tocw_m _aie_tocw_m
#define _aie256_andib _aie_andib
#define _aie256_andib_m _aie_andib_m
#define _aie256_orib _aie_orib
#define _aie256_orib_m _aie_orib_m
#define _aie256_xorib _aie_xorib
#define _aie256_xorib_m _aie_xorib_m
#define _aie256_andb _aie_andb
#define _aie256_andb_m _aie_andb_m
#define _aie256_andh _aie_andh
#define _aie256_andh_m _aie_andh_m
#define _aie256_andw _aie_andw
#define _aie256_andw_m _aie_andw_m
#define _aie256_andnb _aie_andnb
#define _aie256_andnb_m _aie_andnb_m
#define _aie256_andnh _aie_andnh
#define _aie256_andnh_m _aie_andnh_m
#define _aie256_andnw _aie_andnw
#define _aie256_andnw_m _aie_andnw_m
#define _aie256_orb _aie_orb
#define _aie256_orb_m _aie_orb_m
#define _aie256_orh _aie_orh
#define _aie256_orh_m _aie_orh_m
#define _aie256_orw _aie_orw
#define _aie256_orw_m _aie_orw_m
#define _aie256_ornb _aie_ornb
#define _aie256_ornb_m _aie_ornb_m
#define _aie256_ornh _aie_ornh
#define _aie256_ornh_m _aie_ornh_m
#define _aie256_ornw _aie_ornw
#define _aie256_ornw_m _aie_ornw_m
#define _aie256_xorb _aie_xorb
#define _aie256_xorb_m _aie_xorb_m
#define _aie256_xorh _aie_xorh
#define _aie256_xorh_m _aie_xorh_m
#define _aie256_xorw _aie_xorw
#define _aie256_xorw_m _aie_xorw_m
#define _aie256_xornb _aie_xornb
#define _aie256_xornb_m _aie_xornb_m
#define _aie256_xornh _aie_xornh
#define _aie256_xornh_m _aie_xornh_m
#define _aie256_xornw _aie_xornw
#define _aie256_xornw_m _aie_xornw_m
#define _aie256_eselb _aie_eselb
#define _aie256_eselh _aie_eselh
#define _aie256_eselw _aie_eselw
#define _aie256_andv _aie_andb
#define _aie256_andnv _aie_andnb
#define _aie256_orv _aie_orb
#define _aie256_ornv _aie_ornb
#define _aie256_xorv _aie_xorb
#define _aie256_xornv _aie_xornb
#define _aie256_bselv _aie_bselv
#define _aie256_faddw _aie_faddw
#define _aie256_faddw_m _aie_faddw_m
#define _aie256_fsubw _aie_fsubw
#define _aie256_fsubw_m _aie_fsubw_m
#define _aie256_fmaddw _aie_fmaddw
#define _aie256_fmaddw_m _aie_fmaddw_m
#define _aie256_fmsubw _aie_fmsubw
#define _aie256_fmsubw_m _aie_fmsubw_m
#define _aie256_fnmaddw _aie_fnmaddw
#define _aie256_fnmaddw_m _aie_fnmaddw_m
#define _aie256_fnmsubw _aie_fnmsubw
#define _aie256_fnmsubw_m _aie_fnmsubw_m
#define _aie256_fmaxw _aie_fmaxw
#define _aie256_fmaxw_m _aie_fmaxw_m
#define _aie256_fminw _aie_fminw
#define _aie256_fminw_m _aie_fminw_m
#define _aie256_fmulw _aie_fmulw
#define _aie256_fmulw_m _aie_fmulw_m
#define _aie256_fcmulrw _aie_fcmulrw
#define _aie256_fcmulrw_m _aie_fcmulrw_m
#define _aie256_fcmuliw _aie_fcmuliw
#define _aie256_fcmuliw_m _aie_fcmuliw_m
#define _aie256_fcaddw _aie_fcaddw
#define _aie256_fcaddw_m _aie_fcaddw_m
#define _aie256_fmaxaw _aie_fmaxaw
#define _aie256_fmaxaw_m _aie_fmaxaw_m
#define _aie256_fminaw _aie_fminaw
#define _aie256_fminaw_m _aie_fminaw_m
#define _aie256_fclassw _aie_fclassw
#define _aie256_fclassw_m _aie_fclassw_m
#define _aie256_faddh _aie_faddh
#define _aie256_faddh_m _aie_faddh_m
#define _aie256_fsubh _aie_fsubh
#define _aie256_fsubh_m _aie_fsubh_m
#define _aie256_fmaxh _aie_fmaxh
#define _aie256_fmaxh_m _aie_fmaxh_m
#define _aie256_fminh _aie_fminh
#define _aie256_fminh_m _aie_fminh_m
#define _aie256_fmulh _aie_fmulh
#define _aie256_fmulh_m _aie_fmulh_m
#define _aie256_fcmulrh _aie_fcmulrh
#define _aie256_fcmulrh_m _aie_fcmulrh_m
#define _aie256_fcmulih _aie_fcmulih
#define _aie256_fcmulih_m _aie_fcmulih_m
#define _aie256_fcaddh _aie_fcaddh
#define _aie256_fcaddh_m _aie_fcaddh_m
#define _aie256_fmaxah _aie_fmaxah
#define _aie256_fmaxah_m _aie_fmaxah_m
#define _aie256_fminah _aie_fminah
#define _aie256_fminah_m _aie_fminah_m
#define _aie256_fclassh _aie_fclassh
#define _aie256_fclassh_m _aie_fclassh_m
#define _aie256_fceqw _aie_fceqw
#define _aie256_fclew _aie_fclew
#define _aie256_fcltw _aie_fcltw
#define _aie256_fcorw _aie_fcorw
#define _aie256_pfceqh _aie_pfceqh
#define _aie256_pfceqh_m _aie_pfceqh_m
#define _aie256_pfceqw _aie_pfceqw
#define _aie256_pfceqw_m _aie_pfceqw_m
#define _aie256_pfcneh _aie_pfcneh
#define _aie256_pfcneh_m _aie_pfcneh_m
#define _aie256_pfcnew _aie_pfcnew
#define _aie256_pfcnew_m _aie_pfcnew_m
#define _aie256_pfcleh _aie_pfcleh
#define _aie256_pfcleh_m _aie_pfcleh_m
#define _aie256_pfclew _aie_pfclew
#define _aie256_pfclew_m _aie_pfclew_m
#define _aie256_pfclth _aie_pfclth
#define _aie256_pfclth_m _aie_pfclth_m
#define _aie256_pfcltw _aie_pfcltw
#define _aie256_pfcltw_m _aie_pfcltw_m
#define _aie256_pfcorh _aie_pfcorh
#define _aie256_pfcorh_m _aie_pfcorh_m
#define _aie256_pfcorw _aie_pfcorw
#define _aie256_pfcorw_m _aie_pfcorw_m
#define _aie256_ffsiw _aie_ffsiw
#define _aie256_ffsiw_m _aie_ffsiw_m
#define _aie256_ffuiw _aie_ffuiw
#define _aie256_ffuiw_m _aie_ffuiw_m
#define _aie256_ftsiw _aie_ftsiw
#define _aie256_ftsiw_m _aie_ftsiw_m
#define _aie256_ftuiw _aie_ftuiw
#define _aie256_ftuiw_m _aie_ftuiw_m
#define _aie256_frintw _aie_frintw
#define _aie256_frintw_m _aie_frintw_m
#define _aie256_ftruncsw _aie_ftruncsw
#define _aie256_ftruncsw_m _aie_ftruncsw_m
#define _aie256_ftruncuw _aie_ftruncuw
#define _aie256_ftruncuw_m _aie_ftruncuw_m
#define _aie256_ffsih _aie_ffsih
#define _aie256_ffsih_m _aie_ffsih_m
#define _aie256_ffuih _aie_ffuih
#define _aie256_ffuih_m _aie_ffuih_m
#define _aie256_ftsih _aie_ftsih
#define _aie256_ftsih_m _aie_ftsih_m
#define _aie256_ftuih _aie_ftuih
#define _aie256_ftuih_m _aie_ftuih_m
#define _aie256_frinth _aie_frinth
#define _aie256_frinth_m _aie_frinth_m
#define _aie256_ftruncsh _aie_ftruncsh
#define _aie256_ftruncsh_m _aie_ftruncsh_m
#define _aie256_ftruncuh _aie_ftruncuh
#define _aie256_ftruncuh_m _aie_ftruncuh_m
#define _aie256_fcvthw _aie_fcvthw
#define _aie256_fcvthw_m _aie_fcvthw_m
#define _aie256_fcvtwh _aie_fcvtwh
#define _aie256_fcvtwh_m _aie_fcvtwh_m
#define _aie256_sllb _aie_sllb
#define _aie256_sllb_m _aie_sllb_m
#define _aie256_sllh _aie_sllh
#define _aie256_sllh_m _aie_sllh_m
#define _aie256_sllw _aie_sllw
#define _aie256_sllw_m _aie_sllw_m
#define _aie256_sllib _aie_sllib
#define _aie256_sllib_m _aie_sllib_m
#define _aie256_sllih _aie_sllih
#define _aie256_sllih_m _aie_sllih_m
#define _aie256_slliw _aie_slliw
#define _aie256_slliw_m _aie_slliw_m
#define _aie256_srab _aie_srab
#define _aie256_srab_m _aie_srab_m
#define _aie256_srah _aie_srah
#define _aie256_srah_m _aie_srah_m
#define _aie256_sraw _aie_sraw
#define _aie256_sraw_m _aie_sraw_m
#define _aie256_sraib _aie_sraib
#define _aie256_sraib_m _aie_sraib_m
#define _aie256_sraih _aie_sraih
#define _aie256_sraih_m _aie_sraih_m
#define _aie256_sraiw _aie_sraiw
#define _aie256_sraiw_m _aie_sraiw_m
#define _aie256_srarb _aie_srarb
#define _aie256_srarb_m _aie_srarb_m
#define _aie256_srarh _aie_srarh
#define _aie256_srarh_m _aie_srarh_m
#define _aie256_srarw _aie_srarw
#define _aie256_srarw_m _aie_srarw_m
#define _aie256_srarib _aie_srarib
#define _aie256_srarib_m _aie_srarib_m
#define _aie256_srarih _aie_srarih
#define _aie256_srarih_m _aie_srarih_m
#define _aie256_srariw _aie_srariw
#define _aie256_srariw_m _aie_srariw_m
#define _aie256_srlb _aie_srlb
#define _aie256_srlb_m _aie_srlb_m
#define _aie256_srlh _aie_srlh
#define _aie256_srlh_m _aie_srlh_m
#define _aie256_srlw _aie_srlw
#define _aie256_srlw_m _aie_srlw_m
#define _aie256_srlib _aie_srlib
#define _aie256_srlib_m _aie_srlib_m
#define _aie256_srlih _aie_srlih
#define _aie256_srlih_m _aie_srlih_m
#define _aie256_srliw _aie_srliw
#define _aie256_srliw_m _aie_srliw_m
#define _aie256_srlrb _aie_srlrb
#define _aie256_srlrb_m _aie_srlrb_m
#define _aie256_srlrh _aie_srlrh
#define _aie256_srlrh_m _aie_srlrh_m
#define _aie256_srlrw _aie_srlrw
#define _aie256_srlrw_m _aie_srlrw_m
#define _aie256_srlrib _aie_srlrib
#define _aie256_srlrib_m _aie_srlrib_m
#define _aie256_srlrih _aie_srlrih
#define _aie256_srlrih_m _aie_srlrih_m
#define _aie256_srlriw _aie_srlriw
#define _aie256_srlriw_m _aie_srlriw_m
#define _aie256_gt1bi _aie_gt1bi
#define _aie256_gt1bi_m _aie_gt1bi_m
#define _aie256_gt2bi _aie_gt2bi
#define _aie256_gt2bi_m _aie_gt2bi_m
#define _aie256_gt4bi _aie_gt4bi
#define _aie256_gt4bi_m _aie_gt4bi_m
#define _aie256_gtb _aie_gtb
#define _aie256_gtb_m _aie_gtb_m
#define _aie256_gth _aie_gth
#define _aie256_gth_m _aie_gth_m
#define _aie256_gt2w _aie_gt2w
#define _aie256_gt2w_m _aie_gt2w_m
#define _aie256_extuwll _aie_extuwll
#define _aie256_extuwll_m _aie_extuwll_m
#define _aie256_extuwlh _aie_extuwlh
#define _aie256_extuwlh_m _aie_extuwlh_m
#define _aie256_extuwhl _aie_extuwhl
#define _aie256_extuwhl_m _aie_extuwhl_m
#define _aie256_extuwhh _aie_extuwhh
#define _aie256_extuwhh_m _aie_extuwhh_m
#define _aie256_extu1bil _aie_extu1bil
#define _aie256_extu1bil_m _aie_extu1bil_m
#define _aie256_extu2bil _aie_extu2bil
#define _aie256_extu2bil_m _aie_extu2bil_m
#define _aie256_extu4bil _aie_extu4bil
#define _aie256_extu4bil_m _aie_extu4bil_m
#define _aie256_extubl _aie_extubl
#define _aie256_extubl_m _aie_extubl_m
#define _aie256_extuhl _aie_extuhl
#define _aie256_extuhl_m _aie_extuhl_m
#define _aie256_extu1bih _aie_extu1bih
#define _aie256_extu1bih_m _aie_extu1bih_m
#define _aie256_extu2bih _aie_extu2bih
#define _aie256_extu2bih_m _aie_extu2bih_m
#define _aie256_extu4bih _aie_extu4bih
#define _aie256_extu4bih_m _aie_extu4bih_m
#define _aie256_extubh _aie_extubh
#define _aie256_extubh_m _aie_extubh_m
#define _aie256_extuhh _aie_extuhh
#define _aie256_extuhh_m _aie_extuhh_m
#define _aie256_exts1bil _aie_exts1bil
#define _aie256_exts1bil_m _aie_exts1bil_m
#define _aie256_exts2bil _aie_exts2bil
#define _aie256_exts2bil_m _aie_exts2bil_m
#define _aie256_exts4bil _aie_exts4bil
#define _aie256_exts4bil_m _aie_exts4bil_m
#define _aie256_extsbl _aie_extsbl
#define _aie256_extsbl_m _aie_extsbl_m
#define _aie256_extshl _aie_extshl
#define _aie256_extshl_m _aie_extshl_m
#define _aie256_exts1bih _aie_exts1bih
#define _aie256_exts1bih_m _aie_exts1bih_m
#define _aie256_exts2bih _aie_exts2bih
#define _aie256_exts2bih_m _aie_exts2bih_m
#define _aie256_exts4bih _aie_exts4bih
#define _aie256_exts4bih_m _aie_exts4bih_m
#define _aie256_extsbh _aie_extsbh
#define _aie256_extsbh_m _aie_extsbh_m
#define _aie256_extshh _aie_extshh
#define _aie256_extshh_m _aie_extshh_m
#define _aie256_extu3bw _aie_extu3bw
#define _aie256_extu3bw_m _aie_extu3bw_m
#define _aie256_gshufw _aie_gshufw
#define _aie256_gshufw_m _aie_gshufw_m
#define _aie256_gshufwb _aie_gshufwb
#define _aie256_gshufwb_m _aie_gshufwb_m
#define _aie256_gshufwb_2 _aie_gshufwb_2
#define _aie256_gshufwb_2_m _aie_gshufwb_2_m
#define _aie256_gshufvb _aie_gshufvb
#define _aie256_gshufvb_m _aie_gshufvb_m
#define _aie256_ilve2bi _aie_ilve2bi
#define _aie256_ilve2bi_m _aie_ilve2bi_m
#define _aie256_ilve4bi _aie_ilve4bi
#define _aie256_ilve4bi_m _aie_ilve4bi_m
#define _aie256_ilveb _aie_ilveb
#define _aie256_ilveb_m _aie_ilveb_m
#define _aie256_ilveh _aie_ilveh
#define _aie256_ilveh_m _aie_ilveh_m
#define _aie256_ilvew _aie_ilvew
#define _aie256_ilvew_m _aie_ilvew_m
#define _aie256_ilved _aie_ilved
#define _aie256_ilved_m _aie_ilved_m
#define _aie256_ilvo2bi _aie_ilvo2bi
#define _aie256_ilvo2bi_m _aie_ilvo2bi_m
#define _aie256_ilvo4bi _aie_ilvo4bi
#define _aie256_ilvo4bi_m _aie_ilvo4bi_m
#define _aie256_ilvob _aie_ilvob
#define _aie256_ilvob_m _aie_ilvob_m
#define _aie256_ilvoh _aie_ilvoh
#define _aie256_ilvoh_m _aie_ilvoh_m
#define _aie256_ilvow _aie_ilvow
#define _aie256_ilvow_m _aie_ilvow_m
#define _aie256_ilvod _aie_ilvod
#define _aie256_ilvod_m _aie_ilvod_m
#define _aie256_bshli _aie_bshli
#define _aie256_bshli_m _aie_bshli_m
#define _aie256_bshri _aie_bshri
#define _aie256_bshri_m _aie_bshri_m
#define _aie256_bshl _aie_bshl
#define _aie256_bshl_m _aie_bshl_m
#define _aie256_bshr _aie_bshr
#define _aie256_bshr_m _aie_bshr_m
#define _aie256_lih _aie_lih
#define _aie256_liw _aie_liw
#define _aie256_liwh _aie_liwh
#define _aie256_liwr _aie_liwr
#define _aie256_mfcpub _aie_mfcpub
#define _aie256_mfcpub_m _aie_mfcpub_m
#define _aie256_mfcpuh _aie_mfcpuh
#define _aie256_mfcpuh_m _aie_mfcpuh_m
#define _aie256_mfcpuw _aie_mfcpuw
#define _aie256_mfcpuw_m _aie_mfcpuw_m
#define _aie256_sumz _aie_sumz
#define _aie256_sumz_m _aie_sumz_m
#define _aie256_mfsumz _aie_mfsumz
#define _aie256_mfsumz_m _aie_mfsumz_m
#define _aie256_mxsum _aie_mxsum
#define _aie256_mxsum_m _aie_mxsum_m
#define _aie256_cmvw _aie_cmvw
#define _aie256_cmvw_m _aie_cmvw_m
#define _aie256_pmaph _aie_pmaph
#define _aie256_pmaph_m _aie_pmaph_m
#define _aie256_pmapw _aie_pmapw
#define _aie256_pmapw_m _aie_pmapw_m
#define _aie256_lavb _aie_lavb
#define _aie256_lavb_m _aie_lavb_m
#define _aie256_lavh _aie_lavh
#define _aie256_lavh_m _aie_lavh_m
#define _aie256_lavw _aie_lavw
#define _aie256_lavw_m _aie_lavw_m
#define _aie256_savb _aie_savb
#define _aie256_savb_m _aie_savb_m
#define _aie256_savh _aie_savh
#define _aie256_savh_m _aie_savh_m
#define _aie256_savw _aie_savw
#define _aie256_savw_m _aie_savw_m
#define _aie256_luvb _aie_luvb
#define _aie256_luvb_m _aie_luvb_m
#define _aie256_luvh _aie_luvh
#define _aie256_luvh_m _aie_luvh_m
#define _aie256_luvw _aie_luvw
#define _aie256_luvw_m _aie_luvw_m
#define _aie256_suvb _aie_suvb
#define _aie256_suvb_m _aie_suvb_m
#define _aie256_suvh _aie_suvh
#define _aie256_suvh_m _aie_suvh_m
#define _aie256_suvw _aie_suvw
#define _aie256_suvw_m _aie_suvw_m
#define _aie256_lutw _aie_lutw
#define _aie256_lutr _aie_lutr
#define _aie256_nnrwr _aie_nnrwr
#define _aie256_nnrrd _aie_nnrrd
#define _aie256_nndwr _aie_nndwr
#define _aie256_nndrd _aie_nndrd
#define _aie256_nncmd _aie_nncmd
#define _aie256_nnmac _aie_nnmac
#elif (__AIE_VECTOR_BITS == 128)
#define _aie128_readvl _aie_readvl
#define _aie128_psubs _aie_psubs
#define _aie128_addr_upd _aie_addr_upd
#define _aie128_addr_upd_offset _aie_addr_upd_offset
#define _aie128_fcvthw_ext _aie_fcvthw_ext
#define _aie128_fcvtwh_ext _aie_fcvtwh_ext
#define _aie128_pnot_b8 _aie_pnot_b8
#define _aie128_pnot_b16 _aie_pnot_b16
#define _aie128_pnot_b32 _aie_pnot_b32
#define _aie128_pand_b8 _aie_pand_b8
#define _aie128_pand_b16 _aie_pand_b16
#define _aie128_pand_b32 _aie_pand_b32
#define _aie128_pnand_b8 _aie_pnand_b8
#define _aie128_pnand_b16 _aie_pnand_b16
#define _aie128_pnand_b32 _aie_pnand_b32
#define _aie128_pandn_b8 _aie_pandn_b8
#define _aie128_pandn_b16 _aie_pandn_b16
#define _aie128_pandn_b32 _aie_pandn_b32
#define _aie128_por_b8 _aie_por_b8
#define _aie128_por_b16 _aie_por_b16
#define _aie128_por_b32 _aie_por_b32
#define _aie128_pnor_b8 _aie_pnor_b8
#define _aie128_pnor_b16 _aie_pnor_b16
#define _aie128_pnor_b32 _aie_pnor_b32
#define _aie128_porn_b8 _aie_porn_b8
#define _aie128_porn_b16 _aie_porn_b16
#define _aie128_porn_b32 _aie_porn_b32
#define _aie128_pxor_b8 _aie_pxor_b8
#define _aie128_pxor_b16 _aie_pxor_b16
#define _aie128_pxor_b32 _aie_pxor_b32
#define _aie128_pxnor_b8 _aie_pxnor_b8
#define _aie128_pxnor_b16 _aie_pxnor_b16
#define _aie128_pxnor_b32 _aie_pxnor_b32
#define _aie128_pcpop_b8 _aie_pcpop_b8
#define _aie128_pcpop_b8_m _aie_pcpop_b8_m
#define _aie128_pcpop_b16 _aie_pcpop_b16
#define _aie128_pcpop_b16_m _aie_pcpop_b16_m
#define _aie128_pcpop_b32 _aie_pcpop_b32
#define _aie128_pcpop_b32_m _aie_pcpop_b32_m
#define _aie128_pfirst_b8 _aie_pfirst_b8
#define _aie128_pfirst_b8_m _aie_pfirst_b8_m
#define _aie128_pfirst_b16 _aie_pfirst_b16
#define _aie128_pfirst_b16_m _aie_pfirst_b16_m
#define _aie128_pfirst_b32 _aie_pfirst_b32
#define _aie128_pfirst_b32_m _aie_pfirst_b32_m
#define _aie128_psbf_b8 _aie_psbf_b8
#define _aie128_psbf_b8_m _aie_psbf_b8_m
#define _aie128_psbf_b16 _aie_psbf_b16
#define _aie128_psbf_b16_m _aie_psbf_b16_m
#define _aie128_psbf_b32 _aie_psbf_b32
#define _aie128_psbf_b32_m _aie_psbf_b32_m
#define _aie128_psif_b8 _aie_psif_b8
#define _aie128_psif_b8_m _aie_psif_b8_m
#define _aie128_psif_b16 _aie_psif_b16
#define _aie128_psif_b16_m _aie_psif_b16_m
#define _aie128_psif_b32 _aie_psif_b32
#define _aie128_psif_b32_m _aie_psif_b32_m
#define _aie128_psof_b8 _aie_psof_b8
#define _aie128_psof_b8_m _aie_psof_b8_m
#define _aie128_psof_b16 _aie_psof_b16
#define _aie128_psof_b16_m _aie_psof_b16_m
#define _aie128_psof_b32 _aie_psof_b32
#define _aie128_psof_b32_m _aie_psof_b32_m
#define _aie128_piotab _aie_piotab
#define _aie128_piotab_m _aie_piotab_m
#define _aie128_piotah _aie_piotah
#define _aie128_piotah_m _aie_piotah_m
#define _aie128_piotaw _aie_piotaw
#define _aie128_piotaw_m _aie_piotaw_m
#define _aie128_pidb _aie_pidb
#define _aie128_pidb_m _aie_pidb_m
#define _aie128_pidh _aie_pidh
#define _aie128_pidh_m _aie_pidh_m
#define _aie128_pidw _aie_pidw
#define _aie128_pidw_m _aie_pidw_m
#define _aie128_pdec_b8 _aie_pdec_b8
#define _aie128_pdec_b16 _aie_pdec_b16
#define _aie128_pdec_b32 _aie_pdec_b32
#define _aie128_pld_b8 _aie_pld_b8
#define _aie128_pld_b16 _aie_pld_b16
#define _aie128_pld_b32 _aie_pld_b32
#define _aie128_psd_b8 _aie_psd_b8
#define _aie128_psd_b16 _aie_psd_b16
#define _aie128_psd_b32 _aie_psd_b32
#define _aie128_ceqb _aie_ceqb
#define _aie128_ceqh _aie_ceqh
#define _aie128_ceqw _aie_ceqw
#define _aie128_ceqzb _aie_ceqzb
#define _aie128_ceqzh _aie_ceqzh
#define _aie128_ceqzw _aie_ceqzw
#define _aie128_clesb _aie_clesb
#define _aie128_clesh _aie_clesh
#define _aie128_clesw _aie_clesw
#define _aie128_cleub _aie_cleub
#define _aie128_cleuh _aie_cleuh
#define _aie128_cleuw _aie_cleuw
#define _aie128_clezb _aie_clezb
#define _aie128_clezh _aie_clezh
#define _aie128_clezw _aie_clezw
#define _aie128_cltsb _aie_cltsb
#define _aie128_cltsh _aie_cltsh
#define _aie128_cltsw _aie_cltsw
#define _aie128_cltub _aie_cltub
#define _aie128_cltuh _aie_cltuh
#define _aie128_cltuw _aie_cltuw
#define _aie128_cltzb _aie_cltzb
#define _aie128_cltzh _aie_cltzh
#define _aie128_cltzw _aie_cltzw
#define _aie128_pceqb _aie_pceqb
#define _aie128_pceqb_m _aie_pceqb_m
#define _aie128_pceqh _aie_pceqh
#define _aie128_pceqh_m _aie_pceqh_m
#define _aie128_pceqw _aie_pceqw
#define _aie128_pceqw_m _aie_pceqw_m
#define _aie128_pceqzb _aie_pceqzb
#define _aie128_pceqzb_m _aie_pceqzb_m
#define _aie128_pceqzh _aie_pceqzh
#define _aie128_pceqzh_m _aie_pceqzh_m
#define _aie128_pceqzw _aie_pceqzw
#define _aie128_pceqzw_m _aie_pceqzw_m
#define _aie128_pcneb _aie_pcneb
#define _aie128_pcneb_m _aie_pcneb_m
#define _aie128_pcneh _aie_pcneh
#define _aie128_pcneh_m _aie_pcneh_m
#define _aie128_pcnew _aie_pcnew
#define _aie128_pcnew_m _aie_pcnew_m
#define _aie128_pcnezb _aie_pcnezb
#define _aie128_pcnezb_m _aie_pcnezb_m
#define _aie128_pcnezh _aie_pcnezh
#define _aie128_pcnezh_m _aie_pcnezh_m
#define _aie128_pcnezw _aie_pcnezw
#define _aie128_pcnezw_m _aie_pcnezw_m
#define _aie128_pclesb _aie_pclesb
#define _aie128_pclesb_m _aie_pclesb_m
#define _aie128_pclesh _aie_pclesh
#define _aie128_pclesh_m _aie_pclesh_m
#define _aie128_pclesw _aie_pclesw
#define _aie128_pclesw_m _aie_pclesw_m
#define _aie128_pcleub _aie_pcleub
#define _aie128_pcleub_m _aie_pcleub_m
#define _aie128_pcleuh _aie_pcleuh
#define _aie128_pcleuh_m _aie_pcleuh_m
#define _aie128_pcleuw _aie_pcleuw
#define _aie128_pcleuw_m _aie_pcleuw_m
#define _aie128_pclezb _aie_pclezb
#define _aie128_pclezb_m _aie_pclezb_m
#define _aie128_pclezh _aie_pclezh
#define _aie128_pclezh_m _aie_pclezh_m
#define _aie128_pclezw _aie_pclezw
#define _aie128_pclezw_m _aie_pclezw_m
#define _aie128_pcltsb _aie_pcltsb
#define _aie128_pcltsb_m _aie_pcltsb_m
#define _aie128_pcltsh _aie_pcltsh
#define _aie128_pcltsh_m _aie_pcltsh_m
#define _aie128_pcltsw _aie_pcltsw
#define _aie128_pcltsw_m _aie_pcltsw_m
#define _aie128_pcltub _aie_pcltub
#define _aie128_pcltub_m _aie_pcltub_m
#define _aie128_pcltuh _aie_pcltuh
#define _aie128_pcltuh_m _aie_pcltuh_m
#define _aie128_pcltuw _aie_pcltuw
#define _aie128_pcltuw_m _aie_pcltuw_m
#define _aie128_pcltzb _aie_pcltzb
#define _aie128_pcltzb_m _aie_pcltzb_m
#define _aie128_pcltzh _aie_pcltzh
#define _aie128_pcltzh_m _aie_pcltzh_m
#define _aie128_pcltzw _aie_pcltzw
#define _aie128_pcltzw_m _aie_pcltzw_m
#define _aie128_addb _aie_addb
#define _aie128_addb_m _aie_addb_m
#define _aie128_addh _aie_addh
#define _aie128_addh_m _aie_addh_m
#define _aie128_addw _aie_addw
#define _aie128_addw_m _aie_addw_m
#define _aie128_subb _aie_subb
#define _aie128_subb_m _aie_subb_m
#define _aie128_subh _aie_subh
#define _aie128_subh_m _aie_subh_m
#define _aie128_subw _aie_subw
#define _aie128_subw_m _aie_subw_m
#define _aie128_waddsbl _aie_waddsbl
#define _aie128_waddsbl_m _aie_waddsbl_m
#define _aie128_waddsbh _aie_waddsbh
#define _aie128_waddsbh_m _aie_waddsbh_m
#define _aie128_waddshl _aie_waddshl
#define _aie128_waddshl_m _aie_waddshl_m
#define _aie128_waddshh _aie_waddshh
#define _aie128_waddshh_m _aie_waddshh_m
#define _aie128_waddubl _aie_waddubl
#define _aie128_waddubl_m _aie_waddubl_m
#define _aie128_waddubh _aie_waddubh
#define _aie128_waddubh_m _aie_waddubh_m
#define _aie128_wadduhl _aie_wadduhl
#define _aie128_wadduhl_m _aie_wadduhl_m
#define _aie128_wadduhh _aie_wadduhh
#define _aie128_wadduhh_m _aie_wadduhh_m
#define _aie128_wsubsbl _aie_wsubsbl
#define _aie128_wsubsbl_m _aie_wsubsbl_m
#define _aie128_wsubsbh _aie_wsubsbh
#define _aie128_wsubsbh_m _aie_wsubsbh_m
#define _aie128_wsubshl _aie_wsubshl
#define _aie128_wsubshl_m _aie_wsubshl_m
#define _aie128_wsubshh _aie_wsubshh
#define _aie128_wsubshh_m _aie_wsubshh_m
#define _aie128_wsububl _aie_wsububl
#define _aie128_wsububl_m _aie_wsububl_m
#define _aie128_wsububh _aie_wsububh
#define _aie128_wsububh_m _aie_wsububh_m
#define _aie128_wsubuhl _aie_wsubuhl
#define _aie128_wsubuhl_m _aie_wsubuhl_m
#define _aie128_wsubuhh _aie_wsubuhh
#define _aie128_wsubuhh_m _aie_wsubuhh_m
#define _aie128_absb _aie_absb
#define _aie128_absb_m _aie_absb_m
#define _aie128_absh _aie_absh
#define _aie128_absh_m _aie_absh_m
#define _aie128_absw _aie_absw
#define _aie128_absw_m _aie_absw_m
#define _aie128_mulb _aie_mulb
#define _aie128_mulb_m _aie_mulb_m
#define _aie128_mulh _aie_mulh
#define _aie128_mulh_m _aie_mulh_m
#define _aie128_mulw _aie_mulw
#define _aie128_mulw_m _aie_mulw_m
#define _aie128_smulbe _aie_smulbe
#define _aie128_smulbe_m _aie_smulbe_m
#define _aie128_smulbo _aie_smulbo
#define _aie128_smulbo_m _aie_smulbo_m
#define _aie128_smulhe _aie_smulhe
#define _aie128_smulhe_m _aie_smulhe_m
#define _aie128_smulho _aie_smulho
#define _aie128_smulho_m _aie_smulho_m
#define _aie128_umulbe _aie_umulbe
#define _aie128_umulbe_m _aie_umulbe_m
#define _aie128_umulbo _aie_umulbo
#define _aie128_umulbo_m _aie_umulbo_m
#define _aie128_umulhe _aie_umulhe
#define _aie128_umulhe_m _aie_umulhe_m
#define _aie128_umulho _aie_umulho
#define _aie128_umulho_m _aie_umulho_m
#define _aie128_wsmulbl _aie_wsmulbl
#define _aie128_wsmulbl_m _aie_wsmulbl_m
#define _aie128_wsmulbh _aie_wsmulbh
#define _aie128_wsmulbh_m _aie_wsmulbh_m
#define _aie128_wsmulhl _aie_wsmulhl
#define _aie128_wsmulhl_m _aie_wsmulhl_m
#define _aie128_wsmulhh _aie_wsmulhh
#define _aie128_wsmulhh_m _aie_wsmulhh_m
#define _aie128_wumulbl _aie_wumulbl
#define _aie128_wumulbl_m _aie_wumulbl_m
#define _aie128_wumulbh _aie_wumulbh
#define _aie128_wumulbh_m _aie_wumulbh_m
#define _aie128_wumulhl _aie_wumulhl
#define _aie128_wumulhl_m _aie_wumulhl_m
#define _aie128_wumulhh _aie_wumulhh
#define _aie128_wumulhh_m _aie_wumulhh_m
#define _aie128_mlaw _aie_mlaw
#define _aie128_mlaw_m _aie_mlaw_m
#define _aie128_mlsw _aie_mlsw
#define _aie128_mlsw_m _aie_mlsw_m
#define _aie128_smlahe _aie_smlahe
#define _aie128_smlahe_m _aie_smlahe_m
#define _aie128_smlaho _aie_smlaho
#define _aie128_smlaho_m _aie_smlaho_m
#define _aie128_smlshe _aie_smlshe
#define _aie128_smlshe_m _aie_smlshe_m
#define _aie128_smlsho _aie_smlsho
#define _aie128_smlsho_m _aie_smlsho_m
#define _aie128_wsmlahl _aie_wsmlahl
#define _aie128_wsmlahl_m _aie_wsmlahl_m
#define _aie128_wsmlahh _aie_wsmlahh
#define _aie128_wsmlahh_m _aie_wsmlahh_m
#define _aie128_wsmlshl _aie_wsmlshl
#define _aie128_wsmlshl_m _aie_wsmlshl_m
#define _aie128_wsmlshh _aie_wsmlshh
#define _aie128_wsmlshh_m _aie_wsmlshh_m
#define _aie128_maxab _aie_maxab
#define _aie128_maxab_m _aie_maxab_m
#define _aie128_maxah _aie_maxah
#define _aie128_maxah_m _aie_maxah_m
#define _aie128_maxaw _aie_maxaw
#define _aie128_maxaw_m _aie_maxaw_m
#define _aie128_maxsb _aie_maxsb
#define _aie128_maxsb_m _aie_maxsb_m
#define _aie128_maxsh _aie_maxsh
#define _aie128_maxsh_m _aie_maxsh_m
#define _aie128_maxsw _aie_maxsw
#define _aie128_maxsw_m _aie_maxsw_m
#define _aie128_maxub _aie_maxub
#define _aie128_maxub_m _aie_maxub_m
#define _aie128_maxuh _aie_maxuh
#define _aie128_maxuh_m _aie_maxuh_m
#define _aie128_maxuw _aie_maxuw
#define _aie128_maxuw_m _aie_maxuw_m
#define _aie128_maxu2bi _aie_maxu2bi
#define _aie128_maxu2bi_m _aie_maxu2bi_m
#define _aie128_maxu4bi _aie_maxu4bi
#define _aie128_maxu4bi_m _aie_maxu4bi_m
#define _aie128_minab _aie_minab
#define _aie128_minab_m _aie_minab_m
#define _aie128_minah _aie_minah
#define _aie128_minah_m _aie_minah_m
#define _aie128_minaw _aie_minaw
#define _aie128_minaw_m _aie_minaw_m
#define _aie128_minsb _aie_minsb
#define _aie128_minsb_m _aie_minsb_m
#define _aie128_minsh _aie_minsh
#define _aie128_minsh_m _aie_minsh_m
#define _aie128_minsw _aie_minsw
#define _aie128_minsw_m _aie_minsw_m
#define _aie128_minub _aie_minub
#define _aie128_minub_m _aie_minub_m
#define _aie128_minuh _aie_minuh
#define _aie128_minuh_m _aie_minuh_m
#define _aie128_minuw _aie_minuw
#define _aie128_minuw_m _aie_minuw_m
#define _aie128_minu2bi _aie_minu2bi
#define _aie128_minu2bi_m _aie_minu2bi_m
#define _aie128_minu4bi _aie_minu4bi
#define _aie128_minu4bi_m _aie_minu4bi_m
#define _aie128_satsshb _aie_satsshb
#define _aie128_satsshb_m _aie_satsshb_m
#define _aie128_satsswb _aie_satsswb
#define _aie128_satsswb_m _aie_satsswb_m
#define _aie128_satsswh _aie_satsswh
#define _aie128_satsswh_m _aie_satsswh_m
#define _aie128_satsub2bi _aie_satsub2bi
#define _aie128_satsub2bi_m _aie_satsub2bi_m
#define _aie128_satsub4bi _aie_satsub4bi
#define _aie128_satsub4bi_m _aie_satsub4bi_m
#define _aie128_satsuh2bi _aie_satsuh2bi
#define _aie128_satsuh2bi_m _aie_satsuh2bi_m
#define _aie128_satsuh4bi _aie_satsuh4bi
#define _aie128_satsuh4bi_m _aie_satsuh4bi_m
#define _aie128_satsuhb _aie_satsuhb
#define _aie128_satsuhb_m _aie_satsuhb_m
#define _aie128_satsuw2bi _aie_satsuw2bi
#define _aie128_satsuw2bi_m _aie_satsuw2bi_m
#define _aie128_satsuw4bi _aie_satsuw4bi
#define _aie128_satsuw4bi_m _aie_satsuw4bi_m
#define _aie128_satsuwb _aie_satsuwb
#define _aie128_satsuwb_m _aie_satsuwb_m
#define _aie128_satsuwh _aie_satsuwh
#define _aie128_satsuwh_m _aie_satsuwh_m
#define _aie128_satuub2bi _aie_satuub2bi
#define _aie128_satuub2bi_m _aie_satuub2bi_m
#define _aie128_satuub4bi _aie_satuub4bi
#define _aie128_satuub4bi_m _aie_satuub4bi_m
#define _aie128_satuuh2bi _aie_satuuh2bi
#define _aie128_satuuh2bi_m _aie_satuuh2bi_m
#define _aie128_satuuh4bi _aie_satuuh4bi
#define _aie128_satuuh4bi_m _aie_satuuh4bi_m
#define _aie128_satuuhb _aie_satuuhb
#define _aie128_satuuhb_m _aie_satuuhb_m
#define _aie128_satuuw4bi _aie_satuuw4bi
#define _aie128_satuuw4bi_m _aie_satuuw4bi_m
#define _aie128_satuuwb _aie_satuuwb
#define _aie128_satuuwb_m _aie_satuuwb_m
#define _aie128_satuuwh _aie_satuuwh
#define _aie128_satuuwh_m _aie_satuuwh_m
#define _aie128_tocb _aie_tocb
#define _aie128_tocb_m _aie_tocb_m
#define _aie128_toch _aie_toch
#define _aie128_toch_m _aie_toch_m
#define _aie128_tocw _aie_tocw
#define _aie128_tocw_m _aie_tocw_m
#define _aie128_andib _aie_andib
#define _aie128_andib_m _aie_andib_m
#define _aie128_orib _aie_orib
#define _aie128_orib_m _aie_orib_m
#define _aie128_xorib _aie_xorib
#define _aie128_xorib_m _aie_xorib_m
#define _aie128_andb _aie_andb
#define _aie128_andb_m _aie_andb_m
#define _aie128_andh _aie_andh
#define _aie128_andh_m _aie_andh_m
#define _aie128_andw _aie_andw
#define _aie128_andw_m _aie_andw_m
#define _aie128_andnb _aie_andnb
#define _aie128_andnb_m _aie_andnb_m
#define _aie128_andnh _aie_andnh
#define _aie128_andnh_m _aie_andnh_m
#define _aie128_andnw _aie_andnw
#define _aie128_andnw_m _aie_andnw_m
#define _aie128_orb _aie_orb
#define _aie128_orb_m _aie_orb_m
#define _aie128_orh _aie_orh
#define _aie128_orh_m _aie_orh_m
#define _aie128_orw _aie_orw
#define _aie128_orw_m _aie_orw_m
#define _aie128_ornb _aie_ornb
#define _aie128_ornb_m _aie_ornb_m
#define _aie128_ornh _aie_ornh
#define _aie128_ornh_m _aie_ornh_m
#define _aie128_ornw _aie_ornw
#define _aie128_ornw_m _aie_ornw_m
#define _aie128_xorb _aie_xorb
#define _aie128_xorb_m _aie_xorb_m
#define _aie128_xorh _aie_xorh
#define _aie128_xorh_m _aie_xorh_m
#define _aie128_xorw _aie_xorw
#define _aie128_xorw_m _aie_xorw_m
#define _aie128_xornb _aie_xornb
#define _aie128_xornb_m _aie_xornb_m
#define _aie128_xornh _aie_xornh
#define _aie128_xornh_m _aie_xornh_m
#define _aie128_xornw _aie_xornw
#define _aie128_xornw_m _aie_xornw_m
#define _aie128_eselb _aie_eselb
#define _aie128_eselh _aie_eselh
#define _aie128_eselw _aie_eselw
#define _aie128_andv _aie_andb
#define _aie128_andnv _aie_andnb
#define _aie128_orv _aie_orb
#define _aie128_ornv _aie_ornb
#define _aie128_xorv _aie_xorb
#define _aie128_xornv _aie_xornb
#define _aie128_bselv _aie_bselv
#define _aie128_faddw _aie_faddw
#define _aie128_faddw_m _aie_faddw_m
#define _aie128_fsubw _aie_fsubw
#define _aie128_fsubw_m _aie_fsubw_m
#define _aie128_fmaddw _aie_fmaddw
#define _aie128_fmaddw_m _aie_fmaddw_m
#define _aie128_fmsubw _aie_fmsubw
#define _aie128_fmsubw_m _aie_fmsubw_m
#define _aie128_fnmaddw _aie_fnmaddw
#define _aie128_fnmaddw_m _aie_fnmaddw_m
#define _aie128_fnmsubw _aie_fnmsubw
#define _aie128_fnmsubw_m _aie_fnmsubw_m
#define _aie128_fmaxw _aie_fmaxw
#define _aie128_fmaxw_m _aie_fmaxw_m
#define _aie128_fminw _aie_fminw
#define _aie128_fminw_m _aie_fminw_m
#define _aie128_fmulw _aie_fmulw
#define _aie128_fmulw_m _aie_fmulw_m
#define _aie128_fcmulrw _aie_fcmulrw
#define _aie128_fcmulrw_m _aie_fcmulrw_m
#define _aie128_fcmuliw _aie_fcmuliw
#define _aie128_fcmuliw_m _aie_fcmuliw_m
#define _aie128_fcaddw _aie_fcaddw
#define _aie128_fcaddw_m _aie_fcaddw_m
#define _aie128_fmaxaw _aie_fmaxaw
#define _aie128_fmaxaw_m _aie_fmaxaw_m
#define _aie128_fminaw _aie_fminaw
#define _aie128_fminaw_m _aie_fminaw_m
#define _aie128_fclassw _aie_fclassw
#define _aie128_fclassw_m _aie_fclassw_m
#define _aie128_faddh _aie_faddh
#define _aie128_faddh_m _aie_faddh_m
#define _aie128_fsubh _aie_fsubh
#define _aie128_fsubh_m _aie_fsubh_m
#define _aie128_fmaxh _aie_fmaxh
#define _aie128_fmaxh_m _aie_fmaxh_m
#define _aie128_fminh _aie_fminh
#define _aie128_fminh_m _aie_fminh_m
#define _aie128_fmulh _aie_fmulh
#define _aie128_fmulh_m _aie_fmulh_m
#define _aie128_fcmulrh _aie_fcmulrh
#define _aie128_fcmulrh_m _aie_fcmulrh_m
#define _aie128_fcmulih _aie_fcmulih
#define _aie128_fcmulih_m _aie_fcmulih_m
#define _aie128_fcaddh _aie_fcaddh
#define _aie128_fcaddh_m _aie_fcaddh_m
#define _aie128_fmaxah _aie_fmaxah
#define _aie128_fmaxah_m _aie_fmaxah_m
#define _aie128_fminah _aie_fminah
#define _aie128_fminah_m _aie_fminah_m
#define _aie128_fclassh _aie_fclassh
#define _aie128_fclassh_m _aie_fclassh_m
#define _aie128_fceqw _aie_fceqw
#define _aie128_fclew _aie_fclew
#define _aie128_fcltw _aie_fcltw
#define _aie128_fcorw _aie_fcorw
#define _aie128_pfceqh _aie_pfceqh
#define _aie128_pfceqh_m _aie_pfceqh_m
#define _aie128_pfceqw _aie_pfceqw
#define _aie128_pfceqw_m _aie_pfceqw_m
#define _aie128_pfcneh _aie_pfcneh
#define _aie128_pfcneh_m _aie_pfcneh_m
#define _aie128_pfcnew _aie_pfcnew
#define _aie128_pfcnew_m _aie_pfcnew_m
#define _aie128_pfcleh _aie_pfcleh
#define _aie128_pfcleh_m _aie_pfcleh_m
#define _aie128_pfclew _aie_pfclew
#define _aie128_pfclew_m _aie_pfclew_m
#define _aie128_pfclth _aie_pfclth
#define _aie128_pfclth_m _aie_pfclth_m
#define _aie128_pfcltw _aie_pfcltw
#define _aie128_pfcltw_m _aie_pfcltw_m
#define _aie128_pfcorh _aie_pfcorh
#define _aie128_pfcorh_m _aie_pfcorh_m
#define _aie128_pfcorw _aie_pfcorw
#define _aie128_pfcorw_m _aie_pfcorw_m
#define _aie128_ffsiw _aie_ffsiw
#define _aie128_ffsiw_m _aie_ffsiw_m
#define _aie128_ffuiw _aie_ffuiw
#define _aie128_ffuiw_m _aie_ffuiw_m
#define _aie128_ftsiw _aie_ftsiw
#define _aie128_ftsiw_m _aie_ftsiw_m
#define _aie128_ftuiw _aie_ftuiw
#define _aie128_ftuiw_m _aie_ftuiw_m
#define _aie128_frintw _aie_frintw
#define _aie128_frintw_m _aie_frintw_m
#define _aie128_ftruncsw _aie_ftruncsw
#define _aie128_ftruncsw_m _aie_ftruncsw_m
#define _aie128_ftruncuw _aie_ftruncuw
#define _aie128_ftruncuw_m _aie_ftruncuw_m
#define _aie128_ffsih _aie_ffsih
#define _aie128_ffsih_m _aie_ffsih_m
#define _aie128_ffuih _aie_ffuih
#define _aie128_ffuih_m _aie_ffuih_m
#define _aie128_ftsih _aie_ftsih
#define _aie128_ftsih_m _aie_ftsih_m
#define _aie128_ftuih _aie_ftuih
#define _aie128_ftuih_m _aie_ftuih_m
#define _aie128_frinth _aie_frinth
#define _aie128_frinth_m _aie_frinth_m
#define _aie128_ftruncsh _aie_ftruncsh
#define _aie128_ftruncsh_m _aie_ftruncsh_m
#define _aie128_ftruncuh _aie_ftruncuh
#define _aie128_ftruncuh_m _aie_ftruncuh_m
#define _aie128_fcvthw _aie_fcvthw
#define _aie128_fcvthw_m _aie_fcvthw_m
#define _aie128_fcvtwh _aie_fcvtwh
#define _aie128_fcvtwh_m _aie_fcvtwh_m
#define _aie128_sllb _aie_sllb
#define _aie128_sllb_m _aie_sllb_m
#define _aie128_sllh _aie_sllh
#define _aie128_sllh_m _aie_sllh_m
#define _aie128_sllw _aie_sllw
#define _aie128_sllw_m _aie_sllw_m
#define _aie128_sllib _aie_sllib
#define _aie128_sllib_m _aie_sllib_m
#define _aie128_sllih _aie_sllih
#define _aie128_sllih_m _aie_sllih_m
#define _aie128_slliw _aie_slliw
#define _aie128_slliw_m _aie_slliw_m
#define _aie128_srab _aie_srab
#define _aie128_srab_m _aie_srab_m
#define _aie128_srah _aie_srah
#define _aie128_srah_m _aie_srah_m
#define _aie128_sraw _aie_sraw
#define _aie128_sraw_m _aie_sraw_m
#define _aie128_sraib _aie_sraib
#define _aie128_sraib_m _aie_sraib_m
#define _aie128_sraih _aie_sraih
#define _aie128_sraih_m _aie_sraih_m
#define _aie128_sraiw _aie_sraiw
#define _aie128_sraiw_m _aie_sraiw_m
#define _aie128_srarb _aie_srarb
#define _aie128_srarb_m _aie_srarb_m
#define _aie128_srarh _aie_srarh
#define _aie128_srarh_m _aie_srarh_m
#define _aie128_srarw _aie_srarw
#define _aie128_srarw_m _aie_srarw_m
#define _aie128_srarib _aie_srarib
#define _aie128_srarib_m _aie_srarib_m
#define _aie128_srarih _aie_srarih
#define _aie128_srarih_m _aie_srarih_m
#define _aie128_srariw _aie_srariw
#define _aie128_srariw_m _aie_srariw_m
#define _aie128_srlb _aie_srlb
#define _aie128_srlb_m _aie_srlb_m
#define _aie128_srlh _aie_srlh
#define _aie128_srlh_m _aie_srlh_m
#define _aie128_srlw _aie_srlw
#define _aie128_srlw_m _aie_srlw_m
#define _aie128_srlib _aie_srlib
#define _aie128_srlib_m _aie_srlib_m
#define _aie128_srlih _aie_srlih
#define _aie128_srlih_m _aie_srlih_m
#define _aie128_srliw _aie_srliw
#define _aie128_srliw_m _aie_srliw_m
#define _aie128_srlrb _aie_srlrb
#define _aie128_srlrb_m _aie_srlrb_m
#define _aie128_srlrh _aie_srlrh
#define _aie128_srlrh_m _aie_srlrh_m
#define _aie128_srlrw _aie_srlrw
#define _aie128_srlrw_m _aie_srlrw_m
#define _aie128_srlrib _aie_srlrib
#define _aie128_srlrib_m _aie_srlrib_m
#define _aie128_srlrih _aie_srlrih
#define _aie128_srlrih_m _aie_srlrih_m
#define _aie128_srlriw _aie_srlriw
#define _aie128_srlriw_m _aie_srlriw_m
#define _aie128_gt1bi _aie_gt1bi
#define _aie128_gt1bi_m _aie_gt1bi_m
#define _aie128_gt2bi _aie_gt2bi
#define _aie128_gt2bi_m _aie_gt2bi_m
#define _aie128_gt4bi _aie_gt4bi
#define _aie128_gt4bi_m _aie_gt4bi_m
#define _aie128_gtb _aie_gtb
#define _aie128_gtb_m _aie_gtb_m
#define _aie128_gth _aie_gth
#define _aie128_gth_m _aie_gth_m
#define _aie128_gt2w _aie_gt2w
#define _aie128_gt2w_m _aie_gt2w_m
#define _aie128_extuwll _aie_extuwll
#define _aie128_extuwll_m _aie_extuwll_m
#define _aie128_extuwlh _aie_extuwlh
#define _aie128_extuwlh_m _aie_extuwlh_m
#define _aie128_extuwhl _aie_extuwhl
#define _aie128_extuwhl_m _aie_extuwhl_m
#define _aie128_extuwhh _aie_extuwhh
#define _aie128_extuwhh_m _aie_extuwhh_m
#define _aie128_extu1bil _aie_extu1bil
#define _aie128_extu1bil_m _aie_extu1bil_m
#define _aie128_extu2bil _aie_extu2bil
#define _aie128_extu2bil_m _aie_extu2bil_m
#define _aie128_extu4bil _aie_extu4bil
#define _aie128_extu4bil_m _aie_extu4bil_m
#define _aie128_extubl _aie_extubl
#define _aie128_extubl_m _aie_extubl_m
#define _aie128_extuhl _aie_extuhl
#define _aie128_extuhl_m _aie_extuhl_m
#define _aie128_extu1bih _aie_extu1bih
#define _aie128_extu1bih_m _aie_extu1bih_m
#define _aie128_extu2bih _aie_extu2bih
#define _aie128_extu2bih_m _aie_extu2bih_m
#define _aie128_extu4bih _aie_extu4bih
#define _aie128_extu4bih_m _aie_extu4bih_m
#define _aie128_extubh _aie_extubh
#define _aie128_extubh_m _aie_extubh_m
#define _aie128_extuhh _aie_extuhh
#define _aie128_extuhh_m _aie_extuhh_m
#define _aie128_exts1bil _aie_exts1bil
#define _aie128_exts1bil_m _aie_exts1bil_m
#define _aie128_exts2bil _aie_exts2bil
#define _aie128_exts2bil_m _aie_exts2bil_m
#define _aie128_exts4bil _aie_exts4bil
#define _aie128_exts4bil_m _aie_exts4bil_m
#define _aie128_extsbl _aie_extsbl
#define _aie128_extsbl_m _aie_extsbl_m
#define _aie128_extshl _aie_extshl
#define _aie128_extshl_m _aie_extshl_m
#define _aie128_exts1bih _aie_exts1bih
#define _aie128_exts1bih_m _aie_exts1bih_m
#define _aie128_exts2bih _aie_exts2bih
#define _aie128_exts2bih_m _aie_exts2bih_m
#define _aie128_exts4bih _aie_exts4bih
#define _aie128_exts4bih_m _aie_exts4bih_m
#define _aie128_extsbh _aie_extsbh
#define _aie128_extsbh_m _aie_extsbh_m
#define _aie128_extshh _aie_extshh
#define _aie128_extshh_m _aie_extshh_m
#define _aie128_extu3bw _aie_extu3bw
#define _aie128_extu3bw_m _aie_extu3bw_m
#define _aie128_gshufw _aie_gshufw
#define _aie128_gshufw_m _aie_gshufw_m
#define _aie128_gshufwb _aie_gshufwb
#define _aie128_gshufwb_m _aie_gshufwb_m
#define _aie128_gshufwb_2 _aie_gshufwb_2
#define _aie128_gshufwb_2_m _aie_gshufwb_2_m
#define _aie128_gshufvb _aie_gshufvb
#define _aie128_gshufvb_m _aie_gshufvb_m
#define _aie128_ilve2bi _aie_ilve2bi
#define _aie128_ilve2bi_m _aie_ilve2bi_m
#define _aie128_ilve4bi _aie_ilve4bi
#define _aie128_ilve4bi_m _aie_ilve4bi_m
#define _aie128_ilveb _aie_ilveb
#define _aie128_ilveb_m _aie_ilveb_m
#define _aie128_ilveh _aie_ilveh
#define _aie128_ilveh_m _aie_ilveh_m
#define _aie128_ilvew _aie_ilvew
#define _aie128_ilvew_m _aie_ilvew_m
#define _aie128_ilved _aie_ilved
#define _aie128_ilved_m _aie_ilved_m
#define _aie128_ilvo2bi _aie_ilvo2bi
#define _aie128_ilvo2bi_m _aie_ilvo2bi_m
#define _aie128_ilvo4bi _aie_ilvo4bi
#define _aie128_ilvo4bi_m _aie_ilvo4bi_m
#define _aie128_ilvob _aie_ilvob
#define _aie128_ilvob_m _aie_ilvob_m
#define _aie128_ilvoh _aie_ilvoh
#define _aie128_ilvoh_m _aie_ilvoh_m
#define _aie128_ilvow _aie_ilvow
#define _aie128_ilvow_m _aie_ilvow_m
#define _aie128_ilvod _aie_ilvod
#define _aie128_ilvod_m _aie_ilvod_m
#define _aie128_bshli _aie_bshli
#define _aie128_bshli_m _aie_bshli_m
#define _aie128_bshri _aie_bshri
#define _aie128_bshri_m _aie_bshri_m
#define _aie128_bshl _aie_bshl
#define _aie128_bshl_m _aie_bshl_m
#define _aie128_bshr _aie_bshr
#define _aie128_bshr_m _aie_bshr_m
#define _aie128_lih _aie_lih
#define _aie128_liw _aie_liw
#define _aie128_liwh _aie_liwh
#define _aie128_liwr _aie_liwr
#define _aie128_mfcpub _aie_mfcpub
#define _aie128_mfcpub_m _aie_mfcpub_m
#define _aie128_mfcpuh _aie_mfcpuh
#define _aie128_mfcpuh_m _aie_mfcpuh_m
#define _aie128_mfcpuw _aie_mfcpuw
#define _aie128_mfcpuw_m _aie_mfcpuw_m
#define _aie128_sumz _aie_sumz
#define _aie128_sumz_m _aie_sumz_m
#define _aie128_mfsumz _aie_mfsumz
#define _aie128_mfsumz_m _aie_mfsumz_m
#define _aie128_mxsum _aie_mxsum
#define _aie128_mxsum_m _aie_mxsum_m
#define _aie128_cmvw _aie_cmvw
#define _aie128_cmvw_m _aie_cmvw_m
#define _aie128_pmaph _aie_pmaph
#define _aie128_pmaph_m _aie_pmaph_m
#define _aie128_pmapw _aie_pmapw
#define _aie128_pmapw_m _aie_pmapw_m
#define _aie128_lavb _aie_lavb
#define _aie128_lavb_m _aie_lavb_m
#define _aie128_lavh _aie_lavh
#define _aie128_lavh_m _aie_lavh_m
#define _aie128_lavw _aie_lavw
#define _aie128_lavw_m _aie_lavw_m
#define _aie128_savb _aie_savb
#define _aie128_savb_m _aie_savb_m
#define _aie128_savh _aie_savh
#define _aie128_savh_m _aie_savh_m
#define _aie128_savw _aie_savw
#define _aie128_savw_m _aie_savw_m
#define _aie128_luvb _aie_luvb
#define _aie128_luvb_m _aie_luvb_m
#define _aie128_luvh _aie_luvh
#define _aie128_luvh_m _aie_luvh_m
#define _aie128_luvw _aie_luvw
#define _aie128_luvw_m _aie_luvw_m
#define _aie128_suvb _aie_suvb
#define _aie128_suvb_m _aie_suvb_m
#define _aie128_suvh _aie_suvh
#define _aie128_suvh_m _aie_suvh_m
#define _aie128_suvw _aie_suvw
#define _aie128_suvw_m _aie_suvw_m
#define _aie128_lutw _aie_lutw
#define _aie128_lutr _aie_lutr
#define _aie128_nnrwr _aie_nnrwr
#define _aie128_nnrrd _aie_nnrrd
#define _aie128_nndwr _aie_nndwr
#define _aie128_nndrd _aie_nndrd
#define _aie128_nncmd _aie_nncmd
#define _aie128_nnmac _aie_nnmac
#endif

#endif
