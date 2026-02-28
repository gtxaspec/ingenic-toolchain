#! /usr/bin/env bash
# This file contains the complete sequence of commands
# Mentor Graphics used to build this version of Sourcery CodeBench.
#
# For each free or open-source component of Sourcery CodeBench,
# the source code provided includes all of the configuration
# scripts and makefiles for that component, including any and
# all modifications made by Mentor Graphics.  From this list of
# commands, you can see every configuration option used by
# Mentor Graphics during the build process.
#
# This file is provided as a guideline for users who wish to
# modify and rebuild a free or open-source component of
# Sourcery CodeBench from source. For a number of reasons,
# though, you may not be able to successfully run this script
# directly on your system. Certain aspects of the Mentor Graphics
# build environment (such as directory names) are included in
# these commands. Mentor Graphics uses Canadian cross compilers so
# you may need to modify various configuration options and paths
# if you are building natively. This sequence of commands
# includes those used to build proprietary components of
# Sourcery CodeBench for which source code is not provided.
#
# Please note that Sourcery CodeBench support covers only your
# use of the original, validated binaries provided as part of
# Sourcery CodeBench -- and specifically does not cover either
# the process of rebuilding a component or the use of any
# binaries you may build.  In addition, if you rebuild any
# component, you must not use the --with-pkgversion and
# --with-bugurl configuration options that embed Mentor Graphics
# trademarks in the resulting binary; see the "Mentor Graphics
# Trademarks" section in the Sourcery CodeBench Software
# License Agreement.
set -e
inform_fd=2
umask 022
exec < /dev/null
export JX=-j24
local_path=`pwd`

local_arch=64
if [ `uname -m`x = "i686"x ]; then
    local_arch=32
else
    local_arch=64
fi


error_handler ()
{
   exit 1
}

check_status() {
    local status="$?"
    if [ "$status" -ne 0 ]; then
	error_handler
    fi
}

check_pipe() {
    local -a status=("${PIPESTATUS[@]}")
    local limit=$1
    local ix

    if [ -z "$limit" ] ; then
	limit="${#status[@]}"
    fi
    for ((ix=0; ix != $limit ; ix++)); do
	if [ "${status[$ix]}" != "0" ] ; then
	    error_handler
	fi
    done
}

error () {
    echo "$script: error: $@" >& $inform_fd
    exit 1
}

nonfatal_error () {
    echo "$script: error: $@" >& $inform_fd
}

warning () {
    echo "$script: warning: $@" >& $inform_fd
}

verbose () {
    if $gnu_verbose; then
	echo "$script: $@" >& $inform_fd
    fi
}

copy_dir() {
    mkdir -p "$2"

    (cd "$1" && tar cf - .) | (cd "$2" && tar xf -)
    check_pipe
}

copy_dir_if_present() {
    if [ ! -d "$1" ]; then
	return
    fi
    copy_dir "$1" "$2"
}

copy_dir_clean() {
    mkdir -p "$2"
    (cd "$1" && tar cf - \
	--exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc \
	--exclude="*~" --exclude=".#*" \
	--exclude="*.orig" --exclude="*.rej" \
	.) | (cd "$2" && tar xf -)
    check_pipe
}

copy_dir_clean_if_present() {
    if [ ! -d "$1" ]; then
        return
    fi
    copy_dir_clean "$1" "$2"
}

update_dir_clean() {
    mkdir -p "$2"


    (cd "$1" && tar cf - \
	--exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc \
	--exclude="*~" --exclude=".#*" \
	--exclude="*.orig" --exclude="*.rej" \
	--after-date="$3" \
	. 2> /dev/null) | (cd "$2" && tar xf -)
    check_pipe
}

copy_dir_exclude() {
    local source="$1"
    local dest="$2"
    local excl="$3"
    shift 3
    mkdir -p "$dest"
    (cd "$source" && tar cfX - "$excl" "$@") | (cd "$dest" && tar xf -)
    check_pipe
}

copy_dir_only() {
    local source="$1"
    local dest="$2"
    shift 2
    mkdir -p "$dest"
    (cd "$source" && tar cf - "$@") | (cd "$dest" && tar xf -)
    check_pipe
}

check_mentor_trademarks ()
{
    local cfg_script="$1/configure"
    shift
    local have_mentor_trademark=false
    local c
    for c in "$@"; do
	case "$c" in
	    (--with-pkgversion=*[Ss]ourcery*)
		have_mentor_trademark=true
		;;
	    (--with-bugurl=*[Ss]ourcery*)
		have_mentor_trademark=true
		;;
	    (*)
		;;
	esac
    done
    if "$have_mentor_trademark"; then
	case $(dnsdomainname) in
	    (*.mentorg.com)
		"$cfg_script" "$@"
		;;
	    (*)
		error "If you rebuild any component, you must not use the" \
		    "--with-pkgversion and --with-bugurl configuration" \
		    "options that embed Mentor Graphics trademarks in the" \
		    "resulting binary; see the \"Mentor Graphics" \
		    "Trademarks\" section in the Software License Agreement."
		;;
	esac
    else
	"$cfg_script" "$@"
    fi
}

clean_environment() {
    local env_var_list
    local var




    unset BASH_ENV CDPATH POSIXLY_CORRECT TMOUT

    env_var_list=$(export | \
	grep '^declare -x ' | \
	sed -e 's/^declare -x //' -e 's/=.*//')

    for var in $env_var_list; do
	case $var in
	    HOME|HOSTNAME|LOGNAME|PWD|SHELL|SHLVL|SSH_*|TERM|USER)


		;;
	    LD_LIBRARY_PATH|PATH| \
		FLEXLM_NO_CKOUT_INSTALL_LIC|LM_APP_DISABLE_CACHE_READ)


		;;
	    CSL_CONFIG_SUB)

		;;
	    MAKEINFO)

		;;
	    *_LICENSE_FILE)













		if false; then
		    local license_file_envvar
		    license_file_envvar=

		    if [ "$var" != "$license_file_envvar" ]; then
			export -n "$var" || true
		    fi
		else
		    export -n "$var" || true
		fi
		;;
	    *)

		export -n "$var" || true
		;;
	esac
    done


    export LANG=C
    export LC_ALL=C


    export CVS_RSH=ssh



    user_shell=$SHELL
    export SHELL=$BASH
    export CONFIG_SHELL=$BASH
}

pushenv() {
    pushenv_level=$(($pushenv_level + 1))
    eval pushenv_vars_${pushenv_level}=
}


pushenv_level=0
pushenv_vars_0=



pushenvvar() {
    local pushenv_var="$1"
    local pushenv_newval="$2"
    eval local pushenv_oldval=\"\$$pushenv_var\"
    eval local pushenv_oldset=\"\${$pushenv_var+set}\"
    local pushenv_save_var=saved_${pushenv_level}_${pushenv_var}
    local pushenv_savep_var=savedp_${pushenv_level}_${pushenv_var}
    eval local pushenv_save_set=\"\${$pushenv_savep_var+set}\"
    if [ "$pushenv_save_set" = "set" ]; then
	error "Pushing $pushenv_var more than once at level $pushenv_level"
    fi
    if [ "$pushenv_oldset" = "set" ]; then
	eval $pushenv_save_var=\"\$pushenv_oldval\"
    else
	unset $pushenv_save_var
    fi
    eval $pushenv_savep_var=1
    eval export $pushenv_var=\"\$pushenv_newval\"
    local pushenv_list_var=pushenv_vars_${pushenv_level}
    eval $pushenv_list_var=\"\$$pushenv_list_var \$pushenv_var\"
}

prependenvvar() {
    local pushenv_var="$1"
    local pushenv_newval="$2"
    eval local pushenv_oldval=\"\$$pushenv_var\"
    pushenvvar "$pushenv_var" "$pushenv_newval$pushenv_oldval"
}

popenv() {
    local pushenv_var=
    eval local pushenv_vars=\"\$pushenv_vars_${pushenv_level}\"
    for pushenv_var in $pushenv_vars; do
	local pushenv_save_var=saved_${pushenv_level}_${pushenv_var}
	local pushenv_savep_var=savedp_${pushenv_level}_${pushenv_var}
	eval local pushenv_save_val=\"\$$pushenv_save_var\"
	eval local pushenv_save_set=\"\${$pushenv_save_var+set}\"
	unset $pushenv_save_var
	unset $pushenv_savep_var
	if [ "$pushenv_save_set" = "set" ]; then
	    eval export $pushenv_var=\"\$pushenv_save_val\"
	else
	    unset $pushenv_var
	fi
    done
    unset pushenv_vars_${pushenv_level}
    if [ "$pushenv_level" = "0" ]; then
	error "Popping environment level 0"
    else
	pushenv_level=$(($pushenv_level - 1))
    fi
}

