FROM condaforge/mambaforge

COPY ./openbabel-3.1.1.yml ./
RUN mamba env create -f openbabel-3.1.1.yml && mamba clean -y --all
