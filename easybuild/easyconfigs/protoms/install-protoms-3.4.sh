#!/usr/bin/env bash


export PATH=${INSTALLDIR}/bin:$PATH
cd /tmp 
wget https://github.com/essex-lab/ProtoMS/archive/refs/tags/release_3.4.tar.gz
tar -xvf release_3.4.tar.gz

cd ProtoMS-release_3.4

export FFLAGS="$FFLAGS -fallow-argument-mismatch -std=legacy"
export CXXFLAGS="$CXXFLAGS -fallow-argument-mismatch -std=legacy"
export CFLAGS="$CFLAGS -fallow-argument-mismatch -std=legacy"
export FORTRANFLAGS="$FORTRANFLAGS -fallow-argument-mismatch -std=legacy"
rm -rf build
mkdir build
cd build
cmake ..
make install
cd ..
${INSTALLDIR}/bin/pip install -r requirements.txt

