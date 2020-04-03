
FROM centos:7

MAINTAINER "mr.AlexZT" 

RUN yum install -y epel-release && \
    yum install -y certbot docker-registry cronie

ADD entrypoint.sh /entrypoint.sh

VOLUME /etc/letsencrypt/live
VOLUME /var/lib/registry
VOLUME /auth/htpasswd
VOLUME /home

ENV JELASTIC_EXPOSE="DISABLED"

