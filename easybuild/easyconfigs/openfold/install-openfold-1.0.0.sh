#!/usr/bin/env bash

export CUDA=11.1.1
echo "Installing alphafold to: ${INSTALLDIR}"
env |grep EASY

CURDIR=$(pwd)

wget https://github.com/aqlaboratory/openfold/archive/refs/tags/v1.0.0.tar.gz
tar -xvf v1.0.0.tar.gz
cd openfold-1.0.0

${INSTALLDIR}/bin/python setup.py install
${INSTALLDIR}/bin/pip install ipython ipykernel
chmod 777 scripts/*
cp -rf scripts/* ${INSTALLDIR}/bin/

exit 0
