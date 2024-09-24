#!/system/bin/sh

MODDIR="${0%/*}"
source "${MODDIR}/config.sh"

SSL_CERT_DIR="/system/etc/security/cacerts/" busybox setuidgid "$adg_user:$adg_group" $bin_path >>$log_path 2>&1 &

sleep 3
if [ ! -f "${MODDIR}/manual" ]; then
  "${MODDIR}/apply_iptables.sh"
fi
