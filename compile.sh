#!/bin/bash -ev

pushd python
./python.sh
popd

pushd web/python-nginx
./nginx.sh
popd
