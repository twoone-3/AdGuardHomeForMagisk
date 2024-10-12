#!/system/bin/sh

AGH_DIR="/data/adb/agh"
SCRIPT_DIR="$AGH_DIR/scripts"
MOD_PATH="/data/adb/modules/AdGuardHome"

(
  exec >$AGH_DIR/agh.log 2>&1
  while [ "$(getprop init.svc.bootanim)" != "stopped" ]; do
    echo "Waiting for system to finish booting..." >>/data/adb/agh/agh.log
    sleep 8
  done

  if [ ! -f "$MOD_PATH/disable" ]; then
    $SCRIPT_DIR/service.sh start
    if [ ! -f "$MOD_PATH/disable_iptable" ]; then
      $SCRIPT_DIR/iptables.sh enable
      sed -i "s/description=\[.*\]/description=\[😎AdGuardHome is running and 🔗iptables is enabled\]/" "$MOD_PATH/module.prop"
    else
      sed -i "s/description=\[.*\]/description=\[😎AdGuardHome is running but ⛓️‍💥iptables is disabled\]/" "$MOD_PATH/module.prop"
    fi
  fi

  inotifyd $SCRIPT_DIR/inotify.sh $MOD_PATH:d,n >/dev/null 2>&1 &
) &
