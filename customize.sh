ADG_DIR="$MODPATH/bin"
case $ARCH in
  arm64)
    mv "$ADG_DIR/AdGuardHome_arm64" "$ADG_DIR/AdGuardHome"
    rm -f "$ADG_DIR/AdGuardHome_armv7"
  ;;
  arm)
    mv "$ADG_DIR/AdGuardHome_armv7" "$ADG_DIR/AdGuardHome"
    rm -f "$ADG_DIR/AdGuardHome_arm64"
  ;;
  x86)
    # mv "$ADG_DIR/AdGuardHome_x86" "$ADG_DIR/AdGuardHome"
    abort "x86 is not supported"
  ;;
  x64)
    # mv "$ADG_DIR/AdGuardHome_x64" "$ADG_DIR/AdGuardHome"
    abort "x64 is not supported"
  ;;
esac

chmod 0775 "$ADG_DIR/AdGuardHome" "$MODPATH/apply_iptables.sh" "$MODPATH/flush_iptables.sh"
chown root:net_raw "$ADG_DIR/AdGuardHome"

ui_print "- Installing success, please reboot your device"