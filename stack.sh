#!/bin/bash -ev

docker build .

docker build python

docker build web/python-nginx

docker build web/python-nginx-pgpool

docker build web/python-nginx-pgpool-libsodium/

docker build db/postgres/
