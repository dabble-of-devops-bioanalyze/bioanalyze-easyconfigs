#!/usr/bin/env bash

export CUDA=11.1.1
echo "Installing alphafold to: ${INSTALLDIR}"
env |grep EASY

CURDIR=$(pwd)
ALPHAFOLD="https://github.com/deepmind/alphafold/archive/refs/tags/v2.2.2.tar.gz"

wget $ALPHAFOLD
tar -xvf v2.2.2.tar.gz

cd alphafold-2.2.2
#${INSTALLDIR}/bin/pip3 install -r ./alphafold-2.2.2-requirements.txt
${INSTALLDIR}/bin/pip3 install -r ./requirements.txt

${INSTALLDIR}/bin/pip3 install --upgrade \
      jax==0.2.14 \
      jaxlib==0.1.69+cuda$(cut -f1,2 -d. <<< ${CUDA} | sed 's/\.//g') \
      -f https://storage.googleapis.com/jax-releases/jax_releases.html

# Run setup.py to install only AlphaFold.
${INSTALLDIR}/bin/pip3 install --no-dependencies ./
${INSTALLDIR}/bin/pip3 install pydantic rich-click click "typer[all]"
# this messes up the alphafold 2.2.2 installation

wget -q -P ${INSTALLDIR}/lib/python3.7/site-packages/lib/python3.7/site-packages/alphafold/common/ \
  https://git.scicore.unibas.ch/schwede/openstructure/-/raw/7102c63615b64735c4941278d92b554ec94415f8/modules/mol/alg/src/stereo_chemical_props.txt

# Apply OpenMM patch.
pushd ${INSTALLDIR}/lib/python3.7/site-packages/ && \
    patch -p0 < ${CURDIR}/alphafold-2.2.2/docker/openmm.patch && \
    popd

exit 0
