#!/bin/bash -evx

sudo apt-get update && apt-get -y install python-software-properties software-properties-common && \
        sudo add-apt-repository "deb http://gb.archive.ubuntu.com/ubuntu $(lsb_release -sc) universe" && \
            sudo apt-get update

sudo add-apt-repository ppa:saiarcot895/myppa && \
        sudo apt-get update && \
            sudo apt-get -y install apt-fast

export GIT_VERSION=2.1.2
export PYTHON_VERSION=2.7.10

sudo apt-fast update
sudo apt-fast -y install wget sudo vim curl build-essential

wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-fast update
sudo apt-fast install jenkins

echo "JENKINS_HOME=/media/data/jenkins" | sudo tee -a /etc/environment
