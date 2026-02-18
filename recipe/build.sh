#!/bin/bash

set -e

# update autotools config for arm64 support
if [[ -d "${BUILD_PREFIX}/share/gnuconfig" ]]; then
  cp -f ${BUILD_PREFIX}/share/gnuconfig/config.* ${SRC_DIR}/config/
fi

mkdir -p _build
cd _build

# see https://git.ligo.org/gds/gds/-/issues/171
export CPU_COUNT=1

${SRC_DIR}/configure \
  --disable-static \
  --enable-online \
  --enable-shared \
  --includedir="${PREFIX}/include/gds" \
  --prefix="${PREFIX}" \
  --with-jsoncpp="${PREFIX}" \
;

# build
make -j ${CPU_COUNT} VERBOSE=1 V=1

# test
make -j ${CPU_COUNT} VERBOSE=1 V=1 check

# install
make -j ${CPU_COUNT} VERBOSE=1 V=1 install
