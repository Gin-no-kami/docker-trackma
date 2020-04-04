FROM python:3.5-buster

LABEL maintainer Gin-no-kami <frosty5689@gmail.com>

RUN apt-get update \
 && apt-get install -y ca-certificates tzdata \
 && update-ca-certificates \
 && pip install --upgrade --no-cache-dir setuptools pyinotify envparse \
 && rm -rf /root/.cache

ARG TRACKMA_VERSION=v0.8.2

RUN apt-get update && apt-get install -y bash

RUN apt-get update && apt-get install -y build-dependencies wget unzip && \
    wget -O /tmp/trackma-$TRACKMA_VERSION.zip https://github.com/z411/trackma/archive/$TRACKMA_VERSION.zip && \
    ls -l /tmp && \
    mkdir -p /opt && \
    unzip /tmp/trackma-$TRACKMA_VERSION.zip -d /opt && \
    mv /opt/trackma* /opt/trackma &&\
    cd /opt/trackma && \
    python3 setup.py install && \
    rm -rf /tmp/trackma-$TRACKMA_VERSION.zip && \
    apt-get remove build-dependencies

ADD run/* /opt/trackma/

VOLUME /config

WORKDIR /opt/trackma

CMD ["/opt/trackma/start.sh"]
