#!/bin/bash
dotest_case=$1

if [  "$dotest_case"x = "gcc"x ];then
echo '
#generate_gcc_dejagnu_site
# If outside target test, tmpdir must be path running test
set host_alias     i686-pc-linux-gnu
set host_triplet   i686-pc-linux-gnu
set build_triplet  i686-pc-linux-gnu
set target_alias   EXP_TOOLCHAIN_TARGET
set target_triplet EXP_TOOLCHAIN_TARGET
#fix boards_dir to your position of the dejagnu
lappend boards_dir "EXP_DEJAGNU_DIR"

# this two flags maybe defined sshcp.exp
# set CFLAGS      "EXP_CFLAGS"
# append LDFLAGS  "EXP_LDFLAGS"
# set timeout       1000
# set timeout_value 10000
set HOSTCC        "gcc"
set HOSTCFLAGS    "-g -O2"
'
if [ "${outside}"x = "y"x ];then
echo 'set tmpdir         EXP_RUN_DIR'
fi

elif [ "$dotest_case"x = "gdb"x ];then
echo '
set host_alias     i686-pc-linux-gnu
set host_triplet   i686-pc-linux-gnu
set build_triplet  i686-pc-linux-gnu
set target_alias   EXP_TOOLCHAIN_TARGET
set target_triplet EXP_TOOLCHAIN_TARGET
#　fix boards_dir to your position of the dejagnu
lappend boards_dir "EXP_DEJAGNU_DIR"

set srcdir        EXP_GDB_SRC_DIR/gdb/testsuite
set all_flag 1
set tool gdb
'
elif [ "$dotest_case"x = "gas"x ];then

echo '
set host_alias     i686-pc-linux-gnu
set host_triplet   i686-pc-linux-gnu
set build_triplet  i686-pc-linux-gnu
set target_alias   EXP_TOOLCHAIN_TARGET_INTERNAL
set target_triplet EXP_TOOLCHAIN_TARGET_INTERNAL
#fix boards_dir to your position of the dejagnu
lappend boards_dir "EXP_DEJAGNU_DIR"

# set to sim , gas ld binutils and sim will all be tested
set srcdir         EXP_GAS_SRC_DIR/sim/testsuite/
set all_flag 1
set tool sim
'
fi


