;; Machine Description for Ingenic Xburst2 MXA ASE
;; Based on the Ingenic Xburst2 MXA spec Revision 00.07
;;
;; Copyright (C) 2015-2017 Free Software Foundation, Inc.
;;
;; This file is part of GCC.
;;
;; GCC is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; GCC is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GCC; see the file COPYING3.  If not see
;; <http://www.gnu.org/licenses/>.
;;

(define_c_enum "unspec" [
  UNSPEC_MSA_FCMUL_W
  UNSPEC_MSA_FEXUPLC_W
  UNSPEC_MSA_FEXUPRC_W
  UNSPEC_MSA_LDINSSU_W
  UNSPEC_MSA_LDINSS_W
  UNSPEC_MSA_VSHFR_B
  UNSPEC_MSA_VSLDI_B
  UNSPEC_MSA_LDINS
  UNSPEC_MSA_STEXT
  UNSPEC_MSA_PCNT_V
  UNSPEC_MSA_BEXT
  UNSPEC_MSA_BEXP
  UNSPEC_MSA_BEXP_2B
  UNSPEC_MSA_BEXP_4B
  UNSPEC_MSA_BMU_V
  UNSPEC_MSA_SLL_V
  UNSPEC_MSA_SLLI_V
  UNSPEC_MSA_SRL_V
  UNSPEC_MSA_SRLI_V
  UNSPEC_MSA_MOVE_W
  UNSPEC_MSA_MOVBT_B
  UNSPEC_MSA_MOVBP_B
  UNSPEC_MSA_SATSS
  UNSPEC_MSA_SATUU
  UNSPEC_MSA_SATUS
  UNSPEC_MSA_ADDSL
  UNSPEC_MSA_ADDSR
  UNSPEC_MSA_ADDUL
  UNSPEC_MSA_ADDUR
  UNSPEC_MSA_ACCSL
  UNSPEC_MSA_ACCSR
  UNSPEC_MSA_ACCUL
  UNSPEC_MSA_ACCUR
  UNSPEC_MSA_SUBSL
  UNSPEC_MSA_SUBSR
  UNSPEC_MSA_SUBUL
  UNSPEC_MSA_SUBUR
  UNSPEC_MSA_MULSL
  UNSPEC_MSA_MULSR
  UNSPEC_MSA_MULUL
  UNSPEC_MSA_MULUR
])

(define_insn "msa_fcmul_w"
 [(set (match_operand:V4SF 0 "register_operand" "=f")
       (unspec:V4SF [(match_operand:V4SF 1 "register_operand" "f")
         (match_operand:V4SF 2 "register_operand" "f")]
	UNSPEC_MSA_FCMUL_W))]
 "ISA_HAS_MSA"
 "fcmul.w\t%w0,%w1,%w2"
  [(set_attr "mode"	"V4SF")
   (set_attr "type" "simd_fmul")])

(define_insn "msa_fexuplc_w"
  [(set (match_operand:V4SF 0 "register_operand" "=f")
     (unspec:V4SF [(match_operand:V8HI 1 "register_operand" "f")
        (match_operand:V8HI 2 "register_operand" "f")]
	UNSPEC_MSA_FEXUPLC_W))]
 "ISA_HAS_MSA"
 "fexuplc.w\t%w0,%w1,%w2"
 [(set_attr "type" "simd_fcvt")
  (set_attr "mode"     "V4SF")])

(define_insn "msa_fexuprc_w"
  [(set (match_operand:V4SF 0 "register_operand" "=f")
     (unspec:V4SF [(match_operand:V8HI 1 "register_operand" "f")
        (match_operand:V8HI 2 "register_operand" "f")]
	UNSPEC_MSA_FEXUPRC_W))]
 "ISA_HAS_MSA"
 "fexuprc.w\t%w0,%w1,%w2"
 [(set_attr "type" "simd_fcvt")
  (set_attr "mode"     "V4SF")])

(define_insn "msa_ldinss_w"
  [(set (match_operand:V4SI 0 "register_operand" "=f")
    (mem:V4SI (unspec:SI [(match_operand:SI 3 "register_operand" "d")
		(match_operand:SI 4 "register_operand" "d")
		(match_operand 2 "const_0_to_3_operand" "")
		(match_operand:V4SI 1 "register_operand" "0")]
		UNSPEC_MSA_LDINSS_W)))]
  "ISA_HAS_MSA"
{
  return "ldinss.w\t%w0[%2], %4(%3)";
}
[(set_attr "mode"     "V4SI")
  (set_attr "type" "simd_load")])

;; miss ldinssu.w
;; miss ldinssu2.w

