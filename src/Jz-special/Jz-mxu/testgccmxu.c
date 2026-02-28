#include "./jzmedia.h"

void __start()
{
    int src = 100, dst = 120;
#if 1
    D16MUL_WW(xr1,xr2,xr3,xr4);
    D16MUL_LW(xr5,xr6,xr7,xr8);
    D16MUL_HW(xr9,xr10,xr11,xr12);
    D16MUL_XW(xr13,xr14,xr15,xr0);

    D16MULF_WW(xr0,xr2,xr3);
    D16MULF_LW(xr5,xr6,xr7);
    D16MULF_HW(xr9,xr10,xr11);
    D16MULF_XW(xr13,xr14,xr15);

    D16MULE_WW(xr1,xr2,xr3,xr4);
    D16MULE_LW(xr5,xr6,xr7,xr8);
    D16MULE_HW(xr9,xr10,xr11,xr12);
    D16MULE_XW(xr13,xr14,xr15,xr0);

    D16MAC_AA_WW(xr1,xr2,xr3,xr4);
    D16MAC_AA_LW(xr5,xr6,xr7,xr8);
    D16MAC_AA_HW(xr9,xr10,xr11,xr12);
    D16MAC_AA_XW(xr13,xr14,xr15,xr0);

    D16MAC_AS_WW(xr1,xr2,xr3,xr4);
    D16MAC_AS_LW(xr5,xr6,xr7,xr8);
    D16MAC_AS_HW(xr9,xr10,xr11,xr12);
    D16MAC_AS_XW(xr13,xr14,xr15,xr0);

    D16MAC_SA_WW(xr1,xr2,xr3,xr4);
    D16MAC_SA_LW(xr5,xr6,xr7,xr8);
    D16MAC_SA_HW(xr9,xr10,xr11,xr12);
    D16MAC_SA_XW(xr13,xr14,xr15,xr0);

    D16MAC_SS_WW(xr1,xr2,xr3,xr4);
    D16MAC_SS_LW(xr5,xr6,xr7,xr8);
    D16MAC_SS_HW(xr9,xr10,xr11,xr12);
    D16MAC_SS_XW(xr13,xr14,xr15,xr0);

    D16MACF_AA_WW(xr1,xr2,xr3,xr4);
    D16MACF_AA_LW(xr5,xr6,xr7,xr8);
    D16MACF_AA_HW(xr9,xr10,xr11,xr12);
    D16MACF_AA_XW(xr13,xr14,xr15,xr0);

    D16MACF_AS_WW(xr1,xr2,xr3,xr4);
    D16MACF_AS_LW(xr5,xr6,xr7,xr8);
    D16MACF_AS_HW(xr9,xr10,xr11,xr12);
    D16MACF_AS_XW(xr13,xr14,xr15,xr0);

    D16MACF_SA_WW(xr1,xr2,xr3,xr4);
    D16MACF_SA_LW(xr5,xr6,xr7,xr8);
    D16MACF_SA_HW(xr9,xr10,xr11,xr12);
    D16MACF_SA_XW(xr13,xr14,xr15,xr0);

    D16MACF_SS_WW(xr1,xr2,xr3,xr4);
    D16MACF_SS_LW(xr5,xr6,xr7,xr8);
    D16MACF_SS_HW(xr9,xr10,xr11,xr12);
    D16MACF_SS_XW(xr13,xr14,xr15,xr0);

    D16MADL_AA_WW(xr1,xr2,xr3,xr4);
    D16MADL_AA_LW(xr5,xr6,xr7,xr8);
    D16MADL_AA_HW(xr9,xr10,xr11,xr12);
    D16MADL_AA_XW(xr13,xr14,xr15,xr0);

    D16MADL_AS_WW(xr1,xr2,xr3,xr4);
    D16MADL_AS_LW(xr5,xr6,xr7,xr8);
    D16MADL_AS_HW(xr9,xr10,xr11,xr12);
    D16MADL_AS_XW(xr13,xr14,xr15,xr0);

    D16MADL_SA_WW(xr1,xr2,xr3,xr4);
    D16MADL_SA_LW(xr5,xr6,xr7,xr8);
    D16MADL_SA_HW(xr9,xr10,xr11,xr12);
    D16MADL_SA_XW(xr13,xr14,xr15,xr0);

    D16MADL_SS_WW(xr1,xr2,xr3,xr4);
    D16MADL_SS_LW(xr5,xr6,xr7,xr8);
    D16MADL_SS_HW(xr9,xr10,xr11,xr12);
    D16MADL_SS_XW(xr13,xr14,xr15,xr0);

    S16MAD_A_HH(xr1,xr2,xr3,xr4);
    S16MAD_A_LL(xr5,xr6,xr7,xr8);
    S16MAD_A_HL(xr9,xr10,xr11,xr12);
    S16MAD_A_LH(xr13,xr14,xr15,xr0);

    S16MAD_S_HH(xr1,xr2,xr3,xr4);
    S16MAD_S_LL(xr5,xr6,xr7,xr8);
    S16MAD_S_HL(xr9,xr10,xr11,xr12);
    S16MAD_S_LH(xr13,xr14,xr15,xr0);

    Q16ADD_AA_WW(xr1,xr2,xr3,xr4);
    Q16ADD_AA_LW(xr5,xr6,xr7,xr8);
    Q16ADD_AA_HW(xr9,xr10,xr11,xr12);
    Q16ADD_AA_XW(xr13,xr14,xr15,xr0);

    Q16ADD_AS_WW(xr1,xr2,xr3,xr4);
    Q16ADD_AS_LW(xr5,xr6,xr7,xr8);
    Q16ADD_AS_HW(xr9,xr10,xr11,xr12);
    Q16ADD_AS_XW(xr13,xr14,xr15,xr0);

    Q16ADD_SA_WW(xr1,xr2,xr3,xr4);
    Q16ADD_SA_LW(xr5,xr6,xr7,xr8);
    Q16ADD_SA_HW(xr9,xr10,xr11,xr12);
    Q16ADD_SA_XW(xr13,xr14,xr15,xr0);

    Q16ADD_SS_WW(xr1,xr2,xr3,xr4);
    Q16ADD_SS_LW(xr5,xr6,xr7,xr8);
    Q16ADD_SS_HW(xr9,xr10,xr11,xr12);
    Q16ADD_SS_XW(xr13,xr14,xr15,xr0);

    D16MACE_AA_WW(xr1,xr2,xr3,xr4);
    D16MACE_AA_LW(xr5,xr6,xr7,xr8);
    D16MACE_AA_HW(xr9,xr10,xr11,xr12);
    D16MACE_AA_XW(xr13,xr14,xr15,xr0);

    D16MACE_AS_WW(xr1,xr2,xr3,xr4);
    D16MACE_AS_LW(xr5,xr6,xr7,xr8);
    D16MACE_AS_HW(xr9,xr10,xr11,xr12);
    D16MACE_AS_XW(xr13,xr14,xr15,xr0);

    D16MACE_SA_WW(xr1,xr2,xr3,xr4);
    D16MACE_SA_LW(xr5,xr6,xr7,xr8);
    D16MACE_SA_HW(xr9,xr10,xr11,xr12);
    D16MACE_SA_XW(xr13,xr14,xr15,xr0);

    D16MACE_SS_WW(xr1,xr2,xr3,xr4);
    D16MACE_SS_LW(xr5,xr6,xr7,xr8);
    D16MACE_SS_HW(xr9,xr10,xr11,xr12);
    D16MACE_SS_XW(xr13,xr14,xr15,xr0);

    Q8MUL(xr1,xr2,xr3,xr4);
    Q8MULSU(xr5,xr6,xr7,xr8);
    Q8MOVZ(xr9,xr10,xr11);
    Q8MOVN(xr12,xr13,xr14);
    D16MOVZ(xr15,xr0,xr1);
    D16MOVN(xr2,xr3,xr4);
    S32MOVZ(xr5,xr6,xr7);
    S32MOVN(xr8,xr9,xr10);

    Q8MAC_AA(xr11,xr12,xr13,xr14);
    Q8MAC_AS(xr15,xr0,xr1,xr2);
    Q8MAC_SA(xr3,xr4,xr5,xr6);
    Q8MAC_SS(xr7,xr8,xr9,xr10);

    Q8MACSU_AA(xr11,xr12,xr13,xr14);
    Q8MACSU_AS(xr15,xr0,xr1,xr2);
    Q8MACSU_SA(xr3,xr4,xr5,xr6);
    Q8MACSU_SS(xr7,xr8,xr9,xr10);

    Q8MADL_AA(xr11,xr12,xr13,xr14);
    Q8MADL_AS(xr15,xr0,xr1,xr2);
    Q8MADL_SA(xr3,xr4,xr5,xr6);
    Q8MADL_SS(xr7,xr8,xr9,xr10);

    S32SFL(xr11,xr12,xr13,xr14,0x0);
    S32SFL(xr15,xr0,xr1,xr2,0x1);
    S32SFL(xr3,xr4,xr5,xr6,0x02);
    S32SFL(xr7,xr8,xr9,xr10,0x3);

    Q16SCOP(xr11,xr12,xr13,xr14);
    Q8SAD(xr15,xr0,xr1,xr2);

    D32ADD_AA(xr3,xr4,xr5,xr6);
    D32ADD_AS(xr7,xr8,xr9,xr10);
    D32ADD_SA(xr11,xr12,xr13,xr14);
    D32ADD_SS(xr15,xr0,xr1,xr2);

    D32ACC_AA(xr3,xr4,xr5,xr6);
    D32ACC_AS(xr7,xr8,xr9,xr10);
    D32ACC_SA(xr11,xr12,xr13,xr14);
    D32ACC_SS(xr15,xr0,xr1,xr2);

    D32ACCM_AA(xr3,xr4,xr5,xr6);
    D32ACCM_AS(xr7,xr8,xr9,xr10);
    D32ACCM_SA(xr11,xr12,xr13,xr14);
    D32ACCM_SS(xr15,xr0,xr1,xr2);

    D32ASUM_AA(xr3,xr4,xr5,xr6);
    D32ASUM_AS(xr7,xr8,xr9,xr10);
    D32ASUM_SA(xr11,xr12,xr13,xr14);
    D32ASUM_SS(xr15,xr0,xr1,xr2);

    Q16ACC_AA(xr3,xr4,xr5,xr6);
    Q16ACC_AS(xr7,xr8,xr9,xr10);
    Q16ACC_SA(xr11,xr12,xr13,xr14);
    Q16ACC_SS(xr15,xr0,xr1,xr2);

    Q16ACCM_AA(xr3,xr4,xr5,xr6);
    Q16ACCM_AS(xr7,xr8,xr9,xr10);
    Q16ACCM_SA(xr11,xr12,xr13,xr14);
    Q16ACCM_SS(xr15,xr0,xr1,xr2);

    D16ASUM_AA(xr3,xr4,xr5,xr6);
    D16ASUM_AS(xr7,xr8,xr9,xr10);
    D16ASUM_SA(xr11,xr12,xr13,xr14);
    D16ASUM_SS(xr15,xr0,xr1,xr2);

    Q8ADDE_AA(xr3,xr4,xr5,xr6);
    Q8ADDE_AS(xr7,xr8,xr9,xr10);
    Q8ADDE_SA(xr11,xr12,xr13,xr14);
    Q8ADDE_SS(xr15,xr0,xr1,xr2);

    Q8ACCE_AA(xr3,xr4,xr5,xr6);
    Q8ACCE_AS(xr7,xr8,xr9,xr10);
    Q8ACCE_SA(xr11,xr12,xr13,xr14);
    Q8ACCE_SS(xr15,xr0,xr1,xr2);

    D32ADDC(xr3,xr4,xr5,xr6);
    D8SUM(xr7,xr8,xr9);
    D8SUMC(xr11,xr12,xr13);

    S32CPS(xr14,xr15,xr0);
    D16CPS(xr1,xr2,xr3);
    Q8ABD(xr4,xr5,xr6);
    Q16SAT(xr7,xr8,xr9);

    S32SLT(xr10,xr11,xr12);
    D16SLT(xr13,xr14,xr15);
    D16AVG(xr0,xr1,xr2);
    D16AVGR(xr3,xr4,xr5);
    Q8AVG(xr6,xr7,xr8);
    Q8AVGR(xr9,xr10,xr11);
    Q8ADD_AA(xr12,xr13,xr14);
    Q8ADD_AS(xr15,xr0,xr1);
    Q8ADD_SA(xr2,xr3,xr4);
    Q8ADD_SS(xr5,xr6,xr7);

    S32MAX(xr8,xr9,xr10);
    S32MIN(xr11,xr12,xr13);
    D16MAX(xr14,xr15,xr0);
    D16MIN(xr1,xr2,xr3);
    Q8MAX(xr4,xr5,xr6);
    Q8MIN(xr7,xr8,xr9);
    Q8SLT(xr10,xr11,xr12);
    Q8SLTU(xr13,xr14,xr15);

    D32SLL(xr0,xr1,xr2,xr3,0x0);
    D32SLL(xr4,xr5,xr6,xr7,0xf);

    D32SLR(xr8,xr9,xr10,xr11,0x0);
    D32SLR(xr12,xr13,xr14,xr15,0xf);

    D32SARL(xr0,xr1,xr2,0x0);
    D32SARL(xr3,xr4,xr5,0xf);

    D32SAR(xr6,xr7,xr8,xr9,0x0);
    D32SAR(xr10,xr11,xr12,xr13,0xf);

    Q16SLL(xr14,xr15,xr0,xr1,0x0);
    Q16SLL(xr2,xr3,xr4,xr5,0xf);

    Q16SLR(xr6,xr7,xr8,xr9,0x0);
    Q16SLR(xr10,xr11,xr12,xr13,0xf);

    Q16SAR(xr14,xr15,xr0,xr1,0x0);
    Q16SAR(xr2,xr3,xr4,xr5,0xf);

    D32SLLV(xr6,xr7,src);
    D32SLRV(xr10,xr11,src);
    D32SARV(xr14,xr15,src);
    Q16SLLV(xr2,xr3,src);
    Q16SLRV(xr6,xr7,src);
    Q16SARV(xr10,xr11,src);

    S32MADD(xr14,xr15,src,dst);
    S32MADDU(xr0,xr1,src,dst);

    S32MSUB(xr2,xr3,src,dst);
    S32MSUBU(xr4,xr5,src,dst);

    S32MUL(xr6,xr7,src,dst);
    S32MULU(xr8,xr9,src,dst);

    S32EXTR(xr10,xr11,src,0x1);
    S32EXTR(xr10,xr11,dst,0x1f);

    S32EXTRV(xr12,xr13,src,dst);

    D32SARW(xr14,xr15,xr0,src);

    S32ALN(xr1,xr2,xr3,src);
    S32ALNI(xr4,xr5,xr6,ptn0);
    S32ALNI(xr7,xr8,xr9,ptn1);
    S32ALNI(xr10,xr11,xr12,ptn2);
    S32ALNI(xr13,xr14,xr15,ptn3);
    /* S32ALNI(xr0,xr1,xr2,ptn4); */
    /* S32ALNI(xr3,xr4,xr5,ptn5); */
    /* S32ALNI(xr6,xr7,xr8,ptn6); */
    /* S32ALNI(xr9,xr10,xr11,ptn7); */

    S32LUI(xr12,0xff,ptn0);
    S32LUI(xr13,0x81,ptn1);
    S32LUI(xr14,-128,ptn2);
    S32LUI(xr15,0x0,ptn3);
    S32LUI(xr0,0x0,ptn4);
    S32LUI(xr1,0x0,ptn5);
    S32LUI(xr2,0x0,ptn6);
    S32LUI(xr3,0x0,ptn7);

    S32NOR(xr4,xr5,xr6);
    S32AND(xr7,xr8,xr9);
    S32OR(xr10,xr11,xr12);
    S32XOR(xr13,xr14,xr15);

    LXB(src,dst,0);
    LXB(src,dst,1);
    LXB(src,dst,2);

    LXBU(src,dst,0);
    LXBU(src,dst,1);
    LXBU(src,dst,2);

    LXH(src,dst,0);
    LXH(src,dst,1);
    LXH(src,dst,2);

    LXHU(src,dst,0);
    LXHU(src,dst,1);
    LXHU(src,dst,2);

    LXW(src,dst,0);
    LXW(src,dst,1);
    LXW(src,dst,2);

    S16LDD(xr0,src,-512,ptn0);
    S16LDD(xr1,src,510,ptn1);
    S16LDD(xr2,src,0,ptn2);
    S16LDD(xr3,src,-510,ptn3);

    S16STD(xr4,src,-512,ptn0);
    S16STD(xr5,src,510,ptn1);

    S16LDI(xr6,src,-512,ptn0);
    S16LDI(xr7,src,510,ptn1);
    S16LDI(xr8,src,0,ptn2);
    S16LDI(xr9,src,-510,ptn3);

    S16SDI(xr10,src,-512,ptn0);
    S16SDI(xr11,src,510,ptn1);

    S32M2I(xr12);
    S32M2I(xr16);

    S32I2M(xr13,src);
    S32I2M(xr16,src);

    S32LDDV(xr14,src,dst,0);
    S32LDDV(xr15,src,dst,1);
    S32LDDV(xr0,src,dst,2);

    S32LDDVR(xr1,src,dst,0);
    S32LDDVR(xr2,src,dst,1);
    S32LDDVR(xr3,src,dst,2);

    S32STDV(xr4,src,dst,0);
    S32STDV(xr5,src,dst,1);
    S32STDV(xr6,src,dst,2);

    S32STDVR(xr7,src,dst,0);
    S32STDVR(xr8,src,dst,1);
    S32STDVR(xr9,src,dst,2);

    S32LDIV(xr10,src,dst,0);
    S32LDIV(xr11,src,dst,1);
    S32LDIV(xr12,src,dst,2);

    S32LDIVR(xr13,src,dst,0);
    S32LDIVR(xr14,src,dst,1);
    S32LDIVR(xr15,src,dst,2);

    S32SDIV(xr0,src,dst,0);
    S32SDIV(xr1,src,dst,1);
    S32SDIV(xr2,src,dst,2);

    S32SDIVR(xr3,src,dst,0);
    S32SDIVR(xr4,src,dst,1);
    S32SDIVR(xr5,src,dst,2);

    S32LDD(xr6,src,-2048);
    S32LDD(xr7,src,2044);

    S32LDDR(xr9,src,-2048);
    S32LDDR(xr10,src,2044);

    S32STD(xr11,src,-2048);
    S32STD(xr12,src,2044);

    S32STDR(xr13,src,-2048);
    S32STDR(xr14,src,2044);

    S32LDI(xr15,src,-2048);
    S32LDI(xr0,src,2044);

    S32LDIR(xr1,src,-2048);
    S32LDIR(xr2,src,2044);

    S32SDI(xr3,src,-2048);
    S32SDI(xr4,src,2044);

    S32SDIR(xr5,src,-2048);
    S32SDIR(xr6,src,2044);

    S8LDD(xr7,dst,127,ptn0);
    S8LDD(xr8,dst,-128,ptn1);
    S8LDD(xr9,dst,127,ptn2);
    S8LDD(xr10,dst,-128,ptn3);
    S8LDD(xr11,dst,127,ptn4);
    S8LDD(xr12,dst,-128,ptn5);
    S8LDD(xr13,dst,127,ptn6);
    S8LDD(xr14,dst,-128,ptn7);

    S8STD(xr15,dst,127,ptn0);
    S8STD(xr0,dst,-128,ptn1);
    S8STD(xr1,dst,127,ptn2);
    S8STD(xr2,dst,-128,ptn3);
    S8STD(xr3,dst,127,ptn4);
    S8STD(xr4,dst,-128,ptn5);
    S8STD(xr5,dst,127,ptn6);
    S8STD(xr6,dst,-128,ptn7);

    S8LDI(xr7,dst,127,ptn0);
    S8LDI(xr8,dst,-128,ptn1);
    S8LDI(xr9,dst,127,ptn2);
    S8LDI(xr10,dst,-128,ptn3);
    S8LDI(xr11,dst,127,ptn4);
    S8LDI(xr12,dst,-128,ptn5);
    S8LDI(xr13,dst,127,ptn6);
    S8LDI(xr14,dst,-128,ptn7);

    S8SDI(xr15,dst,127,ptn0);
    S8SDI(xr0,dst,-128,ptn1);
    S8SDI(xr1,dst,127,ptn2);
    S8SDI(xr2,dst,-128,ptn3);
    S8SDI(xr3,dst,127,ptn4);
    S8SDI(xr4,dst,-128,ptn5);
    S8SDI(xr5,dst,127,ptn6);
    S8SDI(xr6,dst,-128,ptn7);

#endif
    S32SDIR(xr5,src,-2048);
    S32SDIR(xr6,src,2044);
    S32LDDR(xr9,src,-2048);
    S32LDDR(xr10,src,2044);


}

