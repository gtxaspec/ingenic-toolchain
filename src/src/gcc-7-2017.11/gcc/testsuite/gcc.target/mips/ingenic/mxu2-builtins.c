/* Test builtins for MIPS MXU2 ASE instructions */
/* { dg-do compile } */
/* { dg-options " -mmxu2" } */
/* { dg-skip-if "madd and msub need combine" { *-*-* } { "-O0" "-flto" } { "" } } */

/* { dg-final { scan-assembler "mxu2_add_b.*:.*addb.*mxu2_add_b" } } */
/* { dg-final { scan-assembler "mxu2_add_h.*:.*addh.*mxu2_add_h" } } */
/* { dg-final { scan-assembler "mxu2_add_w.*:.*addw.*mxu2_add_w" } } */
/* { dg-final { scan-assembler "mxu2_add_d.*:.*addd.*mxu2_add_d" } } */
/* { dg-final { scan-assembler "mxu2_addss_b.*:.*addssb.*mxu2_addss_b" } } */
/* { dg-final { scan-assembler "mxu2_addss_h.*:.*addssh.*mxu2_addss_h" } } */
/* { dg-final { scan-assembler "mxu2_addss_w.*:.*addssw.*mxu2_addss_w" } } */
/* { dg-final { scan-assembler "mxu2_addss_d.*:.*addssd.*mxu2_addss_d" } } */
/* { dg-final { scan-assembler "mxu2_adduu_b.*:.*adduub.*mxu2_adduu_b" } } */
/* { dg-final { scan-assembler "mxu2_adduu_h.*:.*adduuh.*mxu2_adduu_h" } } */
/* { dg-final { scan-assembler "mxu2_adduu_w.*:.*adduuw.*mxu2_adduu_w" } } */
/* { dg-final { scan-assembler "mxu2_adduu_d.*:.*adduud.*mxu2_adduu_d" } } */
/* { dg-final { scan-assembler "mxu2_addas_b.*:.*addasb.*mxu2_addas_b" } } */
/* { dg-final { scan-assembler "mxu2_addas_h.*:.*addash.*mxu2_addas_h" } } */
/* { dg-final { scan-assembler "mxu2_addas_w.*:.*addasw.*mxu2_addas_w" } } */
/* { dg-final { scan-assembler "mxu2_addas_d.*:.*addasd.*mxu2_addas_d" } } */
/* { dg-final { scan-assembler "mxu2_adda_b.*:.*addab.*mxu2_adda_b" } } */
/* { dg-final { scan-assembler "mxu2_adda_h.*:.*addah.*mxu2_adda_h" } } */
/* { dg-final { scan-assembler "mxu2_adda_w.*:.*addaw.*mxu2_adda_w" } } */
/* { dg-final { scan-assembler "mxu2_adda_d.*:.*addad.*mxu2_adda_d" } } */
/* { dg-final { scan-assembler "mxu2_fadd_w.*:.*faddw.*mxu2_fadd_w" } } */
/* { dg-final { scan-assembler "mxu2_fadd_d.*:.*faddd.*mxu2_fadd_d" } } */
/* { dg-final { scan-assembler "mxu2_fmadd_w.*:.*fmaddw.*mxu2_fmadd_w" } } */
/* { dg-final { scan-assembler "mxu2_fmadd_d.*:.*fmaddd.*mxu2_fmadd_d" } } */
/* { dg-final { scan-assembler "mxu2_madd_b.*:.*maddb.*mxu2_madd_b" } } */
/* { dg-final { scan-assembler "mxu2_madd_h.*:.*maddh.*mxu2_madd_h" } } */
/* { dg-final { scan-assembler "mxu2_madd_w.*:.*maddw.*mxu2_madd_w" } } */
/* { dg-final { scan-assembler "mxu2_madd_d.*:.*maddd.*mxu2_madd_d" } } */
/* { dg-final { scan-assembler "mxu2_maddq_h.*:.*maddqh.*mxu2_maddq_h" } } */
/* { dg-final { scan-assembler "mxu2_maddq_w.*:.*maddqw.*mxu2_maddq_w" } } */
/* { dg-final { scan-assembler "mxu2_maddqr_h.*:.*maddqrh.*mxu2_maddqr_h" } } */
/* { dg-final { scan-assembler "mxu2_maddqr_w.*:.*maddqrw.*mxu2_maddqr_w" } } */
/* { dg-final { scan-assembler "mxu2_dadds_h.*:.*daddsh.*mxu2_dadds_h" } } */
/* { dg-final { scan-assembler "mxu2_dadds_w.*:.*daddsw.*mxu2_dadds_w" } } */
/* { dg-final { scan-assembler "mxu2_dadds_d.*:.*daddsd.*mxu2_dadds_d" } } */
/* { dg-final { scan-assembler "mxu2_daddu_h.*:.*dadduh.*mxu2_daddu_h" } } */
/* { dg-final { scan-assembler "mxu2_daddu_w.*:.*dadduw.*mxu2_daddu_w" } } */
/* { dg-final { scan-assembler "mxu2_daddu_d.*:.*daddud.*mxu2_daddu_d" } } */

/* { dg-final { scan-assembler "mxu2_sub_b.*:.*subb.*mxu2_sub_b" } } */
/* { dg-final { scan-assembler "mxu2_sub_h.*:.*subh.*mxu2_sub_h" } } */
/* { dg-final { scan-assembler "mxu2_sub_w.*:.*subw.*mxu2_sub_w" } } */
/* { dg-final { scan-assembler "mxu2_sub_d.*:.*subd.*mxu2_sub_d" } } */
/* { dg-final { scan-assembler "mxu2_subss_b.*:.*subssb.*mxu2_subss_b" } } */
/* { dg-final { scan-assembler "mxu2_subss_h.*:.*subssh.*mxu2_subss_h" } } */
/* { dg-final { scan-assembler "mxu2_subss_w.*:.*subssw.*mxu2_subss_w" } } */
/* { dg-final { scan-assembler "mxu2_subss_d.*:.*subssd.*mxu2_subss_d" } } */
/* { dg-final { scan-assembler "mxu2_subuu_b.*:.*subuub.*mxu2_subuu_b" } } */
/* { dg-final { scan-assembler "mxu2_subuu_h.*:.*subuuh.*mxu2_subuu_h" } } */
/* { dg-final { scan-assembler "mxu2_subuu_w.*:.*subuuw.*mxu2_subuu_w" } } */
/* { dg-final { scan-assembler "mxu2_subuu_d.*:.*subuud.*mxu2_subuu_d" } } */
/* { dg-final { scan-assembler "mxu2_subsa_b.*:.*subsab.*mxu2_subsa_b" } } */
/* { dg-final { scan-assembler "mxu2_subsa_h.*:.*subsah.*mxu2_subsa_h" } } */
/* { dg-final { scan-assembler "mxu2_subsa_w.*:.*subsaw.*mxu2_subsa_w" } } */
/* { dg-final { scan-assembler "mxu2_subsa_d.*:.*subsad.*mxu2_subsa_d" } } */
/* { dg-final { scan-assembler "mxu2_subua_b.*:.*subuab.*mxu2_subua_b" } } */
/* { dg-final { scan-assembler "mxu2_subua_h.*:.*subuah.*mxu2_subua_h" } } */
/* { dg-final { scan-assembler "mxu2_subua_w.*:.*subuaw.*mxu2_subua_w" } } */
/* { dg-final { scan-assembler "mxu2_subua_d.*:.*subuad.*mxu2_subua_d" } } */
/* { dg-final { scan-assembler "mxu2_subus_b.*:.*subusb.*mxu2_subus_b" } } */
/* { dg-final { scan-assembler "mxu2_subus_h.*:.*subush.*mxu2_subus_h" } } */
/* { dg-final { scan-assembler "mxu2_subus_w.*:.*subusw.*mxu2_subus_w" } } */
/* { dg-final { scan-assembler "mxu2_subus_d.*:.*subusd.*mxu2_subus_d" } } */
/* { dg-final { scan-assembler "mxu2_fsub_w.*:.*fsubw.*mxu2_fsub_w" } } */
/* { dg-final { scan-assembler "mxu2_fsub_d.*:.*fsubd.*mxu2_fsub_d" } } */
/* { dg-final { scan-assembler "mxu2_fmsub_w.*:.*fmsubw.*mxu2_fmsub_w" } } */
/* { dg-final { scan-assembler "mxu2_fmsub_d.*:.*fmsubd.*mxu2_fmsub_d" } } */
/* { dg-final { scan-assembler "mxu2_msub_b.*:.*msubb.*mxu2_msub_b" } } */
/* { dg-final { scan-assembler "mxu2_msub_h.*:.*msubh.*mxu2_msub_h" } } */
/* { dg-final { scan-assembler "mxu2_msub_w.*:.*msubw.*mxu2_msub_w" } } */
/* { dg-final { scan-assembler "mxu2_msub_d.*:.*msubd.*mxu2_msub_d" } } */
/* { dg-final { scan-assembler "mxu2_msubq_h.*:.*msubqh.*mxu2_msubq_h" } } */
/* { dg-final { scan-assembler "mxu2_msubq_w.*:.*msubqw.*mxu2_msubq_w" } } */
/* { dg-final { scan-assembler "mxu2_msubqr_h.*:.*msubqrh.*mxu2_msubqr_h" } } */
/* { dg-final { scan-assembler "mxu2_msubqr_w.*:.*msubqrw.*mxu2_msubqr_w" } } */
/* { dg-final { scan-assembler "mxu2_dsubs_h.*:.*dsubsh.*mxu2_dsubs_h" } } */
/* { dg-final { scan-assembler "mxu2_dsubs_w.*:.*dsubsw.*mxu2_dsubs_w" } } */
/* { dg-final { scan-assembler "mxu2_dsubs_d.*:.*dsubsd.*mxu2_dsubs_d" } } */
/* { dg-final { scan-assembler "mxu2_dsubu_h.*:.*dsubuh.*mxu2_dsubu_h" } } */
/* { dg-final { scan-assembler "mxu2_dsubu_w.*:.*dsubuw.*mxu2_dsubu_w" } } */
/* { dg-final { scan-assembler "mxu2_dsubu_d.*:.*dsubud.*mxu2_dsubu_d" } } */

/* { dg-final { scan-assembler "mxu2_mul_b.*:.*mulb.*mxu2_mul_b" } } */
/* { dg-final { scan-assembler "mxu2_mul_h.*:.*mulh.*mxu2_mul_h" } } */
/* { dg-final { scan-assembler "mxu2_mul_w.*:.*mulw.*mxu2_mul_w" } } */
/* { dg-final { scan-assembler "mxu2_mul_d.*:.*muld.*mxu2_mul_d" } } */
/* { dg-final { scan-assembler "mxu2_fmul_w.*:.*fmulw.*mxu2_fmul_w" } } */
/* { dg-final { scan-assembler "mxu2_fmul_d.*:.*fmuld.*mxu2_fmul_d" } } */
/* { dg-final { scan-assembler "mxu2_mulq_h.*:.*mulqh.*mxu2_mulq_h" } } */
/* { dg-final { scan-assembler "mxu2_mulq_w.*:.*mulqw.*mxu2_mulq_w" } } */
/* { dg-final { scan-assembler "mxu2_mulqr_h.*:.*mulqrh.*mxu2_mulqr_h" } } */
/* { dg-final { scan-assembler "mxu2_mulqr_w.*:.*mulqrw.*mxu2_mulqr_w" } } */

