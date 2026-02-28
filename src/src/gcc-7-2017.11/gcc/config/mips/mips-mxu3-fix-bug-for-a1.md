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

(define_attr "mxu3_type"
  "unknown, load_sync, load_bug"
  (const_string "unknown"))

(define_mode_iterator IMXU3_BUG_LS  [V8DI V16SI])

;;
;; LU[W,D]
;;
(define_insn "mxu3_lu<imxu3lfmt>_pre_sync_insn"
  [(parallel [
   (set (match_operand:IMXU3_BUG_LS 0 "register_operand" "=q")
        (unspec:IMXU3_BUG_LS
          [(match_operand:SI 3 "register_operand" "+d")
           (match_operand:IMXU3_BUG_LS 1 "register_operand" "0")
           (match_operand:SI 2 "const_int_operand" "")]
           UNSPEC_MXU3_LOAD_UPDATE_PRE_SYNC))
   (set (match_dup 3) (plus:SI (match_dup 3) 
                               (match_operand:SI 4 "const_int_operand" "")))]
  )]
 "ISA_HAS_MXU3 && (INTVAL (operands[4]) == GET_MODE_SIZE (<UNITMODE>mode))"
 {
   int elt = ffs ((int) INTVAL (operands[2])) - 1;
   operands[2] = GEN_INT (elt);

   return "sync\n\tlu<imxu3lfmt>\t%w0[%2],%z3";
 }
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")
  (set_attr "hazard" "forbidden_slot")
  (set_attr "insn_count" "2")
  (set_attr "mxu3_type" "load_sync")])

(define_split
  [(parallel [
   (set (match_operand:IMXU3_BUG_LS 0 "register_operand")
        (vec_merge:IMXU3_BUG_LS 
          (vec_duplicate:IMXU3_BUG_LS
            (mem:<UNITMODE> 
              (match_operand:SI 2 "register_operand")))
          (match_dup 0)
          (match_operand:SI     1 "const_int_operand")))
   (set (match_dup 2) (plus:SI (match_dup 2) 
                               (match_operand:SI 3 "const_int_operand")))]
  )]
 "ISA_HAS_MXU3 && mips_mxu3_fix_bug_for_a1_split_p (insn)"
 [(parallel [
   (set (match_dup 0)
        (unspec:IMXU3_BUG_LS
          [(match_dup 2)
           (match_dup 0)
           (match_dup 1)]
           UNSPEC_MXU3_LOAD_UPDATE_PRE_SYNC))
   (set (match_dup 2) (plus:SI (match_dup 2) 
                               (match_operand:SI 3 "const_int_operand" "")))]
  )])

;;
;; LA[W,D]
;;
(define_insn "*mxu3_la<imxu3lfmt>_pre_sync_insn"
  [(set (match_operand:IMXU3_BUG_LS 0 "register_operand" "=q")
        (unspec:IMXU3_BUG_LS
          [(match_operand:SI 3 "register_operand" "d")
           (match_operand:SI 4 "const_<unit_memoff>_operand" "")
           (match_operand:IMXU3_BUG_LS 1 "register_operand" "0")
           (match_operand:SI 2 "const_int_operand" "")]
           UNSPEC_MXU3_LOAD_PRE_SYNC))]
 "ISA_HAS_MXU3"
 {
   int elt = ffs ((int) INTVAL (operands[2])) - 1;
   operands[2] = GEN_INT (elt);

   return "sync\n\tla<imxu3lfmt>\t%w0[%2],%4(%z3)";
 }
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")
  (set_attr "hazard" "forbidden_slot")
  (set_attr "insn_count" "2")
  (set_attr "mxu3_type" "load_sync")])

(define_split
  [(set (match_operand:IMXU3_BUG_LS 0 "register_operand")
        (vec_merge:IMXU3_BUG_LS 
          (vec_duplicate:IMXU3_BUG_LS
            (mem:<UNITMODE> 
              (plus:SI
                (match_operand:SI 2 "register_operand")
                (match_operand:SI 3 "const_<unit_memoff>_operand"))))
          (match_dup 0)
          (match_operand:SI 1 "const_int_operand")))]
  "ISA_HAS_MXU3 && mips_mxu3_fix_bug_for_a1_split_p (insn)"
  [(set (match_dup 0)
        (unspec:IMXU3_BUG_LS
          [(match_dup 2)
           (match_dup 3)
           (match_dup 0)
           (match_dup 1)]
           UNSPEC_MXU3_LOAD_PRE_SYNC))])

;;
;; LOAD SCATTER  LAW LAD
;;
(define_int_iterator LOAD_SCATTER_SI_PRE_SYNC_UNS 
  [UNSPEC_MXU3_LAW2B_PRE_SYNC
   UNSPEC_MXU3_LAW2H_PRE_SYNC
   UNSPEC_MXU3_LAW4B_PRE_SYNC
   UNSPEC_MXU3_LAW4H_PRE_SYNC
   UNSPEC_MXU3_LAW8B_PRE_SYNC
   UNSPEC_MXU3_LAW8H_PRE_SYNC
   UNSPEC_MXU3_LAW16B_PRE_SYNC
   UNSPEC_MXU3_LAW16H_PRE_SYNC])

