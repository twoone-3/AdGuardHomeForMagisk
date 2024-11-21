AGH_DIR="/data/adb/agh"
SCRIPT_DIR="$AGH_DIR/scripts"
PID_FILE="$AGH_DIR/bin/agh_pid"
MOD_PATH="/data/adb/modules/AdGuardHome"

enable_iptables=false
enable_iptables=$(grep "^enable_iptables=" "$AGH_DIR/scripts/config.sh" | sed 's/^enable_iptables=//')
echo "enable_iptables: $enable_iptables"

update_description() {
  sed -i "s/description=\[.*\]/description=\[$1\]/" "$MOD_PATH/module.prop"
}

if [ -f "$PID_FILE" ]; then
  echo "Stopping AdGuardHome..."
  if [ "$enable_iptables" = true ]; then
    $SCRIPT_DIR/iptables.sh disable
  fi
  $SCRIPT_DIR/service.sh stop
  update_description "🔴AdGuardHome is stopped"
  echo "Done"
else
  echo "Starting AdGuardHome..."
  $SCRIPT_DIR/service.sh start
  if [ "$enable_iptables" = true ]; then
    $SCRIPT_DIR/iptables.sh enable
    update_description "🟢AdGuardHome is running | iptables is enabled"
  else
    update_description "🟢AdGuardHome is running | iptables is disabled"
  fi
  echo "Done"
fi

echo "waiting for 1 second"
sleep 1
