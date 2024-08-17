#!/system/bin/sh

SKIPUNZIP=1

ui_print "- Installing AdGuardHome for $ARCH"

if [ -d "$MODPATH" ]; then
  ui_print "- Backing up AdGuardHome configuration..."
  date=$(date +%Y%m%d-%H%M%S)
  cp "/data/adb/modules/AdGuardHome/bin/AdGuardHome.yaml" "/data/adb/AdGuardHome-$date.yaml"
  ui_print "- Backup Success, the backup file is /data/adb/AdGuardHome-$date.yaml"
fi

ui_print "- Extracting files..."
unzip -o "$ZIPFILE" -x 'META-INF/*' -x 'webroot/*' -d "$MODPATH" >&2

ui_print "- Setting permissions..."
chmod 0755 "$MODPATH/bin/AdGuardHome" "$MODPATH/apply_iptables.sh" "$MODPATH/flush_iptables.sh"
chown root:net_raw "$MODPATH/bin/AdGuardHome"

ui_print "- Installation is complete, please restart your device."