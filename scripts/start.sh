#!/system/bin/sh

AGH_DIR="/data/adb/agh"
BIN_DIR="$AGH_DIR/bin"
SCRIPT_DIR="$AGH_DIR/scripts"
exec > "$AGH_DIR/start.log" 2>&1
source "$AGH_DIR/scripts/config.sh"

# to fix https://github.com/AdguardTeam/AdGuardHome/issues/7002
export SSL_CERT_DIR="/system/etc/security/cacerts/"
busybox setuidgid "$adg_user:$adg_group" "$BIN_DIR/AdGuardHome" --logfile "$BIN_DIR/AdGuardHome.log" --no-check-update &

sleep 3
if [ "$manual" = false ]; then
  "$SCRIPT_DIR/apply_iptables.sh"
fi
