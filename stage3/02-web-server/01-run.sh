#!/bin/bash -e

on_chroot << EOF

rm -rf /var/www/html
mkdir -p /var/www/html

cd /var/www/html && git clone -v https://github.com/missionmule/data-mule-server.git .

mkdir -p /srv/flight-data/field
mkdir -p /srv/flight-data/logs

rm -rf /etc/apache2/apache2.conf

EOF

install -m 755 files/apache2.conf   "${ROOTFS_DIR}/etc/apache2/apache2.conf"

on_chroot << EOF

chown pi:pi -R /srv/
chmod 755 /srv/

EOF
