 #!/bin/bash

manifest_path=${local_path}/.repo/manifest.xml
testenv=${local_path}/testenv
base_path="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
nfshostip=192.168.4.13
gatewayip=192.168.4.1
netmask=255.255.255.0


syncEnvSource()
{
    if [ -e ${local_path}/.repo/manifests/env ];
    then
	if [ -h ${manifest_path} ];
	then
	    REAL_PATH=`readlink -f ${manifest_path}`
	    sed -i "/^<include name=\"env\/${board}-env.xml\"\/>/d"  ${REAL_PATH}
	    sed -i  "/<\/manifest>/i<include name=\"env\/${board}-env.xml\"\/>"  ${REAL_PATH}
	    tail ${REAL_PATH}
	    [ $syncuboot = 1 ] && repo sync bootloader/u-boot
	    [ $syncrootfs = 1 ] && repo sync buildroot/buildroot
	    [ $synckernel = 1 ] && repo sync AOSP/kernel/mips
#	    repo sync results
	fi
    else
	[ $syncuboot = 1 ] && {
	    git clone ssh://192.168.1.26:29418/bootloader/u-boot -b ingenic-master ${local_path}/testenv/uboot
	    pushd ${local_path}/testenv/uboot
	    git reset --hard d63327c7a557fb23fd6f58367e8fe4c7596e5aae
	    popd
	}
	[ $syncrootfs = 1 ] && {
	    git clone ssh://192.168.1.26:29418/buildroot/buildroot -b ingenic-master ${local_path}/testenv/buildroot
	    pushd ${local_path}/testenv/buildroot
	    git reset --hard 78de3d5cbd5b3b58661ffce455ba4cd5ab7dd1fc
	    popd
	}
	[ $synckernel = 1 ] && {
	    git clone ssh://192.168.1.26:29418/AOSP/kernel/mips -b ingenic-master-3.10.14 ${local_path}/testenv/kernel
	    pushd ${local_path}/testenv/kernel
	    git reset --hard b63563291a3158e6a276250c7096fd64ef030c38
	    popd
	}
#	git clone ssh://192.168.1.26:29418/toolchains/src/mips-tools/results
    fi
}

# For build kernel
build_kernel()
{
    pushd ${testenv}/kernel
    git reset --hard b63563291a3158e6a276250c7096fd64ef030c38
    git apply  ${local_path}/locals/tlchtest/patchs/0001-Kernel-build-env-for-gcc5.2-compiler-gcc5.h-std-gnu8.patch
    make distclean
    cp ${local_path}/locals/tlchtest/configs/${board}_tlchenv_defconfig ./arch/mips/configs/
    make ${board}_tlchenv_defconfig
    make uImage V=1 -j24  >kernel.log 2>&1
    if [ $? != 0 ];then
	echo "build *** [kernel] Error"
	popd
	return 1
    fi
    cp arch/mips/boot/uImage ${outputdir}/
    popd
}

# For build uboot
build_uboot()
{
    pushd ${testenv}/uboot
    git reset --hard d63327c7a557fb23fd6f58367e8fe4c7596e5aae
    git apply  ${local_path}/locals/tlchtest/patchs/0001-Uboot-build-env-for-gcc5.2-compiler-gcc5.h-std-gnu89.patch
    sed -i "/^[ \t]*#define CONFIG_BOOTARGS/c\#define CONFIG_BOOTARGS BOOTARGS_COMMON \" ip=${targetip}:${nfshostip}:${gatewayip}:${netmask} nfsroot=${nfshostip}:${rootfsdir} rw\""  include/configs/dorado.h

    make dorado_v22_uImage_msc0 -j24 2>&1 >uboot.log

    if [ $? != 0 ];then
	echo "build *** [uboot] Error"
	popd
	return 1
    fi

    cp u-boot-with-spl-mbr-gpt.bin ${outputdir}/uboot
    popd
}
# For build rootfs
push_rootfs_env()
{
echo "# Configure Loopback
auto eth0
iface eth0 inet static
    address 10.0.2.15
    netmask 255.255.255.0
    gateway 10.0.2.2
    dns-nameservers 192.168.1.2 " > system/skeleton/etc/network/interfaces

echo " #!/bin/bash
rm /dev/fuse
mknod /dev/fuse c 10 229
mkdir -p ${local_path}
sshfs ${host}:${local_path} ${local_path} -o uid=1000,gid=1000,allow_other " > system/skeleton/root/.sshfsconfig

echo "source ~/.sshfsconfig" >> system/skeleton/etc/profile

sed -i -e "/^BR2_TOOLCHAIN_EXTERNAL_PATH/c\BR2_TOOLCHAIN_EXTERNAL_PATH=\"${install_path}\"" \
    -e "/^BR2_TARGET_GENERIC_GETTY_PORT/c\BR2_TARGET_GENERIC_GETTY_PORT=\"${getty_port}\""  .config

}