(define_int_iterator LOAD_SCATTER_DI_PRE_SYNC_UNS 
  [UNSPEC_MXU3_LAD2B_PRE_SYNC
   UNSPEC_MXU3_LAD2H_PRE_SYNC
   UNSPEC_MXU3_LAD2W_PRE_SYNC
   UNSPEC_MXU3_LAD4B_PRE_SYNC
   UNSPEC_MXU3_LAD4H_PRE_SYNC
   UNSPEC_MXU3_LAD4W_PRE_SYNC
   UNSPEC_MXU3_LAD8B_PRE_SYNC
   UNSPEC_MXU3_LAD8H_PRE_SYNC
   UNSPEC_MXU3_LAD8W_PRE_SYNC])

(define_int_attr load_scatter_si_pre_sync_fmt
  [(UNSPEC_MXU3_LAW2B_PRE_SYNC   "w2b")
   (UNSPEC_MXU3_LAW2H_PRE_SYNC   "w2h")
   (UNSPEC_MXU3_LAW4B_PRE_SYNC   "w4b")
   (UNSPEC_MXU3_LAW4H_PRE_SYNC   "w4h")
   (UNSPEC_MXU3_LAW8B_PRE_SYNC   "w8b")
   (UNSPEC_MXU3_LAW8H_PRE_SYNC   "w8h")
   (UNSPEC_MXU3_LAW16B_PRE_SYNC  "w16b")
   (UNSPEC_MXU3_LAW16H_PRE_SYNC  "w16h")])

(define_int_attr load_scatter_di_pre_sync_fmt
  [(UNSPEC_MXU3_LAD2B_PRE_SYNC   "d2b")
   (UNSPEC_MXU3_LAD2H_PRE_SYNC   "d2h")
   (UNSPEC_MXU3_LAD2W_PRE_SYNC   "d2w")
   (UNSPEC_MXU3_LAD4B_PRE_SYNC   "d4b")
   (UNSPEC_MXU3_LAD4H_PRE_SYNC   "d4h")
   (UNSPEC_MXU3_LAD4W_PRE_SYNC   "d4w")
   (UNSPEC_MXU3_LAD8B_PRE_SYNC   "d8b")
   (UNSPEC_MXU3_LAD8H_PRE_SYNC   "d8h")
   (UNSPEC_MXU3_LAD8W_PRE_SYNC   "d8w")])

(define_int_attr load_scatter_si_pre_sync_n
  [(UNSPEC_MXU3_LAW2B_PRE_SYNC   "uimm4")
   (UNSPEC_MXU3_LAW2H_PRE_SYNC   "uimm4")
   (UNSPEC_MXU3_LAW4B_PRE_SYNC   "uimm3")
   (UNSPEC_MXU3_LAW4H_PRE_SYNC   "uimm3")
   (UNSPEC_MXU3_LAW8B_PRE_SYNC   "uimm2")
   (UNSPEC_MXU3_LAW8H_PRE_SYNC   "uimm2")
   (UNSPEC_MXU3_LAW16B_PRE_SYNC  "uimm1")
   (UNSPEC_MXU3_LAW16H_PRE_SYNC  "uimm1")])

(define_int_attr load_scatter_di_pre_sync_n
  [(UNSPEC_MXU3_LAD2B_PRE_SYNC   "uimm3")
   (UNSPEC_MXU3_LAD2H_PRE_SYNC   "uimm3")
   (UNSPEC_MXU3_LAD2W_PRE_SYNC   "uimm3")
   (UNSPEC_MXU3_LAD4B_PRE_SYNC   "uimm2")
   (UNSPEC_MXU3_LAD4H_PRE_SYNC   "uimm2")
   (UNSPEC_MXU3_LAD4W_PRE_SYNC   "uimm2")
   (UNSPEC_MXU3_LAD8B_PRE_SYNC   "uimm1")
   (UNSPEC_MXU3_LAD8H_PRE_SYNC   "uimm1")
   (UNSPEC_MXU3_LAD8W_PRE_SYNC   "uimm1")])

(define_int_attr load_scatter_si_pre_sync_p
  [(UNSPEC_MXU3_LAW2B_PRE_SYNC   "uimm1")
   (UNSPEC_MXU3_LAW2H_PRE_SYNC   "uimm1")
   (UNSPEC_MXU3_LAW4B_PRE_SYNC   "uimm2")
   (UNSPEC_MXU3_LAW4H_PRE_SYNC   "uimm2")
   (UNSPEC_MXU3_LAW8B_PRE_SYNC   "uimm3")
   (UNSPEC_MXU3_LAW8H_PRE_SYNC   "uimm3")
   (UNSPEC_MXU3_LAW16B_PRE_SYNC  "uimm4")
   (UNSPEC_MXU3_LAW16H_PRE_SYNC  "uimm4")])

