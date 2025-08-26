FROM mambaorg/micromamba:2.3.1-ubuntu24.04

COPY --chown=mambauser:mambauser environment.yml /home/mambauser/

# install and setup of micromamba for openms
USER mambauser
ENV HOME=/home/mambauser
ENV ENV_NAME=openms

RUN echo 'show_banner: false' > ~/.mambarc \
    && micromamba env create -y -f /home/mambauser/environment.yml \
    && micromamba clean --all --yes

# First is necessary for base_image to activate the conda environment second is entrypoint
# which adds the python file to PATH
ENTRYPOINT [ "/usr/local/bin/_entrypoint.sh"]