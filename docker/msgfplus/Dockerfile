FROM --platform=amd64 eclipse-temurin:21-alpine

# copy over container information
COPY ./container.sh ./container.sh

# install MS-GF+ and bash
RUN . ./container.sh \
    && wget -q -O /tmp/msgfplus.zip https://github.com/MSGFPlus/msgfplus/releases/download/${CONTAINER_VERSION}/MSGFPlus_${MSGFPLUS_VERSION}.zip \
    && mkdir /opt/msgfplus \
    && unzip /tmp/msgfplus.zip -d /opt/msgfplus

CMD ["java", "-jar", "/opt/msgfplus/MSGFPlus.jar"]
