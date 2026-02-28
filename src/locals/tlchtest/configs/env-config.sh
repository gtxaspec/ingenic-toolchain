
kernel_remote=
kernel_branch=
kernel_local=
kernel_tag=
kernel_patch=
kernel_config=
kernel_output=
uboot_remote=
uboot_branch=
uboot_local=
uboot_tag=
uboot_patch=
uboot_config=
uboot_output=
rootfs_remote=
rootfs_branch=
rootfs_local=
rootfs_tag=
rootfs_patch=
rootfs_config=
rootfs_output=


# remote branch local output tag patch config
kernel_output="arch/mips/boot/uImage"
uboot_output="u-boot-with-spl-mbr-gpt.bin"
rootfs_output="output/images/*"


rootfs_environment()
{
    # rootfs
    rootfs_remote="ssh://192.168.1.26:29418/buildroot/buildroot"
    rootfs_branch="ingenic-master"
    rootfs_local="${testenv}/buildroot_o6"

    rootfs_tag="78de3d5"
    rootfs_config="${work_path}/configs/ingenic_tlchenv_defconfig"

    # Different for gcc 7.2.0 and 5.2.0
    if [ $gcc_version = "72" ];then
	if [ $buildroot_version = "2017" ];then
	    rootfs_remote="ssh://192.168.1.26:29418/buildroot/buildroot_1702"
	    rootfs_branch="ingenic-master"
	    rootfs_local="${testenv}/buildroot"
	    rootfs_patch="${work_path}/patchs/0001-Buildroot.2017-build-for-gcc72.patch"
	    rootfs_tag="ad089203"
	    rootfs_config="${work_path}/configs/ingenic_tlchenv_2017_defconfig"
	else
	    rootfs_patch="${work_path}/patchs/0001-Buildroot-build-for-gcc72.patch"
	    buildroot_cflags+="-Wno-format-nonliteral -std=gnu89"
	fi
    elif [ $gcc_version = "52" ];then
	rootfs_patch="${work_path}/patchs/0001-Buildroot-build-for-gcc52.patch"
    fi
}


if [ "$target_environment"x = "dorado"x ];then
    # kernel
    kernel_remote="ssh://192.168.1.26:29418/AOSP/kernel/mips"
    kernel_branch="ingenic-master-3.10.14"
    kernel_local="${testenv}/kernel"
    kernel_tag="b635632"
    kernel_config="${work_path}/configs/${board}_tlchenv_defconfig"

    # uboot
    uboot_remote="ssh://192.168.1.26:29418/bootloader/u-boot"
    uboot_branch="ingenic-master"
    uboot_local="${testenv}/uboot"
    uboot_tag="d63327c"
    uboot_config="dorado_v22_uImage_msc0"

    rootfs_environment

    # Different for gcc 7.2.0 and 5.2.0
    if [ $gcc_version = "72" ];then
	kernel_patch="${work_path}/patchs/0001-Kernel-dorado-build-for-gcc72.patch"
	uboot_patch="${work_path}/patchs/0001-Uboot-dorado-build-for-gcc72.patch"
    elif [ $gcc_version = "52" ];then
	kernel_patch="${work_path}/patchs/0001-Kernel-dorado-build-for-gcc52.patch"
	uboot_patch="${work_path}/patchs/0001-Uboot-dorado-build-for-gcc52.patch"
    fi

elif [ "$target_environment"x = "mensa"x ]; then
    # kernel
    kernel_remote="ssh://192.168.1.26:29418/kernel/kernel-3.10"
    kernel_branch="ingenic-kernel-3.10.14"
    kernel_local="${testenv}/kernel_np"
    kernel_tag="4c3ac7a9"
    kernel_config="${work_path}/configs/mensa_v20_tlchenv_defconfig"

    # uboot
    uboot_remote="ssh://192.168.1.26:29418/bootloader/u-boot"
    uboot_branch="ingenic-master"
    uboot_local="${testenv}/uboot"
    uboot_tag="4a92a23f"
    uboot_config="mensa_v20_uImage_msc0"
    uboot_output="u-boot-with-spl-mbr.bin"

    rootfs_environment

    if [ $gcc_version = "72" ];then
	kernel_patch="${work_path}/patchs/0001-Kernel-mensa-build-for-gcc72.patch"
	uboot_patch="${work_path}/patchs/0001-Uboot-mensa-build-for-gcc72.patch"
    elif [ $gcc_version = "52" ];then
	kernel_patch=""
	uboot_patch=""
    fi

elif [ "$target_environment"x = "x2000"x ]; then
    # kernel
    kernel_remote="ssh://192.168.1.26:29418/AOSP/kernel/mips"
    kernel_branch="fpga-x2000"
    kernel_local="${testenv}/kernel"
    kernel_tag="cc590358"
    kernel_config="${work_path}/configs/x2000_seal_defconfig"

    # uboot
    uboot_remote="ssh://192.168.1.26:29418/bootloader/u-boot"
    uboot_branch="fpga-x2000"
    uboot_local="${testenv}/uboot"
    uboot_tag="21da02ef"
    uboot_config="x2000_uImage_msc0"
    uboot_output="u-boot-with-spl-mbr-gpt.bin"

    rootfs_environment

    if [ $gcc_version = "72" ];then
	kernel_patch="${work_path}/patchs/0001-Kernel-x2000-build-for-gcc72.patch"
	uboot_patch="${work_path}/patchs/0001-Uboot-x2000-build-for-gcc72.patch"
    elif [ $gcc_version = "52" ];then
	kernel_patch=""
	uboot_patch=""
    fi

elif [ "$target_environment"x = "kernel47"x ];then
    echo "kernel 47 config ***"
    exit 1
fi
