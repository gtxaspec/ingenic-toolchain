#objdump: -dr --prefix-addresses --show-raw-insn -Mmxu2
#name: MXU R2 128 instructions
#as: -32 -mmxu2 --defsym insn_log2=2

.*: +file format .*mips.*

Disassembly of section \.text:
[0-9a-f]+ <[^>]*> 70838028 	bnez16b	\$vr3,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 70847fe8 	bnez16b	\$vr4,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7085fee8 	bnez16b	\$vr5,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7086ffe8 	bnez16b	\$vr6,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MIPS_PC10	external_label
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 71878028 	bnez8h	\$vr7,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 71887fe8 	bnez8h	\$vr8,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7189fee8 	bnez8h	\$vr9,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 718affe8 	bnez8h	\$vr10,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MIPS_PC10	external_label
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 728b8028 	bnez4w	\$vr11,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 728c7fe8 	bnez4w	\$vr12,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 728dfee8 	bnez4w	\$vr13,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 728effe8 	bnez4w	\$vr14,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MIPS_PC10	external_label
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 738f8028 	bnez2d	\$vr15,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 73907fe8 	bnez2d	\$vr16,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7391fee8 	bnez2d	\$vr17,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7392ffe8 	bnez2d	\$vr18,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MIPS_PC10	external_label
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 70938029 	bnez1q	\$vr19,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 70947fe9 	bnez1q	\$vr20,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7095fee9 	bnez1q	\$vr21,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7096ffe9 	bnez1q	\$vr22,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MIPS_PC10	external_label
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 70178028 	beqz16b	\$vr23,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 70187fe8 	beqz16b	\$vr24,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7019fee8 	beqz16b	\$vr25,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 701affe8 	beqz16b	\$vr26,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MIPS_PC10	external_label
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 711b8028 	beqz8h	\$vr27,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 711c7fe8 	beqz8h	\$vr28,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 711dfee8 	beqz8h	\$vr29,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 711effe8 	beqz8h	\$vr30,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MIPS_PC10	external_label
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 721f8028 	beqz4w	\$vr31,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 72007fe8 	beqz4w	\$vr0,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7201fee8 	beqz4w	\$vr1,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7202ffe8 	beqz4w	\$vr2,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MIPS_PC10	external_label
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 73038028 	beqz2d	\$vr3,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 73047fe8 	beqz2d	\$vr4,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7305fee8 	beqz2d	\$vr5,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7306ffe8 	beqz2d	\$vr6,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MIPS_PC10	external_label
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 70078029 	beqz1q	\$vr7,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 70087fe9 	beqz1q	\$vr8,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 7009fee9 	beqz1q	\$vr9,[0-9a-f]+ <[^>]*>
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 700affe9 	beqz1q	\$vr10,[0-9a-f]+ <[^>]*>
[	]*[0-9a-f]+: R_MIPS_PC10	external_label
[0-9a-f]+ <[^>]*> 00000000 	nop
[0-9a-f]+ <[^>]*> 4a020828 	ceqb	\$vr0,\$vr1,\$vr2
[0-9a-f]+ <[^>]*> 4a0520e9 	ceqh	\$vr3,\$vr4,\$vr5
[0-9a-f]+ <[^>]*> 4a0839aa 	ceqw	\$vr6,\$vr7,\$vr8
[0-9a-f]+ <[^>]*> 4a0b526b 	ceqd	\$vr9,\$vr10,\$vr11
[0-9a-f]+ <[^>]*> 4bc0ce00 	ceqzb	\$vr24,\$vr25
[0-9a-f]+ <[^>]*> 4bc0e6c1 	ceqzh	\$vr27,\$vr28
[0-9a-f]+ <[^>]*> 4bc0ff82 	ceqzw	\$vr30,\$vr31
[0-9a-f]+ <[^>]*> 4bc01043 	ceqzd	\$vr1,\$vr2
[0-9a-f]+ <[^>]*> 4a0e6b2c 	cneb	\$vr12,\$vr13,\$vr14
[0-9a-f]+ <[^>]*> 4a1183ed 	cneh	\$vr15,\$vr16,\$vr17
[0-9a-f]+ <[^>]*> 4a149cae 	cnew	\$vr18,\$vr19,\$vr20
[0-9a-f]+ <[^>]*> 4a17b56f 	cned	\$vr21,\$vr22,\$vr23
[0-9a-f]+ <[^>]*> 4bc020c4 	cnezb	\$vr3,\$vr4
[0-9a-f]+ <[^>]*> 4bc03145 	cnezh	\$vr5,\$vr6
[0-9a-f]+ <[^>]*> 4bc041c6 	cnezw	\$vr7,\$vr8
[0-9a-f]+ <[^>]*> 4bc05247 	cnezd	\$vr9,\$vr10
[0-9a-f]+ <[^>]*> 4a0e6b38 	clesb	\$vr12,\$vr13,\$vr14
[0-9a-f]+ <[^>]*> 4a1183f9 	clesh	\$vr15,\$vr16,\$vr17
[0-9a-f]+ <[^>]*> 4a149cba 	clesw	\$vr18,\$vr19,\$vr20
[0-9a-f]+ <[^>]*> 4a17b57b 	clesd	\$vr21,\$vr22,\$vr23
[0-9a-f]+ <[^>]*> 4a1ace3c 	cleub	\$vr24,\$vr25,\$vr26
[0-9a-f]+ <[^>]*> 4a1de6fd 	cleuh	\$vr27,\$vr28,\$vr29
[0-9a-f]+ <[^>]*> 4a00ffbe 	cleuw	\$vr30,\$vr31,\$vr0
[0-9a-f]+ <[^>]*> 4a03107f 	cleud	\$vr1,\$vr2,\$vr3
[0-9a-f]+ <[^>]*> 4bc0ce0c 	clezb	\$vr24,\$vr25
[0-9a-f]+ <[^>]*> 4bc0de8d 	clezh	\$vr26,\$vr27
[0-9a-f]+ <[^>]*> 4bc0ef0e 	clezw	\$vr28,\$vr29
[0-9a-f]+ <[^>]*> 4bc0ff8f 	clezd	\$vr30,\$vr31
[0-9a-f]+ <[^>]*> 4a020830 	cltsb	\$vr0,\$vr1,\$vr2
[0-9a-f]+ <[^>]*> 4a0520f1 	cltsh	\$vr3,\$vr4,\$vr5
[0-9a-f]+ <[^>]*> 4a0839b2 	cltsw	\$vr6,\$vr7,\$vr8
[0-9a-f]+ <[^>]*> 4a0b5273 	cltsd	\$vr9,\$vr10,\$vr11
[0-9a-f]+ <[^>]*> 4a0e6b34 	cltub	\$vr12,\$vr13,\$vr14
[0-9a-f]+ <[^>]*> 4a1183f5 	cltuh	\$vr15,\$vr16,\$vr17
[0-9a-f]+ <[^>]*> 4a149cb6 	cltuw	\$vr18,\$vr19,\$vr20
[0-9a-f]+ <[^>]*> 4a17b577 	cltud	\$vr21,\$vr22,\$vr23
[0-9a-f]+ <[^>]*> 4bc0ce08 	cltzb	\$vr24,\$vr25
[0-9a-f]+ <[^>]*> 4bc0de89 	cltzh	\$vr26,\$vr27
[0-9a-f]+ <[^>]*> 4bc0ef0a 	cltzw	\$vr28,\$vr29
[0-9a-f]+ <[^>]*> 4bc0ff8b 	cltzd	\$vr30,\$vr31
[0-9a-f]+ <[^>]*> 4a220800 	addab	\$vr0,\$vr1,\$vr2
[0-9a-f]+ <[^>]*> 4a2520c1 	addah	\$vr3,\$vr4,\$vr5
[0-9a-f]+ <[^>]*> 4a283982 	addaw	\$vr6,\$vr7,\$vr8
[0-9a-f]+ <[^>]*> 4a2b5243 	addad	\$vr9,\$vr10,\$vr11
[0-9a-f]+ <[^>]*> 4a2e6b08 	addasb	\$vr12,\$vr13,\$vr14
[0-9a-f]+ <[^>]*> 4a3183c9 	addash	\$vr15,\$vr16,\$vr17
[0-9a-f]+ <[^>]*> 4a349c8a 	addasw	\$vr18,\$vr19,\$vr20
[0-9a-f]+ <[^>]*> 4a37b54b 	addasd	\$vr21,\$vr22,\$vr23
[0-9a-f]+ <[^>]*> 4a3ace10 	addssb	\$vr24,\$vr25,\$vr26
[0-9a-f]+ <[^>]*> 4a3de6d1 	addssh	\$vr27,\$vr28,\$vr29
[0-9a-f]+ <[^>]*> 4a20ff92 	addssw	\$vr30,\$vr31,\$vr0
[0-9a-f]+ <[^>]*> 4a231053 	addssd	\$vr1,\$vr2,\$vr3
[0-9a-f]+ <[^>]*> 4a262918 	adduub	\$vr4,\$vr5,\$vr6
[0-9a-f]+ <[^>]*> 4a2941d9 	adduuh	\$vr7,\$vr8,\$vr9
[0-9a-f]+ <[^>]*> 4a2c5a9a 	adduuw	\$vr10,\$vr11,\$vr12
[0-9a-f]+ <[^>]*> 4a2f735b 	adduud	\$vr13,\$vr14,\$vr15
[0-9a-f]+ <[^>]*> 4a328c20 	addb	\$vr16,\$vr17,\$vr18
[0-9a-f]+ <[^>]*> 4a35a4e1 	addh	\$vr19,\$vr20,\$vr21
[0-9a-f]+ <[^>]*> 4a38bda2 	addw	\$vr22,\$vr23,\$vr24
[0-9a-f]+ <[^>]*> 4a3bd663 	addd	\$vr25,\$vr26,\$vr27
[0-9a-f]+ <[^>]*> 4a3eef04 	subsab	\$vr28,\$vr29,\$vr30
[0-9a-f]+ <[^>]*> 4a2107c5 	subsah	\$vr31,\$vr0,\$vr1
[0-9a-f]+ <[^>]*> 4a241886 	subsaw	\$vr2,\$vr3,\$vr4
[0-9a-f]+ <[^>]*> 4a273147 	subsad	\$vr5,\$vr6,\$vr7
[0-9a-f]+ <[^>]*> 4a2a4a0c 	subuab	\$vr8,\$vr9,\$vr10
[0-9a-f]+ <[^>]*> 4a2d62cd 	subuah	\$vr11,\$vr12,\$vr13
[0-9a-f]+ <[^>]*> 4a307b8e 	subuaw	\$vr14,\$vr15,\$vr16
[0-9a-f]+ <[^>]*> 4a33944f 	subuad	\$vr17,\$vr18,\$vr19
[0-9a-f]+ <[^>]*> 4a36ad14 	subssb	\$vr20,\$vr21,\$vr22
[0-9a-f]+ <[^>]*> 4a39c5d5 	subssh	\$vr23,\$vr24,\$vr25
[0-9a-f]+ <[^>]*> 4a3cde96 	subssw	\$vr26,\$vr27,\$vr28
[0-9a-f]+ <[^>]*> 4a3ff757 	subssd	\$vr29,\$vr30,\$vr31
[0-9a-f]+ <[^>]*> 4a22081c 	subuub	\$vr0,\$vr1,\$vr2
[0-9a-f]+ <[^>]*> 4a2520dd 	subuuh	\$vr3,\$vr4,\$vr5
[0-9a-f]+ <[^>]*> 4a28399e 	subuuw	\$vr6,\$vr7,\$vr8
[0-9a-f]+ <[^>]*> 4a2b525f 	subuud	\$vr9,\$vr10,\$vr11
[0-9a-f]+ <[^>]*> 4a2e6b24 	subusb	\$vr12,\$vr13,\$vr14
[0-9a-f]+ <[^>]*> 4a3183e5 	subush	\$vr15,\$vr16,\$vr17
[0-9a-f]+ <[^>]*> 4a349ca6 	subusw	\$vr18,\$vr19,\$vr20
[0-9a-f]+ <[^>]*> 4a37b567 	subusd	\$vr21,\$vr22,\$vr23
[0-9a-f]+ <[^>]*> 4a3ace2c 	subb	\$vr24,\$vr25,\$vr26
[0-9a-f]+ <[^>]*> 4a3de6ed 	subh	\$vr27,\$vr28,\$vr29
[0-9a-f]+ <[^>]*> 4a20ffae 	subw	\$vr30,\$vr31,\$vr0
[0-9a-f]+ <[^>]*> 4a23106f 	subd	\$vr1,\$vr2,\$vr3
[0-9a-f]+ <[^>]*> 4a262930 	avesb	\$vr4,\$vr5,\$vr6
[0-9a-f]+ <[^>]*> 4a2941f1 	avesh	\$vr7,\$vr8,\$vr9
[0-9a-f]+ <[^>]*> 4a2c5ab2 	avesw	\$vr10,\$vr11,\$vr12
[0-9a-f]+ <[^>]*> 4a2f7373 	avesd	\$vr13,\$vr14,\$vr15
[0-9a-f]+ <[^>]*> 4a328c38 	aveub	\$vr16,\$vr17,\$vr18
[0-9a-f]+ <[^>]*> 4a35a4f9 	aveuh	\$vr19,\$vr20,\$vr21
[0-9a-f]+ <[^>]*> 4a38bdba 	aveuw	\$vr22,\$vr23,\$vr24
[0-9a-f]+ <[^>]*> 4a3bd67b 	aveud	\$vr25,\$vr26,\$vr27
[0-9a-f]+ <[^>]*> 4a3eef34 	aversb	\$vr28,\$vr29,\$vr30
[0-9a-f]+ <[^>]*> 4a2107f5 	aversh	\$vr31,\$vr0,\$vr1
[0-9a-f]+ <[^>]*> 4a2418b6 	aversw	\$vr2,\$vr3,\$vr4
[0-9a-f]+ <[^>]*> 4a273177 	aversd	\$vr5,\$vr6,\$vr7
[0-9a-f]+ <[^>]*> 4a2a4a3c 	averub	\$vr8,\$vr9,\$vr10
[0-9a-f]+ <[^>]*> 4a2d62fd 	averuh	\$vr11,\$vr12,\$vr13
[0-9a-f]+ <[^>]*> 4a307bbe 	averuw	\$vr14,\$vr15,\$vr16
[0-9a-f]+ <[^>]*> 4a33947f 	averud	\$vr17,\$vr18,\$vr19
[0-9a-f]+ <[^>]*> 4a56ad00 	divsb	\$vr20,\$vr21,\$vr22
[0-9a-f]+ <[^>]*> 4a59c5c1 	divsh	\$vr23,\$vr24,\$vr25
[0-9a-f]+ <[^>]*> 4a5cde82 	divsw	\$vr26,\$vr27,\$vr28
[0-9a-f]+ <[^>]*> 4a5ff743 	divsd	\$vr29,\$vr30,\$vr31
[0-9a-f]+ <[^>]*> 4a420808 	divub	\$vr0,\$vr1,\$vr2
[0-9a-f]+ <[^>]*> 4a4520c9 	divuh	\$vr3,\$vr4,\$vr5
[0-9a-f]+ <[^>]*> 4a48398a 	divuw	\$vr6,\$vr7,\$vr8
[0-9a-f]+ <[^>]*> 4a4b524b 	divud	\$vr9,\$vr10,\$vr11
[0-9a-f]+ <[^>]*> 4a4e6b10 	modsb	\$vr12,\$vr13,\$vr14
[0-9a-f]+ <[^>]*> 4a5183d1 	modsh	\$vr15,\$vr16,\$vr17
[0-9a-f]+ <[^>]*> 4a549c92 	modsw	\$vr18,\$vr19,\$vr20
[0-9a-f]+ <[^>]*> 4a57b553 	modsd	\$vr21,\$vr22,\$vr23
[0-9a-f]+ <[^>]*> 4a5ace18 	modub	\$vr24,\$vr25,\$vr26
[0-9a-f]+ <[^>]*> 4a5de6d9 	moduh	\$vr27,\$vr28,\$vr29
[0-9a-f]+ <[^>]*> 4a40ff9a 	moduw	\$vr30,\$vr31,\$vr0
[0-9a-f]+ <[^>]*> 4a43105b 	modud	\$vr1,\$vr2,\$vr3
[0-9a-f]+ <[^>]*> 4a46290c 	maddb	\$vr4,\$vr5,\$vr6
[0-9a-f]+ <[^>]*> 4a4941cd 	maddh	\$vr7,\$vr8,\$vr9
[0-9a-f]+ <[^>]*> 4a4c5a8e 	maddw	\$vr10,\$vr11,\$vr12
[0-9a-f]+ <[^>]*> 4a4f734f 	maddd	\$vr13,\$vr14,\$vr15
[0-9a-f]+ <[^>]*> 4a528c14 	msubb	\$vr16,\$vr17,\$vr18
[0-9a-f]+ <[^>]*> 4a55a4d5 	msubh	\$vr19,\$vr20,\$vr21
[0-9a-f]+ <[^>]*> 4a58bd96 	msubw	\$vr22,\$vr23,\$vr24
[0-9a-f]+ <[^>]*> 4a5bd657 	msubd	\$vr25,\$vr26,\$vr27
[0-9a-f]+ <[^>]*> 4a5eef04 	mulb	\$vr28,\$vr29,\$vr30
[0-9a-f]+ <[^>]*> 4a4107c5 	mulh	\$vr31,\$vr0,\$vr1
[0-9a-f]+ <[^>]*> 4a441886 	mulw	\$vr2,\$vr3,\$vr4
[0-9a-f]+ <[^>]*> 4a473147 	muld	\$vr5,\$vr6,\$vr7
[0-9a-f]+ <[^>]*> 4a0a4a00 	maxab	\$vr8,\$vr9,\$vr10
[0-9a-f]+ <[^>]*> 4a0d62c1 	maxah	\$vr11,\$vr12,\$vr13
[0-9a-f]+ <[^>]*> 4a107b82 	maxaw	\$vr14,\$vr15,\$vr16
[0-9a-f]+ <[^>]*> 4a139443 	maxad	\$vr17,\$vr18,\$vr19
[0-9a-f]+ <[^>]*> 4a16ad08 	maxsb	\$vr20,\$vr21,\$vr22
[0-9a-f]+ <[^>]*> 4a19c5c9 	maxsh	\$vr23,\$vr24,\$vr25
[0-9a-f]+ <[^>]*> 4a1cde8a 	maxsw	\$vr26,\$vr27,\$vr28
[0-9a-f]+ <[^>]*> 4a1ff74b 	maxsd	\$vr29,\$vr30,\$vr31
[0-9a-f]+ <[^>]*> 4a020810 	maxub	\$vr0,\$vr1,\$vr2
[0-9a-f]+ <[^>]*> 4a0520d1 	maxuh	\$vr3,\$vr4,\$vr5
[0-9a-f]+ <[^>]*> 4a083992 	maxuw	\$vr6,\$vr7,\$vr8
[0-9a-f]+ <[^>]*> 4a0b5253 	maxud	\$vr9,\$vr10,\$vr11
[0-9a-f]+ <[^>]*> 4a0e6b04 	minab	\$vr12,\$vr13,\$vr14
[0-9a-f]+ <[^>]*> 4a1183c5 	minah	\$vr15,\$vr16,\$vr17
[0-9a-f]+ <[^>]*> 4a149c86 	minaw	\$vr18,\$vr19,\$vr20
[0-9a-f]+ <[^>]*> 4a17b547 	minad	\$vr21,\$vr22,\$vr23
[0-9a-f]+ <[^>]*> 4a1ace0c 	minsb	\$vr24,\$vr25,\$vr26
[0-9a-f]+ <[^>]*> 4a1de6cd 	minsh	\$vr27,\$vr28,\$vr29
[0-9a-f]+ <[^>]*> 4a00ff8e 	minsw	\$vr30,\$vr31,\$vr0
[0-9a-f]+ <[^>]*> 4a03104f 	minsd	\$vr1,\$vr2,\$vr3
[0-9a-f]+ <[^>]*> 4a062914 	minub	\$vr4,\$vr5,\$vr6
[0-9a-f]+ <[^>]*> 4a0941d5 	minuh	\$vr7,\$vr8,\$vr9
[0-9a-f]+ <[^>]*> 4a0c5a96 	minuw	\$vr10,\$vr11,\$vr12
[0-9a-f]+ <[^>]*> 4a0f7357 	minud	\$vr13,\$vr14,\$vr15
[0-9a-f]+ <[^>]*> 4a528c21 	dotpsh	\$vr16,\$vr17,\$vr18
[0-9a-f]+ <[^>]*> 4a55a4e2 	dotpsw	\$vr19,\$vr20,\$vr21
[0-9a-f]+ <[^>]*> 4a58bda3 	dotpsd	\$vr22,\$vr23,\$vr24
[0-9a-f]+ <[^>]*> 4a5bd669 	dotpuh	\$vr25,\$vr26,\$vr27
[0-9a-f]+ <[^>]*> 4a5eef2a 	dotpuw	\$vr28,\$vr29,\$vr30
[0-9a-f]+ <[^>]*> 4a4107eb 	dotpud	\$vr31,\$vr0,\$vr1
[0-9a-f]+ <[^>]*> 4a4418a5 	daddsh	\$vr2,\$vr3,\$vr4
[0-9a-f]+ <[^>]*> 4a473166 	daddsw	\$vr5,\$vr6,\$vr7
[0-9a-f]+ <[^>]*> 4a4a4a27 	daddsd	\$vr8,\$vr9,\$vr10
[0-9a-f]+ <[^>]*> 4a4d62ed 	dadduh	\$vr11,\$vr12,\$vr13
[0-9a-f]+ <[^>]*> 4a507bae 	dadduw	\$vr14,\$vr15,\$vr16
[0-9a-f]+ <[^>]*> 4a53946f 	daddud	\$vr17,\$vr18,\$vr19
[0-9a-f]+ <[^>]*> 4a56ad35 	dsubsh	\$vr20,\$vr21,\$vr22
[0-9a-f]+ <[^>]*> 4a59c5f6 	dsubsw	\$vr23,\$vr24,\$vr25
[0-9a-f]+ <[^>]*> 4a5cdeb7 	dsubsd	\$vr26,\$vr27,\$vr28
[0-9a-f]+ <[^>]*> 4a5ff77d 	dsubuh	\$vr29,\$vr30,\$vr31
[0-9a-f]+ <[^>]*> 4a42083e 	dsubuw	\$vr0,\$vr1,\$vr2
[0-9a-f]+ <[^>]*> 4a4520ff 	dsubud	\$vr3,\$vr4,\$vr5
[0-9a-f]+ <[^>]*> 4bc03990 	locb	\$vr6,\$vr7
[0-9a-f]+ <[^>]*> 4bc04a11 	loch	\$vr8,\$vr9
[0-9a-f]+ <[^>]*> 4bc05a92 	locw	\$vr10,\$vr11
[0-9a-f]+ <[^>]*> 4bc06b13 	locd	\$vr12,\$vr13
[0-9a-f]+ <[^>]*> 4bc07b94 	lzcb	\$vr14,\$vr15
[0-9a-f]+ <[^>]*> 4bc08c15 	lzch	\$vr16,\$vr17
[0-9a-f]+ <[^>]*> 4bc09c96 	lzcw	\$vr18,\$vr19
[0-9a-f]+ <[^>]*> 4bc0ad17 	lzcd	\$vr20,\$vr21
[0-9a-f]+ <[^>]*> 4bc07bb0 	bcntb	\$vr14,\$vr15
[0-9a-f]+ <[^>]*> 4bc06b31 	bcnth	\$vr12,\$vr13
[0-9a-f]+ <[^>]*> 4bc05ab2 	bcntw	\$vr10,\$vr11
[0-9a-f]+ <[^>]*> 4bc04a33 	bcntd	\$vr8,\$vr9
[0-9a-f]+ <[^>]*> 700039b8 	satsb	\$vr6,\$vr7,0
[0-9a-f]+ <[^>]*> 703f2938 	satsb	\$vr4,\$vr5,63
[0-9a-f]+ <[^>]*> 710018b8 	satsh	\$vr2,\$vr3,0
[0-9a-f]+ <[^>]*> 713f0838 	satsh	\$vr0,\$vr1,63
[0-9a-f]+ <[^>]*> 7200ffb8 	satsw	\$vr30,\$vr31,0
[0-9a-f]+ <[^>]*> 723fef38 	satsw	\$vr28,\$vr29,63
[0-9a-f]+ <[^>]*> 7300deb8 	satsd	\$vr26,\$vr27,0
[0-9a-f]+ <[^>]*> 733fce38 	satsd	\$vr24,\$vr25,63
[0-9a-f]+ <[^>]*> 7040bdb8 	satub	\$vr22,\$vr23,0
[0-9a-f]+ <[^>]*> 707fad38 	satub	\$vr20,\$vr21,63
[0-9a-f]+ <[^>]*> 71409cb8 	satuh	\$vr18,\$vr19,0
[0-9a-f]+ <[^>]*> 717f8c38 	satuh	\$vr16,\$vr17,63
[0-9a-f]+ <[^>]*> 72407bb8 	satuw	\$vr14,\$vr15,0
[0-9a-f]+ <[^>]*> 727f6b38 	satuw	\$vr12,\$vr13,63
[0-9a-f]+ <[^>]*> 73405ab8 	satud	\$vr10,\$vr11,0
[0-9a-f]+ <[^>]*> 737f4a38 	satud	\$vr8,\$vr9,63
[0-9a-f]+ <[^>]*> 4ac73178 	andv	\$vr5,\$vr6,\$vr7
[0-9a-f]+ <[^>]*> 700020f0 	andib	\$vr3,\$vr4,0
[0-9a-f]+ <[^>]*> 70ff1070 	andib	\$vr1,\$vr2,255
[0-9a-f]+ <[^>]*> 701ff759 	bselv	\$vr29,\$vr30,\$vr31,\$vr0
[0-9a-f]+ <[^>]*> 4adcdeb9 	norv	\$vr26,\$vr27,\$vr28
[0-9a-f]+ <[^>]*> 7100ce30 	norib	\$vr24,\$vr25,0
[0-9a-f]+ <[^>]*> 71ffbdb0 	norib	\$vr22,\$vr23,255
[0-9a-f]+ <[^>]*> 4ad5a4fa 	orv	\$vr19,\$vr20,\$vr21
[0-9a-f]+ <[^>]*> 72009470 	orib	\$vr17,\$vr18,0
[0-9a-f]+ <[^>]*> 72ff83f0 	orib	\$vr15,\$vr16,255
[0-9a-f]+ <[^>]*> 4ace6b3b 	xorv	\$vr12,\$vr13,\$vr14
[0-9a-f]+ <[^>]*> 73005ab0 	xorib	\$vr10,\$vr11,0
[0-9a-f]+ <[^>]*> 73ff4a30 	xorib	\$vr8,\$vr9,255
[0-9a-f]+ <[^>]*> 4b073140 	faddw	\$vr5,\$vr6,\$vr7
[0-9a-f]+ <[^>]*> 4b041881 	faddd	\$vr2,\$vr3,\$vr4
[0-9a-f]+ <[^>]*> 4b0107c2 	fsubw	\$vr31,\$vr0,\$vr1
[0-9a-f]+ <[^>]*> 4b1eef03 	fsubd	\$vr28,\$vr29,\$vr30
[0-9a-f]+ <[^>]*> 4b1bd644 	fmulw	\$vr25,\$vr26,\$vr27
[0-9a-f]+ <[^>]*> 4b18bd85 	fmuld	\$vr22,\$vr23,\$vr24
[0-9a-f]+ <[^>]*> 4b15a4c6 	fdivw	\$vr19,\$vr20,\$vr21
[0-9a-f]+ <[^>]*> 4b128c07 	fdivd	\$vr16,\$vr17,\$vr18
[0-9a-f]+ <[^>]*> 4bc17b80 	fsqrtw	\$vr14,\$vr15
[0-9a-f]+ <[^>]*> 4bc16b01 	fsqrtd	\$vr12,\$vr13
[0-9a-f]+ <[^>]*> 4b0b5248 	fmaddw	\$vr9,\$vr10,\$vr11
[0-9a-f]+ <[^>]*> 4b083989 	fmaddd	\$vr6,\$vr7,\$vr8
[0-9a-f]+ <[^>]*> 4b0520ca 	fmsubw	\$vr3,\$vr4,\$vr5
[0-9a-f]+ <[^>]*> 4b02080b 	fmsubd	\$vr0,\$vr1,\$vr2
[0-9a-f]+ <[^>]*> 4b1ff758 	fmaxw	\$vr29,\$vr30,\$vr31
[0-9a-f]+ <[^>]*> 4b1cde99 	fmaxd	\$vr26,\$vr27,\$vr28
[0-9a-f]+ <[^>]*> 4b19c5da 	fmaxaw	\$vr23,\$vr24,\$vr25
[0-9a-f]+ <[^>]*> 4b16ad1b 	fmaxad	\$vr20,\$vr21,\$vr22
[0-9a-f]+ <[^>]*> 4b13945c 	fminw	\$vr17,\$vr18,\$vr19
[0-9a-f]+ <[^>]*> 4b107b9d 	fmind	\$vr14,\$vr15,\$vr16
[0-9a-f]+ <[^>]*> 4b0d62de 	fminaw	\$vr11,\$vr12,\$vr13
[0-9a-f]+ <[^>]*> 4b0a4a1f 	fminad	\$vr8,\$vr9,\$vr10
[0-9a-f]+ <[^>]*> 4bc13986 	fclassw	\$vr6,\$vr7
[0-9a-f]+ <[^>]*> 4bc12907 	fclassd	\$vr4,\$vr5
[0-9a-f]+ <[^>]*> 4b031052 	fceqw	\$vr1,\$vr2,\$vr3
[0-9a-f]+ <[^>]*> 4b00ff93 	fceqd	\$vr30,\$vr31,\$vr0
[0-9a-f]+ <[^>]*> 4b1de6d6 	fclew	\$vr27,\$vr28,\$vr29
[0-9a-f]+ <[^>]*> 4b1ace17 	fcled	\$vr24,\$vr25,\$vr26
[0-9a-f]+ <[^>]*> 4b17b554 	fcltw	\$vr21,\$vr22,\$vr23
[0-9a-f]+ <[^>]*> 4b149c95 	fcltd	\$vr18,\$vr19,\$vr20
[0-9a-f]+ <[^>]*> 4b1183d0 	fcorw	\$vr15,\$vr16,\$vr17
[0-9a-f]+ <[^>]*> 4b0e6b11 	fcord	\$vr12,\$vr13,\$vr14
[0-9a-f]+ <[^>]*> 4b0b524c 	vcvths	\$vr9,\$vr10,\$vr11
[0-9a-f]+ <[^>]*> 4b08398d 	vcvtsd	\$vr6,\$vr7,\$vr8
[0-9a-f]+ <[^>]*> 4bc12920 	vcvtesh	\$vr4,\$vr5
[0-9a-f]+ <[^>]*> 4bc118a1 	vcvteds	\$vr2,\$vr3
[0-9a-f]+ <[^>]*> 4bc10828 	vcvtosh	\$vr0,\$vr1
[0-9a-f]+ <[^>]*> 4bc1ffa9 	vcvtods	\$vr30,\$vr31
[0-9a-f]+ <[^>]*> 4bc1ef08 	vcvtssw	\$vr28,\$vr29
[0-9a-f]+ <[^>]*> 4bc1de89 	vcvtsdl	\$vr26,\$vr27
[0-9a-f]+ <[^>]*> 4bc1ce0a 	vcvtusw	\$vr24,\$vr25
[0-9a-f]+ <[^>]*> 4bc1bd8b 	vcvtudl	\$vr22,\$vr23
[0-9a-f]+ <[^>]*> 4bc1ad1c 	vcvtrws	\$vr20,\$vr21
[0-9a-f]+ <[^>]*> 4bc19c9d 	vcvtrld	\$vr18,\$vr19
[0-9a-f]+ <[^>]*> 4bc18c0c 	vcvtsws	\$vr16,\$vr17
[0-9a-f]+ <[^>]*> 4bc17b8d 	vcvtsld	\$vr14,\$vr15
[0-9a-f]+ <[^>]*> 4bc16b0e 	vcvtuws	\$vr12,\$vr13
[0-9a-f]+ <[^>]*> 4bc15a8f 	vcvtuld	\$vr10,\$vr11
[0-9a-f]+ <[^>]*> 4bc14a14 	vtruncsws	\$vr8,\$vr9
[0-9a-f]+ <[^>]*> 4bc13995 	vtruncsld	\$vr6,\$vr7
[0-9a-f]+ <[^>]*> 4bc12916 	vtruncuws	\$vr4,\$vr5
[0-9a-f]+ <[^>]*> 4bc11897 	vtrunculd	\$vr2,\$vr3
[0-9a-f]+ <[^>]*> 4bc10830 	vcvtqesh	\$vr0,\$vr1
[0-9a-f]+ <[^>]*> 4bc1ffb1 	vcvtqedw	\$vr30,\$vr31
[0-9a-f]+ <[^>]*> 4bc1ef38 	vcvtqosh	\$vr28,\$vr29
[0-9a-f]+ <[^>]*> 4bc1deb9 	vcvtqodw	\$vr26,\$vr27
[0-9a-f]+ <[^>]*> 4b19c5ce 	vcvtqhs	\$vr23,\$vr24,\$vr25
[0-9a-f]+ <[^>]*> 4b19c5cf 	vcvtqwd	\$vr23,\$vr24,\$vr25
[0-9a-f]+ <[^>]*> 4b16ad30 	maddqh	\$vr20,\$vr21,\$vr22
[0-9a-f]+ <[^>]*> 4b139471 	maddqw	\$vr17,\$vr18,\$vr19
[0-9a-f]+ <[^>]*> 4b107bb2 	maddqrh	\$vr14,\$vr15,\$vr16
[0-9a-f]+ <[^>]*> 4b0d62f3 	maddqrw	\$vr11,\$vr12,\$vr13
[0-9a-f]+ <[^>]*> 4b0a4a34 	msubqh	\$vr8,\$vr9,\$vr10
[0-9a-f]+ <[^>]*> 4b073175 	msubqw	\$vr5,\$vr6,\$vr7
[0-9a-f]+ <[^>]*> 4b0418b6 	msubqrh	\$vr2,\$vr3,\$vr4
[0-9a-f]+ <[^>]*> 4b0107f7 	msubqrw	\$vr31,\$vr0,\$vr1
[0-9a-f]+ <[^>]*> 4b1eef28 	mulqh	\$vr28,\$vr29,\$vr30
[0-9a-f]+ <[^>]*> 4b1bd669 	mulqw	\$vr25,\$vr26,\$vr27
[0-9a-f]+ <[^>]*> 4b18bdaa 	mulqrh	\$vr22,\$vr23,\$vr24
[0-9a-f]+ <[^>]*> 4b15a4eb 	mulqrw	\$vr19,\$vr20,\$vr21
[0-9a-f]+ <[^>]*> 4a328c28 	sllb	\$vr16,\$vr17,\$vr18
[0-9a-f]+ <[^>]*> 4a2f7369 	sllh	\$vr13,\$vr14,\$vr15
[0-9a-f]+ <[^>]*> 4a2c5aaa 	sllw	\$vr10,\$vr11,\$vr12
[0-9a-f]+ <[^>]*> 4a2941eb 	slld	\$vr7,\$vr8,\$vr9
[0-9a-f]+ <[^>]*> 70803178 	sllib	\$vr5,\$vr6,0
[0-9a-f]+ <[^>]*> 70bf20f8 	sllib	\$vr3,\$vr4,63
[0-9a-f]+ <[^>]*> 71801078 	sllih	\$vr1,\$vr2,0
[0-9a-f]+ <[^>]*> 71bf07f8 	sllih	\$vr31,\$vr0,63
[0-9a-f]+ <[^>]*> 7280f778 	slliw	\$vr29,\$vr30,0
[0-9a-f]+ <[^>]*> 72bfe6f8 	slliw	\$vr27,\$vr28,63
[0-9a-f]+ <[^>]*> 7380d678 	sllid	\$vr25,\$vr26,0
[0-9a-f]+ <[^>]*> 73bfc5f8 	sllid	\$vr23,\$vr24,63
[0-9a-f]+ <[^>]*> 4a16ad18 	srab	\$vr20,\$vr21,\$vr22
[0-9a-f]+ <[^>]*> 4a139459 	srah	\$vr17,\$vr18,\$vr19
[0-9a-f]+ <[^>]*> 4a107b9a 	sraw	\$vr14,\$vr15,\$vr16
[0-9a-f]+ <[^>]*> 4a0d62db 	srad	\$vr11,\$vr12,\$vr13
[0-9a-f]+ <[^>]*> 70005279 	sraib	\$vr9,\$vr10,0
[0-9a-f]+ <[^>]*> 703f41f9 	sraib	\$vr7,\$vr8,63
[0-9a-f]+ <[^>]*> 71003179 	sraih	\$vr5,\$vr6,0
[0-9a-f]+ <[^>]*> 713f20f9 	sraih	\$vr3,\$vr4,63
[0-9a-f]+ <[^>]*> 72001079 	sraiw	\$vr1,\$vr2,0
[0-9a-f]+ <[^>]*> 723f07f9 	sraiw	\$vr31,\$vr0,63
[0-9a-f]+ <[^>]*> 7300f779 	sraid	\$vr29,\$vr30,0
[0-9a-f]+ <[^>]*> 733fe6f9 	sraid	\$vr27,\$vr28,63
[0-9a-f]+ <[^>]*> 4a1ace20 	srarb	\$vr24,\$vr25,\$vr26
[0-9a-f]+ <[^>]*> 4a17b561 	srarh	\$vr21,\$vr22,\$vr23
[0-9a-f]+ <[^>]*> 4a149ca2 	srarw	\$vr18,\$vr19,\$vr20
[0-9a-f]+ <[^>]*> 4a1183e3 	srard	\$vr15,\$vr16,\$vr17
[0-9a-f]+ <[^>]*> 70407379 	srarib	\$vr13,\$vr14,0
[0-9a-f]+ <[^>]*> 707f62f9 	srarib	\$vr11,\$vr12,63
[0-9a-f]+ <[^>]*> 71405279 	srarih	\$vr9,\$vr10,0
[0-9a-f]+ <[^>]*> 717f41f9 	srarih	\$vr7,\$vr8,63
[0-9a-f]+ <[^>]*> 72403179 	srariw	\$vr5,\$vr6,0
[0-9a-f]+ <[^>]*> 727f20f9 	srariw	\$vr3,\$vr4,63
[0-9a-f]+ <[^>]*> 73401079 	srarid	\$vr1,\$vr2,0
[0-9a-f]+ <[^>]*> 737f07f9 	srarid	\$vr31,\$vr0,63
[0-9a-f]+ <[^>]*> 4a1eef1c 	srlb	\$vr28,\$vr29,\$vr30
[0-9a-f]+ <[^>]*> 4a1bd65d 	srlh	\$vr25,\$vr26,\$vr27
[0-9a-f]+ <[^>]*> 4a18bd9e 	srlw	\$vr22,\$vr23,\$vr24
[0-9a-f]+ <[^>]*> 4a15a4df 	srld	\$vr19,\$vr20,\$vr21
[0-9a-f]+ <[^>]*> 70809479 	srlib	\$vr17,\$vr18,0
[0-9a-f]+ <[^>]*> 70bf83f9 	srlib	\$vr15,\$vr16,63
[0-9a-f]+ <[^>]*> 71807379 	srlih	\$vr13,\$vr14,0
[0-9a-f]+ <[^>]*> 71bf62f9 	srlih	\$vr11,\$vr12,63
[0-9a-f]+ <[^>]*> 72805279 	srliw	\$vr9,\$vr10,0
[0-9a-f]+ <[^>]*> 72bf41f9 	srliw	\$vr7,\$vr8,63
[0-9a-f]+ <[^>]*> 73803179 	srlid	\$vr5,\$vr6,0
[0-9a-f]+ <[^>]*> 73bf20f9 	srlid	\$vr3,\$vr4,63
[0-9a-f]+ <[^>]*> 4a020824 	srlrb	\$vr0,\$vr1,\$vr2
[0-9a-f]+ <[^>]*> 4a1ff765 	srlrh	\$vr29,\$vr30,\$vr31
[0-9a-f]+ <[^>]*> 4a1cdea6 	srlrw	\$vr26,\$vr27,\$vr28
[0-9a-f]+ <[^>]*> 4a19c5e7 	srlrd	\$vr23,\$vr24,\$vr25
[0-9a-f]+ <[^>]*> 70c0b579 	srlrib	\$vr21,\$vr22,0
[0-9a-f]+ <[^>]*> 70ffa4f9 	srlrib	\$vr19,\$vr20,63
[0-9a-f]+ <[^>]*> 71c09479 	srlrih	\$vr17,\$vr18,0
[0-9a-f]+ <[^>]*> 71ff83f9 	srlrih	\$vr15,\$vr16,63
[0-9a-f]+ <[^>]*> 72c07379 	srlriw	\$vr13,\$vr14,0
[0-9a-f]+ <[^>]*> 72ff62f9 	srlriw	\$vr11,\$vr12,63
[0-9a-f]+ <[^>]*> 73c05279 	srlrid	\$vr9,\$vr10,0
[0-9a-f]+ <[^>]*> 73ff41f9 	srlrid	\$vr7,\$vr8,63
[0-9a-f]+ <[^>]*> 700079b1 	insfcpub	\$vr6\[0\],t7
[0-9a-f]+ <[^>]*> 701f7171 	insfcpub	\$vr5\[31\],t6
[0-9a-f]+ <[^>]*> 70ff7171 	insfcpub	\$vr5\[255\],t6
[0-9a-f]+ <[^>]*> 71006931 	insfcpuh	\$vr4\[0\],t5
[0-9a-f]+ <[^>]*> 711f60f1 	insfcpuh	\$vr3\[31\],t4
[0-9a-f]+ <[^>]*> 71ff60f1 	insfcpuh	\$vr3\[255\],t4
[0-9a-f]+ <[^>]*> 720058b1 	insfcpuw	\$vr2\[0\],t3
[0-9a-f]+ <[^>]*> 721f5071 	insfcpuw	\$vr1\[31\],t2
[0-9a-f]+ <[^>]*> 72ff5071 	insfcpuw	\$vr1\[255\],t2
[0-9a-f]+ <[^>]*> 4be04800 	insffpuw	\$vr0\[0\],\$f9
[0-9a-f]+ <[^>]*> 4bff47c0 	insffpuw	\$vr31\[31\],\$f8
[0-9a-f]+ <[^>]*> 4be03f81 	insffpud	\$vr30\[0\],\$f7
[0-9a-f]+ <[^>]*> 4bff3741 	insffpud	\$vr29\[31\],\$f6
[0-9a-f]+ <[^>]*> 70ffe6f2 	insfmxub	\$vr27\[255\],\$vr28\[0\]
[0-9a-f]+ <[^>]*> 701fe6f2 	insfmxub	\$vr27\[31\],\$vr28\[0\]
[0-9a-f]+ <[^>]*> 7000d672 	insfmxub	\$vr25\[0\],\$vr26\[0\]
[0-9a-f]+ <[^>]*> 71ffc5f2 	insfmxuh	\$vr23\[255\],\$vr24\[0\]
[0-9a-f]+ <[^>]*> 711fc5f2 	insfmxuh	\$vr23\[31\],\$vr24\[0\]
[0-9a-f]+ <[^>]*> 7100b572 	insfmxuh	\$vr21\[0\],\$vr22\[0\]
[0-9a-f]+ <[^>]*> 72ffa4f2 	insfmxuw	\$vr19\[255\],\$vr20\[0\]
[0-9a-f]+ <[^>]*> 721fa4f2 	insfmxuw	\$vr19\[31\],\$vr20\[0\]
[0-9a-f]+ <[^>]*> 72009472 	insfmxuw	\$vr17\[0\],\$vr18\[0\]
[0-9a-f]+ <[^>]*> 73ff83f2 	insfmxud	\$vr15\[255\],\$vr16\[0\]
[0-9a-f]+ <[^>]*> 731f83f2 	insfmxud	\$vr15\[31\],\$vr16\[0\]
[0-9a-f]+ <[^>]*> 73007372 	insfmxud	\$vr13\[0\],\$vr14\[0\]
[0-9a-f]+ <[^>]*> 4a5c62dc 	repxb	\$vr11,\$vr12\[gp\]
[0-9a-f]+ <[^>]*> 4a5b525d 	repxh	\$vr9,\$vr10\[k1\]
[0-9a-f]+ <[^>]*> 4a5a399e 	repxw	\$vr6,\$vr7\[k0\]
[0-9a-f]+ <[^>]*> 4a59291f 	repxd	\$vr4,\$vr5\[t9\]
[0-9a-f]+ <[^>]*> 700018b5 	repib	\$vr2,\$vr3\[0\]
[0-9a-f]+ <[^>]*> 701f0835 	repib	\$vr0,\$vr1\[31\]
[0-9a-f]+ <[^>]*> 70ff0835 	repib	\$vr0,\$vr1\[255\]
[0-9a-f]+ <[^>]*> 7100ffb5 	repih	\$vr30,\$vr31\[0\]
[0-9a-f]+ <[^>]*> 711fef35 	repih	\$vr28,\$vr29\[31\]
[0-9a-f]+ <[^>]*> 71ffef35 	repih	\$vr28,\$vr29\[255\]
[0-9a-f]+ <[^>]*> 7200deb5 	repiw	\$vr26,\$vr27\[0\]
[0-9a-f]+ <[^>]*> 721fce35 	repiw	\$vr24,\$vr25\[31\]
[0-9a-f]+ <[^>]*> 72ffce35 	repiw	\$vr24,\$vr25\[255\]
[0-9a-f]+ <[^>]*> 7300bdb5 	repid	\$vr22,\$vr23\[0\]
[0-9a-f]+ <[^>]*> 731fad35 	repid	\$vr20,\$vr21\[31\]
[0-9a-f]+ <[^>]*> 73ffad35 	repid	\$vr20,\$vr21\[255\]
[0-9a-f]+ <[^>]*> 72728c18 	shufv	\$vr16,\$vr17,\$vr18,\$vr19
[0-9a-f]+ <[^>]*> 731003d4 	lu1q	\$vr15,-512\(t8\)
[0-9a-f]+ <[^>]*> 72effb94 	lu1q	\$vr14,511\(s7\)
[0-9a-f]+ <[^>]*> 72d50347 	lu1qx	\$vr13,s5\(s6\)
[0-9a-f]+ <[^>]*> 731003ec 	la1q	\$vr15,-8192\(t8\)
[0-9a-f]+ <[^>]*> 72effbac 	la1q	\$vr14,8176\(s7\)
[0-9a-f]+ <[^>]*> 72d58347 	la1qx	\$vr13,s5\(s6\)
[0-9a-f]+ <[^>]*> 7200030c 	lib	\$vr12,-16384
[0-9a-f]+ <[^>]*> 71fffacc 	lib	\$vr11,16383
[0-9a-f]+ <[^>]*> 7200028d 	lih	\$vr10,-16384
[0-9a-f]+ <[^>]*> 71fffa4d 	lih	\$vr9,16383
[0-9a-f]+ <[^>]*> 7200020e 	liw	\$vr8,-16384
[0-9a-f]+ <[^>]*> 71fff9ce 	liw	\$vr7,16383
[0-9a-f]+ <[^>]*> 7200018f 	lid	\$vr6,-16384
[0-9a-f]+ <[^>]*> 71fff94f 	lid	\$vr5,16383
[0-9a-f]+ <[^>]*> 7290011c 	su1q	\$vr4,-512\(s4\)
[0-9a-f]+ <[^>]*> 726ff8dc 	su1q	\$vr3,511\(s3\)
[0-9a-f]+ <[^>]*> 72512087 	su1qx	\$vr2,s1\(s2\)
[0-9a-f]+ <[^>]*> 7290013c 	sa1q	\$vr4,-8192\(s4\)
[0-9a-f]+ <[^>]*> 726ff8fc 	sa1q	\$vr3,8176\(s3\)
[0-9a-f]+ <[^>]*> 7251a087 	sa1qx	\$vr2,s1\(s2\)
[0-9a-f]+ <[^>]*> 70008073 	mtcpusb	s0,\$vr1\[0\]
[0-9a-f]+ <[^>]*> 701f7833 	mtcpusb	t7,\$vr0\[31\]
[0-9a-f]+ <[^>]*> 70ff7833 	mtcpusb	t7,\$vr0\[255\]
[0-9a-f]+ <[^>]*> 710077f3 	mtcpush	t6,\$vr31\[0\]
[0-9a-f]+ <[^>]*> 711f6fb3 	mtcpush	t5,\$vr30\[31\]
[0-9a-f]+ <[^>]*> 71ff6fb3 	mtcpush	t5,\$vr30\[255\]
[0-9a-f]+ <[^>]*> 72006773 	mtcpusw	t4,\$vr29\[0\]
[0-9a-f]+ <[^>]*> 721f5f33 	mtcpusw	t3,\$vr28\[31\]
[0-9a-f]+ <[^>]*> 72ff5f33 	mtcpusw	t3,\$vr28\[255\]
[0-9a-f]+ <[^>]*> 700056f4 	mtcpuub	t2,\$vr27\[0\]
[0-9a-f]+ <[^>]*> 701f4eb4 	mtcpuub	t1,\$vr26\[31\]
[0-9a-f]+ <[^>]*> 70ff4eb4 	mtcpuub	t1,\$vr26\[255\]
[0-9a-f]+ <[^>]*> 71004674 	mtcpuuh	t0,\$vr25\[0\]
[0-9a-f]+ <[^>]*> 711f3e34 	mtcpuuh	a3,\$vr24\[31\]
[0-9a-f]+ <[^>]*> 71ff3e34 	mtcpuuh	a3,\$vr24\[255\]
[0-9a-f]+ <[^>]*> 720035f4 	mtcpuuw	a2,\$vr23\[0\]
[0-9a-f]+ <[^>]*> 721f2db4 	mtcpuuw	a1,\$vr22\[31\]
[0-9a-f]+ <[^>]*> 72ff2db4 	mtcpuuw	a1,\$vr22\[255\]
[0-9a-f]+ <[^>]*> 4bc0257c 	mfcpub	\$vr21,a0
[0-9a-f]+ <[^>]*> 4bc01d3d 	mfcpuh	\$vr20,v1
[0-9a-f]+ <[^>]*> 4bc014fe 	mfcpuw	\$vr19,v0
[0-9a-f]+ <[^>]*> 4be09144 	mtfpuw	\$f5,\$vr18\[0\]
[0-9a-f]+ <[^>]*> 4bff8904 	mtfpuw	\$f4,\$vr17\[31\]
[0-9a-f]+ <[^>]*> 4be080c5 	mtfpud	\$f3,\$vr16\[0\]
[0-9a-f]+ <[^>]*> 4bff7885 	mtfpud	\$f2,\$vr15\[31\]
[0-9a-f]+ <[^>]*> 4bc103be 	mffpuw	\$vr14,\$f0
[0-9a-f]+ <[^>]*> 4bc10bff 	mffpud	\$vr15,\$f1
[0-9a-f]+ <[^>]*> 4bc1103c 	ctcmxu	\$0,v0
[0-9a-f]+ <[^>]*> 4bc1187c 	ctcmxu	\$1,v1
[0-9a-f]+ <[^>]*> 4bc120bc 	ctcmxu	\$2,a0
[0-9a-f]+ <[^>]*> 4bc128fc 	ctcmxu	\$3,a1
[0-9a-f]+ <[^>]*> 4bc137fc 	ctcmxu	\$31,a2
[0-9a-f]+ <[^>]*> 4bc1383d 	cfcmxu	a3,\$0
[0-9a-f]+ <[^>]*> 4bc1407d 	cfcmxu	t0,\$1
[0-9a-f]+ <[^>]*> 4bc148bd 	cfcmxu	t1,\$2
[0-9a-f]+ <[^>]*> 4bc150fd 	cfcmxu	t2,\$3
[0-9a-f]+ <[^>]*> 4bc15ffd 	cfcmxu	t3,\$31
	\.\.\.
