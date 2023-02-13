FROM condaforge/mambaforge

COPY ./smina-2020.12.10.yml ./
RUN mamba env create -f smina-2020.12.10.yml && mamba clean -y --all
