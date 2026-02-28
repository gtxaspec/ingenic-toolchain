	.text
	.set	noat
	.set	noreorder
	.set	nomacro
test_msa:
#BNEZ
1:
	bnez16b	$vr3,. + 4 + (-512 << insn_log2)
	nop
	bnez16b	$vr4,. + 4 + (511 << insn_log2)
	nop
	bnez16b	$vr5,1b
	nop
	bnez16b	$vr6,external_label
	nop
1:
	bnez8h	$vr7,. + 4 + (-512 << insn_log2)
	nop
	bnez8h	$vr8,. + 4 + (511 << insn_log2)
	nop
	bnez8h	$vr9,1b
	nop
	bnez8h	$vr10,external_label
	nop
1:
	bnez4w	$vr11,. + 4 + (-512 << insn_log2)
	nop
	bnez4w	$vr12,. + 4 + (511 << insn_log2)
	nop
	bnez4w	$vr13,1b
	nop
	bnez4w	$vr14,external_label
	nop
1:
	bnez2d	$vr15,. + 4 + (-512 << insn_log2)
	nop
	bnez2d	$vr16,. + 4 + (511 << insn_log2)
	nop
	bnez2d	$vr17,1b
	nop
	bnez2d	$vr18,external_label
	nop

#BNEZ1Q
1:
	bnez1q	$vr19,. + 4 + (-512 << insn_log2)
	nop
	bnez1q	$vr20,. + 4 + (511 << insn_log2)
	nop
	bnez1q	$vr21,1b
	nop
	bnez1q	$vr22,external_label
	nop

#BEQZ
1:
	beqz16b	$vr23,. + 4 + (-512 << insn_log2)
	nop
	beqz16b	$vr24,. + 4 + (511 << insn_log2)
	nop
	beqz16b	$vr25,1b
	nop
	beqz16b	$vr26,external_label
	nop
1:
	beqz8h	$vr27,. + 4 + (-512 << insn_log2)
	nop
	beqz8h	$vr28,. + 4 + (511 << insn_log2)
	nop
	beqz8h	$vr29,1b
	nop
	beqz8h	$vr30,external_label
	nop
1:
	beqz4w	$vr31,. + 4 + (-512 << insn_log2)
	nop
	beqz4w	$vr0,. + 4 + (511 << insn_log2)
	nop
	beqz4w	$vr1,1b
	nop
	beqz4w	$vr2,external_label
	nop
1:
	beqz2d	$vr3,. + 4 + (-512 << insn_log2)
	nop
	beqz2d	$vr4,. + 4 + (511 << insn_log2)
	nop
	beqz2d	$vr5,1b
	nop
	beqz2d	$vr6,external_label
	nop

#BEQZ1Q
1:
	beqz1q	$vr7,. + 4 + (-512 << insn_log2)
	nop
	beqz1q	$vr8,. + 4 + (511 << insn_log2)
	nop
	beqz1q	$vr9,1b
	nop
	beqz1q	$vr10,external_label
	nop
#CEQ
	ceqb	$vr0,$vr1,$vr2
	ceqh	$vr3,$vr4,$vr5
	ceqw	$vr6,$vr7,$vr8
	ceqd	$vr9,$vr10,$vr11

#CEQZ
	ceqzb	$vr24,$vr25
	ceqzh	$vr27,$vr28
	ceqzw	$vr30,$vr31
	ceqzd	$vr1,$vr2

#CNE
	cneb	$vr12,$vr13,$vr14
	cneh	$vr15,$vr16,$vr17
	cnew	$vr18,$vr19,$vr20
	cned	$vr21,$vr22,$vr23

#CNEZ
	cnezb	$vr3,$vr4
	cnezh	$vr5,$vr6
	cnezw	$vr7,$vr8
	cnezd	$vr9,$vr10

#CLES
	clesb	$vr12,$vr13,$vr14
	clesh	$vr15,$vr16,$vr17
	clesw	$vr18,$vr19,$vr20
	clesd	$vr21,$vr22,$vr23

#CLEU
	cleub	$vr24,$vr25,$vr26
	cleuh	$vr27,$vr28,$vr29
	cleuw	$vr30,$vr31,$vr0
	cleud	$vr1,$vr2,$vr3

#CLEZ
	clezb	$vr24,$vr25
	clezh	$vr26,$vr27
	clezw	$vr28,$vr29
	clezd	$vr30,$vr31

