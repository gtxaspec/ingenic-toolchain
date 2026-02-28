/* Test MIPS MXU2 ASE instructions */
/* { dg-do compile } */
/* { dg-options " -mmxu2 -mfused-madd" } */
/* { dg-skip-if "madd and msub need combine" { *-*-* } { "-O0" "-flto" } { "" } } */
/* { dg-final { scan-assembler "test0_v16i8.*:.*lui.*test0_v16i8" } } */
/* { dg-final { scan-assembler "test0_v8i16.*:.*lui.*test0_v8i16" } } */
/* { dg-final { scan-assembler "test0_v4i32.*:.*lui.*test0_v4i32" } } */
/* { dg-final { scan-assembler "test0_v2i64.*:.*lui.*test0_v2i64" } } */
/* { dg-final { scan-assembler "test0_v16u8.*:.*lui.*test0_v16u8" } } */
/* { dg-final { scan-assembler "test0_v8u16.*:.*lui.*test0_v8u16" } } */
/* { dg-final { scan-assembler "test0_v4u32.*:.*lui.*test0_v4u32" } } */
/* { dg-final { scan-assembler "test0_v2u64.*:.*lui.*test0_v2u64" } } */
/* { dg-final { scan-assembler "test0_v4f32.*:.*lui.*test0_v4f32" } } */
/* { dg-final { scan-assembler "test0_v2f64.*:.*lui.*test0_v2f64" } } */
/* { dg-final { scan-assembler "test1_v16i8.*:.*lui.*test1_v16i8" } } */
/* { dg-final { scan-assembler "test1_v8i16.*:.*lui.*test1_v8i16" } } */
/* { dg-final { scan-assembler "test1_v4i32.*:.*lui.*test1_v4i32" } } */
/* { dg-final { scan-assembler "test1_v2i64.*:.*lui.*test1_v2i64" } } */
/* { dg-final { scan-assembler "test1_v16u8.*:.*lui.*test1_v16u8" } } */
/* { dg-final { scan-assembler "test1_v8u16.*:.*lui.*test1_v8u16" } } */
/* { dg-final { scan-assembler "test1_v4u32.*:.*lui.*test1_v4u32" } } */
/* { dg-final { scan-assembler "test1_v2u64.*:.*lui.*test1_v2u64" } } */
/* { dg-final { scan-assembler "test1_v4f32.*:.*lui.*test1_v4f32" } } */
/* { dg-final { scan-assembler "test1_v2f64.*:.*lui.*test1_v2f64" } } */
/* { dg-final { scan-assembler "test2_v16i8.*:.*addb.*test2_v16i8" } } */
/* { dg-final { scan-assembler "test2_v8i16.*:.*addh.*test2_v8i16" } } */
/* { dg-final { scan-assembler "test2_v4i32.*:.*addw.*test2_v4i32" } } */
/* { dg-final { scan-assembler "test2_v2i64.*:.*addd.*test2_v2i64" } } */
/* { dg-final { scan-assembler "test2_v16u8.*:.*addb.*test2_v16u8" } } */
/* { dg-final { scan-assembler "test2_v8u16.*:.*addh.*test2_v8u16" } } */
/* { dg-final { scan-assembler "test2_v4u32.*:.*addw.*test2_v4u32" } } */
/* { dg-final { scan-assembler "test2_v2u64.*:.*addd.*test2_v2u64" } } */
/* { dg-final { scan-assembler "test2_v4f32.*:.*faddw.*test2_v4f32" } } */
/* { dg-final { scan-assembler "test2_v2f64.*:.*faddd.*test2_v2f64" } } */
/* { dg-final { scan-assembler "test3_v16i8.*:.*subb.*test3_v16i8" } } */
/* { dg-final { scan-assembler "test3_v8i16.*:.*subh.*test3_v8i16" } } */
/* { dg-final { scan-assembler "test3_v4i32.*:.*subw.*test3_v4i32" } } */
/* { dg-final { scan-assembler "test3_v2i64.*:.*subd.*test3_v2i64" } } */
/* { dg-final { scan-assembler "test3_v16u8.*:.*subb.*test3_v16u8" } } */
/* { dg-final { scan-assembler "test3_v8u16.*:.*subh.*test3_v8u16" } } */
/* { dg-final { scan-assembler "test3_v4u32.*:.*subw.*test3_v4u32" } } */
/* { dg-final { scan-assembler "test3_v2u64.*:.*subd.*test3_v2u64" } } */
/* { dg-final { scan-assembler "test3_v4f32.*:.*fsubw.*test3_v4f32" } } */
/* { dg-final { scan-assembler "test3_v2f64.*:.*fsubd.*test3_v2f64" } } */
/* { dg-final { scan-assembler "test4_v16i8.*:.*mulb.*test4_v16i8" } } */
/* { dg-final { scan-assembler "test4_v8i16.*:.*mulh.*test4_v8i16" } } */
/* { dg-final { scan-assembler "test4_v4i32.*:.*mulw.*test4_v4i32" } } */
/* { dg-final { scan-assembler "test4_v2i64.*:.*muld.*test4_v2i64" } } */
/* { dg-final { scan-assembler "test4_v16u8.*:.*mulb.*test4_v16u8" } } */
/* { dg-final { scan-assembler "test4_v8u16.*:.*mulh.*test4_v8u16" } } */
/* { dg-final { scan-assembler "test4_v4u32.*:.*mulw.*test4_v4u32" } } */
/* { dg-final { scan-assembler "test4_v2u64.*:.*muld.*test4_v2u64" } } */
/* { dg-final { scan-assembler "test4_v4f32.*:.*fmulw.*test4_v4f32" } } */
/* { dg-final { scan-assembler "test4_v2f64.*:.*fmuld.*test4_v2f64" } } */
/* { dg-final { scan-assembler "test5_v16i8.*:.*divsb.*test5_v16i8" } } */
/* { dg-final { scan-assembler "test5_v8i16.*:.*divsh.*test5_v8i16" } } */
/* { dg-final { scan-assembler "test5_v4i32.*:.*divsw.*test5_v4i32" } } */
/* { dg-final { scan-assembler "test5_v2i64.*:.*divsd.*test5_v2i64" } } */
/* { dg-final { scan-assembler "test5_v16u8.*:.*divub.*test5_v16u8" } } */
/* { dg-final { scan-assembler "test5_v8u16.*:.*divuh.*test5_v8u16" } } */
/* { dg-final { scan-assembler "test5_v4u32.*:.*divuw.*test5_v4u32" } } */
/* { dg-final { scan-assembler "test5_v2u64.*:.*divud.*test5_v2u64" } } */
/* { dg-final { scan-assembler "test5_v4f32.*:.*fdivw.*test5_v4f32" } } */
/* { dg-final { scan-assembler "test5_v2f64.*:.*fdivd.*test5_v2f64" } } */
/* { dg-final { scan-assembler "test6_v16i8.*:.*modsb.*test6_v16i8" } } */
/* { dg-final { scan-assembler "test6_v8i16.*:.*modsh.*test6_v8i16" } } */
/* { dg-final { scan-assembler "test6_v4i32.*:.*modsw.*test6_v4i32" } } */
/* { dg-final { scan-assembler "test6_v2i64.*:.*modsd.*test6_v2i64" } } */
/* { dg-final { scan-assembler "test6_v16u8.*:.*modub.*test6_v16u8" } } */
/* { dg-final { scan-assembler "test6_v8u16.*:.*moduh.*test6_v8u16" } } */
/* { dg-final { scan-assembler "test6_v4u32.*:.*moduw.*test6_v4u32" } } */
/* { dg-final { scan-assembler "test6_v2u64.*:.*modud.*test6_v2u64" } } */
/* { dg-final { scan-assembler "test7_v16i8.*:.*subb.*test7_v16i8" } } */
/* { dg-final { scan-assembler "test7_v8i16.*:.*subh.*test7_v8i16" } } */
/* { dg-final { scan-assembler "test7_v4i32.*:.*subw.*test7_v4i32" } } */
/* { dg-final { scan-assembler "test7_v2i64.*:.*subd.*test7_v2i64" } } */
/* { dg-final { scan-assembler "test7_v16u8.*:.*subb.*test7_v16u8" } } */
/* { dg-final { scan-assembler "test7_v8u16.*:.*subh.*test7_v8u16" } } */
/* { dg-final { scan-assembler "test7_v4u32.*:.*subw.*test7_v4u32" } } */
/* { dg-final { scan-assembler "test7_v2u64.*:.*subd.*test7_v2u64" } } */
/* { dg-final { scan-assembler "test7_v4f32.*:.*fsubw.*test7_v4f32" } } */
/* { dg-final { scan-assembler "test7_v2f64.*:.*fsubd.*test7_v2f64" } } */
/* { dg-final { scan-assembler "test8_v16i8.*:.*xorv.*test8_v16i8" } } */
/* { dg-final { scan-assembler "test8_v8i16.*:.*xorv.*test8_v8i16" } } */
/* { dg-final { scan-assembler "test8_v4i32.*:.*xorv.*test8_v4i32" } } */
/* { dg-final { scan-assembler "test8_v2i64.*:.*xorv.*test8_v2i64" } } */
/* { dg-final { scan-assembler "test8_v16u8.*:.*xorv.*test8_v16u8" } } */
/* { dg-final { scan-assembler "test8_v8u16.*:.*xorv.*test8_v8u16" } } */
/* { dg-final { scan-assembler "test8_v4u32.*:.*xorv.*test8_v4u32" } } */
/* { dg-final { scan-assembler "test8_v2u64.*:.*xorv.*test8_v2u64" } } */
/* { dg-final { scan-assembler "test9_v16i8.*:.*orv.*test9_v16i8" } } */
/* { dg-final { scan-assembler "test9_v8i16.*:.*orv.*test9_v8i16" } } */
/* { dg-final { scan-assembler "test9_v4i32.*:.*orv.*test9_v4i32" } } */
/* { dg-final { scan-assembler "test9_v2i64.*:.*orv.*test9_v2i64" } } */
/* { dg-final { scan-assembler "test9_v16u8.*:.*orv.*test9_v16u8" } } */
/* { dg-final { scan-assembler "test9_v8u16.*:.*orv.*test9_v8u16" } } */
/* { dg-final { scan-assembler "test9_v4u32.*:.*orv.*test9_v4u32" } } */
/* { dg-final { scan-assembler "test10_v16i8.*:.*andv.*test10_v16i8" } } */
/* { dg-final { scan-assembler "test10_v8i16.*:.*andv.*test10_v8i16" } } */
/* { dg-final { scan-assembler "test10_v4i32.*:.*andv.*test10_v4i32" } } */
/* { dg-final { scan-assembler "test10_v2i64.*:.*andv.*test10_v2i64" } } */
/* { dg-final { scan-assembler "test10_v16u8.*:.*andv.*test10_v16u8" } } */
/* { dg-final { scan-assembler "test10_v8u16.*:.*andv.*test10_v8u16" } } */
/* { dg-final { scan-assembler "test10_v4u32.*:.*andv.*test10_v4u32" } } */
/* { dg-final { scan-assembler "test10_v2u64.*:.*andv.*test10_v2u64" } } */
/* { dg-final { scan-assembler "test11_v16i8.*:.*norv.*test11_v16i8" } } */
/* { dg-final { scan-assembler "test11_v8i16.*:.*norv.*test11_v8i16" } } */
/* { dg-final { scan-assembler "test11_v4i32.*:.*norv.*test11_v4i32" } } */
/* { dg-final { scan-assembler "test11_v2i64.*:.*norv.*test11_v2i64" } } */
/* { dg-final { scan-assembler "test11_v16u8.*:.*norv.*test11_v16u8" } } */
/* { dg-final { scan-assembler "test11_v8u16.*:.*norv.*test11_v8u16" } } */
/* { dg-final { scan-assembler "test11_v4u32.*:.*norv.*test11_v4u32" } } */
/* { dg-final { scan-assembler "test11_v2u64.*:.*norv.*test11_v2u64" } } */
/* { dg-final { scan-assembler "test12_v16i8.*:.*srab.*test12_v16i8" } } */
/* { dg-final { scan-assembler "test12_v8i16.*:.*srah.*test12_v8i16" } } */
/* { dg-final { scan-assembler "test12_v4i32.*:.*sraw.*test12_v4i32" } } */
/* { dg-final { scan-assembler "test12_v2i64.*:.*srad.*test12_v2i64" } } */
/* { dg-final { scan-assembler "test12_v16u8.*:.*srlb.*test12_v16u8" } } */
/* { dg-final { scan-assembler "test12_v8u16.*:.*srlh.*test12_v8u16" } } */
/* { dg-final { scan-assembler "test12_v4u32.*:.*srlw.*test12_v4u32" } } */
/* { dg-final { scan-assembler "test12_v2u64.*:.*srld.*test12_v2u64" } } */
/* { dg-final { scan-assembler "test13_v16i8.*:.*sllb.*test13_v16i8" } } */
/* { dg-final { scan-assembler "test13_v8i16.*:.*sllh.*test13_v8i16" } } */
/* { dg-final { scan-assembler "test13_v4i32.*:.*sllw.*test13_v4i32" } } */
/* { dg-final { scan-assembler "test13_v2i64.*:.*slld.*test13_v2i64" } } */
/* { dg-final { scan-assembler "test13_v16u8.*:.*sllb.*test13_v16u8" } } */
/* { dg-final { scan-assembler "test13_v8u16.*:.*sllh.*test13_v8u16" } } */
/* { dg-final { scan-assembler "test13_v4u32.*:.*sllw.*test13_v4u32" } } */
/* { dg-final { scan-assembler "test13_v2u64.*:.*slld.*test13_v2u64" } } */
/* { dg-final { scan-assembler "test14_v16i8.*:.*ceqb.*test14_v16i8" } } */
/* { dg-final { scan-assembler "test14_v8i16.*:.*ceqh.*test14_v8i16" } } */
/* { dg-final { scan-assembler "test14_v4i32.*:.*ceqw.*test14_v4i32" } } */
/* { dg-final { scan-assembler "test14_v2i64.*:.*ceqd.*test14_v2i64" } } */
/* { dg-final { scan-assembler "test14_v16u8.*:.*ceqb.*test14_v16u8" } } */
/* { dg-final { scan-assembler "test14_v8u16.*:.*ceqh.*test14_v8u16" } } */
/* { dg-final { scan-assembler "test14_v4u32.*:.*ceqw.*test14_v4u32" } } */
/* { dg-final { scan-assembler "test14_v2u64.*:.*ceqd.*test14_v2u64" } } */
/* { dg-final { scan-assembler "test14_v4f32.*:.*fceqw.*test14_v4f32" } } */
/* { dg-final { scan-assembler "test14_v2f64.*:.*fceqd.*test14_v2f64" } } */
/* { dg-final { scan-assembler "test15_v16i8.*:.*cneb.*test15_v16i8" } } */
/* { dg-final { scan-assembler "test15_v8i16.*:.*cneh.*test15_v8i16" } } */
/* { dg-final { scan-assembler "test15_v4i32.*:.*cnew.*test15_v4i32" } } */
/* { dg-final { scan-assembler "test15_v2i64.*:.*cned.*test15_v2i64" } } */
/* { dg-final { scan-assembler "test15_v16u8.*:.*cneb.*test15_v16u8" } } */
/* { dg-final { scan-assembler "test15_v8u16.*:.*cneh.*test15_v8u16" } } */
/* { dg-final { scan-assembler "test15_v4u32.*:.*cnew.*test15_v4u32" } } */
/* { dg-final { scan-assembler "test15_v2u64.*:.*cned.*test15_v2u64" } } */
/* { dg-final { scan-assembler "test15_v4f32.*:.*fceqw.*norv.*test15_v4f32" } } */
/* { dg-final { scan-assembler "test15_v2f64.*:.*fceqd.*norv.*test15_v2f64" } } */
/* { dg-final { scan-assembler "test16_v16i8.*:.*cltsb.*test16_v16i8" } } */
/* { dg-final { scan-assembler "test16_v8i16.*:.*cltsh.*test16_v8i16" } } */
/* { dg-final { scan-assembler "test16_v4i32.*:.*cltsw.*test16_v4i32" } } */
/* { dg-final { scan-assembler "test16_v2i64.*:.*cltsd.*test16_v2i64" } } */
/* { dg-final { scan-assembler "test16_v16u8.*:.*cltub.*test16_v16u8" } } */
/* { dg-final { scan-assembler "test16_v8u16.*:.*cltuh.*test16_v8u16" } } */
/* { dg-final { scan-assembler "test16_v4u32.*:.*cltuw.*test16_v4u32" } } */
/* { dg-final { scan-assembler "test16_v2u64.*:.*cltud.*test16_v2u64" } } */
/* { dg-final { scan-assembler "test16_v4f32.*:.*fcltw.*test16_v4f32" } } */
/* { dg-final { scan-assembler "test16_v2f64.*:.*fcltd.*test16_v2f64" } } */
/* { dg-final { scan-assembler "test17_v16i8.*:.*clesb.*test17_v16i8" } } */
/* { dg-final { scan-assembler "test17_v8i16.*:.*clesh.*test17_v8i16" } } */
/* { dg-final { scan-assembler "test17_v4i32.*:.*clesw.*test17_v4i32" } } */
/* { dg-final { scan-assembler "test17_v2i64.*:.*clesd.*test17_v2i64" } } */
/* { dg-final { scan-assembler "test17_v16u8.*:.*cleub.*test17_v16u8" } } */
/* { dg-final { scan-assembler "test17_v8u16.*:.*cleuh.*test17_v8u16" } } */
/* { dg-final { scan-assembler "test17_v4u32.*:.*cleuw.*test17_v4u32" } } */
/* { dg-final { scan-assembler "test17_v2u64.*:.*cleud.*test17_v2u64" } } */
/* { dg-final { scan-assembler "test17_v4f32.*:.*fclew.*test17_v4f32" } } */
/* { dg-final { scan-assembler "test17_v2f64.*:.*fcled.*test17_v2f64" } } */
/* { dg-final { scan-assembler "test18_v16i8.*:.*cltsb.*test18_v16i8" } } */
/* { dg-final { scan-assembler "test18_v8i16.*:.*cltsh.*test18_v8i16" } } */
/* { dg-final { scan-assembler "test18_v4i32.*:.*cltsw.*test18_v4i32" } } */
/* { dg-final { scan-assembler "test18_v2i64.*:.*cltsd.*test18_v2i64" } } */
/* { dg-final { scan-assembler "test18_v16u8.*:.*cltub.*test18_v16u8" } } */
/* { dg-final { scan-assembler "test18_v8u16.*:.*cltuh.*test18_v8u16" } } */
/* { dg-final { scan-assembler "test18_v4u32.*:.*cltuw.*test18_v4u32" } } */
/* { dg-final { scan-assembler "test18_v2u64.*:.*cltud.*test18_v2u64" } } */
/* { dg-final { scan-assembler "test18_v4f32.*:.*fcltw.*test18_v4f32" } } */
/* { dg-final { scan-assembler "test18_v2f64.*:.*fcltd.*test18_v2f64" } } */
/* { dg-final { scan-assembler "test19_v16i8.*:.*clesb.*test19_v16i8" } } */
/* { dg-final { scan-assembler "test19_v8i16.*:.*clesh.*test19_v8i16" } } */
/* { dg-final { scan-assembler "test19_v4i32.*:.*clesw.*test19_v4i32" } } */
/* { dg-final { scan-assembler "test19_v2i64.*:.*clesd.*test19_v2i64" } } */
/* { dg-final { scan-assembler "test19_v16u8.*:.*cleub.*test19_v16u8" } } */
/* { dg-final { scan-assembler "test19_v8u16.*:.*cleuh.*test19_v8u16" } } */
/* { dg-final { scan-assembler "test19_v4u32.*:.*cleuw.*test19_v4u32" } } */
/* { dg-final { scan-assembler "test19_v2u64.*:.*cleud.*test19_v2u64" } } */
/* { dg-final { scan-assembler "test19_v4f32.*:.*fclew.*test19_v4f32" } } */
/* { dg-final { scan-assembler "test19_v2f64.*:.*fcled.*test19_v2f64" } } */
/* { dg-final { scan-assembler "test20_v16i8.*:.*addb.*test20_v16i8" } } */
/* { dg-final { scan-assembler "test20_v8i16.*:.*addh.*test20_v8i16" } } */
/* { dg-final { scan-assembler "test20_v4i32.*:.*addw.*test20_v4i32" } } */
/* { dg-final { scan-assembler "test20_v2i64.*:.*addd.*test20_v2i64" } } */
/* { dg-final { scan-assembler "test20_v16u8.*:.*addb.*test20_v16u8" } } */
/* { dg-final { scan-assembler "test20_v8u16.*:.*addh.*test20_v8u16" } } */
/* { dg-final { scan-assembler "test20_v4u32.*:.*addw.*test20_v4u32" } } */
/* { dg-final { scan-assembler "test20_v2u64.*:.*addd.*test20_v2u64" } } */
/* { dg-final { scan-assembler "test21_v16i8.*:.*subb.*test21_v16i8" } } */
/* { dg-final { scan-assembler "test21_v8i16.*:.*subh.*test21_v8i16" } } */
/* { dg-final { scan-assembler "test21_v4i32.*:.*subw.*test21_v4i32" } } */
/* { dg-final { scan-assembler "test21_v2i64.*:.*subd.*test21_v2i64" } } */
/* { dg-final { scan-assembler "test21_v16u8.*:*lib.*\-31.*addb.*test21_v16u8" } } */
/* { dg-final { scan-assembler "test21_v8u16.*:*lih.*\-31.*addh.*test21_v8u16" } } */
/* { dg-final { scan-assembler "test21_v4u32.*:*liw.*\-31.*addw.*test21_v4u32" } } */
/* { dg-final { scan-assembler "test21_v2u64.*:*lid.*\-31.*addd.*test21_v2u64" } } */

