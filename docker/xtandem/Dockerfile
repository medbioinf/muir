FROM quay.io/medbioinf/alpine-bash:3.22.1 AS unzip

ARG XTANDEM_VERSION

# download and unzip X!Tandem
RUN wget -O /tmp/tandem.zip ftp://ftp.thegpm.org/projects/tandem/source/tandem-linux-${XTANDEM_VERSION}.zip \
    && unzip /tmp/tandem.zip tandem-linux-${XTANDEM_VERSION}/bin/static_link_ubuntu/tandem.exe -d /tmp/ \
    && mv /tmp/tandem-linux-${XTANDEM_VERSION}/bin/static_link_ubuntu/tandem.exe /tmp/tandem.exe  \
    && rm /tmp/tandem.zip

FROM ubuntu:noble-20250716

COPY --chmod=755 ./entrypoint.sh /usr/local/bin
COPY --from=unzip --chmod=755 /tmp/tandem.exe /usr/local/bin/tandem.exe

RUN ln -sf /usr/local/bin/tandem.exe /usr/local/bin/tandem

# setting entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]