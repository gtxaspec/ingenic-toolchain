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
local_path=`pwd`
export JX=-j24
exec < /dev/null

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
pushenvvar CSL_SCRIPTDIR ${local_path}/src/scripts-trunk
# pushenvvar PATH /usr/local/tools/gcc-4.7.3/bin
# pushenvvar LD_LIBRARY_PATH /usr/local/tools/gcc-4.7.3/i686-pc-linux-gnu/lib:/usr/local/tools/gcc-4.7.3/lib64:/usr/local/tools/gcc-4.7.3/lib
pushenvvar LD_LIBRARY_PATH /usr/local/lib:/usr/local/lib64
pushenvvar FLEXLM_NO_CKOUT_INSTALL_LIC ''
pushenvvar LM_APP_DISABLE_CACHE_READ ''
pushenvvar MAKEINFO 'makeinfo --css-ref=../cs.css'
pushenvvar CSL_CONFIG_SUB ${local_path}/src/config-trunk/config.sub
clean_environment

echo " ----------# task [001/281] /init/dirs"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
mkdir -p ${local_path}/obj
mkdir -p ${local_path}/install/opt/codesourcery
mkdir -p ${local_path}/pkg
mkdir -p ${local_path}/logs/data
mkdir -p ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html
mkdir -p ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf
popenv

echo " ----------# task [002/281] /init/cleanup"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/pkg/mips-2015.05-19-mips-sde-elf.src.tar.bz2 ${local_path}/pkg/mips-2015.05-19-mips-sde-elf.backup.tar.bz2
popenv

echo " ----------# task [003/281] /init/source_package/binutils"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/binutils-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/binutils-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' binutils-2015.05
popd
popenv

echo " ----------# task [004/281] /init/source_package/gcc"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/gcc-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/gcc-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' gcc-4.9-2015.05
popd
popenv

echo " ----------# task [005/281] /init/source_package/gdb"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/gdb-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/gdb-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' gdb-2015.05
popd
popenv

echo " ----------# task [006/281] /init/source_package/zlib"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/zlib-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/zlib-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' zlib-1.2.8
popd
popenv

echo " ----------# task [007/281] /init/source_package/gmp"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/gmp-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/gmp-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' gmp-2015.05
popd
popenv

echo " ----------# task [008/281] /init/source_package/mpfr"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/mpfr-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/mpfr-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' mpfr-2015.05
popd
popenv

echo " ----------# task [009/281] /init/source_package/mpc"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/mpc-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/mpc-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' mpc-2015.05
popd
popenv

echo " ----------# task [010/281] /init/source_package/cloog"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/cloog-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/cloog-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' cloog-0.18.1
popd
popenv

echo " ----------# task [011/281] /init/source_package/isl"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/isl-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/isl-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' isl-0.12.2
popd
popenv

echo " ----------# task [012/281] /init/source_package/ncurses"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/ncurses-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/ncurses-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' ncurses-5.9
popd
popenv

echo " ----------# task [013/281] /init/source_package/getting_started"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/getting_started-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/getting_started-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' getting-started-2015.05
popd
popenv

echo " ----------# task [014/281] /init/source_package/p2_installer"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/p2_installer-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/p2_installer-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' p2_installer-2015.05
popd
popenv

echo " ----------# task [015/281] /init/source_package/fbench"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/fbench-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/fbench-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' fbench-trunk
popd
popenv

echo " ----------# task [016/281] /init/source_package/sprite"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/sprite-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/sprite-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' sprite-2015.05
popd
popenv

echo " ----------# task [017/281] /init/source_package/mips_sprite"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/mips_sprite-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/mips_sprite-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' mips_sprite-2015.05
popd
popenv

echo " ----------# task [018/281] /init/source_package/eembc"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/eembc-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/eembc-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' eembc-trunk
popd
popenv

echo " ----------# task [019/281] /init/source_package/dhrystone"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/dhrystone-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/dhrystone-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' dhrystone-trunk
popd
popenv

echo " ----------# task [020/281] /init/source_package/newlib"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/newlib-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/newlib-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' newlib-2015.05
popd
popenv

echo " ----------# task [021/281] /init/source_package/cs3"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/cs3-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/cs3-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' cs3-2015.05
popd
popenv

echo " ----------# task [022/281] /init/source_package/board_support"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/board_support-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/board_support-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' board-support-trunk
popd
popenv

echo " ----------# task [023/281] /init/source_package/python"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/python-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/python-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' python-2.7.5
popd
popenv

echo " ----------# task [024/281] /init/source_package/qemu"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/qemu-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/qemu-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' qemu-2.2-2015.05
popd
popenv

echo " ----------# task [025/281] /init/source_package/csl_tests"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/csl_tests-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/csl_tests-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' csl-tests-trunk
popd
popenv

echo " ----------# task [026/281] /init/source_package/dejagnu_boards"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/dejagnu_boards-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/dejagnu_boards-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' dejagnu-boards-trunk
popd
popenv

echo " ----------# task [027/281] /init/source_package/scripts"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/scripts-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/scripts-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' scripts-trunk
popd
popenv

echo " ----------# task [028/281] /init/source_package/xfails"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/xfails-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/xfails-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' xfails-trunk
popd
popenv

echo " ----------# task [029/281] /init/source_package/portal"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/portal-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/portal-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' portal-trunk
popd
popenv

echo " ----------# task [030/281] /init/source_package/config"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/config-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/config-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' config-trunk
popd
popenv

echo " ----------# task [031/281] /init/source_package/libiconv"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/libiconv-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/libiconv-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' libiconv-1.14
popd
popenv

echo " ----------# task [032/281] /init/source_package/expat"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/expat-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/expat-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' expat-2015.05
popd
popenv

echo " ----------# task [033/281] /init/source_package/csl_docbook"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/csl_docbook-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/csl_docbook-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' csl-docbook-trunk
popd
popenv

echo " ----------# task [034/281] /init/source_package/release_notes"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/release_notes-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/release_notes-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' release-notes-trunk
popd
popenv

echo " ----------# task [035/281] /init/source_package/eclipse_common"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/eclipse_common-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/eclipse_common-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' eclipse_common-2015.05
popd
popenv

echo " ----------# task [036/281] /init/source_package/p2_repogenerator"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/p2_repogenerator-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/p2_repogenerator-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' p2_repogenerator-2015.05
popd
popenv

echo " ----------# task [037/281] /init/source_package/make"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/make-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/make-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' make-3.81
popd
popenv

echo " ----------# task [038/281] /init/source_package/coreutils"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/coreutils-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/coreutils-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' coreutils-5.94
popd
popenv

echo " ----------# task [039/281] /init/source_package/gdil"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/gdil-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/gdil-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' gdil-2015.05
popd
popenv

echo " ----------# task [040/281] /init/source_package/edge_utils"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/edge_utils-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/edge_utils-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' edge-utils-2015.05
popd
popenv

echo " ----------# task [041/281] /init/source_package/python_win32"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/python_win32-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/python_win32-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' python-win32-2.7.5
popd
popenv

echo " ----------# task [042/281] /init/source_package/glib"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/glib-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/glib-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' glib-2.30.2
popd
popenv

echo " ----------# task [043/281] /init/source_package/pixman"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/pixman-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/pixman-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' pixman-0.30.0
popd
popenv

echo " ----------# task [044/281] /init/source_package/libfdt"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/libfdt-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/libfdt-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' libfdt-2015.05
popd
popenv

echo " ----------# task [045/281] /init/source_package/msvcrt"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/msvcrt-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup/msvcrt-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' msvcrt-9.0
popd
popenv

echo " ----------# task [046/281] /init/source_package/libffi"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/libffi-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/libffi-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' libffi-3.0.13
popd
popenv

echo " ----------# task [047/281] /init/source_package/gettext"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/gettext-2015.05-19.tar.bz2
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/src
# tar cf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf/gettext-2015.05-19.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' gettext-0.18.1.1
popd
popenv

echo " ----------# task [048/281] /i686-pc-linux-gnu/host_cleanup"
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
popenv

echo " ----------# task [049/281] /i686-pc-linux-gnu/zlib_first/copy"
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
rm -rf ${local_path}/obj/zlib-first-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/zlib-1.2.8 ${local_path}/obj/zlib-first-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/zlib-first-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
popenv

echo " ----------# task [050/281] /i686-pc-linux-gnu/zlib_first/configure"
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
pushd ${local_path}/obj/zlib-first-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushenv
pushenvvar CFLAGS '-O3 -fPIC'
pushenvvar CC 'gcc  '
pushenvvar AR 'ar '
pushenvvar RANLIB 'ranlib '
./configure --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --static
popenv
popd
popenv

echo " ----------# task [051/281] /i686-pc-linux-gnu/zlib_first/build"
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
pushd ${local_path}/obj/zlib-first-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv

echo " ----------# task [052/281] /i686-pc-linux-gnu/zlib_first/install"
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
pushd ${local_path}/obj/zlib-first-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv

echo " ----------# task [053/281] /i686-pc-linux-gnu/gmp/configure"
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
rm -rf ${local_path}/obj/gmp-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/gmp-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/gmp-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
#check_mentor_trademarks ${local_path}/src/gmp-2015.05 --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=i686-pc-linux-gnu --host=i686-pc-linux-gnu --disable-nls ABI=64
check_mentor_trademarks ${local_path}/src/gmp-2015.05 --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=x86_64-pc-linux-gnu --target=x86_64-pc-linux-gnu --host=x86_64-pc-linux-gnu --disable-nls ABI=64
popd
popenv
popenv
popenv

echo " ----------# task [054/281] /i686-pc-linux-gnu/gmp/build"
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
pushd ${local_path}/obj/gmp-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [055/281] /i686-pc-linux-gnu/gmp/install"
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
pushd ${local_path}/obj/gmp-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo " ----------# task [056/281] /i686-pc-linux-gnu/gmp/postinstall"
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
pushd ${local_path}/obj/gmp-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo " ----------# task [057/281] /i686-pc-linux-gnu/mpfr/configure"
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
rm -rf ${local_path}/obj/mpfr-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/mpfr-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/mpfr-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/mpfr-2015.05 --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls --with-gmp=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo " ----------# task [058/281] /i686-pc-linux-gnu/mpfr/build"
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
pushd ${local_path}/obj/mpfr-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [059/281] /i686-pc-linux-gnu/mpfr/install"
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
pushd ${local_path}/obj/mpfr-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo " ----------# task [060/281] /i686-pc-linux-gnu/mpfr/postinstall"
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
pushd ${local_path}/obj/mpfr-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo " ----------# task [061/281] /i686-pc-linux-gnu/mpc/configure"
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
rm -rf ${local_path}/obj/mpc-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/mpc-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/mpc-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/mpc-2015.05 --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls --with-gmp=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo " ----------# task [062/281] /i686-pc-linux-gnu/mpc/build"
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
pushd ${local_path}/obj/mpc-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [063/281] /i686-pc-linux-gnu/mpc/install"
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
pushd ${local_path}/obj/mpc-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo " ----------# task [064/281] /i686-pc-linux-gnu/mpc/postinstall"
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
pushd ${local_path}/obj/mpc-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo " ----------# task [065/281] /i686-pc-linux-gnu/isl/configure"
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
rm -rf ${local_path}/obj/isl-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/isl-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/isl-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/src/isl-0.12.2
autoreconf -f -i
popd
check_mentor_trademarks ${local_path}/src/isl-0.12.2 --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls --with-gmp-prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo " ----------# task [066/281] /i686-pc-linux-gnu/isl/build"
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
pushd ${local_path}/obj/isl-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [067/281] /i686-pc-linux-gnu/isl/install"
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
pushd ${local_path}/obj/isl-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo " ----------# task [068/281] /i686-pc-linux-gnu/isl/postinstall"
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
pushd ${local_path}/obj/isl-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo " ----------# task [069/281] /i686-pc-linux-gnu/cloog/configure"
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
rm -rf ${local_path}/obj/cloog-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/cloog-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/cloog-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/cloog-0.18.1 --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls --with-isl=system --with-isl-prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-gmp-prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo " ----------# task [070/281] /i686-pc-linux-gnu/cloog/build"
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
pushd ${local_path}/obj/cloog-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [071/281] /i686-pc-linux-gnu/cloog/install"
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
pushd ${local_path}/obj/cloog-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo " ----------# task [072/281] /i686-pc-linux-gnu/cloog/postinstall"
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
pushd ${local_path}/obj/cloog-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo " ----------# task [073/281] /i686-pc-linux-gnu/toolchain/binutils/copy"
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
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf ${local_path}/obj/binutils-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/binutils-2015.05 ${local_path}/obj/binutils-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/binutils-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
touch ${local_path}/obj/binutils-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv

echo " ----------# task [074/281] /i686-pc-linux-gnu/toolchain/binutils/configure"
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
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/obj/binutils-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu --prefix=${local_path}/install/opt/codesourcery --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-gdb --disable-libdecnumber --disable-readline --disable-sim '--with-pkgversion=Ingenic 2015.05' --with-bugurl=https://ingenic.com --disable-nls --with-sysroot=/opt/codesourcery/mips-sde-elf --enable-poison-system-directories --enable-plugins
popd
popenv
popenv
popenv

echo " ----------# task [075/281] /i686-pc-linux-gnu/toolchain/binutils/libiberty"
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
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX} all-libiberty
popd
copy_dir_clean ${local_path}/src/binutils-2015.05/include ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/include
chmod -R u+w ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/include
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib
cp ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/libiberty/libiberty.a ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib
popenv
popenv
popenv

echo " ----------# task [076/281] /i686-pc-linux-gnu/toolchain/binutils/build"
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
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [077/281] /i686-pc-linux-gnu/toolchain/binutils/install"
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
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=${local_path}/install/opt/codesourcery/share
popd
popenv
popenv
popenv

echo " ----------# task [078/281] /i686-pc-linux-gnu/toolchain/binutils/postinstall"
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
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/install/opt/codesourcery
popd
pushd ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=${local_path}/install/opt/codesourcery/share install-html
popd
pushd ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=${local_path}/install/opt/codesourcery/share install-pdf
popd
cp ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/bfd/.libs/libbfd.a ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib
cp ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/bfd/bfd.h ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/include
cp ${local_path}/src/binutils-2015.05/bfd/elf-bfd.h ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/include
cp ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/opcodes/.libs/libopcodes.a ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/binutils
rsync -a ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/binutils/bfdtest1 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/binutils/
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/binutils
rsync -a ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/binutils/bfdtest2 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/binutils/
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/ld/libldtestplug.la ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/ld/libldtestplug_la-testplug.lo ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/ld/libldtestplug_la-testplug.o ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/ld/libtool ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a ${local_path}/obj/binutils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/ld/.libs ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/configure.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/etc/configure.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/configure.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly configure
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/standards.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/etc/standards.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/standards.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly standards
rmdir ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/etc
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/bfd.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/bfd.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/bfd.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly bfd
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libiberty.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libiberty.pdf
rm -f ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-ld.bfd
rm -f ${local_path}/install/opt/codesourcery/bin/ld.bfd
rm -f ${local_path}/install/opt/codesourcery/mips-sde-elf/bin/ld.bfd
popenv
popenv
popenv

echo " ----------# task [079/281] /i686-pc-linux-gnu/toolchain/gcc_first/configure"
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
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
rm -rf ${local_path}/obj/gcc-first-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/gcc-first-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/gcc-first-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/gcc-4.9-2015.05 --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu --target=mips-sde-elf --enable-threads --disable-libmudflap --disable-libssp --disable-libstdcxx-pch --with-arch-32=mips32r2 --with-arch-64=mips64r2 --disable-threads --enable-sgxxlite-sde-multilibs --with-gnu-as --with-gnu-ld '--with-specs=%{save-temps: -fverbose-asm} -D__CS_SOURCERYGXX_MAJ__=2015 -D__CS_SOURCERYGXX_MIN__=5 -D__CS_SOURCERYGXX_REV__=19' --enable-languages=c,c++ --disable-shared --enable-lto --with-newlib '--with-pkgversion=Ingenic 2015.05' --with-bugurl=https://ingenic.com --disable-nls --prefix=${local_path}/install/opt/codesourcery --disable-shared --disable-threads --disable-libssp --disable-libgomp --without-headers --with-newlib --disable-decimal-float --disable-libffi --disable-libquadmath --disable-libitm --disable-libatomic --enable-languages=c '' --with-sysroot=/opt/codesourcery/mips-sde-elf --with-build-sysroot=${local_path}/install/opt/codesourcery/mips-sde-elf --with-gmp=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpc=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-isl=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-cloog=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-libgomp --disable-libitm --disable-libatomic --disable-libssp --enable-poison-system-directories --with-python-dir=mips-sde-elf/share/gdb/python --with-build-time-tools=${local_path}/install/opt/codesourcery/mips-sde-elf/bin --with-build-time-tools=${local_path}/install/opt/codesourcery/mips-sde-elf/bin SED=sed
popd
popenv
popenv

echo " ----------# task [080/281] /i686-pc-linux-gnu/toolchain/gcc_first/build"
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
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
pushd ${local_path}/obj/gcc-first-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX} LDFLAGS_FOR_TARGET=--sysroot=${local_path}/install/opt/codesourcery/mips-sde-elf CPPFLAGS_FOR_TARGET=--sysroot=${local_path}/install/opt/codesourcery/mips-sde-elf build_tooldir=${local_path}/install/opt/codesourcery/mips-sde-elf
popd
popenv
popenv

echo " ----------# task [081/281] /i686-pc-linux-gnu/toolchain/gcc_first/install"
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
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
pushd ${local_path}/obj/gcc-first-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man install
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man install-html
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man install-pdf
popd
popenv
popenv

echo " ----------# task [082/281] /i686-pc-linux-gnu/toolchain/gcc_first/postinstall"
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
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
pushd ${local_path}/install/opt/codesourcery
rmdir include
popd
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/gcc/multilib_list.txt
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/gcc
cat > ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/gcc/multilib_list.txt <<'EOF0'
.;base;MIPS32 revision 2 - Big-Endian, O32
el;base;MIPS32 revision 2 - Little-Endian, O32
mips16;base;MIPS32 revision 2 - Big-Endian, O32, mips16
sof;base;MIPS32 revision 2 - Big-Endian, Soft-Float, O32
mips16/sof;base;MIPS32 revision 2 - Big-Endian, O32, mips16, Soft-Float
el/mips16;base;MIPS32 revision 2 - Little-Endian, O32, mips16
el/sof;base;MIPS32 revision 2 - Little-Endian, O32, Soft-Float
el/mips16/sof;base;MIPS32 revision 2 - Little-Endian, O32, mips16, Soft-Float
nan2008;base;MIPS32 revision 2 - Big-Endian, 2008 NaN, O32
el/nan2008;base;MIPS32 revision 2 - Little-Endian, 2008 NaN, O32
el/micromips/sof;base;MIPS32 revision 2 - Little-Endian, O32, micromips, Soft-Float
64;base;MIPS64 revision 2 - Big Endian, N64
sof/64;base;MIPS64 revision 2 - Big Endian, N64, Soft-Float
el/64;base;MIPS64 revision 2 - Little Endian, N64
el/sof/64;base;MIPS64 revision 2 - Little Endian, N64, Soft-Float
EOF0
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gccinstall ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gcc/gccinstall.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/gccinstall.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly gccinstall
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gccint ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gcc/gccint.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/gccint.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly gccint
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/cppinternals ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gcc/cppinternals.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/cppinternals.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly cppinternals
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libiberty.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libiberty.pdf
popenv
popenv

echo " ----------# task [083/281] /i686-pc-linux-gnu/toolchain/newlib/gcc/configure"
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
pushenvvar CC_FOR_TARGET mips-sde-elf-gcc
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
rm -rf ${local_path}/obj/newlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/newlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/newlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/newlib-2015.05 --prefix=${local_path}/install/opt/codesourcery --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --enable-newlib-io-long-long --enable-newlib-register-fini --disable-newlib-multithread --enable-libgloss --disable-newlib-supplied-syscalls --disable-nls
popd
popenv
popenv
popenv

echo " ----------# task [084/281] /i686-pc-linux-gnu/toolchain/newlib/gcc/build"
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
pushenvvar CC_FOR_TARGET mips-sde-elf-gcc
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
pushd ${local_path}/obj/newlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [085/281] /i686-pc-linux-gnu/toolchain/newlib/gcc/install"
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
pushenvvar CC_FOR_TARGET mips-sde-elf-gcc
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
pushd ${local_path}/obj/newlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=${local_path}/install/opt/codesourcery/share
popd
popenv
popenv
popenv

echo " ----------# task [086/281] /i686-pc-linux-gnu/toolchain/newlib/gcc/postinstall"
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
pushenvvar CC_FOR_TARGET mips-sde-elf-gcc
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
pushd ${local_path}/obj/newlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make pdf
mkdir -p ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf
cp ${local_path}/obj/newlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libc/libc.pdf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libc.pdf
mkdir -p ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf
cp ${local_path}/obj/newlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libm/libm.pdf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libm.pdf
make html
mkdir -p ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html
copy_dir ${local_path}/obj/newlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libc/libc.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libc
mkdir -p ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html
copy_dir ${local_path}/obj/newlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libm/libm.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libm
popd
popenv
popenv
popenv

echo " ----------# task [087/281] /i686-pc-linux-gnu/toolchain/gcc_final/configure"
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
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
rm -f ${local_path}/install/opt/codesourcery/mips-sde-elf/usr
ln -s . ${local_path}/install/opt/codesourcery/mips-sde-elf/usr
rm -rf ${local_path}/obj/gcc-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/gcc-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/gcc-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/gcc-4.9-2015.05 --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu --target=mips-sde-elf --enable-threads --disable-libmudflap --disable-libssp --disable-libstdcxx-pch --with-arch-32=mips32r2 --with-arch-64=mips64r2 --disable-threads --enable-sgxxlite-sde-multilibs --with-gnu-as --with-gnu-ld '--with-specs=%{save-temps: -fverbose-asm} -D__CS_SOURCERYGXX_MAJ__=2015 -D__CS_SOURCERYGXX_MIN__=5 -D__CS_SOURCERYGXX_REV__=19' --enable-languages=c,c++ --disable-shared --enable-lto --with-newlib '--with-pkgversion=Ingenic 2015.05' --with-bugurl=https://ingenic.com --disable-nls --prefix=${local_path}/install/opt/codesourcery --with-headers=yes --with-sysroot=/opt/codesourcery/mips-sde-elf --with-build-sysroot=${local_path}/install/opt/codesourcery/mips-sde-elf --with-gmp=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpc=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-isl=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-cloog=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-libgomp --disable-libitm --disable-libatomic --disable-libssp --enable-poison-system-directories --with-python-dir=mips-sde-elf/share/gdb/python --with-build-time-tools=${local_path}/install/opt/codesourcery/mips-sde-elf/bin --with-build-time-tools=${local_path}/install/opt/codesourcery/mips-sde-elf/bin SED=sed
popd
popenv
popenv

echo " ----------# task [088/281] /i686-pc-linux-gnu/toolchain/gcc_final/build"
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
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
rm -f ${local_path}/install/opt/codesourcery/mips-sde-elf/usr
ln -s . ${local_path}/install/opt/codesourcery/mips-sde-elf/usr
pushd ${local_path}/obj/gcc-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX} LDFLAGS_FOR_TARGET=--sysroot=${local_path}/install/opt/codesourcery/mips-sde-elf CPPFLAGS_FOR_TARGET=--sysroot=${local_path}/install/opt/codesourcery/mips-sde-elf build_tooldir=${local_path}/install/opt/codesourcery/mips-sde-elf
popd
popenv
popenv

echo " ----------# task [089/281] /i686-pc-linux-gnu/toolchain/gcc_final/install"
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
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
rm -f ${local_path}/install/opt/codesourcery/mips-sde-elf/usr
ln -s . ${local_path}/install/opt/codesourcery/mips-sde-elf/usr
pushd ${local_path}/obj/gcc-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man install
#make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man install-html
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man install-pdf
popd
popenv
popenv


echo " ----------# task [090/281] /i686-pc-linux-gnu/toolchain/gcc_final/postinstall"
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
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
pushd ${local_path}/install/opt/codesourcery
rmdir include
popd
rm -f ${local_path}/install/opt/codesourcery/mips-sde-elf/usr
rm -f ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/gcc/multilib_list.txt
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/gcc
cat > ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/gcc/multilib_list.txt <<'EOF0'
.;base;MIPS32 revision 2 - Big-Endian, O32
el;base;MIPS32 revision 2 - Little-Endian, O32
mips16;base;MIPS32 revision 2 - Big-Endian, O32, mips16
sof;base;MIPS32 revision 2 - Big-Endian, Soft-Float, O32
mips16/sof;base;MIPS32 revision 2 - Big-Endian, O32, mips16, Soft-Float
el/mips16;base;MIPS32 revision 2 - Little-Endian, O32, mips16
el/sof;base;MIPS32 revision 2 - Little-Endian, O32, Soft-Float
el/mips16/sof;base;MIPS32 revision 2 - Little-Endian, O32, mips16, Soft-Float
nan2008;base;MIPS32 revision 2 - Big-Endian, 2008 NaN, O32
el/nan2008;base;MIPS32 revision 2 - Little-Endian, 2008 NaN, O32
el/micromips/sof;base;MIPS32 revision 2 - Little-Endian, O32, micromips, Soft-Float
64;base;MIPS64 revision 2 - Big Endian, N64
sof/64;base;MIPS64 revision 2 - Big Endian, N64, Soft-Float
el/64;base;MIPS64 revision 2 - Little Endian, N64
el/sof/64;base;MIPS64 revision 2 - Little Endian, N64, Soft-Float
EOF0
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gccinstall ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gcc/gccinstall.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/gccinstall.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly gccinstall
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gccint ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gcc/gccint.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/gccint.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly gccint
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/cppinternals ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gcc/cppinternals.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/cppinternals.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly cppinternals
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libiberty.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libiberty.pdf
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/.//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64//libstdc++.a-gdb.py
rm -rf ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64//libstdc++.a-gdb.py
popenv
popenv

echo " ----------# task [091/281] /i686-pc-linux-gnu/toolchain/zlib/0/copy"
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
rm -rf ${local_path}/obj/zlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/zlib-1.2.8 ${local_path}/obj/zlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/zlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
popenv

echo " ----------# task [092/281] /i686-pc-linux-gnu/toolchain/zlib/0/configure"
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
pushd ${local_path}/obj/zlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushenv
pushenvvar CFLAGS '-O3 -fPIC'
pushenvvar CC 'gcc  '
pushenvvar AR 'ar '
pushenvvar RANLIB 'ranlib '
./configure --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --static
popenv
popd
popenv

echo " ----------# task [093/281] /i686-pc-linux-gnu/toolchain/zlib/0/build"
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
pushd ${local_path}/obj/zlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv

echo " ----------# task [094/281] /i686-pc-linux-gnu/toolchain/zlib/0/install"
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
pushd ${local_path}/obj/zlib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv

echo " ----------# task [095/281] /i686-pc-linux-gnu/toolchain/python/0/copy"
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
rm -rf ${local_path}/obj/python-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/python-2.7.5 ${local_path}/obj/python-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/python-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
touch ${local_path}/obj/python-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv

echo " ----------# task [096/281] /i686-pc-linux-gnu/toolchain/python/0/configure"
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
rm -rf ${local_path}/obj/python-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/python-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/python-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/obj/python-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --enable-shared --disable-nls
popd
popenv
popenv
popenv

echo " ----------# task [097/281] /i686-pc-linux-gnu/toolchain/python/0/build"
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
pushd ${local_path}/obj/python-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [098/281] /i686-pc-linux-gnu/toolchain/python/0/install"
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
pushd ${local_path}/obj/python-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo " ----------# task [099/281] /i686-pc-linux-gnu/toolchain/python/0/postinstall"
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
mkdir -p ${local_path}/install/opt/codesourcery/lib
mkdir -p ${local_path}/install/opt/codesourcery/lib/python2.7
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/cmath.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_heapq.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/math.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_functools.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_lsprof.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/grp.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_testcapi.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/syslog.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/time.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_elementtree.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_collections.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/select.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/ossaudiodev.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/resource.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_codecs_tw.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_multiprocessing.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_json.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/datetime.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_codecs_hk.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_bisect.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/crypt.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/Python-2.7.5-py2.7.egg-info ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_locale.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_struct.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_codecs_jp.so ${local_path}/install/opt/codesourcery/lib/python2.7/
#install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/imageop.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/future_builtins.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_codecs_cn.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/zlib.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/termios.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_io.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/array.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_multibytecodec.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_socket.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_codecs_kr.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/fcntl.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/unicodedata.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_random.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/cStringIO.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_ctypes.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/pyexpat.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/linuxaudiodev.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_hotshot.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/audioop.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/binascii.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/spwd.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_csv.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/mmap.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/operator.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/itertools.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/nis.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/parser.so ${local_path}/install/opt/codesourcery/lib/python2.7/
#install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/dl.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/cPickle.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_ctypes_test.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/strop.so ${local_path}/install/opt/codesourcery/lib/python2.7/
install -m 755 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_codecs_iso2022.so ${local_path}/install/opt/codesourcery/lib/python2.7/
pushd ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7
find . -name '*.py*' > ${local_path}/install/opt/codesourcery/lib/python27.zip.files
zip ${local_path}/install/opt/codesourcery/lib/python27.zip -@ < ${local_path}/install/opt/codesourcery/lib/python27.zip.files
rm ${local_path}/install/opt/codesourcery/lib/python27.zip.files
popd
install -m 644 ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/libpython2.7.so.1.0 ${local_path}/install/opt/codesourcery/lib/
popenv
popenv
popenv

echo " ----------# task [100/281] /i686-pc-linux-gnu/toolchain/expat/0/configure"
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
rm -rf ${local_path}/obj/expat-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/expat-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/expat-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/expat-2015.05 --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls
popd
popenv
popenv
popenv

echo " ----------# task [101/281] /i686-pc-linux-gnu/toolchain/expat/0/build"
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
pushd ${local_path}/obj/expat-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [102/281] /i686-pc-linux-gnu/toolchain/expat/0/install"
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
pushd ${local_path}/obj/expat-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo " ----------# task [103/281] /i686-pc-linux-gnu/toolchain/ncurses/0/configure"
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
rm -rf ${local_path}/obj/ncurses-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/ncurses-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/ncurses-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/ncurses-5.9 --prefix=/usr --disable-shared --without-debug --without-cxx --without-ada --disable-nls --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu
popd
popenv
popenv
popenv

echo " ----------# task [104/281] /i686-pc-linux-gnu/toolchain/ncurses/0/build"
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
pushd ${local_path}/obj/ncurses-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make -j1
popd
popenv
popenv
popenv

echo " ----------# task [105/281] /i686-pc-linux-gnu/toolchain/ncurses/0/install"
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
pushd ${local_path}/obj/ncurses-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install DESTDIR=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu
popd
popenv
popenv
popenv

echo " ----------# task [106/281] /i686-pc-linux-gnu/toolchain/gdb/0/copy"
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
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS '-L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib -Wl,-rpath,'\''\\\$$\$$\\\$$\$$ORIGIN'\''/../lib'
prepend_path LD_LIBRARY_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf ${local_path}/obj/gdb-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/gdb-2015.05 ${local_path}/obj/gdb-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/gdb-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
touch ${local_path}/obj/gdb-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv


echo " ----------# task [107/281] /i686-pc-linux-gnu/toolchain/gdb/0/configure"
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
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS '-L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib -Wl,-rpath,'\''\\\$$\$$\\\$$\$$ORIGIN'\''/../lib'
prepend_path LD_LIBRARY_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf ${local_path}/obj/gdb-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/gdb-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/gdb-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/obj/gdb-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu --prefix=${local_path}/install/opt/codesourcery --build=i686-pc-linux-gnu  --target=mips-sde-elf --host=i686-pc-linux-gnu --enable-sim --disable-binutils --disable-elfcpp --disable-gas --disable-gold --disable-gprof --disable-ld '--with-pkgversion=Ingenic 2015.05' --with-bugurl=https://ingenic.com --disable-libmcheck --disable-nls --with-libexpat-prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-python=${local_path}/obj/gdb-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/csl-python-config.sh --with-system-gdbinit=/opt/codesourcery/i686-pc-linux-gnu/mips-sde-elf/lib/gdbinit '--with-gdb-datadir='\''${prefix}'\''/mips-sde-elf/share/gdb'
popd
popenv
popenv
popenv

echo " ----------# task [108/281] /i686-pc-linux-gnu/toolchain/gdb/0/build"
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
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS '-L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib -Wl,-rpath,'\''\\\$$\$$\\\$$\$$ORIGIN'\''/../lib'
prepend_path LD_LIBRARY_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
cat > ${local_path}/obj/gdb-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/csl-python-config.sh <<'EOF0'
#!/bin/bash

# This script is auto-generated by modules/gdb:mod_configure_opts_gdb.
# gdb/configure tries to detect the python version by running python-config.py,
# using the python binary passed as an argument to --with-python. This doesn't
# work for cross tools, as the appropriate python binary cannot be run
# on the build server. It also doesn't support our host-libs directory layout.
# Therefore instead of passing a python binary to --with-python, we pass this
# script which provides output suitable for our environment.

case "$2" in
  "--ldflags")
    echo "-Lreplacelocalpath/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib -lpython2.7"
    ;;
  "--includes")
    echo "-Ireplacelocalpath/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include/python2.7"
    ;;
  "--exec-prefix")
    echo "/opt/codesourcery"
    ;;
  *)
    echo "Unknown option \"$2\". Accepted options are:"
    echo "  --ldflags"
    echo "  --includes"
    echo "  --exec-prefix"
    ;;
esac
EOF0
sed -i "s|replacelocalpath|${local_path}|g" ${local_path}/obj/gdb-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/csl-python-config.sh
chmod +x ${local_path}/obj/gdb-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/csl-python-config.sh
pushd ${local_path}/obj/gdb-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [109/281] /i686-pc-linux-gnu/toolchain/gdb/0/install"
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
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS '-L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib -Wl,-rpath,'\''\\\$$\$$\\\$$\$$ORIGIN'\''/../lib'
prepend_path LD_LIBRARY_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/gdb-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=${local_path}/install/opt/codesourcery/share
popd
popenv
popenv
popenv

echo " ----------# task [110/281] /i686-pc-linux-gnu/toolchain/gdb/0/postinstall"
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
pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS '-L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib -Wl,-rpath,'\''\\\$$\$$\\\$$\$$ORIGIN'\''/../lib'
prepend_path LD_LIBRARY_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/gdb-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=${local_path}/install/opt/codesourcery/share install-html
make prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=${local_path}/install/opt/codesourcery/share install-pdf
popd
mkdir -p ${local_path}/install/opt/codesourcery/i686-pc-linux-gnu/mips-sde-elf/lib
rm -f ${local_path}/install/opt/codesourcery/i686-pc-linux-gnu/mips-sde-elf/lib/gdbinit
cat > ${local_path}/install/opt/codesourcery/i686-pc-linux-gnu/mips-sde-elf/lib/gdbinit <<'EOF0'
python
class UseOtherQemu(gdb.Function):
  def __init__(self):
    super(UseOtherQemu, self).__init__("cs_use_other_qemu")
  def invoke(self):
    return not gdb.is_big_endian()
UseOtherQemu()
end

define target qemu 
  if $cs_use_other_qemu()
    if $argc == 0
      target remote | mips-sde-elf-qemu-system-el -S -p stdio --semihosting --serial null --monitor null -kernel /dev/null -M mipssim --cpu 24Kf
    else
      if $argc == 1
        target remote | mips-sde-elf-qemu-system-el -S -p stdio --semihosting --serial null --monitor null -kernel /dev/null -M mipssim --cpu $arg0
      else
        echo Too many arguments.\n
      end
    end
  else
  if $argc == 0
    target remote | mips-sde-elf-qemu-system -S -p stdio --semihosting --serial null --monitor null -kernel /dev/null -M mipssim --cpu 24Kf
  else
    if $argc == 1
      target remote | mips-sde-elf-qemu-system -S -p stdio --semihosting --serial null --monitor null -kernel /dev/null -M mipssim --cpu $arg0
    else
      echo Too many arguments.\n
    end
  end
  end
end
document target qemu
Use the QEMU simulator to run the program being debugged.
You can optionally provide an argument that specifies the CPU QEMU
should emulate.
end
EOF0
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/annotate ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/annotate.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/annotate.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly annotate
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gdbint ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gdbint.pdf
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/stabs ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/stabs.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/stabs.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly stabs
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/configure.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/etc/configure.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/configure.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly configure
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/standards.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/etc/standards.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/standards.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly standards
rmdir ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/etc
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/bfd.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/bfd.pdf
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/bfd.info
install-info --infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly bfd
rm -f ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libiberty.html ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libiberty.pdf
pushd ${local_path}/install/opt/codesourcery
mkdir -p i686-pc-linux-gnu/mips-sde-elf/include/
mv include/gdb i686-pc-linux-gnu/mips-sde-elf/include
rmdir include
popd
rm -rf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/gdb
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/gdb
cp -a ${local_path}/obj/gdb-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/gdb/data-directory/python ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/gdb/
popenv
popenv
popenv

