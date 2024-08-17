#!/system/bin/sh

iptables -t nat -N ADGUARD
# return requests from AdGuardHome
iptables -t nat -A ADGUARD -m owner --uid-owner root --gid-owner net_raw -j RETURN
# redirect DNS requests to AdGuardHome
iptables -t nat -A ADGUARD -p udp --dport 53 -j REDIRECT --to-ports 5591
iptables -t nat -A ADGUARD -p tcp --dport 53 -j REDIRECT --to-ports 5591
# apply iptables rules
iptables -t nat -I OUTPUT -j ADGUARD
# DROP ipv6 DNS requests
ip6tables -t filter -A OUTPUT -p udp --dport 53 -j DROP
# disable ipv6
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=0
sysctl -w net.ipv6.conf.all.accept_ra=0
sysctl -w net.ipv6.conf.wlan0.accept_ra=0
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.wlan0.disable_ipv6=1
