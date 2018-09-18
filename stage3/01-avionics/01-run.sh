#!/bin/bash -e

on_chroot << EOF

rm -rf /opt/mission-mule
mkdir -p /opt/mission-mule


mkdir -p /home/pi/.ssh
touch /home/pi/.ssh/known_hosts

cd /opt/mission-mule && git clone -v https://github.com/missionmule/data-mule.git

cd /opt/mission-mule/data-mule && pip install -r /opt/mission-mule/data-mule/requirements.txt

EOF

install -m 644 files/mission-mule-avionics.service   "${ROOTFS_DIR}/lib/systemd/system/"

on_chroot << EOF

systemctl enable mission-mule-avionics
systemctl disable hciuart

EOF
