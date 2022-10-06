#!/usr/bin/env bash

export CUDA=11.1.1
echo "Installing alphafold to: ${INSTALLDIR}"
env |grep EASY

CURDIR=$(pwd)

${INSTALLDIR}/bin/pip3 install --upgrade \
      jax==0.2.14 \
      jaxlib==0.1.69+cuda$(cut -f1,2 -d. <<< ${CUDA} | sed 's/\.//g') \
      -f https://storage.googleapis.com/jax-releases/jax_releases.html

wget -q -P ${INSTALLDIR}/lib/python3.7/site-packages/lib/python3.7/site-packages/alphafold/common/ \
  https://git.scicore.unibas.ch/schwede/openstructure/-/raw/7102c63615b64735c4941278d92b554ec94415f8/modules/mol/alg/src/stereo_chemical_props.txt

# Apply OpenMM patch.
pushd ${INSTALLDIR}/lib/python3.7/site-packages/ && \
    patch -p0 < ${CURDIR}/alphafold-2.2.2/docker/openmm.patch && \
    popd

exit 0
