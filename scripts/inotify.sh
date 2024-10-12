events="$1"
monitor_dir="$2"
monitor_file="$3"

AGH_DIR="/data/adb/agh"
SCRIPT_DIR="$AGH_DIR/scripts"
MOD_PATH="/data/adb/modules/AdGuardHome"

exec >>$AGH_DIR/agh.log 2>&1

if [ "${monitor_file}" = "disable" ]; then
  if [ "${events}" = "d" ]; then
    $SCRIPT_DIR/service.sh start
    if [ ! -f "/data/adb/modules/AdGuardHome/disable_iptable" ]; then
      $SCRIPT_DIR/iptables.sh enable
      sed -i "s/description=\[.*\]/description=\[😎AdGuardHome is running and 🔗iptables is enabled\]/" "$MOD_PATH/module.prop"
    else
      sed -i "s/description=\[.*\]/description=\[😎AdGuardHome is running but ⛓️‍💥iptables is disabled\]/" "$MOD_PATH/module.prop"
    fi
  elif [ "${events}" = "n" ]; then
    if [ -f "/data/adb/modules/AdGuardHome/disable_iptable" ]; then
      $SCRIPT_DIR/iptables.sh disable
    fi
    $SCRIPT_DIR/service.sh stop
    sed -i "s/description=\[.*\]/description=\[😐AdGuardHome is stopped and ⛓️‍💥iptables is disabled\]/" "$MOD_PATH/module.prop"
  fi
fi

if [ "${monitor_file}" = "disable_iptable" ]; then
  if [ "${events}" = "d" ]; then
    if [ ! -f "/data/adb/modules/AdGuardHome/disable" ]; then
      $SCRIPT_DIR/iptables.sh enable
      sed -i "s/description=\[.*\]/description=\[😎AdGuardHome is running and 🔗iptables is enabled\]/" "$MOD_PATH/module.prop"
    fi
  elif [ "${events}" = "n" ]; then
    if [ ! -f "/data/adb/modules/AdGuardHome/disable" ]; then
      $SCRIPT_DIR/iptables.sh disable
      sed -i "s/description=\[.*\]/description=\[😎AdGuardHome is running but ⛓️‍💥iptables is disabled\]/" "$MOD_PATH/module.prop"
    fi
  fi
fi
