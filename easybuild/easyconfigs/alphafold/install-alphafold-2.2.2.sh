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
# this messes up the alphafold 2.2.2 installation
# need to find out which versions of alphafold are pinned to which versions of colabfold
#${INSTALLDIR}/bin/pip3 install -q --no-warn-conflicts "colabfold[alphafold-minus-jax] @ git+https://github.com/sokrypton/ColabFold"

  # high risk high gain
#${INSTALLDIR}/bin/pip install -q "jax[cuda11_cudnn805]>=0.3.8,<0.4" -f https://storage.googleapis.com/jax-releases/jax_releases.html
#${INSTALLDIR}/bin/pip install --force "jax[cuda11_cudnn805]>=0.3,<0.4" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html


# Apply OpenMM patch.
pushd ${INSTALLDIR}/lib/python3.7/site-packages/ && \
    patch -p0 < ${CURDIR}/alphafold-2.2.2/docker/openmm.patch && \
    popd

${INSTALLDIR}/bin/pip install prefect>=2 \
  prefect-aws \
  prefect-shell \
  prefect-dask

exit 0
