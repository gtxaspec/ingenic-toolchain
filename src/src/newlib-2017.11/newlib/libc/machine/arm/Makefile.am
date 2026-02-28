## Process this file with automake to generate Makefile.in

AUTOMAKE_OPTIONS = cygnus

INCLUDES = $(NEWLIB_CFLAGS) $(CROSS_CFLAGS) $(TARGET_CFLAGS)

AM_CCASFLAGS = $(INCLUDES)

LIB_SOURCES = setjmp.S access.c strlen.c strcmp.S strcpy.c \
	        $(MEMCPY_SRC) memcpy-stub.c memchr-stub.c memchr.S \
		strlen.c strlen-armv7.S

if USE_LIBTOOL
noinst_LTLIBRARIES = libarm.la
libarm_la_SOURCES = $(LIB_SOURCES)
noinst_DATA = objectlist.awk.in
else
noinst_LIBRARIES = lib.a
endif

if HAVE_THUMB1
if OPT_SIZE
STRLEN_SRC=strlen.c
STRLEN_OBJ=$(lpfx)strlen.o
else
STRLEN_SRC=
STRLEN_OBJ=
endif
else
STRLEN_SRC=strlen.c
STRLEN_OBJ=$(lpfx)strlen.o
endif

if HAVE_ARMV7
MEMCHR_SRC=memchr.S
MEMCHR_OBJ=$(lpfx)memchr.o
else
MEMCHR_SRC=
MEMCHR_OBJ=
endif

if OPT_SIZE
MEMCPY_SRC=
MEMCPY_OBJ=
else
if HAVE_ARMV7A
MEMCPY_SRC=memcpy.S
MEMCPY_OBJ=$(lpfx)memcpy.o
else
if HAVE_ARMV7M
MEMCPY_SRC=memcpy.S
MEMCPY_OBJ=$(lpfx)memcpy.o
else
MEMCPY_SRC=memcpx-asm.S memcpx.c
MEMCPY_OBJ=$(lpfx)memcpx-asm.o $(lpfx)memcpx.o
endif !HAVE_ARMV7M
endif !HAVE_ARMV7A
endif !OPT_SIZE

lib_a_SOURCES = setjmp.S access.c strcmp.S strcpy.c \
	        $(MEMCPY_SRC) $(MEMCHR_SRC) $(STRLEN_SRC) \
		strlen-armv7.S aeabi_memcpy.c aeabi_memcpy-armv7a.S

lib_a_CCASFLAGS=$(AM_CCASFLAGS)
lib_a_CFLAGS = $(AM_CFLAGS)
lib_a_LIBADD = $(STRLEN_OBJ) $(MEMCHR_OBJ) $(MEMCPY_OBJ)
lib_a_DEPENDENCIES = $(STRLEN_OBJ) $(MEMCHR_OBJ) $(MEMCPY_OBJ)

include $(srcdir)/../../../Makefile.shared

ACLOCAL_AMFLAGS = -I ../../.. -I ../../../..
CONFIG_STATUS_DEPENDENCIES = $(newlib_basedir)/configure.host

MEMCPY_DEP=memcpy-armv7a.S memcpy-armv7m.S memcpx-asm.S memcpx.c
STRCMP_DEP=strcmp-arm-tiny.S strcmp-armv4.S strcmp-armv4t.S strcmp-armv6.S \
	strcmp-armv6m.S strcmp-armv7.S strcmp-armv7m.S

$(lpfx)memcpy.o: $(MEMCPY_DEP)

$(lpfx)memcpy.obj: $(MEMCPY_DEP)

$(lpfx)strcmp.o: $(STRCMP_DEP)

$(lpfx)strcmp.obj: $(STRCMP_DEP)