/* { xdg-final { scan-assembler "test22_v16i8.*:.*lib.*mulb.*test22_v16i8" } } */
/* { xdg-final { scan-assembler "test22_v8i16.*:.*lih.*mulh.*test22_v8i16" } } */
/* { xdg-final { scan-assembler "test22_v4i32.*:.*liw.*mulw.*test22_v4i32" } } */
/* { xdg-final { scan-assembler "test22_v2i64.*:.*lid.*muld.*test22_v2i64" } } */
/* { xdg-final { scan-assembler "test22_v16u8.*:.*lib.*mulb.*test22_v16u8" } } */
/* { xdg-final { scan-assembler "test22_v8u16.*:.*lih.*mulh.*test22_v8u16" } } */
/* { xdg-final { scan-assembler "test22_v4u32.*:.*liw.*mulw.*test22_v4u32" } } */
/* { xdg-final { scan-assembler "test22_v2u64.*:.*lid.*muld.*test22_v2u64" } } */

/* { dg-final { scan-assembler "test22_v16i8.*:.*(lib.*mulb|sllib.*addb).*test22_v16i8" } } */
/* { dg-final { scan-assembler "test22_v8i16.*:.*(lih.*mulh|sllih.*addh).*test22_v8i16" } } */
/* { dg-final { scan-assembler "test22_v4i32.*:.*(liw.*mulw|slliw.*addw).*test22_v4i32" } } */
/* { dg-final { scan-assembler "test22_v2i64.*:.*(lid.*muld|sllid.*addd).*test22_v2i64" } } */
/* { dg-final { scan-assembler "test22_v16u8.*:.*(lib.*mulb|sllib.*addb).*test22_v16u8" } } */
/* { dg-final { scan-assembler "test22_v8u16.*:.*(lih.*mulh|sllih.*addh).*test22_v8u16" } } */
/* { dg-final { scan-assembler "test22_v4u32.*:.*(liw.*mulw|slliw.*addw).*test22_v4u32" } } */
/* { dg-final { scan-assembler "test22_v2u64.*:.*(lid.*muld|sllid.*addd).*test22_v2u64" } } */

