
FROM centos:7

MAINTAINER "mr.AlexZT" 

RUN yum install -y epel-release && \
    yum install -y certbot docker-registry cronie openssh-server logrotate file net-tools

ADD entrypoint.sh /entrypoint.sh
ADD letsencryptrenewal.sh /letsencryptrenewal.sh

VOLUME /etc/letsencrypt/live
VOLUME /var/lib/registry
VOLUME /auth
VOLUME /home

ENV JELASTIC_EXPOSE="DISABLED"

