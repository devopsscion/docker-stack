#!/bin/bash -ev

pushd /installs
wget --quiet --continue https://download.libsodium.org/libsodium/releases/libsodium-stable-2018-03-26.tar.gz 
tar -xvf libsodium-stable-2018-03-26.tar.gz 
cd libsodium-stable && ./configure 
make -j$(nproc) && make check 
sudo make install

sudo ldconfig
popd