#CLTS
	cltsb	$vr0,$vr1,$vr2
	cltsh	$vr3,$vr4,$vr5
	cltsw	$vr6,$vr7,$vr8
	cltsd	$vr9,$vr10,$vr11

#CLTU
	cltub	$vr12,$vr13,$vr14
	cltuh	$vr15,$vr16,$vr17
	cltuw	$vr18,$vr19,$vr20
	cltud	$vr21,$vr22,$vr23

#CLTZ
	cltzb	$vr24,$vr25
	cltzh	$vr26,$vr27
	cltzw	$vr28,$vr29
	cltzd	$vr30,$vr31

#ADDA
	addab	$vr0,$vr1,$vr2
	addah	$vr3,$vr4,$vr5
	addaw	$vr6,$vr7,$vr8
	addad	$vr9,$vr10,$vr11

#ADDAS
	addasb	$vr12,$vr13,$vr14
	addash	$vr15,$vr16,$vr17
	addasw	$vr18,$vr19,$vr20
	addasd	$vr21,$vr22,$vr23

#ADDSS
	addssb	$vr24,$vr25,$vr26
	addssh	$vr27,$vr28,$vr29
	addssw	$vr30,$vr31,$vr0
	addssd	$vr1,$vr2,$vr3

#ADDUU
	adduub	$vr4,$vr5,$vr6
	adduuh	$vr7,$vr8,$vr9
	adduuw	$vr10,$vr11,$vr12
	adduud	$vr13,$vr14,$vr15

#ADD
	addb	$vr16,$vr17,$vr18
	addh	$vr19,$vr20,$vr21
	addw	$vr22,$vr23,$vr24
	addd	$vr25,$vr26,$vr27

#SUBSA
	subsab	$vr28,$vr29,$vr30
	subsah	$vr31,$vr0,$vr1
	subsaw	$vr2,$vr3,$vr4
	subsad	$vr5,$vr6,$vr7

#SUBUA
	subuab	$vr8,$vr9,$vr10
	subuah	$vr11,$vr12,$vr13
	subuaw	$vr14,$vr15,$vr16
	subuad	$vr17,$vr18,$vr19

#SUBSS
	subssb	$vr20,$vr21,$vr22
	subssh	$vr23,$vr24,$vr25
	subssw	$vr26,$vr27,$vr28
	subssd	$vr29,$vr30,$vr31

#SUBUU
	subuub	$vr0,$vr1,$vr2
	subuuh	$vr3,$vr4,$vr5
	subuuw	$vr6,$vr7,$vr8
	subuud	$vr9,$vr10,$vr11

#SUBUS
	subusb	$vr12,$vr13,$vr14
	subush	$vr15,$vr16,$vr17
	subusw	$vr18,$vr19,$vr20
	subusd	$vr21,$vr22,$vr23

#SUB
	subb	$vr24,$vr25,$vr26
	subh	$vr27,$vr28,$vr29
	subw	$vr30,$vr31,$vr0
	subd	$vr1,$vr2,$vr3

#AVES
	avesb	$vr4,$vr5,$vr6
	avesh	$vr7,$vr8,$vr9
	avesw	$vr10,$vr11,$vr12
	avesd	$vr13,$vr14,$vr15

#AVEU
	aveub	$vr16,$vr17,$vr18
	aveuh	$vr19,$vr20,$vr21
	aveuw	$vr22,$vr23,$vr24
	aveud	$vr25,$vr26,$vr27

#AVERS
	aversb	$vr28,$vr29,$vr30
	aversh	$vr31,$vr0,$vr1
	aversw	$vr2,$vr3,$vr4
	aversd	$vr5,$vr6,$vr7

#AVERU
	averub	$vr8,$vr9,$vr10
	averuh	$vr11,$vr12,$vr13
	averuw	$vr14,$vr15,$vr16
	averud	$vr17,$vr18,$vr19

#DIVS
	divsb	$vr20,$vr21,$vr22
	divsh	$vr23,$vr24,$vr25
	divsw	$vr26,$vr27,$vr28
	divsd	$vr29,$vr30,$vr31

#DIVU
	divub	$vr0,$vr1,$vr2
	divuh	$vr3,$vr4,$vr5
	divuw	$vr6,$vr7,$vr8
	divud	$vr9,$vr10,$vr11

