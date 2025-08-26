FROM quay.io/medbioinf/eclipse-temurin-alpine-bash:21.0.8_9-jre

ARG DOWNLOAD_URL
ARG CONTAINER_VERSION

ADD ${DOWNLOAD_URL} /tmp/

RUN unzip /tmp/fdrbench-${CONTAINER_VERSION}.zip -d /opt \
    # rename the directory to get rid of the version number
    && mv /opt/fdrbench-${CONTAINER_VERSION} /opt/fdrbench \
    && mv /opt/fdrbench/fdrbench-${CONTAINER_VERSION}.jar /opt/fdrbench/fdrbench.jar \
    # clean up
    && rm -f /tmp/fdrbench-${CONTAINER_VERSION}.zip

    CMD ["java", "-jar", "/opt/fdrbench/fdrbench.jar"]
