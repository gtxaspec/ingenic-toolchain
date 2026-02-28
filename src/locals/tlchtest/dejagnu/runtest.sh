#!/bin/bash
test_type=$1

if [ "$test_type"x = "inside"x ];then
echo '
export PATH=EXP_PATH
export DEJAGNU=EXP_DEJAGNU_DIR/site.exp
make -j4 -k -w check RUNTESTFLAGS="--target_board sshcp -v -v EXP_DEJAGNU_SPECIAL"

#Test for per
#execute.exp=20101011-1.c

#To set test options
#export COMPAT_OPTIONS="[list [list {-EL -muclibc -msoft-float} {-EL -muclibc -msoft-float}] ]"
'

elif [ "$test_type"x = "outside"x ];then
    echo '
export PATH=EXP_PATH
export DEJAGNU=EXP_DEJAGNU_DIR/site.exp

runtest --srcdir    EXP_SRC_DIR \
    --outdir    EXP_OUT_DIR \
    --objdir    EXP_OBJ_DIR \
    -tool       EXP_TOOL \
    --tool_exec EXP_TOOL_EXEC \
    --target    EXP_TOOLCHAIN_TARGET  \
    --target_board sshcp \
    -v -v \
    EXP_DEJAGNU_SPECIAL
'
fi
