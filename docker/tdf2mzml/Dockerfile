FROM mambaorg/micromamba:2.3.1-ubuntu24.04

# Copy environment.yml and requirements.txt
COPY --chown=mambauser:mambauser environment.yml /home/mambauser/
COPY --chown=mambauser:mambauser requirements.txt /home/mambauser/

# setup of micromamba
USER mambauser
ENV HOME=/home/mambauser
ENV ENV_NAME=tdf2mzml
WORKDIR /home/mambauser

RUN echo 'show_banner: false' > ~/.mambarc \
    && micromamba env create -y -f /home/mambauser/environment.yml \
    && micromamba clean --all --yes

# fixing the libgomp linking problem, as it is installed via conda
ENV LD_LIBRARY_PATH=/opt/conda/envs/tdf2mzml/lib:/usr/lib/x86_64-linux-gnu/

# install / tdf2mzml
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN git clone --branch 0.4 https://github.com/mafreitas/tdf2mzml.git /tmp/tdf2mzml \
    && pip install /tmp/tdf2mzml \
    && rm -rf /tmp/tdf2mzml

# First is necessary for base_image to activate the conda environment second is entrypoint
# which adds the python file to PATH
ENTRYPOINT [ "/usr/local/bin/_entrypoint.sh"]