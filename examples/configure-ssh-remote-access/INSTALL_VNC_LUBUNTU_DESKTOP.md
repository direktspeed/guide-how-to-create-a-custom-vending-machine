# REAL VNC needs systemctl enable start after update
https://github.com/novnc/noVNC
# INSTALL VNC DESKTOP LUBUNTU
sudo apt-get update
sudo apt-get install x11vnc
# Create Password
sudo x11vnc -storepasswd /etc/x11vnc.pass
# Creates and Starts
#x11vnc -usepw -forever -display :0
# Autostart
nano /home/pi/.config/autostart/x11vnc.desktop
[Desktop Entry]
Type=Application
Name=X11VNC
Exec=x11vnc -usepw -forever -display :0
StartupNotify=false



sudo nano /lib/systemd/system/x11vnc.service

[Unit]
Description=Start X11VNC
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -display :0 -auth guess -forever -loop -noxdamage -repeat -rfbauth /etc/x11vnc.pass -rfbport 5900 -shared -httpdir /usr/share/vnc-java/ -httpport 5800
# -scale 0.9
# -scale 800x600

[Install]
WantedBy=multi-user.target


sudo systemctl enable x11vnc.service
