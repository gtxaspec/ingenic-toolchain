#ifdef _WIN32

#include "sys/mman.h"

void* mmap(void* start, size_t length, int prot, int flags, int fd,
           off_t offset)
{
  return MAP_FAILED;
}

int munmap(void* start, size_t length)
{
  return 0;
}

#endif

