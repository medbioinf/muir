FROM --platform=amd64 mambaorg/micromamba:1.5.8-noble

WORKDIR /home/mambauser

COPY --chown=mambauser:mambauser environment.yml .
COPY ./container.sh ./container.sh

# install and setup of micromamba and openms
USER mambauser
ENV HOME /home/mambauser
ENV ENV_NAME=openms

RUN echo 'show_banner: false' > ~/.mambarc

RUN micromamba env create -y -f environment.yml \
    && micromamba clean --all --yes

USER root

# install Percolator and dependencies
RUN apt-get update -y \
    && apt-get install -y curl libgomp1 \
    && apt-get clean

RUN . ./container.sh \
    && curl -L -o /tmp/percolator.deb https://github.com/percolator/percolator/releases/download/${PERCOLATOR_REL_VERSION}/percolator-v${PERCOLATOR_SHORT_VERSION}-linux-amd64.deb \
    && dpkg -i /tmp/percolator.deb \
    && apt-get install -f -y \
    && rm -rf /tmp/percolator.deb \
    && apt-get clean

# First is necessary for base_image to activate the conda environment second is entrypoint
# which adds the python file to PATH
ENTRYPOINT [ "/usr/local/bin/_entrypoint.sh"]
