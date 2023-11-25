until [ $(getprop sys.boot_completed) ]; do
	sleep 1
done
MODDIR=${0%/*}
chmod +x "$MODDIR/AdGuardHome"
chmod +x "$MODDIR/script.sh"
"$MODDIR/AdGuardHome" > /dev/null 2>&1 &
"$MODDIR/script.sh" > /dev/null 2>&1