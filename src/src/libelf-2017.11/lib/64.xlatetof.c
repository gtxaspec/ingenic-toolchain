/*
 * 64.xlatetof.c - implementation of the elf64_xlateto[fm](3) functions.
 * Copyright (C) 1995 - 2006 Michael Riepe
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 * 
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA
 */

#include <private.h>
#include <ext_types.h>
#include <byteswap.h>

#if __LIBELF64

#ifndef lint
static const char rcsid[] = "@(#) $Id: 64.xlatetof.c,v 1.27 2008/05/23 08:15:34 michael Exp $";
#endif /* lint */

/*
 * Ugly, ugly
 */
#ifdef _WIN32
# define Cat2(a,b)a##b
# define Cat3(a,b,c)a##b##c
# define Ex1(m1,m2,a,b)m1##m2(a##b)
# define Ex2(m1,m2,a,b,c)m1##m2(a,b##c)
#else /* _WIN32 */
# define x
# if defined/**/x
#  define Cat2(a,b)a##b
#  define Cat3(a,b,c)a##b##c
#  define Ex1(m1,m2,a,b)m1##m2(a##b)
#  define Ex2(m1,m2,a,b,c)m1##m2(a,b##c)
# else
#  define Cat2(a,b)a/**/b
#  define Cat3(a,b,c)a/**/b/**/c
#  define Ex1(m1,m2,a,b)m1/**/m2(a/**/b)
#  define Ex2(m1,m2,a,b,c)m1/**/m2(a,b/**/c)
# endif
# undef x
#endif /* _WIN32 */

/*
 * auxiliary macros for execution order reversal
 */
#define seq_forw(a,b) a b
#define seq_back(a,b) b a

/*
 * function instantiator
 */
#define copy_type_e_io(name,e,io,tfrom,tto,copy)		\
    static size_t						\
    Cat3(name,_,io)(unsigned char *dst, const unsigned char *src, size_t n) {	\
	n /= sizeof(tfrom);					\
	if (n && dst) {						\
	    const tfrom *from = (const tfrom*)src;		\
	    tto *to = (tto*)dst;				\
	    size_t i;						\
	    __libelf_u64_t tmp64;				\
								\
	    if (sizeof(tfrom) < sizeof(tto)) {			\
		from += n;					\
		to += n;					\
		for (i = 0; i < n; i++) {			\
		    --from;					\
		    --to;					\
		    copy(e,io,seq_back)				\
		}						\
	    }							\
	    else {						\
		for (i = 0; i < n; i++) {			\
		    copy(e,io,seq_forw)				\
		    from++;					\
		    to++;					\
		}						\
	    }							\
	}							\
	return n * sizeof(tto);					\
    }

#define copy_type_e(name,e,type,copy)				\
    copy_type_e_io(name,e,tom,Cat2(__ext_,type),type,copy)	\
    copy_type_e_io(name,e,tof,type,Cat2(__ext_,type),copy)

/*
 * master function instantiator
 */
#define copy_type(name,version,type,copy)		\
    copy_type_e(Cat3(name,L,version),L,type,copy)	\
    copy_type_e(Cat3(name,M,version),M,type,copy)

/*
 * scalar copying
 */
#define copy_scalar_tom(type)	*to = Cat2(__load_,type)(*from);
#define copy_scalar_tof(type) \
  tmp64 = *from, Cat2(__store_,type)(*to, tmp64);

/*
 * structure member copying
 */
#define copy_tom(mb,type)	to->mb = Cat2(__load_,type)(from->mb);
#define copy_tof(mb,type) \
  tmp64 = from->mb, Cat2(__store_,type)(to->mb, tmp64);

/*
 * structure member copying (direction independent)
 */
