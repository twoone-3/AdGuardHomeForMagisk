iptables -t nat -N ADGUARD
# return requests from AdGuardHome
iptables -t nat -A ADGUARD -m owner --uid-owner root --gid-owner net_raw -j RETURN
# redirect DNS requests to AdGuardHome
iptables -t nat -A ADGUARD -p udp --dport 53 -j REDIRECT --to-ports 5591
iptables -t nat -A ADGUARD -p tcp --dport 53 -j REDIRECT --to-ports 5591
# apply iptables rules
iptables -t nat -A OUTPUT -j ADGUARD
# block ipv6 DNS requests
ip6tables -t filter -A OUTPUT -p tcp --dport 53 -j REJECT
ip6tables -t filter -A OUTPUT -p udp --dport 53 -j REJECT