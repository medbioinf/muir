FROM quay.io/medbioinf/alpine-bash:3.22.1

ARG DOWNLOAD_URL
ARG SAGE_VERSION
ADD ${DOWNLOAD_URL} /tmp/sage.tar.gz
COPY --chmod=755 ./entrypoint.sh /usr/local/bin

# install sage and bash
RUN tar -x --strip-components 1 -C /usr/local/bin -f /tmp/sage.tar.gz sage-${SAGE_VERSION}-x86_64-unknown-linux-musl/sage \
    && rm -rf  /tmp/sage.tar.gz \
    && chmod +x /usr/local/bin/sage

# setting entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]