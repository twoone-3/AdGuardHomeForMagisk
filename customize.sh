#!/system/bin/sh

SKIPUNZIP=1

ui_print "- Installing AdGuardHome for $ARCH"

CONFIG_PATH="/data/adb/modules/AdGuardHome/bin/AdGuardHome.yaml"
BACKUP_PATH="/storage/emulated/0/AdGuardHome.yaml"

if [ -f "$CONFIG_PATH" ]; then
  ui_print "- Previous configuration found, would you like to restore it?"
  ui_print "- (Volume Up = Yes, Volume Down = No)"
  key_click=""
  while [ "$key_click" = "" ]; do
    key_click="$(getevent -qlc 1 | awk '{ print $3 }' | grep 'KEY_')"
    sleep 0.2
  done
  case "$key_click" in
  "KEY_VOLUMEUP")
    cp "$CONFIG_PATH" "$BACKUP_PATH"
    ui_print "- Backup Success, the backup file is $BACKUP_PATH"
    ;;
  *)
    ui_print "- Backup Skipped"
    ;;
  esac

fi

ui_print "- Extracting files..."
unzip -o "$ZIPFILE" -x 'META-INF/*' -d "$MODPATH" >&2

ui_print "- Setting permissions..."
chmod +x "$MODPATH/bin/AdGuardHome" "$MODPATH/*.sh"
chown root:net_raw "$MODPATH/bin/AdGuardHome" 

ui_print "- Would you like to apply iptables rules in every boot?"
ui_print "- (Volume Up = Yes, Volume Down = No)"
key_click=""
while [ "$key_click" = "" ]; do
  key_click="$(getevent -qlc 1 | awk '{ print $3 }' | grep 'KEY_')"
  sleep 0.2
done
case "$key_click" in
"KEY_VOLUMEUP")
  touch "$MODPATH/apply_iptables.sh"
  ui_print "- Iptables rules will be applied in every boot."
  ;;
*)
  touch "$MODPATH/manual"
  ui_print "- Iptables rules will not be applied in every boot."
  ;;
esac

ui_print "- Installation is complete, please restart your device."