#define copy_byte(e,io,mb)	to->mb = from->mb;
#define copy_addr(e,io,mb)	Ex2(copy_,io,mb,u64,e)
#define copy_half(e,io,mb)	Ex2(copy_,io,mb,u16,e)
#define copy_off(e,io,mb)	Ex2(copy_,io,mb,u64,e)
#define copy_sword(e,io,mb)	Ex2(copy_,io,mb,i32,e)
#define copy_word(e,io,mb)	Ex2(copy_,io,mb,u32,e)
#define copy_sxword(e,io,mb)	Ex2(copy_,io,mb,i64,e)
#define copy_xword(e,io,mb)	Ex2(copy_,io,mb,u64,e)
#define copy_arr(e,io,mb)	\
    array_copy(to->mb, sizeof(to->mb), from->mb, sizeof(from->mb));

/*
 * scalar copying (direction independent)
 * these macros are used as `copy' arguments to copy_type()
 */
#define copy_addr_11(e,io,seq)	Ex1(copy_scalar_,io,u64,e)
#define copy_half_11(e,io,seq)	Ex1(copy_scalar_,io,u16,e)
#define copy_off_11(e,io,seq)	Ex1(copy_scalar_,io,u64,e)
#define copy_sword_11(e,io,seq)	Ex1(copy_scalar_,io,i32,e)
#define copy_word_11(e,io,seq)	Ex1(copy_scalar_,io,u32,e)
#define copy_sxword_11(e,io,seq)Ex1(copy_scalar_,io,i64,e)
#define copy_xword_11(e,io,seq)	Ex1(copy_scalar_,io,u64,e)

/*
 * structure copying (direction independent)
 * these macros are used as `copy' arguments to copy_type()
 */
#define copy_dyn_11(e,io,seq)		\
    seq(copy_xword(e,io,d_tag),		\
    seq(copy_addr(e,io,d_un.d_ptr),	\
    nullcopy))
#define copy_ehdr_11(e,io,seq)		\
    seq(copy_arr(e,io,e_ident),		\
    seq(copy_half(e,io,e_type),		\
    seq(copy_half(e,io,e_machine),	\
    seq(copy_word(e,io,e_version),	\
    seq(copy_addr(e,io,e_entry),	\
    seq(copy_off(e,io,e_phoff),		\
    seq(copy_off(e,io,e_shoff),		\
    seq(copy_word(e,io,e_flags),	\
    seq(copy_half(e,io,e_ehsize),	\
    seq(copy_half(e,io,e_phentsize),	\
    seq(copy_half(e,io,e_phnum),	\
    seq(copy_half(e,io,e_shentsize),	\
    seq(copy_half(e,io,e_shnum),	\
    seq(copy_half(e,io,e_shstrndx),	\
    nullcopy))))))))))))))
#define copy_phdr_11(e,io,seq)		\
    seq(copy_word(e,io,p_type),		\
    seq(copy_word(e,io,p_flags),	\
    seq(copy_off(e,io,p_offset),	\
    seq(copy_addr(e,io,p_vaddr),	\
    seq(copy_addr(e,io,p_paddr),	\
    seq(copy_xword(e,io,p_filesz),	\
    seq(copy_xword(e,io,p_memsz),	\
    seq(copy_xword(e,io,p_align),	\
    nullcopy))))))))
#if __LIBELF64_IRIX
#define copy_rela_11(e,io,seq)		\
    seq(copy_addr(e,io,r_offset),	\
    seq(copy_word(e,io,r_sym),		\
    seq(copy_byte(e,io,r_ssym),		\
    seq(copy_byte(e,io,r_type3),	\
    seq(copy_byte(e,io,r_type2),	\
    seq(copy_byte(e,io,r_type),		\
    seq(copy_sxword(e,io,r_addend),	\
    nullcopy)))))))
#define copy_rel_11(e,io,seq)		\
    seq(copy_addr(e,io,r_offset),	\
    seq(copy_word(e,io,r_sym),		\
    seq(copy_byte(e,io,r_ssym),		\
    seq(copy_byte(e,io,r_type3),	\
    seq(copy_byte(e,io,r_type2),	\
    seq(copy_byte(e,io,r_type),		\
    nullcopy))))))
#else /* __LIBELF64_IRIX */
#define copy_rela_11(e,io,seq)		\
    seq(copy_addr(e,io,r_offset),	\
    seq(copy_xword(e,io,r_info),	\
    seq(copy_sxword(e,io,r_addend),	\
    nullcopy)))
