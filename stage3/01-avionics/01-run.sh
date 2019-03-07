#!/bin/bash -e

on_chroot << EOF

rm -rf /opt/mission-mule
mkdir -p /opt/mission-mule

mkdir -p /home/pi/.ssh
touch /home/pi/.ssh/known_hosts

cd /opt/mission-mule && git clone -v https://github.com/missionmule/firefly-mule.git

cd /opt/mission-mule/firefly-mule && pip3 install -r /opt/mission-mule/firefly-mule/requirements.txt

cd /opt/mission-mule && git clone -v https://github.com/missionmule/data-mule-server.git

rm -rf /etc/nginx/sites-available/default

mkdir -p /srv/
chown pi:pi -R /srv/
chmod 755 /srv/

EOF

install -m 644 files/mission-mule-avionics.service   "${ROOTFS_DIR}/lib/systemd/system/"
install -m 644 files/mission-mule-client.service   "${ROOTFS_DIR}/lib/systemd/system/"
install -m 644 files/mission-mule-server.service   "${ROOTFS_DIR}/lib/systemd/system/"
install -m 644 files/default   "${ROOTFS_DIR}/etc/nginx/sites-available/"
install -m 644 files/setup.sh   "${ROOTFS_DIR}/opt/mission-mule/"

on_chroot << EOF

systemctl enable mission-mule-avionics
systemctl disable hciuart
systemctl enable mission-mule-client
systemctl enable mission-mule-server
systemctl enable nginx

EOF
