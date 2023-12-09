until [ $(getprop sys.boot_completed) ]; do
	sleep 1
done
MODDIR=${0%/*}
chmod +x "$MODDIR/AdGuardHome"
"$MODDIR/AdGuardHome" > "$MODDIR/AdGuardHome.log" 2>&1 &
# 读取配置文件的端口
adhome_port="$(cat "$MODDIR/AdGuardHome.yaml" | egrep '^  port: ' | sed -n 's/  port: //g;s/ //g;$p')"
# 新建规则链
iptables -t nat -N ADHOME
# 将 53 端口所有 upd tcp 流量转发到 adguard home
iptables -t nat -A ADHOME -p udp --dport 53 -j REDIRECT --to-ports ${adhome_port}
iptables -t nat -A ADHOME -p tcp --dport 53 -j REDIRECT --to-ports ${adhome_port}
ip6tables -t nat -A ADHOME -p udp --dport 53 -j REDIRECT --to-ports ${adhome_port}
ip6tables -t nat -A ADHOME -p tcp --dort 53 -j REDIRECT --to-ports ${adhome_port}
# 将 ADHOME 规则添加到 OUTPUT
iptables -t nat -A OUTPUT -j ADHOME
