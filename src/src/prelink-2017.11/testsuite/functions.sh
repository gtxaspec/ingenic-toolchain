#!/bin/bash
CC="${CC:-gcc} ${LINKOPTS}"
CCLINK=${CCLINK:-${CC} -Wl,--dynamic-linker=`echo ./ld*.so.*[0-9]`}
CXX="${CXX:-g++} ${LINKOPTS}"
CXXLINK=${CXXLINK:-${CXX} -Wl,--dynamic-linker=`echo ./ld*.so.*[0-9]`}
PRELINK=${PRELINK:-../src/prelink -c ./prelink.conf -C ./prelink.cache --ld-library-path=. --dynamic-linker=`echo ./ld*.so.*[0-9]`}
BUILD_CC=${BUILD_CC:-${CC}}
STRIP=${STRIP:-strip}
READELF=${READELF:-readelf}
RUN=${RUN:-env}
RUN_HOST=${RUN_HOST:-env}
# For documentation purposes...
PRELINK_RTLD=${PRELINK_RTLD:-}
srcdir=${srcdir:-`dirname $0`}
savelibs() {
  for i in $LIBS $BINS; do cp -p $i $i.orig; done
}
comparelibs() {
  for i in $LIBS $BINS; do
    cp -p $i $i.new
    echo $PRELINK -u $i.new
    $RUN_HOST $PRELINK -u $i.new || exit
    cmp -s $i.orig $i.new || exit
    rm -f $i.new
    echo $PRELINK -y $i \> $i.new
    $RUN_HOST $PRELINK -y $i > $i.new || exit
    cmp -s $i.orig $i.new || exit
    rm -f $i.new
  done
}
