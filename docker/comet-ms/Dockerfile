FROM --platform=amd64 ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
    && apt-get install -y curl \
    && apt-get clean

COPY ./container.sh ./container.sh
COPY ./entrypoint.sh /usr/local/bin

# install comet
RUN ./container.sh \
    && curl -L -o /usr/local/bin/comet https://github.com/UWPR/Comet/releases/download/${COMET_VERSION}/comet.linux.exe \
    && chmod +x /usr/local/bin/comet

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]