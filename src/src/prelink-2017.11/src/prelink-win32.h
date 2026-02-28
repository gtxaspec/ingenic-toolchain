#ifndef _PRELINK_WIN32_H
#define _PRELINK_WIN32_H

#include <io.h>
#include <sys/stat.h>
#include "elf.h"
#define _ELF_REPL_H
#include <libelf.h>
#include <libiberty.h>

#ifdef _WIN64
#include <minwindef.h>
#else

#define ELOOP 40 /* prob to be removed */

struct stat64 /* must be the same as __stat64 */
{
    _dev_t st_dev;
    _ino_t st_ino;
    _mode_t st_mode;
    short st_nlink;
    short st_uid;
    short st_gid;
    _dev_t st_rdev;
    __int64 st_size;
    __time64_t st_atime;
    __time64_t st_mtime;
    __time64_t st_ctime;
};
#endif /* _WIN64 */
/* FIXME */

extern int stat64(const char*, struct stat64*);
#define lstat64 stat64
extern int fstat64(int, struct stat64*);
extern int link(const char*, const char*);

#include <dirent.h>

extern int dirfd(DIR*);
extern int fchdir(int);

#include "byteswap.h"
#include "endian.h"
#include "error.h"
#include "features.h"
#include "missing.h"
#include <stdint.h>
#include <malloc.h>

#include <stdio.h>

#define S_ISLNK(x) 0
#define MAXSYMLINKS  0
extern int readlink(const char*, char*, size_t);

extern int mkstemp(char *template);

extern char* realpath(const char*, char*);

/* sys/stat.h */
extern int fchmod(int, mode_t);

/* unistd.h */
typedef int uid_t;
typedef int gid_t;
extern int fchown(int, uid_t, gid_t);
extern int fsync (int);

#endif

