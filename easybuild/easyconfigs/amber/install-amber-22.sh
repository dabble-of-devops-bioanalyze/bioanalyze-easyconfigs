#!/usr/bin/env bash

export PATH=${INSTALLDIR}/bin:$PATH

./configure_cmake.py \
  --prefix ${PREFIX} \
  --noX11 \
  --mpi \
  --no-updates

make install

cp -rf * ${INSTALLDIR}/bin/
