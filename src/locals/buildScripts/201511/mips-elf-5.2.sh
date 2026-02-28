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

export WORKPATH=`pwd`
export JX=-j8


local_arch=64
if [ `uname -m`x = "i686"x ]; then
    local_arch=32
else
    local_arch=64
fi

#
# For release, should set version_mask;
#  eg. env version_mask=r3.0.0-gcc520 ./mips-elf-5.2.sh
#
if [ "${version_mask}"x = ""x ];then
    version_mask="internal-develop3"
else
    version_mask=${version_mask}
fi
datemask=`date +"%Y.%m-%d"`
echo "Ingenic ${version_mask} $datemask"

set -e
inform_fd=2
umask 022
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
pushenvvar CSL_SCRIPTDIR $WORKPATH/src/scripts-trunk
pushenvvar PATH /bin:/sbin:/usr/bin:/usr/local/bin
pushenvvar LD_LIBRARY_PATH /usr/local/lib:/usr/local/lib64
pushenvvar FLEXLM_NO_CKOUT_INSTALL_LIC ''
pushenvvar LM_APP_DISABLE_CACHE_READ ''
pushenvvar MAKEINFO 'makeinfo --css-ref=../cs.css'
pushenvvar CSL_CONFIG_SUB $WORKPATH/src/config-trunk/config.sub
clean_environment

echo "----------------# task [001/278] /init/dirs\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
mkdir -p $WORKPATH/obj
mkdir -p $WORKPATH/install/opt/codesourcery
mkdir -p $WORKPATH/pkg
mkdir -p $WORKPATH/logs/data
mkdir -p $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html
mkdir -p $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf
popenv

echo "----------------# task [002/278] /init/cleanup\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/pkg/mips-2015.11-33-mips-sde-elf.src.tar.bz2 $WORKPATH/pkg/mips-2015.11-33-mips-sde-elf.backup.tar.bz2
popenv

echo "----------------# task [003/278] /init/build_p2_repogenerator\n"
echo "----------------# task [004/278] /init/source_package/binutils\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/binutils-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/binutils-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' binutils-2015.11
popd
popenv

echo "----------------# task [005/278] /init/source_package/gcc\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/gcc-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/gcc-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' gcc-5-2015.11
popd
popenv

echo "----------------# task [006/278] /init/source_package/gdb\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/gdb-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/gdb-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' gdb-2015.11
popd
popenv

echo "----------------# task [007/278] /init/source_package/zlib\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/zlib-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/zlib-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' zlib-1.2.8
popd
popenv

echo "----------------# task [008/278] /init/source_package/gmp\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/gmp-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/gmp-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' gmp-2015.11
popd
popenv

echo "----------------# task [009/278] /init/source_package/mpfr\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/mpfr-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src/mpfr-2015.11
touch *
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/mpfr-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' mpfr-2015.11
popd
popenv

echo "----------------# task [010/278] /init/source_package/mpc\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/mpc-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/mpc-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' mpc-2015.11
popd
popenv

echo "----------------# task [011/278] /init/source_package/isl\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/isl-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src/isl-0.14
touch *
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/isl-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' isl-0.14
popd
popenv

echo "----------------# task [012/278] /init/source_package/ncurses\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/ncurses-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/ncurses-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' ncurses-5.9
popd
popenv

echo "----------------# task [013/278] /init/source_package/getting_started\n"
echo "----------------# task [014/278] /init/source_package/p2_installer\n"
echo "----------------# task [015/278] /init/source_package/fbench\n"
echo "----------------# task [016/278] /init/source_package/sprite\n"
echo "----------------# task [017/278] /init/source_package/mips_sprite\n"
echo "----------------# task [018/278] /init/source_package/eembc\n"
echo "----------------# task [019/278] /init/source_package/dhrystone\n"
echo "----------------# task [020/278] /init/source_package/newlib\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/newlib-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/newlib-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' newlib-2015.11
popd
popenv

echo "----------------# task [021/278] /init/source_package/cs3\n"
echo "----------------# task [022/278] /init/source_package/board_support\n"
echo "----------------# task [023/278] /init/source_package/python\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/python-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/python-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' python-2.7.5
popd
popenv

echo "----------------# task [024/278] /init/source_package/qemu\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/qemu-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/qemu-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' qemu-2.2-2015.11
popd
popenv

echo "----------------# task [025/278] /init/source_package/dejagnu_boards\n"
echo "----------------# task [026/278] /init/source_package/scripts\n"
echo "----------------# task [027/278] /init/source_package/xfails\n"
echo "----------------# task [028/278] /init/source_package/portal\n"
echo "----------------# task [029/278] /init/source_package/config\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/config-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/config-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' config-trunk
popd
popenv

echo "----------------# task [030/278] /init/source_package/csl_tests\n"
echo "----------------# task [031/278] /init/source_package/libiconv\n"
echo "----------------# task [032/278] /init/source_package/expat\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/expat-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/expat-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' expat-2015.11
popd
popenv

echo "----------------# task [033/278] /init/source_package/csl_docbook\n"
echo "----------------# task [034/278] /init/source_package/release_notes\n"
echo "----------------# task [035/278] /init/source_package/eclipse_common\n"
echo "----------------# task [036/278] /init/source_package/p2_repogenerator\n"
echo "----------------# task [037/278] /init/source_package/make\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/make-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/make-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' make-3.81
popd
popenv

echo "----------------# task [038/278] /init/source_package/coreutils\n"
echo "----------------# task [039/278] /init/source_package/gdil\n"
echo "----------------# task [040/278] /init/source_package/edge_utils\n"
echo "----------------# task [041/278] /init/source_package/python_win32\n"
echo "----------------# task [042/278] /init/source_package/glib\n"
echo "----------------# task [043/278] /init/source_package/pixman\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/pixman-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/pixman-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' pixman-0.32.6
popd
popenv

echo "----------------# task [044/278] /init/source_package/libfdt\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/libfdt-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/libfdt-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' libfdt-2015.11
popd
popenv

echo "----------------# task [045/278] /init/source_package/msvcrt\n"
echo "----------------# task [046/278] /init/source_package/libffi\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/libffi-2015.11-33.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf/libffi-2015.11-33.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' libffi-3.2.1
popd
popenv

echo "----------------# task [047/278] /init/source_package/gettext\n"
echo "----------------# task [048/278] /i686-pc-linux-gnu/host_cleanup\n"
echo "----------------# task [049/278] /i686-pc-linux-gnu/zlib_first/copy\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
rm -rf $WORKPATH/obj/zlib-first-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean $WORKPATH/src/zlib-1.2.8 $WORKPATH/obj/zlib-first-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w $WORKPATH/obj/zlib-first-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
popenv

echo "----------------# task [050/278] /i686-pc-linux-gnu/zlib_first/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushd $WORKPATH/obj/zlib-first-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushenv
pushenvvar CFLAGS '-O3 -fPIC'
pushenvvar CC 'gcc  '
pushenvvar AR 'ar '
pushenvvar RANLIB 'ranlib '
./configure --prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --static
popenv
popd
popenv

echo "----------------# task [051/278] /i686-pc-linux-gnu/zlib_first/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushd $WORKPATH/obj/zlib-first-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv

