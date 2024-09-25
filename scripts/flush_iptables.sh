#!/system/bin/sh

AGH_DIR="/data/adb/agh"
exec >"$AGH_DIR/flush.log" 2>&1
source "$AGH_DIR/scripts/config.sh"

# erase all iptables rules
$iptables_w -t nat -D OUTPUT -j ADGUARD
$iptables_w -t nat -F ADGUARD
$iptables_w -t nat -X ADGUARD

ip6tables -w 64 -t filter -D OUTPUT -p udp --dport 53 -j DROP
ip6tables -w 64 -t filter -D OUTPUT -p tcp --dport 53 -j DROP
# sysctl -w net.ipv4.ip_forward=1
# sysctl -w net.ipv6.conf.all.forwarding=0
# sysctl -w net.ipv6.conf.all.accept_ra=0
# sysctl -w net.ipv6.conf.wlan0.accept_ra=0
sysctl -w net.ipv6.conf.all.disable_ipv6=0
sysctl -w net.ipv6.conf.default.disable_ipv6=0
# sysctl -w net.ipv6.conf.wlan0.disable_ipv6=1