(define_insn "msa_ldins_<msafmt>"
  [(set (match_operand:IMSA_DW 0 "register_operand" "=f")
    (mem:IMSA_DW (unspec:SI [(match_operand:SI 3 "register_operand" "d")
		(match_operand:SI 4 "register_operand" "d")
		(match_operand 2 "const_<indeximm>_operand" "")
		(match_operand:IMSA_DW 1 "register_operand" "0")]
		UNSPEC_MSA_LDINS)))]
  "ISA_HAS_MSA"
{
  return "ldins.<msafmt>\t%w0[%2], %4(%3)";
}
 [(set_attr "mode"     "<MODE>")
  (set_attr "type" "simd_load")])

;; miss ldinsu.w

(define_insn "msa_stext_<msafmt>"
  [(set (mem:IMSA_DW (plus:SI (match_operand:SI 2 "register_operand" "d")
			  (match_operand:SI 3 "register_operand" "d")))
	  (unspec:IMSA_DW [(match_operand:IMSA_DW 0 "register_operand" "f")
	   (match_operand 1 "const_<indeximm>_operand" "")]
	   UNSPEC_MSA_STEXT))]
  "ISA_HAS_MSA"
{
  return "stext.<msafmt>\t%w0[%1], %3(%2)";
}
 [(set_attr "mode"     "<MODE>")
  (set_attr "type" "simd_store")])

;; miss stextu.df

(define_insn "msa_vshfr_b"
  [(set (match_operand:V16QI 0 "register_operand" "=f")
	(unspec:V16QI [(match_operand:V16QI 1 "register_operand" "f")
	 (match_operand:V16QI 2 "register_operand" "f")
	 (match_operand:V16QI 3 "register_operand" "f")]
	 UNSPEC_MSA_VSHFR_B))]
  "ISA_HAS_MSA"
  "vshfr.b\t%w0,%w1,%w2,%w3"
  [(set_attr "type" "simd_sld")
   (set_attr "mode" "V16QI")])

(define_insn "msa_vsldi_b"
 [(set (match_operand:V16QI 0 "register_operand" "=f")
    (unspec:V16QI [(match_operand:V16QI 1 "register_operand" "f")
	 (match_operand:V16QI 2 "register_operand" "f")
	 (match_operand 3 "const_uimm4_operand" "")]
	 UNSPEC_MSA_VSLDI_B))]
 "ISA_HAS_MSA"
 "vsldi.b\t%w0,%w1,%w2,%3"
  [(set_attr "type" "simd_sld")
   (set_attr "mode" "V16QI")])