echo "----------------# task [052/278] /i686-pc-linux-gnu/zlib_first/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushd $WORKPATH/obj/zlib-first-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv

echo "----------------# task [053/278] /i686-pc-linux-gnu/gmp/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CFLAGS '-g -O2'
rm -rf $WORKPATH/obj/gmp-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/gmp-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/gmp-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
#check_mentor_trademarks $WORKPATH/src/gmp-2015.11 --prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=i686-pc-linux-gnu --host=i686-pc-linux-gnu --disable-nls
check_mentor_trademarks $WORKPATH/src/gmp-2015.11 --prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --enable-cxx ABI=${local_arch}
popd
popenv
popenv
popenv

echo "----------------# task [054/278] /i686-pc-linux-gnu/gmp/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CFLAGS '-g -O2'
pushd $WORKPATH/obj/gmp-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [055/278] /i686-pc-linux-gnu/gmp/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CFLAGS '-g -O2'
pushd $WORKPATH/obj/gmp-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [056/278] /i686-pc-linux-gnu/gmp/postinstall\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CFLAGS '-g -O2'
pushd $WORKPATH/obj/gmp-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo "----------------# task [057/278] /i686-pc-linux-gnu/mpfr/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/mpfr-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/mpfr-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/mpfr-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/mpfr-2015.11 --prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls --with-gmp=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo "----------------# task [058/278] /i686-pc-linux-gnu/mpfr/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/mpfr-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [059/278] /i686-pc-linux-gnu/mpfr/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/mpfr-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [060/278] /i686-pc-linux-gnu/mpfr/postinstall\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/mpfr-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo "----------------# task [061/278] /i686-pc-linux-gnu/mpc/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/mpc-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/mpc-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/mpc-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/mpc-2015.11 --prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls --with-gmp=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo "----------------# task [062/278] /i686-pc-linux-gnu/mpc/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/mpc-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [063/278] /i686-pc-linux-gnu/mpc/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/mpc-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [064/278] /i686-pc-linux-gnu/mpc/postinstall\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/mpc-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo "----------------# task [065/278] /i686-pc-linux-gnu/isl/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/isl-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/isl-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/isl-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
touch *
check_mentor_trademarks $WORKPATH/src/isl-0.14 --prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls --with-gmp-prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo "----------------# task [066/278] /i686-pc-linux-gnu/isl/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/isl-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [067/278] /i686-pc-linux-gnu/isl/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/isl-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [068/278] /i686-pc-linux-gnu/isl/postinstall\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/isl-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv
echo "----------------# task [069/278] /i686-pc-linux-gnu/toolchain/binutils/copy\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf $WORKPATH/obj/binutils-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean $WORKPATH/src/binutils-2015.11 $WORKPATH/obj/binutils-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w $WORKPATH/obj/binutils-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
touch $WORKPATH/obj/binutils-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv

echo "----------------# task [070/278] /i686-pc-linux-gnu/toolchain/binutils/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/obj/binutils-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu --prefix=/opt/codesourcery --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --with-python=no --with-zlib=no --disable-gdb --disable-libdecnumber --disable-readline --enable-sim "--with-pkgversion=Ingenic ${version_mask} $datemask" --disable-nls --with-sysroot=/opt/codesourcery/mips-sde-elf --enable-poison-system-directories --enable-plugins
popd
popenv
popenv
popenv

echo "----------------# task [071/278] /i686-pc-linux-gnu/toolchain/binutils/libiberty\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX all-libiberty
popd
copy_dir_clean $WORKPATH/src/binutils-2015.11/include $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/include
chmod -R u+w $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/include
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib
cp $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/libiberty/libiberty.a $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib
popenv
popenv
popenv

echo "----------------# task [072/278] /i686-pc-linux-gnu/toolchain/binutils/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [073/278] /i686-pc-linux-gnu/toolchain/binutils/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/opt/codesourcery/share
popd
popenv
popenv
popenv

echo "----------------# task [074/278] /i686-pc-linux-gnu/toolchain/binutils/postinstall\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/install/opt/codesourcery
popd
pushd $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/opt/codesourcery/share install-html
popd
pushd $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/opt/codesourcery/share install-pdf
popd
cp $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/bfd/.libs/libbfd.a $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib
cp $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/bfd/bfd.h $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/include
cp $WORKPATH/src/binutils-2015.11/bfd/elf-bfd.h $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/include
cp $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/opcodes/.libs/libopcodes.a $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/binutils
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/binutils/bfdtest1 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/binutils/
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/binutils
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/binutils/bfdtest2 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/binutils/
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/ld/libldtestplug.la $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/ld/libldtestplug2.la $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/ld/libldtestplug2_la-testplug2.lo $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/ld/libldtestplug2_la-testplug2.o $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/ld/libldtestplug3.la $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/ld/libldtestplug3_la-testplug3.lo $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/ld/libldtestplug3_la-testplug3.o $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/ld/libldtestplug_la-testplug.lo $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/ld/libldtestplug_la-testplug.o $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/ld/libtool $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld
rsync -a $WORKPATH/obj/binutils-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/ld/.libs $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testsuite/ld/
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/configure.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/etc/configure.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/standards.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/etc/standards.pdf
rm -rf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/bfd.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/bfd.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/bfd.info
install-info --infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly bfd
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libiberty.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libiberty.pdf
rm -f $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-ld.bfd
rm -f $WORKPATH/install/opt/codesourcery/bin/ld.bfd
popenv
popenv
popenv

echo "----------------# task [075/278] /i686-pc-linux-gnu/toolchain/gcc_first/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
rm -rf $WORKPATH/obj/gcc-first-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/gcc-first-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/gcc-first-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/gcc-5-2015.11 --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu --target=mips-sde-elf --enable-threads --disable-libmudflap --disable-libssp --disable-libstdcxx-pch --with-arch-32=mips32r2 --with-arch-64=mips64r2 --disable-threads --enable-sgxxlite-sde-multilibs --with-gnu-as --with-gnu-ld '--with-specs=-D__CS_SOURCERYGXX_MAJ__=2015 -D__CS_SOURCERYGXX_MIN__=11 -D__CS_SOURCERYGXX_REV__=33' --enable-languages=c,c++ --disable-shared --enable-lto--with-newlib "--with-pkgversion=Ingenic ${version_mask} $datemask" --disable-nls --prefix=$WORKPATH/install/opt/codesourcery --disable-shared --disable-threads --disable-libssp --disable-libgomp --without-headers --with-newlib --disable-decimal-float --disable-libffi --disable-libquadmath --disable-libitm --disable-libatomic --enable-languages=c '' --with-sysroot=/opt/codesourcery/mips-sde-elf --with-build-sysroot=$WORKPATH/install/opt/codesourcery/mips-sde-elf --with-gmp=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpc=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-isl=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-libgomp --disable-libitm --disable-libatomic --disable-libssp --disable-libcc1 --enable-poison-system-directories --with-python-dir=mips-sde-elf/share/gdb/python --with-build-time-tools=$WORKPATH/install/opt/codesourcery/mips-sde-elf/bin --with-build-time-tools=$WORKPATH/install/opt/codesourcery/mips-sde-elf/bin SED=sed
popd
popenv
popenv

