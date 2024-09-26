events="$1"
monitor_dir="$2"
monitor_file="$3"

AGH_DIR="/data/adb/agh"
SCRIPT_DIR="$AGH_DIR/scripts"

if [ "${monitor_file}" = "disable" ]; then
  if [ "${events}" = "d" ]; then
    $SCRIPT_DIR/service.sh start >>$AGH_DIR/agh.log 2>&1 &&
      $SCRIPT_DIR/iptables.sh enable >>$AGH_DIR/agh.log 2>&1
  elif [ "${events}" = "n" ]; then
    $SCRIPT_DIR/iptables.sh disable >>$AGH_DIR/agh.log 2>&1 &&
      $SCRIPT_DIR/service.sh stop >>$AGH_DIR/agh.log 2>&1
  fi
fi
