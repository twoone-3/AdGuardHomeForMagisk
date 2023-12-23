# until [ $(getprop sys.boot_completed) ]; do
# 	sleep 1
# done
MODDIR="${0%/*}"
ADG_DIR="$MODDIR/bin"
# 输出重定向
exec 1>"$ADG_DIR/stdout.log"
exec 2>"$ADG_DIR/stderr.log"

setuidgid root:net_raw "$ADG_DIR/AdGuardHome" 2>&1 &

"$MODDIR/apply_iptables.sh"
