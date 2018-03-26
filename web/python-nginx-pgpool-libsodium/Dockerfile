FROM devopsscion/python-nginx-pgpool:postgres-automation-enhancements-2.0

RUN mkdir /repos
WORKDIR /repos
RUN git clone https://github.com/data-luminosity/message

WORKDIR /repos/message
RUN pip3 install -r requirements.txt

RUN sudo apt-get install -yqq libgdal-dev

ADD libosodium.sh /installs/libsodium.sh
WORKDIR /installs
RUN ./libsodium.sh