echo "----------------# task [076/278] /i686-pc-linux-gnu/toolchain/gcc_first/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
pushd $WORKPATH/obj/gcc-first-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX LDFLAGS_FOR_TARGET=--sysroot=$WORKPATH/install/opt/codesourcery/mips-sde-elf CPPFLAGS_FOR_TARGET=--sysroot=$WORKPATH/install/opt/codesourcery/mips-sde-elf build_tooldir=$WORKPATH/install/opt/codesourcery/mips-sde-elf
popd
popenv
popenv

echo "----------------# task [077/278] /i686-pc-linux-gnu/toolchain/gcc_first/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
pushd $WORKPATH/obj/gcc-first-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man install
make prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man install-html
make prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man install-pdf
popd
popenv
popenv

echo "----------------# task [078/278] /i686-pc-linux-gnu/toolchain/gcc_first/postinstall\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
pushd $WORKPATH/install/opt/codesourcery
rmdir include
popd
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/gcc/multilib_list.txt
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/gcc
cat > $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/gcc/multilib_list.txt <<'EOF0'
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
rm -rf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gccinstall $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gcc/gccinstall.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/gccinstall.info
install-info --infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly gccinstall
rm -rf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gccint $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gcc/gccint.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/gccint.info
install-info --infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly gccint
rm -rf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/cppinternals $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gcc/cppinternals.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/cppinternals.info
install-info --infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly cppinternals
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libiberty.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libiberty.pdf
popenv
popenv

echo "----------------# task [079/278] /i686-pc-linux-gnu/toolchain/newlib/gcc/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CC_FOR_TARGET mips-sde-elf-gcc
pushenvvar CFLAGS_FOR_TARGET '-g -O2 -mno-branch-likely'
rm -rf $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/newlib-2015.11 --prefix=$WORKPATH/install/opt/codesourcery --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --enable-newlib-io-long-long --enable-newlib-register-fini --disable-newlib-multithread --enable-libgloss --disable-newlib-supplied-syscalls --disable-nls
popd
popenv
popenv
popenv

echo "----------------# task [080/278] /i686-pc-linux-gnu/toolchain/newlib/gcc/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CC_FOR_TARGET mips-sde-elf-gcc
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
pushd $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [081/278] /i686-pc-linux-gnu/toolchain/newlib/gcc/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CC_FOR_TARGET mips-sde-elf-gcc
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
pushd $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/opt/codesourcery/share
popd
popenv
popenv
popenv

echo "----------------# task [082/278] /i686-pc-linux-gnu/toolchain/newlib/gcc/postinstall\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CC_FOR_TARGET mips-sde-elf-gcc
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
pushd $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
#make pdf
#mkdir -p $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf
#cp $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libc/libc.pdf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libc.pdf
#mkdir -p $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf
#cp $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libm/libm.pdf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libm.pdf
#make html
#mkdir -p $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html
#copy_dir $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libc/libc.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libc
mkdir -p $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html
#copy_dir $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libm/libm.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libm
popd
popenv
popenv
popenv

echo "----------------# task [079_1/278] /i686-pc-linux-gnu/toolchain/newlib_1/gcc/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CC_FOR_TARGET mips-sde-elf-gcc
pushenvvar CFLAGS_FOR_TARGET '-g -O2 -mno-branch-likely'
rm -rf $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/
mkdir -p $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/
pushd $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/
check_mentor_trademarks $WORKPATH/src/newlib-2015.11 --prefix=$WORKPATH/install/opt/codesourcery --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --enable-newlib-io-long-long --enable-newlib-register-fini --disable-newlib-multithread --enable-libgloss --disable-newlib-supplied-syscalls --disable-nls
popd
popenv
popenv
popenv

echo "----------------# task [080_1/278] /i686-pc-linux-gnu/toolchain/newlib_1/gcc/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CC_FOR_TARGET "$WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-gcc -mfp64"
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
pushd $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [081_1/278] /i686-pc-linux-gnu/toolchain/newlib_1/gcc/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CC_FOR_TARGET "$WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-gcc -mfp64"
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
pushd $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/
make install prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib/ htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/opt/codesourcery/share
popenv
popenv
popenv

echo "----------------# task [082_1/278] /i686-pc-linux-gnu/toolchain/newlib_1/gcc/postinstall\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CC_FOR_TARGET "$WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-gcc -mfp64"
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
pushd $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/
#make pdf
#mkdir -p $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf
#cp $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libc/libc.pdf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libc.pdf
#mkdir -p $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf
#cp $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libm/libm.pdf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libm.pdf
#make html
#mkdir -p $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html
#copy_dir $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libc/libc.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libc
mkdir -p $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html
#copy_dir $WORKPATH/obj/newlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libm/libm.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libm
popd
popenv
popenv
popenv

echo "----------------# task [083/278] /i686-pc-linux-gnu/toolchain/gcc_final/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
rm -f $WORKPATH/install/opt/codesourcery/mips-sde-elf/usr
ln -s . $WORKPATH/install/opt/codesourcery/mips-sde-elf/usr
rm -rf $WORKPATH/obj/gcc-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/gcc-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/gcc-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/gcc-5-2015.11 --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu --target=mips-sde-elf --enable-threads --disable-libmudflap --disable-libssp --disable-libstdcxx-pch --with-arch-32=mips32r2 --with-arch-64=mips64r2 --disable-threads --enable-sgxxlite-sde-multilibs --with-gnu-as --with-gnu-ld '--with-specs=-D__CS_SOURCERYGXX_MAJ__=2015 -D__CS_SOURCERYGXX_MIN__=11 -D__CS_SOURCERYGXX_REV__=33' --enable-languages=c,c++ --disable-shared --enable-lto --with-newlib "--with-pkgversion=Ingenic ${version_mask} $datemask" --disable-nls --prefix=$WORKPATH/install/opt/codesourcery --with-headers=yes --with-sysroot=$WORKPATH/install/opt/codesourcery/mips-sde-elf --with-build-sysroot=$WORKPATH/install/opt/codesourcery/mips-sde-elf --with-gmp=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpc=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-isl=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-libgomp --disable-libitm --disable-libatomic --disable-libssp --disable-libcc1 --enable-poison-system-directories --with-python-dir=mips-sde-elf/share/gdb/python --with-build-time-tools=$WORKPATH/install/opt/codesourcery/mips-sde-elf/bin --with-build-time-tools=$WORKPATH/install/opt/codesourcery/mips-sde-elf/bin SED=sed
popd
popenv
popenv

echo "----------------# task [084/278] /i686-pc-linux-gnu/toolchain/gcc_final/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
rm -f $WORKPATH/install/opt/codesourcery/mips-sde-elf/usr
ln -s . $WORKPATH/install/opt/codesourcery/mips-sde-elf/usr
pushd $WORKPATH/obj/gcc-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX LDFLAGS_FOR_TARGET=--sysroot=$WORKPATH/install/opt/codesourcery/mips-sde-elf CPPFLAGS_FOR_TARGET=--sysroot=$WORKPATH/install/opt/codesourcery/mips-sde-elf build_tooldir=$WORKPATH/install/opt/codesourcery/mips-sde-elf
popd
popenv
popenv