# echo " ----------# task [111/281] /i686-pc-linux-gnu/toolchain/cs3/gcc/configure"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenvvar CC mips-sde-elf-gcc
# pushenvvar CXX mips-sde-elf-g++
# pushenvvar LD mips-sde-elf-ld
# pushenvvar AR mips-sde-elf-ar
# pushenvvar RANLIB mips-sde-elf-ranlib
# pushenv
# pushenvvar CC mips-sde-elf-gcc
# rm -rf ${local_path}/obj/cs3-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# mkdir -p ${local_path}/obj/cs3-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# pushd ${local_path}/obj/cs3-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# check_mentor_trademarks ${local_path}/src/cs3-2015.05 --prefix=${local_path}/install/opt/codesourcery --build=i686-pc-linux-gnu --target=mips-sde-elf --host=mips-sde-elf '--with-pkgversion=Ingenic 2015.05' --with-bugurl=https://ingenic.com --disable-nls --with-intermediate-dir=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/cs3 '--with-configs=public-*'
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [112/281] /i686-pc-linux-gnu/toolchain/cs3/gcc/build"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenvvar CC mips-sde-elf-gcc
# pushenvvar CXX mips-sde-elf-g++
# pushenvvar LD mips-sde-elf-ld
# pushenvvar AR mips-sde-elf-ar
# pushenvvar RANLIB mips-sde-elf-ranlib
# pushenv
# pushenvvar CC mips-sde-elf-gcc
# pushd ${local_path}/obj/cs3-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make ${JX}
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [113/281] /i686-pc-linux-gnu/toolchain/cs3/gcc/install"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenvvar CC mips-sde-elf-gcc
# pushenvvar CXX mips-sde-elf-g++
# pushenvvar LD mips-sde-elf-ld
# pushenvvar AR mips-sde-elf-ar
# pushenvvar RANLIB mips-sde-elf-ranlib
# pushenv
# pushenvvar CC mips-sde-elf-gcc
# pushd ${local_path}/obj/cs3-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make install prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=${local_path}/install/opt/codesourcery/share
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [114/281] /i686-pc-linux-gnu/getting_started/copy"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# rm -rf ${local_path}/obj/getting_started-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# copy_dir_clean ${local_path}/src/getting-started-2015.05 ${local_path}/obj/getting_started-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# chmod -R u+w ${local_path}/obj/getting_started-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# touch ${local_path}/obj/getting_started-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
# mkdir -p ${local_path}/obj/getting_started-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/sgxx/2015.05
# copy_dir_clean ${local_path}/src/release-notes-trunk ${local_path}/obj/getting_started-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/release-notes
# cat > ${local_path}/obj/getting_started-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/sgxx/2015.05/mips-sde-elf-lite-libs.xml <<'EOF0'
# <!DOCTYPE getting-started SYSTEM "getting-started.dtd">
# <!-- automatically generated, do not edit -->
# <section id="sec-multilibs">
#   <title>Library Configurations</title>
#   <para>
#     &csl_prod; for &csl_target_name; includes the following library
#     configuration.
#   </para>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS32 revision 2 - Big-Endian, O32</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry>default</entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>./</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS32 revision 2 - Little-Endian, O32</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-EL</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>el/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS32 revision 2 - Big-Endian, O32, mips16</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-mips16</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>mips16/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS32 revision 2 - Big-Endian, Soft-Float, O32</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-msoft-float</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>sof/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS32 revision 2 - Big-Endian, O32, mips16, Soft-Float</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-mips16 -msoft-float</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>mips16/sof/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS32 revision 2 - Little-Endian, O32, mips16</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-EL -mips16</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>el/mips16/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS32 revision 2 - Little-Endian, O32, Soft-Float</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-EL -msoft-float</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>el/sof/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS32 revision 2 - Little-Endian, O32, mips16, Soft-Float</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-EL -mips16 -msoft-float</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>el/mips16/sof/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS32 revision 2 - Big-Endian, 2008 NaN, O32</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-mnan=2008</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>nan2008/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS32 revision 2 - Little-Endian, 2008 NaN, O32</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-EL -mnan=2008</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>el/nan2008/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS32 revision 2 - Little-Endian, O32, micromips, Soft-Float</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-EL -mmicromips -msoft-float</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>el/micromips/sof/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS64 revision 2 - Big Endian, N64</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-mabi=64</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>64/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS64 revision 2 - Big Endian, N64, Soft-Float</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-msoft-float -mabi=64</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>sof/64/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS64 revision 2 - Little Endian, N64</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-EL -mabi=64</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>el/64/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <informaltable>
#     <?dbfo keep-together="always" ?>
#     <?dbfo table-width="100%" ?>
#     <?dbhtml table-width="100%" ?>
#     <tgroup cols="2" align="left">
#       <colspec colname="c1" colwidth="1*" />
#       <colspec colname="c2" colwidth="2*" />
#       <thead>
# 	<row>
# 	  <entry namest="c1" nameend="c2">MIPS64 revision 2 - Little Endian, N64, Soft-Float</entry>
# 	</row>
#       </thead>
#       <tbody>
# 	<row>
# 	  <entry>Command-line option(s):</entry>
# 	  <entry><option>-EL -msoft-float -mabi=64</option></entry>
# 	</row>
# 	<row>
# 	  <entry>Library subdirectory:</entry>
# 	  <entry><filename>el/sof/64/</filename></entry>
# 	</row>
#       </tbody>
#     </tgroup>
#   </informaltable>
#   <xi:include href="${local_path}/obj/getting_started-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/library-intro.xml" xpointer="xpointer(*/*)"/>
# </section>
# EOF0
# cat > ${local_path}/obj/getting_started-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/sgxx/2015.05/mips-sde-elf-lite.dtd <<'EOF0'
# <!-- automatically generated, do not edit -->
# <!ENTITY csl_multilib_sec "<xi:include href='${local_path}/obj/getting_started-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/sgxx/2015.05/mips-sde-elf-lite-libs.xml'/>">
# <!ENTITY csl_subpackage_sec "">
# <!ENTITY csl_binutils_component_license "&csl_gpl3.0_license;">
# <!ENTITY csl_binutils_component_version "2.24.51.20140217">
# <!ENTITY csl_gcc_component_license "&csl_gpl3.0_license;">
# <!ENTITY csl_gcc_component_version "4.9.2">
# <!ENTITY csl_gdb_component_license "&csl_gpl3.0_license;">
# <!ENTITY csl_gdb_component_version "7.7.50-cvs">
# <!ENTITY csl_sprite_component_license "&csl_cs_license;">
# <!ENTITY csl_mips_sprite_component_license "&csl_cs_license;">
# <!ENTITY csl_newlib_component_license "&csl_newlib_license;">
# <!ENTITY csl_newlib_component_version "2.1.0">
# <!ENTITY csl_cs3_component_license "&csl_cs_license;">
# <!ENTITY csl_python_component_license "&csl_python_license;">
# <!ENTITY csl_qemu_component_license "&csl_gpl2.0_license;">
# <!ENTITY csl_qemu_component_version "2.2.0">
# <!ENTITY csl_make_component_license "&csl_gpl2.0_license;">
# <!ENTITY csl_coreutils_component_license "&csl_gpl2.0_license;">
# <!ENTITY csl_python_win32_component_license "&csl_python_license;">
# EOF0
# popenv
# popenv
# popenv

