#!/bin/bash - 
#===============================================================================
#
#          FILE: web.sh
# 
#         USAGE: web/web.sh
# 
#   DESCRIPTION: 66CCFF stack, install web-specific components.
# 
#       OPTIONS: ===
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Bob Lozano, bob@devops.center
#  ORGANIZATION: devops.center
#       CREATED: long time ago
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error

source ../../dcENV.sh                       # initalize logging environment

dcStartLog "install of customer-specific worker, combo: ${COMBINED_WEBANDWORKER}"

# Some equired packages for rendering
sudo apt-fast -y install libfontconfig-dev libxrender-dev libxtst6

# install node
curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
sudo apt-get install -y nodejs
curl -L https://npmjs.com/install.sh | sudo sh
sudo npm install -g less

# Install required packages
sudo pip install -r requirements.txt

# prepare required directories for this app
sudo mkdir -p /data/deploy /data/media /data/media/pdfcreator /data/media/reports/pdf /data/scratch 

dcEndLog "install of customer-specific worker, combo: ${COMBINED_WEBANDWORKER}"
