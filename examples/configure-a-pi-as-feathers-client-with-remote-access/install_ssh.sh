#!/bin/bash
cp -r ../.ssh /home/pi
sudo sed -i "s/#PasswordAuth.*/PasswordAuthentication no/g" /etc/ssh/sshd_config
sed  -i "s/ALL=(ALL:ALL) ALL.*/ALL=(ALL) NOPASSWD:ALL/g" /etc/sudoers
