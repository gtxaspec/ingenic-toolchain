#ifndef _MMAN_H
#define _MMAN_H

/* mmap stub for use where alternative code not using memory-mapped files
   is provided.  mapfile.c provides Win32 memory-mapped files when really
   needed. */

#include <stdlib.h>
#include <sys/types.h>

#define MAP_FAILED 0

#define PROT_READ 0
#define MAP_PRIVATE 0

extern void* mmap(void*, size_t, int, int, int, off_t);
extern int munmap(void*, size_t);

#endif
