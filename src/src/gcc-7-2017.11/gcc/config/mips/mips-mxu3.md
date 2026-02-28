;; Machine Description for MIPS INGENIC MXU3
;;
;; Copyright (C) 2014 Free Software Foundation, Inc.
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
   UNSPEC_MXU3_BNEZV
   UNSPEC_MXU3_BEQZV
   UNSPEC_MXU3_BNEZ
   UNSPEC_MXU3_BEQZ
   UNSPEC_MXU3_CEQZ
   UNSPEC_MXU3_CLEZ
   UNSPEC_MXU3_CLTZ
   UNSPEC_MXU3_INTSUM
   UNSPEC_MXU3_UUMRSUMAC
   UNSPEC_MXU3_SSMRSUMAC
   UNSPEC_MXU3_SUMRSUMAC
   UNSPEC_MXU3_UUMSUMAC
   UNSPEC_MXU3_SSMSUMAC
   UNSPEC_MXU3_SUMSUMAC
   UNSPEC_MXU3_UMAXBI
   UNSPEC_MXU3_UMINBI
   UNSPEC_MXU3_SATSSHB
   UNSPEC_MXU3_SATSSWB
   UNSPEC_MXU3_SATSSWH
   UNSPEC_MXU3_SATSUB2BI
   UNSPEC_MXU3_SATSUB4BI
   UNSPEC_MXU3_SATSUH2BI
   UNSPEC_MXU3_SATSUH4BI
   UNSPEC_MXU3_SATSUHB
   UNSPEC_MXU3_SATSUW2BI
   UNSPEC_MXU3_SATSUW4BI
   UNSPEC_MXU3_SATSUWB
   UNSPEC_MXU3_SATSUWH
   UNSPEC_MXU3_SATUUB2BI
   UNSPEC_MXU3_SATUUB4BI
   UNSPEC_MXU3_SATUUH2BI
   UNSPEC_MXU3_SATUUH4BI
   UNSPEC_MXU3_SATUUHB
   UNSPEC_MXU3_SATUUW4BI
   UNSPEC_MXU3_SATUUWB
   UNSPEC_MXU3_SATUUWH
   UNSPEC_MXU3_TOC
   UNSPEC_MXU3_FCLASS
   UNSPEC_MXU3_FTSIW
   UNSPEC_MXU3_FTUIW
   UNSPEC_MXU3_FRINTW
   UNSPEC_MXU3_FXAS1W
   UNSPEC_MXU3_FXAS2W
   UNSPEC_MXU3_FXAS4W
   UNSPEC_MXU3_FXAS8W
   UNSPEC_MXU3_SRAR
   UNSPEC_MXU3_SRARI
   UNSPEC_MXU3_SRLR
   UNSPEC_MXU3_SRLRI
   UNSPEC_MXU3_GT1BI
   UNSPEC_MXU3_GT2BI
   UNSPEC_MXU3_GT4BI
   UNSPEC_MXU3_GTB
   UNSPEC_MXU3_GTH
   UNSPEC_MXU3_EXTUQLL
   UNSPEC_MXU3_EXTUQLH
   UNSPEC_MXU3_EXTUQHL
   UNSPEC_MXU3_EXTUQHH
   UNSPEC_MXU3_EXTUOLL
   UNSPEC_MXU3_EXTUOLH
   UNSPEC_MXU3_EXTUOHL
   UNSPEC_MXU3_EXTUOHH
   UNSPEC_MXU3_EXT1BI
   UNSPEC_MXU3_EXT2BI
   UNSPEC_MXU3_EXT4BI
   UNSPEC_MXU3_EXTU3BW
   UNSPEC_MXU3_REPIO
   UNSPEC_MXU3_GSHUFW
   UNSPEC_MXU3_GSHUFWB
   UNSPEC_MXU3_GSHUFWB_1
   UNSPEC_MXU3_GSHUFWB_2
   UNSPEC_MXU3_GSHUFVB
   UNSPEC_MXU3_GSHUFB
   UNSPEC_MXU3_GSHUFWH
   UNSPEC_MXU3_GSHUFH
   UNSPEC_MXU3_BSHLI
   UNSPEC_MXU3_BSHL
   UNSPEC_MXU3_BSHRI
   UNSPEC_MXU3_BSHR
   UNSPEC_MXU3_LAW2B
   UNSPEC_MXU3_LAW2H
   UNSPEC_MXU3_LAW4B
   UNSPEC_MXU3_LAW4H
   UNSPEC_MXU3_LAW8B
   UNSPEC_MXU3_LAW8H
   UNSPEC_MXU3_LAW16B
   UNSPEC_MXU3_LAW16H
   UNSPEC_MXU3_LAD2B
   UNSPEC_MXU3_LAD2H
   UNSPEC_MXU3_LAD2W
   UNSPEC_MXU3_LAD4B
   UNSPEC_MXU3_LAD4H
   UNSPEC_MXU3_LAD4W
   UNSPEC_MXU3_LAD8B
   UNSPEC_MXU3_LAD8H
   UNSPEC_MXU3_LAD8W
   UNSPEC_MXU3_LAQ2B
   UNSPEC_MXU3_LAQ2H
   UNSPEC_MXU3_LAQ2W
   UNSPEC_MXU3_LAQ2D
   UNSPEC_MXU3_LAQ4B
   UNSPEC_MXU3_LAQ4H
   UNSPEC_MXU3_LAQ4W
   UNSPEC_MXU3_LAQ4D
   UNSPEC_MXU3_LAO2B
   UNSPEC_MXU3_LAO2H
   UNSPEC_MXU3_LAO2W
   UNSPEC_MXU3_LAO2D
   UNSPEC_MXU3_LAO2Q
   UNSPEC_MXU3_SAD2W
   UNSPEC_MXU3_SAD4W
   UNSPEC_MXU3_SAD8W
   UNSPEC_MXU3_SAQ2W
   UNSPEC_MXU3_SAQ2D
   UNSPEC_MXU3_SAQ4W
   UNSPEC_MXU3_SAQ4D
   UNSPEC_MXU3_SAO2W
   UNSPEC_MXU3_SAO2D
   UNSPEC_MXU3_SAO2Q
   UNSPEC_MXU3_PMAP
   UNSPEC_MXU3_CFCMXU
   UNSPEC_MXU3_CTCMXU
   UNSPEC_MXU3_LIWR
   UNSPEC_MXU3_FCMULRW
   UNSPEC_MXU3_FCMULIW
   UNSPEC_MXU3_FCADDW
   UNSPEC_MXU3_CMVW
   UNSPEC_MXU3_NNRWR
   UNSPEC_MXU3_NNRRD
   UNSPEC_MXU3_NNDWR
   UNSPEC_MXU3_NNDRD
   UNSPEC_MXU3_NNCMD
   UNSPEC_MXU3_NNMAC
   UNSPEC_MXU3_MOVW
   UNSPEC_MXU3_LOAD_PRE_SYNC
   UNSPEC_MXU3_LOAD_UPDATE_PRE_SYNC
   UNSPEC_MXU3_LAW2B_PRE_SYNC 
   UNSPEC_MXU3_LAW2H_PRE_SYNC 
   UNSPEC_MXU3_LAW4B_PRE_SYNC 
   UNSPEC_MXU3_LAW4H_PRE_SYNC 
   UNSPEC_MXU3_LAW8B_PRE_SYNC 
   UNSPEC_MXU3_LAW8H_PRE_SYNC 
   UNSPEC_MXU3_LAW16B_PRE_SYNC
   UNSPEC_MXU3_LAW16H_PRE_SYNC
   UNSPEC_MXU3_LAD2B_PRE_SYNC
   UNSPEC_MXU3_LAD2H_PRE_SYNC
   UNSPEC_MXU3_LAD2W_PRE_SYNC
   UNSPEC_MXU3_LAD4B_PRE_SYNC
   UNSPEC_MXU3_LAD4H_PRE_SYNC
   UNSPEC_MXU3_LAD4W_PRE_SYNC
   UNSPEC_MXU3_LAD8B_PRE_SYNC
   UNSPEC_MXU3_LAD8H_PRE_SYNC
   UNSPEC_MXU3_LAD8W_PRE_SYNC
  ])

(define_constants
  [(COP2_REG_FIRST     112)
   (COP2_REG_LAST      143)
   (VWR_REG_FIRST      192)
  ])

;; This attribute qives define_insn suffix for instructions
;; with need distinction between integer and floating point.
(define_mode_attr mxu3fmt_f
  [(V8DF  "d_f")
   (V16SF "w_f")
   (V8DI  "d")
   (V16SI "w")
   (V32HI "h")
   (V64QI "b")])
;;
(define_mode_attr imxu3fmt
  [(V16SI  "w")
   (V32HI  "h")
   (V64QI  "b")])

;;
(define_mode_attr imxu3hsfmt
  [(V16SI  "w")
   (V32HI  "h")])

;;
(define_mode_attr imxu3lfmt
  [(V2OI   "o")
   (V4TI   "q")
   (V8DI   "d")
   (V16SI  "w")
   (V32HI  "h")
   (V64QI  "b")])

(define_mode_attr imxu3wfmt
  [(V4TI   "q")
   (V8DI   "d")
   (V16SI  "w")])

(define_mode_attr imxu3vsifmt
  [(V16SI  "1")
   (V8SI   "2")
   (V4SI   "4")
   (V2SI   "8")
   (V1SI   "16")])

(define_mode_attr mxu3fmt1
  [(V16SF  "w")
   (V16SI  "sw")
   (V32HI  "sh")
   (V64QI  "sb")])

(define_mode_attr mxu3fmt2
  [(V16SF  "w")
   (V8DI   "d")
   (V16SI  "w")
   (V32HI  "h")
   (V64QI  "b")])

(define_mode_attr mxu3fmtp
  [(V16SF  "f")
   (V16SI  "")
   (V32HI  "")
   (V64QI  "")])
;;

(define_mode_attr  mxu3doublemode
  [(V64QI "V64HI") (V32HI "V32SI") (V16SI "V16DI")])

(define_mode_attr halfmode512
  [(V64QI "V32QI") (V32HI "V16HI") (V16SI "V8SI")
   (V8DI  "V4DI")  (V16SF "V8SF")  (V4TI  "V2TI")])

;; All vector modes with 512 bits.
(define_mode_iterator MODEMXU3  [V2OI V1SI V4TI V16SF V8DI V16SI V32HI V64QI])
(define_mode_iterator MODE512   [V2OI V4TI V16SF V8DI V16SI V32HI V64QI])
(define_mode_iterator MXU3      [V8DF V16SF V8DI V16SI V32HI V64QI])
(define_mode_iterator MXU3A     [V16SF V16SI V32HI V64QI])
(define_mode_iterator MXU3IF    [V16SF V16SI])

;; Only integer modes.
(define_mode_iterator IMXU3     [V16SI V32HI V64QI])
(define_mode_iterator IMXU3D    [V8DI V16SI V32HI V64QI])
(define_mode_iterator IMXU3DS   [V16SI V8DI])
(define_mode_iterator IMXU3HS   [V16SI V32HI])
(define_mode_iterator IMXU3HB   [V32HI V64QI])
(define_mode_iterator IMXU3L    [V4TI V8DI V16SI V32HI V64QI])
(define_mode_iterator IMXU3_LS  [V2OI V4TI V8DI V16SI])
(define_mode_iterator IMXU3VSI  [V16SI V8SI V4SI V2SI V1SI])

(define_code_iterator plusminus [plus minus])

;; Base name for define_insn
(define_code_attr plusminus_insn
  [(plus "add") (ss_plus "ssadd") (us_plus "usadd")
   (minus "sub") (ss_minus "sssub") (us_minus "ussub")])

(define_code_attr plusminus_abbr [(plus "a") (minus "s")])

;;
;;Compare & Float point compare
;;
(define_code_iterator MXU3_FCC [ordered eq le lt])

(define_code_attr mxu3_fcc
    [(ordered   "fcorw")
     (eq        "fceqw")
     (le        "fclew")
     (lt        "fcltw")])

(define_code_iterator MXU3_ICC [eq le leu lt ltu])

(define_code_attr mxu3_icc
    [(eq  "eq")
     (le  "les")
     (leu "leu")
     (lt  "lts")
     (ltu "ltu")])

(define_mode_attr mxu3a_cmp_res
    [(V16SF  "v16si")
     (V16SI  "v16si")
     (V32HI  "v32hi")
     (V64QI  "v64qi")])

(define_mode_attr MXU3A_cmp_res
    [(V16SF  "V16SI")
     (V16SI  "V16SI")
     (V32HI  "V32HI")
     (V64QI  "V64QI")])

(define_mode_attr mxu3a_cmp_mixed
    [(V16SF  "v16si")
     (V16SI  "v16sf")])

(define_mode_attr MXU3A_cmp_mixed
    [(V16SF  "V16SI")
     (V16SI  "V16SF")])

;; This attribute is used to form an immediate operand constraint using
;; "const_<imxu3vsi_imm>_operand".
(define_mode_attr imxu3vsi_imm
  [(V16SI "uimm0")
   (V8SI  "uimm1")
   (V4SI  "uimm2")
   (V2SI  "uimm3")
   (V1SI  "uimm4")])

;; "const_<imxu3vsi_immrec>_operand".
(define_mode_attr imxu3vsi_immrec
  [(V16SI "uimm4")
   (V8SI  "uimm3")
   (V4SI  "uimm2")
   (V2SI  "uimm1")
   (V1SI  "uimm0")])

;; "const_<mxu3_bitimm>_operand".
(define_mode_attr mxu3_bitimm
  [(V64QI "uimm3")
   (V32HI "uimm4")
   (V16SI "uimm5")])

;; "const_<elemindex>_operand"
(define_mode_attr elemindex
  [(V64QI "uimm6")
   (V32HI "uimm5")
   (V16SI "uimm4")
   (V8DI  "uimm3")
   (V4TI  "0_to_3")
   (V2OI  "uimm1")
   (V16SF "uimm4")])

(define_mode_attr unit_memoff 
  [(V64QI "imm5")
   (V32HI "imm6")
   (V16SI "imm7")
   (V8DI  "imm8")
   (V4TI  "imm9")
   (V2OI  "imm10")])


;;
;; vec_init
;;
(define_mode_iterator MODE512_VEC   [V16SF V8DI V16SI V32HI V64QI])

(define_expand "vec_init<mode>"
  [(match_operand:MODE512_VEC 0 "register_operand")
   (match_operand:MODE512_VEC 1 "reg_or_0_operand")]
  "ISA_HAS_MXU3"
{
  mips_expand_vector_init (operands[0], operands[1]);
  DONE;
})

