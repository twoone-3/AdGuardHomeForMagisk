#!/system/bin/sh

# 添加busybox到PATH
if ! command -v busybox &> /dev/null; then
  export PATH="/data/adb/magisk:/data/adb/ksu/bin:/data/adb/ap/bin:$PATH:/system/bin"
fi

# 是否手动模式，默认关闭，开启后不会自动应用iptables规则
# true: 开启
# false: 关闭
manual=false

# 是否开启 ipv6，默认关闭，开启可能导致某些应用走v6无法屏蔽广告
# true: 开启
# false: 关闭
ipv6=false

# 路由模式选择
# true: 黑名单
# false: 白名单
use_blacklist=true

# 重定向端口
redir_port=5591

# 用户组和用户
adg_user="root"
adg_group="net_raw"

# 应用包名列表
# 例如: ("com.tencent.mm" "com.tencent.mobileqq")
packages_list=()

# 以下内容无需修改
system_packages_file="/data/system/packages.list"
iptables_w="iptables -w 64"

