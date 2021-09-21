# ETL notebook Dockerfile
FROM jupyter/scipy-notebook:latest

# install unrar library 
USER root
RUN apt-get -q update && \
    apt-get install -yq --no-install-recommends \
    unrar && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# install needed libraries
USER jovyan
RUN pip install --quiet --no-cache-dir \
    'papermill' 'rarfile' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
