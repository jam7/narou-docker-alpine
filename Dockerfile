FROM adoptopenjdk/openjdk8:alpine-slim
LABEL maintainer "Kazushi (Jam) Marukawa <jam@pobox.com>"

ENV NAROU_VERSION 3.8.0
WORKDIR /opt/narou

RUN apk --update add --no-cache ruby ruby-io-console ruby-json ruby-etc ca-certificates curl unzip docker-cli su-exec

#COPY narou-${NAROU_VERSION}.gem .
RUN apk add --no-cache --virtual .ruby-builddeps build-base libffi-dev ruby-dev && \
    gem install narou -v ${NAROU_VERSION} --no-document && \
    apk del .ruby-builddeps

COPY entrypoint.sh /narou/
COPY init.sh /narou/
COPY kindlegen.sh /narou/
COPY narou.sh /narou/

ENTRYPOINT ["/narou/entrypoint.sh"]
