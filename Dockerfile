FROM debian:wheezy
MAINTAINER Tim Haak <tim@haak.co.uk>
#Thanks to https://github.com/bydavy/docker-plex/blob/master/Dockerfile and https://github.com/aostanin/docker-plex/blob/master/Dockerfile

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get -q update
RUN apt-get -qy --force-yes dist-upgrade

RUN apt-get install -qy --force-yes curl

RUN echo "deb http://shell.ninthgate.se/packages/debian squeeze main" > /etc/apt/sources.list.d/plexmediaserver.list

RUN curl http://shell.ninthgate.se/packages/shell-ninthgate-se-keyring.key | apt-key add -

RUN apt-get -q update

RUN apt-get install -qy --force-yes plexmediaserver

# apt clean
RUN apt-get clean &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf /tmp/*

VOLUME /config
VOLUME /data

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 32400

CMD ["/start.sh"]