echo "----------------# task [085/278] /i686-pc-linux-gnu/toolchain/gcc_final/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
rm -f $WORKPATH/install/opt/codesourcery/mips-sde-elf/usr
ln -s . $WORKPATH/install/opt/codesourcery/mips-sde-elf/usr
pushd $WORKPATH/obj/gcc-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man install
make prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man install-html
make prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man install-pdf
popd
popenv
popenv

echo "----------------# task [086/278] /i686-pc-linux-gnu/toolchain/gcc_final/postinstall\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
pushd $WORKPATH/install/opt/codesourcery
rmdir include
popd
rm -f $WORKPATH/install/opt/codesourcery/mips-sde-elf/usr
rm -f $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/gcc/multilib_list.txt
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/gcc
cat > $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/gcc/multilib_list.txt <<'EOF0'
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
rm -rf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gccinstall $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gcc/gccinstall.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/gccinstall.info
install-info --infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly gccinstall
rm -rf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gccint $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gcc/gccint.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/gccint.info
install-info --infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly gccint
rm -rf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/cppinternals $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gcc/cppinternals.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/cppinternals.info
install-info --infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly cppinternals
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libiberty.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libiberty.pdf
rm -rf $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/.//libstdc++.a-gdb.py
rm -rf $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/el//libstdc++.a-gdb.py
rm -rf $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/sof//libstdc++.a-gdb.py
rm -rf $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/el/sof//libstdc++.a-gdb.py
popenv
popenv

echo "----------------# task [087/278] /i686-pc-linux-gnu/toolchain/zlib/0/copy\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
rm -rf $WORKPATH/obj/zlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean $WORKPATH/src/zlib-1.2.8 $WORKPATH/obj/zlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w $WORKPATH/obj/zlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
popenv

echo "----------------# task [088/278] /i686-pc-linux-gnu/toolchain/zlib/0/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushd $WORKPATH/obj/zlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushenv
pushenvvar CFLAGS '-O3 -fPIC'
pushenvvar CC 'gcc  '
pushenvvar AR 'ar '
pushenvvar RANLIB 'ranlib '
./configure --prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --static
popenv
popd
popenv

echo "----------------# task [089/278] /i686-pc-linux-gnu/toolchain/zlib/0/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushd $WORKPATH/obj/zlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv

echo "----------------# task [090/278] /i686-pc-linux-gnu/toolchain/zlib/0/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushd $WORKPATH/obj/zlib-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv

echo "----------------# task [091/278] /i686-pc-linux-gnu/toolchain/python/0/copy\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/python-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean $WORKPATH/src/python-2.7.5 $WORKPATH/obj/python-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w $WORKPATH/obj/python-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
touch $WORKPATH/obj/python-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv

echo "----------------# task [092/278] /i686-pc-linux-gnu/toolchain/python/0/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/python-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/python-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/python-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/obj/python-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu --prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --enable-shared --disable-nls
popd
popenv
popenv
popenv

echo "----------------# task [093/278] /i686-pc-linux-gnu/toolchain/python/0/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/python-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [094/278] /i686-pc-linux-gnu/toolchain/python/0/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/python-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [095/278] /i686-pc-linux-gnu/toolchain/python/0/postinstall\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
mkdir -p $WORKPATH/install/opt/codesourcery/lib
mkdir -p $WORKPATH/install/opt/codesourcery/lib/python2.7
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/cmath.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_heapq.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/math.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_functools.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_lsprof.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/grp.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_testcapi.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/syslog.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/time.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_elementtree.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_collections.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/select.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/ossaudiodev.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/resource.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_codecs_tw.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_multiprocessing.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_json.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/datetime.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_codecs_hk.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_bisect.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/crypt.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/Python-2.7.5-py2.7.egg-info $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_locale.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_struct.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_codecs_jp.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
#install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/imageop.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/future_builtins.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_codecs_cn.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/zlib.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/termios.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_io.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/array.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_multibytecodec.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_socket.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_codecs_kr.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/fcntl.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/unicodedata.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_random.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/cStringIO.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_ctypes.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/pyexpat.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/linuxaudiodev.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_hotshot.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/audioop.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/binascii.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/spwd.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_csv.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/mmap.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/operator.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/itertools.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/nis.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/parser.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
#install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/dl.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/cPickle.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_ctypes_test.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/strop.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
install -m 755 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7/lib-dynload/_codecs_iso2022.so $WORKPATH/install/opt/codesourcery/lib/python2.7/
pushd $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/python2.7
find . -name '*.py*' > $WORKPATH/install/opt/codesourcery/lib/python27.zip.files
zip $WORKPATH/install/opt/codesourcery/lib/python27.zip -@ < $WORKPATH/install/opt/codesourcery/lib/python27.zip.files
rm $WORKPATH/install/opt/codesourcery/lib/python27.zip.files
popd
install -m 644 $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib/libpython2.7.so.1.0 $WORKPATH/install/opt/codesourcery/lib/
popenv
popenv
popenv

echo "----------------# task [096/278] /i686-pc-linux-gnu/toolchain/expat/0/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/expat-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/expat-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/expat-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/expat-2015.11 --prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls
popd
popenv
popenv
popenv

echo "----------------# task [097/278] /i686-pc-linux-gnu/toolchain/expat/0/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/expat-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [098/278] /i686-pc-linux-gnu/toolchain/expat/0/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/expat-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [099/278] /i686-pc-linux-gnu/toolchain/ncurses/0/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/ncurses-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/ncurses-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/ncurses-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/ncurses-5.9 --prefix=/usr --disable-shared --without-debug --without-cxx --without-ada --disable-nls --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu
popd
popenv
popenv
popenv

echo "----------------# task [100/278] /i686-pc-linux-gnu/toolchain/ncurses/0/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/ncurses-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make -j1
popd
popenv
popenv
popenv

echo "----------------# task [101/278] /i686-pc-linux-gnu/toolchain/ncurses/0/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/ncurses-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install DESTDIR=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu
popd
popenv
popenv
popenv

echo "----------------# task [102/278] /i686-pc-linux-gnu/toolchain/gdb/0/copy\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS '-L$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib -Wl,-rpath,'\''\\\$$\$$\\\$$\$$ORIGIN'\''/../lib'
prepend_path LD_LIBRARY_PATH $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf $WORKPATH/obj/gdb-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean $WORKPATH/src/gdb-2015.11 $WORKPATH/obj/gdb-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w $WORKPATH/obj/gdb-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
touch $WORKPATH/obj/gdb-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv

echo "----------------# task [103/278] /i686-pc-linux-gnu/toolchain/gdb/0/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS "-L$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib -Wl,-rpath,'\''\\\$$\$$\\\$$\$$ORIGIN'\''/../lib"
prepend_path LD_LIBRARY_PATH $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf $WORKPATH/obj/gdb-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/gdb-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/gdb-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/obj/gdb-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu --prefix=$WORKPATH/install/opt/codesourcery --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-sim --disable-binutils --disable-elfcpp --disable-gas --disable-gold --disable-gprof --disable-ld "--with-pkgversion=Ingenic ${version_mask} $datemask" --with-python=no --with-zlib=no  --disable-libmcheck --disable-nls --with-libexpat-prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-system-gdbinit=$WORKPATH/install/opt/codesourcery/i686-pc-linux-gnu/mips-sde-elf/lib/gdbinit '--with-gdb-datadir='\''${prefix}'\''/mips-sde-elf/share/gdb'
popd
popenv
popenv
popenv

