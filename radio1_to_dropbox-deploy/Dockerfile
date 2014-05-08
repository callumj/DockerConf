FROM ubuntu:14.04

MAINTAINER Callum Jones <callum@callumj.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe multiverse" > /etc/apt/sources.list
RUN apt-get -y update

RUN mkdir -p /temp/ruby
RUN apt-get install -y build-essential libssl-dev zlib1g-dev libxml2-dev libxslt-dev
RUN apt-get install -y wget git openssh-client libpq-dev
RUN apt-get install -y autoconf automake build-essential libass-dev libgpac-dev
RUN apt-get install -y libxext-dev pkg-config zlib1g-dev libmp3lame-dev
RUN apt-get install -y rtmpdump libgpac-dev pkg-config libtool libfaac-dev

WORKDIR /temp
RUN mkdir /temp/ffmpeg_sources
RUN mkdir /temp/ffmpeg_build

WORKDIR /temp/ffmpeg_sources
RUN wget -q http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz -O /temp/yasm.tgz

RUN mkdir /temp/ffmpeg_sources/yasm
RUN tar zxvf /temp/yasm.tgz --strip=1 -C /temp/ffmpeg_sources/yasm
WORKDIR /temp/ffmpeg_sources/yasm
RUN ./configure --prefix="/temp/ffmpeg_build" --bindir="/bin"
RUN make
RUN make install
RUN make distclean

WORKDIR /temp/ffmpeg_sources
RUN wget -q http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 -O /temp/ffmpeg.tar.bz

RUN mkdir /temp/ffmpeg_sources/ffmpeg
RUN tar xjvf /temp/ffmpeg.tar.bz --strip=1 -C /temp/ffmpeg_sources/ffmpeg
WORKDIR /temp/ffmpeg_sources/ffmpeg
RUN ./configure --prefix="/temp/ffmpeg_build" --extra-cflags="-I/temp/ffmpeg_build/include" --extra-ldflags="-L/temp/ffmpeg_build/lib" --bindir="/bin" --extra-libs="-ldl" --enable-libmp3lame --enable-libfaac --enable-gpl --enable-nonfree
RUN make
RUN make install
RUN make distclean

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

RUN mkdir /radio1_to_dropbox
RUN git clone git@github.com:callumj/radio1_to_dropbox.git /radio1_to_dropbox
WORKDIR /radio1_to_dropbox
RUN bundle install

RUN echo "cd /radio1_to_dropbox" > /boot.sh
RUN echo "git pull origin master" >> /boot.sh
RUN echo "bundle install" >> /boot.sh
ADD boot.sh /boot.sh
RUN chmod +x /boot.sh

WORKDIR /
CMD /bin/sh -c "./boot.sh"