/* { dg-final { scan-assembler "mxu2_divs_b.*:.*divsb.*mxu2_divs_b" } } */
/* { dg-final { scan-assembler "mxu2_divs_h.*:.*divsh.*mxu2_divs_h" } } */
/* { dg-final { scan-assembler "mxu2_divs_w.*:.*divsw.*mxu2_divs_w" } } */
/* { dg-final { scan-assembler "mxu2_divs_d.*:.*divsd.*mxu2_divs_d" } } */
/* { dg-final { scan-assembler "mxu2_divu_b.*:.*divub.*mxu2_divu_b" } } */
/* { dg-final { scan-assembler "mxu2_divu_h.*:.*divuh.*mxu2_divu_h" } } */
/* { dg-final { scan-assembler "mxu2_divu_w.*:.*divuw.*mxu2_divu_w" } } */
/* { dg-final { scan-assembler "mxu2_divu_d.*:.*divud.*mxu2_divu_d" } } */
/* { dg-final { scan-assembler "mxu2_fdiv_w.*:.*fdivw.*mxu2_fdiv_w" } } */
/* { dg-final { scan-assembler "mxu2_fdiv_d.*:.*fdivd.*mxu2_fdiv_d" } } */

/* { dg-final { scan-assembler "mxu2_mods_b.*:.*modsb.*mxu2_mods_b" } } */
/* { dg-final { scan-assembler "mxu2_mods_h.*:.*modsh.*mxu2_mods_h" } } */
/* { dg-final { scan-assembler "mxu2_mods_w.*:.*modsw.*mxu2_mods_w" } } */
/* { dg-final { scan-assembler "mxu2_mods_d.*:.*modsd.*mxu2_mods_d" } } */
/* { dg-final { scan-assembler "mxu2_modu_b.*:.*modub.*mxu2_modu_b" } } */
/* { dg-final { scan-assembler "mxu2_modu_h.*:.*moduh.*mxu2_modu_h" } } */
/* { dg-final { scan-assembler "mxu2_modu_w.*:.*moduw.*mxu2_modu_w" } } */
/* { dg-final { scan-assembler "mxu2_modu_d.*:.*modud.*mxu2_modu_d" } } */

/* { dg-final { scan-assembler "mxu2_maxa_b.*:.*maxab.*mxu2_maxa_b" } } */
/* { dg-final { scan-assembler "mxu2_maxa_h.*:.*maxah.*mxu2_maxa_h" } } */
/* { dg-final { scan-assembler "mxu2_maxa_w.*:.*maxaw.*mxu2_maxa_w" } } */
/* { dg-final { scan-assembler "mxu2_maxa_d.*:.*maxad.*mxu2_maxa_d" } } */
/* { dg-final { scan-assembler "mxu2_maxs_b.*:.*maxsb.*mxu2_maxs_b" } } */
/* { dg-final { scan-assembler "mxu2_maxs_h.*:.*maxsh.*mxu2_maxs_h" } } */
/* { dg-final { scan-assembler "mxu2_maxs_w.*:.*maxsw.*mxu2_maxs_w" } } */
/* { dg-final { scan-assembler "mxu2_maxs_d.*:.*maxsd.*mxu2_maxs_d" } } */
/* { dg-final { scan-assembler "mxu2_maxu_b.*:.*maxub.*mxu2_maxu_b" } } */
/* { dg-final { scan-assembler "mxu2_maxu_h.*:.*maxuh.*mxu2_maxu_h" } } */
/* { dg-final { scan-assembler "mxu2_maxu_w.*:.*maxuw.*mxu2_maxu_w" } } */
/* { dg-final { scan-assembler "mxu2_maxu_d.*:.*maxud.*mxu2_maxu_d" } } */
/* { dg-final { scan-assembler "mxu2_fmax_w.*:.*fmaxw.*mxu2_fmax_w" } } */
/* { dg-final { scan-assembler "mxu2_fmax_d.*:.*fmaxd.*mxu2_fmax_d" } } */
/* { dg-final { scan-assembler "mxu2_fmaxa_w.*:.*fmaxaw.*mxu2_fmaxa_w" } } */
/* { dg-final { scan-assembler "mxu2_fmaxa_d.*:.*fmaxad.*mxu2_fmaxa_d" } } */

/* { dg-final { scan-assembler "mxu2_mina_b.*:.*minab.*mxu2_mina_b" } } */
/* { dg-final { scan-assembler "mxu2_mina_h.*:.*minah.*mxu2_mina_h" } } */
/* { dg-final { scan-assembler "mxu2_mina_w.*:.*minaw.*mxu2_mina_w" } } */
/* { dg-final { scan-assembler "mxu2_mina_d.*:.*minad.*mxu2_mina_d" } } */
/* { dg-final { scan-assembler "mxu2_mins_b.*:.*minsb.*mxu2_mins_b" } } */
/* { dg-final { scan-assembler "mxu2_mins_h.*:.*minsh.*mxu2_mins_h" } } */
/* { dg-final { scan-assembler "mxu2_mins_w.*:.*minsw.*mxu2_mins_w" } } */
/* { dg-final { scan-assembler "mxu2_mins_d.*:.*minsd.*mxu2_mins_d" } } */
/* { dg-final { scan-assembler "mxu2_minu_b.*:.*minub.*mxu2_minu_b" } } */
/* { dg-final { scan-assembler "mxu2_minu_h.*:.*minuh.*mxu2_minu_h" } } */
/* { dg-final { scan-assembler "mxu2_minu_w.*:.*minuw.*mxu2_minu_w" } } */
/* { dg-final { scan-assembler "mxu2_minu_d.*:.*minud.*mxu2_minu_d" } } */
/* { dg-final { scan-assembler "mxu2_fmin_w.*:.*fminw.*mxu2_fmin_w" } } */
/* { dg-final { scan-assembler "mxu2_fmin_d.*:.*fmind.*mxu2_fmin_d" } } */
/* { dg-final { scan-assembler "mxu2_fmina_w.*:.*fminaw.*mxu2_fmina_w" } } */
/* { dg-final { scan-assembler "mxu2_fmina_d.*:.*fminad.*mxu2_fmina_d" } } */

/* { dg-final { scan-assembler "mxu2_sats_b.*:.*satsb.*mxu2_sats_b" } } */
/* { dg-final { scan-assembler "mxu2_sats_h.*:.*satsh.*mxu2_sats_h" } } */
/* { dg-final { scan-assembler "mxu2_sats_w.*:.*satsw.*mxu2_sats_w" } } */
/* { dg-final { scan-assembler "mxu2_sats_d.*:.*satsd.*mxu2_sats_d" } } */
/* { dg-final { scan-assembler "mxu2_satu_b.*:.*satub.*mxu2_satu_b" } } */
/* { dg-final { scan-assembler "mxu2_satu_h.*:.*satuh.*mxu2_satu_h" } } */
/* { dg-final { scan-assembler "mxu2_satu_w.*:.*satuw.*mxu2_satu_w" } } */
/* { dg-final { scan-assembler "mxu2_satu_d.*:.*satud.*mxu2_satu_d" } } */

/* { dg-final { scan-assembler "mxu2_avers_b.*:.*aversb.*mxu2_avers_b" } } */
/* { dg-final { scan-assembler "mxu2_avers_h.*:.*aversh.*mxu2_avers_h" } } */
/* { dg-final { scan-assembler "mxu2_avers_w.*:.*aversw.*mxu2_avers_w" } } */
/* { dg-final { scan-assembler "mxu2_avers_d.*:.*aversd.*mxu2_avers_d" } } */
/* { dg-final { scan-assembler "mxu2_averu_b.*:.*averub.*mxu2_averu_b" } } */
/* { dg-final { scan-assembler "mxu2_averu_h.*:.*averuh.*mxu2_averu_h" } } */
/* { dg-final { scan-assembler "mxu2_averu_w.*:.*averuw.*mxu2_averu_w" } } */
/* { dg-final { scan-assembler "mxu2_averu_d.*:.*averud.*mxu2_averu_d" } } */
/* { dg-final { scan-assembler "mxu2_aves_b.*:.*avesb.*mxu2_aves_b" } } */
/* { dg-final { scan-assembler "mxu2_aves_h.*:.*avesh.*mxu2_aves_h" } } */
/* { dg-final { scan-assembler "mxu2_aves_w.*:.*avesw.*mxu2_aves_w" } } */
/* { dg-final { scan-assembler "mxu2_aves_d.*:.*avesd.*mxu2_aves_d" } } */
/* { dg-final { scan-assembler "mxu2_aveu_b.*:.*aveub.*mxu2_aveu_b" } } */
/* { dg-final { scan-assembler "mxu2_aveu_h.*:.*aveuh.*mxu2_aveu_h" } } */
/* { dg-final { scan-assembler "mxu2_aveu_w.*:.*aveuw.*mxu2_aveu_w" } } */
/* { dg-final { scan-assembler "mxu2_aveu_d.*:.*aveud.*mxu2_aveu_d" } } */

/* { dg-final { scan-assembler "mxu2_fsqrt_w.*:.*fsqrtw.*mxu2_fsqrt_w" } } */
/* { dg-final { scan-assembler "mxu2_fsqrt_d.*:.*fsqrtd.*mxu2_fsqrt_d" } } */

/* { dg-final { scan-assembler "mxu2_dotps_h.*:.*dotpsh.*mxu2_dotps_h" } } */
/* { dg-final { scan-assembler "mxu2_dotps_w.*:.*dotpsw.*mxu2_dotps_w" } } */
/* { dg-final { scan-assembler "mxu2_dotps_d.*:.*dotpsd.*mxu2_dotps_d" } } */
/* { dg-final { scan-assembler "mxu2_dotpu_h.*:.*dotpuh.*mxu2_dotpu_h" } } */
/* { dg-final { scan-assembler "mxu2_dotpu_w.*:.*dotpuw.*mxu2_dotpu_w" } } */
/* { dg-final { scan-assembler "mxu2_dotpu_d.*:.*dotpud.*mxu2_dotpu_d" } } */

/* { dg-final { scan-assembler "mxu2_fclass_w.*:.*fclassw.*mxu2_fclass_w" } } */
/* { dg-final { scan-assembler "mxu2_fclass_d.*:.*fclassd.*mxu2_fclass_d" } } */

