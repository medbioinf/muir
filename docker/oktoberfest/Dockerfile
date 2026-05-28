FROM mambaorg/micromamba:2.6.0-ubuntu24.04

# Copy environment.yml and requirements.txt
COPY --chown=mambauser:mambauser environment.yml /home/mambauser/
COPY --chown=mambauser:mambauser requirements.txt /home/mambauser/

# install and setup of micromamba for oktoberfest
USER mambauser
ENV HOME=/home/mambauser
ENV ENV_NAME=oktoberfest
ENV LD_LIBRARY_PATH=/opt/conda/envs/oktoberfest/lib
ENV MPLCONFIGDIR=/tmp/matplotlib
ENV NUMBA_CACHE_DIR=/tmp/numba_cache

RUN echo 'show_banner: false' > ~/.mambarc \
    && micromamba env create -y -f /home/mambauser/environment.yml \
    && micromamba clean --all --yes

# First is necessary for base_image to activate the conda environment second is entrypoint
# which adds the python file to PATH
ENTRYPOINT [ "/usr/local/bin/_entrypoint.sh"]
