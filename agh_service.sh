#!/system/bin/sh

(
  while [ "$(getprop init.svc.bootanim)" != "stopped" ]; do
    echo "Waiting for system to finish booting..." >/data/adb/agh/agh.log
    sleep 5
  done
  AGH_DIR="/data/adb/agh"
  SCRIPT_DIR="$AGH_DIR/scripts"

  $SCRIPT_DIR/service.sh start >>$AGH_DIR/agh.log 2>&1 &&
    $SCRIPT_DIR/iptables.sh enable >>$AGH_DIR/agh.log 2>&1

  inotifyd $SCRIPT_DIR/inotify.sh /data/adb/modules/AdGuardHome:d,n >/dev/null 2>&1 &
) &