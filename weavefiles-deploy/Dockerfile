# VERSION 0.14
FROM ubuntu:14.04

MAINTAINER Callum Jones <callum@callumj.com>

EXPOSE 80
ENV DOMAIN callumj.com

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe multiverse" > /etc/apt/sources.list
RUN apt-get -y update

RUN apt-get install -y nginx curl
RUN rm -r -f /etc/nginx/conf.d/*

ADD boot.sh /boot.sh
ADD nginx.conf /etc/nginx/app.conf

RUN chmod +x boot.sh

CMD /bin/bash "/boot.sh"
