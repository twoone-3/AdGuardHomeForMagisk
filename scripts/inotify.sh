events="$1"
monitor_dir="$2"
monitor_file="$3"

AGH_DIR="/data/adb/agh"
SCRIPT_DIR="$AGH_DIR/scripts"
MOD_PATH="/data/adb/modules/AdGuardHome"
source "$AGH_DIR/scripts/config.sh"

exec >>$AGH_DIR/agh.log 2>&1

update_description () {
  sed -i "s/description=\[.*\]/description=\[$1\]/" "$MOD_PATH/module.prop"
}

if [ "${monitor_file}" = "disable" ]; then
  if [ "${events}" = "d" ]; then
    $SCRIPT_DIR/service.sh start
    if [ "$enable_iptables" = true ]; then
      $SCRIPT_DIR/iptables.sh enable
      update_description "🟢AdGuardHome is running | iptables is enabled"
    else
      update_description "🟢AdGuardHome is running | iptables is disabled"
    fi
  elif [ "${events}" = "n" ]; then
    if [ "$enable_iptables" = true ]; then
      $SCRIPT_DIR/iptables.sh disable
    fi
    $SCRIPT_DIR/service.sh stop
    update_description "🔴AdGuardHome is stopped"
  fi
fi