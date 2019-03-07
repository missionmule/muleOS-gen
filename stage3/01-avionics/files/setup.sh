#!/bin/bash -e

curl -sL https://deb.nodesource.com/setup_10.x | bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

apt-get remove cmdtest nodejs -y
apt-get update
apt-get install nodejs yarn -y

yarn add global react-scripts serve

cd /opt/mission-mule/data-mule-server
yarn setup
cd client
yarn build
