#!/bin/bash

_generate_dejagnu_exps()
{
    export run_dir src_dir

    local sshcpfile="${dejagnu_dir}/sshcp.exp"
    local sitefile="${dejagnu_dir}/site.exp"
    local runtestfile="${dejagnu_dir}/runtest.sh"
    local sde_elf_standard="${dejagnu_dir}/standard.exp"

    sh ${work_path}/dejagnu/site.sh $1 > ${sitefile}
    sh  ${work_path}/dejagnu/sshcp.sh   $1 > ${sshcpfile}
    if [ "$toolchain_target"x = "mips-sde-elf"x ];then
	cat ${work_path}/dejagnu/mips-idt.exp > ${sshcpfile}
	cat ${work_path}/dejagnu/standard.exp > ${sde_elf_standard}
    fi
    sh  ${work_path}/dejagnu/runtest.sh "inside" > ${runtestfile}

    sed -i -f ${work_path}/dejagnu/localenv.sed \
	${sitefile} \
	${sshcpfile} \
	${runtestfile}

    check_run "chmod +x ${runtestfile}"
    check_run "cp ${runtestfile} ${run_dir}"
}

_dejagnu_gas()
{
    run_dir=${local_path}/obj/`ls ${local_path}/obj | grep binutils-2.*${objectdir_suffix}.*`
    src_dir=${local_path}/obj/`ls ${local_path}/obj | grep binutils-src.*${objectdir_suffix}.*`
    toolchain_target_internal=$(echo ${toolchain_target_internal} | sed "s/mips/mipsel-*/")

    export toolchain_target_internal
    _generate_dejagnu_exps gas
}

_dejagnu_gcc()
{
    run_dir=${local_path}/obj/`ls ${local_path}/obj | grep gcc-2.*${objectdir_suffix}.*`

    _generate_dejagnu_exps gcc
}

_dejagnu_gdb()
{
    if [ "$gdbtype"x = "binutils"x ];then
	run_dir=${local_path}/obj/`ls ${local_path}/obj | grep binutils-2.*${objectdir_suffix}.*`
	src_dir=${local_path}/obj/`ls ${local_path}/obj | grep binutils-src.*${objectdir_suffix}.*`

    elif [ "$gdbtype"x = "gdb"x ];then
	run_dir=${local_path}/obj/`ls ${local_path}/obj | grep gdb-2.*${objectdir_suffix}.*`
	src_dir=${local_path}/obj/`ls ${local_path}/obj | grep gdb-src.*${objectdir_suffix}.*`
    else
	echo "dejagnu *** [gdb] try -x gdb or -x binutils"
	exit 1
    fi


    _generate_dejagnu_exps gdb
}

_dejagnu_base_run()
{
    local project=$1
    pushd ${run_dir}

    echo "Dejagnu [$run_dir] ... "
    vexe "./runtest.sh"
    if [ "$project"x == "gas"x ];then
	mkdir -p ${outputdir}/${project}
	find . -regextype posix-extended -regex '.*/(binutils|ld|gas|sim)\.(log|sum)' \
	     -exec cp {} ${outputdir}/${project} \;
    else
	cp -rfda ${run_dir}/${project}/testsuite \
	   ${outputdir}/${project}
    fi
    echo "Dejagnu [$run_dir] finish"

    popd
}

dejagnu_running()
{
    local project=$1
    local case=$2

    if [ "$project"x = "gcc"x ]; then
	check_run "_dejagnu_gcc"
	check_run "_dejagnu_base_run gcc"
    elif [ "$project"x = "gas"x ]; then
	_dejagnu_gas
	_dejagnu_base_run gas
    elif [ "$project"x = "gdb"x ]; then
	_dejagnu_gdb
	_dejagnu_base_run gdb
    fi
}