(define_insn "msa_bmr_<msafmt_f>"
  [(set (match_operand:MSA 0 "register_operand" "=f")
	(ior:MSA (and:MSA (match_operand:MSA 1 "register_operand" "f")
			  (match_operand:MSA 3 "register_operand" "f"))
	 (and:MSA (match_operand:MSA 2 "register_operand" "f")
	  (not:MSA (match_dup 3)))))]
 "ISA_HAS_MSA"
 "bmr.v\t%w0,%w1,%w2,%w3"
  [(set_attr "type" "simd_sld")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_pcnt_v"
  [(set (match_operand:V16QI 0 "register_operand" "=f")
	(unspec:V16QI [(match_operand:V16QI 1 "register_operand" "f")]
	UNSPEC_MSA_PCNT_V))]
 "ISA_HAS_MSA"
 "pcnt.v\t%w0,%w1"
  [(set_attr "type" "simd_bit")
   (set_attr "mode" "V16QI")])

(define_insn "msa_bext_<msafmt>"
  [(set (match_operand:IMSA_WHB 0 "register_operand" "=f")
	(unspec:IMSA_WHB [(match_operand:IMSA_WHB 1 "register_operand" "f")]
	UNSPEC_MSA_BEXT))]
 "ISA_HAS_MSA"
 "bext.<msafmt>\t%w0,%w1"
  [(set_attr "type" "simd_bit")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_bexp_<msafmt>"
  [(set (match_operand:IMSA_WHB 0 "register_operand" "=f")
	(unspec:IMSA_WHB [(match_operand:IMSA_WHB 1 "register_operand" "f")]
	UNSPEC_MSA_BEXP))]
 "ISA_HAS_MSA"
 "bexp.<msafmt>\t%w0,%w1"
  [(set_attr "type" "simd_bit")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_bexp_2b"
  [(set (match_operand:V16QI 0 "register_operand" "=f")
	(unspec:V16QI [(match_operand:V16QI 1 "register_operand" "f")]
	UNSPEC_MSA_BEXP_2B))]
 "ISA_HAS_MSA"
 "bexp.2b\t%w0,%w1"
  [(set_attr "type" "simd_bit")
   (set_attr "mode" "V16QI")])

(define_insn "msa_bexp_4b"
  [(set (match_operand:V16QI 0 "register_operand" "=f")
	(unspec:V16QI [(match_operand:V16QI 1 "register_operand" "f")]
	UNSPEC_MSA_BEXP_4B))]
 "ISA_HAS_MSA"
 "bexp.4b\t%w0,%w1"
  [(set_attr "type" "simd_bit")
   (set_attr "mode" "V16QI")])

(define_insn "msa_bmu_v"
  [(set (match_operand:V16QI 0 "register_operand" "=f")
	(unspec:V16QI [(match_operand:V16QI 1 "register_operand" "0")
	   (match_operand:V16QI 2 "register_operand" "f")
	   (match_operand:V16QI 3 "register_operand" "f")]
	UNSPEC_MSA_BMU_V))]
 "ISA_HAS_MSA"
 "bmu.v\t%w0,%w2,%w3"
  [(set_attr "type" "simd_bit")
   (set_attr "mode" "V16QI")])

(define_insn "msa_sll_v"
  [(set (match_operand:V16QI 0 "register_operand" "=f")
	(unspec:V16QI [(match_operand:V16QI 1 "register_operand" "f")
	   (match_operand:V16QI 2 "register_operand" "f")]
	UNSPEC_MSA_SLL_V))]
 "ISA_HAS_MSA"
 "sll.v\t%w0,%w1,%w2"
  [(set_attr "type" "simd_shift")
   (set_attr "mode" "V16QI")])

(define_insn "msa_slli_v"
  [(set (match_operand:V16QI 0 "register_operand" "=f")
	(unspec:V16QI [(match_operand:V16QI 1 "register_operand" "f")
	   (match_operand:V16QI 2 "const_uimm5_operand" "")]
	UNSPEC_MSA_SLLI_V))]
 "ISA_HAS_MSA"
 "slli.v\t%w0,%w1,%2"
  [(set_attr "type" "simd_shift")
   (set_attr "mode" "V16QI")])

(define_insn "msa_srl_v"
  [(set (match_operand:V16QI 0 "register_operand" "=f")
	(unspec:V16QI [(match_operand:V16QI 1 "register_operand" "f")
	   (match_operand:V16QI 2 "register_operand" "f")]
	UNSPEC_MSA_SRL_V))]
 "ISA_HAS_MSA"
 "srl.v\t%w0,%w1,%w2"
  [(set_attr "type" "simd_shift")
   (set_attr "mode" "V16QI")])

(define_insn "msa_srli_v"
  [(set (match_operand:V16QI 0 "register_operand" "=f")
	(unspec:V16QI [(match_operand:V16QI 1 "register_operand" "f")
	   (match_operand:V16QI 2 "const_uimm5_operand" "")]
	UNSPEC_MSA_SRLI_V))]
 "ISA_HAS_MSA"
 "srli.v\t%w0,%w1,%2"
  [(set_attr "type" "simd_shift")
   (set_attr "mode" "V16QI")])

(define_insn "msa_move_w"
  [(set (match_operand:V4SI 0 "register_operand" "=f")
	(unspec:V4SI [(match_operand:V4SI 1 "register_operand" "0")
	(match_operand 2 "const_0_to_3_operand" "")
	(match_operand:V4SI 3 "register_operand" "f")
	(match_operand 4 "const_0_to_3_operand" "")]
	UNSPEC_MSA_MOVE_W))]
 "ISA_HAS_MSA"
 "move.w\t%w0[%2],%w3[%4]"
  [(set_attr "type"	"simd_move")
   (set_attr "mode"	"V4SI")])

(define_insn "msa_movbt_b"
  [(set (match_operand:V16QI 0 "register_operand" "=f")
	(unspec:V16QI [(match_operand:V16QI 1 "register_operand" "f")
	(match_operand:V16QI 2 "register_operand" "f")]
	UNSPEC_MSA_MOVBT_B))]
 "ISA_HAS_MSA"
 "movbt.b\t%w0,%w1,%w2"
  [(set_attr "type"	"simd_move")
   (set_attr "mode"	"V16QI")])

(define_insn "msa_movbp_b"
  [(set (match_operand:V16QI 0 "register_operand" "=f")
	(unspec:V16QI [(match_operand:V16QI 1 "register_operand" "f")
	(match_operand:V16QI 2 "register_operand" "f")]
	UNSPEC_MSA_MOVBP_B))]
 "ISA_HAS_MSA"
 "movbp.b\t%w0,%w1,%w2"
  [(set_attr "type"	"simd_move")
   (set_attr "mode"	"V16QI")])

(define_insn "msa_satss_<hmsafmt>"
  [(set (match_operand:<VHMODE> 0 "register_operand" "=f")
	(unspec:<VHMODE> [(match_operand:IMSA_WH 1 "register_operand" "f")
	(match_operand:IMSA_WH 2 "register_operand" "f")]
	UNSPEC_MSA_SATSS))]
 "ISA_HAS_MSA"
 "satss.<hmsafmt>\t%w0,%w1,%w2"
  [(set_attr "type" "simd_sat")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_satuu_<hmsafmt>"
  [(set (match_operand:<VHMODE> 0 "register_operand" "=f")
	(unspec:<VHMODE> [(match_operand:IMSA_WH 1 "register_operand" "f")
	(match_operand:IMSA_WH 2 "register_operand" "f")]
	UNSPEC_MSA_SATUU))]
 "ISA_HAS_MSA"
 "satuu.<hmsafmt>\t%w0,%w1,%w2"
  [(set_attr "type" "simd_sat")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_satus_<hmsafmt>"
  [(set (match_operand:<VHMODE> 0 "register_operand" "=f")
	(unspec:<VHMODE> [(match_operand:IMSA_WH 1 "register_operand" "f")
	(match_operand:IMSA_WH 2 "register_operand" "f")]
	UNSPEC_MSA_SATUS))]
 "ISA_HAS_MSA"
 "satus.<hmsafmt>\t%w0,%w1,%w2"
  [(set_attr "type" "simd_sat")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_addsl_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:<VHMODE> 1 "register_operand" "f")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_ADDSL))]
 "ISA_HAS_MSA"
 "addsl.<msafmt>\t%w0,%w1,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_addsr_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:<VHMODE> 1 "register_operand" "f")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_ADDSR))]
 "ISA_HAS_MSA"
 "addsr.<msafmt>\t%w0,%w1,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_addul_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:<VHMODE> 1 "register_operand" "f")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_ADDUL))]
 "ISA_HAS_MSA"
 "addul.<msafmt>\t%w0,%w1,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_addur_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:<VHMODE> 1 "register_operand" "f")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_ADDUR))]
 "ISA_HAS_MSA"
 "addur.<msafmt>\t%w0,%w1,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_accsl_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:IMSA_WH 1 "register_operand" "0")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_ACCSL))]
 "ISA_HAS_MSA"
 "accsl.<msafmt>\t%w0,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_accsr_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:IMSA_WH 1 "register_operand" "0")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_ACCSR))]
 "ISA_HAS_MSA"
 "accsr.<msafmt>\t%w0,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_accul_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:IMSA_WH 1 "register_operand" "0")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_ACCUL))]
 "ISA_HAS_MSA"
 "accul.<msafmt>\t%w0,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_accur_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:IMSA_WH 1 "register_operand" "0")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_ACCUR))]
 "ISA_HAS_MSA"
 "accur.<msafmt>\t%w0,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_subsl_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:<VHMODE> 1 "register_operand" "f")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_SUBSL))]
 "ISA_HAS_MSA"
 "subsl.<msafmt>\t%w0,%w1,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_subsr_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:<VHMODE> 1 "register_operand" "f")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_SUBSR))]
 "ISA_HAS_MSA"
 "subsr.<msafmt>\t%w0,%w1,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_subul_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:<VHMODE> 1 "register_operand" "f")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_SUBUL))]
 "ISA_HAS_MSA"
 "subul.<msafmt>\t%w0,%w1,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_subur_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:<VHMODE> 1 "register_operand" "f")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_SUBUR))]
 "ISA_HAS_MSA"
 "subur.<msafmt>\t%w0,%w1,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_mulsl_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:<VHMODE> 1 "register_operand" "f")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_MULSL))]
 "ISA_HAS_MSA"
 "mulsl.<msafmt>\t%w0,%w1,%w2"
  [(set_attr "alu_type" "simd_add")
   (set_attr "type" "simd_int_arith")
   (set_attr "mode" "<MODE>")])

(define_insn "msa_mulsr_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:<VHMODE> 1 "register_operand" "f")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_MULSR))]
 "ISA_HAS_MSA"
 "mulsr.<msafmt>\t%w0,%w1,%w2"
  [(set_attr "mode"	"<MODE>")
   (set_attr "type" "simd_mul")])

(define_insn "msa_mulul_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:<VHMODE> 1 "register_operand" "f")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_MULUL))]
 "ISA_HAS_MSA"
 "mulul.<msafmt>\t%w0,%w1,%w2"
  [(set_attr "mode"	"<MODE>")
   (set_attr "type" "simd_mul")])

(define_insn "msa_mulur_<msafmt>"
  [(set (match_operand:IMSA_WH 0 "register_operand" "=f")
	(unspec:IMSA_WH [(match_operand:<VHMODE> 1 "register_operand" "f")
	(match_operand:<VHMODE> 2 "register_operand" "f")]
	UNSPEC_MSA_MULUR))]
 "ISA_HAS_MSA"
 "mulur.<msafmt>\t%w0,%w1,%w2"
  [(set_attr "mode"	"<MODE>")
   (set_attr "type" "simd_mul")])