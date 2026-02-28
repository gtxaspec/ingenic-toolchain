#ifdef _WIN32

#ifndef _NFTW64_H
#define _NFTW64_H

#include <sys/types.h>
#include "ftw.h"

typedef int (*__nftw64_func_t) (__const char *__filename,
                                __const struct stat64 *__status,
                                int __flag, struct FTW *__info);

#endif

#endif
