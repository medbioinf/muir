FROM eclipse-temurin:21-alpine

COPY ./container.sh ./container.sh

RUN . ./container.sh \
    # download and install fdrbench
    && wget -q -O fdrbench-${CONTAINER_VERSION}.zip https://github.com/Noble-Lab/FDRBench/releases/download/v${CONTAINER_VERSION}/fdrbench-${CONTAINER_VERSION}.zip \
    && unzip fdrbench-${CONTAINER_VERSION}.zip -d /opt \
    # rename the directory to get rid of the version number
    && mv /opt/fdrbench-${CONTAINER_VERSION} /opt/fdrbench \
    && mv /opt/fdrbench/fdrbench-${CONTAINER_VERSION}.jar /opt/fdrbench/fdrbench.jar \
    # clean up
    && rm -f fdrbench-${CONTAINER_VERSION}.zip \
    # install bash
    && apk add --no-cache bash

    CMD ["java", "-jar", "/opt/fdrbench/fdrbench.jar"]
