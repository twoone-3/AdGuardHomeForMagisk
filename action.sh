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
  echo "trying to stop module"
  if [ "$enable_iptables" = true ]; then
    $SCRIPT_DIR/iptables.sh disable
    if [ $? -ne 0 ]; then
      update_description "🔴failed to disable iptables"
      exit 1
    fi
  fi
  $SCRIPT_DIR/service.sh stop
  if [ $? -ne 0 ]; then
    update_description "🔴failed to stop bin"
    exit 1
  fi
  echo "module is disabled"
  update_description "🔴module is disabled"
else
  echo "trying to start module"
  $SCRIPT_DIR/service.sh start
  if [ $? -ne 0 ]; then
    update_description "🔴failed to start bin"
    exit 1
  fi
  if [ "$enable_iptables" = true ]; then
    $SCRIPT_DIR/iptables.sh enable
    if [ $? -ne 0 ]; then
      update_description "🔴failed to enable iptables"
      exit 1
    fi
    echo "iptables is enabled"
    update_description "🟢bin is running \& iptables is enabled"
  else
    echo "iptables is disabled"
    update_description "🟢bin is running \& iptables is disabled"
  fi
fi

echo "Waiting for 1 second..."
echo "Refresh the page to see the changes."
sleep 1
