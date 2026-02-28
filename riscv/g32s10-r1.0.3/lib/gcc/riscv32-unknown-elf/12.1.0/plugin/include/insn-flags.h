/* Generated automatically by the program `genflags'
   from the machine description file `md'.  */

#ifndef GCC_INSN_FLAGS_H
#define GCC_INSN_FLAGS_H

#define HAVE_addsf3 (TARGET_HARD_FLOAT)
#define HAVE_adddf3 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_addhf3 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_aie_addr_update_vls_internal (TARGET_INGENICAIE && TARGET_AIE_VLS)
#define HAVE_aie_addr_update_vla (TARGET_INGENICAIE && TARGET_AIE_VLA)
#define HAVE_aie_addr_update_offset (TARGET_INGENICAIE)
#define HAVE_addsi3 1
#define HAVE_adddi3 (TARGET_64BIT)
#define HAVE_subsf3 (TARGET_HARD_FLOAT)
#define HAVE_subdf3 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_subhf3 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_subdi3 (TARGET_64BIT)
#define HAVE_subsi3 1
#define HAVE_negdi2 (TARGET_64BIT)
#define HAVE_negsi2 1
#define HAVE_mulsf3 (TARGET_HARD_FLOAT)
#define HAVE_muldf3 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_mulhf3 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_mulsi3 (TARGET_MUL)
#define HAVE_muldi3 (TARGET_MUL && TARGET_64BIT)
#define HAVE_smuldi3_highpart (TARGET_MUL && TARGET_64BIT)
#define HAVE_umuldi3_highpart (TARGET_MUL && TARGET_64BIT)
#define HAVE_usmuldi3_highpart (TARGET_MUL && TARGET_64BIT)
#define HAVE_smulsi3_highpart (TARGET_MUL && !TARGET_64BIT)
#define HAVE_umulsi3_highpart (TARGET_MUL && !TARGET_64BIT)
#define HAVE_usmulsi3_highpart (TARGET_MUL && !TARGET_64BIT)
#define HAVE_divsi3 (TARGET_DIV)
#define HAVE_udivsi3 (TARGET_DIV)
#define HAVE_modsi3 (TARGET_DIV)
#define HAVE_umodsi3 (TARGET_DIV)
#define HAVE_divdi3 (TARGET_DIV && TARGET_64BIT)
#define HAVE_udivdi3 (TARGET_DIV && TARGET_64BIT)
#define HAVE_moddi3 (TARGET_DIV && TARGET_64BIT)
#define HAVE_umoddi3 (TARGET_DIV && TARGET_64BIT)
#define HAVE_divsf3 ((TARGET_HARD_FLOAT && TARGET_FDIV) && (TARGET_HARD_FLOAT))
#define HAVE_divdf3 ((TARGET_HARD_FLOAT && TARGET_FDIV) && (TARGET_DOUBLE_FLOAT))
#define HAVE_divhf3 ((TARGET_HARD_FLOAT && TARGET_FDIV) && (TARGET_ZFH))
#define HAVE_sqrtsf2 ((TARGET_HARD_FLOAT && TARGET_FDIV) && (TARGET_HARD_FLOAT))
#define HAVE_sqrtdf2 ((TARGET_HARD_FLOAT && TARGET_FDIV) && (TARGET_DOUBLE_FLOAT))
#define HAVE_sqrthf2 ((TARGET_HARD_FLOAT && TARGET_FDIV) && (TARGET_ZFH))
#define HAVE_fmasf4 (TARGET_HARD_FLOAT)
#define HAVE_fmadf4 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_fmahf4 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_fmssf4 (TARGET_HARD_FLOAT)
#define HAVE_fmsdf4 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_fmshf4 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_fnmssf4 (TARGET_HARD_FLOAT)
#define HAVE_fnmsdf4 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_fnmshf4 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_fnmasf4 (TARGET_HARD_FLOAT)
#define HAVE_fnmadf4 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_fnmahf4 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_abssf2 (TARGET_HARD_FLOAT)
#define HAVE_absdf2 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_abshf2 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_copysignsf3 (TARGET_HARD_FLOAT)
#define HAVE_copysigndf3 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_copysignhf3 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_negsf2 (TARGET_HARD_FLOAT)
#define HAVE_negdf2 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_neghf2 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_sminsf3 (TARGET_HARD_FLOAT)
#define HAVE_smindf3 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_sminhf3 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_smaxsf3 (TARGET_HARD_FLOAT)
#define HAVE_smaxdf3 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_smaxhf3 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_andsi3 (!TARGET_64BIT)
#define HAVE_iorsi3 (!TARGET_64BIT)
#define HAVE_xorsi3 (!TARGET_64BIT)
#define HAVE_anddi3 (TARGET_64BIT)
#define HAVE_iordi3 (TARGET_64BIT)
#define HAVE_xordi3 (TARGET_64BIT)
#define HAVE_one_cmplsi2 (!TARGET_64BIT)
#define HAVE_one_cmpldi2 (TARGET_64BIT)
#define HAVE_truncdfsf2 (TARGET_DOUBLE_FLOAT)
#define HAVE_truncsfhf2 (TARGET_ZFHMIN)
#define HAVE_truncdfhf2 (TARGET_ZFHMIN && TARGET_DOUBLE_FLOAT)
#define HAVE_zero_extendqihi2 1
#define HAVE_zero_extendqisi2 1
#define HAVE_zero_extendqidi2 (TARGET_64BIT)
#define HAVE_extendsidi2 (TARGET_64BIT)
#define HAVE_extendhfsf2 (TARGET_ZFHMIN)
#define HAVE_extendsfdf2 (TARGET_DOUBLE_FLOAT)
#define HAVE_extendhfdf2 (TARGET_ZFHMIN && TARGET_DOUBLE_FLOAT)
#define HAVE_fix_truncsfsi2 (TARGET_HARD_FLOAT)
#define HAVE_fix_truncdfsi2 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_fix_trunchfsi2 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_fix_truncsfdi2 ((TARGET_HARD_FLOAT) && ((TARGET_64BIT) && (TARGET_HARD_FLOAT)))
#define HAVE_fix_truncdfdi2 ((TARGET_HARD_FLOAT) && ((TARGET_64BIT) && (TARGET_DOUBLE_FLOAT)))
#define HAVE_fix_trunchfdi2 ((TARGET_HARD_FLOAT) && ((TARGET_64BIT) && (TARGET_ZFH)))
#define HAVE_fixuns_truncsfsi2 (TARGET_HARD_FLOAT)
#define HAVE_fixuns_truncdfsi2 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_fixuns_trunchfsi2 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_fixuns_truncsfdi2 ((TARGET_HARD_FLOAT) && ((TARGET_64BIT) && (TARGET_HARD_FLOAT)))
#define HAVE_fixuns_truncdfdi2 ((TARGET_HARD_FLOAT) && ((TARGET_64BIT) && (TARGET_DOUBLE_FLOAT)))
#define HAVE_fixuns_trunchfdi2 ((TARGET_HARD_FLOAT) && ((TARGET_64BIT) && (TARGET_ZFH)))
#define HAVE_floatsisf2 (TARGET_HARD_FLOAT)
#define HAVE_floatsidf2 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_floatsihf2 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_floatdisf2 ((TARGET_HARD_FLOAT) && ((TARGET_HARD_FLOAT) && (TARGET_64BIT)))
#define HAVE_floatdidf2 ((TARGET_HARD_FLOAT) && ((TARGET_DOUBLE_FLOAT) && (TARGET_64BIT)))
#define HAVE_floatdihf2 ((TARGET_HARD_FLOAT) && ((TARGET_ZFH) && (TARGET_64BIT)))
#define HAVE_floatunssisf2 (TARGET_HARD_FLOAT)
#define HAVE_floatunssidf2 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_floatunssihf2 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_floatunsdisf2 ((TARGET_HARD_FLOAT) && ((TARGET_HARD_FLOAT) && (TARGET_64BIT)))
#define HAVE_floatunsdidf2 ((TARGET_HARD_FLOAT) && ((TARGET_DOUBLE_FLOAT) && (TARGET_64BIT)))
#define HAVE_floatunsdihf2 ((TARGET_HARD_FLOAT) && ((TARGET_ZFH) && (TARGET_64BIT)))
#define HAVE_lrintsfsi2 (TARGET_HARD_FLOAT)
#define HAVE_lroundsfsi2 (TARGET_HARD_FLOAT)
#define HAVE_lrintdfsi2 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_lrounddfsi2 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_lrinthfsi2 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_lroundhfsi2 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_lrintsfdi2 ((TARGET_HARD_FLOAT) && ((TARGET_64BIT) && (TARGET_HARD_FLOAT)))
#define HAVE_lroundsfdi2 ((TARGET_HARD_FLOAT) && ((TARGET_64BIT) && (TARGET_HARD_FLOAT)))
#define HAVE_lrintdfdi2 ((TARGET_HARD_FLOAT) && ((TARGET_64BIT) && (TARGET_DOUBLE_FLOAT)))
#define HAVE_lrounddfdi2 ((TARGET_HARD_FLOAT) && ((TARGET_64BIT) && (TARGET_DOUBLE_FLOAT)))
#define HAVE_lrinthfdi2 ((TARGET_HARD_FLOAT) && ((TARGET_64BIT) && (TARGET_ZFH)))
#define HAVE_lroundhfdi2 ((TARGET_HARD_FLOAT) && ((TARGET_64BIT) && (TARGET_ZFH)))
#define HAVE_got_loadsi (Pmode == SImode)
#define HAVE_got_loaddi (Pmode == DImode)
#define HAVE_tls_add_tp_lesi (Pmode == SImode)
#define HAVE_tls_add_tp_ledi (Pmode == DImode)
#define HAVE_got_load_tls_gdsi (Pmode == SImode)
#define HAVE_got_load_tls_gddi (Pmode == DImode)
#define HAVE_got_load_tls_iesi (Pmode == SImode)
#define HAVE_got_load_tls_iedi (Pmode == DImode)
#define HAVE_auipcsi (Pmode == SImode)
#define HAVE_auipcdi (Pmode == DImode)
#define HAVE_fence 1
#define HAVE_fence_i (TARGET_ZIFENCEI)
#define HAVE_ashlsi3 1
#define HAVE_ashrsi3 1
#define HAVE_lshrsi3 1
#define HAVE_ashldi3 (TARGET_64BIT)
#define HAVE_ashrdi3 (TARGET_64BIT)
#define HAVE_lshrdi3 (TARGET_64BIT)
#define HAVE_zero_extendsidi2_shifted (TARGET_64BIT && !TARGET_ZBA \
   && ((INTVAL (operands[3]) >> INTVAL (operands[2])) == 0xffffffff))