echo "----------------# task [104/278] /i686-pc-linux-gnu/toolchain/gdb/0/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS '-L$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib -Wl,-rpath,'\''\\\$$\$$\\\$$\$$ORIGIN'\''/../lib'
prepend_path LD_LIBRARY_PATH $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
cat > $WORKPATH/obj/gdb-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/csl-python-config.sh <<'EOF0'
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
    echo "-Lreplacelocalpath/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib -lpython2.7"
    ;;
  "--includes")
    echo "-Ireplacelocalpath/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include/python2.7"
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
sed -i "s|replacelocalpath|${WORKPATH}|g" ${WORKPATH}/obj/gdb-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/csl-python-config.sh
chmod +x $WORKPATH/obj/gdb-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/csl-python-config.sh
pushd $WORKPATH/obj/gdb-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [105/278] /i686-pc-linux-gnu/toolchain/gdb/0/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS '-L$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib -Wl,-rpath,'\''\\\$$\$$\\\$$\$$ORIGIN'\''/../lib'
prepend_path LD_LIBRARY_PATH $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/obj/gdb-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/opt/codesourcery/share
popd
popenv
popenv
popenv

echo "----------------# task [106/278] /i686-pc-linux-gnu/toolchain/gdb/0/postinstall\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS '-L$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib -Wl,-rpath,'\''\\\$$\$$\\\$$\$$ORIGIN'\''/../lib'
prepend_path LD_LIBRARY_PATH $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/obj/gdb-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/opt/codesourcery/share install-html
make prefix=$WORKPATH/install/opt/codesourcery exec_prefix=$WORKPATH/install/opt/codesourcery libdir=$WORKPATH/install/opt/codesourcery/lib htmldir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/opt/codesourcery/share install-pdf
popd
mkdir -p $WORKPATH/install/opt/codesourcery/i686-pc-linux-gnu/mips-sde-elf/lib
rm -f $WORKPATH/install/opt/codesourcery/i686-pc-linux-gnu/mips-sde-elf/lib/gdbinit
cat > $WORKPATH/install/opt/codesourcery/i686-pc-linux-gnu/mips-sde-elf/lib/gdbinit <<'EOF0'
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
rm -rf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/annotate $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/annotate.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/annotate.info
install-info --infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly annotate
rm -rf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/gdbint $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/gdbint.pdf
rm -rf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/stabs $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/stabs.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/stabs.info
install-info --infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly stabs
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/configure.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/etc/configure.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/configure.info
install-info --infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly configure
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/standards.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/etc/standards.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/standards.info
install-info --infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly standards
rm -rf $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/bfd.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/bfd.pdf
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info/bfd.info
install-info --infodir=$WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info --remove-exactly bfd
rm -f $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html/libiberty.html $WORKPATH/install/opt/codesourcery/share/doc/mips-mips-sde-elf/pdf/libiberty.pdf
pushd $WORKPATH/install/opt/codesourcery
mkdir -p i686-pc-linux-gnu/mips-sde-elf/include/
mv include/gdb i686-pc-linux-gnu/mips-sde-elf/include
rmdir include
popd
rm -rf $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/gdb
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/gdb
#cp -a $WORKPATH/obj/gdb-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/gdb/data-directory/python $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/gdb/
popenv
popenv
popenv

echo "----------------# task [107/278] /i686-pc-linux-gnu/toolchain/cs3/gcc/configure\n"
echo "----------------# task [108/278] /i686-pc-linux-gnu/toolchain/cs3/gcc/build\n"
echo "----------------# task [109/278] /i686-pc-linux-gnu/toolchain/cs3/gcc/install\n"
echo "----------------# task [110/278] /i686-pc-linux-gnu/getting_started/copy\n"
echo "----------------# task [111/278] /i686-pc-linux-gnu/getting_started/configure\n"
echo "----------------# task [112/278] /i686-pc-linux-gnu/getting_started/build\n"
echo "----------------# task [113/278] /i686-pc-linux-gnu/getting_started/install\n"
echo "----------------# task [114/278] /i686-pc-linux-gnu/csl_docbook\n"
echo "----------------# task [115/278] /i686-pc-linux-gnu/gdil/configure\n"
echo "----------------# task [116/278] /i686-pc-linux-gnu/gdil/build\n"
echo "----------------# task [117/278] /i686-pc-linux-gnu/gdil/install\n"
echo "----------------# task [118/278] /i686-pc-linux-gnu/edge_utils/build\n"
echo "----------------# task [119/278] /i686-pc-linux-gnu/mips_sprite/configure\n"
echo "----------------# task [120/278] /i686-pc-linux-gnu/mips_sprite/build\n"
echo "----------------# task [121/278] /i686-pc-linux-gnu/mips_sprite/install\n"
echo "----------------# task [122/278] /i686-pc-linux-gnu/sprite/configure\n"
echo "----------------# task [123/278] /i686-pc-linux-gnu/sprite/build\n"
echo "----------------# task [124/278] /i686-pc-linux-gnu/sprite/install\n"
echo "----------------# task [125/278] /i686-pc-linux-gnu/sprite/postinstall\n"
echo "----------------# task [126/278] /i686-pc-linux-gnu/gettext/configure\n"
echo "----------------# task [127/278] /i686-pc-linux-gnu/gettext/build\n"
echo "----------------# task [128/278] /i686-pc-linux-gnu/gettext/install\n"

echo "----------------# task [129/278] /i686-pc-linux-gnu/libffi/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/libffi-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/libffi-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/libffi-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/libffi-3.2.1 --prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls
popd
popenv
popenv
popenv

echo "----------------# task [130/278] /i686-pc-linux-gnu/libffi/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/libffi-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [131/278] /i686-pc-linux-gnu/libffi/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushd $WORKPATH/obj/libffi-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [132/278] /i686-pc-linux-gnu/glib/copy\n"
echo "----------------# task [133/278] /i686-pc-linux-gnu/glib/configure\n"
echo "----------------# task [134/278] /i686-pc-linux-gnu/glib/build\n"
echo "----------------# task [135/278] /i686-pc-linux-gnu/glib/install\n"
echo "----------------# task [136/278] /i686-pc-linux-gnu/pixman/configure\n"
echo "----------------# task [137/278] /i686-pc-linux-gnu/pixman/build\n"
echo "----------------# task [138/278] /i686-pc-linux-gnu/pixman/install\n"
echo "----------------# task [139/278] /i686-pc-linux-gnu/pixman/postinstall\n"
echo "----------------# task [140/278] /i686-pc-linux-gnu/libfdt/copy\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
rm -rf $WORKPATH/obj/libfdt-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean $WORKPATH/src/libfdt-2015.11 $WORKPATH/obj/libfdt-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w $WORKPATH/obj/libfdt-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
touch $WORKPATH/obj/libfdt-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv

