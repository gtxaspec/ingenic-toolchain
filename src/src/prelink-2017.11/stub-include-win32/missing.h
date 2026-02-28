#ifndef _MY_MISSING_H
#define _MY_MISSING_H

/* This is sub-optimal, but we don't really need it.  */
#ifndef _WIN32
# define GLOB_PERIOD 0
#if defined (__sun__)
# define GLOB_BRACE 0
#endif
#endif

#ifndef __P
# define __P(x) x
#endif

#ifdef __CYGWIN__
/* Cygwin's types are already 64-bit.  */
# define ino64_t ino_t
# define stat64 stat
# define fstat64 fstat
# define lstat64 lstat
# define nftw64 nftw

# include <sys/types.h>

#endif

#if defined (_WIN32) || defined (__CYGWIN__)

char *stpcpy(char *dest, const char *src);
#define __stpcpy stpcpy

void *memmem (const void *__haystack, size_t haystacklen,
	      const void *__needle, size_t needlelen);

ssize_t pread (int __fd, void *__buf, size_t __nbytes,
	       off_t __offset);

#endif

#ifdef _WIN32
typedef _ino_t ino64_t;
#endif

# define TEMP_FAILURE_RETRY(expression) \
  (__extension__                                                              \
    ({ long int __result;                                                     \
       do __result = (long int) (expression);                                 \
       while (__result == -1L && errno == EINTR);                             \
       __result; }))

#define strdupa(str) ({ char * __ret = malloc (strlen (str) + 1);  strcpy (__ret, str); __ret; })

char *canonicalize_file_name (const char *name);

#include <stdio.h>

void *
mempcpy (void *dest, const void *src, size_t size);

ssize_t getline(char **lineptr, size_t *n, FILE *stream);

#ifdef _WIN32

#endif

#endif
