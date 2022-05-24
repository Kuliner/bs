#!/bin/sh
sudo apt-get update -y
sudo apt-get install clamav clamav-daemon -y
cp clamd.conf /etc/clamav/clamd.conf
cp freshclam.conf /etc/clamav/freshclam.conf
sudo service clamav-freshclam restart
sudo service clamav-daemon start