(define_insn "mxu3_vec_duplicate<mode>"
  [(set (match_operand:MODE512_VEC 0 "register_operand" "=q,q")
	(vec_duplicate:MODE512_VEC
	  (match_operand:<UNITMODE> 1 "reg_or_0_operand" "d,f")))]
  "ISA_HAS_MXU3"
  "#"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

(define_split
  [(set (match_operand:MODE512_VEC 0 "register_operand")
	(vec_duplicate:MODE512_VEC
	  (match_operand:<UNITMODE> 1 "reg_or_0_operand")))]
  "ISA_HAS_MXU3 && reload_completed"
  [(const_int 0)]
{
  rtx tos, vop;
  machine_mode mode = GET_MODE (operands[1]);
  if (mode != DImode)
    {
      tos = gen_tmp_stack_mem (mode, gen_rtx_PLUS (SImode, stack_pointer_rtx, GEN_INT(-4)));
      vop = gen_rtx_REG (V16SImode, REGNO (operands[0]));

      mips_emit_move (tos, operands[1]);
      emit_insn (gen_mxu3_law_insn (vop, vop, GEN_INT (1), stack_pointer_rtx, GEN_INT (-4)));

      if (mode != SFmode)
        vop = operands[0];

      emit_insn (gen_mxu3_repi<mxu3fmt2> (vop, vop, GEN_INT (0)));
    }
  else
    {
      tos = gen_tmp_stack_mem (mode, gen_rtx_PLUS (SImode, stack_pointer_rtx, GEN_INT(-8)));
      vop = gen_rtx_REG (V8DImode, REGNO (operands[0]));

      mips_emit_move (tos, operands[1]);
      emit_insn (gen_mxu3_lad_insn (vop, vop, GEN_INT (1), stack_pointer_rtx, GEN_INT (-8)));
      emit_insn (gen_mxu3_repid (operands[0], operands[0], GEN_INT (0)));
    }
  DONE;
})

(define_expand "vec_set<mode>"
  [(match_operand:MODE512_VEC 0 "register_operand")
   (match_operand:<UNITMODE> 1 "register_operand")
   (match_operand:SI 2 "immediate_operand")]
  "ISA_HAS_MXU3"
  {
    if (GET_MODE (operands[0]) == V16SImode
        && GET_CODE (operands[1]) == SUBREG
        && GET_MODE (SUBREG_REG (operands[1])) == V1SImode)
      {
        emit_insn (gen_mxu3_movw_v16si (operands[0], operands[2],
                                        SUBREG_REG (operands[1])));
      }
    else
      {
        unsigned HOST_WIDE_INT elem = (unsigned HOST_WIDE_INT) 1 << INTVAL (operands[2]);
        emit_insn (gen_mxu3_vec_set<mode> (operands[0], operands[1],
                                       GEN_INT (elem), operands[0]));
      }
    DONE;
  }
)

(define_insn "mxu3_vec_set<mode>"
  [(set (match_operand:MODE512_VEC 0 "register_operand" "=q,q")
        (vec_merge:MODE512_VEC
            (vec_duplicate:MODE512_VEC
                (match_operand:<UNITMODE> 1 "register_operand" "d,f"))
            (match_operand:MODE512_VEC 3 "register_operand" "0,0")
            (match_operand:DI 2 "immediate_operand" "")))]
  "ISA_HAS_MXU3"
  "#"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

(define_split
  [(set (match_operand:MODE512_VEC 0 "register_operand")
        (vec_merge:MODE512_VEC
            (vec_duplicate:MODE512_VEC
                (match_operand:<UNITMODE> 1 "register_operand"))
            (match_operand:MODE512_VEC 3 "register_operand")
            (match_operand:DI 2 "immediate_operand")))]
  "ISA_HAS_MXU3 && reload_completed"
  [(const_int 0)]
{
  rtx tos, vop;
  machine_mode mode = GET_MODE (operands[1]);
  unsigned HOST_WIDE_INT sel = INTVAL (operands[2]);
  int pos = -1, off = -4, size = GET_MODE_SIZE (mode);

  while (sel)
    {
      sel = sel >> 1;
      pos++;
    }

  if (mode != DImode)
    {
      off += (pos & (7 >> size)) * size;
      pos = pos / (4 / size);
      tos = gen_tmp_stack_mem (mode, gen_rtx_PLUS (SImode, stack_pointer_rtx, GEN_INT(off)));
      vop = gen_rtx_REG (V16SImode, REGNO (operands[0]));

      if (size < 4)
        emit_insn (gen_mxu3_saw_insn (vop, GEN_INT (pos), stack_pointer_rtx, GEN_INT (-4)));
      mips_emit_move (tos, operands[1]);
      emit_insn
        (gen_mxu3_law_insn (vop, vop, GEN_INT (1 << pos), stack_pointer_rtx, GEN_INT (-4)));
    }
  else
    {
      tos = gen_tmp_stack_mem (mode, gen_rtx_PLUS (SImode, stack_pointer_rtx, GEN_INT(-8)));
      vop = gen_rtx_REG (V8DImode, REGNO (operands[0]));

      mips_emit_move (tos, operands[1]);
      emit_insn
        (gen_mxu3_lad_insn (vop, vop, GEN_INT (1 << pos), stack_pointer_rtx, GEN_INT (-8)));
    }
  DONE;
})

;;
;; move
;;
(define_expand "mov<mode>"
  [(set (match_operand:MODEMXU3 0)
        (match_operand:MODEMXU3 1))]
  "ISA_HAS_MXU3"
{
  if (mips_legitimize_move (<MODE>mode, operands[0], operands[1]))
    DONE;
})

(define_expand "movmisalign<mode>"
  [(set (match_operand:MODEMXU3 0)
	(match_operand:MODEMXU3 1))]
  "ISA_HAS_MXU3"
{
  if (mips_legitimize_move (<MODE>mode, operands[0], operands[1]))
    DONE;
})

(define_insn "mov<mode>_mxu3"
  [(set (match_operand:MODE512 0 "nonimmediate_operand" "=q,T,q,R,q,q,q,T")
	(match_operand:MODE512 1 "move_operand"          "q,q,T,q,R,YX,YG,YG"))]
  "ISA_HAS_MXU3
   && (register_operand (operands[0], <MODE>mode)
       || reg_or_0_operand (operands[1], <MODE>mode))"
{  return mips_output_move (operands[0], operands[1]); }
   [(set_attr "mode"     "TI")])

(define_split
  [(set (match_operand:MODE512 0 "nonimmediate_operand")
	(match_operand:MODE512 1 "move_operand"))]
  "reload_completed && TARGET_MXU3
   && mips_split_512bit_move_p (operands[0], operands[1])"
  [(const_int 0)]
{
  mips_split_512bit_move (operands[0], operands[1]);
  DONE;
})

(define_split
  [(set (match_operand:SI 0 "nonimmediate_operand")
    (match_operand:SI 1 "move_operand"))]
    "reload_completed && TARGET_MXU3
     && mips_split_move_insn_p (operands[0], operands[1], insn)"
  [(const_int 0)]
{
  mips_split_move_insn (operands[0], operands[1], curr_insn);
  DONE;
})


(define_insn "mxu3_vwr_move"
  [(set (match_operand:V1SI 0 "nonimmediate_operand" "=w,w,R,*q,*w,w")
        (match_operand:V1SI 1 "move_operand" "w,R,w,*w,*q,YGYX"))
   (use (reg:V16SI COP2_REG_LAST))]
  "ISA_HAS_MXU3"
   "@
    movw\t$vr31[%e0],$vr31[%e1]
    law\t$vr31[%e0],%1
    saw\t$vr31[%e1],%0
    movw\t%w0[0],$vr31[%e1]
    movw\t$vr31[%e0],%w1[0]
    liwr\t%w0,%E1"
   [(set_attr "mode" "TI")])

;; Special case for transferring data from VWR to VPR.
(define_insn "mxu3_movw_v16si"
  [(set (match_operand:V16SI 0 "register_operand" "+q")
      (unspec:V16SI [(match_dup 0)
        (match_operand:SI 1 "const_uimm4_operand" "")
        (match_operand:V1SI 2 "register_operand" "w")]
       UNSPEC_MXU3_MOVW))
    (use (reg:V16SI COP2_REG_LAST))]
  "ISA_HAS_MXU3"
  "movw\t%w0[%1],$vr31[%e2]"
  [(set_attr "mode" "TI")])

;; Special case for transferring date from VPR to VWR.
(define_insn "mxu3_movw_v1si"
  [(set (match_operand:V1SI 0 "register_operand" "=w")
      (unspec:V1SI [(match_operand:V16SI 1 "register_operand" "q")
          (match_operand:SI 2 "const_uimm4_operand" "")]
       UNSPEC_MXU3_MOVW))
    (use (reg:V16SI COP2_REG_LAST))]
  "ISA_HAS_MXU3"
  "movw\t$vr31[%e0],%w1[%2]"
  [(set_attr "mode" "TI")])

;;
;; branch
;;
;;bnezv
(define_insn "mxu3_branchnz_v_<mxu3fmt_f>"
 [(set (pc) (if_then_else
       	        (ne (unspec:SI [(match_operand:MXU3 1 "register_operand" "q")]
	     	 	     UNSPEC_MXU3_BNEZV)
	        (match_operand:SI 2 "const_0_operand"))
	     (label_ref (match_operand 0))
	     (pc)))]
  "ISA_HAS_MXU3"
  {
	return mips_output_conditional_branch (insn, operands,
	       				      MIPS_BRANCH ("bnezv", "%w1,%0"),
	       				      MIPS_BRANCH ("beqzv", "%w1,%0"));
  }
  [(set_attr "lat_type"	"lat3")
   (set_attr "type" "simd_branch")])

(define_expand "mxu3_bnezv_<mxu3fmt_f>"
 [(set (match_operand:SI 0 "register_operand" "=d")
       (unspec:SI [(match_operand:MXU3 1 "register_operand" "q")]
       UNSPEC_MXU3_BNEZV))]
 "ISA_HAS_MXU3"
 {
	mips_expand_mxu3_branch (operands, gen_mxu3_branchnz_v_<MXU3:mxu3fmt_f>);
	DONE;
 })

;;beqzv
(define_insn "mxu3_branchz_v_<mxu3fmt_f>"
 [(set (pc) (if_then_else
       	        (eq (unspec:SI [(match_operand:MXU3 1 "register_operand" "q")]
	     	 	     UNSPEC_MXU3_BEQZV)
	        (match_operand:SI 2 "const_0_operand"))
	     (label_ref (match_operand 0))
	     (pc)))]
  "ISA_HAS_MXU3"
  {
	return mips_output_conditional_branch (insn, operands,
	       				      MIPS_BRANCH ("beqzv", "%w1,%0"),
	       				      MIPS_BRANCH ("bnezv", "%w1,%0"));
  }
  [(set_attr "lat_type"	"unknown")
   (set_attr "type" "simd_branch")])

(define_expand "mxu3_beqzv_<mxu3fmt_f>"
 [(set (match_operand:SI 0 "register_operand" "=d")
       (unspec:SI [(match_operand:MXU3 1 "register_operand" "q")]
        UNSPEC_MXU3_BEQZV))]
 "ISA_HAS_MXU3"
 {
	mips_expand_mxu3_branch (operands, gen_mxu3_branchz_v_<MXU3:mxu3fmt_f>);
	DONE;
 })

;; bnez<imxu3fmt>
(define_insn "mxu3_branchnz_<imxu3fmt>"
 [(set (pc) (if_then_else
       	        (ne (unspec:SI [(match_operand:IMXU3 1 "register_operand" "q")]
	     	 	     UNSPEC_MXU3_BNEZ)
	        (match_operand:IMXU3 2 "const_0_operand"))
	     (label_ref (match_operand 0))
	     (pc)))]
  "ISA_HAS_MXU3"
  {
	return mips_output_conditional_branch (insn, operands,
	       				      MIPS_BRANCH ("bnez<imxu3fmt>", "%w1,%0"),
	       				      MIPS_BRANCH ("beqz<imxu3fmt>", "%w1,%0"));
  }
  [(set_attr "lat_type"	"unknown")
   (set_attr "type" "simd_branch")])

(define_expand "mxu3_bnez<imxu3fmt>"
 [(set (match_operand:SI 0 "register_operand" "=d")
       (unspec:SI [(match_operand:IMXU3 1 "register_operand" "q")]
       UNSPEC_MXU3_BNEZ))]
 "ISA_HAS_MXU3"
 {
	mips_expand_mxu3_branch (operands, gen_mxu3_branchnz_<IMXU3:imxu3fmt>);
	DONE;
 })


;; beqz<imxu3fmt>
(define_insn "mxu3_branchz_<imxu3fmt>"
 [(set (pc) (if_then_else
       	        (eq (unspec:SI [(match_operand:IMXU3 1 "register_operand" "q")]
	     	 	     UNSPEC_MXU3_BEQZ)
	        (match_operand:IMXU3 2 "const_0_operand"))
	     (label_ref (match_operand 0))
	     (pc)))]
  "ISA_HAS_MXU3"
  {
	return mips_output_conditional_branch (insn, operands,
	       				      MIPS_BRANCH ("beqz<imxu3fmt>", "%w1,%0"),
	       				      MIPS_BRANCH ("bnez<imxu3fmt>", "%w1,%0"));
  }
  [(set_attr "lat_type"	"unknown")
   (set_attr "type" "simd_branch")])

(define_expand "mxu3_beqz<imxu3fmt>"
 [(set (match_operand:SI 0 "register_operand" "=d")
       (unspec:SI [(match_operand:IMXU3 1 "register_operand" "q")]
       UNSPEC_MXU3_BEQZ))]
 "ISA_HAS_MXU3"
 {
	mips_expand_mxu3_branch (operands, gen_mxu3_branchz_<IMXU3:imxu3fmt>);
	DONE;
 })

;;
;; Compare
;;

(define_expand "vec_cmp<mode><mode>"
  [(set (match_operand:IMXU3 0 "register_operand")
	(match_operator 1 "comparison_operator"
	    [(match_operand:IMXU3 2 "register_operand")
	     (match_operand:IMXU3 3 "nonmemory_operand")]))]
  "ISA_HAS_MXU3"
{
  rtx mask = operands[0];
  enum rtx_code code = GET_CODE (operands[1]);
  bool cmp_zero = false;
  

  switch (code)
    {
    case EQ:
    case NE:
      if (operands[3] == CONST0_RTX (<MODE>mode))
      {
        cmp_zero = true;
        break;
      }

      /* Fall through.  */
    default:
      if (!REG_P (operands[3]))
        operands[3] = force_reg (<MODE>mode, operands[3]);

      break;
    }

  switch (code)
    {
    case EQ:
      if (cmp_zero)
        emit_insn (gen_mxu3_ceqz<mxu3fmt2> (mask, operands[2]));
      else
        emit_insn (gen_mxu3_ceq<mxu3fmt2> (mask, operands[2],  operands[3]));
      break;

    case NE:
      if (cmp_zero)
        emit_insn (gen_mxu3_ceqz<mxu3fmt2> (mask, operands[2]));
      else
        emit_insn (gen_mxu3_ceq<mxu3fmt2> (mask, operands[2], operands[3]));
      emit_insn (gen_one_cmpl<mode>2 (mask, mask));
      break;

    case LT:
      emit_insn (gen_mxu3_clts<mxu3fmt2> (mask, operands[2], operands[3]));
      break;

    case LE:
      emit_insn (gen_mxu3_cles<mxu3fmt2> (mask, operands[2], operands[3]));
      break;

    case LTU:
      emit_insn (gen_mxu3_cltu<mxu3fmt2> (mask, operands[2], operands[3]));
      break;

    case LEU:
      emit_insn (gen_mxu3_cleu<mxu3fmt2> (mask, operands[2], operands[3]));
      break;

    case GE:
      emit_insn (gen_mxu3_cles<mxu3fmt2> (mask, operands[3], operands[2]));
      break;

    case GT:
      emit_insn (gen_mxu3_clts<mxu3fmt2> (mask, operands[3], operands[2]));
      break;

    case GEU:
      emit_insn (gen_mxu3_cleu<mxu3fmt2> (mask, operands[3], operands[2]));
      break;

    case GTU:
      emit_insn (gen_mxu3_cltu<mxu3fmt2> (mask, operands[3], operands[2]));
      break;

    default:
      gcc_unreachable ();
    }

  DONE;
})

(define_expand "vec_cmpv16sfv16si"
  [(set (match_operand:V16SI 0 "register_operand")
	(match_operator 1 "comparison_operator"
	    [(match_operand:V16SF 2 "register_operand")
	     (match_operand:V16SF 3 "nonmemory_operand")]))]
  "ISA_HAS_MXU3"
{
  enum rtx_code code = GET_CODE (operands[1]);
  rtx tmp = gen_reg_rtx (V16SImode);

  rtx (*comparison) (rtx, rtx, rtx) = NULL;

  if (!REG_P (operands[3]))
    operands[3] = force_reg (V16SFmode, operands[3]);

  switch (code)
    {
    case GT:
    case UNLE:
      std::swap (operands[2], operands[3]);
      /* Fall through.  */
    case UNGE:
    case LT:
      comparison = gen_mxu3_fcltw;
      break;
    case GE:
    case UNLT:
      std::swap (operands[2], operands[3]);
      /* Fall through.  */
    case UNGT:
    case LE:
      comparison = gen_mxu3_fclew;
      break;
    case NE:
    case EQ:
      comparison = gen_mxu3_fceqw;
      break;
    case UNEQ:
    case ORDERED:
    case UNORDERED:
      break;
    default:
      gcc_unreachable ();
    }

  switch (code)
    {
    case UNGE:
    case UNGT:
    case UNLE:
    case UNLT:
    case NE:
      /* FCM returns false for lanes which are unordered, so if we use
         the inverse of the comparison we actually want to emit, then
         invert the result, we will end up with the correct result.
         Note that a NE NaN and NaN NE b are true for all a, b.

         Our transformations are:
         a UNGE b -> !(b GT a) -> !(a LT b)
         a UNGT b -> !(b GE a) -> !(a LE b)
         a UNLE b -> !(a GT b) -> !(b LT a)
         a UNLT b -> !(a GE b) -> !(b LE a)
         a   NE b -> !(a EQ b)  */
      gcc_assert (comparison != NULL);
      emit_insn (comparison (operands[0], operands[2], operands[3]));
      emit_insn (gen_one_cmplv16si2 (operands[0], operands[0]));
      break;

    case LT:
    case LE:
    case GT:
    case GE:
    case EQ:
      /* The easy case.  Here we emit one of FCMLE, FCMLT or FCMEQ.
         As a LT b <=> b GE a && a LE b <=> b GT a.  Our transformations are:
         a GE b -> a GE b -> b LE a
         a GT b -> a GT b -> b LT a
         a LE b -> b GE a -> a LE b
         a LT b -> b GT a -> a LT b
         a EQ b -> a EQ b  */
      gcc_assert (comparison != NULL);
      emit_insn (comparison (operands[0], operands[2], operands[3]));
      break;

    case UNEQ:
      /* We check (a == b || !(a ORDERED b)).  */
      gcc_assert (comparison != NULL);
      emit_insn (comparison (operands[0], operands[2], operands[3]));
      emit_insn (gen_mxu3_fcorw (tmp, operands[2], operands[3]));
      emit_insn (gen_one_cmplv16si2 (tmp, tmp));
      emit_insn (gen_iorv16si3 (operands[0], operands[0], tmp));
      break;

    case UNORDERED:
      /* Operands are ORDERED iff (a > b || b >= a), so we can compute
         UNORDERED as !ORDERED.  */
      emit_insn (gen_mxu3_fcorw (operands[0], operands[2], operands[3]));
      emit_insn (gen_one_cmplv16si2 (operands[0], operands[0]));
      break;

    case ORDERED:
      emit_insn (gen_mxu3_fcorw (operands[0], operands[2], operands[3]));
      break;

    default:
      gcc_unreachable ();
    }

  DONE;
})

(define_expand "vec_cmpu<mode><mode>"
  [(set (match_operand:IMXU3 0 "register_operand")
	  (match_operator 1 "comparison_operator"
	    [(match_operand:IMXU3 2 "register_operand")
	     (match_operand:IMXU3 3 "nonmemory_operand")]))]
  "ISA_HAS_MXU3"
{
  emit_insn (gen_vec_cmp<mode><mode> (operands[0], operands[1],
	                              operands[2], operands[3]));
  DONE;
})

(define_expand "vcond_mask_<mode><mxu3a_cmp_res>"
  [(match_operand:MXU3A 0 "register_operand")                           
   (match_operand:MXU3A 1 "nonmemory_operand")                          
   (match_operand:MXU3A 2 "nonmemory_operand")                          
   (match_operand:<MXU3A_cmp_res> 3 "register_operand")]
  "ISA_HAS_MXU3"
{     
  /* If we have (a = (P) ? -1 : 0);                                      
     Then we can simply move the generated mask (result must be int).  */
  if (operands[1] == CONSTM1_RTX (<MODE>mode)
      && operands[2] == CONST0_RTX (<MODE>mode)) 
    emit_move_insn (operands[0], operands[3]);                           
  /* Similarly, (a = (P) ? 0 : -1) is just inverting the generated mask.  */
  else if (operands[1] == CONST0_RTX (<MODE>mode)                        
           && operands[2] == CONSTM1_RTX (<MODE>mode))                   
    emit_insn (gen_one_cmpl<mxu3a_cmp_res>2 (operands[0], operands[3]));
  else
    {
      if (!REG_P (operands[1]))                                          
        operands[1] = force_reg (<MODE>mode, operands[1]);               
      if (!REG_P (operands[2]))
        operands[2] = force_reg (<MODE>mode, operands[2]);
      emit_insn (gen_mxu3_bselv<mode> (operands[0], operands[3],
                                                operands[2], operands[1]));
    }

  DONE;
})

(define_expand "vcond<mode><mode>"
  [(set (match_operand:MXU3A 0 "register_operand")
	(if_then_else:MXU3A
	  (match_operator 3 "comparison_operator"
	    [(match_operand:MXU3A 4 "register_operand")
	     (match_operand:MXU3A 5 "nonmemory_operand")])
	  (match_operand:MXU3A 1 "nonmemory_operand")
	  (match_operand:MXU3A 2 "nonmemory_operand")))]
  "ISA_HAS_MXU3"
{
  rtx mask = gen_reg_rtx (<MXU3A_cmp_res>mode);
  enum rtx_code code = GET_CODE (operands[3]);

  /* NE is handled as !EQ in vec_cmp patterns, we can explicitly invert
     it as well as switch operands 1/2 in order to avoid the additional
     NOT instruction.  */
  if (code == NE)
    {
      operands[3] = gen_rtx_fmt_ee (EQ, GET_MODE (operands[3]),
        			    operands[4], operands[5]);
      std::swap (operands[1], operands[2]);
    }
  emit_insn (gen_vec_cmp<mode><mxu3a_cmp_res> (mask, operands[3],
        			               operands[4], operands[5]));
  emit_insn (gen_vcond_mask_<mode><mxu3a_cmp_res> (operands[0], operands[1],
  					           operands[2], mask));

  DONE;
})

(define_expand "vcond<mxu3a_cmp_mixed><mode>"
  [(set (match_operand:<MXU3A_cmp_mixed> 0 "register_operand")
	(if_then_else:<MXU3A_cmp_mixed>
	  (match_operator 3 "comparison_operator"
	    [(match_operand:MXU3IF 4 "register_operand")
	     (match_operand:MXU3IF 5 "nonmemory_operand")])
	  (match_operand:<MXU3A_cmp_mixed> 1 "nonmemory_operand")
	  (match_operand:<MXU3A_cmp_mixed> 2 "nonmemory_operand")))]
  "ISA_HAS_MXU3"
{
  rtx mask = gen_reg_rtx (<MXU3A_cmp_res>mode);
  enum rtx_code code = GET_CODE (operands[3]);

  /* NE is handled as !EQ in vec_cmp patterns, we can explicitly invert
     it as well as switch operands 1/2 in order to avoid the additional
     NOT instruction.  */
  if (code == NE)
    {
      operands[3] = gen_rtx_fmt_ee (EQ, GET_MODE (operands[3]),
        			    operands[4], operands[5]);
      std::swap (operands[1], operands[2]);
    }
  emit_insn (gen_vec_cmp<mode><mxu3a_cmp_res> (mask, operands[3],
        			               operands[4], operands[5]));
  emit_insn (gen_vcond_mask_<mxu3a_cmp_mixed><mxu3a_cmp_res> (operands[0], operands[1],
  					                      operands[2], mask));

  DONE;
})

(define_expand "vcondu<mode><mode>"
  [(set (match_operand:IMXU3 0 "register_operand")
	(if_then_else:IMXU3
	  (match_operator 3 "comparison_operator"
	    [(match_operand:IMXU3 4 "register_operand")
	     (match_operand:IMXU3 5 "nonmemory_operand")])
	  (match_operand:IMXU3 1 "nonmemory_operand")
	  (match_operand:IMXU3 2 "nonmemory_operand")))]
  "ISA_HAS_MXU3"
{
  emit_insn (gen_vcond<mode><mode> (operands[0], operands[1],
	                            operands[2], operands[3],
	                            operands[4], operands[5]));
  DONE;
})

(define_expand "vconduv16sfv16si"
  [(set (match_operand:V16SF 0 "register_operand")
	(if_then_else:V16SF
	  (match_operator 3 "comparison_operator"
	    [(match_operand:V16SI 4 "register_operand")
	     (match_operand:V16SI 5 "nonmemory_operand")])
	  (match_operand:V16SF 1 "nonmemory_operand")
	  (match_operand:V16SF 2 "nonmemory_operand")))]
  "ISA_HAS_MXU3"
{
  rtx mask = gen_reg_rtx (V16SImode);
  enum rtx_code code = GET_CODE (operands[3]);

  /* NE is handled as !EQ in vec_cmp patterns, we can explicitly invert
     it as well as switch operands 1/2 in order to avoid the additional
     NOT instruction.  */
  if (code == NE)
    {
      operands[3] = gen_rtx_fmt_ee (EQ, GET_MODE (operands[3]),
        			    operands[4], operands[5]);
      std::swap (operands[1], operands[2]);
    }
  emit_insn (gen_vec_cmpv16siv16si (mask, operands[3],
        	                    operands[4], operands[5]));
  emit_insn (gen_vcond_mask_v16sfv16si (operands[0], operands[1],
			                operands[2], mask));

  DONE;
})

(define_insn "mxu3_c<MXU3_ICC:mxu3_icc><IMXU3:mxu3fmt2>"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
	(MXU3_ICC:IMXU3 (match_operand:IMXU3 1 "register_operand" "q")
		  (match_operand:IMXU3 2 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "c<MXU3_ICC:mxu3_icc><IMXU3:mxu3fmt2>\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

(define_insn "mxu3_ceqz<mxu3fmt2>"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
	(unspec:IMXU3 [(match_operand:IMXU3 1 "register_operand" "q")]
	UNSPEC_MXU3_CEQZ))]
  "ISA_HAS_MXU3"
  "ceqz<mxu3fmt2>\t%w0,%w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

(define_insn "mxu3_clez<mxu3fmt2>"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
	(unspec:IMXU3 [(match_operand:IMXU3 1 "register_operand" "q")]
	UNSPEC_MXU3_CLEZ))]
  "ISA_HAS_MXU3"
  "clez<mxu3fmt2>\t%w0,%w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

(define_insn "mxu3_cltz<mxu3fmt2>"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
	(unspec:IMXU3 [(match_operand:IMXU3 1 "register_operand" "q")]
	UNSPEC_MXU3_CLTZ))]
  "ISA_HAS_MXU3"
  "cltz<mxu3fmt2>\t%w0,%w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;;
;; integer arithmetic
;;
;; ADD
(define_insn "add<mode>3"
[(set (match_operand:MXU3A 0 "register_operand" "=q")
      (plus:MXU3A
        (match_operand:MXU3A 1 "register_operand" "q")
        (match_operand:MXU3A 2 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "<mxu3fmtp>add<mxu3fmt2>\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

(define_insn "addv1si3"
  [(set (match_operand:V1SI 0 "register_operand" "=w")
        (plus:V1SI
          (match_operand:V1SI 1 "register_operand" "%0")
          (match_operand:V1SI 2 "register_operand" "w")))
   (use (reg:V16SI COP2_REG_LAST))]
  "ISA_HAS_MXU3"
  "addrw\t%w0,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

(define_insn "mxu3_addiw"
  [(set (match_operand:V1SI 0 "register_operand" "=w")
        (plus:V1SI
          (match_operand:V1SI 1 "register_operand" "w")
          (const_vector:V1SI 
            [(match_operand 2 "const_imm8_operand" "")])))
   (use (reg:V16SI COP2_REG_LAST))]
  "ISA_HAS_MXU3"
  "addiw\t%w0,%w1,%2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SUB
(define_insn "sub<mode>3"
[(set (match_operand:MXU3A 0 "register_operand" "=q")
      (minus:MXU3A
        (match_operand:MXU3A 1 "register_operand" "q")
        (match_operand:MXU3A 2 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "<mxu3fmtp>sub<mxu3fmt2>\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; W(ADD,SUB)<SU>BL
(define_insn "mxu3_w<plusminus_insn><su>bl"
[(set (match_operand:V32HI 0 "register_operand" "=q")
      (plusminus:V32HI
        (match_operand:V32HI 1 "register_operand" "q")
        (any_extend:V32HI
          (vec_select:V32QI
            (match_operand:V64QI 2 "register_operand" "q")
            (parallel [(const_int 0)  (const_int 1)  (const_int 2)  (const_int 3)
                       (const_int 4)  (const_int 5)  (const_int 6)  (const_int 7)
                       (const_int 8)  (const_int 9)  (const_int 10) (const_int 11)
                       (const_int 12) (const_int 13) (const_int 14) (const_int 15)
                       (const_int 16) (const_int 17) (const_int 18) (const_int 19)
                       (const_int 20) (const_int 21) (const_int 22) (const_int 23)
                       (const_int 24) (const_int 25) (const_int 26) (const_int 27)
                       (const_int 28) (const_int 29) (const_int 30) (const_int 31)])))))]
  "ISA_HAS_MXU3"
  "w<plusminus_insn><su>bl\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; W(ADD,SUB)<SU>BH
(define_insn "mxu3_w<plusminus_insn><su>bh"
[(set (match_operand:V32HI 0 "register_operand" "=q")
      (plusminus:V32HI
        (match_operand:V32HI 1 "register_operand" "q")
        (any_extend:V32HI
          (vec_select:V32QI
            (match_operand:V64QI 2 "register_operand" "q")
            (parallel [(const_int 32) (const_int 33) (const_int 34) (const_int 35)
                       (const_int 36) (const_int 37) (const_int 38) (const_int 39)
                       (const_int 40) (const_int 41) (const_int 42) (const_int 43)
                       (const_int 44) (const_int 45) (const_int 46) (const_int 47)
                       (const_int 48) (const_int 49) (const_int 50) (const_int 51)
                       (const_int 52) (const_int 53) (const_int 54) (const_int 55)
                       (const_int 56) (const_int 57) (const_int 58) (const_int 59)
                       (const_int 60) (const_int 61) (const_int 62) (const_int 63)])))))]
  "ISA_HAS_MXU3"
  "w<plusminus_insn><su>bh\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; W(ADD,SUB)<SU>HL
(define_insn "mxu3_w<plusminus_insn><su>hl"
[(set (match_operand:V16SI 0 "register_operand" "=q")
      (plusminus:V16SI
        (match_operand:V16SI 1 "register_operand" "q")
        (any_extend:V16SI
          (vec_select:V16HI
            (match_operand:V32HI 2 "register_operand" "q")
            (parallel [(const_int 0)  (const_int 1)  (const_int 2)  (const_int 3)
                       (const_int 4)  (const_int 5)  (const_int 6)  (const_int 7)
                       (const_int 8)  (const_int 9)  (const_int 10) (const_int 11)
                       (const_int 12) (const_int 13) (const_int 14) (const_int 15)])))))]
  "ISA_HAS_MXU3"
  "w<plusminus_insn><su>hl\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; W(ADD,SUB)<SU>HH
(define_insn "mxu3_w<plusminus_insn><su>hh"
[(set (match_operand:V16SI 0 "register_operand" "=q")
      (plusminus:V16SI
        (match_operand:V16SI 1 "register_operand" "q")
        (any_extend:V16SI
          (vec_select:V16HI
            (match_operand:V32HI 2 "register_operand" "q")
            (parallel [(const_int 16) (const_int 17) (const_int 18) (const_int 19)
                       (const_int 20) (const_int 21) (const_int 22) (const_int 23)
                       (const_int 24) (const_int 25) (const_int 26) (const_int 27)
                       (const_int 28) (const_int 29) (const_int 30) (const_int 31)])))))]
  "ISA_HAS_MXU3"
  "w<plusminus_insn><su>hh\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SRXSUM2BI
(define_insn "mxu3_sr<imxu3vsifmt>sum2bi"
[(set (match_operand:V16SI 0 "register_operand" "=T")
      (unspec:V16SI
         [(plus:V64QI
            (lshiftrt:V64QI (match_operand:V64QI 3 "register_operand" "q") (const_int 2))
            (match_dup 3))
          (const_int 3)
          (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))
          (match_operand:V16SI 1 "register_operand" "0")]
         UNSPEC_MXU3_INTSUM))]
  "ISA_HAS_MXU3"
  "sr<imxu3vsifmt>sum2bi\t%w0[%2],%w3"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SRXSUM4BI
(define_insn "mxu3_sr<imxu3vsifmt>sum4bi"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(plus:V64QI
             (lshiftrt:V64QI (match_operand:V64QI 3 "register_operand" "q") (const_int 4))
             (match_dup 3))
           (const_int 15)
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))
           (match_operand:V16SI 1 "register_operand" "0")]
          UNSPEC_MXU3_INTSUM))]
  "ISA_HAS_MXU3"
  "sr<imxu3vsifmt>sum4bi\t%w0[%2],%w3"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SRXSUMU/SB
(define_insn "mxu3_sr<imxu3vsifmt>sum<su>b"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(any_extend:V64HI (match_operand:V64QI 3 "register_operand" "q"))
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))
           (match_operand:V16SI 1 "register_operand" "0")]
          UNSPEC_MXU3_INTSUM))]
  "ISA_HAS_MXU3"
  "sr<imxu3vsifmt>sum<su>b\t%w0[%2],%w3"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SRXSUMU/SH
(define_insn "mxu3_sr<imxu3vsifmt>sum<su>h"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(any_extend:V32SI (match_operand:V32HI 3 "register_operand" "q"))
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))
           (match_operand:V16SI 1 "register_operand" "0")]
          UNSPEC_MXU3_INTSUM))]
  "ISA_HAS_MXU3"
  "sr<imxu3vsifmt>sum<su>h\t%w0[%2],%w3"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SRXSUMW
(define_insn "mxu3_sr<imxu3vsifmt>sumw"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(match_operand:V16SI 3 "register_operand" "q")
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))
           (match_operand:V16SI 1 "register_operand" "0")]
          UNSPEC_MXU3_INTSUM))]
  "ISA_HAS_MXU3"
  "sr<imxu3vsifmt>sumw\t%w0[%2],%w3"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; ABS(B,H,W)