/* { dg-final { scan-assembler "test23_v16i8.*:.*lib\t\\\$vr\\d+,37.*divsb.*test23_v16i8" } } */
/* { dg-final { scan-assembler "test23_v8i16.*:.*lih\t\\\$vr\\d+,37.*divsh.*test23_v8i16" } } */
/* { dg-final { scan-assembler "test23_v4i32.*:.*liw\t\\\$vr\\d+,37.*divsw.*test23_v4i32" } } */
/* { dg-final { scan-assembler "test23_v2i64.*:.*lid\t\\\$vr\\d+,37.*divsd.*test23_v2i64" } } */
/* { dg-final { scan-assembler "test23_v16u8.*:.*lib\t\\\$vr\\d+,37.*divub.*test23_v16u8" } } */
/* { dg-final { scan-assembler "test23_v8u16.*:.*lih\t\\\$vr\\d+,37.*divuh.*test23_v8u16" } } */
/* { dg-final { scan-assembler "test23_v4u32.*:.*liw\t\\\$vr\\d+,37.*divuw.*test23_v4u32" } } */
/* { dg-final { scan-assembler "test23_v2u64.*:.*lid\t\\\$vr\\d+,37.*divud.*test23_v2u64" } } */
/* { dg-final { scan-assembler "test24_v16i8.*:.*lib\t\\\$vr\\d+,37.*modsb.*test24_v16i8" } } */
/* { dg-final { scan-assembler "test24_v8i16.*:.*lih\t\\\$vr\\d+,37.*modsh.*test24_v8i16" } } */
/* { dg-final { scan-assembler "test24_v4i32.*:.*liw\t\\\$vr\\d+,37.*modsw.*test24_v4i32" } } */
/* { dg-final { scan-assembler "test24_v2i64.*:.*lid\t\\\$vr\\d+,37.*modsd.*test24_v2i64" } } */
/* { dg-final { scan-assembler "test24_v16u8.*:.*lib\t\\\$vr\\d+,37.*modub.*test24_v16u8" } } */
/* { dg-final { scan-assembler "test24_v8u16.*:.*lih\t\\\$vr\\d+,37.*moduh.*test24_v8u16" } } */
/* { dg-final { scan-assembler "test24_v4u32.*:.*liw\t\\\$vr\\d+,37.*moduw.*test24_v4u32" } } */
/* { dg-final { scan-assembler "test24_v2u64.*:.*lid\t\\\$vr\\d+,37.*modud.*test24_v2u64" } } */

