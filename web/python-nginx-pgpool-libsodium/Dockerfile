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
