#!/bin/sh
sudo apt-get install clamav-base clamav-daemon clamav-freshclam &&
sed -i.old '1s;^;TCPSocket 3310\nTCPAddr 127.0.0.1\n;' /etc/clamav/clamd.conf &&
echo "ListenStream=127.0.0.1:3310" | sudo tee -a /etc/systemd/system/clamav-daemon.service.d/extend.conf &&
systemctl daemon-reload &&
sudo service clamav-freshclam restart &&
sudo service clamav-daemon restart