(define_insn "abs<mode>2"
[(set (match_operand:IMXU3 0 "register_operand" "=q")
      (abs:IMXU3 
        (match_operand:IMXU3 1 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "abs<imxu3fmt>\t%w0,%w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; MUL(B,H,W)
(define_insn "mul<mode>3"
[(set (match_operand:MXU3A 0 "register_operand" "=q")
      (mult:MXU3A 
        (match_operand:MXU3A 1 "register_operand" "q")
        (match_operand:MXU3A 2 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "<mxu3fmtp>mul<mxu3fmt2>\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; (U,S)MULBE
(define_insn "mxu3_<su>mulbe"
[(set (match_operand:V32HI 0 "register_operand" "=q")
      (mult:V32HI
        (any_extend:V32HI
          (vec_select:V32QI
            (match_operand:V64QI 1 "register_operand" "q")
            (parallel [(const_int 0)  (const_int 2)
                       (const_int 4)  (const_int 6)
                       (const_int 8)  (const_int 10)
                       (const_int 12) (const_int 14)
                       (const_int 16) (const_int 18)
                       (const_int 20) (const_int 22)
                       (const_int 24) (const_int 26)
                       (const_int 28) (const_int 30)
                       (const_int 32) (const_int 34)
                       (const_int 36) (const_int 38)
                       (const_int 40) (const_int 42)
                       (const_int 44) (const_int 46)
                       (const_int 48) (const_int 50)
                       (const_int 52) (const_int 54)
                       (const_int 56) (const_int 58)
                       (const_int 60) (const_int 62)])))
        (any_extend:V32HI
          (vec_select:V32QI
            (match_operand:V64QI 2 "register_operand" "q")
            (parallel [(const_int 0)  (const_int 2)
                       (const_int 4)  (const_int 6)
                       (const_int 8)  (const_int 10)
                       (const_int 12) (const_int 14)
                       (const_int 16) (const_int 18)
                       (const_int 20) (const_int 22)
                       (const_int 24) (const_int 26)
                       (const_int 28) (const_int 30)
                       (const_int 32) (const_int 34)
                       (const_int 36) (const_int 38)
                       (const_int 40) (const_int 42)
                       (const_int 44) (const_int 46)
                       (const_int 48) (const_int 50)
                       (const_int 52) (const_int 54)
                       (const_int 56) (const_int 58)
                       (const_int 60) (const_int 62)])))))]
  "ISA_HAS_MXU3"
  "<su>mulbe\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; (U,S)MULBO
(define_insn "mxu3_<su>mulbo"
[(set (match_operand:V32HI 0 "register_operand" "=q")
      (mult:V32HI
        (any_extend:V32HI
          (vec_select:V32QI
            (match_operand:V64QI 1 "register_operand" "q")
            (parallel [(const_int 1)  (const_int 3)
                       (const_int 5)  (const_int 7)
                       (const_int 9)  (const_int 11)
                       (const_int 13) (const_int 15)
                       (const_int 17) (const_int 19)
                       (const_int 21) (const_int 23)
                       (const_int 25) (const_int 27)
                       (const_int 29) (const_int 31)
                       (const_int 33) (const_int 35)
                       (const_int 37) (const_int 39)
                       (const_int 41) (const_int 43)
                       (const_int 45) (const_int 47)
                       (const_int 49) (const_int 51)
                       (const_int 53) (const_int 55)
                       (const_int 57) (const_int 59)
                       (const_int 61) (const_int 63)])))
        (any_extend:V32HI
          (vec_select:V32QI
            (match_operand:V64QI 2 "register_operand" "q")
            (parallel [(const_int 1)  (const_int 3)
                       (const_int 5)  (const_int 7)
                       (const_int 9)  (const_int 11)
                       (const_int 13) (const_int 15)
                       (const_int 17) (const_int 19)
                       (const_int 21) (const_int 23)
                       (const_int 25) (const_int 27)
                       (const_int 29) (const_int 31)
                       (const_int 33) (const_int 35)
                       (const_int 37) (const_int 39)
                       (const_int 41) (const_int 43)
                       (const_int 45) (const_int 47)
                       (const_int 49) (const_int 51)
                       (const_int 53) (const_int 55)
                       (const_int 57) (const_int 59)
                       (const_int 61) (const_int 63)])))))]
  "ISA_HAS_MXU3"
  "<su>mulbo\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; (U,S)MULHE
(define_insn "mxu3_<su>mulhe"
[(set (match_operand:V16SI 0 "register_operand" "=q")
      (mult:V16SI
        (any_extend:V16SI
          (vec_select:V16HI
            (match_operand:V32HI 1 "register_operand" "q")
            (parallel [(const_int 0)  (const_int 2)
                       (const_int 4)  (const_int 6)
                       (const_int 8)  (const_int 10)
                       (const_int 12) (const_int 14)
                       (const_int 16) (const_int 18)
                       (const_int 20) (const_int 22)
                       (const_int 24) (const_int 26)
                       (const_int 28) (const_int 30)])))
        (any_extend:V16SI
          (vec_select:V16HI
            (match_operand:V32HI 2 "register_operand" "q")
            (parallel [(const_int 0)  (const_int 2)
                       (const_int 4)  (const_int 6)
                       (const_int 8)  (const_int 10)
                       (const_int 12) (const_int 14)
                       (const_int 16) (const_int 18)
                       (const_int 20) (const_int 22)
                       (const_int 24) (const_int 26)
                       (const_int 28) (const_int 30)])))))]
  "ISA_HAS_MXU3"
  "<su>mulhe\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; (U,S)MULHO
(define_insn "mxu3_<su>mulho"
[(set (match_operand:V16SI 0 "register_operand" "=q")
      (mult:V16SI
        (any_extend:V16SI
          (vec_select:V16HI
            (match_operand:V32HI 1 "register_operand" "q")
            (parallel [(const_int 1)  (const_int 3)
                       (const_int 5)  (const_int 7)
                       (const_int 9)  (const_int 11)
                       (const_int 13) (const_int 15)
                       (const_int 17) (const_int 19)
                       (const_int 21) (const_int 23)
                       (const_int 25) (const_int 27)
                       (const_int 29) (const_int 31)])))
        (any_extend:V16SI
          (vec_select:V16HI
            (match_operand:V32HI 2 "register_operand" "q")
            (parallel [(const_int 1)  (const_int 3)
                       (const_int 5)  (const_int 7)
                       (const_int 9)  (const_int 11)
                       (const_int 13) (const_int 15)
                       (const_int 17) (const_int 19)
                       (const_int 21) (const_int 23)
                       (const_int 25) (const_int 27)
                       (const_int 29) (const_int 31)])))))]
  "ISA_HAS_MXU3"
  "<su>mulho\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; W(S,U)MULHL
(define_insn "mxu3_w<su>mulhl"
[(set (match_operand:V16SI 0 "register_operand" "=q")
      (mult:V16SI
        (match_operand:V16SI 1 "register_operand" "q")
        (any_extend:V16SI
          (vec_select:V16HI
            (match_operand:V32HI 2 "register_operand" "q")
            (parallel [(const_int 0)  (const_int 1)
                       (const_int 2)  (const_int 3)
                       (const_int 4)  (const_int 5)
                       (const_int 6)  (const_int 7)
                       (const_int 8)  (const_int 9)
                       (const_int 10) (const_int 11)
                       (const_int 12) (const_int 13)
                       (const_int 14) (const_int 15)])))))]
  "ISA_HAS_MXU3"
  "w<su>mulhl\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; W(S,U)MULHH
(define_insn "mxu3_w<su>mulhh"
[(set (match_operand:V16SI 0 "register_operand" "=q")
      (mult:V16SI
        (match_operand:V16SI 1 "register_operand" "q")
        (any_extend:V16SI
          (vec_select:V16HI
            (match_operand:V32HI 2 "register_operand" "q")
            (parallel [(const_int 16) (const_int 17)
                       (const_int 18) (const_int 19)
                       (const_int 20) (const_int 21)
                       (const_int 22) (const_int 23)
                       (const_int 24) (const_int 25)
                       (const_int 26) (const_int 27)
                       (const_int 28) (const_int 29)
                       (const_int 30) (const_int 31)])))))]
  "ISA_HAS_MXU3"
  "w<su>mulhh\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; W(U,S)MULBL
(define_insn "mxu3_w<su>mulbl"
[(set (match_operand:V32HI 0 "register_operand" "=q")
      (mult:V32HI
        (match_operand:V32HI 1 "register_operand" "q")
        (any_extend:V32HI
          (vec_select:V32QI
            (match_operand:V64QI 2 "register_operand" "q")
            (parallel [(const_int 0)  (const_int 1)
                       (const_int 2)  (const_int 3)
                       (const_int 4)  (const_int 5)
                       (const_int 6)  (const_int 7)
                       (const_int 8)  (const_int 9)
                       (const_int 10) (const_int 11)
                       (const_int 12) (const_int 13)
                       (const_int 14) (const_int 15)
                       (const_int 16) (const_int 17)
                       (const_int 18) (const_int 19)
                       (const_int 20) (const_int 21)
                       (const_int 22) (const_int 23)
                       (const_int 24) (const_int 25)
                       (const_int 26) (const_int 27)
                       (const_int 28) (const_int 29)
                       (const_int 30) (const_int 31)])))))]
  "ISA_HAS_MXU3"
  "w<su>mulbl\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; W(U,S)MULBH
(define_insn "mxu3_w<su>mulbh"
[(set (match_operand:V32HI 0 "register_operand" "=q")
      (mult:V32HI
        (match_operand:V32HI 1 "register_operand" "q")
        (any_extend:V32HI
          (vec_select:V32QI
            (match_operand:V64QI 2 "register_operand" "q")
            (parallel [(const_int 32) (const_int 33)
                       (const_int 34) (const_int 35)
                       (const_int 36) (const_int 37)
                       (const_int 38) (const_int 39)
                       (const_int 40) (const_int 41)
                       (const_int 42) (const_int 43)
                       (const_int 44) (const_int 45)
                       (const_int 46) (const_int 47)
                       (const_int 48) (const_int 49)
                       (const_int 50) (const_int 51)
                       (const_int 52) (const_int 53)
                       (const_int 54) (const_int 55)
                       (const_int 56) (const_int 57)
                       (const_int 58) (const_int 59)
                       (const_int 60) (const_int 61)
                       (const_int 62) (const_int 63)])))))]
  "ISA_HAS_MXU3"
  "w<su>mulbh\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; maddw
(define_insn "mxu3_mlaw"
  [(set (match_operand:V16SI 0 "register_operand" "=T")
        (plus:V16SI
          (match_operand:V16SI 1 "register_operand" "0")
          (mult:V16SI
            (match_operand:V16SI 2 "register_operand" "q")
            (match_operand:V16SI 3 "register_operand" "q"))))]
  "ISA_HAS_MXU3"
  "mlaw\t%w0,%w2,%w3"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; msubw
(define_insn "mxu3_mlsw"
  [(set (match_operand:V16SI 0 "register_operand" "=T")
        (minus:V16SI
          (match_operand:V16SI 1 "register_operand" "0")
          (mult:V16SI
            (match_operand:V16SI 2 "register_operand" "q")
            (match_operand:V16SI 3 "register_operand" "q"))))]
  "ISA_HAS_MXU3"
  "mlsw\t%w0,%w2,%w3"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; sml(a,s)he
(define_insn "mxu3_sml<plusminus_abbr>he"
  [(set (match_operand:V16SI 0 "register_operand" "=T")
        (plusminus:V16SI
          (match_operand:V16SI 1 "register_operand" "0")
          (mult:V16SI
            (sign_extend:V16SI
              (vec_select:V16HI
                (match_operand:V32HI 2 "register_operand" "q")
                (parallel [(const_int 0)  (const_int 2)
                           (const_int 4)  (const_int 6)
                           (const_int 8)  (const_int 10)
                           (const_int 12) (const_int 14)
                           (const_int 16) (const_int 18)
                           (const_int 20) (const_int 22)
                           (const_int 24) (const_int 26)
                           (const_int 28) (const_int 30)])))
            (sign_extend:V16SI
              (vec_select:V16HI
                (match_operand:V32HI 3 "register_operand" "q")
                (parallel [(const_int 0)  (const_int 2)
                           (const_int 4)  (const_int 6)
                           (const_int 8)  (const_int 10)
                           (const_int 12) (const_int 14)
                           (const_int 16) (const_int 18)
                           (const_int 20) (const_int 22)
                           (const_int 24) (const_int 26)
                           (const_int 28) (const_int 30)]))))))]
  "ISA_HAS_MXU3"
  "sml<plusminus_abbr>he\t%w0,%w2,%w3"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; sml(a,s)ho
(define_insn "mxu3_sml<plusminus_abbr>ho"
  [(set (match_operand:V16SI 0 "register_operand" "=T")
        (plusminus:V16SI
          (match_operand:V16SI 1 "register_operand" "0")
          (mult:V16SI
            (sign_extend:V16SI
              (vec_select:V16HI
                (match_operand:V32HI 2 "register_operand" "q")
                (parallel [(const_int 1)  (const_int 3)
                           (const_int 5)  (const_int 7)
                           (const_int 9)  (const_int 11)
                           (const_int 13) (const_int 15)
                           (const_int 17) (const_int 19)
                           (const_int 21) (const_int 23)
                           (const_int 25) (const_int 27)
                           (const_int 29) (const_int 31)])))
            (sign_extend:V16SI
              (vec_select:V16HI
                (match_operand:V32HI 3 "register_operand" "q")
                (parallel [(const_int 1)  (const_int 3)
                           (const_int 5)  (const_int 7)
                           (const_int 9)  (const_int 11)
                           (const_int 13) (const_int 15)
                           (const_int 17) (const_int 19)
                           (const_int 21) (const_int 23)
                           (const_int 25) (const_int 27)
                           (const_int 29) (const_int 31)]))))))]
  "ISA_HAS_MXU3"
  "sml<plusminus_abbr>ho\t%w0,%w2,%w3"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; wsml(a,s)hl
(define_insn "mxu3_wsml<plusminus_abbr>hl"
  [(set (match_operand:V16SI 0 "register_operand" "=T")
        (plusminus:V16SI
          (match_operand:V16SI 1 "register_operand" "0")
          (mult:V16SI
            (match_operand:V16SI 2 "register_operand" "q")
            (sign_extend:V16SI
              (vec_select:V16HI
                (match_operand:V32HI 3 "register_operand" "q")
                (parallel [(const_int 0)  (const_int 1)
                           (const_int 2)  (const_int 3)
                           (const_int 4)  (const_int 5)
                           (const_int 6)  (const_int 7)
                           (const_int 8)  (const_int 9)
                           (const_int 10) (const_int 11)
                           (const_int 12) (const_int 13)
                           (const_int 14) (const_int 15)]))))))]
  "ISA_HAS_MXU3"
  "wsml<plusminus_abbr>hl\t%w0,%w2,%w3"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; wsml(a,s)hh
(define_insn "mxu3_wsml<plusminus_abbr>hh"
  [(set (match_operand:V16SI 0 "register_operand" "=T")
        (plusminus:V16SI
          (match_operand:V16SI 1 "register_operand" "0")
          (mult:V16SI
            (match_operand:V16SI 2 "register_operand" "q")
            (sign_extend:V16SI
              (vec_select:V16HI
                (match_operand:V32HI 3 "register_operand" "q")
                (parallel [(const_int 16) (const_int 17)
                           (const_int 18) (const_int 19)
                           (const_int 20) (const_int 21)
                           (const_int 22) (const_int 23)
                           (const_int 24) (const_int 25)
                           (const_int 26) (const_int 27)
                           (const_int 28) (const_int 29)
                           (const_int 30) (const_int 31)]))))))]
  "ISA_HAS_MXU3"
  "wsml<plusminus_abbr>hh\t%w0,%w2,%w3"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])


;; SRXMAC2BI
;; sr1 (16 groups, V16SI, merge sel 0); sr2 (8 groups, V8SI, merge sel 0-1)
(define_insn "mxu3_sr<imxu3vsifmt>mac2bi"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(match_operand:V64QI 3 "register_operand" "q")
           (match_operand:V64QI 4 "register_operand" "q")
           (match_operand:SI 5 "const_<imxu3vsi_immrec>_operand" "")
           (const_int 3)
           (match_operand:V16SI 1 "register_operand" "0")
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))]
          UNSPEC_MXU3_UUMRSUMAC))]
  "ISA_HAS_MXU3"
  "sr<imxu3vsifmt>mac2bi\t%w0[%2],%w3, %w4[%5]"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SRXMAC4BI
;; sr1 (16 groups, V16SI, merge sel 0); sr2 (8 groups, V8SI, merge sel 0-1)
(define_insn "mxu3_sr<imxu3vsifmt>mac4bi"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(match_operand:V64QI 3 "register_operand" "q")
           (match_operand:V64QI 4 "register_operand" "q")
           (match_operand:SI 5 "const_<imxu3vsi_immrec>_operand" "")
           (const_int 15)
           (match_operand:V16SI 1 "register_operand" "0")
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))]
          UNSPEC_MXU3_UUMRSUMAC))]
  "ISA_HAS_MXU3"
  "sr<imxu3vsifmt>mac4bi\t%w0[%2],%w3, %w4[%5]"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SRXMACUUB
;; sr1 (16 groups, V16SI, merge sel 0); sr2 (8 groups, V8SI, merge sel 0-1)
(define_insn "mxu3_sr<imxu3vsifmt>macuub"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(match_operand:V64QI 3 "register_operand" "q")
           (match_operand:V64QI 4 "register_operand" "q")
           (match_operand:SI 5 "const_<imxu3vsi_immrec>_operand" "")
           (const_int 255)
           (match_operand:V16SI 1 "register_operand" "0")
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))]
          UNSPEC_MXU3_UUMRSUMAC))]
  "ISA_HAS_MXU3"
  "sr<imxu3vsifmt>macuub\t%w0[%2],%w3, %w4[%5]"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SRXMACSUB
;; sr1 (16 groups, V16SI, merge sel 0); sr2 (8 groups, V8SI, merge sel 0-1)
(define_insn "mxu3_sr<imxu3vsifmt>macsub"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(match_operand:V64QI 3 "register_operand" "q")
           (match_operand:V64QI 4 "register_operand" "q")
           (match_operand:SI 5 "const_<imxu3vsi_immrec>_operand" "")
           (const_int 255)
           (match_operand:V16SI 1 "register_operand" "0")
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))]
          UNSPEC_MXU3_SUMRSUMAC))]
  "ISA_HAS_MXU3"
  "sr<imxu3vsifmt>macsub\t%w0[%2],%w3, %w4[%5]"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SRXMACSSB
;; sr1 (16 groups, V16SI, merge sel 0); sr2 (8 groups, V8SI, merge sel 0-1)
(define_insn "mxu3_sr<imxu3vsifmt>macssb"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(match_operand:V64QI 3 "register_operand" "q")
           (match_operand:V64QI 4 "register_operand" "q")
           (match_operand:SI 5 "const_<imxu3vsi_immrec>_operand" "")
           (const_int 255)
           (match_operand:V16SI 1 "register_operand" "0")
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))]
          UNSPEC_MXU3_SSMRSUMAC))]
  "ISA_HAS_MXU3"
  "sr<imxu3vsifmt>macssb\t%w0[%2],%w3, %w4[%5]"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SRXMACSSH
;; sr1 (16 groups, V16SI, merge sel 0); sr2 (8 groups, V8SI, merge sel 0-1)
(define_insn "mxu3_sr<imxu3vsifmt>macssh"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(match_operand:V32HI 3 "register_operand" "q")
           (match_operand:V32HI 4 "register_operand" "q")
           (match_operand:SI 5 "const_<imxu3vsi_immrec>_operand" "")
           (const_int 65535)
           (match_operand:V16SI 1 "register_operand" "0")
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))]
          UNSPEC_MXU3_SSMRSUMAC))]
  "ISA_HAS_MXU3"
  "sr<imxu3vsifmt>macssh\t%w0[%2],%w3, %w4[%5]"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SXMACUUB
;; s1 (16 groups, V16SI, merge sel 0); s2 (8 groups, V8SI, merge sel 0-1)
(define_insn "mxu3_s<imxu3vsifmt>macuub"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(match_operand:V64QI 3 "register_operand" "q")
           (match_operand:V64QI 4 "register_operand" "q")
           (const_int 255)
           (match_operand:V16SI 1 "register_operand" "0")
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))]
          UNSPEC_MXU3_UUMSUMAC))]
  "ISA_HAS_MXU3"
  "s<imxu3vsifmt>macuub\t%w0[%2],%w3, %w4"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SXMACSUB
;; s1 (16 groups, V16SI, merge sel 0); s2 (8 groups, V8SI, merge sel 0-1)
(define_insn "mxu3_s<imxu3vsifmt>macsub"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(match_operand:V64QI 3 "register_operand" "q")
           (match_operand:V64QI 4 "register_operand" "q")
           (const_int 255)
           (match_operand:V16SI 1 "register_operand" "0")
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))]
          UNSPEC_MXU3_SUMSUMAC))]
  "ISA_HAS_MXU3"
  "s<imxu3vsifmt>macsub\t%w0[%2],%w3, %w4"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SXMACSSB
;; s1 (16 groups, V16SI, merge sel 0); s2 (8 groups, V8SI, merge sel 0-1)
(define_insn "mxu3_s<imxu3vsifmt>macssb"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(match_operand:V64QI 3 "register_operand" "q")
           (match_operand:V64QI 4 "register_operand" "q")
           (const_int 255)
           (match_operand:V16SI 1 "register_operand" "0")
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))]
          UNSPEC_MXU3_SSMSUMAC))]
  "ISA_HAS_MXU3"
  "s<imxu3vsifmt>macssb\t%w0[%2],%w3, %w4"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SXMACSSH