link_dir ()
{
    local source_dir="$1"
    local target_dir="$2"

    local absolute_source_dir=false
    if echo "$source_dir" | egrep -q '^/'; then
	absolute_source_dir=true
    fi

    if ! $absolute_source_dir && [ $target_dir != "." ]; then
	error "source_dir must be an absolute path or target_dir must be ."
    fi

    local f
    for f in $source_dir/*; do
	ln -s "$f" "$target_dir"
    done
}

prepend_path() {
    if $(eval "test -n \"\$$1\""); then
	prependenvvar "$1" "$2:"
    else
	prependenvvar "$1" "$2"
    fi
}

deb_extract() {
    set -x
    local deb=$1
    local suffix=$2
    local opts

    case $suffix in
	(gz)
	    opts="zxf"
	    ;;
	(xz)
	    opts="Jxf"
	    ;;
	(*)
	    error "deb_extract: unhandled suffix $suffix"
	    ;;
    esac
    ar p "$deb" data.tar."$suffix" | tar "$opts" -
}
pushenvvar CSL_SCRIPTDIR ${local_path}/src/scripts-trunk
pushenvvar LD_LIBRARY_PATH /usr/local/lib:/usr/local/lib64
pushenvvar FLEXLM_NO_CKOUT_INSTALL_LIC ''
pushenvvar LM_APP_DISABLE_CACHE_READ ''
pushenvvar MAKEINFO 'makeinfo --css-ref=../cs.css'
pushenvvar CSL_CONFIG_SUB ${local_path}/src/config-trunk/config.sub
clean_environment

echo "----------------# task [001/397] /init/dirs"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
mkdir -p ${local_path}/obj
mkdir -p ${local_path}/install/opt/codesourcery
mkdir -p ${local_path}/pkg
mkdir -p ${local_path}/logs/data
mkdir -p ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html
mkdir -p ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf
popenv

echo "----------------# task [002/397] /init/cleanup"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/pkg/mips-2015.11-32-mips-linux-gnu.src.tar.bz2 ${local_path}/pkg/mips-2015.11-32-mips-linux-gnu.backup.tar.bz2
popenv

echo "----------------# task [003/397] /init/build_p2_repogenerator"
echo "----------------# task [004/397] /init/source_package/binutils"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/binutils-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src

#touch binutils-2015.11/*
popd
popenv

echo "----------------# task [005/397] /init/source_package/gcc"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/gcc-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch gcc-5-2015.11/*
popd
popenv

echo "----------------# task [006/397] /init/source_package/gdb"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/gdb-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch gdb-2015.11/*
popd
popenv

echo "----------------# task [007/397] /init/source_package/zlib"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/zlib-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch zlib-1.2.8/*
popd
popenv

echo "----------------# task [008/397] /init/source_package/gmp"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/gmp-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch gmp-2015.11/*
popd
popenv

echo "----------------# task [009/397] /init/source_package/mpfr"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/mpfr-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
touch mpfr-2015.11/*
popd
popenv

echo "----------------# task [010/397] /init/source_package/mpc"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/mpc-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
touch mpc-2015.11/*
popd
popenv

echo "----------------# task [011/397] /init/source_package/isl"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/isl-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
touch isl-0.14/*
popd
popenv

echo "----------------# task [012/397] /init/source_package/ncurses"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/ncurses-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch ncurses-5.9/*
popd
popenv

echo "----------------# task [013/397] /init/source_package/getting_started"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/getting_started-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [014/397] /init/source_package/p2_installer"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/p2_installer-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [015/397] /init/source_package/fbench"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/fbench-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
popd
popenv

echo "----------------# task [016/397] /init/source_package/sprite"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/sprite-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [017/397] /init/source_package/mips_sprite"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/mips_sprite-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [018/397] /init/source_package/uclibc"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/uclibc-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch uclibc-2015.11/*
popd
popenv

echo "----------------# task [019/397] /init/source_package/qemu"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/qemu-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch qemu-2.2-2015.11/*
popd
popenv

echo "----------------# task [020/397] /init/source_package/glibc"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/glibc-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch glibc-2.22-2015.11/*
popd
popenv

echo "----------------# task [021/397] /init/source_package/linux"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/linux-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch linux-2015.11/*
popd
popenv

echo "----------------# task [022/397] /init/source_package/dejagnu_boards"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/dejagnu_boards-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [023/397] /init/source_package/scripts"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/scripts-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [024/397] /init/source_package/xfails"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/xfails-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [025/397] /init/source_package/portal"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/portal-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [026/397] /init/source_package/config"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/config-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
popd
popenv

echo "----------------# task [027/397] /init/source_package/csl_tests"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/csl_tests-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [028/397] /init/source_package/libiconv"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/libiconv-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch libiconv-1.14/*
popd
popenv

echo "----------------# task [029/397] /init/source_package/expat"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/expat-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch expat-2015.11/*
popd
popenv

echo "----------------# task [030/397] /init/source_package/csl_docbook"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/csl_docbook-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [031/397] /init/source_package/release_notes"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/release_notes-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [032/397] /init/source_package/eclipse_common"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/eclipse_common-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [033/397] /init/source_package/p2_repogenerator"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/p2_repogenerator-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

#fi #debug
echo "----------------# task [034/397] /init/source_package/make"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/make-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch make-3.81/*
popd
popenv

echo "----------------# task [035/397] /init/source_package/coreutils"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/coreutils-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
popd
popenv

echo "----------------# task [036/397] /init/source_package/gdil"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/gdil-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [037/397] /init/source_package/edge_utils"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/edge_utils-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [038/397] /init/source_package/cs3"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/cs3-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [039/397] /init/source_package/uclibc_configs"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup/uclibc_configs-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.backup
pushd ${local_path}/src
popd
popenv

echo "----------------# task [040/397] /init/source_package/glib"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/glib-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch glib-2.44.1/*
popd
popenv

echo "----------------# task [041/397] /init/source_package/pixman"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/pixman-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch pixman-0.32.6/*
popd
popenv

echo "----------------# task [042/397] /init/source_package/libfdt"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/libfdt-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch libfdt-2015.11/*
popd
popenv

echo "----------------# task [043/397] /init/source_package/libffi"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/libffi-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch libffi-3.2.1/*
popd
popenv

echo "----------------# task [044/397] /init/source_package/gettext"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu/gettext-2015.11-32.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
#touch gettext-0.18.1.1/*
popd
popenv

echo "----------------# task [045/397] /i686-pc-linux-gnu/host_cleanup"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
popenv

echo "----------------# task [046/397] /i686-pc-linux-gnu/zlib_first/host_cleanup"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -rf ${local_path}/obj/zlib-first-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/zlib-1.2.8 ${local_path}/obj/zlib-first-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/zlib-first-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
popenv

echo "----------------# task [047/397] /i686-pc-linux-gnu/zlib_first/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/zlib-first-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushenv
pushenvvar CFLAGS '-O3 -fPIC'
pushenvvar CC 'gcc  '
pushenvvar AR 'ar '
pushenvvar RANLIB 'ranlib '
./configure --prefix=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --static
popenv
popd
popenv

echo "----------------# task [048/397] /i686-pc-linux-gnu/zlib_first/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/zlib-first-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX
popd
popenv

echo "----------------# task [049/397] /i686-pc-linux-gnu/zlib_first/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/zlib-first-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make install
popd
popenv

echo "----------------# task [050/397] /i686-pc-linux-gnu/gmp/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CFLAGS '-g -O2'
rm -rf ${local_path}/obj/gmp-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/gmp-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/gmp-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/gmp-2015.11 --prefix=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared ABI=${local_arch}
popd
popenv
popenv
popenv

echo "----------------# task [051/397] /i686-pc-linux-gnu/gmp/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CFLAGS '-g -O2'
pushd ${local_path}/obj/gmp-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [052/397] /i686-pc-linux-gnu/gmp/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CFLAGS '-g -O2'
pushd ${local_path}/obj/gmp-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [053/397] /i686-pc-linux-gnu/gmp/postinstall"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CFLAGS '-g -O2'
pushd ${local_path}/obj/gmp-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo "----------------# task [054/397] /i686-pc-linux-gnu/mpfr/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf ${local_path}/obj/mpfr-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/mpfr-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/mpfr-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/mpfr-2015.11 --prefix=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-linux-gnu --host=i686-pc-linux-gnu --disable-nls --with-gmp=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo "----------------# task [055/397] /i686-pc-linux-gnu/mpfr/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/mpfr-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [056/397] /i686-pc-linux-gnu/mpfr/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/mpfr-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [057/397] /i686-pc-linux-gnu/mpfr/postinstall"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/mpfr-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo "----------------# task [058/397] /i686-pc-linux-gnu/mpc/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf ${local_path}/obj/mpc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/mpc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/mpc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/mpc-2015.11 --prefix=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-linux-gnu --host=i686-pc-linux-gnu --disable-nls --with-gmp=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo "----------------# task [059/397] /i686-pc-linux-gnu/mpc/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/mpc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [060/397] /i686-pc-linux-gnu/mpc/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/mpc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [061/397] /i686-pc-linux-gnu/mpc/postinstall"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/mpc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo "----------------# task [062/397] /i686-pc-linux-gnu/isl/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf ${local_path}/obj/isl-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/isl-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/isl-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/isl-0.14 --prefix=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-linux-gnu --host=i686-pc-linux-gnu --disable-nls --with-gmp-prefix=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo "----------------# task [063/397] /i686-pc-linux-gnu/isl/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/isl-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [064/397] /i686-pc-linux-gnu/isl/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/isl-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [065/397] /i686-pc-linux-gnu/isl/postinstall"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/isl-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo "----------------# task [066/397] /i686-pc-linux-gnu/toolchain/binutils/copy"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf ${local_path}/obj/binutils-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/binutils-2015.11 ${local_path}/obj/binutils-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/binutils-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
touch ${local_path}/obj/binutils-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv

echo "----------------# task [067/397] /i686-pc-linux-gnu/toolchain/binutils/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/obj/binutils-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu --prefix=/opt/codesourcery --build=i686-pc-linux-gnu --target=mips-linux-gnu --host=i686-pc-linux-gnu --disable-gdb --disable-libdecnumber --disable-readline --disable-sim '--with-pkgversion=Ingenic 2016.03-32' --disable-nls --with-sysroot=/opt/codesourcery/mips-linux-gnu/libc --enable-poison-system-directories --enable-plugins
popd
popenv
popenv
popenv

echo "----------------# task [068/397] /i686-pc-linux-gnu/toolchain/binutils/libiberty"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX all-libiberty
popd
copy_dir_clean ${local_path}/src/binutils-2015.11/include ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/include
chmod -R u+w ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/include
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/lib
cp ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/libiberty/libiberty.a ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/lib
popenv
popenv
popenv

echo "----------------# task [069/397] /i686-pc-linux-gnu/toolchain/binutils/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX 2>&1 |tee binutils_build.log
popd
popenv
popenv
popenv

echo "----------------# task [070/397] /i686-pc-linux-gnu/toolchain/binutils/install\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make install prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man datadir=${local_path}/install/opt/codesourcery/share 2>&1|tee binutils_install.log
popd
popenv
popenv
popenv

echo "----------------# task [071/397] /i686-pc-linux-gnu/toolchain/binutils/postinstall"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/install/opt/codesourcery
popd
pushd ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man datadir=${local_path}/install/opt/codesourcery/share install-html
popd
pushd ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man datadir=${local_path}/install/opt/codesourcery/share install-pdf
popd
cp ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/bfd/.libs/libbfd.a ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/lib
cp ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/bfd/bfd.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/include
cp ${local_path}/src/binutils-2015.11/bfd/elf-bfd.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/include
cp ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/opcodes/.libs/libopcodes.a ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/lib
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/binutils
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/binutils/bfdtest1 ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/binutils/
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/binutils
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/binutils/bfdtest2 ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/binutils/
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/ld/libldtestplug.la ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/ld/libldtestplug2.la ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/ld/libldtestplug2_la-testplug2.lo ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/ld/libldtestplug2_la-testplug2.o ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/ld/libldtestplug3.la ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/ld/libldtestplug3_la-testplug3.lo ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/ld/libldtestplug3_la-testplug3.o ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/ld/libldtestplug_la-testplug.lo ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/ld/libldtestplug_la-testplug.o ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/ld/libtool ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/ld/.libs ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/configure.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/etc/configure.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/standards.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/etc/standards.pdf
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/bfd.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/bfd.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/bfd.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly bfd
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/libiberty.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/libiberty.pdf
rm -f ${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-ld.bfd
rm -f ${local_path}/install/opt/codesourcery/bin/ld.bfd
popenv
popenv
popenv


echo "----------------# task [072/397] /i686-pc-linux-gnu/toolchain/install_kernel_headers_glibc"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include/bits ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include/gnu
rm -rf ${local_path}/obj/linux-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/linux-2015.11 ${local_path}/obj/linux-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/linux-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/linux-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make ARCH=mips CROSS_COMPILE=${local_path}/install/opt/codesourcery/bin/mips-linux-gnu- INSTALL_HDR_PATH=${local_path}/obj/linux-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/tmp-install headers_install
pushd ${local_path}/obj/linux-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/tmp-install/include
copy_dir linux ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include/linux
copy_dir asm ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include/asm
copy_dir asm-generic ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include/asm-generic
copy_dir drm ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include/drm
copy_dir mtd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include/mtd
copy_dir rdma ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include/rdma
copy_dir sound ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include/sound
copy_dir video ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include/video
popd
popd
popenv

echo "----------------# task [073/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_0"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./
popenv

echo "----------------# task [074/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_1"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./
popenv

echo "----------------# task [075/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_2"
echo "----------------# task [076/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_3"
echo "----------------# task [077/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_4"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/
popenv

echo "----------------# task [078/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_5"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/
popenv

echo "----------------# task [079/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_6"
echo "----------------# task [080/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_7"
echo "----------------# task [081/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_8"
echo "----------------# task [082/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_9"
echo "----------------# task [083/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_10"
echo "----------------# task [084/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_11"
echo "----------------# task [085/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_12"
echo "----------------# task [086/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_13"
echo "----------------# task [087/397] /i686-pc-linux-gnu/toolchain/create_sysroot/glibc_14"
echo "----------------# task [088/397] /i686-pc-linux-gnu/toolchain/install_kernel_headers_uclibc"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/include ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/include/bits
rm -rf ${local_path}/obj/linux-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/linux-2015.11 ${local_path}/obj/linux-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/linux-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/linux-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make ARCH=mips CROSS_COMPILE=${local_path}/install/opt/codesourcery/bin/mips-linux-gnu- INSTALL_HDR_PATH=${local_path}/obj/linux-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/tmp-install headers_install
pushd ${local_path}/obj/linux-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/tmp-install/include
copy_dir linux ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/include/linux
copy_dir asm ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/include/asm
copy_dir asm-generic ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/include/asm-generic
copy_dir drm ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/include/drm
copy_dir mtd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/include/mtd
copy_dir rdma ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/include/rdma
copy_dir sound ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/include/sound
copy_dir video ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/include/video
popd
popd
popenv
echo "----------------# task [089/397] /i686-pc-linux-gnu/toolchain/create_sysroot/uclibc_0"
echo "----------------# task [090/397] /i686-pc-linux-gnu/toolchain/create_sysroot/uclibc_1"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/
popenv

echo "----------------# task [091/397] /i686-pc-linux-gnu/toolchain/create_sysroot/uclibc_2"
echo "----------------# task [092/397] /i686-pc-linux-gnu/toolchain/create_sysroot/uclibc_3"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/
popenv

echo "----------------# task [093/397] /i686-pc-linux-gnu/toolchain/create_sysroot/uclibc_4"
echo "----------------# task [094/397] /i686-pc-linux-gnu/toolchain/create_sysroot/uclibc_5"
echo "----------------# task [095/397] /i686-pc-linux-gnu/toolchain/gcc_first/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-linux-gnu-ar
pushenvvar NM_FOR_TARGET mips-linux-gnu-nm
pushenvvar OBJDUMP_FOR_TARET mips-linux-gnu-objdump
pushenvvar STRIP_FOR_TARGET mips-linux-gnu-strip
rm -rf ${local_path}/obj/gcc-first-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/gcc-first-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/gcc-first-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/gcc-5-2015.11 --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu --target=mips-linux-gnu --enable-threads --disable-libmudflap --disable-libssp --disable-libstdcxx-pch --with-arch-32=mips32r2 --with-arch-64=mips64r2 --with-float=hard --with-mips-plt --enable-extra-sgxxlite-multilibs --with-gnu-as --with-gnu-ld '--with-specs=-D__CS_SOURCERYGXX_MAJ__=2015 -D__CS_SOURCERYGXX_MIN__=11 -D__CS_SOURCERYGXX_REV__=32' --enable-languages=c,c++ --enable-shared --enable-lto --enable-symvers=gnu --enable-__cxa_atexit --with-glibc-version=2.22 '--with-pkgversion=Ingenic 2016.03-32'  --disable-nls --prefix=${local_path}/install/opt/codesourcery --disable-shared --disable-threads --disable-libssp --disable-libgomp --without-headers --with-newlib --disable-decimal-float --disable-libffi --disable-libquadmath --disable-libitm --disable-libatomic --enable-languages=c '' --with-sysroot=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc --with-build-sysroot=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc --with-gmp=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --with-mpc=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --with-isl=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --disable-libgomp --disable-libitm --disable-libatomic --disable-libssp --disable-libcc1 --enable-poison-system-directories --with-python-dir=mips-linux-gnu/share/gdb/python --with-build-time-tools=${local_path}/install/opt/codesourcery/mips-linux-gnu/bin --with-build-time-tools=${local_path}/install/opt/codesourcery/mips-linux-gnu/bin SED=sed
popd
popenv
popenv

echo "----------------# task [096/397] /i686-pc-linux-gnu/toolchain/gcc_first/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-linux-gnu-ar
pushenvvar NM_FOR_TARGET mips-linux-gnu-nm
pushenvvar OBJDUMP_FOR_TARET mips-linux-gnu-objdump
pushenvvar STRIP_FOR_TARGET mips-linux-gnu-strip
pushd ${local_path}/obj/gcc-first-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX LDFLAGS_FOR_TARGET=--sysroot=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc CPPFLAGS_FOR_TARGET=--sysroot=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc build_tooldir=${local_path}/install/opt/codesourcery/mips-linux-gnu 2>&1|tee gcc_first_build.log
popd
popenv
popenv

echo "----------------# task [097/397] /i686-pc-linux-gnu/toolchain/gcc_first/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-linux-gnu-ar
pushenvvar NM_FOR_TARGET mips-linux-gnu-nm
pushenvvar OBJDUMP_FOR_TARET mips-linux-gnu-objdump
pushenvvar STRIP_FOR_TARGET mips-linux-gnu-strip
pushd ${local_path}/obj/gcc-first-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man install 2>&1|tee gcc_first_install.log
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man install-html
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man install-pdf
popd
popenv
popenv

echo "----------------# task [098/397] /i686-pc-linux-gnu/toolchain/gcc_first/postinstall"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-linux-gnu-ar
pushenvvar NM_FOR_TARGET mips-linux-gnu-nm
pushenvvar OBJDUMP_FOR_TARET mips-linux-gnu-objdump
pushenvvar STRIP_FOR_TARGET mips-linux-gnu-strip
pushd ${local_path}/install/opt/codesourcery
rm include -rf
popd
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc/multilib_list.txt
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc
cat > ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc/multilib_list.txt <<'EOF0'
.;base;MIPS32 revision 2 - Little-Endian, O32
#64;addon;MIPS64 revision 2 - Big-Endian, N64
#el;addon;MIPS32 revision 2 - Little-Endian, O32
#el/64;addon;MIPS64 revision 2 - Little-Endian, N64
#soft-float;addon;MIPS32 revision 2 - Big-Endian, Soft-Float, O32
#soft-float/64;addon;MIPS64 revision 2 - Big-Endian, Soft-Float, N64
soft-float;addon;MIPS32 revision 2 - Little-Endian, Soft-Float, O32
#soft-float/el/64;addon;MIPS64 revision 2 - Little-Endian, Soft-Float, N64
#nan2008;addon;MIPS32 revision 2 - Big-Endian, 2008 NaN, O32
#nan2008/el;addon;MIPS32 revision 2 - Little-Endian, 2008 NaN, O32
#micromips/soft-float/el;addon;MIPS32 revision 2 - Little-Endian, Soft-Float, O32, microMIPS
#mips16;addon;MIPS32 revision 2 - Big-Endian, O32, MIPS16
#mips16/el;addon;MIPS32 revision 2 - Little-Endian, O32, MIPS16
#mips16/soft-float;addon;MIPS32 revision 2 - Big-Endian, Soft-Float, O32, MIPS16
#mips16/soft-float/el;addon;MIPS32 revision 2 - Little-Endian, Soft-Float, O32, MIPS16
#uclibc;addon;MIPS32 revision 2 - uClibc, Big-Endian, O32
uclibc;addon;MIPS32 revision 2 - uClibc, Little-Endian, O32
#uclibc/soft-float;addon;MIPS32 revision 2 - uClibc, Big-Endian, Soft-Float, O32
uclibc/soft-float;addon;MIPS32 revision 2 - uClibc, Little-Endian, Soft-Float, O32
#uclibc/nan2008;addon;MIPS32 revision 2 - uClibc, Big-Endian, 2008 NaN, O32
#uclibc/nan2008/el;addon;MIPS32 revision 2 - uClibc, Little-Endian, 2008 NaN, O32
EOF0
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/gccinstall ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/gcc/gccinstall.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/gccinstall.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly gccinstall
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/gccint ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/gcc/gccint.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/gccint.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly gccint
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/cppinternals ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/gcc/cppinternals.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/cppinternals.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly cppinternals
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/libiberty.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/libiberty.pdf
popenv
popenv
echo "----------------# task [099/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_0/copy"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -rf ${local_path}/obj/glibc-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/default/
copy_dir_clean ${local_path}/src/glibc-2.22-2015.11 ${local_path}/obj/glibc-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/default/
chmod -R u+w ${local_path}/obj/glibc-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/default/
touch ${local_path}/obj/glibc-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/default//.gnu-stamp
popenv

echo "----------------# task [100/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_1/copy"
echo "----------------# task [101/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_2/copy"
echo "----------------# task [102/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_3/copy"
echo "----------------# task [103/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_4/copy"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -rf ${local_path}/obj/glibc-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/msoft-float/
copy_dir_clean ${local_path}/src/glibc-2.22-2015.11 ${local_path}/obj/glibc-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/msoft-float/
chmod -R u+w ${local_path}/obj/glibc-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/msoft-float/
touch ${local_path}/obj/glibc-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/msoft-float//.gnu-stamp
popenv

echo "----------------# task [104/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_5/copy"
echo "----------------# task [105/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_6/copy"
echo "----------------# task [106/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_7/copy"
echo "----------------# task [107/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_8/copy"
echo "----------------# task [108/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_9/copy"
echo "----------------# task [109/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_10/copy"
echo "----------------# task [110/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_11/copy"
echo "----------------# task [111/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_12/copy"
echo "----------------# task [112/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_13/copy"
echo "----------------# task [113/397] /i686-pc-linux-gnu/toolchain/glibc_headers/glibc_14/copy"

echo "----------------# task [114/397] /i686-pc-linux-gnu/toolchain/glibc_headers/ulibc_0/copy"
echo "----------------# task [116/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_0/install"
echo "----------------# task [117/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_1/copy"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -rf ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc/
copy_dir_clean ${local_path}/src/uclibc-2015.11 ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc/
chmod -R u+w ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc/
popenv
echo "----------------# task [118/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_1/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/ ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
pushd ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc/
echo "KERNEL_SOURCE=\"${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr\"" > .config
echo "KERNEL_HEADERS=\"${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/include\"" >> .config
echo "CROSS_COMPILER_PREFIX=\"${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-\"" >> .config
cat >> .config <<'EOF0'
RUNTIME_PREFIX="/"
DEVEL_PREFIX="/usr"
#
# Automatically generated make config: don't edit
# Version: 0.9.30-svn
# Wed Jul 29 12:53:38 2009
#
# TARGET_alpha is not set
# TARGET_arm is not set
# TARGET_avr32 is not set
# TARGET_bfin is not set
# TARGET_cris is not set
# TARGET_e1 is not set
# TARGET_frv is not set
# TARGET_h8300 is not set
# TARGET_hppa is not set
# TARGET_i386 is not set
# TARGET_i960 is not set
# TARGET_ia64 is not set
# TARGET_m68k is not set
# TARGET_microblaze is not set
TARGET_mips=y
# TARGET_nios is not set
# TARGET_nios2 is not set
# TARGET_powerpc is not set
# TARGET_sh is not set
# TARGET_sh64 is not set
# TARGET_sparc is not set
# TARGET_v850 is not set
# TARGET_vax is not set
# TARGET_x86_64 is not set
# TARGET_xtensa is not set

#
# Target Architecture Features and Options
#
TARGET_ARCH="mips"
FORCE_OPTIONS_FOR_ARCH=y
ARCH_CFLAGS="-mno-split-addresses"
CONFIG_MIPS_O32_ABI=y
# CONFIG_MIPS_N32_ABI is not set
# CONFIG_MIPS_N64_ABI is not set
# CONFIG_MIPS_ISA_1 is not set
# CONFIG_MIPS_ISA_2 is not set
# CONFIG_MIPS_ISA_3 is not set
# CONFIG_MIPS_ISA_4 is not set
# CONFIG_MIPS_ISA_MIPS32 is not set
CONFIG_MIPS_ISA_MIPS32R2=y
# CONFIG_MIPS_ISA_MIPS64 is not set
TARGET_SUBARCH=""

#
# Using ELF file format
#
ARCH_ANY_ENDIAN=y
ARCH_LITTLE_ENDIAN=y
# ARCH_WANTS_BIG_ENDIAN is not set
ARCH_WANTS_LITTLE_ENDIAN=y
ARCH_HAS_MMU=y
ARCH_USE_MMU=y
UCLIBC_HAS_FLOATS=y
UCLIBC_HAS_FPU=y
DO_C99_MATH=y
# UCLIBC_HAS_FENV is not set
HAVE_DOT_CONFIG=y

#
# General Library Settings
#
# HAVE_NO_PIC is not set
DOPIC=y
# ARCH_HAS_NO_SHARED is not set
# ARCH_HAS_NO_LDSO is not set
HAVE_SHARED=y
FORCE_SHAREABLE_TEXT_SEGMENTS=y
LDSO_LDD_SUPPORT=y
LDSO_CACHE_SUPPORT=y
# LDSO_PRELOAD_FILE_SUPPORT is not set
LDSO_BASE_FILENAME="ld.so"
UCLIBC_STATIC_LDCONFIG=y
LDSO_RUNPATH=y
UCLIBC_CTOR_DTOR=y
# LDSO_GNU_HASH_SUPPORT is not set
# HAS_NO_THREADS is not set
UCLIBC_HAS_THREADS=y
PTHREADS_DEBUG_SUPPORT=y
LINUXTHREADS_OLD=y
# UCLIBC_HAS_THREADS_NATIVE is not set
UCLIBC_HAS_SYSLOG=y
UCLIBC_HAS_LFS=y
# MALLOC is not set
# MALLOC_SIMPLE is not set
MALLOC_STANDARD=y
# MALLOC_GLIBC_COMPAT is not set
UCLIBC_DYNAMIC_ATEXIT=y
# COMPAT_ATEXIT is not set
UCLIBC_SUSV3_LEGACY=y
# UCLIBC_SUSV3_LEGACY_MACROS is not set
# UCLIBC_SUSV4_LEGACY is not set
# UCLIBC_HAS_STUBS is not set
UCLIBC_HAS_SHADOW=y
# UCLIBC_HAS_PROGRAM_INVOCATION_NAME is not set
UCLIBC_HAS_PTY=y
ASSUME_DEVPTS=y
UNIX98PTY_ONLY=y
# UCLIBC_HAS_GETPT is not set
UCLIBC_HAS_TM_EXTENSIONS=y
UCLIBC_HAS_TZ_CACHING=y
UCLIBC_HAS_TZ_FILE=y
UCLIBC_HAS_TZ_FILE_READ_MANY=y
UCLIBC_TZ_FILE_PATH="/etc/TZ"

#
# Advanced Library Settings
#
UCLIBC_PWD_BUFFER_SIZE=256
UCLIBC_GRP_BUFFER_SIZE=256

#
# Support various families of functions
#
UCLIBC_LINUX_MODULE_24=y
UCLIBC_LINUX_SPECIFIC=y
UCLIBC_HAS_GNU_ERROR=y
UCLIBC_BSD_SPECIFIC=y
UCLIBC_HAS_BSD_ERR=y
# UCLIBC_HAS_OBSOLETE_BSD_SIGNAL is not set
# UCLIBC_HAS_OBSOLETE_SYSV_SIGNAL is not set
# UCLIBC_NTP_LEGACY is not set
# UCLIBC_SV4_DEPRECATED is not set
UCLIBC_HAS_REALTIME=y
UCLIBC_HAS_ADVANCED_REALTIME=y
UCLIBC_HAS_EPOLL=y
UCLIBC_HAS_XATTR=y
UCLIBC_HAS_PROFILING=y
UCLIBC_HAS_CRYPT_IMPL=y
UCLIBC_HAS_CRYPT=y
UCLIBC_HAS_NETWORK_SUPPORT=y
UCLIBC_HAS_SOCKET=y
UCLIBC_HAS_IPV4=y
# UCLIBC_HAS_IPV6 is not set
UCLIBC_HAS_RPC=y
# UCLIBC_HAS_FULL_RPC is not set
UCLIBC_HAS_REENTRANT_RPC=y
# UCLIBC_USE_NETLINK is not set
# UCLIBC_HAS_BSD_RES_CLOSE is not set
UCLIBC_HAS_COMPAT_RES_STATE=y
# UCLIBC_HAS_EXTRA_COMPAT_RES_STATE is not set

#
# String and Stdio Support
#
UCLIBC_HAS_STRING_GENERIC_OPT=y
UCLIBC_HAS_STRING_ARCH_OPT=y
UCLIBC_HAS_CTYPE_TABLES=y
UCLIBC_HAS_CTYPE_SIGNED=y
UCLIBC_HAS_CTYPE_UNSAFE=y
# UCLIBC_HAS_CTYPE_CHECKED is not set
# UCLIBC_HAS_CTYPE_ENFORCED is not set
UCLIBC_HAS_WCHAR=y
# UCLIBC_HAS_LOCALE is not set
# UCLIBC_HAS_HEXADECIMAL_FLOATS is not set
# UCLIBC_HAS_GLIBC_CUSTOM_PRINTF is not set
UCLIBC_PRINTF_SCANF_POSITIONAL_ARGS=9
# UCLIBC_HAS_SCANF_GLIBC_A_FLAG is not set
# UCLIBC_HAS_STDIO_BUFSIZ_NONE is not set
# UCLIBC_HAS_STDIO_BUFSIZ_256 is not set
# UCLIBC_HAS_STDIO_BUFSIZ_512 is not set
# UCLIBC_HAS_STDIO_BUFSIZ_1024 is not set
# UCLIBC_HAS_STDIO_BUFSIZ_2048 is not set
UCLIBC_HAS_STDIO_BUFSIZ_4096=y
# UCLIBC_HAS_STDIO_BUFSIZ_8192 is not set
UCLIBC_HAS_STDIO_BUILTIN_BUFFER_NONE=y
# UCLIBC_HAS_STDIO_BUILTIN_BUFFER_4 is not set
# UCLIBC_HAS_STDIO_BUILTIN_BUFFER_8 is not set
# UCLIBC_HAS_STDIO_SHUTDOWN_ON_ABORT is not set
UCLIBC_HAS_STDIO_GETC_MACRO=y
UCLIBC_HAS_STDIO_PUTC_MACRO=y
UCLIBC_HAS_STDIO_AUTO_RW_TRANSITION=y
# UCLIBC_HAS_FOPEN_LARGEFILE_MODE is not set
# UCLIBC_HAS_FOPEN_EXCLUSIVE_MODE is not set
# UCLIBC_HAS_GLIBC_CUSTOM_STREAMS is not set
# UCLIBC_HAS_PRINTF_M_SPEC is not set
UCLIBC_HAS_ERRNO_MESSAGES=y
# UCLIBC_HAS_SYS_ERRLIST is not set
UCLIBC_HAS_SIGNUM_MESSAGES=y
# UCLIBC_HAS_SYS_SIGLIST is not set
UCLIBC_HAS_GNU_GETOPT=y
UCLIBC_HAS_GNU_GETSUBOPT=y

#
# Big and Tall
#
UCLIBC_HAS_REGEX=y
UCLIBC_HAS_REGEX_OLD=y
UCLIBC_HAS_FNMATCH=y
UCLIBC_HAS_FNMATCH_OLD=y
# UCLIBC_HAS_WORDEXP is not set
# UCLIBC_HAS_FTW is not set
UCLIBC_HAS_GLOB=y
# UCLIBC_HAS_GNU_GLOB is not set

#
# Library Installation Options
#
SHARED_LIB_LOADER_PREFIX="$(RUNTIME_PREFIX)lib"
HARDWIRED_ABSPATH=y

#
# Security options
#
UCLIBC_BUILD_PIE=y
# UCLIBC_HAS_ARC4RANDOM is not set
# HAVE_NO_SSP is not set
# UCLIBC_HAS_SSP is not set
UCLIBC_BUILD_RELRO=y
# UCLIBC_BUILD_NOW is not set
UCLIBC_BUILD_NOEXECSTACK=y

#
# uClibc development/debugging options
#
UCLIBC_EXTRA_CFLAGS=""
# DODEBUG is not set
# DODEBUG_PT is not set
# DOSTRIP is not set
# DOASSERTS is not set
# SUPPORT_LD_DEBUG is not set
# SUPPORT_LD_DEBUG_EARLY is not set
# UCLIBC_MALLOC_DEBUGGING is not set
WARNINGS="-Wall"
# EXTRA_WARNINGS is not set
# DOMULTI is not set
# UCLIBC_MJN3_ONLY is not set
EOF0
yes "" | make oldconfig
popd
popenv

echo "----------------# task [119/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_1/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc/
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL ' headers
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL ' PREFIX=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/ install_headers
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL ' lib/crt1.o
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL ' lib/crti.o
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL ' lib/crtn.o
cp lib/crt1.o lib/crti.o lib/crtn.o ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-gcc -muclibc -EL -o ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib//libc.so -nostdlib -nostartfiles -shared -x c /dev/null
popd
popenv

echo "----------------# task [120/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_2/copy"
echo "----------------# task [121/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_2/configure"
echo "----------------# task [122/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_2/install"
echo "----------------# task [123/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_3/copy"
pushenv
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -rf ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc-msoft-float/
copy_dir_clean ${local_path}/src/uclibc-2015.11 ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc-msoft-float/
chmod -R u+w ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc-msoft-float/
popenv

echo "----------------# task [124/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_3/cnfigure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/ ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
pushd ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc-msoft-float/
echo "KERNEL_SOURCE=\"${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr\"" > .config
echo "KERNEL_HEADERS=\"${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/include\"" >> .config
echo "CROSS_COMPILER_PREFIX=\"${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-\"" >> .config
cat >> .config <<'EOF0'
RUNTIME_PREFIX="/"
DEVEL_PREFIX="/usr"
#
# Automatically generated make config: don't edit
# Version: 0.9.30-svn
# Wed Jul 29 12:55:13 2009
#
# TARGET_alpha is not set
# TARGET_arm is not set
# TARGET_avr32 is not set
# TARGET_bfin is not set
# TARGET_cris is not set
# TARGET_e1 is not set
# TARGET_frv is not set
# TARGET_h8300 is not set
# TARGET_hppa is not set
# TARGET_i386 is not set
# TARGET_i960 is not set
# TARGET_ia64 is not set
# TARGET_m68k is not set
# TARGET_microblaze is not set
TARGET_mips=y
# TARGET_nios is not set
# TARGET_nios2 is not set
# TARGET_powerpc is not set
# TARGET_sh is not set
# TARGET_sh64 is not set
# TARGET_sparc is not set
# TARGET_v850 is not set
# TARGET_vax is not set
# TARGET_x86_64 is not set
# TARGET_xtensa is not set

#
# Target Architecture Features and Options
#
TARGET_ARCH="mips"
FORCE_OPTIONS_FOR_ARCH=y
ARCH_CFLAGS="-mno-split-addresses"
CONFIG_MIPS_O32_ABI=y
# CONFIG_MIPS_N32_ABI is not set
# CONFIG_MIPS_N64_ABI is not set
# CONFIG_MIPS_ISA_1 is not set
# CONFIG_MIPS_ISA_2 is not set
# CONFIG_MIPS_ISA_3 is not set
# CONFIG_MIPS_ISA_4 is not set
# CONFIG_MIPS_ISA_MIPS32 is not set
CONFIG_MIPS_ISA_MIPS32R2=y
# CONFIG_MIPS_ISA_MIPS64 is not set
TARGET_SUBARCH=""

#
# Using ELF file format
#
ARCH_ANY_ENDIAN=y
ARCH_LITTLE_ENDIAN=y
# ARCH_WANTS_BIG_ENDIAN is not set
ARCH_WANTS_LITTLE_ENDIAN=y
ARCH_HAS_MMU=y
ARCH_USE_MMU=y
UCLIBC_HAS_FLOATS=y
# UCLIBC_HAS_FPU is not set
UCLIBC_HAS_SOFT_FLOAT=y
DO_C99_MATH=y
# UCLIBC_HAS_FENV is not set
HAVE_DOT_CONFIG=y

#
# General Library Settings
#
# HAVE_NO_PIC is not set
DOPIC=y
# ARCH_HAS_NO_SHARED is not set
# ARCH_HAS_NO_LDSO is not set
HAVE_SHARED=y
FORCE_SHAREABLE_TEXT_SEGMENTS=y
LDSO_LDD_SUPPORT=y
LDSO_CACHE_SUPPORT=y
# LDSO_PRELOAD_FILE_SUPPORT is not set
LDSO_BASE_FILENAME="ld.so"
UCLIBC_STATIC_LDCONFIG=y
LDSO_RUNPATH=y
UCLIBC_CTOR_DTOR=y
# LDSO_GNU_HASH_SUPPORT is not set
# HAS_NO_THREADS is not set
UCLIBC_HAS_THREADS=y
PTHREADS_DEBUG_SUPPORT=y
LINUXTHREADS_OLD=y
# UCLIBC_HAS_THREADS_NATIVE is not set
UCLIBC_HAS_SYSLOG=y
UCLIBC_HAS_LFS=y
# MALLOC is not set
# MALLOC_SIMPLE is not set
MALLOC_STANDARD=y
# MALLOC_GLIBC_COMPAT is not set
UCLIBC_DYNAMIC_ATEXIT=y
# COMPAT_ATEXIT is not set
UCLIBC_SUSV3_LEGACY=y
# UCLIBC_SUSV3_LEGACY_MACROS is not set
# UCLIBC_SUSV4_LEGACY is not set
# UCLIBC_HAS_STUBS is not set
UCLIBC_HAS_SHADOW=y
# UCLIBC_HAS_PROGRAM_INVOCATION_NAME is not set
UCLIBC_HAS_PTY=y
ASSUME_DEVPTS=y
UNIX98PTY_ONLY=y
# UCLIBC_HAS_GETPT is not set
UCLIBC_HAS_TM_EXTENSIONS=y
UCLIBC_HAS_TZ_CACHING=y
UCLIBC_HAS_TZ_FILE=y
UCLIBC_HAS_TZ_FILE_READ_MANY=y
UCLIBC_TZ_FILE_PATH="/etc/TZ"

#
# Advanced Library Settings
#
UCLIBC_PWD_BUFFER_SIZE=256
UCLIBC_GRP_BUFFER_SIZE=256

#
# Support various families of functions
#
UCLIBC_LINUX_MODULE_24=y
UCLIBC_LINUX_SPECIFIC=y
UCLIBC_HAS_GNU_ERROR=y
UCLIBC_BSD_SPECIFIC=y
UCLIBC_HAS_BSD_ERR=y
# UCLIBC_HAS_OBSOLETE_BSD_SIGNAL is not set
# UCLIBC_HAS_OBSOLETE_SYSV_SIGNAL is not set
# UCLIBC_NTP_LEGACY is not set
# UCLIBC_SV4_DEPRECATED is not set
UCLIBC_HAS_REALTIME=y
UCLIBC_HAS_ADVANCED_REALTIME=y
UCLIBC_HAS_EPOLL=y
UCLIBC_HAS_XATTR=y
UCLIBC_HAS_PROFILING=y
UCLIBC_HAS_CRYPT_IMPL=y
UCLIBC_HAS_CRYPT=y
UCLIBC_HAS_NETWORK_SUPPORT=y
UCLIBC_HAS_SOCKET=y
UCLIBC_HAS_IPV4=y
# UCLIBC_HAS_IPV6 is not set
UCLIBC_HAS_RPC=y
# UCLIBC_HAS_FULL_RPC is not set
UCLIBC_HAS_REENTRANT_RPC=y
# UCLIBC_USE_NETLINK is not set
# UCLIBC_HAS_BSD_RES_CLOSE is not set
UCLIBC_HAS_COMPAT_RES_STATE=y
# UCLIBC_HAS_EXTRA_COMPAT_RES_STATE is not set

#
# String and Stdio Support
#
UCLIBC_HAS_STRING_GENERIC_OPT=y
UCLIBC_HAS_STRING_ARCH_OPT=y
UCLIBC_HAS_CTYPE_TABLES=y
UCLIBC_HAS_CTYPE_SIGNED=y
UCLIBC_HAS_CTYPE_UNSAFE=y
# UCLIBC_HAS_CTYPE_CHECKED is not set
# UCLIBC_HAS_CTYPE_ENFORCED is not set
UCLIBC_HAS_WCHAR=y
# UCLIBC_HAS_LOCALE is not set
# UCLIBC_HAS_HEXADECIMAL_FLOATS is not set
# UCLIBC_HAS_GLIBC_CUSTOM_PRINTF is not set
UCLIBC_PRINTF_SCANF_POSITIONAL_ARGS=9
# UCLIBC_HAS_SCANF_GLIBC_A_FLAG is not set
# UCLIBC_HAS_STDIO_BUFSIZ_NONE is not set
# UCLIBC_HAS_STDIO_BUFSIZ_256 is not set
# UCLIBC_HAS_STDIO_BUFSIZ_512 is not set
# UCLIBC_HAS_STDIO_BUFSIZ_1024 is not set
# UCLIBC_HAS_STDIO_BUFSIZ_2048 is not set
UCLIBC_HAS_STDIO_BUFSIZ_4096=y
# UCLIBC_HAS_STDIO_BUFSIZ_8192 is not set
UCLIBC_HAS_STDIO_BUILTIN_BUFFER_NONE=y
# UCLIBC_HAS_STDIO_BUILTIN_BUFFER_4 is not set
# UCLIBC_HAS_STDIO_BUILTIN_BUFFER_8 is not set
# UCLIBC_HAS_STDIO_SHUTDOWN_ON_ABORT is not set
UCLIBC_HAS_STDIO_GETC_MACRO=y
UCLIBC_HAS_STDIO_PUTC_MACRO=y
UCLIBC_HAS_STDIO_AUTO_RW_TRANSITION=y
# UCLIBC_HAS_FOPEN_LARGEFILE_MODE is not set
# UCLIBC_HAS_FOPEN_EXCLUSIVE_MODE is not set
# UCLIBC_HAS_GLIBC_CUSTOM_STREAMS is not set
# UCLIBC_HAS_PRINTF_M_SPEC is not set
UCLIBC_HAS_ERRNO_MESSAGES=y
# UCLIBC_HAS_SYS_ERRLIST is not set
UCLIBC_HAS_SIGNUM_MESSAGES=y
# UCLIBC_HAS_SYS_SIGLIST is not set
UCLIBC_HAS_GNU_GETOPT=y
UCLIBC_HAS_GNU_GETSUBOPT=y

#
# Big and Tall
#
UCLIBC_HAS_REGEX=y
UCLIBC_HAS_REGEX_OLD=y
UCLIBC_HAS_FNMATCH=y
UCLIBC_HAS_FNMATCH_OLD=y
# UCLIBC_HAS_WORDEXP is not set
# UCLIBC_HAS_FTW is not set
UCLIBC_HAS_GLOB=y
# UCLIBC_HAS_GNU_GLOB is not set

#
# Library Installation Options
#
SHARED_LIB_LOADER_PREFIX="$(RUNTIME_PREFIX)lib"
HARDWIRED_ABSPATH=y

#
# Security options
#
UCLIBC_BUILD_PIE=y
# UCLIBC_HAS_ARC4RANDOM is not set
# HAVE_NO_SSP is not set
# UCLIBC_HAS_SSP is not set
UCLIBC_BUILD_RELRO=y
# UCLIBC_BUILD_NOW is not set
UCLIBC_BUILD_NOEXECSTACK=y

#
# uClibc development/debugging options
#
UCLIBC_EXTRA_CFLAGS=""
# DODEBUG is not set
# DODEBUG_PT is not set
# DOSTRIP is not set
# DOASSERTS is not set
# SUPPORT_LD_DEBUG is not set
# SUPPORT_LD_DEBUG_EARLY is not set
# UCLIBC_MALLOC_DEBUGGING is not set
WARNINGS="-Wall"
# EXTRA_WARNINGS is not set
# DOMULTI is not set
# UCLIBC_MJN3_ONLY is not set
EOF0
yes "" | make oldconfig
popd
popenv

echo "----------------# task [125/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_3/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc-msoft-float/
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL -msoft-float ' headers
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL -msoft-float ' PREFIX=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/ install_headers
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL -msoft-float ' lib/crt1.o
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL -msoft-float ' lib/crti.o
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL -msoft-float ' lib/crtn.o
cp lib/crt1.o lib/crti.o lib/crtn.o ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-gcc -muclibc -EL -msoft-float -o ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib//libc.so -nostdlib -nostartfiles -shared -x c /dev/null
popd
popenv

echo "----------------# task [126/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_4/copy"
echo "----------------# task [127/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_4/configure"
echo "----------------# task [128/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_4/install"
echo "----------------# task [129/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_5/copy"
echo "----------------# task [130/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_5/configure"
echo "----------------# task [131/397] /i686-pc-linux-gnu/toolchain/ulibc_headers/uclibc_5/install"

echo "----------------# task [132/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_0/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./lib/./ ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
rm -rf ${local_path}/obj/glibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/default/
mkdir -p ${local_path}/obj/glibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/default/
pushd ${local_path}/obj/glibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/default/
pushenv
pushenvvar BUILD_CC gcc
export CC="${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-gcc"
export CXX="${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-g++"
pushenvvar CFLAGS '-g -O2'
pushenvvar AR ${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-ar
pushenvvar NM ${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-nm
pushenvvar RANLIB ${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-ranlib
pushenvvar READELF ${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-readelf
pushenvvar PERL /usr/bin/perl
pushenvvar BASH_SHELL /bin/bash
check_mentor_trademarks ${local_path}/obj/glibc-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/default/ --prefix=/usr --with-headers=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include --build=i686-pc-linux-gnu --host=mips-linux-gnu --disable-profile --without-gd --without-cvs --enable-obsolete-rpc --enable-add-ons --enable-kernel=2.6.32 '--with-pkgversion=Ingenic 2016.03'
popenv
popd
popenv

echo "----------------# task [133/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_0/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/glibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/default/
pushenv
pushenvvar PARALLELMFLAGS $JX
make
popenv
popd
popenv

echo "----------------# task [134/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_0/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/info/dir ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/share/info/dir
pushd ${local_path}/obj/glibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/default/
make install_root=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./ install
make html
mkdir -p ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html
copy_dir ${local_path}/obj/glibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/default//manual/libc ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/libc
make pdf
mkdir -p ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf
cp ${local_path}/obj/glibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/default//manual/libc.pdf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/libc.pdf
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/libexec/pt_chown
rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libc_pic
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libBrokenLocale_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libanl_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libc_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libcidn_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libcrypt_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libdl_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libm_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnsl_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_compat_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_db_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_dns_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_files_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_hesiod_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_nis_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_nisplus_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libresolv_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./librt_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libthread_db_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libutil_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libBrokenLocale_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libanl_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libc_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libcidn_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libcrypt_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libdl_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libm_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnsl_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_compat_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_db_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_dns_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_files_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_hesiod_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_nis_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libnss_nisplus_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libresolv_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./librt_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libthread_db_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./libutil_pic.map
pushd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv sbin/ldconfig ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv sbin/sln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/catchsegv ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/gencat ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/getconf ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/getent ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/iconv ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/ldd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/locale ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/localedef ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/makedb ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/mtrace ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/pcprofiledump ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/pldd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/rpcgen ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/sotruss ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/sprof ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/tzselect ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/xtrace ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/sbin/iconvconfig ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/sbin/nscd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/sbin/zdump ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/sbin/zic ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/libexec/getconf/POSIX_V6_ILP32_OFF32 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/libexec/getconf/POSIX_V6_ILP32_OFFBIG ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/libexec/getconf/POSIX_V7_ILP32_OFF32 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/libexec/getconf/POSIX_V7_ILP32_OFFBIG ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/libexec/getconf/XBS5_ILP32_OFF32 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/libexec/getconf/XBS5_ILP32_OFFBIG ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
popd
popd
popenv

echo "----------------# task [135/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_1/configure"
echo "----------------# task [136/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_1/build"
echo "----------------# task [137/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_1/install"
echo "----------------# task [138/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_2/configure"
echo "----------------# task [139/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_2/build"
echo "----------------# task [140/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_2/install"
echo "----------------# task [141/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_3/configure"
echo "----------------# task [142/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_3/build"
echo "----------------# task [143/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_3/install"
echo "----------------# task [144/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_4/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/ ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
rm -rf ${local_path}/obj/glibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/msoft-float/
mkdir -p ${local_path}/obj/glibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/msoft-float/
pushd ${local_path}/obj/glibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/msoft-float/
pushenv
pushenvvar BUILD_CC gcc
export CC="${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-gcc -msoft-float"
export CXX="${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-g++ -msoft-float"
pushenvvar CFLAGS '-g -O2'
pushenvvar AR ${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-ar
pushenvvar NM ${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-nm
pushenvvar RANLIB ${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-ranlib
pushenvvar READELF ${local_path}/install/opt/codesourcery/bin/mips-linux-gnu-readelf
pushenvvar PERL /usr/bin/perl
pushenvvar BASH_SHELL /bin/bash
check_mentor_trademarks ${local_path}/obj/glibc-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/msoft-float/ --prefix=/usr --with-headers=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include --build=i686-pc-linux-gnu --host=mips-linux-gnu --disable-profile --without-gd --without-cvs --enable-obsolete-rpc --enable-add-ons --enable-kernel=2.6.32 --without-fp '--with-pkgversion= Ingenic 2015.11-32' 
popenv
popd
popenv

echo "----------------# task [145/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_4/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/glibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/msoft-float/
pushenv
pushenvvar PARALLELMFLAGS $JX
make
popenv
popd
popenv

echo "----------------# task [146/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_4/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/info/dir ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/share/info/dir
pushd ${local_path}/obj/glibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/msoft-float/
make install_root=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/ install
cp ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/include/gnu/stubs-o32_soft.h ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include/gnu/stubs-o32_soft.h
cp ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/include/gnu/lib-names-o32_soft.h ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/include/gnu/lib-names-o32_soft.h
make html
mkdir -p ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html
make pdf
mkdir -p ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/libexec/pt_chown
rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libc_pic
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libBrokenLocale_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libanl_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libc_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libcidn_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libcrypt_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libdl_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libm_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnsl_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_compat_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_db_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_dns_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_files_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_hesiod_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_nis_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_nisplus_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libresolv_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/librt_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libthread_db_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libutil_pic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libBrokenLocale_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libanl_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libc_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libcidn_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libcrypt_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libdl_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libm_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnsl_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_compat_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_db_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_dns_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_files_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_hesiod_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_nis_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_nisplus_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libresolv_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/librt_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libthread_db_pic.map
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libutil_pic.map
pushd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv sbin/ldconfig ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv sbin/sln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/catchsegv ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/gencat ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/getconf ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/getent ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/iconv ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/ldd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/locale ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/localedef ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/makedb ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/mtrace ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/pcprofiledump ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/pldd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/rpcgen ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/sotruss ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/sprof ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/tzselect ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/xtrace ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/sbin/iconvconfig ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/sbin/nscd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/sbin/zdump ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/sbin/zic ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/libexec/getconf/POSIX_V6_ILP32_OFF32 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/libexec/getconf/POSIX_V6_ILP32_OFFBIG ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/libexec/getconf/POSIX_V7_ILP32_OFF32 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/libexec/getconf/POSIX_V7_ILP32_OFFBIG ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/libexec/getconf/XBS5_ILP32_OFF32 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/libexec/getconf/XBS5_ILP32_OFFBIG ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
popd
popd
popenv

echo "----------------# task [147/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_5/configure"
echo "----------------# task [148/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_5/build"
echo "----------------# task [149/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_5/install"
echo "----------------# task [150/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_6/configure"
echo "----------------# task [151/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_6/build"
echo "----------------# task [152/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_6/install"
echo "----------------# task [153/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_7/configure"
echo "----------------# task [154/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_7/build"
echo "----------------# task [155/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_7/install"
echo "----------------# task [156/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_8/configure"
echo "----------------# task [157/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_8/build"
echo "----------------# task [158/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_8/install"
echo "----------------# task [159/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_9/configure"
echo "----------------# task [160/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_9/build"
echo "----------------# task [161/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_9/install"
echo "----------------# task [162/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_10/configure"
echo "----------------# task [163/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_10/build"
echo "----------------# task [164/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_10/install"
echo "----------------# task [165/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_11/configure"
echo "----------------# task [166/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_11/build"
echo "----------------# task [167/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_11/install"
echo "----------------# task [168/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_12/configure"
echo "----------------# task [169/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_12/build"
echo "----------------# task [170/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_12/install"
echo "----------------# task [171/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_13/configure"
echo "----------------# task [172/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_13/build"
echo "----------------# task [173/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_13/install"
echo "----------------# task [174/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_14/configure"
echo "----------------# task [175/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_14/build"
echo "----------------# task [176/397] /i686-pc-linux-gnu/toolchain/glibc/glibc_14/install"
echo "----------------# task [177/397] /i686-pc-linux-gnu/toolchain/build_host_glibc"
echo "----------------# task [178/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_0"
echo "----------------# task [179/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_1"
echo "----------------# task [180/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_2"
echo "----------------# task [181/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_3"
echo "----------------# task [182/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_4"
echo "----------------# task [183/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_5"
echo "----------------# task [184/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_6"
echo "----------------# task [185/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_7"
echo "----------------# task [186/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_8"
echo "----------------# task [187/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_9"
echo "----------------# task [188/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_10"
echo "----------------# task [189/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_11"
echo "----------------# task [190/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_12"
echo "----------------# task [191/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_13"
echo "----------------# task [192/397] /i686-pc-linux-gnu/toolchain/install_glibc_locale/glibc_14"
echo "----------------# task [193/397] /i686-pc-linux-gnu/toolchain/gcc_second/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-linux-gnu-ar
pushenvvar NM_FOR_TARGET mips-linux-gnu-nm
pushenvvar OBJDUMP_FOR_TARET mips-linux-gnu-objdump
pushenvvar STRIP_FOR_TARGET mips-linux-gnu-strip
rm -rf ${local_path}/obj/gcc-second-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/gcc-second-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/gcc-second-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/gcc-5-2015.11 --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu --target=mips-linux-gnu --enable-threads --disable-libmudflap --disable-libssp --disable-libstdcxx-pch --with-arch-32=mips32r2 --with-arch-64=mips64r2 --with-float=hard --with-mips-plt --enable-extra-sgxxlite-multilibs --with-gnu-as --with-gnu-ld '--with-specs=-D__CS_SOURCERYGXX_MAJ__=2015 -D__CS_SOURCERYGXX_MIN__=11 -D__CS_SOURCERYGXX_REV__=32' --enable-languages=c,c++ --enable-shared --enable-lto --enable-symvers=gnu --enable-__cxa_atexit --with-glibc-version=2.22 '--with-pkgversion=Ingenic 2016.03-32' --disable-nls --prefix=${local_path}/install/opt/codesourcery --disable-libffi --disable-libquadmath --disable-libitm --disable-libatomic --enable-languages=c --with-sysroot=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc --with-build-sysroot=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc --with-gmp=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --with-mpc=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --with-isl=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --disable-libgomp --disable-libitm --disable-libatomic --disable-libssp --disable-libcc1 --enable-poison-system-directories --with-python-dir=mips-linux-gnu/share/gdb/python --with-build-time-tools=${local_path}/install/opt/codesourcery/mips-linux-gnu/bin --with-build-time-tools=${local_path}/install/opt/codesourcery/mips-linux-gnu/bin SED=sed
popd
popenv
popenv

echo "----------------# task [194/397] /i686-pc-linux-gnu/toolchain/gcc_second/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-linux-gnu-ar
pushenvvar NM_FOR_TARGET mips-linux-gnu-nm
pushenvvar OBJDUMP_FOR_TARET mips-linux-gnu-objdump
pushenvvar STRIP_FOR_TARGET mips-linux-gnu-strip
pushd ${local_path}/obj/gcc-second-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX LDFLAGS_FOR_TARGET=--sysroot=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc CPPFLAGS_FOR_TARGET=--sysroot=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc build_tooldir=${local_path}/install/opt/codesourcery/mips-linux-gnu 2>&1|tee gcc_second_build.log
popd
popenv
popenv

echo "----------------# task [195/397] /i686-pc-linux-gnu/toolchain/gcc_second/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-linux-gnu-ar
pushenvvar NM_FOR_TARGET mips-linux-gnu-nm
pushenvvar OBJDUMP_FOR_TARET mips-linux-gnu-objdump
pushenvvar STRIP_FOR_TARGET mips-linux-gnu-strip
pushd ${local_path}/obj/gcc-second-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man install 2>&1|tee gcc_second_install.log
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man install-html
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man install-pdf
popd
popenv
popenv


echo "----------------# task [196/397] /i686-pc-linux-gnu/toolchain/gcc_second/postinstall"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-linux-gnu-ar
pushenvvar NM_FOR_TARGET mips-linux-gnu-nm
pushenvvar OBJDUMP_FOR_TARET mips-linux-gnu-objdump
pushenvvar STRIP_FOR_TARGET mips-linux-gnu-strip
pushd ${local_path}/install/opt/codesourcery
rm include -rf
popd
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc/multilib_list.txt
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc
cat > ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc/multilib_list.txt <<'EOF0'
.;base;MIPS32 revision 2 - Little-Endian, O32
#64;addon;MIPS64 revision 2 - Big-Endian, N64
#el;addon;MIPS32 revision 2 - Little-Endian, O32
#el/64;addon;MIPS64 revision 2 - Little-Endian, N64
#soft-float;addon;MIPS32 revision 2 - Big-Endian, Soft-Float, O32
#soft-float/64;addon;MIPS64 revision 2 - Big-Endian, Soft-Float, N64
soft-float;addon;MIPS32 revision 2 - Little-Endian, Soft-Float, O32
#soft-float/el/64;addon;MIPS64 revision 2 - Little-Endian, Soft-Float, N64
#nan2008;addon;MIPS32 revision 2 - Big-Endian, 2008 NaN, O32
#nan2008/el;addon;MIPS32 revision 2 - Little-Endian, 2008 NaN, O32
#micromips/soft-float/el;addon;MIPS32 revision 2 - Little-Endian, Soft-Float, O32, microMIPS
#mips16;addon;MIPS32 revision 2 - Big-Endian, O32, MIPS16
#mips16/el;addon;MIPS32 revision 2 - Little-Endian, O32, MIPS16
#mips16/soft-float;addon;MIPS32 revision 2 - Big-Endian, Soft-Float, O32, MIPS16
#mips16/soft-float/el;addon;MIPS32 revision 2 - Little-Endian, Soft-Float, O32, MIPS16
#uclibc;addon;MIPS32 revision 2 - uClibc, Big-Endian, O32
uclibc;addon;MIPS32 revision 2 - uClibc, Little-Endian, O32
#uclibc/soft-float;addon;MIPS32 revision 2 - uClibc, Big-Endian, Soft-Float, O32
uclibc/soft-float;addon;MIPS32 revision 2 - uClibc, Little-Endian, Soft-Float, O32
#uclibc/nan2008;addon;MIPS32 revision 2 - uClibc, Big-Endian, 2008 NaN, O32
#uclibc/nan2008/el;addon;MIPS32 revision 2 - uClibc, Little-Endian, 2008 NaN, O32
EOF0
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/gccinstall ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/gcc/gccinstall.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/gccinstall.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly gccinstall
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/gccint ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/gcc/gccint.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/gccint.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly gccint
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/cppinternals ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/gcc/cppinternals.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/cppinternals.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly cppinternals
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/libiberty.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/libiberty.pdf
popenv
popenv

echo "----------------# task [197/397] /i686-pc-linux-gnu/toolchain/uclibc/uclibc_0/build"
echo "----------------# task [198/397] /i686-pc-linux-gnu/toolchain/uclibc/uclibc_0/install"
echo "----------------# task [199/397] /i686-pc-linux-gnu/toolchain/uclibc/uclibc_1/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc/
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL ' $JX
popd
popenv

echo "----------------# task [200/397] /i686-pc-linux-gnu/toolchain/uclibc/uclibc_1/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc/
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL ' PREFIX=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc $JX install
popd
popenv

echo "----------------# task [201/397] /i686-pc-linux-gnu/toolchain/uclibc/uclibc_2/build"
echo "----------------# task [202/397] /i686-pc-linux-gnu/toolchain/uclibc/uclibc_2/install"
echo "----------------# task [203/397] /i686-pc-linux-gnu/toolchain/uclibc/uclibc_3/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc-msoft-float/
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL -msoft-float ' $JX
popd
popenv

echo "----------------# task [204/397] /i686-pc-linux-gnu/toolchain/uclibc/uclibc_3/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/uclibc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/muclibc-msoft-float/
make VERBOSE=1 ARCH_CFLAGS= 'UCLIBC_EXTRA_CFLAGS=-muclibc -EL -msoft-float ' PREFIX=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float $JX install
popd
popenv

echo "----------------# task [205/397] /i686-pc-linux-gnu/toolchain/uclibc/uclibc_4/build"
echo "----------------# task [206/397] /i686-pc-linux-gnu/toolchain/uclibc/uclibc_4/install"
echo "----------------# task [207/397] /i686-pc-linux-gnu/toolchain/uclibc/uclibc_5/buid"
echo "----------------# task [208/397] /i686-pc-linux-gnu/toolchain/uclibc/uclibc_5/install"
echo "----------------# task [209/397] /i686-pc-linux-gnu/toolchain/gcc_final/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-linux-gnu-ar
pushenvvar NM_FOR_TARGET mips-linux-gnu-nm
pushenvvar OBJDUMP_FOR_TARET mips-linux-gnu-objdump
pushenvvar STRIP_FOR_TARGET mips-linux-gnu-strip
rm -rf ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/gcc-5-2015.11 --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu --target=mips-linux-gnu --enable-threads --disable-libmudflap --disable-libssp --disable-libstdcxx-pch --with-arch-32=mips32r2 --with-arch-64=mips64r2 --with-float=hard --with-mips-plt --enable-extra-sgxxlite-multilibs --with-gnu-as --with-gnu-ld '--with-specs=-D__CS_SOURCERYGXX_MAJ__=2015 -D__CS_SOURCERYGXX_MIN__=11 -D__CS_SOURCERYGXX_REV__=32' --enable-languages=c,c++ --enable-shared --enable-lto --enable-symvers=gnu --enable-__cxa_atexit --with-glibc-version=2.22 '--with-pkgversion=Ingenic 2016.03-32'  --disable-nls --prefix=${local_path}/install/opt/codesourcery --with-sysroot=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc --with-build-sysroot=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc --with-gmp=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --with-mpc=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --with-isl=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --enable-libgomp --disable-libitm --enable-libatomic --disable-libssp --disable-libcc1 --enable-poison-system-directories --with-python-dir=mips-linux-gnu/share/gdb/python --with-build-time-tools=${local_path}/install/opt/codesourcery/mips-linux-gnu/bin --with-build-time-tools=${local_path}/install/opt/codesourcery/mips-linux-gnu/bin SED=sed
popd
popenv
popenv
echo "----------------# task [210/397] /i686-pc-linux-gnu/toolchain/gcc_final/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-linux-gnu-ar
pushenvvar NM_FOR_TARGET mips-linux-gnu-nm
pushenvvar OBJDUMP_FOR_TARET mips-linux-gnu-objdump
pushenvvar STRIP_FOR_TARGET mips-linux-gnu-strip
pushd ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX LDFLAGS_FOR_TARGET=--sysroot=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc CPPFLAGS_FOR_TARGET=--sysroot=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc build_tooldir=${local_path}/install/opt/codesourcery/mips-linux-gnu 2>&1|tee gcc_final_build.log
popd
popenv
popenv

echo "----------------# task [211/397] /i686-pc-linux-gnu/toolchain/gcc_final/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-linux-gnu-ar
pushenvvar NM_FOR_TARGET mips-linux-gnu-nm
pushenvvar OBJDUMP_FOR_TARET mips-linux-gnu-objdump
pushenvvar STRIP_FOR_TARGET mips-linux-gnu-strip
pushd ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man install 2>&1|tee gcc_final_install.log
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man install-html
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man install-pdf
popd
popenv
popenv

echo "----------------# task [212/397] /i686-pc-linux-gnu/toolchain/gcc_final/postinstall"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-linux-gnu-ar
pushenvvar NM_FOR_TARGET mips-linux-gnu-nm
pushenvvar OBJDUMP_FOR_TARET mips-linux-gnu-objdump
pushenvvar STRIP_FOR_TARGET mips-linux-gnu-strip
pushd ${local_path}/install/opt/codesourcery
rm include -rf
popd
rm -f ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc/multilib_list.txt
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc
cat > ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc/multilib_list.txt <<'EOF0'
.;base;MIPS32 revision 2 - Little-Endian, O32
#64;addon;MIPS64 revision 2 - Big-Endian, N64
#el;addon;MIPS32 revision 2 - Little-Endian, O32
#el/64;addon;MIPS64 revision 2 - Little-Endian, N64
#soft-float;addon;MIPS32 revision 2 - Big-Endian, Soft-Float, O32
#soft-float/64;addon;MIPS64 revision 2 - Big-Endian, Soft-Float, N64
soft-float;addon;MIPS32 revision 2 - Little-Endian, Soft-Float, O32
#soft-float/el/64;addon;MIPS64 revision 2 - Little-Endian, Soft-Float, N64
#nan2008;addon;MIPS32 revision 2 - Big-Endian, 2008 NaN, O32
#nan2008/el;addon;MIPS32 revision 2 - Little-Endian, 2008 NaN, O32
#micromips/soft-float/el;addon;MIPS32 revision 2 - Little-Endian, Soft-Float, O32, microMIPS
#mips16;addon;MIPS32 revision 2 - Big-Endian, O32, MIPS16
#mips16/el;addon;MIPS32 revision 2 - Little-Endian, O32, MIPS16
#mips16/soft-float;addon;MIPS32 revision 2 - Big-Endian, Soft-Float, O32, MIPS16
#mips16/soft-float/el;addon;MIPS32 revision 2 - Little-Endian, Soft-Float, O32, MIPS16
#uclibc;addon;MIPS32 revision 2 - uClibc, Big-Endian, O32
uclibc;addon;MIPS32 revision 2 - uClibc, Little-Endian, O32
#uclibc/soft-float;addon;MIPS32 revision 2 - uClibc, Big-Endian, Soft-Float, O32
uclibc/soft-float;addon;MIPS32 revision 2 - uClibc, Little-Endian, Soft-Float, O32
#uclibc/nan2008;addon;MIPS32 revision 2 - uClibc, Big-Endian, 2008 NaN, O32
#uclibc/nan2008/el;addon;MIPS32 revision 2 - uClibc, Little-Endian, 2008 NaN, O32
EOF0
rm -rf ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/.
install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/./libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/./config.h
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc
install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/uclibc/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/mips16
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/mips16/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/mips16/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/mips16/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/mips16/config.h
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/soft-float
install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/soft-float/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/soft-float/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/nan2008
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/nan2008/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/nan2008/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/nan2008/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/nan2008/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/el
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/el/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/el/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/el/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/el/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/64
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/64/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/64/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/64/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/64/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/el/64
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/el/64/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/el/64/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/el/64/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/el/64/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/soft-float/el
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/soft-float/el/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/soft-float/el/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/soft-float/el/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/soft-float/el/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/soft-float/64
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/soft-float/64/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/soft-float/64/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/soft-float/64/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/soft-float/64/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/soft-float/el/64
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/soft-float/el/64/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/soft-float/el/64/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/soft-float/el/64/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/soft-float/el/64/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/nan2008/el
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/nan2008/el/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/nan2008/el/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/nan2008/el/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/nan2008/el/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/micromips/soft-float/el
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/micromips/soft-float/el/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/micromips/soft-float/el/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/micromips/soft-float/el/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/micromips/soft-float/el/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/mips16/soft-float
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/mips16/soft-float/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/mips16/soft-float/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/mips16/soft-float/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/mips16/soft-float/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/mips16/el
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/mips16/el/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/mips16/el/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/mips16/el/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/mips16/el/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/mips16/soft-float/el
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/mips16/soft-float/el/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/mips16/soft-float/el/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/mips16/soft-float/el/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/mips16/soft-float/el/config.h
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/soft-float
install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/uclibc/soft-float/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/soft-float/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/nan2008
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/uclibc/nan2008/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/nan2008/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/uclibc/nan2008/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/nan2008/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/el
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/uclibc/el/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/el/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/uclibc/el/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/el/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/soft-float/el
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/uclibc/soft-float/el/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/soft-float/el/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/uclibc/soft-float/el/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/soft-float/el/config.h
#mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/nan2008/el
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/uclibc/nan2008/el/libgomp/testsuite/libgomp-test-support.exp ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/nan2008/el/libgomp-test-support.exp
#install -m 644 ${local_path}/obj/gcc-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/mips-linux-gnu/uclibc/nan2008/el/libgomp/config.h ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/gcc-libgomp/uclibc/nan2008/el/config.h
#rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/gccinstall ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/gcc/gccinstall.pdf
#rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/gccinstall.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly gccinstall
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/gccint ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/gcc/gccint.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/gccint.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly gccint
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/cppinternals ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/gcc/cppinternals.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/cppinternals.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly cppinternals
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/libiberty.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/libiberty.pdf
rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/.//libstdc++.so.6.0.21-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el//libstdc++.so.6.0.21-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el//libstdc++.so.6.0.21-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el//libstdc++.so.6.0.21-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008//libstdc++.so.6.0.21-gdb.py
#rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el//libstdc++.so.6.0.21-gdb.py
popenv
popenv

echo "----------------# task [213/397] /i686-pc-linux-gnu/toolchain/zlib/0/copy"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -rf ${local_path}/obj/zlib-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/zlib-1.2.8 ${local_path}/obj/zlib-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/zlib-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
popenv


echo "----------------# task [214/397] /i686-pc-linux-gnu/toolchain/zlib/0/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/zlib-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushenv
pushenvvar CFLAGS '-O3 -fPIC'
pushenvvar CC 'gcc  '
pushenvvar AR 'ar '
pushenvvar RANLIB 'ranlib '
./configure --prefix=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --static
popenv
popd
popenv

echo "----------------# task [215/397] /i686-pc-linux-gnu/toolchain/zlib/0/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/zlib-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX
popd
popenv

echo "----------------# task [216/397] /i686-pc-linux-gnu/toolchain/zlib/0/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/obj/zlib-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make install
popd
popenv

echo "----------------# task [217/397] /i686-pc-linux-gnu/toolchain/expat/0/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf ${local_path}/obj/expat-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/expat-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/expat-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/expat-2015.11 --prefix=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-linux-gnu --host=i686-pc-linux-gnu --disable-nls
popd
popenv
popenv
popenv

echo "----------------# task [218/397] /i686-pc-linux-gnu/toolchain/expat/0/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/expat-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [219/397] /i686-pc-linux-gnu/toolchain/expat/0/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/expat-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [220/397] /i686-pc-linux-gnu/toolchain/ncurses/0/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf ${local_path}/obj/ncurses-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/ncurses-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/ncurses-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/ncurses-5.9 --prefix=/usr --disable-shared --without-debug --without-cxx --without-ada --disable-nls --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu
popd
popenv
popenv
popenv

echo "----------------# task [221/397] /i686-pc-linux-gnu/toolchain/ncurses/0/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/ncurses-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make -j1
popd
popenv
popenv
popenv

echo "----------------# task [222/397] /i686-pc-linux-gnu/toolchain/ncurses/0/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushd ${local_path}/obj/ncurses-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make install DESTDIR=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu
popd
popenv
popenv
popenv

echo "----------------# task [223/397] /i686-pc-linux-gnu/toolchain/gdb/0/copy"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf ${local_path}/obj/gdb-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/gdb-2015.11 ${local_path}/obj/gdb-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/gdb-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
touch ${local_path}/obj/gdb-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv

echo "----------------# task [224/397] /i686-pc-linux-gnu/toolchain/gdb/0/configure"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf ${local_path}/obj/gdb-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/gdb-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/gdb-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/obj/gdb-src-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu --prefix=/opt/codesourcery --build=i686-pc-linux-gnu --target=mips-linux-gnu --host=i686-pc-linux-gnu --disable-sim --disable-binutils --disable-elfcpp --disable-gas --disable-gold --disable-gprof --disable-ld '--with-pkgversion=Ingenic 2016.03-32' --disable-libmcheck --disable-nls --with-libexpat-prefix=${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr --with-system-gdbinit=/opt/codesourcery/i686-pc-linux-gnu/mips-linux-gnu/lib/gdbinit '--with-gdb-datadir='\''${prefix}'\''/mips-linux-gnu/share/gdb'
popd
popenv
popenv
popenv

echo "----------------# task [225/397] /i686-pc-linux-gnu/toolchain/gdb/0/build"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/gdb-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX 2>&1|tee gdb_build.log
popd
popenv
popenv
popenv

echo "----------------# task [226/397] /i686-pc-linux-gnu/toolchain/gdb/0/install"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/gdb-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make install prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info
mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man datadir=${local_path}/install/opt/codesourcery/share 2>&1|tee gdb_install.log
popd
popenv
popenv
popenv
echo "----------------# task [227/397] /i686-pc-linux-gnu/toolchain/gdb/0/postinstall"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/gdb-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man datadir=${local_path}/install/opt/codesourcery/share install-html
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/man datadir=${local_path}/install/opt/codesourcery/share install-pdf
popd
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/annotate ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/annotate.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/annotate.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly annotate
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/gdbint ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/gdbint.pdf
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/stabs ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/stabs.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/stabs.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly stabs
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/configure.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/etc/configure.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/standards.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/etc/standards.pdf
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/bfd.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/bfd.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info/bfd.info
#install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/info --remove-exactly bfd
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/html/libiberty.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-linux-gnu/pdf/libiberty.pdf
pushd ${local_path}/install/opt/codesourcery
mkdir -p i686-pc-linux-gnu/mips-linux-gnu/include/
mv include/gdb i686-pc-linux-gnu/mips-linux-gnu/include
rm include -rf
popd
popenv
popenv
popenv

echo "----------------# task [228/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_0"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -rf ${local_path}/obj/gdbserver-2015.11-32-mips-linux-gnu/default/
mkdir -p ${local_path}/obj/gdbserver-2015.11-32-mips-linux-gnu/default/
pushd ${local_path}/obj/gdbserver-2015.11-32-mips-linux-gnu/default/
pushenv
pushenvvar RANLIB mips-linux-gnu-ranlib
pushenvvar CC 'mips-linux-gnu-gcc '
check_mentor_trademarks ${local_path}/src/gdb-2015.11/gdb/gdbserver --build=i686-pc-linux-gnu --host=mips-linux-gnu --prefix=/usr --disable-shared --disable-sim --disable-binutils --disable-elfcpp --disable-gas --disable-gold --disable-gprof --disable-ld '--with-pkgversion=Ingenic 2016.03-32' --disable-libmcheck
popenv
make $JX 2>&1|tee build_gdbserver_glibc_0.log
make DESTDIR=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./ install 2>&1|tee install_gdbserver_glibc_0.log
pushd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
mv usr/bin/gdbserver ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./bin
popd
popd
popenv

echo "----------------# task [229/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_1"
echo "----------------# task [230/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_2"
echo "----------------# task [231/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_3"
echo "----------------# task [232/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_4"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -rf ${local_path}/obj/gdbserver-2015.11-32-mips-linux-gnu/msoft-float/
mkdir -p ${local_path}/obj/gdbserver-2015.11-32-mips-linux-gnu/msoft-float/
pushd ${local_path}/obj/gdbserver-2015.11-32-mips-linux-gnu/msoft-float/
pushenv
pushenvvar RANLIB mips-linux-gnu-ranlib
pushenvvar CC 'mips-linux-gnu-gcc -msoft-float'
check_mentor_trademarks ${local_path}/src/gdb-2015.11/gdb/gdbserver --build=i686-pc-linux-gnu --host=mips-linux-gnu --prefix=/usr --disable-shared --disable-sim --disable-binutils --disable-elfcpp --disable-gas --disable-gold --disable-gprof --disable-ld '--with-pkgversion=Ingenic 2016.03-32'  --disable-libmcheck
popenv
make $JX
make DESTDIR=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/ install
pushd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
mv usr/bin/gdbserver ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/bin
popd
popd
popenv

echo "----------------# task [233/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_5"
echo "----------------# task [234/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_6"
echo "----------------# task [235/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_7"
echo "----------------# task [236/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_8"
echo "----------------# task [237/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_9"
echo "----------------# task [238/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_10"
echo "----------------# task [239/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_11"
echo "----------------# task [240/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_12"
echo "----------------# task [241/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_13"
echo "----------------# task [242/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/glibc_14"
echo "----------------# task [243/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/uclibc_0"
echo "----------------# task [244/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/uclibc_1"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -rf ${local_path}/obj/gdbserver-2015.11-32-mips-linux-gnu/muclibc/
mkdir -p ${local_path}/obj/gdbserver-2015.11-32-mips-linux-gnu/muclibc/
pushd ${local_path}/obj/gdbserver-2015.11-32-mips-linux-gnu/muclibc/
pushenv
pushenvvar RANLIB mips-linux-gnu-ranlib
pushenvvar CC 'mips-linux-gnu-gcc -muclibc -EL'
check_mentor_trademarks ${local_path}/src/gdb-2015.11/gdb/gdbserver --build=i686-pc-linux-gnu --host=mips-linux-gnu --prefix=/usr --disable-shared --disable-sim --disable-binutils --disable-elfcpp --disable-gas --disable-gold --disable-gprof --disable-ld '--with-pkgversion=Ingenic 2016.03-32'  --disable-libmcheck
popenv
make $JX
make DESTDIR=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/ install
pushd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/bin
mv usr/bin/gdbserver ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/bin
popd
popd
popenv

echo "----------------# task [245/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/uclibc_2"
echo "----------------# task [246/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/uclibc_3"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -rf ${local_path}/obj/gdbserver-2015.11-32-mips-linux-gnu/muclibc-msoft-float/
mkdir -p ${local_path}/obj/gdbserver-2015.11-32-mips-linux-gnu/muclibc-msoft-float/
pushd ${local_path}/obj/gdbserver-2015.11-32-mips-linux-gnu/muclibc-msoft-float/
pushenv
pushenvvar RANLIB mips-linux-gnu-ranlib
pushenvvar CC 'mips-linux-gnu-gcc -muclibc -EL -msoft-float'
check_mentor_trademarks ${local_path}/src/gdb-2015.11/gdb/gdbserver --build=i686-pc-linux-gnu --host=mips-linux-gnu --prefix=/usr --disable-shared --disable-sim --disable-binutils --disable-elfcpp --disable-gas --disable-gold --disable-gprof --disable-ld '--with-pkgversion=Ingenic 2016.03-32'  --disable-libmcheck
popenv
make $JX
make DESTDIR=${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/ install
pushd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/bin
mv usr/bin/gdbserver ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/bin
popd
popd
popenv

echo "----------------# task [247/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/uclibc_4"
echo "----------------# task [248/397] /i686-pc-linux-gnu/toolchain/build_gdbserver/uclibc_5"
echo "----------------# task [249/397] /i686-pc-linux-gnu/toolchain/cs3/gcc/configure"
echo "----------------# task [250/397] /i686-pc-linux-gnu/toolchain/cs3/gcc/build"
echo "----------------# task [251/397] /i686-pc-linux-gnu/toolchain/cs3/gcc/install"
echo "----------------# task [252/397] /i686-pc-linux-gnu/toolchain/cs3/gcc/configure"
echo "----------------# task [253/397] /i686-pc-linux-gnu/toolchain/cs3/gcc/build"
echo "----------------# task [254/397] /i686-pc-linux-gnu/toolchain/cs3/gcc/install"
echo "----------------# task [255/397] /i686-pc-linux-gnu/toolchain/getting_started/copy"
echo "----------------# task [256/397] /i686-pc-linux-gnu/toolchain/getting_started/configure"
echo "----------------# task [257/397] /i686-pc-linux-gnu/toolchain/getting_started/build"
echo "----------------# task [258/397] /i686-pc-linux-gnu/toolchain/getting_started/install"
echo "----------------# task [259/397] /i686-pc-linux-gnu/toolchain/getting_started/csl_docbook"
echo " ----------# task [260/397] /i686-pc-linux-gnu/toolchain/gdil/configure\n"
echo " ----------# task [261/397] /i686-pc-linux-gnu/toolchain/gdil/build\n"
echo " ----------# task [262/397] /i686-pc-linux-gnu/toolchain/gdil/install\n"
echo " ----------# task [263/397] /i686-pc-linux-gnu/edge_utils/build\n"
echo " ----------# task [264/397] /i686-pc-linux-gnu/mips_sprite/configure\n"
echo " ----------# task [265/397] /i686-pc-linux-gnu/mips_sprite/build\n"
echo " ----------# task [266/397] /i686-pc-linux-gnu/mips_sprite/install\n"
echo " ----------# task [267/397] /i686-pc-linux-gnu/mips_sprite/configure\n"
echo " ----------# task [268/397] /i686-pc-linux-gnu/sprite/build\n"
echo " ----------# task [269/397] /i686-pc-linux-gnu/sprite/install"
echo " ----------# task [270/397] /i686-pc-linux-gnu/sprite/postinstall"
echo " ----------# task [271/397] /i686-pc-linux-gnu/gettext/configure"
echo " ----------# task [272/397] /i686-pc-linux-gnu/gettext/build"
echo " ----------# task [273/397] /i686-pc-linux-gnu/gettext/install"
echo " ----------# task [274/397] /i686-pc-linux-gnu/libffi/configure"
echo " ----------# task [275/397] /i686-pc-linux-gnu/libffi/build"
echo " ----------# task [276/397] /i686-pc-linux-gnu/libffi/install"
echo " ----------# task [277/397] /i686-pc-linux-gnu/glib/copy"
echo " ----------# task [278/397] /i686-pc-linux-gnu/glib/configure"
echo " ----------# task [279/397] /i686-pc-linux-gnu/glib/build"
echo " ----------# task [280/397] /i686-pc-linux-gnu/glib/install"
echo " ----------# task [281/397] /i686-pc-linux-gnu/pixman/configure"
echo " ----------# task [282/397] /i686-pc-linux-gnu/pixman/build"
echo " ----------# task [283/397] /i686-pc-linux-gnu/pixman/install"
echo " ----------# task [284/397] /i686-pc-linux-gnu/pixman/postinstall"
echo " ----------# task [285/397] /i686-pc-linux-gnu/libfdt/copy"
echo " ----------# task [286/397] /i686-pc-linux-gnu/libfdt/configure"
echo " ----------# task [287/397] /i686-pc-linux-gnu/libfdt/build"
echo " ----------# task [288/397] /i686-pc-linux-gnu/libfdt/install"
echo " ----------# task [289/397] /i686-pc-linux-gnu/qemu/copy"
echo " ----------# task [290/397] /i686-pc-linux-gnu/qemu/configure"
echo " ----------# task [291/397] /i686-pc-linux-gnu/qemu/build"
echo " ----------# task [292/397] /i686-pc-linux-gnu/qemu/install"
echo " ----------# task [293/397] /i686-pc-linux-gnu/qemu/postinstall"
echo " ----------# task [294/397] /i686-pc-linux-gnu/finalize_libc_installation"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libstdc++.so.6.0.20 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libatomic.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/./
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/gdbserver ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/gdbserver
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./sbin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/ldconfig ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./sbin/ldconfig
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./sbin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/sln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./sbin/sln
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/catchsegv ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/catchsegv
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/gencat ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/gencat
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/getconf ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/getconf
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/getent ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/getent
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/iconv ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/iconv
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/ldd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/ldd
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/locale ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/locale
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/localedef ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/localedef
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/makedb ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/makedb
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/mtrace ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/mtrace
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/pcprofiledump ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/pcprofiledump
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/pldd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/pldd
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/rpcgen ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/rpcgen
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/sotruss ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/sotruss
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/sprof ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/sprof
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/tzselect ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/tzselect
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/xtrace ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/xtrace
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/sbin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/iconvconfig ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/sbin/iconvconfig
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/sbin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/nscd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/sbin/nscd
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/sbin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/zdump ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/sbin/zdump
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/sbin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/zic ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/sbin/zic
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/POSIX_V7_ILP32_OFF32 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf/POSIX_V7_ILP32_OFF32
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/POSIX_V7_ILP32_OFFBIG ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf/POSIX_V7_ILP32_OFFBIG
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/POSIX_V6_ILP32_OFF32 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf/POSIX_V6_ILP32_OFF32
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/POSIX_V6_ILP32_OFFBIG ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf/POSIX_V6_ILP32_OFFBIG
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/XBS5_ILP32_OFF32 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf/XBS5_ILP32_OFF32
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/lib/.//bin/XBS5_ILP32_OFFBIG ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf/XBS5_ILP32_OFFBIG
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/gdbserver
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./sbin/ldconfig
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./sbin/sln
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/catchsegv
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/gencat
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/getconf
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/getent
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/iconv
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/ldd
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/locale
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/localedef
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/makedb
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/mtrace
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/pcprofiledump
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/pldd
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/rpcgen
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/sotruss
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/sprof
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/tzselect
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/bin/xtrace
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/sbin/iconvconfig
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/sbin/nscd
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/sbin/zdump
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/sbin/zic
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf/POSIX_V7_ILP32_OFF32
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf/POSIX_V7_ILP32_OFFBIG
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf/POSIX_V6_ILP32_OFF32
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf/POSIX_V6_ILP32_OFFBIG
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf/XBS5_ILP32_OFF32
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/libexec/getconf/XBS5_ILP32_OFFBIG
rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/el/usr/include
rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/include
pushd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/etc
rm -f ./rpc
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./etc/./rpc ./rpc
popd
pushd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/share
rm -f ./info/dir
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./info/dir ./info/dir
rm -f ./i18n/charmaps/IBM860.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM860.gz ./i18n/charmaps/IBM860.gz
rm -f ./i18n/charmaps/IBM864.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM864.gz ./i18n/charmaps/IBM864.gz
rm -f ./i18n/charmaps/CP1254.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1254.gz ./i18n/charmaps/CP1254.gz
rm -f ./i18n/charmaps/BS_4730.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/BS_4730.gz ./i18n/charmaps/BS_4730.gz
rm -f ./i18n/charmaps/IBM903.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM903.gz ./i18n/charmaps/IBM903.gz
rm -f ./i18n/charmaps/CP771.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP771.gz ./i18n/charmaps/CP771.gz
rm -f ./i18n/charmaps/ISO-8859-3.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-3.gz ./i18n/charmaps/ISO-8859-3.gz
rm -f ./i18n/charmaps/CP1253.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1253.gz ./i18n/charmaps/CP1253.gz
rm -f ./i18n/charmaps/IBM880.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM880.gz ./i18n/charmaps/IBM880.gz
rm -f ./i18n/charmaps/EBCDIC-DK-NO-A.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-DK-NO-A.gz ./i18n/charmaps/EBCDIC-DK-NO-A.gz
rm -f ./i18n/charmaps/ISO-8859-9E.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-9E.gz ./i18n/charmaps/ISO-8859-9E.gz
rm -f ./i18n/charmaps/HP-ROMAN8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/HP-ROMAN8.gz ./i18n/charmaps/HP-ROMAN8.gz
rm -f ./i18n/charmaps/CP775.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP775.gz ./i18n/charmaps/CP775.gz
rm -f ./i18n/charmaps/IBM285.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM285.gz ./i18n/charmaps/IBM285.gz
rm -f ./i18n/charmaps/ISO_6937-2-25.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_6937-2-25.gz ./i18n/charmaps/ISO_6937-2-25.gz
rm -f ./i18n/charmaps/KOI8-T.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/KOI8-T.gz ./i18n/charmaps/KOI8-T.gz
rm -f ./i18n/charmaps/KOI-8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/KOI-8.gz ./i18n/charmaps/KOI-8.gz
rm -f ./i18n/charmaps/ISO-8859-10.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-10.gz ./i18n/charmaps/ISO-8859-10.gz
rm -f ./i18n/charmaps/ISO_5427.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_5427.gz ./i18n/charmaps/ISO_5427.gz
rm -f ./i18n/charmaps/EBCDIC-ES.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-ES.gz ./i18n/charmaps/EBCDIC-ES.gz
rm -f ./i18n/charmaps/GEORGIAN-PS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GEORGIAN-PS.gz ./i18n/charmaps/GEORGIAN-PS.gz
rm -f ./i18n/charmaps/IBM904.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM904.gz ./i18n/charmaps/IBM904.gz
rm -f ./i18n/charmaps/IBM1124.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1124.gz ./i18n/charmaps/IBM1124.gz
rm -f ./i18n/charmaps/IBM918.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM918.gz ./i18n/charmaps/IBM918.gz
rm -f ./i18n/charmaps/DS_2089.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/DS_2089.gz ./i18n/charmaps/DS_2089.gz
rm -f ./i18n/charmaps/JIS_C6229-1984-A.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6229-1984-A.gz ./i18n/charmaps/JIS_C6229-1984-A.gz
rm -f ./i18n/charmaps/HP-THAI8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/HP-THAI8.gz ./i18n/charmaps/HP-THAI8.gz
rm -f ./i18n/charmaps/EUC-KR.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EUC-KR.gz ./i18n/charmaps/EUC-KR.gz
rm -f ./i18n/charmaps/ANSI_X3.110-1983.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ANSI_X3.110-1983.gz ./i18n/charmaps/ANSI_X3.110-1983.gz
rm -f ./i18n/charmaps/ISO_6937-2-ADD.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_6937-2-ADD.gz ./i18n/charmaps/ISO_6937-2-ADD.gz
rm -f ./i18n/charmaps/CP10007.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP10007.gz ./i18n/charmaps/CP10007.gz
rm -f ./i18n/charmaps/IBM870.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM870.gz ./i18n/charmaps/IBM870.gz
rm -f ./i18n/charmaps/EBCDIC-FR.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-FR.gz ./i18n/charmaps/EBCDIC-FR.gz
rm -f ./i18n/charmaps/MAC-CYRILLIC.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MAC-CYRILLIC.gz ./i18n/charmaps/MAC-CYRILLIC.gz
rm -f ./i18n/charmaps/MAC-CENTRALEUROPE.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MAC-CENTRALEUROPE.gz ./i18n/charmaps/MAC-CENTRALEUROPE.gz
rm -f ./i18n/charmaps/ISO-IR-197.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-IR-197.gz ./i18n/charmaps/ISO-IR-197.gz
rm -f ./i18n/charmaps/CP1250.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1250.gz ./i18n/charmaps/CP1250.gz
rm -f ./i18n/charmaps/IBM1164.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1164.gz ./i18n/charmaps/IBM1164.gz
rm -f ./i18n/charmaps/NATS-SEFI.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NATS-SEFI.gz ./i18n/charmaps/NATS-SEFI.gz
rm -f ./i18n/charmaps/ISO-8859-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-1.gz ./i18n/charmaps/ISO-8859-1.gz
rm -f ./i18n/charmaps/ISO_10367-BOX.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_10367-BOX.gz ./i18n/charmaps/ISO_10367-BOX.gz
rm -f ./i18n/charmaps/EBCDIC-ES-A.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-ES-A.gz ./i18n/charmaps/EBCDIC-ES-A.gz
rm -f ./i18n/charmaps/PT2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/PT2.gz ./i18n/charmaps/PT2.gz
rm -f ./i18n/charmaps/CP949.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP949.gz ./i18n/charmaps/CP949.gz
rm -f ./i18n/charmaps/EBCDIC-CA-FR.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-CA-FR.gz ./i18n/charmaps/EBCDIC-CA-FR.gz
rm -f ./i18n/charmaps/NF_Z_62-010_1973.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NF_Z_62-010_1973.gz ./i18n/charmaps/NF_Z_62-010_1973.gz
rm -f ./i18n/charmaps/ISO-8859-2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-2.gz ./i18n/charmaps/ISO-8859-2.gz
rm -f ./i18n/charmaps/ES.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ES.gz ./i18n/charmaps/ES.gz
rm -f ./i18n/charmaps/T.101-G2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/T.101-G2.gz ./i18n/charmaps/T.101-G2.gz
rm -f ./i18n/charmaps/IEC_P27-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IEC_P27-1.gz ./i18n/charmaps/IEC_P27-1.gz
rm -f ./i18n/charmaps/IBM280.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM280.gz ./i18n/charmaps/IBM280.gz
rm -f ./i18n/charmaps/IBM1004.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1004.gz ./i18n/charmaps/IBM1004.gz
rm -f ./i18n/charmaps/CP1258.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1258.gz ./i18n/charmaps/CP1258.gz
rm -f ./i18n/charmaps/IBM281.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM281.gz ./i18n/charmaps/IBM281.gz
rm -f ./i18n/charmaps/GB18030.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GB18030.gz ./i18n/charmaps/GB18030.gz
rm -f ./i18n/charmaps/IBM1047.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1047.gz ./i18n/charmaps/IBM1047.gz
rm -f ./i18n/charmaps/GREEK-CCITT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GREEK-CCITT.gz ./i18n/charmaps/GREEK-CCITT.gz
rm -f ./i18n/charmaps/IBM1133.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1133.gz ./i18n/charmaps/IBM1133.gz
rm -f ./i18n/charmaps/GOST_19768-74.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GOST_19768-74.gz ./i18n/charmaps/GOST_19768-74.gz
rm -f ./i18n/charmaps/NC_NC00-10.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NC_NC00-10.gz ./i18n/charmaps/NC_NC00-10.gz
rm -f ./i18n/charmaps/IBM857.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM857.gz ./i18n/charmaps/IBM857.gz
rm -f ./i18n/charmaps/KOI8-RU.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/KOI8-RU.gz ./i18n/charmaps/KOI8-RU.gz
rm -f ./i18n/charmaps/ISO_646.IRV.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_646.IRV.gz ./i18n/charmaps/ISO_646.IRV.gz
rm -f ./i18n/charmaps/CP770.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP770.gz ./i18n/charmaps/CP770.gz
rm -f ./i18n/charmaps/IBM866NAV.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM866NAV.gz ./i18n/charmaps/IBM866NAV.gz
rm -f ./i18n/charmaps/IBM865.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM865.gz ./i18n/charmaps/IBM865.gz
rm -f ./i18n/charmaps/EUC-TW.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EUC-TW.gz ./i18n/charmaps/EUC-TW.gz
rm -f ./i18n/charmaps/IBM038.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM038.gz ./i18n/charmaps/IBM038.gz
rm -f ./i18n/charmaps/ES2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ES2.gz ./i18n/charmaps/ES2.gz
rm -f ./i18n/charmaps/T.61-8BIT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/T.61-8BIT.gz ./i18n/charmaps/T.61-8BIT.gz
rm -f ./i18n/charmaps/BRF.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/BRF.gz ./i18n/charmaps/BRF.gz
rm -f ./i18n/charmaps/JIS_X0201.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_X0201.gz ./i18n/charmaps/JIS_X0201.gz
rm -f ./i18n/charmaps/CP1256.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1256.gz ./i18n/charmaps/CP1256.gz
rm -f ./i18n/charmaps/IBM1132.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1132.gz ./i18n/charmaps/IBM1132.gz
rm -f ./i18n/charmaps/NS_4551-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NS_4551-1.gz ./i18n/charmaps/NS_4551-1.gz
rm -f ./i18n/charmaps/KOI8-U.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/KOI8-U.gz ./i18n/charmaps/KOI8-U.gz
rm -f ./i18n/charmaps/ANSI_X3.4-1968.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ANSI_X3.4-1968.gz ./i18n/charmaps/ANSI_X3.4-1968.gz
rm -f ./i18n/charmaps/EBCDIC-UK.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-UK.gz ./i18n/charmaps/EBCDIC-UK.gz
rm -f ./i18n/charmaps/IBM1161.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1161.gz ./i18n/charmaps/IBM1161.gz
rm -f ./i18n/charmaps/IBM868.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM868.gz ./i18n/charmaps/IBM868.gz
rm -f ./i18n/charmaps/IBM500.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM500.gz ./i18n/charmaps/IBM500.gz
rm -f ./i18n/charmaps/ISO_5428.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_5428.gz ./i18n/charmaps/ISO_5428.gz
rm -f ./i18n/charmaps/JIS_C6229-1984-B-ADD.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6229-1984-B-ADD.gz ./i18n/charmaps/JIS_C6229-1984-B-ADD.gz
rm -f ./i18n/charmaps/IBM297.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM297.gz ./i18n/charmaps/IBM297.gz
rm -f ./i18n/charmaps/ISO-IR-90.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-IR-90.gz ./i18n/charmaps/ISO-IR-90.gz
rm -f ./i18n/charmaps/MAC-SAMI.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MAC-SAMI.gz ./i18n/charmaps/MAC-SAMI.gz
rm -f ./i18n/charmaps/EBCDIC-DK-NO.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-DK-NO.gz ./i18n/charmaps/EBCDIC-DK-NO.gz
rm -f ./i18n/charmaps/LATIN-GREEK.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/LATIN-GREEK.gz ./i18n/charmaps/LATIN-GREEK.gz
rm -f ./i18n/charmaps/MAC-UK.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MAC-UK.gz ./i18n/charmaps/MAC-UK.gz
rm -f ./i18n/charmaps/PT154.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/PT154.gz ./i18n/charmaps/PT154.gz
rm -f ./i18n/charmaps/INIS-CYRILLIC.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/INIS-CYRILLIC.gz ./i18n/charmaps/INIS-CYRILLIC.gz
rm -f ./i18n/charmaps/INIS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/INIS.gz ./i18n/charmaps/INIS.gz
rm -f ./i18n/charmaps/SAMI-WS2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/SAMI-WS2.gz ./i18n/charmaps/SAMI-WS2.gz
rm -f ./i18n/charmaps/BIG5.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/BIG5.gz ./i18n/charmaps/BIG5.gz
rm -f ./i18n/charmaps/JIS_C6229-1984-B.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6229-1984-B.gz ./i18n/charmaps/JIS_C6229-1984-B.gz
rm -f ./i18n/charmaps/EBCDIC-US.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-US.gz ./i18n/charmaps/EBCDIC-US.gz
rm -f ./i18n/charmaps/LATIN-GREEK-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/LATIN-GREEK-1.gz ./i18n/charmaps/LATIN-GREEK-1.gz
rm -f ./i18n/charmaps/GB_1988-80.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GB_1988-80.gz ./i18n/charmaps/GB_1988-80.gz
rm -f ./i18n/charmaps/IBM861.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM861.gz ./i18n/charmaps/IBM861.gz
rm -f ./i18n/charmaps/MSZ_7795.3.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MSZ_7795.3.gz ./i18n/charmaps/MSZ_7795.3.gz
rm -f ./i18n/charmaps/ISO-8859-13.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-13.gz ./i18n/charmaps/ISO-8859-13.gz
rm -f ./i18n/charmaps/TSCII.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/TSCII.gz ./i18n/charmaps/TSCII.gz
rm -f ./i18n/charmaps/BS_VIEWDATA.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/BS_VIEWDATA.gz ./i18n/charmaps/BS_VIEWDATA.gz
rm -f ./i18n/charmaps/ISO-8859-4.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-4.gz ./i18n/charmaps/ISO-8859-4.gz
rm -f ./i18n/charmaps/IBM284.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM284.gz ./i18n/charmaps/IBM284.gz
rm -f ./i18n/charmaps/SAMI.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/SAMI.gz ./i18n/charmaps/SAMI.gz
rm -f ./i18n/charmaps/CP1125.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1125.gz ./i18n/charmaps/CP1125.gz
rm -f ./i18n/charmaps/HP-ROMAN9.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/HP-ROMAN9.gz ./i18n/charmaps/HP-ROMAN9.gz
rm -f ./i18n/charmaps/IBM424.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM424.gz ./i18n/charmaps/IBM424.gz
rm -f ./i18n/charmaps/NATS-SEFI-ADD.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NATS-SEFI-ADD.gz ./i18n/charmaps/NATS-SEFI-ADD.gz
rm -f ./i18n/charmaps/ASMO_449.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ASMO_449.gz ./i18n/charmaps/ASMO_449.gz
rm -f ./i18n/charmaps/DEC-MCS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/DEC-MCS.gz ./i18n/charmaps/DEC-MCS.gz
rm -f ./i18n/charmaps/IBM922.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM922.gz ./i18n/charmaps/IBM922.gz
rm -f ./i18n/charmaps/IBM278.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM278.gz ./i18n/charmaps/IBM278.gz
rm -f ./i18n/charmaps/SEN_850200_C.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/SEN_850200_C.gz ./i18n/charmaps/SEN_850200_C.gz
rm -f ./i18n/charmaps/JIS_C6229-1984-HAND.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6229-1984-HAND.gz ./i18n/charmaps/JIS_C6229-1984-HAND.gz
rm -f ./i18n/charmaps/INVARIANT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/INVARIANT.gz ./i18n/charmaps/INVARIANT.gz
rm -f ./i18n/charmaps/ISO-8859-5.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-5.gz ./i18n/charmaps/ISO-8859-5.gz
rm -f ./i18n/charmaps/CSA_Z243.4-1985-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CSA_Z243.4-1985-1.gz ./i18n/charmaps/CSA_Z243.4-1985-1.gz
rm -f ./i18n/charmaps/ISO_5427-EXT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_5427-EXT.gz ./i18n/charmaps/ISO_5427-EXT.gz
rm -f ./i18n/charmaps/TIS-620.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/TIS-620.gz ./i18n/charmaps/TIS-620.gz
rm -f ./i18n/charmaps/NATS-DANO-ADD.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NATS-DANO-ADD.gz ./i18n/charmaps/NATS-DANO-ADD.gz
rm -f ./i18n/charmaps/IBM256.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM256.gz ./i18n/charmaps/IBM256.gz
rm -f ./i18n/charmaps/IBM852.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM852.gz ./i18n/charmaps/IBM852.gz
rm -f ./i18n/charmaps/UTF-8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/UTF-8.gz ./i18n/charmaps/UTF-8.gz
rm -f ./i18n/charmaps/JIS_C6220-1969-RO.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6220-1969-RO.gz ./i18n/charmaps/JIS_C6220-1969-RO.gz
rm -f ./i18n/charmaps/HP-GREEK8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/HP-GREEK8.gz ./i18n/charmaps/HP-GREEK8.gz
rm -f ./i18n/charmaps/DIN_66003.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/DIN_66003.gz ./i18n/charmaps/DIN_66003.gz
rm -f ./i18n/charmaps/ISO_646.BASIC.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_646.BASIC.gz ./i18n/charmaps/ISO_646.BASIC.gz
rm -f ./i18n/charmaps/IBM277.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM277.gz ./i18n/charmaps/IBM277.gz
rm -f ./i18n/charmaps/ISO_2033-1983.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_2033-1983.gz ./i18n/charmaps/ISO_2033-1983.gz
rm -f ./i18n/charmaps/ISO_10646.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_10646.gz ./i18n/charmaps/ISO_10646.gz
rm -f ./i18n/charmaps/CP773.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP773.gz ./i18n/charmaps/CP773.gz
rm -f ./i18n/charmaps/IBM855.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM855.gz ./i18n/charmaps/IBM855.gz
rm -f ./i18n/charmaps/GREEK7-OLD.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GREEK7-OLD.gz ./i18n/charmaps/GREEK7-OLD.gz
rm -f ./i18n/charmaps/CWI.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CWI.gz ./i18n/charmaps/CWI.gz
rm -f ./i18n/charmaps/IBM437.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM437.gz ./i18n/charmaps/IBM437.gz
rm -f ./i18n/charmaps/GBK.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GBK.gz ./i18n/charmaps/GBK.gz
rm -f ./i18n/charmaps/IBM875.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM875.gz ./i18n/charmaps/IBM875.gz
rm -f ./i18n/charmaps/MACINTOSH.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MACINTOSH.gz ./i18n/charmaps/MACINTOSH.gz
rm -f ./i18n/charmaps/WINDOWS-31J.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/WINDOWS-31J.gz ./i18n/charmaps/WINDOWS-31J.gz
rm -f ./i18n/charmaps/NF_Z_62-010.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NF_Z_62-010.gz ./i18n/charmaps/NF_Z_62-010.gz
rm -f ./i18n/charmaps/EUC-JP.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EUC-JP.gz ./i18n/charmaps/EUC-JP.gz
rm -f ./i18n/charmaps/ISO-8859-8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-8.gz ./i18n/charmaps/ISO-8859-8.gz
rm -f ./i18n/charmaps/EBCDIC-IT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-IT.gz ./i18n/charmaps/EBCDIC-IT.gz
rm -f ./i18n/charmaps/ISO-8859-15.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-15.gz ./i18n/charmaps/ISO-8859-15.gz
rm -f ./i18n/charmaps/JUS_I.B1.003-MAC.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JUS_I.B1.003-MAC.gz ./i18n/charmaps/JUS_I.B1.003-MAC.gz
rm -f ./i18n/charmaps/CP737.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP737.gz ./i18n/charmaps/CP737.gz
rm -f ./i18n/charmaps/ISO-8859-11.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-11.gz ./i18n/charmaps/ISO-8859-11.gz
rm -f ./i18n/charmaps/VIDEOTEX-SUPPL.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/VIDEOTEX-SUPPL.gz ./i18n/charmaps/VIDEOTEX-SUPPL.gz
rm -f ./i18n/charmaps/IBM863.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM863.gz ./i18n/charmaps/IBM863.gz
rm -f ./i18n/charmaps/MAC-IS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MAC-IS.gz ./i18n/charmaps/MAC-IS.gz
rm -f ./i18n/charmaps/CSN_369103.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CSN_369103.gz ./i18n/charmaps/CSN_369103.gz
rm -f ./i18n/charmaps/ISO_11548-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_11548-1.gz ./i18n/charmaps/ISO_11548-1.gz
rm -f ./i18n/charmaps/GB2312.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GB2312.gz ./i18n/charmaps/GB2312.gz
rm -f ./i18n/charmaps/ISO_6937.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_6937.gz ./i18n/charmaps/ISO_6937.gz
rm -f ./i18n/charmaps/JIS_C6229-1984-KANA.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6229-1984-KANA.gz ./i18n/charmaps/JIS_C6229-1984-KANA.gz
rm -f ./i18n/charmaps/CP1252.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1252.gz ./i18n/charmaps/CP1252.gz
rm -f ./i18n/charmaps/ISO_8859-SUPP.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_8859-SUPP.gz ./i18n/charmaps/ISO_8859-SUPP.gz
rm -f ./i18n/charmaps/BIG5-HKSCS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/BIG5-HKSCS.gz ./i18n/charmaps/BIG5-HKSCS.gz
rm -f ./i18n/charmaps/EBCDIC-PT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-PT.gz ./i18n/charmaps/EBCDIC-PT.gz
rm -f ./i18n/charmaps/IBM1162.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1162.gz ./i18n/charmaps/IBM1162.gz
rm -f ./i18n/charmaps/NS_4551-2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NS_4551-2.gz ./i18n/charmaps/NS_4551-2.gz
rm -f ./i18n/charmaps/IBM905.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM905.gz ./i18n/charmaps/IBM905.gz
rm -f ./i18n/charmaps/JIS_C6220-1969-JP.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6220-1969-JP.gz ./i18n/charmaps/JIS_C6220-1969-JP.gz
rm -f ./i18n/charmaps/NATS-DANO.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NATS-DANO.gz ./i18n/charmaps/NATS-DANO.gz
rm -f ./i18n/charmaps/INIS-8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/INIS-8.gz ./i18n/charmaps/INIS-8.gz
rm -f ./i18n/charmaps/IBM274.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM274.gz ./i18n/charmaps/IBM274.gz
rm -f ./i18n/charmaps/IBM850.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM850.gz ./i18n/charmaps/IBM850.gz
rm -f ./i18n/charmaps/IBM1129.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1129.gz ./i18n/charmaps/IBM1129.gz
rm -f ./i18n/charmaps/VISCII.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/VISCII.gz ./i18n/charmaps/VISCII.gz
rm -f ./i18n/charmaps/IBM1163.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1163.gz ./i18n/charmaps/IBM1163.gz
rm -f ./i18n/charmaps/IBM273.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM273.gz ./i18n/charmaps/IBM273.gz
rm -f ./i18n/charmaps/EBCDIC-FI-SE.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-FI-SE.gz ./i18n/charmaps/EBCDIC-FI-SE.gz
rm -f ./i18n/charmaps/IBM871.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM871.gz ./i18n/charmaps/IBM871.gz
rm -f ./i18n/charmaps/IBM275.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM275.gz ./i18n/charmaps/IBM275.gz
rm -f ./i18n/charmaps/SHIFT_JIS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/SHIFT_JIS.gz ./i18n/charmaps/SHIFT_JIS.gz
rm -f ./i18n/charmaps/EBCDIC-FI-SE-A.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-FI-SE-A.gz ./i18n/charmaps/EBCDIC-FI-SE-A.gz
rm -f ./i18n/charmaps/SEN_850200_B.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/SEN_850200_B.gz ./i18n/charmaps/SEN_850200_B.gz
rm -f ./i18n/charmaps/IBM423.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM423.gz ./i18n/charmaps/IBM423.gz
rm -f ./i18n/charmaps/MIK.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MIK.gz ./i18n/charmaps/MIK.gz
rm -f ./i18n/charmaps/IBM869.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM869.gz ./i18n/charmaps/IBM869.gz
rm -f ./i18n/charmaps/HP-TURKISH8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/HP-TURKISH8.gz ./i18n/charmaps/HP-TURKISH8.gz
rm -f ./i18n/charmaps/ARMSCII-8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ARMSCII-8.gz ./i18n/charmaps/ARMSCII-8.gz
rm -f ./i18n/charmaps/GEORGIAN-ACADEMY.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GEORGIAN-ACADEMY.gz ./i18n/charmaps/GEORGIAN-ACADEMY.gz
rm -f ./i18n/charmaps/CP772.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP772.gz ./i18n/charmaps/CP772.gz
rm -f ./i18n/charmaps/PT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/PT.gz ./i18n/charmaps/PT.gz
rm -f ./i18n/charmaps/T.61-7BIT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/T.61-7BIT.gz ./i18n/charmaps/T.61-7BIT.gz
rm -f ./i18n/charmaps/IBM420.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM420.gz ./i18n/charmaps/IBM420.gz
rm -f ./i18n/charmaps/EBCDIC-AT-DE.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-AT-DE.gz ./i18n/charmaps/EBCDIC-AT-DE.gz
rm -f ./i18n/charmaps/ISO-8859-14.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-14.gz ./i18n/charmaps/ISO-8859-14.gz
rm -f ./i18n/charmaps/GREEK7.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GREEK7.gz ./i18n/charmaps/GREEK7.gz
rm -f ./i18n/charmaps/ECMA-CYRILLIC.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ECMA-CYRILLIC.gz ./i18n/charmaps/ECMA-CYRILLIC.gz
rm -f ./i18n/charmaps/ISO_8859-1,GL.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_8859-1,GL.gz ./i18n/charmaps/ISO_8859-1,GL.gz
rm -f ./i18n/charmaps/CP774.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP774.gz ./i18n/charmaps/CP774.gz
rm -f ./i18n/charmaps/NEXTSTEP.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NEXTSTEP.gz ./i18n/charmaps/NEXTSTEP.gz
rm -f ./i18n/charmaps/TCVN5712-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/TCVN5712-1.gz ./i18n/charmaps/TCVN5712-1.gz
rm -f ./i18n/charmaps/EUC-JP-MS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EUC-JP-MS.gz ./i18n/charmaps/EUC-JP-MS.gz
rm -f ./i18n/charmaps/IBM1160.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1160.gz ./i18n/charmaps/IBM1160.gz
rm -f ./i18n/charmaps/IBM1026.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1026.gz ./i18n/charmaps/IBM1026.gz
rm -f ./i18n/charmaps/IBM851.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM851.gz ./i18n/charmaps/IBM851.gz
rm -f ./i18n/charmaps/CP1255.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1255.gz ./i18n/charmaps/CP1255.gz
rm -f ./i18n/charmaps/SHIFT_JISX0213.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/SHIFT_JISX0213.gz ./i18n/charmaps/SHIFT_JISX0213.gz
rm -f ./i18n/charmaps/ISO-8859-9.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-9.gz ./i18n/charmaps/ISO-8859-9.gz
rm -f ./i18n/charmaps/IBM874.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM874.gz ./i18n/charmaps/IBM874.gz
rm -f ./i18n/charmaps/CSA_Z243.4-1985-GR.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CSA_Z243.4-1985-GR.gz ./i18n/charmaps/CSA_Z243.4-1985-GR.gz
rm -f ./i18n/charmaps/IBM856.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM856.gz ./i18n/charmaps/IBM856.gz
rm -f ./i18n/charmaps/IBM866.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM866.gz ./i18n/charmaps/IBM866.gz
rm -f ./i18n/charmaps/EBCDIC-ES-S.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-ES-S.gz ./i18n/charmaps/EBCDIC-ES-S.gz
rm -f ./i18n/charmaps/IBM290.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM290.gz ./i18n/charmaps/IBM290.gz
rm -f ./i18n/charmaps/CSA_Z243.4-1985-2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CSA_Z243.4-1985-2.gz ./i18n/charmaps/CSA_Z243.4-1985-2.gz
rm -f ./i18n/charmaps/EBCDIC-IS-FRISS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-IS-FRISS.gz ./i18n/charmaps/EBCDIC-IS-FRISS.gz
rm -f ./i18n/charmaps/IBM037.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM037.gz ./i18n/charmaps/IBM037.gz
rm -f ./i18n/charmaps/CP1251.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1251.gz ./i18n/charmaps/CP1251.gz
rm -f ./i18n/charmaps/JUS_I.B1.002.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JUS_I.B1.002.gz ./i18n/charmaps/JUS_I.B1.002.gz
rm -f ./i18n/charmaps/RK1048.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/RK1048.gz ./i18n/charmaps/RK1048.gz
rm -f ./i18n/charmaps/ISO-8859-7.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-7.gz ./i18n/charmaps/ISO-8859-7.gz
rm -f ./i18n/charmaps/CP1257.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1257.gz ./i18n/charmaps/CP1257.gz
rm -f ./i18n/charmaps/IBM862.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM862.gz ./i18n/charmaps/IBM862.gz
rm -f ./i18n/charmaps/ISO-IR-209.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-IR-209.gz ./i18n/charmaps/ISO-IR-209.gz
rm -f ./i18n/charmaps/IBM891.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM891.gz ./i18n/charmaps/IBM891.gz
rm -f ./i18n/charmaps/KOI8-R.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/KOI8-R.gz ./i18n/charmaps/KOI8-R.gz
rm -f ./i18n/charmaps/KSC5636.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/KSC5636.gz ./i18n/charmaps/KSC5636.gz
rm -f ./i18n/charmaps/ISO-8859-16.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-16.gz ./i18n/charmaps/ISO-8859-16.gz
rm -f ./i18n/charmaps/ISO-8859-6.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-6.gz ./i18n/charmaps/ISO-8859-6.gz
rm -f ./i18n/charmaps/EBCDIC-AT-DE-A.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-AT-DE-A.gz ./i18n/charmaps/EBCDIC-AT-DE-A.gz
rm -f ./i18n/charmaps/JOHAB.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JOHAB.gz ./i18n/charmaps/JOHAB.gz
rm -f ./i18n/charmaps/JIS_C6229-1984-HAND-ADD.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6229-1984-HAND-ADD.gz ./i18n/charmaps/JIS_C6229-1984-HAND-ADD.gz
rm -f ./i18n/charmaps/ISIRI-3342.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISIRI-3342.gz ./i18n/charmaps/ISIRI-3342.gz
rm -f ./i18n/charmaps/EUC-JISX0213.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EUC-JISX0213.gz ./i18n/charmaps/EUC-JISX0213.gz
rm -f ./i18n/charmaps/IT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IT.gz ./i18n/charmaps/IT.gz
rm -f ./i18n/charmaps/JUS_I.B1.003-SERB.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JUS_I.B1.003-SERB.gz ./i18n/charmaps/JUS_I.B1.003-SERB.gz
rm -f ./i18n/locales/gu_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gu_IN ./i18n/locales/gu_IN
rm -f ./i18n/locales/fa_IR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fa_IR ./i18n/locales/fa_IR
rm -f ./i18n/locales/ta_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ta_IN ./i18n/locales/ta_IN
rm -f ./i18n/locales/es_SV
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_SV ./i18n/locales/es_SV
rm -f ./i18n/locales/tr_CY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tr_CY ./i18n/locales/tr_CY
rm -f ./i18n/locales/ga_IE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ga_IE@euro ./i18n/locales/ga_IE@euro
rm -f ./i18n/locales/en_AG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_AG ./i18n/locales/en_AG
rm -f ./i18n/locales/et_EE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/et_EE ./i18n/locales/et_EE
rm -f ./i18n/locales/eu_ES
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/eu_ES ./i18n/locales/eu_ES
rm -f ./i18n/locales/it_IT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/it_IT ./i18n/locales/it_IT
rm -f ./i18n/locales/iu_CA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/iu_CA ./i18n/locales/iu_CA
rm -f ./i18n/locales/pap_AW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pap_AW ./i18n/locales/pap_AW
rm -f ./i18n/locales/om_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/om_ET ./i18n/locales/om_ET
rm -f ./i18n/locales/my_MM
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/my_MM ./i18n/locales/my_MM
rm -f ./i18n/locales/ky_KG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ky_KG ./i18n/locales/ky_KG
rm -f ./i18n/locales/unm_US
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/unm_US ./i18n/locales/unm_US
rm -f ./i18n/locales/es_UY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_UY ./i18n/locales/es_UY
rm -f ./i18n/locales/ur_PK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ur_PK ./i18n/locales/ur_PK
rm -f ./i18n/locales/aa_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/aa_ET ./i18n/locales/aa_ET
rm -f ./i18n/locales/gez_ER
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gez_ER ./i18n/locales/gez_ER
rm -f ./i18n/locales/aa_DJ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/aa_DJ ./i18n/locales/aa_DJ
rm -f ./i18n/locales/zh_TW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/zh_TW ./i18n/locales/zh_TW
rm -f ./i18n/locales/anp_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/anp_IN ./i18n/locales/anp_IN
rm -f ./i18n/locales/kok_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/kok_IN ./i18n/locales/kok_IN
rm -f ./i18n/locales/en_NG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_NG ./i18n/locales/en_NG
rm -f ./i18n/locales/ar_JO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_JO ./i18n/locales/ar_JO
rm -f ./i18n/locales/de_AT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_AT ./i18n/locales/de_AT
rm -f ./i18n/locales/so_DJ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/so_DJ ./i18n/locales/so_DJ
rm -f ./i18n/locales/fy_NL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fy_NL ./i18n/locales/fy_NL
rm -f ./i18n/locales/es_AR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_AR ./i18n/locales/es_AR
rm -f ./i18n/locales/ku_TR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ku_TR ./i18n/locales/ku_TR
rm -f ./i18n/locales/wa_BE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/wa_BE@euro ./i18n/locales/wa_BE@euro
rm -f ./i18n/locales/ar_SY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_SY ./i18n/locales/ar_SY
rm -f ./i18n/locales/de_BE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_BE@euro ./i18n/locales/de_BE@euro
rm -f ./i18n/locales/ve_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ve_ZA ./i18n/locales/ve_ZA
rm -f ./i18n/locales/es_PR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_PR ./i18n/locales/es_PR
rm -f ./i18n/locales/ug_CN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ug_CN ./i18n/locales/ug_CN
rm -f ./i18n/locales/kl_GL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/kl_GL ./i18n/locales/kl_GL
rm -f ./i18n/locales/es_CR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_CR ./i18n/locales/es_CR
rm -f ./i18n/locales/ff_SN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ff_SN ./i18n/locales/ff_SN
rm -f ./i18n/locales/hi_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hi_IN ./i18n/locales/hi_IN
rm -f ./i18n/locales/quz_PE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/quz_PE ./i18n/locales/quz_PE
rm -f ./i18n/locales/iso14651_t1_pinyin
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/iso14651_t1_pinyin ./i18n/locales/iso14651_t1_pinyin
rm -f ./i18n/locales/ta_LK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ta_LK ./i18n/locales/ta_LK
rm -f ./i18n/locales/ayc_PE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ayc_PE ./i18n/locales/ayc_PE
rm -f ./i18n/locales/hr_HR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hr_HR ./i18n/locales/hr_HR
rm -f ./i18n/locales/ka_GE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ka_GE ./i18n/locales/ka_GE
rm -f ./i18n/locales/pa_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pa_IN ./i18n/locales/pa_IN
rm -f ./i18n/locales/nr_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nr_ZA ./i18n/locales/nr_ZA
rm -f ./i18n/locales/bho_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bho_IN ./i18n/locales/bho_IN
rm -f ./i18n/locales/wae_CH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/wae_CH ./i18n/locales/wae_CH
rm -f ./i18n/locales/hy_AM
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hy_AM ./i18n/locales/hy_AM
rm -f ./i18n/locales/es_EC
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_EC ./i18n/locales/es_EC
rm -f ./i18n/locales/mag_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mag_IN ./i18n/locales/mag_IN
rm -f ./i18n/locales/de_CH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_CH ./i18n/locales/de_CH
rm -f ./i18n/locales/es_BO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_BO ./i18n/locales/es_BO
rm -f ./i18n/locales/ne_NP
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ne_NP ./i18n/locales/ne_NP
rm -f ./i18n/locales/lg_UG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lg_UG ./i18n/locales/lg_UG
rm -f ./i18n/locales/csb_PL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/csb_PL ./i18n/locales/csb_PL
rm -f ./i18n/locales/yo_NG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/yo_NG ./i18n/locales/yo_NG
rm -f ./i18n/locales/br_FR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/br_FR ./i18n/locales/br_FR
rm -f ./i18n/locales/gd_GB
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gd_GB ./i18n/locales/gd_GB
rm -f ./i18n/locales/en_ZW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_ZW ./i18n/locales/en_ZW
rm -f ./i18n/locales/POSIX
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/POSIX ./i18n/locales/POSIX
rm -f ./i18n/locales/sv_FI
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sv_FI ./i18n/locales/sv_FI
rm -f ./i18n/locales/sat_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sat_IN ./i18n/locales/sat_IN
rm -f ./i18n/locales/hak_TW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hak_TW ./i18n/locales/hak_TW
rm -f ./i18n/locales/sv_SE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sv_SE ./i18n/locales/sv_SE
rm -f ./i18n/locales/nds_NL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nds_NL ./i18n/locales/nds_NL
rm -f ./i18n/locales/el_CY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/el_CY ./i18n/locales/el_CY
rm -f ./i18n/locales/sk_SK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sk_SK ./i18n/locales/sk_SK
rm -f ./i18n/locales/es_US
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_US ./i18n/locales/es_US
rm -f ./i18n/locales/yue_HK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/yue_HK ./i18n/locales/yue_HK
rm -f ./i18n/locales/translit_compat
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_compat ./i18n/locales/translit_compat
rm -f ./i18n/locales/fr_FR@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_FR@euro ./i18n/locales/fr_FR@euro
rm -f ./i18n/locales/iso14651_t1_common
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/iso14651_t1_common ./i18n/locales/iso14651_t1_common
rm -f ./i18n/locales/ar_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_IN ./i18n/locales/ar_IN
rm -f ./i18n/locales/niu_NU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/niu_NU ./i18n/locales/niu_NU
rm -f ./i18n/locales/bo_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bo_IN ./i18n/locales/bo_IN
rm -f ./i18n/locales/mn_MN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mn_MN ./i18n/locales/mn_MN
rm -f ./i18n/locales/ar_KW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_KW ./i18n/locales/ar_KW
rm -f ./i18n/locales/hne_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hne_IN ./i18n/locales/hne_IN
rm -f ./i18n/locales/om_KE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/om_KE ./i18n/locales/om_KE
rm -f ./i18n/locales/de_DE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_DE@euro ./i18n/locales/de_DE@euro
rm -f ./i18n/locales/bn_BD
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bn_BD ./i18n/locales/bn_BD
rm -f ./i18n/locales/be_BY@latin
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/be_BY@latin ./i18n/locales/be_BY@latin
rm -f ./i18n/locales/translit_cjk_variants
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_cjk_variants ./i18n/locales/translit_cjk_variants
rm -f ./i18n/locales/bem_ZM
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bem_ZM ./i18n/locales/bem_ZM
rm -f ./i18n/locales/rw_RW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/rw_RW ./i18n/locales/rw_RW
rm -f ./i18n/locales/translit_hangul
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_hangul ./i18n/locales/translit_hangul
rm -f ./i18n/locales/mhr_RU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mhr_RU ./i18n/locales/mhr_RU
rm -f ./i18n/locales/es_CL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_CL ./i18n/locales/es_CL
rm -f ./i18n/locales/translit_cjk_compat
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_cjk_compat ./i18n/locales/translit_cjk_compat
rm -f ./i18n/locales/ar_BH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_BH ./i18n/locales/ar_BH
rm -f ./i18n/locales/ar_LB
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_LB ./i18n/locales/ar_LB
rm -f ./i18n/locales/nb_NO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nb_NO ./i18n/locales/nb_NO
rm -f ./i18n/locales/fr_FR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_FR ./i18n/locales/fr_FR
rm -f ./i18n/locales/i18n
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/i18n ./i18n/locales/i18n
rm -f ./i18n/locales/it_IT@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/it_IT@euro ./i18n/locales/it_IT@euro
rm -f ./i18n/locales/xh_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/xh_ZA ./i18n/locales/xh_ZA
rm -f ./i18n/locales/es_VE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_VE ./i18n/locales/es_VE
rm -f ./i18n/locales/en_PH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_PH ./i18n/locales/en_PH
rm -f ./i18n/locales/lb_LU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lb_LU ./i18n/locales/lb_LU
rm -f ./i18n/locales/fr_BE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_BE ./i18n/locales/fr_BE
rm -f ./i18n/locales/es_NI
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_NI ./i18n/locales/es_NI
rm -f ./i18n/locales/nl_NL@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nl_NL@euro ./i18n/locales/nl_NL@euro
rm -f ./i18n/locales/en_AU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_AU ./i18n/locales/en_AU
rm -f ./i18n/locales/uz_UZ@cyrillic
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/uz_UZ@cyrillic ./i18n/locales/uz_UZ@cyrillic
rm -f ./i18n/locales/iso14651_t1
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/iso14651_t1 ./i18n/locales/iso14651_t1
rm -f ./i18n/locales/so_KE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/so_KE ./i18n/locales/so_KE
rm -f ./i18n/locales/pt_BR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pt_BR ./i18n/locales/pt_BR
rm -f ./i18n/locales/te_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/te_IN ./i18n/locales/te_IN
rm -f ./i18n/locales/zu_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/zu_ZA ./i18n/locales/zu_ZA
rm -f ./i18n/locales/lv_LV
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lv_LV ./i18n/locales/lv_LV
rm -f ./i18n/locales/sw_KE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sw_KE ./i18n/locales/sw_KE
rm -f ./i18n/locales/ss_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ss_ZA ./i18n/locales/ss_ZA
rm -f ./i18n/locales/tt_RU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tt_RU ./i18n/locales/tt_RU
rm -f ./i18n/locales/gl_ES
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gl_ES ./i18n/locales/gl_ES
rm -f ./i18n/locales/fil_PH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fil_PH ./i18n/locales/fil_PH
rm -f ./i18n/locales/ca_AD
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ca_AD ./i18n/locales/ca_AD
rm -f ./i18n/locales/es_CO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_CO ./i18n/locales/es_CO
rm -f ./i18n/locales/sl_SI
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sl_SI ./i18n/locales/sl_SI
rm -f ./i18n/locales/az_AZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/az_AZ ./i18n/locales/az_AZ
rm -f ./i18n/locales/gez_ET@abegede
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gez_ET@abegede ./i18n/locales/gez_ET@abegede
rm -f ./i18n/locales/tk_TM
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tk_TM ./i18n/locales/tk_TM
rm -f ./i18n/locales/gl_ES@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gl_ES@euro ./i18n/locales/gl_ES@euro
rm -f ./i18n/locales/ps_AF
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ps_AF ./i18n/locales/ps_AF
rm -f ./i18n/locales/es_HN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_HN ./i18n/locales/es_HN
rm -f ./i18n/locales/ia_FR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ia_FR ./i18n/locales/ia_FR
rm -f ./i18n/locales/fr_LU@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_LU@euro ./i18n/locales/fr_LU@euro
rm -f ./i18n/locales/cmn_TW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/cmn_TW ./i18n/locales/cmn_TW
rm -f ./i18n/locales/nds_DE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nds_DE ./i18n/locales/nds_DE
rm -f ./i18n/locales/ht_HT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ht_HT ./i18n/locales/ht_HT
rm -f ./i18n/locales/hsb_DE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hsb_DE ./i18n/locales/hsb_DE
rm -f ./i18n/locales/bhb_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bhb_IN ./i18n/locales/bhb_IN
rm -f ./i18n/locales/gv_GB
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gv_GB ./i18n/locales/gv_GB
rm -f ./i18n/locales/ko_KR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ko_KR ./i18n/locales/ko_KR
rm -f ./i18n/locales/ber_DZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ber_DZ ./i18n/locales/ber_DZ
rm -f ./i18n/locales/ks_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ks_IN ./i18n/locales/ks_IN
rm -f ./i18n/locales/pt_PT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pt_PT ./i18n/locales/pt_PT
rm -f ./i18n/locales/cv_RU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/cv_RU ./i18n/locales/cv_RU
rm -f ./i18n/locales/am_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/am_ET ./i18n/locales/am_ET
rm -f ./i18n/locales/ru_UA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ru_UA ./i18n/locales/ru_UA
rm -f ./i18n/locales/dz_BT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/dz_BT ./i18n/locales/dz_BT
rm -f ./i18n/locales/es_PE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_PE ./i18n/locales/es_PE
rm -f ./i18n/locales/fur_IT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fur_IT ./i18n/locales/fur_IT
rm -f ./i18n/locales/translit_small
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_small ./i18n/locales/translit_small
rm -f ./i18n/locales/is_IS
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/is_IS ./i18n/locales/is_IS
rm -f ./i18n/locales/mr_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mr_IN ./i18n/locales/mr_IN
rm -f ./i18n/locales/en_HK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_HK ./i18n/locales/en_HK
rm -f ./i18n/locales/pl_PL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pl_PL ./i18n/locales/pl_PL
rm -f ./i18n/locales/lij_IT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lij_IT ./i18n/locales/lij_IT
rm -f ./i18n/locales/mk_MK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mk_MK ./i18n/locales/mk_MK
rm -f ./i18n/locales/af_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/af_ZA ./i18n/locales/af_ZA
rm -f ./i18n/locales/iw_IL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/iw_IL ./i18n/locales/iw_IL
rm -f ./i18n/locales/or_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/or_IN ./i18n/locales/or_IN
rm -f ./i18n/locales/uk_UA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/uk_UA ./i18n/locales/uk_UA
rm -f ./i18n/locales/fr_LU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_LU ./i18n/locales/fr_LU
rm -f ./i18n/locales/es_PY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_PY ./i18n/locales/es_PY
rm -f ./i18n/locales/translit_narrow
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_narrow ./i18n/locales/translit_narrow
rm -f ./i18n/locales/es_GT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_GT ./i18n/locales/es_GT
rm -f ./i18n/locales/brx_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/brx_IN ./i18n/locales/brx_IN
rm -f ./i18n/locales/lt_LT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lt_LT ./i18n/locales/lt_LT
rm -f ./i18n/locales/en_ZM
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_ZM ./i18n/locales/en_ZM
rm -f ./i18n/locales/wa_BE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/wa_BE ./i18n/locales/wa_BE
rm -f ./i18n/locales/mai_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mai_IN ./i18n/locales/mai_IN
rm -f ./i18n/locales/el_GR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/el_GR ./i18n/locales/el_GR
rm -f ./i18n/locales/sd_IN@devanagari
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sd_IN@devanagari ./i18n/locales/sd_IN@devanagari
rm -f ./i18n/locales/wo_SN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/wo_SN ./i18n/locales/wo_SN
rm -f ./i18n/locales/zh_CN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/zh_CN ./i18n/locales/zh_CN
rm -f ./i18n/locales/ur_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ur_IN ./i18n/locales/ur_IN
rm -f ./i18n/locales/aa_ER
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/aa_ER ./i18n/locales/aa_ER
rm -f ./i18n/locales/mt_MT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mt_MT ./i18n/locales/mt_MT
rm -f ./i18n/locales/ga_IE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ga_IE ./i18n/locales/ga_IE
rm -f ./i18n/locales/fy_DE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fy_DE ./i18n/locales/fy_DE
rm -f ./i18n/locales/fr_CH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_CH ./i18n/locales/fr_CH
rm -f ./i18n/locales/lzh_TW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lzh_TW ./i18n/locales/lzh_TW
rm -f ./i18n/locales/es_MX
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_MX ./i18n/locales/es_MX
rm -f ./i18n/locales/tig_ER
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tig_ER ./i18n/locales/tig_ER
rm -f ./i18n/locales/sr_RS
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sr_RS ./i18n/locales/sr_RS
rm -f ./i18n/locales/en_IE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_IE ./i18n/locales/en_IE
rm -f ./i18n/locales/fr_BE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_BE@euro ./i18n/locales/fr_BE@euro
rm -f ./i18n/locales/sr_RS@latin
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sr_RS@latin ./i18n/locales/sr_RS@latin
rm -f ./i18n/locales/hu_HU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hu_HU ./i18n/locales/hu_HU
rm -f ./i18n/locales/ak_GH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ak_GH ./i18n/locales/ak_GH
rm -f ./i18n/locales/dv_MV
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/dv_MV ./i18n/locales/dv_MV
rm -f ./i18n/locales/de_LU@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_LU@euro ./i18n/locales/de_LU@euro
rm -f ./i18n/locales/st_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/st_ZA ./i18n/locales/st_ZA
rm -f ./i18n/locales/de_DE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_DE ./i18n/locales/de_DE
rm -f ./i18n/locales/es_ES
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_ES ./i18n/locales/es_ES
rm -f ./i18n/locales/byn_ER
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/byn_ER ./i18n/locales/byn_ER
rm -f ./i18n/locales/br_FR@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/br_FR@euro ./i18n/locales/br_FR@euro
rm -f ./i18n/locales/nan_TW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nan_TW ./i18n/locales/nan_TW
rm -f ./i18n/locales/fo_FO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fo_FO ./i18n/locales/fo_FO
rm -f ./i18n/locales/nl_BE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nl_BE@euro ./i18n/locales/nl_BE@euro
rm -f ./i18n/locales/zh_HK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/zh_HK ./i18n/locales/zh_HK
rm -f ./i18n/locales/fr_CA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_CA ./i18n/locales/fr_CA
rm -f ./i18n/locales/sq_MK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sq_MK ./i18n/locales/sq_MK
rm -f ./i18n/locales/fi_FI@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fi_FI@euro ./i18n/locales/fi_FI@euro
rm -f ./i18n/locales/vi_VN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/vi_VN ./i18n/locales/vi_VN
rm -f ./i18n/locales/so_SO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/so_SO ./i18n/locales/so_SO
rm -f ./i18n/locales/pap_AN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pap_AN ./i18n/locales/pap_AN
rm -f ./i18n/locales/en_BW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_BW ./i18n/locales/en_BW
rm -f ./i18n/locales/sq_AL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sq_AL ./i18n/locales/sq_AL
rm -f ./i18n/locales/fi_FI
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fi_FI ./i18n/locales/fi_FI
rm -f ./i18n/locales/id_ID
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/id_ID ./i18n/locales/id_ID
rm -f ./i18n/locales/niu_NZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/niu_NZ ./i18n/locales/niu_NZ
rm -f ./i18n/locales/translit_font
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_font ./i18n/locales/translit_font
rm -f ./i18n/locales/sid_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sid_ET ./i18n/locales/sid_ET
rm -f ./i18n/locales/tt_RU@iqtelif
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tt_RU@iqtelif ./i18n/locales/tt_RU@iqtelif
rm -f ./i18n/locales/os_RU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/os_RU ./i18n/locales/os_RU
rm -f ./i18n/locales/sw_TZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sw_TZ ./i18n/locales/sw_TZ
rm -f ./i18n/locales/nhn_MX
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nhn_MX ./i18n/locales/nhn_MX
rm -f ./i18n/locales/gez_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gez_ET ./i18n/locales/gez_ET
rm -f ./i18n/locales/bg_BG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bg_BG ./i18n/locales/bg_BG
rm -f ./i18n/locales/si_LK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/si_LK ./i18n/locales/si_LK
rm -f ./i18n/locales/sr_ME
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sr_ME ./i18n/locales/sr_ME
rm -f ./i18n/locales/ber_MA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ber_MA ./i18n/locales/ber_MA
rm -f ./i18n/locales/es_ES@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_ES@euro ./i18n/locales/es_ES@euro
rm -f ./i18n/locales/ast_ES
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ast_ES ./i18n/locales/ast_ES
rm -f ./i18n/locales/de_AT@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_AT@euro ./i18n/locales/de_AT@euro
rm -f ./i18n/locales/tg_TJ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tg_TJ ./i18n/locales/tg_TJ
rm -f ./i18n/locales/ca_IT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ca_IT ./i18n/locales/ca_IT
rm -f ./i18n/locales/nso_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nso_ZA ./i18n/locales/nso_ZA
rm -f ./i18n/locales/it_CH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/it_CH ./i18n/locales/it_CH
rm -f ./i18n/locales/ce_RU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ce_RU ./i18n/locales/ce_RU
rm -f ./i18n/locales/translit_circle
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_circle ./i18n/locales/translit_circle
rm -f ./i18n/locales/crh_UA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/crh_UA ./i18n/locales/crh_UA
rm -f ./i18n/locales/ar_SD
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_SD ./i18n/locales/ar_SD
rm -f ./i18n/locales/ca_FR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ca_FR ./i18n/locales/ca_FR
rm -f ./i18n/locales/li_NL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/li_NL ./i18n/locales/li_NL
rm -f ./i18n/locales/eu_ES@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/eu_ES@euro ./i18n/locales/eu_ES@euro
rm -f ./i18n/locales/ar_LY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_LY ./i18n/locales/ar_LY
rm -f ./i18n/locales/oc_FR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/oc_FR ./i18n/locales/oc_FR
rm -f ./i18n/locales/ar_DZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_DZ ./i18n/locales/ar_DZ
rm -f ./i18n/locales/pa_PK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pa_PK ./i18n/locales/pa_PK
rm -f ./i18n/locales/zh_SG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/zh_SG ./i18n/locales/zh_SG
rm -f ./i18n/locales/an_ES
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/an_ES ./i18n/locales/an_ES
rm -f ./i18n/locales/ha_NG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ha_NG ./i18n/locales/ha_NG
rm -f ./i18n/locales/sv_FI@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sv_FI@euro ./i18n/locales/sv_FI@euro
rm -f ./i18n/locales/szl_PL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/szl_PL ./i18n/locales/szl_PL
rm -f ./i18n/locales/ti_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ti_ET ./i18n/locales/ti_ET
rm -f ./i18n/locales/en_GB
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_GB ./i18n/locales/en_GB
rm -f ./i18n/locales/raj_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/raj_IN ./i18n/locales/raj_IN
rm -f ./i18n/locales/nan_TW@latin
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nan_TW@latin ./i18n/locales/nan_TW@latin
rm -f ./i18n/locales/kw_GB
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/kw_GB ./i18n/locales/kw_GB
rm -f ./i18n/locales/so_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/so_ET ./i18n/locales/so_ET
rm -f ./i18n/locales/ks_IN@devanagari
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ks_IN@devanagari ./i18n/locales/ks_IN@devanagari
rm -f ./i18n/locales/nl_NL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nl_NL ./i18n/locales/nl_NL
rm -f ./i18n/locales/sd_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sd_IN ./i18n/locales/sd_IN
rm -f ./i18n/locales/es_CU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_CU ./i18n/locales/es_CU
rm -f ./i18n/locales/tcy_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tcy_IN ./i18n/locales/tcy_IN
rm -f ./i18n/locales/en_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_IN ./i18n/locales/en_IN
rm -f ./i18n/locales/en_CA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_CA ./i18n/locales/en_CA
rm -f ./i18n/locales/ms_MY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ms_MY ./i18n/locales/ms_MY
rm -f ./i18n/locales/mni_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mni_IN ./i18n/locales/mni_IN
rm -f ./i18n/locales/th_TH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/th_TH ./i18n/locales/th_TH
rm -f ./i18n/locales/ar_IQ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_IQ ./i18n/locales/ar_IQ
rm -f ./i18n/locales/nl_AW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nl_AW ./i18n/locales/nl_AW
rm -f ./i18n/locales/ar_AE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_AE ./i18n/locales/ar_AE
rm -f ./i18n/locales/ca_ES@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ca_ES@euro ./i18n/locales/ca_ES@euro
rm -f ./i18n/locales/kn_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/kn_IN ./i18n/locales/kn_IN
rm -f ./i18n/locales/km_KH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/km_KH ./i18n/locales/km_KH
rm -f ./i18n/locales/de_BE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_BE ./i18n/locales/de_BE
rm -f ./i18n/locales/sc_IT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sc_IT ./i18n/locales/sc_IT
rm -f ./i18n/locales/yi_US
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/yi_US ./i18n/locales/yi_US
rm -f ./i18n/locales/bo_CN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bo_CN ./i18n/locales/bo_CN
rm -f ./i18n/locales/shs_CA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/shs_CA ./i18n/locales/shs_CA
rm -f ./i18n/locales/uz_UZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/uz_UZ ./i18n/locales/uz_UZ
rm -f ./i18n/locales/ar_OM
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_OM ./i18n/locales/ar_OM
rm -f ./i18n/locales/es_PA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_PA ./i18n/locales/es_PA
rm -f ./i18n/locales/de_LU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_LU ./i18n/locales/de_LU
rm -f ./i18n/locales/es_DO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_DO ./i18n/locales/es_DO
rm -f ./i18n/locales/nn_NO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nn_NO ./i18n/locales/nn_NO
rm -f ./i18n/locales/li_BE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/li_BE ./i18n/locales/li_BE
rm -f ./i18n/locales/ro_RO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ro_RO ./i18n/locales/ro_RO
rm -f ./i18n/locales/tl_PH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tl_PH ./i18n/locales/tl_PH
rm -f ./i18n/locales/ar_QA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_QA ./i18n/locales/ar_QA
rm -f ./i18n/locales/ar_MA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_MA ./i18n/locales/ar_MA
rm -f ./i18n/locales/el_GR@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/el_GR@euro ./i18n/locales/el_GR@euro
rm -f ./i18n/locales/ru_RU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ru_RU ./i18n/locales/ru_RU
rm -f ./i18n/locales/the_NP
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/the_NP ./i18n/locales/the_NP
rm -f ./i18n/locales/ik_CA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ik_CA ./i18n/locales/ik_CA
rm -f ./i18n/locales/pap_CW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pap_CW ./i18n/locales/pap_CW
rm -f ./i18n/locales/translit_neutral
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_neutral ./i18n/locales/translit_neutral
rm -f ./i18n/locales/en_IE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_IE@euro ./i18n/locales/en_IE@euro
rm -f ./i18n/locales/ar_TN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_TN ./i18n/locales/ar_TN
rm -f ./i18n/locales/ar_EG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_EG ./i18n/locales/ar_EG
rm -f ./i18n/locales/wal_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/wal_ET ./i18n/locales/wal_ET
rm -f ./i18n/locales/ar_YE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_YE ./i18n/locales/ar_YE
rm -f ./i18n/locales/he_IL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/he_IL ./i18n/locales/he_IL
rm -f ./i18n/locales/mi_NZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mi_NZ ./i18n/locales/mi_NZ
rm -f ./i18n/locales/en_SG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_SG ./i18n/locales/en_SG
rm -f ./i18n/locales/sa_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sa_IN ./i18n/locales/sa_IN
rm -f ./i18n/locales/pt_PT@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pt_PT@euro ./i18n/locales/pt_PT@euro
rm -f ./i18n/locales/lo_LA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lo_LA ./i18n/locales/lo_LA
rm -f ./i18n/locales/ja_JP
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ja_JP ./i18n/locales/ja_JP
rm -f ./i18n/locales/translit_wide
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_wide ./i18n/locales/translit_wide
rm -f ./i18n/locales/ml_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ml_IN ./i18n/locales/ml_IN
rm -f ./i18n/locales/bn_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bn_IN ./i18n/locales/bn_IN
rm -f ./i18n/locales/nl_BE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nl_BE ./i18n/locales/nl_BE
rm -f ./i18n/locales/en_DK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_DK ./i18n/locales/en_DK
rm -f ./i18n/locales/ti_ER
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ti_ER ./i18n/locales/ti_ER
rm -f ./i18n/locales/translit_fraction
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_fraction ./i18n/locales/translit_fraction
rm -f ./i18n/locales/kk_KZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/kk_KZ ./i18n/locales/kk_KZ
rm -f ./i18n/locales/doi_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/doi_IN ./i18n/locales/doi_IN
rm -f ./i18n/locales/se_NO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/se_NO ./i18n/locales/se_NO
rm -f ./i18n/locales/translit_combining
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_combining ./i18n/locales/translit_combining
rm -f ./i18n/locales/mg_MG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mg_MG ./i18n/locales/mg_MG
rm -f ./i18n/locales/tr_TR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tr_TR ./i18n/locales/tr_TR
rm -f ./i18n/locales/ts_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ts_ZA ./i18n/locales/ts_ZA
rm -f ./i18n/locales/as_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/as_IN ./i18n/locales/as_IN
rm -f ./i18n/locales/tn_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tn_ZA ./i18n/locales/tn_ZA
rm -f ./i18n/locales/aa_ER@saaho
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/aa_ER@saaho ./i18n/locales/aa_ER@saaho
rm -f ./i18n/locales/en_US
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_US ./i18n/locales/en_US
rm -f ./i18n/locales/cy_GB
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/cy_GB ./i18n/locales/cy_GB
rm -f ./i18n/locales/bs_BA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bs_BA ./i18n/locales/bs_BA
rm -f ./i18n/locales/da_DK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/da_DK ./i18n/locales/da_DK
rm -f ./i18n/locales/en_NZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_NZ ./i18n/locales/en_NZ
rm -f ./i18n/locales/be_BY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/be_BY ./i18n/locales/be_BY
rm -f ./i18n/locales/ar_SS
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_SS ./i18n/locales/ar_SS
rm -f ./i18n/locales/ar_SA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_SA ./i18n/locales/ar_SA
rm -f ./i18n/locales/gez_ER@abegede
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gez_ER@abegede ./i18n/locales/gez_ER@abegede
rm -f ./i18n/locales/cs_CZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/cs_CZ ./i18n/locales/cs_CZ
rm -f ./i18n/locales/ig_NG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ig_NG ./i18n/locales/ig_NG
rm -f ./i18n/locales/ca_ES
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ca_ES ./i18n/locales/ca_ES
rm -f ./i18n/locales/en_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_ZA ./i18n/locales/en_ZA
rm -f ./locale/eo/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/eo/LC_MESSAGES/libc.mo ./locale/eo/LC_MESSAGES/libc.mo
rm -f ./locale/lt/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/lt/LC_MESSAGES/libc.mo ./locale/lt/LC_MESSAGES/libc.mo
rm -f ./locale/zh_TW/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/zh_TW/LC_MESSAGES/libc.mo ./locale/zh_TW/LC_MESSAGES/libc.mo
rm -f ./locale/ca/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/ca/LC_MESSAGES/libc.mo ./locale/ca/LC_MESSAGES/libc.mo
rm -f ./locale/sl/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/sl/LC_MESSAGES/libc.mo ./locale/sl/LC_MESSAGES/libc.mo
rm -f ./locale/nb/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/nb/LC_MESSAGES/libc.mo ./locale/nb/LC_MESSAGES/libc.mo
rm -f ./locale/da/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/da/LC_MESSAGES/libc.mo ./locale/da/LC_MESSAGES/libc.mo
rm -f ./locale/hu/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/hu/LC_MESSAGES/libc.mo ./locale/hu/LC_MESSAGES/libc.mo
rm -f ./locale/vi/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/vi/LC_MESSAGES/libc.mo ./locale/vi/LC_MESSAGES/libc.mo
rm -f ./locale/ko/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/ko/LC_MESSAGES/libc.mo ./locale/ko/LC_MESSAGES/libc.mo
rm -f ./locale/tr/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/tr/LC_MESSAGES/libc.mo ./locale/tr/LC_MESSAGES/libc.mo
rm -f ./locale/pt_BR/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/pt_BR/LC_MESSAGES/libc.mo ./locale/pt_BR/LC_MESSAGES/libc.mo
rm -f ./locale/de/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/de/LC_MESSAGES/libc.mo ./locale/de/LC_MESSAGES/libc.mo
rm -f ./locale/hr/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/hr/LC_MESSAGES/libc.mo ./locale/hr/LC_MESSAGES/libc.mo
rm -f ./locale/ia/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/ia/LC_MESSAGES/libc.mo ./locale/ia/LC_MESSAGES/libc.mo
rm -f ./locale/sv/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/sv/LC_MESSAGES/libc.mo ./locale/sv/LC_MESSAGES/libc.mo
rm -f ./locale/pl/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/pl/LC_MESSAGES/libc.mo ./locale/pl/LC_MESSAGES/libc.mo
rm -f ./locale/gl/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/gl/LC_MESSAGES/libc.mo ./locale/gl/LC_MESSAGES/libc.mo
rm -f ./locale/be/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/be/LC_MESSAGES/libc.mo ./locale/be/LC_MESSAGES/libc.mo
rm -f ./locale/fi/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/fi/LC_MESSAGES/libc.mo ./locale/fi/LC_MESSAGES/libc.mo
rm -f ./locale/zh_CN/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/zh_CN/LC_MESSAGES/libc.mo ./locale/zh_CN/LC_MESSAGES/libc.mo
rm -f ./locale/cs/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/cs/LC_MESSAGES/libc.mo ./locale/cs/LC_MESSAGES/libc.mo
rm -f ./locale/id/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/id/LC_MESSAGES/libc.mo ./locale/id/LC_MESSAGES/libc.mo
rm -f ./locale/ja/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/ja/LC_MESSAGES/libc.mo ./locale/ja/LC_MESSAGES/libc.mo
rm -f ./locale/bg/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/bg/LC_MESSAGES/libc.mo ./locale/bg/LC_MESSAGES/libc.mo
rm -f ./locale/locale.alias
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/locale.alias ./locale/locale.alias
rm -f ./locale/es/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/es/LC_MESSAGES/libc.mo ./locale/es/LC_MESSAGES/libc.mo
rm -f ./locale/ru/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/ru/LC_MESSAGES/libc.mo ./locale/ru/LC_MESSAGES/libc.mo
rm -f ./locale/el/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/el/LC_MESSAGES/libc.mo ./locale/el/LC_MESSAGES/libc.mo
rm -f ./locale/fr/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/fr/LC_MESSAGES/libc.mo ./locale/fr/LC_MESSAGES/libc.mo
rm -f ./locale/en_GB/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/en_GB/LC_MESSAGES/libc.mo ./locale/en_GB/LC_MESSAGES/libc.mo
rm -f ./locale/nl/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/nl/LC_MESSAGES/libc.mo ./locale/nl/LC_MESSAGES/libc.mo
rm -f ./locale/sk/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/sk/LC_MESSAGES/libc.mo ./locale/sk/LC_MESSAGES/libc.mo
rm -f ./locale/it/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/it/LC_MESSAGES/libc.mo ./locale/it/LC_MESSAGES/libc.mo
rm -f ./locale/uk/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/uk/LC_MESSAGES/libc.mo ./locale/uk/LC_MESSAGES/libc.mo
rm -f ./locale/rw/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/rw/LC_MESSAGES/libc.mo ./locale/rw/LC_MESSAGES/libc.mo
popd
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libstdc++.so.6.0.20 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libatomic.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/gdbserver ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/gdbserver
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/sbin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/ldconfig ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/sbin/ldconfig
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/sbin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/sln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/sbin/sln
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/catchsegv ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/catchsegv
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/gencat ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/gencat
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/getconf ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/getconf
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/getent ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/getent
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/iconv ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/iconv
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/ldd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/ldd
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/locale ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/locale
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/localedef ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/localedef
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/makedb ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/makedb
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/mtrace ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/mtrace
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/pcprofiledump ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/pcprofiledump
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/pldd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/pldd
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/rpcgen ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/rpcgen
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/sotruss ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/sotruss
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/sprof ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/sprof
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/tzselect ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/tzselect
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/xtrace ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/xtrace
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/sbin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/iconvconfig ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/sbin/iconvconfig
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/sbin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/nscd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/sbin/nscd
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/sbin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/zdump ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/sbin/zdump
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/sbin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/zic ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/sbin/zic
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/POSIX_V7_ILP32_OFF32 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf/POSIX_V7_ILP32_OFF32
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/POSIX_V7_ILP32_OFFBIG ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf/POSIX_V7_ILP32_OFFBIG
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/POSIX_V6_ILP32_OFF32 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf/POSIX_V6_ILP32_OFF32
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/POSIX_V6_ILP32_OFFBIG ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf/POSIX_V6_ILP32_OFFBIG
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/XBS5_ILP32_OFF32 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf/XBS5_ILP32_OFF32
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib//bin/XBS5_ILP32_OFFBIG ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf/XBS5_ILP32_OFFBIG
rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/include
pushd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/etc
rm -f ./rpc
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./etc/./rpc ./rpc
popd
pushd ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/share
rm -f ./info/dir
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./info/dir ./info/dir
rm -f ./i18n/charmaps/IBM860.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM860.gz ./i18n/charmaps/IBM860.gz
rm -f ./i18n/charmaps/IBM864.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM864.gz ./i18n/charmaps/IBM864.gz
rm -f ./i18n/charmaps/CP1254.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1254.gz ./i18n/charmaps/CP1254.gz
rm -f ./i18n/charmaps/BS_4730.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/BS_4730.gz ./i18n/charmaps/BS_4730.gz
rm -f ./i18n/charmaps/IBM903.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM903.gz ./i18n/charmaps/IBM903.gz
rm -f ./i18n/charmaps/CP771.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP771.gz ./i18n/charmaps/CP771.gz
rm -f ./i18n/charmaps/ISO-8859-3.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-3.gz ./i18n/charmaps/ISO-8859-3.gz
rm -f ./i18n/charmaps/CP1253.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1253.gz ./i18n/charmaps/CP1253.gz
rm -f ./i18n/charmaps/IBM880.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM880.gz ./i18n/charmaps/IBM880.gz
rm -f ./i18n/charmaps/EBCDIC-DK-NO-A.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-DK-NO-A.gz ./i18n/charmaps/EBCDIC-DK-NO-A.gz
rm -f ./i18n/charmaps/ISO-8859-9E.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-9E.gz ./i18n/charmaps/ISO-8859-9E.gz
rm -f ./i18n/charmaps/HP-ROMAN8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/HP-ROMAN8.gz ./i18n/charmaps/HP-ROMAN8.gz
rm -f ./i18n/charmaps/CP775.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP775.gz ./i18n/charmaps/CP775.gz
rm -f ./i18n/charmaps/IBM285.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM285.gz ./i18n/charmaps/IBM285.gz
rm -f ./i18n/charmaps/ISO_6937-2-25.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_6937-2-25.gz ./i18n/charmaps/ISO_6937-2-25.gz
rm -f ./i18n/charmaps/KOI8-T.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/KOI8-T.gz ./i18n/charmaps/KOI8-T.gz
rm -f ./i18n/charmaps/KOI-8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/KOI-8.gz ./i18n/charmaps/KOI-8.gz
rm -f ./i18n/charmaps/ISO-8859-10.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-10.gz ./i18n/charmaps/ISO-8859-10.gz
rm -f ./i18n/charmaps/ISO_5427.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_5427.gz ./i18n/charmaps/ISO_5427.gz
rm -f ./i18n/charmaps/EBCDIC-ES.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-ES.gz ./i18n/charmaps/EBCDIC-ES.gz
rm -f ./i18n/charmaps/GEORGIAN-PS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GEORGIAN-PS.gz ./i18n/charmaps/GEORGIAN-PS.gz
rm -f ./i18n/charmaps/IBM904.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM904.gz ./i18n/charmaps/IBM904.gz
rm -f ./i18n/charmaps/IBM1124.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1124.gz ./i18n/charmaps/IBM1124.gz
rm -f ./i18n/charmaps/IBM918.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM918.gz ./i18n/charmaps/IBM918.gz
rm -f ./i18n/charmaps/DS_2089.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/DS_2089.gz ./i18n/charmaps/DS_2089.gz
rm -f ./i18n/charmaps/JIS_C6229-1984-A.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6229-1984-A.gz ./i18n/charmaps/JIS_C6229-1984-A.gz
rm -f ./i18n/charmaps/HP-THAI8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/HP-THAI8.gz ./i18n/charmaps/HP-THAI8.gz
rm -f ./i18n/charmaps/EUC-KR.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EUC-KR.gz ./i18n/charmaps/EUC-KR.gz
rm -f ./i18n/charmaps/ANSI_X3.110-1983.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ANSI_X3.110-1983.gz ./i18n/charmaps/ANSI_X3.110-1983.gz
rm -f ./i18n/charmaps/ISO_6937-2-ADD.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_6937-2-ADD.gz ./i18n/charmaps/ISO_6937-2-ADD.gz
rm -f ./i18n/charmaps/CP10007.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP10007.gz ./i18n/charmaps/CP10007.gz
rm -f ./i18n/charmaps/IBM870.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM870.gz ./i18n/charmaps/IBM870.gz
rm -f ./i18n/charmaps/EBCDIC-FR.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-FR.gz ./i18n/charmaps/EBCDIC-FR.gz
rm -f ./i18n/charmaps/MAC-CYRILLIC.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MAC-CYRILLIC.gz ./i18n/charmaps/MAC-CYRILLIC.gz
rm -f ./i18n/charmaps/MAC-CENTRALEUROPE.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MAC-CENTRALEUROPE.gz ./i18n/charmaps/MAC-CENTRALEUROPE.gz
rm -f ./i18n/charmaps/ISO-IR-197.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-IR-197.gz ./i18n/charmaps/ISO-IR-197.gz
rm -f ./i18n/charmaps/CP1250.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1250.gz ./i18n/charmaps/CP1250.gz
rm -f ./i18n/charmaps/IBM1164.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1164.gz ./i18n/charmaps/IBM1164.gz
rm -f ./i18n/charmaps/NATS-SEFI.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NATS-SEFI.gz ./i18n/charmaps/NATS-SEFI.gz
rm -f ./i18n/charmaps/ISO-8859-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-1.gz ./i18n/charmaps/ISO-8859-1.gz
rm -f ./i18n/charmaps/ISO_10367-BOX.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_10367-BOX.gz ./i18n/charmaps/ISO_10367-BOX.gz
rm -f ./i18n/charmaps/EBCDIC-ES-A.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-ES-A.gz ./i18n/charmaps/EBCDIC-ES-A.gz
rm -f ./i18n/charmaps/PT2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/PT2.gz ./i18n/charmaps/PT2.gz
rm -f ./i18n/charmaps/CP949.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP949.gz ./i18n/charmaps/CP949.gz
rm -f ./i18n/charmaps/EBCDIC-CA-FR.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-CA-FR.gz ./i18n/charmaps/EBCDIC-CA-FR.gz
rm -f ./i18n/charmaps/NF_Z_62-010_1973.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NF_Z_62-010_1973.gz ./i18n/charmaps/NF_Z_62-010_1973.gz
rm -f ./i18n/charmaps/ISO-8859-2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-2.gz ./i18n/charmaps/ISO-8859-2.gz
rm -f ./i18n/charmaps/ES.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ES.gz ./i18n/charmaps/ES.gz
rm -f ./i18n/charmaps/T.101-G2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/T.101-G2.gz ./i18n/charmaps/T.101-G2.gz
rm -f ./i18n/charmaps/IEC_P27-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IEC_P27-1.gz ./i18n/charmaps/IEC_P27-1.gz
rm -f ./i18n/charmaps/IBM280.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM280.gz ./i18n/charmaps/IBM280.gz
rm -f ./i18n/charmaps/IBM1004.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1004.gz ./i18n/charmaps/IBM1004.gz
rm -f ./i18n/charmaps/CP1258.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1258.gz ./i18n/charmaps/CP1258.gz
rm -f ./i18n/charmaps/IBM281.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM281.gz ./i18n/charmaps/IBM281.gz
rm -f ./i18n/charmaps/GB18030.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GB18030.gz ./i18n/charmaps/GB18030.gz
rm -f ./i18n/charmaps/IBM1047.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1047.gz ./i18n/charmaps/IBM1047.gz
rm -f ./i18n/charmaps/GREEK-CCITT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GREEK-CCITT.gz ./i18n/charmaps/GREEK-CCITT.gz
rm -f ./i18n/charmaps/IBM1133.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1133.gz ./i18n/charmaps/IBM1133.gz
rm -f ./i18n/charmaps/GOST_19768-74.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GOST_19768-74.gz ./i18n/charmaps/GOST_19768-74.gz
rm -f ./i18n/charmaps/NC_NC00-10.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NC_NC00-10.gz ./i18n/charmaps/NC_NC00-10.gz
rm -f ./i18n/charmaps/IBM857.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM857.gz ./i18n/charmaps/IBM857.gz
rm -f ./i18n/charmaps/KOI8-RU.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/KOI8-RU.gz ./i18n/charmaps/KOI8-RU.gz
rm -f ./i18n/charmaps/ISO_646.IRV.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_646.IRV.gz ./i18n/charmaps/ISO_646.IRV.gz
rm -f ./i18n/charmaps/CP770.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP770.gz ./i18n/charmaps/CP770.gz
rm -f ./i18n/charmaps/IBM866NAV.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM866NAV.gz ./i18n/charmaps/IBM866NAV.gz
rm -f ./i18n/charmaps/IBM865.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM865.gz ./i18n/charmaps/IBM865.gz
rm -f ./i18n/charmaps/EUC-TW.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EUC-TW.gz ./i18n/charmaps/EUC-TW.gz
rm -f ./i18n/charmaps/IBM038.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM038.gz ./i18n/charmaps/IBM038.gz
rm -f ./i18n/charmaps/ES2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ES2.gz ./i18n/charmaps/ES2.gz
rm -f ./i18n/charmaps/T.61-8BIT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/T.61-8BIT.gz ./i18n/charmaps/T.61-8BIT.gz
rm -f ./i18n/charmaps/BRF.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/BRF.gz ./i18n/charmaps/BRF.gz
rm -f ./i18n/charmaps/JIS_X0201.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_X0201.gz ./i18n/charmaps/JIS_X0201.gz
rm -f ./i18n/charmaps/CP1256.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1256.gz ./i18n/charmaps/CP1256.gz
rm -f ./i18n/charmaps/IBM1132.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1132.gz ./i18n/charmaps/IBM1132.gz
rm -f ./i18n/charmaps/NS_4551-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NS_4551-1.gz ./i18n/charmaps/NS_4551-1.gz
rm -f ./i18n/charmaps/KOI8-U.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/KOI8-U.gz ./i18n/charmaps/KOI8-U.gz
rm -f ./i18n/charmaps/ANSI_X3.4-1968.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ANSI_X3.4-1968.gz ./i18n/charmaps/ANSI_X3.4-1968.gz
rm -f ./i18n/charmaps/EBCDIC-UK.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-UK.gz ./i18n/charmaps/EBCDIC-UK.gz
rm -f ./i18n/charmaps/IBM1161.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1161.gz ./i18n/charmaps/IBM1161.gz
rm -f ./i18n/charmaps/IBM868.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM868.gz ./i18n/charmaps/IBM868.gz
rm -f ./i18n/charmaps/IBM500.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM500.gz ./i18n/charmaps/IBM500.gz
rm -f ./i18n/charmaps/ISO_5428.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_5428.gz ./i18n/charmaps/ISO_5428.gz
rm -f ./i18n/charmaps/JIS_C6229-1984-B-ADD.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6229-1984-B-ADD.gz ./i18n/charmaps/JIS_C6229-1984-B-ADD.gz
rm -f ./i18n/charmaps/IBM297.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM297.gz ./i18n/charmaps/IBM297.gz
rm -f ./i18n/charmaps/ISO-IR-90.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-IR-90.gz ./i18n/charmaps/ISO-IR-90.gz
rm -f ./i18n/charmaps/MAC-SAMI.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MAC-SAMI.gz ./i18n/charmaps/MAC-SAMI.gz
rm -f ./i18n/charmaps/EBCDIC-DK-NO.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-DK-NO.gz ./i18n/charmaps/EBCDIC-DK-NO.gz
rm -f ./i18n/charmaps/LATIN-GREEK.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/LATIN-GREEK.gz ./i18n/charmaps/LATIN-GREEK.gz
rm -f ./i18n/charmaps/MAC-UK.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MAC-UK.gz ./i18n/charmaps/MAC-UK.gz
rm -f ./i18n/charmaps/PT154.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/PT154.gz ./i18n/charmaps/PT154.gz
rm -f ./i18n/charmaps/INIS-CYRILLIC.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/INIS-CYRILLIC.gz ./i18n/charmaps/INIS-CYRILLIC.gz
rm -f ./i18n/charmaps/INIS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/INIS.gz ./i18n/charmaps/INIS.gz
rm -f ./i18n/charmaps/SAMI-WS2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/SAMI-WS2.gz ./i18n/charmaps/SAMI-WS2.gz
rm -f ./i18n/charmaps/BIG5.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/BIG5.gz ./i18n/charmaps/BIG5.gz
rm -f ./i18n/charmaps/JIS_C6229-1984-B.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6229-1984-B.gz ./i18n/charmaps/JIS_C6229-1984-B.gz
rm -f ./i18n/charmaps/EBCDIC-US.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-US.gz ./i18n/charmaps/EBCDIC-US.gz
rm -f ./i18n/charmaps/LATIN-GREEK-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/LATIN-GREEK-1.gz ./i18n/charmaps/LATIN-GREEK-1.gz
rm -f ./i18n/charmaps/GB_1988-80.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GB_1988-80.gz ./i18n/charmaps/GB_1988-80.gz
rm -f ./i18n/charmaps/IBM861.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM861.gz ./i18n/charmaps/IBM861.gz
rm -f ./i18n/charmaps/MSZ_7795.3.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MSZ_7795.3.gz ./i18n/charmaps/MSZ_7795.3.gz
rm -f ./i18n/charmaps/ISO-8859-13.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-13.gz ./i18n/charmaps/ISO-8859-13.gz
rm -f ./i18n/charmaps/TSCII.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/TSCII.gz ./i18n/charmaps/TSCII.gz
rm -f ./i18n/charmaps/BS_VIEWDATA.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/BS_VIEWDATA.gz ./i18n/charmaps/BS_VIEWDATA.gz
rm -f ./i18n/charmaps/ISO-8859-4.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-4.gz ./i18n/charmaps/ISO-8859-4.gz
rm -f ./i18n/charmaps/IBM284.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM284.gz ./i18n/charmaps/IBM284.gz
rm -f ./i18n/charmaps/SAMI.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/SAMI.gz ./i18n/charmaps/SAMI.gz
rm -f ./i18n/charmaps/CP1125.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1125.gz ./i18n/charmaps/CP1125.gz
rm -f ./i18n/charmaps/HP-ROMAN9.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/HP-ROMAN9.gz ./i18n/charmaps/HP-ROMAN9.gz
rm -f ./i18n/charmaps/IBM424.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM424.gz ./i18n/charmaps/IBM424.gz
rm -f ./i18n/charmaps/NATS-SEFI-ADD.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NATS-SEFI-ADD.gz ./i18n/charmaps/NATS-SEFI-ADD.gz
rm -f ./i18n/charmaps/ASMO_449.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ASMO_449.gz ./i18n/charmaps/ASMO_449.gz
rm -f ./i18n/charmaps/DEC-MCS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/DEC-MCS.gz ./i18n/charmaps/DEC-MCS.gz
rm -f ./i18n/charmaps/IBM922.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM922.gz ./i18n/charmaps/IBM922.gz
rm -f ./i18n/charmaps/IBM278.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM278.gz ./i18n/charmaps/IBM278.gz
rm -f ./i18n/charmaps/SEN_850200_C.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/SEN_850200_C.gz ./i18n/charmaps/SEN_850200_C.gz
rm -f ./i18n/charmaps/JIS_C6229-1984-HAND.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6229-1984-HAND.gz ./i18n/charmaps/JIS_C6229-1984-HAND.gz
rm -f ./i18n/charmaps/INVARIANT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/INVARIANT.gz ./i18n/charmaps/INVARIANT.gz
rm -f ./i18n/charmaps/ISO-8859-5.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-5.gz ./i18n/charmaps/ISO-8859-5.gz
rm -f ./i18n/charmaps/CSA_Z243.4-1985-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CSA_Z243.4-1985-1.gz ./i18n/charmaps/CSA_Z243.4-1985-1.gz
rm -f ./i18n/charmaps/ISO_5427-EXT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_5427-EXT.gz ./i18n/charmaps/ISO_5427-EXT.gz
rm -f ./i18n/charmaps/TIS-620.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/TIS-620.gz ./i18n/charmaps/TIS-620.gz
rm -f ./i18n/charmaps/NATS-DANO-ADD.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NATS-DANO-ADD.gz ./i18n/charmaps/NATS-DANO-ADD.gz
rm -f ./i18n/charmaps/IBM256.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM256.gz ./i18n/charmaps/IBM256.gz
rm -f ./i18n/charmaps/IBM852.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM852.gz ./i18n/charmaps/IBM852.gz
rm -f ./i18n/charmaps/UTF-8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/UTF-8.gz ./i18n/charmaps/UTF-8.gz
rm -f ./i18n/charmaps/JIS_C6220-1969-RO.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6220-1969-RO.gz ./i18n/charmaps/JIS_C6220-1969-RO.gz
rm -f ./i18n/charmaps/HP-GREEK8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/HP-GREEK8.gz ./i18n/charmaps/HP-GREEK8.gz
rm -f ./i18n/charmaps/DIN_66003.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/DIN_66003.gz ./i18n/charmaps/DIN_66003.gz
rm -f ./i18n/charmaps/ISO_646.BASIC.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_646.BASIC.gz ./i18n/charmaps/ISO_646.BASIC.gz
rm -f ./i18n/charmaps/IBM277.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM277.gz ./i18n/charmaps/IBM277.gz
rm -f ./i18n/charmaps/ISO_2033-1983.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_2033-1983.gz ./i18n/charmaps/ISO_2033-1983.gz
rm -f ./i18n/charmaps/ISO_10646.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_10646.gz ./i18n/charmaps/ISO_10646.gz
rm -f ./i18n/charmaps/CP773.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP773.gz ./i18n/charmaps/CP773.gz
rm -f ./i18n/charmaps/IBM855.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM855.gz ./i18n/charmaps/IBM855.gz
rm -f ./i18n/charmaps/GREEK7-OLD.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GREEK7-OLD.gz ./i18n/charmaps/GREEK7-OLD.gz
rm -f ./i18n/charmaps/CWI.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CWI.gz ./i18n/charmaps/CWI.gz
rm -f ./i18n/charmaps/IBM437.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM437.gz ./i18n/charmaps/IBM437.gz
rm -f ./i18n/charmaps/GBK.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GBK.gz ./i18n/charmaps/GBK.gz
rm -f ./i18n/charmaps/IBM875.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM875.gz ./i18n/charmaps/IBM875.gz
rm -f ./i18n/charmaps/MACINTOSH.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MACINTOSH.gz ./i18n/charmaps/MACINTOSH.gz
rm -f ./i18n/charmaps/WINDOWS-31J.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/WINDOWS-31J.gz ./i18n/charmaps/WINDOWS-31J.gz
rm -f ./i18n/charmaps/NF_Z_62-010.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NF_Z_62-010.gz ./i18n/charmaps/NF_Z_62-010.gz
rm -f ./i18n/charmaps/EUC-JP.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EUC-JP.gz ./i18n/charmaps/EUC-JP.gz
rm -f ./i18n/charmaps/ISO-8859-8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-8.gz ./i18n/charmaps/ISO-8859-8.gz
rm -f ./i18n/charmaps/EBCDIC-IT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-IT.gz ./i18n/charmaps/EBCDIC-IT.gz
rm -f ./i18n/charmaps/ISO-8859-15.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-15.gz ./i18n/charmaps/ISO-8859-15.gz
rm -f ./i18n/charmaps/JUS_I.B1.003-MAC.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JUS_I.B1.003-MAC.gz ./i18n/charmaps/JUS_I.B1.003-MAC.gz
rm -f ./i18n/charmaps/CP737.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP737.gz ./i18n/charmaps/CP737.gz
rm -f ./i18n/charmaps/ISO-8859-11.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-11.gz ./i18n/charmaps/ISO-8859-11.gz
rm -f ./i18n/charmaps/VIDEOTEX-SUPPL.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/VIDEOTEX-SUPPL.gz ./i18n/charmaps/VIDEOTEX-SUPPL.gz
rm -f ./i18n/charmaps/IBM863.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM863.gz ./i18n/charmaps/IBM863.gz
rm -f ./i18n/charmaps/MAC-IS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MAC-IS.gz ./i18n/charmaps/MAC-IS.gz
rm -f ./i18n/charmaps/CSN_369103.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CSN_369103.gz ./i18n/charmaps/CSN_369103.gz
rm -f ./i18n/charmaps/ISO_11548-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_11548-1.gz ./i18n/charmaps/ISO_11548-1.gz
rm -f ./i18n/charmaps/GB2312.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GB2312.gz ./i18n/charmaps/GB2312.gz
rm -f ./i18n/charmaps/ISO_6937.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_6937.gz ./i18n/charmaps/ISO_6937.gz
rm -f ./i18n/charmaps/JIS_C6229-1984-KANA.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6229-1984-KANA.gz ./i18n/charmaps/JIS_C6229-1984-KANA.gz
rm -f ./i18n/charmaps/CP1252.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1252.gz ./i18n/charmaps/CP1252.gz
rm -f ./i18n/charmaps/ISO_8859-SUPP.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_8859-SUPP.gz ./i18n/charmaps/ISO_8859-SUPP.gz
rm -f ./i18n/charmaps/BIG5-HKSCS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/BIG5-HKSCS.gz ./i18n/charmaps/BIG5-HKSCS.gz
rm -f ./i18n/charmaps/EBCDIC-PT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-PT.gz ./i18n/charmaps/EBCDIC-PT.gz
rm -f ./i18n/charmaps/IBM1162.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1162.gz ./i18n/charmaps/IBM1162.gz
rm -f ./i18n/charmaps/NS_4551-2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NS_4551-2.gz ./i18n/charmaps/NS_4551-2.gz
rm -f ./i18n/charmaps/IBM905.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM905.gz ./i18n/charmaps/IBM905.gz
rm -f ./i18n/charmaps/JIS_C6220-1969-JP.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6220-1969-JP.gz ./i18n/charmaps/JIS_C6220-1969-JP.gz
rm -f ./i18n/charmaps/NATS-DANO.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NATS-DANO.gz ./i18n/charmaps/NATS-DANO.gz
rm -f ./i18n/charmaps/INIS-8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/INIS-8.gz ./i18n/charmaps/INIS-8.gz
rm -f ./i18n/charmaps/IBM274.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM274.gz ./i18n/charmaps/IBM274.gz
rm -f ./i18n/charmaps/IBM850.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM850.gz ./i18n/charmaps/IBM850.gz
rm -f ./i18n/charmaps/IBM1129.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1129.gz ./i18n/charmaps/IBM1129.gz
rm -f ./i18n/charmaps/VISCII.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/VISCII.gz ./i18n/charmaps/VISCII.gz
rm -f ./i18n/charmaps/IBM1163.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1163.gz ./i18n/charmaps/IBM1163.gz
rm -f ./i18n/charmaps/IBM273.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM273.gz ./i18n/charmaps/IBM273.gz
rm -f ./i18n/charmaps/EBCDIC-FI-SE.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-FI-SE.gz ./i18n/charmaps/EBCDIC-FI-SE.gz
rm -f ./i18n/charmaps/IBM871.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM871.gz ./i18n/charmaps/IBM871.gz
rm -f ./i18n/charmaps/IBM275.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM275.gz ./i18n/charmaps/IBM275.gz
rm -f ./i18n/charmaps/SHIFT_JIS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/SHIFT_JIS.gz ./i18n/charmaps/SHIFT_JIS.gz
rm -f ./i18n/charmaps/EBCDIC-FI-SE-A.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-FI-SE-A.gz ./i18n/charmaps/EBCDIC-FI-SE-A.gz
rm -f ./i18n/charmaps/SEN_850200_B.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/SEN_850200_B.gz ./i18n/charmaps/SEN_850200_B.gz
rm -f ./i18n/charmaps/IBM423.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM423.gz ./i18n/charmaps/IBM423.gz
rm -f ./i18n/charmaps/MIK.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/MIK.gz ./i18n/charmaps/MIK.gz
rm -f ./i18n/charmaps/IBM869.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM869.gz ./i18n/charmaps/IBM869.gz
rm -f ./i18n/charmaps/HP-TURKISH8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/HP-TURKISH8.gz ./i18n/charmaps/HP-TURKISH8.gz
rm -f ./i18n/charmaps/ARMSCII-8.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ARMSCII-8.gz ./i18n/charmaps/ARMSCII-8.gz
rm -f ./i18n/charmaps/GEORGIAN-ACADEMY.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GEORGIAN-ACADEMY.gz ./i18n/charmaps/GEORGIAN-ACADEMY.gz
rm -f ./i18n/charmaps/CP772.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP772.gz ./i18n/charmaps/CP772.gz
rm -f ./i18n/charmaps/PT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/PT.gz ./i18n/charmaps/PT.gz
rm -f ./i18n/charmaps/T.61-7BIT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/T.61-7BIT.gz ./i18n/charmaps/T.61-7BIT.gz
rm -f ./i18n/charmaps/IBM420.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM420.gz ./i18n/charmaps/IBM420.gz
rm -f ./i18n/charmaps/EBCDIC-AT-DE.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-AT-DE.gz ./i18n/charmaps/EBCDIC-AT-DE.gz
rm -f ./i18n/charmaps/ISO-8859-14.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-14.gz ./i18n/charmaps/ISO-8859-14.gz
rm -f ./i18n/charmaps/GREEK7.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/GREEK7.gz ./i18n/charmaps/GREEK7.gz
rm -f ./i18n/charmaps/ECMA-CYRILLIC.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ECMA-CYRILLIC.gz ./i18n/charmaps/ECMA-CYRILLIC.gz
rm -f ./i18n/charmaps/ISO_8859-1,GL.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO_8859-1,GL.gz ./i18n/charmaps/ISO_8859-1,GL.gz
rm -f ./i18n/charmaps/CP774.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP774.gz ./i18n/charmaps/CP774.gz
rm -f ./i18n/charmaps/NEXTSTEP.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/NEXTSTEP.gz ./i18n/charmaps/NEXTSTEP.gz
rm -f ./i18n/charmaps/TCVN5712-1.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/TCVN5712-1.gz ./i18n/charmaps/TCVN5712-1.gz
rm -f ./i18n/charmaps/EUC-JP-MS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EUC-JP-MS.gz ./i18n/charmaps/EUC-JP-MS.gz
rm -f ./i18n/charmaps/IBM1160.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1160.gz ./i18n/charmaps/IBM1160.gz
rm -f ./i18n/charmaps/IBM1026.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM1026.gz ./i18n/charmaps/IBM1026.gz
rm -f ./i18n/charmaps/IBM851.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM851.gz ./i18n/charmaps/IBM851.gz
rm -f ./i18n/charmaps/CP1255.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1255.gz ./i18n/charmaps/CP1255.gz
rm -f ./i18n/charmaps/SHIFT_JISX0213.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/SHIFT_JISX0213.gz ./i18n/charmaps/SHIFT_JISX0213.gz
rm -f ./i18n/charmaps/ISO-8859-9.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-9.gz ./i18n/charmaps/ISO-8859-9.gz
rm -f ./i18n/charmaps/IBM874.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM874.gz ./i18n/charmaps/IBM874.gz
rm -f ./i18n/charmaps/CSA_Z243.4-1985-GR.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CSA_Z243.4-1985-GR.gz ./i18n/charmaps/CSA_Z243.4-1985-GR.gz
rm -f ./i18n/charmaps/IBM856.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM856.gz ./i18n/charmaps/IBM856.gz
rm -f ./i18n/charmaps/IBM866.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM866.gz ./i18n/charmaps/IBM866.gz
rm -f ./i18n/charmaps/EBCDIC-ES-S.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-ES-S.gz ./i18n/charmaps/EBCDIC-ES-S.gz
rm -f ./i18n/charmaps/IBM290.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM290.gz ./i18n/charmaps/IBM290.gz
rm -f ./i18n/charmaps/CSA_Z243.4-1985-2.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CSA_Z243.4-1985-2.gz ./i18n/charmaps/CSA_Z243.4-1985-2.gz
rm -f ./i18n/charmaps/EBCDIC-IS-FRISS.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-IS-FRISS.gz ./i18n/charmaps/EBCDIC-IS-FRISS.gz
rm -f ./i18n/charmaps/IBM037.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM037.gz ./i18n/charmaps/IBM037.gz
rm -f ./i18n/charmaps/CP1251.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1251.gz ./i18n/charmaps/CP1251.gz
rm -f ./i18n/charmaps/JUS_I.B1.002.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JUS_I.B1.002.gz ./i18n/charmaps/JUS_I.B1.002.gz
rm -f ./i18n/charmaps/RK1048.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/RK1048.gz ./i18n/charmaps/RK1048.gz
rm -f ./i18n/charmaps/ISO-8859-7.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-7.gz ./i18n/charmaps/ISO-8859-7.gz
rm -f ./i18n/charmaps/CP1257.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/CP1257.gz ./i18n/charmaps/CP1257.gz
rm -f ./i18n/charmaps/IBM862.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM862.gz ./i18n/charmaps/IBM862.gz
rm -f ./i18n/charmaps/ISO-IR-209.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-IR-209.gz ./i18n/charmaps/ISO-IR-209.gz
rm -f ./i18n/charmaps/IBM891.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IBM891.gz ./i18n/charmaps/IBM891.gz
rm -f ./i18n/charmaps/KOI8-R.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/KOI8-R.gz ./i18n/charmaps/KOI8-R.gz
rm -f ./i18n/charmaps/KSC5636.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/KSC5636.gz ./i18n/charmaps/KSC5636.gz
rm -f ./i18n/charmaps/ISO-8859-16.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-16.gz ./i18n/charmaps/ISO-8859-16.gz
rm -f ./i18n/charmaps/ISO-8859-6.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISO-8859-6.gz ./i18n/charmaps/ISO-8859-6.gz
rm -f ./i18n/charmaps/EBCDIC-AT-DE-A.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EBCDIC-AT-DE-A.gz ./i18n/charmaps/EBCDIC-AT-DE-A.gz
rm -f ./i18n/charmaps/JOHAB.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JOHAB.gz ./i18n/charmaps/JOHAB.gz
rm -f ./i18n/charmaps/JIS_C6229-1984-HAND-ADD.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JIS_C6229-1984-HAND-ADD.gz ./i18n/charmaps/JIS_C6229-1984-HAND-ADD.gz
rm -f ./i18n/charmaps/ISIRI-3342.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/ISIRI-3342.gz ./i18n/charmaps/ISIRI-3342.gz
rm -f ./i18n/charmaps/EUC-JISX0213.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/EUC-JISX0213.gz ./i18n/charmaps/EUC-JISX0213.gz
rm -f ./i18n/charmaps/IT.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/IT.gz ./i18n/charmaps/IT.gz
rm -f ./i18n/charmaps/JUS_I.B1.003-SERB.gz
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/charmaps/JUS_I.B1.003-SERB.gz ./i18n/charmaps/JUS_I.B1.003-SERB.gz
rm -f ./i18n/locales/gu_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gu_IN ./i18n/locales/gu_IN
rm -f ./i18n/locales/fa_IR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fa_IR ./i18n/locales/fa_IR
rm -f ./i18n/locales/ta_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ta_IN ./i18n/locales/ta_IN
rm -f ./i18n/locales/es_SV
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_SV ./i18n/locales/es_SV
rm -f ./i18n/locales/tr_CY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tr_CY ./i18n/locales/tr_CY
rm -f ./i18n/locales/ga_IE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ga_IE@euro ./i18n/locales/ga_IE@euro
rm -f ./i18n/locales/en_AG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_AG ./i18n/locales/en_AG
rm -f ./i18n/locales/et_EE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/et_EE ./i18n/locales/et_EE
rm -f ./i18n/locales/eu_ES
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/eu_ES ./i18n/locales/eu_ES
rm -f ./i18n/locales/it_IT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/it_IT ./i18n/locales/it_IT
rm -f ./i18n/locales/iu_CA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/iu_CA ./i18n/locales/iu_CA
rm -f ./i18n/locales/pap_AW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pap_AW ./i18n/locales/pap_AW
rm -f ./i18n/locales/om_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/om_ET ./i18n/locales/om_ET
rm -f ./i18n/locales/my_MM
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/my_MM ./i18n/locales/my_MM
rm -f ./i18n/locales/ky_KG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ky_KG ./i18n/locales/ky_KG
rm -f ./i18n/locales/unm_US
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/unm_US ./i18n/locales/unm_US
rm -f ./i18n/locales/es_UY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_UY ./i18n/locales/es_UY
rm -f ./i18n/locales/ur_PK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ur_PK ./i18n/locales/ur_PK
rm -f ./i18n/locales/aa_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/aa_ET ./i18n/locales/aa_ET
rm -f ./i18n/locales/gez_ER
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gez_ER ./i18n/locales/gez_ER
rm -f ./i18n/locales/aa_DJ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/aa_DJ ./i18n/locales/aa_DJ
rm -f ./i18n/locales/zh_TW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/zh_TW ./i18n/locales/zh_TW
rm -f ./i18n/locales/anp_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/anp_IN ./i18n/locales/anp_IN
rm -f ./i18n/locales/kok_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/kok_IN ./i18n/locales/kok_IN
rm -f ./i18n/locales/en_NG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_NG ./i18n/locales/en_NG
rm -f ./i18n/locales/ar_JO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_JO ./i18n/locales/ar_JO
rm -f ./i18n/locales/de_AT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_AT ./i18n/locales/de_AT
rm -f ./i18n/locales/so_DJ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/so_DJ ./i18n/locales/so_DJ
rm -f ./i18n/locales/fy_NL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fy_NL ./i18n/locales/fy_NL
rm -f ./i18n/locales/es_AR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_AR ./i18n/locales/es_AR
rm -f ./i18n/locales/ku_TR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ku_TR ./i18n/locales/ku_TR
rm -f ./i18n/locales/wa_BE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/wa_BE@euro ./i18n/locales/wa_BE@euro
rm -f ./i18n/locales/ar_SY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_SY ./i18n/locales/ar_SY
rm -f ./i18n/locales/de_BE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_BE@euro ./i18n/locales/de_BE@euro
rm -f ./i18n/locales/ve_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ve_ZA ./i18n/locales/ve_ZA
rm -f ./i18n/locales/es_PR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_PR ./i18n/locales/es_PR
rm -f ./i18n/locales/ug_CN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ug_CN ./i18n/locales/ug_CN
rm -f ./i18n/locales/kl_GL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/kl_GL ./i18n/locales/kl_GL
rm -f ./i18n/locales/es_CR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_CR ./i18n/locales/es_CR
rm -f ./i18n/locales/ff_SN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ff_SN ./i18n/locales/ff_SN
rm -f ./i18n/locales/hi_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hi_IN ./i18n/locales/hi_IN
rm -f ./i18n/locales/quz_PE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/quz_PE ./i18n/locales/quz_PE
rm -f ./i18n/locales/iso14651_t1_pinyin
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/iso14651_t1_pinyin ./i18n/locales/iso14651_t1_pinyin
rm -f ./i18n/locales/ta_LK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ta_LK ./i18n/locales/ta_LK
rm -f ./i18n/locales/ayc_PE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ayc_PE ./i18n/locales/ayc_PE
rm -f ./i18n/locales/hr_HR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hr_HR ./i18n/locales/hr_HR
rm -f ./i18n/locales/ka_GE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ka_GE ./i18n/locales/ka_GE
rm -f ./i18n/locales/pa_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pa_IN ./i18n/locales/pa_IN
rm -f ./i18n/locales/nr_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nr_ZA ./i18n/locales/nr_ZA
rm -f ./i18n/locales/bho_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bho_IN ./i18n/locales/bho_IN
rm -f ./i18n/locales/wae_CH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/wae_CH ./i18n/locales/wae_CH
rm -f ./i18n/locales/hy_AM
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hy_AM ./i18n/locales/hy_AM
rm -f ./i18n/locales/es_EC
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_EC ./i18n/locales/es_EC
rm -f ./i18n/locales/mag_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mag_IN ./i18n/locales/mag_IN
rm -f ./i18n/locales/de_CH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_CH ./i18n/locales/de_CH
rm -f ./i18n/locales/es_BO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_BO ./i18n/locales/es_BO
rm -f ./i18n/locales/ne_NP
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ne_NP ./i18n/locales/ne_NP
rm -f ./i18n/locales/lg_UG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lg_UG ./i18n/locales/lg_UG
rm -f ./i18n/locales/csb_PL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/csb_PL ./i18n/locales/csb_PL
rm -f ./i18n/locales/yo_NG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/yo_NG ./i18n/locales/yo_NG
rm -f ./i18n/locales/br_FR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/br_FR ./i18n/locales/br_FR
rm -f ./i18n/locales/gd_GB
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gd_GB ./i18n/locales/gd_GB
rm -f ./i18n/locales/en_ZW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_ZW ./i18n/locales/en_ZW
rm -f ./i18n/locales/POSIX
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/POSIX ./i18n/locales/POSIX
rm -f ./i18n/locales/sv_FI
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sv_FI ./i18n/locales/sv_FI
rm -f ./i18n/locales/sat_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sat_IN ./i18n/locales/sat_IN
rm -f ./i18n/locales/hak_TW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hak_TW ./i18n/locales/hak_TW
rm -f ./i18n/locales/sv_SE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sv_SE ./i18n/locales/sv_SE
rm -f ./i18n/locales/nds_NL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nds_NL ./i18n/locales/nds_NL
rm -f ./i18n/locales/el_CY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/el_CY ./i18n/locales/el_CY
rm -f ./i18n/locales/sk_SK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sk_SK ./i18n/locales/sk_SK
rm -f ./i18n/locales/es_US
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_US ./i18n/locales/es_US
rm -f ./i18n/locales/yue_HK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/yue_HK ./i18n/locales/yue_HK
rm -f ./i18n/locales/translit_compat
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_compat ./i18n/locales/translit_compat
rm -f ./i18n/locales/fr_FR@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_FR@euro ./i18n/locales/fr_FR@euro
rm -f ./i18n/locales/iso14651_t1_common
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/iso14651_t1_common ./i18n/locales/iso14651_t1_common
rm -f ./i18n/locales/ar_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_IN ./i18n/locales/ar_IN
rm -f ./i18n/locales/niu_NU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/niu_NU ./i18n/locales/niu_NU
rm -f ./i18n/locales/bo_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bo_IN ./i18n/locales/bo_IN
rm -f ./i18n/locales/mn_MN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mn_MN ./i18n/locales/mn_MN
rm -f ./i18n/locales/ar_KW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_KW ./i18n/locales/ar_KW
rm -f ./i18n/locales/hne_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hne_IN ./i18n/locales/hne_IN
rm -f ./i18n/locales/om_KE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/om_KE ./i18n/locales/om_KE
rm -f ./i18n/locales/de_DE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_DE@euro ./i18n/locales/de_DE@euro
rm -f ./i18n/locales/bn_BD
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bn_BD ./i18n/locales/bn_BD
rm -f ./i18n/locales/be_BY@latin
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/be_BY@latin ./i18n/locales/be_BY@latin
rm -f ./i18n/locales/translit_cjk_variants
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_cjk_variants ./i18n/locales/translit_cjk_variants
rm -f ./i18n/locales/bem_ZM
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bem_ZM ./i18n/locales/bem_ZM
rm -f ./i18n/locales/rw_RW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/rw_RW ./i18n/locales/rw_RW
rm -f ./i18n/locales/translit_hangul
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_hangul ./i18n/locales/translit_hangul
rm -f ./i18n/locales/mhr_RU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mhr_RU ./i18n/locales/mhr_RU
rm -f ./i18n/locales/es_CL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_CL ./i18n/locales/es_CL
rm -f ./i18n/locales/translit_cjk_compat
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_cjk_compat ./i18n/locales/translit_cjk_compat
rm -f ./i18n/locales/ar_BH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_BH ./i18n/locales/ar_BH
rm -f ./i18n/locales/ar_LB
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_LB ./i18n/locales/ar_LB
rm -f ./i18n/locales/nb_NO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nb_NO ./i18n/locales/nb_NO
rm -f ./i18n/locales/fr_FR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_FR ./i18n/locales/fr_FR
rm -f ./i18n/locales/i18n
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/i18n ./i18n/locales/i18n
rm -f ./i18n/locales/it_IT@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/it_IT@euro ./i18n/locales/it_IT@euro
rm -f ./i18n/locales/xh_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/xh_ZA ./i18n/locales/xh_ZA
rm -f ./i18n/locales/es_VE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_VE ./i18n/locales/es_VE
rm -f ./i18n/locales/en_PH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_PH ./i18n/locales/en_PH
rm -f ./i18n/locales/lb_LU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lb_LU ./i18n/locales/lb_LU
rm -f ./i18n/locales/fr_BE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_BE ./i18n/locales/fr_BE
rm -f ./i18n/locales/es_NI
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_NI ./i18n/locales/es_NI
rm -f ./i18n/locales/nl_NL@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nl_NL@euro ./i18n/locales/nl_NL@euro
rm -f ./i18n/locales/en_AU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_AU ./i18n/locales/en_AU
rm -f ./i18n/locales/uz_UZ@cyrillic
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/uz_UZ@cyrillic ./i18n/locales/uz_UZ@cyrillic
rm -f ./i18n/locales/iso14651_t1
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/iso14651_t1 ./i18n/locales/iso14651_t1
rm -f ./i18n/locales/so_KE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/so_KE ./i18n/locales/so_KE
rm -f ./i18n/locales/pt_BR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pt_BR ./i18n/locales/pt_BR
rm -f ./i18n/locales/te_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/te_IN ./i18n/locales/te_IN
rm -f ./i18n/locales/zu_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/zu_ZA ./i18n/locales/zu_ZA
rm -f ./i18n/locales/lv_LV
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lv_LV ./i18n/locales/lv_LV
rm -f ./i18n/locales/sw_KE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sw_KE ./i18n/locales/sw_KE
rm -f ./i18n/locales/ss_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ss_ZA ./i18n/locales/ss_ZA
rm -f ./i18n/locales/tt_RU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tt_RU ./i18n/locales/tt_RU
rm -f ./i18n/locales/gl_ES
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gl_ES ./i18n/locales/gl_ES
rm -f ./i18n/locales/fil_PH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fil_PH ./i18n/locales/fil_PH
rm -f ./i18n/locales/ca_AD
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ca_AD ./i18n/locales/ca_AD
rm -f ./i18n/locales/es_CO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_CO ./i18n/locales/es_CO
rm -f ./i18n/locales/sl_SI
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sl_SI ./i18n/locales/sl_SI
rm -f ./i18n/locales/az_AZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/az_AZ ./i18n/locales/az_AZ
rm -f ./i18n/locales/gez_ET@abegede
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gez_ET@abegede ./i18n/locales/gez_ET@abegede
rm -f ./i18n/locales/tk_TM
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tk_TM ./i18n/locales/tk_TM
rm -f ./i18n/locales/gl_ES@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gl_ES@euro ./i18n/locales/gl_ES@euro
rm -f ./i18n/locales/ps_AF
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ps_AF ./i18n/locales/ps_AF
rm -f ./i18n/locales/es_HN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_HN ./i18n/locales/es_HN
rm -f ./i18n/locales/ia_FR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ia_FR ./i18n/locales/ia_FR
rm -f ./i18n/locales/fr_LU@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_LU@euro ./i18n/locales/fr_LU@euro
rm -f ./i18n/locales/cmn_TW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/cmn_TW ./i18n/locales/cmn_TW
rm -f ./i18n/locales/nds_DE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nds_DE ./i18n/locales/nds_DE
rm -f ./i18n/locales/ht_HT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ht_HT ./i18n/locales/ht_HT
rm -f ./i18n/locales/hsb_DE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hsb_DE ./i18n/locales/hsb_DE
rm -f ./i18n/locales/bhb_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bhb_IN ./i18n/locales/bhb_IN
rm -f ./i18n/locales/gv_GB
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gv_GB ./i18n/locales/gv_GB
rm -f ./i18n/locales/ko_KR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ko_KR ./i18n/locales/ko_KR
rm -f ./i18n/locales/ber_DZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ber_DZ ./i18n/locales/ber_DZ
rm -f ./i18n/locales/ks_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ks_IN ./i18n/locales/ks_IN
rm -f ./i18n/locales/pt_PT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pt_PT ./i18n/locales/pt_PT
rm -f ./i18n/locales/cv_RU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/cv_RU ./i18n/locales/cv_RU
rm -f ./i18n/locales/am_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/am_ET ./i18n/locales/am_ET
rm -f ./i18n/locales/ru_UA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ru_UA ./i18n/locales/ru_UA
rm -f ./i18n/locales/dz_BT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/dz_BT ./i18n/locales/dz_BT
rm -f ./i18n/locales/es_PE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_PE ./i18n/locales/es_PE
rm -f ./i18n/locales/fur_IT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fur_IT ./i18n/locales/fur_IT
rm -f ./i18n/locales/translit_small
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_small ./i18n/locales/translit_small
rm -f ./i18n/locales/is_IS
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/is_IS ./i18n/locales/is_IS
rm -f ./i18n/locales/mr_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mr_IN ./i18n/locales/mr_IN
rm -f ./i18n/locales/en_HK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_HK ./i18n/locales/en_HK
rm -f ./i18n/locales/pl_PL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pl_PL ./i18n/locales/pl_PL
rm -f ./i18n/locales/lij_IT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lij_IT ./i18n/locales/lij_IT
rm -f ./i18n/locales/mk_MK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mk_MK ./i18n/locales/mk_MK
rm -f ./i18n/locales/af_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/af_ZA ./i18n/locales/af_ZA
rm -f ./i18n/locales/iw_IL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/iw_IL ./i18n/locales/iw_IL
rm -f ./i18n/locales/or_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/or_IN ./i18n/locales/or_IN
rm -f ./i18n/locales/uk_UA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/uk_UA ./i18n/locales/uk_UA
rm -f ./i18n/locales/fr_LU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_LU ./i18n/locales/fr_LU
rm -f ./i18n/locales/es_PY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_PY ./i18n/locales/es_PY
rm -f ./i18n/locales/translit_narrow
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_narrow ./i18n/locales/translit_narrow
rm -f ./i18n/locales/es_GT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_GT ./i18n/locales/es_GT
rm -f ./i18n/locales/brx_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/brx_IN ./i18n/locales/brx_IN
rm -f ./i18n/locales/lt_LT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lt_LT ./i18n/locales/lt_LT
rm -f ./i18n/locales/en_ZM
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_ZM ./i18n/locales/en_ZM
rm -f ./i18n/locales/wa_BE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/wa_BE ./i18n/locales/wa_BE
rm -f ./i18n/locales/mai_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mai_IN ./i18n/locales/mai_IN
rm -f ./i18n/locales/el_GR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/el_GR ./i18n/locales/el_GR
rm -f ./i18n/locales/sd_IN@devanagari
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sd_IN@devanagari ./i18n/locales/sd_IN@devanagari
rm -f ./i18n/locales/wo_SN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/wo_SN ./i18n/locales/wo_SN
rm -f ./i18n/locales/zh_CN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/zh_CN ./i18n/locales/zh_CN
rm -f ./i18n/locales/ur_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ur_IN ./i18n/locales/ur_IN
rm -f ./i18n/locales/aa_ER
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/aa_ER ./i18n/locales/aa_ER
rm -f ./i18n/locales/mt_MT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mt_MT ./i18n/locales/mt_MT
rm -f ./i18n/locales/ga_IE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ga_IE ./i18n/locales/ga_IE
rm -f ./i18n/locales/fy_DE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fy_DE ./i18n/locales/fy_DE
rm -f ./i18n/locales/fr_CH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_CH ./i18n/locales/fr_CH
rm -f ./i18n/locales/lzh_TW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lzh_TW ./i18n/locales/lzh_TW
rm -f ./i18n/locales/es_MX
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_MX ./i18n/locales/es_MX
rm -f ./i18n/locales/tig_ER
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tig_ER ./i18n/locales/tig_ER
rm -f ./i18n/locales/sr_RS
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sr_RS ./i18n/locales/sr_RS
rm -f ./i18n/locales/en_IE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_IE ./i18n/locales/en_IE
rm -f ./i18n/locales/fr_BE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_BE@euro ./i18n/locales/fr_BE@euro
rm -f ./i18n/locales/sr_RS@latin
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sr_RS@latin ./i18n/locales/sr_RS@latin
rm -f ./i18n/locales/hu_HU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/hu_HU ./i18n/locales/hu_HU
rm -f ./i18n/locales/ak_GH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ak_GH ./i18n/locales/ak_GH
rm -f ./i18n/locales/dv_MV
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/dv_MV ./i18n/locales/dv_MV
rm -f ./i18n/locales/de_LU@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_LU@euro ./i18n/locales/de_LU@euro
rm -f ./i18n/locales/st_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/st_ZA ./i18n/locales/st_ZA
rm -f ./i18n/locales/de_DE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_DE ./i18n/locales/de_DE
rm -f ./i18n/locales/es_ES
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_ES ./i18n/locales/es_ES
rm -f ./i18n/locales/byn_ER
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/byn_ER ./i18n/locales/byn_ER
rm -f ./i18n/locales/br_FR@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/br_FR@euro ./i18n/locales/br_FR@euro
rm -f ./i18n/locales/nan_TW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nan_TW ./i18n/locales/nan_TW
rm -f ./i18n/locales/fo_FO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fo_FO ./i18n/locales/fo_FO
rm -f ./i18n/locales/nl_BE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nl_BE@euro ./i18n/locales/nl_BE@euro
rm -f ./i18n/locales/zh_HK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/zh_HK ./i18n/locales/zh_HK
rm -f ./i18n/locales/fr_CA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fr_CA ./i18n/locales/fr_CA
rm -f ./i18n/locales/sq_MK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sq_MK ./i18n/locales/sq_MK
rm -f ./i18n/locales/fi_FI@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fi_FI@euro ./i18n/locales/fi_FI@euro
rm -f ./i18n/locales/vi_VN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/vi_VN ./i18n/locales/vi_VN
rm -f ./i18n/locales/so_SO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/so_SO ./i18n/locales/so_SO
rm -f ./i18n/locales/pap_AN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pap_AN ./i18n/locales/pap_AN
rm -f ./i18n/locales/en_BW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_BW ./i18n/locales/en_BW
rm -f ./i18n/locales/sq_AL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sq_AL ./i18n/locales/sq_AL
rm -f ./i18n/locales/fi_FI
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/fi_FI ./i18n/locales/fi_FI
rm -f ./i18n/locales/id_ID
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/id_ID ./i18n/locales/id_ID
rm -f ./i18n/locales/niu_NZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/niu_NZ ./i18n/locales/niu_NZ
rm -f ./i18n/locales/translit_font
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_font ./i18n/locales/translit_font
rm -f ./i18n/locales/sid_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sid_ET ./i18n/locales/sid_ET
rm -f ./i18n/locales/tt_RU@iqtelif
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tt_RU@iqtelif ./i18n/locales/tt_RU@iqtelif
rm -f ./i18n/locales/os_RU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/os_RU ./i18n/locales/os_RU
rm -f ./i18n/locales/sw_TZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sw_TZ ./i18n/locales/sw_TZ
rm -f ./i18n/locales/nhn_MX
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nhn_MX ./i18n/locales/nhn_MX
rm -f ./i18n/locales/gez_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gez_ET ./i18n/locales/gez_ET
rm -f ./i18n/locales/bg_BG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bg_BG ./i18n/locales/bg_BG
rm -f ./i18n/locales/si_LK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/si_LK ./i18n/locales/si_LK
rm -f ./i18n/locales/sr_ME
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sr_ME ./i18n/locales/sr_ME
rm -f ./i18n/locales/ber_MA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ber_MA ./i18n/locales/ber_MA
rm -f ./i18n/locales/es_ES@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_ES@euro ./i18n/locales/es_ES@euro
rm -f ./i18n/locales/ast_ES
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ast_ES ./i18n/locales/ast_ES
rm -f ./i18n/locales/de_AT@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_AT@euro ./i18n/locales/de_AT@euro
rm -f ./i18n/locales/tg_TJ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tg_TJ ./i18n/locales/tg_TJ
rm -f ./i18n/locales/ca_IT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ca_IT ./i18n/locales/ca_IT
rm -f ./i18n/locales/nso_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nso_ZA ./i18n/locales/nso_ZA
rm -f ./i18n/locales/it_CH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/it_CH ./i18n/locales/it_CH
rm -f ./i18n/locales/ce_RU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ce_RU ./i18n/locales/ce_RU
rm -f ./i18n/locales/translit_circle
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_circle ./i18n/locales/translit_circle
rm -f ./i18n/locales/crh_UA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/crh_UA ./i18n/locales/crh_UA
rm -f ./i18n/locales/ar_SD
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_SD ./i18n/locales/ar_SD
rm -f ./i18n/locales/ca_FR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ca_FR ./i18n/locales/ca_FR
rm -f ./i18n/locales/li_NL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/li_NL ./i18n/locales/li_NL
rm -f ./i18n/locales/eu_ES@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/eu_ES@euro ./i18n/locales/eu_ES@euro
rm -f ./i18n/locales/ar_LY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_LY ./i18n/locales/ar_LY
rm -f ./i18n/locales/oc_FR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/oc_FR ./i18n/locales/oc_FR
rm -f ./i18n/locales/ar_DZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_DZ ./i18n/locales/ar_DZ
rm -f ./i18n/locales/pa_PK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pa_PK ./i18n/locales/pa_PK
rm -f ./i18n/locales/zh_SG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/zh_SG ./i18n/locales/zh_SG
rm -f ./i18n/locales/an_ES
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/an_ES ./i18n/locales/an_ES
rm -f ./i18n/locales/ha_NG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ha_NG ./i18n/locales/ha_NG
rm -f ./i18n/locales/sv_FI@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sv_FI@euro ./i18n/locales/sv_FI@euro
rm -f ./i18n/locales/szl_PL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/szl_PL ./i18n/locales/szl_PL
rm -f ./i18n/locales/ti_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ti_ET ./i18n/locales/ti_ET
rm -f ./i18n/locales/en_GB
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_GB ./i18n/locales/en_GB
rm -f ./i18n/locales/raj_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/raj_IN ./i18n/locales/raj_IN
rm -f ./i18n/locales/nan_TW@latin
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nan_TW@latin ./i18n/locales/nan_TW@latin
rm -f ./i18n/locales/kw_GB
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/kw_GB ./i18n/locales/kw_GB
rm -f ./i18n/locales/so_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/so_ET ./i18n/locales/so_ET
rm -f ./i18n/locales/ks_IN@devanagari
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ks_IN@devanagari ./i18n/locales/ks_IN@devanagari
rm -f ./i18n/locales/nl_NL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nl_NL ./i18n/locales/nl_NL
rm -f ./i18n/locales/sd_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sd_IN ./i18n/locales/sd_IN
rm -f ./i18n/locales/es_CU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_CU ./i18n/locales/es_CU
rm -f ./i18n/locales/tcy_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tcy_IN ./i18n/locales/tcy_IN
rm -f ./i18n/locales/en_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_IN ./i18n/locales/en_IN
rm -f ./i18n/locales/en_CA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_CA ./i18n/locales/en_CA
rm -f ./i18n/locales/ms_MY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ms_MY ./i18n/locales/ms_MY
rm -f ./i18n/locales/mni_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mni_IN ./i18n/locales/mni_IN
rm -f ./i18n/locales/th_TH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/th_TH ./i18n/locales/th_TH
rm -f ./i18n/locales/ar_IQ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_IQ ./i18n/locales/ar_IQ
rm -f ./i18n/locales/nl_AW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nl_AW ./i18n/locales/nl_AW
rm -f ./i18n/locales/ar_AE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_AE ./i18n/locales/ar_AE
rm -f ./i18n/locales/ca_ES@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ca_ES@euro ./i18n/locales/ca_ES@euro
rm -f ./i18n/locales/kn_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/kn_IN ./i18n/locales/kn_IN
rm -f ./i18n/locales/km_KH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/km_KH ./i18n/locales/km_KH
rm -f ./i18n/locales/de_BE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_BE ./i18n/locales/de_BE
rm -f ./i18n/locales/sc_IT
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sc_IT ./i18n/locales/sc_IT
rm -f ./i18n/locales/yi_US
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/yi_US ./i18n/locales/yi_US
rm -f ./i18n/locales/bo_CN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bo_CN ./i18n/locales/bo_CN
rm -f ./i18n/locales/shs_CA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/shs_CA ./i18n/locales/shs_CA
rm -f ./i18n/locales/uz_UZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/uz_UZ ./i18n/locales/uz_UZ
rm -f ./i18n/locales/ar_OM
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_OM ./i18n/locales/ar_OM
rm -f ./i18n/locales/es_PA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_PA ./i18n/locales/es_PA
rm -f ./i18n/locales/de_LU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/de_LU ./i18n/locales/de_LU
rm -f ./i18n/locales/es_DO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/es_DO ./i18n/locales/es_DO
rm -f ./i18n/locales/nn_NO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nn_NO ./i18n/locales/nn_NO
rm -f ./i18n/locales/li_BE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/li_BE ./i18n/locales/li_BE
rm -f ./i18n/locales/ro_RO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ro_RO ./i18n/locales/ro_RO
rm -f ./i18n/locales/tl_PH
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tl_PH ./i18n/locales/tl_PH
rm -f ./i18n/locales/ar_QA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_QA ./i18n/locales/ar_QA
rm -f ./i18n/locales/ar_MA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_MA ./i18n/locales/ar_MA
rm -f ./i18n/locales/el_GR@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/el_GR@euro ./i18n/locales/el_GR@euro
rm -f ./i18n/locales/ru_RU
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ru_RU ./i18n/locales/ru_RU
rm -f ./i18n/locales/the_NP
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/the_NP ./i18n/locales/the_NP
rm -f ./i18n/locales/ik_CA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ik_CA ./i18n/locales/ik_CA
rm -f ./i18n/locales/pap_CW
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pap_CW ./i18n/locales/pap_CW
rm -f ./i18n/locales/translit_neutral
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_neutral ./i18n/locales/translit_neutral
rm -f ./i18n/locales/en_IE@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_IE@euro ./i18n/locales/en_IE@euro
rm -f ./i18n/locales/ar_TN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_TN ./i18n/locales/ar_TN
rm -f ./i18n/locales/ar_EG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_EG ./i18n/locales/ar_EG
rm -f ./i18n/locales/wal_ET
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/wal_ET ./i18n/locales/wal_ET
rm -f ./i18n/locales/ar_YE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_YE ./i18n/locales/ar_YE
rm -f ./i18n/locales/he_IL
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/he_IL ./i18n/locales/he_IL
rm -f ./i18n/locales/mi_NZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mi_NZ ./i18n/locales/mi_NZ
rm -f ./i18n/locales/en_SG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_SG ./i18n/locales/en_SG
rm -f ./i18n/locales/sa_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/sa_IN ./i18n/locales/sa_IN
rm -f ./i18n/locales/pt_PT@euro
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/pt_PT@euro ./i18n/locales/pt_PT@euro
rm -f ./i18n/locales/lo_LA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/lo_LA ./i18n/locales/lo_LA
rm -f ./i18n/locales/ja_JP
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ja_JP ./i18n/locales/ja_JP
rm -f ./i18n/locales/translit_wide
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_wide ./i18n/locales/translit_wide
rm -f ./i18n/locales/ml_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ml_IN ./i18n/locales/ml_IN
rm -f ./i18n/locales/bn_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bn_IN ./i18n/locales/bn_IN
rm -f ./i18n/locales/nl_BE
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/nl_BE ./i18n/locales/nl_BE
rm -f ./i18n/locales/en_DK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_DK ./i18n/locales/en_DK
rm -f ./i18n/locales/ti_ER
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ti_ER ./i18n/locales/ti_ER
rm -f ./i18n/locales/translit_fraction
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_fraction ./i18n/locales/translit_fraction
rm -f ./i18n/locales/kk_KZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/kk_KZ ./i18n/locales/kk_KZ
rm -f ./i18n/locales/doi_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/doi_IN ./i18n/locales/doi_IN
rm -f ./i18n/locales/se_NO
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/se_NO ./i18n/locales/se_NO
rm -f ./i18n/locales/translit_combining
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/translit_combining ./i18n/locales/translit_combining
rm -f ./i18n/locales/mg_MG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/mg_MG ./i18n/locales/mg_MG
rm -f ./i18n/locales/tr_TR
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tr_TR ./i18n/locales/tr_TR
rm -f ./i18n/locales/ts_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ts_ZA ./i18n/locales/ts_ZA
rm -f ./i18n/locales/as_IN
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/as_IN ./i18n/locales/as_IN
rm -f ./i18n/locales/tn_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/tn_ZA ./i18n/locales/tn_ZA
rm -f ./i18n/locales/aa_ER@saaho
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/aa_ER@saaho ./i18n/locales/aa_ER@saaho
rm -f ./i18n/locales/en_US
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_US ./i18n/locales/en_US
rm -f ./i18n/locales/cy_GB
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/cy_GB ./i18n/locales/cy_GB
rm -f ./i18n/locales/bs_BA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/bs_BA ./i18n/locales/bs_BA
rm -f ./i18n/locales/da_DK
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/da_DK ./i18n/locales/da_DK
rm -f ./i18n/locales/en_NZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_NZ ./i18n/locales/en_NZ
rm -f ./i18n/locales/be_BY
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/be_BY ./i18n/locales/be_BY
rm -f ./i18n/locales/ar_SS
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_SS ./i18n/locales/ar_SS
rm -f ./i18n/locales/ar_SA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ar_SA ./i18n/locales/ar_SA
rm -f ./i18n/locales/gez_ER@abegede
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/gez_ER@abegede ./i18n/locales/gez_ER@abegede
rm -f ./i18n/locales/cs_CZ
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/cs_CZ ./i18n/locales/cs_CZ
rm -f ./i18n/locales/ig_NG
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ig_NG ./i18n/locales/ig_NG
rm -f ./i18n/locales/ca_ES
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/ca_ES ./i18n/locales/ca_ES
rm -f ./i18n/locales/en_ZA
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./i18n/locales/en_ZA ./i18n/locales/en_ZA
rm -f ./locale/eo/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/eo/LC_MESSAGES/libc.mo ./locale/eo/LC_MESSAGES/libc.mo
rm -f ./locale/lt/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/lt/LC_MESSAGES/libc.mo ./locale/lt/LC_MESSAGES/libc.mo
rm -f ./locale/zh_TW/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/zh_TW/LC_MESSAGES/libc.mo ./locale/zh_TW/LC_MESSAGES/libc.mo
rm -f ./locale/ca/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/ca/LC_MESSAGES/libc.mo ./locale/ca/LC_MESSAGES/libc.mo
rm -f ./locale/sl/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/sl/LC_MESSAGES/libc.mo ./locale/sl/LC_MESSAGES/libc.mo
rm -f ./locale/nb/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/nb/LC_MESSAGES/libc.mo ./locale/nb/LC_MESSAGES/libc.mo
rm -f ./locale/da/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/da/LC_MESSAGES/libc.mo ./locale/da/LC_MESSAGES/libc.mo
rm -f ./locale/hu/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/hu/LC_MESSAGES/libc.mo ./locale/hu/LC_MESSAGES/libc.mo
rm -f ./locale/vi/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/vi/LC_MESSAGES/libc.mo ./locale/vi/LC_MESSAGES/libc.mo
rm -f ./locale/ko/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/ko/LC_MESSAGES/libc.mo ./locale/ko/LC_MESSAGES/libc.mo
rm -f ./locale/tr/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/tr/LC_MESSAGES/libc.mo ./locale/tr/LC_MESSAGES/libc.mo
rm -f ./locale/pt_BR/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/pt_BR/LC_MESSAGES/libc.mo ./locale/pt_BR/LC_MESSAGES/libc.mo
rm -f ./locale/de/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/de/LC_MESSAGES/libc.mo ./locale/de/LC_MESSAGES/libc.mo
rm -f ./locale/hr/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/hr/LC_MESSAGES/libc.mo ./locale/hr/LC_MESSAGES/libc.mo
rm -f ./locale/ia/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/ia/LC_MESSAGES/libc.mo ./locale/ia/LC_MESSAGES/libc.mo
rm -f ./locale/sv/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/sv/LC_MESSAGES/libc.mo ./locale/sv/LC_MESSAGES/libc.mo
rm -f ./locale/pl/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/pl/LC_MESSAGES/libc.mo ./locale/pl/LC_MESSAGES/libc.mo
rm -f ./locale/gl/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/gl/LC_MESSAGES/libc.mo ./locale/gl/LC_MESSAGES/libc.mo
rm -f ./locale/be/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/be/LC_MESSAGES/libc.mo ./locale/be/LC_MESSAGES/libc.mo
rm -f ./locale/fi/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/fi/LC_MESSAGES/libc.mo ./locale/fi/LC_MESSAGES/libc.mo
rm -f ./locale/zh_CN/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/zh_CN/LC_MESSAGES/libc.mo ./locale/zh_CN/LC_MESSAGES/libc.mo
rm -f ./locale/cs/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/cs/LC_MESSAGES/libc.mo ./locale/cs/LC_MESSAGES/libc.mo
rm -f ./locale/id/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/id/LC_MESSAGES/libc.mo ./locale/id/LC_MESSAGES/libc.mo
rm -f ./locale/ja/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/ja/LC_MESSAGES/libc.mo ./locale/ja/LC_MESSAGES/libc.mo
rm -f ./locale/bg/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/bg/LC_MESSAGES/libc.mo ./locale/bg/LC_MESSAGES/libc.mo
rm -f ./locale/locale.alias
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/locale.alias ./locale/locale.alias
rm -f ./locale/es/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/es/LC_MESSAGES/libc.mo ./locale/es/LC_MESSAGES/libc.mo
rm -f ./locale/ru/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/ru/LC_MESSAGES/libc.mo ./locale/ru/LC_MESSAGES/libc.mo
rm -f ./locale/el/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/el/LC_MESSAGES/libc.mo ./locale/el/LC_MESSAGES/libc.mo
rm -f ./locale/fr/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/fr/LC_MESSAGES/libc.mo ./locale/fr/LC_MESSAGES/libc.mo
rm -f ./locale/en_GB/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/en_GB/LC_MESSAGES/libc.mo ./locale/en_GB/LC_MESSAGES/libc.mo
rm -f ./locale/nl/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/nl/LC_MESSAGES/libc.mo ./locale/nl/LC_MESSAGES/libc.mo
rm -f ./locale/sk/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/sk/LC_MESSAGES/libc.mo ./locale/sk/LC_MESSAGES/libc.mo
rm -f ./locale/it/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/it/LC_MESSAGES/libc.mo ./locale/it/LC_MESSAGES/libc.mo
rm -f ./locale/uk/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/uk/LC_MESSAGES/libc.mo ./locale/uk/LC_MESSAGES/libc.mo
rm -f ./locale/rw/LC_MESSAGES/libc.mo
ln ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/./usr/share/./locale/rw/LC_MESSAGES/libc.mo ./locale/rw/LC_MESSAGES/libc.mo
popd
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/gdbserver
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/sbin/ldconfig
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/sbin/sln
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/catchsegv
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/gencat
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/getconf
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/getent
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/iconv
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/ldd
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/locale
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/localedef
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/makedb
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/mtrace
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/pcprofiledump
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/pldd
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/rpcgen
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/sotruss
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/sprof
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/tzselect
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/bin/xtrace
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/sbin/iconvconfig
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/sbin/nscd
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/sbin/zdump
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/sbin/zic
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf/POSIX_V7_ILP32_OFF32
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf/POSIX_V7_ILP32_OFFBIG
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf/POSIX_V6_ILP32_OFF32
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf/POSIX_V6_ILP32_OFFBIG
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf/XBS5_ILP32_OFF32
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/libexec/getconf/XBS5_ILP32_OFFBIG
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libstdc++.so.6.0.20 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libatomic.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib//bin/gdbserver ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/bin/gdbserver
rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/el/usr/include
rm -rf ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/include
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libstdc++.so.6.0.20 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
cp -d ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libatomic.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/
mkdir -p ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/bin
ln -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib//bin/gdbserver ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/bin/gdbserver
popenv


echo " ----------# task [295/397] /i686-pc-linux-gnu/pretidy_installation"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/install/opt/codesourcery
popd
popenv

echo " ----------# task [296/397] /i686-pc-linux-gnu/remove_libtool_archives"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
find ${local_path}/install/opt/codesourcery -name '*.la' -exec rm '{}' ';'
popenv
echo " ----------# task [297/397] /i686-pc-linux-gnu/remove_copied_libs"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/./libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/el/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/el/libatomic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/el/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/../lib64/soft-float/el/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/nan2008/el/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/micromips/soft-float/el/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/el/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/mips16/soft-float/el/libatomic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/el/libatomic.a
rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/el/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/libatomic.a
#rm -f ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libgcc_s.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libgcc_s.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libstdc++.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libstdc++.so.6 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libstdc++.so.6.0.21 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libstdc++.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libgomp-plugin-host_nonshm.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libgomp-plugin-host_nonshm.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libgomp-plugin-host_nonshm.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libgomp.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libgomp.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libgomp.so.1.0.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libgomp.a ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libatomic.so ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libatomic.so.1 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libatomic.so.1.1.0 ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/nan2008/el/libatomic.a
popenv

echo " ----------# task [298/397] /i686-pc-linux-gnu/remove_fixed_headers"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
pushd ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/4.9.2/include-fixed
popd
popenv

echo " ----------# task [299/397] /i686-pc-linux-gnu/add_tooldir_readme"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
cat > ${local_path}/install/opt/codesourcery/mips-linux-gnu/bin/README.txt <<'EOF0'
The executables in this directory are for internal use by the compiler
and may not operate correctly when used directly.  This directory
should not be placed on your PATH.  Instead, you should use the
executables in ../../bin/ and place that directory on your PATH.
EOF0
popenv

echo " ----------# task [300/397] /i686-pc-linux-gnu/readme_files/install"
echo " ----------# task [301/397] /i686-pc-linux-gnu/strip_host_objects"
echo " ----------# task [302/397] /i686-pc-linux-gnu/strip_target_objects"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
pushenvvar CC 'gcc  '
pushenvvar CXX 'g++ '
pushenvvar LD 'ld '
pushenvvar OBJCOPY 'objcopy '
pushenvvar AR 'ar '
pushenvvar AS 'as '
pushenvvar RANLIB 'ranlib '
prepend_path PATH ${local_path}/install/opt/codesourcery/bin
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libc_nonshared.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libstdc++.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/crti.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libcrypt.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libnss_db.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libstdc++.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libpthread.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libanl.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libpthread_nonshared.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libatomic.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libg.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/librt.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libmcheck.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libgomp.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libnsl.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/librpcsvc.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/crtn.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO-IR-209.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/GBBIG5.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ASMO_449.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1149.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1156.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM903.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM902.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1047.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/SHIFT_JISX0213.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM875.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-2.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/BIG5.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM921.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-1.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1158.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-10.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/KOI-8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM280.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1148.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1122.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM437.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CSN_369103.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM852.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/INIS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-4.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1145.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM277.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/KOI8-R.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/LATIN-GREEK.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO-IR-197.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IEC_P27-1.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1132.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP1125.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/HP-GREEK8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1167.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EUC-JP.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/libGB.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/libJISX0213.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM922.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM862.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/HP-THAI8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM865.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO-2022-CN-EXT.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-US.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO-2022-JP.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM9448.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM857.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CWI.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP1258.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM16804.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1008_420.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-DK-NO.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM939.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ARMSCII-8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM297.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1146.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/DEC-MCS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM863.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/VISCII.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1123.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1157.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/SJIS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/MIK.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/JOHAB.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-AT-DE.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EUC-TW.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO_2033.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP1253.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM932.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO646.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM861.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM274.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM880.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM868.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM864.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1161.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO_10367-BOX.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM037.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP1252.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-UK.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/TIS-620.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1162.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-14.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-FR.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM275.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM866.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1046.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1137.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/TSCII.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM869.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/MAC-UK.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/libKSC.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/TCVN5712-1.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/RK1048.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP772.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM891.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM851.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP1256.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/UTF-32.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM870.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/T.61.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1097.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1130.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-ES.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1112.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP1257.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO-2022-CN.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1141.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1147.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/UTF-7.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP1254.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EUC-JP-MS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/PT154.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1025.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/MAC-CENTRALEUROPE.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/libCNS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-11.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM871.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-DK-NO-A.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/GBK.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM855.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM904.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-ES-S.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-9.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM901.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM866NAV.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-7.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1164.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM4909.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM4517.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1129.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1124.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM273.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-6.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1008.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1154.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-3.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO_6937.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/GOST_19768-74.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM9030.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/HP-TURKISH8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP1255.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1142.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP10007.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM803.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/BIG5HKSCS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM285.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-CA-FR.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/UNICODE.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM856.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/SAMI-WS2.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/UHC.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1364.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP1251.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP932.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM424.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM420.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1163.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO_5428.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM038.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1140.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/KOI8-RU.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP775.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM12712.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ANSI_X3.110.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM290.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1143.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/libISOIR165.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/HP-ROMAN8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO-2022-KR.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO_11548-1.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-FI-SE.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM874.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISIRI-3342.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/UTF-16.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM281.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EUC-JISX0213.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP773.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM423.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP1250.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1399.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM9066.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP771.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/GEORGIAN-ACADEMY.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO-2022-JP-3.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP737.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO_6937-2.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/GREEK-CCITT.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM4971.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/GREEK7.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP774.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-15.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/CP770.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-IT.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1388.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM933.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM500.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1160.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1166.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1004.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO_5427-EXT.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM935.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/LATIN-GREEK-1.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/GB18030.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1155.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/GREEK7-OLD.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/GEORGIAN-PS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM850.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM905.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1133.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-9E.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM937.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM5347.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/MACINTOSH.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1026.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/BRF.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO_5427.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/HP-ROMAN9.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/INIS-8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/KOI8-U.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM284.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/NATS-DANO.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-FI-SE-A.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/MAC-IS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/KOI8-T.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM860.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-ES-A.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM930.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ECMA-CYRILLIC.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1390.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM943.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EUC-KR.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/GBGBK.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1144.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/NATS-SEFI.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-PT.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM278.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-IS-FRISS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/MAC-SAMI.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-16.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-13.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1371.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/INIS-CYRILLIC.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/libJIS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM4899.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM1153.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM918.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/ISO8859-5.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EUC-CN.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/IBM256.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gconv/EBCDIC-AT-DE-A.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libm.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libc.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/Mcrt1.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libdl.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libcidn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/Scrt1.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libdl.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/librt.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libm.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libnss_files.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libnss_hesiod.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/gcrt1.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libresolv.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/audit/sotruss-lib.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libnss_nisplus.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libutil.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libgomp-plugin-host_nonshm.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/crt1.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libcrypt.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libanl.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libnsl.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libgomp.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libthread_db.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libpthread.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libutil.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libatomic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libBrokenLocale.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libc.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libnss_compat.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libnss_dns.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libieee.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libBrokenLocale.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libnss_nis.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/usr/lib/libresolv.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libc_nonshared.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libstdc++.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/crti.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libcrypt.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_db.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libstdc++.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libpthread.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libanl.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libpthread_nonshared.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libatomic.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libg.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/librt.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libmcheck.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libgomp.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnsl.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/librpcsvc.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/crtn.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO-IR-209.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/GBBIG5.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ASMO_449.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1149.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1156.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM903.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM902.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1047.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/SHIFT_JISX0213.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM875.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-2.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/BIG5.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM921.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-1.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1158.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-10.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/KOI-8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM280.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1148.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1122.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM437.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CSN_369103.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM852.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/INIS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-4.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1145.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM277.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/KOI8-R.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/LATIN-GREEK.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO-IR-197.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IEC_P27-1.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1132.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP1125.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/HP-GREEK8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1167.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EUC-JP.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/libGB.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/libJISX0213.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM922.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM862.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/HP-THAI8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM865.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO-2022-CN-EXT.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-US.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO-2022-JP.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM9448.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM857.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CWI.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP1258.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM16804.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1008_420.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-DK-NO.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM939.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ARMSCII-8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM297.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1146.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/DEC-MCS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM863.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/VISCII.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1123.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1157.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/SJIS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/MIK.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/JOHAB.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-AT-DE.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EUC-TW.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO_2033.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP1253.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM932.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO646.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM861.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM274.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM880.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM868.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM864.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1161.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO_10367-BOX.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM037.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP1252.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-UK.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/TIS-620.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1162.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-14.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-FR.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM275.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM866.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1046.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1137.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/TSCII.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM869.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/MAC-UK.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/libKSC.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/TCVN5712-1.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/RK1048.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP772.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM891.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM851.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP1256.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/UTF-32.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM870.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/T.61.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1097.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1130.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-ES.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1112.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP1257.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO-2022-CN.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1141.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1147.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/UTF-7.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP1254.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EUC-JP-MS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/PT154.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1025.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/MAC-CENTRALEUROPE.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/libCNS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-11.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM871.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-DK-NO-A.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/GBK.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM855.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM904.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-ES-S.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-9.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM901.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM866NAV.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-7.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1164.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM4909.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM4517.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1129.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1124.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM273.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-6.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1008.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1154.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-3.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO_6937.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/GOST_19768-74.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM9030.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/HP-TURKISH8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP1255.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1142.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP10007.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM803.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/BIG5HKSCS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM285.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-CA-FR.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/UNICODE.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM856.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/SAMI-WS2.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/UHC.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1364.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP1251.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP932.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM424.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM420.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1163.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO_5428.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM038.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1140.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/KOI8-RU.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP775.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM12712.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ANSI_X3.110.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM290.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1143.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/libISOIR165.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/HP-ROMAN8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO-2022-KR.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO_11548-1.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-FI-SE.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM874.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISIRI-3342.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/UTF-16.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM281.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EUC-JISX0213.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP773.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM423.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP1250.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1399.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM9066.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP771.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/GEORGIAN-ACADEMY.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO-2022-JP-3.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP737.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO_6937-2.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/GREEK-CCITT.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM4971.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/GREEK7.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP774.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-15.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/CP770.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-IT.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1388.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM933.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM500.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1160.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1166.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1004.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO_5427-EXT.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM935.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/LATIN-GREEK-1.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/GB18030.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1155.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/GREEK7-OLD.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/GEORGIAN-PS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM850.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM905.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1133.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-9E.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM937.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM5347.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/MACINTOSH.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1026.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/BRF.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO_5427.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/HP-ROMAN9.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/INIS-8.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/KOI8-U.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM284.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/NATS-DANO.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-FI-SE-A.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/MAC-IS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/KOI8-T.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM860.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-ES-A.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM930.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ECMA-CYRILLIC.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1390.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM943.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EUC-KR.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/GBGBK.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1144.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/NATS-SEFI.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-PT.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM278.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-IS-FRISS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/MAC-SAMI.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-16.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-13.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1371.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/INIS-CYRILLIC.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/libJIS.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM4899.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM1153.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM918.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/ISO8859-5.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EUC-CN.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/IBM256.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gconv/EBCDIC-AT-DE-A.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libm.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libc.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/Mcrt1.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libdl.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libcidn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/Scrt1.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libdl.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/librt.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libm.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_files.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_hesiod.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/gcrt1.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libresolv.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/audit/sotruss-lib.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_nisplus.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libutil.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libgomp-plugin-host_nonshm.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/crt1.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libcrypt.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libanl.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnsl.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libgomp.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libthread_db.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libpthread.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libutil.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libatomic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libBrokenLocale.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libc.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_compat.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_dns.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libieee.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libBrokenLocale.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libnss_nis.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/usr/lib/libresolv.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libnss_nisplus-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libcrypt-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libc-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libnss_compat-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libSegFault.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libnss_dns-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libm-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libmemusage.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libthread_db-1.0.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libnsl-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libpthread-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libutil-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libnss_db-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libresolv-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libnss_files-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libcidn-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libpcprofile.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libnss_hesiod-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/ld-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libnss_nis-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libBrokenLocale-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libgcc_s.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libanl-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/librt-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float/lib/libdl-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libstdc++.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/crti.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libcrypt.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libstdc++.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libpthread.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libatomic.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libthread_db.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/librt.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libc_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libgomp.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libnsl.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/crtn.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libresolv_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libnsl_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libdl_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libm.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libc.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libdl.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/librt_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libm_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libcrypt_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/Scrt1.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libdl.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/librt.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libm.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libresolv.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libutil.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libgomp-plugin-host_nonshm.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/crt1.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libcrypt.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libnsl.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libgomp.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libutil_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libthread_db.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libpthread_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/uclibc_nonshared.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libthread_db_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libpthread.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libutil.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libatomic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libc.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/usr/lib/libresolv.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libstdc++.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/crti.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libcrypt.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libstdc++.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libpthread.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libatomic.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libthread_db.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/librt.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libc_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libgomp.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libnsl.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/crtn.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libresolv_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libnsl_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libdl_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libm.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libc.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libdl.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/librt_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libm_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libcrypt_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/Scrt1.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libdl.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/librt.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libm.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libresolv.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libutil.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libgomp-plugin-host_nonshm.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/crt1.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libcrypt.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libnsl.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libgomp.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libutil_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libthread_db.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libpthread_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/uclibc_nonshared.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libthread_db_pic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libpthread.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libutil.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libatomic.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libc.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/usr/lib/libresolv.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/ld-uClibc-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/libuClibc-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/libcrypt-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/libutil-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/libthread_db-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/libnsl-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/libgcc_s.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/librt-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/libm-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/libpthread-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/libresolv-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float/lib/libdl-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/ld-uClibc-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/libuClibc-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/libcrypt-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/libutil-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/libthread_db-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/libnsl-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/libgcc_s.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/librt-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/libm-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/libpthread-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/libresolv-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/lib/libdl-0.9.30-svn.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libnss_nisplus-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libcrypt-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libc-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libnss_compat-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libSegFault.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libnss_dns-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libm-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libmemusage.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libthread_db-1.0.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libnsl-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libpthread-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libutil-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libnss_db-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libresolv-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libnss_files-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libcidn-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libpcprofile.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libnss_hesiod-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/ld-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libnss_nis-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libBrokenLocale-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libgcc_s.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libanl-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/librt-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/lib/libdl-2.22.so || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/libsupc++.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/soft-float/libsupc++.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/libsupc++.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/lib/uclibc/soft-float/libsupc++.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/libgcov.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/crtend.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/libgcc_eh.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/crtendS.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/crtbegin.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/crtfastmath.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/soft-float/libgcov.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/soft-float/crtend.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/soft-float/libgcc_eh.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/soft-float/crtendS.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/soft-float/crtbegin.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/soft-float/crtfastmath.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/soft-float/crtbeginS.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/soft-float/libgcc.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/soft-float/crtbeginT.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/crtbeginS.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/libgcc.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/libgcov.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/crtend.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/libgcc_eh.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/crtendS.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/crtbegin.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/crtfastmath.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/soft-float/libgcov.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/soft-float/crtend.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/soft-float/libgcc_eh.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/soft-float/crtendS.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/soft-float/crtbegin.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/soft-float/crtfastmath.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/soft-float/crtbeginS.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/soft-float/libgcc.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/soft-float/crtbeginT.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/crtbeginS.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/libgcc.a || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/uclibc/crtbeginT.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-linux-gnu/5.2.0/crtbeginT.o || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/POSIX_V6_ILP32_OFF32 || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/POSIX_V6_ILP32_OFFBIG || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/POSIX_V7_ILP32_OFF32 || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/POSIX_V7_ILP32_OFFBIG || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/XBS5_ILP32_OFF32 || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/XBS5_ILP32_OFFBIG || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/catchsegv || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/gdbserver || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/gencat || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/getconf || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/getent || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/iconv || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/iconvconfig || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/ldconfig || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/ldd || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/locale || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/localedef || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/makedb || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/mtrace || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/nscd || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/pcprofiledump || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/pldd || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/rpcgen || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/sln || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/sotruss || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/sprof || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/tzselect || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/xtrace || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/zdump || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/.//usr/lib/.//bin/zic || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/POSIX_V6_ILP32_OFF32 || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/POSIX_V6_ILP32_OFFBIG || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/POSIX_V7_ILP32_OFF32 || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/POSIX_V7_ILP32_OFFBIG || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/XBS5_ILP32_OFF32 || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/XBS5_ILP32_OFFBIG || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/catchsegv || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/gdbserver || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/gencat || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/getconf || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/getent || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/iconv || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/iconvconfig || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/ldconfig || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/ldd || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/locale || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/localedef || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/makedb || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/mtrace || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/nscd || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/pcprofiledump || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/pldd || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/rpcgen || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/sln || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/sotruss || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/sprof || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/tzselect || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/xtrace || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/zdump || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/soft-float//usr/lib//bin/zic || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc//usr/bin/gdbserver || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc//usr/lib//bin/gdbserver || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float//usr/bin/gdbserver || true
mips-linux-gnu-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-linux-gnu/libc/uclibc/soft-float//usr/lib//bin/gdbserver || true
popenv
#if [ "" == "x" ]; then # ========= don't compile_mingw32 303 - 397  and other fini
#fi # ========= don't compile_mingw32
echo "############################## FINISHED ##################################"
exit 0;
