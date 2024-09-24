#!/system/bin/sh
SKIPUNZIP=1

ui_print "- Installing AdGuardHome for $ARCH"

AGH_DIR="/data/adb/agh"
BIN_DIR="$AGH_DIR/bin"
SCRIPT_DIR="$AGH_DIR/scripts"
SERVICE_DIR="/data/adb/service.d"

if [ -d "$AGH_DIR" ]; then
  ui_print "- Backup existing installation..."
  BACKUP_DIR=$(mktemp -d /data/adb/agh.XXXXXXXXXX)
  mv "$AGH_DIR"/* "$BACKUP_DIR"
  ui_print "- Backup created at $BACKUP_DIR"
else
  mkdir -p "$AGH_DIR" "$BIN_DIR" "$SCRIPT_DIR"
fi

ui_print "- Extracting files..."
unzip -o "$ZIPFILE" "uninstall.sh" -d $MODPATH
unzip -o "$ZIPFILE" "module.prop" -d $MODPATH
unzip -o "$ZIPFILE" "agh_service.sh" -d $SERVICE_DIR
unzip -o "$ZIPFILE" "scripts/*" -d $AGH_DIR
unzip -o "$ZIPFILE" "bin/*" -d $AGH_DIR

ui_print "- Setting permissions..."
chmod +x "$BIN_DIR/AdGuardHome"
chmod +x "$SCRIPT_DIR/apply_iptables.sh"
chmod +x "$SCRIPT_DIR/flush_iptables.sh"
chmod +x "$SCRIPT_DIR/start.sh"
chmod +x "$SERVICE_DIR/agh_service.sh"
chmod +x "$MODPATH/uninstall.sh"
chown root:net_raw "$BIN_DIR/AdGuardHome"

ui_print "- Installation is complete, please restart your device."
