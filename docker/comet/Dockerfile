FROM --platform=amd64 ubuntu:24.04

ARG COMET_VERSION=v2024.01.0

ENV DEBIAN_FRONTEND noninteractive
ENV COMET_VERSION=${COMET_VERSION}

RUN apt-get update -y \
    && apt-get install -y curl \
    && apt-get clean

COPY ../entrypoint.sh /usr/local/bin

# install comet
RUN curl -L -o /usr/local/bin/comet https://github.com/UWPR/Comet/releases/download/${COMET_VERSION}/comet.linux.exe \
    && chmod +x /usr/local/bin/comet

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]