#define HAVE_jump 1
#define HAVE_indirect_jumpsi (Pmode == SImode)
#define HAVE_indirect_jumpdi (Pmode == DImode)
#define HAVE_tablejumpsi 1
#define HAVE_tablejumpdi (TARGET_64BIT)
#define HAVE_blockage 1
#define HAVE_simple_return 1
#define HAVE_simple_return_internal 1
#define HAVE_eh_set_lr_si (! TARGET_64BIT)
#define HAVE_eh_set_lr_di (TARGET_64BIT)
#define HAVE_eh_return_internal 1
#define HAVE_sibcall_internal (SIBLING_CALL_P (insn))
#define HAVE_sibcall_value_internal (SIBLING_CALL_P (insn))
#define HAVE_call_internal 1
#define HAVE_call_value_internal 1
#define HAVE_nop 1
#define HAVE_trap 1
#define HAVE_gpr_save 1
#define HAVE_gpr_restore 1
#define HAVE_gpr_restore_return 1
#define HAVE_riscv_frflags (TARGET_HARD_FLOAT)
#define HAVE_riscv_fsflags (TARGET_HARD_FLOAT)
#define HAVE_riscv_mret 1
#define HAVE_riscv_sret 1
#define HAVE_riscv_uret 1
#define HAVE_stack_tiesi (!TARGET_64BIT)
#define HAVE_stack_tiedi (TARGET_64BIT)
#define HAVE_stack_protect_set_si 1
#define HAVE_stack_protect_set_di (TARGET_64BIT)
#define HAVE_stack_protect_test_si 1
#define HAVE_stack_protect_test_di (TARGET_64BIT)
#define HAVE_clzsi2 (TARGET_ZBB)
#define HAVE_ctzsi2 (TARGET_ZBB)
#define HAVE_popcountsi2 (TARGET_ZBB)
#define HAVE_clzdi2 (TARGET_64BIT && TARGET_ZBB)
#define HAVE_ctzdi2 (TARGET_64BIT && TARGET_ZBB)
#define HAVE_popcountdi2 (TARGET_64BIT && TARGET_ZBB)
#define HAVE_rotrsi3 (TARGET_ZBB)
#define HAVE_rotrdi3 (TARGET_64BIT && TARGET_ZBB)
#define HAVE_rotrsi3_sext (TARGET_64BIT && TARGET_ZBB)
#define HAVE_rotlsi3 (TARGET_ZBB)
#define HAVE_rotldi3 (TARGET_64BIT && TARGET_ZBB)
#define HAVE_rotlsi3_sext (TARGET_64BIT && TARGET_ZBB)
#define HAVE_bswapsi2 ((TARGET_64BIT && TARGET_ZBB) && (!TARGET_64BIT))
#define HAVE_bswapdi2 ((TARGET_64BIT && TARGET_ZBB) && (TARGET_64BIT))
#define HAVE_sminsi3 ((TARGET_ZBB) && (!TARGET_64BIT))
#define HAVE_uminsi3 ((TARGET_ZBB) && (!TARGET_64BIT))
#define HAVE_smaxsi3 ((TARGET_ZBB) && (!TARGET_64BIT))
#define HAVE_umaxsi3 ((TARGET_ZBB) && (!TARGET_64BIT))
#define HAVE_smindi3 ((TARGET_ZBB) && (TARGET_64BIT))
#define HAVE_umindi3 ((TARGET_ZBB) && (TARGET_64BIT))
#define HAVE_smaxdi3 ((TARGET_ZBB) && (TARGET_64BIT))
#define HAVE_umaxdi3 ((TARGET_ZBB) && (TARGET_64BIT))
#define HAVE_mem_thread_fence_1 1
#define HAVE_atomic_storesi (TARGET_ATOMIC)
#define HAVE_atomic_storedi ((TARGET_ATOMIC) && (TARGET_64BIT))
#define HAVE_atomic_addsi (TARGET_ATOMIC)
#define HAVE_atomic_orsi (TARGET_ATOMIC)
#define HAVE_atomic_xorsi (TARGET_ATOMIC)
#define HAVE_atomic_andsi (TARGET_ATOMIC)
#define HAVE_atomic_adddi ((TARGET_ATOMIC) && (TARGET_64BIT))
#define HAVE_atomic_ordi ((TARGET_ATOMIC) && (TARGET_64BIT))
#define HAVE_atomic_xordi ((TARGET_ATOMIC) && (TARGET_64BIT))
#define HAVE_atomic_anddi ((TARGET_ATOMIC) && (TARGET_64BIT))
#define HAVE_atomic_fetch_addsi (TARGET_ATOMIC)
#define HAVE_atomic_fetch_orsi (TARGET_ATOMIC)
#define HAVE_atomic_fetch_xorsi (TARGET_ATOMIC)
#define HAVE_atomic_fetch_andsi (TARGET_ATOMIC)
#define HAVE_atomic_fetch_adddi ((TARGET_ATOMIC) && (TARGET_64BIT))
#define HAVE_atomic_fetch_ordi ((TARGET_ATOMIC) && (TARGET_64BIT))
#define HAVE_atomic_fetch_xordi ((TARGET_ATOMIC) && (TARGET_64BIT))
#define HAVE_atomic_fetch_anddi ((TARGET_ATOMIC) && (TARGET_64BIT))
#define HAVE_atomic_exchangesi (TARGET_ATOMIC)
#define HAVE_atomic_exchangedi ((TARGET_ATOMIC) && (TARGET_64BIT))
#define HAVE_atomic_cas_value_strongsi (TARGET_ATOMIC)
#define HAVE_atomic_cas_value_strongdi ((TARGET_ATOMIC) && (TARGET_64BIT))
#define HAVE_vec_duplicatevnx16qi (TARGET_INGENICAIE)
#define HAVE_vec_duplicatevnx8qi (TARGET_INGENICAIE)
#define HAVE_vec_duplicatevnx4qi (TARGET_INGENICAIE)
#define HAVE_vec_duplicatevnx8hi (TARGET_INGENICAIE)
#define HAVE_vec_duplicatevnx4hi (TARGET_INGENICAIE)
#define HAVE_vec_duplicatevnx4si (TARGET_INGENICAIE)
#define HAVE_vec_duplicatevnx4sf (TARGET_INGENICAIE)
#define HAVE_vec_duplicatevnx8hf (TARGET_INGENICAIE)
#define HAVE_vec_duplicatevnx4hf (TARGET_INGENICAIE)
#define HAVE_vec_duplicatevnx2di ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_vec_duplicatevnx2ti ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_vec_duplicateaie_v2oi ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_aie_vec_duplicatevnx2di ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_vec_duplicatevnx2ti ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_vec_duplicateaie_v2oi ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_livnx4sf (TARGET_INGENICAIE)
#define HAVE_livnx8hf (TARGET_INGENICAIE)
#define HAVE_livnx16qi (TARGET_INGENICAIE)
#define HAVE_livnx8hi (TARGET_INGENICAIE)
#define HAVE_livnx4si (TARGET_INGENICAIE)
#define HAVE_livnx8qi (TARGET_INGENICAIE)
#define HAVE_livnx4qi (TARGET_INGENICAIE)
#define HAVE_livnx4hi (TARGET_INGENICAIE)
#define HAVE_livnx4hf (TARGET_INGENICAIE)
#define HAVE_livnx2di ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_livnx2ti ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_liaie_v2oi ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_truncsivw2 (TARGET_INGENICAIE)
#define HAVE_truncvwsi2 (TARGET_INGENICAIE)
#define HAVE_extendvwsi2 (TARGET_INGENICAIE)
#define HAVE_extendsivw2 (TARGET_INGENICAIE)
#define HAVE_zero_extendvwsi2 (TARGET_INGENICAIE)
#define HAVE_aie_vwr_move (TARGET_INGENICAIE)
#define HAVE_addvw3 (TARGET_INGENICAIE)
#define HAVE_aie_ceqb (TARGET_INGENICAIE)
#define HAVE_aie_clesb (TARGET_INGENICAIE)
#define HAVE_aie_cleub (TARGET_INGENICAIE)
#define HAVE_aie_cltsb (TARGET_INGENICAIE)
#define HAVE_aie_cltub (TARGET_INGENICAIE)
#define HAVE_aie_ceqh (TARGET_INGENICAIE)
#define HAVE_aie_clesh (TARGET_INGENICAIE)
#define HAVE_aie_cleuh (TARGET_INGENICAIE)
#define HAVE_aie_cltsh (TARGET_INGENICAIE)
#define HAVE_aie_cltuh (TARGET_INGENICAIE)
#define HAVE_aie_ceqw (TARGET_INGENICAIE)
#define HAVE_aie_clesw (TARGET_INGENICAIE)
#define HAVE_aie_cleuw (TARGET_INGENICAIE)
#define HAVE_aie_cltsw (TARGET_INGENICAIE)
#define HAVE_aie_cltuw (TARGET_INGENICAIE)
#define HAVE_aie_ceqzb (TARGET_INGENICAIE)
#define HAVE_aie_clezb (TARGET_INGENICAIE)
#define HAVE_aie_cltzb (TARGET_INGENICAIE)
#define HAVE_aie_ceqzh (TARGET_INGENICAIE)
#define HAVE_aie_clezh (TARGET_INGENICAIE)
#define HAVE_aie_cltzh (TARGET_INGENICAIE)
#define HAVE_aie_ceqzw (TARGET_INGENICAIE)
#define HAVE_aie_clezw (TARGET_INGENICAIE)
#define HAVE_aie_cltzw (TARGET_INGENICAIE)
#define HAVE_aie_fcorw (TARGET_INGENICAIE)
#define HAVE_aie_fceqw (TARGET_INGENICAIE)
#define HAVE_aie_fclew (TARGET_INGENICAIE)
#define HAVE_aie_fcltw (TARGET_INGENICAIE)
#define HAVE_floatvnx4sivnx4sf2 (TARGET_INGENICAIE)
#define HAVE_floatvnx8hivnx8hf2 (TARGET_INGENICAIE)
#define HAVE_floatunsvnx4sivnx4sf2 (TARGET_INGENICAIE)
#define HAVE_floatunsvnx8hivnx8hf2 (TARGET_INGENICAIE)
#define HAVE_fix_truncvnx4sfvnx4si2 (TARGET_INGENICAIE)
#define HAVE_fix_truncvnx8hfvnx8hi2 (TARGET_INGENICAIE)
#define HAVE_fixuns_truncvnx4sfvnx4si2 (TARGET_INGENICAIE)
#define HAVE_fixuns_truncvnx8hfvnx8hi2 (TARGET_INGENICAIE)
#define HAVE_andvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_iorvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_xorvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_andvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_iorvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_xorvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_andvnx4si3 (TARGET_INGENICAIE)
#define HAVE_iorvnx4si3 (TARGET_INGENICAIE)
#define HAVE_xorvnx4si3 (TARGET_INGENICAIE)
#define HAVE_andvnx2di3 ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_iorvnx2di3 ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_xorvnx2di3 ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_andvnx2ti3 ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_iorvnx2ti3 ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_xorvnx2ti3 ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_andaie_v2oi3 ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_ioraie_v2oi3 ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_xoraie_v2oi3 ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_andnotvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_iornotvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_xornotvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_andnotvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_iornotvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_xornotvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_andnotvnx4si3 (TARGET_INGENICAIE)
#define HAVE_iornotvnx4si3 (TARGET_INGENICAIE)
#define HAVE_xornotvnx4si3 (TARGET_INGENICAIE)
#define HAVE_andnotvnx2di3 ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_iornotvnx2di3 ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_xornotvnx2di3 ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_andnotvnx2ti3 ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_iornotvnx2ti3 ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_xornotvnx2ti3 ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_andnotaie_v2oi3 ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_iornotaie_v2oi3 ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_xornotaie_v2oi3 ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_one_cmplvnx16qi2 (TARGET_INGENICAIE)
#define HAVE_one_cmplvnx8hi2 (TARGET_INGENICAIE)
#define HAVE_one_cmplvnx4si2 (TARGET_INGENICAIE)
#define HAVE_one_cmplvnx2di2 ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_one_cmplvnx2ti2 ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_one_cmplaie_v2oi2 ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_bselvvnx4sf_alt (TARGET_INGENICAIE)
#define HAVE_bselvvnx8hf_alt (TARGET_INGENICAIE)
#define HAVE_bselvvnx16qi_alt (TARGET_INGENICAIE)
#define HAVE_bselvvnx8hi_alt (TARGET_INGENICAIE)
#define HAVE_bselvvnx4si_alt (TARGET_INGENICAIE)
#define HAVE_bselvvnx2di_alt ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_bselvvnx2ti_alt ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_bselvaie_v2oi_alt ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_bselvvnx4sf (TARGET_INGENICAIE)
#define HAVE_bselvvnx8hf (TARGET_INGENICAIE)
#define HAVE_bselvvnx16qi (TARGET_INGENICAIE)
#define HAVE_bselvvnx8hi (TARGET_INGENICAIE)
#define HAVE_bselvvnx4si (TARGET_INGENICAIE)
#define HAVE_bselvvnx2di ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_bselvvnx2ti ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_bselvaie_v2oi ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_vashlvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_vashlvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_vashlvnx4si3 (TARGET_INGENICAIE)
#define HAVE_vashrvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_vashrvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_vashrvnx4si3 (TARGET_INGENICAIE)
#define HAVE_vlshrvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_vlshrvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_vlshrvnx4si3 (TARGET_INGENICAIE)
#define HAVE_aie_liwh_insn (TARGET_INGENICAIE)
#define HAVE_aie_liwr (TARGET_INGENICAIE)
#define HAVE_aie_lutw (TARGET_INGENICAIE)
#define HAVE_aie_lutr (TARGET_INGENICAIE)
#define HAVE_aie_nnrwr (TARGET_INGENICAIE)
#define HAVE_aie_nnrrd (TARGET_INGENICAIE)
#define HAVE_aie_nndwr (TARGET_INGENICAIE)
#define HAVE_aie_nndrd (TARGET_INGENICAIE)
#define HAVE_aie_nncmd (TARGET_INGENICAIE)
#define HAVE_aie_nnmac (TARGET_INGENICAIE)
#define HAVE_aie_mask_all_zerovnx16bi (TARGET_INGENICAIE)
#define HAVE_aie_mask_all_zerovnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_mask_all_zerovnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_mask_all_truevnx16bi (TARGET_INGENICAIE)
#define HAVE_aie_mask_all_truevnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_mask_all_truevnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_movvnx16bi (TARGET_INGENICAIE)
#define HAVE_aie_movvnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_movvnx4bi (TARGET_INGENICAIE)
#define HAVE_andvnx16bi3 (TARGET_INGENICAIE)
#define HAVE_iorvnx16bi3 (TARGET_INGENICAIE)
#define HAVE_xorvnx16bi3 (TARGET_INGENICAIE)
#define HAVE_andvnx8bi3 (TARGET_INGENICAIE)
#define HAVE_iorvnx8bi3 (TARGET_INGENICAIE)
#define HAVE_xorvnx8bi3 (TARGET_INGENICAIE)
#define HAVE_andvnx4bi3 (TARGET_INGENICAIE)
#define HAVE_iorvnx4bi3 (TARGET_INGENICAIE)
#define HAVE_xorvnx4bi3 (TARGET_INGENICAIE)
#define HAVE_notandvnx16bi3 (TARGET_INGENICAIE)
#define HAVE_notiorvnx16bi3 (TARGET_INGENICAIE)
#define HAVE_notxorvnx16bi3 (TARGET_INGENICAIE)
#define HAVE_notandvnx8bi3 (TARGET_INGENICAIE)
#define HAVE_notiorvnx8bi3 (TARGET_INGENICAIE)
#define HAVE_notxorvnx8bi3 (TARGET_INGENICAIE)
#define HAVE_notandvnx4bi3 (TARGET_INGENICAIE)
#define HAVE_notiorvnx4bi3 (TARGET_INGENICAIE)
#define HAVE_notxorvnx4bi3 (TARGET_INGENICAIE)
#define HAVE_andnotvnx16bi3 (TARGET_INGENICAIE)
#define HAVE_iornotvnx16bi3 (TARGET_INGENICAIE)
#define HAVE_xornotvnx16bi3 (TARGET_INGENICAIE)
#define HAVE_andnotvnx8bi3 (TARGET_INGENICAIE)
#define HAVE_iornotvnx8bi3 (TARGET_INGENICAIE)
#define HAVE_xornotvnx8bi3 (TARGET_INGENICAIE)
#define HAVE_andnotvnx4bi3 (TARGET_INGENICAIE)
#define HAVE_iornotvnx4bi3 (TARGET_INGENICAIE)
#define HAVE_xornotvnx4bi3 (TARGET_INGENICAIE)
#define HAVE_one_cmplvnx16bi2 (TARGET_INGENICAIE)
#define HAVE_one_cmplvnx8bi2 (TARGET_INGENICAIE)
#define HAVE_one_cmplvnx4bi2 (TARGET_INGENICAIE)
#define HAVE_aie_pcpopvnx16bi (TARGET_INGENICAIE)
#define HAVE_aie_pcpopvnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_pcpopvnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_pfirstvnx16bi (TARGET_INGENICAIE)
#define HAVE_aie_pfirstvnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_pfirstvnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_psbfvnx16bi (TARGET_INGENICAIE)
#define HAVE_aie_psifvnx16bi (TARGET_INGENICAIE)
#define HAVE_aie_psofvnx16bi (TARGET_INGENICAIE)
#define HAVE_aie_psbfvnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_psifvnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_psofvnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_psbfvnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_psifvnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_psofvnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_piotab (TARGET_INGENICAIE)
#define HAVE_aie_piotah (TARGET_INGENICAIE)
#define HAVE_aie_piotaw (TARGET_INGENICAIE)
#define HAVE_aie_pidvnx16qi (TARGET_INGENICAIE)
#define HAVE_aie_pidvnx8qi (TARGET_INGENICAIE)
#define HAVE_aie_pidvnx4qi (TARGET_INGENICAIE)
#define HAVE_aie_pidvnx8hi (TARGET_INGENICAIE)
#define HAVE_aie_pidvnx4hi (TARGET_INGENICAIE)
#define HAVE_aie_pidvnx4si (TARGET_INGENICAIE)
#define HAVE_aie_pdecvnx16bi (TARGET_INGENICAIE)
#define HAVE_aie_pdecvnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_pdecvnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_pceqvnx16qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcnevnx16qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pclesvnx16qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcleuvnx16qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltsvnx16qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltuvnx16qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pceqvnx8qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcnevnx8qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pclesvnx8qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcleuvnx8qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltsvnx8qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltuvnx8qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pceqvnx4qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcnevnx4qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pclesvnx4qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcleuvnx4qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltsvnx4qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltuvnx4qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pceqvnx8hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcnevnx8hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pclesvnx8hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcleuvnx8hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltsvnx8hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltuvnx8hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pceqvnx4hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcnevnx4hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pclesvnx4hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcleuvnx4hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltsvnx4hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltuvnx4hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pceqvnx4si_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcnevnx4si_mask (TARGET_INGENICAIE)
#define HAVE_aie_pclesvnx4si_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcleuvnx4si_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltsvnx4si_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltuvnx4si_mask (TARGET_INGENICAIE)
#define HAVE_aie_pceqzvnx16qi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pcnezvnx16qi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pclezvnx16qi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pcltzvnx16qi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pceqzvnx8qi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pcnezvnx8qi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pclezvnx8qi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pcltzvnx8qi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pceqzvnx4qi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pcnezvnx4qi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pclezvnx4qi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pcltzvnx4qi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pceqzvnx8hi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pcnezvnx8hi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pclezvnx8hi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pcltzvnx8hi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pceqzvnx4hi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pcnezvnx4hi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pclezvnx4hi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pcltzvnx4hi_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pceqzvnx4si_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pcnezvnx4si_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pclezvnx4si_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_pcltzvnx4si_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_readvl (TARGET_INGENICAIE)
#define HAVE_vundefinedvnx4sf (TARGET_INGENICAIE)
#define HAVE_vundefinedvnx8hf (TARGET_INGENICAIE)
#define HAVE_vundefinedvnx16qi (TARGET_INGENICAIE)
#define HAVE_vundefinedvnx8hi (TARGET_INGENICAIE)
#define HAVE_vundefinedvnx4si (TARGET_INGENICAIE)
#define HAVE_vundefinedvnx2di ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_vundefinedvnx2ti ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_vundefinedaie_v2oi ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_vundefinedvnx16bi (TARGET_INGENICAIE)
#define HAVE_vundefinedvnx8bi (TARGET_INGENICAIE)
#define HAVE_vundefinedvnx4bi (TARGET_INGENICAIE)
#define HAVE_addvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_subvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_mulvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_sminvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_uminvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_smaxvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_umaxvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_addvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_subvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_mulvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_sminvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_uminvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_smaxvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_umaxvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_addvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_subvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_mulvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_sminvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_uminvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_smaxvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_umaxvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_addvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_subvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_mulvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_sminvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_uminvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_smaxvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_umaxvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_addvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_subvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_mulvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_sminvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_uminvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_smaxvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_umaxvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_addvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_subvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_mulvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_sminvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_uminvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_smaxvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_umaxvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_aie_waddsbl_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsubsbl_mask (TARGET_INGENICAIE)
#define HAVE_aie_waddubl_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsububl_mask (TARGET_INGENICAIE)
#define HAVE_aie_waddsbh_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsubsbh_mask (TARGET_INGENICAIE)
#define HAVE_aie_waddubh_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsububh_mask (TARGET_INGENICAIE)
#define HAVE_aie_waddshl_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsubshl_mask (TARGET_INGENICAIE)
#define HAVE_aie_wadduhl_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsubuhl_mask (TARGET_INGENICAIE)
#define HAVE_aie_waddshh_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsubshh_mask (TARGET_INGENICAIE)
#define HAVE_aie_wadduhh_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsubuhh_mask (TARGET_INGENICAIE)
#define HAVE_absvnx16qi2_mask (TARGET_INGENICAIE)
#define HAVE_absvnx8qi2_mask (TARGET_INGENICAIE)
#define HAVE_absvnx4qi2_mask (TARGET_INGENICAIE)
#define HAVE_absvnx8hi2_mask (TARGET_INGENICAIE)
#define HAVE_absvnx4hi2_mask (TARGET_INGENICAIE)
#define HAVE_absvnx4si2_mask (TARGET_INGENICAIE)
#define HAVE_aie_smulbe_mask (TARGET_INGENICAIE)
#define HAVE_aie_umulbe_mask (TARGET_INGENICAIE)
#define HAVE_aie_smulbo_mask (TARGET_INGENICAIE)
#define HAVE_aie_umulbo_mask (TARGET_INGENICAIE)
#define HAVE_aie_smulhe_mask (TARGET_INGENICAIE)
#define HAVE_aie_umulhe_mask (TARGET_INGENICAIE)
#define HAVE_aie_smulho_mask (TARGET_INGENICAIE)
#define HAVE_aie_umulho_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsmulbl_mask (TARGET_INGENICAIE)
#define HAVE_aie_wumulbl_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsmulbh_mask (TARGET_INGENICAIE)
#define HAVE_aie_wumulbh_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsmulhl_mask (TARGET_INGENICAIE)
#define HAVE_aie_wumulhl_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsmulhh_mask (TARGET_INGENICAIE)
#define HAVE_aie_wumulhh_mask (TARGET_INGENICAIE)
#define HAVE_aie_mlaw_mask (TARGET_INGENICAIE)
#define HAVE_aie_mlsw_mask (TARGET_INGENICAIE)
#define HAVE_aie_smlahe_mask (TARGET_INGENICAIE)
#define HAVE_aie_smlshe_mask (TARGET_INGENICAIE)
#define HAVE_aie_smlaho_mask (TARGET_INGENICAIE)
#define HAVE_aie_smlsho_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsmlahl_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsmlshl_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsmlahh_mask (TARGET_INGENICAIE)
#define HAVE_aie_wsmlshh_mask (TARGET_INGENICAIE)
#define HAVE_aie_maxu2bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_maxu4bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_minu2bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_minu4bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_maxab_mask (TARGET_INGENICAIE)
#define HAVE_aie_maxah_mask (TARGET_INGENICAIE)
#define HAVE_aie_maxaw_mask (TARGET_INGENICAIE)
#define HAVE_aie_minab_mask (TARGET_INGENICAIE)
#define HAVE_aie_minah_mask (TARGET_INGENICAIE)
#define HAVE_aie_minaw_mask (TARGET_INGENICAIE)
#define HAVE_aie_satsub2bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_satsub4bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_satuub2bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_satuub4bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_satsshb_mask (TARGET_INGENICAIE)
#define HAVE_aie_satsuh2bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_satsuh4bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_satsuhb_mask (TARGET_INGENICAIE)
#define HAVE_aie_satuuh2bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_satuuh4bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_satuuhb_mask (TARGET_INGENICAIE)
#define HAVE_aie_satsswb_mask (TARGET_INGENICAIE)
#define HAVE_aie_satsswh_mask (TARGET_INGENICAIE)
#define HAVE_aie_satsuw2bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_satsuw4bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_satsuwb_mask (TARGET_INGENICAIE)
#define HAVE_aie_satsuwh_mask (TARGET_INGENICAIE)
#define HAVE_aie_satuuw4bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_satuuwb_mask (TARGET_INGENICAIE)
#define HAVE_aie_satuuwh_mask (TARGET_INGENICAIE)
#define HAVE_aie_tocb_mask (TARGET_INGENICAIE)
#define HAVE_aie_toch_mask (TARGET_INGENICAIE)
#define HAVE_aie_tocw_mask (TARGET_INGENICAIE)
#define HAVE_andvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_iorvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_xorvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_andvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_iorvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_xorvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_andvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_iorvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_xorvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_andvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_iorvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_xorvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_andvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_iorvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_xorvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_andvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_iorvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_xorvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_andnotvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_iornotvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_xornotvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_andnotvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_iornotvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_xornotvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_andnotvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_iornotvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_xornotvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_notxorvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_notxorvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_notxorvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_aie_eselvnx16qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_eselvnx8qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_eselvnx4qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_eselvnx8hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_eselvnx4hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_eselvnx4si_mask (TARGET_INGENICAIE)
#define HAVE_aie_eselvnx4sf_mask (TARGET_INGENICAIE)
#define HAVE_aie_eselvnx8hf_mask (TARGET_INGENICAIE)
#define HAVE_aie_eselvnx4hf_mask (TARGET_INGENICAIE)
#define HAVE_aie_pfcorw_mask (TARGET_INGENICAIE)
#define HAVE_aie_pfceqw_mask (TARGET_INGENICAIE)
#define HAVE_aie_pfcnew_mask (TARGET_INGENICAIE)
#define HAVE_aie_pfclew_mask (TARGET_INGENICAIE)
#define HAVE_aie_pfcltw_mask (TARGET_INGENICAIE)
#define HAVE_aie_pfcorh_mask (TARGET_INGENICAIE)
#define HAVE_aie_pfceqh_mask (TARGET_INGENICAIE)
#define HAVE_aie_pfcneh_mask (TARGET_INGENICAIE)
#define HAVE_aie_pfcleh_mask (TARGET_INGENICAIE)
#define HAVE_aie_pfclth_mask (TARGET_INGENICAIE)
#define HAVE_aie_fmaddw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fmsubw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fnmaddw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fnmsubw_mask (TARGET_INGENICAIE)
#define HAVE_aie_faddw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fsubw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fmulw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fminw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fmaxw_mask (TARGET_INGENICAIE)
#define HAVE_aie_faddh_mask (TARGET_INGENICAIE)
#define HAVE_aie_fsubh_mask (TARGET_INGENICAIE)
#define HAVE_aie_fmulh_mask (TARGET_INGENICAIE)
#define HAVE_aie_fminh_mask (TARGET_INGENICAIE)
#define HAVE_aie_fmaxh_mask (TARGET_INGENICAIE)
#define HAVE_aie_fcmulrw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fcmuliw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fcaddw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fcmulrh_mask (TARGET_INGENICAIE)
#define HAVE_aie_fcmulih_mask (TARGET_INGENICAIE)
#define HAVE_aie_fcaddh_mask (TARGET_INGENICAIE)
#define HAVE_aie_fmaxaw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fmaxah_mask (TARGET_INGENICAIE)
#define HAVE_aie_fminaw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fminah_mask (TARGET_INGENICAIE)
#define HAVE_aie_fclassw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fclassh_mask (TARGET_INGENICAIE)
#define HAVE_aie_ffsiw_mask (TARGET_INGENICAIE)
#define HAVE_aie_ffsih_mask (TARGET_INGENICAIE)
#define HAVE_aie_ffuiw_mask (TARGET_INGENICAIE)
#define HAVE_aie_ffuih_mask (TARGET_INGENICAIE)
#define HAVE_aie_ftsiw_mask (TARGET_INGENICAIE)
#define HAVE_aie_ftsih_mask (TARGET_INGENICAIE)
#define HAVE_aie_ftuiw_mask (TARGET_INGENICAIE)
#define HAVE_aie_ftuih_mask (TARGET_INGENICAIE)
#define HAVE_aie_frintw_mask (TARGET_INGENICAIE)
#define HAVE_aie_frinth_mask (TARGET_INGENICAIE)
#define HAVE_aie_ftruncsw_mask (TARGET_INGENICAIE)
#define HAVE_aie_ftruncsh_mask (TARGET_INGENICAIE)
#define HAVE_aie_ftruncuw_mask (TARGET_INGENICAIE)
#define HAVE_aie_ftruncuh_mask (TARGET_INGENICAIE)
#define HAVE_aie_fcvthw_mask (TARGET_INGENICAIE)
#define HAVE_aie_fcvtwh_mask (TARGET_INGENICAIE)
#define HAVE_vashlvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_vashlvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_vashlvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_vashlvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_vashlvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_vashlvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_aie_sllib_mask (TARGET_INGENICAIE)
#define HAVE_aie_sllih_mask (TARGET_INGENICAIE)
#define HAVE_aie_slliw_mask (TARGET_INGENICAIE)
#define HAVE_vashrvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_vashrvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_vashrvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_vashrvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_vashrvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_vashrvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_aie_sraib_mask (TARGET_INGENICAIE)
#define HAVE_aie_sraih_mask (TARGET_INGENICAIE)
#define HAVE_aie_sraiw_mask (TARGET_INGENICAIE)
#define HAVE_vlshrvnx16qi3_mask (TARGET_INGENICAIE)
#define HAVE_vlshrvnx8qi3_mask (TARGET_INGENICAIE)
#define HAVE_vlshrvnx4qi3_mask (TARGET_INGENICAIE)
#define HAVE_vlshrvnx8hi3_mask (TARGET_INGENICAIE)
#define HAVE_vlshrvnx4hi3_mask (TARGET_INGENICAIE)
#define HAVE_vlshrvnx4si3_mask (TARGET_INGENICAIE)
#define HAVE_aie_srlib_mask (TARGET_INGENICAIE)
#define HAVE_aie_srlih_mask (TARGET_INGENICAIE)
#define HAVE_aie_srliw_mask (TARGET_INGENICAIE)
#define HAVE_aie_srarb_mask (TARGET_INGENICAIE)
#define HAVE_aie_srarh_mask (TARGET_INGENICAIE)
#define HAVE_aie_srarw_mask (TARGET_INGENICAIE)
#define HAVE_aie_srarib_mask (TARGET_INGENICAIE)
#define HAVE_aie_srarih_mask (TARGET_INGENICAIE)
#define HAVE_aie_srariw_mask (TARGET_INGENICAIE)
#define HAVE_aie_srlrb_mask (TARGET_INGENICAIE)
#define HAVE_aie_srlrh_mask (TARGET_INGENICAIE)
#define HAVE_aie_srlrw_mask (TARGET_INGENICAIE)
#define HAVE_aie_srlrib_mask (TARGET_INGENICAIE)
#define HAVE_aie_srlrih_mask (TARGET_INGENICAIE)
#define HAVE_aie_srlriw_mask (TARGET_INGENICAIE)
#define HAVE_aie_gt1bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_gt2bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_gt4bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_gtb_mask (TARGET_INGENICAIE)
#define HAVE_aie_gth_mask (TARGET_INGENICAIE)
#define HAVE_aie_extuwll_mask (TARGET_INGENICAIE)
#define HAVE_aie_extuwlh_mask (TARGET_INGENICAIE)
#define HAVE_aie_extuwhl_mask (TARGET_INGENICAIE)
#define HAVE_aie_extuwhh_mask (TARGET_INGENICAIE)
#define HAVE_aie_extu1bil_mask (TARGET_INGENICAIE)
#define HAVE_aie_exts1bil_mask (TARGET_INGENICAIE)
#define HAVE_aie_extu1bih_mask (TARGET_INGENICAIE)
#define HAVE_aie_exts1bih_mask (TARGET_INGENICAIE)
#define HAVE_aie_extu2bil_mask (TARGET_INGENICAIE)
#define HAVE_aie_exts2bil_mask (TARGET_INGENICAIE)
#define HAVE_aie_extu2bih_mask (TARGET_INGENICAIE)
#define HAVE_aie_exts2bih_mask (TARGET_INGENICAIE)
#define HAVE_aie_extu4bil_mask (TARGET_INGENICAIE)
#define HAVE_aie_exts4bil_mask (TARGET_INGENICAIE)
#define HAVE_aie_extu4bih_mask (TARGET_INGENICAIE)
#define HAVE_aie_exts4bih_mask (TARGET_INGENICAIE)
#define HAVE_aie_extsbl_mask (TARGET_INGENICAIE)
#define HAVE_aie_extubl_mask (TARGET_INGENICAIE)
#define HAVE_aie_extsbh_mask (TARGET_INGENICAIE)
#define HAVE_aie_extubh_mask (TARGET_INGENICAIE)
#define HAVE_aie_extshl_mask (TARGET_INGENICAIE)
#define HAVE_aie_extuhl_mask (TARGET_INGENICAIE)
#define HAVE_aie_extshh_mask (TARGET_INGENICAIE)
#define HAVE_aie_extuhh_mask (TARGET_INGENICAIE)
#define HAVE_aie_extu3bw_mask (TARGET_INGENICAIE)
#define HAVE_aie_gshufw_mask (TARGET_INGENICAIE)
#define HAVE_aie_gshufwb_mask (TARGET_INGENICAIE)
#define HAVE_aie_gshufwb_2_mask (TARGET_INGENICAIE)
#define HAVE_aie_gshufvb_mask (TARGET_INGENICAIE)
#define HAVE_aie_ilve2bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_ilve4bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_ilvo2bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_ilvo4bi_mask (TARGET_INGENICAIE)
#define HAVE_aie_bshli_mask (TARGET_INGENICAIE)
#define HAVE_aie_bshri_mask (TARGET_INGENICAIE)
#define HAVE_aie_bshl_mask (TARGET_INGENICAIE)
#define HAVE_aie_bshr_mask (TARGET_INGENICAIE)
#define HAVE_aie_mfcpuvnx16qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_mfcpuvnx8qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_mfcpuvnx4qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_mfcpuvnx8hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_mfcpuvnx4hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_mfcpuvnx4si_mask (TARGET_INGENICAIE)
#define HAVE_aie_mfcpuvnx4sf_mask (TARGET_INGENICAIE)
#define HAVE_aie_mfcpuvnx8hf_mask (TARGET_INGENICAIE)
#define HAVE_aie_mfcpuvnx4hf_mask (TARGET_INGENICAIE)
#define HAVE_aie_mfsumz_mask_insn (TARGET_INGENICAIE)
#define HAVE_aie_mxsum_mask_insn (TARGET_INGENICAIE)
#define HAVE_aie_cmvw_mask (TARGET_INGENICAIE)
#define HAVE_aie_pmaph_mask (TARGET_INGENICAIE)
#define HAVE_aie_pmapw_mask (TARGET_INGENICAIE)
#define HAVE_aie_luvb_mask_const (TARGET_INGENICAIE && TARGET_AIE_VLS && USE_LOAD_STORE_UPDATE \
   && REG_P (XEXP (operands[3], 0)) \
   && REGNO (XEXP (operands[3], 0)) == REGNO (operands[4]) \
   && INTVAL (operands[5]) == BYTES_PER_AIE_VECTOR.to_constant ())
