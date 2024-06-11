FROM --platform=amd64 ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive

COPY ./entrypoint.sh /usr/local/bin
COPY ./container.sh ./container.sh

# install X!Tandem and dependencies
RUN apt-get update -y \
    && apt-get install -y curl unzip \
    && apt-get clean

RUN . ./container.sh \
    && curl -L -o /tmp/tandem.zip ftp://ftp.thegpm.org/projects/tandem/source/tandem-linux-${XTANDEM_VERSION}.zip \
    && unzip /tmp/tandem.zip tandem-linux-${XTANDEM_VERSION}/bin/static_link_ubuntu/tandem.exe -d /tmp/ \
    && mv /tmp/tandem-linux-${XTANDEM_VERSION}/bin/static_link_ubuntu/tandem.exe /usr/local/bin/tandem.exe  \
    && chmod a+x /usr/local/bin/tandem.exe \
    && ln -sf /usr/local/bin/tandem.exe /usr/local/bin/tandem \
    && rm -rf /tmp/tandem.zip /tmp/tandem-linux-${XTANDEM_VERSION}

# setting entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]