# echo " ----------# task [115/281] /i686-pc-linux-gnu/getting_started/configure"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# rm -rf ${local_path}/obj/getting_started-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# mkdir -p ${local_path}/obj/getting_started-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# pushd ${local_path}/obj/getting_started-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# check_mentor_trademarks ${local_path}/obj/getting_started-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu --prefix=${local_path}/install/opt/codesourcery --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls --with-release-config=sgxx/2015.05/mips-sde-elf-lite '--with-components=binutils gcc gdb zlib gmp mpfr mpc cloog isl ncurses getting_started p2_installer fbench sprite mips_sprite eembc dhrystone newlib cs3 board_support python qemu branding contents comparison csl_tests dejagnu_boards scripts xfails portal harness config libiconv expat csl_docbook release_notes eclipse_common p2_repogenerator make coreutils gdil edge_utils newlib_common python_win32 glib pixman libfdt msvcrt python_windows libffi gettext no-accel_newlib no-alf no-alp_examples no-android no-antlr no-apm_examples no-argp no-arm_stub no-ashling no-atlas_install no-bdi_setup no-boost no-brewmp no-ccs no-ccs_mdi_library no-cctools no-cfpe_stub no-cgen no-clang no-cml no-codewarrior_plugin no-com_codesourcery_util no-compiler_rt no-connexion no-coremark no-cs no-csibe no-csldoc no-cslibc_manual no-cuda no-cula_install no-cxxabi no-cygwin_wrapper no-dbgrtool no-dinkum no-dltk no-eclipse no-eclipse_cdt no-eclipse_patches no-eclipse_plugin no-eclipse_product no-eclipse_zip no-eembc2 no-eembc2_qc no-elf2flt no-emf no-fftw no-fftw_source no-flexlm_utils no-glibc no-glibc_localedef no-glibc_ports no-harness_test no-hexagon_codec no-hexagon_dinkum no-ide no-installanywhere no-intel_sprite no-json_c no-kinetis_examples no-libcsftdi no-libcurl no-libcxx no-libcxxabi no-libedit no-libelf no-libftdi no-libusb no-libusb_win32 no-license no-license_lib no-linux no-lld no-lldb no-llvm no-lsb no-lttng_tools no-lttng_ust no-mep_cs no-mepl no-mesa no-mesp_docs no-mettools no-mgls no-mingw no-mingw64 no-mips_toolchain_manual no-mklibs no-nios2r2_simulator no-nucleus_binary_demos no-nvptxtools no-ocdremote no-omf2elf no-openposix no-openssl no-oprofile no-oprofile_plugin no-osawareness_plugin no-ph no-plex_skel no-popt no-power_sprite no-ppl no-prelink no-profiling_plugins no-python_hexagon_linux no-python_macosx no-python_win64 no-qmtest_ph no-qti_tools no-redsea no-rica_plugin no-rpm no-sgxx_application_notes no-sgxx_demos no-simdmath no-spec2000 no-spec2000_configs no-spec2006 no-spec2xxx no-stellarisware no-stm32_generate_sgxx no-stm32_stdperiph_lib no-stm32_usb_fs_device_lib no-svxx_api_reference no-svxx_benchmarks no-svxx_binary no-svxx_copy_variants no-svxx_documentation no-svxx_fftw no-svxx_source no-sysroot_utils no-sysrootinfo no-systemtap no-trace_processor no-uclibc no-uclibc_configs no-userspace_rcu no-util_linux no-verifone_plugin no-vsi no-w32api no-windows_script_wrapper no-xlp_mdi no-xulrunner no-yocto_layer' '--with-features=glibc_armhf_legacy_dyn_linker sgxx_version multilibs tarball public elf sprite mdimips sprite mdimips newlib_newlib cs3 qemu-system' '--with-hosts=i686-pc-linux-gnu i686-mingw32' --with-target-arch-name=MIPS --with-target-os-name=ELF --with-intermediate-dir=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/getting_started --with-csl-docbook=${local_path}/src/csl-docbook-trunk --with-version-string=2015.05-19 '--with-pkgversion=Ingenic 2015.05' '--with-brand=Sourcery CodeBench Lite' --with-pkg_prefix=mips '--with-xml-catalog-files=/usr/local/tools/gcc-4.7.3/share/sgml/docbook/docbook-xsl/catalog.xml /etc/xml/catalog' --with-license=lite --with-cs3=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/cs3/doc
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [116/281] /i686-pc-linux-gnu/getting_started/build"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# pushd ${local_path}/obj/getting_started-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make ${JX}
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [117/281] /i686-pc-linux-gnu/getting_started/install"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# pushd ${local_path}/obj/getting_started-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make install prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=${local_path}/install/opt/codesourcery/share docdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [118/281] /i686-pc-linux-gnu/csl_docbook"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# cp ${local_path}/src/csl-docbook-trunk/css/cs.css ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html
# rm -rf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/csl_docbook/
# mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/csl_docbook/
# cat > ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/csl_docbook//list.txt <<'EOF0'
# ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/binutils.html;Binary Utilities (HTML)
# ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/as.html;Assembler (HTML)
# ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/ld.html;Linker (HTML)
# ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gprof.html;Profiler (HTML)
# ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gcc;Compiler (HTML)
# ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/cpp;Preprocessor (HTML)
# ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gdb;Debugger (HTML)
# ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/getting-started;Getting Started Guide (HTML)
# ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libc;C Library (Newlib) (HTML)
# ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libm;Math Library (Newlib) (HTML)
# ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/cs.css;
# EOF0
# cat > ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/csl_docbook/toc.xml <<'EOF0'
# <toc label="Sourcery CodeBench for MIPS ELF">
# <topic label="Binary Utilities (HTML)">
# <topic label="Introduction" href="doc/binutils.html/index.html#Top"/><topic label="ar" href="doc/binutils.html/ar.html#ar">
# <topic label="Controlling ar on the Command Line" href="doc/binutils.html/ar-cmdline.html#ar-cmdline"/><topic label="Controlling ar with a Script" href="doc/binutils.html/ar-scripts.html#ar-scripts"/></topic><topic label="nm" href="doc/binutils.html/nm.html#nm"/><topic label="objcopy" href="doc/binutils.html/objcopy.html#objcopy"/><topic label="objdump" href="doc/binutils.html/objdump.html#objdump"/><topic label="ranlib" href="doc/binutils.html/ranlib.html#ranlib"/><topic label="size" href="doc/binutils.html/size.html#size"/><topic label="strings" href="doc/binutils.html/strings.html#strings"/><topic label="strip" href="doc/binutils.html/strip.html#strip"/><topic label="c++filt" href="doc/binutils.html/c_002b_002bfilt.html#c_002b_002bfilt"/><topic label="addr2line" href="doc/binutils.html/addr2line.html#addr2line"/><topic label="nlmconv" href="doc/binutils.html/nlmconv.html#nlmconv"/><topic label="windmc" href="doc/binutils.html/windmc.html#windmc"/><topic label="windres" href="doc/binutils.html/windres.html#windres"/><topic label="dlltool" href="doc/binutils.html/dlltool.html#dlltool">
# <topic label="The format of the dlltool .def file" href="doc/binutils.html/def-file-format.html#def-file-format"/></topic><topic label="readelf" href="doc/binutils.html/readelf.html#readelf"/><topic label="elfedit" href="doc/binutils.html/elfedit.html#elfedit"/><topic label="Common Options" href="doc/binutils.html/Common-Options.html#Common-Options"/><topic label="Selecting the Target System" href="doc/binutils.html/Selecting-the-Target-System.html#Selecting-the-Target-System">
# <topic label="Target Selection" href="doc/binutils.html/Target-Selection.html#Target-Selection"/><topic label="Architecture Selection" href="doc/binutils.html/Architecture-Selection.html#Architecture-Selection"/></topic><topic label="Reporting Bugs" href="doc/binutils.html/Reporting-Bugs.html#Reporting-Bugs">
# <topic label="Have You Found a Bug?" href="doc/binutils.html/Bug-Criteria.html#Bug-Criteria"/><topic label="How to Report Bugs" href="doc/binutils.html/Bug-Reporting.html#Bug-Reporting"/></topic><topic label="Appendix A GNU Free Documentation License" href="doc/binutils.html/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/><topic label="Binutils Index" href="doc/binutils.html/Binutils-Index.html#Binutils-Index"/><topic label="ar" href="doc/binutils.html/ar.html#ar"/><topic label="nm" href="doc/binutils.html/nm.html#nm"/><topic label="objcopy" href="doc/binutils.html/objcopy.html#objcopy"/><topic label="objdump" href="doc/binutils.html/objdump.html#objdump"/><topic label="ranlib" href="doc/binutils.html/ranlib.html#ranlib"/><topic label="size" href="doc/binutils.html/size.html#size"/><topic label="strings" href="doc/binutils.html/strings.html#strings"/><topic label="strip" href="doc/binutils.html/strip.html#strip"/><topic label="c++filt" href="doc/binutils.html/c_002b_002bfilt.html#c_002b_002bfilt"/><topic label="cxxfilt" href="doc/binutils.html/c_002b_002bfilt.html#c_002b_002bfilt"/><topic label="addr2line" href="doc/binutils.html/addr2line.html#addr2line"/><topic label="nlmconv" href="doc/binutils.html/nlmconv.html#nlmconv"/><topic label="windmc" href="doc/binutils.html/windmc.html#windmc"/><topic label="windres" href="doc/binutils.html/windres.html#windres"/><topic label="dlltool" href="doc/binutils.html/dlltool.html#dlltool"/><topic label="readelf" href="doc/binutils.html/readelf.html#readelf"/><topic label="elfedit" href="doc/binutils.html/elfedit.html#elfedit"/><topic label="Common Options" href="doc/binutils.html/Common-Options.html#Common-Options"/><topic label="Selecting the Target System" href="doc/binutils.html/Selecting-the-Target-System.html#Selecting-the-Target-System"/><topic label="Reporting Bugs" href="doc/binutils.html/Reporting-Bugs.html#Reporting-Bugs"/><topic label="GNU Free Documentation License" href="doc/binutils.html/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/><topic label="Binutils Index" href="doc/binutils.html/Binutils-Index.html#Binutils-Index"/>
# </topic>
# <topic label="Assembler (HTML)">
# <topic label="Using as" href="doc/as.html/index.html#Top"/><topic label="Overview" href="doc/as.html/Overview.html#Overview">
# <topic label="Structure of this Manual" href="doc/as.html/Manual.html#Manual"/><topic label="The GNU Assembler" href="doc/as.html/GNU-Assembler.html#GNU-Assembler"/><topic label="Object File Formats" href="doc/as.html/Object-Formats.html#Object-Formats"/><topic label="Command Line" href="doc/as.html/Command-Line.html#Command-Line"/><topic label="Input Files" href="doc/as.html/Input-Files.html#Input-Files"/><topic label="Output (Object) File" href="doc/as.html/Object.html#Object"/><topic label="Error and Warning Messages" href="doc/as.html/Errors.html#Errors"/></topic><topic label="Command-Line Options" href="doc/as.html/Invoking.html#Invoking">
# <topic label="Enable Listings: -a[cdghlns]" href="doc/as.html/a.html#a"/><topic label="--alternate" href="doc/as.html/alternate.html#alternate"/><topic label="-D" href="doc/as.html/D.html#D"/><topic label="Work Faster: -f" href="doc/as.html/f.html#f"/><topic label=".include Search Path: -I path" href="doc/as.html/I.html#I"/><topic label="Difference Tables: -K" href="doc/as.html/K.html#K"/><topic label="Include Local Symbols: -L" href="doc/as.html/L.html#L"/><topic label="Configuring listing output: --listing" href="doc/as.html/listing.html#listing"/><topic label="Assemble in MRI Compatibility Mode: -M" href="doc/as.html/M.html#M"/><topic label="Dependency Tracking: --MD" href="doc/as.html/MD.html#MD"/><topic label="Name the Object File: -o" href="doc/as.html/o.html#o"/><topic label="Join Data and Text Sections: -R" href="doc/as.html/R.html#R"/><topic label="Display Assembly Statistics: --statistics" href="doc/as.html/statistics.html#statistics"/><topic label="Compatible Output: --traditional-format" href="doc/as.html/traditional_002dformat.html#traditional_002dformat"/><topic label="Announce Version: -v" href="doc/as.html/v.html#v"/><topic label="Control Warnings: -W, --warn, --no-warn, --fatal-warnings" href="doc/as.html/W.html#W"/><topic label="Generate Object File in Spite of Errors: -Z" href="doc/as.html/Z.html#Z"/></topic><topic label="Syntax" href="doc/as.html/Syntax.html#Syntax">
# <topic label="Preprocessing" href="doc/as.html/Preprocessing.html#Preprocessing"/><topic label="Whitespace" href="doc/as.html/Whitespace.html#Whitespace"/><topic label="Comments" href="doc/as.html/Comments.html#Comments"/><topic label="Symbols" href="doc/as.html/Symbol-Intro.html#Symbol-Intro"/><topic label="Statements" href="doc/as.html/Statements.html#Statements"/><topic label="Constants" href="doc/as.html/Constants.html#Constants">
# <topic label="Character Constants" href="doc/as.html/Characters.html#Characters">
# <topic label="Strings" href="doc/as.html/Strings.html#Strings"/><topic label="Characters" href="doc/as.html/Chars.html#Chars"/></topic><topic label="Number Constants" href="doc/as.html/Numbers.html#Numbers">
# <topic label="Integers" href="doc/as.html/Integers.html#Integers"/><topic label="Bignums" href="doc/as.html/Bignums.html#Bignums"/><topic label="Flonums" href="doc/as.html/Flonums.html#Flonums"/></topic></topic></topic><topic label="Sections and Relocation" href="doc/as.html/Sections.html#Sections">
# <topic label="Background" href="doc/as.html/Secs-Background.html#Secs-Background"/><topic label="Linker Sections" href="doc/as.html/Ld-Sections.html#Ld-Sections"/><topic label="Assembler Internal Sections" href="doc/as.html/As-Sections.html#As-Sections"/><topic label="Sub-Sections" href="doc/as.html/Sub_002dSections.html#Sub_002dSections"/><topic label="bss Section" href="doc/as.html/bss.html#bss"/></topic><topic label="Symbols" href="doc/as.html/Symbols.html#Symbols">
# <topic label="Labels" href="doc/as.html/Labels.html#Labels"/><topic label="Giving Symbols Other Values" href="doc/as.html/Setting-Symbols.html#Setting-Symbols"/><topic label="Symbol Names" href="doc/as.html/Symbol-Names.html#Symbol-Names"/><topic label="The Special Dot Symbol" href="doc/as.html/Dot.html#Dot"/><topic label="Symbol Attributes" href="doc/as.html/Symbol-Attributes.html#Symbol-Attributes">
# <topic label="Value" href="doc/as.html/Symbol-Value.html#Symbol-Value"/><topic label="Type" href="doc/as.html/Symbol-Type.html#Symbol-Type"/><topic label="Symbol Attributes: a.out" href="doc/as.html/a_002eout-Symbols.html#a_002eout-Symbols">
# <topic label="Descriptor" href="doc/as.html/Symbol-Desc.html#Symbol-Desc"/><topic label="Other" href="doc/as.html/Symbol-Other.html#Symbol-Other"/></topic><topic label="Symbol Attributes for COFF" href="doc/as.html/COFF-Symbols.html#COFF-Symbols">
# <topic label="Primary Attributes" href="doc/as.html/COFF-Symbols.html#COFF-Symbols"/><topic label="Auxiliary Attributes" href="doc/as.html/COFF-Symbols.html#COFF-Symbols"/></topic><topic label="Symbol Attributes for SOM" href="doc/as.html/SOM-Symbols.html#SOM-Symbols"/></topic></topic><topic label="Expressions" href="doc/as.html/Expressions.html#Expressions">
# <topic label="Empty Expressions" href="doc/as.html/Empty-Exprs.html#Empty-Exprs"/><topic label="Integer Expressions" href="doc/as.html/Integer-Exprs.html#Integer-Exprs">
# <topic label="Arguments" href="doc/as.html/Arguments.html#Arguments"/><topic label="Operators" href="doc/as.html/Operators.html#Operators"/><topic label="Prefix Operator" href="doc/as.html/Prefix-Ops.html#Prefix-Ops"/><topic label="Infix Operators" href="doc/as.html/Infix-Ops.html#Infix-Ops"/></topic></topic><topic label="Assembler Directives" href="doc/as.html/Pseudo-Ops.html#Pseudo-Ops">
# <topic label=".abort" href="doc/as.html/Abort.html#Abort"/><topic label=".ABORT (COFF)" href="doc/as.html/ABORT-_0028COFF_0029.html#ABORT-_0028COFF_0029"/><topic label=".align abs-expr, abs-expr, abs-expr" href="doc/as.html/Align.html#Align"/><topic label=".altmacro" href="doc/as.html/Altmacro.html#Altmacro"/><topic label=".ascii &quot;string&quot;..." href="doc/as.html/Ascii.html#Ascii"/><topic label=".asciz &quot;string&quot;..." href="doc/as.html/Asciz.html#Asciz"/><topic label=".balign[wl] abs-expr, abs-expr, abs-expr" href="doc/as.html/Balign.html#Balign"/><topic label=".bundle_align_mode abs-expr" href="doc/as.html/Bundle-directives.html#Bundle-directives"/><topic label=".bundle_lock and .bundle_unlock" href="doc/as.html/Bundle-directives.html#Bundle-directives"/><topic label=".byte expressions" href="doc/as.html/Byte.html#Byte"/><topic label=".cfi_sections section_list" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_startproc [simple]" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_endproc" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_personality encoding [, exp]" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_lsda encoding [, exp]" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_inline_lsda [align]" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_def_cfa register, offset" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_def_cfa_register register" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_def_cfa_offset offset" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_adjust_cfa_offset offset" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_offset register, offset" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_rel_offset register, offset" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_register register1, register2" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_restore register" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_undefined register" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_same_value register" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_remember_state," href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_return_column register" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_signal_frame" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_window_save" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_escape expression[, ...]" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_val_encoded_addr register, encoding, label" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".cfi_epilogue_begin" href="doc/as.html/CFI-directives.html#CFI-directives"/><topic label=".comm symbol , length " href="doc/as.html/Comm.html#Comm"/><topic label=".data subsection" href="doc/as.html/Data.html#Data"/><topic label=".def name" href="doc/as.html/Def.html#Def"/><topic label=".desc symbol, abs-expression" href="doc/as.html/Desc.html#Desc"/><topic label=".dim" href="doc/as.html/Dim.html#Dim"/><topic label=".double flonums" href="doc/as.html/Double.html#Double"/><topic label=".eject" href="doc/as.html/Eject.html#Eject"/><topic label=".else" href="doc/as.html/Else.html#Else"/><topic label=".elseif" href="doc/as.html/Elseif.html#Elseif"/><topic label=".end" href="doc/as.html/End.html#End"/><topic label=".endef" href="doc/as.html/Endef.html#Endef"/><topic label=".endfunc" href="doc/as.html/Endfunc.html#Endfunc"/><topic label=".endif" href="doc/as.html/Endif.html#Endif"/><topic label=".equ symbol, expression" href="doc/as.html/Equ.html#Equ"/><topic label=".equiv symbol, expression" href="doc/as.html/Equiv.html#Equiv"/><topic label=".eqv symbol, expression" href="doc/as.html/Eqv.html#Eqv"/><topic label=".err" href="doc/as.html/Err.html#Err"/><topic label=".error &quot;string&quot;" href="doc/as.html/Error.html#Error"/><topic label=".exitm" href="doc/as.html/Exitm.html#Exitm"/><topic label=".extern" href="doc/as.html/Extern.html#Extern"/><topic label=".fail expression" href="doc/as.html/Fail.html#Fail"/><topic label=".file" href="doc/as.html/File.html#File"/><topic label=".fill repeat , size , value" href="doc/as.html/Fill.html#Fill"/><topic label=".float flonums" href="doc/as.html/Float.html#Float"/><topic label=".func name[,label]" href="doc/as.html/Func.html#Func"/><topic label=".global symbol, .globl symbol" href="doc/as.html/Global.html#Global"/><topic label=".gnu_attribute tag,value" href="doc/as.html/Gnu_005fattribute.html#Gnu_005fattribute"/><topic label=".hidden names" href="doc/as.html/Hidden.html#Hidden"/><topic label=".hword expressions" href="doc/as.html/hword.html#hword"/><topic label=".ident" href="doc/as.html/Ident.html#Ident"/><topic label=".if absolute expression" href="doc/as.html/If.html#If"/><topic label=".incbin &quot;file&quot;[,skip[,count]]" href="doc/as.html/Incbin.html#Incbin"/><topic label=".include &quot;file&quot;" href="doc/as.html/Include.html#Include"/><topic label=".int expressions" href="doc/as.html/Int.html#Int"/><topic label=".internal names" href="doc/as.html/Internal.html#Internal"/><topic label=".irp symbol,values..." href="doc/as.html/Irp.html#Irp"/><topic label=".irpc symbol,values..." href="doc/as.html/Irpc.html#Irpc"/><topic label=".lcomm symbol , length" href="doc/as.html/Lcomm.html#Lcomm"/><topic label=".lflags" href="doc/as.html/Lflags.html#Lflags"/><topic label=".line line-number" href="doc/as.html/Line.html#Line"/><topic label=".linkonce [type]" href="doc/as.html/Linkonce.html#Linkonce"/><topic label=".list" href="doc/as.html/List.html#List"/><topic label=".ln line-number" href="doc/as.html/Ln.html#Ln"/><topic label=".loc fileno lineno [column] [options]" href="doc/as.html/Loc.html#Loc"/><topic label=".loc_mark_labels enable" href="doc/as.html/Loc_005fmark_005flabels.html#Loc_005fmark_005flabels"/><topic label=".local names" href="doc/as.html/Local.html#Local"/><topic label=".long expressions" href="doc/as.html/Long.html#Long"/><topic label=".macro" href="doc/as.html/Macro.html#Macro"/><topic label=".mri val" href="doc/as.html/MRI.html#MRI"/><topic label=".noaltmacro" href="doc/as.html/Noaltmacro.html#Noaltmacro"/><topic label=".nolist" href="doc/as.html/Nolist.html#Nolist"/><topic label=".octa bignums" href="doc/as.html/Octa.html#Octa"/><topic label=".offset loc" href="doc/as.html/Offset.html#Offset"/><topic label=".org new-lc , fill" href="doc/as.html/Org.html#Org"/><topic label=".p2align[wl] abs-expr, abs-expr, abs-expr" href="doc/as.html/P2align.html#P2align"/><topic label=".popsection" href="doc/as.html/PopSection.html#PopSection"/><topic label=".previous" href="doc/as.html/Previous.html#Previous"/><topic label=".print string" href="doc/as.html/Print.html#Print"/><topic label=".protected names" href="doc/as.html/Protected.html#Protected"/><topic label=".psize lines , columns" href="doc/as.html/Psize.html#Psize"/><topic label=".purgem name" href="doc/as.html/Purgem.html#Purgem"/><topic label=".pushsection name [, subsection] [, &quot;flags&quot;[, @type[,arguments]]]" href="doc/as.html/PushSection.html#PushSection"/><topic label=".quad bignums" href="doc/as.html/Quad.html#Quad"/><topic label=".reloc offset, reloc_name[, expression]" href="doc/as.html/Reloc.html#Reloc"/><topic label=".rept count" href="doc/as.html/Rept.html#Rept"/><topic label=".sbttl &quot;subheading&quot;" href="doc/as.html/Sbttl.html#Sbttl"/><topic label=".scl class" href="doc/as.html/Scl.html#Scl"/><topic label=".section name" href="doc/as.html/Section.html#Section"/><topic label=".set symbol, expression" href="doc/as.html/Set.html#Set"/><topic label=".short expressions" href="doc/as.html/Short.html#Short"/><topic label=".single flonums" href="doc/as.html/Single.html#Single"/><topic label=".size" href="doc/as.html/Size.html#Size"/><topic label=".skip size , fill" href="doc/as.html/Skip.html#Skip"/><topic label=".sleb128 expressions" href="doc/as.html/Sleb128.html#Sleb128"/><topic label=".space size , fill" href="doc/as.html/Space.html#Space"/><topic label=".stabd, .stabn, .stabs" href="doc/as.html/Stab.html#Stab"/><topic label=".string &quot;str&quot;, .string8 &quot;str&quot;, .string16" href="doc/as.html/String.html#String"/><topic label=".struct expression" href="doc/as.html/Struct.html#Struct"/><topic label=".subsection name" href="doc/as.html/SubSection.html#SubSection"/><topic label=".symver" href="doc/as.html/Symver.html#Symver"/><topic label=".tag structname" href="doc/as.html/Tag.html#Tag"/><topic label=".text subsection" href="doc/as.html/Text.html#Text"/><topic label=".title &quot;heading&quot;" href="doc/as.html/Title.html#Title"/><topic label=".type" href="doc/as.html/Type.html#Type"/><topic label=".uleb128 expressions" href="doc/as.html/Uleb128.html#Uleb128"/><topic label=".val addr" href="doc/as.html/Val.html#Val"/><topic label=".version &quot;string&quot;" href="doc/as.html/Version.html#Version"/><topic label=".vtable_entry table, offset" href="doc/as.html/VTableEntry.html#VTableEntry"/><topic label=".vtable_inherit child, parent" href="doc/as.html/VTableInherit.html#VTableInherit"/><topic label=".warning &quot;string&quot;" href="doc/as.html/Warning.html#Warning"/><topic label=".weak names" href="doc/as.html/Weak.html#Weak"/><topic label=".weakref alias, target" href="doc/as.html/Weakref.html#Weakref"/><topic label=".word expressions" href="doc/as.html/Word.html#Word"/><topic label="Deprecated Directives" href="doc/as.html/Deprecated.html#Deprecated"/></topic><topic label="Object Attributes" href="doc/as.html/Object-Attributes.html#Object-Attributes">
# <topic label="gnu Object Attributes" href="doc/as.html/GNU-Object-Attributes.html#GNU-Object-Attributes">
# <topic label="Common gnu attributes" href="doc/as.html/GNU-Object-Attributes.html#GNU-Object-Attributes"/><topic label="MIPS Attributes" href="doc/as.html/GNU-Object-Attributes.html#GNU-Object-Attributes"/><topic label="PowerPC Attributes" href="doc/as.html/GNU-Object-Attributes.html#GNU-Object-Attributes"/></topic><topic label="Defining New Object Attributes" href="doc/as.html/Defining-New-Object-Attributes.html#Defining-New-Object-Attributes"/></topic><topic label="Machine Dependent Features" href="doc/as.html/Machine-Dependencies.html#Machine-Dependencies">
# <topic label="AArch64 Dependent Features" href="doc/as.html/AArch64_002dDependent.html#AArch64_002dDependent">
# <topic label="Options" href="doc/as.html/AArch64-Options.html#AArch64-Options"/><topic label="Syntax" href="doc/as.html/AArch64-Syntax.html#AArch64-Syntax">
# <topic label="Special Characters" href="doc/as.html/AArch64_002dChars.html#AArch64_002dChars"/><topic label="Register Names" href="doc/as.html/AArch64_002dRegs.html#AArch64_002dRegs"/><topic label="Relocations" href="doc/as.html/AArch64_002dRelocations.html#AArch64_002dRelocations"/></topic><topic label="Floating Point" href="doc/as.html/AArch64-Floating-Point.html#AArch64-Floating-Point"/><topic label="AArch64 Machine Directives" href="doc/as.html/AArch64-Directives.html#AArch64-Directives"/><topic label="Opcodes" href="doc/as.html/AArch64-Opcodes.html#AArch64-Opcodes"/><topic label="Mapping Symbols" href="doc/as.html/AArch64-Mapping-Symbols.html#AArch64-Mapping-Symbols"/></topic><topic label="Alpha Dependent Features" href="doc/as.html/Alpha_002dDependent.html#Alpha_002dDependent">
# <topic label="Notes" href="doc/as.html/Alpha-Notes.html#Alpha-Notes"/><topic label="Options" href="doc/as.html/Alpha-Options.html#Alpha-Options"/><topic label="Syntax" href="doc/as.html/Alpha-Syntax.html#Alpha-Syntax">
# <topic label="Special Characters" href="doc/as.html/Alpha_002dChars.html#Alpha_002dChars"/><topic label="Register Names" href="doc/as.html/Alpha_002dRegs.html#Alpha_002dRegs"/><topic label="Relocations" href="doc/as.html/Alpha_002dRelocs.html#Alpha_002dRelocs"/></topic><topic label="Floating Point" href="doc/as.html/Alpha-Floating-Point.html#Alpha-Floating-Point"/><topic label="Alpha Assembler Directives" href="doc/as.html/Alpha-Directives.html#Alpha-Directives"/><topic label="Opcodes" href="doc/as.html/Alpha-Opcodes.html#Alpha-Opcodes"/></topic><topic label="ARC Dependent Features" href="doc/as.html/ARC_002dDependent.html#ARC_002dDependent">
# <topic label="Options" href="doc/as.html/ARC-Options.html#ARC-Options"/><topic label="Syntax" href="doc/as.html/ARC-Syntax.html#ARC-Syntax">
# <topic label="Special Characters" href="doc/as.html/ARC_002dChars.html#ARC_002dChars"/><topic label="Register Names" href="doc/as.html/ARC_002dRegs.html#ARC_002dRegs"/></topic><topic label="Floating Point" href="doc/as.html/ARC-Floating-Point.html#ARC-Floating-Point"/><topic label="ARC Machine Directives" href="doc/as.html/ARC-Directives.html#ARC-Directives"/><topic label="Opcodes" href="doc/as.html/ARC-Opcodes.html#ARC-Opcodes"/></topic><topic label="ARM Dependent Features" href="doc/as.html/ARM_002dDependent.html#ARM_002dDependent">
# <topic label="Options" href="doc/as.html/ARM-Options.html#ARM-Options"/><topic label="Syntax" href="doc/as.html/ARM-Syntax.html#ARM-Syntax">
# <topic label="Instruction Set Syntax" href="doc/as.html/ARM_002dInstruction_002dSet.html#ARM_002dInstruction_002dSet"/><topic label="Special Characters" href="doc/as.html/ARM_002dChars.html#ARM_002dChars"/><topic label="Register Names" href="doc/as.html/ARM_002dRegs.html#ARM_002dRegs"/><topic label="ARM relocation generation" href="doc/as.html/ARM_002dRelocations.html#ARM_002dRelocations"/><topic label="NEON Alignment Specifiers" href="doc/as.html/ARM_002dNeon_002dAlignment.html#ARM_002dNeon_002dAlignment"/></topic><topic label="Floating Point" href="doc/as.html/ARM-Floating-Point.html#ARM-Floating-Point"/><topic label="ARM Machine Directives" href="doc/as.html/ARM-Directives.html#ARM-Directives"/><topic label="Opcodes" href="doc/as.html/ARM-Opcodes.html#ARM-Opcodes"/><topic label="Mapping Symbols" href="doc/as.html/ARM-Mapping-Symbols.html#ARM-Mapping-Symbols"/><topic label="Unwinding" href="doc/as.html/ARM-Unwinding-Tutorial.html#ARM-Unwinding-Tutorial"/></topic><topic label="AVR Dependent Features" href="doc/as.html/AVR_002dDependent.html#AVR_002dDependent">
# <topic label="Options" href="doc/as.html/AVR-Options.html#AVR-Options"/><topic label="Syntax" href="doc/as.html/AVR-Syntax.html#AVR-Syntax">
# <topic label="Special Characters" href="doc/as.html/AVR_002dChars.html#AVR_002dChars"/><topic label="Register Names" href="doc/as.html/AVR_002dRegs.html#AVR_002dRegs"/><topic label="Relocatable Expression Modifiers" href="doc/as.html/AVR_002dModifiers.html#AVR_002dModifiers"/></topic><topic label="Opcodes" href="doc/as.html/AVR-Opcodes.html#AVR-Opcodes"/></topic><topic label="Blackfin Dependent Features" href="doc/as.html/Blackfin_002dDependent.html#Blackfin_002dDependent">
# <topic label="Options" href="doc/as.html/Blackfin-Options.html#Blackfin-Options"/><topic label="Syntax" href="doc/as.html/Blackfin-Syntax.html#Blackfin-Syntax"/><topic label="Directives" href="doc/as.html/Blackfin-Directives.html#Blackfin-Directives"/></topic><topic label="CR16 Dependent Features" href="doc/as.html/CR16_002dDependent.html#CR16_002dDependent">
# <topic label="CR16 Operand Qualifiers" href="doc/as.html/CR16-Operand-Qualifiers.html#CR16-Operand-Qualifiers"/><topic label="CR16 Syntax" href="doc/as.html/CR16-Syntax.html#CR16-Syntax">
# <topic label="Special Characters" href="doc/as.html/CR16_002dChars.html#CR16_002dChars"/></topic></topic><topic label="CRIS Dependent Features" href="doc/as.html/CRIS_002dDependent.html#CRIS_002dDependent">
# <topic label="Command-line Options" href="doc/as.html/CRIS_002dOpts.html#CRIS_002dOpts"/><topic label="Instruction expansion" href="doc/as.html/CRIS_002dExpand.html#CRIS_002dExpand"/><topic label="Symbols" href="doc/as.html/CRIS_002dSymbols.html#CRIS_002dSymbols"/><topic label="Syntax" href="doc/as.html/CRIS_002dSyntax.html#CRIS_002dSyntax">
# <topic label="Special Characters" href="doc/as.html/CRIS_002dChars.html#CRIS_002dChars"/><topic label="Symbols in position-independent code" href="doc/as.html/CRIS_002dPic.html#CRIS_002dPic"/><topic label="Register names" href="doc/as.html/CRIS_002dRegs.html#CRIS_002dRegs"/><topic label="Assembler Directives" href="doc/as.html/CRIS_002dPseudos.html#CRIS_002dPseudos"/></topic></topic><topic label="D10V Dependent Features" href="doc/as.html/D10V_002dDependent.html#D10V_002dDependent">
# <topic label="D10V Options" href="doc/as.html/D10V_002dOpts.html#D10V_002dOpts"/><topic label="Syntax" href="doc/as.html/D10V_002dSyntax.html#D10V_002dSyntax">
# <topic label="Size Modifiers" href="doc/as.html/D10V_002dSize.html#D10V_002dSize"/><topic label="Sub-Instructions" href="doc/as.html/D10V_002dSubs.html#D10V_002dSubs"/><topic label="Special Characters" href="doc/as.html/D10V_002dChars.html#D10V_002dChars"/><topic label="Register Names" href="doc/as.html/D10V_002dRegs.html#D10V_002dRegs"/><topic label="Addressing Modes" href="doc/as.html/D10V_002dAddressing.html#D10V_002dAddressing"/><topic label="@WORD Modifier" href="doc/as.html/D10V_002dWord.html#D10V_002dWord"/></topic><topic label="Floating Point" href="doc/as.html/D10V_002dFloat.html#D10V_002dFloat"/><topic label="Opcodes" href="doc/as.html/D10V_002dOpcodes.html#D10V_002dOpcodes"/></topic><topic label="D30V Dependent Features" href="doc/as.html/D30V_002dDependent.html#D30V_002dDependent">
# <topic label="D30V Options" href="doc/as.html/D30V_002dOpts.html#D30V_002dOpts"/><topic label="Syntax" href="doc/as.html/D30V_002dSyntax.html#D30V_002dSyntax">
# <topic label="Size Modifiers" href="doc/as.html/D30V_002dSize.html#D30V_002dSize"/><topic label="Sub-Instructions" href="doc/as.html/D30V_002dSubs.html#D30V_002dSubs"/><topic label="Special Characters" href="doc/as.html/D30V_002dChars.html#D30V_002dChars"/><topic label="Guarded Execution" href="doc/as.html/D30V_002dGuarded.html#D30V_002dGuarded"/><topic label="Register Names" href="doc/as.html/D30V_002dRegs.html#D30V_002dRegs"/><topic label="Addressing Modes" href="doc/as.html/D30V_002dAddressing.html#D30V_002dAddressing"/></topic><topic label="Floating Point" href="doc/as.html/D30V_002dFloat.html#D30V_002dFloat"/><topic label="Opcodes" href="doc/as.html/D30V_002dOpcodes.html#D30V_002dOpcodes"/></topic><topic label="Epiphany Dependent Features" href="doc/as.html/Epiphany_002dDependent.html#Epiphany_002dDependent">
# <topic label="Options" href="doc/as.html/Epiphany-Options.html#Epiphany-Options"/><topic label="Epiphany Syntax" href="doc/as.html/Epiphany-Syntax.html#Epiphany-Syntax">
# <topic label="Special Characters" href="doc/as.html/Epiphany_002dChars.html#Epiphany_002dChars"/></topic></topic><topic label="H8/300 Dependent Features" href="doc/as.html/H8_002f300_002dDependent.html#H8_002f300_002dDependent">
# <topic label="Options" href="doc/as.html/H8_002f300-Options.html#H8_002f300-Options"/><topic label="Syntax" href="doc/as.html/H8_002f300-Syntax.html#H8_002f300-Syntax">
# <topic label="Special Characters" href="doc/as.html/H8_002f300_002dChars.html#H8_002f300_002dChars"/><topic label="Register Names" href="doc/as.html/H8_002f300_002dRegs.html#H8_002f300_002dRegs"/><topic label="Addressing Modes" href="doc/as.html/H8_002f300_002dAddressing.html#H8_002f300_002dAddressing"/></topic><topic label="Floating Point" href="doc/as.html/H8_002f300-Floating-Point.html#H8_002f300-Floating-Point"/><topic label="H8/300 Machine Directives" href="doc/as.html/H8_002f300-Directives.html#H8_002f300-Directives"/><topic label="Opcodes" href="doc/as.html/H8_002f300-Opcodes.html#H8_002f300-Opcodes"/></topic><topic label="HPPA Dependent Features" href="doc/as.html/HPPA_002dDependent.html#HPPA_002dDependent">
# <topic label="Notes" href="doc/as.html/HPPA-Notes.html#HPPA-Notes"/><topic label="Options" href="doc/as.html/HPPA-Options.html#HPPA-Options"/><topic label="Syntax" href="doc/as.html/HPPA-Syntax.html#HPPA-Syntax"/><topic label="Floating Point" href="doc/as.html/HPPA-Floating-Point.html#HPPA-Floating-Point"/><topic label="HPPA Assembler Directives" href="doc/as.html/HPPA-Directives.html#HPPA-Directives"/><topic label="Opcodes" href="doc/as.html/HPPA-Opcodes.html#HPPA-Opcodes"/></topic><topic label="ESA/390 Dependent Features" href="doc/as.html/ESA_002f390_002dDependent.html#ESA_002f390_002dDependent">
# <topic label="Notes" href="doc/as.html/ESA_002f390-Notes.html#ESA_002f390-Notes"/><topic label="Options" href="doc/as.html/ESA_002f390-Options.html#ESA_002f390-Options"/><topic label="Syntax" href="doc/as.html/ESA_002f390-Syntax.html#ESA_002f390-Syntax"/><topic label="Floating Point" href="doc/as.html/ESA_002f390-Floating-Point.html#ESA_002f390-Floating-Point"/><topic label="ESA/390 Assembler Directives" href="doc/as.html/ESA_002f390-Directives.html#ESA_002f390-Directives"/><topic label="Opcodes" href="doc/as.html/ESA_002f390-Opcodes.html#ESA_002f390-Opcodes"/></topic><topic label="80386 Dependent Features" href="doc/as.html/i386_002dDependent.html#i386_002dDependent">
# <topic label="Options" href="doc/as.html/i386_002dOptions.html#i386_002dOptions"/><topic label="x86 specific Directives" href="doc/as.html/i386_002dDirectives.html#i386_002dDirectives"/><topic label="i386 Syntactical Considerations" href="doc/as.html/i386_002dSyntax.html#i386_002dSyntax">
# <topic label="AT&amp;T Syntax versus Intel Syntax" href="doc/as.html/i386_002dVariations.html#i386_002dVariations"/><topic label="Special Characters" href="doc/as.html/i386_002dChars.html#i386_002dChars"/></topic><topic label="Instruction Naming" href="doc/as.html/i386_002dMnemonics.html#i386_002dMnemonics"/><topic label="AT&amp;T Mnemonic versus Intel Mnemonic" href="doc/as.html/i386_002dMnemonics.html#i386_002dMnemonics"/><topic label="Register Naming" href="doc/as.html/i386_002dRegs.html#i386_002dRegs"/><topic label="Instruction Prefixes" href="doc/as.html/i386_002dPrefixes.html#i386_002dPrefixes"/><topic label="Memory References" href="doc/as.html/i386_002dMemory.html#i386_002dMemory"/><topic label="Handling of Jump Instructions" href="doc/as.html/i386_002dJumps.html#i386_002dJumps"/><topic label="Floating Point" href="doc/as.html/i386_002dFloat.html#i386_002dFloat"/><topic label="Intel's MMX and AMD's 3DNow! SIMD Operations" href="doc/as.html/i386_002dSIMD.html#i386_002dSIMD"/><topic label="AMD's Lightweight Profiling Instructions" href="doc/as.html/i386_002dLWP.html#i386_002dLWP"/><topic label="Bit Manipulation Instructions" href="doc/as.html/i386_002dBMI.html#i386_002dBMI"/><topic label="AMD's Trailing Bit Manipulation Instructions" href="doc/as.html/i386_002dTBM.html#i386_002dTBM"/><topic label="Writing 16-bit Code" href="doc/as.html/i386_002d16bit.html#i386_002d16bit"/><topic label="AT&amp;T Syntax bugs" href="doc/as.html/i386_002dBugs.html#i386_002dBugs"/><topic label="Specifying CPU Architecture" href="doc/as.html/i386_002dArch.html#i386_002dArch"/><topic label="Notes" href="doc/as.html/i386_002dNotes.html#i386_002dNotes"/></topic><topic label="Intel i860 Dependent Features" href="doc/as.html/i860_002dDependent.html#i860_002dDependent">
# <topic label="i860 Notes" href="doc/as.html/Notes_002di860.html#Notes_002di860"/><topic label="i860 Command-line Options" href="doc/as.html/Options_002di860.html#Options_002di860">
# <topic label="SVR4 compatibility options" href="doc/as.html/Options_002di860.html#Options_002di860"/><topic label="Other options" href="doc/as.html/Options_002di860.html#Options_002di860"/></topic><topic label="i860 Machine Directives" href="doc/as.html/Directives_002di860.html#Directives_002di860"/><topic label="i860 Opcodes" href="doc/as.html/Opcodes-for-i860.html#Opcodes-for-i860">
# <topic label="Other instruction support (pseudo-instructions)" href="doc/as.html/Opcodes-for-i860.html#Opcodes-for-i860"/></topic><topic label="i860 Syntax" href="doc/as.html/Syntax-of-i860.html#Syntax-of-i860">
# <topic label="Special Characters" href="doc/as.html/i860_002dChars.html#i860_002dChars"/></topic></topic><topic label="Intel 80960 Dependent Features" href="doc/as.html/i960_002dDependent.html#i960_002dDependent">
# <topic label="i960 Command-line Options" href="doc/as.html/Options_002di960.html#Options_002di960"/><topic label="Floating Point" href="doc/as.html/Floating-Point_002di960.html#Floating-Point_002di960"/><topic label="i960 Machine Directives" href="doc/as.html/Directives_002di960.html#Directives_002di960"/><topic label="i960 Opcodes" href="doc/as.html/Opcodes-for-i960.html#Opcodes-for-i960">
# <topic label="callj" href="doc/as.html/callj_002di960.html#callj_002di960"/><topic label="Compare-and-Branch" href="doc/as.html/Compare_002dand_002dbranch_002di960.html#Compare_002dand_002dbranch_002di960"/></topic><topic label="Syntax for the i960" href="doc/as.html/Syntax-of-i960.html#Syntax-of-i960">
# <topic label="Special Characters" href="doc/as.html/i960_002dChars.html#i960_002dChars"/></topic></topic><topic label="IA-64 Dependent Features" href="doc/as.html/IA_002d64_002dDependent.html#IA_002d64_002dDependent">
# <topic label="Options" href="doc/as.html/IA_002d64-Options.html#IA_002d64-Options"/><topic label="Syntax" href="doc/as.html/IA_002d64-Syntax.html#IA_002d64-Syntax">
# <topic label="Special Characters" href="doc/as.html/IA_002d64_002dChars.html#IA_002d64_002dChars"/><topic label="Register Names" href="doc/as.html/IA_002d64_002dRegs.html#IA_002d64_002dRegs"/><topic label="IA-64 Processor-Status-Register (PSR) Bit Names" href="doc/as.html/IA_002d64_002dBits.html#IA_002d64_002dBits"/><topic label="Relocations" href="doc/as.html/IA_002d64_002dRelocs.html#IA_002d64_002dRelocs"/></topic><topic label="Opcodes" href="doc/as.html/IA_002d64-Opcodes.html#IA_002d64-Opcodes"/></topic><topic label="IP2K Dependent Features" href="doc/as.html/IP2K_002dDependent.html#IP2K_002dDependent">
# <topic label="IP2K Options" href="doc/as.html/IP2K_002dOpts.html#IP2K_002dOpts"/><topic label="IP2K Syntax" href="doc/as.html/IP2K_002dSyntax.html#IP2K_002dSyntax">
# <topic label="Special Characters" href="doc/as.html/IP2K_002dChars.html#IP2K_002dChars"/></topic></topic><topic label="LM32 Dependent Features" href="doc/as.html/LM32_002dDependent.html#LM32_002dDependent">
# <topic label="Options" href="doc/as.html/LM32-Options.html#LM32-Options"/><topic label="Syntax" href="doc/as.html/LM32-Syntax.html#LM32-Syntax">
# <topic label="Register Names" href="doc/as.html/LM32_002dRegs.html#LM32_002dRegs"/><topic label="Relocatable Expression Modifiers" href="doc/as.html/LM32_002dModifiers.html#LM32_002dModifiers"/><topic label="Special Characters" href="doc/as.html/LM32_002dChars.html#LM32_002dChars"/></topic><topic label="Opcodes" href="doc/as.html/LM32-Opcodes.html#LM32-Opcodes"/></topic><topic label="M32C Dependent Features" href="doc/as.html/M32C_002dDependent.html#M32C_002dDependent">
# <topic label="M32C Options" href="doc/as.html/M32C_002dOpts.html#M32C_002dOpts"/><topic label="M32C Syntax" href="doc/as.html/M32C_002dSyntax.html#M32C_002dSyntax">
# <topic label="Symbolic Operand Modifiers" href="doc/as.html/M32C_002dModifiers.html#M32C_002dModifiers"/><topic label="Special Characters" href="doc/as.html/M32C_002dChars.html#M32C_002dChars"/></topic></topic><topic label="M32R Dependent Features" href="doc/as.html/M32R_002dDependent.html#M32R_002dDependent">
# <topic label="M32R Options" href="doc/as.html/M32R_002dOpts.html#M32R_002dOpts"/><topic label="M32R Directives" href="doc/as.html/M32R_002dDirectives.html#M32R_002dDirectives"/><topic label="M32R Warnings" href="doc/as.html/M32R_002dWarnings.html#M32R_002dWarnings"/></topic><topic label="M680x0 Dependent Features" href="doc/as.html/M68K_002dDependent.html#M68K_002dDependent">
# <topic label="M680x0 Options" href="doc/as.html/M68K_002dOpts.html#M68K_002dOpts"/><topic label="Syntax" href="doc/as.html/M68K_002dSyntax.html#M68K_002dSyntax"/><topic label="Motorola Syntax" href="doc/as.html/M68K_002dMoto_002dSyntax.html#M68K_002dMoto_002dSyntax"/><topic label="Floating Point" href="doc/as.html/M68K_002dFloat.html#M68K_002dFloat"/><topic label="680x0 Machine Directives" href="doc/as.html/M68K_002dDirectives.html#M68K_002dDirectives"/><topic label="Opcodes" href="doc/as.html/M68K_002dopcodes.html#M68K_002dopcodes">
# <topic label="Branch Improvement" href="doc/as.html/M68K_002dBranch.html#M68K_002dBranch"/><topic label="Special Characters" href="doc/as.html/M68K_002dChars.html#M68K_002dChars"/></topic></topic><topic label="M68HC11 and M68HC12 Dependent Features" href="doc/as.html/M68HC11_002dDependent.html#M68HC11_002dDependent">
# <topic label="M68HC11 and M68HC12 Options" href="doc/as.html/M68HC11_002dOpts.html#M68HC11_002dOpts"/><topic label="Syntax" href="doc/as.html/M68HC11_002dSyntax.html#M68HC11_002dSyntax"/><topic label="Symbolic Operand Modifiers" href="doc/as.html/M68HC11_002dModifiers.html#M68HC11_002dModifiers"/><topic label="Assembler Directives" href="doc/as.html/M68HC11_002dDirectives.html#M68HC11_002dDirectives"/><topic label="Floating Point" href="doc/as.html/M68HC11_002dFloat.html#M68HC11_002dFloat"/><topic label="Opcodes" href="doc/as.html/M68HC11_002dopcodes.html#M68HC11_002dopcodes">
# <topic label="Branch Improvement" href="doc/as.html/M68HC11_002dBranch.html#M68HC11_002dBranch"/></topic></topic><topic label="Meta Dependent Features" href="doc/as.html/Meta_002dDependent.html#Meta_002dDependent">
# <topic label="Options" href="doc/as.html/Meta-Options.html#Meta-Options"/><topic label="Syntax" href="doc/as.html/Meta-Syntax.html#Meta-Syntax">
# <topic label="Special Characters" href="doc/as.html/Meta_002dChars.html#Meta_002dChars"/><topic label="Register Names" href="doc/as.html/Meta_002dRegs.html#Meta_002dRegs"/></topic></topic><topic label="MicroBlaze Dependent Features" href="doc/as.html/MicroBlaze_002dDependent.html#MicroBlaze_002dDependent">
# <topic label="Directives" href="doc/as.html/MicroBlaze-Directives.html#MicroBlaze-Directives"/><topic label="Syntax for the MicroBlaze" href="doc/as.html/MicroBlaze-Syntax.html#MicroBlaze-Syntax">
# <topic label="Special Characters" href="doc/as.html/MicroBlaze_002dChars.html#MicroBlaze_002dChars"/></topic></topic><topic label="MIPS Dependent Features" href="doc/as.html/MIPS_002dDependent.html#MIPS_002dDependent">
# <topic label="Assembler options" href="doc/as.html/MIPS-Options.html#MIPS-Options"/><topic label="High-level assembly macros" href="doc/as.html/MIPS-Macros.html#MIPS-Macros"/><topic label="Directives to override the size of symbols" href="doc/as.html/MIPS-Symbol-Sizes.html#MIPS-Symbol-Sizes"/><topic label="Controlling the use of small data accesses" href="doc/as.html/MIPS-Small-Data.html#MIPS-Small-Data"/><topic label="Directives to override the ISA level" href="doc/as.html/MIPS-ISA.html#MIPS-ISA"/><topic label="Directives to control code generation" href="doc/as.html/MIPS-assembly-options.html#MIPS-assembly-options"/><topic label="Directives for extending MIPS 16 bit instructions" href="doc/as.html/MIPS-autoextend.html#MIPS-autoextend"/><topic label="Directive to mark data as an instruction" href="doc/as.html/MIPS-insn.html#MIPS-insn"/><topic label="Directives to record which NaN encoding is being used" href="doc/as.html/MIPS-NaN-Encodings.html#MIPS-NaN-Encodings"/><topic label="Directives to save and restore options" href="doc/as.html/MIPS-Option-Stack.html#MIPS-Option-Stack"/><topic label="Directives to control generation of MIPS ASE instructions" href="doc/as.html/MIPS-ASE-Instruction-Generation-Overrides.html#MIPS-ASE-Instruction-Generation-Overrides"/><topic label="Directives to override floating-point options" href="doc/as.html/MIPS-Floating_002dPoint.html#MIPS-Floating_002dPoint"/><topic label="Syntactical considerations for the MIPS assembler" href="doc/as.html/MIPS-Syntax.html#MIPS-Syntax">
# <topic label="Special Characters" href="doc/as.html/MIPS_002dChars.html#MIPS_002dChars"/></topic></topic><topic label="MMIX Dependent Features" href="doc/as.html/MMIX_002dDependent.html#MMIX_002dDependent">
# <topic label="Command-line Options" href="doc/as.html/MMIX_002dOpts.html#MMIX_002dOpts"/><topic label="Instruction expansion" href="doc/as.html/MMIX_002dExpand.html#MMIX_002dExpand"/><topic label="Syntax" href="doc/as.html/MMIX_002dSyntax.html#MMIX_002dSyntax">
# <topic label="Special Characters" href="doc/as.html/MMIX_002dChars.html#MMIX_002dChars"/><topic label="Symbols" href="doc/as.html/MMIX_002dSymbols.html#MMIX_002dSymbols"/><topic label="Register names" href="doc/as.html/MMIX_002dRegs.html#MMIX_002dRegs"/><topic label="Assembler Directives" href="doc/as.html/MMIX_002dPseudos.html#MMIX_002dPseudos"/></topic><topic label="Differences to mmixal" href="doc/as.html/MMIX_002dmmixal.html#MMIX_002dmmixal"/></topic><topic label="MSP 430 Dependent Features" href="doc/as.html/MSP430_002dDependent.html#MSP430_002dDependent">
# <topic label="Options" href="doc/as.html/MSP430-Options.html#MSP430-Options"/><topic label="Syntax" href="doc/as.html/MSP430-Syntax.html#MSP430-Syntax">
# <topic label="Macros" href="doc/as.html/MSP430_002dMacros.html#MSP430_002dMacros"/><topic label="Special Characters" href="doc/as.html/MSP430_002dChars.html#MSP430_002dChars"/><topic label="Register Names" href="doc/as.html/MSP430_002dRegs.html#MSP430_002dRegs"/><topic label="Assembler Extensions" href="doc/as.html/MSP430_002dExt.html#MSP430_002dExt"/></topic><topic label="Floating Point" href="doc/as.html/MSP430-Floating-Point.html#MSP430-Floating-Point"/><topic label="MSP 430 Machine Directives" href="doc/as.html/MSP430-Directives.html#MSP430-Directives"/><topic label="Opcodes" href="doc/as.html/MSP430-Opcodes.html#MSP430-Opcodes"/><topic label="Profiling Capability" href="doc/as.html/MSP430-Profiling-Capability.html#MSP430-Profiling-Capability"/></topic><topic label="NDS32 Dependent Features" href="doc/as.html/NDS32_002dDependent.html#NDS32_002dDependent">
# <topic label="NDS32 Options" href="doc/as.html/NDS32-Options.html#NDS32-Options"/><topic label="Syntax" href="doc/as.html/NDS32-Syntax.html#NDS32-Syntax">
# <topic label="Special Characters" href="doc/as.html/NDS32_002dChars.html#NDS32_002dChars"/><topic label="Register Names" href="doc/as.html/NDS32_002dRegs.html#NDS32_002dRegs"/><topic label="Pseudo Instructions" href="doc/as.html/NDS32_002dOps.html#NDS32_002dOps"/></topic></topic><topic label="Nios II Dependent Features" href="doc/as.html/NiosII_002dDependent.html#NiosII_002dDependent">
# <topic label="Options" href="doc/as.html/Nios-II-Options.html#Nios-II-Options"/><topic label="Syntax" href="doc/as.html/Nios-II-Syntax.html#Nios-II-Syntax">
# <topic label="Special Characters" href="doc/as.html/Nios-II-Chars.html#Nios-II-Chars"/></topic><topic label="Nios II Machine Relocations" href="doc/as.html/Nios-II-Relocations.html#Nios-II-Relocations"/><topic label="Nios II Machine Directives" href="doc/as.html/Nios-II-Directives.html#Nios-II-Directives"/><topic label="Opcodes" href="doc/as.html/Nios-II-Opcodes.html#Nios-II-Opcodes"/></topic><topic label="NS32K Dependent Features" href="doc/as.html/NS32K_002dDependent.html#NS32K_002dDependent">
# <topic label="Syntax" href="doc/as.html/NS32K-Syntax.html#NS32K-Syntax">
# <topic label="Special Characters" href="doc/as.html/NS32K_002dChars.html#NS32K_002dChars"/></topic></topic><topic label="PDP-11 Dependent Features" href="doc/as.html/PDP_002d11_002dDependent.html#PDP_002d11_002dDependent">
# <topic label="Options" href="doc/as.html/PDP_002d11_002dOptions.html#PDP_002d11_002dOptions">
# <topic label="Code Generation Options" href="doc/as.html/PDP_002d11_002dOptions.html#PDP_002d11_002dOptions"/><topic label="Instruction Set Extension Options" href="doc/as.html/PDP_002d11_002dOptions.html#PDP_002d11_002dOptions"/><topic label="CPU Model Options" href="doc/as.html/PDP_002d11_002dOptions.html#PDP_002d11_002dOptions"/><topic label="Machine Model Options" href="doc/as.html/PDP_002d11_002dOptions.html#PDP_002d11_002dOptions"/></topic><topic label="Assembler Directives" href="doc/as.html/PDP_002d11_002dPseudos.html#PDP_002d11_002dPseudos"/><topic label="PDP-11 Assembly Language Syntax" href="doc/as.html/PDP_002d11_002dSyntax.html#PDP_002d11_002dSyntax"/><topic label="Instruction Naming" href="doc/as.html/PDP_002d11_002dMnemonics.html#PDP_002d11_002dMnemonics"/><topic label="Synthetic Instructions" href="doc/as.html/PDP_002d11_002dSynthetic.html#PDP_002d11_002dSynthetic"/></topic><topic label="picoJava Dependent Features" href="doc/as.html/PJ_002dDependent.html#PJ_002dDependent">
# <topic label="Options" href="doc/as.html/PJ-Options.html#PJ-Options"/><topic label="PJ Syntax" href="doc/as.html/PJ-Syntax.html#PJ-Syntax">
# <topic label="Special Characters" href="doc/as.html/PJ_002dChars.html#PJ_002dChars"/></topic></topic><topic label="PowerPC Dependent Features" href="doc/as.html/PPC_002dDependent.html#PPC_002dDependent">
# <topic label="Options" href="doc/as.html/PowerPC_002dOpts.html#PowerPC_002dOpts"/><topic label="PowerPC Assembler Directives" href="doc/as.html/PowerPC_002dPseudo.html#PowerPC_002dPseudo"/><topic label="PowerPC Syntax" href="doc/as.html/PowerPC_002dSyntax.html#PowerPC_002dSyntax">
# <topic label="Special Characters" href="doc/as.html/PowerPC_002dChars.html#PowerPC_002dChars"/></topic></topic><topic label="RL78 Dependent Features" href="doc/as.html/RL78_002dDependent.html#RL78_002dDependent">
# <topic label="RL78 Options" href="doc/as.html/RL78_002dOpts.html#RL78_002dOpts"/><topic label="Symbolic Operand Modifiers" href="doc/as.html/RL78_002dModifiers.html#RL78_002dModifiers"/><topic label="Assembler Directives" href="doc/as.html/RL78_002dDirectives.html#RL78_002dDirectives"/><topic label="Syntax for the RL78" href="doc/as.html/RL78_002dSyntax.html#RL78_002dSyntax">
# <topic label="Special Characters" href="doc/as.html/RL78_002dChars.html#RL78_002dChars"/></topic></topic><topic label="RX Dependent Features" href="doc/as.html/RX_002dDependent.html#RX_002dDependent">
# <topic label="RX Options" href="doc/as.html/RX_002dOpts.html#RX_002dOpts"/><topic label="Symbolic Operand Modifiers" href="doc/as.html/RX_002dModifiers.html#RX_002dModifiers"/><topic label="Assembler Directives" href="doc/as.html/RX_002dDirectives.html#RX_002dDirectives"/><topic label="Floating Point" href="doc/as.html/RX_002dFloat.html#RX_002dFloat"/><topic label="Syntax for the RX" href="doc/as.html/RX_002dSyntax.html#RX_002dSyntax">
# <topic label="Special Characters" href="doc/as.html/RX_002dChars.html#RX_002dChars"/></topic></topic><topic label="IBM S/390 Dependent Features" href="doc/as.html/S_002f390_002dDependent.html#S_002f390_002dDependent">
# <topic label="Options" href="doc/as.html/s390-Options.html#s390-Options"/><topic label="Special Characters" href="doc/as.html/s390-Characters.html#s390-Characters"/><topic label="Instruction syntax" href="doc/as.html/s390-Syntax.html#s390-Syntax">
# <topic label="Register naming" href="doc/as.html/s390-Register.html#s390-Register"/><topic label="Instruction Mnemonics" href="doc/as.html/s390-Mnemonics.html#s390-Mnemonics"/><topic label="Instruction Operands" href="doc/as.html/s390-Operands.html#s390-Operands"/><topic label="Instruction Formats" href="doc/as.html/s390-Formats.html#s390-Formats"/><topic label="Instruction Aliases" href="doc/as.html/s390-Aliases.html#s390-Aliases"/><topic label="Instruction Operand Modifier" href="doc/as.html/s390-Operand-Modifier.html#s390-Operand-Modifier"/><topic label="Instruction Marker" href="doc/as.html/s390-Instruction-Marker.html#s390-Instruction-Marker"/><topic label="Literal Pool Entries" href="doc/as.html/s390-Literal-Pool-Entries.html#s390-Literal-Pool-Entries"/></topic><topic label="Assembler Directives" href="doc/as.html/s390-Directives.html#s390-Directives"/><topic label="Floating Point" href="doc/as.html/s390-Floating-Point.html#s390-Floating-Point"/></topic><topic label="SCORE Dependent Features" href="doc/as.html/SCORE_002dDependent.html#SCORE_002dDependent">
# <topic label="Options" href="doc/as.html/SCORE_002dOpts.html#SCORE_002dOpts"/><topic label="SCORE Assembler Directives" href="doc/as.html/SCORE_002dPseudo.html#SCORE_002dPseudo"/><topic label="SCORE Syntax" href="doc/as.html/SCORE_002dSyntax.html#SCORE_002dSyntax">
# <topic label="Special Characters" href="doc/as.html/SCORE_002dChars.html#SCORE_002dChars"/></topic></topic><topic label="Renesas / SuperH SH Dependent Features" href="doc/as.html/SH_002dDependent.html#SH_002dDependent">
# <topic label="Options" href="doc/as.html/SH-Options.html#SH-Options"/><topic label="Syntax" href="doc/as.html/SH-Syntax.html#SH-Syntax">
# <topic label="Special Characters" href="doc/as.html/SH_002dChars.html#SH_002dChars"/><topic label="Register Names" href="doc/as.html/SH_002dRegs.html#SH_002dRegs"/><topic label="Addressing Modes" href="doc/as.html/SH_002dAddressing.html#SH_002dAddressing"/></topic><topic label="Floating Point" href="doc/as.html/SH-Floating-Point.html#SH-Floating-Point"/><topic label="SH Machine Directives" href="doc/as.html/SH-Directives.html#SH-Directives"/><topic label="Opcodes" href="doc/as.html/SH-Opcodes.html#SH-Opcodes"/></topic><topic label="SuperH SH64 Dependent Features" href="doc/as.html/SH64_002dDependent.html#SH64_002dDependent">
# <topic label="Options" href="doc/as.html/SH64-Options.html#SH64-Options"/><topic label="Syntax" href="doc/as.html/SH64-Syntax.html#SH64-Syntax">
# <topic label="Special Characters" href="doc/as.html/SH64_002dChars.html#SH64_002dChars"/><topic label="Register Names" href="doc/as.html/SH64_002dRegs.html#SH64_002dRegs"/><topic label="Addressing Modes" href="doc/as.html/SH64_002dAddressing.html#SH64_002dAddressing"/></topic><topic label="SH64 Machine Directives" href="doc/as.html/SH64-Directives.html#SH64-Directives"/><topic label="Opcodes" href="doc/as.html/SH64-Opcodes.html#SH64-Opcodes"/></topic><topic label="SPARC Dependent Features" href="doc/as.html/Sparc_002dDependent.html#Sparc_002dDependent">
# <topic label="Options" href="doc/as.html/Sparc_002dOpts.html#Sparc_002dOpts"/><topic label="Enforcing aligned data" href="doc/as.html/Sparc_002dAligned_002dData.html#Sparc_002dAligned_002dData"/><topic label="Sparc Syntax" href="doc/as.html/Sparc_002dSyntax.html#Sparc_002dSyntax">
# <topic label="Special Characters" href="doc/as.html/Sparc_002dChars.html#Sparc_002dChars"/><topic label="Register Names" href="doc/as.html/Sparc_002dRegs.html#Sparc_002dRegs"/><topic label="Constants" href="doc/as.html/Sparc_002dConstants.html#Sparc_002dConstants"/><topic label="Relocations" href="doc/as.html/Sparc_002dRelocs.html#Sparc_002dRelocs"/><topic label="Size Translations" href="doc/as.html/Sparc_002dSize_002dTranslations.html#Sparc_002dSize_002dTranslations"/></topic><topic label="Floating Point" href="doc/as.html/Sparc_002dFloat.html#Sparc_002dFloat"/><topic label="Sparc Machine Directives" href="doc/as.html/Sparc_002dDirectives.html#Sparc_002dDirectives"/></topic><topic label="TIC54X Dependent Features" href="doc/as.html/TIC54X_002dDependent.html#TIC54X_002dDependent">
# <topic label="Options" href="doc/as.html/TIC54X_002dOpts.html#TIC54X_002dOpts"/><topic label="Blocking" href="doc/as.html/TIC54X_002dBlock.html#TIC54X_002dBlock"/><topic label="Environment Settings" href="doc/as.html/TIC54X_002dEnv.html#TIC54X_002dEnv"/><topic label="Constants Syntax" href="doc/as.html/TIC54X_002dConstants.html#TIC54X_002dConstants"/><topic label="String Substitution" href="doc/as.html/TIC54X_002dSubsyms.html#TIC54X_002dSubsyms"/><topic label="Local Labels" href="doc/as.html/TIC54X_002dLocals.html#TIC54X_002dLocals"/><topic label="Math Builtins" href="doc/as.html/TIC54X_002dBuiltins.html#TIC54X_002dBuiltins"/><topic label="Extended Addressing" href="doc/as.html/TIC54X_002dExt.html#TIC54X_002dExt"/><topic label="Directives" href="doc/as.html/TIC54X_002dDirectives.html#TIC54X_002dDirectives"/><topic label="Macros" href="doc/as.html/TIC54X_002dMacros.html#TIC54X_002dMacros"/><topic label="Memory-mapped Registers" href="doc/as.html/TIC54X_002dMMRegs.html#TIC54X_002dMMRegs"/><topic label="TIC54X Syntax" href="doc/as.html/TIC54X_002dSyntax.html#TIC54X_002dSyntax">
# <topic label="Special Characters" href="doc/as.html/TIC54X_002dChars.html#TIC54X_002dChars"/></topic></topic><topic label="TIC6X Dependent Features" href="doc/as.html/TIC6X_002dDependent.html#TIC6X_002dDependent">
# <topic label="TIC6X Options" href="doc/as.html/TIC6X-Options.html#TIC6X-Options"/><topic label="TIC6X Syntax" href="doc/as.html/TIC6X-Syntax.html#TIC6X-Syntax"/><topic label="TIC6X Directives" href="doc/as.html/TIC6X-Directives.html#TIC6X-Directives"/></topic><topic label="TILE-Gx Dependent Features" href="doc/as.html/TILE_002dGx_002dDependent.html#TILE_002dGx_002dDependent">
# <topic label="Options" href="doc/as.html/TILE_002dGx-Options.html#TILE_002dGx-Options"/><topic label="Syntax" href="doc/as.html/TILE_002dGx-Syntax.html#TILE_002dGx-Syntax">
# <topic label="Opcode Names" href="doc/as.html/TILE_002dGx-Opcodes.html#TILE_002dGx-Opcodes"/><topic label="Register Names" href="doc/as.html/TILE_002dGx-Registers.html#TILE_002dGx-Registers"/><topic label="Symbolic Operand Modifiers" href="doc/as.html/TILE_002dGx-Modifiers.html#TILE_002dGx-Modifiers"/></topic><topic label="TILE-Gx Directives" href="doc/as.html/TILE_002dGx-Directives.html#TILE_002dGx-Directives"/></topic><topic label="TILEPro Dependent Features" href="doc/as.html/TILEPro_002dDependent.html#TILEPro_002dDependent">
# <topic label="Options" href="doc/as.html/TILEPro-Options.html#TILEPro-Options"/><topic label="Syntax" href="doc/as.html/TILEPro-Syntax.html#TILEPro-Syntax">
# <topic label="Opcode Names" href="doc/as.html/TILEPro-Opcodes.html#TILEPro-Opcodes"/><topic label="Register Names" href="doc/as.html/TILEPro-Registers.html#TILEPro-Registers"/><topic label="Symbolic Operand Modifiers" href="doc/as.html/TILEPro-Modifiers.html#TILEPro-Modifiers"/></topic><topic label="TILEPro Directives" href="doc/as.html/TILEPro-Directives.html#TILEPro-Directives"/></topic><topic label="Z80 Dependent Features" href="doc/as.html/Z80_002dDependent.html#Z80_002dDependent">
# <topic label="Options" href="doc/as.html/Z80-Options.html#Z80-Options"/><topic label="Syntax" href="doc/as.html/Z80-Syntax.html#Z80-Syntax">
# <topic label="Special Characters" href="doc/as.html/Z80_002dChars.html#Z80_002dChars"/><topic label="Register Names" href="doc/as.html/Z80_002dRegs.html#Z80_002dRegs"/><topic label="Case Sensitivity" href="doc/as.html/Z80_002dCase.html#Z80_002dCase"/></topic><topic label="Floating Point" href="doc/as.html/Z80-Floating-Point.html#Z80-Floating-Point"/><topic label="Z80 Assembler Directives" href="doc/as.html/Z80-Directives.html#Z80-Directives"/><topic label="Opcodes" href="doc/as.html/Z80-Opcodes.html#Z80-Opcodes"/></topic><topic label="Z8000 Dependent Features" href="doc/as.html/Z8000_002dDependent.html#Z8000_002dDependent">
# <topic label="Options" href="doc/as.html/Z8000-Options.html#Z8000-Options"/><topic label="Syntax" href="doc/as.html/Z8000-Syntax.html#Z8000-Syntax">
# <topic label="Special Characters" href="doc/as.html/Z8000_002dChars.html#Z8000_002dChars"/><topic label="Register Names" href="doc/as.html/Z8000_002dRegs.html#Z8000_002dRegs"/><topic label="Addressing Modes" href="doc/as.html/Z8000_002dAddressing.html#Z8000_002dAddressing"/></topic><topic label="Assembler Directives for the Z8000" href="doc/as.html/Z8000-Directives.html#Z8000-Directives"/><topic label="Opcodes" href="doc/as.html/Z8000-Opcodes.html#Z8000-Opcodes"/></topic><topic label="VAX Dependent Features" href="doc/as.html/Vax_002dDependent.html#Vax_002dDependent">
# <topic label="VAX Command-Line Options" href="doc/as.html/VAX_002dOpts.html#VAX_002dOpts"/><topic label="VAX Floating Point" href="doc/as.html/VAX_002dfloat.html#VAX_002dfloat"/><topic label="Vax Machine Directives" href="doc/as.html/VAX_002ddirectives.html#VAX_002ddirectives"/><topic label="VAX Opcodes" href="doc/as.html/VAX_002dopcodes.html#VAX_002dopcodes"/><topic label="VAX Branch Improvement" href="doc/as.html/VAX_002dbranch.html#VAX_002dbranch"/><topic label="VAX Operands" href="doc/as.html/VAX_002doperands.html#VAX_002doperands"/><topic label="Not Supported on VAX" href="doc/as.html/VAX_002dno.html#VAX_002dno"/><topic label="VAX Syntax" href="doc/as.html/VAX_002dSyntax.html#VAX_002dSyntax">
# <topic label="Special Characters" href="doc/as.html/VAX_002dChars.html#VAX_002dChars"/></topic></topic><topic label="v850 Dependent Features" href="doc/as.html/V850_002dDependent.html#V850_002dDependent">
# <topic label="Options" href="doc/as.html/V850-Options.html#V850-Options"/><topic label="Syntax" href="doc/as.html/V850-Syntax.html#V850-Syntax">
# <topic label="Special Characters" href="doc/as.html/V850_002dChars.html#V850_002dChars"/><topic label="Register Names" href="doc/as.html/V850_002dRegs.html#V850_002dRegs"/></topic><topic label="Floating Point" href="doc/as.html/V850-Floating-Point.html#V850-Floating-Point"/><topic label="V850 Machine Directives" href="doc/as.html/V850-Directives.html#V850-Directives"/><topic label="Opcodes" href="doc/as.html/V850-Opcodes.html#V850-Opcodes"/></topic><topic label="XGATE Dependent Features" href="doc/as.html/XGATE_002dDependent.html#XGATE_002dDependent">
# <topic label="XGATE Options" href="doc/as.html/XGATE_002dOpts.html#XGATE_002dOpts"/><topic label="Syntax" href="doc/as.html/XGATE_002dSyntax.html#XGATE_002dSyntax"/><topic label="Assembler Directives" href="doc/as.html/XGATE_002dDirectives.html#XGATE_002dDirectives"/><topic label="Floating Point" href="doc/as.html/XGATE_002dFloat.html#XGATE_002dFloat"/><topic label="Opcodes" href="doc/as.html/XGATE_002dopcodes.html#XGATE_002dopcodes"/></topic><topic label="XStormy16 Dependent Features" href="doc/as.html/XSTORMY16_002dDependent.html#XSTORMY16_002dDependent">
# <topic label="Syntax" href="doc/as.html/XStormy16-Syntax.html#XStormy16-Syntax">
# <topic label="Special Characters" href="doc/as.html/XStormy16_002dChars.html#XStormy16_002dChars"/></topic><topic label="XStormy16 Machine Directives" href="doc/as.html/XStormy16-Directives.html#XStormy16-Directives"/><topic label="XStormy16 Pseudo-Opcodes" href="doc/as.html/XStormy16-Opcodes.html#XStormy16-Opcodes"/></topic><topic label="Xtensa Dependent Features" href="doc/as.html/Xtensa_002dDependent.html#Xtensa_002dDependent">
# <topic label="Command Line Options" href="doc/as.html/Xtensa-Options.html#Xtensa-Options"/><topic label="Assembler Syntax" href="doc/as.html/Xtensa-Syntax.html#Xtensa-Syntax">
# <topic label="Opcode Names" href="doc/as.html/Xtensa-Opcodes.html#Xtensa-Opcodes"/><topic label="Register Names" href="doc/as.html/Xtensa-Registers.html#Xtensa-Registers"/></topic><topic label="Xtensa Optimizations" href="doc/as.html/Xtensa-Optimizations.html#Xtensa-Optimizations">
# <topic label="Using Density Instructions" href="doc/as.html/Density-Instructions.html#Density-Instructions"/><topic label="Automatic Instruction Alignment" href="doc/as.html/Xtensa-Automatic-Alignment.html#Xtensa-Automatic-Alignment"/></topic><topic label="Xtensa Relaxation" href="doc/as.html/Xtensa-Relaxation.html#Xtensa-Relaxation">
# <topic label="Conditional Branch Relaxation" href="doc/as.html/Xtensa-Branch-Relaxation.html#Xtensa-Branch-Relaxation"/><topic label="Function Call Relaxation" href="doc/as.html/Xtensa-Call-Relaxation.html#Xtensa-Call-Relaxation"/><topic label="Other Immediate Field Relaxation" href="doc/as.html/Xtensa-Immediate-Relaxation.html#Xtensa-Immediate-Relaxation"/></topic><topic label="Directives" href="doc/as.html/Xtensa-Directives.html#Xtensa-Directives">
# <topic label="schedule" href="doc/as.html/Schedule-Directive.html#Schedule-Directive"/><topic label="longcalls" href="doc/as.html/Longcalls-Directive.html#Longcalls-Directive"/><topic label="transform" href="doc/as.html/Transform-Directive.html#Transform-Directive"/><topic label="literal" href="doc/as.html/Literal-Directive.html#Literal-Directive"/><topic label="literal_position" href="doc/as.html/Literal-Position-Directive.html#Literal-Position-Directive"/><topic label="literal_prefix" href="doc/as.html/Literal-Prefix-Directive.html#Literal-Prefix-Directive"/><topic label="absolute-literals" href="doc/as.html/Absolute-Literals-Directive.html#Absolute-Literals-Directive"/></topic></topic></topic><topic label="Reporting Bugs" href="doc/as.html/Reporting-Bugs.html#Reporting-Bugs">
# <topic label="Have You Found a Bug?" href="doc/as.html/Bug-Criteria.html#Bug-Criteria"/><topic label="How to Report Bugs" href="doc/as.html/Bug-Reporting.html#Bug-Reporting"/></topic><topic label="Acknowledgements" href="doc/as.html/Acknowledgements.html#Acknowledgements"/><topic label="Appendix A GNU Free Documentation License" href="doc/as.html/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/><topic label="AS Index" href="doc/as.html/AS-Index.html#AS-Index"/><topic label="Overview" href="doc/as.html/Overview.html#Overview"/><topic label="Invoking" href="doc/as.html/Invoking.html#Invoking"/><topic label="Syntax" href="doc/as.html/Syntax.html#Syntax"/><topic label="Sections" href="doc/as.html/Sections.html#Sections"/><topic label="Symbols" href="doc/as.html/Symbols.html#Symbols"/><topic label="Expressions" href="doc/as.html/Expressions.html#Expressions"/><topic label="Pseudo Ops" href="doc/as.html/Pseudo-Ops.html#Pseudo-Ops"/><topic label="Object Attributes" href="doc/as.html/Object-Attributes.html#Object-Attributes"/><topic label="Machine Dependencies" href="doc/as.html/Machine-Dependencies.html#Machine-Dependencies"/><topic label="Reporting Bugs" href="doc/as.html/Reporting-Bugs.html#Reporting-Bugs"/><topic label="Acknowledgements" href="doc/as.html/Acknowledgements.html#Acknowledgements"/><topic label="GNU Free Documentation License" href="doc/as.html/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/><topic label="AS Index" href="doc/as.html/AS-Index.html#AS-Index"/>
# </topic>
# <topic label="Linker (HTML)">
# <topic label="LD" href="doc/ld.html/index.html#Top"/><topic label="Overview" href="doc/ld.html/Overview.html#Overview"/><topic label="Invocation" href="doc/ld.html/Invocation.html#Invocation">
# <topic label="Command Line Options" href="doc/ld.html/Options.html#Options">
# <topic label="Options Specific to i386 PE Targets" href="doc/ld.html/Options.html#Options"/><topic label="Options specific to C6X uClinux targets" href="doc/ld.html/Options.html#Options"/><topic label="Options specific to Motorola 68HC11 and 68HC12 targets" href="doc/ld.html/Options.html#Options"/><topic label="Options specific to Motorola 68K target" href="doc/ld.html/Options.html#Options"/><topic label="Options specific to MIPS targets" href="doc/ld.html/Options.html#Options"/></topic><topic label="Environment Variables" href="doc/ld.html/Environment.html#Environment"/></topic><topic label="Linker Scripts" href="doc/ld.html/Scripts.html#Scripts">
# <topic label="Basic Linker Script Concepts" href="doc/ld.html/Basic-Script-Concepts.html#Basic-Script-Concepts"/><topic label="Linker Script Format" href="doc/ld.html/Script-Format.html#Script-Format"/><topic label="Simple Linker Script Example" href="doc/ld.html/Simple-Example.html#Simple-Example"/><topic label="Simple Linker Script Commands" href="doc/ld.html/Simple-Commands.html#Simple-Commands">
# <topic label="Setting the Entry Point" href="doc/ld.html/Entry-Point.html#Entry-Point"/><topic label="Commands Dealing with Files" href="doc/ld.html/File-Commands.html#File-Commands"/><topic label="Commands Dealing with Object File Formats" href="doc/ld.html/Format-Commands.html#Format-Commands"/><topic label="Assign alias names to memory regions" href="doc/ld.html/REGION_005fALIAS.html#REGION_005fALIAS"/><topic label="Other Linker Script Commands" href="doc/ld.html/Miscellaneous-Commands.html#Miscellaneous-Commands"/></topic><topic label="Assigning Values to Symbols" href="doc/ld.html/Assignments.html#Assignments">
# <topic label="Simple Assignments" href="doc/ld.html/Simple-Assignments.html#Simple-Assignments"/><topic label="HIDDEN" href="doc/ld.html/HIDDEN.html#HIDDEN"/><topic label="PROVIDE" href="doc/ld.html/PROVIDE.html#PROVIDE"/><topic label="PROVIDE_HIDDEN" href="doc/ld.html/PROVIDE_005fHIDDEN.html#PROVIDE_005fHIDDEN"/><topic label="Source Code Reference" href="doc/ld.html/Source-Code-Reference.html#Source-Code-Reference"/></topic><topic label="SECTIONS Command" href="doc/ld.html/SECTIONS.html#SECTIONS">
# <topic label="Output Section Description" href="doc/ld.html/Output-Section-Description.html#Output-Section-Description"/><topic label="Output Section Name" href="doc/ld.html/Output-Section-Name.html#Output-Section-Name"/><topic label="Output Section Address" href="doc/ld.html/Output-Section-Address.html#Output-Section-Address"/><topic label="Input Section Description" href="doc/ld.html/Input-Section.html#Input-Section">
# <topic label="Input Section Basics" href="doc/ld.html/Input-Section-Basics.html#Input-Section-Basics"/><topic label="Input Section Wildcard Patterns" href="doc/ld.html/Input-Section-Wildcards.html#Input-Section-Wildcards"/><topic label="Input Section for Common Symbols" href="doc/ld.html/Input-Section-Common.html#Input-Section-Common"/><topic label="Input Section and Garbage Collection" href="doc/ld.html/Input-Section-Keep.html#Input-Section-Keep"/><topic label="Input Section Example" href="doc/ld.html/Input-Section-Example.html#Input-Section-Example"/></topic><topic label="Output Section Data" href="doc/ld.html/Output-Section-Data.html#Output-Section-Data"/><topic label="Output Section Keywords" href="doc/ld.html/Output-Section-Keywords.html#Output-Section-Keywords"/><topic label="Output Section Discarding" href="doc/ld.html/Output-Section-Discarding.html#Output-Section-Discarding"/><topic label="Output Section Attributes" href="doc/ld.html/Output-Section-Attributes.html#Output-Section-Attributes">
# <topic label="Output Section Type" href="doc/ld.html/Output-Section-Type.html#Output-Section-Type"/><topic label="Output Section LMA" href="doc/ld.html/Output-Section-LMA.html#Output-Section-LMA"/><topic label="Forced Output Alignment" href="doc/ld.html/Forced-Output-Alignment.html#Forced-Output-Alignment"/><topic label="Forced Input Alignment" href="doc/ld.html/Forced-Input-Alignment.html#Forced-Input-Alignment"/><topic label="Output Section Constraint" href="doc/ld.html/Output-Section-Constraint.html#Output-Section-Constraint"/><topic label="Output Section Region" href="doc/ld.html/Output-Section-Region.html#Output-Section-Region"/><topic label="Output Section Phdr" href="doc/ld.html/Output-Section-Phdr.html#Output-Section-Phdr"/><topic label="Output Section Fill" href="doc/ld.html/Output-Section-Fill.html#Output-Section-Fill"/></topic><topic label="Overlay Description" href="doc/ld.html/Overlay-Description.html#Overlay-Description"/></topic><topic label="MEMORY Command" href="doc/ld.html/MEMORY.html#MEMORY"/><topic label="PHDRS Command" href="doc/ld.html/PHDRS.html#PHDRS"/><topic label="VERSION Command" href="doc/ld.html/VERSION.html#VERSION"/><topic label="Expressions in Linker Scripts" href="doc/ld.html/Expressions.html#Expressions">
# <topic label="Constants" href="doc/ld.html/Constants.html#Constants"/><topic label="Symbolic Constants" href="doc/ld.html/Symbolic-Constants.html#Symbolic-Constants"/><topic label="Symbol Names" href="doc/ld.html/Symbols.html#Symbols"/><topic label="Orphan Sections" href="doc/ld.html/Orphan-Sections.html#Orphan-Sections"/><topic label="The Location Counter" href="doc/ld.html/Location-Counter.html#Location-Counter"/><topic label="Operators" href="doc/ld.html/Operators.html#Operators"/><topic label="Evaluation" href="doc/ld.html/Evaluation.html#Evaluation"/><topic label="The Section of an Expression" href="doc/ld.html/Expression-Section.html#Expression-Section"/><topic label="Builtin Functions" href="doc/ld.html/Builtin-Functions.html#Builtin-Functions"/></topic><topic label="Implicit Linker Scripts" href="doc/ld.html/Implicit-Linker-Scripts.html#Implicit-Linker-Scripts"/></topic><topic label="Machine Dependent Features" href="doc/ld.html/Machine-Dependent.html#Machine-Dependent">
# <topic label="ld and the H8/300" href="doc/ld.html/H8_002f300.html#H8_002f300"/><topic label="ld and the Intel 960 Family" href="doc/ld.html/i960.html#i960"/><topic label="ld and the Motorola 68HC11 and 68HC12 families" href="doc/ld.html/M68HC11_002f68HC12.html#M68HC11_002f68HC12">
# <topic label="Linker Relaxation" href="doc/ld.html/M68HC11_002f68HC12.html#M68HC11_002f68HC12"/><topic label="Trampoline Generation" href="doc/ld.html/M68HC11_002f68HC12.html#M68HC11_002f68HC12"/></topic><topic label="ld and the ARM family" href="doc/ld.html/ARM.html#ARM"/><topic label="ld and HPPA 32-bit ELF Support" href="doc/ld.html/HPPA-ELF32.html#HPPA-ELF32"/><topic label="ld and the Motorola 68K family" href="doc/ld.html/M68K.html#M68K"/><topic label="ld and the MIPS family" href="doc/ld.html/MIPS.html#MIPS"/><topic label="ld and MMIX" href="doc/ld.html/MMIX.html#MMIX"/><topic label="ld and MSP430" href="doc/ld.html/MSP430.html#MSP430"/><topic label="ld and NDS32" href="doc/ld.html/NDS32.html#NDS32"/><topic label="ld and the Altera Nios II" href="doc/ld.html/Nios-II.html#Nios-II"/><topic label="ld and PowerPC 32-bit ELF Support" href="doc/ld.html/PowerPC-ELF32.html#PowerPC-ELF32"/><topic label="ld and PowerPC64 64-bit ELF Support" href="doc/ld.html/PowerPC64-ELF64.html#PowerPC64-ELF64"/><topic label="ld and SPU ELF Support" href="doc/ld.html/SPU-ELF.html#SPU-ELF"/><topic label="ld's Support for Various TI COFF Versions" href="doc/ld.html/TI-COFF.html#TI-COFF"/><topic label="ld and WIN32 (cygwin/mingw)" href="doc/ld.html/WIN32.html#WIN32"/><topic label="ld and Xtensa Processors" href="doc/ld.html/Xtensa.html#Xtensa"/></topic><topic label="BFD" href="doc/ld.html/BFD.html#BFD">
# <topic label="How It Works: An Outline of BFD" href="doc/ld.html/BFD-outline.html#BFD-outline">
# <topic label="Information Loss" href="doc/ld.html/BFD-information-loss.html#BFD-information-loss"/><topic label="The BFD canonical object-file format" href="doc/ld.html/Canonical-format.html#Canonical-format"/></topic></topic><topic label="Reporting Bugs" href="doc/ld.html/Reporting-Bugs.html#Reporting-Bugs">
# <topic label="Have You Found a Bug?" href="doc/ld.html/Bug-Criteria.html#Bug-Criteria"/><topic label="How to Report Bugs" href="doc/ld.html/Bug-Reporting.html#Bug-Reporting"/></topic><topic label="Appendix A MRI Compatible Script Files" href="doc/ld.html/MRI.html#MRI"/><topic label="Appendix B GNU Free Documentation License" href="doc/ld.html/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/><topic label="LD Index" href="doc/ld.html/LD-Index.html#LD-Index"/><topic label="Overview" href="doc/ld.html/Overview.html#Overview"/><topic label="Invocation" href="doc/ld.html/Invocation.html#Invocation"/><topic label="Scripts" href="doc/ld.html/Scripts.html#Scripts"/><topic label="Machine Dependent" href="doc/ld.html/Machine-Dependent.html#Machine-Dependent"/><topic label="BFD" href="doc/ld.html/BFD.html#BFD"/><topic label="Reporting Bugs" href="doc/ld.html/Reporting-Bugs.html#Reporting-Bugs"/><topic label="MRI" href="doc/ld.html/MRI.html#MRI"/><topic label="GNU Free Documentation License" href="doc/ld.html/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/><topic label="LD Index" href="doc/ld.html/LD-Index.html#LD-Index"/>
# </topic>
# <topic label="Profiler (HTML)">
# <topic label="Profiling a Program: Where Does It Spend Its Time?" href="doc/gprof.html/index.html#Top"/><topic label="Introduction to Profiling" href="doc/gprof.html/Introduction.html#Introduction"/><topic label="Compiling a Program for Profiling" href="doc/gprof.html/Compiling.html#Compiling"/><topic label="Executing the Program" href="doc/gprof.html/Executing.html#Executing"/><topic label="gprof Command Summary" href="doc/gprof.html/Invoking.html#Invoking">
# <topic label="Output Options" href="doc/gprof.html/Output-Options.html#Output-Options"/><topic label="Analysis Options" href="doc/gprof.html/Analysis-Options.html#Analysis-Options"/><topic label="Miscellaneous Options" href="doc/gprof.html/Miscellaneous-Options.html#Miscellaneous-Options"/><topic label="Deprecated Options" href="doc/gprof.html/Deprecated-Options.html#Deprecated-Options"/><topic label="Symspecs" href="doc/gprof.html/Symspecs.html#Symspecs"/></topic><topic label="Interpreting gprof's Output" href="doc/gprof.html/Output.html#Output">
# <topic label="The Flat Profile" href="doc/gprof.html/Flat-Profile.html#Flat-Profile"/><topic label="The Call Graph" href="doc/gprof.html/Call-Graph.html#Call-Graph">
# <topic label="The Primary Line" href="doc/gprof.html/Primary.html#Primary"/><topic label="Lines for a Function's Callers" href="doc/gprof.html/Callers.html#Callers"/><topic label="Lines for a Function's Subroutines" href="doc/gprof.html/Subroutines.html#Subroutines"/><topic label="How Mutually Recursive Functions Are Described" href="doc/gprof.html/Cycles.html#Cycles"/></topic><topic label="Line-by-line Profiling" href="doc/gprof.html/Line_002dby_002dline.html#Line_002dby_002dline"/><topic label="The Annotated Source Listing" href="doc/gprof.html/Annotated-Source.html#Annotated-Source"/></topic><topic label="Inaccuracy of gprof Output" href="doc/gprof.html/Inaccuracy.html#Inaccuracy">
# <topic label="Statistical Sampling Error" href="doc/gprof.html/Sampling-Error.html#Sampling-Error"/><topic label="Estimating children Times" href="doc/gprof.html/Assumptions.html#Assumptions"/></topic><topic label="Answers to Common Questions" href="doc/gprof.html/How-do-I_003f.html#How-do-I_003f"/><topic label="Incompatibilities with Unix gprof" href="doc/gprof.html/Incompatibilities.html#Incompatibilities"/><topic label="Details of Profiling" href="doc/gprof.html/Details.html#Details">
# <topic label="Implementation of Profiling" href="doc/gprof.html/Implementation.html#Implementation"/><topic label="Profiling Data File Format" href="doc/gprof.html/File-Format.html#File-Format">
# <topic label="Histogram Records" href="doc/gprof.html/File-Format.html#File-Format"/><topic label="Call-Graph Records" href="doc/gprof.html/File-Format.html#File-Format"/><topic label="Basic-Block Execution Count Records" href="doc/gprof.html/File-Format.html#File-Format"/></topic><topic label="gprof's Internal Operation" href="doc/gprof.html/Internals.html#Internals"/><topic label="Debugging gprof" href="doc/gprof.html/Debugging.html#Debugging"/></topic><topic label="Appendix A GNU Free Documentation License" href="doc/gprof.html/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/><topic label="Introduction" href="doc/gprof.html/Introduction.html#Introduction"/><topic label="Compiling" href="doc/gprof.html/Compiling.html#Compiling"/><topic label="Executing" href="doc/gprof.html/Executing.html#Executing"/><topic label="Invoking" href="doc/gprof.html/Invoking.html#Invoking"/><topic label="Output" href="doc/gprof.html/Output.html#Output"/><topic label="Inaccuracy" href="doc/gprof.html/Inaccuracy.html#Inaccuracy"/><topic label="How do I?" href="doc/gprof.html/How-do-I_003f.html#How-do-I_003f"/><topic label="Incompatibilities" href="doc/gprof.html/Incompatibilities.html#Incompatibilities"/><topic label="Details" href="doc/gprof.html/Details.html#Details"/><topic label="GNU Free Documentation License" href="doc/gprof.html/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/>
# </topic>
# <topic label="Compiler (HTML)">
# <topic label="Introduction" href="doc/gcc/index.html#Top"/><topic label="Programming Languages Supported by GCC" href="doc/gcc/G_002b_002b-and-GCC.html#G_002b_002b-and-GCC"/><topic label="Language Standards Supported by GCC" href="doc/gcc/Standards.html#Standards">
# <topic label="C language" href="doc/gcc/Standards.html#Standards"/><topic label="C++ language" href="doc/gcc/Standards.html#Standards"/><topic label="Objective-C and Objective-C++ languages" href="doc/gcc/Standards.html#Standards"/><topic label="Go language" href="doc/gcc/Standards.html#Standards"/><topic label="References for other languages" href="doc/gcc/Standards.html#Standards"/></topic><topic label="GCC Command Options" href="doc/gcc/Invoking-GCC.html#Invoking-GCC">
# <topic label="Option Summary" href="doc/gcc/Option-Summary.html#Option-Summary"/><topic label="Options Controlling the Kind of Output" href="doc/gcc/Overall-Options.html#Overall-Options"/><topic label="Compiling C++ Programs" href="doc/gcc/Invoking-G_002b_002b.html#Invoking-G_002b_002b"/><topic label="Options Controlling C Dialect" href="doc/gcc/C-Dialect-Options.html#C-Dialect-Options"/><topic label="Options Controlling C++ Dialect" href="doc/gcc/C_002b_002b-Dialect-Options.html#C_002b_002b-Dialect-Options"/><topic label="Options Controlling Objective-C and Objective-C++ Dialects" href="doc/gcc/Objective_002dC-and-Objective_002dC_002b_002b-Dialect-Options.html#Objective_002dC-and-Objective_002dC_002b_002b-Dialect-Options"/><topic label="Options to Control Diagnostic Messages Formatting" href="doc/gcc/Language-Independent-Options.html#Language-Independent-Options"/><topic label="Options to Request or Suppress Warnings" href="doc/gcc/Warning-Options.html#Warning-Options"/><topic label="Options for Debugging Your Program or GCC" href="doc/gcc/Debugging-Options.html#Debugging-Options"/><topic label="Options That Control Optimization" href="doc/gcc/Optimize-Options.html#Optimize-Options"/><topic label="Options Controlling the Preprocessor" href="doc/gcc/Preprocessor-Options.html#Preprocessor-Options"/><topic label="Passing Options to the Assembler" href="doc/gcc/Assembler-Options.html#Assembler-Options"/><topic label="Options for Linking" href="doc/gcc/Link-Options.html#Link-Options"/><topic label="Options for Directory Search" href="doc/gcc/Directory-Options.html#Directory-Options"/><topic label="Specifying subprocesses and the switches to pass to them" href="doc/gcc/Spec-Files.html#Spec-Files"/><topic label="Specifying Target Machine and Compiler Version" href="doc/gcc/Target-Options.html#Target-Options"/><topic label="Hardware Models and Configurations" href="doc/gcc/Submodel-Options.html#Submodel-Options">
# <topic label="AArch64 Options" href="doc/gcc/AArch64-Options.html#AArch64-Options">
# <topic label="-march and -mcpu feature modifiers" href="doc/gcc/AArch64-Options.html#AArch64-Options"/></topic><topic label="Adapteva Epiphany Options" href="doc/gcc/Adapteva-Epiphany-Options.html#Adapteva-Epiphany-Options"/><topic label="ARC Options" href="doc/gcc/ARC-Options.html#ARC-Options"/><topic label="ARM Options" href="doc/gcc/ARM-Options.html#ARM-Options"/><topic label="AVR Options" href="doc/gcc/AVR-Options.html#AVR-Options">
# <topic label="EIND and Devices with more than 128 Ki Bytes of Flash" href="doc/gcc/AVR-Options.html#AVR-Options"/><topic label="Handling of the RAMPD, RAMPX, RAMPY and RAMPZ Special Function Registers" href="doc/gcc/AVR-Options.html#AVR-Options"/><topic label="AVR Built-in Macros" href="doc/gcc/AVR-Options.html#AVR-Options"/></topic><topic label="Blackfin Options" href="doc/gcc/Blackfin-Options.html#Blackfin-Options"/><topic label="C6X Options" href="doc/gcc/C6X-Options.html#C6X-Options"/><topic label="CRIS Options" href="doc/gcc/CRIS-Options.html#CRIS-Options"/><topic label="CR16 Options" href="doc/gcc/CR16-Options.html#CR16-Options"/><topic label="Darwin Options" href="doc/gcc/Darwin-Options.html#Darwin-Options"/><topic label="DEC Alpha Options" href="doc/gcc/DEC-Alpha-Options.html#DEC-Alpha-Options"/><topic label="FR30 Options" href="doc/gcc/FR30-Options.html#FR30-Options"/><topic label="FRV Options" href="doc/gcc/FRV-Options.html#FRV-Options"/><topic label="GNU/Linux Options" href="doc/gcc/GNU_002fLinux-Options.html#GNU_002fLinux-Options"/><topic label="H8/300 Options" href="doc/gcc/H8_002f300-Options.html#H8_002f300-Options"/><topic label="HPPA Options" href="doc/gcc/HPPA-Options.html#HPPA-Options"/><topic label="Intel 386 and AMD x86-64 Options" href="doc/gcc/i386-and-x86_002d64-Options.html#i386-and-x86_002d64-Options"/><topic label="i386 and x86-64 Windows Options" href="doc/gcc/i386-and-x86_002d64-Windows-Options.html#i386-and-x86_002d64-Windows-Options"/><topic label="IA-64 Options" href="doc/gcc/IA_002d64-Options.html#IA_002d64-Options"/><topic label="LM32 Options" href="doc/gcc/LM32-Options.html#LM32-Options"/><topic label="M32C Options" href="doc/gcc/M32C-Options.html#M32C-Options"/><topic label="M32R/D Options" href="doc/gcc/M32R_002fD-Options.html#M32R_002fD-Options"/><topic label="M680x0 Options" href="doc/gcc/M680x0-Options.html#M680x0-Options"/><topic label="MCore Options" href="doc/gcc/MCore-Options.html#MCore-Options"/><topic label="MeP Options" href="doc/gcc/MeP-Options.html#MeP-Options"/><topic label="MicroBlaze Options" href="doc/gcc/MicroBlaze-Options.html#MicroBlaze-Options"/><topic label="MIPS Options" href="doc/gcc/MIPS-Options.html#MIPS-Options"/><topic label="MMIX Options" href="doc/gcc/MMIX-Options.html#MMIX-Options"/><topic label="MN10300 Options" href="doc/gcc/MN10300-Options.html#MN10300-Options"/><topic label="Moxie Options" href="doc/gcc/Moxie-Options.html#Moxie-Options"/><topic label="MSP430 Options" href="doc/gcc/MSP430-Options.html#MSP430-Options"/><topic label="NDS32 Options" href="doc/gcc/NDS32-Options.html#NDS32-Options"/><topic label="Nios II Options" href="doc/gcc/Nios-II-Options.html#Nios-II-Options"/><topic label="PDP-11 Options" href="doc/gcc/PDP_002d11-Options.html#PDP_002d11-Options"/><topic label="picoChip Options" href="doc/gcc/picoChip-Options.html#picoChip-Options"/><topic label="PowerPC Options" href="doc/gcc/PowerPC-Options.html#PowerPC-Options"/><topic label="RL78 Options" href="doc/gcc/RL78-Options.html#RL78-Options"/><topic label="IBM RS/6000 and PowerPC Options" href="doc/gcc/RS_002f6000-and-PowerPC-Options.html#RS_002f6000-and-PowerPC-Options"/><topic label="RX Options" href="doc/gcc/RX-Options.html#RX-Options"/><topic label="S/390 and zSeries Options" href="doc/gcc/S_002f390-and-zSeries-Options.html#S_002f390-and-zSeries-Options"/><topic label="Score Options" href="doc/gcc/Score-Options.html#Score-Options"/><topic label="SH Options" href="doc/gcc/SH-Options.html#SH-Options"/><topic label="Solaris 2 Options" href="doc/gcc/Solaris-2-Options.html#Solaris-2-Options"/><topic label="SPARC Options" href="doc/gcc/SPARC-Options.html#SPARC-Options"/><topic label="SPU Options" href="doc/gcc/SPU-Options.html#SPU-Options"/><topic label="Options for System V" href="doc/gcc/System-V-Options.html#System-V-Options"/><topic label="TILE-Gx Options" href="doc/gcc/TILE_002dGx-Options.html#TILE_002dGx-Options"/><topic label="TILEPro Options" href="doc/gcc/TILEPro-Options.html#TILEPro-Options"/><topic label="V850 Options" href="doc/gcc/V850-Options.html#V850-Options"/><topic label="VAX Options" href="doc/gcc/VAX-Options.html#VAX-Options"/><topic label="VMS Options" href="doc/gcc/VMS-Options.html#VMS-Options"/><topic label="VxWorks Options" href="doc/gcc/VxWorks-Options.html#VxWorks-Options"/><topic label="x86-64 Options" href="doc/gcc/x86_002d64-Options.html#x86_002d64-Options"/><topic label="Xstormy16 Options" href="doc/gcc/Xstormy16-Options.html#Xstormy16-Options"/><topic label="Xtensa Options" href="doc/gcc/Xtensa-Options.html#Xtensa-Options"/><topic label="zSeries Options" href="doc/gcc/zSeries-Options.html#zSeries-Options"/></topic><topic label="Options for Code Generation Conventions" href="doc/gcc/Code-Gen-Options.html#Code-Gen-Options"/><topic label="Environment Variables Affecting GCC" href="doc/gcc/Environment-Variables.html#Environment-Variables"/><topic label="Using Precompiled Headers" href="doc/gcc/Precompiled-Headers.html#Precompiled-Headers"/></topic><topic label="C Implementation-defined behavior" href="doc/gcc/C-Implementation.html#C-Implementation">
# <topic label="Translation" href="doc/gcc/Translation-implementation.html#Translation-implementation"/><topic label="Environment" href="doc/gcc/Environment-implementation.html#Environment-implementation"/><topic label="Identifiers" href="doc/gcc/Identifiers-implementation.html#Identifiers-implementation"/><topic label="Characters" href="doc/gcc/Characters-implementation.html#Characters-implementation"/><topic label="Integers" href="doc/gcc/Integers-implementation.html#Integers-implementation"/><topic label="Floating point" href="doc/gcc/Floating-point-implementation.html#Floating-point-implementation"/><topic label="Arrays and pointers" href="doc/gcc/Arrays-and-pointers-implementation.html#Arrays-and-pointers-implementation"/><topic label="Hints" href="doc/gcc/Hints-implementation.html#Hints-implementation"/><topic label="Structures, unions, enumerations, and bit-fields" href="doc/gcc/Structures-unions-enumerations-and-bit_002dfields-implementation.html#Structures-unions-enumerations-and-bit_002dfields-implementation"/><topic label="Qualifiers" href="doc/gcc/Qualifiers-implementation.html#Qualifiers-implementation"/><topic label="Declarators" href="doc/gcc/Declarators-implementation.html#Declarators-implementation"/><topic label="Statements" href="doc/gcc/Statements-implementation.html#Statements-implementation"/><topic label="Preprocessing directives" href="doc/gcc/Preprocessing-directives-implementation.html#Preprocessing-directives-implementation"/><topic label="Library functions" href="doc/gcc/Library-functions-implementation.html#Library-functions-implementation"/><topic label="Architecture" href="doc/gcc/Architecture-implementation.html#Architecture-implementation"/><topic label="Locale-specific behavior" href="doc/gcc/Locale_002dspecific-behavior-implementation.html#Locale_002dspecific-behavior-implementation"/></topic><topic label="C++ Implementation-defined behavior" href="doc/gcc/C_002b_002b-Implementation.html#C_002b_002b-Implementation">
# <topic label="Conditionally-supported behavior" href="doc/gcc/Conditionally_002dsupported-behavior.html#Conditionally_002dsupported-behavior"/><topic label="Exception handling" href="doc/gcc/Exception-handling.html#Exception-handling"/></topic><topic label="Extensions to the C Language Family" href="doc/gcc/C-Extensions.html#C-Extensions">
# <topic label="Statements and Declarations in Expressions" href="doc/gcc/Statement-Exprs.html#Statement-Exprs"/><topic label="Locally Declared Labels" href="doc/gcc/Local-Labels.html#Local-Labels"/><topic label="Labels as Values" href="doc/gcc/Labels-as-Values.html#Labels-as-Values"/><topic label="Nested Functions" href="doc/gcc/Nested-Functions.html#Nested-Functions"/><topic label="Constructing Function Calls" href="doc/gcc/Constructing-Calls.html#Constructing-Calls"/><topic label="Referring to a Type with typeof" href="doc/gcc/Typeof.html#Typeof"/><topic label="Conditionals with Omitted Operands" href="doc/gcc/Conditionals.html#Conditionals"/><topic label="128-bit integers" href="doc/gcc/_005f_005fint128.html#_005f_005fint128"/><topic label="Double-Word Integers" href="doc/gcc/Long-Long.html#Long-Long"/><topic label="Complex Numbers" href="doc/gcc/Complex.html#Complex"/><topic label="Additional Floating Types" href="doc/gcc/Floating-Types.html#Floating-Types"/><topic label="Half-Precision Floating Point" href="doc/gcc/Half_002dPrecision.html#Half_002dPrecision"/><topic label="Decimal Floating Types" href="doc/gcc/Decimal-Float.html#Decimal-Float"/><topic label="Hex Floats" href="doc/gcc/Hex-Floats.html#Hex-Floats"/><topic label="Fixed-Point Types" href="doc/gcc/Fixed_002dPoint.html#Fixed_002dPoint"/><topic label="Named Address Spaces" href="doc/gcc/Named-Address-Spaces.html#Named-Address-Spaces">
# <topic label="AVR Named Address Spaces" href="doc/gcc/Named-Address-Spaces.html#Named-Address-Spaces"/><topic label="M32C Named Address Spaces" href="doc/gcc/Named-Address-Spaces.html#Named-Address-Spaces"/><topic label="RL78 Named Address Spaces" href="doc/gcc/Named-Address-Spaces.html#Named-Address-Spaces"/><topic label="SPU Named Address Spaces" href="doc/gcc/Named-Address-Spaces.html#Named-Address-Spaces"/></topic><topic label="Arrays of Length Zero" href="doc/gcc/Zero-Length.html#Zero-Length"/><topic label="Structures With No Members" href="doc/gcc/Empty-Structures.html#Empty-Structures"/><topic label="Arrays of Variable Length" href="doc/gcc/Variable-Length.html#Variable-Length"/><topic label="Macros with a Variable Number of Arguments." href="doc/gcc/Variadic-Macros.html#Variadic-Macros"/><topic label="Slightly Looser Rules for Escaped Newlines" href="doc/gcc/Escaped-Newlines.html#Escaped-Newlines"/><topic label="Non-Lvalue Arrays May Have Subscripts" href="doc/gcc/Subscripting.html#Subscripting"/><topic label="Arithmetic on void- and Function-Pointers" href="doc/gcc/Pointer-Arith.html#Pointer-Arith"/><topic label="Non-Constant Initializers" href="doc/gcc/Initializers.html#Initializers"/><topic label="Compound Literals" href="doc/gcc/Compound-Literals.html#Compound-Literals"/><topic label="Designated Initializers" href="doc/gcc/Designated-Inits.html#Designated-Inits"/><topic label="Case Ranges" href="doc/gcc/Case-Ranges.html#Case-Ranges"/><topic label="Cast to a Union Type" href="doc/gcc/Cast-to-Union.html#Cast-to-Union"/><topic label="Mixed Declarations and Code" href="doc/gcc/Mixed-Declarations.html#Mixed-Declarations"/><topic label="Declaring Attributes of Functions" href="doc/gcc/Function-Attributes.html#Function-Attributes"/><topic label="Attribute Syntax" href="doc/gcc/Attribute-Syntax.html#Attribute-Syntax"/><topic label="Prototypes and Old-Style Function Definitions" href="doc/gcc/Function-Prototypes.html#Function-Prototypes"/><topic label="C++ Style Comments" href="doc/gcc/C_002b_002b-Comments.html#C_002b_002b-Comments"/><topic label="Dollar Signs in Identifier Names" href="doc/gcc/Dollar-Signs.html#Dollar-Signs"/><topic label="The Character &lt;ESC&gt; in Constants" href="doc/gcc/Character-Escapes.html#Character-Escapes"/><topic label="Specifying Attributes of Variables" href="doc/gcc/Variable-Attributes.html#Variable-Attributes">
# <topic label="AVR Variable Attributes" href="doc/gcc/Variable-Attributes.html#Variable-Attributes"/><topic label="Blackfin Variable Attributes" href="doc/gcc/Variable-Attributes.html#Variable-Attributes"/><topic label="M32R/D Variable Attributes" href="doc/gcc/Variable-Attributes.html#Variable-Attributes"/><topic label="MeP Variable Attributes" href="doc/gcc/Variable-Attributes.html#Variable-Attributes"/><topic label="i386 Variable Attributes" href="doc/gcc/Variable-Attributes.html#Variable-Attributes"/><topic label="PowerPC Variable Attributes" href="doc/gcc/Variable-Attributes.html#Variable-Attributes"/><topic label="SPU Variable Attributes" href="doc/gcc/Variable-Attributes.html#Variable-Attributes"/><topic label="Xstormy16 Variable Attributes" href="doc/gcc/Variable-Attributes.html#Variable-Attributes"/></topic><topic label="Specifying Attributes of Types" href="doc/gcc/Type-Attributes.html#Type-Attributes">
# <topic label="ARM Type Attributes" href="doc/gcc/Type-Attributes.html#Type-Attributes"/><topic label="MeP Type Attributes" href="doc/gcc/Type-Attributes.html#Type-Attributes"/><topic label="i386 Type Attributes" href="doc/gcc/Type-Attributes.html#Type-Attributes"/><topic label="PowerPC Type Attributes" href="doc/gcc/Type-Attributes.html#Type-Attributes"/><topic label="SPU Type Attributes" href="doc/gcc/Type-Attributes.html#Type-Attributes"/></topic><topic label="Inquiring on Alignment of Types or Variables" href="doc/gcc/Alignment.html#Alignment"/><topic label="An Inline Function is As Fast As a Macro" href="doc/gcc/Inline.html#Inline"/><topic label="When is a Volatile Object Accessed?" href="doc/gcc/Volatiles.html#Volatiles"/><topic label="Assembler Instructions with C Expression Operands" href="doc/gcc/Extended-Asm.html#Extended-Asm">
# <topic label="Size of an asm" href="doc/gcc/Extended-Asm.html#Extended-Asm"/><topic label="i386 floating-point asm operands" href="doc/gcc/Extended-Asm.html#Extended-Asm"/></topic><topic label="Constraints for asm Operands" href="doc/gcc/Constraints.html#Constraints">
# <topic label="Simple Constraints" href="doc/gcc/Simple-Constraints.html#Simple-Constraints"/><topic label="Multiple Alternative Constraints" href="doc/gcc/Multi_002dAlternative.html#Multi_002dAlternative"/><topic label="Constraint Modifier Characters" href="doc/gcc/Modifiers.html#Modifiers"/><topic label="Constraints for Particular Machines" href="doc/gcc/Machine-Constraints.html#Machine-Constraints"/></topic><topic label="Controlling Names Used in Assembler Code" href="doc/gcc/Asm-Labels.html#Asm-Labels"/><topic label="Variables in Specified Registers" href="doc/gcc/Explicit-Reg-Vars.html#Explicit-Reg-Vars">
# <topic label="Defining Global Register Variables" href="doc/gcc/Global-Reg-Vars.html#Global-Reg-Vars"/><topic label="Specifying Registers for Local Variables" href="doc/gcc/Local-Reg-Vars.html#Local-Reg-Vars"/></topic><topic label="Alternate Keywords" href="doc/gcc/Alternate-Keywords.html#Alternate-Keywords"/><topic label="Incomplete enum Types" href="doc/gcc/Incomplete-Enums.html#Incomplete-Enums"/><topic label="Function Names as Strings" href="doc/gcc/Function-Names.html#Function-Names"/><topic label="Getting the Return or Frame Address of a Function" href="doc/gcc/Return-Address.html#Return-Address"/><topic label="Using Vector Instructions through Built-in Functions" href="doc/gcc/Vector-Extensions.html#Vector-Extensions"/><topic label="Offsetof" href="doc/gcc/Offsetof.html#Offsetof"/><topic label="Legacy __sync Built-in Functions for Atomic Memory Access" href="doc/gcc/_005f_005fsync-Builtins.html#_005f_005fsync-Builtins"/><topic label="Built-in functions for memory model aware atomic operations" href="doc/gcc/_005f_005fatomic-Builtins.html#_005f_005fatomic-Builtins"/><topic label="x86 specific memory model extensions for transactional memory" href="doc/gcc/x86-specific-memory-model-extensions-for-transactional-memory.html#x86-specific-memory-model-extensions-for-transactional-memory"/><topic label="Object Size Checking Built-in Functions" href="doc/gcc/Object-Size-Checking.html#Object-Size-Checking"/><topic label="Cilk Plus C/C++ language extension Built-in Functions." href="doc/gcc/Cilk-Plus-Builtins.html#Cilk-Plus-Builtins"/><topic label="Other Built-in Functions Provided by GCC" href="doc/gcc/Other-Builtins.html#Other-Builtins"/><topic label="Built-in Functions Specific to Particular Target Machines" href="doc/gcc/Target-Builtins.html#Target-Builtins">
# <topic label="Alpha Built-in Functions" href="doc/gcc/Alpha-Built_002din-Functions.html#Alpha-Built_002din-Functions"/><topic label="Altera Nios II Built-in Functions" href="doc/gcc/Altera-Nios-II-Built_002din-Functions.html#Altera-Nios-II-Built_002din-Functions"/><topic label="ARC Built-in Functions" href="doc/gcc/ARC-Built_002din-Functions.html#ARC-Built_002din-Functions"/><topic label="ARC SIMD Built-in Functions" href="doc/gcc/ARC-SIMD-Built_002din-Functions.html#ARC-SIMD-Built_002din-Functions"/><topic label="ARM iWMMXt Built-in Functions" href="doc/gcc/ARM-iWMMXt-Built_002din-Functions.html#ARM-iWMMXt-Built_002din-Functions"/><topic label="ARM NEON Intrinsics" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics">
# <topic label="Addition" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Multiplication" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Multiply-accumulate" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Multiply-subtract" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Fused-multiply-accumulate" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Fused-multiply-subtract" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Round to integral (to nearest, ties to even)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Round to integral (to nearest, ties away from zero)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Round to integral (towards +Inf)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Round to integral (towards -Inf)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Round to integral (towards 0)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Subtraction" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Comparison (equal-to)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Comparison (greater-than-or-equal-to)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Comparison (less-than-or-equal-to)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Comparison (greater-than)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Comparison (less-than)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Comparison (absolute greater-than-or-equal-to)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Comparison (absolute less-than-or-equal-to)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Comparison (absolute greater-than)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Comparison (absolute less-than)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Test bits" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Absolute difference" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Absolute difference and accumulate" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Maximum" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Minimum" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Pairwise add" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Pairwise add, single_opcode widen and accumulate" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Folding maximum" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Folding minimum" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Reciprocal step" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector shift left" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector shift left by constant" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector shift right by constant" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector shift right by constant and accumulate" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector shift right and insert" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector shift left and insert" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Absolute value" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Negation" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Bitwise not" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Count leading sign bits" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Count leading zeros" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Count number of set bits" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Reciprocal estimate" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Reciprocal square-root estimate" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Get lanes from a vector" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Set lanes in a vector" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Create vector from literal bit pattern" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Set all lanes to the same value" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Combining vectors" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Splitting vectors" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Conversions" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Move, single_opcode narrowing" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Move, single_opcode long" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Table lookup" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Extended table lookup" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Multiply, lane" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Long multiply, lane" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Saturating doubling long multiply, lane" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Saturating doubling multiply high, lane" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Multiply-accumulate, lane" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Multiply-subtract, lane" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector multiply by scalar" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector long multiply by scalar" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector saturating doubling long multiply by scalar" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector saturating doubling multiply high by scalar" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector multiply-accumulate by scalar" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector multiply-subtract by scalar" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Vector extract" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Reverse elements" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Bit selection" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Transpose elements" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Zip elements" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Unzip elements" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Element/structure loads, VLD1 variants" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Element/structure stores, VST1 variants" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Element/structure loads, VLD2 variants" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Element/structure stores, VST2 variants" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Element/structure loads, VLD3 variants" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Element/structure stores, VST3 variants" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Element/structure loads, VLD4 variants" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Element/structure stores, VST4 variants" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Logical operations (AND)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Logical operations (OR)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Logical operations (exclusive OR)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Logical operations (AND-NOT)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Logical operations (OR-NOT)" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/><topic label="Reinterpret casts" href="doc/gcc/ARM-NEON-Intrinsics.html#ARM-NEON-Intrinsics"/></topic><topic label="ARM ACLE Intrinsics" href="doc/gcc/ARM-ACLE-Intrinsics.html#ARM-ACLE-Intrinsics">
# <topic label="CRC32 intrinsics" href="doc/gcc/ARM-ACLE-Intrinsics.html#ARM-ACLE-Intrinsics"/></topic><topic label="ARM Floating Point Status and Control Intrinsics" href="doc/gcc/ARM-Floating-Point-Status-and-Control-Intrinsics.html#ARM-Floating-Point-Status-and-Control-Intrinsics"/><topic label="AVR Built-in Functions" href="doc/gcc/AVR-Built_002din-Functions.html#AVR-Built_002din-Functions"/><topic label="Blackfin Built-in Functions" href="doc/gcc/Blackfin-Built_002din-Functions.html#Blackfin-Built_002din-Functions"/><topic label="FR-V Built-in Functions" href="doc/gcc/FR_002dV-Built_002din-Functions.html#FR_002dV-Built_002din-Functions">
# <topic label="Argument Types" href="doc/gcc/Argument-Types.html#Argument-Types"/><topic label="Directly-mapped Integer Functions" href="doc/gcc/Directly_002dmapped-Integer-Functions.html#Directly_002dmapped-Integer-Functions"/><topic label="Directly-mapped Media Functions" href="doc/gcc/Directly_002dmapped-Media-Functions.html#Directly_002dmapped-Media-Functions"/><topic label="Raw read/write Functions" href="doc/gcc/Raw-read_002fwrite-Functions.html#Raw-read_002fwrite-Functions"/><topic label="Other Built-in Functions" href="doc/gcc/Other-Built_002din-Functions.html#Other-Built_002din-Functions"/></topic><topic label="X86 Built-in Functions" href="doc/gcc/X86-Built_002din-Functions.html#X86-Built_002din-Functions"/><topic label="X86 transaction memory intrinsics" href="doc/gcc/X86-transactional-memory-intrinsics.html#X86-transactional-memory-intrinsics"/><topic label="MIPS DSP Built-in Functions" href="doc/gcc/MIPS-DSP-Built_002din-Functions.html#MIPS-DSP-Built_002din-Functions"/><topic label="MIPS Paired-Single Support" href="doc/gcc/MIPS-Paired_002dSingle-Support.html#MIPS-Paired_002dSingle-Support"/><topic label="MIPS Loongson Built-in Functions" href="doc/gcc/MIPS-Loongson-Built_002din-Functions.html#MIPS-Loongson-Built_002din-Functions">
# <topic label="Paired-Single Arithmetic" href="doc/gcc/Paired_002dSingle-Arithmetic.html#Paired_002dSingle-Arithmetic"/><topic label="Paired-Single Built-in Functions" href="doc/gcc/Paired_002dSingle-Built_002din-Functions.html#Paired_002dSingle-Built_002din-Functions"/><topic label="MIPS-3D Built-in Functions" href="doc/gcc/MIPS_002d3D-Built_002din-Functions.html#MIPS_002d3D-Built_002din-Functions"/></topic><topic label="Other MIPS Built-in Functions" href="doc/gcc/Other-MIPS-Built_002din-Functions.html#Other-MIPS-Built_002din-Functions"/><topic label="MSP430 Built-in Functions" href="doc/gcc/MSP430-Built_002din-Functions.html#MSP430-Built_002din-Functions"/><topic label="NDS32 Built-in Functions" href="doc/gcc/NDS32-Built_002din-Functions.html#NDS32-Built_002din-Functions"/><topic label="picoChip Built-in Functions" href="doc/gcc/picoChip-Built_002din-Functions.html#picoChip-Built_002din-Functions"/><topic label="PowerPC Built-in Functions" href="doc/gcc/PowerPC-Built_002din-Functions.html#PowerPC-Built_002din-Functions"/><topic label="PowerPC AltiVec Built-in Functions" href="doc/gcc/PowerPC-AltiVec_002fVSX-Built_002din-Functions.html#PowerPC-AltiVec_002fVSX-Built_002din-Functions"/><topic label="PowerPC Hardware Transactional Memory Built-in Functions" href="doc/gcc/PowerPC-Hardware-Transactional-Memory-Built_002din-Functions.html#PowerPC-Hardware-Transactional-Memory-Built_002din-Functions">
# <topic label="PowerPC HTM Low Level Built-in Functions" href="doc/gcc/PowerPC-Hardware-Transactional-Memory-Built_002din-Functions.html#PowerPC-Hardware-Transactional-Memory-Built_002din-Functions"/><topic label="PowerPC HTM High Level Inline Functions" href="doc/gcc/PowerPC-Hardware-Transactional-Memory-Built_002din-Functions.html#PowerPC-Hardware-Transactional-Memory-Built_002din-Functions"/></topic><topic label="RX Built-in Functions" href="doc/gcc/RX-Built_002din-Functions.html#RX-Built_002din-Functions"/><topic label="S/390 System z Built-in Functions" href="doc/gcc/S_002f390-System-z-Built_002din-Functions.html#S_002f390-System-z-Built_002din-Functions"/><topic label="SH Built-in Functions" href="doc/gcc/SH-Built_002din-Functions.html#SH-Built_002din-Functions"/><topic label="SPARC VIS Built-in Functions" href="doc/gcc/SPARC-VIS-Built_002din-Functions.html#SPARC-VIS-Built_002din-Functions"/><topic label="SPU Built-in Functions" href="doc/gcc/SPU-Built_002din-Functions.html#SPU-Built_002din-Functions"/><topic label="TI C6X Built-in Functions" href="doc/gcc/TI-C6X-Built_002din-Functions.html#TI-C6X-Built_002din-Functions"/><topic label="TILE-Gx Built-in Functions" href="doc/gcc/TILE_002dGx-Built_002din-Functions.html#TILE_002dGx-Built_002din-Functions"/><topic label="TILEPro Built-in Functions" href="doc/gcc/TILEPro-Built_002din-Functions.html#TILEPro-Built_002din-Functions"/></topic><topic label="Format Checks Specific to Particular Target Machines" href="doc/gcc/Target-Format-Checks.html#Target-Format-Checks">
# <topic label="Solaris Format Checks" href="doc/gcc/Solaris-Format-Checks.html#Solaris-Format-Checks"/><topic label="Darwin Format Checks" href="doc/gcc/Darwin-Format-Checks.html#Darwin-Format-Checks"/></topic><topic label="Pragmas Accepted by GCC" href="doc/gcc/Pragmas.html#Pragmas">
# <topic label="ARM Pragmas" href="doc/gcc/ARM-Pragmas.html#ARM-Pragmas"/><topic label="M32C Pragmas" href="doc/gcc/M32C-Pragmas.html#M32C-Pragmas"/><topic label="MeP Pragmas" href="doc/gcc/MeP-Pragmas.html#MeP-Pragmas"/><topic label="RS/6000 and PowerPC Pragmas" href="doc/gcc/RS_002f6000-and-PowerPC-Pragmas.html#RS_002f6000-and-PowerPC-Pragmas"/><topic label="Darwin Pragmas" href="doc/gcc/Darwin-Pragmas.html#Darwin-Pragmas"/><topic label="Solaris Pragmas" href="doc/gcc/Solaris-Pragmas.html#Solaris-Pragmas"/><topic label="Symbol-Renaming Pragmas" href="doc/gcc/Symbol_002dRenaming-Pragmas.html#Symbol_002dRenaming-Pragmas"/><topic label="Structure-Packing Pragmas" href="doc/gcc/Structure_002dPacking-Pragmas.html#Structure_002dPacking-Pragmas"/><topic label="Weak Pragmas" href="doc/gcc/Weak-Pragmas.html#Weak-Pragmas"/><topic label="Diagnostic Pragmas" href="doc/gcc/Diagnostic-Pragmas.html#Diagnostic-Pragmas"/><topic label="Visibility Pragmas" href="doc/gcc/Visibility-Pragmas.html#Visibility-Pragmas"/><topic label="Push/Pop Macro Pragmas" href="doc/gcc/Push_002fPop-Macro-Pragmas.html#Push_002fPop-Macro-Pragmas"/><topic label="Function Specific Option Pragmas" href="doc/gcc/Function-Specific-Option-Pragmas.html#Function-Specific-Option-Pragmas"/><topic label="Loop-Specific Pragmas" href="doc/gcc/Loop_002dSpecific-Pragmas.html#Loop_002dSpecific-Pragmas"/></topic><topic label="Unnamed struct/union fields within structs/unions" href="doc/gcc/Unnamed-Fields.html#Unnamed-Fields"/><topic label="Thread-Local Storage" href="doc/gcc/Thread_002dLocal.html#Thread_002dLocal">
# <topic label="ISO/IEC 9899:1999 Edits for Thread-Local Storage" href="doc/gcc/C99-Thread_002dLocal-Edits.html#C99-Thread_002dLocal-Edits"/><topic label="ISO/IEC 14882:1998 Edits for Thread-Local Storage" href="doc/gcc/C_002b_002b98-Thread_002dLocal-Edits.html#C_002b_002b98-Thread_002dLocal-Edits"/></topic><topic label="Binary constants using the &#x2018;0b&#x2019; prefix" href="doc/gcc/Binary-constants.html#Binary-constants"/></topic><topic label="Extensions to the C++ Language" href="doc/gcc/C_002b_002b-Extensions.html#C_002b_002b-Extensions">
# <topic label="When is a Volatile C++ Object Accessed?" href="doc/gcc/C_002b_002b-Volatiles.html#C_002b_002b-Volatiles"/><topic label="Restricting Pointer Aliasing" href="doc/gcc/Restricted-Pointers.html#Restricted-Pointers"/><topic label="Vague Linkage" href="doc/gcc/Vague-Linkage.html#Vague-Linkage"/><topic label="#pragma interface and implementation" href="doc/gcc/C_002b_002b-Interface.html#C_002b_002b-Interface"/><topic label="Where's the Template?" href="doc/gcc/Template-Instantiation.html#Template-Instantiation"/><topic label="Extracting the function pointer from a bound pointer to member function" href="doc/gcc/Bound-member-functions.html#Bound-member-functions"/><topic label="C++-Specific Variable, Function, and Type Attributes" href="doc/gcc/C_002b_002b-Attributes.html#C_002b_002b-Attributes"/><topic label="Function Multiversioning" href="doc/gcc/Function-Multiversioning.html#Function-Multiversioning"/><topic label="Namespace Association" href="doc/gcc/Namespace-Association.html#Namespace-Association"/><topic label="Type Traits" href="doc/gcc/Type-Traits.html#Type-Traits"/><topic label="Java Exceptions" href="doc/gcc/Java-Exceptions.html#Java-Exceptions"/><topic label="Deprecated Features" href="doc/gcc/Deprecated-Features.html#Deprecated-Features"/><topic label="Backwards Compatibility" href="doc/gcc/Backwards-Compatibility.html#Backwards-Compatibility"/></topic><topic label="GNU Objective-C features" href="doc/gcc/Objective_002dC.html#Objective_002dC">
# <topic label="GNU Objective-C runtime API" href="doc/gcc/GNU-Objective_002dC-runtime-API.html#GNU-Objective_002dC-runtime-API">
# <topic label="Modern GNU Objective-C runtime API" href="doc/gcc/Modern-GNU-Objective_002dC-runtime-API.html#Modern-GNU-Objective_002dC-runtime-API"/><topic label="Traditional GNU Objective-C runtime API" href="doc/gcc/Traditional-GNU-Objective_002dC-runtime-API.html#Traditional-GNU-Objective_002dC-runtime-API"/></topic><topic label="+load: Executing code before main" href="doc/gcc/Executing-code-before-main.html#Executing-code-before-main">
# <topic label="What you can and what you cannot do in +load" href="doc/gcc/What-you-can-and-what-you-cannot-do-in-_002bload.html#What-you-can-and-what-you-cannot-do-in-_002bload"/></topic><topic label="Type encoding" href="doc/gcc/Type-encoding.html#Type-encoding">
# <topic label="Legacy type encoding" href="doc/gcc/Legacy-type-encoding.html#Legacy-type-encoding"/><topic label="@encode" href="doc/gcc/_0040encode.html#_0040encode"/><topic label="Method signatures" href="doc/gcc/Method-signatures.html#Method-signatures"/></topic><topic label="Garbage Collection" href="doc/gcc/Garbage-Collection.html#Garbage-Collection"/><topic label="Constant string objects" href="doc/gcc/Constant-string-objects.html#Constant-string-objects"/><topic label="compatibility_alias" href="doc/gcc/compatibility_005falias.html#compatibility_005falias"/><topic label="Exceptions" href="doc/gcc/Exceptions.html#Exceptions"/><topic label="Synchronization" href="doc/gcc/Synchronization.html#Synchronization"/><topic label="Fast enumeration" href="doc/gcc/Fast-enumeration.html#Fast-enumeration">
# <topic label="Using fast enumeration" href="doc/gcc/Using-fast-enumeration.html#Using-fast-enumeration"/><topic label="c99-like fast enumeration syntax" href="doc/gcc/c99_002dlike-fast-enumeration-syntax.html#c99_002dlike-fast-enumeration-syntax"/><topic label="Fast enumeration details" href="doc/gcc/Fast-enumeration-details.html#Fast-enumeration-details"/><topic label="Fast enumeration protocol" href="doc/gcc/Fast-enumeration-protocol.html#Fast-enumeration-protocol"/></topic><topic label="Messaging with the GNU Objective-C runtime" href="doc/gcc/Messaging-with-the-GNU-Objective_002dC-runtime.html#Messaging-with-the-GNU-Objective_002dC-runtime">
# <topic label="Dynamically registering methods" href="doc/gcc/Dynamically-registering-methods.html#Dynamically-registering-methods"/><topic label="Forwarding hook" href="doc/gcc/Forwarding-hook.html#Forwarding-hook"/></topic></topic><topic label="Binary Compatibility" href="doc/gcc/Compatibility.html#Compatibility"/><topic label="gcov&#x2014;a Test Coverage Program" href="doc/gcc/Gcov.html#Gcov">
# <topic label="Introduction to gcov" href="doc/gcc/Gcov-Intro.html#Gcov-Intro"/><topic label="Invoking gcov" href="doc/gcc/Invoking-Gcov.html#Invoking-Gcov"/><topic label="Using gcov with GCC Optimization" href="doc/gcc/Gcov-and-Optimization.html#Gcov-and-Optimization"/><topic label="Brief description of gcov data files" href="doc/gcc/Gcov-Data-Files.html#Gcov-Data-Files"/><topic label="Data file relocation to support cross-profiling" href="doc/gcc/Cross_002dprofiling.html#Cross_002dprofiling"/></topic><topic label="Known Causes of Trouble with GCC" href="doc/gcc/Trouble.html#Trouble">
# <topic label="Actual Bugs We Haven't Fixed Yet" href="doc/gcc/Actual-Bugs.html#Actual-Bugs"/><topic label="Interoperation" href="doc/gcc/Interoperation.html#Interoperation"/><topic label="Incompatibilities of GCC" href="doc/gcc/Incompatibilities.html#Incompatibilities"/><topic label="Fixed Header Files" href="doc/gcc/Fixed-Headers.html#Fixed-Headers"/><topic label="Standard Libraries" href="doc/gcc/Standard-Libraries.html#Standard-Libraries"/><topic label="Disappointments and Misunderstandings" href="doc/gcc/Disappointments.html#Disappointments"/><topic label="Common Misunderstandings with GNU C++" href="doc/gcc/C_002b_002b-Misunderstandings.html#C_002b_002b-Misunderstandings">
# <topic label="Declare and Define Static Members" href="doc/gcc/Static-Definitions.html#Static-Definitions"/><topic label="Name lookup, templates, and accessing members of base classes" href="doc/gcc/Name-lookup.html#Name-lookup"/><topic label="Temporaries May Vanish Before You Expect" href="doc/gcc/Temporaries.html#Temporaries"/><topic label="Implicit Copy-Assignment for Virtual Bases" href="doc/gcc/Copy-Assignment.html#Copy-Assignment"/></topic><topic label="Certain Changes We Don't Want to Make" href="doc/gcc/Non_002dbugs.html#Non_002dbugs"/><topic label="Warning Messages and Error Messages" href="doc/gcc/Warnings-and-Errors.html#Warnings-and-Errors"/></topic><topic label="Reporting Bugs" href="doc/gcc/Bugs.html#Bugs">
# <topic label="Have You Found a Bug?" href="doc/gcc/Bug-Criteria.html#Bug-Criteria"/><topic label="How and where to Report Bugs" href="doc/gcc/Bug-Reporting.html#Bug-Reporting"/></topic><topic label="How To Get Help with GCC" href="doc/gcc/Service.html#Service"/><topic label="Contributing to GCC Development" href="doc/gcc/Contributing.html#Contributing"/><topic label="Funding Free Software" href="doc/gcc/Funding.html#Funding"/><topic label="The GNU Project and GNU/Linux" href="doc/gcc/GNU-Project.html#GNU-Project"/><topic label="GNU General Public License" href="doc/gcc/Copying.html#Copying"/><topic label="GNU Free Documentation License" href="doc/gcc/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License">
# <topic label="ADDENDUM: How to use this License for your documents" href="doc/gcc/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/></topic><topic label="Contributors to GCC" href="doc/gcc/Contributors.html#Contributors"/><topic label="Option Index" href="doc/gcc/Option-Index.html#Option-Index"/><topic label="Keyword Index" href="doc/gcc/Keyword-Index.html#Keyword-Index"/><topic label="G++ and GCC" href="doc/gcc/G_002b_002b-and-GCC.html#G_002b_002b-and-GCC"/><topic label="Standards" href="doc/gcc/Standards.html#Standards"/><topic label="Invoking GCC" href="doc/gcc/Invoking-GCC.html#Invoking-GCC"/><topic label="C Implementation" href="doc/gcc/C-Implementation.html#C-Implementation"/><topic label="C++ Implementation" href="doc/gcc/C_002b_002b-Implementation.html#C_002b_002b-Implementation"/><topic label="C Extensions" href="doc/gcc/C-Extensions.html#C-Extensions"/><topic label="C++ Extensions" href="doc/gcc/C_002b_002b-Extensions.html#C_002b_002b-Extensions"/><topic label="Objective-C" href="doc/gcc/Objective_002dC.html#Objective_002dC"/><topic label="Compatibility" href="doc/gcc/Compatibility.html#Compatibility"/><topic label="Gcov" href="doc/gcc/Gcov.html#Gcov"/><topic label="Trouble" href="doc/gcc/Trouble.html#Trouble"/><topic label="Bugs" href="doc/gcc/Bugs.html#Bugs"/><topic label="Service" href="doc/gcc/Service.html#Service"/><topic label="Contributing" href="doc/gcc/Contributing.html#Contributing"/><topic label="Funding" href="doc/gcc/Funding.html#Funding"/><topic label="GNU Project" href="doc/gcc/GNU-Project.html#GNU-Project"/><topic label="Copying" href="doc/gcc/Copying.html#Copying"/><topic label="GNU Free Documentation License" href="doc/gcc/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/><topic label="Contributors" href="doc/gcc/Contributors.html#Contributors"/><topic label="Option Index" href="doc/gcc/Option-Index.html#Option-Index"/><topic label="Keyword Index" href="doc/gcc/Keyword-Index.html#Keyword-Index"/>
# </topic>
# <topic label="Preprocessor (HTML)">
# <topic label="The C Preprocessor" href="doc/cpp/index.html#Top"/><topic label="Overview" href="doc/cpp/Overview.html#Overview">
# <topic label="Character sets" href="doc/cpp/Character-sets.html#Character-sets"/><topic label="Initial processing" href="doc/cpp/Initial-processing.html#Initial-processing"/><topic label="Tokenization" href="doc/cpp/Tokenization.html#Tokenization"/><topic label="The preprocessing language" href="doc/cpp/The-preprocessing-language.html#The-preprocessing-language"/></topic><topic label="Header Files" href="doc/cpp/Header-Files.html#Header-Files">
# <topic label="Include Syntax" href="doc/cpp/Include-Syntax.html#Include-Syntax"/><topic label="Include Operation" href="doc/cpp/Include-Operation.html#Include-Operation"/><topic label="Search Path" href="doc/cpp/Search-Path.html#Search-Path"/><topic label="Once-Only Headers" href="doc/cpp/Once_002dOnly-Headers.html#Once_002dOnly-Headers"/><topic label="Alternatives to Wrapper #ifndef" href="doc/cpp/Alternatives-to-Wrapper-_0023ifndef.html#Alternatives-to-Wrapper-_0023ifndef"/><topic label="Computed Includes" href="doc/cpp/Computed-Includes.html#Computed-Includes"/><topic label="Wrapper Headers" href="doc/cpp/Wrapper-Headers.html#Wrapper-Headers"/><topic label="System Headers" href="doc/cpp/System-Headers.html#System-Headers"/></topic><topic label="Macros" href="doc/cpp/Macros.html#Macros">
# <topic label="Object-like Macros" href="doc/cpp/Object_002dlike-Macros.html#Object_002dlike-Macros"/><topic label="Function-like Macros" href="doc/cpp/Function_002dlike-Macros.html#Function_002dlike-Macros"/><topic label="Macro Arguments" href="doc/cpp/Macro-Arguments.html#Macro-Arguments"/><topic label="Stringification" href="doc/cpp/Stringification.html#Stringification"/><topic label="Concatenation" href="doc/cpp/Concatenation.html#Concatenation"/><topic label="Variadic Macros" href="doc/cpp/Variadic-Macros.html#Variadic-Macros"/><topic label="Predefined Macros" href="doc/cpp/Predefined-Macros.html#Predefined-Macros">
# <topic label="Standard Predefined Macros" href="doc/cpp/Standard-Predefined-Macros.html#Standard-Predefined-Macros"/><topic label="Common Predefined Macros" href="doc/cpp/Common-Predefined-Macros.html#Common-Predefined-Macros"/><topic label="System-specific Predefined Macros" href="doc/cpp/System_002dspecific-Predefined-Macros.html#System_002dspecific-Predefined-Macros"/><topic label="C++ Named Operators" href="doc/cpp/C_002b_002b-Named-Operators.html#C_002b_002b-Named-Operators"/></topic><topic label="Undefining and Redefining Macros" href="doc/cpp/Undefining-and-Redefining-Macros.html#Undefining-and-Redefining-Macros"/><topic label="Directives Within Macro Arguments" href="doc/cpp/Directives-Within-Macro-Arguments.html#Directives-Within-Macro-Arguments"/><topic label="Macro Pitfalls" href="doc/cpp/Macro-Pitfalls.html#Macro-Pitfalls">
# <topic label="Misnesting" href="doc/cpp/Misnesting.html#Misnesting"/><topic label="Operator Precedence Problems" href="doc/cpp/Operator-Precedence-Problems.html#Operator-Precedence-Problems"/><topic label="Swallowing the Semicolon" href="doc/cpp/Swallowing-the-Semicolon.html#Swallowing-the-Semicolon"/><topic label="Duplication of Side Effects" href="doc/cpp/Duplication-of-Side-Effects.html#Duplication-of-Side-Effects"/><topic label="Self-Referential Macros" href="doc/cpp/Self_002dReferential-Macros.html#Self_002dReferential-Macros"/><topic label="Argument Prescan" href="doc/cpp/Argument-Prescan.html#Argument-Prescan"/><topic label="Newlines in Arguments" href="doc/cpp/Newlines-in-Arguments.html#Newlines-in-Arguments"/></topic></topic><topic label="Conditionals" href="doc/cpp/Conditionals.html#Conditionals">
# <topic label="Conditional Uses" href="doc/cpp/Conditional-Uses.html#Conditional-Uses"/><topic label="Conditional Syntax" href="doc/cpp/Conditional-Syntax.html#Conditional-Syntax">
# <topic label="Ifdef" href="doc/cpp/Ifdef.html#Ifdef"/><topic label="If" href="doc/cpp/If.html#If"/><topic label="Defined" href="doc/cpp/Defined.html#Defined"/><topic label="Else" href="doc/cpp/Else.html#Else"/><topic label="Elif" href="doc/cpp/Elif.html#Elif"/></topic><topic label="Deleted Code" href="doc/cpp/Deleted-Code.html#Deleted-Code"/></topic><topic label="Diagnostics" href="doc/cpp/Diagnostics.html#Diagnostics"/><topic label="Line Control" href="doc/cpp/Line-Control.html#Line-Control"/><topic label="Pragmas" href="doc/cpp/Pragmas.html#Pragmas"/><topic label="Other Directives" href="doc/cpp/Other-Directives.html#Other-Directives"/><topic label="Preprocessor Output" href="doc/cpp/Preprocessor-Output.html#Preprocessor-Output"/><topic label="Traditional Mode" href="doc/cpp/Traditional-Mode.html#Traditional-Mode">
# <topic label="Traditional lexical analysis" href="doc/cpp/Traditional-lexical-analysis.html#Traditional-lexical-analysis"/><topic label="Traditional macros" href="doc/cpp/Traditional-macros.html#Traditional-macros"/><topic label="Traditional miscellany" href="doc/cpp/Traditional-miscellany.html#Traditional-miscellany"/><topic label="Traditional warnings" href="doc/cpp/Traditional-warnings.html#Traditional-warnings"/></topic><topic label="Implementation Details" href="doc/cpp/Implementation-Details.html#Implementation-Details">
# <topic label="Implementation-defined behavior" href="doc/cpp/Implementation_002ddefined-behavior.html#Implementation_002ddefined-behavior"/><topic label="Implementation limits" href="doc/cpp/Implementation-limits.html#Implementation-limits"/><topic label="Obsolete Features" href="doc/cpp/Obsolete-Features.html#Obsolete-Features">
# <topic label="Assertions" href="doc/cpp/Obsolete-Features.html#Obsolete-Features"/></topic><topic label="Differences from previous versions" href="doc/cpp/Differences-from-previous-versions.html#Differences-from-previous-versions"/></topic><topic label="Invocation" href="doc/cpp/Invocation.html#Invocation"/><topic label="Environment Variables" href="doc/cpp/Environment-Variables.html#Environment-Variables"/><topic label="GNU Free Documentation License" href="doc/cpp/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License">
# <topic label="ADDENDUM: How to use this License for your documents" href="doc/cpp/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/></topic><topic label="Index of Directives" href="doc/cpp/Index-of-Directives.html#Index-of-Directives"/><topic label="Option Index" href="doc/cpp/Option-Index.html#Option-Index"/><topic label="Concept Index" href="doc/cpp/Concept-Index.html#Concept-Index"/><topic label="Overview" href="doc/cpp/Overview.html#Overview"/><topic label="Header Files" href="doc/cpp/Header-Files.html#Header-Files"/><topic label="Macros" href="doc/cpp/Macros.html#Macros"/><topic label="Conditionals" href="doc/cpp/Conditionals.html#Conditionals"/><topic label="Diagnostics" href="doc/cpp/Diagnostics.html#Diagnostics"/><topic label="Line Control" href="doc/cpp/Line-Control.html#Line-Control"/><topic label="Pragmas" href="doc/cpp/Pragmas.html#Pragmas"/><topic label="Other Directives" href="doc/cpp/Other-Directives.html#Other-Directives"/><topic label="Preprocessor Output" href="doc/cpp/Preprocessor-Output.html#Preprocessor-Output"/><topic label="Traditional Mode" href="doc/cpp/Traditional-Mode.html#Traditional-Mode"/><topic label="Implementation Details" href="doc/cpp/Implementation-Details.html#Implementation-Details"/><topic label="Invocation" href="doc/cpp/Invocation.html#Invocation"/><topic label="Environment Variables" href="doc/cpp/Environment-Variables.html#Environment-Variables"/><topic label="GNU Free Documentation License" href="doc/cpp/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/><topic label="Index of Directives" href="doc/cpp/Index-of-Directives.html#Index-of-Directives"/><topic label="Option Index" href="doc/cpp/Option-Index.html#Option-Index"/><topic label="Concept Index" href="doc/cpp/Concept-Index.html#Concept-Index"/><topic label="Character sets" href="doc/cpp/Character-sets.html#Character-sets"/><topic label="Initial processing" href="doc/cpp/Initial-processing.html#Initial-processing"/><topic label="Tokenization" href="doc/cpp/Tokenization.html#Tokenization"/><topic label="The preprocessing language" href="doc/cpp/The-preprocessing-language.html#The-preprocessing-language"/><topic label="Include Syntax" href="doc/cpp/Include-Syntax.html#Include-Syntax"/><topic label="Include Operation" href="doc/cpp/Include-Operation.html#Include-Operation"/><topic label="Search Path" href="doc/cpp/Search-Path.html#Search-Path"/><topic label="Once-Only Headers" href="doc/cpp/Once_002dOnly-Headers.html#Once_002dOnly-Headers"/><topic label="Alternatives to Wrapper #ifndef" href="doc/cpp/Alternatives-to-Wrapper-_0023ifndef.html#Alternatives-to-Wrapper-_0023ifndef"/><topic label="Computed Includes" href="doc/cpp/Computed-Includes.html#Computed-Includes"/><topic label="Wrapper Headers" href="doc/cpp/Wrapper-Headers.html#Wrapper-Headers"/><topic label="System Headers" href="doc/cpp/System-Headers.html#System-Headers"/><topic label="Object-like Macros" href="doc/cpp/Object_002dlike-Macros.html#Object_002dlike-Macros"/><topic label="Function-like Macros" href="doc/cpp/Function_002dlike-Macros.html#Function_002dlike-Macros"/><topic label="Macro Arguments" href="doc/cpp/Macro-Arguments.html#Macro-Arguments"/><topic label="Stringification" href="doc/cpp/Stringification.html#Stringification"/><topic label="Concatenation" href="doc/cpp/Concatenation.html#Concatenation"/><topic label="Variadic Macros" href="doc/cpp/Variadic-Macros.html#Variadic-Macros"/><topic label="Predefined Macros" href="doc/cpp/Predefined-Macros.html#Predefined-Macros"/><topic label="Undefining and Redefining Macros" href="doc/cpp/Undefining-and-Redefining-Macros.html#Undefining-and-Redefining-Macros"/><topic label="Directives Within Macro Arguments" href="doc/cpp/Directives-Within-Macro-Arguments.html#Directives-Within-Macro-Arguments"/><topic label="Macro Pitfalls" href="doc/cpp/Macro-Pitfalls.html#Macro-Pitfalls"/><topic label="Standard Predefined Macros" href="doc/cpp/Standard-Predefined-Macros.html#Standard-Predefined-Macros"/><topic label="Common Predefined Macros" href="doc/cpp/Common-Predefined-Macros.html#Common-Predefined-Macros"/><topic label="System-specific Predefined Macros" href="doc/cpp/System_002dspecific-Predefined-Macros.html#System_002dspecific-Predefined-Macros"/><topic label="C++ Named Operators" href="doc/cpp/C_002b_002b-Named-Operators.html#C_002b_002b-Named-Operators"/><topic label="Misnesting" href="doc/cpp/Misnesting.html#Misnesting"/><topic label="Operator Precedence Problems" href="doc/cpp/Operator-Precedence-Problems.html#Operator-Precedence-Problems"/><topic label="Swallowing the Semicolon" href="doc/cpp/Swallowing-the-Semicolon.html#Swallowing-the-Semicolon"/><topic label="Duplication of Side Effects" href="doc/cpp/Duplication-of-Side-Effects.html#Duplication-of-Side-Effects"/><topic label="Self-Referential Macros" href="doc/cpp/Self_002dReferential-Macros.html#Self_002dReferential-Macros"/><topic label="Argument Prescan" href="doc/cpp/Argument-Prescan.html#Argument-Prescan"/><topic label="Newlines in Arguments" href="doc/cpp/Newlines-in-Arguments.html#Newlines-in-Arguments"/><topic label="Conditional Uses" href="doc/cpp/Conditional-Uses.html#Conditional-Uses"/><topic label="Conditional Syntax" href="doc/cpp/Conditional-Syntax.html#Conditional-Syntax"/><topic label="Deleted Code" href="doc/cpp/Deleted-Code.html#Deleted-Code"/><topic label="Ifdef" href="doc/cpp/Ifdef.html#Ifdef"/><topic label="If" href="doc/cpp/If.html#If"/><topic label="Defined" href="doc/cpp/Defined.html#Defined"/><topic label="Else" href="doc/cpp/Else.html#Else"/><topic label="Elif" href="doc/cpp/Elif.html#Elif"/><topic label="Implementation-defined behavior" href="doc/cpp/Implementation_002ddefined-behavior.html#Implementation_002ddefined-behavior"/><topic label="Implementation limits" href="doc/cpp/Implementation-limits.html#Implementation-limits"/><topic label="Obsolete Features" href="doc/cpp/Obsolete-Features.html#Obsolete-Features"/><topic label="Differences from previous versions" href="doc/cpp/Differences-from-previous-versions.html#Differences-from-previous-versions"/><topic label="Obsolete Features" href="doc/cpp/Obsolete-Features.html#Obsolete-Features"/>
# </topic>
# <topic label="Debugger (HTML)">
# <topic label="Debugging with gdb" href="doc/gdb/index.html#Top"/><topic label="Summary of gdb" href="doc/gdb/Summary.html#Summary">
# <topic label="Free Software" href="doc/gdb/Free-Software.html#Free-Software"/><topic label="Free Software Needs Free Documentation" href="doc/gdb/Free-Documentation.html#Free-Documentation"/><topic label="Contributors to gdb" href="doc/gdb/Contributors.html#Contributors"/></topic><topic label="A Sample gdb Session" href="doc/gdb/Sample-Session.html#Sample-Session"/><topic label="Getting In and Out of gdb" href="doc/gdb/Invocation.html#Invocation">
# <topic label="Invoking gdb" href="doc/gdb/Invoking-GDB.html#Invoking-GDB">
# <topic label="Choosing Files" href="doc/gdb/File-Options.html#File-Options"/><topic label="Choosing Modes" href="doc/gdb/Mode-Options.html#Mode-Options"/><topic label="What gdb Does During Startup" href="doc/gdb/Startup.html#Startup"/></topic><topic label="Quitting gdb" href="doc/gdb/Quitting-GDB.html#Quitting-GDB"/><topic label="Shell Commands" href="doc/gdb/Shell-Commands.html#Shell-Commands"/><topic label="Logging Output" href="doc/gdb/Logging-Output.html#Logging-Output"/></topic><topic label="gdb Commands" href="doc/gdb/Commands.html#Commands">
# <topic label="Command Syntax" href="doc/gdb/Command-Syntax.html#Command-Syntax"/><topic label="Command Completion" href="doc/gdb/Completion.html#Completion"/><topic label="Getting Help" href="doc/gdb/Help.html#Help"/></topic><topic label="Running Programs Under gdb" href="doc/gdb/Running.html#Running">
# <topic label="Compiling for Debugging" href="doc/gdb/Compilation.html#Compilation"/><topic label="Starting your Program" href="doc/gdb/Starting.html#Starting"/><topic label="Your Program's Arguments" href="doc/gdb/Arguments.html#Arguments"/><topic label="Your Program's Environment" href="doc/gdb/Environment.html#Environment"/><topic label="Your Program's Working Directory" href="doc/gdb/Working-Directory.html#Working-Directory"/><topic label="Your Program's Input and Output" href="doc/gdb/Input_002fOutput.html#Input_002fOutput"/><topic label="Debugging an Already-running Process" href="doc/gdb/Attach.html#Attach"/><topic label="Killing the Child Process" href="doc/gdb/Kill-Process.html#Kill-Process"/><topic label="Debugging Multiple Inferiors and Programs" href="doc/gdb/Inferiors-and-Programs.html#Inferiors-and-Programs"/><topic label="Debugging Programs with Multiple Threads" href="doc/gdb/Threads.html#Threads"/><topic label="Debugging Forks" href="doc/gdb/Forks.html#Forks"/><topic label="Setting a Bookmark to Return to Later" href="doc/gdb/Checkpoint_002fRestart.html#Checkpoint_002fRestart">
# <topic label="A Non-obvious Benefit of Using Checkpoints" href="doc/gdb/Checkpoint_002fRestart.html#Checkpoint_002fRestart"/></topic></topic><topic label="Stopping and Continuing" href="doc/gdb/Stopping.html#Stopping">
# <topic label="Breakpoints, Watchpoints, and Catchpoints" href="doc/gdb/Breakpoints.html#Breakpoints">
# <topic label="Setting Breakpoints" href="doc/gdb/Set-Breaks.html#Set-Breaks"/><topic label="Setting Watchpoints" href="doc/gdb/Set-Watchpoints.html#Set-Watchpoints"/><topic label="Setting Catchpoints" href="doc/gdb/Set-Catchpoints.html#Set-Catchpoints"/><topic label="Deleting Breakpoints" href="doc/gdb/Delete-Breaks.html#Delete-Breaks"/><topic label="Disabling Breakpoints" href="doc/gdb/Disabling.html#Disabling"/><topic label="Break Conditions" href="doc/gdb/Conditions.html#Conditions"/><topic label="Breakpoint Command Lists" href="doc/gdb/Break-Commands.html#Break-Commands"/><topic label="Dynamic Printf" href="doc/gdb/Dynamic-Printf.html#Dynamic-Printf"/><topic label="How to save breakpoints to a file" href="doc/gdb/Save-Breakpoints.html#Save-Breakpoints"/><topic label="Static Probe Points" href="doc/gdb/Static-Probe-Points.html#Static-Probe-Points"/><topic label="&#x201C;Cannot insert breakpoints&#x201D;" href="doc/gdb/Error-in-Breakpoints.html#Error-in-Breakpoints"/><topic label="&#x201C;Breakpoint address adjusted...&#x201D;" href="doc/gdb/Breakpoint_002drelated-Warnings.html#Breakpoint_002drelated-Warnings"/></topic><topic label="Continuing and Stepping" href="doc/gdb/Continuing-and-Stepping.html#Continuing-and-Stepping"/><topic label="Skipping Over Functions and Files" href="doc/gdb/Skipping-Over-Functions-and-Files.html#Skipping-Over-Functions-and-Files"/><topic label="Signals" href="doc/gdb/Signals.html#Signals"/><topic label="Stopping and Starting Multi-thread Programs" href="doc/gdb/Thread-Stops.html#Thread-Stops">
# <topic label="All-Stop Mode" href="doc/gdb/All_002dStop-Mode.html#All_002dStop-Mode"/><topic label="Non-Stop Mode" href="doc/gdb/Non_002dStop-Mode.html#Non_002dStop-Mode"/><topic label="Background Execution" href="doc/gdb/Background-Execution.html#Background-Execution"/><topic label="Thread-Specific Breakpoints" href="doc/gdb/Thread_002dSpecific-Breakpoints.html#Thread_002dSpecific-Breakpoints"/><topic label="Interrupted System Calls" href="doc/gdb/Interrupted-System-Calls.html#Interrupted-System-Calls"/><topic label="Observer Mode" href="doc/gdb/Observer-Mode.html#Observer-Mode"/></topic></topic><topic label="Running programs backward" href="doc/gdb/Reverse-Execution.html#Reverse-Execution"/><topic label="Recording Inferior's Execution and Replaying It" href="doc/gdb/Process-Record-and-Replay.html#Process-Record-and-Replay"/><topic label="Examining the Stack" href="doc/gdb/Stack.html#Stack">
# <topic label="Stack Frames" href="doc/gdb/Frames.html#Frames"/><topic label="Backtraces" href="doc/gdb/Backtrace.html#Backtrace"/><topic label="Management of Frame Filters." href="doc/gdb/Frame-Filter-Management.html#Frame-Filter-Management"/><topic label="Selecting a Frame" href="doc/gdb/Selection.html#Selection"/><topic label="Information About a Frame" href="doc/gdb/Frame-Info.html#Frame-Info"/></topic><topic label="Examining Source Files" href="doc/gdb/Source.html#Source">
# <topic label="Printing Source Lines" href="doc/gdb/List.html#List"/><topic label="Specifying a Location" href="doc/gdb/Specify-Location.html#Specify-Location"/><topic label="Editing Source Files" href="doc/gdb/Edit.html#Edit">
# <topic label="Choosing your Editor" href="doc/gdb/Edit.html#Edit"/></topic><topic label="Searching Source Files" href="doc/gdb/Search.html#Search"/><topic label="Specifying Source Directories" href="doc/gdb/Source-Path.html#Source-Path"/><topic label="Source and Machine Code" href="doc/gdb/Machine-Code.html#Machine-Code"/></topic><topic label="Examining Data" href="doc/gdb/Data.html#Data">
# <topic label="Expressions" href="doc/gdb/Expressions.html#Expressions"/><topic label="Ambiguous Expressions" href="doc/gdb/Ambiguous-Expressions.html#Ambiguous-Expressions"/><topic label="Program Variables" href="doc/gdb/Variables.html#Variables"/><topic label="Artificial Arrays" href="doc/gdb/Arrays.html#Arrays"/><topic label="Output Formats" href="doc/gdb/Output-Formats.html#Output-Formats"/><topic label="Examining Memory" href="doc/gdb/Memory.html#Memory"/><topic label="Automatic Display" href="doc/gdb/Auto-Display.html#Auto-Display"/><topic label="Print Settings" href="doc/gdb/Print-Settings.html#Print-Settings"/><topic label="Pretty Printing" href="doc/gdb/Pretty-Printing.html#Pretty-Printing">
# <topic label="Pretty-Printer Introduction" href="doc/gdb/Pretty_002dPrinter-Introduction.html#Pretty_002dPrinter-Introduction"/><topic label="Pretty-Printer Example" href="doc/gdb/Pretty_002dPrinter-Example.html#Pretty_002dPrinter-Example"/><topic label="Pretty-Printer Commands" href="doc/gdb/Pretty_002dPrinter-Commands.html#Pretty_002dPrinter-Commands"/></topic><topic label="Value History" href="doc/gdb/Value-History.html#Value-History"/><topic label="Convenience Variables" href="doc/gdb/Convenience-Vars.html#Convenience-Vars"/><topic label="Convenience Functions" href="doc/gdb/Convenience-Funs.html#Convenience-Funs"/><topic label="Registers" href="doc/gdb/Registers.html#Registers"/><topic label="Floating Point Hardware" href="doc/gdb/Floating-Point-Hardware.html#Floating-Point-Hardware"/><topic label="Vector Unit" href="doc/gdb/Vector-Unit.html#Vector-Unit"/><topic label="Operating System Auxiliary Information" href="doc/gdb/OS-Information.html#OS-Information"/><topic label="Memory Region Attributes" href="doc/gdb/Memory-Region-Attributes.html#Memory-Region-Attributes">
# <topic label="Attributes" href="doc/gdb/Memory-Region-Attributes.html#Memory-Region-Attributes">
# <topic label="Memory Access Mode" href="doc/gdb/Memory-Region-Attributes.html#Memory-Region-Attributes"/><topic label="Memory Access Size" href="doc/gdb/Memory-Region-Attributes.html#Memory-Region-Attributes"/><topic label="Data Cache" href="doc/gdb/Memory-Region-Attributes.html#Memory-Region-Attributes"/></topic><topic label="Memory Access Checking" href="doc/gdb/Memory-Region-Attributes.html#Memory-Region-Attributes"/></topic><topic label="Copy Between Memory and a File" href="doc/gdb/Dump_002fRestore-Files.html#Dump_002fRestore-Files"/><topic label="How to Produce a Core File from Your Program" href="doc/gdb/Core-File-Generation.html#Core-File-Generation"/><topic label="Character Sets" href="doc/gdb/Character-Sets.html#Character-Sets"/><topic label="Caching Data of Targets" href="doc/gdb/Caching-Target-Data.html#Caching-Target-Data"/><topic label="Search Memory" href="doc/gdb/Searching-Memory.html#Searching-Memory"/></topic><topic label="Debugging Optimized Code" href="doc/gdb/Optimized-Code.html#Optimized-Code">
# <topic label="Inline Functions" href="doc/gdb/Inline-Functions.html#Inline-Functions"/><topic label="Tail Call Frames" href="doc/gdb/Tail-Call-Frames.html#Tail-Call-Frames"/></topic><topic label="C Preprocessor Macros" href="doc/gdb/Macros.html#Macros"/><topic label="Tracepoints" href="doc/gdb/Tracepoints.html#Tracepoints">
# <topic label="Commands to Set Tracepoints" href="doc/gdb/Set-Tracepoints.html#Set-Tracepoints">
# <topic label="Create and Delete Tracepoints" href="doc/gdb/Create-and-Delete-Tracepoints.html#Create-and-Delete-Tracepoints"/><topic label="Enable and Disable Tracepoints" href="doc/gdb/Enable-and-Disable-Tracepoints.html#Enable-and-Disable-Tracepoints"/><topic label="Tracepoint Passcounts" href="doc/gdb/Tracepoint-Passcounts.html#Tracepoint-Passcounts"/><topic label="Tracepoint Conditions" href="doc/gdb/Tracepoint-Conditions.html#Tracepoint-Conditions"/><topic label="Trace State Variables" href="doc/gdb/Trace-State-Variables.html#Trace-State-Variables"/><topic label="Tracepoint Action Lists" href="doc/gdb/Tracepoint-Actions.html#Tracepoint-Actions"/><topic label="Listing Tracepoints" href="doc/gdb/Listing-Tracepoints.html#Listing-Tracepoints"/><topic label="Listing Static Tracepoint Markers" href="doc/gdb/Listing-Static-Tracepoint-Markers.html#Listing-Static-Tracepoint-Markers"/><topic label="Starting and Stopping Trace Experiments" href="doc/gdb/Starting-and-Stopping-Trace-Experiments.html#Starting-and-Stopping-Trace-Experiments"/><topic label="Tracepoint Restrictions" href="doc/gdb/Tracepoint-Restrictions.html#Tracepoint-Restrictions"/></topic><topic label="Using the Collected Data" href="doc/gdb/Analyze-Collected-Data.html#Analyze-Collected-Data">
# <topic label="tfind n" href="doc/gdb/tfind.html#tfind"/><topic label="tdump" href="doc/gdb/tdump.html#tdump"/><topic label="save tracepoints filename" href="doc/gdb/save-tracepoints.html#save-tracepoints"/></topic><topic label="Convenience Variables for Tracepoints" href="doc/gdb/Tracepoint-Variables.html#Tracepoint-Variables"/><topic label="Using Trace Files" href="doc/gdb/Trace-Files.html#Trace-Files"/></topic><topic label="Debugging Programs That Use Overlays" href="doc/gdb/Overlays.html#Overlays">
# <topic label="How Overlays Work" href="doc/gdb/How-Overlays-Work.html#How-Overlays-Work"/><topic label="Overlay Commands" href="doc/gdb/Overlay-Commands.html#Overlay-Commands"/><topic label="Automatic Overlay Debugging" href="doc/gdb/Automatic-Overlay-Debugging.html#Automatic-Overlay-Debugging"/><topic label="Overlay Sample Program" href="doc/gdb/Overlay-Sample-Program.html#Overlay-Sample-Program"/></topic><topic label="Using gdb with Different Languages" href="doc/gdb/Languages.html#Languages">
# <topic label="Switching Between Source Languages" href="doc/gdb/Setting.html#Setting">
# <topic label="List of Filename Extensions and Languages" href="doc/gdb/Filenames.html#Filenames"/><topic label="Setting the Working Language" href="doc/gdb/Manually.html#Manually"/><topic label="Having gdb Infer the Source Language" href="doc/gdb/Automatically.html#Automatically"/></topic><topic label="Displaying the Language" href="doc/gdb/Show.html#Show"/><topic label="Type and Range Checking" href="doc/gdb/Checks.html#Checks">
# <topic label="An Overview of Type Checking" href="doc/gdb/Type-Checking.html#Type-Checking"/><topic label="An Overview of Range Checking" href="doc/gdb/Range-Checking.html#Range-Checking"/></topic><topic label="Supported Languages" href="doc/gdb/Supported-Languages.html#Supported-Languages">
# <topic label="C and C++" href="doc/gdb/C.html#C">
# <topic label="C and C++ Operators" href="doc/gdb/C-Operators.html#C-Operators"/><topic label="C and C++ Constants" href="doc/gdb/C-Constants.html#C-Constants"/><topic label="C++ Expressions" href="doc/gdb/C-Plus-Plus-Expressions.html#C-Plus-Plus-Expressions"/><topic label="C and C++ Defaults" href="doc/gdb/C-Defaults.html#C-Defaults"/><topic label="C and C++ Type and Range Checks" href="doc/gdb/C-Checks.html#C-Checks"/><topic label="gdb and C" href="doc/gdb/Debugging-C.html#Debugging-C"/><topic label="gdb Features for C++" href="doc/gdb/Debugging-C-Plus-Plus.html#Debugging-C-Plus-Plus"/><topic label="Decimal Floating Point format" href="doc/gdb/Decimal-Floating-Point.html#Decimal-Floating-Point"/></topic><topic label="D" href="doc/gdb/D.html#D"/><topic label="Go" href="doc/gdb/Go.html#Go"/><topic label="Objective-C" href="doc/gdb/Objective_002dC.html#Objective_002dC">
# <topic label="Method Names in Commands" href="doc/gdb/Method-Names-in-Commands.html#Method-Names-in-Commands"/><topic label="The Print Command With Objective-C" href="doc/gdb/The-Print-Command-with-Objective_002dC.html#The-Print-Command-with-Objective_002dC"/></topic><topic label="OpenCL C" href="doc/gdb/OpenCL-C.html#OpenCL-C">
# <topic label="OpenCL C Datatypes" href="doc/gdb/OpenCL-C-Datatypes.html#OpenCL-C-Datatypes"/><topic label="OpenCL C Expressions" href="doc/gdb/OpenCL-C-Expressions.html#OpenCL-C-Expressions"/><topic label="OpenCL C Operators" href="doc/gdb/OpenCL-C-Operators.html#OpenCL-C-Operators"/></topic><topic label="Fortran" href="doc/gdb/Fortran.html#Fortran">
# <topic label="Fortran Operators and Expressions" href="doc/gdb/Fortran-Operators.html#Fortran-Operators"/><topic label="Fortran Defaults" href="doc/gdb/Fortran-Defaults.html#Fortran-Defaults"/><topic label="Special Fortran Commands" href="doc/gdb/Special-Fortran-Commands.html#Special-Fortran-Commands"/></topic><topic label="Pascal" href="doc/gdb/Pascal.html#Pascal"/><topic label="Modula-2" href="doc/gdb/Modula_002d2.html#Modula_002d2">
# <topic label="Operators" href="doc/gdb/M2-Operators.html#M2-Operators"/><topic label="Built-in Functions and Procedures" href="doc/gdb/Built_002dIn-Func_002fProc.html#Built_002dIn-Func_002fProc"/><topic label="Constants" href="doc/gdb/M2-Constants.html#M2-Constants"/><topic label="Modula-2 Types" href="doc/gdb/M2-Types.html#M2-Types"/><topic label="Modula-2 Defaults" href="doc/gdb/M2-Defaults.html#M2-Defaults"/><topic label="Deviations from Standard Modula-2" href="doc/gdb/Deviations.html#Deviations"/><topic label="Modula-2 Type and Range Checks" href="doc/gdb/M2-Checks.html#M2-Checks"/><topic label="The Scope Operators :: and ." href="doc/gdb/M2-Scope.html#M2-Scope"/><topic label="gdb and Modula-2" href="doc/gdb/GDB_002fM2.html#GDB_002fM2"/></topic><topic label="Ada" href="doc/gdb/Ada.html#Ada">
# <topic label="Introduction" href="doc/gdb/Ada-Mode-Intro.html#Ada-Mode-Intro"/><topic label="Omissions from Ada" href="doc/gdb/Omissions-from-Ada.html#Omissions-from-Ada"/><topic label="Additions to Ada" href="doc/gdb/Additions-to-Ada.html#Additions-to-Ada"/><topic label="Stopping at the Very Beginning" href="doc/gdb/Stopping-Before-Main-Program.html#Stopping-Before-Main-Program"/><topic label="Ada Exceptions" href="doc/gdb/Ada-Exceptions.html#Ada-Exceptions"/><topic label="Extensions for Ada Tasks" href="doc/gdb/Ada-Tasks.html#Ada-Tasks"/><topic label="Tasking Support when Debugging Core Files" href="doc/gdb/Ada-Tasks-and-Core-Files.html#Ada-Tasks-and-Core-Files"/><topic label="Tasking Support when using the Ravenscar Profile" href="doc/gdb/Ravenscar-Profile.html#Ravenscar-Profile"/><topic label="Known Peculiarities of Ada Mode" href="doc/gdb/Ada-Glitches.html#Ada-Glitches"/></topic></topic><topic label="Unsupported Languages" href="doc/gdb/Unsupported-Languages.html#Unsupported-Languages"/></topic><topic label="Examining the Symbol Table" href="doc/gdb/Symbols.html#Symbols"/><topic label="Altering Execution" href="doc/gdb/Altering.html#Altering">
# <topic label="Assignment to Variables" href="doc/gdb/Assignment.html#Assignment"/><topic label="Continuing at a Different Address" href="doc/gdb/Jumping.html#Jumping"/><topic label="Giving your Program a Signal" href="doc/gdb/Signaling.html#Signaling"/><topic label="Returning from a Function" href="doc/gdb/Returning.html#Returning"/><topic label="Calling Program Functions" href="doc/gdb/Calling.html#Calling"/><topic label="Patching Programs" href="doc/gdb/Patching.html#Patching"/></topic><topic label="gdb Files" href="doc/gdb/GDB-Files.html#GDB-Files">
# <topic label="Commands to Specify Files" href="doc/gdb/Files.html#Files"/><topic label="Debugging Information in Separate Files" href="doc/gdb/Separate-Debug-Files.html#Separate-Debug-Files"/><topic label="Debugging information in a special section" href="doc/gdb/MiniDebugInfo.html#MiniDebugInfo"/><topic label="Index Files Speed Up gdb" href="doc/gdb/Index-Files.html#Index-Files"/><topic label="Errors Reading Symbol Files" href="doc/gdb/Symbol-Errors.html#Symbol-Errors"/><topic label="GDB Data Files" href="doc/gdb/Data-Files.html#Data-Files"/></topic><topic label="Specifying a Debugging Target" href="doc/gdb/Targets.html#Targets">
# <topic label="Active Targets" href="doc/gdb/Active-Targets.html#Active-Targets"/><topic label="Commands for Managing Targets" href="doc/gdb/Target-Commands.html#Target-Commands"/><topic label="Choosing Target Byte Order" href="doc/gdb/Byte-Order.html#Byte-Order"/></topic><topic label="Debugging Remote Programs" href="doc/gdb/Remote-Debugging.html#Remote-Debugging">
# <topic label="Connecting to a Remote Target" href="doc/gdb/Connecting.html#Connecting"/><topic label="Sending files to a remote system" href="doc/gdb/File-Transfer.html#File-Transfer"/><topic label="Using the gdbserver Program" href="doc/gdb/Server.html#Server">
# <topic label="Running gdbserver" href="doc/gdb/Server.html#Server">
# <topic label="Attaching to a Running Program" href="doc/gdb/Server.html#Server"/><topic label="Multi-Process Mode for gdbserver" href="doc/gdb/Server.html#Server"/><topic label="TCP port allocation lifecycle of gdbserver" href="doc/gdb/Server.html#Server"/><topic label="Other Command-Line Arguments for gdbserver" href="doc/gdb/Server.html#Server"/></topic><topic label="Connecting to gdbserver" href="doc/gdb/Server.html#Server"/><topic label="Monitor Commands for gdbserver" href="doc/gdb/Server.html#Server"/><topic label="Tracepoints support in gdbserver" href="doc/gdb/Server.html#Server"/></topic><topic label="Remote Configuration" href="doc/gdb/Remote-Configuration.html#Remote-Configuration"/><topic label="Implementing a Remote Stub" href="doc/gdb/Remote-Stub.html#Remote-Stub">
# <topic label="What the Stub Can Do for You" href="doc/gdb/Stub-Contents.html#Stub-Contents"/><topic label="What You Must Do for the Stub" href="doc/gdb/Bootstrapping.html#Bootstrapping"/><topic label="Putting it All Together" href="doc/gdb/Debug-Session.html#Debug-Session"/></topic></topic><topic label="Configuration-Specific Information" href="doc/gdb/Configurations.html#Configurations">
# <topic label="Native" href="doc/gdb/Native.html#Native">
# <topic label="HP-UX" href="doc/gdb/HP_002dUX.html#HP_002dUX"/><topic label="BSD libkvm Interface" href="doc/gdb/BSD-libkvm-Interface.html#BSD-libkvm-Interface"/><topic label="SVR4 Process Information" href="doc/gdb/SVR4-Process-Information.html#SVR4-Process-Information"/><topic label="Features for Debugging djgpp Programs" href="doc/gdb/DJGPP-Native.html#DJGPP-Native"/><topic label="Features for Debugging MS Windows PE Executables" href="doc/gdb/Cygwin-Native.html#Cygwin-Native">
# <topic label="Support for DLLs without Debugging Symbols" href="doc/gdb/Non_002ddebug-DLL-Symbols.html#Non_002ddebug-DLL-Symbols"/><topic label="DLL Name Prefixes" href="doc/gdb/Non_002ddebug-DLL-Symbols.html#Non_002ddebug-DLL-Symbols"/><topic label="Working with Minimal Symbols" href="doc/gdb/Non_002ddebug-DLL-Symbols.html#Non_002ddebug-DLL-Symbols"/></topic><topic label="Commands Specific to gnu Hurd Systems" href="doc/gdb/Hurd-Native.html#Hurd-Native"/><topic label="Darwin" href="doc/gdb/Darwin.html#Darwin"/></topic><topic label="Embedded Operating Systems" href="doc/gdb/Embedded-OS.html#Embedded-OS">
# <topic label="Using gdb with VxWorks" href="doc/gdb/VxWorks.html#VxWorks">
# <topic label="Connecting to VxWorks" href="doc/gdb/VxWorks-Connection.html#VxWorks-Connection"/><topic label="VxWorks Download" href="doc/gdb/VxWorks-Download.html#VxWorks-Download"/><topic label="Running Tasks" href="doc/gdb/VxWorks-Attach.html#VxWorks-Attach"/></topic></topic><topic label="Embedded Processors" href="doc/gdb/Embedded-Processors.html#Embedded-Processors">
# <topic label="ARM" href="doc/gdb/ARM.html#ARM"/><topic label="Renesas M32R/D and M32R/SDI" href="doc/gdb/M32R_002fD.html#M32R_002fD"/><topic label="M68k" href="doc/gdb/M68K.html#M68K"/><topic label="MicroBlaze" href="doc/gdb/MicroBlaze.html#MicroBlaze"/><topic label="MIPS Embedded" href="doc/gdb/MIPS-Embedded.html#MIPS-Embedded"/><topic label="PowerPC Embedded" href="doc/gdb/PowerPC-Embedded.html#PowerPC-Embedded"/><topic label="HP PA Embedded" href="doc/gdb/PA.html#PA"/><topic label="Tsqware Sparclet" href="doc/gdb/Sparclet.html#Sparclet">
# <topic label="Setting File to Debug" href="doc/gdb/Sparclet-File.html#Sparclet-File"/><topic label="Connecting to Sparclet" href="doc/gdb/Sparclet-Connection.html#Sparclet-Connection"/><topic label="Sparclet Download" href="doc/gdb/Sparclet-Download.html#Sparclet-Download"/><topic label="Running and Debugging" href="doc/gdb/Sparclet-Execution.html#Sparclet-Execution"/></topic><topic label="Fujitsu Sparclite" href="doc/gdb/Sparclite.html#Sparclite"/><topic label="Zilog Z8000" href="doc/gdb/Z8000.html#Z8000"/><topic label="Atmel AVR" href="doc/gdb/AVR.html#AVR"/><topic label="CRIS" href="doc/gdb/CRIS.html#CRIS"/><topic label="Renesas Super-H" href="doc/gdb/Super_002dH.html#Super_002dH"/></topic><topic label="Architectures" href="doc/gdb/Architectures.html#Architectures">
# <topic label="AArch64" href="doc/gdb/AArch64.html#AArch64"/><topic label="x86 Architecture-specific Issues" href="doc/gdb/i386.html#i386">
# <topic label="Intel(R) Memory Protection Extensions (MPX)." href="doc/gdb/i386.html#i386"/></topic><topic label="Alpha" href="doc/gdb/Alpha.html#Alpha"/><topic label="MIPS" href="doc/gdb/MIPS.html#MIPS"/><topic label="HPPA" href="doc/gdb/HPPA.html#HPPA"/><topic label="Cell Broadband Engine SPU architecture" href="doc/gdb/SPU.html#SPU"/><topic label="PowerPC" href="doc/gdb/PowerPC.html#PowerPC"/><topic label="Nios II" href="doc/gdb/Nios-II.html#Nios-II"/></topic></topic><topic label="Controlling gdb" href="doc/gdb/Controlling-GDB.html#Controlling-GDB">
# <topic label="Prompt" href="doc/gdb/Prompt.html#Prompt"/><topic label="Command Editing" href="doc/gdb/Editing.html#Editing"/><topic label="Command History" href="doc/gdb/Command-History.html#Command-History"/><topic label="Screen Size" href="doc/gdb/Screen-Size.html#Screen-Size"/><topic label="Numbers" href="doc/gdb/Numbers.html#Numbers"/><topic label="Configuring the Current ABI" href="doc/gdb/ABI.html#ABI"/><topic label="Automatically loading associated files" href="doc/gdb/Auto_002dloading.html#Auto_002dloading">
# <topic label="Automatically loading init file in the current directory" href="doc/gdb/Init-File-in-the-Current-Directory.html#Init-File-in-the-Current-Directory"/><topic label="Automatically loading thread debugging library" href="doc/gdb/libthread_005fdb_002eso_002e1-file.html#libthread_005fdb_002eso_002e1-file"/><topic label="Security restriction for auto-loading" href="doc/gdb/Auto_002dloading-safe-path.html#Auto_002dloading-safe-path"/><topic label="Displaying files tried for auto-load" href="doc/gdb/Auto_002dloading-verbose-mode.html#Auto_002dloading-verbose-mode"/></topic><topic label="Optional Warnings and Messages" href="doc/gdb/Messages_002fWarnings.html#Messages_002fWarnings"/><topic label="Optional Messages about Internal Happenings" href="doc/gdb/Debugging-Output.html#Debugging-Output"/><topic label="Other Miscellaneous Settings" href="doc/gdb/Other-Misc-Settings.html#Other-Misc-Settings"/></topic><topic label="Extending gdb" href="doc/gdb/Extending-GDB.html#Extending-GDB">
# <topic label="Canned Sequences of Commands" href="doc/gdb/Sequences.html#Sequences">
# <topic label="User-defined Commands" href="doc/gdb/Define.html#Define"/><topic label="User-defined Command Hooks" href="doc/gdb/Hooks.html#Hooks"/><topic label="Command Files" href="doc/gdb/Command-Files.html#Command-Files"/><topic label="Commands for Controlled Output" href="doc/gdb/Output.html#Output"/><topic label="Controlling auto-loading native gdb scripts" href="doc/gdb/Auto_002dloading-sequences.html#Auto_002dloading-sequences"/></topic><topic label="Extending gdb using Python" href="doc/gdb/Python.html#Python">
# <topic label="Python Commands" href="doc/gdb/Python-Commands.html#Python-Commands"/><topic label="Python API" href="doc/gdb/Python-API.html#Python-API">
# <topic label="Basic Python" href="doc/gdb/Basic-Python.html#Basic-Python"/><topic label="Exception Handling" href="doc/gdb/Exception-Handling.html#Exception-Handling"/><topic label="Values From Inferior" href="doc/gdb/Values-From-Inferior.html#Values-From-Inferior"/><topic label="Types In Python" href="doc/gdb/Types-In-Python.html#Types-In-Python"/><topic label="Pretty Printing API" href="doc/gdb/Pretty-Printing-API.html#Pretty-Printing-API"/><topic label="Selecting Pretty-Printers" href="doc/gdb/Selecting-Pretty_002dPrinters.html#Selecting-Pretty_002dPrinters"/><topic label="Writing a Pretty-Printer" href="doc/gdb/Writing-a-Pretty_002dPrinter.html#Writing-a-Pretty_002dPrinter"/><topic label="Type Printing API" href="doc/gdb/Type-Printing-API.html#Type-Printing-API"/><topic label="Filtering Frames." href="doc/gdb/Frame-Filter-API.html#Frame-Filter-API"/><topic label="Decorating Frames." href="doc/gdb/Frame-Decorator-API.html#Frame-Decorator-API"/><topic label="Writing a Frame Filter" href="doc/gdb/Writing-a-Frame-Filter.html#Writing-a-Frame-Filter"/><topic label="Inferiors In Python" href="doc/gdb/Inferiors-In-Python.html#Inferiors-In-Python"/><topic label="Events In Python" href="doc/gdb/Events-In-Python.html#Events-In-Python"/><topic label="Threads In Python" href="doc/gdb/Threads-In-Python.html#Threads-In-Python"/><topic label="Commands In Python" href="doc/gdb/Commands-In-Python.html#Commands-In-Python"/><topic label="Parameters In Python" href="doc/gdb/Parameters-In-Python.html#Parameters-In-Python"/><topic label="Writing new convenience functions" href="doc/gdb/Functions-In-Python.html#Functions-In-Python"/><topic label="Program Spaces In Python" href="doc/gdb/Progspaces-In-Python.html#Progspaces-In-Python"/><topic label="Objfiles In Python" href="doc/gdb/Objfiles-In-Python.html#Objfiles-In-Python"/><topic label="Accessing inferior stack frames from Python." href="doc/gdb/Frames-In-Python.html#Frames-In-Python"/><topic label="Accessing blocks from Python." href="doc/gdb/Blocks-In-Python.html#Blocks-In-Python"/><topic label="Python representation of Symbols." href="doc/gdb/Symbols-In-Python.html#Symbols-In-Python"/><topic label="Symbol table representation in Python." href="doc/gdb/Symbol-Tables-In-Python.html#Symbol-Tables-In-Python"/><topic label="Manipulating line tables using Python" href="doc/gdb/Line-Tables-In-Python.html#Line-Tables-In-Python"/><topic label="Manipulating breakpoints using Python" href="doc/gdb/Breakpoints-In-Python.html#Breakpoints-In-Python"/><topic label="Finish Breakpoints" href="doc/gdb/Finish-Breakpoints-in-Python.html#Finish-Breakpoints-in-Python"/><topic label="Python representation of lazy strings." href="doc/gdb/Lazy-Strings-In-Python.html#Lazy-Strings-In-Python"/><topic label="Python representation of architectures" href="doc/gdb/Architectures-In-Python.html#Architectures-In-Python"/></topic><topic label="Python Auto-loading" href="doc/gdb/Python-Auto_002dloading.html#Python-Auto_002dloading"/><topic label="Python modules" href="doc/gdb/Python-modules.html#Python-modules">
# <topic label="gdb.printing" href="doc/gdb/gdb_002eprinting.html#gdb_002eprinting"/><topic label="gdb.types" href="doc/gdb/gdb_002etypes.html#gdb_002etypes"/><topic label="gdb.prompt" href="doc/gdb/gdb_002eprompt.html#gdb_002eprompt"/></topic></topic><topic label="Extending gdb using Guile" href="doc/gdb/Guile.html#Guile">
# <topic label="Guile Introduction" href="doc/gdb/Guile-Introduction.html#Guile-Introduction"/><topic label="Guile Commands" href="doc/gdb/Guile-Commands.html#Guile-Commands"/><topic label="Guile API" href="doc/gdb/Guile-API.html#Guile-API">
# <topic label="Basic Guile" href="doc/gdb/Basic-Guile.html#Basic-Guile"/><topic label="Guile Configuration" href="doc/gdb/Guile-Configuration.html#Guile-Configuration"/><topic label="GDB Scheme Data Types" href="doc/gdb/GDB-Scheme-Data-Types.html#GDB-Scheme-Data-Types"/><topic label="Guile Exception Handling" href="doc/gdb/Guile-Exception-Handling.html#Guile-Exception-Handling"/><topic label="Values From Inferior In Guile" href="doc/gdb/Values-From-Inferior-In-Guile.html#Values-From-Inferior-In-Guile"/><topic label="Arithmetic In Guile" href="doc/gdb/Arithmetic-In-Guile.html#Arithmetic-In-Guile"/><topic label="Types In Guile" href="doc/gdb/Types-In-Guile.html#Types-In-Guile"/><topic label="Guile Pretty Printing API" href="doc/gdb/Guile-Pretty-Printing-API.html#Guile-Pretty-Printing-API"/><topic label="Selecting Guile Pretty-Printers" href="doc/gdb/Selecting-Guile-Pretty_002dPrinters.html#Selecting-Guile-Pretty_002dPrinters"/><topic label="Writing a Guile Pretty-Printer" href="doc/gdb/Writing-a-Guile-Pretty_002dPrinter.html#Writing-a-Guile-Pretty_002dPrinter"/><topic label="Objfiles In Guile" href="doc/gdb/Objfiles-In-Guile.html#Objfiles-In-Guile"/><topic label="Accessing inferior stack frames from Guile." href="doc/gdb/Frames-In-Guile.html#Frames-In-Guile"/><topic label="Accessing blocks from Guile." href="doc/gdb/Blocks-In-Guile.html#Blocks-In-Guile"/><topic label="Guile representation of Symbols." href="doc/gdb/Symbols-In-Guile.html#Symbols-In-Guile"/><topic label="Symbol table representation in Guile." href="doc/gdb/Symbol-Tables-In-Guile.html#Symbol-Tables-In-Guile"/><topic label="Manipulating breakpoints using Guile" href="doc/gdb/Breakpoints-In-Guile.html#Breakpoints-In-Guile"/><topic label="Guile representation of lazy strings." href="doc/gdb/Lazy-Strings-In-Guile.html#Lazy-Strings-In-Guile"/><topic label="Guile representation of architectures" href="doc/gdb/Architectures-In-Guile.html#Architectures-In-Guile"/><topic label="Disassembly In Guile" href="doc/gdb/Disassembly-In-Guile.html#Disassembly-In-Guile"/><topic label="I/O Ports in Guile" href="doc/gdb/I_002fO-Ports-in-Guile.html#I_002fO-Ports-in-Guile"/><topic label="Memory Ports in Guile" href="doc/gdb/Memory-Ports-in-Guile.html#Memory-Ports-in-Guile"/><topic label="Iterators In Guile" href="doc/gdb/Iterators-In-Guile.html#Iterators-In-Guile"/></topic><topic label="Guile Auto-loading" href="doc/gdb/Guile-Auto_002dloading.html#Guile-Auto_002dloading"/><topic label="Guile Modules" href="doc/gdb/Guile-Modules.html#Guile-Modules">
# <topic label="Guile Printing Module" href="doc/gdb/Guile-Printing-Module.html#Guile-Printing-Module"/><topic label="Guile Types Module" href="doc/gdb/Guile-Types-Module.html#Guile-Types-Module"/></topic></topic><topic label="Auto-loading extensions" href="doc/gdb/Auto_002dloading-extensions.html#Auto_002dloading-extensions">
# <topic label="The objfile-gdb.ext file" href="doc/gdb/objfile_002dgdbdotext-file.html#objfile_002dgdbdotext-file"/><topic label="The .debug_gdb_scripts section" href="doc/gdb/dotdebug_005fgdb_005fscripts-section.html#dotdebug_005fgdb_005fscripts-section"/><topic label="Which flavor to choose?" href="doc/gdb/Which-flavor-to-choose_003f.html#Which-flavor-to-choose_003f"/></topic><topic label="Multiple Extension Languages" href="doc/gdb/Multiple-Extension-Languages.html#Multiple-Extension-Languages">
# <topic label="Python comes first" href="doc/gdb/Multiple-Extension-Languages.html#Multiple-Extension-Languages"/></topic><topic label="Creating new spellings of existing commands" href="doc/gdb/Aliases.html#Aliases"/></topic><topic label="Command Interpreters" href="doc/gdb/Interpreters.html#Interpreters"/><topic label="gdb Text User Interface" href="doc/gdb/TUI.html#TUI">
# <topic label="TUI Overview" href="doc/gdb/TUI-Overview.html#TUI-Overview"/><topic label="TUI Key Bindings" href="doc/gdb/TUI-Keys.html#TUI-Keys"/><topic label="TUI Single Key Mode" href="doc/gdb/TUI-Single-Key-Mode.html#TUI-Single-Key-Mode"/><topic label="TUI-specific Commands" href="doc/gdb/TUI-Commands.html#TUI-Commands"/><topic label="TUI Configuration Variables" href="doc/gdb/TUI-Configuration.html#TUI-Configuration"/></topic><topic label="Using gdb under gnu Emacs" href="doc/gdb/Emacs.html#Emacs"/><topic label="The gdb/mi Interface" href="doc/gdb/GDB_002fMI.html#GDB_002fMI">
# <topic label="Function and Purpose" href="doc/gdb/GDB_002fMI.html#GDB_002fMI"/><topic label="Notation and Terminology" href="doc/gdb/GDB_002fMI.html#GDB_002fMI"/><topic label="gdb/mi General Design" href="doc/gdb/GDB_002fMI-General-Design.html#GDB_002fMI-General-Design">
# <topic label="Context management" href="doc/gdb/Context-management.html#Context-management">
# <topic label="Threads and Frames" href="doc/gdb/Context-management.html#Context-management"/><topic label="Language" href="doc/gdb/Context-management.html#Context-management"/></topic><topic label="Asynchronous command execution and non-stop mode" href="doc/gdb/Asynchronous-and-non_002dstop-modes.html#Asynchronous-and-non_002dstop-modes"/><topic label="Thread groups" href="doc/gdb/Thread-groups.html#Thread-groups"/></topic><topic label="gdb/mi Command Syntax" href="doc/gdb/GDB_002fMI-Command-Syntax.html#GDB_002fMI-Command-Syntax">
# <topic label="gdb/mi Input Syntax" href="doc/gdb/GDB_002fMI-Input-Syntax.html#GDB_002fMI-Input-Syntax"/><topic label="gdb/mi Output Syntax" href="doc/gdb/GDB_002fMI-Output-Syntax.html#GDB_002fMI-Output-Syntax"/></topic><topic label="gdb/mi Compatibility with CLI" href="doc/gdb/GDB_002fMI-Compatibility-with-CLI.html#GDB_002fMI-Compatibility-with-CLI"/><topic label="gdb/mi Development and Front Ends" href="doc/gdb/GDB_002fMI-Development-and-Front-Ends.html#GDB_002fMI-Development-and-Front-Ends"/><topic label="gdb/mi Output Records" href="doc/gdb/GDB_002fMI-Output-Records.html#GDB_002fMI-Output-Records">
# <topic label="gdb/mi Result Records" href="doc/gdb/GDB_002fMI-Result-Records.html#GDB_002fMI-Result-Records"/><topic label="gdb/mi Stream Records" href="doc/gdb/GDB_002fMI-Stream-Records.html#GDB_002fMI-Stream-Records"/><topic label="gdb/mi Async Records" href="doc/gdb/GDB_002fMI-Async-Records.html#GDB_002fMI-Async-Records"/><topic label="gdb/mi Breakpoint Information" href="doc/gdb/GDB_002fMI-Breakpoint-Information.html#GDB_002fMI-Breakpoint-Information"/><topic label="gdb/mi Frame Information" href="doc/gdb/GDB_002fMI-Frame-Information.html#GDB_002fMI-Frame-Information"/><topic label="gdb/mi Thread Information" href="doc/gdb/GDB_002fMI-Thread-Information.html#GDB_002fMI-Thread-Information"/><topic label="gdb/mi Ada Exception Information" href="doc/gdb/GDB_002fMI-Ada-Exception-Information.html#GDB_002fMI-Ada-Exception-Information"/></topic><topic label="Simple Examples of gdb/mi Interaction" href="doc/gdb/GDB_002fMI-Simple-Examples.html#GDB_002fMI-Simple-Examples"/><topic label="gdb/mi Command Description Format" href="doc/gdb/GDB_002fMI-Command-Description-Format.html#GDB_002fMI-Command-Description-Format"/><topic label="gdb/mi Breakpoint Commands" href="doc/gdb/GDB_002fMI-Breakpoint-Commands.html#GDB_002fMI-Breakpoint-Commands"/><topic label="gdb/mi Catchpoint Commands" href="doc/gdb/GDB_002fMI-Catchpoint-Commands.html#GDB_002fMI-Catchpoint-Commands">
# <topic label="Shared Library gdb/mi Catchpoints" href="doc/gdb/Shared-Library-GDB_002fMI-Catchpoint-Commands.html#Shared-Library-GDB_002fMI-Catchpoint-Commands"/><topic label="Ada Exception gdb/mi Catchpoints" href="doc/gdb/Ada-Exception-GDB_002fMI-Catchpoint-Commands.html#Ada-Exception-GDB_002fMI-Catchpoint-Commands"/></topic><topic label="gdb/mi  Program Context" href="doc/gdb/GDB_002fMI-Program-Context.html#GDB_002fMI-Program-Context"/><topic label="gdb/mi Thread Commands" href="doc/gdb/GDB_002fMI-Thread-Commands.html#GDB_002fMI-Thread-Commands"/><topic label="gdb/mi Ada Tasking Commands" href="doc/gdb/GDB_002fMI-Ada-Tasking-Commands.html#GDB_002fMI-Ada-Tasking-Commands"/><topic label="gdb/mi Program Execution" href="doc/gdb/GDB_002fMI-Program-Execution.html#GDB_002fMI-Program-Execution"/><topic label="gdb/mi Stack Manipulation Commands" href="doc/gdb/GDB_002fMI-Stack-Manipulation.html#GDB_002fMI-Stack-Manipulation"/><topic label="gdb/mi Variable Objects" href="doc/gdb/GDB_002fMI-Variable-Objects.html#GDB_002fMI-Variable-Objects"/><topic label="gdb/mi Data Manipulation" href="doc/gdb/GDB_002fMI-Data-Manipulation.html#GDB_002fMI-Data-Manipulation"/><topic label="gdb/mi Tracepoint Commands" href="doc/gdb/GDB_002fMI-Tracepoint-Commands.html#GDB_002fMI-Tracepoint-Commands"/><topic label="gdb/mi Symbol Query Commands" href="doc/gdb/GDB_002fMI-Symbol-Query.html#GDB_002fMI-Symbol-Query"/><topic label="gdb/mi File Commands" href="doc/gdb/GDB_002fMI-File-Commands.html#GDB_002fMI-File-Commands"/><topic label="gdb/mi Target Manipulation Commands" href="doc/gdb/GDB_002fMI-Target-Manipulation.html#GDB_002fMI-Target-Manipulation"/><topic label="gdb/mi File Transfer Commands" href="doc/gdb/GDB_002fMI-File-Transfer-Commands.html#GDB_002fMI-File-Transfer-Commands"/><topic label="Ada Exceptions gdb/mi Commands" href="doc/gdb/GDB_002fMI-Ada-Exceptions-Commands.html#GDB_002fMI-Ada-Exceptions-Commands"/><topic label="gdb/mi Support Commands" href="doc/gdb/GDB_002fMI-Support-Commands.html#GDB_002fMI-Support-Commands"/><topic label="Miscellaneous gdb/mi Commands" href="doc/gdb/GDB_002fMI-Miscellaneous-Commands.html#GDB_002fMI-Miscellaneous-Commands"/></topic><topic label="gdb Annotations" href="doc/gdb/Annotations.html#Annotations">
# <topic label="What is an Annotation?" href="doc/gdb/Annotations-Overview.html#Annotations-Overview"/><topic label="The Server Prefix" href="doc/gdb/Server-Prefix.html#Server-Prefix"/><topic label="Annotation for gdb Input" href="doc/gdb/Prompting.html#Prompting"/><topic label="Errors" href="doc/gdb/Errors.html#Errors"/><topic label="Invalidation Notices" href="doc/gdb/Invalidation.html#Invalidation"/><topic label="Running the Program" href="doc/gdb/Annotations-for-Running.html#Annotations-for-Running"/><topic label="Displaying Source" href="doc/gdb/Source-Annotations.html#Source-Annotations"/></topic><topic label="JIT Compilation Interface" href="doc/gdb/JIT-Interface.html#JIT-Interface">
# <topic label="JIT Declarations" href="doc/gdb/Declarations.html#Declarations"/><topic label="Registering Code" href="doc/gdb/Registering-Code.html#Registering-Code"/><topic label="Unregistering Code" href="doc/gdb/Unregistering-Code.html#Unregistering-Code"/><topic label="Custom Debug Info" href="doc/gdb/Custom-Debug-Info.html#Custom-Debug-Info">
# <topic label="Using JIT Debug Info Readers" href="doc/gdb/Using-JIT-Debug-Info-Readers.html#Using-JIT-Debug-Info-Readers"/><topic label="Writing JIT Debug Info Readers" href="doc/gdb/Writing-JIT-Debug-Info-Readers.html#Writing-JIT-Debug-Info-Readers"/></topic></topic><topic label="In-Process Agent" href="doc/gdb/In_002dProcess-Agent.html#In_002dProcess-Agent">
# <topic label="In-Process Agent Protocol" href="doc/gdb/In_002dProcess-Agent-Protocol.html#In_002dProcess-Agent-Protocol">
# <topic label="IPA Protocol Objects" href="doc/gdb/IPA-Protocol-Objects.html#IPA-Protocol-Objects"/><topic label="IPA Protocol Commands" href="doc/gdb/IPA-Protocol-Commands.html#IPA-Protocol-Commands"/></topic></topic><topic label="Reporting Bugs in gdb" href="doc/gdb/GDB-Bugs.html#GDB-Bugs">
# <topic label="Have You Found a Bug?" href="doc/gdb/Bug-Criteria.html#Bug-Criteria"/><topic label="How to Report Bugs" href="doc/gdb/Bug-Reporting.html#Bug-Reporting"/></topic><topic label="Command Line Editing" href="doc/gdb/Command-Line-Editing.html#Command-Line-Editing">
# <topic label="Introduction to Line Editing" href="doc/gdb/Introduction-and-Notation.html#Introduction-and-Notation"/><topic label="Readline Interaction" href="doc/gdb/Readline-Interaction.html#Readline-Interaction">
# <topic label="Readline Bare Essentials" href="doc/gdb/Readline-Bare-Essentials.html#Readline-Bare-Essentials"/><topic label="Readline Movement Commands" href="doc/gdb/Readline-Movement-Commands.html#Readline-Movement-Commands"/><topic label="Readline Killing Commands" href="doc/gdb/Readline-Killing-Commands.html#Readline-Killing-Commands"/><topic label="Readline Arguments" href="doc/gdb/Readline-Arguments.html#Readline-Arguments"/><topic label="Searching for Commands in the History" href="doc/gdb/Searching.html#Searching"/></topic><topic label="Readline Init File" href="doc/gdb/Readline-Init-File.html#Readline-Init-File">
# <topic label="Readline Init File Syntax" href="doc/gdb/Readline-Init-File-Syntax.html#Readline-Init-File-Syntax"/><topic label="Conditional Init Constructs" href="doc/gdb/Conditional-Init-Constructs.html#Conditional-Init-Constructs"/><topic label="Sample Init File" href="doc/gdb/Sample-Init-File.html#Sample-Init-File"/></topic><topic label="Bindable Readline Commands" href="doc/gdb/Bindable-Readline-Commands.html#Bindable-Readline-Commands">
# <topic label="Commands For Moving" href="doc/gdb/Commands-For-Moving.html#Commands-For-Moving"/><topic label="Commands For Manipulating The History" href="doc/gdb/Commands-For-History.html#Commands-For-History"/><topic label="Commands For Changing Text" href="doc/gdb/Commands-For-Text.html#Commands-For-Text"/><topic label="Killing And Yanking" href="doc/gdb/Commands-For-Killing.html#Commands-For-Killing"/><topic label="Specifying Numeric Arguments" href="doc/gdb/Numeric-Arguments.html#Numeric-Arguments"/><topic label="Letting Readline Type For You" href="doc/gdb/Commands-For-Completion.html#Commands-For-Completion"/><topic label="Keyboard Macros" href="doc/gdb/Keyboard-Macros.html#Keyboard-Macros"/><topic label="Some Miscellaneous Commands" href="doc/gdb/Miscellaneous-Commands.html#Miscellaneous-Commands"/></topic><topic label="Readline vi Mode" href="doc/gdb/Readline-vi-Mode.html#Readline-vi-Mode"/></topic><topic label="Using History Interactively" href="doc/gdb/Using-History-Interactively.html#Using-History-Interactively">
# <topic label="History Expansion" href="doc/gdb/History-Interaction.html#History-Interaction">
# <topic label="Event Designators" href="doc/gdb/Event-Designators.html#Event-Designators"/><topic label="Word Designators" href="doc/gdb/Word-Designators.html#Word-Designators"/><topic label="Modifiers" href="doc/gdb/Modifiers.html#Modifiers"/></topic></topic><topic label="Appendix A In Memoriam" href="doc/gdb/In-Memoriam.html#In-Memoriam"/><topic label="Appendix B Formatting Documentation" href="doc/gdb/Formatting-Documentation.html#Formatting-Documentation"/><topic label="Appendix C Installing gdb" href="doc/gdb/Installing-GDB.html#Installing-GDB">
# <topic label="C.1 Requirements for Building gdb" href="doc/gdb/Requirements.html#Requirements"/><topic label="C.2 Invoking the gdb configure Script" href="doc/gdb/Running-Configure.html#Running-Configure"/><topic label="C.3 Compiling gdb in Another Directory" href="doc/gdb/Separate-Objdir.html#Separate-Objdir"/><topic label="C.4 Specifying Names for Hosts and Targets" href="doc/gdb/Config-Names.html#Config-Names"/><topic label="C.5 configure Options" href="doc/gdb/Configure-Options.html#Configure-Options"/><topic label="C.6 System-wide configuration and settings" href="doc/gdb/System_002dwide-configuration.html#System_002dwide-configuration">
# <topic label="C.6.1 Installed System-wide Configuration Scripts" href="doc/gdb/System_002dwide-Configuration-Scripts.html#System_002dwide-Configuration-Scripts"/></topic></topic><topic label="Appendix D Maintenance Commands" href="doc/gdb/Maintenance-Commands.html#Maintenance-Commands"/><topic label="Appendix E gdb Remote Serial Protocol" href="doc/gdb/Remote-Protocol.html#Remote-Protocol">
# <topic label="E.1 Overview" href="doc/gdb/Overview.html#Overview"/><topic label="E.2 Standard Replies" href="doc/gdb/Standard-Replies.html#Standard-Replies"/><topic label="E.3 Packets" href="doc/gdb/Packets.html#Packets"/><topic label="E.4 Stop Reply Packets" href="doc/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets"/><topic label="E.5 General Query Packets" href="doc/gdb/General-Query-Packets.html#General-Query-Packets"/><topic label="E.6 Architecture-Specific Protocol Details" href="doc/gdb/Architecture_002dSpecific-Protocol-Details.html#Architecture_002dSpecific-Protocol-Details">
# <topic label="E.6.1 ARM-specific Protocol Details" href="doc/gdb/ARM_002dSpecific-Protocol-Details.html#ARM_002dSpecific-Protocol-Details">
# <topic label="E.6.1.1 ARM Breakpoint Kinds" href="doc/gdb/ARM-Breakpoint-Kinds.html#ARM-Breakpoint-Kinds"/></topic><topic label="E.6.2 MIPS-specific Protocol Details" href="doc/gdb/MIPS_002dSpecific-Protocol-Details.html#MIPS_002dSpecific-Protocol-Details">
# <topic label="E.6.2.1 MIPS Register Packet Format" href="doc/gdb/MIPS-Register-packet-Format.html#MIPS-Register-packet-Format"/><topic label="E.6.2.2 MIPS Breakpoint Kinds" href="doc/gdb/MIPS-Breakpoint-Kinds.html#MIPS-Breakpoint-Kinds"/></topic></topic><topic label="E.7 Tracepoint Packets" href="doc/gdb/Tracepoint-Packets.html#Tracepoint-Packets">
# <topic label="E.7.1 Relocate instruction reply packet" href="doc/gdb/Tracepoint-Packets.html#Tracepoint-Packets"/></topic><topic label="E.8 Host I/O Packets" href="doc/gdb/Host-I_002fO-Packets.html#Host-I_002fO-Packets"/><topic label="E.9 Interrupts" href="doc/gdb/Interrupts.html#Interrupts"/><topic label="E.10 Notification Packets" href="doc/gdb/Notification-Packets.html#Notification-Packets"/><topic label="E.11 Remote Protocol Support for Non-Stop Mode" href="doc/gdb/Remote-Non_002dStop.html#Remote-Non_002dStop"/><topic label="E.12 Packet Acknowledgment" href="doc/gdb/Packet-Acknowledgment.html#Packet-Acknowledgment"/><topic label="E.13 Examples" href="doc/gdb/Examples.html#Examples"/><topic label="E.14 File-I/O Remote Protocol Extension" href="doc/gdb/File_002dI_002fO-Remote-Protocol-Extension.html#File_002dI_002fO-Remote-Protocol-Extension">
# <topic label="E.14.1 File-I/O Overview" href="doc/gdb/File_002dI_002fO-Overview.html#File_002dI_002fO-Overview"/><topic label="E.14.2 Protocol Basics" href="doc/gdb/Protocol-Basics.html#Protocol-Basics"/><topic label="E.14.3 The F Request Packet" href="doc/gdb/The-F-Request-Packet.html#The-F-Request-Packet"/><topic label="E.14.4 The F Reply Packet" href="doc/gdb/The-F-Reply-Packet.html#The-F-Reply-Packet"/><topic label="E.14.5 The &#x2018;Ctrl-C&#x2019; Message" href="doc/gdb/The-Ctrl_002dC-Message.html#The-Ctrl_002dC-Message"/><topic label="E.14.6 Console I/O" href="doc/gdb/Console-I_002fO.html#Console-I_002fO"/><topic label="E.14.7 List of Supported Calls" href="doc/gdb/List-of-Supported-Calls.html#List-of-Supported-Calls">
# <topic label="open" href="doc/gdb/open.html#open"/><topic label="close" href="doc/gdb/close.html#close"/><topic label="read" href="doc/gdb/read.html#read"/><topic label="write" href="doc/gdb/write.html#write"/><topic label="lseek" href="doc/gdb/lseek.html#lseek"/><topic label="rename" href="doc/gdb/rename.html#rename"/><topic label="unlink" href="doc/gdb/unlink.html#unlink"/><topic label="stat/fstat" href="doc/gdb/stat_002ffstat.html#stat_002ffstat"/><topic label="gettimeofday" href="doc/gdb/gettimeofday.html#gettimeofday"/><topic label="isatty" href="doc/gdb/isatty.html#isatty"/><topic label="system" href="doc/gdb/system.html#system"/></topic><topic label="E.14.8 Protocol-specific Representation of Datatypes" href="doc/gdb/Protocol_002dspecific-Representation-of-Datatypes.html#Protocol_002dspecific-Representation-of-Datatypes">
# <topic label="Integral Datatypes" href="doc/gdb/Integral-Datatypes.html#Integral-Datatypes"/><topic label="Pointer Values" href="doc/gdb/Pointer-Values.html#Pointer-Values"/><topic label="Memory Transfer" href="doc/gdb/Memory-Transfer.html#Memory-Transfer"/><topic label="struct stat" href="doc/gdb/struct-stat.html#struct-stat"/><topic label="struct timeval" href="doc/gdb/struct-timeval.html#struct-timeval"/></topic><topic label="E.14.9 Constants" href="doc/gdb/Constants.html#Constants">
# <topic label="Open Flags" href="doc/gdb/Open-Flags.html#Open-Flags"/><topic label="mode_t Values" href="doc/gdb/mode_005ft-Values.html#mode_005ft-Values"/><topic label="Errno Values" href="doc/gdb/Errno-Values.html#Errno-Values"/><topic label="Lseek Flags" href="doc/gdb/Lseek-Flags.html#Lseek-Flags"/><topic label="Limits" href="doc/gdb/Limits.html#Limits"/></topic><topic label="E.14.10 File-I/O Examples" href="doc/gdb/File_002dI_002fO-Examples.html#File_002dI_002fO-Examples"/></topic><topic label="E.15 Library List Format" href="doc/gdb/Library-List-Format.html#Library-List-Format"/><topic label="E.16 Library List Format for SVR4 Targets" href="doc/gdb/Library-List-Format-for-SVR4-Targets.html#Library-List-Format-for-SVR4-Targets"/><topic label="E.17 Memory Map Format" href="doc/gdb/Memory-Map-Format.html#Memory-Map-Format"/><topic label="E.18 Thread List Format" href="doc/gdb/Thread-List-Format.html#Thread-List-Format"/><topic label="E.19 Traceframe Info Format" href="doc/gdb/Traceframe-Info-Format.html#Traceframe-Info-Format"/><topic label="E.20 Branch Trace Format" href="doc/gdb/Branch-Trace-Format.html#Branch-Trace-Format"/></topic><topic label="Appendix F The GDB Agent Expression Mechanism" href="doc/gdb/Agent-Expressions.html#Agent-Expressions">
# <topic label="F.1 General Bytecode Design" href="doc/gdb/General-Bytecode-Design.html#General-Bytecode-Design"/><topic label="F.2 Bytecode Descriptions" href="doc/gdb/Bytecode-Descriptions.html#Bytecode-Descriptions"/><topic label="F.3 Using Agent Expressions" href="doc/gdb/Using-Agent-Expressions.html#Using-Agent-Expressions"/><topic label="F.4 Varying Target Capabilities" href="doc/gdb/Varying-Target-Capabilities.html#Varying-Target-Capabilities"/><topic label="F.5 Rationale" href="doc/gdb/Rationale.html#Rationale"/></topic><topic label="Appendix G Target Descriptions" href="doc/gdb/Target-Descriptions.html#Target-Descriptions">
# <topic label="G.1 Retrieving Descriptions" href="doc/gdb/Retrieving-Descriptions.html#Retrieving-Descriptions"/><topic label="G.2 Target Description Format" href="doc/gdb/Target-Description-Format.html#Target-Description-Format">
# <topic label="G.2.1 Inclusion" href="doc/gdb/Target-Description-Format.html#Target-Description-Format"/><topic label="G.2.2 Architecture" href="doc/gdb/Target-Description-Format.html#Target-Description-Format"/><topic label="G.2.3 OS ABI" href="doc/gdb/Target-Description-Format.html#Target-Description-Format"/><topic label="G.2.4 Compatible Architecture" href="doc/gdb/Target-Description-Format.html#Target-Description-Format"/><topic label="G.2.5 Features" href="doc/gdb/Target-Description-Format.html#Target-Description-Format"/><topic label="G.2.6 Types" href="doc/gdb/Target-Description-Format.html#Target-Description-Format"/><topic label="G.2.7 Registers" href="doc/gdb/Target-Description-Format.html#Target-Description-Format"/></topic><topic label="G.3 Predefined Target Types" href="doc/gdb/Predefined-Target-Types.html#Predefined-Target-Types"/><topic label="G.4 Standard Target Features" href="doc/gdb/Standard-Target-Features.html#Standard-Target-Features">
# <topic label="G.4.1 AArch64 Features" href="doc/gdb/AArch64-Features.html#AArch64-Features"/><topic label="G.4.2 ARM Features" href="doc/gdb/ARM-Features.html#ARM-Features"/><topic label="G.4.3 i386 Features" href="doc/gdb/i386-Features.html#i386-Features"/><topic label="G.4.4 MIPS Features" href="doc/gdb/MIPS-Features.html#MIPS-Features"/><topic label="G.4.5 M68K Features" href="doc/gdb/M68K-Features.html#M68K-Features"/><topic label="G.4.6 Nios II Features" href="doc/gdb/Nios-II-Features.html#Nios-II-Features"/><topic label="G.4.7 PowerPC Features" href="doc/gdb/PowerPC-Features.html#PowerPC-Features"/><topic label="G.4.8 S/390 and System z Features" href="doc/gdb/S_002f390-and-System-z-Features.html#S_002f390-and-System-z-Features"/><topic label="G.4.9 TMS320C6x Features" href="doc/gdb/TIC6x-Features.html#TIC6x-Features"/></topic></topic><topic label="Appendix H Operating System Information" href="doc/gdb/Operating-System-Information.html#Operating-System-Information">
# <topic label="H.1 Process list" href="doc/gdb/Process-list.html#Process-list"/></topic><topic label="Appendix I Trace File Format" href="doc/gdb/Trace-File-Format.html#Trace-File-Format"/><topic label="Appendix J .gdb_index section format" href="doc/gdb/Index-Section-Format.html#Index-Section-Format"/><topic label="Appendix K Manual pages" href="doc/gdb/Man-Pages.html#Man-Pages"/><topic label="Appendix L GNU GENERAL PUBLIC LICENSE" href="doc/gdb/Copying.html#Copying"/><topic label="Appendix M GNU Free Documentation License" href="doc/gdb/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/><topic label="Concept Index" href="doc/gdb/Concept-Index.html#Concept-Index"/><topic label="Command, Variable, and Function Index" href="doc/gdb/Command-and-Variable-Index.html#Command-and-Variable-Index"/><topic label="Summary" href="doc/gdb/Summary.html#Summary"/><topic label="Sample Session" href="doc/gdb/Sample-Session.html#Sample-Session"/><topic label="Invocation" href="doc/gdb/Invocation.html#Invocation"/><topic label="Commands" href="doc/gdb/Commands.html#Commands"/><topic label="Running" href="doc/gdb/Running.html#Running"/><topic label="Stopping" href="doc/gdb/Stopping.html#Stopping"/><topic label="Reverse Execution" href="doc/gdb/Reverse-Execution.html#Reverse-Execution"/><topic label="Process Record and Replay" href="doc/gdb/Process-Record-and-Replay.html#Process-Record-and-Replay"/><topic label="Stack" href="doc/gdb/Stack.html#Stack"/><topic label="Source" href="doc/gdb/Source.html#Source"/><topic label="Data" href="doc/gdb/Data.html#Data"/><topic label="Optimized Code" href="doc/gdb/Optimized-Code.html#Optimized-Code"/><topic label="Macros" href="doc/gdb/Macros.html#Macros"/><topic label="Tracepoints" href="doc/gdb/Tracepoints.html#Tracepoints"/><topic label="Overlays" href="doc/gdb/Overlays.html#Overlays"/><topic label="Languages" href="doc/gdb/Languages.html#Languages"/><topic label="Symbols" href="doc/gdb/Symbols.html#Symbols"/><topic label="Altering" href="doc/gdb/Altering.html#Altering"/><topic label="GDB Files" href="doc/gdb/GDB-Files.html#GDB-Files"/><topic label="Targets" href="doc/gdb/Targets.html#Targets"/><topic label="Remote Debugging" href="doc/gdb/Remote-Debugging.html#Remote-Debugging"/><topic label="Configurations" href="doc/gdb/Configurations.html#Configurations"/><topic label="Controlling GDB" href="doc/gdb/Controlling-GDB.html#Controlling-GDB"/><topic label="Extending GDB" href="doc/gdb/Extending-GDB.html#Extending-GDB"/><topic label="Interpreters" href="doc/gdb/Interpreters.html#Interpreters"/><topic label="TUI" href="doc/gdb/TUI.html#TUI"/><topic label="Emacs" href="doc/gdb/Emacs.html#Emacs"/><topic label="GDB/MI" href="doc/gdb/GDB_002fMI.html#GDB_002fMI"/><topic label="Annotations" href="doc/gdb/Annotations.html#Annotations"/><topic label="JIT Interface" href="doc/gdb/JIT-Interface.html#JIT-Interface"/><topic label="In-Process Agent" href="doc/gdb/In_002dProcess-Agent.html#In_002dProcess-Agent"/><topic label="GDB Bugs" href="doc/gdb/GDB-Bugs.html#GDB-Bugs"/><topic label="Command Line Editing" href="doc/gdb/Command-Line-Editing.html#Command-Line-Editing"/><topic label="Using History Interactively" href="doc/gdb/Using-History-Interactively.html#Using-History-Interactively"/><topic label="In Memoriam" href="doc/gdb/In-Memoriam.html#In-Memoriam"/><topic label="Formatting Documentation" href="doc/gdb/Formatting-Documentation.html#Formatting-Documentation"/><topic label="Installing GDB" href="doc/gdb/Installing-GDB.html#Installing-GDB"/><topic label="Maintenance Commands" href="doc/gdb/Maintenance-Commands.html#Maintenance-Commands"/><topic label="Remote Protocol" href="doc/gdb/Remote-Protocol.html#Remote-Protocol"/><topic label="Agent Expressions" href="doc/gdb/Agent-Expressions.html#Agent-Expressions"/><topic label="Target Descriptions" href="doc/gdb/Target-Descriptions.html#Target-Descriptions"/><topic label="Operating System Information" href="doc/gdb/Operating-System-Information.html#Operating-System-Information"/><topic label="Trace File Format" href="doc/gdb/Trace-File-Format.html#Trace-File-Format"/><topic label="Index Section Format" href="doc/gdb/Index-Section-Format.html#Index-Section-Format"/><topic label="Man Pages" href="doc/gdb/Man-Pages.html#Man-Pages"/><topic label="Copying" href="doc/gdb/Copying.html#Copying"/><topic label="GNU Free Documentation License" href="doc/gdb/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License"/><topic label="Concept Index" href="doc/gdb/Concept-Index.html#Concept-Index"/><topic label="Command and Variable Index" href="doc/gdb/Command-and-Variable-Index.html#Command-and-Variable-Index"/>
# </topic>
# <topic label="Getting Started">
# <topic label="Preface" href="doc/getting-started/pr01.html"><topic label="1. Intended Audience" href="doc/getting-started/pr01.html#idm47592725736800"/><topic label="2. Organization" href="doc/getting-started/pr01s02.html"/><topic label="3. Typographical Conventions" href="doc/getting-started/pr01s03.html"/></topic><topic label="1. Quick Start" href="doc/getting-started/chap-quickstart.html"><topic label="1.1. Installation and Set-Up" href="doc/getting-started/chap-quickstart.html#idm47592725802144"/><topic label="1.2. Configuring Sourcery CodeBench Lite for the Target System" href="doc/getting-started/ch01s02.html"/><topic label="1.3. Building Your Program" href="doc/getting-started/ch01s03.html"/><topic label="1.4. Running and Debugging Your Program" href="doc/getting-started/ch01s04.html"/></topic><topic label="2. Installation and Configuration" href="doc/getting-started/chap-installation.html"><topic label="2.1. Terminology" href="doc/getting-started/chap-installation.html#idm47592725637936"/><topic label="2.2. System Requirements" href="doc/getting-started/ch02s02.html"/><topic label="2.3. Registering with the Sourcery CodeBench Portal" href="doc/getting-started/sec-portal-account.html"/><topic label="2.4. Downloading an Installer" href="doc/getting-started/ch02s04.html"/><topic label="2.5. Installing Sourcery CodeBench Lite" href="doc/getting-started/sec-installing.html"/><topic label="2.6. Installing Sourcery CodeBench Lite Updates" href="doc/getting-started/sec-updating.html"/><topic label="2.7. Setting up the Environment" href="doc/getting-started/sec-setting-up-environment.html"/><topic label="2.8. Uninstalling Sourcery CodeBench Lite" href="doc/getting-started/sec-uninstalling.html"/></topic><topic label="3. Sourcery CodeBench Lite for MIPS ELF" href="doc/getting-started/chap-target.html"><topic label="3.1. Included Components and Features" href="doc/getting-started/chap-target.html#idm47592725481648"/><topic label="3.2. Library Configurations" href="doc/getting-started/sec-multilibs.html"/><topic label="3.3. CS3 Support" href="doc/getting-started/sec-mips-elf-cs3.html"/><topic label="3.4. Using Sourcery CodeBench with MIPS Boards" href="doc/getting-started/sec-malta.html"/><topic label="3.5. Using Sourcery CodeBench with YAMON" href="doc/getting-started/sec-yamon.html"/><topic label="3.6. Profiling Support" href="doc/getting-started/sec-mips-elf-profiling.html"/><topic label="3.7. Using Flash Memory" href="doc/getting-started/sec-using-flash.html"/></topic><topic label="4. Using Sourcery CodeBench from the Command Line" href="doc/getting-started/chap-building.html"><topic label="4.1. Building an Application" href="doc/getting-started/chap-building.html#sec-factorial-build"/><topic label="4.2. Running Applications on the Target System" href="doc/getting-started/ch04s02.html"/><topic label="4.3. Running Applications from GDB" href="doc/getting-started/sec-remote-debugging.html"/></topic><topic label="5. CS3&#x2122;: The CodeSourcery Common Startup Code Sequence" href="doc/getting-started/chap-cs3.html"><topic label="5.1. Linker Scripts" href="doc/getting-started/chap-cs3.html#sec-cs3-linker-scripts"/><topic label="5.2. Program Startup and Termination" href="doc/getting-started/sec-cs3-startup.html"/><topic label="5.3. Memory Layout" href="doc/getting-started/sec-cs3-memory-layout.html"/><topic label="5.4. Interrupt Vectors and Handlers" href="doc/getting-started/sec-cs3-interrupts.html"/><topic label="5.5. Supported Boards for MIPS ELF" href="doc/getting-started/sec-cs3-supported-boards.html"/></topic><topic label="6. Sourcery CodeBench Debug Sprite" href="doc/getting-started/sprite.html"><topic label="6.1. Probing for Debug Devices" href="doc/getting-started/sprite.html#sec-sprite-probe"/><topic label="6.2. Debug Sprite Example" href="doc/getting-started/ch06s02.html"/><topic label="6.3. Invoking Sourcery CodeBench Debug Sprite" href="doc/getting-started/sec-sprite-invocation.html"/><topic label="6.4. Sourcery CodeBench Debug Sprite Options" href="doc/getting-started/sec-sprite-options.html"/><topic label="6.5. MDI Devices" href="doc/getting-started/debug-sprite-mdi-url.html"/><topic label="6.6. Debugging a Remote Board" href="doc/getting-started/ch06s06.html"/><topic label="6.7. Supported Board Files" href="doc/getting-started/sec-sprite-supported-boards.html"/><topic label="6.8. Board File Syntax" href="doc/getting-started/sec-sprite-board-file.html"/></topic><topic label="7. Next Steps with Sourcery CodeBench" href="doc/getting-started/chap-next-steps.html"><topic label="7.1. Sourcery CodeBench Knowledge Base" href="doc/getting-started/chap-next-steps.html#idm47592724610496"/><topic label="7.2. Manuals for GNU Toolchain Components" href="doc/getting-started/ch07s02.html"/></topic><topic label="A. Sourcery CodeBench Lite Release Notes" href="doc/getting-started/chap-release.html"><topic label="A.1. Changes in Sourcery CodeBench Lite for MIPS ELF" href="doc/getting-started/chap-release.html#sec-release-notes"/></topic><topic label="B. Sourcery CodeBench Lite Licenses" href="doc/getting-started/chap-license.html"><topic label="B.1. Sourcery CodeBench Lite License Agreement" href="doc/getting-started/chap-license.html#sec-eval-agreement"/><topic label="B.2. Licenses and Third-Party Information for Sourcery CodeBench Lite Components" href="doc/getting-started/apbs02.html"/><topic label="B.3. Attribution" href="doc/getting-started/apbs03.html"/></topic>
#  </topic>
# <topic label="C Library (Newlib) (HTML)">
# <topic label="Introduction" href="doc/libc/Introduction.html#Introduction"/><topic label="Stdlib" href="doc/libc/Stdlib.html#Stdlib"/><topic label="Ctype" href="doc/libc/Ctype.html#Ctype"/><topic label="Stdio" href="doc/libc/Stdio.html#Stdio"/><topic label="Strings" href="doc/libc/Strings.html#Strings"/><topic label="Wchar strings" href="doc/libc/Wchar-strings.html#Wchar-strings"/><topic label="Signals" href="doc/libc/Signals.html#Signals"/><topic label="Timefns" href="doc/libc/Timefns.html#Timefns"/><topic label="Locale" href="doc/libc/Locale.html#Locale"/><topic label="Reentrancy" href="doc/libc/Reentrancy.html#Reentrancy"/><topic label="Misc" href="doc/libc/Misc.html#Misc"/><topic label="Syscalls" href="doc/libc/Syscalls.html#Syscalls"/><topic label="Arglists" href="doc/libc/Arglists.html#Arglists"/><topic label="Document Index" href="doc/libc/Document-Index.html#Document-Index"/>
# </topic>
# <topic label="Math Library (Newlib) (HTML)">
# <topic label="Math" href="doc/libm/Math.html#Math"/><topic label="Complex" href="doc/libm/Complex.html#Complex"/><topic label="Reentrancy" href="doc/libm/Reentrancy.html#Reentrancy"/><topic label="Long Double Functions" href="doc/libm/Long-Double-Functions.html#Long-Double-Functions"/><topic label="Document Index" href="doc/libm/Document-Index.html#Document-Index"/>
# </topic>
# </toc>
# EOF0
# popenv

