FROM quay.io/medbioinf/eclipse-temurin-alpine-bash:21.0.8_9-jre

ARG DOWNLOAD_URL
ADD ${DOWNLOAD_URL} /tmp/msgfplus.zip

# install MS-GF+
RUN mkdir /opt/msgfplus \
    && unzip /tmp/msgfplus.zip -d /opt/msgfplus \
    && rm /tmp/msgfplus.zip

CMD ["java", "-jar", "/opt/msgfplus/MSGFPlus.jar"]