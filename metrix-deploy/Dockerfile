# VERSION 0.18
FROM ubuntu:14.04

MAINTAINER Callum Jones <callum@callumj.com>

EXPOSE 8080 6379
ENV DOMAIN metrix.callumj.com

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe multiverse" > /etc/apt/sources.list
RUN apt-get -y update

RUN apt-get install -y redis-server golang git
RUN mkdir -p /opt/go
RUN mkdir /app
RUN mkdir /redis_data

ADD boot.sh /boot.sh
ADD go.sh /etc/profile.d/go.sh
ADD redis.conf /etc/redis.conf
ADD metrix.yml /etc/metrix.yml

RUN chmod +x boot.sh

CMD /bin/bash "/boot.sh"
