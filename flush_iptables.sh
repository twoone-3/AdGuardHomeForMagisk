iptables -t nat -D OUTPUT -j ADGUARD
iptables -t nat -F ADGUARD
iptables -t nat -X ADGUARD
ip6tables -t filter -D OUTPUT -p tcp --dport 53 -j REJECT
ip6tables -t filter -D OUTPUT -p udp --dport 53 -j REJECT