FROM ubuntu:14.04

MAINTAINER Callum Jones <callum@callumj.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get -y update

RUN mkdir -p /temp/ruby
RUN apt-get install -y build-essential libssl-dev zlib1g-dev
RUN apt-get install -y wget git openssh-client libpq-dev

RUN wget -q http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p451.tar.gz -O /temp/ruby.tgz

RUN tar xvfz /temp/ruby.tgz --strip=1 -C /temp/ruby > /dev/null

WORKDIR /temp/ruby

RUN ./configure --disable-install-rdoc > /dev/null
RUN make > /dev/null
RUN make install > /dev/null

RUN gem install bundler

ADD ssh/ /ssh
RUN chmod -R 0600 /ssh

RUN echo "    IdentityFile /ssh/id_rsa" >> /etc/ssh/ssh_config
RUN echo "    Host github.com"
RUN echo "        StrictHostKeyChecking=no" >> /etc/ssh/ssh_config

RUN mkdir /extendeddata
RUN git clone git@github.com:callumj/extendeddata.git /extendeddata
WORKDIR /extendeddata
RUN bundle install

RUN echo "cd /extendeddata" > /boot.sh
RUN echo "git pull origin master" >> /boot.sh
RUN echo "bundle install" >> /boot.sh
RUN echo "RAILS_ENV=production clockwork clockwork.rb" >> /boot.sh
RUN chmod +x /boot.sh

WORKDIR /
CMD /bin/sh -c "./boot.sh"