#i!/bin/sh

if [ -z "$1" ];then
	echo "Please input board IP and Toolchains PATH!!!!!"
	exit 0;
fi

if [ -z "$2" ];then
	echo "Please input Toolchains PATH!!!!!"
	exit 0;
fi

FILE_NAME="dorado_v2.1_dejagnu"

if ! [ -d "$FILE_NAME" ]; then
echo "====================download sources==========================="
	mkdir $FILE_NAME
	cd $FILE_NAME
	export SRC_PATH=`pwd`

	repo init -u ssh://192.168.1.26:29418/linux/manifest -b ingenic-master
	cd $SRC_PATH/.repo/manifests/

	sed -i 's/   <project path="binaries.*$//g' default.xml
	sed -i '/^[[:space:]][[:space:]]*$/d' default.xml

	cd $SRC_PATH
	repo sync
	repo forall -c "git reset --hard  ingenic-buildroot201405-kernel3.10.14-dorado-v1.0-20141127"
	
	mkdir images
else
echo "====================sources had==========================="
	cd $FILE_NAME
	export SRC_PATH=`pwd`
fi


echo "====================build u-boot==========================="
cd $SRC_PATH/sources/bootloader/u-boot
sed -i "s/rootdelay=2 init=\/linuxrc root=\/dev\/mmcblk0p7 rw/ip=$1:192.168.4.1:192.168.4.1:255.255.255.0 rootdelay=2 init=\/linuxrc root=\/dev\/mmcblk0p7 rw/g" include/configs/dorado.h
export CROSS_COMPILE=$2
make distclean
make dorado_uImage_msc0 -j4 V=1
cp u-boot-with-spl-mbr-gpt.bin $SRC_PATH/images
git checkout include/configs/dorado.h

echo "====================build kernel-3.10.14==========================="
cd $SRC_PATH/sources/kernel/linux-3.10.14
export CROSS_COMPILE=$2
make distclean
make dorado_v21_linux_defconfig
make uImage -j8 V=1
cp arch/mips/boot/uImage $SRC_PATH/images
echo "====================finished==========================="
