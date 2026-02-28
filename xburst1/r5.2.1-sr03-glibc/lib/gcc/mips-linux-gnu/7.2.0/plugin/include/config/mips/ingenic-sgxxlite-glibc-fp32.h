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
  "%{!muclibc: %{!mglibc: -mglibc}}",	\
  "%{!msingle-float: %{!msoft-float: %{!mmsa: %{!mmxu3:%{!mfp*: %{mabi=32: -mfp32}}}}}}", \
  "%{mmsa: %{!mfp*: -mfp64}}",		\
  "%{mmxu3: %{!mfp*: -mfp64}}"

/* LIBS_OWNER_DIR for create dir to every lib */
#ifdef LIBS_OWNER_DIR
/* sysroot multi-lib glibc */
#define SYSROOT_MULTILIB_PRIVATE 	\
   "%{muclibc:/uclibc}"			\
   "%{mglibc:/glibc}"			\
   "%{!msoft-float:%{mfp64:/mfp64;mmsa:/mfp64}}"	\


/* sysroot header */
#define SYSROOT_HEADERS_PRIVATE 	\
   "%{muclibc:/uclibc}"			\
   "%{mglibc:/glibc}"			\

#else
/* sysroot multi-lib glibc */
#define SYSROOT_MULTILIB_PRIVATE 	\
   "%{muclibc:/uclibc}"			\
   "%{!msoft-float:%{mfp64:/mfp64;mmsa:/mfp64}}"


#endif //

