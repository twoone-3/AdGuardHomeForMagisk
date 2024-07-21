if [ "$ARCH" != "arm64" ]; then
  abort "- only support arm64"
fi

ui_print "- Installing AdGuardHome"

ADG_DIR="$MODPATH/bin"
chmod 0775 "$ADG_DIR/AdGuardHome" "$MODPATH/apply_iptables.sh" "$MODPATH/flush_iptables.sh"
chown root:net_raw "$ADG_DIR/AdGuardHome"

ui_print "- Installing success, please reboot your device"