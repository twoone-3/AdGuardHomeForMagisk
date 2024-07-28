ADG_DIR="$MODPATH/bin"
case $ARCH in
  arm64)
    ui_print "- Installing AdGuardHome for arm64"
  ;;
  arm)
    ui_print "- Installing AdGuardHome for armv7"
  ;;
  x86)
    abort "x86 is not supported"
  ;;
  x64)
    abort "x64 is not supported"
  ;;
esac

chmod 0775 "$ADG_DIR/AdGuardHome" "$MODPATH/apply_iptables.sh" "$MODPATH/flush_iptables.sh"
chown root:net_raw "$ADG_DIR/AdGuardHome"

ui_print "- Installing success, please reboot your device"