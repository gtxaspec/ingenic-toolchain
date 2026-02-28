
CC=$(CROSS_COMPILER_PREFIX)gcc
CFLAGS=-O2 -mmxu2

HFILE=mxuextend.h
CFILE=printf-mxu.c
OBJ=libmxuextend.a
printf-mxu.o=printf-mxu.o


all: $(OBJ)

$(OBJ):$(printf-mxu.o)
	ar -r $@ $<

$(printf-mxu.o):
	$(CC) -c $(CFILE) -o $@ $(CFLAGS) $(ARCH_CFLAGS)

install_headers:
	cp $(HFILE) $(PREFIX)

install_libs:
	cp $(OBJ) $(PREFIX)

clean:
	rm $(OBJ) $(printf-mxu.o)

.PHONY: $(all) $(OBJ) $(printf-mxu.o) $(clean) $(install)


