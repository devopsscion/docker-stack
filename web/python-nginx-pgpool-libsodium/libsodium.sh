#!/bin/bash -ev

wget --quiet --continue https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
tar -xvf LATEST.tar.gz 
cd libsodium-stable/ && ./configure 
make -j$(nproc) && make check 
sudo make install

sudo ldconfig
