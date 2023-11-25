ui_print " -------------------------- "
ui_print " ------ 安装中，请稍等 ------ "

if [ "$ARCH" != "arm64" ]; then
  ui_print " 仅支持arm64架构，安装失败 "
  exit 1
fi

ui_print " ----- 安装已完成，请重启 ---- "
ui_print " -------------------------- "