# echo " ----------# task [119/281] /i686-pc-linux-gnu/gdil/configure"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# rm -rf ${local_path}/obj/gdil-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# mkdir -p ${local_path}/obj/gdil-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# pushd ${local_path}/obj/gdil-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# check_mentor_trademarks ${local_path}/src/gdil-2015.05 --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --with-csl-docbook=${local_path}/src/csl-docbook-trunk '--with-xml-catalog-files=/usr/local/tools/gcc-4.7.3/share/sgml/docbook/docbook-xsl/catalog.xml /etc/xml/catalog' --disable-nls --with-expat=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr '--with-features=xml autoconf driver config sprite doc transport_socket transport_stdio'
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [120/281] /i686-pc-linux-gnu/gdil/build"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# pushd ${local_path}/obj/gdil-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make ${JX}
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [121/281] /i686-pc-linux-gnu/gdil/install"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# pushd ${local_path}/obj/gdil-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make install
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [122/281] /i686-pc-linux-gnu/edge_utils/build"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# rm -rf ${local_path}/obj/edge-utils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# mkdir -p ${local_path}/obj/edge-utils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# copy_dir_clean ${local_path}/src/edge-utils-2015.05/source ${local_path}/obj/edge-utils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/source
# chmod -R u+w ${local_path}/obj/edge-utils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make -C ${local_path}/obj/edge-utils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/source/debugger/utils -j4 BLDTYPE=rls HOST_OS=lnx GPREF=i686-pc-linux-gnu- lnx_rls/libUtils.a
# mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/edge-utils-i686-pc-linux-gnu/lib
# cp ${local_path}/obj/edge-utils-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/source/debugger/utils/lnx_rls/libUtils.a ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/edge-utils-i686-pc-linux-gnu/lib
# mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/edge-utils-i686-pc-linux-gnu/include
# cp ${local_path}/src/edge-utils-2015.05/source/debugger/utils/NumericValue.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/clBaseTypes.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/clByteBuffer.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/clErrorLogger.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/clException.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/clStl.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluAllocators.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluAtomic.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluCLibrary.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluCond.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluConfigData.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluConfigFile.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluDebugTrace.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluDll.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluEmo.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluEndian.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluErrors.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluEvent.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluEventWaiter.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluFile.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluFileUtils.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluFindFile.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluFunctionTrace.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluGuard.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluHighResTimer.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluHtmlLogFile.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluInetPackets.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluInetSocket.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluLogFile.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluMutex.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluOutput.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluQ.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluRedirect.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluRegex.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluSemaphore.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluSerialPort.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluSerialPortBase.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluSerialPortPosix.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluSerialPortWin32.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluSmartPtr.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluSocketBase.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluSplitPath.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluStats.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluStringHeapManager.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluStringUtil.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluSync.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluTask.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluTextTable.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluThread.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluThreadPool.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluThreadedMember.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluTime.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluTimerQueue.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluTransaction.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluTransactionIdMap.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluUniqueIDManager.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluUnixSignalHandling.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluUtils.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluUtilsPch.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluValueMap.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluVector.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluXmlParser.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/rpn_calc.h ${local_path}/src/edge-utils-2015.05/source/debugger/utils/stdint_opus.h ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/edge-utils-i686-pc-linux-gnu/include
# cp ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluConfigData.inl ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluEvent.inl ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluGuard.inl ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluHighResTimer.inl ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluLogFile.inl ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluMutex.inl ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluTask.inl ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluThread.inl ${local_path}/src/edge-utils-2015.05/source/debugger/utils/cluTime.inl ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/edge-utils-i686-pc-linux-gnu/include
# popenv

