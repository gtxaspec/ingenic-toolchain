#!/bin/bash

check_run()
{
    local command=$@

    $command

    if [ "$?"x != "0"x ];then
	echo "Error ***: $1"
	exit 1
    fi
}

check_git_localdir_exist()
{
    local memsage="Download load dir \"$1\" exist, Re-download or Continue or Exit [R/C/E]:"
    dowhat=1
    if [ -e $1 ];then
	readp=1
	while [ 1 ]
	do
	    read -n 2 -p "$memsage" ready
	    case $ready in
		'R'|'r')
		    dowhat=1
		    break
		    ;;
		'C'|'c')
		    dowhat=2
		    break
		    ;;
		'E'|'e')
		    exit 1
		    ;;
		*)
		    echo " "
		    continue
		    ;;
	    esac
	done
    fi

    if [ "$dowhat"x = "1"x ];then
	rm -fr $1
    fi
    return $dowhat
}

vexe()
{
    echo $verbose
    # must use if...then...else...fi; cannot use (&& ||),because
    # $@ >/dev/null maybe get error.
    if [ "$verbose" = "0" ];then
	eval $@ >/dev/null
    else
	eval $@
    fi
}

yes_or_no()
{
    readp=1
    while [ ${readp} ]
    do
	read -n 2 -p "$1 [Y/N]:" ready
	case $ready in
	    'Y')
		readp=0
		break
		;;
	    'y')
		readp=0
		break
		;;
	    'N')
		echo " "
		exit 1
		;;
	    'n')
		echo " "
		exit 1
		;;
	    *)
		echo " "
		continue
		;;
	esac
    done
}


#LTP
run_ltp()
{
    if [ "$buildroot_version" = "2012" ];then
	ssh root@${targetip} "cd /usr; ./runltp 1>ltp.log"
    elif [ "$buildroot_version" = "2017"]; then
	ssh root@${targetip} "cd /usr/lib/ltp-testsuite; ./runltp 1>ltp.log"
    else
	echo "*** buildroot_version: 2017 or 2012. you set '$buildroot_version'"
    fi
}