#define HAVE_aie_luvh_mask_const (TARGET_INGENICAIE && TARGET_AIE_VLS && USE_LOAD_STORE_UPDATE \
   && REG_P (XEXP (operands[3], 0)) \
   && REGNO (XEXP (operands[3], 0)) == REGNO (operands[4]) \
   && INTVAL (operands[5]) == BYTES_PER_AIE_VECTOR.to_constant ())
#define HAVE_aie_luvw_mask_const (TARGET_INGENICAIE && TARGET_AIE_VLS && USE_LOAD_STORE_UPDATE \
   && REG_P (XEXP (operands[3], 0)) \
   && REGNO (XEXP (operands[3], 0)) == REGNO (operands[4]) \
   && INTVAL (operands[5]) == BYTES_PER_AIE_VECTOR.to_constant ())
#define HAVE_aie_luvb_mask_reg (TARGET_INGENICAIE && TARGET_AIE_VLA && USE_LOAD_STORE_UPDATE \
   && REG_P (XEXP (operands[3], 0)) \
   && REGNO (XEXP (operands[3], 0)) == REGNO (operands[4]))
#define HAVE_aie_luvh_mask_reg (TARGET_INGENICAIE && TARGET_AIE_VLA && USE_LOAD_STORE_UPDATE \
   && REG_P (XEXP (operands[3], 0)) \
   && REGNO (XEXP (operands[3], 0)) == REGNO (operands[4]))
#define HAVE_aie_luvw_mask_reg (TARGET_INGENICAIE && TARGET_AIE_VLA && USE_LOAD_STORE_UPDATE \
   && REG_P (XEXP (operands[3], 0)) \
   && REGNO (XEXP (operands[3], 0)) == REGNO (operands[4]))
#define HAVE_aie_lavb_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_lavh_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_lavw_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_suvb_mask_const (TARGET_INGENICAIE && TARGET_AIE_VLS && USE_LOAD_STORE_UPDATE \
  && REG_P (XEXP (operands[0], 0)) \
  && REGNO (XEXP (operands[0], 0)) == REGNO (operands[3]) \
  && INTVAL (operands[4]) == BYTES_PER_AIE_VECTOR.to_constant ())
#define HAVE_aie_suvh_mask_const (TARGET_INGENICAIE && TARGET_AIE_VLS && USE_LOAD_STORE_UPDATE \
  && REG_P (XEXP (operands[0], 0)) \
  && REGNO (XEXP (operands[0], 0)) == REGNO (operands[3]) \
  && INTVAL (operands[4]) == BYTES_PER_AIE_VECTOR.to_constant ())
#define HAVE_aie_suvw_mask_const (TARGET_INGENICAIE && TARGET_AIE_VLS && USE_LOAD_STORE_UPDATE \
  && REG_P (XEXP (operands[0], 0)) \
  && REGNO (XEXP (operands[0], 0)) == REGNO (operands[3]) \
  && INTVAL (operands[4]) == BYTES_PER_AIE_VECTOR.to_constant ())
#define HAVE_aie_suvb_mask_reg (TARGET_INGENICAIE && TARGET_AIE_VLA && USE_LOAD_STORE_UPDATE \
  && REG_P (XEXP (operands[0], 0)) \
  && REGNO (XEXP (operands[0], 0)) == REGNO (operands[3]))
#define HAVE_aie_suvh_mask_reg (TARGET_INGENICAIE && TARGET_AIE_VLA && USE_LOAD_STORE_UPDATE \
  && REG_P (XEXP (operands[0], 0)) \
  && REGNO (XEXP (operands[0], 0)) == REGNO (operands[3]))
#define HAVE_aie_suvw_mask_reg (TARGET_INGENICAIE && TARGET_AIE_VLA && USE_LOAD_STORE_UPDATE \
  && REG_P (XEXP (operands[0], 0)) \
  && REGNO (XEXP (operands[0], 0)) == REGNO (operands[3]))
#define HAVE_aie_savb_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_savh_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_savw_mask_internal (TARGET_INGENICAIE)
#define HAVE_aie_maskloadvnx16qi (TARGET_INGENICAIE)
#define HAVE_aie_maskloadvnx8hi (TARGET_INGENICAIE)
#define HAVE_aie_maskloadvnx4si (TARGET_INGENICAIE)
#define HAVE_aie_maskloadvnx4sf (TARGET_INGENICAIE)
#define HAVE_aie_maskloadvnx8hf (TARGET_INGENICAIE)
#define HAVE_aie_maskstorevnx16qi (TARGET_INGENICAIE)
#define HAVE_aie_maskstorevnx8hi (TARGET_INGENICAIE)
#define HAVE_aie_maskstorevnx4si (TARGET_INGENICAIE)
#define HAVE_aie_maskstorevnx4sf (TARGET_INGENICAIE)
#define HAVE_aie_maskstorevnx8hf (TARGET_INGENICAIE)
#define HAVE_aie_ilvevnx16qi (TARGET_INGENICAIE)
#define HAVE_aie_ilvevnx8qi (TARGET_INGENICAIE)
#define HAVE_aie_ilvevnx4qi (TARGET_INGENICAIE)
#define HAVE_aie_ilvevnx8hi (TARGET_INGENICAIE)
#define HAVE_aie_ilvevnx4hi (TARGET_INGENICAIE)
#define HAVE_aie_ilvevnx4si (TARGET_INGENICAIE)
#define HAVE_aie_ilvevnx4sf (TARGET_INGENICAIE)
#define HAVE_aie_ilvevnx8hf (TARGET_INGENICAIE)
#define HAVE_aie_ilvevnx4hf (TARGET_INGENICAIE)
#define HAVE_aie_ilvovnx16qi (TARGET_INGENICAIE)
#define HAVE_aie_ilvovnx8qi (TARGET_INGENICAIE)
#define HAVE_aie_ilvovnx4qi (TARGET_INGENICAIE)
#define HAVE_aie_ilvovnx8hi (TARGET_INGENICAIE)
#define HAVE_aie_ilvovnx4hi (TARGET_INGENICAIE)
#define HAVE_aie_ilvovnx4si (TARGET_INGENICAIE)
#define HAVE_aie_ilvovnx4sf (TARGET_INGENICAIE)
#define HAVE_aie_ilvovnx8hf (TARGET_INGENICAIE)
#define HAVE_aie_ilvovnx4hf (TARGET_INGENICAIE)
#define HAVE_psubszsi3 (TARGET_INGENICAIE)
#define HAVE_aie_vec_duplicate_vlvnx16qi (TARGET_INGENICAIE)
#define HAVE_aie_vec_duplicate_vlvnx8qi (TARGET_INGENICAIE)
#define HAVE_aie_vec_duplicate_vlvnx4qi (TARGET_INGENICAIE)
#define HAVE_aie_vec_duplicate_vlvnx8hi (TARGET_INGENICAIE)
#define HAVE_aie_vec_duplicate_vlvnx4hi (TARGET_INGENICAIE)
#define HAVE_aie_vec_duplicate_vlvnx4si (TARGET_INGENICAIE)
#define HAVE_movsioi2_subreg (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_movdioi2_subreg ((TARGET_INGENICAIE && TARGET_AIE512) && (TARGET_64BIT))
#define HAVE_aie_sr1sum2bi_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2sum2bi_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4sum2bi_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8sum2bi_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16sum2bi_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sr1sum4bi_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2sum4bi_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4sum4bi_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8sum4bi_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16sum4bi_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sr1sumub_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2sumub_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4sumub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8sumub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16sumub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sr1sumsb_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2sumsb_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4sumsb_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8sumsb_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16sumsb_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sr1sumuh_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2sumuh_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4sumuh_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8sumuh_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16sumuh_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sr1sumsh_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2sumsh_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4sumsh_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8sumsh_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16sumsh_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sr1sumw_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2sumw_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4sumw_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8sumw_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16sumw_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sr1mac2bi_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2mac2bi_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4mac2bi_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8mac2bi_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16mac2bi_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sr1mac4bi_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2mac4bi_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4mac4bi_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8mac4bi_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16mac4bi_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sr1macuub_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2macuub_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4macuub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8macuub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16macuub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sr1macsub_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2macsub_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4macsub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8macsub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16macsub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sr1macssb_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2macssb_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4macssb_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8macssb_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16macssb_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sr1macssh_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr2macssh_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sr4macssh_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr8macssh_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sr16macssh_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_s1macuub_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_s2macuub_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_s4macuub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_s8macuub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_s16macuub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_s1macsub_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_s2macsub_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_s4macsub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_s8macsub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_s16macsub_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_s1macssb_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_s2macssb_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_s4macssb_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_s8macssb_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_s16macssb_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_s1macssh_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_s2macssh_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_s4macssh_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_s8macssh_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_s16macssh_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_fxas1w_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_fxas2w_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_fxas4w_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_fxas8w_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_fxas1h_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_fxas2h_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_fxas4h_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_fxas8h_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_gt2w_mask_insn (TARGET_INGENICAIE)
#define HAVE_aie_gt4w_mask_insn (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_gt8w_mask_insn (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_gt2d_mask_insn (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_gt4d_mask_insn (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_gt2q_mask_insn (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_extudll_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_extudlh_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_extudhl_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_extudhh_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_extuqll_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_extuqlh_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_extuqhl_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_extuqhh_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_extuoll_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_extuolh_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_extuohl_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_extuohh_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_shufw2_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_shufw4_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_shufw8_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_shufd2_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_shufd4_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_shufq2_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_ilveb_mask (TARGET_INGENICAIE)
#define HAVE_aie_ilveh_mask (TARGET_INGENICAIE)
#define HAVE_aie_ilvew_mask (TARGET_INGENICAIE)
#define HAVE_aie_ilved_mask ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_ilveq_mask ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_ilveo_mask ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_aie_ilvob_mask (TARGET_INGENICAIE)
#define HAVE_aie_ilvoh_mask (TARGET_INGENICAIE)
#define HAVE_aie_ilvow_mask (TARGET_INGENICAIE)
#define HAVE_aie_ilvod_mask ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_ilvoq_mask ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_ilvoo_mask ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_aie_repib_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_repih_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_repiw_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_repid_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_repiq_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_repio_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_repib (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_repih (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_repiw (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_repid ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_repiq ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_repio ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_movw (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_movd ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_movq ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_movo ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_luw_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && INTVAL (operands[5]) == GET_MODE_SIZE (SImode))
#define HAVE_aie_lud_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && INTVAL (operands[5]) == GET_MODE_SIZE (DImode)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_luq_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && INTVAL (operands[5]) == GET_MODE_SIZE (TImode)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_luo_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && INTVAL (operands[5]) == GET_MODE_SIZE (OImode)) && (TARGET_AIE512))
#define HAVE_aie_law_mask_internal (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && ((abs(INTVAL(operands[5])) \
      & (GET_MODE_SIZE (SImode) - 1)) == 0) \
   && riscv_1bit_select_p (operands[3], GET_MODE(operands[0])))
#define HAVE_aie_lad_mask_internal ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && ((abs(INTVAL(operands[5])) \
      & (GET_MODE_SIZE (DImode) - 1)) == 0) \
   && riscv_1bit_select_p (operands[3], GET_MODE(operands[0]))) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_laq_mask_internal ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && ((abs(INTVAL(operands[5])) \
      & (GET_MODE_SIZE (TImode) - 1)) == 0) \
   && riscv_1bit_select_p (operands[3], GET_MODE(operands[0]))) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_lao_mask_internal ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && ((abs(INTVAL(operands[5])) \
      & (GET_MODE_SIZE (OImode) - 1)) == 0) \
   && riscv_1bit_select_p (operands[3], GET_MODE(operands[0]))) && (TARGET_AIE512))
#define HAVE_aie_suw_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && REG_P (XEXP (operands[3], 0)) \
   && REGNO (XEXP (operands[3], 0)) == REGNO (operands[4]) \
   && INTVAL (operands[5]) == GET_MODE_SIZE (SImode))
#define HAVE_aie_sud_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && REG_P (XEXP (operands[3], 0)) \
   && REGNO (XEXP (operands[3], 0)) == REGNO (operands[4]) \
   && INTVAL (operands[5]) == GET_MODE_SIZE (DImode)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_suq_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && REG_P (XEXP (operands[3], 0)) \
   && REGNO (XEXP (operands[3], 0)) == REGNO (operands[4]) \
   && INTVAL (operands[5]) == GET_MODE_SIZE (TImode)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_suo_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && REG_P (XEXP (operands[3], 0)) \
   && REGNO (XEXP (operands[3], 0)) == REGNO (operands[4]) \
   && INTVAL (operands[5]) == GET_MODE_SIZE (OImode)) && (TARGET_AIE512))
#define HAVE_aie_saw_mask_internal (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sad_mask_internal ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_saq_mask_internal ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sao_mask_internal ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_luw2b_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (SImode))
#define HAVE_aie_luw2h_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (SImode))
#define HAVE_aie_luw4b_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (SImode))
#define HAVE_aie_luw4h_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (SImode))
#define HAVE_aie_luw8b_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (SImode)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_luw8h_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (SImode)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_luw16b_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (SImode)) && (TARGET_AIE512))
#define HAVE_aie_luw16h_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (SImode)) && (TARGET_AIE512))
#define HAVE_aie_lud2b_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (DImode))
#define HAVE_aie_lud2h_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (DImode))
#define HAVE_aie_lud2w_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (DImode))
#define HAVE_aie_lud4b_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (DImode)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_lud4h_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (DImode)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_lud4w_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (DImode)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_lud8b_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (DImode)) && (TARGET_AIE512))
#define HAVE_aie_lud8h_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (DImode)) && (TARGET_AIE512))
#define HAVE_aie_lud8w_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (DImode)) && (TARGET_AIE512))
#define HAVE_aie_luq2b_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (TImode))
#define HAVE_aie_luq2h_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (TImode))
#define HAVE_aie_luq2w_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (TImode))
#define HAVE_aie_luq2d_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (TImode))
#define HAVE_aie_luq4b_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (TImode)) && (TARGET_AIE512))
#define HAVE_aie_luq4h_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (TImode)) && (TARGET_AIE512))
#define HAVE_aie_luq4w_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (TImode)) && (TARGET_AIE512))
#define HAVE_aie_luq4d_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE256 || TARGET_AIE512) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (TImode)) && (TARGET_AIE512))
#define HAVE_aie_luo2b_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && TARGET_AIE512 \
   && INTVAL (operands[6]) == GET_MODE_SIZE (OImode))
#define HAVE_aie_luo2h_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && TARGET_AIE512 \
   && INTVAL (operands[6]) == GET_MODE_SIZE (OImode))
#define HAVE_aie_luo2w_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && TARGET_AIE512 \
   && INTVAL (operands[6]) == GET_MODE_SIZE (OImode))
#define HAVE_aie_luo2d_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && TARGET_AIE512 \
   && INTVAL (operands[6]) == GET_MODE_SIZE (OImode))
#define HAVE_aie_luo2q_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && TARGET_AIE512 \
   && INTVAL (operands[6]) == GET_MODE_SIZE (OImode))
#define HAVE_aie_law2b_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_law2h_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_law4b_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_law4h_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_law8b_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_law8h_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_law16b_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_law16h_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_lad2b_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_lad2h_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_lad2w_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_lad4b_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_lad4h_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_lad4w_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_lad8b_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_lad8h_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_lad8w_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_laq2b_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_laq2h_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_laq2w_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_laq2d_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_laq4b_mask ((TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_laq4h_mask ((TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_laq4w_mask ((TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_laq4d_mask ((TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_lao2b_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_lao2h_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_lao2w_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_lao2d_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_lao2q_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_sud2w_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && REG_P (XEXP (operands[4], 0)) \
   && REGNO (XEXP (operands[4], 0)) == REGNO (operands[5]) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (DImode))
#define HAVE_aie_sud4w_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && REG_P (XEXP (operands[4], 0)) \
   && REGNO (XEXP (operands[4], 0)) == REGNO (operands[5]) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (DImode)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sud8w_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512) \
   && REG_P (XEXP (operands[4], 0)) \
   && REGNO (XEXP (operands[4], 0)) == REGNO (operands[5]) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (DImode)) && (TARGET_AIE512))
#define HAVE_aie_suq2w_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE256 || TARGET_AIE512) \
   && REG_P (XEXP (operands[4], 0)) \
   && REGNO (XEXP (operands[4], 0)) == REGNO (operands[5]) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (TImode))
#define HAVE_aie_suq2d_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE256 || TARGET_AIE512) \
   && REG_P (XEXP (operands[4], 0)) \
   && REGNO (XEXP (operands[4], 0)) == REGNO (operands[5]) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (TImode))
#define HAVE_aie_suq4w_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE256 || TARGET_AIE512) \
   && REG_P (XEXP (operands[4], 0)) \
   && REGNO (XEXP (operands[4], 0)) == REGNO (operands[5]) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (TImode)) && (TARGET_AIE512))
#define HAVE_aie_suq4d_mask ((TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && (TARGET_AIE256 || TARGET_AIE512) \
   && REG_P (XEXP (operands[4], 0)) \
   && REGNO (XEXP (operands[4], 0)) == REGNO (operands[5]) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (TImode)) && (TARGET_AIE512))
#define HAVE_aie_suo2w_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && TARGET_AIE512 \
   && REG_P (XEXP (operands[4], 0)) \
   && REGNO (XEXP (operands[4], 0)) == REGNO (operands[5]) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (OImode))
#define HAVE_aie_suo2d_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && TARGET_AIE512 \
   && REG_P (XEXP (operands[4], 0)) \
   && REGNO (XEXP (operands[4], 0)) == REGNO (operands[5]) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (OImode))
#define HAVE_aie_suo2q_mask (TARGET_INGENICAIE && USE_LOAD_STORE_UPDATE \
   && TARGET_AIE512 \
   && REG_P (XEXP (operands[4], 0)) \
   && REGNO (XEXP (operands[4], 0)) == REGNO (operands[5]) \
   && INTVAL (operands[6]) == GET_MODE_SIZE (OImode))
