# VERSION 0.13
FROM ubuntu:14.04

MAINTAINER Callum Jones <callum@callumj.com>

EXPOSE 8080 6379
ENV DOMAIN metrix.callumj.com

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe multiverse" > /etc/apt/sources.list
RUN apt-get -y update

RUN apt-get install -y redis-server
RUN mkdir -p /opt/go
RUN mkdir /app

ADD boot.sh /boot.sh
ADD go.sh /etc/profile.d/go.sh
ADD redis.conf /etc/redis/redis.conf
ADD metrix.yml /etc/metrix.yml

RUN chmod +x boot.sh

CMD /bin/bash "/boot.sh"
