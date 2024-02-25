MODDIR="${0%/*}"
ADG_DIR="$MODDIR/bin"
# redirect the log
exec 1>"$ADG_DIR/stdout.log"
exec 2>"$ADG_DIR/stderr.log"

setuidgid root:net_admin "$ADG_DIR/AdGuardHome" &

"$MODDIR/apply_iptables.sh"
