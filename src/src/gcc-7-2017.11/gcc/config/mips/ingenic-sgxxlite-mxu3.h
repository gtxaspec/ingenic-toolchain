/* Target macros for mips*-mti-linux* targets.
   Copyright (C) 2012-2015 Free Software Foundation, Inc.

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


/* Ingenic toolchains private spec. */
#define MIPS_INGENIC_SPEC_PRIVATE	\
"%{!mno-mxu3: %{!mmxu3: %{!mmxu2: %{!mmsa: %{!msoft-float: "	\
	"%{!msingle-float: %{!mfp32: -mmxu3}}}}}}}"	,	\
"%{!muclibc: %{!mglibc: -mglibc}}"				

/* sysroot multi-lib glibc */
#define SYSROOT_MULTILIB_PRIVATE 	\
   "%{muclibc:/uclibc}"			\
   "%{mglibc:/glibc}"			


