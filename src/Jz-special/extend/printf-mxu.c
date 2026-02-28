/*
 * printf-mxu.c
 *
 * Copyright (C) 2015 Ingenic Semiconductor CO.,LTD.
 * Cheng Lulu <lulu.cheng@ingenic.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see the file COPYING, or write
 * to the Free Software Foundation, Inc.,
 * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */

#include <stdarg.h>
#include <mxu2.h>

#define ZEROPAD  1    /* pad with zero */
#define SIGN  2    /* unsigned/signed long */
#define PLUS  4    /* show plus */
#define SPACE  8    /* space if plus */
#define LEFT  16    /* left justified */
#define SMALL  32    /* Must be 32 == 0x20 */
#define SPECIAL  64    /* 0x */
#define MXU2  128             /* sign MXU2 type */
#define FLOAT  256             /* sign Float type */

#define __do_div(n, base) \
  ({int __res;                        \
    __res = ((unsigned long long) n) % (unsigned) base; \
    n = ((unsigned long long) n) / (unsigned) base; \
    __res; })

#undef NULL
#define NULL ((void *)0)

enum {
  false  = 0,
  true  = 1
};

#define PRINTBUF_SIZE 1024

static char printf_buf[PRINTBUF_SIZE];

inline int
skip_atoi (const char **s)
{
  int i = 0;

  while (isdigit (**s))
    i = i * 10 + *((*s)++) - '0';
  return i;
}

static char *
number (char *str, long long num, int base, int size,
       int precision, int type)
{
  /* we are called with base 8, 10 or 16, only, thus don't need "G..."  */
  static const char digits[16] = "0123456789ABCDEF"; /* "GHIJKLMNOPQRSTUVWXYZ"; */

  char tmp[66];
  char c, sign, locase;
  int i;

  /* locase = 0 or 0x20. ORing digits or letters with 'locase'
   * produces same digits or (maybe lowercased) letters */
  locase = (type & SMALL);
  if (type & LEFT)
    type &= ~ZEROPAD;
  if (base < 2 || base > 36)
    return NULL;
  c = (type & ZEROPAD) ? '0' : ' ';
  sign = 0;
  if (type & SIGN)
    {
      if (num < 0)
        {
          sign = '-';
          num = -num;
          size--;
        }
      else if (type & PLUS)
        {
          sign = '+';
          size--;
        }
      else if (type & SPACE)
        {
          sign = ' ';
          size--;
        }
    }
  if (type & SPECIAL)
    {
      if (base == 16)
        size -= 2;
      else if (base == 8)
        size--;
    }

  i = 0;
  if (num == 0)
    tmp[i++] = '0';
  else
    while (num != 0)
      tmp[i++] = (digits[__do_div(num, base)] | locase);
  if (i > precision)
    precision = i;
  size -= precision;
  if (!(type & (ZEROPAD + LEFT)))
    while (size-- > 0)
      *str++ = ' ';
  if (sign)
    *str++ = sign;
  if (type & SPECIAL)
    {
      if (base == 8)
        *str++ = '0';
      else if (base == 16)
        {
          *str++ = '0';
          *str++ = ('X' | locase);
        }
    }
  if (!(type & LEFT))
    while (size-- > 0)
      *str++ = c;
  while (i < precision--)
    *str++ = '0';
  while (i-- > 0)
    *str++ = tmp[i];
  while (size-- > 0)
    *str++ = ' ';
  return str;
}

static char *
number_f (char *str, long double num_f, int base, int precision,
           int type)
{
  static const char digits[10] = "0123456789";

  char tmp[66];
  char c, sign, locase;
  int i;
  long double t2 = 0.0, j;
  int part_int;
  long long part_dec = 0;

  sign = 0;

  if (num_f < 0)
    {
      sign = '-';
      num_f = -num_f;
      part_int = -part_int;
    }

  t2 = num_f;

  j = 1;
  for ( i = 0; i < precision + 1; i++ )
    j = j * 10;
  t2 = t2 * j;

  if ( (long long)t2%10 > 4)
    {
      t2 = t2*0.1;
      t2 = t2 + 1;
    }
  else
    t2 = t2*0.1;

  j = 1.0;
  for ( i = 0; i < precision; i++ )
    j = j * 0.1;
  t2 = t2 * j;

  num_f = t2;

  if (sign)
    *str++ = sign;

  i = 0;
  part_int = num_f/1;
  if (part_int == 0)
    tmp[i++] = '0';
  else
    while (part_int != 0)
      tmp[i++] = (digits[__do_div(part_int, base)]);

  while (i-- > 0)
    *str++ = tmp[i];

  *str++ = '.';

  t2 = num_f;

  for (i = 0; i < precision; i++)
    {
      part_dec = t2*10;
      *str++ = digits[part_dec%10];
      t2 = t2*10;
    }

  return str;
}