/* { dg-final { scan-assembler "test25_v16i8.*:.*xorib.*test25_v16i8" } } */
/* { dg-final { scan-assembler "test25_v8i16.*:.*lih.*xorv.*test25_v8i16" } } */
/* { dg-final { scan-assembler "test25_v4i32.*:.*liw.*xorv.*test25_v4i32" } } */
/* { dg-final { scan-assembler "test25_v2i64.*:.*lid.*xorv.*test25_v2i64" } } */
/* { dg-final { scan-assembler "test25_v16u8.*:.*xorib.*test25_v16u8" } } */
/* { dg-final { scan-assembler "test25_v8u16.*:.*lih.*xorv.*test25_v8u16" } } */
/* { dg-final { scan-assembler "test25_v4u32.*:.*liw.*xorv.*test25_v4u32" } } */
/* { dg-final { scan-assembler "test25_v2u64.*:.*lid.*xorv.*test25_v2u64" } } */
/* { dg-final { scan-assembler "test26_v16i8.*:.*orib.*test26_v16i8" } } */
/* { dg-final { scan-assembler "test26_v8i16.*:.*lih.*orv.*test26_v8i16" } } */
/* { dg-final { scan-assembler "test26_v4i32.*:.*liw.*orv.*test26_v4i32" } } */
/* { dg-final { scan-assembler "test26_v2i64.*:.*lid.*orv.*test26_v2i64" } } */
/* { dg-final { scan-assembler "test26_v16u8.*:.*orib.*test26_v16u8" } } */
/* { dg-final { scan-assembler "test26_v8u16.*:.*lih.*orv.*test26_v8u16" } } */
/* { dg-final { scan-assembler "test26_v4u32.*:.*liw.*orv.*test26_v4u32" } } */
/* { dg-final { scan-assembler "test26_v2u64.*:.*lid.*orv.*test26_v2u64" } } */
/* { dg-final { scan-assembler "test27_v16i8.*:.*andib.*test27_v16i8" } } */
/* { dg-final { scan-assembler "test27_v8i16.*:.*lih.*andv.*test27_v8i16" } } */
/* { dg-final { scan-assembler "test27_v4i32.*:.*liw.*andv.*test27_v4i32" } } */
/* { dg-final { scan-assembler "test27_v2i64.*:.*lid.*andv.*test27_v2i64" } } */
/* { dg-final { scan-assembler "test27_v16u8.*:.*andib.*test27_v16u8" } } */
/* { dg-final { scan-assembler "test27_v8u16.*:.*lih.*andv.*test27_v8u16" } } */
/* { dg-final { scan-assembler "test27_v4u32.*:.*liw.*andv.*test27_v4u32" } } */
/* { dg-final { scan-assembler "test27_v2u64.*:.*lid.*andv.*test27_v2u64" } } */
/* { dg-final { scan-assembler "test28_v16i8.*:.*sraib.*test28_v16i8" } } */
/* { dg-final { scan-assembler "test28_v8i16.*:.*sraih.*test28_v8i16" } } */
/* { dg-final { scan-assembler "test28_v4i32.*:.*sraiw.*test28_v4i32" } } */
/* { dg-final { scan-assembler "test28_v2i64.*:.*sraid.*test28_v2i64" } } */
/* { dg-final { scan-assembler "test28_v16u8.*:.*srlib.*test28_v16u8" } } */
/* { dg-final { scan-assembler "test28_v8u16.*:.*srlih.*test28_v8u16" } } */
/* { dg-final { scan-assembler "test28_v4u32.*:.*srliw.*test28_v4u32" } } */
/* { dg-final { scan-assembler "test28_v2u64.*:.*srlid.*test28_v2u64" } } */
/* { dg-final { scan-assembler "test29_v16i8.*:.*sllib.*test29_v16i8" } } */
/* { dg-final { scan-assembler "test29_v8i16.*:.*sllih.*test29_v8i16" } } */
/* { dg-final { scan-assembler "test29_v4i32.*:.*slliw.*test29_v4i32" } } */
/* { dg-final { scan-assembler "test29_v2i64.*:.*sllid.*test29_v2i64" } } */
/* { dg-final { scan-assembler "test29_v16u8.*:.*sllib.*test29_v16u8" } } */
/* { dg-final { scan-assembler "test29_v8u16.*:.*sllih.*test29_v8u16" } } */
/* { dg-final { scan-assembler "test29_v4u32.*:.*slliw.*test29_v4u32" } } */
/* { dg-final { scan-assembler "test29_v2u64.*:.*sllid.*test29_v2u64" } } */
/* { skip { scan-assembler "test30_v16i8.*:.*cltsb.*test30_v16i8" } } */
/* { skip { scan-assembler "test30_v8i16.*:.*cltsh.*test30_v8i16" } } */
/* { skip { scan-assembler "test30_v4i32.*:.*cltsw.*test30_v4i32" } } */
/* { skip { scan-assembler "test30_v2i64.*:.*cltsd.*test30_v2i64" } } */
/* { skip { scan-assembler "test30_v16u8.*:.*cltub.*test30_v16u8" } } */
/* { skip { scan-assembler "test30_v8u16.*:.*cltuh.*test30_v8u16" } } */
/* { skip { scan-assembler "test30_v4u32.*:.*cltuw.*test30_v4u32" } } */
/* { skip { scan-assembler "test30_v2u64.*:.*cltud.*test30_v2u64" } } */
/* { skip { scan-assembler "test30_v4f32.*:.*fclew.*test30_v4f32" } } */
/* { skip { scan-assembler "test30_v2f64.*:.*fcled.*test30_v2f64" } } */
/* { skip { scan-assembler "test31_s_v16i8.*:.*cltsb.*test31_s_v16i8" } } */
/* { skip { scan-assembler "test31_s_v8i16.*:.*cltsh.*test31_s_v8i16" } } */
/* { skip { scan-assembler "test31_s_v4i32.*:.*cltsw.*test31_s_v4i32" } } */
/* { skip { scan-assembler "test31_s_v2i64.*:.*cltsd.*test31_s_v2i64" } } */
/* { skip { scan-assembler "test31_s_v16u8.*:.*cltub.*test31_s_v16u8" } } */
/* { skip { scan-assembler "test31_s_v8u16.*:.*cltuh.*test31_s_v8u16" } } */
/* { skip { scan-assembler "test31_s_v4u32.*:.*cltuw.*test31_s_v4u32" } } */
/* { skip { scan-assembler "test31_s_v2u64.*:.*cltud.*test31_s_v2u64" } } */
/* { skip { scan-assembler "test31_s_v4f32.*:.*fcltw.*test31_s_v4f32" } } */
/* { skip { scan-assembler "test31_s_v2f64.*:.*fcltd.*test31_s_v2f64" } } */
/* { skip { scan-assembler "test31_u_v16i8.*:.*cltsb.*test31_u_v16i8" } } */
/* { skip { scan-assembler "test31_u_v8i16.*:.*cltsh.*test31_u_v8i16" } } */
/* { skip { scan-assembler "test31_u_v4i32.*:.*cltsw.*test31_u_v4i32" } } */
/* { skip { scan-assembler "test31_u_v2i64.*:.*cltsd.*test31_u_v2i64" } } */
/* { skip { scan-assembler "test31_u_v16u8.*:.*cltub.*test31_u_v16u8" } } */
/* { skip { scan-assembler "test31_u_v8u16.*:.*cltuh.*test31_u_v8u16" } } */
/* { skip { scan-assembler "test31_u_v4u32.*:.*cltuw.*test31_u_v4u32" } } */
/* { skip { scan-assembler "test31_u_v2u64.*:.*cltud.*test31_u_v2u64" } } */
/* { skip { scan-assembler "test31_u_v4f32.*:.*fcltw.*test31_u_v4f32" } } */
/* { skip { scan-assembler "test31_u_v2f64.*:.*fcltd.*test31_u_v2f64" } } */
/* { skip { scan-assembler "test32_s_v16i8.*:.*cltsb.*test32_s_v16i8" } } */
/* { skip { scan-assembler "test32_s_v8i16.*:.*cltsh.*test32_s_v8i16" } } */
/* { skip { scan-assembler "test32_s_v4i32.*:.*cltsw.*test32_s_v4i32" } } */
/* { skip { scan-assembler "test32_s_v2i64.*:.*cltsd.*test32_s_v2i64" } } */
/* { skip { scan-assembler "test32_s_v16u8.*:.*cltub.*test32_s_v16u8" } } */
/* { skip { scan-assembler "test32_s_v8u16.*:.*cltuh.*test32_s_v8u16" } } */
/* { skip { scan-assembler "test32_s_v4u32.*:.*cltuw.*test32_s_v4u32" } } */
/* { skip { scan-assembler "test32_s_v2u64.*:.*cltud.*test32_s_v2u64" } } */
/* { skip { scan-assembler "test32_s_v4f32.*:.*fcltw.*test32_s_v4f32" } } */
/* { skip { scan-assembler "test32_s_v2f64.*:.*fcltd.*test32_s_v2f64" } } */
/* { skip { scan-assembler "test32_u_v16i8.*:.*cltsb.*test32_u_v16i8" } } */
/* { skip { scan-assembler "test32_u_v8i16.*:.*cltsh.*test32_u_v8i16" } } */
/* { skip { scan-assembler "test32_u_v4i32.*:.*cltsw.*test32_u_v4i32" } } */
/* { skip { scan-assembler "test32_u_v2i64.*:.*cltsd.*test32_u_v2i64" } } */
/* { skip { scan-assembler "test32_u_v16u8.*:.*cltub.*test32_u_v16u8" } } */
/* { skip { scan-assembler "test32_u_v8u16.*:.*cltuh.*test32_u_v8u16" } } */
/* { skip { scan-assembler "test32_u_v4u32.*:.*cltuw.*test32_u_v4u32" } } */
/* { skip { scan-assembler "test32_u_v2u64.*:.*cltud.*test32_u_v2u64" } } */
/* { skip { scan-assembler "test32_u_v4f32.*:.*fcltw.*test32_u_v4f32" } } */
/* { skip { scan-assembler "test32_u_v2f64.*:.*fcltd.*test32_u_v2f64" } } */
/* { dg-final { scan-assembler "test33_v4f32.*:.*faddw.*test33_v4f32" } } */
/* { dg-final { scan-assembler "test33_v2f64.*:.*faddd.*test33_v2f64" } } */
/* { dg-final { scan-assembler "test34_v4f32.*:.*fsubw.*test34_v4f32" } } */
/* { dg-final { scan-assembler "test34_v2f64.*:.*fsubd.*test34_v2f64" } } */
/* { dg-final { scan-assembler "test35_v4f32.*:.*fmulw.*test35_v4f32" } } */
/* { dg-final { scan-assembler "test35_v2f64.*:.*fmuld.*test35_v2f64" } } */
/* { dg-final { scan-assembler "test36_v4f32.*:.*fdivw.*test36_v4f32" } } */
/* { dg-final { scan-assembler "test36_v2f64.*:.*fdivd.*test36_v2f64" } } */

