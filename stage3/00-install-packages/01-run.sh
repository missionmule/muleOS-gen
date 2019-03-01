#!/bin/bash -e

on_chroot << EOF

pip3 install future
pip3 install lxml
pip3 install paramiko
pip3 install pyserial
pip3 install geopy

EOF

on_chroot << EOF

curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -

EOF
