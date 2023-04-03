FROM condaforge/mambaforge

COPY ./docking-1.0.yml ./
RUN mamba env create -f docking-1.0.yml && mamba clean -y --all
ENV PATH=/opt/conda/envs/docking/bin/:$PATH