echo "----------------# task [141/278] /i686-pc-linux-gnu/libfdt/configure\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
rm -rf $WORKPATH/obj/libfdt-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/libfdt-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/libfdt-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/obj/libfdt-src-2015.11-33-mips-sde-elf-i686-pc-linux-gnu --prefix=$WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls
popd
popenv
popenv
popenv

echo "----------------# task [142/278] /i686-pc-linux-gnu/libfdt/build\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
pushd $WORKPATH/obj/libfdt-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [143/278] /i686-pc-linux-gnu/libfdt/install\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushenv
pushenv
pushenvvar CC 'gcc  -fPIE'
pushenvvar CXX 'g++  -fPIE'
pushd $WORKPATH/obj/libfdt-2015.11-33-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [144/278] /i686-pc-linux-gnu/qemu/copy\n"
echo "----------------# task [145/278] /i686-pc-linux-gnu/qemu/configure\n"
echo "----------------# task [146/278] /i686-pc-linux-gnu/qemu/build\n"
echo "----------------# task [147/278] /i686-pc-linux-gnu/qemu/install\n"
echo "----------------# task [148/278] /i686-pc-linux-gnu/qemu/postinstall\n"
echo "----------------# task [149/278] /i686-pc-linux-gnu/finalize_libc_installation\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
popenv

echo "----------------# task [150/278] /i686-pc-linux-gnu/pretidy_installation\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushd $WORKPATH/install/opt/codesourcery
popd
popenv

echo "----------------# task [151/278] /i686-pc-linux-gnu/remove_libtool_archives\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
find $WORKPATH/install/opt/codesourcery -name '*.la' -exec rm '{}' ';'
popenv

echo "----------------# task [152/278] /i686-pc-linux-gnu/remove_copied_libs\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
popenv

echo "----------------# task [153/278] /i686-pc-linux-gnu/remove_fixed_headers\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
pushd $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/include-fixed
#Move jzmedia.h head file to toolchains include
cp $WORKPATH/Jz-special/Jz-mxu/jzmedia.h  $WORKPATH/install/opt/codesourcery/mips-sde-elf/include/
popd
popenv

echo "----------------# task [154/278] /i686-pc-linux-gnu/add_tooldir_readme\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
cat > $WORKPATH/install/opt/codesourcery/mips-sde-elf/bin/README.txt <<'EOF0'
The executables in this directory are for internal use by the compiler
and may not operate correctly when used directly.  This directory
should not be placed on your PATH.  Instead, you should use the
executables in ../../bin/ and place that directory on your PATH.
EOF0
popenv

echo "----------------# task [155/278] /i686-pc-linux-gnu/readme_files/install\n"
echo "----------------# task [156/278] /i686-pc-linux-gnu/strip_host_objects\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-addr2line
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-ar
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-as
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-c++
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-c++filt
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-conv
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-cpp
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-elfedit
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-g++
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-gcc
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-gcc-5.2.0
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-gcc-ar
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-gcc-nm
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-gcc-ranlib
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-gcov
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-gcov-tool
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-gdb
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-gprof
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-ld
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-nm
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-objcopy
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-objdump
#strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-qemu-system
#strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-qemu-system-el
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-ranlib
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-readelf
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-size
#strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-sprite
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-strings
strip $WORKPATH/install/opt/codesourcery/bin/mips-sde-elf-strip
strip $WORKPATH/install/opt/codesourcery/mips-sde-elf/bin/ar
strip $WORKPATH/install/opt/codesourcery/mips-sde-elf/bin/as
strip $WORKPATH/install/opt/codesourcery/mips-sde-elf/bin/ld
strip $WORKPATH/install/opt/codesourcery/mips-sde-elf/bin/ld.bfd
strip $WORKPATH/install/opt/codesourcery/mips-sde-elf/bin/nm
strip $WORKPATH/install/opt/codesourcery/mips-sde-elf/bin/objcopy
strip $WORKPATH/install/opt/codesourcery/mips-sde-elf/bin/objdump
strip $WORKPATH/install/opt/codesourcery/mips-sde-elf/bin/ranlib
strip $WORKPATH/install/opt/codesourcery/mips-sde-elf/bin/strip
strip $WORKPATH/install/opt/codesourcery/libexec/gcc/mips-sde-elf/5.2.0/cc1
strip $WORKPATH/install/opt/codesourcery/libexec/gcc/mips-sde-elf/5.2.0/collect2
strip $WORKPATH/install/opt/codesourcery/libexec/gcc/mips-sde-elf/5.2.0/install-tools/fixincl
strip $WORKPATH/install/opt/codesourcery/libexec/gcc/mips-sde-elf/5.2.0/plugin/gengtype
strip $WORKPATH/install/opt/codesourcery/libexec/gcc/mips-sde-elf/5.2.0/cc1plus
strip $WORKPATH/install/opt/codesourcery/libexec/gcc/mips-sde-elf/5.2.0/lto-wrapper
strip $WORKPATH/install/opt/codesourcery/libexec/gcc/mips-sde-elf/5.2.0/lto1
strip $WORKPATH/install/opt/codesourcery/libexec/gcc/mips-sde-elf/5.2.0/liblto_plugin.so
strip $WORKPATH/install/opt/codesourcery/lib/libpython2.7.so.1.0
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_bisect.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_codecs_cn.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_codecs_hk.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_codecs_iso2022.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_codecs_jp.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_codecs_kr.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_codecs_tw.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_collections.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_csv.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_ctypes.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_ctypes_test.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_elementtree.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_functools.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_heapq.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_hotshot.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_io.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_json.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_locale.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_lsprof.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_multibytecodec.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_multiprocessing.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_random.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_socket.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_struct.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/_testcapi.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/array.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/audioop.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/binascii.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/cPickle.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/cStringIO.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/cmath.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/crypt.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/datetime.so
#strip $WORKPATH/install/opt/codesourcery/lib/python2.7/dl.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/fcntl.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/future_builtins.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/grp.so
#strip $WORKPATH/install/opt/codesourcery/lib/python2.7/imageop.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/itertools.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/linuxaudiodev.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/math.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/mmap.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/nis.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/operator.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/ossaudiodev.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/parser.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/pyexpat.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/resource.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/select.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/spwd.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/strop.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/syslog.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/termios.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/time.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/unicodedata.so
strip $WORKPATH/install/opt/codesourcery/lib/python2.7/zlib.so
popenv

echo "----------------# task [157/278] /i686-pc-linux-gnu/strip_target_objects\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/sof/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/sof/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/sof/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/sof/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/sof/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/fp64/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/fp64/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/fp64/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/fp64/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/fp64/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/fp64/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/mips-sde-elf/lib/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/fp64/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/fp64/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/fp64/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/fp64/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/fp64/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/fp64/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/sof/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/sof/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/sof/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/sof/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/sof/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/opt/codesourcery/lib/gcc/mips-sde-elf/5.2.0/sof/libgcc.a || true
popenv