/* { xdg-final { scan-assembler "test37_v16i8.*:.*mulb.*addb.*test37_v16i8" } } */
/* { xdg-final { scan-assembler "test37_v8i16.*:.*mulh.*addh.*test37_v8i16" } } */
/* { xdg-final { scan-assembler "test37_v4i32.*:.*mulw.*addw.*test37_v4i32" } } */
/* { xdg-final { scan-assembler "test37_v2i64.*:.*muld.*addd.*test37_v2i64" } } */
/* { xdg-final { scan-assembler "test37_v16u8.*:.*mulb.*addb.*test37_v16u8" } } */
/* { xdg-final { scan-assembler "test37_v8u16.*:.*mulh.*addh.*test37_v8u16" } } */
/* { xdg-final { scan-assembler "test37_v4u32.*:.*mulw.*addw.*test37_v4u32" } } */
/* { xdg-final { scan-assembler "test37_v2u64.*:.*muld.*addd.*test37_v2u64" } } */
/* { xdg-final { scan-assembler "test37_v4f32.*:.*fmulw.*faddw.*test37_v4f32" } } */
/* { xdg-final { scan-assembler "test37_v2f64.*:.*fmuld.*faddd.*test37_v2f64" } } */

/* { dg-final { scan-assembler "test37_v16i8.*:.*maddb.*test37_v16i8"} } */
/* { dg-final { scan-assembler "test37_v8i16.*:.*maddh.*test37_v8i16" } } */
/* { dg-final { scan-assembler "test37_v4i32.*:.*maddw.*test37_v4i32" } } */
/* { dg-final { scan-assembler "test37_v2i64.*:.*maddd.*test37_v2i64" } } */
/* { dg-final { scan-assembler "test37_v16u8.*:.*maddb.*test37_v16u8" } } */
/* { dg-final { scan-assembler "test37_v8u16.*:.*maddh.*test37_v8u16" } } */
/* { dg-final { scan-assembler "test37_v4u32.*:.*maddw.*test37_v4u32" } } */
/* { dg-final { scan-assembler "test37_v2u64.*:.*maddd.*test37_v2u64" } } */
/* { dg-final { scan-assembler "test37_v4f32.*:.*fmaddw.*test37_v4f32" } } */
/* { dg-final { scan-assembler "test37_v2f64.*:.*fmaddd.*test37_v2f64" } } */