(define_int_attr load_scatter_di_pre_sync_p
  [(UNSPEC_MXU3_LAD2B_PRE_SYNC   "uimm1")
   (UNSPEC_MXU3_LAD2H_PRE_SYNC   "uimm1")
   (UNSPEC_MXU3_LAD2W_PRE_SYNC   "uimm1")
   (UNSPEC_MXU3_LAD4B_PRE_SYNC   "uimm2")
   (UNSPEC_MXU3_LAD4H_PRE_SYNC   "uimm2")
   (UNSPEC_MXU3_LAD4W_PRE_SYNC   "uimm2")
   (UNSPEC_MXU3_LAD8B_PRE_SYNC   "uimm3")
   (UNSPEC_MXU3_LAD8H_PRE_SYNC   "uimm3")
   (UNSPEC_MXU3_LAD8W_PRE_SYNC   "uimm3")])

(define_insn "mxu3_la<load_scatter_si_pre_sync_fmt>_pre_sync"
  [(set (match_operand:V16SI 0 "register_operand" "=q")
        (unspec:V16SI
          [(match_operand:V16SI 1 "register_operand" "0")
           (match_operand:SI 2 "const_<load_scatter_si_pre_sync_n>_operand" "")
           (match_operand:SI 3 "const_<load_scatter_si_pre_sync_p>_operand" "")
           (mem:SI (match_operand:SI 4 "register_operand" "d"))]
           LOAD_SCATTER_SI_PRE_SYNC_UNS))]
 "ISA_HAS_MXU3"
 "sync\n\tla<load_scatter_si_pre_sync_fmt>\t%w0[%2],%3,%z4"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")
  (set_attr "hazard" "forbidden_slot")
  (set_attr "insn_count" "2")
  (set_attr "mxu3_type" "load_sync")])

(define_split
  [(set (match_operand:V16SI 0 "register_operand")
        (unspec:V16SI
          [(match_dup 0)
           (match_operand:SI 1 "const_<load_scatter_si_n>_operand")
           (match_operand:SI 2 "const_<load_scatter_si_p>_operand")
           (mem:SI (match_operand:SI 3 "register_operand"))]
           LOAD_SCATTER_SI_UNS))]
 "ISA_HAS_MXU3 && mips_mxu3_fix_bug_for_a1_split_p (insn)"
 [(set (match_operand:V16SI 0 "register_operand")
        (unspec:V16SI
          [(match_dup 0)
           (match_operand:SI 1 "const_<load_scatter_si_pre_sync_n>_operand")
           (match_operand:SI 2 "const_<load_scatter_si_pre_sync_p>_operand")
           (mem:SI (match_operand:SI 3 "register_operand"))]
           LOAD_SCATTER_SI_PRE_SYNC_UNS))])

(define_insn "mxu3_la<load_scatter_di_pre_sync_fmt>_pre_sync"
  [(set (match_operand:V8DI 0 "register_operand" "=q")
        (unspec:V8DI
          [(match_operand:V8DI 1 "register_operand" "0")
           (match_operand:SI 2 "const_<load_scatter_di_pre_sync_n>_operand" "")
           (match_operand:SI 3 "const_<load_scatter_di_pre_sync_p>_operand" "")
           (mem:DI (match_operand:SI 4 "register_operand" "d"))]
           LOAD_SCATTER_DI_PRE_SYNC_UNS))]
 "ISA_HAS_MXU3"
 "sync\n\tla<load_scatter_di_pre_sync_fmt>\t%w0[%2],%3,%z4"
 [(set_attr "mode" "TI")
  (set_attr "lat_type" "lat3")
  (set_attr "hazard" "forbidden_slot")
  (set_attr "insn_count" "2")
  (set_attr "mxu3_type" "load_sync")])

(define_split
  [(set (match_operand:V8DI 0 "register_operand")
        (unspec:V8DI
          [(match_dup 0)
           (match_operand:DI 1 "const_<load_scatter_di_n>_operand")
           (match_operand:DI 2 "const_<load_scatter_di_p>_operand")
           (mem:DI (match_operand:DI 3 "register_operand"))]
           LOAD_SCATTER_DI_UNS))]
 "ISA_HAS_MXU3 && mips_mxu3_fix_bug_for_a1_split_p (insn)"
 [(set (match_operand:V8DI 0 "register_operand")
        (unspec:V8DI
          [(match_dup 0)
           (match_operand:DI 1 "const_<load_scatter_di_pre_sync_n>_operand")
           (match_operand:DI 2 "const_<load_scatter_di_pre_sync_p>_operand")
           (mem:DI (match_operand:DI 3 "register_operand"))]
           LOAD_SCATTER_DI_PRE_SYNC_UNS))])
