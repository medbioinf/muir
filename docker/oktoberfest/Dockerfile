FROM mambaorg/micromamba:2.5.0-ubuntu24.04

# Copy environment.yml and requirements.txt
COPY --chown=mambauser:mambauser environment.yml /home/mambauser/
COPY --chown=mambauser:mambauser requirements.txt /home/mambauser/

# install dependencies for oktoberfest
# TODO: check whether this is still needed - git can probably be removed when psm_utils is merged
USER root
RUN apt update \
    && apt install -y libglib2.0-0 git \
    && apt clean

# install and setup of micromamba for psm-utils
USER mambauser
ENV HOME=/home/mambauser
ENV ENV_NAME=oktoberfest

RUN echo 'show_banner: false' > ~/.mambarc \
    && micromamba env create -y -f /home/mambauser/environment.yml \
    && micromamba clean --all --yes

# First is necessary for base_image to actvate the conda environment second is entrypoint
# which adds the python file to PATH
ENTRYPOINT [ "/usr/local/bin/_entrypoint.sh"]
