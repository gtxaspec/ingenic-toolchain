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
export JX=-j24


local_arch=64
if [ `uname -m`x = "i686"x ]; then
    local_arch=32
else
    local_arch=64
fi


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

copy_dir_clean() {
    mkdir -p "$2"
    (cd "$1" && tar cf - \
	--exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc \
	--exclude="*~" --exclude=".#*" \
	--exclude="*.orig" --exclude="*.rej" \
	.) | (cd "$2" && tar xf -)
    check_pipe
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

prepend_path() {
    if $(eval "test -n \"\$$1\""); then
	prependenvvar "$1" "$2:"
    else
	prependenvvar "$1" "$2"
    fi
}

pushenvvar CSL_SCRIPTDIR $WORKPATH/src/scripts-trunk
pushenvvar PATH /bin:/sbin:/usr/bin:/usr/local/bin:/usr/local/tools/gcc-4.7.3/bin
#pushenvvar LD_LIBRARY_PATH /usr/local/tools/gcc-4.3.3/i686-pc-linux-gnu/lib:/usr/local/tools/gcc-4.3.3/lib64:/usr/local/tools/gcc-4.3.3/lib
pushenvvar FLEXLM_NO_CKOUT_INSTALL_LIC 1
pushenvvar LM_APP_DISABLE_CACHE_READ 1
pushenvvar MAKEINFO 'makeinfo --css-ref=../cs.css'
pushenvvar CSL_CONFIG_SUB $WORKPATH/src/config-trunk/config.sub
clean_environment

echo "----------------# task [001/209] /init/dirs\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
mkdir -p $WORKPATH/obj
mkdir -p $WORKPATH/install
mkdir -p $WORKPATH/pkg
mkdir -p $WORKPATH/logs/data
mkdir -p $WORKPATH/install/share/doc/mips-mips-sde-elf/html
mkdir -p $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf
popenv

echo "----------------# task [002/209] /init/cleanup\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
rm -f $WORKPATH/pkg/mips-2012.09-98-mips-sde-elf.src.tar.bz2 $WORKPATH/pkg/mips-2012.09-98-mips-sde-elf.backup.tar.bz2
popenv

echo "----------------# task [003/209] /init/source_package/binutils\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
rm -f $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/binutils-2012.09-98.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/binutils-2012.09-98.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' binutils-2012.09
popd
popenv

echo "----------------# task [004/209] /init/source_package/gcc\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
rm -f $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/gcc-2012.09-98.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/gcc-2012.09-98.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' gcc-4.7-2012.09
popd
popenv

echo "----------------# task [005/209] /init/source_package/gdb\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
rm -f $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/gdb-2012.09-98.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/gdb-2012.09-98.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' gdb-2012.09
popd
popenv

echo "----------------# task [006/209] /init/source_package/zlib\n"
echo "----------------# task [007/209] /init/source_package/gmp\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
rm -f $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/gmp-2012.09-98.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/gmp-2012.09-98.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' gmp-2012.09
popd
popenv

echo "----------------# task [008/209] /init/source_package/mpfr\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
rm -f $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/mpfr-2012.09-98.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/mpfr-2012.09-98.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' mpfr-2012.09
popd
popenv

echo "----------------# task [009/209] /init/source_package/mpc\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
rm -f $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/mpc-2012.09-98.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/mpc-2012.09-98.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' mpc-2012.09
popd
popenv

echo "----------------# task [010/209] /init/source_package/cloog\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
rm -f $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/cloog-2012.09-98.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
cd $WORKPATH/src/cloog-0.15/
./autogen.sh
cd -
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/cloog-2012.09-98.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' cloog-0.15
popd
popenv

echo "----------------# task [011/209] /init/source_package/ppl\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
rm -f $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/ppl-2012.09-98.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/ppl-2012.09-98.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' ppl-sgxx-0.11-2012.09
popd
popenv

echo "----------------# task [012/209] /init/source_package/getting_started\n"
echo "----------------# task [013/209] /init/source_package/installanywhere\n"
echo "----------------# task [014/209] /init/source_package/fbench\n"
echo "----------------# task [015/209] /init/source_package/sprite\n"
echo "----------------# task [016/209] /init/source_package/mips_sprite\n"
echo "----------------# task [017/209] /init/source_package/eembc\n"
echo "----------------# task [018/209] /init/source_package/dhrystone\n"
echo "----------------# task [019/209] /init/source_package/newlib\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
rm -f $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/newlib-2012.09-98.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/newlib-2012.09-98.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' newlib-2012.09
popd
popenv

echo "----------------# task [020/209] /init/source_package/cs3\n"
echo "----------------# task [021/209] /init/source_package/board_support\n"
echo "----------------# task [022/209] /init/source_package/csl_tests\n"
echo "----------------# task [023/209] /init/source_package/dejagnu_boards\n"
echo "----------------# task [024/209] /init/source_package/scripts\n"
echo "----------------# task [025/209] /init/source_package/xfails\n"
echo "----------------# task [026/209] /init/source_package/portal\n"
echo "----------------# task [027/209] /init/source_package/config\n"
echo "----------------# task [028/209] /init/source_package/libiconv\n"
echo "----------------# task [029/209] /init/source_package/libelf\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
rm -f $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/libelf-2012.09-98.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/libelf-2012.09-98.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' libelf-2012.09
popd
popenv

echo "----------------# task [030/209] /init/source_package/expat\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
rm -f $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/expat-2012.09-98.tar.bz2
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
pushd $WORKPATH/src
#tar cf $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf/expat-2012.09-98.tar.bz2 --bzip2 --owner=0 --group=0 --exclude=CVS --exclude=.svn --exclude=.git --exclude=.pc '--exclude=*~' '--exclude=.#*' '--exclude=*.orig' '--exclude=*.rej' expat-2012.09
popd
popenv

echo "----------------# task [031/209] /init/source_package/csl_docbook\n"
echo "----------------# task [032/209] /init/source_package/release_notes\n"
echo "----------------# task [033/209] /init/source_package/make\n"
echo "----------------# task [034/209] /init/source_package/coreutils\n"
echo "----------------# task [035/209] /init/source_package/gdil\n"
echo "----------------# task [036/209] /init/source_package/edge_utils\n"
echo "----------------# task [037/209] /i686-pc-linux-gnu/host_cleanup\n"
echo "----------------# task [038/209] /i686-pc-linux-gnu/zlib_first/copy\n"
echo "----------------# task [039/209] /i686-pc-linux-gnu/zlib_first/configure\n"
echo "----------------# task [040/209] /i686-pc-linux-gnu/zlib_first/build\n"
echo "----------------# task [041/209] /i686-pc-linux-gnu/zlib_first/install\n"
echo "----------------# task [042/209] /i686-pc-linux-gnu/gmp/configure\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CFLAGS '-g -O2'
rm -rf $WORKPATH/obj/gmp-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/gmp-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/gmp-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
#check_mentor_trademarks $WORKPATH/src/gmp-2012.09 --prefix=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=i686-pc-linux-gnu --host=i686-pc-linux-gnu --enable-cxx --disable-nls
check_mentor_trademarks $WORKPATH/src/gmp-2012.09 --prefix=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --enable-cxx ABI=${local_arch}

popd
popenv
popenv
popenv

echo "----------------# task [043/209] /i686-pc-linux-gnu/gmp/build\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CFLAGS '-g -O2'
pushd $WORKPATH/obj/gmp-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [044/209] /i686-pc-linux-gnu/gmp/install\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CFLAGS '-g -O2'
pushd $WORKPATH/obj/gmp-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [045/209] /i686-pc-linux-gnu/gmp/postinstall\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CFLAGS '-g -O2'
pushd $WORKPATH/obj/gmp-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo "----------------# task [046/209] /i686-pc-linux-gnu/mpfr/configure\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/mpfr-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/mpfr-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/mpfr-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/mpfr-2012.09 --prefix=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls --with-gmp=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo "----------------# task [047/209] /i686-pc-linux-gnu/mpfr/build\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/mpfr-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [048/209] /i686-pc-linux-gnu/mpfr/install\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/mpfr-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [049/209] /i686-pc-linux-gnu/mpfr/postinstall\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/mpfr-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo "----------------# task [050/209] /i686-pc-linux-gnu/mpc/configure\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/mpc-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/mpc-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/mpc-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/mpc-2012.09 --prefix=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls --with-gmp=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo "----------------# task [051/209] /i686-pc-linux-gnu/mpc/build\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/mpc-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [052/209] /i686-pc-linux-gnu/mpc/install\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/mpc-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [053/209] /i686-pc-linux-gnu/mpc/postinstall\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/mpc-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo "----------------# task [054/209] /i686-pc-linux-gnu/ppl/configure\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/ppl-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/ppl-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/ppl-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/ppl-sgxx-0.11-2012.09 --prefix=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls --with-libgmp-prefix=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-gmp-prefix=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr CPPFLAGS=-I$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include LDFLAGS=-L$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib --disable-watchdog
popd
popenv
popenv
popenv

echo "----------------# task [055/209] /i686-pc-linux-gnu/ppl/build\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/ppl-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [056/209] /i686-pc-linux-gnu/ppl/install\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/ppl-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [057/209] /i686-pc-linux-gnu/cloog/configure\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/cloog-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/cloog-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/cloog-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/cloog-0.15 --prefix=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls --with-ppl=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-gmp=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr
popd
popenv
popenv
popenv

echo "----------------# task [058/209] /i686-pc-linux-gnu/cloog/build\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/cloog-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [059/209] /i686-pc-linux-gnu/cloog/install\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/cloog-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [060/209] /i686-pc-linux-gnu/cloog/postinstall\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/cloog-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make check
popd
popenv
popenv
popenv

echo "----------------# task [061/209] /i686-pc-linux-gnu/libelf/configure\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/libelf-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/libelf-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/libelf-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/libelf-2012.09 --prefix=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls
popd
popenv
popenv
popenv

echo "----------------# task [062/209] /i686-pc-linux-gnu/libelf/build\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/libelf-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [063/209] /i686-pc-linux-gnu/libelf/install\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/libelf-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

echo "----------------# task [064/209] /i686-pc-linux-gnu/toolchain/binutils/copy\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf $WORKPATH/obj/binutils-src-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean $WORKPATH/src/binutils-2012.09 $WORKPATH/obj/binutils-src-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w $WORKPATH/obj/binutils-src-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
touch $WORKPATH/obj/binutils-src-2012.09-98-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv

echo "----------------# task [065/209] /i686-pc-linux-gnu/toolchain/binutils/configure\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/obj/binutils-src-2012.09-98-mips-sde-elf-i686-pc-linux-gnu --prefix=$WORKPATH/install --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu '--with-pkgversion=Ingenic 2015.02' --with-python=no --with-zlib=no --disable-nls --with-sysroot=/opt/codesourcery/mips-sde-elf --enable-poison-system-directories --enable-plugins
popd
popenv
popenv
popenv

echo "----------------# task [066/209] /i686-pc-linux-gnu/toolchain/binutils/libiberty\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX all-libiberty
popd
copy_dir_clean $WORKPATH/src/binutils-2012.09/include $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/include
chmod -R u+w $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/include
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib
cp $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu/libiberty/libiberty.a $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib
popenv
popenv
popenv

echo "----------------# task [067/209] /i686-pc-linux-gnu/toolchain/binutils/build\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [068/209] /i686-pc-linux-gnu/toolchain/binutils/install\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make install prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/share
popd
popenv
popenv
popenv

echo "----------------# task [069/209] /i686-pc-linux-gnu/toolchain/binutils/postinstall\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/install
#rm ./lib/libiberty.a
rm -rf ./lib
popd
pushd $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/share install-html
popd
pushd $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/share install-pdf
popd
cp $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu/bfd/.libs/libbfd.a $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib
cp $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu/bfd/bfd.h $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/include
cp $WORKPATH/src/binutils-2012.09/bfd/elf-bfd.h $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/include
cp $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu/opcodes/.libs/libopcodes.a $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/lib
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testbin
cp $WORKPATH/obj/binutils-2012.09-98-mips-sde-elf-i686-pc-linux-gnu/binutils/bfdtest1 $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-binutils-i686-pc-linux-gnu/usr/testbin
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/html/configure.html $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/etc/configure.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/configure.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly configure
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/html/standards.html $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/etc/standards.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/standards.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly standards
rmdir $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/etc
rm -rf $WORKPATH/install/share/doc/mips-mips-sde-elf/html/bfd.html $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/bfd.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/bfd.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly bfd
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/html/libiberty.html $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/libiberty.pdf
rm -f $WORKPATH/install/bin/mips-sde-elf-ld.bfd
rm -f $WORKPATH/install/bin/ld.bfd
rm -f $WORKPATH/install/mips-sde-elf/bin/ld.bfd
popenv
popenv
popenv

echo "----------------# task [070/209] /i686-pc-linux-gnu/toolchain/gcc_first/configure\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
rm -rf $WORKPATH/obj/gcc-first-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/gcc-first-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/gcc-first-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/gcc-4.7-2012.09 --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu --target=mips-sde-elf --enable-threads --disable-libmudflap --disable-libssp --disable-libstdcxx-pch --with-arch-32=mips32r2 --with-arch-64=mips64r2 --enable-sgxx-sde-multilibs --disable-threads --with-gnu-as --with-gnu-ld '--with-specs=%{save-temps: -fverbose-asm} -D__CS_SOURCERYGXX_MAJ__=2012 -D__CS_SOURCERYGXX_MIN__=9 -D__CS_SOURCERYGXX_REV__=98' --enable-languages=c,c++ --disable-shared --enable-lto    '--with-pkgversion=Ingenic 2015.02'  --disable-nls --prefix=$WORKPATH/install  --disable-shared --disable-threads --disable-libssp --disable-libgomp --without-headers --with-newlib --disable-decimal-float --disable-libffi --disable-libquadmath --disable-libitm --disable-libatomic --enable-languages=c --with-sysroot=/opt/codesourcery/mips-sde-elf --with-build-sysroot=$WORKPATH/install/mips-sde-elf --with-gmp=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpc=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-ppl=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr '--with-host-libstdcxx=-static-libgcc -Wl,-Bstatic,-lstdc++,-Bdynamic -lm' --with-cloog=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-libelf=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-libgomp --disable-libitm --enable-poison-system-directories --with-build-time-tools=$WORKPATH/install/mips-sde-elf/bin --with-build-time-tools=$WORKPATH/install/mips-sde-elf/bin
popd
popenv
popenv

echo "----------------# task [071/209] /i686-pc-linux-gnu/toolchain/gcc_first/build\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
pushd $WORKPATH/obj/gcc-first-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX LDFLAGS_FOR_TARGET=--sysroot=$WORKPATH/install/mips-sde-elf CPPFLAGS_FOR_TARGET=--sysroot=$WORKPATH/install/mips-sde-elf build_tooldir=$WORKPATH/install/mips-sde-elf
popd
popenv
popenv

echo "----------------# task [072/209] /i686-pc-linux-gnu/toolchain/gcc_first/install\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
pushd $WORKPATH/obj/gcc-first-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man install
make prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man install-html
make prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man install-pdf
popd
popenv
popenv

echo "----------------# task [073/209] /i686-pc-linux-gnu/toolchain/gcc_first/postinstall\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
pushd $WORKPATH/install
echo "pwd :`pwd`"
#rm ./lib/libiberty.a
rm -rf include
popd
rm -rf $WORKPATH/install/share/doc/mips-mips-sde-elf/html/gccinstall $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/gcc/gccinstall.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/gccinstall.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly gccinstall
rm -rf $WORKPATH/install/share/doc/mips-mips-sde-elf/html/gccint $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/gcc/gccint.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/gccint.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly gccint
rm -rf $WORKPATH/install/share/doc/mips-mips-sde-elf/html/cppinternals $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/gcc/cppinternals.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/cppinternals.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly cppinternals
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/html/libiberty.html $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/libiberty.pdf
popenv
popenv

echo "----------------# task [074/209] /i686-pc-linux-gnu/toolchain/newlib/configure\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
rm -rf $WORKPATH/obj/newlib-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/newlib-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/newlib-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/newlib-2012.09 --prefix=$WORKPATH/install --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --enable-newlib-io-long-long --enable-newlib-register-fini --disable-newlib-multithread --enable-libgloss --disable-newlib-supplied-syscalls --disable-nls
popd
popenv
popenv
popenv

echo "----------------# task [075/209] /i686-pc-linux-gnu/toolchain/newlib/build\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
pushd $WORKPATH/obj/newlib-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX

popd
popenv
popenv
popenv

echo "----------------# task [076/209] /i686-pc-linux-gnu/toolchain/newlib/install\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
pushd $WORKPATH/obj/newlib-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make install prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/share
popd
popenv
popenv
popenv

echo "----------------# task [077/209] /i686-pc-linux-gnu/toolchain/newlib/postinstall\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CFLAGS_FOR_TARGET '-g -O2'
pushd $WORKPATH/obj/newlib-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make pdf
mkdir -p $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf
cp $WORKPATH/obj/newlib-2012.09-98-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libc/libc.pdf $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/libc.pdf
mkdir -p $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf
cp $WORKPATH/obj/newlib-2012.09-98-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libm/libm.pdf $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/libm.pdf
make html
mkdir -p $WORKPATH/install/share/doc/mips-mips-sde-elf/html
copy_dir $WORKPATH/obj/newlib-2012.09-98-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libc/libc.html $WORKPATH/install/share/doc/mips-mips-sde-elf/html/libc
mkdir -p $WORKPATH/install/share/doc/mips-mips-sde-elf/html
copy_dir $WORKPATH/obj/newlib-2012.09-98-mips-sde-elf-i686-pc-linux-gnu/mips-sde-elf/newlib/libm/libm.html $WORKPATH/install/share/doc/mips-mips-sde-elf/html/libm
popd
popenv
popenv
popenv

echo "----------------# task [078/209] /i686-pc-linux-gnu/toolchain/gcc_final/configure\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
rm -f $WORKPATH/install/mips-sde-elf/usr
ln -s . $WORKPATH/install/mips-sde-elf/usr
rm -rf $WORKPATH/obj/gcc-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/gcc-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/gcc-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/gcc-4.7-2012.09 --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu --target=mips-sde-elf --enable-threads --disable-libmudflap --disable-libssp --disable-libstdcxx-pch --with-arch-32=mips32r2 --with-arch-64=mips64r2 --enable-sgxx-sde-multilibs --disable-threads --with-gnu-as --with-gnu-ld '--with-specs=%{save-temps: -fverbose-asm} -D__CS_SOURCERYGXX_MAJ__=2012 -D__CS_SOURCERYGXX_MIN__=9 -D__CS_SOURCERYGXX_REV__=98' --enable-languages=c,c++ --disable-shared --enable-lto --with-newlib '--with-pkgversion=Ingenic 2015.02'  --disable-nls --prefix=$WORKPATH/install --with-headers=yes --with-sysroot=/opt/codesourcery/mips-sde-elf --with-build-sysroot=$WORKPATH/install/mips-sde-elf --with-gmp=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpfr=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-mpc=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-ppl=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr '--with-host-libstdcxx=-static-libgcc -Wl,-Bstatic,-lstdc++,-Bdynamic -lm' --with-cloog=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-libelf=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-libgomp --disable-libitm --enable-poison-system-directories --with-build-time-tools=$WORKPATH/install/mips-sde-elf/bin --with-build-time-tools=$WORKPATH/install/mips-sde-elf/bin
popd
popenv
popenv

echo "----------------# task [079/209] /i686-pc-linux-gnu/toolchain/gcc_final/build\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
rm -f $WORKPATH/install/mips-sde-elf/usr
ln -s . $WORKPATH/install/mips-sde-elf/usr
pushd $WORKPATH/obj/gcc-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX LDFLAGS_FOR_TARGET=--sysroot=$WORKPATH/install/mips-sde-elf CPPFLAGS_FOR_TARGET=--sysroot=$WORKPATH/install/mips-sde-elf build_tooldir=$WORKPATH/install/mips-sde-elf
popd
popenv
popenv

echo "----------------# task [080/209] /i686-pc-linux-gnu/toolchain/gcc_final/install\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
rm -f $WORKPATH/install/mips-sde-elf/usr
ln -s . $WORKPATH/install/mips-sde-elf/usr
pushd $WORKPATH/obj/gcc-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man install
make prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man install-html
make prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man install-pdf
popd
popenv
popenv

echo "----------------# task [081/209] /i686-pc-linux-gnu/toolchain/gcc_final/postinstall\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenvvar AR_FOR_TARGET mips-sde-elf-ar
pushenvvar NM_FOR_TARGET mips-sde-elf-nm
pushenvvar OBJDUMP_FOR_TARET mips-sde-elf-objdump
pushenvvar STRIP_FOR_TARGET mips-sde-elf-strip
pushd $WORKPATH/install
#rm ./lib/libiberty.a
rm -rf include
popd
rm -f $WORKPATH/install/mips-sde-elf/usr
rm -rf $WORKPATH/install/share/doc/mips-mips-sde-elf/html/gccinstall $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/gcc/gccinstall.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/gccinstall.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly gccinstall
rm -rf $WORKPATH/install/share/doc/mips-mips-sde-elf/html/gccint $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/gcc/gccint.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/gccint.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly gccint
rm -rf $WORKPATH/install/share/doc/mips-mips-sde-elf/html/cppinternals $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/gcc/cppinternals.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/cppinternals.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly cppinternals
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/html/libiberty.html $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/libiberty.pdf
rm -f $WORKPATH/install/mips-sde-elf/lib/libstdc++.a-gdb.py
popenv
popenv

echo "----------------# task [082/209] /i686-pc-linux-gnu/toolchain/zlib/0/copy\n"
echo "----------------# task [083/209] /i686-pc-linux-gnu/toolchain/zlib/0/configure\n"
echo "----------------# task [084/209] /i686-pc-linux-gnu/toolchain/zlib/0/build\n"
echo "----------------# task [085/209] /i686-pc-linux-gnu/toolchain/zlib/0/install\n"
echo "----------------# task [086/209] /i686-pc-linux-gnu/toolchain/expat/0/configure\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
rm -rf $WORKPATH/obj/expat-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/expat-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/expat-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/src/expat-2012.09 --prefix=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --disable-shared --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu --disable-nls
popd
popenv
popenv
popenv

echo "----------------# task [087/209] /i686-pc-linux-gnu/toolchain/expat/0/build\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/expat-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [088/209] /i686-pc-linux-gnu/toolchain/expat/0/install\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushd $WORKPATH/obj/expat-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make install
popd
popenv
popenv
popenv

if [ "" == "x" ];then
echo "----------------# task [089/209] /i686-pc-linux-gnu/toolchain/gdb/0/copy\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf $WORKPATH/obj/gdb-src-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
copy_dir_clean $WORKPATH/src/gdb-2012.09 $WORKPATH/obj/gdb-src-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
chmod -R u+w $WORKPATH/obj/gdb-src-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
touch $WORKPATH/obj/gdb-src-2012.09-98-mips-sde-elf-i686-pc-linux-gnu/.gnu-stamp
popenv
popenv
popenv

echo "----------------# task [090/209] /i686-pc-linux-gnu/toolchain/gdb/0/configure\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
rm -rf $WORKPATH/obj/gdb-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
mkdir -p $WORKPATH/obj/gdb-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
pushd $WORKPATH/obj/gdb-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
check_mentor_trademarks $WORKPATH/obj/gdb-src-2012.09-98-mips-sde-elf-i686-pc-linux-gnu --prefix=$WORKPATH/install --build=i686-pc-linux-gnu --target=mips-sde-elf --host=i686-pc-linux-gnu '--with-pkgversion=Ingenic 2015.02' --with-python=no --with-zlib=no --disable-libmcheck --disable-nls --with-libexpat-prefix=$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr --with-system-gdbinit=$WORKPATH/install/i686-pc-linux-gnu/mips-sde-elf/lib/gdbinit '--with-gdb-datadir='\''${prefix}'\''/mips-sde-elf/share/gdb'
popd
popenv
popenv
popenv

echo "----------------# task [091/209] /i686-pc-linux-gnu/toolchain/gdb/0/build\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/obj/gdb-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo "----------------# task [092/209] /i686-pc-linux-gnu/toolchain/gdb/0/install\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/obj/gdb-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make install prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/share
popd
popenv
popenv
popenv

echo "----------------# task [093/209] /i686-pc-linux-gnu/toolchain/gdb/0/postinstall\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushenv
pushenv
pushenvvar CPPFLAGS -I$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/include
pushenvvar LDFLAGS -L$WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/host-libs-i686-pc-linux-gnu/usr/lib
pushd $WORKPATH/obj/gdb-2012.09-98-mips-sde-elf-i686-pc-linux-gnu
make prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/share install-html
make prefix=$WORKPATH/install exec_prefix=$WORKPATH/install libdir=$WORKPATH/install/lib htmldir=$WORKPATH/install/share/doc/mips-mips-sde-elf/html pdfdir=$WORKPATH/install/share/doc/mips-mips-sde-elf/pdf infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info mandir=$WORKPATH/install/share/doc/mips-mips-sde-elf/man datadir=$WORKPATH/install/share install-pdf
popd
rm -rf $WORKPATH/install/share/doc/mips-mips-sde-elf/html/annotate $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/annotate.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/annotate.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly annotate
rm -rf $WORKPATH/install/share/doc/mips-mips-sde-elf/html/gdbint $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/gdbint.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/gdbint.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly gdbint
rm -rf $WORKPATH/install/share/doc/mips-mips-sde-elf/html/stabs $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/stabs.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/stabs.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly stabs
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/html/configure.html $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/etc/configure.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/configure.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly configure
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/html/standards.html $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/etc/standards.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/standards.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly standards
rmdir $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/etc
rm -rf $WORKPATH/install/share/doc/mips-mips-sde-elf/html/bfd.html $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/bfd.pdf
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/info/bfd.info
install-info --infodir=$WORKPATH/install/share/doc/mips-mips-sde-elf/info --remove-exactly bfd
rm -f $WORKPATH/install/share/doc/mips-mips-sde-elf/html/libiberty.html $WORKPATH/install/share/doc/mips-mips-sde-elf/pdf/libiberty.pdf
pushd $WORKPATH/install
mkdir -p i686-pc-linux-gnu/mips-sde-elf/include/
mv include/gdb i686-pc-linux-gnu/mips-sde-elf/include
rmdir include
popd
popenv
popenv
popenv
fi

echo "----------------# task [094/209] /i686-pc-linux-gnu/toolchain/cs3/configure\n"
echo "----------------# task [095/209] /i686-pc-linux-gnu/toolchain/cs3/build\n"
echo "----------------# task [096/209] /i686-pc-linux-gnu/toolchain/cs3/install\n"
echo "----------------# task [097/209] /i686-pc-linux-gnu/getting_started/copy\n"
echo "----------------# task [098/209] /i686-pc-linux-gnu/getting_started/configure\n"
echo "----------------# task [099/209] /i686-pc-linux-gnu/getting_started/build\n"
echo "----------------# task [100/209] /i686-pc-linux-gnu/getting_started/install\n"
echo "----------------# task [101/209] /i686-pc-linux-gnu/csl_docbook\n"
echo "----------------# task [102/209] /i686-pc-linux-gnu/gdil/configure\n"
echo "----------------# task [103/209] /i686-pc-linux-gnu/gdil/build\n"
echo "----------------# task [104/209] /i686-pc-linux-gnu/gdil/install\n"
echo "----------------# task [105/209] /i686-pc-linux-gnu/edge_utils/build\n"
echo "----------------# task [106/209] /i686-pc-linux-gnu/mips_sprite/configure\n"
echo "----------------# task [107/209] /i686-pc-linux-gnu/mips_sprite/build\n"
echo "----------------# task [108/209] /i686-pc-linux-gnu/mips_sprite/install\n"
echo "----------------# task [109/209] /i686-pc-linux-gnu/sprite/configure\n"
echo "----------------# task [110/209] /i686-pc-linux-gnu/sprite/build\n"
echo "----------------# task [111/209] /i686-pc-linux-gnu/sprite/install\n"
echo "----------------# task [112/209] /i686-pc-linux-gnu/finalize_libc_installation\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
popenv

echo "----------------# task [113/209] /i686-pc-linux-gnu/pretidy_installation\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
pushd $WORKPATH/install
#rm ./lib/libiberty.a
popd
popenv

echo "----------------# task [114/209] /i686-pc-linux-gnu/remove_libtool_archives\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
find $WORKPATH/install -name '*.la' -exec rm '{}' ';'
popenv

echo "----------------# task [115/209] /i686-pc-linux-gnu/remove_copied_libs\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
popenv

echo "----------------# task [116/209] /i686-pc-linux-gnu/remove_fixed_headers\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
if [ -d "$WORKPATH/install/lib/gcc/mips-sde-elf/4.7.2" ];then
    pushd $WORKPATH/install/lib/gcc/mips-sde-elf/4.7.2/include-fixed
    popd
elif [ -d "$WORKPATH/install/lib/gcc/mips-sde-elf/4.9.2" ];then
    pushd $WORKPATH/install/lib/gcc/mips-sde-elf/4.9.2/include-fixed
    popd
else
    echo "******** remove fixed headers fail"
    exit 0
fi    
popenv

echo "----------------# task [117/209] /i686-pc-linux-gnu/add_tooldir_readme\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
cat > $WORKPATH/install/mips-sde-elf/bin/README.txt <<'EOF0'
The executables in this directory are for internal use by the compiler
and may not operate correctly when used directly.  This directory
should not be placed on your PATH.  Instead, you should use the
executables in ../../bin/ and place that directory on your PATH.
EOF0
popenv
echo "----------------# task [118/209] /i686-pc-linux-gnu/strip_host_objects\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-addr2line
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-ar
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-as
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-c++
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-c++filt
#/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-conv
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-cpp
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-elfedit
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-g++
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-gcc
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-gcc-ar
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-gcc-nm
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-gcc-ranlib
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-gcov
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-gdb
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-gprof
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-ld
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-nm
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-objcopy
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-objdump
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-ranlib
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-readelf
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-run
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-size
#/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-sprite
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-strings
/usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-strip
/usr/bin/strip $WORKPATH/install/mips-sde-elf/bin/ar
/usr/bin/strip $WORKPATH/install/mips-sde-elf/bin/as
# /usr/bin/strip $WORKPATH/install/mips-sde-elf/bin/c++
# /usr/bin/strip $WORKPATH/install/mips-sde-elf/bin/g++
# /usr/bin/strip $WORKPATH/install/mips-sde-elf/bin/gcc
/usr/bin/strip $WORKPATH/install/mips-sde-elf/bin/ld
/usr/bin/strip $WORKPATH/install/mips-sde-elf/bin/nm
/usr/bin/strip $WORKPATH/install/mips-sde-elf/bin/objcopy
/usr/bin/strip $WORKPATH/install/mips-sde-elf/bin/objdump
/usr/bin/strip $WORKPATH/install/mips-sde-elf/bin/ranlib
/usr/bin/strip $WORKPATH/install/mips-sde-elf/bin/strip
if [ -f "$WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2" ];then
    /usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-gcc-4.7.2
    /usr/bin/strip $WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2/cc1
    /usr/bin/strip $WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2/collect2
    /usr/bin/strip $WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2/install-tools/fixincl
    /usr/bin/strip $WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2/cc1plus
    /usr/bin/strip $WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2/lto-wrapper
    /usr/bin/strip $WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2/lto1
elif [ -f "$WORKPATH/install/libexec/gcc/mips-sde-elf/4.9.2" ];then
    /usr/bin/strip $WORKPATH/install/bin/mips-sde-elf-gcc-4.9.2
    /usr/bin/strip $WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2/cc1
    /usr/bin/strip $WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2/collect2
    /usr/bin/strip $WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2/install-tools/fixincl
    /usr/bin/strip $WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2/cc1plus
    /usr/bin/strip $WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2/lto-wrapper
    /usr/bin/strip $WORKPATH/install/libexec/gcc/mips-sde-elf/4.7.2/lto1
else
    echo "******** strip host objects error"
fi
popenv
#!!!!!!!!!!!!!!!!!!!Should libcs3
echo "----------------# task [119/209] /i686-pc-linux-gnu/strip_target_objects\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
_N_GCC_VERSION=
if [ -d "$WORKPATH/install/lib/gcc/mips-sde-elf/4.7.2" ];then
    _N_GCC_VERSION=4.7.2
elif [ -d "$WORKPATH/install/lib/gcc/mips-sde-elf/4.9.2" ];then
    _N_GCC_VERSION=4.9.2
else
    echo "******** strip target objects"
    exit 0
fi    
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/sof/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/sof/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/sof/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/sof/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/sof/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/sof/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/sof/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/sof/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/sof/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/sof/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/sof/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/sof/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/micromips/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/sof/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/sof/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/sof/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/sof/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/sof/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/sof/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/sof/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/sof/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/sof/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/sof/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/sof/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/sof/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/mips16/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/64/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/64/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/64/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/64/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/64/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/64/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/64/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/64/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/64/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/64/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/64/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/64/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/64/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/64/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/64/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/64/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/64/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/64/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/64/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/64/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/64/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/64/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/64/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/64/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/sof/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/sof/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/sof/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/sof/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/sof/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/sof/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/sof/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/sof/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/sof/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/sof/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/sof/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/sof/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/sof/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/micromips/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/sof/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/sof/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/sof/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/sof/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/sof/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/sof/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/sof/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/sof/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/sof/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/sof/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/sof/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/sof/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/mips16/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/64/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/64/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/64/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/64/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/64/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/64/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/64/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/64/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/64/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/64/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/64/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/64/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/64/libcs3yamon.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/64/libstdc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/64/libcs3hal.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/64/libsupc++.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/64/libg.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/64/libcs3.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/64/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/64/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/64/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/64/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/64/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/64/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/libc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/libcs3-mips-fpemu.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/sof/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/libm.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/libcs3unhosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/libcs3-mips-cp1.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/el/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/mips-sde-elf/lib/libcs3hosted.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/micromips/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/micromips/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/micromips/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/micromips/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/micromips/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/micromips/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/micromips/sof/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/micromips/sof/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/micromips/sof/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/micromips/sof/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/micromips/sof/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/micromips/sof/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/mips16/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/mips16/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/mips16/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/mips16/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/mips16/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/mips16/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/mips16/sof/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/mips16/sof/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/mips16/sof/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/mips16/sof/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/mips16/sof/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/mips16/sof/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/64/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/64/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/64/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/64/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/64/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/64/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/sof/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/sof/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/sof/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/sof/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/sof/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/sof/64/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/sof/64/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/sof/64/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/sof/64/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/sof/64/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/sof/64/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/sof/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/micromips/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/micromips/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/micromips/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/micromips/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/micromips/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/micromips/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/micromips/sof/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/micromips/sof/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/micromips/sof/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/micromips/sof/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/micromips/sof/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/micromips/sof/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/mips16/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/mips16/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/mips16/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/mips16/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/mips16/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/mips16/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/mips16/sof/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/mips16/sof/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/mips16/sof/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/mips16/sof/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/mips16/sof/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/mips16/sof/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/64/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/64/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/64/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/64/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/64/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/64/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/sof/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/sof/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/sof/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/sof/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/sof/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/sof/64/libgcov.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/sof/64/crti.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/sof/64/crtend.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/sof/64/crtn.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/sof/64/crtbegin.o || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/sof/64/libgcc.a || true
mips-sde-elf-objcopy -R .comment -R .note -R .debug_info -R .debug_aranges -R .debug_pubnames -R .debug_pubtypes -R .debug_abbrev -R .debug_line -R .debug_str -R .debug_ranges -R .debug_loc $WORKPATH/install/lib/gcc/mips-sde-elf/${_N_GCC_VERSION}/el/sof/libgcc.a || true
popenv

echo "----------------# task [120/209] /i686-pc-linux-gnu/package_tbz2\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
pushenvvar CC gcc
pushenvvar CXX g++
pushenvvar AR ar
pushenvvar RANLIB ranlib
prepend_path PATH $WORKPATH/install/bin
rm -f $WORKPATH/pkg/mips-2012.09-98-mips-sde-elf-i686-pc-linux-gnu.tar.bz2
pushd $WORKPATH/obj
rm -f mips-2012.09
ln -s $WORKPATH/install mips-2012.09
tar cjf $WORKPATH/pkg/mips-2012.09-98-mips-sde-elf-i686-pc-linux-gnu.tar.bz2 --owner=0 --group=0 --exclude=host-i686-pc-linux-gnu --exclude=host-i686-mingw32 mips-2012.09/bin mips-2012.09/lib mips-2012.09/libexec mips-2012.09/mips-sde-elf mips-2012.09/share
rm -f mips-2012.09
popd
popenv

echo "----------------# task [121/209] /i686-pc-linux-gnu/package_installanywhere/unpack\n"
# pushenv
# pushenvvar CC_FOR_BUILD gcc
# pushenvvar CXX_FOR_BUILD g++
# pushenvvar CC gcc
# pushenvvar CXX g++
# pushenvvar AR ar
# pushenvvar RANLIB ranlib
# prepend_path PATH $WORKPATH/install/bin
# $WORKPATH/src/scripts-trunk/gnu-ia-unpack -i $WORKPATH/install -l $WORKPATH/logs -o $WORKPATH/obj -p $WORKPATH/pkg -s $WORKPATH/src -T $WORKPATH/testlogs -h i686-pc-linux-gnu -e $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras sgxx/2012.09/mips-sde-elf-lite
# popenv

echo "----------------# task [122/209] /i686-pc-linux-gnu/package_installanywhere/merge_modules\n"
# pushenv
# pushenvvar CC_FOR_BUILD gcc
# pushenvvar CXX_FOR_BUILD g++
# pushenvvar CC gcc
# pushenvvar CXX g++
# pushenvvar AR ar
# pushenvvar RANLIB ranlib
# prepend_path PATH $WORKPATH/install/bin
# $WORKPATH/src/scripts-trunk/gnu-ia-helper-mm -i $WORKPATH/install -l $WORKPATH/logs -o $WORKPATH/obj -p $WORKPATH/pkg -s $WORKPATH/src -T $WORKPATH/testlogs -h i686-pc-linux-gnu -m iamm-common sgxx/2012.09/mips-sde-elf-lite
# $WORKPATH/src/scripts-trunk/gnu-ia-helper-mm -i $WORKPATH/install -l $WORKPATH/logs -o $WORKPATH/obj -p $WORKPATH/pkg -s $WORKPATH/src -T $WORKPATH/testlogs -h i686-pc-linux-gnu -m iamm-jvm sgxx/2012.09/mips-sde-elf-lite
# popenv

echo "----------------# task [123/209] /i686-pc-linux-gnu/package_installanywhere/installer\n"
# pushenv
# pushenvvar CC_FOR_BUILD gcc
# pushenvvar CXX_FOR_BUILD g++
# pushenvvar CC gcc
# pushenvvar CXX g++
# pushenvvar AR ar
# pushenvvar RANLIB ranlib
# prepend_path PATH $WORKPATH/install/bin
# $WORKPATH/src/scripts-trunk/gnu-ia-helper -i $WORKPATH/install -l $WORKPATH/logs -o $WORKPATH/obj -p $WORKPATH/pkg -s $WORKPATH/src -T $WORKPATH/testlogs -h i686-pc-linux-gnu -f $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras/getting_started/license.html -e $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras sgxx/2012.09/mips-sde-elf-lite
# popenv

echo "----------------# task [124/209] /i686-mingw32/host_cleanup\n"
echo "----------------# task [125/209] /i686-mingw32/host_unpack\n"
echo "----------------# task [126/209] /i686-mingw32/libiconv/0/configure\n"
echo "----------------# task [127/209] /i686-mingw32/libiconv/0/build\n"
echo "----------------# task [128/209] /i686-mingw32/libiconv/0/install\n"
echo "----------------# task [129/209] /i686-mingw32/make/copy\n"
echo "----------------# task [130/209] /i686-mingw32/make/configure\n"
echo "----------------# task [131/209] /i686-mingw32/make/build\n"
echo "----------------# task [132/209] /i686-mingw32/make/install\n"
echo "----------------# task [133/209] /i686-mingw32/coreutils/copy\n"
echo "----------------# task [134/209] /i686-mingw32/coreutils/configure\n"
echo "----------------# task [135/209] /i686-mingw32/coreutils/build\n"
echo "----------------# task [136/209] /i686-mingw32/coreutils/install\n"
echo "----------------# task [137/209] /i686-mingw32/zlib_first/copy\n"
echo "----------------# task [138/209] /i686-mingw32/zlib_first/configure\n"
echo "----------------# task [139/209] /i686-mingw32/zlib_first/build\n"
echo "----------------# task [140/209] /i686-mingw32/zlib_first/install\n"
echo "----------------# task [141/209] /i686-mingw32/gmp/configure\n"
echo "----------------# task [142/209] /i686-mingw32/gmp/build\n"
echo "----------------# task [143/209] /i686-mingw32/gmp/install\n"
echo "----------------# task [144/209] /i686-mingw32/gmp/postinstall\n"
echo "----------------# task [145/209] /i686-mingw32/mpfr/configure\n"
echo "----------------# task [146/209] /i686-mingw32/mpfr/build\n"
echo "----------------# task [147/209] /i686-mingw32/mpfr/install\n"
echo "----------------# task [148/209] /i686-mingw32/mpfr/postinstall\n"
echo "----------------# task [149/209] /i686-mingw32/mpc/configure\n"
echo "----------------# task [150/209] /i686-mingw32/mpc/build\n"
echo "----------------# task [151/209] /i686-mingw32/mpc/install\n"
echo "----------------# task [152/209] /i686-mingw32/mpc/postinstall\n"
echo "----------------# task [153/209] /i686-mingw32/ppl/configure\n"
echo "----------------# task [154/209] /i686-mingw32/ppl/build\n"
echo "----------------# task [155/209] /i686-mingw32/ppl/install\n"
echo "----------------# task [156/209] /i686-mingw32/cloog/configure\n"
echo "----------------# task [157/209] /i686-mingw32/cloog/build\n"
echo "----------------# task [158/209] /i686-mingw32/cloog/install\n"
echo "----------------# task [159/209] /i686-mingw32/cloog/postinstall\n"
echo "----------------# task [160/209] /i686-mingw32/libelf/configure\n"
echo "----------------# task [161/209] /i686-mingw32/libelf/build\n"
echo "----------------# task [162/209] /i686-mingw32/libelf/install\n"
echo "----------------# task [163/209] /i686-mingw32/toolchain/binutils/copy\n"
echo "----------------# task [164/209] /i686-mingw32/toolchain/binutils/configure\n"
echo "----------------# task [165/209] /i686-mingw32/toolchain/binutils/libiberty\n"
echo "----------------# task [166/209] /i686-mingw32/toolchain/binutils/build\n"
echo "----------------# task [167/209] /i686-mingw32/toolchain/binutils/install\n"
echo "----------------# task [168/209] /i686-mingw32/toolchain/binutils/postinstall\n"
echo "----------------# task [169/209] /i686-mingw32/toolchain/copy_libs\n"
echo "----------------# task [170/209] /i686-mingw32/toolchain/gcc_final/configure\n"
echo "----------------# task [171/209] /i686-mingw32/toolchain/gcc_final/build\n"
echo "----------------# task [172/209] /i686-mingw32/toolchain/gcc_final/install\n"
echo "----------------# task [173/209] /i686-mingw32/toolchain/gcc_final/postinstall\n"
echo "----------------# task [174/209] /i686-mingw32/toolchain/zlib/0/copy\n"
echo "----------------# task [175/209] /i686-mingw32/toolchain/zlib/0/configure\n"
echo "----------------# task [176/209] /i686-mingw32/toolchain/zlib/0/build\n"
echo "----------------# task [177/209] /i686-mingw32/toolchain/zlib/0/install\n"
echo "----------------# task [178/209] /i686-mingw32/toolchain/expat/0/configure\n"
echo "----------------# task [179/209] /i686-mingw32/toolchain/expat/0/build\n"
echo "----------------# task [180/209] /i686-mingw32/toolchain/expat/0/install\n"
echo "----------------# task [181/209] /i686-mingw32/toolchain/gdb/0/copy\n"
echo "----------------# task [182/209] /i686-mingw32/toolchain/gdb/0/configure\n"
echo "----------------# task [183/209] /i686-mingw32/toolchain/gdb/0/build\n"
echo "----------------# task [184/209] /i686-mingw32/toolchain/gdb/0/install\n"
echo "----------------# task [185/209] /i686-mingw32/toolchain/gdb/0/postinstall\n"
echo "----------------# task [186/209] /i686-mingw32/gdil/configure\n"
echo "----------------# task [187/209] /i686-mingw32/gdil/build\n"
echo "----------------# task [188/209] /i686-mingw32/gdil/install\n"
echo "----------------# task [189/209] /i686-mingw32/edge_utils/build\n"
echo "----------------# task [190/209] /i686-mingw32/mips_sprite/configure\n"
echo "----------------# task [191/209] /i686-mingw32/mips_sprite/build\n"
echo "----------------# task [192/209] /i686-mingw32/mips_sprite/install\n"
echo "----------------# task [193/209] /i686-mingw32/sprite/configure\n"
echo "----------------# task [194/209] /i686-mingw32/sprite/build\n"
echo "----------------# task [195/209] /i686-mingw32/sprite/install\n"
echo "----------------# task [196/209] /i686-mingw32/pretidy_installation\n"
echo "----------------# task [197/209] /i686-mingw32/remove_libtool_archives\n"
echo "----------------# task [198/209] /i686-mingw32/remove_copied_libs\n"
echo "----------------# task [199/209] /i686-mingw32/remove_fixed_headers\n"
echo "----------------# task [200/209] /i686-mingw32/add_tooldir_readme\n"
echo "----------------# task [201/209] /i686-mingw32/strip_host_objects\n"
echo "----------------# task [202/209] /i686-mingw32/package_tbz2\n"
echo "----------------# task [203/209] /i686-mingw32/package_installanywhere/unpack\n"
echo "----------------# task [204/209] /i686-mingw32/package_installanywhere/merge_modules\n"
echo "----------------# task [205/209] /i686-mingw32/package_installanywhere/installer\n"
echo "----------------# task [206/209] /fini/extras_package\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.extras
pushd $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf
tar cjf $WORKPATH/pkg/mips-2012.09-98-mips-sde-elf.extras.tar.bz2 --owner=0 --group=0 mips-2012.09-98-mips-sde-elf.extras
popd
popenv

echo "----------------# task [207/209] /fini/build_summary\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
cat > $WORKPATH/pkg/mips-2012.09-98-mips-sde-elf-summary.xml <<'EOF0'
<?xml version="1.0" ?><build><variable var="release_config_canonical" value="sgxx/2012.09/mips-sde-elf-lite"/><variable var="version" value="2012.09-98"/><variable var="hosts_string" value="i686-pc-linux-gnu i686-mingw32"/><variable var="target" value="mips-sde-elf"/><variable var="build_date" value="20121219"/><variable var="HOSTNAME" value="build6-lucid-cs"/><variable var="build_operating_system" value="squeeze/sid"/><variable var="build_uname" value="Linux build6-lucid-cs 2.6.32-28-generic #55-Ubuntu SMP Mon Jan 10 23:42:43 UTC 2011 x86_64 GNU/Linux"/><variable var="USER" value="cmoore"/><checksum type="md5" value="271e11082d759e2b26992c38ae13689b" file="mips-2012.09-98-mips-sde-elf-i686-pc-linux-gnu.tar.bz2"/><checksum type="md5" value="b6a7adfc718601e34029b3ab6ae199c4" file="mips-2012.09-98-mips-sde-elf-i686-mingw32.tar.bz2"/><checksum type="md5" value="b895a9e614128613132a7385de0746c7" file="mips-2012.09-98-mips-sde-elf.extras.tar.bz2"/></build>
EOF0
popenv

echo "----------------# task [208/209] /fini/backups_package\n"
pushenv
pushenvvar CC_FOR_BUILD gcc
pushenvvar CXX_FOR_BUILD g++
mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf.backup
pushd $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf
tar cjf $WORKPATH/pkg/mips-2012.09-98-mips-sde-elf.backup.tar.bz2 --owner=0 --group=0 mips-2012.09-98-mips-sde-elf.backup
popd
popenv

echo "----------------# task [209/209] /fini/sources_package\n"
# pushenv
# pushenvvar CC_FOR_BUILD gcc
# pushenvvar CXX_FOR_BUILD g++
# mkdir -p $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
# cp $WORKPATH/pkg/mips-2012.09-98-mips-sde-elf-summary.xml $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
# cp $WORKPATH/mips-2012.09-98-mips-sde-elf.sh $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf/mips-2012.09-98-mips-sde-elf
# pushd $WORKPATH/obj/pkg-2012.09-98-mips-sde-elf
# tar cjf $WORKPATH/pkg/mips-2012.09-98-mips-sde-elf.src.tar.bz2 --owner=0 --group=0 mips-2012.09-98-mips-sde-elf
# popd
# $WORKPATH/src/scripts-trunk/gnu-test -i $WORKPATH/install -l $WORKPATH/logs -o $WORKPATH/obj -p $WORKPATH/pkg -s $WORKPATH/src -T $WORKPATH/testlogs -T $WORKPATH/obj/testlogs-2012.09-98-mips-sde-elf sgxx/2012.09/mips-sde-elf-lite
# copy_dir $WORKPATH/obj/testlogs-2012.09-98-mips-sde-elf $WORKPATH/testlogs
# $WORKPATH/src/scripts-trunk/gnu-test-package -i $WORKPATH/install -l $WORKPATH/logs -o $WORKPATH/obj -p $WORKPATH/pkg -s $WORKPATH/src -T $WORKPATH/testlogs -T $WORKPATH/obj/testlogs-2012.09-98-mips-sde-elf sgxx/2012.09/mips-sde-elf-lite

#Move jzmedia.h jzmxu128.h head file to toolchains include
cp $WORKPATH/Jz-special/Jz-mxu/jzmedia.h  $WORKPATH/install/mips-sde-elf/include/
cp $WORKPATH/Jz-special/Jz-mxu128/jzmxu128.h $WORKPATH/install/mips-sde-elf/include/


echo "----------------# task [210/387] /i686-pc-linux-gnu/toolchain/jz/extend_0/copy\n"
pushenv
prepend_path PATH $WORKPATH/install/bin
rm -rf $WORKPATH/obj/jz-extend-mips-sde-elf/default
copy_dir_clean $WORKPATH/Jz-special/extend $WORKPATH/obj/jz-extend-mips-sde-elf/default
chmod -R u+w $WORKPATH/obj/jz-extend-mips-sde-elf/default
popenv

echo "----------------# task [211/387] /i686-pc-linux-gnu/toolchain/jz/extend_0/install\n"
pushenv
prepend_path PATH $WORKPATH/install/bin
pushd $WORKPATH/obj/jz-extend-mips-sde-elf/default
make V=1 CROSS_COMPILER_PREFIX=$WORKPATH/install/bin/mips-sde-elf-
make V=1 PREFIX=$WORKPATH/install/mips-sde-elf/include install_headers
make V=1 PREFIX=$WORKPATH/install/mips-sde-elf/lib install_libs
popd
popenv

echo "----------------# task [212/387] /i686-pc-linux-gnu/toolchain/jz/extend_1/copy\n"
pushenv
prepend_path PATH $WORKPATH/install/bin
rm -rf $WORKPATH/obj/jz-extend-mips-sde-elf/msoft-float
copy_dir_clean $WORKPATH/Jz-special/extend $WORKPATH/obj/jz-extend-mips-sde-elf/msoft-float
chmod -R u+w $WORKPATH/obj/jz-extend-mips-sde-elf/msoft-float
popenv

echo "----------------# task [213/387] /i686-pc-linux-gnu/toolchain/jz/extend_1/install\n"
pushenv
prepend_path PATH $WORKPATH/install/bin
pushd $WORKPATH/obj/jz-extend-mips-sde-elf/msoft-float
make V=1 CROSS_COMPILER_PREFIX=$WORKPATH/install/bin/mips-sde-elf- ARCH_CFLAGS='-msoft-float'
make V=1 PREFIX=$WORKPATH/install/mips-sde-elf/lib/sof install_libs
popd
popenv

echo "############################## FINISHED ##################################"
