rm -rf install/ log* obj/ pkg/; 
env version_mask="Linux-Release5.1.1-Default(xburst2(fp64)+glibc2.29)" ./mipslinux-7.2.sh --with-private=default_option_mglibc_mfp64 2>&1 | tee log.fp64.glibc 
#env version_mask="Linux-Release5.1.1-Default(xburst2(fp64)+uclibc0.9.33.2)" ./mipslinux-7.2.sh --with-private=default_option_muclibc_mfp64 2>&1 | tee log.fp64.uclibc
#env version_mask="Linux-Release5.1.1-Default(xburst1(fp32)+glibc2.29)" ./mipslinux-7.2.sh --with-private=default_option_mglibc_mfp32 2>&1 | tee log.fp32.glibc
#env version_mask="Linux-Release5.1.1-Default(xburst1(fp32)+uclibc0.9.33.2)" ./mipslinux-7.2.sh --with-private=default_option_muclibc_mfp32 2>&1 | tee log.fp32.uclibc
