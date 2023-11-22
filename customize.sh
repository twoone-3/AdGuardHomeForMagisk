ui_print " -------------------------- "
ui_print " ------ 安装中，请稍等 ------ "

ARCH=$(getprop ro.product.cpu.abi)
ui_print "获取设备的架构: $ARCH"

if [ "$ARCH" = "arm64-v8a" ]; then
  ui_print " --- 设备架构为arm64-v8a，继续安装… --- "
else
  ui_print " 仅支持arm64-v8a架构，安装失败 "
  exit 1
fi

ui_print " ----- 安装已完成，请重启 ---- "
ui_print " -------------------------- "
