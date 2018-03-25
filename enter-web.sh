#!/bin/bash -ev

docker-compose -f stack.yml exec python-nginx-pgpool-libsodium /bin/bash
