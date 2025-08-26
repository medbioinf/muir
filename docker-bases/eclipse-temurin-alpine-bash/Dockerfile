FROM quay.io/medbioinf/alpine-bash:3.22.1

ENV JAVA_HOME=/opt/java/openjdk
COPY --from=eclipse-temurin:21.0.8_9-jre-alpine-3.22 $JAVA_HOME $JAVA_HOME
COPY --from=eclipse-temurin:21.0.8_9-jre-alpine-3.22 /__cacert_entrypoint.sh /__cacert_entrypoint.sh

ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN /bin/sh -c set -eux; \
    echo "Verifying install ..."; \
    echo "java --version"; \
java --version; \
    echo "Complete." # buildkit

ENTRYPOINT ["/__cacert_entrypoint.sh"]