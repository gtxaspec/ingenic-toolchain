extern struct PLArch
  plarch_alpha,
  plarch_arm,
  plarch_i386,
  plarch_ia64,
  plarch_mips,
  plarch_mips64,
  plarch_ppc,
  plarch_ppc64,
  plarch_s390,
  plarch_s390x,
  plarch_sh,
  plarch_sparc,
  plarch_sparc64,
  plarch_x86_64;

#ifndef DSO_READONLY
static struct PLArch * __start_pl_arch[] = {
  &plarch_alpha,
  &plarch_arm,
  &plarch_i386,
  &plarch_ia64,
  &plarch_mips,
  &plarch_mips64,
  &plarch_ppc,
  &plarch_ppc64,
  &plarch_s390,
  &plarch_s390x,
  &plarch_sh,
  &plarch_sparc,
  &plarch_sparc64,
  &plarch_x86_64
};
static struct PLArch **__stop_pl_arch = __start_pl_arch + sizeof (__start_pl_arch) / sizeof (struct PLArch *);
#endif
