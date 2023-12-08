until [ $(getprop sys.boot_completed) ]; do
	sleep 1
done
MODDIR=${0%/*}
chmod +x "$MODDIR/AdGuardHome"
"$MODDIR/AdGuardHome" >/dev/null 2>&1 &
# 读取配置文件的端口
port_yaml="$(cat "$MODDIR/AdGuardHome.yaml" | egrep '^  port: ' | sed -n 's/  port: //g;s/ //g;$p')"
# 新建规则链
iptables -t nat -N ADHOME
# 将 53 端口所有 upd tcp 流量转发到 adguard home
iptables -t nat -A ADHOME -p udp --dport 53 -j DNAT --to-destination "127.0.0.1:$port_yaml"
iptables -t nat -A ADHOME -p tcp --dport 53 -j DNAT --to-destination "127.0.0.1:$port_yaml"
# 将 ADHOME 规则添加到 OUTPUT
iptables -t nat -I OUTPUT -j ADHOME
