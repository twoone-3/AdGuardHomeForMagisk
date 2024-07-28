# erase all iptables rules
iptables -t nat -D OUTPUT -j ADGUARD
iptables -t nat -F ADGUARD
iptables -t nat -X ADGUARD
# delete DROP ipv6 DNS requests
ip6tables -t filter -D OUTPUT -p udp --dport 53 -j DROP
# enable ipv6
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv6.conf.all.accept_ra=2
sysctl -w net.ipv6.conf.wlan0.accept_ra=2
sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.default.disable_ipv6=0
sysctl -w net.ipv6.conf.wlan0.disable_ipv6=0