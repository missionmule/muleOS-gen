#!/bin/bash -e

cd /opt/mission-mule && git clone -v https://github.com/missionmule/data-mule-server.git

cd /opt/mission-mule/data-mule-server && yarn setup

cd /opt/mission-mule/data-mule-server/client && yarn build

rm -rf /etc/nginx/sites-available/default

install -m 644 files/mission-mule-client.service   "${ROOTFS_DIR}/lib/systemd/system/"
install -m 644 files/mission-mule-server.service   "${ROOTFS_DIR}/lib/systemd/system/"
install -m 644 files/default   "${ROOTFS_DIR}/etc/nginx/sites-available/"

mkdir -p /srv/
chown pi:pi -R /srv/
chmod 755 /srv/

on_chroot << EOF
systemctl enable mission-mule-client
systemctl enable mission-mule-server
systemctl enable nginx
EOF
