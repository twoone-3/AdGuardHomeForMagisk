#!/system/bin/sh

(
  until [ "$(getprop init.svc.bootanim)" = "stopped" ]; do
    sleep 5
  done

  if [ -f "/data/adb/agh/scripts/start.sh" ]; then
    /data/adb/agh/scripts/start.sh
  else
    echo "File '/data/adb/agh/scripts/start.sh' not found"
  fi
) &
