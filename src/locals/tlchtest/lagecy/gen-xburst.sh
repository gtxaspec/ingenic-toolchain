#!/bin/bash
SP=$(dirname $_)
set -e
work_path=`pwd`

toolchain_path=${install_path}/bin
testsrc_top_path=/home2/qianliu/work/toolchains/develop/mips-201511-5.2/src/gcc-5-2015.11
testsrc_sub_path=gcc/testsuite
testsrc_path=${testsrc_top_path}/${testsrc_sub_path}
toolchain_target=mips-linux-gnu

base_path=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
path=${toolchain_path}:${base_path}

time_tmp=$(date +%Y%m%d-%H)
tmp_dir=/tmp/dej-${time_tmp}
special_test=

verbose=0
cxxflags=
cflags=
ldflags=


pushvar()
{
    local push_var=$1
    local push_newval="$2"
    eval $push_var="$push_newval"
}

usage()
{
    echo -e "Usage: `basename $0`
\t -t :remote target [qemu/board]
\t -h help
\t -v verbose
\t -s special testcase
\t   exp: -s mips.exp=va-arg-1.c

"
    exit 0
}

parse()
{
    while getopts "hvs:" opt
    do
	case $opt in
	    v)
		verbose=1 ;;
	    s)
		special_test=$OPTARG ;;

	    h) usage ;;
	    \?)
		usage ;;
	esac
    done
}

prepare_env()
{
    testenv=${work_path}/running_dejangnu
    mkdir -p ${testenv}/dejagnu

    export PATH=${path}
    export DEJAGNU=${local_dejagnu}/site.exp
}

dej_runtest()
{
    local project=$1
    local out_dir=${outputdir}/${project}
    local obj_dir="${toolchain_path}/../${toolchain_target}/bin/./"
    local src_dir="${testsrc_path}"

    local tool="${project}"
    local tool_exec="${toolchain_target}-${tool}"

    runtest --srcdir  ${src_dir} \
	    --outdir ${out_dir}  \
	    --objdir ${obj_dir} \
	    -tool ${tool} \
	    --tool_exec ${tool_exec} \
	    --target ${toolchain_target}  \
	    --target_board sshscp \
	    -v -v \
	    ${special_test}
}

parse $@
source ${SP}/gen-dejagnu.sh

echo "--------------"
pushvar testsrc_path /home2/ljia/work/Ingenic/toolchain-test/toolchain-src/ing-5.2/gcc/testsuite
pushvar toolchain_path /home2/qianliu/work/toolchains/develop/mips-201708-7.2/torelease/install/opt/codesourcery/bin
pushvar toolchain_target  mips-linux-gnu
pushvar cflags "\"-mmsa -mfusion\""
pushvar ldflags "\"-mmsa -mfusion\""
pushvar cxxflags "\"-mmsa -mfusion\""
pushvar sshport 2026
pushvar targetip 192.168.4.15

pushd ${local_dejagnu}

vexe dej_runtest gcc
vexe dej_runtest g++
vexe dej_runtest gfortran

popd
