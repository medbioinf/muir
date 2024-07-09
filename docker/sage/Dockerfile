FROM --platform=amd64 alpine:3.20.1

ENV DEBIAN_FRONTEND noninteractive

COPY ./entrypoint.sh /usr/local/bin
COPY ./container.sh ./container.sh

# install sage
RUN . ./container.sh \
    && wget -q -O /tmp/sage.tar.gz https://github.com/lazear/sage/releases/download/${SAGE_VERSION}/sage-${SAGE_VERSION}-x86_64-unknown-linux-musl.tar.gz \
    && tar -x --strip-components 1 -C /usr/local/bin -f /tmp/sage.tar.gz sage-${SAGE_VERSION}-x86_64-unknown-linux-musl/sage \
    && rm -rf  /tmp/sage.tar.gz \
    && chmod +x /usr/local/bin/sage

# setting entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]