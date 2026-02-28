#if defined (_WIN32) || defined (__CYGWIN__)

#include "prelink-win32.h"
#include <assert.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
# include <string.h>
#include <errno.h>

#include <sys/stat.h>

int /* FIXME probably there on Cygwin? */
dirfd(DIR* dir)
{
  return -1;
}

int
fchdir(int fd)
{
  errno = ENOSYS;
  return -1;
}

#ifndef _WIN64
int
stat64(const char* name, struct stat64* buf)
{
  int r;
#ifndef __CYGWIN__
  char win32_path[MAX_PATH + 1];
#endif

  r = _stat64(name, (struct __stat64*) buf);
#ifndef __CYGWIN__
  if (r != -1 || errno != ENOENT)
    return r;
  if (cygpath (name, win32_path))
    r = _stat64(win32_path, (struct __stat64*) buf);
#endif
  return r;
}
#endif

int
fstat64(int fd, struct stat64* buf)
{
  return _fstat64(fd, (struct __stat64*) buf);
}

int
link(const char* old, const char* new)
{
  errno = ENOSYS;
  return -1;
}

#include "mkstemps.c"

int
mkstemp(char* template)
{
  return mkstemps(template, 0);
}

#endif

#ifdef _WIN32
int fchmod(int fd, mode_t mode)
{
  return 0;
}

int fchown(int fd, uid_t user, gid_t group)
{
  return 0;
}

int readlink(const char *path, char *buf, size_t bufsiz)
{
  errno = ENOSYS;
  return -1;
}

int
fsync (int fd)
{
  return 0;
}
#endif

