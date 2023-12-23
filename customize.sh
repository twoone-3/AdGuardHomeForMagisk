if [ "$ARCH" != "arm64" ]; then
  abort "仅支持 arm64 架构，安装失败"
fi

ADG_DIR="$MODPATH/bin"
chmod +x "$ADG_DIR/AdGuardHome" "$MODPATH/apply_iptables.sh" "$MODPATH/flush_iptables.sh"
# TODO: 研究用户组对程序运行有什么影响
# chgrp net_raw "$ADG_DIR/AdGuardHome"
# chgrp net_raw "$ADG_DIR/AdGuardHome.yaml"

ui_print "安装成功，请重启设备"