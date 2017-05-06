FROM openjdk:8-jre-alpine
ENV AOZORA_EPUB3 AozoraEpub3-1.1.0b46.zip
ENV KINDLEGEN kindlegen_linux_2.6_i386_v2_9.tar.gz
ENV NAROU_VERSION 3.1.1
WORKDIR /opt/narou

RUN apk --update add ruby ruby-io-console ruby-json wget unzip && rm -rf /var/cache/apk/*

RUN wget https://github.com/jam7/AozoraEpub3/releases/download/1.1.0b46/${AOZORA_EPUB3} -O /opt/AozoraEpub3.zip

RUN wget http://kindlegen.s3.amazonaws.com/${KINDLEGEN} && \
    mkdir -p /opt/kindlegen && \
    tar zxf ${KINDLEGEN} -C /opt/kindlegen && \
    rm ${KINDLEGEN}

COPY narou-3.1.1.gem .
RUN gem install narou -v ${NAROU_VERSION} --no-document

COPY init.sh /usr/local/bin

ENTRYPOINT ["init.sh"]
CMD ["narou", "web", "-p", "8000", "-n"]
