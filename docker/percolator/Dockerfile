FROM --platform=amd64 ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive

COPY ./entrypoint.sh /usr/local/bin
COPY ./container.sh ./container.sh

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

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]