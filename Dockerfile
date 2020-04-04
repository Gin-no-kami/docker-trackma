FROM python:3-alpine

LABEL maintainer Gin-no-kami <frosty5689@gmail.com>

RUN apk add --no-cache --update \
    ca-certificates \
    tzdata \
 && update-ca-certificates \
 && pip install --upgrade --no-cache-dir setuptools pyinotify envparse \
 && rm -rf /root/.cache

ARG TRACKMA_VERSION=v0.7.6

RUN apk add --no-cache screen bash

RUN apk add --no-cache --update --virtual build-dependencies wget unzip && \
    wget -O /tmp/trackma-$TRACKMA_VERSION.zip https://github.com/z411/trackma/archive/$TRACKMA_VERSION.zip && \
    ls -l /tmp && \
    mkdir -p /opt && \
    unzip /tmp/trackma-$TRACKMA_VERSION.zip -d /opt && \
    mv /opt/trackma* /opt/trackma &&\
    cd /opt/trackma && \
    python3 setup.py install && \
    rm -rf /tmp/trackma-$TRACKMA_VERSION.zip && \
    apk del build-dependencies

ADD run/* /opt/trackma/

VOLUME /config

WORKDIR /opt/trackma

CMD ["/opt/trackma/start.sh"]