/* { dg-final { scan-assembler "mxu2_xorvtest.*:.*xorv.*mxu2_xorvtest" } } */
/* { dg-final { scan-assembler "mxu2_xoribtest.*:.*xorib.*mxu2_xoribtest" } } */
/* { dg-final { scan-assembler "mxu2_orvtest.*:.*orv.*mxu2_orvtest" } } */
/* { dg-final { scan-assembler "mxu2_oribtest.*:.*orib.*mxu2_oribtest" } } */
/* { dg-final { scan-assembler "mxu2_norvtest.*:.*norv.*mxu2_norvtest" } } */
/* { dg-final { scan-assembler "mxu2_noribtest.*:.*norib.*mxu2_noribtest" } } */
/* { dg-final { scan-assembler "mxu2_loc_b.*:.*locb.*mxu2_loc_b" } } */
/* { dg-final { scan-assembler "mxu2_loc_h.*:.*loch.*mxu2_loc_h" } } */
/* { dg-final { scan-assembler "mxu2_loc_w.*:.*locw.*mxu2_loc_w" } } */
/* { dg-final { scan-assembler "mxu2_loc_d.*:.*locd.*mxu2_loc_d" } } */
/* { dg-final { scan-assembler "mxu2_lzc_b.*:.*lzcb.*mxu2_lzc_b" } } */
/* { dg-final { scan-assembler "mxu2_lzc_h.*:.*lzch.*mxu2_lzc_h" } } */
/* { dg-final { scan-assembler "mxu2_lzc_w.*:.*lzcw.*mxu2_lzc_w" } } */
/* { dg-final { scan-assembler "mxu2_lzc_d.*:.*lzcd.*mxu2_lzc_d" } } */
/* { dg-final { scan-assembler "mxu2_bcnt_b.*:.*bcntb.*mxu2_bcnt_b" } } */
/* { dg-final { scan-assembler "mxu2_bcnt_h.*:.*bcnth.*mxu2_bcnt_h" } } */
/* { dg-final { scan-assembler "mxu2_bcnt_w.*:.*bcntw.*mxu2_bcnt_w" } } */
/* { dg-final { scan-assembler "mxu2_bcnt_d.*:.*bcntd.*mxu2_bcnt_d" } } */
/* { dg-final { scan-assembler "mxu2_bselvtest.*:.*bselv.*mxu2_bselvtest" } } */

/* { dg-final { scan-assembler "mxu2_ceq_b.*:.*ceqb.*mxu2_ceq_b" } } */
/* { dg-final { scan-assembler "mxu2_ceq_h.*:.*ceqh.*mxu2_ceq_h" } } */
/* { dg-final { scan-assembler "mxu2_ceq_w.*:.*ceqw.*mxu2_ceq_w" } } */
/* { dg-final { scan-assembler "mxu2_ceq_d.*:.*ceqd.*mxu2_ceq_d" } } */
/* { dg-final { scan-assembler "mxu2_ceqz_b.*:.*ceqzb.*mxu2_ceqz_b" } } */
/* { dg-final { scan-assembler "mxu2_ceqz_h.*:.*ceqzh.*mxu2_ceqz_h" } } */
/* { dg-final { scan-assembler "mxu2_ceqz_w.*:.*ceqzw.*mxu2_ceqz_w" } } */
/* { dg-final { scan-assembler "mxu2_ceqz_d.*:.*ceqzd.*mxu2_ceqz_d" } } */
/* { dg-final { scan-assembler "mxu2_fceq_w.*:.*fceqw.*mxu2_fceq_w" } } */
/* { dg-final { scan-assembler "mxu2_fceq_d.*:.*fceqd.*mxu2_fceq_d" } } */

/* { dg-final { scan-assembler "mxu2_cne_b.*:.*cneb.*mxu2_cne_b" } } */
/* { dg-final { scan-assembler "mxu2_cne_h.*:.*cneh.*mxu2_cne_h" } } */
/* { dg-final { scan-assembler "mxu2_cne_w.*:.*cnew.*mxu2_cne_w" } } */
/* { dg-final { scan-assembler "mxu2_cne_d.*:.*cned.*mxu2_cne_d" } } */
/* { dg-final { scan-assembler "mxu2_cnez_b.*:.*cnezb.*mxu2_cnez_b" } } */
/* { dg-final { scan-assembler "mxu2_cnez_h.*:.*cnezh.*mxu2_cnez_h" } } */
/* { dg-final { scan-assembler "mxu2_cnez_w.*:.*cnezw.*mxu2_cnez_w" } } */
/* { dg-final { scan-assembler "mxu2_cnez_d.*:.*cnezd.*mxu2_cnez_d" } } */

/* { dg-final { scan-assembler "mxu2_cles_b.*:.*clesb.*mxu2_cles_b" } } */
/* { dg-final { scan-assembler "mxu2_cles_h.*:.*clesh.*mxu2_cles_h" } } */
/* { dg-final { scan-assembler "mxu2_cles_w.*:.*clesw.*mxu2_cles_w" } } */
/* { dg-final { scan-assembler "mxu2_cles_d.*:.*clesd.*mxu2_cles_d" } } */
/* { dg-final { scan-assembler "mxu2_cleu_b.*:.*cleub.*mxu2_cleu_b" } } */
/* { dg-final { scan-assembler "mxu2_cleu_h.*:.*cleuh.*mxu2_cleu_h" } } */
/* { dg-final { scan-assembler "mxu2_cleu_w.*:.*cleuw.*mxu2_cleu_w" } } */
/* { dg-final { scan-assembler "mxu2_cleu_d.*:.*cleud.*mxu2_cleu_d" } } */
/* { dg-final { scan-assembler "mxu2_clez_b.*:.*clezb.*mxu2_clez_b" } } */
/* { dg-final { scan-assembler "mxu2_clez_h.*:.*clezh.*mxu2_clez_h" } } */
/* { dg-final { scan-assembler "mxu2_clez_w.*:.*clezw.*mxu2_clez_w" } } */
/* { dg-final { scan-assembler "mxu2_clez_d.*:.*clezd.*mxu2_clez_d" } } */
/* { dg-final { scan-assembler "mxu2_fcle_w.*:.*fclew.*mxu2_fcle_w" } } */
/* { dg-final { scan-assembler "mxu2_fcle_d.*:.*fcled.*mxu2_fcle_d" } } */

/* { dg-final { scan-assembler "mxu2_clts_b.*:.*cltsb.*mxu2_clts_b" } } */
/* { dg-final { scan-assembler "mxu2_clts_h.*:.*cltsh.*mxu2_clts_h" } } */
/* { dg-final { scan-assembler "mxu2_clts_w.*:.*cltsw.*mxu2_clts_w" } } */
/* { dg-final { scan-assembler "mxu2_clts_d.*:.*cltsd.*mxu2_clts_d" } } */
/* { dg-final { scan-assembler "mxu2_cltu_b.*:.*cltub.*mxu2_cltu_b" } } */
/* { dg-final { scan-assembler "mxu2_cltu_h.*:.*cltuh.*mxu2_cltu_h" } } */
/* { dg-final { scan-assembler "mxu2_cltu_w.*:.*cltuw.*mxu2_cltu_w" } } */
/* { dg-final { scan-assembler "mxu2_cltu_d.*:.*cltud.*mxu2_cltu_d" } } */
/* { dg-final { scan-assembler "mxu2_cltz_b.*:.*cltzb.*mxu2_cltz_b" } } */
/* { dg-final { scan-assembler "mxu2_cltz_h.*:.*cltzh.*mxu2_cltz_h" } } */
/* { dg-final { scan-assembler "mxu2_cltz_w.*:.*cltzw.*mxu2_cltz_w" } } */
/* { dg-final { scan-assembler "mxu2_cltz_d.*:.*cltzd.*mxu2_cltz_d" } } */
/* { dg-final { scan-assembler "mxu2_fclt_w.*:.*fcltw.*mxu2_fclt_w" } } */
/* { dg-final { scan-assembler "mxu2_fclt_d.*:.*fcltd.*mxu2_fclt_d" } } */

/* { dg-final { scan-assembler "mxu2_fcor_w.*:.*fcorw.*mxu2_fcor_w" } } */
/* { dg-final { scan-assembler "mxu2_fcor_d.*:.*fcord.*mxu2_fcor_d" } } */

/* { dg-final { scan-assembler "mxu2_sll_b.*:.*sllb.*mxu2_sll_b" } } */
/* { dg-final { scan-assembler "mxu2_sll_h.*:.*sllh.*mxu2_sll_h" } } */
/* { dg-final { scan-assembler "mxu2_sll_w.*:.*sllw.*mxu2_sll_w" } } */
/* { dg-final { scan-assembler "mxu2_sll_d.*:.*slld.*mxu2_sll_d" } } */
/* { dg-final { scan-assembler "mxu2_slli_b.*:.*sllib.*mxu2_slli_b" } } */
/* { dg-final { scan-assembler "mxu2_slli_h.*:.*sllih.*mxu2_slli_h" } } */
/* { dg-final { scan-assembler "mxu2_slli_w.*:.*slliw.*mxu2_slli_w" } } */
/* { dg-final { scan-assembler "mxu2_slli_d.*:.*sllid.*mxu2_slli_d" } } */

/* { dg-final { scan-assembler "mxu2_sra_b.*:.*srab.*mxu2_sra_b" } } */
/* { dg-final { scan-assembler "mxu2_sra_h.*:.*srah.*mxu2_sra_h" } } */
/* { dg-final { scan-assembler "mxu2_sra_w.*:.*sraw.*mxu2_sra_w" } } */
/* { dg-final { scan-assembler "mxu2_sra_d.*:.*srad.*mxu2_sra_d" } } */
/* { dg-final { scan-assembler "mxu2_srai_b.*:.*sraib.*mxu2_srai_b" } } */
/* { dg-final { scan-assembler "mxu2_srai_h.*:.*sraih.*mxu2_srai_h" } } */
/* { dg-final { scan-assembler "mxu2_srai_w.*:.*sraiw.*mxu2_srai_w" } } */
/* { dg-final { scan-assembler "mxu2_srai_d.*:.*sraid.*mxu2_srai_d" } } */
/* { dg-final { scan-assembler "mxu2_srar_b.*:.*srarb.*mxu2_srar_b" } } */
/* { dg-final { scan-assembler "mxu2_srar_h.*:.*srarh.*mxu2_srar_h" } } */
/* { dg-final { scan-assembler "mxu2_srar_w.*:.*srarw.*mxu2_srar_w" } } */
/* { dg-final { scan-assembler "mxu2_srar_d.*:.*srard.*mxu2_srar_d" } } */
/* { dg-final { scan-assembler "mxu2_srari_b.*:.*srarib.*mxu2_srari_b" } } */
/* { dg-final { scan-assembler "mxu2_srari_h.*:.*srarih.*mxu2_srari_h" } } */
/* { dg-final { scan-assembler "mxu2_srari_w.*:.*srariw.*mxu2_srari_w" } } */
/* { dg-final { scan-assembler "mxu2_srari_d.*:.*srarid.*mxu2_srari_d" } } */

/* { dg-final { scan-assembler "mxu2_srl_b.*:.*srlb.*mxu2_srl_b" } } */
/* { dg-final { scan-assembler "mxu2_srl_h.*:.*srlh.*mxu2_srl_h" } } */
/* { dg-final { scan-assembler "mxu2_srl_w.*:.*srlw.*mxu2_srl_w" } } */
/* { dg-final { scan-assembler "mxu2_srl_d.*:.*srld.*mxu2_srl_d" } } */
/* { dg-final { scan-assembler "mxu2_srli_b.*:.*srlib.*mxu2_srli_b" } } */
/* { dg-final { scan-assembler "mxu2_srli_h.*:.*srlih.*mxu2_srli_h" } } */
/* { dg-final { scan-assembler "mxu2_srli_w.*:.*srliw.*mxu2_srli_w" } } */
/* { dg-final { scan-assembler "mxu2_srli_d.*:.*srlid.*mxu2_srli_d" } } */
/* { dg-final { scan-assembler "mxu2_srlr_b.*:.*srlrb.*mxu2_srlr_b" } } */
/* { dg-final { scan-assembler "mxu2_srlr_h.*:.*srlrh.*mxu2_srlr_h" } } */
/* { dg-final { scan-assembler "mxu2_srlr_w.*:.*srlrw.*mxu2_srlr_w" } } */
/* { dg-final { scan-assembler "mxu2_srlr_d.*:.*srlrd.*mxu2_srlr_d" } } */
/* { dg-final { scan-assembler "mxu2_srlri_b.*:.*srlrib.*mxu2_srlri_b" } } */
/* { dg-final { scan-assembler "mxu2_srlri_h.*:.*srlrih.*mxu2_srlri_h" } } */
/* { dg-final { scan-assembler "mxu2_srlri_w.*:.*srlriw.*mxu2_srlri_w" } } */
/* { dg-final { scan-assembler "mxu2_srlri_d.*:.*srlrid.*mxu2_srlri_d" } } */

