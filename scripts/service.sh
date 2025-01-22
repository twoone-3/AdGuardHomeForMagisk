#!/system/bin/sh

AGH_DIR="/data/adb/agh"
BIN_DIR="$AGH_DIR/bin"
SCRIPT_DIR="$AGH_DIR/scripts"
PID_FILE="$AGH_DIR/bin/agh_pid"
source "$AGH_DIR/scripts/config.sh"

exec >>$AGH_DIR/agh.log 2>&1

start_bin() {
  # check if AdGuardHome is already running
  if pgrep AdGuardHome >/dev/null; then
    echo "a another instance of AdGuardHome is already running"
    exit 1
  fi
  # to fix https://github.com/AdguardTeam/AdGuardHome/issues/7002
  export SSL_CERT_DIR="/system/etc/security/cacerts/"
  busybox setuidgid "$adg_user:$adg_group" "$BIN_DIR/AdGuardHome" --logfile "$BIN_DIR/AdGuardHome.log" --no-check-update &
  # wait for AdGuardHome to start
  sleep 1
  if pgrep AdGuardHome >/dev/null; then
    echo "AdGuardHome started"
    echo $! >"$PID_FILE"
  else
    echo "Failed to start AdGuardHome"
    exit 1
  fi
}

stop_bin() {
  if [ ! -f "$PID_FILE" ]; then
    echo "pid file not found"
    exit 1
  fi
  echo "Stopping AdGuardHome"
  kill $(cat "$PID_FILE")
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
