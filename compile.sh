#!/bin/bash -ev

pushd python
./python.sh
popd

pushd web/python-nginx
./nginx.sh
popd

pushd web/python-nginx-pgpool
./pgpool.sh
popd

pushd web/python-nginx-pgpool-libsodium/

popd

pushd db/postgres/
./postgres.sh
popd
