FROM python:3.5-buster

LABEL maintainer Gin-no-kami <frosty5689@gmail.com>

RUN apt-get update \
 && apt-get install -y ca-certificates tzdata \
 && update-ca-certificates \
 && pip install --upgrade --no-cache-dir setuptools pyinotify envparse \
 && pip3 install Trackma
 && rm -rf /root/.cache

RUN mkdir -p /opt/trackma && \
    cd /opt/trackma

ADD run/* /opt/trackma/

VOLUME /config

WORKDIR /opt/trackma

CMD ["/opt/trackma/start.sh"]
