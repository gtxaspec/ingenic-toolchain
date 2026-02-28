;;  Xburst2 pipeline description.
;;  Copyright (C) 2008-2015 Free Software Foundation, Ing.

;; This file is part of GCC.

;; GCC is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; GCC is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GCC; see the file COPYING3.  If not see
;; <http://www.gnu.org/licenses/>.
;;   Copyright (C) 2004, 2005, 2006 Cavium Networks.

(define_automaton "xburst2_main")

(define_cpu_unit "xburst2_pipe0" "xburst2_main")
(define_cpu_unit "xburst2_pipe1" "xburst2_main")

(define_insn_reservation "xburst2_arith" 1
  (and (eq_attr "cpu" "xburst2")
       (eq_attr "type" "unknown,prefetch,prefetchx,condmove,,clz,trap,multi,
			const,arith,shift,slt,nop,logical,signext,move"))
  "xburst2_pipe0 | xburst2_pipe1")

(define_insn_reservation "xburst2_load" 2
  (and (eq_attr "cpu" "xburst2")
       (eq_attr "type" "load"))
  "xburst2_pipe0")

(define_insn_reservation "xburst2_store" 1
  (and (eq_attr "cpu" "xburst2")
       (eq_attr "type" "store"))
  "xburst2_pipe0")

(define_insn_reservation "xburst2_branch" 1
   (and (eq_attr "cpu" "xburst2")
       (eq_attr "type" "branch,jump,call"))
  "xburst2_pipe0 | xburst2_pipe1")