# echo " ----------# task [123/281] /i686-pc-linux-gnu/mips_sprite/configure"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# rm -rf ${local_path}/obj/mips_sprite-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# mkdir -p ${local_path}/obj/mips_sprite-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# pushd ${local_path}/obj/mips_sprite-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# check_mentor_trademarks ${local_path}/src/mips_sprite-2015.05 --prefix=${local_path}/install/opt/codesourcery --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu '--with-pkgversion=Ingenic 2015.05' --with-bugurl=https://ingenic.com --enable-backends=mdimips --disable-nls --with-gdil=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-expat=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-boards=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/cs3/boards
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [124/281] /i686-pc-linux-gnu/mips_sprite/build"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# pushd ${local_path}/obj/mips_sprite-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make ${JX}
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [125/281] /i686-pc-linux-gnu/mips_sprite/install"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# pushd ${local_path}/obj/mips_sprite-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make install prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=${local_path}/install/opt/codesourcery/share
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [126/281] /i686-pc-linux-gnu/sprite/configure"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# rm -rf ${local_path}/obj/sprite-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# mkdir -p ${local_path}/obj/sprite-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# pushd ${local_path}/obj/sprite-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# check_mentor_trademarks ${local_path}/src/sprite-2015.05 --prefix=${local_path}/install/opt/codesourcery --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu '--with-pkgversion=Ingenic 2015.05' --with-bugurl=https://ingenic.com --enable-backends=mdimips --disable-nls --with-gdil=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-expat=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-boards=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/cs3/boards --with-edge-utils=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/edge-utils-i686-pc-linux-gnu --with-mep_cs=
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [127/281] /i686-pc-linux-gnu/sprite/build"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# pushd ${local_path}/obj/sprite-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make ${JX}
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [128/281] /i686-pc-linux-gnu/sprite/install"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# pushd ${local_path}/obj/sprite-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make install prefix=${local_path}/install/opt/codesourcery exec_prefix=${local_path}/install/opt/codesourcery libdir=${local_path}/install/opt/codesourcery/lib htmldir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=${local_path}/install/opt/codesourcery/share
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [129/281] /i686-pc-linux-gnu/sprite/postinstall"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# popenv
# popenv
# popenv

