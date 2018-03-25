#!/bin/bash -ev

docker-compose -f stack.yml exec db-postgres /bin/bash