/* { dg-final { scan-assembler "test38_v16i8.*:.*msubb.*test38_v16i8"} } */
/* { dg-final { scan-assembler "test38_v8i16.*:.*msubh.*test38_v8i16" } } */
/* { dg-final { scan-assembler "test38_v4i32.*:.*msubw.*test38_v4i32" } } */
/* { dg-final { scan-assembler "test38_v2i64.*:.*msubd.*test38_v2i64" } } */
/* { dg-final { scan-assembler "test38_v16u8.*:.*msubb.*test38_v16u8" } } */
/* { dg-final { scan-assembler "test38_v8u16.*:.*msubh.*test38_v8u16" } } */
/* { dg-final { scan-assembler "test38_v4u32.*:.*msubw.*test38_v4u32" } } */
/* { dg-final { scan-assembler "test38_v2u64.*:.*msubd.*test38_v2u64" } } */
/* { dg-final { scan-assembler "test38_v4f32.*:.*fmsubw.*test38_v4f32" } } */
/* { dg-final { scan-assembler "test38_v2f64.*:.*fmsubd.*test38_v2f64" } } */

/* { xdg-final { scan-assembler "test38_v16i8.*:.*mulb.*subb.*test38_v16i8" } } */
/* { xdg-final { scan-assembler "test38_v8i16.*:.*mulh.*subh.*test38_v8i16" } } */
/* { xdg-final { scan-assembler "test38_v4i32.*:.*mulw.*subw.*test38_v4i32" } } */
/* { xdg-final { scan-assembler "test38_v2i64.*:.*muld.*subd.*test38_v2i64" } } */
/* { xdg-final { scan-assembler "test38_v16u8.*:.*mulb.*subb.*test38_v16u8" } } */
/* { xdg-final { scan-assembler "test38_v8u16.*:.*mulh.*subh.*test38_v8u16" } } */
/* { xdg-final { scan-assembler "test38_v4u32.*:.*mulw.*subw.*test38_v4u32" } } */
/* { xdg-final { scan-assembler "test38_v2u64.*:.*muld.*subd.*test38_v2u64" } } */
/* { xdg-final { scan-assembler "test38_v4f32.*:.*fmulw.*fsubw.*test38_v4f32" } } */
/* { xdg-final { scan-assembler "test38_v2f64.*:.*fmuld.*fsubd.*test38_v2f64" } } */

/* { dg-final { scan-assembler "test39_v16i8.*:.*lu1q.*test39_v16i8" } } */
/* { dg-final { scan-assembler "test39_v8i16.*:.*lu1q.*test39_v8i16" } } */
/* { dg-final { scan-assembler "test39_v4i32.*:.*lu1q.*test39_v4i32" } } */
/* { dg-final { scan-assembler "test39_v2i64.*:.*lu1q.*test39_v2i64" } } */
/* { dg-final { scan-assembler "test40_min_v16i8.*:.*lib.*test40_min_v16i8" } } */
/* { dg-final { scan-assembler "test40_min_v8i16.*:.*lih.*test40_min_v8i16" } } */
/* { dg-final { scan-assembler "test40_min_v4i32.*:.*liw.*test40_min_v4i32" } } */
/* { dg-final { scan-assembler "test40_min_v2i64.*:.*lid.*test40_min_v2i64" } } */
/* { dg-final { scan-assembler "test40_max_v16i8.*:.*lib.*test40_max_v16i8" } } */
/* { dg-final { scan-assembler "test40_max_v8i16.*:.*lih.*test40_max_v8i16" } } */
/* { dg-final { scan-assembler "test40_max_v4i32.*:.*liw.*test40_max_v4i32" } } */
/* { dg-final { scan-assembler "test40_max_v2i64.*:.*lid.*test40_max_v2i64" } } */
/* { dg-final { scan-assembler "test41_v16i8.*:.*mfcpub.*test41_v16i8" } } */
/* { dg-final { scan-assembler "test41_v8i16.*:.*mfcpuh.*test41_v8i16" } } */
/* { dg-final { scan-assembler "test41_v4i32.*:.*mfcpuw.*test41_v4i32" } } */
/* { dg-final { scan-assembler "test41_v2i64.*:.*mfcpuw.*insfcpuw.*insfcpuw.*test41_v2i64" } } */
/* { dg-final { scan-assembler "test42_v16i8.*:.*lib.*insfcpub.*test42_v16i8" } } */
/* { dg-final { scan-assembler "test42_v8i16.*:.*lih.*insfcpuh.*test42_v8i16" } } */
/* { dg-final { scan-assembler "test42_v4i32.*:.*liw.*insfcpuw.*test42_v4i32" } } */
/* { dg-final { scan-assembler "test42_v2i64.*:.*lid.*insfcpuw.*insfcpuw.*test42_v2i64" } } */
/* { dg-final { scan-assembler "test43_v16i8.*:.*lib.*test43_v16i8" } } */
/* { dg-final { scan-assembler "test43_v8i16.*:.*lih.*test43_v8i16" } } */
/* { dg-final { scan-assembler "test43_v4i32.*:.*liw.*test43_v4i32" } } */
/* { dg-final { scan-assembler "test43_v2i64.*:.*lid.*test43_v2i64" } } */
/* { dg-final { scan-assembler "test44_v16i8.*:.*(su1q|mtcpusb).*test44_v16i8" } } */
/* { dg-final { scan-assembler "test44_v8i16.*:.*(su1q|mtcpush).*test44_v8i16" } } */
/* { dg-final { scan-assembler "test44_v4i32.*:.*(su1q|mtcpusw).*test44_v4i32" } } */
/* { dg-final { scan-assembler "test44_v2i64.*:.*(su1q|mtcpusw.*mtcpusw).*test44_v2i64" } } */
/* { dg-final { scan-assembler "test45_v16u8.*:.*(su1q|mtcpuub).*test45_v16u8" } } */
/* { dg-final { scan-assembler "test45_v8u16.*:.*(su1q|mtcpuuh).*test45_v8u16" } } */
/* { dg-final { scan-assembler "test45_v4u32.*:.*(su1q|mtcpuuw|mtcpusw).*test45_v4u32" } } */
/* { dg-final { scan-assembler "test45_v2u64.*:.*\(\(mtcpuuw|mtcpusw\).*\)\{2\}.*test45_v2u64" } } */
/* { dg-final { scan-assembler "test46_v16i8.*:.*su1q.*test46_v16i8" } } */
/* { dg-final { scan-assembler "test46_v8i16.*:.*su1q.*test46_v8i16" } } */
/* { dg-final { scan-assembler "test46_v4i32.*:.*su1q.*test46_v4i32" } } */
/* { dg-final { scan-assembler "test46_v2i64.*:.*su1q.*test46_v2i64" } } */
typedef signed char v16i8 __attribute__ ((vector_size(16)));
typedef short v8i16 __attribute__ ((vector_size(16)));
typedef int v4i32 __attribute__ ((vector_size(16)));
typedef long long v2i64 __attribute__ ((vector_size(16)));
typedef unsigned char v16u8 __attribute__ ((vector_size(16)));
typedef unsigned short v8u16 __attribute__ ((vector_size(16)));
typedef unsigned int v4u32 __attribute__ ((vector_size(16)));
typedef unsigned long long v2u64 __attribute__ ((vector_size(16)));
typedef float v4f32 __attribute__ ((vector_size(16)));
typedef double v2f64 __attribute__ ((vector_size(16)));

