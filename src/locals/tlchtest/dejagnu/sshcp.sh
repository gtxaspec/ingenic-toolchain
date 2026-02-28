#!/bin/bash
dotest_case=$1

if [ "$dotest_case"x = "gcc"x ] ||
       [ "$dotest_case"x = "gas"x ];then
echo '
#for common generate_gcc_dejagnu_sshcp
load_generic_config        "unix"
process_multilib_options   ""
set_board_info compiler    "EXP_ABSOLUTE_GCC_PREFIX"
set_board_info c++compiler "EXP_ABSOLUTE_GXX_PREFIX"
set_board_info rsh_prog    "/usr/bin/ssh -p  EXP_SSHPORT"
set_board_info rcp_prog    "/usr/bin/scp -P  EXP_SSHPORT"
set_board_info protocol     standard
set_board_info hostname     EXP_TARGETIP
set_board_info sockethost  "EXP_TARGETIP:"
set_board_info cflags      "EXP_CFLAGS"
set_board_info ldflags     "EXP_CFLAGS"
set_board_info username    root
#end common
'
elif [ "$dotest_case"x = "gdb"x ];then
echo '
# for gdb server sshcp
load_generic_config        "gdbserver"
process_multilib_options   ""
set_board_info compiler    "EXP_ABSOLUTE_GCC_PREFIX"
set_board_info c++compiler "EXP_ABSOLUTE_GXX_PREFIX"
set_board_info rsh_prog    "/usr/bin/ssh"
set_board_info rcp_prog    "/usr/bin/scp"
set_board_info protocol     standard
set_board_info sockethost   "EXP_TARGETIP:"
set_board_info hostname    EXP_TARGETIP
set_board_info username    root
set_board_info cflags      "EXP_CFLAGS"
set_board_info ldflags     "EXP_CFLAGS"

# gdbserver location on your target board.
set_board_info gdb_server_prog      /usr/bin/gdbserver
# We will be using the standard GDB remote protocol
set_board_info gdb_protocol         "remote"
# Use techniques appropriate to a stub
set_board_info use_gdb_stub         1
# This gdbserver can only run a process once per session.
set_board_info gdb,do_reload_on_run 1
# There is no support for argument-passing (yet).
set_board_info noargs               1
# Can not do input (or output) in the current gdbserver.
set_board_info gdb,noinferiorio     1
# Can not do hardware watchpoints, in generate
set_board_info gdb,no_hardware_watchpoints 1
'
fi
