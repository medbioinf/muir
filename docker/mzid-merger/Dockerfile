FROM mambaorg/micromamba:2.1.1-ubuntu22.04

WORKDIR /home/mambauser
# Copy environment.yml
COPY --chown=mambauser:mambauser environment.yml .

ADD --chown=mambauser:mambauser https://github.com/PNNL-Comp-Mass-Spec/MzidMerger/releases/download/v1.4.26/MzidMerger.zip /tmp/MzidMerger.zip

# setup of micromamba
USER mambauser
ENV HOME=/home/mambauser
ENV ENV_NAME=mzidmerger

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