pop_rootfs_env()
{
    git checkout ./system/skeleton/etc/profile \
	system/skeleton/etc/network/interfaces
}

build_rootfs()
{

    pushd ${testenv}/buildroot

    git reset --hard 78de3d5cbd5b3b58661ffce455ba4cd5ab7dd1fc
    git apply  ${local_path}/locals/tlchtest/patchs/0001-Buildroot-build-env-ncurses-with-gcc5.2.patch
    git apply  ${local_path}/locals/tlchtest/patchs/0001-Buildroot-build-env-copy-libgfortran.so-and-libatomic.so-to-lib-with-gcc5.2.patch
    cp ${local_path}/locals/tlchtest/configs/ingenic_tlchenv_defconfig ./configs/

    make clean
    make ingenic_tlchenv_defconfig
    push_rootfs_env
    make 2>&1>rootfs.log
    pop_rootfs_env

    if [ $? != 0 ];then
	echo "build *** [rootfs] Error"
	popd
	return 1
    fi
    cp output/images/rootfs.tar ${outputdir}/

    popd
}

# generate ssh exp
generate_gcc_dejagnu_sshcp()
{
    GCC_path=$install_path/bin/${TOOLCHAIN_PRE}-gcc
    GXX_path=$install_path/bin/${TOOLCHAIN_PRE}-g++

#set compiler c++compiler sockethost
    echo "load_generic_config \"unix\"
process_multilib_options \"\"
set_board_info compiler \"${GCC_path}\"
set_board_info c++compiler \"${GXX_path}\"
set_board_info rsh_prog \"/usr/bin/ssh -p ${sshport}\"
set_board_info rcp_prog \"/usr/bin/scp -P ${sshport}\"
set_board_info protocol standard
set_board_info hostname ${targetip}
set_board_info sockethost \"${targetip}:\"
set_board_info cflags \"${cflags}\"
set_board_info ldflags \"${ldflags}\"
set_board_info username root"  > ${dejagnu_dir}/sshcp.exp

}

# generate dejagnu site.exp
generate_gcc_dejagnu_site()
{
    # set target_alias target_triplet boards_dir
    echo "set host_alias i686-pc-linux-gnu
set host_triplet i686-pc-linux-gnu
set target_alias ${TOOLCHAIN_PRE}
set target_triplet ${TOOLCHAIN_PRE}
set build_triplet i686-pc-linux-gnu
#fix boards_dir to your position of the dejagnu
lappend boards_dir \"${dejagnu_dir}\"" > ${dejagnu_dir}/site.exp
}

# generate dejagnu runtest
generate_runtest()
{
    echo  "export PATH=${install_path}/bin:${base_path}
export DEJAGNU=${dejagnu_dir}/site.exp
make -j4 -k -w check RUNTESTFLAGS=\
\"--target_board sshcp -v -v $dejagnuspecial\"

#Test for per
#execute.exp=20101011-1.c

#To set test options
#export COMPAT_OPTIONS=\"[list [list \
{-EL -muclibc -msoft-float} \
{-EL -muclibc -msoft-float}] ]\"" > ${dejagnu_dir}/runtest.sh

}

# special for gdb
generate_sshcp_gdb()
{
    echo "# gdbserver's location on your target board.
set_board_info gdb_server_prog /root/gdbserver
# We will be using the standard GDB remote protocol
set_board_info gdb_protocol \"remote\"
# Use techniques appropriate to a stub
set_board_info use_gdb_stub 1
# This gdbserver can only run a process once per session.
set_board_info gdb,do_reload_on_run 1
# There's no support for argument-passing (yet).
set_board_info noargs 1
# Can't do input (or output) in the current gdbserver.
set_board_info gdb,noinferiorio 1
# Can't do hardware watchpoints, in generate
set_board_info gdb,no_hardware_watchpoints 1"  >> ${dejagnu_dir}/sshcp.exp

    sed -i "/load_generic_config/c\load_generic_config \"gdbserver\"" ${dejagnu_dir}/sshcp.exp

    echo "set tool gdb
set srcdir ${1}/gdb/testsuite
set all_flag 1" >> ${dejagnu_dir}/site.exp
}

