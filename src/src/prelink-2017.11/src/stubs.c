#ifndef __linux__

#ifdef _WIN32
#include "prelink-win32.h"
#endif
#include <dirent.h>
# include <stdlib.h>
# include <string.h>
# include <stdio.h>
# include <stdarg.h>

#include "libiberty.h"

char *
canonicalize_file_name (const char *name)
{
#if defined _WIN32 && ! defined __CYGWIN__
  char win32_path[MAX_PATH + 1];

  if (cygpath (name, win32_path))
    name = win32_path;
  name = lrealpath (name);
  if (name)
    {
      char *cname = name;
      for (cname = strchr (cname, '\\');
	   cname;
	   cname = strchr (cname + 1, '\\'))
	*cname = '/';
    }
  return name;
#else
  return lrealpath (name);
#endif
}

void *
mempcpy (void *dest, const void *src, size_t size)
{
  memcpy (dest, src, size);
  return (void *) ((char *) dest + size);
}

#ifdef _WIN32
static char format_buf[1024];

const char *
convert_format (const char *fmt)
{
  const char *src;
  char *dst;
  char c;
  if ((1 + strlen (fmt)) * 5 / 4 > sizeof (format_buf))
    return "format string too long";
  src = fmt;
  dst = format_buf;
  for (;;)
    {
      c = *src;
      *dst = c;
      src++;
      dst++;
      if (c == 0)
	break;
      if (c != '%')
	continue;
      while (*src == '#'
	     || ('0' <= *src && *src <= '9')
	     || *src == '-'
	     || *src == ' '
	     || *src == '+'
	     || *src == '.'
	     || *src == '*')
	{
	  *dst = *src;
	  src++;
	  dst++;
	}
      if (src[0] == 'l' && src[1] == 'l'
	  && (src[2] == 'd' || src[2] == 'i' || src[2] == 'o' || src[2] == 'u'
	      || src[2] == 'x' || src[2] == 'X'))
	{
	  dst[0] = 'I';
	  dst[1] = '6';
	  dst[2] = '4';
	  src += 2;
	  dst += 3;
	}
      if (*src != 0)
	{
	  *dst = *src;
	  src++;
	  dst++;
	}
    }
  return format_buf;
}
#endif

void
error (int status, int errnum, const char *fmt, ...)
{
  va_list va;
  va_start (va, fmt);
  fprintf (stderr, PRELINK_PROG ": ");
  vfprintf (stderr, convert_format (fmt), va);
  if (errnum)
    fprintf (stderr, ": %s", strerror (errnum));
  fprintf (stderr, "\n");
  if (status)
    exit (status);
}

ssize_t getline(char **lineptr, size_t *n, FILE *stream)
{
  char buf[1024];
  if (fgets (buf, 1024, stream) == NULL)
    return -1;
  if (*lineptr == 0)
    {
      *lineptr = malloc (strlen (buf) + 32);
      *n = strlen (buf) + 32;
    }
  else if (*n < strlen (buf) + 1)
    {
      *n = strlen (buf) + 32;
      *lineptr = realloc (*lineptr, *n);
    }
  strcpy (*lineptr, buf);
  return strlen (buf);
}

/* From glibc.  */
void *memmem (const void *haystack, size_t haystack_len,
	      const void *needle, size_t needle_len)
{
  const char *begin;
  const char *const last_possible
    = (const char *) haystack + haystack_len - needle_len;

  if (needle_len == 0)
    /* The first occurrence of the empty string is deemed to occur at
       the beginning of the string.  */
    return (void *) haystack;

  /* Sanity check, otherwise the loop might search through the whole
     memory.  */
  if (haystack_len < needle_len)
    return NULL;

  for (begin = (const char *) haystack; begin <= last_possible; ++begin)
    if (begin[0] == ((const char *) needle)[0] &&
        !memcmp ((const void *) &begin[1],
                 (const void *) ((const char *) needle + 1),
                 needle_len - 1))
      return (void *) begin;

  return NULL;
}

# if defined (__CYGWIN__) || defined (_WIN32)

#ifdef _WIN32
typedef int (*__compar_fn_t) (__const void *, __const void *);
#if !defined(_WIN64) && (__MINGW32_MAJOR_VERSION < 3 || __MINGW32_MINOR_VERSION < 14)
typedef enum
{
  preorder,
  postorder,
  endorder,
  leaf
}
VISIT;
#else
#include <search.h>
#endif
typedef void (*__action_fn_t) (__const void *__nodep, VISIT __value,
                               int __level);
typedef void (*__free_fn_t) (void *__nodep);
#include "tsearch.c"
#endif

#  include "ftw.c"

ssize_t pread (int __fd, void *__buf, size_t __nbytes,
	       off_t __offset)
{
  off_t off;
  ssize_t ret;
  int err;

  off = lseek (__fd, 0, SEEK_CUR);

  ret = read (__fd, __buf, __nbytes);
  err = errno;

  lseek (__fd, off, SEEK_SET);

  errno = err;
  return ret;
}
#endif

#ifndef _WIN64
#if (!defined (__CYGWIN__)) || defined (_WIN32)
/* Solaris and Win32.  */
int
asprintf(char **strp, const char *fmt, ...)
{
  va_list va;
  char buf[1024];
  int ret;

  va_start (va, fmt);
  ret = vsprintf (buf, fmt, va);

  va_end (va);

  *strp = strdup (buf);
  return ret;
}

int
strnlen (const char *str, int len)
{
  const char *p = memchr (str, 0, len);
  if (p == NULL)
    return len;
  else return str - p;
}

char *
stpcpy (char *dest, const char *src)
{
  strcpy (dest, src);
  return dest + strlen (dest);
}
# endif
#endif
#endif
