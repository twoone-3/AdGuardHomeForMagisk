MODDIR="${0%/*}"
ADG_DIR="$MODDIR/bin"

pref=100

disable_ipv6() {
  sysctl -w net.ipv4.ip_forward=1
  sysctl -w net.ipv6.conf.all.forwarding=0

  sysctl -w net.ipv6.conf.all.accept_ra=0
  sysctl -w net.ipv6.conf.wlan0.accept_ra=0
  sysctl -w net.ipv6.conf.all.disable_ipv6=1
  sysctl -w net.ipv6.conf.default.disable_ipv6=1
  sysctl -w net.ipv6.conf.wlan0.disable_ipv6=1

  ip -6 rule add unreachable pref "${pref}"

} >> /dev/null 2>&1

ipv6_enable() {
  sysctl -w net.ipv4.ip_forward=1
  sysctl -w net.ipv6.conf.all.forwarding=1

  sysctl -w net.ipv6.conf.all.accept_ra=1
  sysctl -w net.ipv6.conf.wlan0.accept_ra=1
  sysctl -w net.ipv6.conf.all.disable_ipv6=0
  sysctl -w net.ipv6.conf.default.disable_ipv6=0
  sysctl -w net.ipv6.conf.wlan0.disable_ipv6=0

  ip -6 rule del unreachable pref "${pref}"

} >> /dev/null 2>&1

chown root:net_admin "$ADG_DIR/AdGuardHome"
setuidgid root:net_admin "$ADG_DIR/AdGuardHome" >>"$ADG_DIR/AdGuardHome.log" 2>&1 &

"$MODDIR/apply_iptables.sh"
disable_ipv6
