FROM dkay/registry:latest

ADD start.sh /start.sh
ADD entrypoint.sh /entrypoint.sh

EXPOSE 80


