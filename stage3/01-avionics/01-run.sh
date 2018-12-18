#!/bin/bash -e

on_chroot << EOF

rm -rf /opt/mission-mule
mkdir -p /opt/mission-mule

mkdir -p /home/pi/.ssh
touch /home/pi/.ssh/known_hosts

cd /opt/mission-mule && git clone -v https://github.com/missionmule/firefly-mule.git

cd /opt/mission-mule/firefly-mule && pip install -r /opt/mission-mule/firefly-mule/requirements.txt

EOF

install -m 644 files/mission-mule-avionics.service   "${ROOTFS_DIR}/lib/systemd/system/"

on_chroot << EOF

systemctl enable mission-mule-avionics
systemctl disable hciuart

EOF

# Install latest dronekit version for PX4 support

on_chroot << EOF

pip uninstall dronekit-python

cd /etc && git clone -v https://github.com/dronekit/dronekit-python.git
cd /etc/dronekit-python
sudo python setup.py build
sudo python setup.py install

EOF