/* { dg-final { scan-assembler "mxu2_bnez1qtest.*:.*bnez1q.*mxu2_bnez1qtest" } } */
/* { dg-final { scan-assembler "mxu2_bnez16btest.*:.*bnez16b.*mxu2_bnez16btest" } } */
/* { dg-final { scan-assembler "mxu2_bnez8htest.*:.*bnez8h.*mxu2_bnez8htest" } } */
/* { dg-final { scan-assembler "mxu2_bnez4wtest.*:.*bnez4w.*mxu2_bnez4wtest" } } */
/* { dg-final { scan-assembler "mxu2_bnez2dtest.*:.*bnez2d.*mxu2_bnez2dtest" } } */
/* { dg-final { scan-assembler "mxu2_beqz1qtest.*:.*beqz1q.*mxu2_beqz1qtest" } } */
/* { dg-final { scan-assembler "mxu2_beqz16btest.*:.*beqz16b.*mxu2_beqz16btest" } } */
/* { dg-final { scan-assembler "mxu2_beqz8htest.*:.*beqz8h.*mxu2_beqz8htest" } } */
/* { dg-final { scan-assembler "mxu2_beqz4wtest.*:.*beqz4w.*mxu2_beqz4wtest" } } */
/* { dg-final { scan-assembler "mxu2_beqz2dtest.*:.*beqz2d.*mxu2_beqz2dtest" } } */

/* { dg-final { scan-assembler "mxu2_shufvtest.*:.*shufv.*mxu2_shufvtest" } } */
/* { dg-final { scan-assembler "mxu2_insfcpu_b.*:.*insfcpub.*mxu2_insfcpu_b" } } */
/* { dg-final { scan-assembler "mxu2_insfcpu_h.*:.*insfcpuh.*mxu2_insfcpu_h" } } */
/* { dg-final { scan-assembler "mxu2_insfcpu_w.*:.*insfcpuw.*mxu2_insfcpu_w" } } */
/* { dg-final { scan-assembler "mxu2_insfcpu_d.*:.*insfcpuw.*insfcpuw.*mxu2_insfcpu_d" } } */
/* { dg-final { scan-assembler "mxu2_insffpu_w.*:.*insffpuw.*mxu2_insffpu_w" } } */
/* { dg-final { scan-assembler "mxu2_insffpu_d.*:.*insffpud.*mxu2_insffpu_d" } } */
/* { dg-final { scan-assembler "mxu2_insfmxu_b.*:.*insfmxub.*mxu2_insfmxu_b" } } */
/* { dg-final { scan-assembler "mxu2_insfmxu_h.*:.*insfmxuh.*mxu2_insfmxu_h" } } */
/* { dg-final { scan-assembler "mxu2_insfmxu_w.*:.*insfmxuw.*mxu2_insfmxu_w" } } */
/* { dg-final { scan-assembler "mxu2_insfmxu_d.*:.*insfmxud.*mxu2_insfmxu_d" } } */
/* { dg-final { scan-assembler "mxu2_repx_b.*:.*repxb.*repx_b" } } */
/* { dg-final { scan-assembler "mxu2_repx_h.*:.*repxh.*repx_h" } } */
/* { dg-final { scan-assembler "mxu2_repx_w.*:.*repxw.*repx_w" } } */
/* { dg-final { scan-assembler "mxu2_repx_d.*:.*repxd.*repx_d" } } */
/* { dg-final { scan-assembler "mxu2_repi_b.*:.*repib.*mxu2_repi_b" } } */
/* { dg-final { scan-assembler "mxu2_repi_h.*:.*repih.*mxu2_repi_h" } } */
/* { dg-final { scan-assembler "mxu2_repi_w.*:.*repiw.*mxu2_repi_w" } } */
/* { dg-final { scan-assembler "mxu2_repi_d.*:.*repid.*mxu2_repi_d" } } */

/* { dg-final { scan-assembler "mxu2_mtcpus_b.*:.*mtcpusb.*mxu2_mtcpus_b" } } */
/* { dg-final { scan-assembler "mxu2_mtcpus_h.*:.*mtcpush.*mxu2_mtcpus_h" } } */
/* { dg-final { scan-assembler "mxu2_mtcpus_w.*:.*mtcpusw.*mxu2_mtcpus_w" } } */
/* { dg-final { scan-assembler "mxu2_mtcpus_d.*:.*mtcpusw.*mtcpusw.*mxu2_mtcpus_d" } } */
/* { dg-final { scan-assembler "mxu2_mtcpuu_b.*:.*mtcpuub.*mxu2_mtcpuu_b" } } */
/* { dg-final { scan-assembler "mxu2_mtcpuu_h.*:.*mtcpuuh.*mxu2_mtcpuu_h" } } */
/* { dg-final { scan-assembler "mxu2_mtcpuu_w.*:.*mtcpuuw.*mxu2_mtcpuu_w" } } */
/* { dg-final { scan-assembler "mxu2_mtcpuu_d.*:.*mtcpuuw.*mtcpuuw.*mxu2_mtcpuu_d" } } */
/* { dg-final { scan-assembler "mxu2_mfcpu_b.*:.*mfcpub.*mxu2_mfcpu_b" } } */
/* { dg-final { scan-assembler "mxu2_mfcpu_h.*:.*mfcpuh.*mxu2_mfcpu_h" } } */
/* { dg-final { scan-assembler "mxu2_mfcpu_w.*:.*mfcpuw.*mxu2_mfcpu_w" } } */
/* { dg-final { scan-assembler "mxu2_mfcpu_d.*:.*mfcpuw.*mxu2_mfcpu_d" } } */
/* { dg-final { scan-assembler "mxu2_mtfpu_w.*:.*mtfpuw.*mxu2_mtfpu_w" } } */
/* { dg-final { scan-assembler "mxu2_mtfpu_d.*:.*mtfpud.*mxu2_mtfpu_d" } } */
/* { dg-final { scan-assembler "mxu2_mffpu_w.*:.*mffpuw.*mxu2_mffpu_w" } } */
/* { dg-final { scan-assembler "mxu2_mffpu_d.*:.*mffpud.*mxu2_mffpu_d" } } */
/* { dg-final { scan-assembler "mxu2_ctcmxutest.*:.*ctcmxu.*mxu2_ctcmxutest" } } */
/* { dg-final { scan-assembler "mxu2_cfcmxutest.*:.*cfcmxu.*mxu2_cfcmxutest" } } */
/* { dg-final { scan-assembler "mxu2_lu1qtest.*:.*lu1q.*mxu2_lu1qtest" } } */
/* { dg-final { scan-assembler "mxu2_lu1qxtest.*:.*lu1qx.*mxu2_lu1qxtest" } } */
/* { dg-final { scan-assembler "mxu2_la1qtest.*:.*la1q.*mxu2_la1qtest" } } */
/* { dg-final { scan-assembler "mxu2_la1qxtest.*:.*la1qx.*mxu2_la1qxtest" } } */
/* { dg-final { scan-assembler "mxu2_su1qtest.*:.*su1q.*mxu2_su1qtest" } } */
/* { dg-final { scan-assembler "mxu2_su1qxtest.*:.*su1qx.*mxu2_su1qxtest" } } */
/* { dg-final { scan-assembler "mxu2_sa1qtest.*:.*sa1q.*mxu2_sa1qtest" } } */
/* { dg-final { scan-assembler "mxu2_sa1qxtest.*:.*sa1qx.*mxu2_sa1qxtest" } } */
/* { dg-final { scan-assembler "mxu2_li_b.*:.*lib.*mxu2_li_b" } } */
/* { dg-final { scan-assembler "mxu2_li_h.*:.*lih.*mxu2_li_h" } } */
/* { dg-final { scan-assembler "mxu2_li_w.*:.*liw.*mxu2_li_w" } } */
/* { dg-final { scan-assembler "mxu2_li_d.*:.*lid.*mxu2_li_d" } } */

/* { dg-final { scan-assembler "mxu2_vcvthstest.*:.*vcvths.*mxu2_vcvthstest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtsdtest.*:.*vcvtsd.*mxu2_vcvtsdtest" } } */
/* { dg-final { scan-assembler "mxu2_vcvteshtest.*:.*vcvtesh.*mxu2_vcvteshtest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtedstest.*:.*vcvteds.*mxu2_vcvtedstest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtoshtest.*:.*vcvtosh.*mxu2_vcvtoshtest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtodstest.*:.*vcvtods.*mxu2_vcvtodstest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtsswtest.*:.*vcvtssw.*mxu2_vcvtsswtest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtsdltest.*:.*vcvtsdl.*mxu2_vcvtsdltest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtuswtest.*:.*vcvtusw.*mxu2_vcvtuswtest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtudltest.*:.*vcvtudl.*mxu2_vcvtudltest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtswstest.*:.*vcvtsws.*mxu2_vcvtswstest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtsldtest.*:.*vcvtsld.*mxu2_vcvtsldtest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtuwstest.*:.*vcvtuws.*mxu2_vcvtuwstest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtuldtest.*:.*vcvtuld.*mxu2_vcvtuldtest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtrwstest.*:.*vcvtrws.*mxu2_vcvtrwstest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtrldtest.*:.*vcvtrld.*mxu2_vcvtrldtest" } } */
/* { dg-final { scan-assembler "mxu2_vtruncswstest.*:.*vtruncsws.*mxu2_vtruncswstest" } } */
/* { dg-final { scan-assembler "mxu2_vtruncsldtest.*:.*vtruncsld.*mxu2_vtruncsldtest" } } */
/* { dg-final { scan-assembler "mxu2_vtruncuwstest.*:.*vtruncuws.*mxu2_vtruncuwstest" } } */
/* { dg-final { scan-assembler "mxu2_vtrunculdtest.*:.*vtrunculd.*mxu2_vtrunculdtest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtqeshtest.*:.*vcvtqesh.*mxu2_vcvtqeshtest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtqedwtest.*:.*vcvtqedw.*mxu2_vcvtqedwtest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtqoshtest.*:.*vcvtqosh.*mxu2_vcvtqoshtest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtqodwtest.*:.*vcvtqodw.*mxu2_vcvtqodwtest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtqhstest.*:.*vcvtqhs.*mxu2_vcvtqhstest" } } */
/* { dg-final { scan-assembler "mxu2_vcvtqwdtest.*:.*vcvtqwd.*mxu2_vcvtqwdtest" } } */

#include "mxu2.h"

#define U5MAX 31
#define U8MAX 255
#define S5MAX 15

#define v16i8_DF b
#define v8i16_DF h

