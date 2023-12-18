until [ $(getprop sys.boot_completed) ]; do
	sleep 1
done
MODDIR="${0%/*}"
ADG_DIR="$MODDIR/bin"
chmod +x "$ADG_DIR/AdGuardHome"
chown "root:net_admin" "$ADG_DIR/AdGuardHome"
chown "root:net_admin" "$ADG_DIR/AdGuardHome.yaml"
setuidgid "root:net_admin" "$ADG_DIR/AdGuardHome" >"$ADG_DIR/AdGuardHome.log" 2>&1 &
# 读取配置文件的端口
adhome_port="$(cat "$ADG_DIR/AdGuardHome.yaml" | egrep '^  port: ' | sed -n 's/  port: //g;s/ //g;$p')"

apply_rules() {
	# 新建规则链
	iptables -t nat -N ADGUARD
	# 返回所有 AdGuardHome 的请求
	iptables -t nat -A ADGUARD -m owner --uid-owner "root" --gid-owner "net_admin" -j RETURN
	# 将 53 端口所有 udp 流量转发到 adguard home
	iptables -t nat -A ADGUARD -p udp --dport 53 -j REDIRECT --to-ports ${adhome_port}
	ip6tables -t nat -A ADGUARD -p udp --dport 53 -j REDIRECT --to-ports ${adhome_port}
	# 将 ADGUARD 规则添加到 OUTPUT
	iptables -t nat -A OUTPUT -j ADGUARD
}

flush_rules() {
	iptables -t mangle -F ADGUARD
	iptables -t mangle -X ADGUARD

	ip6tables -t mangle -F ADGUARD
	ip6tables -t mangle -X ADGUARD
}

apply_rules