float imm_f = 37.0;

#define v16i8_DF b
#define v8i16_DF h
#define v4i32_DF w
#define v2i64_DF d
#define v16u8_DF b
#define v8u16_DF h
#define v4u32_DF w
#define v2u64_DF d

#define v16i8_IN int
#define v8i16_IN int
#define v4i32_IN int
#define v2i64_IN long long
#define v16u8_IN int
#define v8u16_IN int
#define v4u32_IN int
#define v2u64_IN long long

#define v16i8_INITV V16
#define v8i16_INITV V8
#define v4i32_INITV V4
#define v2i64_INITV V2
#define v16u8_INITV V16
#define v8u16_INITV V8
#define v4u32_INITV V4
#define v2u64_INITV V2

#define v16i8_LI_MIN -128
#define v16i8_LI_MAX 127
#define v8i16_LI_MIN -16384
#define v8i16_LI_MAX 16383
#define v4i32_LI_MIN -16384
#define v4i32_LI_MAX 16383
#define v2i64_LI_MIN -16384
#define v2i64_LI_MAX 16383

#define VE2(VALUE) (VALUE), (VALUE)
#define VE4(VALUE) VE2(VALUE), VE2(VALUE)
#define VE8(VALUE) VE4(VALUE), VE4(VALUE)
#define VE16(VALUE) VE8(VALUE), VE8(VALUE)

#define V16(TYPE, VALUE) (TYPE) { VE16(VALUE) }
#define V8(TYPE, VALUE) (TYPE) { VE8(VALUE) }
#define V4(TYPE, VALUE) (TYPE) { VE4(VALUE) }
#define V2(TYPE, VALUE) (TYPE) { VE2(VALUE) }

#define INIT_VECTOR(TYPE, VALUE) TYPE ## _INITV (TYPE, VALUE)
#define DECLARE(TYPE) TYPE TYPE ## _0, TYPE ## _1, TYPE ## _2;
#define RETURN(TYPE) NOMIPS16 TYPE test0_ ## TYPE () { return TYPE ## _0; }
#define ASSIGN(TYPE) NOMIPS16 void test1_ ## TYPE (TYPE i) { TYPE ## _1 = i; }
#define ADD(TYPE) NOMIPS16 TYPE test2_ ## TYPE (TYPE i, TYPE j) { return i + j; }
#define SUB(TYPE) NOMIPS16 TYPE test3_ ## TYPE (TYPE i, TYPE j) { return i - j; }
#define MUL(TYPE) NOMIPS16 TYPE test4_ ## TYPE (TYPE i, TYPE j) { return i * j; }
#define DIV(TYPE) TYPE test5_ ## TYPE (TYPE i, TYPE j) { return i / j; }
#define MOD(TYPE) TYPE test6_ ## TYPE (TYPE i, TYPE j) { return i % j; }
#define MINUS(TYPE) TYPE test7_ ## TYPE (TYPE i) { return -i; }
#define XOR(TYPE) TYPE test8_ ## TYPE (TYPE i, TYPE j) { return i ^ j; }
#define OR(TYPE) TYPE test9_ ## TYPE (TYPE i, TYPE j) { return i | j; }
#define AND(TYPE) TYPE test10_ ## TYPE (TYPE i, TYPE j) { return i & j; }
#define BIT_COMPLEMENT(TYPE) TYPE test11_ ## TYPE (TYPE i) { return ~i; }
#define SHIFT_RIGHT(TYPE) TYPE test12_ ## TYPE (TYPE i, TYPE j) { return i >> j; }
#define SHIFT_LEFT(TYPE) TYPE test13_ ## TYPE (TYPE i, TYPE j) { return i << j; }
#define EQ(TYPE) TYPE test14_ ## TYPE (TYPE i, TYPE j) { return i == j; }
#define NEQ(TYPE) TYPE test15_ ## TYPE (TYPE i, TYPE j) { return i != j; }
#define LT(TYPE) TYPE test16_ ## TYPE (TYPE i, TYPE j) { return i < j; }
#define LEQ(TYPE) TYPE test17_ ## TYPE (TYPE i, TYPE j) { return i <= j; }
#define GT(TYPE) TYPE test18_ ## TYPE (TYPE i, TYPE j) { return i > j; }
#define GEQ(TYPE) TYPE test19_ ## TYPE (TYPE i, TYPE j) { return i >= j; }

