#!/bin/bash -ex

. ./nginxenv.sh

id -u uwsgi &>/dev/null || sudo useradd uwsgi

sudo apt-fast install -y supervisor rsyslog-gnutls

pushd /tmp

PCRE_VERSION=8.42

wget --quiet --continue ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PCRE_VERSION}.tar.bz2 && \
    tar -xvf pcre-${PCRE_VERSION}.tar.bz2
pushd pcre-${PCRE_VERSION}
./configure && make --silent -j$(nproc) && sudo make --silent install
popd

wget --quiet --continue http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz && tar -xvf nginx-$NGINX_VERSION.tar.gz
pushd nginx-$NGINX_VERSION 
./configure --with-http_stub_status_module --with-http_ssl_module && make --silent -j$(nproc) && sudo make --silent install
popd

sudo apt-fast install -y libgeos-dev

#http://security.stackexchange.com/questions/95178/diffie-hellman-parameters-still-calculating-after-24-hours
cd /etc/ssl/certs && sudo openssl dhparam -dsaparam -out dhparam.pem 2048

sudo pip3 install uwsgi==$UWSGI_VERSION && \
    sudo mkdir -p /var/log/uwsgi && \
    sudo mkdir -p /var/run/uwsgi && \
    sudo chown -R uwsgi /var/run/uwsgi && \
    sudo chown -R uwsgi /var/log/uwsgi

popd #/tmp

#sudo cp conf/nginx.conf /usr/local/nginx/conf/nginx.conf
#sudo cp conf/supervisor-nginx.conf /etc/supervisor/conf.d/nginx.conf
#sudo cp conf/supervisor-uwsgi.conf /etc/supervisor/conf.d/uwsgi.conf
#sudo cp conf/supervisor-rsyslogd.conf /etc/supervisor/conf.d/rsyslogd.conf

