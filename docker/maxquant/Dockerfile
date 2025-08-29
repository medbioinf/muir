FROM mambaorg/micromamba:2.3.1-ubuntu24.04

ARG DOWNLOAD_URL
ADD --chown=mambauser:mambauser ${DOWNLOAD_URL} /tmp/maxquant.zip
COPY --chown=mambauser:mambauser environment.yml /home/mambauser/

# setup of micromamba
USER mambauser
ENV HOME=/home/mambauser
ENV ENV_NAME=maxquant
WORKDIR /home/mambauser
RUN echo 'show_banner: false' > ~/.mambarc \
    && micromamba env create -y -f /home/mambauser/environment.yml \
    && micromamba clean --all --yes

# install / unzip MaxQuant
USER root
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN unzip /tmp/maxquant.zip -d /opt/ \
    && ln -s /opt/MaxQuant* /opt/MaxQuant \
    && rm -rf maxquant.zip

USER mambauser

# Entrypoint for micromamba
ENTRYPOINT [ "/usr/local/bin/_entrypoint.sh"]