echo " ----------# task [130/281] /i686-pc-linux-gnu/gettext/configure"
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
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
rm -rf ${local_path}/obj/gettext-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/gettext-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/gettext-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/gettext-0.18.1.1 --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --with-included-libxml --with-included-gettext --enable-nls
popd
popenv
popenv
popenv

echo " ----------# task [131/281] /i686-pc-linux-gnu/gettext/build"
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
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
pushd ${local_path}/obj/gettext-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [132/281] /i686-pc-linux-gnu/gettext/install"
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
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
pushd ${local_path}/obj/gettext-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo " ----------# task [133/281] /i686-pc-linux-gnu/libffi/configure"
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
rm -rf ${local_path}/obj/libffi-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/libffi-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/libffi-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/libffi-3.0.13 --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls
popd
popenv
popenv
popenv

echo " ----------# task [134/281] /i686-pc-linux-gnu/libffi/build"
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
pushd ${local_path}/obj/libffi-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [135/281] /i686-pc-linux-gnu/libffi/install"
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
pushd ${local_path}/obj/libffi-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

# echo " ----------# task [136/281] /i686-pc-linux-gnu/glib/copy"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# pushenvvar CC 'gcc  -fPIE'
# pushenvvar CXX 'g++  -fPIE'
# pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
# pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
# pushenvvar PKG_CONFIG_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/pkgconfig
# rm -rf ${local_path}/obj/glib-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# copy_dir_clean ${local_path}/src/glib-2.30.2 ${local_path}/obj/glib-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# chmod -R u+w ${local_path}/obj/glib-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# touch ${local_path}/obj/glib-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
# popenv
# popenv
# popenv

