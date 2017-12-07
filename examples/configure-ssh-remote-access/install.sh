#!/bin/bash
#ssh mit password scp -r .ssh home
#cp -r .ssh /home/pi &&
#ssh target sudo sed -i "s/#PasswordAuth.*/PasswordAuthentication no/g" /etc/ssh/sshd_config
## mit passwort via ssh.
#ssh target sudo sed  -i "s/ALL=(ALL:ALL) ALL.*/ALL=(ALL) NOPASSWD:ALL/g" /etc/sudoers
#
#
# Network
sudo apt update && sudo apt install sshpass
source target.config.sh

ssh-keygen -f "~/.ssh/known_hosts" -R $CURRENT_IP
ssh-keyscan $CURRENT_IP >>  ~/.ssh/known_hosts
sshpass -p $DEFAULT_PASSWORD ssh $TARGET "echo $DEFAULT_PASSWORD | sudo -S ls"
sshpass -p $DEFAULT_PASSWORD ssh $TARGET "mkdir .ssh/"
sshpass -p $DEFAULT_PASSWORD rsync --progress -avz -e ssh ./.ssh/authorized_keys $TARGET:~/.ssh/authorized_keys
sshpass -p $DEFAULT_PASSWORD ssh $TARGET "chmod go-w ."
sshpass -p $DEFAULT_PASSWORD ssh $TARGET "chmod 700 ./.ssh"
sshpass -p $DEFAULT_PASSWORD ssh $TARGET "chmod 644 ./.ssh/authorized_keys"
ssh $TARGET "echo $DEFAULT_PASSWORD | sudo -S sed -i 's/#PasswordAuth.*/PasswordAuthentication no/g' /etc/ssh/sshd_config"
ssh $TARGET "echo $DEFAULT_PASSWORD | sudo -S sed -i 's/ALL=(ALL:ALL) ALL.*/ALL=(ALL) NOPASSWD:ALL/g' /etc/sudoers"


#ssh-copy-id $TARGET -p 22
#sshpass -p $DEFAULT_PASSWORD scp -r .ssh/authorized_keys

#detect .config/lxsession Lubuntu LXDE-pi
#detect username pi administrator

rsync -avzh .ssh/authorized_keys $TARGET:/home/$USER_NAME/.ssh
sshpass -p $DEFAULT_PASSWORD ssh $TARGET "echo $DEFAULT_PASSWORD | sudo -S sed -i 's/#PasswordAuth.*/PasswordAuthentication no/g' /etc/ssh/sshd_config"


# Custom
#sudo update-rc.d dhcpcd disable

ssh $TARGET sudo apt install dhcpcd5 -y
# nano /etc/dhcpcd.conf
#detect enp0s25 eth0
export INTER=$(basename $(find /sys/class/net/ -iname 'e*'))
sudo cat <<EOF >>/etc/dhcpcd.conf
interface $INTER
static ip_address=192.168.1.5/32
static routers=192.168.1.1
static domain_name_servers=192.168.1.1 8.8.8.8 4.2.2.1
static domain_search=peep
static domain_name=peep
EOF


.config/lxsession/LXDE-pi/autostart
@lxpanel --profile LXDE-pi
@pcmanfm --desktop --profile LXDE-pi
@xscreensaver -no-splash
@point-rpi
@xset s off
@xset -dpms
@xset s noblank
@sed -i 's/"exited_cleanly": false/"exited_cleanly": true/' ~/.config/chromium-browser Default/Preferences
@chromium-browser --noerrdialogs --kiosk http://master.peep:3030/showclient --incognito --disable-translate

cat <<EOF > .config/lxsession/Lubuntu/autostart
@xset s off
@xset -dpms
@xset s noblank
@sed -i 's/"exited_cleanly": false/"exited_cleanly": true/' ~/.config/chromium/Default/Preferences
@chromium-browser --noerrdialogs --kiosk http://master.peep:3030/peep-room --incognito --disable-translate
EOF


cat <<EOF > /lib/systemd/system/x11vnc.service
[Unit]
Description=Start X11VNC
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -display :0 -auth guess -forever -loop -noxdamage -repeat -rfbauth /etc/x11vnc.pass -rfbport 5900 -shared
# -scale 0.9
# -scale 800x600

[Install]
WantedBy=multi-user.target
EOF
# Set Password
sudo x11vnc -storepasswd /etc/x11vnc.pass
sudo systemctl enable x11vnc.service

## Autologin
/usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf
autologin-user=wmurphy
