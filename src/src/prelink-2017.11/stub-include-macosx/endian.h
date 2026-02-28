#ifndef _MY_ENDIAN

#define _MY_ENDIAN

#define __LITTLE_ENDIAN 1234
#define __BIG_ENDIAN 4321
#ifdef __BIG_ENDIAN__
#define __BYTE_ORDER __BIG_ENDIAN
#else
#define __BYTE_ORDER __LITTLE_ENDIAN
#endif

#endif

