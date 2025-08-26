FROM quay.io/medbioinf/alpine-bash:3.22.1 AS unzip

ARG DOWNLOAD_URL
ADD ${DOWNLOAD_URL} /tmp/mixmhc2pred.zip

# unzip MixMHC2pred
RUN mkdir /opt/mixmhc2pred \
    && unzip /tmp/mixmhc2pred.zip -d /opt/mixmhc2pred \
    && rm /tmp/mixmhc2pred.zip


FROM ubuntu:noble-20250716

COPY --chmod=755 ./entrypoint.sh /usr/local/bin

COPY --from=unzip /opt/mixmhc2pred /usr/local/bin/

# install Percolator and dependencies
RUN ln -sf /usr/local/bin/MixMHC2pred_unix /usr/local/bin/MixMHC2pred

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]