#MODS
	modsb	$vr12,$vr13,$vr14
	modsh	$vr15,$vr16,$vr17
	modsw	$vr18,$vr19,$vr20
	modsd	$vr21,$vr22,$vr23

#MODU
	modub	$vr24,$vr25,$vr26
	moduh	$vr27,$vr28,$vr29
	moduw	$vr30,$vr31,$vr0
	modud	$vr1,$vr2,$vr3

#MADD
	maddb	$vr4,$vr5,$vr6
	maddh	$vr7,$vr8,$vr9
	maddw	$vr10,$vr11,$vr12
	maddd	$vr13,$vr14,$vr15

#MSUB
	msubb	$vr16,$vr17,$vr18
	msubh	$vr19,$vr20,$vr21
	msubw	$vr22,$vr23,$vr24
	msubd	$vr25,$vr26,$vr27

#MUL
	mulb	$vr28,$vr29,$vr30
	mulh	$vr31,$vr0,$vr1
	mulw	$vr2,$vr3,$vr4
	muld	$vr5,$vr6,$vr7

#MAXA
	maxab	$vr8,$vr9,$vr10
	maxah	$vr11,$vr12,$vr13
	maxaw	$vr14,$vr15,$vr16
	maxad	$vr17,$vr18,$vr19

#MAXS
	maxsb	$vr20,$vr21,$vr22
	maxsh	$vr23,$vr24,$vr25
	maxsw	$vr26,$vr27,$vr28
	maxsd	$vr29,$vr30,$vr31

#MAXU
	maxub	$vr0,$vr1,$vr2
	maxuh	$vr3,$vr4,$vr5
	maxuw	$vr6,$vr7,$vr8
	maxud	$vr9,$vr10,$vr11

#MINA
	minab	$vr12,$vr13,$vr14
	minah	$vr15,$vr16,$vr17
	minaw	$vr18,$vr19,$vr20
	minad	$vr21,$vr22,$vr23

#MINS
	minsb	$vr24,$vr25,$vr26
	minsh	$vr27,$vr28,$vr29
	minsw	$vr30,$vr31,$vr0
	minsd	$vr1,$vr2,$vr3

#MINU
	minub	$vr4,$vr5,$vr6
	minuh	$vr7,$vr8,$vr9
	minuw	$vr10,$vr11,$vr12
	minud	$vr13,$vr14,$vr15

#DOTPS
	dotpsh	$vr16,$vr17,$vr18
	dotpsw	$vr19,$vr20,$vr21
	dotpsd	$vr22,$vr23,$vr24

#DOTPU
	dotpuh	$vr25,$vr26,$vr27
	dotpuw	$vr28,$vr29,$vr30
	dotpud	$vr31,$vr0,$vr1

#DADDS
	daddsh	$vr2,$vr3,$vr4
	daddsw	$vr5,$vr6,$vr7
	daddsd	$vr8,$vr9,$vr10

#DADDU
	dadduh	$vr11,$vr12,$vr13
	dadduw	$vr14,$vr15,$vr16
	daddud	$vr17,$vr18,$vr19

#DSUBS
	dsubsh	$vr20,$vr21,$vr22
	dsubsw	$vr23,$vr24,$vr25
	dsubsd	$vr26,$vr27,$vr28

#DSUBU
	dsubuh	$vr29,$vr30,$vr31
	dsubuw	$vr0,$vr1,$vr2
	dsubud	$vr3,$vr4,$vr5

#LOC
	locb	$vr6,$vr7
	loch	$vr8,$vr9
	locw	$vr10,$vr11
	locd	$vr12,$vr13

#LZC
	lzcb	$vr14,$vr15
	lzch	$vr16,$vr17
	lzcw	$vr18,$vr19
	lzcd	$vr20,$vr21

#BCNT
	bcntb	$vr14,$vr15
	bcnth	$vr12,$vr13
	bcntw	$vr10,$vr11
	bcntd	$vr8,$vr9

#SATS
	satsb	$vr6,$vr7,0
	satsb	$vr4,$vr5,63
	satsh	$vr2,$vr3,0
	satsh	$vr0,$vr1,63
	satsw	$vr30,$vr31,0
	satsw	$vr28,$vr29,63
	satsd	$vr26,$vr27,0
	satsd	$vr24,$vr25,63

#SATU
	satub	$vr22,$vr23,0
	satub	$vr20,$vr21,63
	satuh	$vr18,$vr19,0
	satuh	$vr16,$vr17,63
	satuw	$vr14,$vr15,0
	satuw	$vr12,$vr13,63
	satud	$vr10,$vr11,0
	satud	$vr8,$vr9,63

