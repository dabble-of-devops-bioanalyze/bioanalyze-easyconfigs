#!/usr/bin/env bash

echo "Installing alphafold to: ${INSTALLDIR}"
env |grep EASY

CURDIR=$(pwd)
ALPHAFOLD="https://github.com/deepmind/alphafold/archive/refs/tags/v2.2.2.tar.gz"

wget $ALPHAFOLD
tar -xvf v2.2.2.tar.gz

cd alphafold-2.2.2
pip3 install -r ./requirements.txt
# Run setup.py to install only AlphaFold.
pip3 install --no-dependencies ./

pip install -q --no-warn-conflicts "colabfold[alphafold-minus-jax] @ git+https://github.com/sokrypton/ColabFold"
  # high risk high gain
pip install -q "jax[cuda11_cudnn805]>=0.3.8,<0.4" -f https://storage.googleapis.com/jax-releases/jax_releases.html

# Apply OpenMM patch.
pushd ${INSTALLDIR}/lib/python3.7/site-packages/ && \
    patch -p0 < ${BUILDIR}/alphafold-2.2.2/docker/openmm.patch && \
    popd

exit 0
