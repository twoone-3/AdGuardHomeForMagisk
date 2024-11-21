#!/system/bin/sh

AGH_DIR="/data/adb/agh"
SCRIPT_DIR="$AGH_DIR/scripts"
MOD_PATH="/data/adb/modules/AdGuardHome"

update_description() {
  sed -i "s/description=\[.*\]/description=\[$1\]/" "$MOD_PATH/module.prop"
}

exec >$AGH_DIR/agh.log 2>&1

(
  wait_time=0
  while [ "$(getprop init.svc.bootanim)" != "stopped" ]; do
    echo "Waiting for system to finish booting... ($wait_time)"
    sleep 3
    wait_time=$((wait_time + 3))
  done

  enable_iptables=false
  enable_iptables=$(grep "^enable_iptables=" "$AGH_DIR/scripts/config.sh" | sed 's/^enable_iptables=//')
  echo "enable_iptables: $enable_iptables"

  if [ ! -f "$MOD_PATH/disable" ]; then
    echo "start normally"
    $SCRIPT_DIR/service.sh start
    if [ "$enable_iptables" = true ]; then
      echo "enabling iptables"
      $SCRIPT_DIR/iptables.sh enable
      update_description "🟢AdGuardHome is running | iptables is enabled"
    else
      echo "don't enable iptables"
      update_description "🟢AdGuardHome is running | iptables is disabled"
    fi
  else
    echo "don't start"
    update_description "🔴AdGuardHome is stopped"
  fi

  inotifyd $SCRIPT_DIR/inotify.sh $MOD_PATH:d,n &
) &
