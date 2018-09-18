#!/bin/bash -e

install -v -d					"${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d"
install -v -m 644 files/wait.conf		"${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d/"

install -v -d					"${ROOTFS_DIR}/etc/wpa_supplicant"
install -v -m 600 files/wpa_supplicant.conf	"${ROOTFS_DIR}/etc/wpa_supplicant/"

echo "Configuring wireless access point..."

echo "Installing dhcpcd.conf"
install -m 644 -v files/dhcpcd.conf "${ROOTFS_DIR}/etc/"

echo "Installing dnsmasq.conf"
install -m 644 -v files/dnsmasq.conf  "${ROOTFS_DIR}/etc/"

echo "Installing hostapd.conf"
install -v -d	"${ROOTFS_DIR}/etc/hostapd"
install -m 644 -v files/hostapd.conf  "${ROOTFS_DIR}/etc/hostapd/"

echo "Installing hostapd"
install -m 755 -v files/hostapd "${ROOTFS_DIR}/etc/default/"

echo "Installing sysctl.conf"
install -m 644 -v files/sysctl.conf "${ROOTFS_DIR}/etc/"

echo "Installing unique UUID script"
install -m 755 -v files/unique_ssid.py "${ROOTFS_DIR}/opt/"

echo "Wireless access point configuration complete"

echo "Installing unique UUID script"
install -m 755 -v files/unique_ssid.py "${ROOTFS_DIR}/opt/"

# Enable Apache2 access to /srv/ directory where sensor data and logs are kept
echo "Installing apache2.conf..."
install -m 644 -v files/apache2.conf  "${ROOTFS_DIR}/etc/apache2"

on_chroot << EOF

iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sh -c "iptables-save > /etc/iptables.ipv4.nat"

EOF