#define v4i32_DF w
#define v2i64_DF d
#define v16u8_DF b
#define v8u16_DF h
#define v4u32_DF w
#define v2u64_DF d
#define v4f32_DF w
#define v2f64_DF d

#define v16i8_DBL v8i16
#define v8i16_DBL v4i32
#define v4i32_DBL v2i64
#define v16u8_DBL v8u16
#define v8u16_DBL v4u32
#define v4u32_DBL v2u64

#define v16i8_DDF h
#define v8i16_DDF w
#define v4i32_DDF d
#define v16u8_DDF h
#define v8u16_DDF w
#define v4u32_DDF d

#define v4f32_HDF h
#define v2f64_HDF w

// Signed twice the size result.
#define v16u8_SDBL v8i16
#define v8u16_SDBL v4i32
#define v4u32_SDBL v2i64

// Signed values for unsigned type, subsus_u_* instructions.
#define v16u8_S v16i8
#define v8u16_S v8i16
#define v4u32_S v4i32
#define v2u64_S v2i64

// Integer elements for fexp2.
#define v4f32_FEXP2 v4i32
#define v2f64_FEXP2 v2i64

// Return type for floating-point conversion instructions.
#define v4f32_FCNV v8i16
#define v2f64_FCNV v4f32
#define v4f32_FSINT v4i32
#define v2f64_FSINT v2i64
#define v4f32_FUINT v4u32
#define v2f64_FUINT v2u64
#define v4f32_FFP v8i16
#define v2f64_FFP v4i32

// Integer result for floating point operations.
#define v4f32_FRES v4i32
#define v2f64_FRES v2i64

// Return type for compare unsign instructions.
#define v16u8_CMP v16i8
#define v8u16_CMP v8i16
#define v4u32_CMP v4i32
#define v2u64_CMP v2i64

#define PASTE_BUILTIN(NAME, DF) _mx128_ ## NAME ## _ ## DF
#define EVAL_BUILTIN(NAME, DF) PASTE_BUILTIN(NAME, DF)
#define BUILTIN(NAME, DF) EVAL_BUILTIN(NAME, DF)

#define FN_EVAL(NAME, T) mxu2_ ## NAME ## _ ## T
#define FN(NAME, T) FN_EVAL(NAME, T)

#define PASTE_BUILTIN1(NAME, DF) _mx128_ ## NAME
#define EVAL_BUILTIN1(NAME, DF) PASTE_BUILTIN1(NAME, DF)
#define BUILTIN1(NAME, DF) EVAL_BUILTIN1(NAME, DF)

#define FN_EVAL1(NAME, T) mxu2_ ## NAME ## test
#define FN1(NAME, T) FN_EVAL1(NAME, T)

#define ADD(T) NOMIPS16 T FN(add, T ## _DF) (T i, T j) { return BUILTIN(add, T ## _DF) (i, j); }
#define ADDSS(T) NOMIPS16 T FN(addss, T ## _DF) (T i, T j) { return BUILTIN(addss, T ## _DF) (i, j); }
#define ADDUU(T) NOMIPS16 T FN(adduu, T ## _DF) (T i, T j) { return BUILTIN(adduu, T ## _DF) (i, j); }
#define ADDAS(T) NOMIPS16 T FN(addas, T ## _DF) (T i, T j) { return BUILTIN(addas, T ## _DF) (i, j); }
#define ADDA(T) NOMIPS16 T FN(adda, T ## _DF) (T i, T j) { return BUILTIN(adda, T ## _DF) (i, j); }
#define FADD(T) NOMIPS16 T FN(fadd, T ## _DF) (T i, T j) { return BUILTIN(fadd, T ## _DF) (i, j); }
#define FMADD(T) NOMIPS16 T FN(fmadd, T ## _DF) (T i, T j, T k) { return BUILTIN(fmadd, T ## _DF) (i, j, k); }
#define MADD(T) NOMIPS16 T FN(madd, T ## _DF) (T i, T j, T k) { return BUILTIN(madd, T ## _DF) (i, j, k); }
#define MADDQ(T) NOMIPS16 T FN(maddq, T ## _DF) (T i, T j, T k) { return BUILTIN(maddq, T ## _DF) (i, j, k); }
#define MADDQR(T) NOMIPS16 T FN(maddqr, T ## _DF) (T i, T j, T k) { return BUILTIN(maddqr, T ## _DF) (i, j, k); }
#define DADDS(T1,T2) NOMIPS16 T1 FN(dadds, T1 ## _DF) (T1 i, T2 j, T2 k) { return BUILTIN(dadds, T1 ## _DF) (i, j, k); }
#define DADDU(T1,T2) NOMIPS16 T1 FN(daddu, T1 ## _DF) (T1 i, T2 j, T2 k) { return BUILTIN(daddu, T1 ## _DF) (i, j, k); }

#define SUB(T) NOMIPS16 T FN(sub, T ## _DF) (T i, T j) { return BUILTIN(sub, T ## _DF) (i, j); }
#define SUBSS(T) NOMIPS16 T FN(subss, T ## _DF) (T i, T j) { return BUILTIN(subss, T ## _DF) (i, j); }
#define SUBUU(T) NOMIPS16 T FN(subuu, T ## _DF) (T i, T j) { return BUILTIN(subuu, T ## _DF) (i, j); }
#define SUBSA(T) NOMIPS16 T FN(subsa, T ## _DF) (T i, T j) { return BUILTIN(subsa, T ## _DF) (i, j); }
#define SUBUA(T1,T2) NOMIPS16 T1 FN(subua, T2 ## _DF) (T2 i, T2 j) { return BUILTIN(subua, T2 ## _DF) (i, j); }
#define SUBUS(T1,T2) NOMIPS16 T1 FN(subus, T2 ## _DF) (T2 i, T2 j) { return BUILTIN(subus, T2 ## _DF) (i, j); }
#define FSUB(T) NOMIPS16 T FN(fsub, T ## _DF) (T i, T j) { return BUILTIN(fsub, T ## _DF) (i, j); }
#define FMSUB(T) NOMIPS16 T FN(fmsub, T ## _DF) (T i, T j, T k) { return BUILTIN(fmsub, T ## _DF) (i, j, k); }
#define MSUB(T) NOMIPS16 T FN(msub, T ## _DF) (T i, T j, T k) { return BUILTIN(msub, T ## _DF) (i, j, k); }
#define MSUBQ(T) NOMIPS16 T FN(msubq, T ## _DF) (T i, T j, T k) { return BUILTIN(msubq, T ## _DF) (i, j, k); }
#define MSUBQR(T) NOMIPS16 T FN(msubqr, T ## _DF) (T i, T j, T k) { return BUILTIN(msubqr, T ## _DF) (i, j, k); }
#define DSUBS(T1,T2) NOMIPS16 T1 FN(dsubs, T1 ## _DF) (T1 i, T2 j, T2 k) { return BUILTIN(dsubs, T1 ## _DF) (i, j, k); }
#define DSUBU(T1,T2) NOMIPS16 T1 FN(dsubu, T1 ## _DF) (T1 i, T2 j, T2 k) { return BUILTIN(dsubu, T1 ## _DF) (i, j, k); }

#define MUL(T) NOMIPS16 T FN(mul, T ## _DF) (T i, T j) { return BUILTIN(mul, T ## _DF) (i, j); }
#define FMUL(T) NOMIPS16 T FN(fmul, T ## _DF) (T i, T j) { return BUILTIN(fmul, T ## _DF) (i, j); }
#define MULQ(T) NOMIPS16 T FN(mulq, T ## _DF) (T i, T j) { return BUILTIN(mulq, T ## _DF) (i, j); }
#define MULQR(T) NOMIPS16 T FN(mulqr, T ## _DF) (T i, T j) { return BUILTIN(mulqr, T ## _DF) (i, j); }

#define DIVS(T) NOMIPS16 T FN(divs, T ## _DF) (T i, T j) { return BUILTIN(divs, T ## _DF) (i, j); }
#define DIVU(T) NOMIPS16 T FN(divu, T ## _DF) (T i, T j) { return BUILTIN(divu, T ## _DF) (i, j); }
#define FDIV(T) NOMIPS16 T FN(fdiv, T ## _DF) (T i, T j) { return BUILTIN(fdiv, T ## _DF) (i, j); }

#define MODS(T) NOMIPS16 T FN(mods, T ## _DF) (T i, T j) { return BUILTIN(mods, T ## _DF) (i, j); }
#define MODU(T) NOMIPS16 T FN(modu, T ## _DF) (T i, T j) { return BUILTIN(modu, T ## _DF) (i, j); }

#define MAXA(T) NOMIPS16 T FN(maxa, T ## _DF) (T i, T j) { return BUILTIN(maxa, T ## _DF) (i, j); }
#define MAXS(T) NOMIPS16 T FN(maxs, T ## _DF) (T i, T j) { return BUILTIN(maxs, T ## _DF) (i, j); }
#define MAXU(T) NOMIPS16 T FN(maxu, T ## _DF) (T i, T j) { return BUILTIN(maxu, T ## _DF) (i, j); }
#define FMAX(T) NOMIPS16 T FN(fmax, T ## _DF) (T i, T j) { return BUILTIN(fmax, T ## _DF) (i, j); }
#define FMAXA(T) NOMIPS16 T FN(fmaxa, T ## _DF) (T i, T j) { return BUILTIN(fmaxa, T ## _DF) (i, j); }

#define MINA(T) NOMIPS16 T FN(mina, T ## _DF) (T i, T j) { return BUILTIN(mina, T ## _DF) (i, j); }
#define MINS(T) NOMIPS16 T FN(mins, T ## _DF) (T i, T j) { return BUILTIN(mins, T ## _DF) (i, j); }
#define MINU(T) NOMIPS16 T FN(minu, T ## _DF) (T i, T j) { return BUILTIN(minu, T ## _DF) (i, j); }
#define FMIN(T) NOMIPS16 T FN(fmin, T ## _DF) (T i, T j) { return BUILTIN(fmin, T ## _DF) (i, j); }
#define FMINA(T) NOMIPS16 T FN(fmina, T ## _DF) (T i, T j) { return BUILTIN(fmina, T ## _DF) (i, j); }

#define SATS(T) NOMIPS16 T FN(sats, T ## _DF) (T i) { return BUILTIN(sats, T ## _DF) (i, 0); }
#define SATU(T) NOMIPS16 T FN(satu, T ## _DF) (T i) { return BUILTIN(satu, T ## _DF) (i, 0); }

#define AVERS(T) NOMIPS16 T FN(avers, T ## _DF) (T i, T j) { return BUILTIN(avers, T ## _DF) (i, j); }
#define AVERU(T) NOMIPS16 T FN(averu, T ## _DF) (T i, T j) { return BUILTIN(averu, T ## _DF) (i, j); }
#define AVES(T) NOMIPS16 T FN(aves, T ## _DF) (T i, T j) { return BUILTIN(aves, T ## _DF) (i, j); }
#define AVEU(T) NOMIPS16 T FN(aveu, T ## _DF) (T i, T j) { return BUILTIN(aveu, T ## _DF) (i, j); }

#define FSQRT(T) NOMIPS16 T FN(fsqrt, T ## _DF) (T i) { return BUILTIN(fsqrt, T ## _DF) (i); }