#define ADD_I(TYPE) TYPE test20_ ## TYPE (TYPE i) { return i + 31; }
#define SUB_I(TYPE) TYPE test21_ ## TYPE (TYPE i) { return i - 31; }
#define MUL_I(TYPE) TYPE test22_ ## TYPE (TYPE i) { return i * 37; }
#define DIV_I(TYPE) TYPE test23_ ## TYPE (TYPE i) { return i / 37; }
#define MOD_I(TYPE) TYPE test24_ ## TYPE (TYPE i) { return i % 37; }
#define XOR_I(TYPE) TYPE test25_ ## TYPE (TYPE i) { return i ^ 37; }
#define OR_I(TYPE) TYPE test26_ ## TYPE (TYPE i) { return i | 37; }
#define AND_I(TYPE) TYPE test27_ ## TYPE (TYPE i) { return i & 37; }
#define SHIFT_RIGHT_I(TYPE) TYPE test28_ ## TYPE (TYPE i) { return i >> 3; }
#define SHIFT_LEFT_I(TYPE) TYPE test29_ ## TYPE (TYPE i) { return i << 3; }
#define EQ_I(TYPE) TYPE test30_ ## TYPE (TYPE i) { return i == 5; }
#define LT_S_I(TYPE) TYPE test31_s_ ## TYPE (TYPE i) { return i < 5; }
#define LT_U_I(TYPE) TYPE test31_u_ ## TYPE (TYPE i) { return i < (unsigned) 5; }
#define LEQ_S_I(TYPE) TYPE test32_s_ ## TYPE (TYPE i) { return i <= 5; }
#define LEQ_U_I(TYPE) TYPE test32_u_ ## TYPE (TYPE i) { return i <= (unsigned) 5; }

#define ADD_F(TYPE) TYPE test33_ ## TYPE (TYPE i) { return i + imm_f; }
#define SUB_F(TYPE) TYPE test34_ ## TYPE (TYPE i) { return i - imm_f; }
#define MUL_F(TYPE) TYPE test35_ ## TYPE (TYPE i) { return i * imm_f; }
#define DIV_F(TYPE) TYPE test36_ ## TYPE (TYPE i) { return i / imm_f; }

#define MADD(TYPE) TYPE test37_ ## TYPE (TYPE i, TYPE j, TYPE k) { return i * j + k; }
#define MSUB(TYPE) TYPE test38_ ## TYPE (TYPE i, TYPE j, TYPE k) { return k - i * j; }

/* MSA Load/Store and Move instructions */
#define LOAD_V(TYPE) TYPE test39_ ## TYPE (TYPE *i) { return *i; }
#define LOAD_I_MIN(TYPE) TYPE test40_min_ ## TYPE (TYPE *i) { return INIT_VECTOR(TYPE, TYPE ## _LI_MIN); }
#define LOAD_I_MAX(TYPE) TYPE test40_max_ ## TYPE (TYPE *i) { return INIT_VECTOR(TYPE, TYPE ## _LI_MAX); }
#define FILL(TYPE) TYPE test41_ ## TYPE (TYPE ## _IN i) { return INIT_VECTOR(TYPE, i); }
#define INSERT(TYPE) TYPE test42_ ## TYPE (TYPE ## _IN i) { TYPE a = INIT_VECTOR(TYPE, 0); a[1] = i; return a; }
#define INSVE(TYPE) TYPE test43_ ## TYPE (TYPE i) { TYPE a = INIT_VECTOR(TYPE, 0); a[1] = i[0]; return a; }
#define COPY_S(TYPE) TYPE ## _IN test44_ ## TYPE (TYPE i) { return i[1]; }
#define COPY_U(TYPE) TYPE ## _IN test45_ ## TYPE (TYPE i) { return i[1]; }
#define STORE_V(TYPE) void test46_ ## TYPE (TYPE i) { TYPE ## _0 = i; }

#define ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(FUNC) \
  FUNC (v16i8) \
  FUNC (v8i16) \
  FUNC (v4i32) \
  FUNC (v2i64)

#define ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES(FUNC) \
  FUNC (v16u8) \
  FUNC (v8u16) \
  FUNC (v4u32) \
  FUNC (v2u64)

#define ITERATE_FOR_ALL_INT_VECTOR_TYPES(FUNC) \
 ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(FUNC) \
 ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES(FUNC)

#define ITERATE_FOR_ALL_INT_TYPES(FUNC) \
  ITERATE_FOR_ALL_INT_VECTOR_TYPES(FUNC) \

#define ITERATE_FOR_ALL_REAL_VECTOR_TYPES(FUNC) \
  FUNC (v4f32) \
  FUNC (v2f64) \

#define ITERATE_FOR_ALL_REAL_SCALAR_TYPES(FUNC) \
  FUNC (f64) \
  FUNC (f32)

#define ITERATE_FOR_ALL_REAL_TYPES(FUNC) \
  ITERATE_FOR_ALL_REAL_VECTOR_TYPES(FUNC) \

#define ITERATE_FOR_ALL_TYPES(FUNC) \
  ITERATE_FOR_ALL_INT_TYPES(FUNC) \
  ITERATE_FOR_ALL_REAL_TYPES(FUNC)

ITERATE_FOR_ALL_TYPES (DECLARE)
ITERATE_FOR_ALL_TYPES (RETURN)
ITERATE_FOR_ALL_TYPES (ASSIGN)

ITERATE_FOR_ALL_TYPES (ADD)
ITERATE_FOR_ALL_TYPES (SUB)
ITERATE_FOR_ALL_TYPES (MUL)
ITERATE_FOR_ALL_TYPES (DIV)
ITERATE_FOR_ALL_INT_TYPES (MOD)
ITERATE_FOR_ALL_TYPES (MINUS)

ITERATE_FOR_ALL_INT_TYPES (XOR)
ITERATE_FOR_ALL_INT_TYPES (OR)
ITERATE_FOR_ALL_INT_TYPES (AND)
ITERATE_FOR_ALL_INT_TYPES (BIT_COMPLEMENT)
ITERATE_FOR_ALL_INT_TYPES (SHIFT_RIGHT)
ITERATE_FOR_ALL_INT_TYPES (SHIFT_LEFT)

ITERATE_FOR_ALL_TYPES (EQ)
ITERATE_FOR_ALL_TYPES (NEQ)
ITERATE_FOR_ALL_TYPES (LT)
ITERATE_FOR_ALL_TYPES (LEQ)
ITERATE_FOR_ALL_TYPES (GT)
ITERATE_FOR_ALL_TYPES (GEQ)

ITERATE_FOR_ALL_INT_TYPES (ADD_I)
ITERATE_FOR_ALL_INT_TYPES (SUB_I)
ITERATE_FOR_ALL_INT_TYPES (MUL_I)
ITERATE_FOR_ALL_INT_TYPES (DIV_I)

ITERATE_FOR_ALL_INT_TYPES (MOD_I)
ITERATE_FOR_ALL_INT_TYPES (XOR_I)
ITERATE_FOR_ALL_INT_TYPES (OR_I)
ITERATE_FOR_ALL_INT_TYPES (AND_I)
ITERATE_FOR_ALL_INT_TYPES (SHIFT_RIGHT_I)
ITERATE_FOR_ALL_INT_TYPES (SHIFT_LEFT_I)

/*gcc-4.7 can't support the function, gcc-4.9 can support it*/
//ITERATE_FOR_ALL_TYPES (EQ_I)
//ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(LT_S_I)
//ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES(LT_U_I)
//ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(LEQ_S_I)
//ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES(LEQ_U_I)

ITERATE_FOR_ALL_REAL_TYPES (ADD_F)
ITERATE_FOR_ALL_REAL_TYPES (SUB_F)
ITERATE_FOR_ALL_REAL_TYPES (MUL_F)
ITERATE_FOR_ALL_REAL_TYPES (DIV_F)

ITERATE_FOR_ALL_TYPES (MADD)
ITERATE_FOR_ALL_TYPES (MSUB)

/*it achieves the function with too many codes */
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(LOAD_V)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(LOAD_I_MIN)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(LOAD_I_MAX)

ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(FILL)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(INSERT)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(INSVE)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(COPY_S)
ITERATE_FOR_ALL_UNSIGNED_INT_VECTOR_TYPES(COPY_U)
ITERATE_FOR_ALL_SIGNED_INT_VECTOR_TYPES(STORE_V)
