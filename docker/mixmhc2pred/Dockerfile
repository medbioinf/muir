FROM --platform=amd64 ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive

COPY ./entrypoint.sh /usr/local/bin
COPY ./container.sh ./container.sh

# install Percolator and dependencies
RUN apt-get update -y \
    && apt-get install -y curl unzip \
    && apt-get clean

RUN . ./container.sh \
    && curl -L -o /tmp/mixmhc2pre.zip https://github.com/GfellerLab/MixMHC2pred/releases/download/${MIXMHC2PRED_VERSION}/MixMHC2pred-${MIXMHC2PRED_SHORTVERSION}.zip \
    && unzip /tmp/mixmhc2pre.zip -d /usr/local/bin/ \
    && rm /tmp/mixmhc2pre.zip  \
    && ln -sf /usr/local/bin/MixMHC2pred_unix /usr/local/bin/MixMHC2pred

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]