#AND1Q
	andv	$vr5,$vr6,$vr7

#ANDIB
	andib	$vr3,$vr4,0
	andib	$vr1,$vr2,255

#BSELV
	bselv	$vr29,$vr30,$vr31,$vr0

#NOR1Q
	norv	$vr26,$vr27,$vr28

#NORIB
	norib	$vr24,$vr25,0
	norib	$vr22,$vr23,255

#OR1Q
	orv		$vr19,$vr20,$vr21

#ORIB
	orib	$vr17,$vr18,0
	orib	$vr15,$vr16,255

#XOR1Q
	xorv	$vr12,$vr13,$vr14

#XORIB
	xorib	$vr10,$vr11,0
	xorib	$vr8,$vr9,255

#FADD
	faddw	$vr5,$vr6,$vr7
	faddd	$vr2,$vr3,$vr4

#FSUB
	fsubw	$vr31,$vr0,$vr1
	fsubd	$vr28,$vr29,$vr30

#FMUL
	fmulw	$vr25,$vr26,$vr27
	fmuld	$vr22,$vr23,$vr24

#FDIV
	fdivw	$vr19,$vr20,$vr21
	fdivd	$vr16,$vr17,$vr18

#FSQRT
	fsqrtw	$vr14,$vr15
	fsqrtd	$vr12,$vr13

#FMADD
	fmaddw	$vr9,$vr10,$vr11
	fmaddd	$vr6,$vr7,$vr8

#FMSUB
	fmsubw	$vr3,$vr4,$vr5
	fmsubd	$vr0,$vr1,$vr2

#FMAX
	fmaxw	$vr29,$vr30,$vr31
	fmaxd	$vr26,$vr27,$vr28

#FMAXA
	fmaxaw	$vr23,$vr24,$vr25
	fmaxad	$vr20,$vr21,$vr22

#FMIN
	fminw	$vr17,$vr18,$vr19
	fmind	$vr14,$vr15,$vr16

#FMINA
	fminaw	$vr11,$vr12,$vr13
	fminad	$vr8,$vr9,$vr10

#FCLASS
	fclassw	$vr6,$vr7
	fclassd	$vr4,$vr5

#FCEQ
	fceqw	$vr1,$vr2,$vr3
	fceqd	$vr30,$vr31,$vr0

#FCLE
	fclew	$vr27,$vr28,$vr29
	fcled	$vr24,$vr25,$vr26

#FCLT
	fcltw	$vr21,$vr22,$vr23
	fcltd	$vr18,$vr19,$vr20

#FCOR
	fcorw	$vr15,$vr16,$vr17
	fcord	$vr12,$vr13,$vr14

#VCVTHS
	vcvths	$vr9,$vr10,$vr11

#VCVTSD
	vcvtsd	$vr6,$vr7,$vr8

#VCVTESH
	vcvtesh	$vr4,$vr5

#VCVTEDS
	vcvteds	$vr2,$vr3

#VCVTOSH
	vcvtosh	$vr0,$vr1

#VCVTODS
	vcvtods	$vr30,$vr31

#VCVTSSW
	vcvtssw	$vr28,$vr29

#VCVTSDL
	vcvtsdl	$vr26,$vr27

#VCVTUSW
	vcvtusw	$vr24,$vr25

#VCVTUDL
	vcvtudl	$vr22,$vr23

#VCVTRWS
	vcvtrws	$vr20,$vr21

#VCVTRLD
	vcvtrld	$vr18,$vr19

#VCVTSWS
	vcvtsws	$vr16,$vr17

#VCVTSLD
	vcvtsld	$vr14,$vr15

#VCVTUWS
	vcvtuws	$vr12,$vr13

#VCVTULD
	vcvtuld	$vr10,$vr11

#VTRUNCSWS
	vtruncsws	$vr8,$vr9

#VTRUNCSLD
	vtruncsld	$vr6,$vr7

#VTRUNCUWS
	vtruncuws	$vr4,$vr5

#VTRUNCULD
	vtrunculd	$vr2,$vr3

#VCVTQESH
	vcvtqesh	$vr0,$vr1

#VCVTQEDW
	vcvtqedw	$vr30,$vr31

#VCVTQOSH
	vcvtqosh	$vr28,$vr29