#define copy_rel_11(e,io,seq)		\
    seq(copy_addr(e,io,r_offset),	\
    seq(copy_xword(e,io,r_info),	\
    nullcopy))
#endif /* __LIBELF64_IRIX */
#define copy_shdr_11(e,io,seq)		\
    seq(copy_word(e,io,sh_name),	\
    seq(copy_word(e,io,sh_type),	\
    seq(copy_xword(e,io,sh_flags),	\
    seq(copy_addr(e,io,sh_addr),	\
    seq(copy_off(e,io,sh_offset),	\
    seq(copy_xword(e,io,sh_size),	\
    seq(copy_word(e,io,sh_link),	\
    seq(copy_word(e,io,sh_info),	\
    seq(copy_xword(e,io,sh_addralign),	\
    seq(copy_xword(e,io,sh_entsize),	\
    nullcopy))))))))))
#define copy_sym_11(e,io,seq)		\
    seq(copy_word(e,io,st_name),	\
    seq(copy_byte(e,io,st_info),	\
    seq(copy_byte(e,io,st_other),	\
    seq(copy_half(e,io,st_shndx),	\
    seq(copy_addr(e,io,st_value),	\
    seq(copy_xword(e,io,st_size),	\
    nullcopy))))))

#define nullcopy /**/

static size_t
byte_copy(unsigned char *dst, const unsigned char *src, size_t n) {
    if (n && dst && dst != src) {
#if HAVE_BROKEN_MEMMOVE
	size_t i;

	if (dst >= src + n || dst + n <= src) {
	    memcpy(dst, src, n);
	}
	else if (dst < src) {
	    for (i = 0; i < n; i++) {
		dst[i] = src[i];
	    }
	}
	else {
	    for (i = n; --i; ) {
		dst[i] = src[i];
	    }
	}
#else /* HAVE_BROKEN_MEMMOVE */
	memmove(dst, src, n);
#endif /* HAVE_BROKEN_MEMMOVE */
    }
    return n;
}

static void
array_copy(unsigned char *dst, size_t dlen, const unsigned char *src, size_t slen) {
    byte_copy(dst, src, dlen < slen ? dlen : slen);
    if (dlen > slen) {
	memset(dst + slen, 0, dlen - slen);
    }
}

/*
 * instantiate copy functions
 */
copy_type(addr_64,_,Elf64_Addr,copy_addr_11)
copy_type(half_64,_,Elf64_Half,copy_half_11)
copy_type(off_64,_,Elf64_Off,copy_off_11)
copy_type(sword_64,_,Elf64_Sword,copy_sword_11)
copy_type(word_64,_,Elf64_Word,copy_word_11)
copy_type(sxword_64,_,Elf64_Sxword,copy_sxword_11)
copy_type(xword_64,_,Elf64_Xword,copy_xword_11)
copy_type(dyn_64,11,Elf64_Dyn,copy_dyn_11)
copy_type(ehdr_64,11,Elf64_Ehdr,copy_ehdr_11)
copy_type(phdr_64,11,Elf64_Phdr,copy_phdr_11)
copy_type(rela_64,11,Elf64_Rela,copy_rela_11)
copy_type(rel_64,11,Elf64_Rel,copy_rel_11)
copy_type(shdr_64,11,Elf64_Shdr,copy_shdr_11)
copy_type(sym_64,11,Elf64_Sym,copy_sym_11)

/*
 * GNU hash uses a non-uniform entity size on 64-bit platforms
 * -- four 32-bit words are followed by a variable number of 64-bit
 * words and then by a variable number of 32-bit words
 */
