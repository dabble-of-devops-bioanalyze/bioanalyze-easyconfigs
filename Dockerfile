FROM condaforge/mambaforge

RUN bash -c "conda install -y notebook ipython pip prefect>=2; pip install easybuild>=4,<5 prefect-aws"
