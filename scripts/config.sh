#!/system/bin/sh

# 添加busybox到PATH
if ! command -v busybox &> /dev/null; then
  export PATH="/data/adb/magisk:/data/adb/ksu/bin:/data/adb/ap/bin:$PATH:/system/bin"
fi

# 是否启用 ipv6，因为ipv6的DNS请求无法转发，所以默认关闭
ipv6=false

# 路由模式选择，不需要更改
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