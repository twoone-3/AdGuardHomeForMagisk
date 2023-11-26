MODDIR=${0%/*}
# 读取配置文件的端口
port_yaml="$(cat "$MODDIR/AdGuardHome.yaml" | egrep '^  port: ' | sed -n 's/  port: //g;s/ //g;$p')"
# 新建规则链
iptables -t nat -N ADGUARDHOME
iptables -t nat -A ADGUARDHOME -p udp --dport 53 -j DNAT --to-destination "127.0.0.1:$port_yaml"
iptables -t nat -A ADGUARDHOME -p tcp --dport 53 -j DNAT --to-destination "127.0.0.1:$port_yaml"
iptables -t nat -I OUTPUT -j ADGUARDHOME
