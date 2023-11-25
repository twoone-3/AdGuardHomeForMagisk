MODDIR=${0%/*}
# 读取配置文件的端口
port_yaml="$(cat "$MODDIR/AdGuardHome.yaml" | egrep '^  port: ' | sed -n 's/  port: //g;s/ //g;$p')"
# 新建规则链
iptables -t nat -N ADGUARDHOME
iptables -t nat -A ADGUARDHOME ! -d "10.35.53.10" -p udp --dport 53 -j DNAT --to-destination "127.0.0.1:$port_yaml"
iptables -t nat -A ADGUARDHOME ! -d "10.35.53.10" -p tcp --dport 53 -j DNAT --to-destination "127.0.0.1:$port_yaml"
iptables -t nat -A ADGUARDHOME -d "10.35.53.10" -p udp --dport 3553 -j DNAT --to-destination "127.0.0.1:9"
iptables -t nat -I OUTPUT -j ADGUARDHOME
# natOUTPUT="$(iptables -t nat -n -L OUTPUT)"
# nat_OUTPUT="$(echo "$natOUTPUT" | egrep 'ADGUARDHOME' | wc -l)"
# nat_OUTPUT_1="$(echo "$natOUTPUT" | sed -n '3p' | egrep 'ADGUARDHOME' | wc -l)"
# if [ -n "$natOUTPUT" ]; then
# 	if [ "$nat_OUTPUT" != "1" -o "$nat_OUTPUT_1" != "1" ]; then
# 		until [ "$nat_OUTPUT" = "0" ]; do
# 			iptables -t nat -D OUTPUT -j ADGUARDHOME
# 			nat_OUTPUT="$(($nat_OUTPUT - 1))"
# 		done
# 		iptables -t nat -I OUTPUT -j ADGUARDHOME
# 	fi
# fi