echo "----------------# task [158/278] /i686-pc-linux-gnu/package_tbz2/toolchain\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
rm -f $WORKPATH/pkg/mips-2015.11-33-mips-sde-elf-i686-pc-linux-gnu.toolchain.tar.bz2
pushd $WORKPATH/obj
rm -f mips-2015.11
ln -s $WORKPATH/install/opt/codesourcery mips-2015.11
#tar cjfv $WORKPATH/pkg/mips-2015.11-33-mips-sde-elf-i686-pc-linux-gnu.toolchain.tar.bz2 --owner=0 --group=0 --exclude=host-i686-pc-linux-gnu --exclude=host-i686-mingw32 mips-2015.11/README_Sourcery_CodeBench_Lite_for_MIPS_ELF.html mips-2015.11/README_Sourcery_CodeBench_Lite_for_MIPS_ELF.txt mips-2015.11/bin mips-2015.11/i686-pc-linux-gnu mips-2015.11/lib mips-2015.11/libexec mips-2015.11/mips-sde-elf mips-2015.11/share
rm -f mips-2015.11
popd
popenv

echo "----------------# task [159/278] /i686-pc-linux-gnu/create_toolchain_repo/unpack_toolchain\n"
echo "----------------# task [160/278] /i686-pc-linux-gnu/create_toolchain_repo/create_links_file\n"
echo "----------------# task [161/278] /i686-pc-linux-gnu/create_toolchain_repo/create_iu\n"
echo "----------------# task [162/278] /i686-mingw32/host_cleanup\n"
echo "----------------# task [163/278] /i686-mingw32/host_unpack/toolchain\n"
echo "----------------# task [164/278] /i686-mingw32/libiconv/0/configure\n"
echo "----------------# task [165/278] /i686-mingw32/libiconv/0/build\n"
echo "----------------# task [166/278] /i686-mingw32/libiconv/0/install\n"
echo "----------------# task [167/278] /i686-mingw32/make/copy\n"
echo "----------------# task [168/278] /i686-mingw32/make/configure\n"
echo "----------------# task [169/278] /i686-mingw32/make/build\n"
echo "----------------# task [170/278] /i686-mingw32/make/install\n"
echo "----------------# task [171/278] /i686-mingw32/coreutils/copy\n"
echo "----------------# task [172/278] /i686-mingw32/coreutils/configure\n"
echo "----------------# task [173/278] /i686-mingw32/coreutils/build\n"
echo "----------------# task [174/278] /i686-mingw32/coreutils/install\n"
echo "----------------# task [175/278] /i686-mingw32/zlib_first/copy\n"
echo "----------------# task [176/278] /i686-mingw32/zlib_first/configure\n"
echo "----------------# task [177/278] /i686-mingw32/zlib_first/build\n"
echo "----------------# task [178/278] /i686-mingw32/zlib_first/install\n"
echo "----------------# task [179/278] /i686-mingw32/gmp/configure\n"
echo "----------------# task [180/278] /i686-mingw32/gmp/build\n"
echo "----------------# task [181/278] /i686-mingw32/gmp/install\n"
echo "----------------# task [182/278] /i686-mingw32/gmp/postinstall\n"
echo "----------------# task [183/278] /i686-mingw32/mpfr/configure\n"
echo "----------------# task [184/278] /i686-mingw32/mpfr/build\n"
echo "----------------# task [185/278] /i686-mingw32/mpfr/install\n"
echo "----------------# task [186/278] /i686-mingw32/mpfr/postinstall\n"
echo "----------------# task [187/278] /i686-mingw32/mpc/configure\n"
echo "----------------# task [188/278] /i686-mingw32/mpc/build\n"
echo "----------------# task [189/278] /i686-mingw32/mpc/install\n"
echo "----------------# task [190/278] /i686-mingw32/mpc/postinstall\n"
echo "----------------# task [191/278] /i686-mingw32/isl/configure\n"
echo "----------------# task [192/278] /i686-mingw32/isl/build\n"
echo "----------------# task [193/278] /i686-mingw32/isl/install\n"
echo "----------------# task [194/278] /i686-mingw32/isl/postinstall\n"
echo "----------------# task [195/278] /i686-mingw32/toolchain/binutils/copy\n"
echo "----------------# task [196/278] /i686-mingw32/toolchain/binutils/configure\n"
echo "----------------# task [197/278] /i686-mingw32/toolchain/binutils/libiberty\n"
echo "----------------# task [198/278] /i686-mingw32/toolchain/binutils/build\n"
echo "----------------# task [199/278] /i686-mingw32/toolchain/binutils/install\n"
echo "----------------# task [200/278] /i686-mingw32/toolchain/binutils/postinstall\n"
echo "----------------# task [201/278] /i686-mingw32/toolchain/copy_libs\n"
echo "----------------# task [202/278] /i686-mingw32/toolchain/gcc_final/configure\n"
echo "----------------# task [203/278] /i686-mingw32/toolchain/gcc_final/build\n"
echo "----------------# task [204/278] /i686-mingw32/toolchain/gcc_final/install\n"
echo "----------------# task [205/278] /i686-mingw32/toolchain/gcc_final/postinstall\n"
echo "----------------# task [206/278] /i686-mingw32/toolchain/zlib/0/copy\n"
echo "----------------# task [207/278] /i686-mingw32/toolchain/zlib/0/configure\n"
echo "----------------# task [208/278] /i686-mingw32/toolchain/zlib/0/build\n"
echo "----------------# task [209/278] /i686-mingw32/toolchain/zlib/0/install\n"
echo "----------------# task [210/278] /i686-mingw32/toolchain/msvcrt/build\n"
echo "----------------# task [211/278] /i686-mingw32/toolchain/msvcrt/install\n"
echo "----------------# task [212/278] /i686-mingw32/toolchain/python_win32/install\n"
echo "----------------# task [213/278] /i686-mingw32/toolchain/expat/0/configure\n"
echo "----------------# task [214/278] /i686-mingw32/toolchain/expat/0/build\n"
echo "----------------# task [215/278] /i686-mingw32/toolchain/expat/0/install\n"
echo "----------------# task [216/278] /i686-mingw32/toolchain/gdb/0/copy\n"
echo "----------------# task [217/278] /i686-mingw32/toolchain/gdb/0/configure\n"
echo "----------------# task [218/278] /i686-mingw32/toolchain/gdb/0/build\n"
echo "----------------# task [219/278] /i686-mingw32/toolchain/gdb/0/install\n"
echo "----------------# task [220/278] /i686-mingw32/toolchain/gdb/0/postinstall\n"
echo "----------------# task [221/278] /i686-mingw32/gdil/configure\n"
echo "----------------# task [222/278] /i686-mingw32/gdil/build\n"
echo "----------------# task [223/278] /i686-mingw32/gdil/install\n"
echo "----------------# task [224/278] /i686-mingw32/edge_utils/build\n"
echo "----------------# task [225/278] /i686-mingw32/mips_sprite/configure\n"
echo "----------------# task [226/278] /i686-mingw32/mips_sprite/build\n"
echo "----------------# task [227/278] /i686-mingw32/mips_sprite/install\n"
echo "----------------# task [228/278] /i686-mingw32/sprite/configure\n"
echo "----------------# task [229/278] /i686-mingw32/sprite/build\n"
echo "----------------# task [230/278] /i686-mingw32/sprite/install\n"
echo "----------------# task [231/278] /i686-mingw32/sprite/postinstall\n"
echo "----------------# task [232/278] /i686-mingw32/gettext/configure\n"
echo "----------------# task [233/278] /i686-mingw32/gettext/build\n"
echo "----------------# task [234/278] /i686-mingw32/gettext/install\n"
echo "----------------# task [235/278] /i686-mingw32/libffi/configure\n"
echo "----------------# task [236/278] /i686-mingw32/libffi/build\n"
echo "----------------# task [237/278] /i686-mingw32/libffi/install\n"
echo "----------------# task [238/278] /i686-mingw32/glib/copy\n"
echo "----------------# task [239/278] /i686-mingw32/glib/configure\n"
echo "----------------# task [240/278] /i686-mingw32/glib/build\n"
echo "----------------# task [241/278] /i686-mingw32/glib/instal\n"
echo "----------------# task [242/278] /i686-mingw32/pixman/configure\n"
echo "----------------# task [243/278] /i686-mingw32/pixman/build\n"
echo "----------------# task [244/278] /i686-mingw32/pixman/install\n"
echo "----------------# task [245/278] /i686-mingw32/pixman/postinstall\n"
echo "----------------# task [246/278] /i686-mingw32/libfdt/copy\n"
echo "----------------# task [247/278] /i686-mingw32/libfdt/configure\n"
echo "----------------# task [248/278] /i686-mingw32/libfdt/build\n"
echo "----------------# task [249/278] /i686-mingw32/libfdt/install\n"
echo "----------------# task [250/278] /i686-mingw32/qemu/copy\n"
echo "----------------# task [251/278] /i686-mingw32/qemu/configure\n"
echo "----------------# task [252/278] /i686-mingw32/qemu/build\n"
echo "----------------# task [253/278] /i686-mingw32/qemu/install\n"
echo "----------------# task [254/278] /i686-mingw32/qemu/postinstall\n"
echo "----------------# task [255/278] /i686-mingw32/pretidy_installation\n"
echo "----------------# task [256/278] /i686-mingw32/remove_libtool_archives\n"
echo "----------------# task [257/278] /i686-mingw32/remove_copied_libs\n"
echo "----------------# task [258/278] /i686-mingw32/remove_fixed_headers\n"
echo "----------------# task [259/278] /i686-mingw32/add_tooldir_readme\n"
echo "----------------# task [260/278] /i686-mingw32/readme_files/install\n"
echo "----------------# task [261/278] /i686-mingw32/strip_host_objects\n"
echo "----------------# task [262/278] /i686-mingw32/convert_symlinks\n"
echo "----------------# task [263/278] /i686-mingw32/package_tbz2/toolchain\n"
echo "----------------# task [264/278] /i686-mingw32/create_toolchain_repo/unpack_toolchain\n"
echo "----------------# task [265/278] /i686-mingw32/create_toolchain_repo/create_links_file\n"
echo "----------------# task [266/278] /i686-mingw32/create_toolchain_repo/create_iu\n"
echo "----------------# task [267/278] /i686-pc-linux-gnu/package_tbz2\n"
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
prepend_path PATH $WORKPATH/install/opt/codesourcery/bin
rm -f $WORKPATH/pkg/mips-2015.11-33-mips-sde-elf-i686-pc-linux-gnu.tar.bz2
pushd $WORKPATH/obj
rm -f mips-2015.11
ln -s $WORKPATH/install/opt/codesourcery mips-2015.11
#tar cjfv $WORKPATH/pkg/mips-2015.11-33-mips-sde-elf-i686-pc-linux-gnu.tar.bz2 --owner=0 --group=0 --exclude=host-i686-pc-linux-gnu --exclude=host-i686-mingw32 mips-2015.11/README_Sourcery_CodeBench_Lite_for_MIPS_ELF.html mips-2015.11/README_Sourcery_CodeBench_Lite_for_MIPS_ELF.txt mips-2015.11/bin mips-2015.11/i686-pc-linux-gnu mips-2015.11/lib mips-2015.11/libexec mips-2015.11/mips-sde-elf mips-2015.11/share
rm -f mips-2015.11
popd
popenv

