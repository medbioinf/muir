FROM mambaorg/micromamba:2.3.1-ubuntu24.04

ARG DOWNLOAD_URL
ADD --chown=mambauser:mambauser ${DOWNLOAD_URL} /tmp/MzidMerger.zip
COPY --chown=mambauser:mambauser environment.yml /home/mambauser/

# setup of micromamba
USER mambauser
ENV HOME=/home/mambauser
ENV ENV_NAME=mzidmerger
WORKDIR /home/mambauser
RUN echo 'show_banner: false' > ~/.mambarc \
    && micromamba env create -y -f environment.yml \
    && micromamba clean --all --yes

# install / unzip mzid-merger
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN unzip /tmp/MzidMerger.zip \
    && mv net48 /home/mambauser/mzidmerger \
    && rm -r /tmp/MzidMerger.zip Readme.md environment.yml net472 net8.0

# First is necessary for base_image to actvate the conda environment second is entrypoint
# which adds the python file to PATH
ENTRYPOINT [ "/usr/local/bin/_entrypoint.sh"]
