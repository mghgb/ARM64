#!/bin/sh
sudo su
hostnamectl set-hostname dock-node-01
hostnamectl set-hostname "Docker Swarm Node 01" --pretty
cd /etc/network
mv interfaces interfaces.bkp
echo 'source /etc/network/interfaces.d/*' >> interfaces
echo '# Network is managed by Network manager' >> interfaces
echo 'auto lo' >> interfaces
echo 'iface lo inet loopback' >> interfaces
echo 'auto eth0' >> interfaces
echo 'iface eth0 inet static' >> interfaces
echo '        address 192.168.1.70/24' >> interfaces
echo '        gateway 192.168.1.1' >> interfaces
echo '        dns-nameservers 192.168.1.1' >> interfaces
cd ..
mv hosts hosts.bkp
echo '127.0.0.1   localhost' >> hosts
echo '192.168.1.70 dock-node-01' >> hosts
echo '192.168.1.71 dock-node-02' >> hosts
echo '192.168.1.72 dock-node-03' >> hosts
echo '192.168.1.73 dock-node-04' >> hosts
echo $'\n# Disable IPV6' >> sysctl.conf
echo 'net.ipv6.conf.all.disable_ipv6=1' >> sysctl.conf
echo 'net.ipv6.conf.default.disable_ipv6=1' >> sysctl.conf
echo 'net.ipv6.conf.lo.disable_ipv6=1' >> sysctl.conf
apt purge -y dhcpcd5
sleep 10 && reboot
