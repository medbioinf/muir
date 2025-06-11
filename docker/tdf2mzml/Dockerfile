FROM mambaorg/micromamba:2.1.1-ubuntu22.04

WORKDIR /home/mambauser
# Copy environment.yml and requirements.txt
COPY --chown=mambauser:mambauser environment.yml .
COPY --chown=mambauser:mambauser requirements.txt .

# installing dependencies
USER root
RUN apt update -y \
    && apt install -y libgomp1 procps \
    && apt clean

# setup of micromamba
USER mambauser
ENV HOME=/home/mambauser
ENV ENV_NAME=tdf2mzml

RUN echo 'show_banner: false' > ~/.mambarc \
    && micromamba env create -y -f environment.yml \
    && micromamba clean --all --yes

# install / tdf2mzml
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN git clone --branch "${TDF2MZML_VERSION}" https://github.com/mafreitas/tdf2mzml.git /tmp/tdf2mzml \
    && pip install /tmp/tdf2mzml \
    && rm -rf /tmp/tdf2mzml

# First is necessary for base_image to activate the conda environment second is entrypoint
# which adds the python file to PATH
ENTRYPOINT [ "/usr/local/bin/_entrypoint.sh"]