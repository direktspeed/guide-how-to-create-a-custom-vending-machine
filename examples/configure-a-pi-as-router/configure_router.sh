#!/bin/bash
echo "Needs to run as Root"

apt install -y dnsmasq

cat <<EOT > /etc/dnsmasq.conf
# DHCP-Server aktiv für LAN-Interface
interface=eth0

# DHCP-Server nicht aktiv für bestehendes Netzwerk
no-dhcp-interface=wlan0

# IPv4-Adressbereich und Lease-Time
dhcp-range=192.168.33.100,192.168.33.150,24h
dhcp-host=38:60:77:40:50:fc,master,192.168.33.100,infinite
dhcp-host=38:60:77:40:50:99,zimmer1,192.168.33.101,infinite
dhcp-host=38:60:77:40:50:99,zimmer2,192.168.33.102,infinite
dhcp-host=38:60:77:40:50:99,zimmer3,192.168.33.103,infinite


# DNS
dhcp-option=option:dns-server,192.168.33.1
EOT

cat <<EOT > /etc/wpa_supplicant/wpa_supplicant.conf
country=AT
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
network={
    ssid="doc1"
    psk="0Q9Qsa4mHbqsRXL3VhmQ42zkDM58YdtBYYwri4HHGQwlvTqJjexIaR94w126zia"
}
EOT



cat <<EOT > /etc/network/interfaces
# interfaces(5) file used by ifup(8) and ifdown(8)

# Please note that this file is written to be used with dhcpcd
# For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf'

# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

auto lo
iface lo inet loopback

allow-hotplug eth0
iface eth0 inet static
    address 192.168.33.1
    netmask 255.255.255.0

allow-hotplug wlan0
iface wlan0 inet manual
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

    # Vorhandene Firewall-Regel löschen
    up /sbin/iptables -F
    up /sbin/iptables -X
    up /sbin/iptables -t nat -F

    # Loopback zulassen
    up /sbin/iptables -A INPUT -i lo -j ACCEPT
    up /sbin/iptables -A OUTPUT -o lo -j ACCEPT

    # NAT und Masquerading aktivieren
    up /sbin/iptables -A FORWARD -o wlan0 -i eth0 -m conntrack --ctstate NEW -j ACCEPT
    up /sbin/iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
    up /sbin/iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE

    # IP-Forwarding aktivieren
    up sysctl -w net.ipv4.ip_forward=1
    up sysctl -w net.ipv6.conf.all.forwarding=1

    # hostapd und dnsmasq neu starten
    up service dnsmasq restart
EOT

sudo cat <<EOT > /etc/hosts
## Dieser Router
127.0.0.1	localhost router.peep
::1		localhost ip6-localhost ip6-loopback
ff02::1		ip6-allnodes
ff02::2		ip6-allrouters

127.0.1.1	router.peep

## Lokales Netzwerk
#  = IP =     =  Domainname =    = Rechnername =
192.168.1.1     modem.peep           modem            ## Cisco Router
192.168.1.4     router.peep          router            ## PI Router
192.168.1.2     neo.example.org      neo              ## Workstation
192.168.1.3     felidae.example.org  felidae          ## ein Client-Rechner
192.168.1.5     link.example.org     link             ## Notebook
192.168.1.11    zeus.example.org     zeus             ## Der Server
192.168.1.66    bridge.example.org   bridge           ## WLAN-Brücke
EOT

echo 'router' > /etc/hostname
hostname router
