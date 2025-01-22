#!/system/bin/sh

AGH_DIR="/data/adb/agh"
source "$AGH_DIR/scripts/config.sh"
system_packages_file="/data/system/packages.list"
iptables_w="iptables -w 64"
ip6tables_w="ip6tables -w 64"

exec >>$AGH_DIR/agh.log 2>&1

find_packages_uid() {
  uid_list=()
  for package in "${packages_list[@]}"; do
    uid_list+=$(
      busybox awk -v p="${package}" '$1~p{print $2}' "${system_packages_file}"
    )
  done
}

enable_iptables() {
  ${iptables_w} -t nat -N ADGUARD
  # return requests from AdGuardHome
  ${iptables_w} -t nat -A ADGUARD -m owner --uid-owner $adg_user --gid-owner $adg_group -j RETURN
  # return requests from ignore_dest_list
  if [ $ignore_dest_list ]; then
    for subnet in ${ignore_dest_list[@]}; do
      ${iptables_w} -t nat -A ADGUARD -d $subnet -j RETURN
    done
  fi
  # return requests from bypassed apps
  if [ "$use_blacklist" = true ]; then
    find_packages_uid
    if [ ${#uid_list[@]} -ne 0 ]; then
      for uid in "${uid_list[@]}"; do
        ${iptables_w} -t nat -A ADGUARD -m owner --uid-owner $uid -j RETURN
      done
    fi
    # redirect DNS requests to AdGuardHome
    ${iptables_w} -t nat -A ADGUARD -p udp --dport 53 -j REDIRECT --to-ports $redir_port
    ${iptables_w} -t nat -A ADGUARD -p tcp --dport 53 -j REDIRECT --to-ports $redir_port
  else
    if [ ${#uid_list[@]} -ne 0 ]; then
      for uid in "${uid_list[@]}"; do
        ${iptables_w} -t nat -A ADGUARD -p udp --dport 53 -m owner --uid-owner $uid -j REDIRECT --to-ports $redir_port
        ${iptables_w} -t nat -A ADGUARD -p tcp --dport 53 -m owner --uid-owner $uid -j REDIRECT --to-ports $redir_port
      done
    fi
    ${iptables_w} -t nat -A ADGUARD -j RETURN
  fi
  # apply iptables rules
  ${iptables_w} -t nat -I OUTPUT -j ADGUARD
}

disable_iptables() {
  ${iptables_w} -t nat -D OUTPUT -j ADGUARD
  ${iptables_w} -t nat -F ADGUARD
  ${iptables_w} -t nat -X ADGUARD
}

del_block_ipv6_dns() {
  $ip6tables_w -D OUTPUT -p udp --dport 53 -j DROP
  $ip6tables_w -D OUTPUT -p tcp --dport 53 -j DROP
}

add_block_ipv6_dns() {
  $ip6tables_w -A OUTPUT -p udp --dport 53 -j DROP
  $ip6tables_w -A OUTPUT -p tcp --dport 53 -j DROP
}

case "$1" in
enable)
  enable_iptables
  if [ "$block_ipv6_dns" = true ]; then
    add_block_ipv6_dns
  fi
  ;;
disable)
  disable_iptables
  if [ "$block_ipv6_dns" = true ]; then
    del_block_ipv6_dns
  fi
  ;;
*)
  echo "Usage: $0 {enable|disable}"
  exit 1
  ;;
esac