int
_mx128_vsprintf (char *buf, const char *fmt, va_list args)
{
  int len;
  unsigned long num;
  int i, base;
  char *str;
  const char *s;

  int flags;    /* flags to number() */

  int field_width;  /* width of output field */
  int precision;    /* min. # of digits for integers; max
           number of chars for from string */
  int qualifier;    /* 'h', 'l', or 'L' for integer fields */

  v4i32 num_mx128;
  int buf_for_mx128[4];
  int count_mx128;
  long double num_f;

  for (str = buf; *fmt; ++fmt)
    {
      if (*fmt != '%') {
        *str++ = *fmt;
        continue;
      }

    /* process flags */
      flags = 0;
      field_width = -1;
      precision = -1;

    repeat:
      ++fmt;    /* this also skips first '%' */
      switch (*fmt)
        {
        case '-':
          flags |= LEFT;
          goto repeat;
        case '+':
          flags |= PLUS;
          goto repeat;
        case ' ':
          flags |= SPACE;
          goto repeat;
        case '#':
          flags |= SPECIAL;
          goto repeat;
        case '0':
          flags |= ZEROPAD;
          goto repeat;
        }

      /* get field width */
      if (isdigit(*fmt))
        {
          if (*(fmt - 1) == 'v')
            {
              count_mx128 = skip_atoi(&fmt);
            }
          else
            field_width = skip_atoi(&fmt);
        }
      else if (*fmt == '*')
        {
          ++fmt;
          /* it's the next argument */
          field_width = va_arg(args, int);
          if (field_width < 0)
            {
              field_width = -field_width;
              flags |= LEFT;
            }
        }

      /* get the precision */
      if (*fmt == '.')
        {
          ++fmt;
          if (isdigit(*fmt))
            precision = skip_atoi(&fmt);
          else if (*fmt == '*')
            {
              ++fmt;
              /* it's the next argument */
              precision = va_arg(args, int);
            }
          if (precision < 0)
            precision = 0;
        }

      /* get the conversion qualifier */
      qualifier = -1;
      if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L')
        {
          qualifier = *fmt;
          ++fmt;
        }

      /* default base */
      base = 10;

      switch (*fmt)
        {
        case 'c':
          if (!(flags & LEFT))
            while (--field_width > 0)
              *str++ = ' ';
          *str++ = (unsigned char)va_arg(args, int);
          while (--field_width > 0)
            *str++ = ' ';
          continue;

        case 's':
          s = va_arg (args, char *);
          len = strnlen (s, precision);

          if (!(flags & LEFT))
            while (len < field_width--)
              *str++ = ' ';
          for (i = 0; i < len; ++i)
            *str++ = *s++;
          while (len < field_width--)
            *str++ = ' ';
          continue;

        case 'p':
          if (field_width == -1)
            {
              field_width = 2 * sizeof(void *);
              flags |= ZEROPAD;
            }
          str = number (str,
                (unsigned long)va_arg(args, void *), 16,
                field_width, precision, flags);
          continue;

        case 'n':
          if (qualifier == 'l')
            {
              long *ip = va_arg(args, long *);
              *ip = (str - buf);
            }
          else
            {
              int *ip = va_arg(args, int *);
              *ip = (str - buf);
            }
          continue;

        case '%':
          *str++ = '%';
          continue;

        /* integer number formats - set up the flags and "break" */
        case 'o':
          base = 8;
          break;

        case 'x':
          flags |= SMALL;
        case 'X':
          base = 16;
          break;

        case 'd':
        case 'i':
          flags |= SIGN;
        case 'u':
          break;
        case 'f':
          flags |= FLOAT;
          base = 10;
          break;
        case 'v':
          flags |= MXU2;
          goto repeat;
        default:
          *str++ = '%';
          if (*fmt)
            *str++ = *fmt;
          else
            --fmt;
          continue;
        }

      if (qualifier == 'l')
        num = va_arg(args, unsigned long);
      else if (qualifier == 'h')
        {
          num = (unsigned short)va_arg(args, int);
          if (flags & SIGN)
            num = (short)num;
        }
      else if (flags & MXU2)
        {
          num_mx128 = va_arg(args, v4i32);
          _mx128_su1q ((v16i8)num_mx128, buf_for_mx128, 0);
        }
      else if ((flags & SIGN) && !(flags & MXU2))
        num = va_arg (args, int);
      else if (!(flags & FLOAT) && !(flags & MXU2))
        num = va_arg (args, unsigned int);
      else if ((flags & FLOAT) && !(flags & MXU2))
        num_f = va_arg (args, long double);

      if ((flags & MXU2) && !(flags & FLOAT))
        {

          int i = 0;

          if (flags & SIGN)
            {
              while (i < count_mx128)
                {
                  switch (count_mx128)
                    {
                    case 2:
                      str = number (str, ((long long *)buf_for_mx128)[i],
                                   base, field_width, precision, flags);
                      break;
                    case 4:
                      str = number (str, ((int *)buf_for_mx128)[i],
                                   base, field_width, precision, flags);
                      break;
                    case 8:
                      str = number (str, ((short *)buf_for_mx128)[i],
                                   base, field_width, precision, flags);
                      break;
                    case 16:
                      str = number (str, ((char *)buf_for_mx128)[i],
                                   base, field_width, precision, flags);
                      break;
                    }
                  int c = str - buf;
                  buf[c] = ',';
                  str++;
                  i++;
                }
            }
          else
            {
              while (i < count_mx128)
                {
                  switch (count_mx128)
                    {
                    case 2:
                      str = number (str, ((unsigned long long *)buf_for_mx128)[i],
                                   base, field_width, precision, flags);
                      break;
                    case 4:
                      str = number (str, ((unsigned int *)buf_for_mx128)[i],
                                   base, field_width, precision, flags);
                      break;
                    case 8:
                      str = number (str, ((unsigned short *)buf_for_mx128)[i],
                                   base, field_width, precision, flags);
                      break;
                    case 16:
                      str = number (str, ((unsigned char *)buf_for_mx128)[i],
                                   base, field_width, precision, flags);
                      break;
                    }
                  int c = str - buf;
                  buf[c] = ',';
                  str++;
                  i++;
                }
            }
          str--;
        }
      else if ((flags & MXU2) && (flags & FLOAT))
        {
          int i = 0;
          if (precision < 1)
            precision = 6;

          while (i < count_mx128)
            {
              switch (count_mx128)
                {
                case 2:
                  str = number_f (str, ((double *)buf_for_mx128)[i],
                                 base, precision, flags);
                  break;
                case 4:
                  str = number_f (str, ((float *)buf_for_mx128)[i],
                                 base, precision, flags);
                  break;
                }
              int c = str - buf;
              buf[c] = ',';
              str++;
              i++;
            }
          str--;
        }
      else if (!(flags & MXU2) && (flags & FLOAT))
        {
          str = number_f (str, num_f, base, precision, flags);
        }
      else
        {
          str = number (str, num, base, field_width, precision, flags);
        }
    }

  *str = '\0';
  return str - buf;
}

int
_mx128_sprintf (char *buf, const char *fmt, ...)
{
  va_list args;
  int i;

  va_start (args, fmt);
  i = _mx128_vsprintf (buf, fmt, args);
  va_end (args);
  return i;
}

int
_mx128_printf (const char *fmt, ...)
{
  va_list args;
  int printed;

  va_start (args, fmt);
  printed = _mx128_vsprintf (printf_buf, fmt, args);
  va_end (args);

  puts (printf_buf);

  return printed;
}
