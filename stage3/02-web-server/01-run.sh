#!/bin/bash -e

on_chroot << EOF

curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
apt-get install nodejs -y

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt-get install yarn

EOF

on_chroot << EOF

cd /opt/mission-mule && git clone -v https://github.com/missionmule/data-mule-server.git .

cd /opt/mission-mule/data-mule-server && yarn setup

cd /opt/mission-mule/data-mule-server/client && yarn build

rm -rf /etc/nginx/sites-available/default

EOF

install -m 644 files/mission-mule-client.service   "${ROOTFS_DIR}/lib/systemd/system/"
install -m 644 files/mission-mule-server.service   "${ROOTFS_DIR}/lib/systemd/system/"
install -m 644 files/default   "${ROOTFS_DIR}/etc/nginx/sites-available/"

on_chroot << EOF

mkdir -p /srv/
chown pi:pi -R /srv/
chmod 755 /srv/

EOF

on_chroot << EOF

systemctl enable mission-mule-client
systemctl enable mission-mule-server
systemctl enable nginx

EOF