# generate  for elf mips-idt.exp
generate_dejagnu_mips_elf()
{
    cp ${local_path}/locals/tlchtest/dejagnu/standard.exp ${dejagnu_dir}/standard.exp
    cat ${local_path}/locals/tlchtest/dejagnu/mips-idt.exp > ${dejagnu_dir}/sshcp.exp
    sed -i "/^set_board_info compiler/c\set_board_info compiler \"${install_path}/bin/${TOOLCHAIN_PRE}-gcc\"" ${dejagnu_dir}/sshcp.exp
    sed -i "/^set_board_info cflags/c\set_board_info cflags \" ${cflags} -I${install_path}/${TOOLCHAIN_PRE}/include \"" ${dejagnu_dir}/sshcp.exp
    sed -i "/^set_board_info ldflags/c\set_board_info ldflags \"${cflags} -L${install_path}/${TOOLCHAIN_PRE}/lib/${multilib}\"" ${dejagnu_dir}/sshcp.exp
}

vexe()
{
    echo $verbose
    # must use if...then...else...fi; cannot use (&& ||),because
    # $@ >/dev/null maybe get error.
    if [ "$verbose" = "0" ];then
	$@ >/dev/null
    else
	$@ $1
    fi
}

dejagnu_run()
{
    cp ${dejagnu_dir}/runtest.sh $1/
    pushd $1
    chmod +x $1/runtest.sh
    pwd
    vexe ./runtest.sh
    popd
}

# run dejagnu and get result
get_result()
{
    testcase=$1
    rundir=$2
    echo "Dejagnu [$testcase] ..."
    dejagnu_run $rundir

    rm -rf ${outputdir}/gas
    cp -rf $rundir/$testcase/testsuite ${outputdir}/$testcase.$(date +%Y%m%d-%H%M%S)
    echo "Dejagnu [$testcase] finish"
}

# GAS
dejagnu_gas()
{
    [ $test_elf = 0 ] && generate_gcc_dejagnu_sshcp || generate_dejagnu_mips_elf
    generate_gcc_dejagnu_site
    generate_runtest

    srcdir=${local_path}/obj/`ls ${local_path}/obj | grep binutils-src`
    rundir=${local_path}/obj/`ls ${local_path}/obj | grep binutils-2`

    echo "set tool gas
set srcdir ${srcdir}/gas/testsuite/gas/mips
set all_flag 1" >> ${dejagnu_dir}/site.exp

    get_result gas $rundir
}

#GCC
dejagnu_gcc()
{
    [ $test_elf = 0 ] && generate_gcc_dejagnu_sshcp || generate_dejagnu_mips_elf
    generate_gcc_dejagnu_site
    generate_runtest

    rundir=${local_path}/obj/`ls ${local_path}/obj | grep gcc-2`

    get_result gcc $rundir
}

#GDB
dejagnu_gdb()
{
    if [ "$gdbtype"x = "binutils"x ];then
	rundir=${local_path}/obj/`ls ${local_path}/obj | grep binutils-2`
	srcdir=${local_path}/obj/`ls ${local_path}/obj | grep binutils-src`
    elif [ "$gdbtype"x = "gdb"x ];then
	rundir=${local_path}/obj/`ls ${local_path}/obj | grep gdb-2`
	srcdir=${local_path}/obj/`ls ${local_path}/obj | grep gdb-src`
    else
	echo "dejagnu *** [gdb] try -x gdb or -x binutils"
	exit 1
    fi

    [ $test_elf = 0 ] && generate_gcc_dejagnu_sshcp || generate_dejagnu_mips_elf
    generate_gcc_dejagnu_site
    generate_runtest
    generate_sshcp_gdb $srcdir

#dejagnu running
    get_result gdb $rundir
}

#LTP
run_ltp()
{
    ssh root@${targetip} "cd /usr; ./runltp 1>ltp.log"
}


run_glibc()
{
    [ "$multilib"x = ""x ] && multilib=default

    glibc_src_dir=${local_path}/src/`ls ${local_path}/src | grep glibc-2`
    glibc_obj_dir=${local_path}/obj/`ls ${local_path}/obj | grep glibc-2`/${multilib}

    if [ ! -d ${glibc_src_dir} ] || [ ! -d ${glibc_obj_dir} ];then
	echo -e "glibc *** check exist dir ${glibc_src_dir}"
	echo -e "glibc *** check exist dir ${glibc_obj_dir}"
	exit 1
    fi
    pushd ${glibc_src_dir}/scripts
    patch -p1 < \
	  ${local_path}/locals/tlchtest/patchs/0001-Glibc-cross-test-ssh.sh-port.patch
    popd

    pushd ${glibc_obj_dir}
    make V=1 test-wrapper="${glibc_src_dir}/scripts/cross-test-ssh.sh root@${targetip} port $sshport"  tests 2>&1 | tee glibc-test-${multilib}.log
    popd

    pushd ${glibc_src_dir}/scripts
    patch -R -p1 < \
	  ${local_path}/locals/tlchtest/patchs/0001-Glibc-cross-test-ssh.sh-port.patch
    popd

}