echo "----------------# task [268/278] /i686-pc-linux-gnu/package_p2_installer/create_jre_repo\n"
echo "----------------# task [269/278] /i686-pc-linux-gnu/package_p2_installer/build\n"
echo "----------------# task [270/278] /i686-pc-linux-gnu/package_p2_installer/install\n"
echo "----------------# task [271/278] /i686-mingw32/package_tbz2\n"
echo "----------------# task [272/278] /i686-mingw32/package_p2_installer/create_jre_repo\n"
echo "----------------# task [273/278] /i686-mingw32/package_p2_installer/build\n"
echo "----------------# task [274/278] /i686-mingw32/package_p2_installer/install\n"
echo "----------------# task [275/278] /fini/extras_package\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.extras
pushd $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf
tar cjf $WORKPATH/pkg/mips-2015.11-33-mips-sde-elf.extras.tar.bz2 --owner=0 --group=0 mips-2015.11-33-mips-sde-elf.extras
popd
popenv

echo "----------------# task [276/278] /fini/build_summary\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
cat > $WORKPATH/pkg/mips-2015.11-33-mips-sde-elf-summary.xml <<'EOF0'
<?xml version="1.0" ?><build><variable var="release_config_canonical" value="sgxx/2015.11/mips-sde-elf-lite"/><variable var="version" value="2015.11-33"/><variable var="hosts_string" value="i686-pc-linux-gnu i686-mingw32"/><variable var="target" value="mips-sde-elf"/><variable var="build_date" value="20151109"/><variable var="HOSTNAME" value="build6-lucid-cs"/><variable var="build_operating_system" value="squeeze/sid"/><variable var="build_uname" value="Linux build6-lucid-cs 2.6.32-45-generic #104-Ubuntu SMP Tue Feb 19 21:20:09 UTC 2013 x86_64 GNU/Linux"/><variable var="USER" value="cmoore"/><checksum type="md5" value="c73e398645d45f073bc0f742a02ee891" file="mips-2015.11-33-mips-sde-elf-i686-pc-linux-gnu.tar.bz2"/><checksum type="md5" value="dd68b6c40b38d649ce0f3caaf3e94541" file="mips-2015.11-33-mips-sde-elf-i686-mingw32.tar.bz2"/><checksum type="md5" value="b9a6765732c2f03499fdd48b4380b9f2" file="mips-2015.11-33-mips-sde-elf.extras.tar.bz2"/></build>
EOF0
popenv

echo "----------------# task [277/278] /fini/backups_package\n"
pushenv
pushenvvar CC_FOR_BUILD 'gcc '
pushenvvar CXX_FOR_BUILD 'g++ '
mkdir -p $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf/mips-2015.11-33-mips-sde-elf.backup
pushd $WORKPATH/obj/pkg-2015.11-33-mips-sde-elf
tar cjf $WORKPATH/pkg/mips-2015.11-33-mips-sde-elf.backup.tar.bz2 --owner=0 --group=0 mips-2015.11-33-mips-sde-elf.backup
popd

echo " ----------# task [278/278 /i686-pc-linux-gnu/remove_docs\n"
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
rm -rf ${local_path}/install/opt/codesourcery/share/man
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/html
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/info
rm -rf ${local_path}/install/opt/codesourcery/share/doc/mips-mips-sde-elf/man
popenv

popenv
