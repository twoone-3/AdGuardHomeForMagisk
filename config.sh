# 是否开启 ipv6，默认关闭，开启可能导致某些应用走v6无法屏蔽广告
# true: 开启
# false: 关闭
ipv6=false
# 路由模式选择
# true: 黑名单
# false: 白名单
use_blacklist=true
# 应用报名列表
# 例如: packages_list=("com.tencent.mm" "com.tencent.mobileqq")
packages_list=()

# 以下内容无需修改
system_packages_file="/data/system/packages.list"
uid_list="/data/adb/modules/AdGuardHome/appuid.list"
redir_port=5591
adg_user="root"
adg_group="net_raw"
iptables_w="iptables -w 64"