#define HAVE_aie_sad2w_mask_internal (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sad4w_mask_internal ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sad8w_mask_internal ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_saq2w_mask_internal (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_saq2d_mask_internal (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_saq4w_mask_internal ((TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_saq4d_mask_internal ((TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sao2w_mask_internal (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_sao2d_mask_internal (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_sao2q_mask_internal (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_addr_update_vls (TARGET_INGENICAIE && TARGET_AIE_VLS)
#define HAVE_addvsi4 1
#define HAVE_addvdi4 (TARGET_64BIT)
#define HAVE_uaddvsi4 1
#define HAVE_uaddvdi4 (TARGET_64BIT)
#define HAVE_subvsi4 1
#define HAVE_subvdi4 (TARGET_64BIT)
#define HAVE_usubvsi4 1
#define HAVE_usubvdi4 (TARGET_64BIT)
#define HAVE_mulvsi4 (TARGET_MUL)
#define HAVE_mulvdi4 ((TARGET_MUL) && (TARGET_64BIT))
#define HAVE_umulvsi4 (TARGET_MUL)
#define HAVE_umulvdi4 ((TARGET_MUL) && (TARGET_64BIT))
#define HAVE_mulditi3 (TARGET_MUL && TARGET_64BIT)
#define HAVE_umulditi3 (TARGET_MUL && TARGET_64BIT)
#define HAVE_usmulditi3 (TARGET_MUL && TARGET_64BIT)
#define HAVE_mulsidi3 (TARGET_MUL && !TARGET_64BIT)
#define HAVE_umulsidi3 (TARGET_MUL && !TARGET_64BIT)
#define HAVE_usmulsidi3 (TARGET_MUL && !TARGET_64BIT)
#define HAVE_zero_extendsidi2 (TARGET_64BIT)
#define HAVE_zero_extendhisi2 1
#define HAVE_zero_extendhidi2 (TARGET_64BIT)
#define HAVE_extendqihi2 1
#define HAVE_extendqisi2 1
#define HAVE_extendqidi2 (TARGET_64BIT)
#define HAVE_extendhihi2 1
#define HAVE_extendhisi2 1
#define HAVE_extendhidi2 (TARGET_64BIT)
#define HAVE_movhf 1
#define HAVE_movdi 1
#define HAVE_movsi 1
#define HAVE_movhi 1
#define HAVE_movqi 1
#define HAVE_movsf 1
#define HAVE_movdf 1
#define HAVE_cpymemsi 1
#define HAVE_clear_cache 1
#define HAVE_movsicc (TARGET_SFB_ALU)
#define HAVE_movdicc ((TARGET_SFB_ALU) && (TARGET_64BIT))
#define HAVE_condjump 1
#define HAVE_cbranchqi4 (TARGET_64BIT)
#define HAVE_cbranchsi4 1
#define HAVE_cbranchdi4 (TARGET_64BIT)
#define HAVE_cbranchsf4 (TARGET_HARD_FLOAT)
#define HAVE_cbranchdf4 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_cbranchhf4 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_cstoresi4 1
#define HAVE_cstoredi4 (TARGET_64BIT)
#define HAVE_cstoresf4 (TARGET_HARD_FLOAT)
#define HAVE_cstoredf4 ((TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_cstorehf4 ((TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_flt_quietsfsi4 ((TARGET_HARD_FLOAT) && ((((!TARGET_64BIT) && (TARGET_HARD_FLOAT)) && (TARGET_HARD_FLOAT)) && (!TARGET_64BIT)))
#define HAVE_fle_quietsfsi4 ((TARGET_HARD_FLOAT) && ((((!TARGET_64BIT) && (TARGET_HARD_FLOAT)) && (TARGET_HARD_FLOAT)) && (!TARGET_64BIT)))
#define HAVE_flt_quietsfdi4 ((TARGET_HARD_FLOAT) && ((((TARGET_64BIT) && (TARGET_HARD_FLOAT)) && (TARGET_HARD_FLOAT)) && (TARGET_64BIT)))
#define HAVE_fle_quietsfdi4 ((TARGET_HARD_FLOAT) && ((((TARGET_64BIT) && (TARGET_HARD_FLOAT)) && (TARGET_HARD_FLOAT)) && (TARGET_64BIT)))
#define HAVE_flt_quietdfsi4 ((TARGET_HARD_FLOAT) && ((((!TARGET_64BIT) && (TARGET_DOUBLE_FLOAT)) && (TARGET_DOUBLE_FLOAT)) && (!TARGET_64BIT)))
#define HAVE_fle_quietdfsi4 ((TARGET_HARD_FLOAT) && ((((!TARGET_64BIT) && (TARGET_DOUBLE_FLOAT)) && (TARGET_DOUBLE_FLOAT)) && (!TARGET_64BIT)))
#define HAVE_flt_quietdfdi4 ((TARGET_HARD_FLOAT) && ((((TARGET_64BIT) && (TARGET_DOUBLE_FLOAT)) && (TARGET_DOUBLE_FLOAT)) && (TARGET_64BIT)))
#define HAVE_fle_quietdfdi4 ((TARGET_HARD_FLOAT) && ((((TARGET_64BIT) && (TARGET_DOUBLE_FLOAT)) && (TARGET_DOUBLE_FLOAT)) && (TARGET_64BIT)))
#define HAVE_flt_quiethfsi4 ((TARGET_HARD_FLOAT) && ((((!TARGET_64BIT) && (TARGET_ZFH)) && (TARGET_ZFH)) && (!TARGET_64BIT)))
#define HAVE_fle_quiethfsi4 ((TARGET_HARD_FLOAT) && ((((!TARGET_64BIT) && (TARGET_ZFH)) && (TARGET_ZFH)) && (!TARGET_64BIT)))
#define HAVE_flt_quiethfdi4 ((TARGET_HARD_FLOAT) && ((((TARGET_64BIT) && (TARGET_ZFH)) && (TARGET_ZFH)) && (TARGET_64BIT)))
#define HAVE_fle_quiethfdi4 ((TARGET_HARD_FLOAT) && ((((TARGET_64BIT) && (TARGET_ZFH)) && (TARGET_ZFH)) && (TARGET_64BIT)))
#define HAVE_indirect_jump 1
#define HAVE_tablejump 1
#define HAVE_prologue 1
#define HAVE_epilogue 1
#define HAVE_sibcall_epilogue 1
#define HAVE_return (riscv_can_use_return_insn ())
#define HAVE_eh_return 1
#define HAVE_sibcall 1
#define HAVE_sibcall_value 1
#define HAVE_call 1
#define HAVE_call_value 1
#define HAVE_untyped_call 1
#define HAVE_restore_stack_nonlocal 1
#define HAVE_get_thread_pointersi (Pmode == SImode)
#define HAVE_get_thread_pointerdi (Pmode == DImode)
#define HAVE_stack_protect_set 1
#define HAVE_stack_protect_test 1
#define HAVE_mem_thread_fence 1
#define HAVE_atomic_compare_and_swapsi (TARGET_ATOMIC)
#define HAVE_atomic_compare_and_swapdi ((TARGET_ATOMIC) && (TARGET_64BIT))
#define HAVE_atomic_test_and_set (TARGET_ATOMIC)
#define HAVE_vec_initvnx4sfsf (TARGET_INGENICAIE && TARGET_AIE_VLS)
#define HAVE_vec_initvnx8hfhf (TARGET_INGENICAIE && TARGET_AIE_VLS)
#define HAVE_vec_initvnx16qiqi (TARGET_INGENICAIE && TARGET_AIE_VLS)
#define HAVE_vec_initvnx8hihi (TARGET_INGENICAIE && TARGET_AIE_VLS)
#define HAVE_vec_initvnx4sisi (TARGET_INGENICAIE && TARGET_AIE_VLS)
#define HAVE_vec_initvnx2didi ((TARGET_INGENICAIE && TARGET_AIE_VLS) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_vec_initvnx2titi ((TARGET_INGENICAIE && TARGET_AIE_VLS) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_vec_initaie_v2oioi ((TARGET_INGENICAIE && TARGET_AIE_VLS) && (TARGET_AIE512))
#define HAVE_vec_duplicatevnx16bi (TARGET_INGENICAIE)
#define HAVE_vec_duplicatevnx8bi (TARGET_INGENICAIE)
#define HAVE_vec_duplicatevnx4bi (TARGET_INGENICAIE)
#define HAVE_movvnx4sf (TARGET_INGENICAIE)
#define HAVE_movvnx8hf (TARGET_INGENICAIE)
#define HAVE_movvnx16qi (TARGET_INGENICAIE)
#define HAVE_movvnx8hi (TARGET_INGENICAIE)
#define HAVE_movvnx4si (TARGET_INGENICAIE)
#define HAVE_movvw (TARGET_INGENICAIE)
#define HAVE_movvnx2di ((TARGET_INGENICAIE) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_movvnx2ti ((TARGET_INGENICAIE) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_movaie_v2oi ((TARGET_INGENICAIE) && (TARGET_AIE512))
#define HAVE_vec_cmpvnx16qivnx16qi (TARGET_INGENICAIE)
#define HAVE_vec_cmpvnx8hivnx8hi (TARGET_INGENICAIE)
#define HAVE_vec_cmpvnx4sivnx4si (TARGET_INGENICAIE)
#define HAVE_vec_cmpvnx4sfvnx4si (TARGET_INGENICAIE)
#define HAVE_vec_cmpuvnx16qivnx16qi (TARGET_INGENICAIE)
#define HAVE_vec_cmpuvnx8hivnx8hi (TARGET_INGENICAIE)
#define HAVE_vec_cmpuvnx4sivnx4si (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx4sfvnx4si (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx16qivnx16qi (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx8hivnx8hi (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx4sivnx4si (TARGET_INGENICAIE)
#define HAVE_vcondvnx4sfvnx4sf (TARGET_INGENICAIE)
#define HAVE_vcondvnx16qivnx16qi (TARGET_INGENICAIE)
#define HAVE_vcondvnx8hivnx8hi (TARGET_INGENICAIE)
#define HAVE_vcondvnx4sivnx4si (TARGET_INGENICAIE)
#define HAVE_vcondvnx4sivnx4sf (TARGET_INGENICAIE)
#define HAVE_vcondvnx4sfvnx4si (TARGET_INGENICAIE)
#define HAVE_vconduvnx4sfvnx4sf (TARGET_INGENICAIE)
#define HAVE_vconduvnx16qivnx16qi (TARGET_INGENICAIE)
#define HAVE_vconduvnx8hivnx8hi (TARGET_INGENICAIE)
#define HAVE_vconduvnx4sivnx4si (TARGET_INGENICAIE)
#define HAVE_vconduvnx4sfvnx4si (TARGET_INGENICAIE)
#define HAVE_aie_ceqzb_ext (TARGET_INGENICAIE)
#define HAVE_aie_clezb_ext (TARGET_INGENICAIE)
#define HAVE_aie_cltzb_ext (TARGET_INGENICAIE)
#define HAVE_aie_ceqzh_ext (TARGET_INGENICAIE)
#define HAVE_aie_clezh_ext (TARGET_INGENICAIE)
#define HAVE_aie_cltzh_ext (TARGET_INGENICAIE)
#define HAVE_aie_ceqzw_ext (TARGET_INGENICAIE)
#define HAVE_aie_clezw_ext (TARGET_INGENICAIE)
#define HAVE_aie_cltzw_ext (TARGET_INGENICAIE)
#define HAVE_aie_andib (TARGET_INGENICAIE)
#define HAVE_aie_iorib (TARGET_INGENICAIE)
#define HAVE_aie_xorib (TARGET_INGENICAIE)
#define HAVE_aie_lih (TARGET_INGENICAIE)
#define HAVE_aie_liw (TARGET_INGENICAIE)
#define HAVE_aie_liwh (TARGET_INGENICAIE)
#define HAVE_movvnx16bi (TARGET_INGENICAIE)
#define HAVE_movvnx8bi (TARGET_INGENICAIE)
#define HAVE_movvnx4bi (TARGET_INGENICAIE)
#define HAVE_vec_seriesvnx16qi (TARGET_INGENICAIE)
#define HAVE_vec_seriesvnx8qi (TARGET_INGENICAIE)
#define HAVE_vec_seriesvnx4qi (TARGET_INGENICAIE)
#define HAVE_vec_seriesvnx8hi (TARGET_INGENICAIE)
#define HAVE_vec_seriesvnx4hi (TARGET_INGENICAIE)
#define HAVE_vec_seriesvnx4si (TARGET_INGENICAIE)
#define HAVE_aie_pldvnx16bi (TARGET_INGENICAIE)
#define HAVE_aie_pldvnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_pldvnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_psdvnx16bi (TARGET_INGENICAIE)
#define HAVE_aie_psdvnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_psdvnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_pceqzvnx16qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcnezvnx16qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pclezvnx16qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltzvnx16qi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pceqzvnx8hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcnezvnx8hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pclezvnx8hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltzvnx8hi_mask (TARGET_INGENICAIE)
#define HAVE_aie_pceqzvnx4si_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcnezvnx4si_mask (TARGET_INGENICAIE)
#define HAVE_aie_pclezvnx4si_mask (TARGET_INGENICAIE)
#define HAVE_aie_pcltzvnx4si_mask (TARGET_INGENICAIE)
#define HAVE_aie_andib_mask (TARGET_INGENICAIE)
#define HAVE_aie_iorib_mask (TARGET_INGENICAIE)
#define HAVE_aie_xorib_mask (TARGET_INGENICAIE)
#define HAVE_aie_sumz_mask (TARGET_INGENICAIE)
#define HAVE_aie_mfsumz_mask (TARGET_INGENICAIE)
#define HAVE_aie_mxsum_mask (TARGET_INGENICAIE)
#define HAVE_aie_lavb_mask (TARGET_INGENICAIE)
#define HAVE_aie_lavh_mask (TARGET_INGENICAIE)
#define HAVE_aie_lavw_mask (TARGET_INGENICAIE)
#define HAVE_aie_savb_mask (TARGET_INGENICAIE)
#define HAVE_aie_savh_mask (TARGET_INGENICAIE)
#define HAVE_aie_savw_mask (TARGET_INGENICAIE)
#define HAVE_movmisalignvnx16qi (TARGET_INGENICAIE)
#define HAVE_movmisalignvnx8hi (TARGET_INGENICAIE)
#define HAVE_movmisalignvnx4si (TARGET_INGENICAIE)
#define HAVE_movmisalignvnx4sf (TARGET_INGENICAIE)
#define HAVE_movmisalignvnx8hf (TARGET_INGENICAIE)
#define HAVE_len_load_vnx16qi (TARGET_INGENICAIE)
#define HAVE_len_load_vnx8hi (TARGET_INGENICAIE)
#define HAVE_len_load_vnx4si (TARGET_INGENICAIE)
#define HAVE_len_load_vnx4sf (TARGET_INGENICAIE)
#define HAVE_len_load_vnx8hf (TARGET_INGENICAIE)
#define HAVE_len_store_vnx16qi (TARGET_INGENICAIE)
#define HAVE_len_store_vnx8hi (TARGET_INGENICAIE)
#define HAVE_len_store_vnx4si (TARGET_INGENICAIE)
#define HAVE_len_store_vnx4sf (TARGET_INGENICAIE)
#define HAVE_len_store_vnx8hf (TARGET_INGENICAIE)
#define HAVE_len_maskloadvnx16qivnx16bi (TARGET_INGENICAIE)
#define HAVE_len_maskloadvnx8hivnx8bi (TARGET_INGENICAIE)
#define HAVE_len_maskloadvnx4sivnx4bi (TARGET_INGENICAIE)
#define HAVE_len_maskloadvnx4sfvnx4bi (TARGET_INGENICAIE)
#define HAVE_len_maskloadvnx8hfvnx8bi (TARGET_INGENICAIE)
#define HAVE_len_maskstorevnx16qivnx16bi (TARGET_INGENICAIE)
#define HAVE_len_maskstorevnx8hivnx8bi (TARGET_INGENICAIE)
#define HAVE_len_maskstorevnx4sivnx4bi (TARGET_INGENICAIE)
#define HAVE_len_maskstorevnx4sfvnx4bi (TARGET_INGENICAIE)
#define HAVE_len_maskstorevnx8hfvnx8bi (TARGET_INGENICAIE)
#define HAVE_maskloadvnx16qivnx16bi (TARGET_INGENICAIE)
#define HAVE_maskloadvnx8hivnx8bi (TARGET_INGENICAIE)
#define HAVE_maskloadvnx4sivnx4bi (TARGET_INGENICAIE)
#define HAVE_maskloadvnx4sfvnx4bi (TARGET_INGENICAIE)
#define HAVE_maskloadvnx8hfvnx8bi (TARGET_INGENICAIE)
#define HAVE_maskstorevnx16qivnx16bi (TARGET_INGENICAIE)
#define HAVE_maskstorevnx8hivnx8bi (TARGET_INGENICAIE)
#define HAVE_maskstorevnx4sivnx4bi (TARGET_INGENICAIE)
#define HAVE_maskstorevnx4sfvnx4bi (TARGET_INGENICAIE)
#define HAVE_maskstorevnx8hfvnx8bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpvnx16qivnx16bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpvnx8qivnx8bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpvnx4qivnx4bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpvnx8hivnx8bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpvnx4hivnx4bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpvnx4sivnx4bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpvnx4sfvnx4bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpvnx8hfvnx8bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpvnx4hfvnx4bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpuvnx16qivnx16bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpuvnx8qivnx8bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpuvnx4qivnx4bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpuvnx8hivnx8bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpuvnx4hivnx4bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpuvnx4sivnx4bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpuvnx4sfvnx4bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpuvnx8hfvnx8bi (TARGET_INGENICAIE)
#define HAVE_vec_cmpuvnx4hfvnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_vec_cmpvnx16qivnx16bi (TARGET_INGENICAIE)
#define HAVE_aie_vec_cmpvnx8qivnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_vec_cmpvnx4qivnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_vec_cmpvnx8hivnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_vec_cmpvnx4hivnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_vec_cmpvnx4sivnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_vec_cmpvnx4sfvnx4bi (TARGET_INGENICAIE)
#define HAVE_aie_vec_cmpvnx8hfvnx8bi (TARGET_INGENICAIE)
#define HAVE_aie_vec_cmpvnx4hfvnx4bi (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx16qivnx16bi (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx8qivnx8bi (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx4qivnx4bi (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx8hivnx8bi (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx4hivnx4bi (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx4sivnx4bi (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx4sfvnx4bi (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx8hfvnx8bi (TARGET_INGENICAIE)
#define HAVE_vcond_mask_vnx4hfvnx4bi (TARGET_INGENICAIE)
#define HAVE_addvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_subvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_mulvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_sminvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_uminvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_smaxvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_umaxvnx16qi3 (TARGET_INGENICAIE)
#define HAVE_addvnx8qi3 (TARGET_INGENICAIE)
#define HAVE_subvnx8qi3 (TARGET_INGENICAIE)
#define HAVE_mulvnx8qi3 (TARGET_INGENICAIE)
#define HAVE_sminvnx8qi3 (TARGET_INGENICAIE)
#define HAVE_uminvnx8qi3 (TARGET_INGENICAIE)
#define HAVE_smaxvnx8qi3 (TARGET_INGENICAIE)
#define HAVE_umaxvnx8qi3 (TARGET_INGENICAIE)
#define HAVE_addvnx4qi3 (TARGET_INGENICAIE)
#define HAVE_subvnx4qi3 (TARGET_INGENICAIE)
#define HAVE_mulvnx4qi3 (TARGET_INGENICAIE)
#define HAVE_sminvnx4qi3 (TARGET_INGENICAIE)
#define HAVE_uminvnx4qi3 (TARGET_INGENICAIE)
#define HAVE_smaxvnx4qi3 (TARGET_INGENICAIE)
#define HAVE_umaxvnx4qi3 (TARGET_INGENICAIE)
#define HAVE_addvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_subvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_mulvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_sminvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_uminvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_smaxvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_umaxvnx8hi3 (TARGET_INGENICAIE)
#define HAVE_addvnx4hi3 (TARGET_INGENICAIE)
#define HAVE_subvnx4hi3 (TARGET_INGENICAIE)
#define HAVE_mulvnx4hi3 (TARGET_INGENICAIE)
#define HAVE_sminvnx4hi3 (TARGET_INGENICAIE)
#define HAVE_uminvnx4hi3 (TARGET_INGENICAIE)
#define HAVE_smaxvnx4hi3 (TARGET_INGENICAIE)
#define HAVE_umaxvnx4hi3 (TARGET_INGENICAIE)
#define HAVE_addvnx4si3 (TARGET_INGENICAIE)
#define HAVE_subvnx4si3 (TARGET_INGENICAIE)
#define HAVE_mulvnx4si3 (TARGET_INGENICAIE)
#define HAVE_sminvnx4si3 (TARGET_INGENICAIE)
#define HAVE_uminvnx4si3 (TARGET_INGENICAIE)
#define HAVE_smaxvnx4si3 (TARGET_INGENICAIE)
#define HAVE_umaxvnx4si3 (TARGET_INGENICAIE)
#define HAVE_cond_addvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_subvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_mulvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_sminvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_uminvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_smaxvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_umaxvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_addvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_subvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_mulvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_sminvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_uminvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_smaxvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_umaxvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_addvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_subvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_mulvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_sminvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_uminvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_smaxvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_umaxvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_addvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_subvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_mulvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_sminvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_uminvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_smaxvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_umaxvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_addvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_subvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_mulvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_sminvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_uminvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_smaxvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_umaxvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_addvnx4si (TARGET_INGENICAIE)
#define HAVE_cond_subvnx4si (TARGET_INGENICAIE)
#define HAVE_cond_mulvnx4si (TARGET_INGENICAIE)
#define HAVE_cond_sminvnx4si (TARGET_INGENICAIE)
#define HAVE_cond_uminvnx4si (TARGET_INGENICAIE)
#define HAVE_cond_smaxvnx4si (TARGET_INGENICAIE)
#define HAVE_cond_umaxvnx4si (TARGET_INGENICAIE)
#define HAVE_len_addvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_subvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_mulvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_sminvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_uminvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_smaxvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_umaxvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_addvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_subvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_mulvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_sminvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_uminvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_smaxvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_umaxvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_addvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_subvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_mulvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_sminvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_uminvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_smaxvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_umaxvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_addvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_subvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_mulvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_sminvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_uminvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_smaxvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_umaxvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_addvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_subvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_mulvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_sminvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_uminvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_smaxvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_umaxvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_addvnx4si (TARGET_INGENICAIE)
#define HAVE_len_subvnx4si (TARGET_INGENICAIE)
#define HAVE_len_mulvnx4si (TARGET_INGENICAIE)
#define HAVE_len_sminvnx4si (TARGET_INGENICAIE)
#define HAVE_len_uminvnx4si (TARGET_INGENICAIE)
#define HAVE_len_smaxvnx4si (TARGET_INGENICAIE)
#define HAVE_len_umaxvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_addvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_subvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_mulvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_sminvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_uminvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_smaxvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_umaxvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_addvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_subvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_mulvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_sminvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_uminvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_smaxvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_umaxvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_addvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_subvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_mulvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_sminvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_uminvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_smaxvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_umaxvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_addvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_subvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_mulvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_sminvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_uminvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_smaxvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_umaxvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_addvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_subvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_mulvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_sminvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_uminvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_smaxvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_umaxvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_addvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_subvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_mulvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_sminvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_uminvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_smaxvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_umaxvnx4si (TARGET_INGENICAIE)
#define HAVE_absvnx16qi2 (TARGET_INGENICAIE)
#define HAVE_absvnx8qi2 (TARGET_INGENICAIE)
#define HAVE_absvnx4qi2 (TARGET_INGENICAIE)
#define HAVE_absvnx8hi2 (TARGET_INGENICAIE)
#define HAVE_absvnx4hi2 (TARGET_INGENICAIE)
#define HAVE_absvnx4si2 (TARGET_INGENICAIE)
#define HAVE_cond_andvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_iorvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_xorvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_andvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_iorvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_xorvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_andvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_iorvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_xorvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_andvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_iorvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_xorvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_andvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_iorvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_xorvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_andvnx4si (TARGET_INGENICAIE)
#define HAVE_cond_iorvnx4si (TARGET_INGENICAIE)
#define HAVE_cond_xorvnx4si (TARGET_INGENICAIE)
#define HAVE_len_andvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_iorvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_xorvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_andvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_iorvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_xorvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_andvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_iorvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_xorvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_andvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_iorvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_xorvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_andvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_iorvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_xorvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_andvnx4si (TARGET_INGENICAIE)
#define HAVE_len_iorvnx4si (TARGET_INGENICAIE)
#define HAVE_len_xorvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_andvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_iorvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_xorvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_andvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_iorvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_xorvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_andvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_iorvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_xorvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_andvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_iorvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_xorvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_andvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_iorvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_xorvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_andvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_iorvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_xorvnx4si (TARGET_INGENICAIE)
#define HAVE_cond_negvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_negvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_negvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_negvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_negvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_negvnx4si (TARGET_INGENICAIE)
#define HAVE_len_negvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_negvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_negvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_negvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_negvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_negvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_negvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_negvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_negvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_negvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_negvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_negvnx4si (TARGET_INGENICAIE)
#define HAVE_cond_ashlvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_ashrvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_lshrvnx16qi (TARGET_INGENICAIE)
#define HAVE_cond_ashlvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_ashrvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_lshrvnx8qi (TARGET_INGENICAIE)
#define HAVE_cond_ashlvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_ashrvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_lshrvnx4qi (TARGET_INGENICAIE)
#define HAVE_cond_ashlvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_ashrvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_lshrvnx8hi (TARGET_INGENICAIE)
#define HAVE_cond_ashlvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_ashrvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_lshrvnx4hi (TARGET_INGENICAIE)
#define HAVE_cond_ashlvnx4si (TARGET_INGENICAIE)
#define HAVE_cond_ashrvnx4si (TARGET_INGENICAIE)
#define HAVE_cond_lshrvnx4si (TARGET_INGENICAIE)
#define HAVE_len_ashlvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_ashrvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_lshrvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_ashlvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_ashrvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_lshrvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_ashlvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_ashrvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_lshrvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_ashlvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_ashrvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_lshrvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_ashlvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_ashrvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_lshrvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_ashlvnx4si (TARGET_INGENICAIE)
#define HAVE_len_ashrvnx4si (TARGET_INGENICAIE)
#define HAVE_len_lshrvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_ashlvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_ashrvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_lshrvnx16qi (TARGET_INGENICAIE)
#define HAVE_len_tail_ashlvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_ashrvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_lshrvnx8qi (TARGET_INGENICAIE)
#define HAVE_len_tail_ashlvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_ashrvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_lshrvnx4qi (TARGET_INGENICAIE)
#define HAVE_len_tail_ashlvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_ashrvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_lshrvnx8hi (TARGET_INGENICAIE)
#define HAVE_len_tail_ashlvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_ashrvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_lshrvnx4hi (TARGET_INGENICAIE)
#define HAVE_len_tail_ashlvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_ashrvnx4si (TARGET_INGENICAIE)
#define HAVE_len_tail_lshrvnx4si (TARGET_INGENICAIE)
#define HAVE_addvnx4sf3 (TARGET_INGENICAIE)
#define HAVE_subvnx4sf3 (TARGET_INGENICAIE)
#define HAVE_mulvnx4sf3 (TARGET_INGENICAIE)
#define HAVE_sminvnx4sf3 (TARGET_INGENICAIE)
#define HAVE_smaxvnx4sf3 (TARGET_INGENICAIE)
#define HAVE_addvnx8hf3 (TARGET_INGENICAIE)
#define HAVE_subvnx8hf3 (TARGET_INGENICAIE)
#define HAVE_mulvnx8hf3 (TARGET_INGENICAIE)
#define HAVE_sminvnx8hf3 (TARGET_INGENICAIE)
#define HAVE_smaxvnx8hf3 (TARGET_INGENICAIE)
#define HAVE_cond_addvnx4sf (TARGET_INGENICAIE)
#define HAVE_cond_subvnx4sf (TARGET_INGENICAIE)
#define HAVE_cond_mulvnx4sf (TARGET_INGENICAIE)
#define HAVE_cond_sminvnx4sf (TARGET_INGENICAIE)
#define HAVE_cond_smaxvnx4sf (TARGET_INGENICAIE)
#define HAVE_cond_addvnx8hf (TARGET_INGENICAIE)
#define HAVE_cond_subvnx8hf (TARGET_INGENICAIE)
#define HAVE_cond_mulvnx8hf (TARGET_INGENICAIE)
#define HAVE_cond_sminvnx8hf (TARGET_INGENICAIE)
#define HAVE_cond_smaxvnx8hf (TARGET_INGENICAIE)
#define HAVE_len_addvnx4sf (TARGET_INGENICAIE)
#define HAVE_len_subvnx4sf (TARGET_INGENICAIE)
#define HAVE_len_mulvnx4sf (TARGET_INGENICAIE)
#define HAVE_len_sminvnx4sf (TARGET_INGENICAIE)
#define HAVE_len_smaxvnx4sf (TARGET_INGENICAIE)
#define HAVE_len_addvnx8hf (TARGET_INGENICAIE)
#define HAVE_len_subvnx8hf (TARGET_INGENICAIE)
#define HAVE_len_mulvnx8hf (TARGET_INGENICAIE)
#define HAVE_len_sminvnx8hf (TARGET_INGENICAIE)
#define HAVE_len_smaxvnx8hf (TARGET_INGENICAIE)
#define HAVE_len_tail_addvnx4sf (TARGET_INGENICAIE)
#define HAVE_len_tail_subvnx4sf (TARGET_INGENICAIE)
#define HAVE_len_tail_mulvnx4sf (TARGET_INGENICAIE)
#define HAVE_len_tail_sminvnx4sf (TARGET_INGENICAIE)
#define HAVE_len_tail_smaxvnx4sf (TARGET_INGENICAIE)
#define HAVE_len_tail_addvnx8hf (TARGET_INGENICAIE)
#define HAVE_len_tail_subvnx8hf (TARGET_INGENICAIE)
#define HAVE_len_tail_mulvnx8hf (TARGET_INGENICAIE)
#define HAVE_len_tail_sminvnx8hf (TARGET_INGENICAIE)
#define HAVE_len_tail_smaxvnx8hf (TARGET_INGENICAIE)
#define HAVE_fmavnx4sf4 (TARGET_INGENICAIE)
#define HAVE_fmsvnx4sf4 (TARGET_INGENICAIE)
#define HAVE_fnmavnx4sf4 (TARGET_INGENICAIE)
#define HAVE_fnmsvnx4sf4 (TARGET_INGENICAIE)
#define HAVE_len_fmavnx4sf (TARGET_INGENICAIE)
#define HAVE_len_fmsvnx4sf (TARGET_INGENICAIE)
#define HAVE_len_fnmavnx4sf (TARGET_INGENICAIE)
#define HAVE_len_fnmsvnx4sf (TARGET_INGENICAIE)
#define HAVE_vec_widen_umult_even_vnx16qi (TARGET_INGENICAIE)
#define HAVE_vec_widen_umult_even_vnx8hi (TARGET_INGENICAIE)
#define HAVE_vec_widen_smult_even_vnx16qi (TARGET_INGENICAIE)
#define HAVE_vec_widen_smult_even_vnx8hi (TARGET_INGENICAIE)
#define HAVE_vec_widen_umult_odd_vnx16qi (TARGET_INGENICAIE)
#define HAVE_vec_widen_umult_odd_vnx8hi (TARGET_INGENICAIE)
#define HAVE_vec_widen_smult_odd_vnx16qi (TARGET_INGENICAIE)
#define HAVE_vec_widen_smult_odd_vnx8hi (TARGET_INGENICAIE)
#define HAVE_fix_truncsfoi2 ((TARGET_INGENICAIE && TARGET_AIE512 && TARGET_HARD_FLOAT) && (TARGET_HARD_FLOAT))
#define HAVE_fixuns_truncsfoi2 ((TARGET_INGENICAIE && TARGET_AIE512 && TARGET_HARD_FLOAT) && (TARGET_HARD_FLOAT))
#define HAVE_fix_truncdfoi2 ((TARGET_INGENICAIE && TARGET_AIE512 && TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_fixuns_truncdfoi2 ((TARGET_INGENICAIE && TARGET_AIE512 && TARGET_HARD_FLOAT) && (TARGET_DOUBLE_FLOAT))
#define HAVE_fix_trunchfoi2 ((TARGET_INGENICAIE && TARGET_AIE512 && TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_fixuns_trunchfoi2 ((TARGET_INGENICAIE && TARGET_AIE512 && TARGET_HARD_FLOAT) && (TARGET_ZFH))
#define HAVE_aie_gt2w_mask (TARGET_INGENICAIE)
#define HAVE_aie_gt4w_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_gt8w_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_gt2d_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_gt4d_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_gt2q_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_law_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_lad_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_laq_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_lao_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_saw_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sad_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_saq_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sao_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sad2w_mask (TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_sad4w_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && ((TARGET_AIE256 || TARGET_AIE512)))
#define HAVE_aie_sad8w_mask ((TARGET_INGENICAIE && (TARGET_AIE128 || TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_saq2w_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_saq2d_mask (TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512))
#define HAVE_aie_saq4w_mask ((TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_saq4d_mask ((TARGET_INGENICAIE && (TARGET_AIE256 || TARGET_AIE512)) && (TARGET_AIE512))
#define HAVE_aie_sao2w_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_sao2d_mask (TARGET_INGENICAIE && TARGET_AIE512)
#define HAVE_aie_sao2q_mask (TARGET_INGENICAIE && TARGET_AIE512)
extern rtx        gen_addsf3                         (rtx, rtx, rtx);
extern rtx        gen_adddf3                         (rtx, rtx, rtx);
extern rtx        gen_addhf3                         (rtx, rtx, rtx);
extern rtx        gen_aie_addr_update_vls_internal   (rtx, rtx, rtx);
extern rtx        gen_aie_addr_update_vla            (rtx, rtx);
extern rtx        gen_aie_addr_update_offset         (rtx, rtx, rtx);
extern rtx        gen_addsi3                         (rtx, rtx, rtx);
extern rtx        gen_adddi3                         (rtx, rtx, rtx);
extern rtx        gen_subsf3                         (rtx, rtx, rtx);
extern rtx        gen_subdf3                         (rtx, rtx, rtx);
extern rtx        gen_subhf3                         (rtx, rtx, rtx);
extern rtx        gen_subdi3                         (rtx, rtx, rtx);
extern rtx        gen_subsi3                         (rtx, rtx, rtx);
extern rtx        gen_negdi2                         (rtx, rtx);
extern rtx        gen_negsi2                         (rtx, rtx);
extern rtx        gen_mulsf3                         (rtx, rtx, rtx);
extern rtx        gen_muldf3                         (rtx, rtx, rtx);
extern rtx        gen_mulhf3                         (rtx, rtx, rtx);
extern rtx        gen_mulsi3                         (rtx, rtx, rtx);
extern rtx        gen_muldi3                         (rtx, rtx, rtx);
extern rtx        gen_smuldi3_highpart               (rtx, rtx, rtx);
extern rtx        gen_umuldi3_highpart               (rtx, rtx, rtx);
extern rtx        gen_usmuldi3_highpart              (rtx, rtx, rtx);
extern rtx        gen_smulsi3_highpart               (rtx, rtx, rtx);
extern rtx        gen_umulsi3_highpart               (rtx, rtx, rtx);
extern rtx        gen_usmulsi3_highpart              (rtx, rtx, rtx);
extern rtx        gen_divsi3                         (rtx, rtx, rtx);
extern rtx        gen_udivsi3                        (rtx, rtx, rtx);
extern rtx        gen_modsi3                         (rtx, rtx, rtx);
extern rtx        gen_umodsi3                        (rtx, rtx, rtx);
extern rtx        gen_divdi3                         (rtx, rtx, rtx);
extern rtx        gen_udivdi3                        (rtx, rtx, rtx);
extern rtx        gen_moddi3                         (rtx, rtx, rtx);
extern rtx        gen_umoddi3                        (rtx, rtx, rtx);
extern rtx        gen_divsf3                         (rtx, rtx, rtx);
extern rtx        gen_divdf3                         (rtx, rtx, rtx);
extern rtx        gen_divhf3                         (rtx, rtx, rtx);
extern rtx        gen_sqrtsf2                        (rtx, rtx);
extern rtx        gen_sqrtdf2                        (rtx, rtx);
extern rtx        gen_sqrthf2                        (rtx, rtx);
extern rtx        gen_fmasf4                         (rtx, rtx, rtx, rtx);
extern rtx        gen_fmadf4                         (rtx, rtx, rtx, rtx);
extern rtx        gen_fmahf4                         (rtx, rtx, rtx, rtx);
extern rtx        gen_fmssf4                         (rtx, rtx, rtx, rtx);
extern rtx        gen_fmsdf4                         (rtx, rtx, rtx, rtx);
extern rtx        gen_fmshf4                         (rtx, rtx, rtx, rtx);
extern rtx        gen_fnmssf4                        (rtx, rtx, rtx, rtx);
extern rtx        gen_fnmsdf4                        (rtx, rtx, rtx, rtx);
extern rtx        gen_fnmshf4                        (rtx, rtx, rtx, rtx);
extern rtx        gen_fnmasf4                        (rtx, rtx, rtx, rtx);
extern rtx        gen_fnmadf4                        (rtx, rtx, rtx, rtx);
extern rtx        gen_fnmahf4                        (rtx, rtx, rtx, rtx);
extern rtx        gen_abssf2                         (rtx, rtx);
extern rtx        gen_absdf2                         (rtx, rtx);
extern rtx        gen_abshf2                         (rtx, rtx);
extern rtx        gen_copysignsf3                    (rtx, rtx, rtx);
extern rtx        gen_copysigndf3                    (rtx, rtx, rtx);
extern rtx        gen_copysignhf3                    (rtx, rtx, rtx);
extern rtx        gen_negsf2                         (rtx, rtx);
extern rtx        gen_negdf2                         (rtx, rtx);
extern rtx        gen_neghf2                         (rtx, rtx);
extern rtx        gen_sminsf3                        (rtx, rtx, rtx);
extern rtx        gen_smindf3                        (rtx, rtx, rtx);
extern rtx        gen_sminhf3                        (rtx, rtx, rtx);
extern rtx        gen_smaxsf3                        (rtx, rtx, rtx);
extern rtx        gen_smaxdf3                        (rtx, rtx, rtx);
extern rtx        gen_smaxhf3                        (rtx, rtx, rtx);
extern rtx        gen_andsi3                         (rtx, rtx, rtx);
extern rtx        gen_iorsi3                         (rtx, rtx, rtx);
extern rtx        gen_xorsi3                         (rtx, rtx, rtx);
extern rtx        gen_anddi3                         (rtx, rtx, rtx);
extern rtx        gen_iordi3                         (rtx, rtx, rtx);
extern rtx        gen_xordi3                         (rtx, rtx, rtx);
extern rtx        gen_one_cmplsi2                    (rtx, rtx);
extern rtx        gen_one_cmpldi2                    (rtx, rtx);
extern rtx        gen_truncdfsf2                     (rtx, rtx);
extern rtx        gen_truncsfhf2                     (rtx, rtx);
extern rtx        gen_truncdfhf2                     (rtx, rtx);
extern rtx        gen_zero_extendqihi2               (rtx, rtx);
extern rtx        gen_zero_extendqisi2               (rtx, rtx);
extern rtx        gen_zero_extendqidi2               (rtx, rtx);
extern rtx        gen_extendsidi2                    (rtx, rtx);
extern rtx        gen_extendhfsf2                    (rtx, rtx);
extern rtx        gen_extendsfdf2                    (rtx, rtx);
extern rtx        gen_extendhfdf2                    (rtx, rtx);
extern rtx        gen_fix_truncsfsi2                 (rtx, rtx);
extern rtx        gen_fix_truncdfsi2                 (rtx, rtx);
extern rtx        gen_fix_trunchfsi2                 (rtx, rtx);
extern rtx        gen_fix_truncsfdi2                 (rtx, rtx);
extern rtx        gen_fix_truncdfdi2                 (rtx, rtx);
extern rtx        gen_fix_trunchfdi2                 (rtx, rtx);
extern rtx        gen_fixuns_truncsfsi2              (rtx, rtx);
extern rtx        gen_fixuns_truncdfsi2              (rtx, rtx);
extern rtx        gen_fixuns_trunchfsi2              (rtx, rtx);
extern rtx        gen_fixuns_truncsfdi2              (rtx, rtx);
extern rtx        gen_fixuns_truncdfdi2              (rtx, rtx);
extern rtx        gen_fixuns_trunchfdi2              (rtx, rtx);
extern rtx        gen_floatsisf2                     (rtx, rtx);
extern rtx        gen_floatsidf2                     (rtx, rtx);
extern rtx        gen_floatsihf2                     (rtx, rtx);
extern rtx        gen_floatdisf2                     (rtx, rtx);
extern rtx        gen_floatdidf2                     (rtx, rtx);
extern rtx        gen_floatdihf2                     (rtx, rtx);
extern rtx        gen_floatunssisf2                  (rtx, rtx);
extern rtx        gen_floatunssidf2                  (rtx, rtx);
extern rtx        gen_floatunssihf2                  (rtx, rtx);
extern rtx        gen_floatunsdisf2                  (rtx, rtx);
extern rtx        gen_floatunsdidf2                  (rtx, rtx);
extern rtx        gen_floatunsdihf2                  (rtx, rtx);
extern rtx        gen_lrintsfsi2                     (rtx, rtx);
extern rtx        gen_lroundsfsi2                    (rtx, rtx);
extern rtx        gen_lrintdfsi2                     (rtx, rtx);
extern rtx        gen_lrounddfsi2                    (rtx, rtx);
extern rtx        gen_lrinthfsi2                     (rtx, rtx);
extern rtx        gen_lroundhfsi2                    (rtx, rtx);
extern rtx        gen_lrintsfdi2                     (rtx, rtx);
extern rtx        gen_lroundsfdi2                    (rtx, rtx);
extern rtx        gen_lrintdfdi2                     (rtx, rtx);
extern rtx        gen_lrounddfdi2                    (rtx, rtx);
extern rtx        gen_lrinthfdi2                     (rtx, rtx);
extern rtx        gen_lroundhfdi2                    (rtx, rtx);
extern rtx        gen_got_loadsi                     (rtx, rtx);
extern rtx        gen_got_loaddi                     (rtx, rtx);
extern rtx        gen_tls_add_tp_lesi                (rtx, rtx, rtx, rtx);
extern rtx        gen_tls_add_tp_ledi                (rtx, rtx, rtx, rtx);
extern rtx        gen_got_load_tls_gdsi              (rtx, rtx);
extern rtx        gen_got_load_tls_gddi              (rtx, rtx);
extern rtx        gen_got_load_tls_iesi              (rtx, rtx);
extern rtx        gen_got_load_tls_iedi              (rtx, rtx);
extern rtx        gen_auipcsi                        (rtx, rtx, rtx);
extern rtx        gen_auipcdi                        (rtx, rtx, rtx);
extern rtx        gen_fence                          (void);
extern rtx        gen_fence_i                        (void);
extern rtx        gen_ashlsi3                        (rtx, rtx, rtx);
extern rtx        gen_ashrsi3                        (rtx, rtx, rtx);
extern rtx        gen_lshrsi3                        (rtx, rtx, rtx);
extern rtx        gen_ashldi3                        (rtx, rtx, rtx);
extern rtx        gen_ashrdi3                        (rtx, rtx, rtx);
extern rtx        gen_lshrdi3                        (rtx, rtx, rtx);
extern rtx        gen_zero_extendsidi2_shifted       (rtx, rtx, rtx, rtx);
extern rtx        gen_jump                           (rtx);
extern rtx        gen_indirect_jumpsi                (rtx);
extern rtx        gen_indirect_jumpdi                (rtx);
extern rtx        gen_tablejumpsi                    (rtx, rtx);
extern rtx        gen_tablejumpdi                    (rtx, rtx);
extern rtx        gen_blockage                       (void);
extern rtx        gen_simple_return                  (void);
extern rtx        gen_simple_return_internal         (rtx);
extern rtx        gen_eh_set_lr_si                   (rtx);
extern rtx        gen_eh_set_lr_di                   (rtx);
extern rtx        gen_eh_return_internal             (void);
extern rtx        gen_sibcall_internal               (rtx, rtx);
extern rtx        gen_sibcall_value_internal         (rtx, rtx, rtx);
extern rtx        gen_call_internal                  (rtx, rtx);
extern rtx        gen_call_value_internal            (rtx, rtx, rtx);
extern rtx        gen_nop                            (void);
extern rtx        gen_trap                           (void);
extern rtx        gen_gpr_save                       (rtx, rtx);
extern rtx        gen_gpr_restore                    (rtx);
extern rtx        gen_gpr_restore_return             (rtx);
extern rtx        gen_riscv_frflags                  (rtx);
extern rtx        gen_riscv_fsflags                  (rtx);
extern rtx        gen_riscv_mret                     (void);
extern rtx        gen_riscv_sret                     (void);
extern rtx        gen_riscv_uret                     (void);
extern rtx        gen_stack_tiesi                    (rtx, rtx);
extern rtx        gen_stack_tiedi                    (rtx, rtx);
extern rtx        gen_stack_protect_set_si           (rtx, rtx);
extern rtx        gen_stack_protect_set_di           (rtx, rtx);
extern rtx        gen_stack_protect_test_si          (rtx, rtx, rtx);
extern rtx        gen_stack_protect_test_di          (rtx, rtx, rtx);
extern rtx        gen_clzsi2                         (rtx, rtx);
extern rtx        gen_ctzsi2                         (rtx, rtx);
extern rtx        gen_popcountsi2                    (rtx, rtx);
extern rtx        gen_clzdi2                         (rtx, rtx);
extern rtx        gen_ctzdi2                         (rtx, rtx);
extern rtx        gen_popcountdi2                    (rtx, rtx);
extern rtx        gen_rotrsi3                        (rtx, rtx, rtx);
extern rtx        gen_rotrdi3                        (rtx, rtx, rtx);
extern rtx        gen_rotrsi3_sext                   (rtx, rtx, rtx);
extern rtx        gen_rotlsi3                        (rtx, rtx, rtx);
extern rtx        gen_rotldi3                        (rtx, rtx, rtx);
extern rtx        gen_rotlsi3_sext                   (rtx, rtx, rtx);
extern rtx        gen_bswapsi2                       (rtx, rtx);
extern rtx        gen_bswapdi2                       (rtx, rtx);
extern rtx        gen_sminsi3                        (rtx, rtx, rtx);
extern rtx        gen_uminsi3                        (rtx, rtx, rtx);
extern rtx        gen_smaxsi3                        (rtx, rtx, rtx);
extern rtx        gen_umaxsi3                        (rtx, rtx, rtx);
extern rtx        gen_smindi3                        (rtx, rtx, rtx);
extern rtx        gen_umindi3                        (rtx, rtx, rtx);
extern rtx        gen_smaxdi3                        (rtx, rtx, rtx);
extern rtx        gen_umaxdi3                        (rtx, rtx, rtx);
extern rtx        gen_mem_thread_fence_1             (rtx, rtx);
extern rtx        gen_atomic_storesi                 (rtx, rtx, rtx);
extern rtx        gen_atomic_storedi                 (rtx, rtx, rtx);
extern rtx        gen_atomic_addsi                   (rtx, rtx, rtx);
extern rtx        gen_atomic_orsi                    (rtx, rtx, rtx);
extern rtx        gen_atomic_xorsi                   (rtx, rtx, rtx);
extern rtx        gen_atomic_andsi                   (rtx, rtx, rtx);
extern rtx        gen_atomic_adddi                   (rtx, rtx, rtx);
extern rtx        gen_atomic_ordi                    (rtx, rtx, rtx);
extern rtx        gen_atomic_xordi                   (rtx, rtx, rtx);
extern rtx        gen_atomic_anddi                   (rtx, rtx, rtx);
extern rtx        gen_atomic_fetch_addsi             (rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_fetch_orsi              (rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_fetch_xorsi             (rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_fetch_andsi             (rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_fetch_adddi             (rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_fetch_ordi              (rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_fetch_xordi             (rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_fetch_anddi             (rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_exchangesi              (rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_exchangedi              (rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_cas_value_strongsi      (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_cas_value_strongdi      (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vec_duplicatevnx16qi           (rtx, rtx);
extern rtx        gen_vec_duplicatevnx8qi            (rtx, rtx);
extern rtx        gen_vec_duplicatevnx4qi            (rtx, rtx);
extern rtx        gen_vec_duplicatevnx8hi            (rtx, rtx);
extern rtx        gen_vec_duplicatevnx4hi            (rtx, rtx);
extern rtx        gen_vec_duplicatevnx4si            (rtx, rtx);
extern rtx        gen_vec_duplicatevnx4sf            (rtx, rtx);
extern rtx        gen_vec_duplicatevnx8hf            (rtx, rtx);
extern rtx        gen_vec_duplicatevnx4hf            (rtx, rtx);
extern rtx        gen_vec_duplicatevnx2di            (rtx, rtx);
extern rtx        gen_vec_duplicatevnx2ti            (rtx, rtx);
extern rtx        gen_vec_duplicateaie_v2oi          (rtx, rtx);
extern rtx        gen_aie_vec_duplicatevnx2di        (rtx, rtx);
extern rtx        gen_aie_vec_duplicatevnx2ti        (rtx, rtx);
extern rtx        gen_aie_vec_duplicateaie_v2oi      (rtx, rtx);
extern rtx        gen_livnx4sf                       (rtx, rtx);
extern rtx        gen_livnx8hf                       (rtx, rtx);
extern rtx        gen_livnx16qi                      (rtx, rtx);
extern rtx        gen_livnx8hi                       (rtx, rtx);
extern rtx        gen_livnx4si                       (rtx, rtx);
extern rtx        gen_livnx8qi                       (rtx, rtx);
extern rtx        gen_livnx4qi                       (rtx, rtx);
extern rtx        gen_livnx4hi                       (rtx, rtx);
extern rtx        gen_livnx4hf                       (rtx, rtx);
extern rtx        gen_livnx2di                       (rtx, rtx);
extern rtx        gen_livnx2ti                       (rtx, rtx);
extern rtx        gen_liaie_v2oi                     (rtx, rtx);
extern rtx        gen_truncsivw2                     (rtx, rtx);
extern rtx        gen_truncvwsi2                     (rtx, rtx);
extern rtx        gen_extendvwsi2                    (rtx, rtx);
extern rtx        gen_extendsivw2                    (rtx, rtx);
extern rtx        gen_zero_extendvwsi2               (rtx, rtx);
extern rtx        gen_aie_vwr_move                   (rtx, rtx);
extern rtx        gen_addvw3                         (rtx, rtx, rtx);
extern rtx        gen_aie_ceqb                       (rtx, rtx, rtx);
extern rtx        gen_aie_clesb                      (rtx, rtx, rtx);
extern rtx        gen_aie_cleub                      (rtx, rtx, rtx);
extern rtx        gen_aie_cltsb                      (rtx, rtx, rtx);
extern rtx        gen_aie_cltub                      (rtx, rtx, rtx);
extern rtx        gen_aie_ceqh                       (rtx, rtx, rtx);
extern rtx        gen_aie_clesh                      (rtx, rtx, rtx);
extern rtx        gen_aie_cleuh                      (rtx, rtx, rtx);
extern rtx        gen_aie_cltsh                      (rtx, rtx, rtx);
extern rtx        gen_aie_cltuh                      (rtx, rtx, rtx);
extern rtx        gen_aie_ceqw                       (rtx, rtx, rtx);
extern rtx        gen_aie_clesw                      (rtx, rtx, rtx);
extern rtx        gen_aie_cleuw                      (rtx, rtx, rtx);
extern rtx        gen_aie_cltsw                      (rtx, rtx, rtx);
extern rtx        gen_aie_cltuw                      (rtx, rtx, rtx);
extern rtx        gen_aie_ceqzb                      (rtx, rtx, rtx);
extern rtx        gen_aie_clezb                      (rtx, rtx, rtx);
extern rtx        gen_aie_cltzb                      (rtx, rtx, rtx);
extern rtx        gen_aie_ceqzh                      (rtx, rtx, rtx);
extern rtx        gen_aie_clezh                      (rtx, rtx, rtx);
extern rtx        gen_aie_cltzh                      (rtx, rtx, rtx);
extern rtx        gen_aie_ceqzw                      (rtx, rtx, rtx);
extern rtx        gen_aie_clezw                      (rtx, rtx, rtx);
extern rtx        gen_aie_cltzw                      (rtx, rtx, rtx);
extern rtx        gen_aie_fcorw                      (rtx, rtx, rtx);
extern rtx        gen_aie_fceqw                      (rtx, rtx, rtx);
extern rtx        gen_aie_fclew                      (rtx, rtx, rtx);
extern rtx        gen_aie_fcltw                      (rtx, rtx, rtx);
extern rtx        gen_floatvnx4sivnx4sf2             (rtx, rtx);
extern rtx        gen_floatvnx8hivnx8hf2             (rtx, rtx);
extern rtx        gen_floatunsvnx4sivnx4sf2          (rtx, rtx);
extern rtx        gen_floatunsvnx8hivnx8hf2          (rtx, rtx);
extern rtx        gen_fix_truncvnx4sfvnx4si2         (rtx, rtx);
extern rtx        gen_fix_truncvnx8hfvnx8hi2         (rtx, rtx);
extern rtx        gen_fixuns_truncvnx4sfvnx4si2      (rtx, rtx);
extern rtx        gen_fixuns_truncvnx8hfvnx8hi2      (rtx, rtx);
extern rtx        gen_andvnx16qi3                    (rtx, rtx, rtx);
extern rtx        gen_iorvnx16qi3                    (rtx, rtx, rtx);
extern rtx        gen_xorvnx16qi3                    (rtx, rtx, rtx);
extern rtx        gen_andvnx8hi3                     (rtx, rtx, rtx);
extern rtx        gen_iorvnx8hi3                     (rtx, rtx, rtx);
extern rtx        gen_xorvnx8hi3                     (rtx, rtx, rtx);
extern rtx        gen_andvnx4si3                     (rtx, rtx, rtx);
extern rtx        gen_iorvnx4si3                     (rtx, rtx, rtx);
extern rtx        gen_xorvnx4si3                     (rtx, rtx, rtx);
extern rtx        gen_andvnx2di3                     (rtx, rtx, rtx);
extern rtx        gen_iorvnx2di3                     (rtx, rtx, rtx);
extern rtx        gen_xorvnx2di3                     (rtx, rtx, rtx);
extern rtx        gen_andvnx2ti3                     (rtx, rtx, rtx);
extern rtx        gen_iorvnx2ti3                     (rtx, rtx, rtx);
extern rtx        gen_xorvnx2ti3                     (rtx, rtx, rtx);
extern rtx        gen_andaie_v2oi3                   (rtx, rtx, rtx);
extern rtx        gen_ioraie_v2oi3                   (rtx, rtx, rtx);
extern rtx        gen_xoraie_v2oi3                   (rtx, rtx, rtx);
extern rtx        gen_andnotvnx16qi3                 (rtx, rtx, rtx);
extern rtx        gen_iornotvnx16qi3                 (rtx, rtx, rtx);
extern rtx        gen_xornotvnx16qi3                 (rtx, rtx, rtx);
extern rtx        gen_andnotvnx8hi3                  (rtx, rtx, rtx);
extern rtx        gen_iornotvnx8hi3                  (rtx, rtx, rtx);
extern rtx        gen_xornotvnx8hi3                  (rtx, rtx, rtx);
extern rtx        gen_andnotvnx4si3                  (rtx, rtx, rtx);
extern rtx        gen_iornotvnx4si3                  (rtx, rtx, rtx);
extern rtx        gen_xornotvnx4si3                  (rtx, rtx, rtx);
extern rtx        gen_andnotvnx2di3                  (rtx, rtx, rtx);
extern rtx        gen_iornotvnx2di3                  (rtx, rtx, rtx);
extern rtx        gen_xornotvnx2di3                  (rtx, rtx, rtx);
extern rtx        gen_andnotvnx2ti3                  (rtx, rtx, rtx);
extern rtx        gen_iornotvnx2ti3                  (rtx, rtx, rtx);
extern rtx        gen_xornotvnx2ti3                  (rtx, rtx, rtx);
extern rtx        gen_andnotaie_v2oi3                (rtx, rtx, rtx);
extern rtx        gen_iornotaie_v2oi3                (rtx, rtx, rtx);
extern rtx        gen_xornotaie_v2oi3                (rtx, rtx, rtx);
extern rtx        gen_one_cmplvnx16qi2               (rtx, rtx);
extern rtx        gen_one_cmplvnx8hi2                (rtx, rtx);
extern rtx        gen_one_cmplvnx4si2                (rtx, rtx);
extern rtx        gen_one_cmplvnx2di2                (rtx, rtx);
extern rtx        gen_one_cmplvnx2ti2                (rtx, rtx);
extern rtx        gen_one_cmplaie_v2oi2              (rtx, rtx);
extern rtx        gen_bselvvnx4sf_alt                (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx8hf_alt                (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx16qi_alt               (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx8hi_alt                (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx4si_alt                (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx2di_alt                (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx2ti_alt                (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvaie_v2oi_alt              (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx4sf                    (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx8hf                    (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx16qi                   (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx8hi                    (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx4si                    (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx2di                    (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvvnx2ti                    (rtx, rtx, rtx, rtx);
extern rtx        gen_bselvaie_v2oi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_vashlvnx16qi3                  (rtx, rtx, rtx);
extern rtx        gen_vashlvnx8hi3                   (rtx, rtx, rtx);
extern rtx        gen_vashlvnx4si3                   (rtx, rtx, rtx);
extern rtx        gen_vashrvnx16qi3                  (rtx, rtx, rtx);
extern rtx        gen_vashrvnx8hi3                   (rtx, rtx, rtx);
extern rtx        gen_vashrvnx4si3                   (rtx, rtx, rtx);
extern rtx        gen_vlshrvnx16qi3                  (rtx, rtx, rtx);
extern rtx        gen_vlshrvnx8hi3                   (rtx, rtx, rtx);
extern rtx        gen_vlshrvnx4si3                   (rtx, rtx, rtx);
extern rtx        gen_aie_liwh_insn                  (rtx, rtx, rtx);
extern rtx        gen_aie_liwr                       (rtx, rtx);
extern rtx        gen_aie_lutw                       (rtx, rtx);
extern rtx        gen_aie_lutr                       (rtx, rtx);
extern rtx        gen_aie_nnrwr                      (rtx, rtx);
extern rtx        gen_aie_nnrrd                      (rtx, rtx);
extern rtx        gen_aie_nndwr                      (rtx, rtx);
extern rtx        gen_aie_nndrd                      (rtx, rtx);
extern rtx        gen_aie_nncmd                      (rtx);
extern rtx        gen_aie_nnmac                      (rtx, rtx);
extern rtx        gen_aie_mask_all_zerovnx16bi       (rtx, rtx);
extern rtx        gen_aie_mask_all_zerovnx8bi        (rtx, rtx);
extern rtx        gen_aie_mask_all_zerovnx4bi        (rtx, rtx);
extern rtx        gen_aie_mask_all_truevnx16bi       (rtx, rtx);
extern rtx        gen_aie_mask_all_truevnx8bi        (rtx, rtx);
extern rtx        gen_aie_mask_all_truevnx4bi        (rtx, rtx);
extern rtx        gen_aie_movvnx16bi                 (rtx, rtx);
extern rtx        gen_aie_movvnx8bi                  (rtx, rtx);
extern rtx        gen_aie_movvnx4bi                  (rtx, rtx);
extern rtx        gen_andvnx16bi3                    (rtx, rtx, rtx);
extern rtx        gen_iorvnx16bi3                    (rtx, rtx, rtx);
extern rtx        gen_xorvnx16bi3                    (rtx, rtx, rtx);
extern rtx        gen_andvnx8bi3                     (rtx, rtx, rtx);
extern rtx        gen_iorvnx8bi3                     (rtx, rtx, rtx);
extern rtx        gen_xorvnx8bi3                     (rtx, rtx, rtx);
extern rtx        gen_andvnx4bi3                     (rtx, rtx, rtx);
extern rtx        gen_iorvnx4bi3                     (rtx, rtx, rtx);
extern rtx        gen_xorvnx4bi3                     (rtx, rtx, rtx);
extern rtx        gen_notandvnx16bi3                 (rtx, rtx, rtx);
extern rtx        gen_notiorvnx16bi3                 (rtx, rtx, rtx);
extern rtx        gen_notxorvnx16bi3                 (rtx, rtx, rtx);
extern rtx        gen_notandvnx8bi3                  (rtx, rtx, rtx);
extern rtx        gen_notiorvnx8bi3                  (rtx, rtx, rtx);
extern rtx        gen_notxorvnx8bi3                  (rtx, rtx, rtx);
extern rtx        gen_notandvnx4bi3                  (rtx, rtx, rtx);
extern rtx        gen_notiorvnx4bi3                  (rtx, rtx, rtx);
extern rtx        gen_notxorvnx4bi3                  (rtx, rtx, rtx);
extern rtx        gen_andnotvnx16bi3                 (rtx, rtx, rtx);
extern rtx        gen_iornotvnx16bi3                 (rtx, rtx, rtx);
extern rtx        gen_xornotvnx16bi3                 (rtx, rtx, rtx);
extern rtx        gen_andnotvnx8bi3                  (rtx, rtx, rtx);
extern rtx        gen_iornotvnx8bi3                  (rtx, rtx, rtx);
extern rtx        gen_xornotvnx8bi3                  (rtx, rtx, rtx);
extern rtx        gen_andnotvnx4bi3                  (rtx, rtx, rtx);
extern rtx        gen_iornotvnx4bi3                  (rtx, rtx, rtx);
extern rtx        gen_xornotvnx4bi3                  (rtx, rtx, rtx);
extern rtx        gen_one_cmplvnx16bi2               (rtx, rtx);
extern rtx        gen_one_cmplvnx8bi2                (rtx, rtx);
extern rtx        gen_one_cmplvnx4bi2                (rtx, rtx);
extern rtx        gen_aie_pcpopvnx16bi               (rtx, rtx, rtx);
extern rtx        gen_aie_pcpopvnx8bi                (rtx, rtx, rtx);
extern rtx        gen_aie_pcpopvnx4bi                (rtx, rtx, rtx);
extern rtx        gen_aie_pfirstvnx16bi              (rtx, rtx, rtx);
extern rtx        gen_aie_pfirstvnx8bi               (rtx, rtx, rtx);
extern rtx        gen_aie_pfirstvnx4bi               (rtx, rtx, rtx);
extern rtx        gen_aie_psbfvnx16bi                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_psifvnx16bi                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_psofvnx16bi                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_psbfvnx8bi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_psifvnx8bi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_psofvnx8bi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_psbfvnx4bi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_psifvnx4bi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_psofvnx4bi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_piotab                     (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_piotah                     (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_piotaw                     (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pidvnx16qi                 (rtx, rtx, rtx);
extern rtx        gen_aie_pidvnx8qi                  (rtx, rtx, rtx);
extern rtx        gen_aie_pidvnx4qi                  (rtx, rtx, rtx);
extern rtx        gen_aie_pidvnx8hi                  (rtx, rtx, rtx);
extern rtx        gen_aie_pidvnx4hi                  (rtx, rtx, rtx);
extern rtx        gen_aie_pidvnx4si                  (rtx, rtx, rtx);
extern rtx        gen_aie_pdecvnx16bi                (rtx, rtx);
extern rtx        gen_aie_pdecvnx8bi                 (rtx, rtx);
extern rtx        gen_aie_pdecvnx4bi                 (rtx, rtx);
extern rtx        gen_aie_pceqvnx16qi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnevnx16qi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclesvnx16qi_mask          (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcleuvnx16qi_mask          (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltsvnx16qi_mask          (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltuvnx16qi_mask          (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqvnx8qi_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnevnx8qi_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclesvnx8qi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcleuvnx8qi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltsvnx8qi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltuvnx8qi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqvnx4qi_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnevnx4qi_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclesvnx4qi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcleuvnx4qi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltsvnx4qi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltuvnx4qi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqvnx8hi_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnevnx8hi_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclesvnx8hi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcleuvnx8hi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltsvnx8hi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltuvnx8hi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqvnx4hi_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnevnx4hi_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclesvnx4hi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcleuvnx4hi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltsvnx4hi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltuvnx4hi_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqvnx4si_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnevnx4si_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclesvnx4si_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcleuvnx4si_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltsvnx4si_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltuvnx4si_mask           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqzvnx16qi_mask_internal (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnezvnx16qi_mask_internal (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclezvnx16qi_mask_internal (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltzvnx16qi_mask_internal (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqzvnx8qi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnezvnx8qi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclezvnx8qi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltzvnx8qi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqzvnx4qi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnezvnx4qi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclezvnx4qi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltzvnx4qi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqzvnx8hi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnezvnx8hi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclezvnx8hi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltzvnx8hi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqzvnx4hi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnezvnx4hi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclezvnx4hi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltzvnx4hi_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqzvnx4si_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnezvnx4si_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclezvnx4si_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltzvnx4si_mask_internal  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_readvl                     (rtx);
extern rtx        gen_vundefinedvnx4sf               (rtx);
extern rtx        gen_vundefinedvnx8hf               (rtx);
extern rtx        gen_vundefinedvnx16qi              (rtx);
extern rtx        gen_vundefinedvnx8hi               (rtx);
extern rtx        gen_vundefinedvnx4si               (rtx);
extern rtx        gen_vundefinedvnx2di               (rtx);
extern rtx        gen_vundefinedvnx2ti               (rtx);
extern rtx        gen_vundefinedaie_v2oi             (rtx);
extern rtx        gen_vundefinedvnx16bi              (rtx);
extern rtx        gen_vundefinedvnx8bi               (rtx);
extern rtx        gen_vundefinedvnx4bi               (rtx);
extern rtx        gen_addvnx16qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_subvnx16qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_mulvnx16qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_sminvnx16qi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_uminvnx16qi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_smaxvnx16qi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_umaxvnx16qi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_addvnx8qi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_subvnx8qi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_mulvnx8qi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_sminvnx8qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_uminvnx8qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_smaxvnx8qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_umaxvnx8qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_addvnx4qi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_subvnx4qi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_mulvnx4qi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_sminvnx4qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_uminvnx4qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_smaxvnx4qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_umaxvnx4qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_addvnx8hi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_subvnx8hi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_mulvnx8hi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_sminvnx8hi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_uminvnx8hi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_smaxvnx8hi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_umaxvnx8hi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_addvnx4hi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_subvnx4hi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_mulvnx4hi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_sminvnx4hi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_uminvnx4hi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_smaxvnx4hi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_umaxvnx4hi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_addvnx4si3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_subvnx4si3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_mulvnx4si3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_sminvnx4si3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_uminvnx4si3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_smaxvnx4si3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_umaxvnx4si3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_waddsbl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsubsbl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_waddubl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsububl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_waddsbh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsubsbh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_waddubh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsububh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_waddshl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsubshl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wadduhl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsubuhl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_waddshh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsubshh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wadduhh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsubuhh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_absvnx16qi2_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_absvnx8qi2_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_absvnx4qi2_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_absvnx8hi2_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_absvnx4hi2_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_absvnx4si2_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_smulbe_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_umulbe_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_smulbo_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_umulbo_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_smulhe_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_umulhe_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_smulho_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_umulho_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsmulbl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wumulbl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsmulbh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wumulbh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsmulhl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wumulhl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsmulhh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wumulhh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mlaw_mask                  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mlsw_mask                  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_smlahe_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_smlshe_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_smlaho_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_smlsho_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsmlahl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsmlshl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsmlahh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_wsmlshh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_maxu2bi_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_maxu4bi_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_minu2bi_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_minu4bi_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_maxab_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_maxah_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_maxaw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_minab_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_minah_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_minaw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satsub2bi_mask             (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satsub4bi_mask             (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satuub2bi_mask             (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satuub4bi_mask             (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satsshb_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satsuh2bi_mask             (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satsuh4bi_mask             (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satsuhb_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satuuh2bi_mask             (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satuuh4bi_mask             (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satuuhb_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satsswb_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satsswh_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satsuw2bi_mask             (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satsuw4bi_mask             (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satsuwb_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satsuwh_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satuuw4bi_mask             (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satuuwb_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_satuuwh_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_tocb_mask                  (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_toch_mask                  (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_tocw_mask                  (rtx, rtx, rtx, rtx);
extern rtx        gen_andvnx8hi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_iorvnx8hi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_xorvnx8hi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_andvnx4hi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_iorvnx4hi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_xorvnx4hi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_andvnx4si3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_iorvnx4si3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_xorvnx4si3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_andvnx16qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_iorvnx16qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_xorvnx16qi3_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_andvnx8qi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_iorvnx8qi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_xorvnx8qi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_andvnx4qi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_iorvnx4qi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_xorvnx4qi3_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_andnotvnx16qi3_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_iornotvnx16qi3_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_xornotvnx16qi3_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_andnotvnx8hi3_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_iornotvnx8hi3_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_xornotvnx8hi3_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_andnotvnx4si3_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_iornotvnx4si3_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_xornotvnx4si3_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_notxorvnx16qi3_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_notxorvnx8hi3_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_notxorvnx4si3_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_eselvnx16qi_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_eselvnx8qi_mask            (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_eselvnx4qi_mask            (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_eselvnx8hi_mask            (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_eselvnx4hi_mask            (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_eselvnx4si_mask            (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_eselvnx4sf_mask            (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_eselvnx8hf_mask            (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_eselvnx4hf_mask            (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pfcorw_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pfceqw_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pfcnew_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pfclew_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pfcltw_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pfcorh_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pfceqh_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pfcneh_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pfcleh_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pfclth_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fmaddw_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fmsubw_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fnmaddw_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fnmsubw_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_faddw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fsubw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fmulw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fminw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fmaxw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_faddh_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fsubh_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fmulh_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fminh_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fmaxh_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fcmulrw_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fcmuliw_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fcaddw_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fcmulrh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fcmulih_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fcaddh_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fmaxaw_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fmaxah_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fminaw_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fminah_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fclassw_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fclassh_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ffsiw_mask                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ffsih_mask                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ffuiw_mask                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ffuih_mask                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ftsiw_mask                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ftsih_mask                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ftuiw_mask                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ftuih_mask                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_frintw_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_frinth_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ftruncsw_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ftruncsh_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ftruncuw_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ftruncuh_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fcvthw_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fcvtwh_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_vashlvnx16qi3_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vashlvnx8qi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vashlvnx4qi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vashlvnx8hi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vashlvnx4hi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vashlvnx4si3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sllib_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sllih_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_slliw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vashrvnx16qi3_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vashrvnx8qi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vashrvnx4qi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vashrvnx8hi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vashrvnx4hi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vashrvnx4si3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sraib_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sraih_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sraiw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vlshrvnx16qi3_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vlshrvnx8qi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vlshrvnx4qi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vlshrvnx8hi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vlshrvnx4hi3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vlshrvnx4si3_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srlib_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srlih_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srliw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srarb_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srarh_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srarw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srarib_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srarih_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srariw_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srlrb_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srlrh_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srlrw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srlrib_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srlrih_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_srlriw_mask                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt1bi_mask                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt2bi_mask                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt4bi_mask                 (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gtb_mask                   (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gth_mask                   (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuwll_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuwlh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuwhl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuwhh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extu1bil_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_exts1bil_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extu1bih_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_exts1bih_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extu2bil_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_exts2bil_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extu2bih_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_exts2bih_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extu4bil_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_exts4bil_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extu4bih_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_exts4bih_mask              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extsbl_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extubl_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extsbh_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extubh_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extshl_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuhl_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extshh_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuhh_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extu3bw_mask               (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gshufw_mask                (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gshufwb_mask               (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gshufwb_2_mask             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gshufvb_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilve2bi_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilve4bi_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilvo2bi_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilvo4bi_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_bshli_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_bshri_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_bshl_mask                  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_bshr_mask                  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mfcpuvnx16qi_mask          (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mfcpuvnx8qi_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mfcpuvnx4qi_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mfcpuvnx8hi_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mfcpuvnx4hi_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mfcpuvnx4si_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mfcpuvnx4sf_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mfcpuvnx8hf_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mfcpuvnx4hf_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mfsumz_mask_insn           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mxsum_mask_insn            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_cmvw_mask                  (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pmaph_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pmapw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luvb_mask_const            (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luvh_mask_const            (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luvw_mask_const            (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luvb_mask_reg              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luvh_mask_reg              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luvw_mask_reg              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lavb_mask_internal         (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lavh_mask_internal         (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lavw_mask_internal         (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suvb_mask_const            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suvh_mask_const            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suvw_mask_const            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suvb_mask_reg              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suvh_mask_reg              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suvw_mask_reg              (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_savb_mask_internal         (rtx, rtx, rtx);
extern rtx        gen_aie_savh_mask_internal         (rtx, rtx, rtx);
extern rtx        gen_aie_savw_mask_internal         (rtx, rtx, rtx);
extern rtx        gen_aie_maskloadvnx16qi            (rtx, rtx, rtx);
extern rtx        gen_aie_maskloadvnx8hi             (rtx, rtx, rtx);
extern rtx        gen_aie_maskloadvnx4si             (rtx, rtx, rtx);
extern rtx        gen_aie_maskloadvnx4sf             (rtx, rtx, rtx);
extern rtx        gen_aie_maskloadvnx8hf             (rtx, rtx, rtx);
extern rtx        gen_aie_maskstorevnx16qi           (rtx, rtx, rtx);
extern rtx        gen_aie_maskstorevnx8hi            (rtx, rtx, rtx);
extern rtx        gen_aie_maskstorevnx4si            (rtx, rtx, rtx);
extern rtx        gen_aie_maskstorevnx4sf            (rtx, rtx, rtx);
extern rtx        gen_aie_maskstorevnx8hf            (rtx, rtx, rtx);
extern rtx        gen_aie_ilvevnx16qi                (rtx, rtx, rtx);
extern rtx        gen_aie_ilvevnx8qi                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvevnx4qi                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvevnx8hi                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvevnx4hi                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvevnx4si                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvevnx4sf                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvevnx8hf                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvevnx4hf                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvovnx16qi                (rtx, rtx, rtx);
extern rtx        gen_aie_ilvovnx8qi                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvovnx4qi                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvovnx8hi                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvovnx4hi                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvovnx4si                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvovnx4sf                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvovnx8hf                 (rtx, rtx, rtx);
extern rtx        gen_aie_ilvovnx4hf                 (rtx, rtx, rtx);
extern rtx        gen_psubszsi3                      (rtx, rtx, rtx);
extern rtx        gen_aie_vec_duplicate_vlvnx16qi    (rtx, rtx);
extern rtx        gen_aie_vec_duplicate_vlvnx8qi     (rtx, rtx);
extern rtx        gen_aie_vec_duplicate_vlvnx4qi     (rtx, rtx);
extern rtx        gen_aie_vec_duplicate_vlvnx8hi     (rtx, rtx);
extern rtx        gen_aie_vec_duplicate_vlvnx4hi     (rtx, rtx);
extern rtx        gen_aie_vec_duplicate_vlvnx4si     (rtx, rtx);
extern rtx        gen_movsioi2_subreg                (rtx, rtx);
extern rtx        gen_movdioi2_subreg                (rtx, rtx);
extern rtx        gen_aie_sr1sum2bi_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2sum2bi_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4sum2bi_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8sum2bi_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16sum2bi_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr1sum4bi_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2sum4bi_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4sum4bi_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8sum4bi_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16sum4bi_mask            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr1sumub_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2sumub_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4sumub_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8sumub_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16sumub_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr1sumsb_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2sumsb_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4sumsb_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8sumsb_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16sumsb_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr1sumuh_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2sumuh_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4sumuh_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8sumuh_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16sumuh_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr1sumsh_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2sumsh_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4sumsh_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8sumsh_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16sumsh_mask             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr1sumw_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2sumw_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4sumw_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8sumw_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16sumw_mask              (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr1mac2bi_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2mac2bi_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4mac2bi_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8mac2bi_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16mac2bi_mask            (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr1mac4bi_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2mac4bi_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4mac4bi_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8mac4bi_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16mac4bi_mask            (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr1macuub_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2macuub_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4macuub_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8macuub_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16macuub_mask            (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr1macsub_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2macsub_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4macsub_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8macsub_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16macsub_mask            (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr1macssb_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2macssb_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4macssb_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8macssb_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16macssb_mask            (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr1macssh_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr2macssh_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr4macssh_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr8macssh_mask             (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sr16macssh_mask            (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s1macuub_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s2macuub_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s4macuub_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s8macuub_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s16macuub_mask             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s1macsub_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s2macsub_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s4macsub_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s8macsub_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s16macsub_mask             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s1macssb_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s2macssb_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s4macssb_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s8macssb_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s16macssb_mask             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s1macssh_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s2macssh_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s4macssh_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s8macssh_mask              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_s16macssh_mask             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fxas1w_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fxas2w_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fxas4w_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fxas8w_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fxas1h_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fxas2h_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fxas4h_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_fxas8h_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt2w_mask_insn             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt4w_mask_insn             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt8w_mask_insn             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt2d_mask_insn             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt4d_mask_insn             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt2q_mask_insn             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extudll_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extudlh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extudhl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extudhh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuqll_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuqlh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuqhl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuqhh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuoll_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuolh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuohl_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_extuohh_mask               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_shufw2_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_shufw4_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_shufw8_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_shufd2_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_shufd4_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_shufq2_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilveb_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilveh_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilvew_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilved_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilveq_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilveo_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilvob_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilvoh_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilvow_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilvod_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilvoq_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ilvoo_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_repib_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_repih_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_repiw_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_repid_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_repiq_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_repio_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_repib                      (rtx, rtx, rtx);
extern rtx        gen_aie_repih                      (rtx, rtx, rtx);
extern rtx        gen_aie_repiw                      (rtx, rtx, rtx);
extern rtx        gen_aie_repid                      (rtx, rtx, rtx);
extern rtx        gen_aie_repiq                      (rtx, rtx, rtx);
extern rtx        gen_aie_repio                      (rtx, rtx, rtx);
extern rtx        gen_aie_movw                       (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_movd                       (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_movq                       (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_movo                       (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luw_mask                   (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lud_mask                   (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luq_mask                   (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luo_mask                   (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_law_mask_internal          (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lad_mask_internal          (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_laq_mask_internal          (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lao_mask_internal          (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suw_mask                   (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sud_mask                   (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suq_mask                   (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suo_mask                   (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_saw_mask_internal          (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sad_mask_internal          (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_saq_mask_internal          (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sao_mask_internal          (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luw2b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luw2h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luw4b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luw4h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luw8b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luw8h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luw16b_mask                (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luw16h_mask                (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lud2b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lud2h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lud2w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lud4b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lud4h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lud4w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lud8b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lud8h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lud8w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luq2b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luq2h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luq2w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luq2d_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luq4b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luq4h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luq4w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luq4d_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luo2b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luo2h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luo2w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luo2d_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_luo2q_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_law2b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_law2h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_law4b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_law4h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_law8b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_law8h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_law16b_mask                (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_law16h_mask                (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lad2b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lad2h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lad2w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lad4b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lad4h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lad4w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lad8b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lad8h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lad8w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_laq2b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_laq2h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_laq2w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_laq2d_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_laq4b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_laq4h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_laq4w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_laq4d_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lao2b_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lao2h_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lao2w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lao2d_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lao2q_mask                 (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sud2w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sud4w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sud8w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suq2w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suq2d_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suq4w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suq4d_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suo2w_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suo2d_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_suo2q_mask                 (rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sad2w_mask_internal        (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sad4w_mask_internal        (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sad8w_mask_internal        (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_saq2w_mask_internal        (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_saq2d_mask_internal        (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_saq4w_mask_internal        (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_saq4d_mask_internal        (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sao2w_mask_internal        (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sao2d_mask_internal        (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sao2q_mask_internal        (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_addr_update_vls            (rtx, rtx);
extern rtx        gen_addvsi4                        (rtx, rtx, rtx, rtx);
extern rtx        gen_addvdi4                        (rtx, rtx, rtx, rtx);
extern rtx        gen_uaddvsi4                       (rtx, rtx, rtx, rtx);
extern rtx        gen_uaddvdi4                       (rtx, rtx, rtx, rtx);
extern rtx        gen_subvsi4                        (rtx, rtx, rtx, rtx);
extern rtx        gen_subvdi4                        (rtx, rtx, rtx, rtx);
extern rtx        gen_usubvsi4                       (rtx, rtx, rtx, rtx);
extern rtx        gen_usubvdi4                       (rtx, rtx, rtx, rtx);
extern rtx        gen_mulvsi4                        (rtx, rtx, rtx, rtx);
extern rtx        gen_mulvdi4                        (rtx, rtx, rtx, rtx);
extern rtx        gen_umulvsi4                       (rtx, rtx, rtx, rtx);
extern rtx        gen_umulvdi4                       (rtx, rtx, rtx, rtx);
extern rtx        gen_mulditi3                       (rtx, rtx, rtx);
extern rtx        gen_umulditi3                      (rtx, rtx, rtx);
extern rtx        gen_usmulditi3                     (rtx, rtx, rtx);
extern rtx        gen_mulsidi3                       (rtx, rtx, rtx);
extern rtx        gen_umulsidi3                      (rtx, rtx, rtx);
extern rtx        gen_usmulsidi3                     (rtx, rtx, rtx);
extern rtx        gen_zero_extendsidi2               (rtx, rtx);
extern rtx        gen_zero_extendhisi2               (rtx, rtx);
extern rtx        gen_zero_extendhidi2               (rtx, rtx);
extern rtx        gen_extendqihi2                    (rtx, rtx);
extern rtx        gen_extendqisi2                    (rtx, rtx);
extern rtx        gen_extendqidi2                    (rtx, rtx);
extern rtx        gen_extendhihi2                    (rtx, rtx);
extern rtx        gen_extendhisi2                    (rtx, rtx);
extern rtx        gen_extendhidi2                    (rtx, rtx);
extern rtx        gen_movhf                          (rtx, rtx);
extern rtx        gen_movdi                          (rtx, rtx);
extern rtx        gen_movsi                          (rtx, rtx);
extern rtx        gen_movhi                          (rtx, rtx);
extern rtx        gen_movqi                          (rtx, rtx);
extern rtx        gen_movsf                          (rtx, rtx);
extern rtx        gen_movdf                          (rtx, rtx);
extern rtx        gen_cpymemsi                       (rtx, rtx, rtx, rtx);
extern rtx        gen_clear_cache                    (rtx, rtx);
extern rtx        gen_movsicc                        (rtx, rtx, rtx, rtx);
extern rtx        gen_movdicc                        (rtx, rtx, rtx, rtx);
extern rtx        gen_condjump                       (rtx, rtx);
extern rtx        gen_cbranchqi4                     (rtx, rtx, rtx, rtx);
extern rtx        gen_cbranchsi4                     (rtx, rtx, rtx, rtx);
extern rtx        gen_cbranchdi4                     (rtx, rtx, rtx, rtx);
extern rtx        gen_cbranchsf4                     (rtx, rtx, rtx, rtx);
extern rtx        gen_cbranchdf4                     (rtx, rtx, rtx, rtx);
extern rtx        gen_cbranchhf4                     (rtx, rtx, rtx, rtx);
extern rtx        gen_cstoresi4                      (rtx, rtx, rtx, rtx);
extern rtx        gen_cstoredi4                      (rtx, rtx, rtx, rtx);
extern rtx        gen_cstoresf4                      (rtx, rtx, rtx, rtx);
extern rtx        gen_cstoredf4                      (rtx, rtx, rtx, rtx);
extern rtx        gen_cstorehf4                      (rtx, rtx, rtx, rtx);
extern rtx        gen_flt_quietsfsi4                 (rtx, rtx, rtx);
extern rtx        gen_fle_quietsfsi4                 (rtx, rtx, rtx);
extern rtx        gen_flt_quietsfdi4                 (rtx, rtx, rtx);
extern rtx        gen_fle_quietsfdi4                 (rtx, rtx, rtx);
extern rtx        gen_flt_quietdfsi4                 (rtx, rtx, rtx);
extern rtx        gen_fle_quietdfsi4                 (rtx, rtx, rtx);
extern rtx        gen_flt_quietdfdi4                 (rtx, rtx, rtx);
extern rtx        gen_fle_quietdfdi4                 (rtx, rtx, rtx);
extern rtx        gen_flt_quiethfsi4                 (rtx, rtx, rtx);
extern rtx        gen_fle_quiethfsi4                 (rtx, rtx, rtx);
extern rtx        gen_flt_quiethfdi4                 (rtx, rtx, rtx);
extern rtx        gen_fle_quiethfdi4                 (rtx, rtx, rtx);
extern rtx        gen_indirect_jump                  (rtx);
extern rtx        gen_tablejump                      (rtx, rtx);
extern rtx        gen_prologue                       (void);
extern rtx        gen_epilogue                       (void);
extern rtx        gen_sibcall_epilogue               (void);
extern rtx        gen_return                         (void);
extern rtx        gen_eh_return                      (rtx);
extern rtx        gen_sibcall                        (rtx, rtx, rtx, rtx);
extern rtx        gen_sibcall_value                  (rtx, rtx, rtx, rtx);
extern rtx        gen_call                           (rtx, rtx, rtx, rtx);
extern rtx        gen_call_value                     (rtx, rtx, rtx, rtx);
extern rtx        gen_untyped_call                   (rtx, rtx, rtx);
extern rtx        gen_restore_stack_nonlocal         (rtx, rtx);
extern rtx        gen_get_thread_pointersi           (rtx);
extern rtx        gen_get_thread_pointerdi           (rtx);
extern rtx        gen_stack_protect_set              (rtx, rtx);
extern rtx        gen_stack_protect_test             (rtx, rtx, rtx);
extern rtx        gen_mem_thread_fence               (rtx);
extern rtx        gen_atomic_compare_and_swapsi      (rtx, rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_compare_and_swapdi      (rtx, rtx, rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_atomic_test_and_set            (rtx, rtx, rtx);
extern rtx        gen_vec_initvnx4sfsf               (rtx, rtx);
extern rtx        gen_vec_initvnx8hfhf               (rtx, rtx);
extern rtx        gen_vec_initvnx16qiqi              (rtx, rtx);
extern rtx        gen_vec_initvnx8hihi               (rtx, rtx);
extern rtx        gen_vec_initvnx4sisi               (rtx, rtx);
extern rtx        gen_vec_initvnx2didi               (rtx, rtx);
extern rtx        gen_vec_initvnx2titi               (rtx, rtx);
extern rtx        gen_vec_initaie_v2oioi             (rtx, rtx);
extern rtx        gen_vec_duplicatevnx16bi           (rtx, rtx);
extern rtx        gen_vec_duplicatevnx8bi            (rtx, rtx);
extern rtx        gen_vec_duplicatevnx4bi            (rtx, rtx);
extern rtx        gen_movvnx4sf                      (rtx, rtx);
extern rtx        gen_movvnx8hf                      (rtx, rtx);
extern rtx        gen_movvnx16qi                     (rtx, rtx);
extern rtx        gen_movvnx8hi                      (rtx, rtx);
extern rtx        gen_movvnx4si                      (rtx, rtx);
extern rtx        gen_movvw                          (rtx, rtx);
extern rtx        gen_movvnx2di                      (rtx, rtx);
extern rtx        gen_movvnx2ti                      (rtx, rtx);
extern rtx        gen_movaie_v2oi                    (rtx, rtx);
extern rtx        gen_vec_cmpvnx16qivnx16qi          (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpvnx8hivnx8hi            (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpvnx4sivnx4si            (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpvnx4sfvnx4si            (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpuvnx16qivnx16qi         (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpuvnx8hivnx8hi           (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpuvnx4sivnx4si           (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx4sfvnx4si        (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx16qivnx16qi      (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx8hivnx8hi        (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx4sivnx4si        (rtx, rtx, rtx, rtx);
extern rtx        gen_vcondvnx4sfvnx4sf              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vcondvnx16qivnx16qi            (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vcondvnx8hivnx8hi              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vcondvnx4sivnx4si              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vcondvnx4sivnx4sf              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vcondvnx4sfvnx4si              (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vconduvnx4sfvnx4sf             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vconduvnx16qivnx16qi           (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vconduvnx8hivnx8hi             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vconduvnx4sivnx4si             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vconduvnx4sfvnx4si             (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_ceqzb_ext                  (rtx, rtx);
extern rtx        gen_aie_clezb_ext                  (rtx, rtx);
extern rtx        gen_aie_cltzb_ext                  (rtx, rtx);
extern rtx        gen_aie_ceqzh_ext                  (rtx, rtx);
extern rtx        gen_aie_clezh_ext                  (rtx, rtx);
extern rtx        gen_aie_cltzh_ext                  (rtx, rtx);
extern rtx        gen_aie_ceqzw_ext                  (rtx, rtx);
extern rtx        gen_aie_clezw_ext                  (rtx, rtx);
extern rtx        gen_aie_cltzw_ext                  (rtx, rtx);
extern rtx        gen_aie_andib                      (rtx, rtx, rtx);
extern rtx        gen_aie_iorib                      (rtx, rtx, rtx);
extern rtx        gen_aie_xorib                      (rtx, rtx, rtx);
extern rtx        gen_aie_lih                        (rtx, rtx);
extern rtx        gen_aie_liw                        (rtx, rtx);
extern rtx        gen_aie_liwh                       (rtx, rtx, rtx);
extern rtx        gen_movvnx16bi                     (rtx, rtx);
extern rtx        gen_movvnx8bi                      (rtx, rtx);
extern rtx        gen_movvnx4bi                      (rtx, rtx);
extern rtx        gen_vec_seriesvnx16qi              (rtx, rtx, rtx);
extern rtx        gen_vec_seriesvnx8qi               (rtx, rtx, rtx);
extern rtx        gen_vec_seriesvnx4qi               (rtx, rtx, rtx);
extern rtx        gen_vec_seriesvnx8hi               (rtx, rtx, rtx);
extern rtx        gen_vec_seriesvnx4hi               (rtx, rtx, rtx);
extern rtx        gen_vec_seriesvnx4si               (rtx, rtx, rtx);
extern rtx        gen_aie_pldvnx16bi                 (rtx, rtx, rtx);
extern rtx        gen_aie_pldvnx8bi                  (rtx, rtx, rtx);
extern rtx        gen_aie_pldvnx4bi                  (rtx, rtx, rtx);
extern rtx        gen_aie_psdvnx16bi                 (rtx, rtx, rtx);
extern rtx        gen_aie_psdvnx8bi                  (rtx, rtx, rtx);
extern rtx        gen_aie_psdvnx4bi                  (rtx, rtx, rtx);
extern rtx        gen_aie_pceqzvnx16qi_mask          (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnezvnx16qi_mask          (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclezvnx16qi_mask          (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltzvnx16qi_mask          (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqzvnx8hi_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnezvnx8hi_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclezvnx8hi_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltzvnx8hi_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pceqzvnx4si_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcnezvnx4si_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pclezvnx4si_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_pcltzvnx4si_mask           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_andib_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_iorib_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_xorib_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sumz_mask                  (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mfsumz_mask                (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_mxsum_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lavb_mask                  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lavh_mask                  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lavw_mask                  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_savb_mask                  (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_savh_mask                  (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_savw_mask                  (rtx, rtx, rtx, rtx);
extern rtx        gen_movmisalignvnx16qi             (rtx, rtx);
extern rtx        gen_movmisalignvnx8hi              (rtx, rtx);
extern rtx        gen_movmisalignvnx4si              (rtx, rtx);
extern rtx        gen_movmisalignvnx4sf              (rtx, rtx);
extern rtx        gen_movmisalignvnx8hf              (rtx, rtx);
extern rtx        gen_len_load_vnx16qi               (rtx, rtx, rtx, rtx);
extern rtx        gen_len_load_vnx8hi                (rtx, rtx, rtx, rtx);
extern rtx        gen_len_load_vnx4si                (rtx, rtx, rtx, rtx);
extern rtx        gen_len_load_vnx4sf                (rtx, rtx, rtx, rtx);
extern rtx        gen_len_load_vnx8hf                (rtx, rtx, rtx, rtx);
extern rtx        gen_len_store_vnx16qi              (rtx, rtx, rtx, rtx);
extern rtx        gen_len_store_vnx8hi               (rtx, rtx, rtx, rtx);
extern rtx        gen_len_store_vnx4si               (rtx, rtx, rtx, rtx);
extern rtx        gen_len_store_vnx4sf               (rtx, rtx, rtx, rtx);
extern rtx        gen_len_store_vnx8hf               (rtx, rtx, rtx, rtx);
extern rtx        gen_len_maskloadvnx16qivnx16bi     (rtx, rtx, rtx, rtx);
extern rtx        gen_len_maskloadvnx8hivnx8bi       (rtx, rtx, rtx, rtx);
extern rtx        gen_len_maskloadvnx4sivnx4bi       (rtx, rtx, rtx, rtx);
extern rtx        gen_len_maskloadvnx4sfvnx4bi       (rtx, rtx, rtx, rtx);
extern rtx        gen_len_maskloadvnx8hfvnx8bi       (rtx, rtx, rtx, rtx);
extern rtx        gen_len_maskstorevnx16qivnx16bi    (rtx, rtx, rtx, rtx);
extern rtx        gen_len_maskstorevnx8hivnx8bi      (rtx, rtx, rtx, rtx);
extern rtx        gen_len_maskstorevnx4sivnx4bi      (rtx, rtx, rtx, rtx);
extern rtx        gen_len_maskstorevnx4sfvnx4bi      (rtx, rtx, rtx, rtx);
extern rtx        gen_len_maskstorevnx8hfvnx8bi      (rtx, rtx, rtx, rtx);
extern rtx        gen_maskloadvnx16qivnx16bi         (rtx, rtx, rtx);
extern rtx        gen_maskloadvnx8hivnx8bi           (rtx, rtx, rtx);
extern rtx        gen_maskloadvnx4sivnx4bi           (rtx, rtx, rtx);
extern rtx        gen_maskloadvnx4sfvnx4bi           (rtx, rtx, rtx);
extern rtx        gen_maskloadvnx8hfvnx8bi           (rtx, rtx, rtx);
extern rtx        gen_maskstorevnx16qivnx16bi        (rtx, rtx, rtx);
extern rtx        gen_maskstorevnx8hivnx8bi          (rtx, rtx, rtx);
extern rtx        gen_maskstorevnx4sivnx4bi          (rtx, rtx, rtx);
extern rtx        gen_maskstorevnx4sfvnx4bi          (rtx, rtx, rtx);
extern rtx        gen_maskstorevnx8hfvnx8bi          (rtx, rtx, rtx);
extern rtx        gen_vec_cmpvnx16qivnx16bi          (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpvnx8qivnx8bi            (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpvnx4qivnx4bi            (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpvnx8hivnx8bi            (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpvnx4hivnx4bi            (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpvnx4sivnx4bi            (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpvnx4sfvnx4bi            (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpvnx8hfvnx8bi            (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpvnx4hfvnx4bi            (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpuvnx16qivnx16bi         (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpuvnx8qivnx8bi           (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpuvnx4qivnx4bi           (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpuvnx8hivnx8bi           (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpuvnx4hivnx4bi           (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpuvnx4sivnx4bi           (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpuvnx4sfvnx4bi           (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpuvnx8hfvnx8bi           (rtx, rtx, rtx, rtx);
extern rtx        gen_vec_cmpuvnx4hfvnx4bi           (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_vec_cmpvnx16qivnx16bi      (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_vec_cmpvnx8qivnx8bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_vec_cmpvnx4qivnx4bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_vec_cmpvnx8hivnx8bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_vec_cmpvnx4hivnx4bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_vec_cmpvnx4sivnx4bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_vec_cmpvnx4sfvnx4bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_vec_cmpvnx8hfvnx8bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_aie_vec_cmpvnx4hfvnx4bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx16qivnx16bi      (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx8qivnx8bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx4qivnx4bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx8hivnx8bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx4hivnx4bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx4sivnx4bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx4sfvnx4bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx8hfvnx8bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_vcond_mask_vnx4hfvnx4bi        (rtx, rtx, rtx, rtx);
extern rtx        gen_addvnx16qi3                    (rtx, rtx, rtx);
extern rtx        gen_subvnx16qi3                    (rtx, rtx, rtx);
extern rtx        gen_mulvnx16qi3                    (rtx, rtx, rtx);
extern rtx        gen_sminvnx16qi3                   (rtx, rtx, rtx);
extern rtx        gen_uminvnx16qi3                   (rtx, rtx, rtx);
extern rtx        gen_smaxvnx16qi3                   (rtx, rtx, rtx);
extern rtx        gen_umaxvnx16qi3                   (rtx, rtx, rtx);
extern rtx        gen_addvnx8qi3                     (rtx, rtx, rtx);
extern rtx        gen_subvnx8qi3                     (rtx, rtx, rtx);
extern rtx        gen_mulvnx8qi3                     (rtx, rtx, rtx);
extern rtx        gen_sminvnx8qi3                    (rtx, rtx, rtx);
extern rtx        gen_uminvnx8qi3                    (rtx, rtx, rtx);
extern rtx        gen_smaxvnx8qi3                    (rtx, rtx, rtx);
extern rtx        gen_umaxvnx8qi3                    (rtx, rtx, rtx);
extern rtx        gen_addvnx4qi3                     (rtx, rtx, rtx);
extern rtx        gen_subvnx4qi3                     (rtx, rtx, rtx);
extern rtx        gen_mulvnx4qi3                     (rtx, rtx, rtx);
extern rtx        gen_sminvnx4qi3                    (rtx, rtx, rtx);
extern rtx        gen_uminvnx4qi3                    (rtx, rtx, rtx);
extern rtx        gen_smaxvnx4qi3                    (rtx, rtx, rtx);
extern rtx        gen_umaxvnx4qi3                    (rtx, rtx, rtx);
extern rtx        gen_addvnx8hi3                     (rtx, rtx, rtx);
extern rtx        gen_subvnx8hi3                     (rtx, rtx, rtx);
extern rtx        gen_mulvnx8hi3                     (rtx, rtx, rtx);
extern rtx        gen_sminvnx8hi3                    (rtx, rtx, rtx);
extern rtx        gen_uminvnx8hi3                    (rtx, rtx, rtx);
extern rtx        gen_smaxvnx8hi3                    (rtx, rtx, rtx);
extern rtx        gen_umaxvnx8hi3                    (rtx, rtx, rtx);
extern rtx        gen_addvnx4hi3                     (rtx, rtx, rtx);
extern rtx        gen_subvnx4hi3                     (rtx, rtx, rtx);
extern rtx        gen_mulvnx4hi3                     (rtx, rtx, rtx);
extern rtx        gen_sminvnx4hi3                    (rtx, rtx, rtx);
extern rtx        gen_uminvnx4hi3                    (rtx, rtx, rtx);
extern rtx        gen_smaxvnx4hi3                    (rtx, rtx, rtx);
extern rtx        gen_umaxvnx4hi3                    (rtx, rtx, rtx);
extern rtx        gen_addvnx4si3                     (rtx, rtx, rtx);
extern rtx        gen_subvnx4si3                     (rtx, rtx, rtx);
extern rtx        gen_mulvnx4si3                     (rtx, rtx, rtx);
extern rtx        gen_sminvnx4si3                    (rtx, rtx, rtx);
extern rtx        gen_uminvnx4si3                    (rtx, rtx, rtx);
extern rtx        gen_smaxvnx4si3                    (rtx, rtx, rtx);
extern rtx        gen_umaxvnx4si3                    (rtx, rtx, rtx);
extern rtx        gen_cond_addvnx16qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_subvnx16qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_mulvnx16qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_sminvnx16qi               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_uminvnx16qi               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_smaxvnx16qi               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_umaxvnx16qi               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_addvnx8qi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_subvnx8qi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_mulvnx8qi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_sminvnx8qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_uminvnx8qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_smaxvnx8qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_umaxvnx8qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_addvnx4qi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_subvnx4qi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_mulvnx4qi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_sminvnx4qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_uminvnx4qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_smaxvnx4qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_umaxvnx4qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_addvnx8hi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_subvnx8hi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_mulvnx8hi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_sminvnx8hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_uminvnx8hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_smaxvnx8hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_umaxvnx8hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_addvnx4hi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_subvnx4hi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_mulvnx4hi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_sminvnx4hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_uminvnx4hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_smaxvnx4hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_umaxvnx4hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_addvnx4si                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_subvnx4si                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_mulvnx4si                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_sminvnx4si                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_uminvnx4si                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_smaxvnx4si                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_umaxvnx4si                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_addvnx16qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_subvnx16qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_mulvnx16qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_sminvnx16qi                (rtx, rtx, rtx, rtx);
extern rtx        gen_len_uminvnx16qi                (rtx, rtx, rtx, rtx);
extern rtx        gen_len_smaxvnx16qi                (rtx, rtx, rtx, rtx);
extern rtx        gen_len_umaxvnx16qi                (rtx, rtx, rtx, rtx);
extern rtx        gen_len_addvnx8qi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_subvnx8qi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_mulvnx8qi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_sminvnx8qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_uminvnx8qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_smaxvnx8qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_umaxvnx8qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_addvnx4qi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_subvnx4qi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_mulvnx4qi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_sminvnx4qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_uminvnx4qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_smaxvnx4qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_umaxvnx4qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_addvnx8hi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_subvnx8hi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_mulvnx8hi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_sminvnx8hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_uminvnx8hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_smaxvnx8hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_umaxvnx8hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_addvnx4hi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_subvnx4hi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_mulvnx4hi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_sminvnx4hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_uminvnx4hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_smaxvnx4hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_umaxvnx4hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_addvnx4si                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_subvnx4si                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_mulvnx4si                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_sminvnx4si                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_uminvnx4si                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_smaxvnx4si                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_umaxvnx4si                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_addvnx16qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_subvnx16qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_mulvnx16qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_sminvnx16qi           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_uminvnx16qi           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_smaxvnx16qi           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_umaxvnx16qi           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_addvnx8qi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_subvnx8qi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_mulvnx8qi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_sminvnx8qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_uminvnx8qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_smaxvnx8qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_umaxvnx8qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_addvnx4qi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_subvnx4qi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_mulvnx4qi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_sminvnx4qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_uminvnx4qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_smaxvnx4qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_umaxvnx4qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_addvnx8hi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_subvnx8hi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_mulvnx8hi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_sminvnx8hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_uminvnx8hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_smaxvnx8hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_umaxvnx8hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_addvnx4hi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_subvnx4hi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_mulvnx4hi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_sminvnx4hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_uminvnx4hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_smaxvnx4hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_umaxvnx4hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_addvnx4si             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_subvnx4si             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_mulvnx4si             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_sminvnx4si            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_uminvnx4si            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_smaxvnx4si            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_umaxvnx4si            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_absvnx16qi2                    (rtx, rtx);
extern rtx        gen_absvnx8qi2                     (rtx, rtx);
extern rtx        gen_absvnx4qi2                     (rtx, rtx);
extern rtx        gen_absvnx8hi2                     (rtx, rtx);
extern rtx        gen_absvnx4hi2                     (rtx, rtx);
extern rtx        gen_absvnx4si2                     (rtx, rtx);
extern rtx        gen_cond_andvnx16qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_iorvnx16qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_xorvnx16qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_andvnx8qi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_iorvnx8qi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_xorvnx8qi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_andvnx4qi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_iorvnx4qi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_xorvnx4qi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_andvnx8hi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_iorvnx8hi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_xorvnx8hi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_andvnx4hi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_iorvnx4hi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_xorvnx4hi                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_andvnx4si                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_iorvnx4si                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_xorvnx4si                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_andvnx16qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_iorvnx16qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_xorvnx16qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_andvnx8qi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_iorvnx8qi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_xorvnx8qi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_andvnx4qi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_iorvnx4qi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_xorvnx4qi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_andvnx8hi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_iorvnx8hi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_xorvnx8hi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_andvnx4hi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_iorvnx4hi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_xorvnx4hi                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_andvnx4si                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_iorvnx4si                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_xorvnx4si                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_andvnx16qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_iorvnx16qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_xorvnx16qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_andvnx8qi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_iorvnx8qi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_xorvnx8qi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_andvnx4qi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_iorvnx4qi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_xorvnx4qi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_andvnx8hi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_iorvnx8hi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_xorvnx8hi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_andvnx4hi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_iorvnx4hi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_xorvnx4hi             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_andvnx4si             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_iorvnx4si             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_xorvnx4si             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_negvnx16qi                (rtx, rtx, rtx, rtx);
extern rtx        gen_cond_negvnx8qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_cond_negvnx4qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_cond_negvnx8hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_cond_negvnx4hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_cond_negvnx4si                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_negvnx16qi                 (rtx, rtx, rtx);
extern rtx        gen_len_negvnx8qi                  (rtx, rtx, rtx);
extern rtx        gen_len_negvnx4qi                  (rtx, rtx, rtx);
extern rtx        gen_len_negvnx8hi                  (rtx, rtx, rtx);
extern rtx        gen_len_negvnx4hi                  (rtx, rtx, rtx);
extern rtx        gen_len_negvnx4si                  (rtx, rtx, rtx);
extern rtx        gen_len_tail_negvnx16qi            (rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_negvnx8qi             (rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_negvnx4qi             (rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_negvnx8hi             (rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_negvnx4hi             (rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_negvnx4si             (rtx, rtx, rtx, rtx);
extern rtx        gen_cond_ashlvnx16qi               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_ashrvnx16qi               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_lshrvnx16qi               (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_ashlvnx8qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_ashrvnx8qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_lshrvnx8qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_ashlvnx4qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_ashrvnx4qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_lshrvnx4qi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_ashlvnx8hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_ashrvnx8hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_lshrvnx8hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_ashlvnx4hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_ashrvnx4hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_lshrvnx4hi                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_ashlvnx4si                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_ashrvnx4si                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_lshrvnx4si                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_ashlvnx16qi                (rtx, rtx, rtx, rtx);
extern rtx        gen_len_ashrvnx16qi                (rtx, rtx, rtx, rtx);
extern rtx        gen_len_lshrvnx16qi                (rtx, rtx, rtx, rtx);
extern rtx        gen_len_ashlvnx8qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_ashrvnx8qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_lshrvnx8qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_ashlvnx4qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_ashrvnx4qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_lshrvnx4qi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_ashlvnx8hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_ashrvnx8hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_lshrvnx8hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_ashlvnx4hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_ashrvnx4hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_lshrvnx4hi                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_ashlvnx4si                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_ashrvnx4si                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_lshrvnx4si                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_ashlvnx16qi           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_ashrvnx16qi           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_lshrvnx16qi           (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_ashlvnx8qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_ashrvnx8qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_lshrvnx8qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_ashlvnx4qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_ashrvnx4qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_lshrvnx4qi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_ashlvnx8hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_ashrvnx8hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_lshrvnx8hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_ashlvnx4hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_ashrvnx4hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_lshrvnx4hi            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_ashlvnx4si            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_ashrvnx4si            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_lshrvnx4si            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_addvnx4sf3                     (rtx, rtx, rtx);
extern rtx        gen_subvnx4sf3                     (rtx, rtx, rtx);
extern rtx        gen_mulvnx4sf3                     (rtx, rtx, rtx);
extern rtx        gen_sminvnx4sf3                    (rtx, rtx, rtx);
extern rtx        gen_smaxvnx4sf3                    (rtx, rtx, rtx);
extern rtx        gen_addvnx8hf3                     (rtx, rtx, rtx);
extern rtx        gen_subvnx8hf3                     (rtx, rtx, rtx);
extern rtx        gen_mulvnx8hf3                     (rtx, rtx, rtx);
extern rtx        gen_sminvnx8hf3                    (rtx, rtx, rtx);
extern rtx        gen_smaxvnx8hf3                    (rtx, rtx, rtx);
extern rtx        gen_cond_addvnx4sf                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_subvnx4sf                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_mulvnx4sf                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_sminvnx4sf                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_smaxvnx4sf                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_addvnx8hf                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_subvnx8hf                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_mulvnx8hf                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_sminvnx8hf                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_cond_smaxvnx8hf                (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_addvnx4sf                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_subvnx4sf                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_mulvnx4sf                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_sminvnx4sf                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_smaxvnx4sf                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_addvnx8hf                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_subvnx8hf                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_mulvnx8hf                  (rtx, rtx, rtx, rtx);
extern rtx        gen_len_sminvnx8hf                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_smaxvnx8hf                 (rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_addvnx4sf             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_subvnx4sf             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_mulvnx4sf             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_sminvnx4sf            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_smaxvnx4sf            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_addvnx8hf             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_subvnx8hf             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_mulvnx8hf             (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_sminvnx8hf            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_tail_smaxvnx8hf            (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_fmavnx4sf4                     (rtx, rtx, rtx, rtx);
extern rtx        gen_fmsvnx4sf4                     (rtx, rtx, rtx, rtx);
extern rtx        gen_fnmavnx4sf4                    (rtx, rtx, rtx, rtx);
extern rtx        gen_fnmsvnx4sf4                    (rtx, rtx, rtx, rtx);
extern rtx        gen_len_fmavnx4sf                  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_fmsvnx4sf                  (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_fnmavnx4sf                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_len_fnmsvnx4sf                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_vec_widen_umult_even_vnx16qi   (rtx, rtx, rtx);
extern rtx        gen_vec_widen_umult_even_vnx8hi    (rtx, rtx, rtx);
extern rtx        gen_vec_widen_smult_even_vnx16qi   (rtx, rtx, rtx);
extern rtx        gen_vec_widen_smult_even_vnx8hi    (rtx, rtx, rtx);
extern rtx        gen_vec_widen_umult_odd_vnx16qi    (rtx, rtx, rtx);
extern rtx        gen_vec_widen_umult_odd_vnx8hi     (rtx, rtx, rtx);
extern rtx        gen_vec_widen_smult_odd_vnx16qi    (rtx, rtx, rtx);
extern rtx        gen_vec_widen_smult_odd_vnx8hi     (rtx, rtx, rtx);
extern rtx        gen_fix_truncsfoi2                 (rtx, rtx);
extern rtx        gen_fixuns_truncsfoi2              (rtx, rtx);
extern rtx        gen_fix_truncdfoi2                 (rtx, rtx);
extern rtx        gen_fixuns_truncdfoi2              (rtx, rtx);
extern rtx        gen_fix_trunchfoi2                 (rtx, rtx);
extern rtx        gen_fixuns_trunchfoi2              (rtx, rtx);
extern rtx        gen_aie_gt2w_mask                  (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt4w_mask                  (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt8w_mask                  (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt2d_mask                  (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt4d_mask                  (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_gt2q_mask                  (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_law_mask                   (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lad_mask                   (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_laq_mask                   (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_lao_mask                   (rtx, rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_saw_mask                   (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sad_mask                   (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_saq_mask                   (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sao_mask                   (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sad2w_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sad4w_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sad8w_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_saq2w_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_saq2d_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_saq4w_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_saq4d_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sao2w_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sao2d_mask                 (rtx, rtx, rtx, rtx, rtx);
extern rtx        gen_aie_sao2q_mask                 (rtx, rtx, rtx, rtx, rtx);

#endif /* GCC_INSN_FLAGS_H */
