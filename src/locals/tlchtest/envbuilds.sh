#!/bin/bash
source ${local_path}/locals/tlchtest/configs/env-config.sh
nfshostip=192.168.4.13
gatewayip=192.168.4.1
netmask=255.255.255.0

_sync_basic()
{
    local remote=$1
    local branch=$2
    local local_dir=$3
    local tag=$4

    check_git_localdir_exist "$local_dir"

    if [ "$?"x = "1"x ];then
	echo "Downloading ..."
    else
	echo "Ignore download"
	return 0
    fi

    check_run "git clone $remote -b $branch $local_dir"
    pushd $local_dir
    [ "$?"x != "0"x ] && exit 1

    check_run "git reset --hard $tag"
    popd
}

sync_kernel()
{
    _sync_basic "$kernel_remote" "$kernel_branch" \
		"$kernel_local" "$kernel_tag"
}

sync_uboot()
{
    _sync_basic  "$uboot_remote" "$uboot_branch" \
		 "$uboot_local" "$uboot_tag"
}

sync_rootfs()
{
    _sync_basic "$rootfs_remote" "$rootfs_branch" \
		"$rootfs_local" "$rootfs_tag"
}

syncEnvSource()
{
    [ $synckernel = 1 ] && sync_kernel
    [ $syncuboot  = 1 ] && sync_uboot
    [ $syncrootfs = 1 ] && sync_rootfs
}

_build_basic()
{
    local project=$1
    local remote=$2
    local branch=$3
    local local_dir=$4
    local tag=$5
    local patch=$6
    local config=$7
    local output=$8

    pushd $local_dir

    [ "$?"x != "0"x ] && exit 1

    check_run "git reset --hard $tag"
    check_run "git clean -f"
    if  [ "$patch"x != ""x ];then
	check_run "git apply $patch"
    fi


    if [ "$project"x = "uboot"x ]; then
	check_run "make distclean"
	vexe "make  ${config} -j24 2>&1 | tee uboot.log"
    elif [ "$project"x = "kernel"x ]; then
	check_run "make distclean"
	check_run "cp $config .config"
	vexe 'make uImage -j24 V=1 2>&1 | tee kernel.log'
    elif [ "$project"x = "rootfs"x ]; then
	check_run "make clean"
	check_run "cp $config .config"
	check_run "_fix_local_config $project"
	vexe "make -j24 2>&1 | tee buildroot.log"
    fi

    if [ "$?"x != "0"x ];then
	echo "build *** [$project] Error"
	popd
	return 1
    fi

    check_run "cp $output ${outputdir}/"
    popd
}

# For build kernel
build_kernel()
{
    _build_basic "kernel" "$kernel_remote" \
		 "$kernel_branch" "$kernel_local" \
		 "$kernel_tag"  "$kernel_patch"  \
		 "$kernel_config" "$kernel_output"
}

# For build uboot
build_uboot()
{
    _build_basic "uboot" "$uboot_remote" \
		 "$uboot_branch"  "$uboot_local" \
		 "$uboot_tag"  "$uboot_patch"  \
		 "$uboot_config" "$uboot_output"
}


build_rootfs()
{
    _build_basic "rootfs" "$rootfs_remote" \
		 "$rootfs_branch" "$rootfs_local" \
		 "$rootfs_tag"  "$rootfs_patch"  \
		 "$rootfs_config" "$rootfs_output"
}

# For build rootfs
_fix_local_config()
{
    sed -i "s@TOOLCHAIN_LOCAL_PATH@${local_path}@g; s/TOOLCHAIN_HOST/$host/g" ./system/skeleton/root/.sshfsconfig
    sed -i -e "/^BR2_TOOLCHAIN_EXTERNAL_PATH/c\BR2_TOOLCHAIN_EXTERNAL_PATH=\"${install_path}\"" \
	-e "/^BR2_TARGET_GENERIC_GETTY_PORT/c\BR2_TARGET_GENERIC_GETTY_PORT=\"${getty_port}\""  \
	-e "/^BR2_TARGET_OPTIMIZATION/c\BR2_TARGET_OPTIMIZATION=\"${buildroot_cflags}\"" .config
}
