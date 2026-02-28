#!/bin/bash

board=dorado_v22
targetip="192.168.4.168"
getty_port="ttyS1"
rootfsdir=/home/nfsroot/fpga/user/qianliu/rootfs/test
local_path=$(dirname $(dirname `pwd`))
work_path=`pwd`
#time_stamp=$(date +%Y%m%d-%H%M%S)
time_stamp=$(date +%Y%m%d-%H)
outputdir=${local_path}/output/${time_stamp}
testenv=${local_path}/testenv
dejagnu_dir=${testenv}/dejagnu
toolchain_target=mips-linux-gnu
objectdir_suffix=mips-linux
base_path="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"


target_environment="mensa"
gcc_version="72"
buildroot_version="2012"

install_path="${local_path}/install"
gdb_src_dir=
gas_src_dir=

cflags=
ldflags=
test_elf=0
dejagnu_special='$1'
syncenv=n
kernel=n
uboot=n
rootfs=n
dejagnugcc=n
dejagnugas=n
dejagnugdb=n
runltp=n
syncuboot=0
synckernel=0
syncrootfs=0
verbose=0
multilib=
sshport=22
runglibc=0
host=`whoami`@`hostname -I`
host=`echo $host | sed "s/[[:space:]]//g"`
outside=n

usage()
{
    echo -e "Usage: `basename $0`
\t -s repo sync
\t -k kernel
\t -u uboot
\t -r rootfs
\t -p getty [ttyS1]
\t -b board [dorado_v22]
\t -t targetip [192.168.4.168]
\t -d dir of rootfs
\t -i set toolchain absolute install path, default is:
\t    ${install_path}
\t -c test dejagnu gcc
\t -z test dejagnu gas
\t -x test dejagnu gdb
\t   -x gdb       gdb from gdb source
\t   -x binutils  gdb from binutils source
\t -l test dejagnu ltp
\t -e test sde-elf toolchain
\t -a special dejagnu testsuite
\t   -a mips.exp or -a mips.exp=mxu2.c va-arg-1.c
\t -f set dejagnu CFLAGS
\t    multi '-f' for multi flags:
\t        -f \"-mmsa\" -f \"-mfused-madd\"
\t -v verbose
\t -m multilib eg:
\t     sde-elf: -m fp32   / -m sof
\t     linux:   -m mfp32 / -m msoft-float
\t -P port for ssh, default is 22
\t -j test glibc source
\t -o outside test module
\t -g dejagnu exp generate dirs
\t   default is ${dejagnu_dir}
"

    exit 0
}

parse()
{
    while getopts "jg:va:b:cd:ef:hklp:rst:ux:zm:P:oi:" opt
    do
	case $opt in
	    g)
		dejagnu_dir=$OPTARG
		;;
	    P)
		sshport=$OPTARG ;;
	    o)
		outside=y ;;
	    a)
		dejagnu_special=$OPTARG ;;
	    k)
		kernel=y ;;
	    u)
		uboot=y ;;
	    r)
		rootfs=y ;;
	    b)
		board=$OPTARG ;;
	    t)
		targetip=$OPTARG ;;
	    p)
		getty_port=$OPTARG ;;
	    d)
		rootfsdir=$OPTARG ;;
	    c)
		dejagnugcc=y ;;
	    z)
		dejagnugas=y ;;
	    x)
		gdbtype=$OPTARG
		dejagnugdb=y ;;
	    l)
		runltp=y ;;
	    s)
		syncenv=y ;;
	    e)
		test_elf=1
		toolchain_target=mips-sde-elf
		objectdir_suffix=mips-sde
		;;
	    f)
		cflags+="$OPTARG "
		;;
	    m)
		multilib=$OPTARG;;
	    v)
		verbose=1;;
	    j)
		runglibc=y;;
	    i)
		install_path=$OPTARG;;
	    h) usage ;;
	    \?)
		usage ;;
	esac
    done
}

parse $@

mkdir -p ${outputdir}
mkdir -p ${dejagnu_dir}

if [ "$outside"x = "y"x ];then
    if [ -e "${install_path}/bin/${toolchain_target}-gcc" ];then
	install_path="${install_path}"
    elif [ -e "${install_path}/opt/codesourcery/bin/${toolchain_target}-gcc" ];then
	 install_path="${install_path}/opt/codesourcery"
    else
	echo "can't find install."
	exit 1
    fi
