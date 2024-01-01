iptables -t nat -D OUTPUT 1
iptables -t nat -F ADGUARD
iptables -t nat -X ADGUARD