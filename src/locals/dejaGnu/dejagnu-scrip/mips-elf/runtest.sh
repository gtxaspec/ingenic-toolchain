export PATH=/home/toolchains/mipself-r2.1/install/bin:$PATH
export DEJAGNU=/home/toolchains/dejagnu-elf/site.exp


make -j4 -k -w check-gcc-c RUNTESTFLAGS="--target_board mips-idt -v -v"
#make  -j4 -k -w check-gcc-c RUNTESTFLAGS="--target_board jz-cs-4.7.2-mips-sshscp execute.exp=20101011-1.c -v -v"

#########################################################################3
#make  -k -w check RUNTESTFLAGS="--target_board jz-cs-4.7.2-mips-sshscp -v -v"
#make -j3 -k -w check RUNTESTFLAGS="--target_board jz-cs-4.7.2-mips-sshscp1 -v -v"


#make  -k -w check RUNTESTFLAGS="--target_board cs-4.6.3-mips-sshscp -v -v"
#make  -k -w check-gcc RUNTESTFLAGS="--target_board cs-4.7.2-mips-sshscp -v -v"
#make  -k -w check-c++ RUNTESTFLAGS="--target_board cs-4.7.2-mips-sshscp -v -v"
#make  -k -w check-c++ RUNTESTFLAGS="--target_board cs-4.7.2-mips-sshscp1 -v -v"

# To set test options
#export COMPAT_OPTIONS="[list [list {-EL} {-EL}] [list {-EL -msoft-float} {-EL -msoft-float}] [list {-EL -muclibc} {-EL -muclibc}] [list {-EL -muclibc -msoft-float} {-EL -muclibc -msoft-float}] ]"