#define DOTPS(T1, T2) NOMIPS16 T1 FN(dotps, T1 ## _DF) (T2 i, T2 j) { return BUILTIN(dotps, T1 ## _DF) (i, j); }
#define DOTPU(T1, T2) NOMIPS16 T1 FN(dotpu, T1 ## _DF) (T2 i, T2 j) { return BUILTIN(dotpu, T1 ## _DF) (i, j); }

#define FCLASS(T1, T2) NOMIPS16 T1 FN(fclass, T2 ## _DF) (T2 i) { return BUILTIN(fclass, T2 ## _DF) (i); }

#define XORV(T) NOMIPS16 T FN1(xorv, T ## _DF) (T i, T j) { return BUILTIN1(xorv, T ## _DF) (i, j); }
#define XORIB(T) NOMIPS16 T FN1(xorib, T ## _DF) (T i) { return BUILTIN1(xorib, T ## _DF) (i, 31); }
#define ORV(T) NOMIPS16 T FN1(orv, T ## _DF) (T i, T j) { return BUILTIN1(orv, T ## _DF) (i, j); }
#define ORIB(T) NOMIPS16 T FN1(orib, T ## _DF) (T i) { return BUILTIN1(orib, T ## _DF) (i, 31); }
#define NORV(T) NOMIPS16 T FN1(norv, T ## _DF) (T i, T j) { return BUILTIN1(norv, T ## _DF) (i, j); }
#define NORIB(T) NOMIPS16 T FN1(norib, T ## _DF) (T i) { return BUILTIN1(norib, T ## _DF) (i, 31); }
#define LOC(T) NOMIPS16 T FN(loc, T ## _DF) (T i) { return BUILTIN(loc, T ## _DF) (i); }
#define LZC(T) NOMIPS16 T FN(lzc, T ## _DF) (T i) { return BUILTIN(lzc, T ## _DF) (i); }
#define BCNT(T) NOMIPS16 T FN(bcnt, T ## _DF) (T i) { return BUILTIN(bcnt, T ## _DF) (i); }
#define BSELV(T) NOMIPS16 T FN1(bselv, T ## _DF) (T i, T j, T k) { return BUILTIN1(bselv, T ## _DF) (i, j, k); }

#define CEQ(T) NOMIPS16 T FN(ceq, T ## _DF) (T i, T j) { return BUILTIN(ceq, T ## _DF) (i, j); }
#define CEQZ(T) NOMIPS16 T FN(ceqz, T ## _DF) (T i) { return BUILTIN(ceqz, T ## _DF) (i); }
#define FCEQ(T1, T2) NOMIPS16 T1 FN(fceq, T2 ## _DF) (T2 i, T2 j) { return BUILTIN(fceq, T2 ## _DF) (i, j); }

#define CNE(T) NOMIPS16 T FN(cne, T ## _DF) (T i, T j) { return BUILTIN(cne, T ## _DF) (i, j); }
#define CNEZ(T) NOMIPS16 T FN(cnez, T ## _DF) (T i) { return BUILTIN(cnez, T ## _DF) (i); }

#define CLES(T) NOMIPS16 T FN(cles, T ## _DF) (T i, T j) { return BUILTIN(cles, T ## _DF) (i, j); }
#define CLEU(T1,T2) NOMIPS16 T1 FN(cleu, T2 ## _DF) (T2 i, T2 j) { return BUILTIN(cleu, T2 ## _DF) (i, j); }
#define CLEZ(T) NOMIPS16 T FN(clez, T ## _DF) (T i) { return BUILTIN(clez, T ## _DF) (i); }
#define FCLE(T1, T2) NOMIPS16 T1 FN(fcle, T2 ## _DF) (T2 i, T2 j) { return BUILTIN(fcle, T2 ## _DF) (i, j); }

#define CLTS(T) NOMIPS16 T FN(clts, T ## _DF) (T i, T j) { return BUILTIN(clts, T ## _DF) (i, j); }
#define CLTU(T1, T2) NOMIPS16 T1 FN(cltu, T1 ## _DF) (T2 i, T2 j) { return BUILTIN(cltu, T1 ## _DF) (i, j); }
#define CLTZ(T) NOMIPS16 T FN(cltz, T ## _DF) (T i) { return BUILTIN(cltz, T ## _DF) (i); }
#define FCLT(T1, T2) NOMIPS16 T1 FN(fclt, T2 ## _DF) (T2 i, T2 j) { return BUILTIN(fclt, T2 ## _DF) (i, j); }

#define FCOR(T1, T2) NOMIPS16 T1 FN(fcor, T2 ## _DF) (T2 i, T2 j) { return BUILTIN(fcor, T2 ## _DF) (i, j); }

#define SLL(T) NOMIPS16 T FN(sll, T ## _DF) (T i, T j) { return BUILTIN(sll, T ## _DF) (i, j); }
#define SLLI(T) NOMIPS16 T FN(slli, T ## _DF) (T i) { return BUILTIN(slli, T ## _DF) (i, 1); }

#define SRA(T) NOMIPS16 T FN(sra, T ## _DF) (T i, T j) { return BUILTIN(sra, T ## _DF) (i, j); }
#define SRAI(T) NOMIPS16 T FN(srai, T ## _DF) (T i) { return BUILTIN(srai, T ## _DF) (i, 1); }
#define SRAR(T) NOMIPS16 T FN(srar, T ## _DF) (T i, T j) { return BUILTIN(srar, T ## _DF) (i, j); }
#define SRARI(T) NOMIPS16 T FN(srari, T ## _DF) (T i) { return BUILTIN(srari, T ## _DF) (i, 1); }

#define SRL(T) NOMIPS16 T FN(srl, T ## _DF) (T i, T j) { return BUILTIN(srl, T ## _DF) (i, j); }
#define SRLI(T) NOMIPS16 T FN(srli, T ## _DF) (T i) { return BUILTIN(srli, T ## _DF) (i, 1); }
#define SRLR(T) NOMIPS16 T FN(srlr, T ## _DF) (T i, T j) { return BUILTIN(srlr, T ## _DF) (i, j); }
#define SRLRI(T) NOMIPS16 T FN(srlri, T ## _DF) (T i) { return BUILTIN(srlri, T ## _DF) (i, 1); }

#define BNEZ1Q(T) NOMIPS16 int FN1(bnez1q, T ## _DF) (T i) { return BUILTIN1(bnez1q, T ## _DF) (i); }
#define BNEZ16B(T) NOMIPS16 int FN1(bnez16b, T ## _DF) (T i) { return BUILTIN1(bnez16b, T ## _DF) (i); }
#define BNEZ8H(T) NOMIPS16 int FN1(bnez8h, T ## _DF) (T i) { return BUILTIN1(bnez8h, T ## _DF) (i); }
#define BNEZ4W(T) NOMIPS16 int FN1(bnez4w, T ## _DF) (T i) { return BUILTIN1(bnez4w, T ## _DF) (i); }
#define BNEZ2D(T) NOMIPS16 int FN1(bnez2d, T ## _DF) (T i) { return BUILTIN1(bnez2d, T ## _DF) (i); }
#define BEQZ1Q(T) NOMIPS16 int FN1(beqz1q, T ## _DF) (T i) { return BUILTIN1(beqz1q, T ## _DF) (i); }
#define BEQZ16B(T) NOMIPS16 int FN1(beqz16b, T ## _DF) (T i) { return BUILTIN1(beqz16b, T ## _DF) (i); }
#define BEQZ8H(T) NOMIPS16 int FN1(beqz8h, T ## _DF) (T i) { return BUILTIN1(beqz8h, T ## _DF) (i); }
#define BEQZ4W(T) NOMIPS16 int FN1(beqz4w, T ## _DF) (T i) { return BUILTIN1(beqz4w, T ## _DF) (i); }
#define BEQZ2D(T) NOMIPS16 int FN1(beqz2d, T ## _DF) (T i) { return BUILTIN1(beqz2d, T ## _DF) (i); }

#define SHUFV(T) NOMIPS16 T FN1(shufv, T ## _DF) (T i, T j, T k) { return BUILTIN1(shufv, T ## _DF) (i, j, k); }
#define INSFCPU(T) NOMIPS16 T FN(insfcpu, T ## _DF) (T i) { return BUILTIN(insfcpu, T ## _DF) (i, 1, 1); }
#define INSFFPU(T) NOMIPS16 T FN(insffpu, T ## _DF) (T i) { return BUILTIN(insffpu, T ## _DF) (i, 1, 1.0); }
#define INSFMXU(T) NOMIPS16 T FN(insfmxu, T ## _DF) (T i, T j) { return BUILTIN(insfmxu, T ## _DF) (i, 1, j); }
#define REPX(T) NOMIPS16 T FN(repx, T ## _DF) (T i) { return BUILTIN(repx, T ## _DF) (i, 1); }
#define REPI(T) NOMIPS16 T FN(repi, T ## _DF) (T i) { return BUILTIN(repi, T ## _DF) (i, 1); }

#define MTCPUS(T1,T2) NOMIPS16 T1 FN(mtcpus, T2 ## _DF) (T2 i) { return BUILTIN(mtcpus, T2 ## _DF) (i, 1); }
#define MTCPUU(T1,T2) NOMIPS16 T1 FN(mtcpuu, T2 ## _DF) (T2 i) { return BUILTIN(mtcpuu, T2 ## _DF) (i, 1); }
#define MFCPU(T1,T2) NOMIPS16 T1 FN(mfcpu, T1 ## _DF) (T2 i) { return BUILTIN(mfcpu, T1 ## _DF) (1); }
#define MTFPU(T1,T2) NOMIPS16 T1 FN(mtfpu, T2 ## _DF) (T2 i) { return BUILTIN(mtfpu, T2 ## _DF) (i,1); }
#define MFFPU(T1,T2) NOMIPS16 T1 FN(mffpu, T1 ## _DF) (T2 i) { return BUILTIN(mffpu, T1 ## _DF) (1.0); }
#define CTCMXU(T1, T2, T3) NOMIPS16 T1 FN1(ctcmxu, T2 ## _DF) (T2 i, T3 j) { return BUILTIN1(ctcmxu, T2 ## _DF) (1, 1); }
#define CFCMXU(T1, T2) NOMIPS16 T1 FN1(cfcmxu, T2 ## _DF) (T2 i) { return BUILTIN1(cfcmxu, T2 ## _DF) (1); }
#define LU1Q(T1, T2, T3) NOMIPS16 T1 FN1(lu1q, T1 ## _DF) (T2 *i, T3 j) { return BUILTIN1(lu1q, T1 ## _DF) (i,1); }
#define LU1QX(T1, T2, T3) NOMIPS16 T1 FN1(lu1qx, T1 ## _DF) (T2 *i, T3 j) { return BUILTIN1(lu1qx, T1 ## _DF) (i,1); }
#define LA1Q(T1, T2, T3) NOMIPS16 T1 FN1(la1q, T1 ## _DF) (T2 *i, T3 j) { return BUILTIN1(la1q, T1 ## _DF) (i,16); }
#define LA1QX(T1, T2, T3) NOMIPS16 T1 FN1(la1qx, T1 ## _DF) (T2 *i, T3 j) { return BUILTIN1(la1qx, T1 ## _DF) (i,16); }
#define SU1Q(T1, T2, T3, T4) NOMIPS16 T1 FN1(su1q, T2 ## _DF) (T2 i, T3 *j, T4 K) { return BUILTIN1(su1q, T2 ## _DF) (i,j,1); }
#define SU1QX(T1, T2, T3, T4) NOMIPS16 T1 FN1(su1qx, T2 ## _DF) (T2 i, T3 *j, T4 K) { return BUILTIN1(su1qx, T2 ## _DF) (i,j,1); }
#define SA1Q(T1, T2, T3, T4) NOMIPS16 T1 FN1(sa1q, T2 ## _DF) (T2 i, T3 *j, T4 K) { return BUILTIN1(sa1q, T2 ## _DF) (i,j,16); }
#define SA1QX(T1, T2, T3, T4) NOMIPS16 T1 FN1(sa1qx, T2 ## _DF) (T2 i, T3 *j, T4 K) { return BUILTIN1(sa1qx, T2 ## _DF) (i,j,16); }
#define LI(T) NOMIPS16 T FN(li, T ## _DF) (short i) { return BUILTIN(li, T ## _DF) (1); }