#define copy_ghash_e_io(name,e,io,t32from,t32to,copy32,t64from,t64to,copy64)	\
    static size_t							\
    Cat3(name,_,io)(unsigned char *dst, const unsigned char *src, size_t n) {	\
	size_t size = 0;						\
									\
	do {								\
	    const int swap_tom = 1;					\
	    const int swap_tof = 0;					\
	    const int swap = Cat2(swap_,io);				\
	    const t32from *head;					\
	    const t64from *mask;					\
	    const t32from *hash;					\
	    t32to *headto;						\
	    t64to *maskto;						\
	    t32to *hashto;						\
	    size_t maskc;						\
	    size_t hashc;						\
	    size_t off;							\
	    __libelf_u64_t tmp64;					\
									\
	    if (!n)							\
		break;							\
									\
	    off = 0;							\
									\
	    head = (const t32from*)src;					\
	    maskc = 0;							\
	    if (n >= 3 * sizeof(t32from)) {				\
		if (swap)						\
		    maskc = Cat3(__load_,u32,e)(head[2]);		\
		else							\
		    maskc = head[2];					\
	    }								\
									\
	    if (!dst) {							\
		off = 4 * sizeof(t32from);				\
		if (off > n)						\
		    off = n;						\
		n -= off;						\
		size += off / sizeof(t32from) * sizeof(t32to);		\
		if (maskc * sizeof(t64from) > n)			\
		    maskc = n / sizeof(t64from);			\
		n -= maskc * sizeof(t64from);				\
		size += maskc * sizeof(t64to);				\
		size += n / sizeof(t32from) * sizeof(t32to);		\
		break;							\
	    }								\
									\
	    headto = (t32to*)dst;					\
	    {								\
		const t32from *from = head;				\
		t32to *to = headto;					\
		size_t i;						\
									\
		for (i = 0; i < 4; i++) {				\
		    if (off + sizeof(t32from) > n)			\
			break;						\
		    copy32(e,io,seq_forw)				\
		    from++;						\
		    to++;						\
		}							\
		off += i * sizeof(t32from);				\
		size += i * sizeof(t32to);				\
	    }								\
									\
	    if (off < 4 * sizeof(t32from))				\
		break;							\
									\
	    mask = (const t64from*)(src + off);				\
	    maskto = (t64to*)(dst + size);				\
	    {								\
		const t64from *from = mask;				\
		t64to *to = maskto;					\
		size_t i;						\
									\
		for (i = 0; i < maskc; i++) {				\
		    if (off + sizeof(t64from) > n)			\
			break;						\
		    if (dst)						\
			copy64(e,io,seq_forw)				\
		    from++;						\
		    to++;						\
		}							\
		off += i * sizeof(t64from);				\
		size += i * sizeof(t64to);				\
	    }								\
									\
	    if (off < 4 * sizeof(t32from) + maskc * sizeof(t64from))	\
		break;							\
									\
	    hashc = (n - off) / sizeof(t32from);			\
									\
	    hash = (const t32from*)(src + off);				\
	    hashto = (t32to*)(dst + size);				\
	    {								\
		const t32from *from = hash;				\
		t32to *to = hashto;					\
		size_t i;						\
									\
		for (i = 0; i < hashc; i++) {				\
		    if (off + sizeof(t32from) > n)			\
			break;						\
		    if (dst)						\
			copy32(e,io,seq_forw)				\
		    from++;						\
		    to++;						\
		}							\
		off += i * sizeof(t32from);				\
		size += i * sizeof(t32to);				\
	    }								\
									\
	} while (0);							\
									\
	return size;							\
    }

#define copy_ghash_e(name,e,type32,copy32,type64,copy64)		\
    copy_ghash_e_io(name,e,tom,Cat2(__ext_,type32),type32,copy32,Cat2(__ext_,type64),type64,copy64)	\
    copy_ghash_e_io(name,e,tof,type32,Cat2(__ext_,type32),copy32,type64,Cat2(__ext_,type64),copy64)

#define copy_ghash(name,version,type32,copy32,type64,copy64)		\
    copy_ghash_e(Cat3(name,L,version),L,type32,copy32,type64,copy64)	\
    copy_ghash_e(Cat3(name,M,version),M,type32,copy32,type64,copy64)

copy_ghash(ghash_64,_,Elf64_Word,copy_word_11,Elf64_Xword,copy_xword_11)

typedef size_t (*xlator)(unsigned char*, const unsigned char*, size_t);
typedef xlator xltab[ELF_T_NUM][2];

/*
 * translation table (64-bit, version 1 -> version 1)
 */