# echo " ----------# task [137/281] /i686-pc-linux-gnu/glib/configure"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# pushenvvar CC 'gcc  -fPIE'
# pushenvvar CXX 'g++  -fPIE'
# pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
# pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
# pushenvvar PKG_CONFIG_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/pkgconfig
# rm -rf ${local_path}/obj/glib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# mkdir -p ${local_path}/obj/glib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# pushd ${local_path}/obj/glib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# check_mentor_trademarks ${local_path}/obj/glib-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls glib_cv_long_long_format=ll glib_cv_uscore=yes ac_cv_func_posix_getpwuid_r=yes ac_cv_func_posix_getgrgid_r=yes glib_cv_stack_grows=no
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [138/281] /i686-pc-linux-gnu/glib/build"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# pushenvvar CC 'gcc  -fPIE'
# pushenvvar CXX 'g++  -fPIE'
# pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
# pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
# pushenvvar PKG_CONFIG_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/pkgconfig
# pushd ${local_path}/obj/glib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make ${JX} V=1
# popd
# popenv
# popenv
# popenv

# echo " ----------# task [139/281] /i686-pc-linux-gnu/glib/install"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# pushenv
# pushenv
# pushenvvar CC 'gcc  -fPIE'
# pushenvvar CXX 'g++  -fPIE'
# pushenvvar CPPFLAGS -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
# pushenvvar LDFLAGS -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
# pushenvvar PKG_CONFIG_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/pkgconfig
# pushd ${local_path}/obj/glib-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# make install
# popd
# popenv
# popenv
# popenv

