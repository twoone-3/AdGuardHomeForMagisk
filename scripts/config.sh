#!/system/bin/sh

# 添加 busybox 到 PATH
if ! command -v busybox &> /dev/null; then
  export PATH="/data/adb/magisk:/data/adb/ksu/bin:/data/adb/ap/bin:$PATH:/system/bin"
fi

# 本页所有配置需在模块关闭时修改

# 是否启用内置的 iptables 规则
# 内置的规则会重定向所有 DNS 请求到 AdGuardHome
enable_iptables=true

# 阻断 ipv6 的 DNS 请求
# 因为 DNS 请求会走 ipv6，所以阻断 ipv6 的 DNS 请求屏蔽效果更好
# 如果你在使用本模块时遇到与某些特殊软件冲突的情况，可优先尝试改本项目为 false
block_ipv6_dns=true

# 是否启用黑名单模式，否则为白名单模式
# 此项与下面的 packages_list 相关
# true: 黑名单模式，packages_list 中的应用的 DNS 请求将不会被重定向
# false: 白名单模式，只有 packages_list 中的应用的 DNS 请求将会被重定向
use_blacklist=true

# 应用包名列表，使用空格分割
# 例如: ("com.tencent.mm" "com.tencent.mobileqq")
packages_list=()

# 重定向端口，请与 ADGuardHome 的设置保持一致
redir_port=5591

# 用户组和用户，用于绕过 AdGuardHome 本身
adg_user="root"
adg_group="net_raw"
