## Monitor Fujitsu scale
cvt 1920 1080 # returns Modeline ....
#xrandr --newmode <result>
DISPLAY=:0 xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
DISPLAY=:0 xrandr --addmode DP-1 1920x1080_60.00
xrandr # find display port
#xrandr --addmode <display port DP-1> 1920x1080_60.00
DISPLAY=:0 xrandr --addmode <display port DP-1> 1920x1080_60.00

xrandr --output DisplayPort-0 --off --output DVI-0 --mode 2048x1536_60.00 --pos 0x0 --rotate normal --output HDMI-0 --off

sudo chmod a+x /usr/bin/lightdmxrandr.sh
Then open /etc/lightdm/lightdm.conf(If this file is not there then read the "PS" below) by the command:-

sudo gedit /etc/lightdm/lightdm.conf
You can use your own text editor instead of gedit. The file must contain something like this:-

[SeatDefaults]
user-session=ubuntu
Add the below lines to the file:-

greeter-session=unity-greeter
display-setup-script=/usr/bin/lightdmxrandr.sh
session-setup-script=/usr/bin/lightdmxrandr.sh


## Alternativ Method Not checked
Resizing the screen:

xrandr --size 640x480
Desktop icon:

[Desktop Entry]
Encoding=UTF-8
Name=My App
Comment=What the app does
Exec=programname
Icon=??
Terminal=false
Type=Application
StartupNotify=true
Categories=??
and put it in ~/.local/share/applications/programname.desktop or /usr/share/applications/programname.desktop
