#!/system/bin/sh
SKIPUNZIP=1

# get device language
locale=$(getprop persist.sys.locale)
ui_print "- Current locale: $locale"

language=en
case $locale in
zh*)
  language=zh
  ;;
en*)
  language=en
  ;;
*)
  language=en
  ;;
esac

i18n_print() {
  local en_str="$1"
  local zh_str="$2"
  case $language in
  en)
    ui_print "$en_str"
    ;;
  zh)
    ui_print "$zh_str"
    ;;
  esac
}

i18n_print "- Installing AdGuardHome for $ARCH" "- 开始安装 AdGuardHome for $ARCH"

AGH_DIR="/data/adb/agh"
BIN_DIR="$AGH_DIR/bin"
SCRIPT_DIR="$AGH_DIR/scripts"
BACKUP_DIR="$AGH_DIR/backup"
PID_FILE="$AGH_DIR/bin/agh_pid"

i18n_print "- Extracting module basic files..." "- 解压模块基本文件..."
unzip -o "$ZIPFILE" "uninstall.sh" -d $MODPATH >/dev/null 2>&1
unzip -o "$ZIPFILE" "module.prop" -d $MODPATH >/dev/null 2>&1
unzip -o "$ZIPFILE" "service.sh" -d $MODPATH >/dev/null 2>&1
unzip -o "$ZIPFILE" "action.sh" -d $MODPATH >/dev/null 2>&1
unzip -o "$ZIPFILE" "webroot/*" -d $MODPATH >/dev/null 2>&1

if [ -d "$AGH_DIR" ]; then
  # TODO: remove in future versions
  if [ -f "/data/adb/service.d/agh_service.sh" ]; then
    rm "/data/adb/service.d/agh_service.sh"
  fi
  # Stop AdGuardHome
  if [ -f "$PID_FILE" ]; then
    i18n_print "- Found running AdGuardHome process, stopping..." "- 发现正在运行的 AdGuardHome 进程，正在停止..."
    kill -9 $(cat "$PID_FILE")
    rm "$PID_FILE"
    sleep 1
  fi
  i18n_print "- Found old version, do you want to keep the old configuration? (If not, it will be automatically backed up)" "- 发现旧版模块，是否保留原来的配置文件？（若不保留则自动备份）"
  i18n_print "- (Volume Up = Yes, Volume Down = No)" "- （音量上键 = 是, 音量下键 = 否）"
  key_click=""
  while [ "$key_click" = "" ]; do
    key_click="$(getevent -qlc 1 | awk '{ print $3 }' | grep 'KEY_')"
    sleep 0.2
  done
  case "$key_click" in
  "KEY_VOLUMEUP")
    i18n_print "- Keeping old configuration files" "- 保留原来的配置文件"
    unzip -o "$ZIPFILE" "scripts/*" -x "scripts/config.sh" -d $AGH_DIR >/dev/null 2>&1
    unzip -o "$ZIPFILE" "bin/*" -x "bin/AdGuardHome.yaml" -d $AGH_DIR >/dev/null 2>&1
    ;;
  *)
    if [ ! -d "$BACKUP_DIR" ]; then
      mkdir -p "$BACKUP_DIR"
    else
      rm -r "$BACKUP_DIR"
      mkdir -p "$BACKUP_DIR"
    fi
    i18n_print "- Backing up old configuration files..." "- 正在备份旧配置文件..."
    mv "$AGH_DIR/scripts/config.sh" "$BACKUP_DIR"
    mv "$AGH_DIR/bin/AdGuardHome.yaml" "$BACKUP_DIR"
    i18n_print "- Extracting script files..." "- 正在解压脚本文件..."
    unzip -o "$ZIPFILE" "scripts/*" -d $AGH_DIR >/dev/null 2>&1
    i18n_print "- Extracting binary files..." "- 正在解压二进制文件..."
    unzip -o "$ZIPFILE" "bin/*" -d $AGH_DIR >/dev/null 2>&1
    ;;
  esac
else
  i18n_print "- First time installation, extracting files..." "- 第一次安装，正在解压文件..."
  mkdir -p "$AGH_DIR" "$BIN_DIR" "$SCRIPT_DIR"
  unzip -o "$ZIPFILE" "scripts/*" -d $AGH_DIR >/dev/null 2>&1
  unzip -o "$ZIPFILE" "bin/*" -d $AGH_DIR >/dev/null 2>&1
fi

i18n_print "- Setting permissions..." "- 设置权限..."
chmod +x "$BIN_DIR/AdGuardHome"
chmod +x "$SCRIPT_DIR/inotify.sh"
chmod +x "$SCRIPT_DIR/iptables.sh"
chmod +x "$SCRIPT_DIR/service.sh"
chmod +x "$SCRIPT_DIR/action.sh"
chmod +x "$MODPATH/uninstall.sh"
chown root:net_raw "$BIN_DIR/AdGuardHome"

i18n_print "- Installation completed, please reboot." "- 安装完成，请重启设备。"
