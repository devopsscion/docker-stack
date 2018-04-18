#!/bin/bash -evx

sudo apt-get -qq update && sudo apt-get -qq -y install python-software-properties software-properties-common && \
    sudo add-apt-repository "deb http://gb.archive.ubuntu.com/ubuntu $(lsb_release -sc) universe" && \
    sudo apt-get -qq update

sudo add-apt-repository -y ppa:saiarcot895/myppa && \
    sudo apt-get -qq update && \
    sudo apt-get -qq -y install apt-fast

export GIT_VERSION=2.17.0
export PYTHON_VERSION=3.6.5

sudo apt-fast -qq update
sudo apt-fast -qq -y install wget sudo vim curl build-essential

sudo apt-fast -qq -y install libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev
pushd /tmp
wget --quiet --continue https://www.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.gz
test -e git-${GIT_VERSION} || tar -xvf git-${GIT_VERSION}.tar.gz
pushd git-${GIT_VERSION}
make -j$(nproc) --silent prefix=/usr/local all && sudo make --silent prefix=/usr/local install
popd
popd

sudo apt-fast -qq -y install sqlite3 libsqlite3-dev libssl-dev zlib1g-dev libxml2-dev libxslt-dev libbz2-dev gfortran libopenblas-dev liblapack-dev libatlas-dev subversion

pushd /tmp
wget --quiet --continue https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz -O /tmp/Python-${PYTHON_VERSION}.tgz
test -e Python-${PYTHON_VERSION} || tar -xvf Python-${PYTHON_VERSION}.tgz
pushd Python-${PYTHON_VERSION}
./configure CFLAGSFORSHARED="-fPIC" CCSHARED="-fPIC" --quiet CCSHARED="-fPIC" --prefix=/usr/local/opt/python --exec-prefix=/usr/local/opt/python CCSHARED="-fPIC" \
            && make clean && make -j$(nproc) --silent -j$(nproc) && sudo make --silent install
popd

sudo ln -sf /usr/local/opt/python/bin/python3 /usr/local/bin/python3

which python3 && python3 --version

pushd /tmp
wget --quiet --continue https://bootstrap.pypa.io/get-pip.py && sudo python3 get-pip.py
popd
sudo ln -sf /usr/local/opt/python/bin/pip3 /usr/local/bin/pip3

sudo pip3 install -U setuptools-git==1.2 wheel==0.29.0 pipenv
sudo pip3 install --upgrade pip
#RUN pip3 install -U distribute==0.7.3  setuptools==8.3

sudo mkdir -p /wheelhouse

#ipython
#sudo apt-fast -qq -y install libncurses5-dev
#sudo pip install readline==6.2.4.1

sudo mkdir -p /data/scratch && \
    sudo chmod -R 777 /data/scratch

