#!/bin/bash -ev

#sudo cp conf/nginx.conf /usr/local/nginx/conf/nginx.conf
sudo cp conf/supervisor-nginx.conf /etc/supervisor/conf.d/nginx.conf
sudo cp conf/supervisor-uwsgi.conf /etc/supervisor/conf.d/uwsgi.conf
#sudo cp conf/supervisor-rsyslogd.conf /etc/supervisor/conf.d/rsyslogd.conf
