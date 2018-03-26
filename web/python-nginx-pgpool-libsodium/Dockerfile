FROM devopsscion/python-nginx-pgpool:postgres-automation-enhancements-2.0

RUN mkdir /repos
WORKDIR /repos
#RUN git clone https://github.com/devopsscion/libsodium-jni
RUN git clone https://github.com/data-luminosity/message

#WORKDIR /repos/libsodium-jni
#RUN ./dependencies-linux.sh
#RUN ./build.sh

WORKDIR /repos/message
RUN pip3 install -r requirements.txt

RUN sudo apt-get install -yqq libgdal-dev

WORKDIR /tmp
RUN wget --quiet --continue https://download.libsodium.org/libsodium/releases/libsodium-stable-2018-03-26.tar.gz && tar -xvf libsodium-stable-2018-03-26.tar.gz && cd libsodium-stable && ./configure && make -j$(nproc) && make check && sudo make install

