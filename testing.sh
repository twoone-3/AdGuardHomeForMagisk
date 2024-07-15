#!/system/bin/sh
#
#如发现模块BUG，执行此脚本文件，把结果截图给作者，谢谢！
#
MODDIR=${0%/*}
NetworkAgentInfo="$(dumpsys connectivity | egrep 'NetworkAgentInfo\{' | egrep -v 'extra: ims')"
Network="$(echo "$NetworkAgentInfo" | egrep 'type: WIFI|ni\{WIFI')"
if [ -n "$Network" ]; then
	WIFI_Dns="$(echo "$Network" | egrep 'type: WIFI|ni\{WIFI' | sed -n 's/.* DnsAddresses: \[//g;s/\].*//g;s/ //g;p')"
	if [ ! -n "$WIFI_Dns" ]; then
		Network="$(echo "$NetworkAgentInfo" | egrep 'type: MOBILE|ni\{MOBILE')"
	fi
else
	Network="$(echo "$NetworkAgentInfo" | egrep 'type: MOBILE|ni\{MOBILE')"
fi
HostDns="$(echo "$Network" | egrep 'NetworkAgentInfo\{' | sed -n 's/.* DnsAddresses: \[//g;s/\].*//g;s/ //g;s/\///g;s/,/\\n/g;p')"
HostDns_n="$(echo -e "$HostDns" | egrep -v ':')"
type="$(cat "$MODDIR/type")"
mode="$(cat "$MODDIR/module.prop" | egrep '^description=' | sed -n 's/.*=\[//g;s/\].*//g;p')"
mode_conf="$(cat "$MODDIR/mode.conf")"
I_network="$(echo "$mode_conf" | egrep '^I_network=' | sed -n 's/.*=//g;$p')"
Lock_sleep="$(echo "$mode_conf" | egrep '^Lock_sleep=' | sed -n 's/.*=//g;$p')"
port_testing="$(echo "$mode_conf" | egrep '^port_testing=' | sed -n 's/.*=//g;$p')"
port_yaml="$(cat "$MODDIR/AdGuardHome.yaml" | egrep 'port:')"
start="$(ps -ef | egrep 'AdGuardHome' | egrep -v 'egrep')"
module_version="$(cat "$MODDIR/module.prop" | egrep 'version=' | sed -n 's/.*version=//g;$p')"
module_versionCode="$(cat "$MODDIR/module.prop" | egrep 'versionCode=' | sed -n 's/.*versionCode=//g;$p')"
AdGuardHome_byte="$(cat "$MODDIR/AdGuardHome" | wc -c)"
hosts_byte="$(cat '/system/etc/hosts' | wc -c)"
uname_m="$(uname -m)"
topdalao_head="$(cat "$MODDIR/topdalao" | head -n 1 | egrep '#!\/system\/bin\/sh')"
topdalao_H="0"
if [ -n "$topdalao_head" ]; then
	topdalao_H="1"
fi
echo --------- 版本 ----------
echo "$module_version ,$module_versionCode ,$AdGuardHome_byte"
echo --------- 获取dns ----------
echo "$HostDns_n"
echo "如果获取dns为空,但下面网络信息里却有dns,可找作者适配"
echo "I_network=$I_network"
echo ---------- 模式 ------------
echo "$mode ,$type"
echo "息屏不过滤$Lock_sleep"
echo "AdHome端口启动检测$port_testing"
echo "$port_yaml"
echo "$start"
pgrep 'AdGuardHome'
echo "系统架构：$uname_m ,hosts：$hosts_byte 字节 ,head：$topdalao_H ,$module_version ,$module_versionCode"
settings get global private_dns_mode
echo ---------- 端口 ------------
netstat -anp | egrep 'AdGuardHome'
echo --------- 设备信息 ----------
echo "serialno.$(getprop ro.serialno | sed -n 's/ //g;$p'),release.$(getprop ro.build.version.release | sed -n 's/ //g;$p'),sdk.$(getprop ro.build.version.sdk | sed -n 's/ //g;$p'),brand.$(getprop ro.product.brand | sed -n 's/ //g;$p'),model.$(getprop ro.product.model | sed -n 's/ //g;$p')"
echo ------- nat_TOPHOME --------
    iptables -t nat -n -L TOPHOME
echo -------- nat_OUTPUT --------
    iptables -t nat -n -L OUTPUT
echo --- ipv6_filter_OUTPUT -----
    ip6tables -t filter -n -L OUTPUT
echo --------- 网络信息 ----------
echo "$NetworkAgentInfo"
