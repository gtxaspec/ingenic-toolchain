#!/bin/bash

# This file contains the extension packages build commands. Must be included
# in toolchains top buildscript (eg: mipslinux-7.2.sh) to execute.

echo " ----------# task [ext/1/5] /init/source_package/cmake"
pushenv
pushenvvar CC_FOR_BUILD 'gcc  '
pushenvvar CXX_FOR_BUILD 'g++ '
mkdir -p ${local_path}/obj/pkg-2015.11-32-mips-linux-gnu/mips-2015.11-32-mips-linux-gnu
pushd ${local_path}/src
popd
popenv

echo " ----------# task [ext/1/5] /i686-pc-linux-gnu/cmake/configure"
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
rm -rf ${local_path}/obj/cmake-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
mkdir -p ${local_path}/obj/cmake-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
pushd ${local_path}/obj/cmake-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
${local_path}/src/cmake-3.8.2/bootstrap --parallel=8 --prefix=${local_path}/install/opt/codesourcery -- -DCMAKE_C_FLAGS="-O2" -DCMAKE_CXX_FLAGS="-O2"  -DCMAKE_USE_OPENSSL:BOOL=OFF -DBUILD_CursesDialog=OFF
popd
popenv
popenv
popenv

echo " ----------# task [ext/3/5] /i686-pc-linux-gnu/cmake/build"
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
pushd ${local_path}/obj/cmake-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make $JX
popd
popenv
popenv
popenv

echo " ----------# task [ext/4/5] /i686-pc-linux-gnu/cmake/install"
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
pushd ${local_path}/obj/cmake-2015.11-32-mips-linux-gnu-i686-pc-linux-gnu
make install/fast
popd
popenv
popenv
popenv

echo " ----------# task [ext/5/5] /i686-pc-linux-gnu/strip_external_host_objects"
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
strip ${local_path}/install/opt/codesourcery/bin/cmake
strip ${local_path}/install/opt/codesourcery/bin/cpack
strip ${local_path}/install/opt/codesourcery/bin/ctest
popenv
