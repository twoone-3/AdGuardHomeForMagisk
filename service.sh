MODDIR="${0%/*}"
ADG_DIR="$MODDIR/bin"

setuidgid root:net_admin "$ADG_DIR/AdGuardHome""$ADG_DIR/AdGuardHome.log" >> 2>&1 &

"$MODDIR/apply_iptables.sh"