;; s1 (16 groups, V16SI, merge sel 0); s2 (8 groups, V8SI, merge sel 0-1)
(define_insn "mxu3_s<imxu3vsifmt>macssh"
[(set (match_operand:V16SI 0 "register_operand" "=T")
        (unspec:V16SI
          [(match_operand:V32HI 3 "register_operand" "q")
           (match_operand:V32HI 4 "register_operand" "q")
           (const_int 65535)
           (match_operand:V16SI 1 "register_operand" "0")
           (vec_duplicate:IMXU3VSI (match_operand:SI 2 "const_<imxu3vsi_imm>_operand" ""))]
          UNSPEC_MXU3_SSMSUMAC))]
  "ISA_HAS_MXU3"
  "s<imxu3vsifmt>macssh\t%w0[%2],%w3, %w4"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; MAXA(B,H,W) FMAXAW
(define_insn "mxu3_<mxu3fmtp>maxa<mxu3fmt2>"
  [(set (match_operand:MXU3A 0 "register_operand" "=q")
        (if_then_else:MXU3A
          (gt:MXU3A 
            (abs:MXU3A (match_operand:MXU3A 1 "register_operand" "q"))
            (abs:MXU3A (match_operand:MXU3A 2 "register_operand" "q")))
          (match_dup 1)
          (match_dup 2)))]
  "ISA_HAS_MXU3"
  "<mxu3fmtp>maxa<mxu3fmt2>\t%w0, %w1, %w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])
  
;; MAXS(B,H,W) FMAXW
(define_insn "smax<mode>3"
  [(set (match_operand:MXU3A 0 "register_operand" "=q")
        (smax:MXU3A
          (match_operand:MXU3A 1 "register_operand" "q")
          (match_operand:MXU3A 2 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "<mxu3fmtp>max<mxu3fmt1>\t%w0, %w1, %w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])
  
;; MAXU(B,H,W)
(define_insn "umax<mode>3"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
        (umax:IMXU3
          (match_operand:IMXU3 1 "register_operand" "q")
          (match_operand:IMXU3 2 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "maxu<imxu3fmt>\t%w0, %w1, %w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; MAXU2BI
(define_insn "mxu3_maxu2bi"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (unspec:V64QI
          [(match_operand:V64QI 1 "register_operand" "q")
           (match_operand:V64QI 2 "register_operand" "q")
           (const_int 3)]
          UNSPEC_MXU3_UMAXBI))]
  "ISA_HAS_MXU3"
  "maxu2bi\t%w0, %w1, %w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; MAXU4BI
(define_insn "mxu3_maxu4bi"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (unspec:V64QI
          [(match_operand:V64QI 1 "register_operand" "q")
           (match_operand:V64QI 2 "register_operand" "q")
           (const_int 15)]
          UNSPEC_MXU3_UMAXBI))]
  "ISA_HAS_MXU3"
  "maxu4bi\t%w0, %w1, %w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; MINA(B,H,W) FMINAW
(define_insn "mxu3_<mxu3fmtp>mina<mxu3fmt2>"
  [(set (match_operand:MXU3A 0 "register_operand" "=q")
        (if_then_else:MXU3A
          (lt:MXU3A 
            (abs:MXU3A (match_operand:MXU3A 1 "register_operand" "q"))
            (abs:MXU3A (match_operand:MXU3A 2 "register_operand" "q")))
          (match_dup 1)
          (match_dup 2)))]
  "ISA_HAS_MXU3"
  "<mxu3fmtp>mina<mxu3fmt2>\t%w0, %w1, %w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])
  
;; MINS(B,H,W) FMINW
(define_insn "smin<mode>3"
  [(set (match_operand:MXU3A 0 "register_operand" "=q")
        (smin:MXU3A
          (match_operand:MXU3A 1 "register_operand" "q")
          (match_operand:MXU3A 2 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "<mxu3fmtp>min<mxu3fmt1>\t%w0, %w1, %w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])
  
;; MINU(B,H,W)
(define_insn "umin<mode>3"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
        (umin:IMXU3
          (match_operand:IMXU3 1 "register_operand" "q")
          (match_operand:IMXU3 2 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "minu<imxu3fmt>\t%w0, %w1, %w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; MINU2BI
(define_insn "mxu3_minu2bi"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (unspec:V64QI
          [(match_operand:V64QI 1 "register_operand" "q")
           (match_operand:V64QI 2 "register_operand" "q")
           (const_int 3)]
          UNSPEC_MXU3_UMINBI))]
  "ISA_HAS_MXU3"
  "minu2bi\t%w0, %w1, %w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; MINU4BI
(define_insn "mxu3_minu4bi"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (unspec:V64QI
          [(match_operand:V64QI 1 "register_operand" "q")
           (match_operand:V64QI 2 "register_operand" "q")
           (const_int 15)]
          UNSPEC_MXU3_UMINBI))]
  "ISA_HAS_MXU3"
  "minu4bi\t%w0, %w1, %w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; SATURATE
(define_int_iterator SATURATE_B_UNS 
  [UNSPEC_MXU3_SATSUB2BI
   UNSPEC_MXU3_SATSUB4BI
   UNSPEC_MXU3_SATUUB2BI
   UNSPEC_MXU3_SATUUB4BI
  ])

(define_int_iterator SATURATE_H_UNS 
  [UNSPEC_MXU3_SATSSHB
   UNSPEC_MXU3_SATSUH2BI
   UNSPEC_MXU3_SATSUH4BI
   UNSPEC_MXU3_SATSUHB
   UNSPEC_MXU3_SATUUH2BI
   UNSPEC_MXU3_SATUUH4BI
   UNSPEC_MXU3_SATUUHB
  ])

(define_int_iterator SATURATE_W_UNS 
  [UNSPEC_MXU3_SATSSWB
   UNSPEC_MXU3_SATSSWH
   UNSPEC_MXU3_SATSUW2BI
   UNSPEC_MXU3_SATSUW4BI
   UNSPEC_MXU3_SATSUWB
   UNSPEC_MXU3_SATSUWH
   UNSPEC_MXU3_SATUUW4BI
   UNSPEC_MXU3_SATUUWB
   UNSPEC_MXU3_SATUUWH
  ])

(define_int_attr saturate_b
  [(UNSPEC_MXU3_SATSUB2BI  "sub2bi")
   (UNSPEC_MXU3_SATSUB4BI  "sub4bi")
   (UNSPEC_MXU3_SATUUB2BI  "uub2bi")
   (UNSPEC_MXU3_SATUUB4BI  "uub4bi")
  ])

(define_int_attr saturate_h
  [(UNSPEC_MXU3_SATSSHB    "sshb")
   (UNSPEC_MXU3_SATSUH2BI  "suh2bi")
   (UNSPEC_MXU3_SATSUH4BI  "suh4bi")
   (UNSPEC_MXU3_SATSUHB    "suhb")
   (UNSPEC_MXU3_SATUUH2BI  "uuh2bi")
   (UNSPEC_MXU3_SATUUH4BI  "uuh4bi")
   (UNSPEC_MXU3_SATUUHB    "uuhb")
  ])

(define_int_attr saturate_w
  [(UNSPEC_MXU3_SATSSWB    "sswb")
   (UNSPEC_MXU3_SATSSWH    "sswh")
   (UNSPEC_MXU3_SATSUW2BI  "suw2bi") 
   (UNSPEC_MXU3_SATSUW4BI  "suw4bi")
   (UNSPEC_MXU3_SATSUWB    "suwb")
   (UNSPEC_MXU3_SATSUWH    "suwh")
   (UNSPEC_MXU3_SATUUW4BI  "uuw4bi")
   (UNSPEC_MXU3_SATUUWB    "uuwb")
   (UNSPEC_MXU3_SATUUWH    "uuwh")
  ])

(define_insn "mxu3_sat<saturate_b>"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (unspec:V64QI
          [(match_operand:V64QI 1 "register_operand" "q")]
           SATURATE_B_UNS))]
  "ISA_HAS_MXU3"
  "sat<saturate_b>\t%w0, %w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

(define_insn "mxu3_sat<saturate_h>"
  [(set (match_operand:V32HI 0 "register_operand" "=q")
        (unspec:V32HI
          [(match_operand:V32HI 1 "register_operand" "q")]
           SATURATE_H_UNS))]
  "ISA_HAS_MXU3"
  "sat<saturate_h>\t%w0, %w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

(define_insn "mxu3_sat<saturate_w>"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (unspec:V16SI
          [(match_operand:V16SI 1 "register_operand" "q")]
           SATURATE_W_UNS))]
  "ISA_HAS_MXU3"
  "sat<saturate_w>\t%w0, %w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; TOC(B,H,W)
(define_insn "mxu3_toc<imxu3fmt>"
  [(set (match_operand:IMXU3 0 "register_operand" "=T")
        (unspec:IMXU3
          [(match_operand:IMXU3 1 "register_operand" "q")]
          UNSPEC_MXU3_TOC))]
  "ISA_HAS_MXU3"
  "toc<imxu3fmt>\t%w0, %w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;;
;; Bitwise
;;
;; andv, andnv, andib, orv,ornv,orib,xorv,xornv,xorvib,bselv
(define_insn "and<mode>3"
  [(set (match_operand:IMXU3 0 "register_operand" "=q,q")
        (and:IMXU3
          (match_operand:IMXU3 1 "register_operand" "%q,q")
          (match_operand:IMXU3 2 "reg_or_vector_same_val_operand" "q,Urv8")))]
  "ISA_HAS_MXU3"
  "@
   andv\t%w0,%w1,%w2
   andib\t%w0,%w1,%B2"
  [(set_attr "mode"     "TI")
   (set_attr "lat_type" "lat3")])

(define_insn "andnot<mode>3"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
        (and:IMXU3
          (not:IMXU3 (match_operand:IMXU3 1 "register_operand" "q"))
          (match_operand:IMXU3 2 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "andnv\t%w0,%w1,%w2"
  [(set_attr "mode"     "TI")
   (set_attr "lat_type" "lat3")])

(define_insn "one_cmpl<mode>2"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
        (not:IMXU3 (match_operand:IMXU3 1 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "xorib\t%w0,%w1,0xff"
  [(set_attr "mode"     "TI")
   (set_attr "lat_type" "lat3")])

(define_insn "ior<mode>3"
  [(set (match_operand:IMXU3 0 "register_operand" "=q,q")
        (ior:IMXU3
          (match_operand:IMXU3 1 "register_operand" "%q,q")
          (match_operand:IMXU3 2 "reg_or_vector_same_val_operand" "q,Urv8")))]
  "ISA_HAS_MXU3"
  "@
   orv\t%w0,%w1,%w2
   orib\t%w0,%w1,%B2"
  [(set_attr "mode"     "TI")
   (set_attr "lat_type" "lat3")])

(define_insn "iornot<mode>3"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
        (ior:IMXU3
          (not:IMXU3 (match_operand:IMXU3 1 "register_operand" "q"))
          (match_operand:IMXU3 2 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "ornv\t%w0,%w1,%w2"
  [(set_attr "mode"     "TI")
   (set_attr "lat_type" "lat3")])

(define_insn "xor<mode>3"
  [(set (match_operand:IMXU3 0 "register_operand" "=q,q")
        (xor:IMXU3
          (match_operand:IMXU3 1 "register_operand" "%q,q")
          (match_operand:IMXU3 2 "reg_or_vector_same_val_operand" "q,Urv8")))]
  "ISA_HAS_MXU3"
  "@
   xorv\t%w0,%w1,%w2
   xorib\t%w0,%w1,%B2"
  [(set_attr "mode"     "TI")
   (set_attr "lat_type" "lat3")])

(define_insn "xornot<mode>3"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
        (xor:IMXU3
          (not:IMXU3 (match_operand:IMXU3 1 "register_operand" "q"))
          (match_operand:IMXU3 2 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "xornv\t%w0,%w1,%w2"
  [(set_attr "mode"     "TI")
   (set_attr "lat_type" "lat3")])

;; Operand 1 is the mask, operands 2 and 3 are the bitfields from which
;; to select.
;;
;; Thus our BSL is of the form:
;;   op0 = bsl (mask, op2, op3)
;; We can use any of:
;;
;;   if (op0 = mask)
;;     bsl mask, op1, op2
;; Some forms of straight-line code may generate the equivalent form     
;; in *mxu3_bselv<mode>_alt. 

(define_insn "*mxu3_bselv<mode>_alt"
  [(set (match_operand:MXU3A 0 "register_operand" "=q")
        (xor:MXU3A
           (and:MXU3A
             (xor:MXU3A
               (match_operand:MXU3A 3 "register_operand" "q") 
               (match_operand:MXU3A 2 "register_operand" "q"))   
             (match_operand:<MXU3A_cmp_res> 1 "register_operand" "0"))     
          (match_dup:MXU3A 3)                                   
        ))]
  "ISA_HAS_MXU3"
  "bselv\t%w0,%w3,%w2"
 [(set_attr "type" "simd_bitmov")
  (set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; We need this form in addition to the above pattern to match the case  
;; when combine tries merging three insns such that the second operand of
;; the outer XOR matches the second operand of the inner XOR rather than 
;; the first.  The two are equivalent but since recog doesn't try all    
;; permutations of commutative operations, we have to have a separate pattern.

(define_insn "mxu3_bselv<mode>"
  [(set (match_operand:MXU3A 0 "register_operand" "=q")
        (xor:MXU3A
           (and:MXU3A
             (xor:MXU3A
               (match_operand:MXU3A 3 "register_operand" "q") 
               (match_operand:MXU3A 2 "register_operand" "q"))   
             (match_operand:<MXU3A_cmp_res> 1 "register_operand" "0"))     
          (match_dup:MXU3A 2)                                   
        ))]
  "ISA_HAS_MXU3"
  "bselv\t%w0,%w2,%w3"
 [(set_attr "type" "simd_bitmov")
  (set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;;
;;Floating Point Arithmetic
;;
;; FLOAT COMPLEX
(define_int_iterator FLOAT_COMPLEX_UNS 
  [UNSPEC_MXU3_FCMULRW
   UNSPEC_MXU3_FCMULIW
   UNSPEC_MXU3_FCADDW])

(define_int_attr float_complex
  [(UNSPEC_MXU3_FCMULRW  "mulrw")
   (UNSPEC_MXU3_FCMULIW  "muliw")
   (UNSPEC_MXU3_FCADDW   "addw" )])

(define_insn "mxu3_fc<float_complex>"
  [(set (match_operand:V16SF 0 "register_operand" "=q")
  (unspec:V16SF
    [(match_operand:V16SF 1 "register_operand" "q")
     (match_operand:V16SF 2 "register_operand" "q")]
     FLOAT_COMPLEX_UNS))]
  "ISA_HAS_MXU3"
  "fc<float_complex>\t%w0,%w1,%w2"
  [(set_attr "mode" "TI")
   (set_attr "lat_type" "lat3")])

;; FCLASSW
(define_insn "mxu3_fclassw"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (unspec:V16SI [(match_operand:V16SF 1 "register_operand" "q")]
                      UNSPEC_MXU3_FCLASS))]
  "ISA_HAS_MXU3"
  "fclassw\t%w0,%w1"
 [(set_attr "type" "simd_bitmov")
  (set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;;
;; Floating point compare
;;
;; fceq fcle fclt fcor
(define_insn "mxu3_<MXU3_FCC:mxu3_fcc>"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
	(MXU3_FCC:V16SI (match_operand:V16SF 1 "register_operand" "q")
		      (match_operand:V16SF 2 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "<MXU3_FCC:mxu3_fcc>\t%w0,%w1,%w2"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;;
;;Float point conversion
;;
;; FFSIW
(define_insn "floatv16siv16sf2"
  [(set (match_operand:V16SF 0 "register_operand" "=q")
        (float:V16SF (match_operand:V16SI 1 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "ffsiw\t%w0,%w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; FFUIW
(define_insn "floatunsv16siv16sf2"
  [(set (match_operand:V16SF 0 "register_operand" "=q")
        (unsigned_float:V16SF (match_operand:V16SI 1 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "ffuiw\t%w0,%w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; FTSIW
(define_insn "mxu3_ftsiw"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (unspec:V16SI [(match_operand:V16SF 1 "register_operand" "q")]
                      UNSPEC_MXU3_FTSIW))]
  "ISA_HAS_MXU3"
  "ftsiw\t%w0,%w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; FTUIW
(define_insn "mxu3_ftuiw"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (unspec:V16SI [(match_operand:V16SF 1 "register_operand" "q")]
                      UNSPEC_MXU3_FTUIW))]
  "ISA_HAS_MXU3"
  "ftuiw\t%w0,%w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; FRINTW
(define_insn "mxu3_frintw"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (unspec:V16SI [(match_operand:V16SF 1 "register_operand" "q")]
                      UNSPEC_MXU3_FRINTW))]
  "ISA_HAS_MXU3"
  "frintw\t%w0,%w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; FTRUNCSW
(define_insn "fix_truncv16sfv16si2"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (fix:V16SI (match_operand:V16SF 1 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "ftruncsw\t%w0,%w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;; FTRUNCUW
(define_insn "fixuns_truncv16sfv16si2"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (unsigned_fix:V16SI (match_operand:V16SF 1 "register_operand" "q")))]
  "ISA_HAS_MXU3"
  "ftruncuw\t%w0,%w1"
  [(set_attr "mode"	"TI")
   (set_attr "lat_type" "lat4")])

;;
;; shift
;;
(define_insn "vashl<mode>3"
  [(set (match_operand:IMXU3 0 "register_operand" "=q, q")
        (ashift:IMXU3
          (match_operand:IMXU3 1 "register_operand" "q, q")
          (match_operand:IMXU3 2 "reg_or_vector_same_uimm5_operand" "q, Uuv5")))]
  "ISA_HAS_MXU3"
  "@
  sll<imxu3fmt>\t%w0,%w1,%w2
  slli<imxu3fmt>\t%w0,%w1,%E2"
  [(set_attr "type" "simd_shift")
   (set_attr "mode" "TI")])

(define_insn "vashr<mode>3"
  [(set (match_operand:IMXU3 0 "register_operand" "=q, q")
        (ashiftrt:IMXU3
          (match_operand:IMXU3 1 "register_operand" "q, q")
          (match_operand:IMXU3 2 "reg_or_vector_same_uimm5_operand" "q, Uuv5")))]
  "ISA_HAS_MXU3"
  "@
  sra<imxu3fmt>\t%w0,%w1,%w2
  srai<imxu3fmt>\t%w0,%w1,%E2"
  [(set_attr "type" "simd_shift")
   (set_attr "mode" "TI")])

(define_insn "vlshr<mode>3"
  [(set (match_operand:IMXU3 0 "register_operand" "=q, q")
        (lshiftrt:IMXU3
          (match_operand:IMXU3 1 "register_operand" "q, q")
          (match_operand:IMXU3 2 "reg_or_vector_same_uimm5_operand" "q, Uuv5")))]
  "ISA_HAS_MXU3"
  "@
  srl<imxu3fmt>\t%w0,%w1,%w2
  srli<imxu3fmt>\t%w0,%w1,%E2"
  [(set_attr "type" "simd_shift")
   (set_attr "mode" "TI")])

;; srar srari srlr srlri
(define_insn "mxu3_srar<imxu3fmt>"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
        (unspec:IMXU3 [(match_operand:IMXU3 1 "register_operand" "q")
                       (match_operand:IMXU3 2 "register_operand" "q")]
                       UNSPEC_MXU3_SRAR))]
  "ISA_HAS_MXU3"
  "srar<imxu3fmt>\t%w0,%w1,%w2"
  [(set_attr "type" "simd_shift")
   (set_attr "mode" "TI")])

(define_insn "mxu3_srari<imxu3fmt>"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
	(unspec:IMXU3 [(match_operand:IMXU3 1 "register_operand" "q")
		       (match_operand 2 "const_<mxu3_bitimm>_operand" "")]
		       UNSPEC_MXU3_SRARI))]
  "ISA_HAS_MXU3"
  "srari<imxu3fmt>\t%w0,%w1,%2"
  [(set_attr "mode"	"TI")
  (set_attr "lat_type" "lat4")])

(define_insn "mxu3_srlr<imxu3fmt>"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
        (unspec:IMXU3 [(match_operand:IMXU3 1 "register_operand" "q")
                       (match_operand:IMXU3 2 "register_operand" "q")]
                       UNSPEC_MXU3_SRLR))]
  "ISA_HAS_MXU3"
  "srlr<imxu3fmt>\t%w0,%w1,%w2"
  [(set_attr "type" "simd_shift")
   (set_attr "mode" "TI")])

(define_insn "mxu3_srlri<imxu3fmt>"
  [(set (match_operand:IMXU3 0 "register_operand" "=q")
	(unspec:IMXU3 [(match_operand:IMXU3 1 "register_operand" "q")
		       (match_operand 2 "const_<mxu3_bitimm>_operand" "")]
		      UNSPEC_MXU3_SRLRI))]
  "ISA_HAS_MXU3"
  "srlri<imxu3fmt>\t%w0,%w1,%2"
  [(set_attr "mode"	"TI")
  (set_attr "lat_type" "lat4")])

;;
;; Element shuffle/permute
;;

(define_insn "mxu3_gt1bi<imxu3lfmt>"
 [(set (match_operand:IMXU3L 0 "register_operand" "=q")
       (unspec:IMXU3L [(match_operand:IMXU3L 1 "register_operand" "q")]
		      UNSPEC_MXU3_GT1BI))]
 "ISA_HAS_MXU3"
 "gt1bi\t%w0,%w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_insn "mxu3_gt2bi<imxu3lfmt>"
 [(set (match_operand:IMXU3L 0 "register_operand" "=q")
       (unspec:IMXU3L [(match_operand:IMXU3L 1 "register_operand" "q")]
		      UNSPEC_MXU3_GT2BI))]
 "ISA_HAS_MXU3"
 "gt2bi\t%w0,%w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_insn "mxu3_gt4bi<imxu3lfmt>"
 [(set (match_operand:IMXU3L 0 "register_operand" "=q")
       (unspec:IMXU3L [(match_operand:IMXU3L 1 "register_operand" "q")]
		      UNSPEC_MXU3_GT4BI))]
 "ISA_HAS_MXU3"
 "gt4bi\t%w0,%w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_insn "mxu3_gtb<imxu3lfmt>"
 [(set (match_operand:IMXU3L 0 "register_operand" "=q")
       (unspec:IMXU3L [(match_operand:IMXU3L 1 "register_operand" "q")]
		      UNSPEC_MXU3_GTB))]
 "ISA_HAS_MXU3"
 "gtb\t%w0,%w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_insn "mxu3_gth<imxu3lfmt>"
 [(set (match_operand:IMXU3L 0 "register_operand" "=q")
       (unspec:IMXU3L [(match_operand:IMXU3L 1 "register_operand" "q")]
		      UNSPEC_MXU3_GTH))]
 "ISA_HAS_MXU3"
 "gth\t%w0,%w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_insn "mxu3_gt2w_insn"
 [(set (match_operand:V16SI 0 "register_operand" "=q")
       (vec_merge:V16SI
         (vec_duplicate:V16SI
           (vec_select:V8SI 
             (match_operand:V16SI 3 "register_operand" "q")
             (parallel [(match_operand 4 "const_0_or_1_operand" "")
                        (match_operand 5 "const_uimm4_operand" "")
                        (match_operand 6 "const_uimm4_operand" "")
                        (match_operand 7 "const_uimm4_operand" "")
                        (match_operand 8 "const_uimm4_operand" "")
                        (match_operand 9 "const_uimm4_operand" "")
                        (match_operand 10 "const_uimm4_operand" "")
                        (match_operand 11 "const_uimm4_operand" "")])))
         (match_operand:V16SI 1 "register_operand" "0")
         (match_operand 2 "const_uimm16_operand" "")))]
 "ISA_HAS_MXU3 
  && INTVAL (operands[4]) == (INTVAL (operands[5]) - 2)
  && INTVAL (operands[4]) == (INTVAL (operands[6]) - 4)
  && INTVAL (operands[4]) == (INTVAL (operands[7]) - 6)
  && INTVAL (operands[4]) == (INTVAL (operands[8]) - 8)
  && INTVAL (operands[4]) == (INTVAL (operands[9]) - 10)
  && INTVAL (operands[4]) == (INTVAL (operands[10]) - 12)
  && INTVAL (operands[4]) == (INTVAL (operands[11]) - 14)"
 {
   static char buf[128];
   
   snprintf (buf, sizeof(buf), "gt2w\t%%w0[%d], %%w3, %%d4",
     (INTVAL (operands[2]) == 0x0ff ? 0 : 1));
   return buf;
}
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_expand "mxu3_gt2w"
  [(match_operand:V16SI 0 "register_operand")
   (match_operand:V16SI 1 "register_operand" "")
   (match_operand 2 "const_0_or_1_operand" "")
   (match_operand:V16SI 3 "register_operand" "")
   (match_operand 4 "const_0_or_1_operand" "")]
 "ISA_HAS_MXU3"
 {
   unsigned int mask = 0x0ff << (8 * INTVAL(operands[2]));
   int pos = INTVAL (operands[4]);
   emit_insn (gen_mxu3_gt2w_insn (operands[0], operands[1], 
                                  GEN_INT (mask),
                                  operands[3], operands[4],
                                  GEN_INT (pos + 2),
                                  GEN_INT (pos + 4),
                                  GEN_INT (pos + 6),
                                  GEN_INT (pos + 8),
                                  GEN_INT (pos + 10),
                                  GEN_INT (pos + 12),
                                  GEN_INT (pos + 14)));
   DONE;
})

(define_insn "mxu3_gt4w_insn"
 [(set (match_operand:V16SI 0 "register_operand" "=q")
       (vec_merge:V16SI
         (vec_duplicate:V16SI
           (vec_select:V4SI 
             (match_operand:V16SI 3 "register_operand" "q")
             (parallel [(match_operand 4 "const_0_to_3_operand" "")
                        (match_operand 5 "const_uimm4_operand" "")
                        (match_operand 6 "const_uimm4_operand" "")
                        (match_operand 7 "const_uimm4_operand" "")])))
         (match_operand:V16SI 1 "register_operand" "0")
         (match_operand 2 "const_uimm16_operand" "")))]
 "ISA_HAS_MXU3 
  && INTVAL (operands[4]) == (INTVAL (operands[5]) - 4)
  && INTVAL (operands[4]) == (INTVAL (operands[6]) - 8)
  && INTVAL (operands[4]) == (INTVAL (operands[7]) - 12)"
 {
   static char buf[128];
   unsigned int m = INTVAL (operands[2]);
   m = (m == 0xf) ? 0 :
        (m == 0xf0) ? 1 :
        (m == 0x0f00) ? 2 : 3;
   snprintf (buf, sizeof(buf), "gt4w\t%%w0[%d], %%w3, %%d4", m);
   return buf;
 }
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_expand "mxu3_gt4w"
  [(match_operand:V16SI 0 "register_operand")
   (match_operand:V16SI 1 "register_operand" "")
   (match_operand 2 "const_0_to_3_operand" "")
   (match_operand:V16SI 3 "register_operand" "")
   (match_operand 4 "const_0_to_3_operand" "")]
 "ISA_HAS_MXU3"
 {
   unsigned int mask = 0x0f << (4*INTVAL (operands[2]));
   int pos = INTVAL (operands[4]);
   emit_insn (gen_mxu3_gt4w_insn (operands[0], operands[1], 
                                  GEN_INT (mask), 
                                  operands[3], operands[4],
                                  GEN_INT (pos + 4),
                                  GEN_INT (pos + 8),
                                  GEN_INT (pos + 12)));
   DONE;
})

(define_insn "mxu3_gt8w_insn"
 [(set (match_operand:V16SI 0 "register_operand" "=q")
       (vec_merge:V16SI
         (vec_duplicate:V16SI
           (vec_select:V2SI 
             (match_operand:V16SI 3 "register_operand" "q")
             (parallel [(match_operand 4 "const_0_to_7_operand" "")
                        (match_operand 5 "const_uimm4_operand" "")])))
         (match_operand:V16SI 1 "register_operand" "0")
         (match_operand 2 "const_uimm16_operand" "")))]
 "ISA_HAS_MXU3 
  && INTVAL (operands[4]) == (INTVAL (operands[5]) - 8)"
 {
   static char buf[128];
   unsigned int m;

   switch (INTVAL (operands[2]))
   {
     case 3: m = 0; break;
     case 0x0c: m = 1; break;
     case 0x30: m = 2; break;
     case 0x0c0: m = 3; break;
     case 0x300: m = 4; break;
     case 0x0c00: m = 5; break;
     case 0x3000: m = 6; break;
     default: m = 7;
   }

   snprintf (buf, sizeof(buf), "gt8w\t%%w0[%d], %%w3, %%d4", m);
   return buf;
 }
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_expand "mxu3_gt8w"
  [(match_operand:V16SI 0 "register_operand")
   (match_operand:V16SI 1 "register_operand" "")
   (match_operand 2 "const_0_to_7_operand" "")
   (match_operand:V16SI 3 "register_operand" "")
   (match_operand 4 "const_0_to_7_operand" "")]
 "ISA_HAS_MXU3"
 {
   unsigned int mask = 3 << (2 * INTVAL (operands[2]));
   int pos = INTVAL (operands[4]);
   emit_insn (gen_mxu3_gt8w_insn (operands[0], operands[1], 
                                  GEN_INT (mask),
                                  operands[3], operands[4],
                                  GEN_INT (pos + 8)));
   DONE;
})

(define_insn "mxu3_gt2d_insn"
 [(set (match_operand:V8DI 0 "register_operand" "=q")
       (vec_merge:V8DI
         (vec_duplicate:V8DI
           (vec_select:V4DI
             (match_operand:V8DI 3 "register_operand" "q")
             (parallel [(match_operand 4 "const_0_or_1_operand" "")
                        (match_operand 5 "const_uimm4_operand" "")
                        (match_operand 6 "const_uimm4_operand" "")
                        (match_operand 7 "const_uimm4_operand" "")])))
         (match_operand:V8DI 1 "register_operand" "0")
         (match_operand 2 "const_uimm8_operand" "")))]
 "ISA_HAS_MXU3
  && INTVAL (operands[4]) == (INTVAL (operands[5]) - 2)
  && INTVAL (operands[4]) == (INTVAL (operands[6]) - 4)
  && INTVAL (operands[4]) == (INTVAL (operands[7]) - 6)"
 {
   static char buf[128];

   snprintf (buf, sizeof(buf), "gt2d\t%%w0[%d], %%w3, %%d4", 
     (INTVAL (operands[2]) == 0xf ? 0 : 1));
   return buf;
 }
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_expand "mxu3_gt2d"
  [(match_operand:V8DI 0 "register_operand")
   (match_operand:V8DI 1 "register_operand" "")
   (match_operand 2 "const_0_or_1_operand" "")
   (match_operand:V8DI 3 "register_operand" "")
   (match_operand 4 "const_0_or_1_operand" "")]
 "ISA_HAS_MXU3"
 {
   unsigned int mask = INTVAL (operands[2]) ? 0xf0 : 0xf;
   int pos = INTVAL (operands[4]);
   emit_insn (gen_mxu3_gt2d_insn (operands[0], operands[1], 
                                  GEN_INT (mask),
                                  operands[3], operands[4],
                                  GEN_INT (pos + 2),
                                  GEN_INT (pos + 4),
                                  GEN_INT (pos + 6)));
   DONE;
})

(define_insn "mxu3_gt4d_insn"
 [(set (match_operand:V8DI 0 "register_operand" "=q")
       (vec_merge:V8DI
         (vec_duplicate:V8DI
           (vec_select:V2DI
             (match_operand:V8DI 3 "register_operand" "q")
             (parallel [(match_operand 4 "const_0_to_3_operand" "")
                        (match_operand 5 "const_uimm4_operand" "")])))
         (match_operand:V8DI 1 "register_operand" "0")
         (match_operand 2 "const_uimm8_operand" "")))]
 "ISA_HAS_MXU3
  && INTVAL (operands[4]) == (INTVAL (operands[5]) - 4)"
 {
   static char buf[128];
   int m = INTVAL (operands[2]);
   m = (m == 3) ? 0 :
        (m == 0x0c) ? 1 :
        (m == 0x30) ? 2 : 3;

   snprintf (buf, sizeof(buf), "gt4d\t%%w0[%d], %%w3, %%d4", m);
   return buf;
 }
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_expand "mxu3_gt4d"
  [(match_operand:V8DI 0 "register_operand")
   (match_operand:V8DI 1 "register_operand" "")
   (match_operand 2 "const_0_to_3_operand" "")
   (match_operand:V8DI 3 "register_operand" "")
   (match_operand 4 "const_0_to_3_operand" "")]
 "ISA_HAS_MXU3"
 {
   unsigned int mask = 3 << (2 * INTVAL (operands[2]));
   int pos = INTVAL (operands[4]);
   emit_insn (gen_mxu3_gt4d_insn (operands[0], operands[1], GEN_INT (mask), operands[3],
                                  operands[4], GEN_INT (pos + 4)));
   DONE;
})

(define_insn "mxu3_gt2q_insn"
 [(set (match_operand:V4TI 0 "register_operand" "=q")
       (vec_merge:V4TI
         (vec_duplicate:V4TI
           (vec_select:V2TI
             (match_operand:V4TI 3 "register_operand" "q")
             (parallel [(match_operand 4 "const_0_or_1_operand" "")
                        (match_operand 5 "const_uimm4_operand" "")])))
         (match_operand:V4TI 1 "register_operand" "0")
         (match_operand 2 "const_uimm4_operand" "")))]
 "ISA_HAS_MXU3
  && INTVAL (operands[4]) == (INTVAL (operands[5]) - 2)"
 {
   static char buf[128];

   snprintf (buf, sizeof(buf), "gt2q\t%%w0[%d], %%w3, %%d4",
     (INTVAL (operands[2]) == 3 ? 0 : 1));
   return buf;
 }
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_expand "mxu3_gt2q"
  [(match_operand:V4TI 0 "register_operand")
   (match_operand:V4TI 1 "register_operand" "")
   (match_operand 2 "const_0_or_1_operand" "")
   (match_operand:V4TI 3 "register_operand" "")
   (match_operand 4 "const_0_or_1_operand" "")]
 "ISA_HAS_MXU3"
 {
   unsigned int mask = INTVAL (operands[2]) ? 0x0c : 3;
   int pos = INTVAL (operands[4]);
   emit_insn (gen_mxu3_gt2q_insn (operands[0], operands[1], GEN_INT (mask), operands[3],
                                  operands[4], GEN_INT (pos + 2)));
   DONE;
})

;; EXTUWLL (p = 0, zp = 0)
(define_insn "mxu3_extuwll"
[(set (match_operand:V8DI 0 "register_operand" "=q")
    (subreg:V8DI
      (vec_merge:V16SI
        (subreg:V16SI (match_operand:V8DI 1 "register_operand" "0") 0)
        (subreg:V16SI 
          (ashift:V8DI
            (zero_extend:V8DI
              (vec_select:V8SI
                (match_operand:V16SI 2 "register_operand" "q")
                (parallel [(const_int 0) (const_int 1)
                           (const_int 2) (const_int 3)
                           (const_int 4) (const_int 5)
                           (const_int 6) (const_int 7)])))
            (const_int 32)) 0)
        (if_then_else
          (ne (match_operand 3 "const_0_or_1_operand" "")
              (const_int 0))
          (const_int 0)
          (const_int 21845))) 0))]
 "ISA_HAS_MXU3"
 "extuwll\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUWLH (p = 0, zp = 1)
(define_insn "mxu3_extuwlh"
[(set (match_operand:V8DI 0 "register_operand" "=q")
    (subreg:V8DI
      (vec_merge:V16SI
        (subreg:V16SI (match_operand:V8DI 1 "register_operand" "0") 0)
        (subreg:V16SI
          (zero_extend:V8DI
            (vec_select:V8SI
              (match_operand:V16SI 2 "register_operand" "q")
              (parallel [(const_int 0) (const_int 1)
                         (const_int 2) (const_int 3)
                         (const_int 4) (const_int 5)
                         (const_int 6) (const_int 7)]))) 0)
        (if_then_else 
          (ne (match_operand 3 "const_0_or_1_operand" "")
              (const_int 0))
          (const_int 0)
          (const_int 43690))) 0))]
 "ISA_HAS_MXU3"
 "extuwlh\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUWHL (p = 1, zp = 0)
(define_insn "mxu3_extuwhl"
[(set (match_operand:V8DI 0 "register_operand" "=q")
    (subreg:V8DI 
      (vec_merge:V16SI
        (subreg:V16SI (match_operand:V8DI 1 "register_operand" "0") 0)
        (subreg:V16SI
          (ashift:V8DI
            (zero_extend:V8DI
              (vec_select:V8SI
                (match_operand:V16SI 2 "register_operand" "q")
                (parallel [(const_int 8) (const_int 9)
                           (const_int 10) (const_int 11)
                           (const_int 12) (const_int 13)
                           (const_int 14) (const_int 15)])))
            (const_int 32)) 0)
        (if_then_else
          (ne (match_operand 3 "const_0_or_1_operand" "")
              (const_int 0))
          (const_int 0)
          (const_int 21845))) 0))]
 "ISA_HAS_MXU3"
 "extuwhl\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUWHH (p = 1, zp = 1)
(define_insn "mxu3_extuwhh"
  [(set (match_operand:V8DI 0 "register_operand" "=q")
    (subreg:V8DI 
      (vec_merge:V16SI
        (subreg:V16SI (match_operand:V8DI 1 "register_operand" "0") 0)
        (subreg:V16SI
          (zero_extend:V8DI
           (vec_select:V8SI
             (match_operand:V16SI 2 "register_operand" "q")
             (parallel [(const_int 8) (const_int 9)
                        (const_int 10) (const_int 11)
                        (const_int 12) (const_int 13)
                        (const_int 14) (const_int 15)]))) 0)
        (if_then_else
          (ne (match_operand 3 "const_0_or_1_operand" "")
              (const_int 0))
          (const_int 0)
          (const_int 43690))) 0))]
 "ISA_HAS_MXU3"
 "extuwhh\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUDLL (p = 0, zp = 0)
(define_insn "mxu3_extudll"
[(set (match_operand:V4TI 0 "register_operand" "=q")
    (subreg:V4TI
      (vec_merge:V8DI
        (subreg:V8DI (match_operand:V4TI 1 "register_operand" "0") 0)
        (subreg:V8DI 
          (ashift:V4TI
            (zero_extend:V4TI
              (vec_select:V4DI
                (match_operand:V8DI 2 "register_operand" "q")
                (parallel [(const_int 0) (const_int 1)
                           (const_int 2) (const_int 3)])))
            (const_int 64)) 0)
        (if_then_else
          (ne (match_operand 3 "const_0_or_1_operand" "")
              (const_int 0))
          (const_int 0)
          (const_int 85))) 0))]
 "ISA_HAS_MXU3"
 "extudll\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUDLH (p = 0, zp = 1)
(define_insn "mxu3_extudlh"
[(set (match_operand:V4TI 0 "register_operand" "=q")
    (subreg:V4TI
      (vec_merge:V8DI
        (subreg:V8DI (match_operand:V4TI 1 "register_operand" "0") 0)
        (subreg:V8DI
          (zero_extend:V4TI
            (vec_select:V4DI
              (match_operand:V8DI 2 "register_operand" "q")
              (parallel [(const_int 0) (const_int 1)
                         (const_int 2) (const_int 3)]))) 0)
        (if_then_else 
          (ne (match_operand 3 "const_0_or_1_operand" "")
              (const_int 0))
          (const_int 0)
          (const_int 170))) 0))]
 "ISA_HAS_MXU3"
 "extudlh\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])


;; EXTUDHL (p = 1, zp = 0)
(define_insn "mxu3_extudhl"
[(set (match_operand:V4TI 0 "register_operand" "=q")
    (subreg:V4TI
      (vec_merge:V8DI
        (subreg:V8DI (match_operand:V4TI 1 "register_operand" "0") 0)
        (subreg:V8DI 
          (ashift:V4TI
            (zero_extend:V4TI
              (vec_select:V4DI
                (match_operand:V8DI 2 "register_operand" "q")
                (parallel [(const_int 4) (const_int 5)
                           (const_int 6) (const_int 7)])))
            (const_int 64)) 0)
        (if_then_else
          (ne (match_operand 3 "const_0_or_1_operand" "")
              (const_int 0))
          (const_int 0)
          (const_int 85))) 0))]
 "ISA_HAS_MXU3"
 "extudhl\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUDHH (p = 1, zp = 1)
(define_insn "mxu3_extudhh"
[(set (match_operand:V4TI 0 "register_operand" "=q")
    (subreg:V4TI
      (vec_merge:V8DI
        (subreg:V8DI (match_operand:V4TI 1 "register_operand" "0") 0)
        (subreg:V8DI
          (zero_extend:V4TI
            (vec_select:V4DI
              (match_operand:V8DI 2 "register_operand" "q")
              (parallel [(const_int 4) (const_int 5)
                         (const_int 6) (const_int 7)]))) 0)
        (if_then_else 
          (ne (match_operand 3 "const_0_or_1_operand" "")
              (const_int 0))
          (const_int 0)
          (const_int 170))) 0))]
 "ISA_HAS_MXU3"
 "extudhh\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUQLL (p = 0, zp = 0)
(define_insn "mxu3_extuqll"
[(set (match_operand:V4TI 0 "register_operand" "=q")
      (vec_merge:V4TI
        (match_operand:V4TI 1 "register_operand" "0")
        (unspec:V4TI
          [(match_operand:V4TI 2 "register_operand" "q")]
          UNSPEC_MXU3_EXTUQLL)
         (match_operand 3 "const_0_or_1_operand" "")))]
 "ISA_HAS_MXU3"
 "extuqll\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUQLH (p = 0, zp = 1)
(define_insn "mxu3_extuqlh"
[(set (match_operand:V4TI 0 "register_operand" "=q")
      (vec_merge:V4TI
        (match_operand:V4TI 1 "register_operand" "0")
        (unspec:V4TI
          [(match_operand:V4TI 2 "register_operand" "q")]
          UNSPEC_MXU3_EXTUQLH)
         (match_operand 3 "const_0_or_1_operand" "")))]
 "ISA_HAS_MXU3"
 "extuqlh\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUQHL (p = 1, zp = 0)
(define_insn "mxu3_extuqhl"
[(set (match_operand:V4TI 0 "register_operand" "=q")
      (vec_merge:V4TI
        (match_operand:V4TI 1 "register_operand" "0")
        (unspec:V4TI
          [(match_operand:V4TI 2 "register_operand" "q")]
          UNSPEC_MXU3_EXTUQHL)
         (match_operand 3 "const_0_or_1_operand" "")))]
 "ISA_HAS_MXU3"
 "extuqhl\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUQHH (p = 1, zp = 1)
(define_insn "mxu3_extuqhh"
[(set (match_operand:V4TI 0 "register_operand" "=q")
      (vec_merge:V4TI
        (match_operand:V4TI 1 "register_operand" "0")
        (unspec:V4TI
          [(match_operand:V4TI 2 "register_operand" "q")]
          UNSPEC_MXU3_EXTUQHH)
         (match_operand 3 "const_0_or_1_operand" "")))]
 "ISA_HAS_MXU3"
 "extuqhh\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUOLL (p = 0, zp = 0)
(define_insn "mxu3_extuoll"
[(set (match_operand:V4TI 0 "register_operand" "=q")
      (vec_merge:V4TI
        (match_operand:V4TI 1 "register_operand" "0")
        (unspec:V4TI
          [(match_operand:V4TI 2 "register_operand" "q")]
          UNSPEC_MXU3_EXTUOLL)
         (match_operand 3 "const_0_or_1_operand" "")))]
 "ISA_HAS_MXU3"
 "extuoll\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUOLH (p = 0, zp = 1)
(define_insn "mxu3_extuolh"
[(set (match_operand:V4TI 0 "register_operand" "=q")
      (vec_merge:V4TI
        (match_operand:V4TI 1 "register_operand" "0")
        (unspec:V4TI
          [(match_operand:V4TI 2 "register_operand" "q")]
          UNSPEC_MXU3_EXTUOLH)
         (match_operand 3 "const_0_or_1_operand" "")))]
 "ISA_HAS_MXU3"
 "extuolh\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUOHL (p = 1, zp = 0)
(define_insn "mxu3_extuohl"
[(set (match_operand:V4TI 0 "register_operand" "=q")
      (vec_merge:V4TI
        (match_operand:V4TI 1 "register_operand" "0")
        (unspec:V4TI
          [(match_operand:V4TI 2 "register_operand" "q")]
          UNSPEC_MXU3_EXTUOHL)
         (match_operand 3 "const_0_or_1_operand" "")))]
 "ISA_HAS_MXU3"
 "extuohl\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTUOHH (p = 1, zp = 1)
(define_insn "mxu3_extuohh"
[(set (match_operand:V4TI 0 "register_operand" "=q")
      (vec_merge:V4TI
        (match_operand:V4TI 1 "register_operand" "0")
        (unspec:V4TI
          [(match_operand:V4TI 2 "register_operand" "q")]
          UNSPEC_MXU3_EXTUOHH)
         (match_operand 3 "const_0_or_1_operand" "")))]
 "ISA_HAS_MXU3"
 "extuohh\t%w0, %w2, %d3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXT(U/S)1BIL (s = 0,1 p = 0)
(define_insn "mxu3_ext<su>1bil"
[(set (match_operand:V64QI 0 "register_operand" "=q")
      (unspec:V64QI
        [(any_extend:V32HI
           (vec_select:V32QI
             (match_operand:V64QI 1 "register_operand" "q")
             (parallel [(const_int 0)  (const_int 1)  
                        (const_int 2)  (const_int 3)
                        (const_int 4)  (const_int 5)  
                        (const_int 6)  (const_int 7)
                        (const_int 8)  (const_int 9)  
                        (const_int 10) (const_int 11)
                        (const_int 12) (const_int 13) 
                        (const_int 14) (const_int 15) 
                        (const_int 16) (const_int 17) 
                        (const_int 18) (const_int 19) 
                        (const_int 20) (const_int 21) 
                        (const_int 22) (const_int 23) 
                        (const_int 24) (const_int 25) 
                        (const_int 26) (const_int 27) 
                        (const_int 28) (const_int 29) 
                        (const_int 30) (const_int 31)])))]
        UNSPEC_MXU3_EXT1BI))]
 "ISA_HAS_MXU3"
 "ext<su>1bil\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXT(U/S)1BIH (s = 0,1 p = 1)
(define_insn "mxu3_ext<su>1bih"
[(set (match_operand:V64QI 0 "register_operand" "=q")
      (unspec:V64QI
        [(any_extend:V32HI
           (vec_select:V32QI
             (match_operand:V64QI 1 "register_operand" "q")
             (parallel [(const_int 32) (const_int 33)  
                        (const_int 34) (const_int 35)
                        (const_int 36) (const_int 37)  
                        (const_int 38) (const_int 39)
                        (const_int 40) (const_int 41)  
                        (const_int 42) (const_int 43)
                        (const_int 44) (const_int 45) 
                        (const_int 46) (const_int 47) 
                        (const_int 48) (const_int 49) 
                        (const_int 50) (const_int 51) 
                        (const_int 52) (const_int 53) 
                        (const_int 54) (const_int 55) 
                        (const_int 56) (const_int 57) 
                        (const_int 58) (const_int 59) 
                        (const_int 60) (const_int 61) 
                        (const_int 62) (const_int 63)])))]
        UNSPEC_MXU3_EXT1BI))]
 "ISA_HAS_MXU3"
 "ext<su>1bih\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXT(U/S)2BIL (s = 0,1 p = 0)
(define_insn "mxu3_ext<su>2bil"
[(set (match_operand:V64QI 0 "register_operand" "=q")
      (unspec:V64QI
        [(any_extend:V32HI
           (vec_select:V32QI
             (match_operand:V64QI 1 "register_operand" "q")
             (parallel [(const_int 0)  (const_int 1)  
                        (const_int 2)  (const_int 3)
                        (const_int 4)  (const_int 5)  
                        (const_int 6)  (const_int 7)
                        (const_int 8)  (const_int 9)  
                        (const_int 10) (const_int 11)
                        (const_int 12) (const_int 13) 
                        (const_int 14) (const_int 15) 
                        (const_int 16) (const_int 17) 
                        (const_int 18) (const_int 19) 
                        (const_int 20) (const_int 21) 
                        (const_int 22) (const_int 23) 
                        (const_int 24) (const_int 25) 
                        (const_int 26) (const_int 27) 
                        (const_int 28) (const_int 29) 
                        (const_int 30) (const_int 31)])))]
        UNSPEC_MXU3_EXT2BI))]
 "ISA_HAS_MXU3"
 "ext<su>2bil\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXT(U/S)2BIH (s = 0,1 p = 1)
(define_insn "mxu3_ext<su>2bih"
[(set (match_operand:V64QI 0 "register_operand" "=q")
      (unspec:V64QI
        [(any_extend:V32HI
           (vec_select:V32QI
             (match_operand:V64QI 1 "register_operand" "q")
             (parallel [(const_int 32) (const_int 33)  
                        (const_int 34) (const_int 35)
                        (const_int 36) (const_int 37)  
                        (const_int 38) (const_int 39)
                        (const_int 40) (const_int 41)  
                        (const_int 42) (const_int 43)
                        (const_int 44) (const_int 45) 
                        (const_int 46) (const_int 47) 
                        (const_int 48) (const_int 49) 
                        (const_int 50) (const_int 51) 
                        (const_int 52) (const_int 53) 
                        (const_int 54) (const_int 55) 
                        (const_int 56) (const_int 57) 
                        (const_int 58) (const_int 59) 
                        (const_int 60) (const_int 61) 
                        (const_int 62) (const_int 63)])))]
        UNSPEC_MXU3_EXT2BI))]
 "ISA_HAS_MXU3"
 "ext<su>2bih\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXT(U/S)4BIL (s = 0,1 p = 0)
(define_insn "mxu3_ext<su>4bil"
[(set (match_operand:V64QI 0 "register_operand" "=q")
      (unspec:V64QI
        [(any_extend:V32HI
           (vec_select:V32QI
             (match_operand:V64QI 1 "register_operand" "q")
             (parallel [(const_int 0)  (const_int 1)  
                        (const_int 2)  (const_int 3)
                        (const_int 4)  (const_int 5)  
                        (const_int 6)  (const_int 7)
                        (const_int 8)  (const_int 9)  
                        (const_int 10) (const_int 11)
                        (const_int 12) (const_int 13) 
                        (const_int 14) (const_int 15) 
                        (const_int 16) (const_int 17) 
                        (const_int 18) (const_int 19) 
                        (const_int 20) (const_int 21) 
                        (const_int 22) (const_int 23) 
                        (const_int 24) (const_int 25) 
                        (const_int 26) (const_int 27) 
                        (const_int 28) (const_int 29) 
                        (const_int 30) (const_int 31)])))]
        UNSPEC_MXU3_EXT4BI))]
 "ISA_HAS_MXU3"
 "ext<su>4bil\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXT(U/S)4BIH (s = 0,1 p = 1)
(define_insn "mxu3_ext<su>4bih"
[(set (match_operand:V64QI 0 "register_operand" "=q")
      (unspec:V64QI
        [(any_extend:V32HI
           (vec_select:V32QI
             (match_operand:V64QI 1 "register_operand" "q")
             (parallel [(const_int 32) (const_int 33)  
                        (const_int 34) (const_int 35)
                        (const_int 36) (const_int 37)  
                        (const_int 38) (const_int 39)
                        (const_int 40) (const_int 41)  
                        (const_int 42) (const_int 43)
                        (const_int 44) (const_int 45) 
                        (const_int 46) (const_int 47) 
                        (const_int 48) (const_int 49) 
                        (const_int 50) (const_int 51) 
                        (const_int 52) (const_int 53) 
                        (const_int 54) (const_int 55) 
                        (const_int 56) (const_int 57) 
                        (const_int 58) (const_int 59) 
                        (const_int 60) (const_int 61) 
                        (const_int 62) (const_int 63)])))]
        UNSPEC_MXU3_EXT4BI))]
 "ISA_HAS_MXU3"
 "ext<su>4bih\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXT(U/S)BL (s = 0,1 p = 0)
(define_insn "mxu3_ext<su>bl"
[(set (match_operand:V32HI 0 "register_operand" "=q")
      (any_extend:V32HI
        (vec_select:V32QI
          (match_operand:V64QI 1 "register_operand" "q")
          (parallel [(const_int 0)  (const_int 1)  
                     (const_int 2)  (const_int 3)
                     (const_int 4)  (const_int 5)  
                     (const_int 6)  (const_int 7)
                     (const_int 8)  (const_int 9)  
                     (const_int 10) (const_int 11)
                     (const_int 12) (const_int 13) 
                     (const_int 14) (const_int 15) 
                     (const_int 16) (const_int 17) 
                     (const_int 18) (const_int 19) 
                     (const_int 20) (const_int 21) 
                     (const_int 22) (const_int 23) 
                     (const_int 24) (const_int 25) 
                     (const_int 26) (const_int 27) 
                     (const_int 28) (const_int 29) 
                     (const_int 30) (const_int 31)]))))]
 "ISA_HAS_MXU3"
 "ext<su>bl\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXT(U/S)BH (s = 0,1 p = 1)
(define_insn "mxu3_ext<su>bh"
[(set (match_operand:V32HI 0 "register_operand" "=q")
      (any_extend:V32HI
        (vec_select:V32QI
          (match_operand:V64QI 1 "register_operand" "q")
          (parallel [(const_int 32) (const_int 33)  
                     (const_int 34) (const_int 35)
                     (const_int 36) (const_int 37)  
                     (const_int 38) (const_int 39)
                     (const_int 40) (const_int 41)  
                     (const_int 42) (const_int 43)
                     (const_int 44) (const_int 45) 
                     (const_int 46) (const_int 47) 
                     (const_int 48) (const_int 49) 
                     (const_int 50) (const_int 51) 
                     (const_int 52) (const_int 53) 
                     (const_int 54) (const_int 55) 
                     (const_int 56) (const_int 57) 
                     (const_int 58) (const_int 59) 
                     (const_int 60) (const_int 61) 
                     (const_int 62) (const_int 63)]))))]
 "ISA_HAS_MXU3"
 "ext<su>bh\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXT(U/S)HL (s = 0,1 p = 0)
(define_insn "mxu3_ext<su>hl"
[(set (match_operand:V16SI 0 "register_operand" "=q")
      (any_extend:V16SI
        (vec_select:V16HI
          (match_operand:V32HI 1 "register_operand" "q")
          (parallel [(const_int 0)  (const_int 1)  
                     (const_int 2)  (const_int 3)
                     (const_int 4)  (const_int 5)  
                     (const_int 6)  (const_int 7)
                     (const_int 8)  (const_int 9)  
                     (const_int 10) (const_int 11)
                     (const_int 12) (const_int 13) 
                     (const_int 14) (const_int 15)]))))]
 "ISA_HAS_MXU3"
 "ext<su>hl\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXT(U/S)HH (s = 0,1 p = 1)
(define_insn "mxu3_ext<su>hh"
[(set (match_operand:V16SI 0 "register_operand" "=q")
      (any_extend:V16SI
        (vec_select:V16HI
          (match_operand:V32HI 1 "register_operand" "q")
          (parallel [(const_int 16) (const_int 17)  
                     (const_int 18) (const_int 19)
                     (const_int 20) (const_int 21)  
                     (const_int 22) (const_int 23)
                     (const_int 24) (const_int 25)  
                     (const_int 26) (const_int 27)
                     (const_int 28) (const_int 29) 
                     (const_int 30) (const_int 31)]))))]
 "ISA_HAS_MXU3"
 "ext<su>hh\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; EXTU3BW
(define_insn "mxu3_extu3bw"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (unspec:V16SI 
          [(match_operand:V64QI 1 "register_operand" "q")]
          UNSPEC_MXU3_EXTU3BW))]
 "ISA_HAS_MXU3"
 "extu3bw\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; REPI(B,H,W,D,Q)
(define_insn "mxu3_repi<imxu3lfmt>"
  [(set (match_operand:IMXU3L 0 "register_operand" "=q")
        (vec_duplicate:IMXU3L
          (vec_select:<UNITMODE>
             (match_operand:IMXU3L 1 "register_operand" "q")
             (parallel [(match_operand 2 "const_<elemindex>_operand" "")]))))]
 "ISA_HAS_MXU3"
 "repi<imxu3lfmt>\t%w0, %w1[%2]"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; REPIO
(define_insn "mxu3_repio"
  [(set (match_operand:V4TI 0 "register_operand" "=q")
        (unspec:V4TI [(match_operand:V4TI 1 "register_operand" "q")
       	              (match_operand 2 "const_0_or_1_operand" "")]
		      UNSPEC_MXU3_REPIO))]
  "ISA_HAS_MXU3"
  "repio\t%w0,%w1[%2]"
  [(set_attr "mode" "TI")
   (set_attr "lat_type" "lat3")])

;; MOV(W,D,Q)
(define_mode_iterator IMXU3_MOVE [V2OI V4TI V8DI V16SI])

(define_mode_attr imxu3_move_fmt
  [(V16SI  "w")
   (V8DI   "d")
   (V4TI   "q")
   (V2OI   "o")
  ])

(define_mode_attr mxu3_move_idx
  [(V16SI "uimm4")
   (V8DI  "uimm3")
   (V4TI  "0_to_3")
   (V2OI  "0_or_1")
  ])

(define_insn "mxu3_mov<imxu3_move_fmt>"
  [(set (match_operand:IMXU3_MOVE 0 "register_operand" "=q")
        (ior:IMXU3_MOVE
          (vec_merge:IMXU3_MOVE
            (vec_duplicate:IMXU3_MOVE (const_int 0))
            (match_operand:IMXU3_MOVE 1 "register_operand" "0")
            (ashift:SI (const_int 1) (match_operand 2 "const_<mxu3_move_idx>_operand" "")) 
          ) 
          (vec_merge:IMXU3_MOVE
            (match_operand:IMXU3_MOVE 3 "register_operand" "q")
            (vec_duplicate:IMXU3_MOVE (const_int 0))
            (ashift:SI (const_int 1) (match_operand 4 "const_<mxu3_move_idx>_operand" "")) 
          ) 
        )
  )]
 "ISA_HAS_MXU3"
 "mov<imxu3_move_fmt>\t%w0[%2], %w3[%4]"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; SHUFW2
(define_insn "mxu3_shufw2"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (vec_select:V16SI
              (match_operand:V16SI 1 "register_operand" "q")
              (parallel [(const_int 0) (const_int 8)
                         (const_int 1) (const_int 9)
                         (const_int 2) (const_int 10)
                         (const_int 3) (const_int 11)
                         (const_int 4) (const_int 12)
                         (const_int 5) (const_int 13)
                         (const_int 6) (const_int 14)
                         (const_int 7) (const_int 15)])))]
 "ISA_HAS_MXU3"
 "shufw2\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; SHUFW4
(define_insn "mxu3_shufw4"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (vec_select:V16SI
              (match_operand:V16SI 1 "register_operand" "q")
              (parallel [(const_int 0)  (const_int 4)
                         (const_int 8)  (const_int 12)
                         (const_int 1)  (const_int 5)
                         (const_int 9)  (const_int 13)
                         (const_int 2)  (const_int 6)
                         (const_int 10) (const_int 14)
                         (const_int 3)  (const_int 7)
                         (const_int 11) (const_int 15)])))]
 "ISA_HAS_MXU3"
 "shufw4\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; SHUFW8
(define_insn "mxu3_shufw8"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (vec_select:V16SI
              (match_operand:V16SI 1 "register_operand" "q")
              (parallel [(const_int 0)  (const_int 2)
                         (const_int 4)  (const_int 6)
                         (const_int 8)  (const_int 10)
                         (const_int 12) (const_int 14)
                         (const_int 1)  (const_int 3)
                         (const_int 5)  (const_int 7)
                         (const_int 9)  (const_int 11)
                         (const_int 13) (const_int 15)])))]
 "ISA_HAS_MXU3"
 "shufw8\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; SHUFD2
(define_insn "mxu3_shufd2"
  [(set (match_operand:V8DI 0 "register_operand" "=q")
        (vec_select:V8DI
              (match_operand:V8DI 1 "register_operand" "q")
              (parallel [(const_int 0) (const_int 4)
                         (const_int 1) (const_int 5)
                         (const_int 2) (const_int 6)
                         (const_int 3) (const_int 7)])))]
 "ISA_HAS_MXU3"
 "shufd2\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; SHUFD4
(define_insn "mxu3_shufd4"
  [(set (match_operand:V8DI 0 "register_operand" "=q")
        (vec_select:V8DI
              (match_operand:V8DI 1 "register_operand" "q")
              (parallel [(const_int 0) (const_int 2)
                         (const_int 4) (const_int 6)
                         (const_int 1) (const_int 3)
                         (const_int 5) (const_int 7)])))]
 "ISA_HAS_MXU3"
 "shufd4\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; SHUFQ2
(define_insn "mxu3_shufq2"
  [(set (match_operand:V4TI 0 "register_operand" "=q")
        (vec_select:V4TI
              (match_operand:V4TI 1 "register_operand" "q")
              (parallel [(const_int 0) (const_int 2)
                         (const_int 1) (const_int 3)])))]
 "ISA_HAS_MXU3"
 "shufq2\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; GSHUFW
(define_insn "mxu3_gshufw"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (unspec:V16SI
          [(match_operand:V16SI 1 "register_operand" "0")
           (match_operand:V16SI 2 "register_operand" "q")
           (match_operand:V16SI 3 "register_operand" "q")
           (match_operand 4 "const_uimm2_operand" "")]
          UNSPEC_MXU3_GSHUFW))]
 "ISA_HAS_MXU3"
 "gshufw\t%w0, %w2, %w3, %d4"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; GSHUFWB
(define_insn "mxu3_gshufwb"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (unspec:V64QI
          [(match_operand:V64QI 1 "register_operand" "0")
           (match_operand:V16SI 2 "register_operand" "q")
           (match_operand:V64QI 3 "register_operand" "q")]
          UNSPEC_MXU3_GSHUFWB))]
 "ISA_HAS_MXU3 && !ISA_HAS_MXU3_1"
 "gshufwb\t%w0, %w2, %w3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; GSHUFWB_1
(define_insn "mxu3_gshufwb_1"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (unspec:V64QI
          [(match_operand:V64QI 1 "register_operand" "0")
           (match_operand:V16SI 2 "register_operand" "q")
           (match_operand:V64QI 3 "register_operand" "q")
           (match_operand 4 "const_0_or_1_operand" "")]
          UNSPEC_MXU3_GSHUFWB_1))]
 "ISA_HAS_MXU3_1"
 "gshufwb_1\t%w0, %w2, %w3, %d4"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; GSHUFWB_2
(define_insn "mxu3_gshufwb_2"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (unspec:V64QI
          [(match_operand:V64QI 1 "register_operand" "0")
           (match_operand:V16SI 2 "register_operand" "q")
           (match_operand:V64QI 3 "register_operand" "q")
           (match_operand 4 "const_0_or_1_operand" "")]
          UNSPEC_MXU3_GSHUFWB_2))]
 "ISA_HAS_MXU3_1"
 "gshufwb_2\t%w0, %w2, %w3, %d4"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; GSHUFVB
(define_insn "mxu3_gshufvb"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (unspec:V64QI
          [(match_operand:V64QI 1 "register_operand" "0")
           (match_operand:V64QI 2 "register_operand" "q")
           (match_operand:V64QI 3 "register_operand" "q")]
          UNSPEC_MXU3_GSHUFVB))]
 "ISA_HAS_MXU3_1"
 "gshufvb\t%w0, %w2, %w3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; GSHUFB
(define_insn "mxu3_gshufb"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (unspec:V64QI
          [(match_operand:V64QI 1 "register_operand" "0")
           (match_operand:V64QI 2 "register_operand" "q")
           (match_operand:V64QI 3 "register_operand" "q")]
          UNSPEC_MXU3_GSHUFB))]
 "ISA_HAS_MXU3 && !ISA_HAS_MXU3_1"
 "gshufb\t%w0, %w2, %w3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; GSHUFWH
(define_insn "mxu3_gshufwh"
  [(set (match_operand:V32HI 0 "register_operand" "=q")
        (unspec:V32HI
          [(match_operand:V32HI 1 "register_operand" "0")
           (match_operand:V16SI 2 "register_operand" "q")
           (match_operand:V32HI 3 "register_operand" "q")]
          UNSPEC_MXU3_GSHUFWH))]
 "ISA_HAS_MXU3 && !ISA_HAS_MXU3_1"
 "gshufwh\t%w0, %w2, %w3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; GSHUFH
(define_insn "mxu3_gshufh"
  [(set (match_operand:V32HI 0 "register_operand" "=q")
        (unspec:V32HI
          [(match_operand:V32HI 1 "register_operand" "0")
           (match_operand:V32HI 2 "register_operand" "q")
           (match_operand:V32HI 3 "register_operand" "q")]
          UNSPEC_MXU3_GSHUFH))]
 "ISA_HAS_MXU3 && !ISA_HAS_MXU3_1"
 "gshufh\t%w0, %w2, %w3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVE2BI
(define_insn "mxu3_ilve2bi"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (ior:V64QI
          (and:V64QI
            (match_operand:V64QI 1 "register_operand" "q")
            (const_vector:V64QI [(const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)]))
          (and:V64QI
            (ashift:V64QI (match_operand:V64QI 2 "register_operand" "q") (const_int 2))
            (const_vector:V64QI [(const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)]))))]
 "ISA_HAS_MXU3"
 "ilve2bi\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVE4BI
(define_insn "mxu3_ilve4bi"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (ior:V64QI
          (and:V64QI
            (match_operand:V64QI 1 "register_operand" "q")
            (const_vector:V64QI [(const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)
                                 (const_int 15) (const_int 15)]))
          (ashift:V64QI (match_operand:V64QI 2 "register_operand" "q") (const_int 4))))]
 "ISA_HAS_MXU3"
 "ilve4bi\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVEB
(define_insn "mxu3_ilveb"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (vec_select:V64QI
          (vec_concat:V128QI
            (match_operand:V64QI 1 "register_operand" "q")
            (match_operand:V64QI 2 "register_operand" "q"))
          (parallel [(const_int 0)  (const_int 64)
                     (const_int 2)  (const_int 66)
                     (const_int 4)  (const_int 68)
                     (const_int 6)  (const_int 70)
                     (const_int 8)  (const_int 72)
                     (const_int 10) (const_int 74)
                     (const_int 12) (const_int 76)
                     (const_int 14) (const_int 78)
                     (const_int 16) (const_int 80)
                     (const_int 18) (const_int 82)
                     (const_int 20) (const_int 84)
                     (const_int 22) (const_int 86)
                     (const_int 24) (const_int 88)
                     (const_int 26) (const_int 90)
                     (const_int 28) (const_int 92)
                     (const_int 30) (const_int 94)
                     (const_int 32) (const_int 96)
                     (const_int 34) (const_int 98)
                     (const_int 36) (const_int 100)
                     (const_int 38) (const_int 102)
                     (const_int 40) (const_int 104)
                     (const_int 42) (const_int 106)
                     (const_int 44) (const_int 108)
                     (const_int 46) (const_int 110)
                     (const_int 48) (const_int 112)
                     (const_int 50) (const_int 114)
                     (const_int 52) (const_int 116)
                     (const_int 54) (const_int 118)
                     (const_int 56) (const_int 120)
                     (const_int 58) (const_int 122)
                     (const_int 60) (const_int 124)
                     (const_int 62) (const_int 126)])))]
 "ISA_HAS_MXU3"
 "ilveb\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVEH
(define_insn "mxu3_ilveh"
  [(set (match_operand:V32HI 0 "register_operand" "=q")
        (vec_select:V32HI
          (vec_concat:V64HI
            (match_operand:V32HI 1 "register_operand" "q")
            (match_operand:V32HI 2 "register_operand" "q"))
          (parallel [(const_int 0)  (const_int 32)
                     (const_int 2)  (const_int 34)
                     (const_int 4)  (const_int 36)
                     (const_int 6)  (const_int 38)
                     (const_int 8)  (const_int 40)
                     (const_int 10) (const_int 42)
                     (const_int 12) (const_int 44)
                     (const_int 14) (const_int 46)
                     (const_int 16) (const_int 48)
                     (const_int 18) (const_int 50)
                     (const_int 20) (const_int 52)
                     (const_int 22) (const_int 54)
                     (const_int 24) (const_int 56)
                     (const_int 26) (const_int 58)
                     (const_int 28) (const_int 60)
                     (const_int 30) (const_int 62)])))]
 "ISA_HAS_MXU3"
 "ilveh\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVEW
(define_insn "mxu3_ilvew"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (vec_select:V16SI
          (vec_concat:V32SI
            (match_operand:V16SI 1 "register_operand" "q")
            (match_operand:V16SI 2 "register_operand" "q"))
          (parallel [(const_int 0)  (const_int 16)
                     (const_int 2)  (const_int 18)
                     (const_int 4)  (const_int 20)
                     (const_int 6)  (const_int 22)
                     (const_int 8)  (const_int 24)
                     (const_int 10) (const_int 26)
                     (const_int 12) (const_int 28)
                     (const_int 14) (const_int 30)])))]
 "ISA_HAS_MXU3"
 "ilvew\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVED
(define_insn "mxu3_ilved"
  [(set (match_operand:V8DI 0 "register_operand" "=q")
        (vec_select:V8DI
          (vec_concat:V16DI
            (match_operand:V8DI 2 "register_operand" "q")
            (match_operand:V8DI 1 "register_operand" "q"))
          (parallel [(const_int 0)  (const_int 8)
                     (const_int 2)  (const_int 10)
                     (const_int 4)  (const_int 12)
                     (const_int 6)  (const_int 14)])))]
 "ISA_HAS_MXU3"
 "ilved\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVEQ
(define_insn "mxu3_ilveq"
  [(set (match_operand:V4TI 0 "register_operand" "=q")
        (vec_select:V4TI
          (vec_concat:V8TI
            (match_operand:V4TI 1 "register_operand" "q")
            (match_operand:V4TI 2 "register_operand" "q"))
          (parallel [(const_int 0)  (const_int 4)
                     (const_int 2)  (const_int 6)])))]
 "ISA_HAS_MXU3"
 "ilveq\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVEO
(define_insn "mxu3_ilveo"
  [(set (match_operand:V4TI 0 "register_operand" "=q")
        (vec_select:V4TI
          (vec_concat:V8TI
            (match_operand:V4TI 1 "register_operand" "q")
            (match_operand:V4TI 2 "register_operand" "q"))
          (parallel [(const_int 0)  (const_int 1)
                     (const_int 4)  (const_int 5)])))]
 "ISA_HAS_MXU3"
 "ilveo\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVO2BI
(define_insn "mxu3_ilvo2bi"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (ior:V64QI
          (and:V64QI
            (match_operand:V64QI 1 "register_operand" "q")
            (const_vector:V64QI [(const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)
                                 (const_int 204) (const_int 204)]))
          (and:V64QI
            (lshiftrt:V64QI (match_operand:V64QI 2 "register_operand" "q") (const_int 2))
            (const_vector:V64QI [(const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)
                                 (const_int 51) (const_int 51)]))))]
 "ISA_HAS_MXU3"
 "ilvo2bi\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVO4BI
(define_insn "mxu3_ilvo4bi"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (ior:V64QI
          (and:V64QI
            (match_operand:V64QI 1 "register_operand" "q")
            (const_vector:V64QI [(const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)
                                 (const_int 240) (const_int 240)]))
          (lshiftrt:V64QI (match_operand:V64QI 2 "register_operand" "q") (const_int 4))))]
 "ISA_HAS_MXU3"
 "ilvo4bi\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVOB
(define_insn "mxu3_ilvob"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
        (vec_select:V64QI
          (vec_concat:V128QI
            (match_operand:V64QI 2 "register_operand" "q")
            (match_operand:V64QI 1 "register_operand" "q"))
          (parallel [(const_int 1)  (const_int 65)
                     (const_int 3)  (const_int 67)
                     (const_int 5)  (const_int 69)
                     (const_int 7)  (const_int 71)
                     (const_int 9)  (const_int 73)
                     (const_int 11) (const_int 75)
                     (const_int 13) (const_int 77)
                     (const_int 15) (const_int 79)
                     (const_int 17) (const_int 81)
                     (const_int 19) (const_int 83)
                     (const_int 21) (const_int 85)
                     (const_int 23) (const_int 87)
                     (const_int 25) (const_int 89)
                     (const_int 27) (const_int 91)
                     (const_int 29) (const_int 93)
                     (const_int 31) (const_int 95)
                     (const_int 33) (const_int 97)
                     (const_int 35) (const_int 99)
                     (const_int 37) (const_int 101)
                     (const_int 39) (const_int 103)
                     (const_int 41) (const_int 105)
                     (const_int 43) (const_int 107)
                     (const_int 45) (const_int 109)
                     (const_int 47) (const_int 111)
                     (const_int 49) (const_int 113)
                     (const_int 51) (const_int 115)
                     (const_int 53) (const_int 117)
                     (const_int 55) (const_int 119)
                     (const_int 57) (const_int 121)
                     (const_int 59) (const_int 123)
                     (const_int 61) (const_int 125)
                     (const_int 63) (const_int 127)])))]
 "ISA_HAS_MXU3"
 "ilvob\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVOH
(define_insn "mxu3_ilvoh"
  [(set (match_operand:V32HI 0 "register_operand" "=q")
        (vec_select:V32HI
          (vec_concat:V64HI
            (match_operand:V32HI 2 "register_operand" "q")
            (match_operand:V32HI 1 "register_operand" "q"))
          (parallel [(const_int 1)  (const_int 33)
                     (const_int 3)  (const_int 35)
                     (const_int 5)  (const_int 37)
                     (const_int 7)  (const_int 39)
                     (const_int 9)  (const_int 41)
                     (const_int 11) (const_int 43)
                     (const_int 13) (const_int 45)
                     (const_int 15) (const_int 47)
                     (const_int 17) (const_int 49)
                     (const_int 19) (const_int 51)
                     (const_int 21) (const_int 53)
                     (const_int 23) (const_int 55)
                     (const_int 25) (const_int 57)
                     (const_int 27) (const_int 59)
                     (const_int 29) (const_int 61)
                     (const_int 31) (const_int 63)])))]
 "ISA_HAS_MXU3"
 "ilvoh\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVOW
(define_insn "mxu3_ilvow"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (vec_select:V16SI
          (vec_concat:V32SI
            (match_operand:V16SI 2 "register_operand" "q")
            (match_operand:V16SI 1 "register_operand" "q"))
          (parallel [(const_int 1)  (const_int 17)
                     (const_int 3)  (const_int 19)
                     (const_int 5)  (const_int 21)
                     (const_int 7)  (const_int 23)
                     (const_int 9)  (const_int 25)
                     (const_int 11) (const_int 27)
                     (const_int 13) (const_int 29)
                     (const_int 15) (const_int 31)])))]
 "ISA_HAS_MXU3"
 "ilvow\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVOD
(define_insn "mxu3_ilvod"
  [(set (match_operand:V8DI 0 "register_operand" "=q")
        (vec_select:V8DI
          (vec_concat:V16DI
            (match_operand:V8DI 2 "register_operand" "q")
            (match_operand:V8DI 1 "register_operand" "q"))
          (parallel [(const_int 1)  (const_int 9)
                     (const_int 3)  (const_int 11)
                     (const_int 5)  (const_int 13)
                     (const_int 7)  (const_int 15)])))]
 "ISA_HAS_MXU3"
 "ilvod\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVOQ
(define_insn "mxu3_ilvoq"
  [(set (match_operand:V4TI 0 "register_operand" "=q")
        (vec_select:V4TI
          (vec_concat:V8TI
            (match_operand:V4TI 2 "register_operand" "q")
            (match_operand:V4TI 1 "register_operand" "q"))
          (parallel [(const_int 1)  (const_int 5)
                     (const_int 3)  (const_int 7)])))]
 "ISA_HAS_MXU3"
 "ilvoq\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; ILVOO
(define_insn "mxu3_ilvoo"
  [(set (match_operand:V4TI 0 "register_operand" "=q")
        (vec_select:V4TI
          (vec_concat:V8TI
            (match_operand:V4TI 2 "register_operand" "q")
            (match_operand:V4TI 1 "register_operand" "q"))
          (parallel [(const_int 2)  (const_int 3)
                     (const_int 6)  (const_int 7)])))]
 "ISA_HAS_MXU3"
 "ilvoo\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;;BSHLI
(define_insn "mxu3_bshli"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
     (unspec:V64QI
       [(match_operand:V64QI 1 "register_operand" "q")
        (match_operand 2 "const_uimm6_operand" "")]
       UNSPEC_MXU3_BSHLI))]
 "ISA_HAS_MXU3"
 "bshli\t%w0, %w1, %2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;;BSHRI
(define_insn "mxu3_bshri"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
     (unspec:V64QI
       [(match_operand:V64QI 1 "register_operand" "q")
        (match_operand 2 "const_uimm6_operand" "")]
       UNSPEC_MXU3_BSHRI))]
 "ISA_HAS_MXU3"
 "bshri\t%w0, %w1, %2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;;BSHL
(define_insn "mxu3_bshl"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
     (unspec:V64QI
       [(match_operand:V64QI 1 "register_operand" "q")
        (match_operand:V64QI 2 "register_operand" "q")]
       UNSPEC_MXU3_BSHL))]
 "ISA_HAS_MXU3"
 "bshl\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;;BSHR
(define_insn "mxu3_bshr"
  [(set (match_operand:V64QI 0 "register_operand" "=q")
     (unspec:V64QI
       [(match_operand:V64QI 1 "register_operand" "q")
        (match_operand:V64QI 2 "register_operand" "q")]
       UNSPEC_MXU3_BSHR))]
 "ISA_HAS_MXU3"
 "bshr\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;;
;; Register Load and Misc
;;
;; mtcpuw
(define_insn "mxu3_mtcpuw"
  [(set (match_operand:SI 0 "register_operand" "=d")
	  (vec_select:SI 
            (match_operand:V1SI 1 "register_operand" "w")
            (parallel [(const_int 0)])))
   (use (reg:V16SI COP2_REG_LAST))]
  "ISA_HAS_MXU3"
  "mtcpuw\t%0,%w1"
  [(set_attr "mode"	"SI")
   (set_attr "lat_type"	"lat3")])

;; mfcpuw
(define_insn "mxu3_mfcpuw"
  [(set (match_operand:V1SI 0 "register_operand" "=w")
        (vec_duplicate:V1SI
	  (match_operand:SI 1 "register_operand" "d")))
   (use (reg:V16SI COP2_REG_LAST))]
  "ISA_HAS_MXU3"
  "mfcpuw\t%w0,%1"
  [(set_attr "mode"	"SI")
   (set_attr "lat_type"	"lat3")])

;; mtfpuw
(define_insn "mxu3_mtfpuw"
  [(set (match_operand:SF 0 "register_operand" "=f")
        (float:SF
	  (vec_select:SI 
            (match_operand:V1SI 1 "register_operand" "w")
            (parallel [(const_int 0)]))))
   (use (reg:V16SI COP2_REG_LAST))]
  "ISA_HAS_MXU3"
  "mtfpuw\t%0,%w1"
  [(set_attr "mode"	"SI")
   (set_attr "lat_type"	"lat3")])

;; mffpuw
(define_insn "mxu3_mffpuw"
  [(set (match_operand:V1SI 0 "register_operand" "=w")
        (vec_duplicate:V1SI
	  (fix:SI (match_operand:SF 1 "register_operand" "f"))))
   (use (reg:V16SI COP2_REG_LAST))]
  "ISA_HAS_MXU3"
  "mffpuw\t%w0,%1"
  [(set_attr "mode"	"SI")
   (set_attr "lat_type"	"lat3")])

(define_insn "mxu3_mfmxuw"
  [(set (match_operand:V1SI 0 "register_operand" "=w")
        (vec_select:V1SI
	  (match_operand:V16SI 1 "register_operand" "q")
          (parallel [(match_operand 2 "const_uimm4_operand" "")])))
   (use (reg:V16SI COP2_REG_LAST))]
  "ISA_HAS_MXU3"
  "movw\t$vr31[%e0],%w1[%2]"
  [(set_attr "mode"	"SI")
   (set_attr "lat_type"	"lat3")])

(define_insn "mxu3_mtmxuw_insn"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (vec_merge:V16SI
          (vec_duplicate:V16SI
	    (match_operand:V1SI 3 "register_operand" "w"))
          (match_operand:V16SI 1 "register_operand" "0")
          (match_operand 2 "const_int_operand" "")))
   (use (reg:V16SI COP2_REG_LAST))]
  "ISA_HAS_MXU3
   && mips_mxu3_1bit_select_p (operands[2], V16SImode)"
  {
    static char buf[128];
    int pos, sel = INTVAL (operands[2]);
    
    pos = -1;
    while (sel)
    {
      sel = sel >> 1;
      pos++;
    }
    snprintf (buf, sizeof(buf), "movw\t%%w0[%d],$vr31[%%e3]", pos);
    return buf;
  }
  [(set_attr "mode"	"SI")
   (set_attr "lat_type"	"lat3")])

(define_expand "mxu3_mtmxuw"
  [(match_operand:V16SI 0 "register_operand" "")
   (match_operand:V16SI 1 "register_operand" "")
   (match_operand 2 "const_uimm4_operand" "")
   (match_operand:V1SI 3 "register_operand" "")]
  "ISA_HAS_MXU3"
  {
    int idx = INTVAL (operands[2]);
    emit_insn (gen_mxu3_mtmxuw_insn (operands[0], operands[1],
                                     GEN_INT (1 << idx), operands[3]));
    DONE;
  })

;;ctcmxu/cfcmxu
(define_insn "mxu3_ctcmxu"
  [(unspec_volatile [(match_operand 0 "const_uimm5_operand" "")
		     (match_operand:SI 1 "register_operand" "d")]
		    UNSPEC_MXU3_CTCMXU)]
  "ISA_HAS_MXU3"
  "ctcmxu\t$mcs%0,%1"
  [(set_attr "mode"	"SI")
   (set_attr "lat_type"	"lat3")])

(define_insn "mxu3_cfcmxu"
  [(set (match_operand:SI 0 "register_operand" "=d")
        (unspec_volatile:SI [(match_operand 1 "const_uimm5_operand" "")]
		    UNSPEC_MXU3_CFCMXU))]
  "ISA_HAS_MXU3"
  "cfcmxu\t%0,$mcs%1"
  [(set_attr "mode"	"SI")
   (set_attr "lat_type"	"lat3")])

;; sumz
(define_expand "mxu3_sumz"
  [(set (match_operand:V16SI 0 "register_operand")
        (match_operand:SI 1 "const_uimm0_operand"))]
 "ISA_HAS_MXU3"
 {
   rtx imm_rtx;
   imm_rtx = mips_gen_const_int_vector (V16SImode, INTVAL (operands[1]));
   emit_move_insn (operands[0], imm_rtx);
   DONE;
 })

;; mfsum, ignore

;; mfsumz
(define_insn "mxu3_mfsumz_insn"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (match_operand:V16SI 1 "register_operand" "+T"))
   (set (match_dup 1)
        (match_operand:V16SI 2 "const_vector_same_uimm0_operand" ""))]
 "ISA_HAS_MXU3"
 "mfsumz\t%w0, %w1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_expand "mxu3_mfsumz"
  [(match_operand:V16SI 0 "register_operand")
   (match_operand:SI 1 "register_operand")]
 "ISA_HAS_MXU3"
 {
   rtx reg = gen_reg_rtx (V16SImode);
   rtx mem = gen_rtx_MEM (V16SImode, operands[1]);
   rtx imm_rtx;

   imm_rtx = mips_gen_const_int_vector (V16SImode, 0);
   emit_move_insn (reg, mem);
   emit_insn (gen_mxu3_mfsumz_insn (operands[0], reg, imm_rtx));
   emit_move_insn (mem, reg);

   DONE;
 })

;; mtsum, ignore

;; mxsum
(define_insn "mxu3_mxsum_insn"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (match_operand:V16SI 2 "register_operand" "+T"))
   (set (match_dup 2)
        (match_operand:V16SI 1 "register_operand" "q"))]
 "ISA_HAS_MXU3"
 "mxsum\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_expand "mxu3_mxsum"
  [(match_operand:V16SI 0 "register_operand")
   (match_operand:V16SI 1 "register_operand")
   (match_operand:SI 2 "register_operand")]
 "ISA_HAS_MXU3"
 {
   rtx reg = gen_reg_rtx (V16SImode);
   rtx mem = gen_rtx_MEM (V16SImode, operands[2]);

   emit_move_insn (reg, mem);
   emit_insn (gen_mxu3_mxsum_insn (operands[0], operands[1], reg));
   emit_move_insn (mem, reg);

   DONE;
 })

;; LI(H,W)
(define_insn "mxu3_lih_insn"
  [(set (match_operand:V32HI 0 "register_operand" "=q")
        (match_operand:V32HI 1 "const_vector_same_simm16_operand" ""))]
 "ISA_HAS_MXU3"
 "lih\t%w0, %H1"
 [(set_attr "lat_type" "lat3")])

(define_insn "mxu3_liw_insn"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (match_operand:V16SI 1 "const_vector_same_simm16_operand" ""))]
 "ISA_HAS_MXU3"
 {
   operands[1] = CONST_VECTOR_ELT (operands[1], 0);
   return "liw\t%w0, %1";
 }
 [(set_attr "lat_type" "lat3")])

(define_expand "mxu3_lih"
  [(set (match_operand:V32HI 0 "register_operand")
        (match_operand:SI    1 "const_uns_arith_operand"))]
 "ISA_HAS_MXU3"
 {
   rtx imm_rtx;
   imm_rtx = mips_gen_const_int_vector (V32HImode, INTVAL (operands[1]));
   emit_insn (gen_mxu3_lih_insn (operands[0], imm_rtx));
   DONE;
 })

(define_expand "mxu3_liw"
  [(set (match_operand:V16SI 0 "register_operand")
        (match_operand:SI    1 "const_arith_operand"))]
 "ISA_HAS_MXU3"
 {
   rtx imm_rtx;
   imm_rtx = mips_gen_const_int_vector (V16SImode, INTVAL (operands[1]));
   emit_insn (gen_mxu3_liw_insn (operands[0], imm_rtx));
   DONE;
 })

;; LIWH
(define_insn "mxu3_liwh_insn"
  [(set (match_operand:V32HI 0 "register_operand" "=q")
        (vec_merge:V32HI
          (match_operand:V32HI 1 "register_operand" "0")
          (match_operand:V32HI 2 "const_vector_same_simm16_operand" "")
          (const_int 1431655765)))]
 "ISA_HAS_MXU3"
 "liwh\t%w0, %H2"
 [(set_attr "lat_type" "lat3")])

(define_expand "mxu3_liwh"
  [(match_operand:V32HI 0 "register_operand")
   (match_operand:V32HI 1 "register_operand")
   (match_operand:SI 2 "const_uns_arith_operand")]
 "ISA_HAS_MXU3"
 {
   rtx imm_rtx;
   imm_rtx = mips_gen_const_int_vector (V32HImode, INTVAL (operands[2]));
   emit_insn (gen_mxu3_liwh_insn (operands[0], operands[1], imm_rtx));
   DONE;
 })

;; LIWR
(define_insn "mxu3_liwr"
  [(set (match_operand:V1SI 0 "register_operand" "=w")
      (unspec:V1SI
        [(match_operand:SI 1 "const_imm10_operand" "")]
        UNSPEC_MXU3_LIWR))
   (use (reg:V16SI COP2_REG_LAST))]
  "ISA_HAS_MXU3"
  "liwr\t%w0,%1"
  [(set_attr "lat_type" "lat3")])

;; CMVW
(define_insn "mxu3_cmvw"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (unspec:V16SI
          [(match_operand:V16SI 1 "register_operand" "0")
           (match_operand:V16SI 2 "register_operand" "q")
           (match_operand:V16SI 3 "register_operand" "q")
           (match_operand:SI 4 "const_uimm4_operand" "")]
          UNSPEC_MXU3_CMVW))]
 "ISA_HAS_MXU3"
 "cmvw\t%w0, %w2, %w3, %4"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; PMAP
(define_insn "mxu3_pmap<imxu3lfmt>"
  [(set (match_operand:IMXU3HS 0 "register_operand" "=q")
       (unspec:IMXU3HS
         [(match_operand:IMXU3HS 1 "register_operand" "q")
          (match_operand:IMXU3HS 2 "register_operand" "q")]
         UNSPEC_MXU3_PMAP))]
 "ISA_HAS_MXU3"
 "pmap<imxu3lfmt>\t%w0, %w1, %w2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;;
;; MXU3 Load/store peephole2
;;
(include "mips-mxu3-ls-peephole2.md")

;;
;; LU[W,D,Q,O]
;;
(define_insn "mxu3_lu<imxu3lfmt>_insn"
  [(parallel [
   (set (match_operand:IMXU3_LS 0 "register_operand" "=q")
        (vec_merge:IMXU3_LS 
          (vec_duplicate:IMXU3_LS
            (mem:<UNITMODE> 
              (match_operand:SI 3 "register_operand" "+d")))
          (match_operand:IMXU3_LS 1 "register_operand" "0")
          (match_operand:SI     2 "const_int_operand" "")))
   (set (match_dup 3) (plus:SI (match_dup 3) 
                               (match_operand:SI 4 "const_int_operand" "")))]
  )]
 "ISA_HAS_MXU3 && (INTVAL (operands[4]) == GET_MODE_SIZE (<UNITMODE>mode))"
 {
   static char buf[128];
   int pos, sel = INTVAL (operands[2]);

   pos = -1;
   while (sel)
   {
     sel = sel >> 1;
     pos++;
   }
   snprintf (buf, sizeof (buf), "lu<imxu3lfmt>\t%%w0[%d],%%z3", pos);
   return buf;
 }
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")
  (set_attr "hazard" "forbidden_slot")
  (set_attr "insn_count" "2")
  (set_attr "mxu3_type" "load_bug")])

;;
;; LA[W,D,Q,O]
;;
(define_insn "mxu3_la<imxu3lfmt>_insn"
  [(set (match_operand:IMXU3_LS 0 "register_operand" "=q")
        (vec_merge:IMXU3_LS 
          (vec_duplicate:IMXU3_LS
            (mem:<UNITMODE> 
              (plus:SI
                (match_operand:SI 3 "register_operand" "d")
                (match_operand:SI 4 "const_<unit_memoff>_operand" ""))))
          (match_operand:IMXU3_LS 1 "register_operand" "0")
          (match_operand:SI     2 "const_int_operand" "")))]
 "ISA_HAS_MXU3
  && mips_signed_immediate_p(INTVAL(operands[4]), 5, 
                             mips_ldst_scaled_shift(<UNITMODE>mode))
  && mips_mxu3_1bit_select_p (operands[2], GET_MODE(operands[0]))"
 {
   static char buf[128];
   int pos, sel = INTVAL (operands[2]);

   pos = -1;
   while (sel)
   {
     sel = sel >> 1;
     pos++;
   }
   snprintf (buf, sizeof (buf), "la<imxu3lfmt>\t%%w0[%d],%%4(%%z3)", pos);
   return buf;
 }
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")
  (set_attr "hazard" "forbidden_slot")
  (set_attr "insn_count" "2")
  (set_attr "mxu3_type" "load_bug")])

(define_expand "mxu3_la<imxu3lfmt>"
  [(match_operand:IMXU3_LS 0 "register_operand")
   (match_operand:IMXU3_LS 1 "register_operand")
   (match_operand:SI 2 "const_<elemindex>_operand")
   (match_operand:SI 3 "register_operand")
   (match_operand:SI 4 "const_imm5_operand")]
 "ISA_HAS_MXU3"
 {
    int idx = INTVAL (operands[2]);
    int msz = GET_MODE_SIZE (<UNITMODE>mode);
    int off = INTVAL (operands[4]);
    
    emit_insn (gen_mxu3_la<imxu3lfmt>_insn (operands[0], operands[1],
                                            GEN_INT (1 << idx),
                                            operands[3], GEN_INT (off * msz)));
    DONE;
 })

;;
;; SU[W,D,Q,O)
;;
(define_insn "mxu3_su<imxu3lfmt>_insn"
  [(parallel [
   (set (mem:<UNITMODE> 
          (match_operand:SI 2 "register_operand" "+d"))
        (vec_select:<UNITMODE>
          (match_operand:IMXU3_LS 0 "register_operand" "q")
          (parallel [(match_operand:SI 1 "const_<elemindex>_operand" "")])))
   (set (match_dup 2) (plus:SI (match_dup 2)
                               (match_operand:SI 3 "const_int_operand" "")))]
  )]
 "ISA_HAS_MXU3 && (INTVAL (operands[3]) == GET_MODE_SIZE (<UNITMODE>mode))"
 "su<imxu3lfmt>\t%w0[%1],%z2"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;;
;; SA[W,D,Q,O]
;;
(define_insn "mxu3_sa<imxu3lfmt>_insn"
  [(set (mem:<UNITMODE> 
          (plus:SI (match_operand:SI 2 "register_operand" "d")
                   (match_operand:SI 3 "const_<unit_memoff>_operand" "")))
        (vec_select:<UNITMODE>
           (match_operand:IMXU3_LS 0 "register_operand" "q")
           (parallel [(match_operand:SI 1 "const_<elemindex>_operand" "")])))]
 "ISA_HAS_MXU3
  && mips_signed_immediate_p(INTVAL(operands[3]), 5,
                             mips_ldst_scaled_shift(<UNITMODE>mode))"
 "sa<imxu3lfmt>\t%w0[%1],%3(%z2)"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_expand "mxu3_sa<imxu3lfmt>"
  [(match_operand:IMXU3_LS 0 "register_operand")
   (match_operand:SI 1 "const_<elemindex>_operand")
   (match_operand:SI 2 "register_operand")
   (match_operand:SI 3 "const_imm5_operand")]
 "ISA_HAS_MXU3"
 {
    int msz = GET_MODE_SIZE (<UNITMODE>mode);
    int off = INTVAL (operands[3]);

    emit_insn (gen_mxu3_sa<imxu3lfmt>_insn (operands[0], operands[1], operands[2],
                                            GEN_INT (off * msz)));
    DONE;
 })

;;
;; LOAD SCATTER  LAW/LUW LAD/LUD LAQ/LUQ LAO/LUO 
;;
(define_int_iterator LOAD_SCATTER_SI_UNS 
  [UNSPEC_MXU3_LAW2B
   UNSPEC_MXU3_LAW2H
   UNSPEC_MXU3_LAW4B
   UNSPEC_MXU3_LAW4H
   UNSPEC_MXU3_LAW8B
   UNSPEC_MXU3_LAW8H
   UNSPEC_MXU3_LAW16B
   UNSPEC_MXU3_LAW16H])

(define_int_iterator LOAD_SCATTER_DI_UNS 
  [UNSPEC_MXU3_LAD2B
   UNSPEC_MXU3_LAD2H
   UNSPEC_MXU3_LAD2W
   UNSPEC_MXU3_LAD4B
   UNSPEC_MXU3_LAD4H
   UNSPEC_MXU3_LAD4W
   UNSPEC_MXU3_LAD8B
   UNSPEC_MXU3_LAD8H
   UNSPEC_MXU3_LAD8W])

(define_int_iterator LOAD_SCATTER_TI_UNS 
  [UNSPEC_MXU3_LAQ2B
   UNSPEC_MXU3_LAQ2H
   UNSPEC_MXU3_LAQ2W
   UNSPEC_MXU3_LAQ2D
   UNSPEC_MXU3_LAQ4B
   UNSPEC_MXU3_LAQ4H
   UNSPEC_MXU3_LAQ4W
   UNSPEC_MXU3_LAQ4D])

(define_int_iterator LOAD_SCATTER_OI_UNS 
  [UNSPEC_MXU3_LAO2B
   UNSPEC_MXU3_LAO2H
   UNSPEC_MXU3_LAO2W
   UNSPEC_MXU3_LAO2D
   UNSPEC_MXU3_LAO2Q])

(define_int_attr load_scatter_si_fmt
  [(UNSPEC_MXU3_LAW2B   "w2b")
   (UNSPEC_MXU3_LAW2H   "w2h")
   (UNSPEC_MXU3_LAW4B   "w4b")
   (UNSPEC_MXU3_LAW4H   "w4h")
   (UNSPEC_MXU3_LAW8B   "w8b")
   (UNSPEC_MXU3_LAW8H   "w8h")
   (UNSPEC_MXU3_LAW16B  "w16b")
   (UNSPEC_MXU3_LAW16H  "w16h")])

(define_int_attr load_scatter_di_fmt
  [(UNSPEC_MXU3_LAD2B   "d2b")
   (UNSPEC_MXU3_LAD2H   "d2h")
   (UNSPEC_MXU3_LAD2W   "d2w")
   (UNSPEC_MXU3_LAD4B   "d4b")
   (UNSPEC_MXU3_LAD4H   "d4h")
   (UNSPEC_MXU3_LAD4W   "d4w")
   (UNSPEC_MXU3_LAD8B   "d8b")
   (UNSPEC_MXU3_LAD8H   "d8h")
   (UNSPEC_MXU3_LAD8W   "d8w")])

(define_int_attr load_scatter_ti_fmt
  [(UNSPEC_MXU3_LAQ2B   "q2b")
   (UNSPEC_MXU3_LAQ2H   "q2h")
   (UNSPEC_MXU3_LAQ2W   "q2w")
   (UNSPEC_MXU3_LAQ2D   "q2d")
   (UNSPEC_MXU3_LAQ4B   "q4b")
   (UNSPEC_MXU3_LAQ4H   "q4h")
   (UNSPEC_MXU3_LAQ4W   "q4w")
   (UNSPEC_MXU3_LAQ4D   "q4d")])

(define_int_attr load_scatter_oi_fmt
  [(UNSPEC_MXU3_LAO2B   "o2b")
   (UNSPEC_MXU3_LAO2H   "o2h")
   (UNSPEC_MXU3_LAO2W   "o2w")
   (UNSPEC_MXU3_LAO2D   "o2d")
   (UNSPEC_MXU3_LAO2Q   "o2q")])

(define_int_attr load_scatter_si_n
  [(UNSPEC_MXU3_LAW2B   "uimm4")
   (UNSPEC_MXU3_LAW2H   "uimm4")
   (UNSPEC_MXU3_LAW4B   "uimm3")
   (UNSPEC_MXU3_LAW4H   "uimm3")
   (UNSPEC_MXU3_LAW8B   "uimm2")
   (UNSPEC_MXU3_LAW8H   "uimm2")
   (UNSPEC_MXU3_LAW16B  "uimm1")
   (UNSPEC_MXU3_LAW16H  "uimm1")])

(define_int_attr load_scatter_di_n
  [(UNSPEC_MXU3_LAD2B   "uimm3")
   (UNSPEC_MXU3_LAD2H   "uimm3")
   (UNSPEC_MXU3_LAD2W   "uimm3")
   (UNSPEC_MXU3_LAD4B   "uimm2")
   (UNSPEC_MXU3_LAD4H   "uimm2")
   (UNSPEC_MXU3_LAD4W   "uimm2")
   (UNSPEC_MXU3_LAD8B   "uimm1")
   (UNSPEC_MXU3_LAD8H   "uimm1")
   (UNSPEC_MXU3_LAD8W   "uimm1")])

(define_int_attr load_scatter_ti_n
  [(UNSPEC_MXU3_LAQ2B   "uimm2")
   (UNSPEC_MXU3_LAQ2H   "uimm2")
   (UNSPEC_MXU3_LAQ2W   "uimm2")
   (UNSPEC_MXU3_LAQ2D   "uimm2")
   (UNSPEC_MXU3_LAQ4B   "uimm1")
   (UNSPEC_MXU3_LAQ4H   "uimm1")
   (UNSPEC_MXU3_LAQ4W   "uimm1")
   (UNSPEC_MXU3_LAQ4D   "uimm1")])

(define_int_attr load_scatter_oi_n
  [(UNSPEC_MXU3_LAO2B   "uimm1")
   (UNSPEC_MXU3_LAO2H   "uimm1")
   (UNSPEC_MXU3_LAO2W   "uimm1")
   (UNSPEC_MXU3_LAO2D   "uimm1")
   (UNSPEC_MXU3_LAO2Q   "uimm1")])

(define_int_attr load_scatter_si_p
  [(UNSPEC_MXU3_LAW2B   "uimm1")
   (UNSPEC_MXU3_LAW2H   "uimm1")
   (UNSPEC_MXU3_LAW4B   "uimm2")
   (UNSPEC_MXU3_LAW4H   "uimm2")
   (UNSPEC_MXU3_LAW8B   "uimm3")
   (UNSPEC_MXU3_LAW8H   "uimm3")
   (UNSPEC_MXU3_LAW16B  "uimm4")
   (UNSPEC_MXU3_LAW16H  "uimm4")])

(define_int_attr load_scatter_di_p
  [(UNSPEC_MXU3_LAD2B   "uimm1")
   (UNSPEC_MXU3_LAD2H   "uimm1")
   (UNSPEC_MXU3_LAD2W   "uimm1")
   (UNSPEC_MXU3_LAD4B   "uimm2")
   (UNSPEC_MXU3_LAD4H   "uimm2")
   (UNSPEC_MXU3_LAD4W   "uimm2")
   (UNSPEC_MXU3_LAD8B   "uimm3")
   (UNSPEC_MXU3_LAD8H   "uimm3")
   (UNSPEC_MXU3_LAD8W   "uimm3")])

(define_int_attr load_scatter_ti_p
  [(UNSPEC_MXU3_LAQ2B   "uimm1")
   (UNSPEC_MXU3_LAQ2H   "uimm1")
   (UNSPEC_MXU3_LAQ2W   "uimm1")
   (UNSPEC_MXU3_LAQ2D   "uimm1")
   (UNSPEC_MXU3_LAQ4B   "uimm2")
   (UNSPEC_MXU3_LAQ4H   "uimm2")
   (UNSPEC_MXU3_LAQ4W   "uimm2")
   (UNSPEC_MXU3_LAQ4D   "uimm2")])

(define_int_attr load_scatter_oi_p
  [(UNSPEC_MXU3_LAO2B   "uimm1")
   (UNSPEC_MXU3_LAO2H   "uimm1")
   (UNSPEC_MXU3_LAO2W   "uimm1")
   (UNSPEC_MXU3_LAO2D   "uimm1")
   (UNSPEC_MXU3_LAO2Q   "uimm1")])

(define_insn "mxu3_la<load_scatter_si_fmt>"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (unspec:V16SI
          [(match_operand:V16SI 1 "register_operand" "0")
           (match_operand:SI 2 "const_<load_scatter_si_n>_operand" "")
           (match_operand:SI 3 "const_<load_scatter_si_p>_operand" "")
           (mem:SI (match_operand:SI 4 "register_operand" "d"))]
           LOAD_SCATTER_SI_UNS))]
 "ISA_HAS_MXU3"
 "la<load_scatter_si_fmt>\t%w0[%2],%3,%z4"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")
  (set_attr "hazard" "forbidden_slot")
  (set_attr "insn_count" "2")
  (set_attr "mxu3_type" "load_bug")])

(define_insn "mxu3_la<load_scatter_di_fmt>"
  [(set (match_operand:V8DI 0 "register_operand" "=q")
        (unspec:V8DI
          [(match_operand:V8DI 1 "register_operand" "0")
           (match_operand:SI 2 "const_<load_scatter_di_n>_operand" "")
           (match_operand:SI 3 "const_<load_scatter_di_p>_operand" "")
           (mem:DI (match_operand:SI 4 "register_operand" "d"))]
           LOAD_SCATTER_DI_UNS))]
 "ISA_HAS_MXU3"
 "la<load_scatter_di_fmt>\t%w0[%2],%3,%z4"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")
  (set_attr "hazard" "forbidden_slot")
  (set_attr "insn_count" "2")
  (set_attr "mxu3_type" "load_bug")])

(define_insn "mxu3_la<load_scatter_ti_fmt>"
  [(set (match_operand:V4TI 0 "register_operand" "=q")
        (unspec:V4TI
          [(match_operand:V4TI 1 "register_operand" "0")
           (match_operand:SI 2 "const_<load_scatter_ti_n>_operand" "")
           (match_operand:SI 3 "const_<load_scatter_ti_p>_operand" "")
           (mem:TI (match_operand:SI 4 "register_operand" "d"))]
           LOAD_SCATTER_TI_UNS))]
 "ISA_HAS_MXU3"
 "la<load_scatter_ti_fmt>\t%w0[%2],%3,%z4"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")
  (set_attr "mxu3_type" "load_bug")])

(define_insn "mxu3_la<load_scatter_oi_fmt>"
  [(set (match_operand:V2OI 0 "register_operand" "=q")
        (unspec:V2OI
          [(match_operand:V2OI 1 "register_operand" "0")
           (match_operand:SI 2 "const_<load_scatter_oi_n>_operand" "")
           (match_operand:SI 3 "const_<load_scatter_oi_p>_operand" "")
           (mem:OI (match_operand:SI 4 "register_operand" "d"))]
           LOAD_SCATTER_OI_UNS))]
 "ISA_HAS_MXU3"
 "la<load_scatter_oi_fmt>\t%w0[%2],%3,%z4"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")
  (set_attr "mxu3_type" "load_bug")])

;;
;; STORE GATHER SAD/SUD SAQ/SUQ SAO/SUO
;;
(define_int_iterator STORE_GATHER_DI_UNS 
  [UNSPEC_MXU3_SAD2W
   UNSPEC_MXU3_SAD4W
   UNSPEC_MXU3_SAD8W])

(define_int_iterator STORE_GATHER_TI_UNS 
  [UNSPEC_MXU3_SAQ2W
   UNSPEC_MXU3_SAQ2D
   UNSPEC_MXU3_SAQ4W
   UNSPEC_MXU3_SAQ4D])

(define_int_iterator STORE_GATHER_OI_UNS 
  [UNSPEC_MXU3_SAO2W
   UNSPEC_MXU3_SAO2D
   UNSPEC_MXU3_SAO2Q])

(define_int_attr store_gather_di_fmt 
  [(UNSPEC_MXU3_SAD2W "d2w")
   (UNSPEC_MXU3_SAD4W "d4w")
   (UNSPEC_MXU3_SAD8W "d8w")])

(define_int_attr store_gather_ti_fmt
  [(UNSPEC_MXU3_SAQ2W "q2w")
   (UNSPEC_MXU3_SAQ2D "q2d")
   (UNSPEC_MXU3_SAQ4W "q4w")
   (UNSPEC_MXU3_SAQ4D "q4d")])

(define_int_attr store_gather_oi_fmt 
  [(UNSPEC_MXU3_SAO2W "o2w")
   (UNSPEC_MXU3_SAO2D "o2d")
   (UNSPEC_MXU3_SAO2Q "o2q")])

(define_int_attr store_gather_di_n 
  [(UNSPEC_MXU3_SAD2W "uimm3")
   (UNSPEC_MXU3_SAD4W "uimm2")
   (UNSPEC_MXU3_SAD8W "uimm1")])

(define_int_attr store_gather_ti_n
  [(UNSPEC_MXU3_SAQ2W "uimm2")
   (UNSPEC_MXU3_SAQ2D "uimm2")
   (UNSPEC_MXU3_SAQ4W "uimm1")
   (UNSPEC_MXU3_SAQ4D "uimm1")])

(define_int_attr store_gather_oi_n
  [(UNSPEC_MXU3_SAO2W "uimm1")
   (UNSPEC_MXU3_SAO2D "uimm1")
   (UNSPEC_MXU3_SAO2Q "uimm1")])

(define_int_attr store_gather_di_p 
  [(UNSPEC_MXU3_SAD2W "uimm1")
   (UNSPEC_MXU3_SAD4W "uimm2")
   (UNSPEC_MXU3_SAD8W "uimm3")])

(define_int_attr store_gather_ti_p
  [(UNSPEC_MXU3_SAQ2W "uimm1")
   (UNSPEC_MXU3_SAQ2D "uimm1")
   (UNSPEC_MXU3_SAQ4W "uimm2")
   (UNSPEC_MXU3_SAQ4D "uimm2")])

(define_int_attr store_gather_oi_p
  [(UNSPEC_MXU3_SAO2W "uimm1")
   (UNSPEC_MXU3_SAO2D "uimm1")
   (UNSPEC_MXU3_SAO2Q "uimm1")])

(define_insn "mxu3_sa<store_gather_di_fmt>"
  [(set (mem:DI (match_operand:SI 3 "register_operand" "d"))
        (unspec:DI
          [(match_operand:V8DI 0 "register_operand" "q")
           (match_operand:SI 1 "const_<store_gather_di_n>_operand" "")
           (match_operand:SI 2 "const_<store_gather_di_p>_operand" "")]
           STORE_GATHER_DI_UNS))]
 "ISA_HAS_MXU3"
 "sa<store_gather_di_fmt>\t%w0[%1],%2,%z3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_insn "mxu3_sa<store_gather_ti_fmt>"
  [(set (mem:TI (match_operand:SI 3 "register_operand" "d"))
        (unspec:TI
          [(match_operand:V4TI 0 "register_operand" "q")
           (match_operand:SI 1 "const_<store_gather_ti_n>_operand" "")
           (match_operand:SI 2 "const_<store_gather_ti_p>_operand" "")]
           STORE_GATHER_TI_UNS))]
 "ISA_HAS_MXU3"
 "sa<store_gather_ti_fmt>\t%w0[%1],%2,%z3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

(define_insn "mxu3_sa<store_gather_oi_fmt>"
  [(set (mem:OI (match_operand:SI 3 "register_operand" "d"))
        (unspec:OI
          [(match_operand:V2OI 0 "register_operand" "q")
           (match_operand:SI 1 "const_<store_gather_oi_n>_operand" "")
           (match_operand:SI 2 "const_<store_gather_oi_p>_operand" "")]
           STORE_GATHER_OI_UNS))]
 "ISA_HAS_MXU3"
 "sa<store_gather_oi_fmt>\t%w0[%1],%2,%z3"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;;
;; NNA insns
;;
;; NNRWR
(define_insn "mxu3_nnrwr"
  [(unspec_volatile [(match_operand:V1SI 0 "register_operand" "w")
            (match_operand:SI   1 "const_uimm10_operand" "")]
           UNSPEC_MXU3_NNRWR)
   (use (reg:V16SI COP2_REG_LAST))]
 "ISA_HAS_MXU3"
 "nnrwr\t%w0,%1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; NNRRD
(define_insn "mxu3_nnrrd"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
     (unspec_volatile:V16SI 
       [(match_operand:SI 1 "const_uimm10_operand" "")]
       UNSPEC_MXU3_NNRRD))]
 "ISA_HAS_MXU3"
 "nnrrd\t%w0,%1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; NNDWR
(define_insn "mxu3_nndwr"
  [(unspec_volatile
       [(match_operand:V16SI 0 "register_operand" "q")
        (match_operand:SI 1 "const_uimm10_operand" "")]
       UNSPEC_MXU3_NNDWR)]
 "ISA_HAS_MXU3"
 "nndwr\t%w0,%1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; NNDRD
(define_insn "mxu3_nndrd"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
     (unspec_volatile:V16SI 
       [(match_operand:SI 1 "const_uimm10_operand" "")]
       UNSPEC_MXU3_NNDRD))]
 "ISA_HAS_MXU3"
 "nndrd\t%w0,%1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; NNDCMD
(define_insn "mxu3_nncmd"
  [(unspec_volatile [(match_operand:SI 0 "const_uimm15_operand" "")]
           UNSPEC_MXU3_NNCMD)]
 "ISA_HAS_MXU3"
 "nncmd\t%0"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; NNMAC 
(define_insn "mxu3_nnmac"
  [(unspec_volatile [(match_operand:V1SI 0 "register_operand" "w")
            (match_operand:SI   1 "const_uimm10_operand" "")]
           UNSPEC_MXU3_NNMAC)
   (use (reg:V16SI COP2_REG_LAST))]
 "ISA_HAS_MXU3"
 "nnmac\t%w0,%1"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")])

;; FXAS<Lseg>W
(define_int_iterator FXAS_UNS 
  [UNSPEC_MXU3_FXAS1W
   UNSPEC_MXU3_FXAS2W
   UNSPEC_MXU3_FXAS4W
   UNSPEC_MXU3_FXAS8W])

(define_int_attr fxas
  [(UNSPEC_MXU3_FXAS1W  "1")
   (UNSPEC_MXU3_FXAS2W  "2")
   (UNSPEC_MXU3_FXAS4W  "4")
   (UNSPEC_MXU3_FXAS8W  "8")])

(define_insn "mxu3_fxas<fxas>w"
  [(set (match_operand:V16SF 0 "register_operand" "=q")
  (unspec:V16SF
    [(match_operand:V16SF 1 "register_operand" "q")]
     FXAS_UNS))]
  "ISA_HAS_MXU3"
  "fxas<fxas>w\t%w0,%w1"
  [(set_attr "mode" "TI")
   (set_attr "lat_type" "lat3")])

;; Handle the triple or quadruple values return cases for MXU3-EXT-ABI.
;; See comment for call_internal.
(define_insn_and_split "call_value_triple_internal"
  [(set (match_operand 0 "register_operand" "")
        (call (mem:SI (match_operand 1 "call_insn_operand" "c,S"))
              (match_operand 2 "" "")))
   (set (match_operand 3 "register_operand" "")
  (call (mem:SI (match_dup 1))
        (match_dup 2)))
   (set (match_operand 4 "register_operand" "")
  (call (mem:SI (match_dup 1))
        (match_dup 2)))
  (clobber (reg:SI RETURN_ADDR_REGNUM))]
  ""
  {
    return (TARGET_SPLIT_CALLS ? "#"
      : mips_output_jump (operands, 1, 2, true));
  }
  "reload_completed && TARGET_SPLIT_CALLS && TARGET_MXU3_EXT_ABI"
  [(const_int 0)]
{
  mips_split_call (curr_insn,
    gen_call_value_triple_split (operands[0], operands[1],
      operands[2], operands[3], operands[4]));
  DONE;
}
  [(set_attr "jal" "indirect,direct")])

(define_insn "call_value_triple_split"
  [(set (match_operand 0 "register_operand" "")
        (call (mem:SI (match_operand 1 "call_insn_operand" "c,S"))
              (match_operand 2 "" "")))
   (set (match_operand 3 "register_operand" "")
  (call (mem:SI (match_dup 1))
        (match_dup 2)))
   (set (match_operand 4 "register_operand" "")
  (call (mem:SI (match_dup 1))
        (match_dup 2)))
    (clobber (reg:SI RETURN_ADDR_REGNUM))
    (clobber (reg:SI 28))]
  "TARGET_SPLIT_CALLS"
  { return mips_output_jump (operands, 1, 2, true); }
  [(set_attr "jal" "indirect,direct")
   (set_attr "jal_macro" "no")])

(define_insn_and_split "call_value_quadruple_internal"
  [(set (match_operand 0 "register_operand" "")
        (call (mem:SI (match_operand 1 "call_insn_operand" "c,S"))
              (match_operand 2 "" "")))
   (set (match_operand 3 "register_operand" "")
  (call (mem:SI (match_dup 1))
        (match_dup 2)))
   (set (match_operand 4 "register_operand" "")
  (call (mem:SI (match_dup 1))
        (match_dup 2)))
   (set (match_operand 5 "register_operand" "")
  (call (mem:SI (match_dup 1))
        (match_dup 2)))
  (clobber (reg:SI RETURN_ADDR_REGNUM))]
  ""
  {
    return (TARGET_SPLIT_CALLS ? "#"
      : mips_output_jump (operands, 1, 2, true));
  }
  "reload_completed && TARGET_SPLIT_CALLS && TARGET_MXU3_EXT_ABI"
  [(const_int 0)]
{
  mips_split_call (curr_insn,
    gen_call_value_quadruple_split (operands[0], operands[1],
      operands[2], operands[3], operands[4], operands[5]));
  DONE;
}
  [(set_attr "jal" "indirect,direct")])

(define_insn "call_value_quadruple_split"
  [(set (match_operand 0 "register_operand" "")
        (call (mem:SI (match_operand 1 "call_insn_operand" "c,S"))
              (match_operand 2 "" "")))
   (set (match_operand 3 "register_operand" "")
  (call (mem:SI (match_dup 1))
        (match_dup 2)))
   (set (match_operand 4 "register_operand" "")
  (call (mem:SI (match_dup 1))
        (match_dup 2)))
   (set (match_operand 5 "register_operand" "")
  (call (mem:SI (match_dup 1))
        (match_dup 2)))
    (clobber (reg:SI RETURN_ADDR_REGNUM))
    (clobber (reg:SI 28))]
  "TARGET_SPLIT_CALLS"
  { return mips_output_jump (operands, 1, 2, true); }
  [(set_attr "jal" "indirect,direct")
   (set_attr "jal_macro" "no")])

(define_insn "sibcall_value_triple_internal"
  [(set (match_operand 0 "register_operand" "")
        (call (mem:SI (match_operand 1 "call_insn_operand" "j,S"))
              (match_operand 2 "" "")))
   (set (match_operand 3 "register_operand" "")
	(call (mem:SI (match_dup 1))
	      (match_dup 2)))
   (set (match_operand 4 "register_operand" "")
	(call (mem:SI (match_dup 1))
	      (match_dup 2)))]
  "TARGET_MXU3_EXT_ABI && TARGET_SIBCALLS && SIBLING_CALL_P (insn)"
  { return mips_output_jump (operands, 1, 2, false); }
  [(set_attr "jal" "indirect,direct")
   (set_attr "jal_macro" "no")])

(define_insn "sibcall_value_quadruple_internal"
  [(set (match_operand 0 "register_operand" "")
        (call (mem:SI (match_operand 1 "call_insn_operand" "j,S"))
              (match_operand 2 "" "")))
   (set (match_operand 3 "register_operand" "")
	(call (mem:SI (match_dup 1))
	      (match_dup 2)))
   (set (match_operand 4 "register_operand" "")
	(call (mem:SI (match_dup 1))
	      (match_dup 2)))
   (set (match_operand 5 "register_operand" "")
	(call (mem:SI (match_dup 1))
	      (match_dup 2)))]
  "TARGET_MXU3_EXT_ABI && TARGET_SIBCALLS && SIBLING_CALL_P (insn)"
  { return mips_output_jump (operands, 1, 2, false); }
  [(set_attr "jal" "indirect,direct")
   (set_attr "jal_macro" "no")])

;; Fix bug for T40/A1
(include "mips-mxu3-fix-bug-for-a1.md")