#VCVTQODW
	vcvtqodw	$vr26,$vr27

#VCVTQHS
	vcvtqhs	$vr23,$vr24,$vr25

#VCVTQWD
	vcvtqwd	$vr23,$vr24,$vr25

#MADDQ
	maddqh	$vr20,$vr21,$vr22
	maddqw	$vr17,$vr18,$vr19

#MADDQR
	maddqrh	$vr14,$vr15,$vr16
	maddqrw	$vr11,$vr12,$vr13

#MSUBQ
	msubqh	$vr8,$vr9,$vr10
	msubqw	$vr5,$vr6,$vr7

#MSUBQR
	msubqrh	$vr2,$vr3,$vr4
	msubqrw	$vr31,$vr0,$vr1

#MULQ
	mulqh	$vr28,$vr29,$vr30
	mulqw	$vr25,$vr26,$vr27

#MULQR
	mulqrh	$vr22,$vr23,$vr24
	mulqrw	$vr19,$vr20,$vr21

#SLL
	sllb	$vr16,$vr17,$vr18
	sllh	$vr13,$vr14,$vr15
	sllw	$vr10,$vr11,$vr12
	slld	$vr7,$vr8,$vr9

#SLLI
	sllib	$vr5,$vr6,0
	sllib	$vr3,$vr4,63
	sllih	$vr1,$vr2,0
	sllih	$vr31,$vr0,63
	slliw	$vr29,$vr30,0
	slliw	$vr27,$vr28,63
	sllid	$vr25,$vr26,0
	sllid	$vr23,$vr24,63

#SRA
	srab	$vr20,$vr21,$vr22
	srah	$vr17,$vr18,$vr19
	sraw	$vr14,$vr15,$vr16
	srad	$vr11,$vr12,$vr13

#SRAI
	sraib	$vr9,$vr10,0
	sraib	$vr7,$vr8,63
	sraih	$vr5,$vr6,0
	sraih	$vr3,$vr4,63
	sraiw	$vr1,$vr2,0
	sraiw	$vr31,$vr0,63
	sraid	$vr29,$vr30,0
	sraid	$vr27,$vr28,63

#SRAR
	srarb	$vr24,$vr25,$vr26
	srarh	$vr21,$vr22,$vr23
	srarw	$vr18,$vr19,$vr20
	srard	$vr15,$vr16,$vr17

#SRARI
	srarib	$vr13,$vr14,0
	srarib	$vr11,$vr12,63
	srarih	$vr9,$vr10,0
	srarih	$vr7,$vr8,63
	srariw	$vr5,$vr6,0
	srariw	$vr3,$vr4,63
	srarid	$vr1,$vr2,0
	srarid	$vr31,$vr0,63

#SRL
	srlb	$vr28,$vr29,$vr30
	srlh	$vr25,$vr26,$vr27
	srlw	$vr22,$vr23,$vr24
	srld	$vr19,$vr20,$vr21

#SRLI
	srlib	$vr17,$vr18,0
	srlib	$vr15,$vr16,63
	srlih	$vr13,$vr14,0
	srlih	$vr11,$vr12,63
	srliw	$vr9,$vr10,0
	srliw	$vr7,$vr8,63
	srlid	$vr5,$vr6,0
	srlid	$vr3,$vr4,63

#SRLR
	srlrb	$vr0,$vr1,$vr2
	srlrh	$vr29,$vr30,$vr31
	srlrw	$vr26,$vr27,$vr28
	srlrd	$vr23,$vr24,$vr25

#SRLRI
	srlrib	$vr21,$vr22,0
	srlrib	$vr19,$vr20,63
	srlrih	$vr17,$vr18,0
	srlrih	$vr15,$vr16,63
	srlriw	$vr13,$vr14,0
	srlriw	$vr11,$vr12,63
	srlrid	$vr9,$vr10,0
	srlrid	$vr7,$vr8,63

#INSFCPU
	insfcpub	$vr6[0],$15
	insfcpub	$vr5[31],$14
	insfcpub	$vr5[255],$14
	insfcpuh	$vr4[0],$13
	insfcpuh	$vr3[31],$12
	insfcpuh	$vr3[255],$12
	insfcpuw	$vr2[0],$11
	insfcpuw	$vr1[31],$10
	insfcpuw	$vr1[255],$10

#INSFFPU
	insffpuw	$vr0[0],$f9
	insffpuw	$vr31[31],$f8
	insffpud	$vr30[0],$f7
	insffpud	$vr29[31],$f6

