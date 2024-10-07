#!/system/bin/sh
SKIPUNZIP=1

ui_print "- 开始安装 AdGuardHome for $ARCH"
ui_print "- Installing AdGuardHome for $ARCH"

AGH_DIR="/data/adb/agh"
BIN_DIR="$AGH_DIR/bin"
SCRIPT_DIR="$AGH_DIR/scripts"
BACKUP_DIR="$AGH_DIR/backup"
SERVICE_DIR="/data/adb/service.d"

ui_print "- 解压模块基本文件..."
ui_print "- Extracting module basic files..."
unzip -o "$ZIPFILE" "uninstall.sh" -d $MODPATH
unzip -o "$ZIPFILE" "module.prop" -d $MODPATH
unzip -o "$ZIPFILE" "agh_service.sh" -d $SERVICE_DIR

if [ -d "$AGH_DIR" ]; then
  # Stop AdGuardHome
  local pid_file="/data/adb/agh/bin/agh_pid"
  if [ -f "$pid_file" ]; then
    ui_print "- 发现正在运行的 AdGuardHome 进程，正在停止..."
    ui_print "- Found running AdGuardHome process, stopping..."
    kill -9 $(cat "$pid_file")
    rm "$pid_file"
    sleep 1
  fi
  ui_print "- 发现旧版模块，是否保留原来的配置文件？"
  ui_print "- Found old version, do you want to keep the old configuration?"
  ui_print "- (音量上键 = 是, 音量下键 = 否)"
  ui_print "- (Volume Up = Yes, Volume Down = No)"
  key_click=""
  while [ "$key_click" = "" ]; do
    key_click="$(getevent -qlc 1 | awk '{ print $3 }' | grep 'KEY_')"
    sleep 0.2
  done
  case "$key_click" in
  "KEY_VOLUMEUP")
    ui_print "- 保留原来的配置文件..."
    ui_print "- Keeping old configuration files..."
    unzip -o "$ZIPFILE" "scripts/*" -x "scripts/config.sh" -d $AGH_DIR
    unzip -o "$ZIPFILE" "bin/*" -x "bin/AdGuardHome.yaml" -d $AGH_DIR
    ;;
  *)
    if [ ! -d "$BACKUP_DIR" ]; then
      mkdir -p "$BACKUP_DIR"
    else
      rm -r "$BACKUP_DIR"
      mkdir -p "$BACKUP_DIR"
    fi
    ui_print "- 正在备份旧配置文件..."
    ui_print "- Backing up old configuration files..."
    mv "$AGH_DIR/scripts/config.sh" "$BACKUP_DIR"
    mv "$AGH_DIR/bin/AdGuardHome.yaml" "$BACKUP_DIR"
    ui_print "- 正在解压脚本文件..."
    ui_print "- Extracting script files..."
    unzip -o "$ZIPFILE" "scripts/*" -d $AGH_DIR
    ui_print "- 正在解压二进制文件..."
    ui_print "- Extracting binary files..."
    unzip -o "$ZIPFILE" "bin/*" -d $AGH_DIR
    ;;
  esac
else
  ui_print "- 第一次安装，正在解压文件..."
  ui_print "- First time installation, extracting files..."
  mkdir -p "$AGH_DIR" "$BIN_DIR" "$SCRIPT_DIR"
  unzip -o "$ZIPFILE" "scripts/*" -d $AGH_DIR
  unzip -o "$ZIPFILE" "bin/*" -d $AGH_DIR
fi

ui_print "- 正在设置权限..."
ui_print "- Setting permissions..."
chmod +x "$BIN_DIR/AdGuardHome"
chmod +x "$SCRIPT_DIR/inotify.sh"
chmod +x "$SCRIPT_DIR/iptables.sh"
chmod +x "$SCRIPT_DIR/service.sh"
chmod +x "$SERVICE_DIR/agh_service.sh"
chmod +x "$MODPATH/uninstall.sh"
chown root:net_raw "$BIN_DIR/AdGuardHome"

ui_print "- 安装完成，请重启设备。"
ui_print "- Installation completed, please reboot."
