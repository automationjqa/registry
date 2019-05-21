FROM registry:2.7.1
RUN apk add python3 python3-dev libffi-dev openssl-dev musl-dev gcc git
RUN cd /etc && git clone https://github.com/certbot/certbot.git && cd certbot && python3 tools/venv3.py

ENV REGISTRY_AUTH_HTPASSWD_PATH="/auth/htpasswd"
ENV REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm"
ENV REGISTRY_AUTH="htpasswd"

ADD start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 80
ENTRYPOINT ["/start.sh"]
