#!/system/bin/sh

AGH_DIR="/data/adb/agh"
BIN_DIR="$AGH_DIR/bin"
SCRIPT_DIR="$AGH_DIR/scripts"
PID_FILE="$AGH_DIR/bin/agh_pid"
source "$AGH_DIR/scripts/config.sh"

exec >>$AGH_DIR/agh.log 2>&1

start_bin() {
  # to fix https://github.com/AdguardTeam/AdGuardHome/issues/7002
  export SSL_CERT_DIR="/system/etc/security/cacerts/"
  busybox setuidgid "$adg_user:$adg_group" "$BIN_DIR/AdGuardHome" --logfile "$BIN_DIR/AdGuardHome.log" --no-check-update &
  echo $! >"$PID_FILE"
}

stop_bin() {
  if [ ! -f "$PID_FILE" ]; then
    echo "AdGuardHome is not running"
    exit 1
  fi
  echo "Stopping AdGuardHome"
  kill -9 $(cat "$PID_FILE")
  rm "$PID_FILE"
}

case "$1" in
start)
  start_bin
  ;;
stop)
  stop_bin
  ;;
*)
  echo "Usage: $0 {start|stop}"
  exit 1
  ;;
esac
