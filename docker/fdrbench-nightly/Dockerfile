FROM maven:3-eclipse-temurin-21 AS build

COPY ./container.sh ./container.sh

RUN . ./container.sh \
    # clone repo and checkout given commit
    && git clone https://github.com/Noble-Lab/FDRBench.git fdrbench \
    && cd fdrbench \
    && git checkout $FDRBENCH_VERSION \
    # correct IDs for JFASTA
    && sed -i 's;<groupId>JFASTA</groupId>;<groupId>net.sf.jfasta</groupId>;g' pom.xml \
    && sed -i 's;<artifactId>JFASTA</artifactId>;<artifactId>jfasta</artifactId>;g' pom.xml \
    # compile
    && mvn install \
    # get rid of the version number in the directory and jar name
    && mv target/fdrbench-* target/fdrbench \
    && mv target/fdrbench/fdrbench-*.jar target/fdrbench/fdrbench.jar


FROM eclipse-temurin:21-alpine

# copy build target into clean JRE-only container
COPY --from=build /fdrbench/target/fdrbench /opt/fdrbench

COPY ./container.sh ./container.sh

RUN . ./container.sh \
    && apk add --no-cache bash

CMD ["java", "-jar", "/opt/fdrbench/fdrbench.jar"]
