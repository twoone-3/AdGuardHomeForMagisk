until [ -f "${0%/*}/topdalao" ]; do
	sed -i 's/\[.*\]/\[ 文件topdalao丢失，请重新安装模块重启 \]/g' "${0%/*}/module.prop"
	sleep 5
done
sleep 5
MODDIR=${0%/*}
chmod 0755 "$MODDIR/AdGuardHome"
chmod 0755 "$MODDIR/topdalao"
chmod 0755 "$MODDIR/testing.sh"
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
sed -i 's/\[.*\]/\[ 未生效，尝试移除模块重启后再安装，或换稳定版Mgaisk \]/g' "$MODDIR/module.prop"
up=1
while true ; do
if [ "$up" = "20" -o "$up" = "7200" ]; then
	"$MODDIR/up" > /dev/null 2>&1 &
	up=21
fi
sleep 3
"$MODDIR/topdalao" > /dev/null 2>&1
up="$(( $up + 1 ))"
done
