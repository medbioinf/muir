FROM ubuntu:noble-20250716

COPY --chmod=755 ./entrypoint.sh /usr/local/bin

ARG DOWNLOAD_URL

# install comet and make executable
ADD ${DOWNLOAD_URL} /usr/local/bin/
RUN chmod +x /usr/local/bin/comet.linux.exe \
    && ln -sf /usr/local/bin/comet.linux.exe /usr/local/bin/comet

# setting entrypoint
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]