FROM --platform=amd64 eclipse-temurin:21 AS jre-build

# Create a custom Java runtime
RUN $JAVA_HOME/bin/jlink \
         --add-modules java.base \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime

# Define the base image
FROM --platform=amd64 alpine:3.20.1
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH "${JAVA_HOME}/bin:${PATH}"
COPY --from=jre-build /javaruntime $JAVA_HOME

# copy over container information
COPY ./container.sh ./container.sh

# install MS-GF+ and bash
RUN . ./container.sh \
    && wget -q -O /tmp/msgfplus.zip https://github.com/MSGFPlus/msgfplus/releases/download/${CONTAINER_VERSION}/MSGFPlus_${MSGFPLUS_VERSION}.zip \
    && mkdir /opt/msgfplus \
    && unzip /tmp/msgfplus.zip MSGFPlus.jar -d /opt/msgfplus \
    && apk add --no-cache bash \
    && rm -rf /var/lib/apt/lists/*

CMD ["java", "-jar", "/opt/msgfplus/MSGFPlus.jar"]