#if PIC
static xltab
#else /* PIC */
static const xltab
#endif /* PIC */
xlate64_11[/*encoding*/] = {
    {
	{ byte_copy,        byte_copy       },
	{ addr_64L__tom,    addr_64L__tof   },
	{ dyn_64L11_tom,    dyn_64L11_tof   },
	{ ehdr_64L11_tom,   ehdr_64L11_tof  },
	{ half_64L__tom,    half_64L__tof   },
	{ off_64L__tom,     off_64L__tof    },
	{ phdr_64L11_tom,   phdr_64L11_tof  },
	{ rela_64L11_tom,   rela_64L11_tof  },
	{ rel_64L11_tom,    rel_64L11_tof   },
	{ shdr_64L11_tom,   shdr_64L11_tof  },
	{ sword_64L__tom,   sword_64L__tof  },
	{ sym_64L11_tom,    sym_64L11_tof   },
	{ word_64L__tom,    word_64L__tof   },
	{ sxword_64L__tom,  sxword_64L__tof },
	{ xword_64L__tom,   xword_64L__tof  },
#if __LIBELF_SYMBOL_VERSIONS
	{ _elf_verdef_64L11_tom,  _elf_verdef_64L11_tof  },
	{ _elf_verneed_64L11_tom, _elf_verneed_64L11_tof },
#else /* __LIBELF_SYMBOL_VERSIONS */
	{ 0,                0               },
	{ 0,                0               },
#endif /* __LIBELF_SYMBOL_VERSIONS */
	{ ghash_64L__tom,   ghash_64L__tof  },
    },
    {
	{ byte_copy,        byte_copy       },
	{ addr_64M__tom,    addr_64M__tof   },
	{ dyn_64M11_tom,    dyn_64M11_tof   },
	{ ehdr_64M11_tom,   ehdr_64M11_tof  },
	{ half_64M__tom,    half_64M__tof   },
	{ off_64M__tom,     off_64M__tof    },
	{ phdr_64M11_tom,   phdr_64M11_tof  },
	{ rela_64M11_tom,   rela_64M11_tof  },
	{ rel_64M11_tom,    rel_64M11_tof   },
	{ shdr_64M11_tom,   shdr_64M11_tof  },
	{ sword_64M__tom,   sword_64M__tof  },
	{ sym_64M11_tom,    sym_64M11_tof   },
	{ word_64M__tom,    word_64M__tof   },
	{ sxword_64M__tom,  sxword_64M__tof },
	{ xword_64M__tom,   xword_64M__tof  },
#if __LIBELF_SYMBOL_VERSIONS
	{ _elf_verdef_64M11_tom,  _elf_verdef_64M11_tof  },
	{ _elf_verneed_64M11_tom, _elf_verneed_64M11_tof },
#else /* __LIBELF_SYMBOL_VERSIONS */
	{ 0,                0               },
	{ 0,                0               },
#endif /* __LIBELF_SYMBOL_VERSIONS */
	{ ghash_64M__tom,   ghash_64M__tof  },
    },
};

/*
 * main translation table (64-bit)
 */
#if PIC
static xltab*
#else /* PIC */
static const xltab *const
#endif /* PIC */
xlate64[EV_CURRENT - EV_NONE][EV_CURRENT - EV_NONE] = {
    { xlate64_11, },
};

#define translator(sv,dv,enc,type,d)	\
    (xlate64[(sv) - EV_NONE - 1]	\
	    [(dv) - EV_NONE - 1]	\
	    [(enc) - ELFDATA2LSB]	\
	    [(type) - ELF_T_BYTE]	\
	    [d])

/*
 * destination buffer size
 */
size_t
_elf64_xltsize(const Elf_Data *src, unsigned dv, unsigned encode, int tof) {
    Elf_Type type = src->d_type;
    unsigned sv = src->d_version;
    xlator op;

    if (!valid_version(sv) || !valid_version(dv)) {
	seterr(ERROR_UNKNOWN_VERSION);
	return (size_t)-1;
    }
    if (tof) {
	/*
	 * Encoding doesn't really matter (the translator only looks at
	 * the source, which resides in memory), but we need a proper
	 * encoding to select a translator...
	 */
	encode = ELFDATA2LSB;
    }
    else if (!valid_encoding(encode)) {
	seterr(ERROR_UNKNOWN_ENCODING);
	return (size_t)-1;
    }
    if (!valid_type(type)) {
	seterr(ERROR_UNKNOWN_TYPE);
	return (size_t)-1;
    }
    if (!(op = translator(sv, dv, encode, type, tof))) {
	seterr(ERROR_UNKNOWN_TYPE);
	return (size_t)-1;
    }
    return (*op)(NULL, src->d_buf, src->d_size);
}

