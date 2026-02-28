#include "./jzmxu32.h"
#include <mxu.h>


v1i32 v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3;
v2i16 v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3;
v4i8 v4i8_var0, v4i8_var1, v4i8_var2, v4i8_var3;

int rd, rs, rt;

char test1[12] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
char test12[12];
short test2[12] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
int test3[12] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};

char *v4i8_array = test1;
char *v4i8_array_r = test12;
short *v2i16_array = test2;
int *v1i32_array = test3;

void main()
{

#if 1
	S32LDDR(v4i8_var0, v4i8_array, 2044);
	S32STDR(v4i8_var0, v4i8_array, -2048);
	S32LDD(v1i32_var0, v1i32_array, 24);
	S32STD(v1i32_var0, v1i32_array, 24);
	S32LDDVR(v4i8_var0, v4i8_array, rs, 0);
	S32STDVR(v4i8_var0, v4i8_array, rs, 1);
	S32LDDV(v1i32_var0, v1i32_array, rs, 2);
	S32STDV(v1i32_var0, v1i32_array, rs, 2);
	S32LDIR(v4i8_var0, v4i8_array, -2048);
	S32SDIR(v4i8_var0, v4i8_array, 2044);
	S32LDI(v1i32_var0, v1i32_array, -2048);
	S32SDI(v1i32_var0, v1i32_array, 2044);
	S32LDIVR(v4i8_var0, v4i8_array, rs, 0);
	S32SDIVR(v4i8_var0, v4i8_array, rs, 0);
	S32LDIV(v1i32_var0, v1i32_array, rs, 2);
	S32SDIV(v1i32_var0, v1i32_array, rs, 1);
	LXW(rd, v1i32_array, rt, 0);
	S16LDD(v2i16_var0, v2i16_array, -512, 0);
	S16LDD(v2i16_var0, v2i16_array, 510, 3);
	S16LDI(v2i16_var0, v2i16_array, -512, 3);
	S16STD(v2i16_var0, v2i16_array, -512, 0);
	S16SDI(v2i16_var0, v2i16_array, 0x0, 1);
	LXH(rd, v2i16_array, rt, 0);
	LXHU(rd, v2i16_array, rt, 2);
	S8LDD(v4i8_var0, v4i8_array, -128, 0);
	S8LDI(v4i8_var0, v4i8_array, 127, 4);
	S8STD(v4i8_var0, v4i8_array, 127, 4);
	S8SDI(v4i8_var0, v4i8_array, 127, 0);
	LXB(rd, v4i8_array, rt, 0);
	LXBU(rd, v4i8_array, rt, 2);

	S32MUL(v1i32_var0, v1i32_var1, rs, rt);
	S32MULU(v1i32_var0, v1i32_var1, rs, rt);
	S32MADD(v1i32_var0, v1i32_var1, rs, rt);
	S32MADDU(v1i32_var0, v1i32_var1, rs, rt);
	S32MSUB(v1i32_var0, v1i32_var1, rs, rt);
	S32MSUBU(v1i32_var0, v1i32_var1, rs, rt);
	D16MUL_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MUL_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MUL_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MUL_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MULF_WW(v1i32_var0, v2i16_var0, v2i16_var1);
	D16MULF_LW(v1i32_var0, v2i16_var0, v2i16_var1);
	D16MULF_HW(v1i32_var0, v2i16_var0, v2i16_var1);
	D16MULF_XW(v1i32_var0, v2i16_var0, v2i16_var1);
	D16MULE_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MULE_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MULE_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MULE_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MAC_AA_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MAC_AA_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MAC_AA_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MAC_AA_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MAC_AS_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MAC_AS_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MAC_AS_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MAC_AS_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MAC_SA_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MAC_SA_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MAC_SA_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MAC_SA_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MAC_SS_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MAC_SS_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MAC_SS_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MAC_SS_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MACF_AA_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACF_AA_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACF_AA_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACF_AA_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MACF_AS_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACF_AS_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACF_AS_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACF_AS_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MACF_SA_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACF_SA_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACF_SA_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACF_SA_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MACF_SS_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACF_SS_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACF_SS_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACF_SS_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MACE_AA_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACE_AA_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACE_AA_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACE_AA_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MACE_AS_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACE_AS_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACE_AS_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACE_AS_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MACE_SA_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACE_SA_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACE_SA_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACE_SA_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MACE_SS_WW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACE_SS_LW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACE_SS_HW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	D16MACE_SS_XW(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	D16MADL_AA_WW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16MADL_AA_LW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16MADL_AA_HW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16MADL_AA_XW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);

	D16MADL_AS_WW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16MADL_AS_LW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16MADL_AS_HW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16MADL_AS_XW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);

	D16MADL_SA_WW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16MADL_SA_LW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16MADL_SA_HW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16MADL_SA_XW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);

	D16MADL_SS_WW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16MADL_SS_LW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16MADL_SS_HW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16MADL_SS_XW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);

	S16MAD_A_HH(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	S16MAD_A_LL(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	S16MAD_A_HL(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	S16MAD_A_LH(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	S16MAD_S_HH(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	S16MAD_S_LL(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	S16MAD_S_HL(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);
	S16MAD_S_LH(v1i32_var0, v2i16_var0, v2i16_var1, v1i32_var1);

	Q8MUL(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
	Q8MULSU(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);

	Q8MAC_AA(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
	Q8MAC_AS(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
	Q8MAC_SA(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
	Q8MAC_SS(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);

	Q8MACSU_AA(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
	Q8MACSU_AS(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
	Q8MACSU_SA(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
	Q8MACSU_SS(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);

	D32ADD_AA(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);
	D32ADD_AS(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);
	D32ADD_SA(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);
	D32ADD_SS(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);

	D32ADDC(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);

	D32ACC_AA(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);
	D32ACC_AS(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);
	D32ACC_SA(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);
	D32ACC_SS(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);

	D32ACCM_AA(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);
	D32ACCM_AS(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);
	D32ACCM_SA(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);
	D32ACCM_SS(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);

	D32ASUM_AA(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);
	D32ASUM_AS(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);
	D32ASUM_SA(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);
	D32ASUM_SS(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3);

	S32CPS(v1i32_var0, v1i32_var1, v1i32_var2);
	S32SLT(v1i32_var0, v1i32_var1, v1i32_var2);
	S32MOVZ(v1i32_var0, v1i32_var1, v1i32_var2);
	S32MOVN(v1i32_var0, v1i32_var1, v1i32_var2);

	Q16ADD_AA_WW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ADD_AA_LW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ADD_AA_HW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ADD_AA_XW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);

	Q16ADD_AS_WW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ADD_AS_LW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ADD_AS_HW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ADD_AS_XW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);

	Q16ADD_SA_WW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ADD_SA_LW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ADD_SA_HW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ADD_SA_XW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);

	Q16ADD_SS_WW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ADD_SS_LW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ADD_SS_HW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ADD_SS_XW(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);

	Q16ACC_AA(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ACC_AS(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ACC_SA(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ACC_SS(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);

	Q16ACCM_AA(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ACCM_AS(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ACCM_SA(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	Q16ACCM_SS(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);

	D16ASUM_AA(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16ASUM_AS(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16ASUM_SA(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	D16ASUM_SS(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);

	D16CPS(v2i16_var0, v2i16_var1, v2i16_var2);
	D16SLT(v2i16_var0, v2i16_var1, v2i16_var2);
	D16MOVZ(v2i16_var0, v2i16_var1, v2i16_var2);
	D16MOVN(v2i16_var0, v2i16_var1, v2i16_var2);
	D16AVG(v2i16_var0, v2i16_var1, v2i16_var2);
	D16AVGR(v2i16_var0, v2i16_var1, v2i16_var2);

 	Q8ADDE_AA(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
 	Q8ADDE_AS(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
 	Q8ADDE_SA(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
 	Q8ADDE_SS(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);

	Q8ACCE_AA(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
	Q8ACCE_AS(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
	Q8ACCE_SA(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);
	Q8ACCE_SS(v2i16_var0, v4i8_var0, v4i8_var1, v2i16_var1);

	D8SUM(v2i16_var0, v4i8_var0, v4i8_var1);
	D8SUMC(v2i16_var0, v4i8_var0, v4i8_var1);
	Q8ABD(v4i8_var0, v4i8_var1, v4i8_var2);
	Q8SLT(v4i8_var0, v4i8_var1, v4i8_var2);
	Q8SLTU(v4i8_var0, v4i8_var1, v4i8_var2);
	Q8MOVZ(v4i8_var0, v4i8_var1, v4i8_var2);
	Q8MOVN(v4i8_var0, v4i8_var1, v4i8_var2);
	Q8SAD(v1i32_var0, v4i8_var0, v4i8_var1, v1i32_var1);
	Q8AVG(v4i8_var0, v4i8_var1, v4i8_var2);
	Q8AVGR(v4i8_var0, v4i8_var1, v4i8_var2);

	D32SLL(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3, 15);
	D32SLR(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3, 0);
	D32SAR(v1i32_var0, v1i32_var1, v1i32_var2, v1i32_var3, 7);
	D32SARL(v2i16_var0, v1i32_var0, v1i32_var1, 15);
	D32SLLV(v1i32_var0, v1i32_var1, 0xff);
	D32SLRV(v1i32_var0, v1i32_var1, 0xff);
	D32SARV(v1i32_var0, v1i32_var1, rs);
	D32SARW(v2i16_var0, v1i32_var0, v1i32_var1, rt);
	Q16SLL(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3, 0);
	Q16SLR(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3, 15);
	Q16SAR(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3, 8);
	Q16SLLV(v2i16_var0, v2i16_var1, rt);
	Q16SLRV(v2i16_var0, v2i16_var1, 10);
	Q16SARV(v2i16_var0, v2i16_var1, rs);
	S32EXTR(v1i32_var0, v1i32_var1, rs, 31);
	S32EXTRV(v1i32_var0, v1i32_var1, rs, rt);

	S32MAX(v1i32_var0, v1i32_var1, v1i32_var2);
	S32MIN(v1i32_var0, v1i32_var1, v1i32_var2);
	D16MAX(v2i16_var0, v2i16_var1, v2i16_var2);
	D16MIN(v2i16_var0, v2i16_var1, v2i16_var2);
	Q8MAX(v4i8_var0, v4i8_var1, v4i8_var2);
	Q8MIN(v4i8_var0, v4i8_var1, v4i8_var2);

	S32AND(v1i32_var0, v1i32_var1, v1i32_var2);
	S32OR(v1i32_var0, v1i32_var1, v1i32_var2);
	S32XOR(v1i32_var0, v1i32_var1, v1i32_var2);
	S32NOR(v1i32_var0, v1i32_var1, v1i32_var2);

	S32M2I(v1i32_var0, rt);
	S32I2M(v1i32_var0, rs);

	S32SFL(v4i8_var0, v4i8_var1, v4i8_var2, v4i8_var3, 0);
	S32ALN(v4i8_var0, v4i8_var1, v4i8_var2, rs);
	S32ALNI(v4i8_var0, v4i8_var1, v4i8_var2, 3);
	Q16SAT(v4i8_var0, v2i16_var0, v2i16_var1);
	Q16SCOP(v2i16_var0, v2i16_var1, v2i16_var2, v2i16_var3);
	S32LUI(v4i8_var0, 0xf, 3);

	/* Q8MADL and Q8ADD is obsolete. */
	Q8MADL_AA(v4i8_var0, v4i8_var1, v4i8_var2, v4i8_var3);
	Q8MADL_AS(v4i8_var0, v4i8_var1, v4i8_var2, v4i8_var3);
	Q8MADL_SA(v4i8_var0, v4i8_var1, v4i8_var2, v4i8_var3);
	Q8MADL_SS(v4i8_var0, v4i8_var1, v4i8_var2, v4i8_var3);

	Q8ADD_AA(v4i8_var0, v4i8_var1, v4i8_var2);
	Q8ADD_AS(v4i8_var0, v4i8_var1, v4i8_var2);
	Q8ADD_SA(v4i8_var0, v4i8_var1, v4i8_var2);
	Q8ADD_SS(v4i8_var0, v4i8_var1, v4i8_var2);

#endif
	S32STDR(v4i8_var0, v4i8_array_r, 0);
	printf("%d, %d, %d, %d\n", v4i8_array_r[0], v4i8_array_r[1], v4i8_array_r[2], v4i8_array_r[3]);


}

