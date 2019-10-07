FROM openjdk:8-jre-alpine
ENV AOZORA_EPUB3 AozoraEpub3-1.1.0b46.zip
ENV KINDLEGEN kindlegen_linux_2.6_i386_v2_9.tar.gz
ENV NAROU_VERSION 3.4.7.1
WORKDIR /opt/narou

RUN apk --update add ruby ruby-io-console ruby-json wget unzip && rm -rf /var/cache/apk/*

RUN wget https://github.com/jam7/AozoraEpub3/releases/download/1.1.0b46/${AOZORA_EPUB3} -O /opt/AozoraEpub3.zip
RUN wget https://github.com/jam7/AozoraEpub3/releases/download/openjdk-support/AozoraEpub3.jar -O /opt/AozoraEpub3.jar

RUN wget http://kindlegen.s3.amazonaws.com/${KINDLEGEN} && \
    mkdir -p /opt/kindlegen && \
    tar zxf ${KINDLEGEN} -C /opt/kindlegen && \
    rm ${KINDLEGEN}

#COPY narou-${NAROU_VERSION}.gem .
RUN apk add --no-cache --virtual .ruby-builddeps build-base libffi-dev ruby-dev && \
    gem install narou -v ${NAROU_VERSION} --no-document && \
    apk del .ruby-builddeps

COPY init.sh /usr/local/bin

WORKDIR /opt/narou/work

ENTRYPOINT ["init.sh"]
CMD ["narou"]