echo " ----------# task [140/281] /i686-pc-linux-gnu/pixman/configure"
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
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
rm -rf ${local_path}/obj/pixman-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/pixman-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/src/pixman-0.30.0
autoreconf -f -i
popd
pushd ${local_path}/obj/pixman-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/src/pixman-0.30.0 --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=i686-pc-linux-gnu --host=i686-pc-linux-gnu --disable-nls --disable-gtk --disable-libpng
popd
popenv
popenv
popenv

echo " ----------# task [141/281] /i686-pc-linux-gnu/pixman/build"
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
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
pushd ${local_path}/obj/pixman-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [142/281] /i686-pc-linux-gnu/pixman/install"
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
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
pushd ${local_path}/obj/pixman-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo " ----------# task [143/281] /i686-pc-linux-gnu/pixman/postinstall"
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
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
pushd ${local_path}/obj/pixman-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo " ----------# task [144/281] /i686-pc-linux-gnu/libfdt/copy"
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
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
rm -rf ${local_path}/obj/libfdt-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/libfdt-2015.05 ${local_path}/obj/libfdt-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/libfdt-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
touch ${local_path}/obj/libfdt-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv

echo " ----------# task [145/281] /i686-pc-linux-gnu/libfdt/configure"
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
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
rm -rf ${local_path}/obj/libfdt-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/libfdt-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/libfdt-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks ${local_path}/obj/libfdt-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu --prefix=${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls
popd
popenv
popenv
popenv

echo " ----------# task [146/281] /i686-pc-linux-gnu/libfdt/build"
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
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
pushd ${local_path}/obj/libfdt-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX}
popd
popenv
popenv
popenv

echo " ----------# task [147/281] /i686-pc-linux-gnu/libfdt/install"
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
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
pushd ${local_path}/obj/libfdt-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo " ----------# task [148/281] /i686-pc-linux-gnu/qemu/copy"
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
pushenvvar PKG_CONFIG_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/pkgconfig
pushenvvar PKG_CONFIG pkg-config
prepend_path PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/bin
prepend_path LD_LIBRARY_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf ${local_path}/obj/qemu-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean ${local_path}/src/qemu-2.2-2015.05 ${local_path}/obj/qemu-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w ${local_path}/obj/qemu-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
touch ${local_path}/obj/qemu-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv

echo " ----------# task [149/281] /i686-pc-linux-gnu/qemu/configure"
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
pushenvvar PKG_CONFIG_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/pkgconfig
pushenvvar PKG_CONFIG pkg-config
prepend_path PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/bin
prepend_path LD_LIBRARY_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf ${local_path}/obj/qemu-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/qemu-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
pushd ${local_path}/obj/qemu-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
#check_mentor_trademarks ${local_path}/obj/qemu-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu --prefix=${local_path}/install/opt/codesourcery '--with-pkgversion=Ingenic 2015.05' --with-bugurl=https://ingenic.com --disable-sdl --cpu= --cross-prefix=i686-pc-linux-gnu- --host-cc=i686-pc-linux-gnu-gcc --target-list=,mips64-softmmu,mips64el-softmmu --disable-vnc-sasl --disable-vnc-tls --disable-curses --disable-vnc-jpeg --disable-virtfs --other-endian-list=,mips-sde-elf-qemu-system-el,mips-sde-elf-qemu-system '--extra-cflags= 		    -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include' '--extra-ldflags= 		    -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib  		    -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib'
check_mentor_trademarks ${local_path}/obj/qemu-src-2015.05-19-mips-sde-elf-i686-pc-linux-gnu --prefix=${local_path}/install/opt/codesourcery '--with-pkgversion=Ingenic 2015.05' --with-bugurl=https://ingenic.com --disable-sdl --cpu= --cross-prefix=i686-pc-linux-gnu- --host-cc=i686-pc-linux-gnu-gcc --disable-xfsctl --target-list=,mips-softmmu,mipsel-softmmu --disable-vnc-sasl --disable-vnc-tls --disable-curses --disable-vnc-jpeg --disable-virtfs --other-endian-list=,mips-sde-elf-qemu-system-el,mips-sde-elf-qemu-system '--extra-cflags= 		    -I${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include' '--extra-ldflags= 		    -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib  		    -L${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib'
popd
popenv
popenv
popenv

echo " ----------# task [150/281] /i686-pc-linux-gnu/qemu/build"
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
pushenvvar PKG_CONFIG_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/pkgconfig
pushenvvar PKG_CONFIG pkg-config
prepend_path PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/bin
prepend_path LD_LIBRARY_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/qemu-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make ${JX} V=1
popd
popenv
popenv
popenv

echo " ----------# task [151/281] /i686-pc-linux-gnu/qemu/install"
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
pushenvvar PKG_CONFIG_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/pkgconfig
pushenvvar PKG_CONFIG pkg-config
prepend_path PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/bin
prepend_path LD_LIBRARY_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/qemu-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
mkdir -p ${local_path}/install/opt/codesourcery/bin
#install -m 755 mips64-softmmu/qemu-system-mips64 ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-qemu-system
#install -m 755 mips64el-softmmu/qemu-system-mips64el ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-qemu-system-el
install -m 755 mips-softmmu/qemu-system-mips ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-qemu-system
install -m 755 mipsel-softmmu/qemu-system-mipsel ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-qemu-system-el
popd
popenv
popenv
popenv

echo " ----------# task [152/281] /i686-pc-linux-gnu/qemu/postinstall"
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
pushenvvar PKG_CONFIG_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/pkgconfig
pushenvvar PKG_CONFIG pkg-config
prepend_path PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/bin
prepend_path LD_LIBRARY_PATH ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd ${local_path}/obj/qemu-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv


echo " ----------# task [153/281] /i686-pc-linux-gnu/finalize_libc_installation"
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
popenv

echo " ----------# task [154/281] /i686-pc-linux-gnu/pretidy_installation"
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
pushd ${local_path}/install/opt/codesourcery
popd
popenv

echo " ----------# task [155/281] /i686-pc-linux-gnu/remove_libtool_archives"
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
find ${local_path}/install/opt/codesourcery -name '*.la' -exec rm '{}' ';'
popenv

echo " ----------# task [156/281] /i686-pc-linux-gnu/remove_copied_libs"
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
popenv

echo " ----------# task [157/281] /i686-pc-linux-gnu/remove_fixed_headers"
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
pushd ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/include-fixed
popd
popenv

echo " ----------# task [158/281] /i686-pc-linux-gnu/add_tooldir_readme"
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
cat > ${local_path}/install/opt/codesourcery/mips-sde-elf/bin/README.txt <<'EOF0'
The executables in this directory are for internal use by the compiler
and may not operate correctly when used directly.  This directory
should not be placed on your PATH.  Instead, you should use the
executables in ../../bin/ and place that directory on your PATH.
EOF0
popenv

echo " ----------# task [159/281] /i686-pc-linux-gnu/strip_host_objects"
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
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-addr2line
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-ar
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-as
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-c++
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-c++filt
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-conv
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-cpp
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-elfedit
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-g++
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-gcc
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-gcc-4.9.2
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-gcc-ar
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-gcc-nm
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-gcc-ranlib
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-gcov
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-gdb
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-gprof
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-ld
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-nm
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-objcopy
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-objdump
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-qemu-system
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-qemu-system-el
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-ranlib
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-readelf
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-size
#strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-sprite
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-strings
strip ${local_path}/install/opt/codesourcery/bin/mips-sde-elf-strip
strip ${local_path}/install/opt/codesourcery/mips-sde-elf/bin/ar
strip ${local_path}/install/opt/codesourcery/mips-sde-elf/bin/as
strip ${local_path}/install/opt/codesourcery/mips-sde-elf/bin/ld
strip ${local_path}/install/opt/codesourcery/mips-sde-elf/bin/nm
strip ${local_path}/install/opt/codesourcery/mips-sde-elf/bin/objcopy
strip ${local_path}/install/opt/codesourcery/mips-sde-elf/bin/objdump
strip ${local_path}/install/opt/codesourcery/mips-sde-elf/bin/ranlib
strip ${local_path}/install/opt/codesourcery/mips-sde-elf/bin/strip
strip ${local_path}/install/opt/codesourcery/libexec/gcc/mips-sde-elf/4.9.2/cc1
strip ${local_path}/install/opt/codesourcery/libexec/gcc/mips-sde-elf/4.9.2/collect2
strip ${local_path}/install/opt/codesourcery/libexec/gcc/mips-sde-elf/4.9.2/install-tools/fixincl
strip ${local_path}/install/opt/codesourcery/libexec/gcc/mips-sde-elf/4.9.2/plugin/gengtype
strip ${local_path}/install/opt/codesourcery/libexec/gcc/mips-sde-elf/4.9.2/cc1plus
strip ${local_path}/install/opt/codesourcery/libexec/gcc/mips-sde-elf/4.9.2/lto-wrapper
strip ${local_path}/install/opt/codesourcery/libexec/gcc/mips-sde-elf/4.9.2/lto1
strip ${local_path}/install/opt/codesourcery/libexec/gcc/mips-sde-elf/4.9.2/liblto_plugin.so
strip ${local_path}/install/opt/codesourcery/lib/libpython2.7.so.1.0
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_bisect.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_codecs_cn.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_codecs_hk.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_codecs_iso2022.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_codecs_jp.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_codecs_kr.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_codecs_tw.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_collections.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_csv.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_ctypes.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_ctypes_test.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_elementtree.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_functools.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_heapq.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_hotshot.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_io.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_json.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_locale.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_lsprof.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_multibytecodec.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_multiprocessing.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_random.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_socket.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_struct.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/_testcapi.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/array.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/audioop.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/binascii.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/cPickle.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/cStringIO.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/cmath.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/crypt.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/datetime.so
#strip ${local_path}/install/opt/codesourcery/lib/python2.7/dl.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/fcntl.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/future_builtins.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/grp.so
#strip ${local_path}/install/opt/codesourcery/lib/python2.7/imageop.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/itertools.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/linuxaudiodev.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/math.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/mmap.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/nis.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/operator.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/ossaudiodev.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/parser.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/pyexpat.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/resource.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/select.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/spwd.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/strop.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/syslog.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/termios.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/time.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/unicodedata.so
strip ${local_path}/install/opt/codesourcery/lib/python2.7/zlib.so
popenv

echo " ----------# task [160/281] /i686-pc-linux-gnu/strip_target_objects"
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
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/sof/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/mips16/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/64/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/nan2008/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/64/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/micromips/sof/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/sof/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/mips16/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/64/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/nan2008/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/64/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/sof/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/el/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/mips-sde-elf/lib/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/mips16/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/mips16/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/mips16/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/mips16/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/mips16/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/mips16/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/mips16/sof/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/mips16/sof/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/mips16/sof/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/mips16/sof/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/mips16/sof/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/mips16/sof/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/64/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/64/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/64/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/64/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/64/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/64/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/nan2008/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/nan2008/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/nan2008/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/nan2008/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/nan2008/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/nan2008/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/sof/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/sof/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/sof/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/sof/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/sof/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/sof/64/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/sof/64/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/sof/64/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/sof/64/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/sof/64/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/sof/64/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/sof/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/micromips/sof/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/micromips/sof/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/micromips/sof/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/micromips/sof/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/micromips/sof/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/micromips/sof/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/mips16/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/mips16/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/mips16/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/mips16/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/mips16/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/mips16/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/mips16/sof/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/mips16/sof/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/mips16/sof/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/mips16/sof/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/mips16/sof/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/mips16/sof/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/64/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/64/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/64/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/64/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/64/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/64/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/nan2008/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/nan2008/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/nan2008/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/nan2008/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/nan2008/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/nan2008/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/sof/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/sof/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/sof/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/sof/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/sof/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/sof/64/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/sof/64/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/sof/64/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/sof/64/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/sof/64/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/sof/64/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc ${local_path}/install/opt/codesourcery/lib/gcc/mips-sde-elf/4.9.2/el/sof/libgcc.a || true
popenv

echo " ----------# task [161/281] /i686-pc-linux-gnu/package_tbz2"
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
rm -f ${local_path}/pkg/mips-2015.05-19-mips-sde-elf-i686-pc-linux-gnu.tar.bz2
pushd ${local_path}/obj
rm -f mips-2015.05
ln -s ${local_path}/install/opt/codesourcery mips-2015.05
tar cjf ${local_path}/pkg/mips-2015.05-19-mips-sde-elf-i686-pc-linux-gnu.tar.bz2 --owner=0 --group=0 --exclude=host-i686-pc-linux-gnu --exclude=host-i686-mingw32 mips-2015.05/bin mips-2015.05/i686-pc-linux-gnu mips-2015.05/lib mips-2015.05/libexec mips-2015.05/mips-sde-elf mips-2015.05/share
rm -f mips-2015.05
popd
popenv

# echo " ----------# task [266/281] /init/build_p2_repogenerator"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# rm -rf ${local_path}/obj/p2_repogenerator-2015.05-19-mips-sde-elf
# mkdir -p ${local_path}/obj/p2_repogenerator-2015.05-19-mips-sde-elf
# copy_dir_clean ${local_path}/src/p2_repogenerator-2015.05 ${local_path}/obj/p2_repogenerator-2015.05-19-mips-sde-elf
# chmod -R u+w ${local_path}/obj/p2_repogenerator-2015.05-19-mips-sde-elf
# /usr/local/tools/gcc-4.7.3/bin/java -cp /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/plugins/org.eclipse.equinox.launcher_1.3.0.v20140415-2008.jar org.eclipse.core.launcher.Main -application org.eclipse.ant.core.antRunner -buildfile /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/plugins/org.eclipse.pde.build_3.9.0.v20140415-2029/scripts/build.xml -Dbuilder=${local_path}/obj/p2_repogenerator-2015.05-19-mips-sde-elf/build -DbaseLocation=/usr/local/tools/gcc-4.7.3/eclipse-4.4.2 -DbuildDirectory=${local_path}/obj/p2_repogenerator-2015.05-19-mips-sde-elf -Dconfigs=
# rm -rf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/p2_repogenerator
# mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/p2_repogenerator
# cp -a /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/about.html /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/about_files /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/artifacts.xml /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/configuration /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/dropins /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/eclipse /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/eclipse.ini /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/epl-v10.html /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/features /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/icon.xpm /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/notice.html /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/p2 /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/plugins /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/readme ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/p2_repogenerator
# chmod -R u+w ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/p2_repogenerator
# mkdir ${local_path}/obj/p2_repogenerator-2015.05-19-mips-sde-elf/feature
# pushd ${local_path}/obj/p2_repogenerator-2015.05-19-mips-sde-elf/feature
# unzip ${local_path}/obj/p2_repogenerator-2015.05-19-mips-sde-elf/I.TestBuild/com.codesourcery.repogenerator.feature-TestBuild.zip
# popd
# cp -a ${local_path}/obj/p2_repogenerator-2015.05-19-mips-sde-elf/feature/eclipse/plugins ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/p2_repogenerator
# rm -rf ${local_path}/obj/p2_repogenerator-2015.05-19-mips-sde-elf/feature
# popenv

echo " ----------# task [267/281] /i686-pc-linux-gnu/package_tbz2"
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
rm -f ${local_path}/pkg/mips-2015.05-19-mips-sde-elf-i686-pc-linux-gnu.tar.bz2
pushd ${local_path}/obj
rm -f mips-2015.05
ln -s ${local_path}/install/opt/codesourcery mips-2015.05
tar cjf ${local_path}/pkg/mips-2015.05-19-mips-sde-elf-i686-pc-linux-gnu.tar.bz2 --owner=0 --group=0 --exclude=host-i686-pc-linux-gnu --exclude=host-i686-mingw32 mips-2015.05/bin mips-2015.05/i686-pc-linux-gnu mips-2015.05/lib mips-2015.05/libexec mips-2015.05/mips-sde-elf mips-2015.05/share
rm -f mips-2015.05
popd
popenv

# echo " ----------# task [268/281] /i686-pc-linux-gnu/package_p2_installer/create_toolchain_repo"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# ${local_path}/src/scripts-trunk/gnu-p2-toolchain -i ${local_path}/install -l ${local_path}/logs -o ${local_path}/obj -p ${local_path}/pkg -s ${local_path}/src -T ${local_path}/testlogs -h i686-pc-linux-gnu -e ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras sgxx/2015.05/mips-sde-elf-lite
# popenv



# echo " ----------# task [269/281] /i686-pc-linux-gnu/package_p2_installer/create_jre_repo"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# rm -rf ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# mkdir -p ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# mkdir -p ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/jre_tmp
# rm -rf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/jre_repo-i686-pc-linux-gnu
# mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/jre_repo-i686-pc-linux-gnu
# cp -a /opt/macrovision/InstallAnywhere_2010_Enterprise/resource/installer_vms/SunJre1.7.0LinuxINTEL.vm ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/jre_tmp
# pushd ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/jre_tmp
# unzip SunJre1.7.0LinuxINTEL.vm
# rm SunJre1.7.0LinuxINTEL.vm
# tar zxvf vm.tar.Z
# rm vm.tar.Z
# rm vm.properties
# mkdir -p ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/jre_tmp/linkprogs
# find . -type f -perm +111 -printf 'chmod;%#m;%P\n' > ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/link_list
# ${local_path}/src/scripts-trunk/gnu-linkprogs -i ${local_path}/install -l ${local_path}/logs -o ${local_path}/obj -p ${local_path}/pkg -s ${local_path}/src -T ${local_path}/testlogs -o ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/linkprogs/ sgxx/2015.05/mips-sde-elf-lite i686-pc-linux-gnu '' ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/jre_tmp/linkprogs/create-links-jre-i686-pc-linux-gnu ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/jre_tmp/linkprogs/remove-links-jre-i686-pc-linux-gnu ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/remove_script ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/copysize_script ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/link_list
# popd
# rm -rf ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/jre_repo-i686-pc-linux-gnu
# mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/jre_repo-i686-pc-linux-gnu
# /usr/local/tools/gcc-4.7.3/bin/java -cp ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/p2_repogenerator/plugins/org.eclipse.equinox.launcher_1.3.0.v20140415-2008.jar org.eclipse.core.launcher.Main -application com.codesourcery.repoGenerator -artifactDir ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/jre_tmp -outputDir ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/jre_repo-i686-pc-linux-gnu -iuName JRE -id jre -version 1.7.0 -type zip -description 'Java SE Runtime Environment' -zip -artifactSize 140244546
# rm -rf ${local_path}/obj/p2_jre-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/jre_tmp
# popenv

# echo " ----------# task [270/281] /i686-pc-linux-gnu/package_p2_installer/build"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# rm -rf ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# mkdir -p ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# copy_dir_clean ${local_path}/src/p2_installer-2015.05 ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# chmod -R u+w ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# copy_dir_clean ${local_path}/src/eclipse_common-2015.05/com.codesourcery.p2 ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/plugins/com.codesourcery.p2
# copy_dir_clean ${local_path}/src/eclipse_common-2015.05/com.codesourcery.util ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/plugins/com.codesourcery.util
# copy_dir_clean ${local_path}/src/eclipse_common-2015.05/com.codesourcery.util.eclipse ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/plugins/com.codesourcery.util.eclipse
# copy_dir_clean_if_present ${local_path}/src/eclipse_common-2015.05/com.codesourcery.esd.license ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/plugins/com.codesourcery.esd.license
# copy_dir_clean_if_present ${local_path}/src/eclipse_common-2015.05/com.codesourcery.esd.license.linux.x86 ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/plugins/com.codesourcery.esd.license.linux.x86
# copy_dir_clean_if_present ${local_path}/src/eclipse_common-2015.05/com.codesourcery.esd.license.linux.x86_64 ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/plugins/com.codesourcery.esd.license.linux.x86_64
# copy_dir_clean_if_present ${local_path}/src/eclipse_common-2015.05/com.codesourcery.esd.license.win32.x86 ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/plugins/com.codesourcery.esd.license.win32.x86
# copy_dir_clean_if_present ${local_path}/src/eclipse_common-2015.05/com.codesourcery.esd.license.win32.x86_64 ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/plugins/com.codesourcery.esd.license.win32.x86_64
# copy_dir_clean ${local_path}/src/portal-trunk ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/plugins/com.codesourcery.portal
# chmod -R u+w ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu
# i686-pc-linux-gnu-gcc -o ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/plugins/com.codesourcery.installer.linux.x86/exe/instmon-linux-x86 ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/instmon/src/main.c
# cp ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/plugins/com.codesourcery.installer.linux.x86/exe/instmon-linux-x86 ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/plugins/com.codesourcery.installer.linux.x86_64/exe/instmon-linux-x86_64
# rm -rf ${local_path}/pkg/p2_repos/codebench/2015.05-/mips-sde-elf/i686-pc-linux-gnu
# mkdir -p ${local_path}/pkg/p2_repos/codebench/2015.05-/mips-sde-elf/i686-pc-linux-gnu
# cp -a ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/jre_repo-i686-pc-linux-gnu/repo-jre-1.7.0.zip ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer/repos
# mkdir -p ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/config/configuration
# mkdir -p ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/workspace
# /usr/local/tools/gcc-4.7.3/bin/java -jar /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/plugins/org.eclipse.equinox.launcher_1.3.0.v20140415-2008.jar -application org.eclipse.equinox.p2.artifact.repository.mirrorApplication -configuration ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/config/configuration -data ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/workspace -consoleLog -source ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/p2_toolchain_repo-i686-pc-linux-gnu/repo-com.codesourcery.toolchain.mips_sde_elf-2015.5.0.19.zip -destination ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/finalRepo
# /usr/local/tools/gcc-4.7.3/bin/java -jar /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/plugins/org.eclipse.equinox.launcher_1.3.0.v20140415-2008.jar -application org.eclipse.equinox.p2.metadata.repository.mirrorApplication -configuration ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/config/configuration -data ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/workspace -consoleLog -source ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras/p2_toolchain_repo-i686-pc-linux-gnu/repo-com.codesourcery.toolchain.mips_sde_elf-2015.5.0.19.zip -destination ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/finalRepo
# pushd ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/finalRepo
# zip -r ${local_path}/pkg/p2_repos/codebench/2015.05-/mips-sde-elf/i686-pc-linux-gnu/sourcerygxx.zip artifacts.jar content.jar .blobstore
# popd
# sed -i 's|@MENTOR_CLOUD@|true|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@MENTOR_REPO_DIR@|codebench/2015.05-/mips-sde-elf/i686-pc-linux-gnu|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@MENTOR_LICENSE_ENABLE@|false|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@MENTOR_TARGET@|mips-sde-elf|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@MENTOR_TARGET_NAME@|MIPS ELF|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@P2_REQUIRED_ROOTS@|com.codesourcery.toolchain.mips_sde_elf|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@P2_OPTIONAL_ROOTS@||g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@P2_OPTIONAL_ROOTS_DEFAULT@||g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@PRODUCT_VERSION@|2015.05-19|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@PRODUCT_MONTH_AND_YEAR@|2015.05|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@PRODUCT_ID@|Sourcery_CodeBench_Lite_for_MIPS_ELF|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@MODULES@|com.codesourcery.installer.generalModule,com.codesourcery.installer.codebench.module|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@PRODUCT_EDITION@|Sourcery CodeBench Lite|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@PRODUCT_LOCATION@|Sourcery_CodeBench_Lite_for_MIPS_ELF|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@PRODUCT_DIRECTORY@|.|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@PRODUCT_ROOT_DIRECTORY@|codebench|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@MENTOR_ADDONS@||g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@ARCH_VALUE_LOWER_CASE@|mips|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@ARCH_VALUE_UPPER_CASE@|MIPS|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@P2_LINKS@|desktop;;Uninstall ${eclipse.p2.product.name};${eclipse.p2.uninstallLocation}/uninstall{exe};;;|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# sed -i 's|@P2_LAUNCH@| View the '\''Getting Started Guide (HTML)'\''?;${mentor.product.location}/share/doc/mips-mips-sde-elf/html/getting-started/index.html;file;true, Visit Mentor Embedded?;http://www.mentor.com/embedded-software/;html;false|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template
# rm -rf ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/baseLocation/eclipse
# mkdir -p ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/baseLocation/eclipse
# cp -a /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/about.html /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/about_files /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/artifacts.xml /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/configuration /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/dropins /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/eclipse /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/eclipse.ini /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/epl-v10.html /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/features /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/icon.xpm /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/notice.html /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/p2 /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/plugins /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/readme ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/baseLocation/eclipse
# pushd ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/baseLocation
# unzip -o /usr/local/gnu-toolchains/src/eclipse-4.4.2/eclipse-4.4.2-delta-pack.zip
# popd
# chmod -R u+w ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/baseLocation/eclipse
# cp ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer.codebench/installer.properties.template ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer/installer.properties
# sed -i 's|@MENTOR_REPO_JRE@|jar:file:./repos/repo-jre-1.7.0.zip!/|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer/installer.properties
# sed -i 's|@MENTOR_REPO_IDE@|jar:file:./repos/sourcerygxx.zip!/|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer/installer.properties
# sed -i 's|@MENTOR_REPO_ADDONS@||g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer/installer.properties
# sed -i 's|@WINDOW_TITLE@|Setup|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer/installer.properties
# sed -i 's|@WELCOME_TEXT@|${mentor.welcome.offline}|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer/installer.properties
# sed -i 's|@PROGRESS_TEXT@|Loading|g' ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer/installer.properties
# mv ${local_path}/pkg/p2_repos/codebench/2015.05-/mips-sde-elf/i686-pc-linux-gnu/sourcerygxx.zip ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/features/com.codesourcery.installer/repos
# /usr/local/tools/gcc-4.7.3/bin/java -cp /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/plugins/org.eclipse.equinox.launcher_1.3.0.v20140415-2008.jar org.eclipse.core.launcher.Main -application org.eclipse.ant.core.antRunner -buildfile /usr/local/tools/gcc-4.7.3/eclipse-4.4.2/plugins/org.eclipse.pde.build_3.9.0.v20140415-2029/scripts/productBuild/productBuild.xml -Dbuilder=${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/build -DbaseLocation=${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/baseLocation/eclipse/ -DbuildDirectory=${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu -Dconfigs=linux,gtk,x86
# popenv

# echo " ----------# task [271/281] /i686-pc-linux-gnu/package_p2_installer/install"
# pushenv
# pushenvvar CC_FOR_BUILD 'gcc '
# pushenvvar CXX_FOR_BUILD 'g++ '
# pushenvvar CC 'gcc '
# pushenvvar CXX 'g++ '
# pushenvvar LD 'ld '
# pushenvvar OBJCOPY 'objcopy '
# pushenvvar AR 'ar '
# pushenvvar AS 'as '
# pushenvvar RANLIB 'ranlib '
# prepend_path PATH ${local_path}/install/opt/codesourcery/bin
# rm -rf ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/sfx
# mkdir -p ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/sfx
# cp -a ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/I.TestBuild/TestBuild-linux.gtk.x86.zip ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/sfx
# pushd ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/sfx
# unzip TestBuild-linux.gtk.x86.zip
# rm -f ${local_path}/pkg/mips-2015.05-19-mips-sde-elf.bin
# chmod -R +x ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/sfx/eclipse/plugins/com.codesourcery.esd.license.linux.x86_1.1.0.201505121541
# ${local_path}/src/p2_installer-2015.05/sfx_codebench/scripts/linux/build_linux_p2_sfx.sh --installer-dir ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/sfx/eclipse --scratch-dir ${local_path}/obj/p2_installer-2015.05-19-mips-sde-elf-i686-pc-linux-gnu/sfx --output-file ${local_path}/pkg/mips-2015.05-19-mips-sde-elf.bin --help-url https://sourcery.mentor.com/GNUToolchain/kbentry62
# rm TestBuild-linux.gtk.x86.zip
# popd
# popenv

echo " ----------# task [278/281] /fini/extras_package"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.extras
pushd ${local_path}/obj/pkg-2015.05-19-mips-sde-elf
tar cjf ${local_path}/pkg/mips-2015.05-19-mips-sde-elf.extras.tar.bz2 --owner=0 --group=0 mips-2015.05-19-mips-sde-elf.extras
popd
popenv

echo " ----------# task [279/281] /fini/build_summary"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
cat > ${local_path}/pkg/mips-2015.05-19-mips-sde-elf-summary.xml <<'EOF0'
<?xml version="1.0" ?><build><variable var="release_config_canonical" value="sgxx/2015.05/mips-sde-elf-lite"/><variable var="version" value="2015.05-19"/><variable var="hosts_string" value="i686-pc-linux-gnu i686-mingw32"/><variable var="target" value="mips-sde-elf"/><variable var="build_date" value="20150512"/><variable var="HOSTNAME" value="build6-lucid-cs"/><variable var="build_operating_system" value="squeeze/sid"/><variable var="build_uname" value="Linux build6-lucid-cs 2.6.32-45-generic #104-Ubuntu SMP Tue Feb 19 21:20:09 UTC 2013 x86_64 GNU/Linux"/><variable var="USER" value="cmoore"/><checksum type="md5" value="d42334e8dcd2b801003f399db4b767a0" file="mips-2015.05-19-mips-sde-elf-i686-pc-linux-gnu.tar.bz2"/><checksum type="md5" value="c90175f68de0230cd249d150bbaf0618" file="mips-2015.05-19-mips-sde-elf-i686-mingw32.tar.bz2"/><checksum type="md5" value="96e205ad8001307adf631e1651b5c0aa" file="mips-2015.05-19-mips-sde-elf.extras.tar.bz2"/></build>
EOF0
popenv

echo " ----------# task [280/281] /fini/backups_package"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf.backup
pushd ${local_path}/obj/pkg-2015.05-19-mips-sde-elf
tar cjf ${local_path}/pkg/mips-2015.05-19-mips-sde-elf.backup.tar.bz2 --owner=0 --group=0 mips-2015.05-19-mips-sde-elf.backup
popd
popenv


echo " ----------# task [281/281] /fini/sources_package"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
mkdir -p ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
cp ${local_path}/pkg/mips-2015.05-19-mips-sde-elf-summary.xml ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
#cp ${local_path}/logs/mips-2015.05-19-mips-sde-elf.sh ${local_path}/obj/pkg-2015.05-19-mips-sde-elf/mips-2015.05-19-mips-sde-elf
pushd ${local_path}/obj/pkg-2015.05-19-mips-sde-elf
tar cjf ${local_path}/pkg/mips-2015.05-19-mips-sde-elf.src.tar.bz2 --owner=0 --group=0 mips-2015.05-19-mips-sde-elf
popd
# /scratch/cmoore/spring-final-elf/src/scripts-trunk/gnu-test -i /scratch/cmoore/spring-final-elf/install -l /scratch/cmoore/spring-final-elf/logs -o /scratch/cmoore/spring-final-elf/obj -p /scratch/cmoore/spring-final-elf/pkg -s /scratch/cmoore/spring-final-elf/src -T /scratch/cmoore/spring-final-elf/testlogs -T /scratch/cmoore/spring-final-elf/obj/testlogs-2015.05-19-mips-sde-elf sgxx/2015.05/mips-sde-elf-lite
# copy_dir /scratch/cmoore/spring-final-elf/obj/testlogs-2015.05-19-mips-sde-elf /scratch/cmoore/spring-final-elf/testlogs
# /scratch/cmoore/spring-final-elf/src/scripts-trunk/gnu-test-package -i /scratch/cmoore/spring-final-elf/install -l /scratch/cmoore/spring-final-elf/logs -o /scratch/cmoore/spring-final-elf/obj -p /scratch/cmoore/spring-final-elf/pkg -s /scratch/cmoore/spring-final-elf/src -T /scratch/cmoore/spring-final-elf/testlogs -T /scratch/cmoore/spring-final-elf/obj/testlogs-2015.05-19-mips-sde-elf sgxx/2015.05/mips-sde-elf-lite