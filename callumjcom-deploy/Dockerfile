# VERSION 0.06
FROM ubuntu:14.04

MAINTAINER Callum Jones <callum@callumj.com>

EXPOSE 80
ENV DOMAIN callumj.com

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe multiverse" > /etc/apt/sources.list
RUN apt-get -y update

RUN apt-get install -y npm phantomjs nginx git ruby
RUN rm -r -f /etc/nginx/conf.d/*

RUN mkdir -p /app
RUN mkdir -p /app_logs

ADD boot.sh /boot.sh
ADD nginx.conf /etc/nginx/app.conf

RUN chmod +x boot.sh

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g grunt-cli
RUN gem install sass

CMD /bin/bash "/boot.sh"
