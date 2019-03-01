#!/bin/bash -e

on_chroot << EOF

pip3 install future
pip3 install lxml
pip3 install paramiko
pip3 install pyserial
pip3 install geopy

EOF

curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