#INSFMXU
	insfmxub	$vr27[255],$vr28[0]
	insfmxub	$vr27[31],$vr28[0]
	insfmxub	$vr25[0],$vr26[0]
	insfmxuh	$vr23[255],$vr24[0]
	insfmxuh	$vr23[31],$vr24[0]
	insfmxuh	$vr21[0],$vr22[0]
	insfmxuw	$vr19[255],$vr20[0]
	insfmxuw	$vr19[31],$vr20[0]
	insfmxuw	$vr17[0],$vr18[0]
	insfmxud	$vr15[255],$vr16[0]
	insfmxud	$vr15[31],$vr16[0]
	insfmxud	$vr13[0],$vr14[0]

#REPX
	repxb	$vr11,$vr12[$28]
	repxh	$vr9,$vr10[$27]
	repxw	$vr6,$vr7[$26]
	repxd	$vr4,$vr5[$25]

#REPI
	repib	$vr2,$vr3[0]
	repib	$vr0,$vr1[31]
	repib	$vr0,$vr1[255]
	repih	$vr30,$vr31[0]
	repih	$vr28,$vr29[31]
	repih	$vr28,$vr29[255]
	repiw	$vr26,$vr27[0]
	repiw	$vr24,$vr25[31]
	repiw	$vr24,$vr25[255]
	repid	$vr22,$vr23[0]
	repid	$vr20,$vr21[31]
	repid	$vr20,$vr21[255]

#SHUFV
	shufv	$vr16,$vr17,$vr18,$vr19

#LU1Q
	lu1q	$vr15,-512($24)
	lu1q	$vr14,511($23)

#LU1QX
	lu1qx	$vr13,$21($22)

#LA1Q
	la1q	$vr15,-8192($24)
	la1q	$vr14,8176($23)

#LA1QX
	la1qx	$vr13,$21($22)

#LI
	lib	$vr12,-16384
	lib	$vr11,16383
	lih	$vr10,-16384
	lih	$vr9,16383
	liw	$vr8,-16384
	liw	$vr7,16383
	lid	$vr6,-16384
	lid	$vr5,16383

#SU1Q
	su1q	$vr4,-512($20)
	su1q	$vr3,511($19)

#SU1QX
	su1qx	$vr2,$17($18)

#SA1Q
	sa1q	$vr4,-8192($20)
	sa1q	$vr3,8176($19)

#SA1QX
	sa1qx	$vr2,$17($18)

#MTCPUS
	mtcpusb	$16,$vr1[0]
	mtcpusb	$15,$vr0[31]
	mtcpusb	$15,$vr0[255]
	mtcpush	$14,$vr31[0]
	mtcpush	$13,$vr30[31]
	mtcpush	$13,$vr30[255]
	mtcpusw	$12,$vr29[0]
	mtcpusw	$11,$vr28[31]
	mtcpusw	$11,$vr28[255]

#MTCPUU
	mtcpuub	$10,$vr27[0]
	mtcpuub	$9,$vr26[31]
	mtcpuub	$9,$vr26[255]
	mtcpuuh	$8,$vr25[0]
	mtcpuuh	$7,$vr24[31]
	mtcpuuh	$7,$vr24[255]
	mtcpuuw	$6,$vr23[0]
	mtcpuuw	$5,$vr22[31]
	mtcpuuw	$5,$vr22[255]

#MFCPU
	mfcpub	$vr21,$4
	mfcpuh	$vr20,$3
	mfcpuw	$vr19,$2

#MTFPU
	mtfpuw	$f5,$vr18[0]
	mtfpuw	$f4,$vr17[31]
	mtfpud	$f3,$vr16[0]
	mtfpud	$f2,$vr15[31]

#MFFPU
	mffpuw	$vr14,$f0
	mffpud	$vr15,$f1

#CTCMXU
	ctcmxu	$0,$v0
	ctcmxu	$1,$v1
	ctcmxu	$2,$a0
	ctcmxu	$3,$a1
	ctcmxu	$31,$a2

#CFCMXU
	cfcmxu	$a3,$0
	cfcmxu	$t0,$1
	cfcmxu	$t1,$2
	cfcmxu	$t2,$3
	cfcmxu	$t3,$31

# Force at least 8 (non-delay-slot) zero bytes, to make 'objdump' print ...
	.align  2
	.space  8

