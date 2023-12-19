if [ "$ARCH" != "arm64" ]; then
  ui_print "仅支持arm64架构，安装失败"
  exit 1
fi

ADG_DIR="$MODPATH/bin"
chmod 777 "$ADG_DIR/AdGuardHome"
# TODO: 研究用户组对程序运行有什么影响
chgrp net_raw "$ADG_DIR/AdGuardHome"
chgrp net_raw "$ADG_DIR/AdGuardHome.yaml"

ui_print "安装成功"