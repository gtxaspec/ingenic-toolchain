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

;;
;; LU[W,D,Q,O]
;;
;; (la<elem> reg[i], 0[base]) +
;; (addiu base, base, <elem_size>) = (lu<elem> reg[i], base)
;;
(define_peephole2
  [(set (match_operand:IMXU3_LS 0 "register_operand")
        (vec_merge:IMXU3_LS
          (vec_duplicate:IMXU3_LS
            (mem:<UNITMODE>
              (plus:SI
                (match_operand:SI 3 "register_operand")
                (match_operand:SI 4 "const_<unit_memoff>_operand"))))
          (match_operand:IMXU3_LS 1 "register_operand")
          (match_operand:SI   2 "const_int_operand")))
   (set (match_dup 3) (plus:SI (match_dup 3) 
                               (match_operand:SI 5 "const_arith_operand")))
  ]
  "ISA_HAS_MXU3 &&
   (INTVAL (operands[5]) == GET_MODE_SIZE (<UNITMODE>mode)) &&
  !(INTVAL (operands[4]))"
  [(parallel [
   (set (match_dup 0)
        (vec_merge:IMXU3_LS
          (vec_duplicate:IMXU3_LS
            (mem:<UNITMODE> 
              (match_dup 3)))
          (match_dup 1)
          (match_dup 2)))
   (set (match_dup 3) (plus:SI (match_dup 3) 
                               (match_dup 5)))]
   )]
)

;;
;; (addiu base, base, <elem_size>) +
;; (la<elem> reg[i], -<elem_size>[base]) = (lu<elem> reg[i], base)
;;
(define_peephole2
  [(set (match_operand:SI 0 "register_operand") (plus:SI (match_dup 0) 
                                                (match_operand:SI 1 "const_arith_operand")))
   (set (match_operand:IMXU3_LS 2 "register_operand")
        (vec_merge:IMXU3_LS
          (vec_duplicate:IMXU3_LS
            (mem:<UNITMODE>
              (plus:SI
                (match_dup 0)
                (match_operand:SI 3 "const_<unit_memoff>_operand"))))
          (match_operand:IMXU3_LS 4 "register_operand")
          (match_operand:SI   5 "const_int_operand")))
  ]
  "ISA_HAS_MXU3 &&
   (INTVAL (operands[1]) == GET_MODE_SIZE (<UNITMODE>mode)) &&
  !(INTVAL (operands[3]) + INTVAL (operands[1]))"
  [(parallel [
   (set (match_dup 2)
        (vec_merge:IMXU3_LS
          (vec_duplicate:IMXU3_LS
            (mem:<UNITMODE> 
              (match_dup 0)))
          (match_dup 4)
          (match_dup 5)))
   (set (match_dup 0) (plus:SI (match_dup 0) 
                               (match_dup 1)))]
   )]
)

;;
;; SU[W,D,Q,O)
;;
;;
;; (sa<elem> reg[i], 0[base]) +
;; (addiu base, base, <elem_size>) = (su<elem> reg[i], base)
;;
(define_peephole2
  [(set (mem:<UNITMODE> 
          (plus:SI (match_operand:SI 2 "register_operand")
                   (match_operand:SI 3 "const_<unit_memoff>_operand")))
        (vec_select:<UNITMODE>
          (match_operand:IMXU3_LS 0 "register_operand")
          (parallel [(match_operand:SI 1 "const_<elemindex>_operand")])))
   (set (match_dup 2) (plus:SI (match_dup 2) 
                               (match_operand:SI 4 "const_arith_operand")))
  ]
  "ISA_HAS_MXU3 &&
   (INTVAL (operands[4]) == GET_MODE_SIZE (<UNITMODE>mode)) &&
  !(INTVAL (operands[3]))"
  [(parallel [
   (set (mem:<UNITMODE> 
          (match_dup 2))
        (vec_select:<UNITMODE>
          (match_dup 0)
          (parallel [(match_dup 1)])))
   (set (match_dup 2) (plus:SI (match_dup 2) 
                               (match_dup 4)))]
   )]
)

;;
;; (addiu base, base, <elem_size>) +
;; (sa<elem> reg[i], -<elem_size>[base]) = (su<elem> reg[i], base)
;;
(define_peephole2
  [(set (match_operand:SI 0 "register_operand") (plus:SI (match_dup 0) 
                                                (match_operand:SI 1 "const_arith_operand")))
   (set (mem:<UNITMODE> 
          (plus:SI (match_dup 0)
                   (match_operand:SI 2 "const_<unit_memoff>_operand")))
        (vec_select:<UNITMODE>
          (match_operand:IMXU3_LS 3 "register_operand")
          (parallel [(match_operand:SI 4 "const_<elemindex>_operand")])))
  ]
  "ISA_HAS_MXU3 &&
   (INTVAL (operands[1]) == GET_MODE_SIZE (<UNITMODE>mode)) &&
  !(INTVAL (operands[1]) + INTVAL (operands[2]))"
  [(parallel [
   (set (mem:<UNITMODE> 
          (match_dup 0))
        (vec_select:<UNITMODE>
          (match_dup 3)
          (parallel [(match_dup 4)])))
   (set (match_dup 0) (plus:SI (match_dup 0) 
                               (match_dup 1)))]
   )]
)