else
    if [ -e "${install_path}/bin/${toolchain_target}-gcc" ] &&
	   [ -e "${local_path}/obj" ];then
	install_path="${install_path}"
    elif [ -e "${install_path}/opt/codesourcery/bin/${toolchain_target}-gcc" ] &&
	     [ -e "${local_path}/obj" ];then
	install_path="${install_path}/opt/codesourcery"
    else
	echo "can't find install."
	exit 1
    fi
fi

absolute_compiler_prefix="${install_path}/bin/${toolchain_target}-"
absolute_gcc_prefix="${absolute_compiler_prefix}gcc"
absolute_gxx_prefix="${absolute_compiler_prefix}g++"
CROSS_COMPILE="${absolute_compiler_prefix}"
path="${install_path}/bin:${base_path}"
buildroot_cflags=$cflags
# For gas test, should instead mips* with mipsel*
toolchain_target_internal=$toolchain_target
export CROSS_COMPILE
export absolute_gcc_prefix
export absolute_gxx_prefix
export sshport
export targetip
export cflags
export path
export dejagnu_dir
export toolchain_target
export gdb_src_dir
export gas_src_dir
export dejagnu_special
export install_path
export multilib
#source ${local_path}/locals/tlchtest/pretest.sh
source ${local_path}/locals/tlchtest/basic-function.sh
source ${local_path}/locals/tlchtest/envbuilds.sh
source ${local_path}/locals/tlchtest/gen-dejagnu.sh
source ${local_path}/locals/tlchtest/gen-outside-dejagnu.sh

remove_ssh_known_host()
{
    if [ "$sshport" = "22" ];then
	sed -i  "/^${targetip}/d" $HOME/.ssh/known_hosts
    else
	sed -i "/^\[${targetip}\]:${sshport}/d" $HOME/.ssh/known_hosts
    fi
}

if [ $test_elf = 0 ];then
    if [ $uboot = y ];then
	syncuboot=1
	syncenv=1
    fi

    if [ $kernel = y ];then
	synckernel=1
	syncenv=1
    fi

    if [ $rootfs = y ];then
	syncrootfs=1
	syncenv=1
    fi

    #sync testenv
    [ $syncenv = 1 ] && syncEnvSource

    #build uboot
    test ${uboot}  != y || (echo "----- build uboot" &&  (build_uboot))
    [ $? != 0 ] && exit 1
    #build kernel
    test ${kernel} != y || (echo "----- build kernel" && (build_kernel))
    [ $? != 0 ] && exit 1
    #build rootfs
    test ${rootfs} != y || (echo "----- build rootfs" && (build_rootfs))
    [ $? != 0 ] && exit 1

    #Are you ready to test

    if  [ $dejagnugcc = 'y' ] || [ $dejagnugas = 'y' ] ||
	    [ $dejagnugdb = 'y' ] || [ $runglibc = 'y' ];then
	if [ $test_elf = 0 ];then
	    yes_or_no "Have get env in output, are you ready to test"

            # config public key
	    yes_or_no "ssh connect target [ ${targetip} ]. Continue?"
	    remove_ssh_known_host
	    touch /tmp/a
	    vexe ${local_path}/locals/tlchtest/sshcheck.exp ${targetip} ${sshport}
	    [ $? != 0 ] && {
		rm /tmp/a
		yes_or_no "SSH *** [ connect ] ${targetip} Error, continue?"
	    }
	    rm /tmp/a
	fi
    fi

fi
if [ $outside = 'n' ];then
    [ $dejagnugas = 'y' ] && dejagnu_running gas
    [ $dejagnugcc = 'y' ] && dejagnu_running gcc
    [ $dejagnugdb = 'y' ] && dejagnu_running gdb
elif [ $outside = 'y' ];then
    [ $dejagnugas = 'y' ] && dejagnu_outside_running gas
    [ $dejagnugcc = 'y' ] && dejagnu_outside_running gcc
    [ $dejagnugdb = 'y' ] && dejagnu_outside_running gdb
fi

[ $test_elf = 0 ] && [ $runltp = 'y' ]  &&  run_ltp
[ $test_elf = 0 ] && [ $runglibc = 'y' ]  && run_glibc
