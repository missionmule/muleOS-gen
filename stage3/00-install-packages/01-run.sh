#!/bin/bash -e

on_chroot << EOF

pip3 install future
pip3 install lxml
pip3 install paramiko
pip3 install pyserial
pip3 install geopy

EOF

curl -sL https://deb.nodesource.com/setup_10.x | bash -

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

apt-get remove cmdtest && apt-get update && apt-get install yarn nodejs -y

/usr/bin/npm install -g react-scripts serve
