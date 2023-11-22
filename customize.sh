ui_print " -------------------------- "
ui_print " ------ 安装中，请稍等 ------ "
# 获取设备的架构
ARCH=$(getprop ro.product.cpu.abi)
# 打印获取设备架构的步骤
ui_print "获取设备的架构: $ARCH"
# 如果设备是arm64位
if [ "$ARCH" = "arm64-v8a" ]; then
  # 打印设备是arm64位的信息
  ui_print " --- 设备架构为arm64-v8a，继续安装… --- "
  # 执行后续命令
  # ...
else
  # 如果设备不是arm64位
  # 打印设备不是arm64位的信息
  ui_print " 仅支持arm64-v8a架构，安装失败 "
  # 等待两秒
  sleep 2
  # 停止运行
  exit 1
fi

cp "$MODPATH/linux_arm64/AdGuardHome" "$MODPATH/AdGuardHome"

rm -rf "$MODPATH/linux_arm64"

ui_print " ----- 安装已完成，请重启 ---- "
ui_print " -------------------------- "
