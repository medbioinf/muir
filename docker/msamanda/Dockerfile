FROM ubuntu:noble-20250716

ARG DOWNLOAD_URL
COPY --chmod=755 ./entrypoint.sh /usr/local/bin
ADD --chown=mambauser:mambauser ${DOWNLOAD_URL} /tmp/msamanda.tar.gz

# install msamanda
WORKDIR /tmp
RUN tar xf msamanda.tar.gz \
    && mv /tmp/MSAmanda*/* /usr/local/bin/ \
    && rm -rf /tmp/msamanda.tar.gz /tmp/MSAmanda*

# setting entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]