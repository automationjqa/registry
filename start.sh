#!/usr/bin/env bash
  
HOSTNAME="$(hostname)"
STATE_FILE="/home/registry_auth"
PASSWD_FILE="/auth/htpasswd"
CERT_CONFIG_FILE="/home/CertTypeToInstall"
CERT_DEFAUTL_DIRECTORY="/home"
CERT_LOG_FILE="/var/log/cert.log"

CertTypeToInstall="$(cat $CERT_CONFIG_FILE)"

function InstallLetsEncrypt() {
  cd /etc/certbot/
  source venv3/bin/activate
  echo -e "Checking certificate..."
  if [[ ! -f "/etc/letsencrypt/live/$(hostname)/fullchain.pem" ]];then
    echo -e "Cert is absent. Getting new certificate..."
    certbot certonly -n --standalone -d "$HOSTNAME" --agree-tos -m "admin@$HOSTNAME" >>"$CERT_LOG_FILE" 2>>"$CERT_LOG_FILE"
    echo -e "Adding crontab job to renew certificates..."
    echo -e "0 0-10 1,5,10,15,20,25 * * /start.sh" >> /etc/crontabs/root
  else
    echo -e "Cert exists. Trying to renew..."
    certbot renew -n --post-hook "kill -9 $(ps aux | grep 'registry serve /etc/docker/registry/config.yml' | grep -v grep | awk '{print $1}'); registry serve /etc/docker/registry/config.yml 2>>/var/log/run.log >>/var/log/run.log &" >>"$CERT_LOG_FILE" 2>>"$CERT_LOG_FILE"
  fi
  deactivate
}

function install() {
  echo -e "Checking registry auth file..."
  if [[ ! -f "$PASSWD_FILE" ]];then
    echo -e "File is absent. Creating new /auth/htpasswd"
    [[ ! -d "/auth" ]] && mkdir /auth
    local login="jelastic"
    local password="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)"
    htpasswd -Bbn "$login" "$password" > /auth/htpasswd
    echo -e "LOGIN=$login\nPASSWORD=$password" >> "$STATE_FILE";
  else
    echo -e "File has been already created..."
  fi
}

function start () {

  if [[ ! -f "$STATE_FILE" ]]; then
    install
  fi

  if [[ $CertTypeToInstall -eq "install_cert_le" ]]; then
    InstallLetsEncrypt;
    export REGISTRY_HTTP_TLS_CERTIFICATE="/etc/letsencrypt/live/$(hostname)/fullchain.pem"
    export REGISTRY_HTTP_TLS_KEY="/etc/letsencrypt/live/$(hostname)/privkey.pem"
  else
    InstallSelfSigned
    export REGISTRY_HTTP_TLS_CERTIFICATE="$CERT_DEFAUTL_DIRECTORY/$HOSTNAME/fullchain.pem"
    export REGISTRY_HTTP_TLS_KEY="$CERT_DEFAUTL_DIRECTORY/$HOSTNAME/privkey.pem"
  fi

  export REGISTRY_HTTP_SECRET="$(cat $PASSWD_FILE)"

  registry serve /etc/docker/registry/config.yml
}

function InstallSelfSigned() {
  echo "$CERT_DEFAUTL_DIRECTORY/$HOSTNAME"
  mkdir -p "$CERT_DEFAUTL_DIRECTORY/$HOSTNAME"
  cd "$CERT_DEFAUTL_DIRECTORY/$HOSTNAME"
  openssl req -new -x509 -days 3065 -nodes \
    -out $CERT_DEFAUTL_DIRECTORY/$HOSTNAME/fullchain.pem \
    -keyout $CERT_DEFAUTL_DIRECTORY/$HOSTNAME/privkey.pem \
    -subj "/C=UA/ST=Zhytomyr/L=ZT/O=Jelastic/OU=Quality Assurance Department/emailAddress=qa@jelastic.com/CN=$HOSTNAME"
}

start