#define VCVTHS(T1, T2) NOMIPS16 T1 FN1(vcvths, T2 ## _DF) (T2 i, T2 j) { return BUILTIN1(vcvths, T1 ## _DF) (i, j); }
#define VCVTSD(T1, T2) NOMIPS16 T1 FN1(vcvtsd, T2 ## _DF) (T2 i, T2 j) { return BUILTIN1(vcvtsd, T1 ## _DF) (i, j); }
#define VCVTESH(T1, T2) NOMIPS16 T1 FN1(vcvtesh, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtesh, T1 ## _DF) (i); }
#define VCVTEDS(T1, T2) NOMIPS16 T1 FN1(vcvteds, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvteds, T1 ## _DF) (i); }
#define VCVTOSH(T1, T2) NOMIPS16 T1 FN1(vcvtosh, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtosh, T1 ## _DF) (i); }
#define VCVTODS(T1, T2) NOMIPS16 T1 FN1(vcvtods, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtods, T1 ## _DF) (i); }
#define VCVTSSW(T1, T2) NOMIPS16 T1 FN1(vcvtssw, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtssw, T1 ## _DF) (i); }
#define VCVTSDL(T1, T2) NOMIPS16 T1 FN1(vcvtsdl, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtsdl, T1 ## _DF) (i); }
#define VCVTUSW(T1, T2) NOMIPS16 T1 FN1(vcvtusw, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtusw, T1 ## _DF) (i); }
#define VCVTUDL(T1, T2) NOMIPS16 T1 FN1(vcvtudl, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtudl, T1 ## _DF) (i); }
#define VCVTSWS(T1, T2) NOMIPS16 T1 FN1(vcvtsws, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtsws, T1 ## _DF) (i); }
#define VCVTSLD(T1, T2) NOMIPS16 T1 FN1(vcvtsld, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtsld, T1 ## _DF) (i); }
#define VCVTUWS(T1, T2) NOMIPS16 T1 FN1(vcvtuws, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtuws, T1 ## _DF) (i); }
#define VCVTULD(T1, T2) NOMIPS16 T1 FN1(vcvtuld, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtuld, T1 ## _DF) (i); }
#define VCVTRWS(T1, T2) NOMIPS16 T1 FN1(vcvtrws, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtrws, T1 ## _DF) (i); }
#define VCVTRLD(T1, T2) NOMIPS16 T1 FN1(vcvtrld, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtrld, T1 ## _DF) (i); }
#define VTRUNCSWS(T1, T2) NOMIPS16 T1 FN1(vtruncsws, T2 ## _DF) (T2 i ){ return BUILTIN1(vtruncsws, T1 ## _DF) (i); }
#define VTRUNCSLD(T1, T2) NOMIPS16 T1 FN1(vtruncsld, T2 ## _DF) (T2 i ){ return BUILTIN1(vtruncsld, T1 ## _DF) (i); }
#define VTRUNCUWS(T1, T2) NOMIPS16 T1 FN1(vtruncuws, T2 ## _DF) (T2 i ){ return BUILTIN1(vtruncuws, T1 ## _DF) (i); }
#define VTRUNCULD(T1, T2) NOMIPS16 T1 FN1(vtrunculd, T2 ## _DF) (T2 i ){ return BUILTIN1(vtrunculd, T1 ## _DF) (i); }
#define VCVTQESH(T1, T2) NOMIPS16 T1 FN1(vcvtqesh, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtqesh, T1 ## _DF) (i); }
#define VCVTQEDW(T1, T2) NOMIPS16 T1 FN1(vcvtqedw, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtqedw, T1 ## _DF) (i); }
#define VCVTQOSH(T1, T2) NOMIPS16 T1 FN1(vcvtqosh, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtqosh, T1 ## _DF) (i); }
#define VCVTQODW(T1, T2) NOMIPS16 T1 FN1(vcvtqodw, T2 ## _DF) (T2 i ){ return BUILTIN1(vcvtqodw, T1 ## _DF) (i); }
#define VCVTQHS(T1, T2) NOMIPS16 T1 FN1(vcvtqhs, T2 ## _DF) (T2 i, T2 j ){ return BUILTIN1(vcvtqhs, T1 ## _DF) (i, j); }
#define VCVTQWD(T1, T2) NOMIPS16 T1 FN1(vcvtqwd, T2 ## _DF) (T2 i, T2 j ){ return BUILTIN1(vcvtqwd, T1 ## _DF) (i, j); }


#define ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(FUNC) \
  FUNC (v16i8) \
  FUNC (v8i16) \
  FUNC (v4i32) \
  FUNC (v2i64)

#define ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES_2(FUNC) \
  FUNC (v16i8) \
  FUNC (v8i16) \
  FUNC (v4i32)

#define ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES(FUNC) \
  FUNC (v16u8) \
  FUNC (v8u16) \
  FUNC (v4u32) \
  FUNC (v2u64)

#define ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES_2(FUNC) \
  FUNC (v16u8) \
  FUNC (v8u16) \
  FUNC (v4u32)

#define ITERATE_FOR_ALL_REAL_VECTOR_TYPES(FUNC) \
  FUNC (v4f32) \
  FUNC (v2f64) \

#define ITERATE_FOR_H_W_SIGNED_INT_VECTOR_TYPES(FUNC) \
  FUNC (v8i16) \
  FUNC (v4i32) \

#define ITERATE_DDT_SIGNED_VECTOR_TYPES(FUNC) \
  FUNC (v8i16,v16i8) \
  FUNC (v4i32,v8i16) \
  FUNC (v2i64,v4i32) \

#define ITERATE_DDT_UNSIGNED_VECTOR_TYPES(FUNC) \
  FUNC (v8u16,v16u8) \
  FUNC (v4u32,v8u16) \
  FUNC (v2u64,v4u32) \

#define ITERATE_V16I8_SIGNED_VECTOR_TYPES(FUNC) \
  FUNC (v16i8) \

#define ITERATE_V8I16_SIGNED_VECTOR_TYPES(FUNC) \
  FUNC (v8i16) \

#define ITERATE_V4I32_SIGNED_VECTOR_TYPES(FUNC) \
  FUNC (v4i32) \

#define ITERATE_V2I64_SIGNED_VECTOR_TYPES(FUNC) \
  FUNC (v2i64) \

#define ITERATE_V16U8_UNSIGNED_VECTOR_TYPES(FUNC) \
  FUNC (v16u8) \

#define ITERATE_V8U16_UNSIGNED_VECTOR_TYPES(FUNC) \
  FUNC (v8u16) \

#define ITERATE_V4U32_UNSIGNED_VECTOR_TYPES(FUNC) \
  FUNC (v4u32) \

#define ITERATE_V2U64_UNSIGNED_VECTOR_TYPES(FUNC) \
  FUNC (v2u64) \

#define ITERATE_CLASS_VECTOR_TYPES(FUNC) \
  FUNC (v4i32,v4f32) \
  FUNC (v2i64,v2f64) \

#define ITERATE_MTCPUS_VECTOR_TYPES(FUNC) \
  FUNC (int,v16i8) \
  FUNC (int,v8i16) \
  FUNC (int,v4i32) \
  FUNC (long long,v2i64) \

#define ITERATE_MTCPUU_VECTOR_TYPES(FUNC) \
  FUNC (unsigned int,v16i8) \
  FUNC (unsigned int,v8i16) \
  FUNC (unsigned int,v4i32) \
  FUNC (unsigned long long,v2i64) \

#define ITERATE_MFCPU_VECTOR_TYPES(FUNC) \
  FUNC (v16i8, int) \
  FUNC (v8i16, int) \
  FUNC (v4i32, int) \
  FUNC (v2i64, long long) \

#define ITERATE_MTFPU_VECTOR_TYPES(FUNC) \
  FUNC (float, v4f32) \
  FUNC (double, v2f64) \

#define ITERATE_MFFPU_VECTOR_TYPES(FUNC) \
  FUNC (v4f32,float) \
  FUNC (v2f64,double) \

#define ITERATE_CTCMXU_VECTOR_TYPES(FUNC) \
  FUNC (void,unsigned char,int) \

#define ITERATE_CFCMXU_VECTOR_TYPES(FUNC) \
  FUNC (int,unsigned char) \

#define ITERATE_LU1Q_VECTOR_TYPES(FUNC) \
  FUNC (v16i8 ,void , int ) \

#define ITERATE_LA1Q_VECTOR_TYPES(FUNC) \
  FUNC (v16i8 ,void, int ) \

#define ITERATE_SU1Q_VECTOR_TYPES(FUNC) \
  FUNC (void ,v16i8 ,void , int ) \

#define ITERATE_SA1Q_VECTOR_TYPES(FUNC) \
  FUNC (void ,v16i8 ,void , int ) \



#define ITERATE_VCVTHS_VECTOR_TYPES(FUNC) \
  FUNC (v8i16,v4f32) \

#define ITERATE_VCVTSD_VECTOR_TYPES(FUNC) \
  FUNC (v4f32,v2f64) \

#define ITERATE_VCVTESH_VECTOR_TYPES(FUNC) \
  FUNC (v4f32,v8i16) \

#define ITERATE_VCVTEDS_VECTOR_TYPES(FUNC) \
  FUNC (v2f64,v4f32) \

#define ITERATE_VCVTOSH_VECTOR_TYPES(FUNC) \
  FUNC (v4f32,v8i16) \

#define ITERATE_VCVTODS_VECTOR_TYPES(FUNC) \
  FUNC (v2f64,v4f32) \

#define ITERATE_VCVTSSW_VECTOR_TYPES(FUNC) \
  FUNC (v4f32,v4i32) \

#define ITERATE_VCVTSDL_VECTOR_TYPES(FUNC) \
  FUNC (v2f64,v2i64) \

#define ITERATE_VCVTUSW_VECTOR_TYPES(FUNC) \
  FUNC (v4f32,v4u32) \

#define ITERATE_VCVTUDL_VECTOR_TYPES(FUNC) \
  FUNC (v2f64,v2u64) \

#define ITERATE_VCVTSWS_VECTOR_TYPES(FUNC) \
  FUNC (v4i32,v4f32) \

#define ITERATE_VCVTSLD_VECTOR_TYPES(FUNC) \
  FUNC (v2i64,v2f64) \

#define ITERATE_VCVTUWS_VECTOR_TYPES(FUNC) \
  FUNC (v4u32,v4f32) \

