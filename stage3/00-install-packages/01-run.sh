#!/bin/bash -e

on_chroot << EOF

pip3 install future
pip3 install lxml
pip3 install paramiko
pip3 install pyserial
pip3 install geopy

EOF

curl -sL https://deb.nodesource.com/setup_10.x | bash -
apt-get remove nodejs && apt-get update && apt-get install nodejs -y

/usr/bin/npm cache clean --force

/usr/bin/npm install -g react-scripts serve
