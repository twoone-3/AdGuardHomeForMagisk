#!/system/bin/sh

SKIPUNZIP=1

ui_print "- Installing AdGuardHome for $ARCH"

CONFIG_PATH="/data/adb/modules/AdGuardHome/bin/AdGuardHome.yaml"
BACKUP_PATH="/data/adb/modules/AdGuardHome/bin/AdGuardHome.yaml.bak"

if [ -f "$CONFIG_PATH" ]; then
  ui_print "- Restoring AdGuardHome configuration..."
  cp "$CONFIG_PATH" "$BACKUP_PATH"
  ui_print "- Backup Success, the backup file is $BACKUP_PATH"
fi

ui_print "- Extracting files..."
unzip -o "$ZIPFILE" -x 'META-INF/*' -d "$MODPATH" >&2

ui_print "- Setting permissions..."
chmod 0755 "$MODPATH/bin/AdGuardHome" "$MODPATH/apply_iptables.sh" "$MODPATH/flush_iptables.sh"
chown root:net_raw "$MODPATH/bin/AdGuardHome"

ui_print "- Installation is complete, please restart your device."