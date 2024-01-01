MODDIR="${0%/*}"
ADG_DIR="$MODDIR/bin"
# 输出重定向
exec 1>"$ADG_DIR/stdout.log"
exec 2>"$ADG_DIR/stderr.log"

setuidgid root:net_raw "$ADG_DIR/AdGuardHome" &

"$MODDIR/apply_iptables.sh"
