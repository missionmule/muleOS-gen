#!/bin/bash -e

# Make directories for sensor data and logs
on_chroot << EOF

mkdir -p /srv/logs
mkdir -p /srv/data

EOF

# Download web server files into /var/www/html directory (where Apache2 serves from)
on_chroot << EOF

rm -rf /var/www/html
mkdir -p /var/www/html

cd /var/www/html && git clone -v https://github.com/missionmule/data-mule-server.git .

EOF