#define ITERATE_VCVTULD_VECTOR_TYPES(FUNC) \
  FUNC (v2u64,v2f64) \

#define ITERATE_VCVTRWS_VECTOR_TYPES(FUNC) \
  FUNC (v4i32,v4f32) \

#define ITERATE_VCVTRLD_VECTOR_TYPES(FUNC) \
  FUNC (v2i64,v2f64) \

#define ITERATE_VTRUNCSWS_VECTOR_TYPES(FUNC) \
  FUNC (v4i32,v4f32) \

#define ITERATE_VTRUNCSLD_VECTOR_TYPES(FUNC) \
  FUNC (v2i64,v2f64) \

#define ITERATE_VTRUNCUWS_VECTOR_TYPES(FUNC) \
  FUNC (v4u32,v4f32) \

#define ITERATE_VTRUNCULD_VECTOR_TYPES(FUNC) \
  FUNC (v2u64,v2f64) \

#define ITERATE_VCVTQESH_VECTOR_TYPES(FUNC) \
  FUNC (v4f32,v8i16) \

#define ITERATE_VCVTQEDW_VECTOR_TYPES(FUNC) \
  FUNC (v2f64,v4i32) \

#define ITERATE_VCVTQOSH_VECTOR_TYPES(FUNC) \
  FUNC (v4f32,v8i16) \

#define ITERATE_VCVTQODW_VECTOR_TYPES(FUNC) \
  FUNC (v2f64,v4i32) \

#define ITERATE_VCVTQHS_VECTOR_TYPES(FUNC) \
  FUNC (v8i16,v4f32) \

#define ITERATE_VCVTQWD_VECTOR_TYPES(FUNC) \
  FUNC (v4i32,v2f64) \

#define ITERATE_SUBUA_VECTOR_TYPES(FUNC) \
  FUNC (v16i8,v16u8) \
  FUNC (v8i16,v8u16) \
  FUNC (v4i32,v4u32) \
  FUNC (v2i64,v2u64) \

#define ITERATE_SUBUS_VECTOR_TYPES(FUNC) \
  FUNC (v16i8,v16u8) \
  FUNC (v8i16,v8u16) \
  FUNC (v4i32,v4u32) \
  FUNC (v2i64,v2u64) \

#define ITERATE_DSUBU_VECTOR_TYPES(FUNC) \
  FUNC (v8i16,v16u8) \
  FUNC (v4i32,v8u16) \
  FUNC (v2i64,v4u32) \

#define ITERATE_CLEU_VECTOR_TYPES(FUNC) \
  FUNC (v16i8,v16u8) \
  FUNC (v8i16,v8u16) \
  FUNC (v4i32,v4u32) \
  FUNC (v2i64,v2u64) \

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (ADD)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (ADDSS)
ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES (ADDUU)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (ADDAS)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (ADDA)
ITERATE_FOR_ALL_REAL_VECTOR_TYPES (FADD)
ITERATE_FOR_ALL_REAL_VECTOR_TYPES (FMADD)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (MADD)
ITERATE_FOR_H_W_SIGNED_INT_VECTOR_TYPES (MADDQ)
ITERATE_FOR_H_W_SIGNED_INT_VECTOR_TYPES (MADDQR)
ITERATE_DDT_SIGNED_VECTOR_TYPES(DADDS)
ITERATE_DDT_UNSIGNED_VECTOR_TYPES(DADDU)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SUB)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SUBSS)
ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES (SUBUU)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SUBSA)
ITERATE_SUBUA_VECTOR_TYPES (SUBUA)
ITERATE_SUBUS_VECTOR_TYPES (SUBUS)
ITERATE_FOR_ALL_REAL_VECTOR_TYPES (FSUB)
ITERATE_FOR_ALL_REAL_VECTOR_TYPES (FMSUB)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (MSUB)
ITERATE_FOR_H_W_SIGNED_INT_VECTOR_TYPES (MSUBQ)
ITERATE_FOR_H_W_SIGNED_INT_VECTOR_TYPES (MSUBQR)
ITERATE_DDT_SIGNED_VECTOR_TYPES(DSUBS)
ITERATE_DSUBU_VECTOR_TYPES(DSUBU)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (MUL)
ITERATE_FOR_ALL_REAL_VECTOR_TYPES (FMUL)
ITERATE_FOR_H_W_SIGNED_INT_VECTOR_TYPES (MULQ)
ITERATE_FOR_H_W_SIGNED_INT_VECTOR_TYPES (MULQR)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (DIVS)
ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES (DIVU)
ITERATE_FOR_ALL_REAL_VECTOR_TYPES (FDIV)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (MODS)
ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES (MODU)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (MAXA)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (MAXS)
ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES (MAXU)
ITERATE_FOR_ALL_REAL_VECTOR_TYPES (FMAX)
ITERATE_FOR_ALL_REAL_VECTOR_TYPES (FMAXA)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (MINA)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (MINS)
ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES (MINU)
ITERATE_FOR_ALL_REAL_VECTOR_TYPES (FMIN)
ITERATE_FOR_ALL_REAL_VECTOR_TYPES (FMINA)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SATS)
ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES (SATU)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (AVERS)
ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES (AVERU)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (AVES)
ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES (AVEU)

ITERATE_FOR_ALL_REAL_VECTOR_TYPES (FSQRT)

ITERATE_DDT_SIGNED_VECTOR_TYPES (DOTPS)
ITERATE_DDT_UNSIGNED_VECTOR_TYPES (DOTPU)

ITERATE_CLASS_VECTOR_TYPES (FCLASS)

ITERATE_V16I8_SIGNED_VECTOR_TYPES(XORV)
ITERATE_V16I8_SIGNED_VECTOR_TYPES(XORIB)
ITERATE_V16I8_SIGNED_VECTOR_TYPES(ORV)
ITERATE_V16I8_SIGNED_VECTOR_TYPES(ORIB)
ITERATE_V16I8_SIGNED_VECTOR_TYPES(NORV)
ITERATE_V16I8_SIGNED_VECTOR_TYPES(NORIB)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (LOC)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (LZC)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (BCNT)
ITERATE_V16I8_SIGNED_VECTOR_TYPES(BSELV)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (CEQ)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (CEQZ)
ITERATE_CLASS_VECTOR_TYPES (FCEQ)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (CNE)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (CNEZ)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (CLES)
ITERATE_CLEU_VECTOR_TYPES (CLEU)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (CLEZ)
ITERATE_CLASS_VECTOR_TYPES (FCLE)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (CLTS)
ITERATE_CLEU_VECTOR_TYPES (CLTU)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (CLTZ)
ITERATE_CLASS_VECTOR_TYPES (FCLT)

ITERATE_CLASS_VECTOR_TYPES (FCOR)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SLL)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SLLI)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SRA)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SRAI)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SRAR)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SRARI)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SRL)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SRLI)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SRLR)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (SRLRI)

ITERATE_V16U8_UNSIGNED_VECTOR_TYPES(BNEZ1Q)
ITERATE_V16U8_UNSIGNED_VECTOR_TYPES(BNEZ16B)
ITERATE_V8U16_UNSIGNED_VECTOR_TYPES(BNEZ8H)
ITERATE_V4U32_UNSIGNED_VECTOR_TYPES(BNEZ4W)
ITERATE_V2U64_UNSIGNED_VECTOR_TYPES(BNEZ2D)
ITERATE_V16U8_UNSIGNED_VECTOR_TYPES(BEQZ1Q)
ITERATE_V16U8_UNSIGNED_VECTOR_TYPES(BEQZ16B)
ITERATE_V8U16_UNSIGNED_VECTOR_TYPES(BEQZ8H)
ITERATE_V4U32_UNSIGNED_VECTOR_TYPES(BEQZ4W)
ITERATE_V2U64_UNSIGNED_VECTOR_TYPES(BEQZ2D)

ITERATE_V16I8_SIGNED_VECTOR_TYPES(SHUFV)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (INSFCPU)
ITERATE_FOR_ALL_REAL_VECTOR_TYPES (INSFFPU)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (INSFMXU)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (REPX)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (REPI)

ITERATE_MTCPUS_VECTOR_TYPES(MTCPUS)
ITERATE_MTCPUU_VECTOR_TYPES(MTCPUU)
ITERATE_MFCPU_VECTOR_TYPES(MFCPU)
ITERATE_MTFPU_VECTOR_TYPES(MTFPU)
ITERATE_MFFPU_VECTOR_TYPES(MFFPU)
ITERATE_CTCMXU_VECTOR_TYPES(CTCMXU)
ITERATE_CFCMXU_VECTOR_TYPES(CFCMXU)
ITERATE_LU1Q_VECTOR_TYPES(LU1Q)
ITERATE_LU1Q_VECTOR_TYPES(LU1QX)
ITERATE_LA1Q_VECTOR_TYPES(LA1Q)
ITERATE_LA1Q_VECTOR_TYPES(LA1QX)
ITERATE_SU1Q_VECTOR_TYPES(SU1Q)
ITERATE_SU1Q_VECTOR_TYPES(SU1QX)
ITERATE_SA1Q_VECTOR_TYPES(SA1Q)
ITERATE_SA1Q_VECTOR_TYPES(SA1QX)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES (LI)

ITERATE_VCVTHS_VECTOR_TYPES(VCVTHS)
ITERATE_VCVTSD_VECTOR_TYPES(VCVTSD)
ITERATE_VCVTESH_VECTOR_TYPES(VCVTESH)
ITERATE_VCVTEDS_VECTOR_TYPES(VCVTEDS)
ITERATE_VCVTOSH_VECTOR_TYPES(VCVTOSH)
ITERATE_VCVTODS_VECTOR_TYPES(VCVTODS)
ITERATE_VCVTSSW_VECTOR_TYPES(VCVTSSW)
ITERATE_VCVTSDL_VECTOR_TYPES(VCVTSDL)
ITERATE_VCVTUSW_VECTOR_TYPES(VCVTUSW)
ITERATE_VCVTUDL_VECTOR_TYPES(VCVTUDL)
ITERATE_VCVTSWS_VECTOR_TYPES(VCVTSWS)
ITERATE_VCVTSLD_VECTOR_TYPES(VCVTSLD)
ITERATE_VCVTUWS_VECTOR_TYPES(VCVTUWS)
ITERATE_VCVTULD_VECTOR_TYPES(VCVTULD)
ITERATE_VCVTRWS_VECTOR_TYPES(VCVTRWS)
ITERATE_VCVTRLD_VECTOR_TYPES(VCVTRLD)
ITERATE_VTRUNCSWS_VECTOR_TYPES(VTRUNCSWS)
ITERATE_VTRUNCSLD_VECTOR_TYPES(VTRUNCSLD)
ITERATE_VTRUNCUWS_VECTOR_TYPES(VTRUNCUWS)
ITERATE_VTRUNCULD_VECTOR_TYPES(VTRUNCULD)
ITERATE_VCVTQESH_VECTOR_TYPES(VCVTQESH)
ITERATE_VCVTQEDW_VECTOR_TYPES(VCVTQEDW)
ITERATE_VCVTQOSH_VECTOR_TYPES(VCVTQOSH)
ITERATE_VCVTQODW_VECTOR_TYPES(VCVTQODW)
ITERATE_VCVTQHS_VECTOR_TYPES(VCVTQHS)
ITERATE_VCVTQWD_VECTOR_TYPES(VCVTQWD)
