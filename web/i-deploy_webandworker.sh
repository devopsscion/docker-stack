#!/bin/bash -
#===============================================================================
#
#          FILE: i-deploy_webandworker.sh
#
#         USAGE: ./i-deploy_webandworker.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#                PRIVATE_IP=$1
#                PAPERTRAIL_ADDRESS=$2
#                STACK=$3
#                SUFFIX=$4
#                ENV=$5
#                PGVERSION=$6
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Josh, Bob & Trey
#        AUTHOR2: Gregg Jensen (), gjensen@devops.center
#  ORGANIZATION: devops.center
#       CREATED: 09/29/2016 09:23:15
#      REVISION:  ---
#===============================================================================

# All 6 arguments are required

PRIVATE_IP=$1
PAPERTRAIL_ADDRESS=$2
STACK=$3
SUFFIX=$4
ENV=$5
PGVERSION=$6
CUST_APP_NAME=$7

if  [[ -z ${PRIVATE_IP} ]] ||
    [[ -z ${PAPERTRAIL_ADDRESS} ]] ||
    [[ -z ${STACK} ]] ||
    [[ -z ${SUFFIX} ]] ||
    [[ -z ${ENV} ]] ||
    [[ -z ${CUST_APP_NAME} ]] ||
    [[ -z ${PGVERSION} ]] ; then

    echo "6 Arguments are required: "
    echo "    PRIVATE_IP: ${PRIVATE_IP}"
    echo "    PAPERTRAIL_ADDRESS: ${PAPERTRAIL_ADDRESS}"
    echo "    STACK: ${STACK}"
    echo "    SUFFIX: ${SUFFIX}"
    echo "    ENV: ${ENV}"
    echo "    PGVERSION: ${PGVERSION}"
    echo "    CUST_APP_NAME: ${CUST_APP_NAME}"
    exit 1
fi

#-------------------------------------------------------------------------------
# install standard packages/utilities
#-------------------------------------------------------------------------------
cd ~/dcStack/buildtools/utils/ || exit
sudo ./base-utils.sh

#-------------------------------------------------------------------------------
# install stack common to web and workers
#-------------------------------------------------------------------------------
cd ~/dcStack/python/ || exit
sudo ./python.sh

cd ~/dcStack/buildtools/utils || exit
sudo ./install-supervisor.sh custom

#-------------------------------------------------------------------------------
# Fix configuration files, using env vars distributed in the customer-specific (and private) utils.
#-------------------------------------------------------------------------------
if [[ (-n "${ENV}") && (-e "${HOME}/${CUST_APP_NAME}/${CUST_APP_NAME}-utils/environments/${ENV}.env") ]]; then
    pushd ~/dcUtils/
    ./deployenv.sh --type instance --env $ENV --customerAppName ${CUST_APP_NAME}
    popd
fi

#-------------------------------------------------------------------------------
# enable logging
#-------------------------------------------------------------------------------
cd ~/dcStack/logging/ || exit
./i-enable-logging.sh "$PAPERTRAIL_ADDRESS"

#-------------------------------------------------------------------------------
#  install nginx
#-------------------------------------------------------------------------------
cd ~/dcStack/web/python-nginx/ || exit
sudo ./nginx.sh

#-------------------------------------------------------------------------------
# install pgpool
#-------------------------------------------------------------------------------
cd ~/dcStack/web/python-nginx-pgpool/ || exit
sudo ./pgpool.sh "$PGVERSION"

#-------------------------------------------------------------------------------
# install redis client
#-------------------------------------------------------------------------------
cd ~/dcStack/web/python-nginx-pgpool-redis/ || exit
sudo ./redis-client-install.sh

#-------------------------------------------------------------------------------
# Install customer-specific stack - all get the web portion.
#-------------------------------------------------------------------------------
cd ~/dcStack/${STACK}-stack/web/ || exit
sudo ./web.sh

# guessing this was intended to eventually point to a file, but it doesn't currently exist.
#if [[ "$SUFFIX" = "worker" ]]; then
#  cd ~/dcStack/${STACK}-stack/worker/ || exit
#  sudo ./worker.sh
#fi

#-------------------------------------------------------------------------------
# Restart supervisor, so that all services are now running.
#-------------------------------------------------------------------------------
if !(sudo /etc/init.d/supervisor restart); then
    echo "Error somewhere in supervisor or one of the services started by supervisor"
fi
