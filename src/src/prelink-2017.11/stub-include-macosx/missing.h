#ifndef _MY_MISSING_H
#define _MY_MISSING_H

#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/kernel_types.h>

/* From Mac OS X/Leopard man page!  E&OE.  */

struct stat64 {
  dev_t			st_dev;
  mode_t		st_mode;
  nlink_t		st_nlink;
  ino64_t		st_ino;
  uid_t			st_uid;
  gid_t			st_gid;
  dev_t			st_rdev;
  struct timespec	st_atimespec;
  struct timespec	st_mtimespec;
  struct timespec	st_ctimespec;
  struct timespec	st_birthtimespec;
  off_t			st_size;
  blkcnt_t		st_blocks;
  blksize_t		st_blksize;
  uint32_t		st_flags;
  uint32_t		st_gen;
  int32_t		st_lspare;
  int64_t		st_qspare[2];
};

/* Note: although Mac OS X versions >= 10.5 support {,l,f}stat64, the cross-
   toolchains we are using at present do not.  All such operations are
   faked.  */

static void copy_struct_stat_to_stat64 (struct stat64 *dst, struct stat *src)
{
  memset (dst, 0, sizeof (*dst));
  dst->st_dev = src->st_dev;
  dst->st_ino = src->st_ino;
  dst->st_mode = src->st_mode;
  dst->st_nlink = src->st_nlink;
  dst->st_uid = src->st_uid;
  dst->st_gid = src->st_gid;
  dst->st_rdev = src->st_rdev;
  dst->st_atimespec = src->st_atimespec;
  dst->st_mtimespec = src->st_mtimespec;
  dst->st_ctimespec = src->st_ctimespec;
  /* With a real stat64 function, on a filesystem where birth time isn't
     available, the birthtime field is set the same as ctime.  Do that here
     too.  */
  dst->st_birthtimespec = src->st_ctimespec;
  dst->st_size = src->st_size;
  dst->st_blocks = src->st_blocks;
  dst->st_blksize = src->st_blksize;
  dst->st_flags = src->st_flags;
  dst->st_gen = src->st_gen;
}

static int stat64 (const char *path, struct stat64 *buf)
{
  struct stat sbuf;
  int rc = stat (path, &sbuf);
  
  copy_struct_stat_to_stat64 (buf, &sbuf);
  
  return rc;
}

static int lstat64 (const char *path, struct stat64 *buf)
{
  struct stat sbuf;
  int rc = lstat (path, &sbuf);
  
  copy_struct_stat_to_stat64 (buf, &sbuf);
  
  return rc;
}

static int fstat64 (int fd, struct stat64 *buf)
{
  struct stat sbuf;
  int rc = fstat (fd, &sbuf);
  
  copy_struct_stat_to_stat64 (buf, &sbuf);
  
  return rc;
}

#include <ftw.h>

typedef int (*__nftw64_func_t) (const char *, const struct stat64 *, int,
				struct FTW *);

static __nftw64_func_t wrapped_nftw_fn = 0;

static int
nftw64_fn_wrapper (const char *path, const struct stat *sb, int typeflag,
		   struct FTW *ftwbuf)
{
  struct stat64 buf64;
  
  copy_struct_stat_to_stat64 (&buf64, sb);

  return wrapped_nftw_fn (path, (const struct stat64 *) &buf64, typeflag,
			  ftwbuf);
}

/* Warning: not re-entrant.  OS X (including Leopard) doesn't appear to
   support this function, so fake it.  (Other parts of the prelinker already
   assume a non-reentrant nftw64.)  */

static int
nftw64 (const char *path, int (*fn) (const char *, const struct stat64 *, int,
				     struct FTW *),
	int nopenfd, int flags)
{
  wrapped_nftw_fn = fn;

  return nftw (path, &nftw64_fn_wrapper, nopenfd, flags); 
}


#include <alloca.h>

#define strdupa(S) ({				\
    char *__str = (S);				\
    char *__tmp = alloca (strlen (__str) + 1);	\
    strcpy (__tmp, __str);			\
    __tmp;					\
  })

#define TEMP_FAILURE_RETRY(expression)		\
  (__extension__				\
    ({ long int __result;			\
    do __result = (long int) (expression);	\
    while (__result == -1L && errno == EINTR);	\
    __result; }))

#endif