/*
 * direction-independent translation
 */
static Elf_Data*
elf64_xlate(Elf_Data *dst, const Elf_Data *src, unsigned encode, int tof) {
    Elf_Type type;
    int dv;
    int sv;
    size_t dsize;
    size_t tmp;
    xlator op;

    if (!src || !dst) {
	return NULL;
    }
    if (!src->d_buf || !dst->d_buf) {
	seterr(ERROR_NULLBUF);
	return NULL;
    }
    if (!valid_encoding(encode)) {
	seterr(ERROR_UNKNOWN_ENCODING);
	return NULL;
    }
    sv = src->d_version;
    dv = dst->d_version;
    if (!valid_version(sv) || !valid_version(dv)) {
	seterr(ERROR_UNKNOWN_VERSION);
	return NULL;
    }
    type = src->d_type;
    if (!valid_type(type)) {
	seterr(ERROR_UNKNOWN_TYPE);
	return NULL;
    }
    op = translator(sv, dv, encode, type, tof);
    if (!op) {
	seterr(ERROR_UNKNOWN_TYPE);
	return NULL;
    }
    dsize = (*op)(NULL, src->d_buf, src->d_size);
    if (dsize == (size_t)-1) {
	return NULL;
    }
    if (dst->d_size < dsize) {
	seterr(ERROR_DST2SMALL);
	return NULL;
    }
    if (dsize) {
	tmp = (*op)(dst->d_buf, src->d_buf, src->d_size);
	if (tmp == (size_t)-1) {
	    return NULL;
	}
	elf_assert(tmp == dsize);
    }
    dst->d_size = dsize;
    dst->d_type = type;
    return dst;
}

/*
 * finally, the "official" translation functions
 */
Elf_Data*
elf64_xlatetom(Elf_Data *dst, const Elf_Data *src, unsigned encode) {
    return elf64_xlate(dst, src, encode, 0);
}

Elf_Data*
elf64_xlatetof(Elf_Data *dst, const Elf_Data *src, unsigned encode) {
    return elf64_xlate(dst, src, encode, 1);
}

Elf_Data*
gelf_xlatetom(Elf *elf, Elf_Data *dst, const Elf_Data *src, unsigned encode) {
    if (elf) {
	if (elf->e_kind != ELF_K_ELF) {
	    seterr(ERROR_NOTELF);
	}
	else if (elf->e_class == ELFCLASS32) {
	    return elf32_xlatetom(dst, src, encode);
	}
	else if (elf->e_class == ELFCLASS64) {
	    return elf64_xlatetom(dst, src, encode);
	}
	else if (valid_class(elf->e_class)) {
	    seterr(ERROR_UNIMPLEMENTED);
	}
	else {
	    seterr(ERROR_UNKNOWN_CLASS);
	}
    }
    return NULL;
}

Elf_Data*
gelf_xlatetof(Elf *elf, Elf_Data *dst, const Elf_Data *src, unsigned encode) {
    if (elf) {
	if (elf->e_kind != ELF_K_ELF) {
	    seterr(ERROR_NOTELF);
	}
	else if (elf->e_class == ELFCLASS32) {
	    return elf32_xlatetof(dst, src, encode);
	}
	else if (elf->e_class == ELFCLASS64) {
	    return elf64_xlatetof(dst, src, encode);
	}
	else if (valid_class(elf->e_class)) {
	    seterr(ERROR_UNIMPLEMENTED);
	}
	else {
	    seterr(ERROR_UNKNOWN_CLASS);
	}
    }
    return NULL;
}

#endif /* __LIBELF64__ */
