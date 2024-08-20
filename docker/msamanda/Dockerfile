FROM --platform=amd64 ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive

COPY ./entrypoint.sh /usr/local/bin
COPY ./container.sh ./container.sh

# install msamanda and dependencies
RUN apt-get update -y \
    && apt-get install -y curl libicu-dev \
    && apt-get clean

RUN . ./container.sh \
    && curl -L -o /tmp/msamanda.tar.gz https://ms.imp.ac.at/index.php?file=msamanda/MSAmanda_Linux_${MSAMANDA_VERSION}.tar.gz \
    && cd /tmp/ \
    && tar xf msamanda.tar.gz \
    && mv /tmp/MSAmanda*/* /usr/local/bin/ \
    && rm -rf /tmp/msamanda.tar.gz /tmp/MSAmanda*

# setting entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]