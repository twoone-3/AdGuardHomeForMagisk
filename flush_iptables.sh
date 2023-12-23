iptables -t nat -D OUTPUT 1
iptables -t nat -F ADGUARD
iptables -t nat -X ADGUARD

# ip6tables -t nat -D ADGUARD 1
# ip6tables -t nat -F ADGUARD
# ip6tables -t nat -X ADGUARD
