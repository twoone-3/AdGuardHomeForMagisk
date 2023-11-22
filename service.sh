until [ -f "${0%/*}/topdalao" ]; do
	sed -i 's/\[.*\]/\[ 文件topdalao丢失，请重新安装模块重启 \]/g' "${0%/*}/module.prop" > /dev/null 2>&1
	sleep 5
done
while [ "$(getprop sys.boot_completed)" != "1" ]; do
  sleep 1s
done
MODDIR=${0%/*}
chmod 0755 "$MODDIR/AdGuardHome"
chmod 0755 "$MODDIR/topdalao"
chmod 0644 "$MODDIR/mode.conf"
chmod 0644 "$MODDIR/AdGuardHome.yaml"
sleep 1
echo "rm -f \"$MODDIR/stop\"" > "$MODDIR/恢复过滤.sh"
echo "touch \"$MODDIR/stop\"" > "$MODDIR/暂停过滤.sh"
chmod 0755 "$MODDIR/恢复过滤.sh"
chmod 0755 "$MODDIR/暂停过滤.sh"
if [ -f "$MODDIR/t_module" -a "$(cat "$MODDIR/module.prop" | egrep '^#by topdalao' | sed -n '$p')" != '#by topdalao' ]; then
	cp "$MODDIR/t_module" "$MODDIR/module.prop"
	chmod 0644 "$MODDIR/module.prop"
fi
"$MODDIR/AdGuardHome" > /dev/null 2>&1 &
while true ; do
sleep 3
"$MODDIR/topdalao" > /dev/null 2>&1
done
