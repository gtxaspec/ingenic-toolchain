#include "./jzmxu128.h"
#include <mxu2.h>
v4f32 v4f32_src0, v4f32_src1, v4f32_dest;
v2f64 v2f64_src0, v2f64_src1, v2f64_dest;

v16i8 v16i8_src0, v16i8_src1, v16i8_src2, v16i8_dest;
v8i16 v8i16_src0, v8i16_src1, v8i16_dest;
v4i32 v4i32_src0, v4i32_src1, v4i32_dest;
v2i64 v2i64_src0, v2i64_src1, v2i64_dest;

v16u8 v16u8_src0, v16u8_src1, v16u8_dest;
v8u16 v8u16_src0, v8u16_src1, v8u16_dest;
v4u32 v4u32_src0, v4u32_src1, v4u32_dest;
v2u64 v2u64_src0, v2u64_src1, v2u64_dest;


void main ()
{

	BNEZ(16b, v16i8_src0, 2044);
	BNEZ(8h, v8i16_src0, -2048);

	LABEL(test1);

	BEQZ(4w, v4i32_src0, test1);
	BEQZ(4w, v4i32_src0, 2044);
	BEQZ(2d, v2i64_src0, -2048);
	BNEZ1Q(v16i8_src0, 2044);
	BEQZ1Q(v16i8_src0, -2048);

	CEQ(b, v16i8_dest, v16i8_src0, v16i8_src1);
	CEQ(h, v8i16_dest, v8i16_src0, v8i16_src1);
	CEQ(w, v4i32_dest, v4i32_src0, v4i32_src1);
	CEQ(d, v2i64_dest, v2i64_src0, v2i64_src1);

	CEQZ(b, v16i8_dest, v16i8_src0);
	CEQZ(h, v8i16_dest, v8i16_src0);
	CEQZ(w, v4i32_dest, v4i32_src0);
	CEQZ(d, v2i64_dest, v2i64_src0);

	CNE(b, v16i8_dest, v16i8_src0, v16i8_src1);
	CNE(h, v8i16_dest, v8i16_src0, v8i16_src1);
	CNE(w, v4i32_dest, v4i32_src0, v4i32_src1);
	CNE(d, v2i64_dest, v2i64_src0, v2i64_src1);

	CNEZ(b, v16i8_dest, v16i8_src0);
	CNEZ(h, v8i16_dest, v8i16_src0);
	CNEZ(w, v4i32_dest, v4i32_src0);
	CNEZ(d, v2i64_dest, v2i64_src0);

	CLES(b, v16i8_dest, v16i8_src0, v16i8_src1);
	CLES(h, v8i16_dest, v8i16_src0, v8i16_src1);
	CLES(w, v4i32_dest, v4i32_src0, v4i32_src1);
	CLES(d, v2i64_dest, v2i64_src0, v2i64_src1);

	CLEU(b, v16i8_dest, v16i8_src0, v16i8_src1);
	CLEU(h, v8i16_dest, v8i16_src0, v8i16_src1);
	CLEU(w, v4i32_dest, v4i32_src0, v4i32_src1);
	CLEU(d, v2i64_dest, v2i64_src0, v2i64_src1);

	CLEZ(b, v16i8_dest, v16i8_src0);
	CLEZ(h, v8i16_dest, v8i16_src0);
	CLEZ(w, v4i32_dest, v4i32_src0);
	CLEZ(d, v2i64_dest, v2i64_src0);

	CLTS(b, v16i8_dest, v16i8_src0, v16i8_src1);
	CLTS(h, v8i16_dest, v8i16_src0, v8i16_src1);
	CLTS(w, v4i32_dest, v4i32_src0, v4i32_src1);
	CLTS(d, v2i64_dest, v2i64_src0, v2i64_src1);

	CLTU(b, v16i8_dest, v16i8_src0, v16i8_src1);
	CLTU(h, v8i16_dest, v8i16_src0, v8i16_src1);
	CLTU(w, v4i32_dest, v4i32_src0, v4i32_src1);
	CLTU(d, v2i64_dest, v2i64_src0, v2i64_src1);

	CLTZ(b, v16i8_dest, v16i8_src0);
	CLTZ(h, v8i16_dest, v8i16_src0);
	CLTZ(w, v4i32_dest, v4i32_src0);
	CLTZ(d, v2i64_dest, v2i64_src0);

	ADDA(b, v16i8_dest, v16i8_src0, v16i8_src1);
	ADDA(h, v8i16_dest, v8i16_src0, v8i16_src1);
	ADDA(w, v4i32_dest, v4i32_src0, v4i32_src1);
	ADDA(d, v2i64_dest, v2i64_src0, v2i64_src1);

	ADDAS(b, v16i8_dest, v16i8_src0, v16i8_src1);
	ADDAS(h, v8i16_dest, v8i16_src0, v8i16_src1);
	ADDAS(w, v4i32_dest, v4i32_src0, v4i32_src1);
	ADDAS(d, v2i64_dest, v2i64_src0, v2i64_src1);

	ADDSS(b, v16i8_dest, v16i8_src0, v16i8_src1);
	ADDSS(h, v8i16_dest, v8i16_src0, v8i16_src1);
	ADDSS(w, v4i32_dest, v4i32_src0, v4i32_src1);
	ADDSS(d, v2i64_dest, v2i64_src0, v2i64_src1);

	ADDUU(b, v16u8_dest, v16u8_src0, v16u8_src1);
	ADDUU(h, v8u16_dest, v8u16_src0, v8u16_src1);
	ADDUU(w, v4u32_dest, v4u32_src0, v4u32_src1);
	ADDUU(d, v2u64_dest, v2u64_src0, v2u64_src1);

	ADD(b, v16i8_dest, v16i8_src0, v16i8_src1);
	ADD(h, v8i16_dest, v8i16_src0, v8i16_src1);
	ADD(w, v4i32_dest, v4i32_src0, v4i32_src1);
	ADD(d, v2i64_dest, v2i64_src0, v2i64_src1);

	SUBSA(b, v16i8_dest, v16i8_src0, v16i8_src1);
	SUBSA(h, v8i16_dest, v8i16_src0, v8i16_src1);
	SUBSA(w, v4i32_dest, v4i32_src0, v4i32_src1);
	SUBSA(d, v2i64_dest, v2i64_src0, v2i64_src1);

	SUBUA(b, v16u8_dest, v16u8_src0, v16u8_src1);
	SUBUA(h, v8u16_dest, v8u16_src0, v8u16_src1);
	SUBUA(w, v4u32_dest, v4u32_src0, v4u32_src1);
	SUBUA(d, v2u64_dest, v2u64_src0, v2u64_src1);

	SUBSS(b, v16i8_dest, v16i8_src0, v16i8_src1);
	SUBSS(h, v8i16_dest, v8i16_src0, v8i16_src1);
	SUBSS(w, v4i32_dest, v4i32_src0, v4i32_src1);
	SUBSS(d, v2i64_dest, v2i64_src0, v2i64_src1);

	SUBUU(b, v16u8_dest, v16u8_src0, v16u8_src1);
	SUBUU(h, v8u16_dest, v8u16_src0, v8u16_src1);
	SUBUU(w, v4u32_dest, v4u32_src0, v4u32_src1);
	SUBUU(d, v2u64_dest, v2u64_src0, v2u64_src1);

	SUBUS(b, v16i8_dest, v16u8_src0, v16u8_src1);
	SUBUS(h, v8i16_dest, v8u16_src0, v8u16_src1);
	SUBUS(w, v4i32_dest, v4u32_src0, v4u32_src1);
	SUBUS(d, v2i64_dest, v2u64_src0, v2u64_src1);

	SUB(b, v16i8_dest, v16i8_src0, v16i8_src1);
	SUB(h, v8i16_dest, v8i16_src0, v8i16_src1);
	SUB(w, v4i32_dest, v4i32_src0, v4i32_src1);
	SUB(d, v2i64_dest, v2i64_src0, v2i64_src1);

	AVES(b, v16i8_dest, v16i8_src0, v16i8_src1);
	AVES(h, v8i16_dest, v8i16_src0, v8i16_src1);
	AVES(w, v4i32_dest, v4i32_src0, v4i32_src1);
	AVES(d, v2i64_dest, v2i64_src0, v2i64_src1);

	AVEU(b, v16u8_dest, v16u8_src0, v16u8_src1);
	AVEU(h, v8u16_dest, v8u16_src0, v8u16_src1);
	AVEU(w, v4u32_dest, v4u32_src0, v4u32_src1);
	AVEU(d, v2u64_dest, v2u64_src0, v2u64_src1);

	AVERS(b, v16i8_dest, v16i8_src0, v16i8_src1);
	AVERS(h, v8i16_dest, v8i16_src0, v8i16_src1);
	AVERS(w, v4i32_dest, v4i32_src0, v4i32_src1);
	AVERS(d, v2i64_dest, v2i64_src0, v2i64_src1);

	AVERU(b, v16u8_dest, v16u8_src0, v16u8_src1);
	AVERU(h, v8u16_dest, v8u16_src0, v8u16_src1);
	AVERU(w, v4u32_dest, v4u32_src0, v4u32_src1);
	AVERU(d, v2u64_dest, v2u64_src0, v2u64_src1);

	DIVS(b, v16i8_dest, v16i8_src0, v16i8_src1);
	DIVS(h, v8i16_dest, v8i16_src0, v8i16_src1);
	DIVS(w, v4i32_dest, v4i32_src0, v4i32_src1);
	DIVS(d, v2i64_dest, v2i64_src0, v2i64_src1);

	DIVU(b, v16u8_dest, v16u8_src0, v16u8_src1);
	DIVU(h, v8u16_dest, v8u16_src0, v8u16_src1);
	DIVU(w, v4u32_dest, v4u32_src0, v4u32_src1);
	DIVU(d, v2u64_dest, v2u64_src0, v2u64_src1);

	MODS(b, v16i8_dest, v16i8_src0, v16i8_src1);
	MODS(h, v8i16_dest, v8i16_src0, v8i16_src1);
	MODS(w, v4i32_dest, v4i32_src0, v4i32_src1);
	MODS(d, v2i64_dest, v2i64_src0, v2i64_src1);

	MODU(b, v16u8_dest, v16u8_src0, v16u8_src1);
	MODU(h, v8u16_dest, v8u16_src0, v8u16_src1);
	MODU(w, v4u32_dest, v4u32_src0, v4u32_src1);
	MODU(d, v2u64_dest, v2u64_src0, v2u64_src1);

	MADD(b, v16i8_dest, v16i8_src0, v16i8_src1);
	MADD(h, v8i16_dest, v8i16_src0, v8i16_src1);
	MADD(w, v4i32_dest, v4i32_src0, v4i32_src1);
	MADD(d, v2i64_dest, v2i64_src0, v2i64_src1);

	MSUB(b, v16i8_dest, v16i8_src0, v16i8_src1);
	MSUB(h, v8i16_dest, v8i16_src0, v8i16_src1);
	MSUB(w, v4i32_dest, v4i32_src0, v4i32_src1);
	MSUB(d, v2i64_dest, v2i64_src0, v2i64_src1);

	MUL(b, v16i8_dest, v16i8_src0, v16i8_src1);
	MUL(h, v8i16_dest, v8i16_src0, v8i16_src1);
	MUL(w, v4i32_dest, v4i32_src0, v4i32_src1);
	MUL(d, v2i64_dest, v2i64_src0, v2i64_src1);

	MAXA(b, v16i8_dest, v16i8_src0, v16i8_src1);
	MAXA(h, v8i16_dest, v8i16_src0, v8i16_src1);
	MAXA(w, v4i32_dest, v4i32_src0, v4i32_src1);
	MAXA(d, v2i64_dest, v2i64_src0, v2i64_src1);

	MAXS(b, v16i8_dest, v16i8_src0, v16i8_src1);
	MAXS(h, v8i16_dest, v8i16_src0, v8i16_src1);
	MAXS(w, v4i32_dest, v4i32_src0, v4i32_src1);
	MAXS(d, v2i64_dest, v2i64_src0, v2i64_src1);

	MAXU(b, v16u8_dest, v16u8_src0, v16u8_src1);
	MAXU(h, v8u16_dest, v8u16_src0, v8u16_src1);
	MAXU(w, v4u32_dest, v4u32_src0, v4u32_src1);
	MAXU(d, v2u64_dest, v2u64_src0, v2u64_src1);

	MINA(b, v16i8_dest, v16i8_src0, v16i8_src1);
	MINA(h, v8i16_dest, v8i16_src0, v8i16_src1);
	MINA(w, v4i32_dest, v4i32_src0, v4i32_src1);
	MINA(d, v2i64_dest, v2i64_src0, v2i64_src1);

	MINS(b, v16i8_dest, v16i8_src0, v16i8_src1);
	MINS(h, v8i16_dest, v8i16_src0, v8i16_src1);
	MINS(w, v4i32_dest, v4i32_src0, v4i32_src1);
	MINS(d, v2i64_dest, v2i64_src0, v2i64_src1);

	MINU(b, v16u8_dest, v16u8_src0, v16u8_src1);
	MINU(h, v8u16_dest, v8u16_src0, v8u16_src1);
	MINU(w, v4u32_dest, v4u32_src0, v4u32_src1);
	MINU(d, v2u64_dest, v2u64_src0, v2u64_src1);

	SATS(b, v16i8_dest, v16i8_src0, 7);
	SATS(h, v8i16_dest, v8i16_src0, 15);
	SATS(w, v4i32_dest, v4i32_src0, 31);
	SATS(d, v2i64_dest, v2i64_src0, 63);

	SATU(b, v16u8_dest, v16u8_src0, 7);
	SATU(h, v8u16_dest, v8u16_src0, 15);
	SATU(w, v4u32_dest, v4u32_src0, 31);
	SATU(d, v2u64_dest, v2u64_src0, 63);

	DOTPS(h, v8i16_dest, v8i16_src0, v8i16_src1);
	DOTPS(w, v4i32_dest, v4i32_src0, v4i32_src1);
	DOTPS(d, v2i64_dest, v2i64_src0, v2i64_src1);

	DOTPU(h, v8u16_dest, v8u16_src0, v8u16_src1);
	DOTPU(w, v4u32_dest, v4u32_src0, v4u32_src1);
	DOTPU(d, v2u64_dest, v2u64_src0, v2u64_src1);

	DADDS(h, v8i16_dest, v8i16_src0, v8i16_src1);
	DADDS(w, v4i32_dest, v4i32_src0, v4i32_src1);
	DADDS(d, v2i64_dest, v2i64_src0, v2i64_src1);

	DADDU(h, v8u16_dest, v8u16_src0, v8u16_src1);
	DADDU(w, v4u32_dest, v4u32_src0, v4u32_src1);
	DADDU(d, v2u64_dest, v2u64_src0, v2u64_src1);

	DSUBS(h, v8i16_dest, v8i16_src0, v8i16_src1);
	DSUBS(w, v4i32_dest, v4i32_src0, v4i32_src1);
	DSUBS(d, v2i64_dest, v2i64_src0, v2i64_src1);

	DSUBU(h, v8u16_dest, v8u16_src0, v8u16_src1);
	DSUBU(w, v4u32_dest, v4u32_src0, v4u32_src1);
	DSUBU(d, v2u64_dest, v2u64_src0, v2u64_src1);

	LOC(b, v16i8_dest, v16i8_src0);
	LOC(h, v8i16_dest, v8i16_src0);
	LOC(w, v4i32_dest, v4i32_src0);
	LOC(d, v2i64_dest, v2i64_src0);

	LZC(b, v16i8_dest, v16i8_src0);
	LZC(h, v8i16_dest, v8i16_src0);
	LZC(w, v4i32_dest, v4i32_src0);
	LZC(d, v2i64_dest, v2i64_src0);

	BCNT(b, v16i8_dest, v16i8_src0);
	BCNT(h, v8i16_dest, v8i16_src0);
	BCNT(w, v4i32_dest, v4i32_src0);
	BCNT(d, v2i64_dest, v2i64_src0);

	ANDV(v16i8_dest, v16i8_src0, v16i8_src1);

	ANDIB(v16i8_dest, v16i8_src0, 2);

	NORV(v16i8_dest, v16i8_src0, v16i8_src1);
	NORIB(v16i8_dest, v16i8_src0, 2);

	ORV(v16i8_dest, v16i8_src0, v16i8_src1);
	ORIB(v16i8_dest, v16i8_src0, 2);

	XORV(v16i8_dest, v16i8_src0, v16i8_src1);
	XORIB(v16i8_dest, v16i8_src0, 2);

	BSELV(v16i8_dest, v16i8_src0, v16i8_src1, v16i8_src2);

	FADD(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FADD(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FSUB(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FSUB(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FMUL(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FMUL(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FDIV(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FDIV(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FSQRT(w, v4f32_dest, v4f32_src0);
	FSQRT(d, v2f64_dest, v2f64_src0);

	FMADD(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FMADD(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FMSUB(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FMSUB(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FMAX(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FMAX(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FMAXA(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FMAXA(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FMIN(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FMIN(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FMINA(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FMINA(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FCLASS(w, v4f32_dest, v4f32_src0);
	FCLASS(d, v2f64_dest, v2f64_src0);

	FCEQ(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FCEQ(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FCLE(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FCLE(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FCLT(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FCLT(d, v2f64_dest, v2f64_src0, v2f64_src1);

	FCOR(w, v4f32_dest, v4f32_src0, v4f32_src1);
	FCOR(d, v2f64_dest, v2f64_src0, v2f64_src1);

	VCVTHS(v4f32_dest, v4f32_src0, v4f32_src1);
	VCVTSD(v2f64_dest, v2f64_src0, v2f64_src1);

	VCVTESH(v4f32_dest, v4f32_src0);
	VCVTEDS(v2f64_dest, v2f64_src0);

	VCVTOSH(v4f32_dest, v4f32_src0);
	VCVTODS(v2f64_dest, v2f64_src0);

	VCVTSSW(v4f32_dest, v4i32_src0);
	VCVTSDL(v2f64_dest, v2i64_src0);

	VCVTUSW(v4f32_dest, v4u32_src0);
	VCVTUDL(v2f64_dest, v2u64_src0);

	VCVTSWS(v4i32_dest, v4f32_src0);
	VCVTSLD(v2i64_dest, v2f64_src0);

	VCVTUWS(v4u32_dest, v4f32_src0);
	VCVTULD(v2u64_dest, v2f64_src0);

	VCVTRWS(v4i32_dest, v4f32_src0);
	VCVTRLD(v2i64_dest, v2f64_src0);

	VTRUNCSWS(v4i32_dest, v4f32_src0);
	VTRUNCSLD(v2i64_dest, v2f64_src0);

	VTRUNCUWS(v4u32_dest, v4f32_src0);
	VTRUNCULD(v2u64_dest, v2f64_src0);

	VTRUNCUWS(v4u32_dest, v4f32_src0);
	VTRUNCULD(v2u64_dest, v2f64_src0);

	VCVTQESH(v4f32_dest, v8i16_src0);
	VCVTQEDW(v2f64_dest, v4i32_src0);

	VCVTQOSH(v4f32_dest, v8i16_src0);
	VCVTQODW(v2f64_dest, v4i32_src0);

	VCVTQHS(v8i16_dest, v4f32_src0, v4f32_src1);
	VCVTQWD(v4i32_dest, v2f64_src0, v2f64_src1);

	MADDQ(h, v8i16_dest, v8i16_src0, v8i16_src1);
	MADDQ(w, v4i32_dest, v4i32_src0, v4i32_src1);

	MADDQR(h, v8i16_dest, v8i16_src0, v8i16_src1);
	MADDQR(w, v4i32_dest, v4i32_src0, v4i32_src1);

	MSUBQ(h, v8i16_dest, v8i16_src0, v8i16_src1);
	MSUBQ(w, v4i32_dest, v4i32_src0, v4i32_src1);

	MSUBQR(h, v8i16_dest, v8i16_src0, v8i16_src1);
	MSUBQR(w, v4i32_dest, v4i32_src0, v4i32_src1);

	MULQ(h, v4i32_dest, v8i16_src0, v8i16_src1);
	MULQ(w, v2i64_dest, v4i32_src0, v4i32_src1);

	MULQR(h, v4i32_dest, v8i16_src0, v8i16_src1);
	MULQR(w, v2i64_dest, v4i32_src0, v4i32_src1);

	SLL(b, v16i8_dest, v16i8_src0, v16i8_src1);
	SLL(h, v8i16_dest, v8i16_src0, v8i16_src1);
	SLL(w, v4i32_dest, v4i32_src0, v4i32_src1);
	SLL(d, v2i64_dest, v2i64_src0, v2i64_src1);

	SLLI(b, v16i8_dest, v16i8_src0, 7);
	SLLI(h, v8i16_dest, v8i16_src0, 15);
	SLLI(w, v4i32_dest, v4i32_src0, 31);
	SLLI(d, v2i64_dest, v2i64_src0, 63);

	SRA(b, v16i8_dest, v16i8_src0, v16i8_src1);
	SRA(h, v8i16_dest, v8i16_src0, v8i16_src1);
	SRA(w, v4i32_dest, v4i32_src0, v4i32_src1);
	SRA(d, v2i64_dest, v2i64_src0, v2i64_src1);

	SRAI(b, v16i8_dest, v16i8_src0, 7);
	SRAI(h, v8i16_dest, v8i16_src0, 15);
	SRAI(w, v4i32_dest, v4i32_src0, 31);
	SRAI(d, v2i64_dest, v2i64_src0, 63);

	SRAR(b, v16i8_dest, v16i8_src0, v16i8_src1);
	SRAR(h, v8i16_dest, v8i16_src0, v8i16_src1);
	SRAR(w, v4i32_dest, v4i32_src0, v4i32_src1);
	SRAR(d, v2i64_dest, v2i64_src0, v2i64_src1);

	SRARI(b, v16i8_dest, v16i8_src0, 7);
	SRARI(h, v8i16_dest, v8i16_src0, 15);
	SRARI(w, v4i32_dest, v4i32_src0, 31);
	SRARI(d, v2i64_dest, v2i64_src0, 63);

	SRL(b, v16i8_dest, v16i8_src0, v16i8_src1);
	SRL(h, v8i16_dest, v8i16_src0, v8i16_src1);
	SRL(w, v4i32_dest, v4i32_src0, v4i32_src1);
	SRL(d, v2i64_dest, v2i64_src0, v2i64_src1);

	SRLI(b, v16i8_dest, v16i8_src0, 7);
	SRLI(h, v8i16_dest, v8i16_src0, 15);
	SRLI(w, v4i32_dest, v4i32_src0, 31);
	SRLI(d, v2i64_dest, v2i64_src0, 63);

	SRLR(b, v16i8_dest, v16i8_src0, v16i8_src1);
	SRLR(h, v8i16_dest, v8i16_src0, v8i16_src1);
	SRLR(w, v4i32_dest, v4i32_src0, v4i32_src1);
	SRLR(d, v2i64_dest, v2i64_src0, v2i64_src1);

	SRLRI(b, v16i8_dest, v16i8_src0, 7);
	SRLRI(h, v8i16_dest, v8i16_src0, 15);
	SRLRI(w, v4i32_dest, v4i32_src0, 31);
	SRLRI(d, v2i64_dest, v2i64_src0, 63);

	SHUFV(v16i8_dest, v16i8_src0, v16i8_src1, v16i8_src2);

	int a = 2;
	INSFCPU(b, v16i8_dest, 15, a);
	INSFCPU(h, v8i16_dest, 7, a);
	INSFCPU(w, v4i32_dest, 3, a);

	float b = 1.23;
	double c = 2.34567;
 	INSFFPU(w, v4f32_dest, 3, b);
	INSFFPU(d, v2f64_dest, 1, c);

	INSFMXU(b, v16i8_dest, 15, v16i8_src1);
	INSFMXU(h, v8i16_dest, 7, v8i16_src1);
	INSFMXU(w, v4i32_dest, 3, v4i32_src1);
	INSFMXU(d, v2i64_dest, 1, v2i64_src1);

	int e;
	REPX(b, v16i8_dest, v16i8_src1, e);
	REPX(h, v8i16_dest, v8i16_src1, e);
	REPX(w, v4i32_dest, v4i32_src1, e);
	REPX(d, v2i64_dest, v2i64_src1, e);

	REPI(b, v16i8_dest, v16i8_src1, 15);
	REPI(h, v8i16_dest, v8i16_src1, 7);
	REPI(w, v4i32_dest, v4i32_src1, 3);
	REPI(d, v2i64_dest, v2i64_src1, 1);

	int dest;
	MTCPUS(b, dest, v16i8_src1, 15);
	MTCPUS(h, dest, v8i16_src1, 7);
	MTCPUS(w, dest, v4i32_src1, 3);

	unsigned int udest;
	MTCPUU(b, udest, v16u8_src1, 15);
	MTCPUU(h, udest, v8u16_src1, 7);
	MTCPUU(w, udest, v4u32_src1, 3);

	MFCPU(b, v16i8_dest, udest);
	MFCPU(h, v8i16_dest, udest);
	MFCPU(w, v4i32_dest, udest);

	double ddest = 34.5678;
	float fdest = 1.234;
	MTFPU(w, fdest, v4f32_src0, 3);
	MTFPU(d, ddest, v2f64_src0, 1);
	
	MFFPU(w, v4f32_src0, fdest);
	MFFPU(d, v2f64_src0, ddest);

	int t_mcd;
	int f_mcd;
	CTCMXU(1, t_mcd);
	CFCMXU(f_mcd, 31);

	int src[4] = {1, 2, 3, 4};
	LU1Q(v4i32_dest, src, 0);
	LU1QX(v4i32_dest, src, 0);

	LA1Q(v4i32_dest, src, 8176);
	LA1QX(v4i32_dest, src, 0);

	v4i32 v4i32_src3;
	SU1Q(v4i32_src3, src, 0);
	SU1QX(v4i32_src3, src, 0);

	SA1Q(v4i32_src3, src, -8192);
	SA1QX(v4i32_src3, src, 0);

	LI(b, v16i8_dest, 0xf);
	LI(h, v8i16_dest, 0xf);
	LI(w, v4i32_dest, 0xf);
	LI(d, v2i64_dest, 0xf);
}
