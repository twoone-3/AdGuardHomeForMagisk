# BREAKING CHANGES
- 修改了 config.sh 的配置文件格式
- 现在不会阻断除了 53 端口以外的 ipv6 流量了
- 将 disable_iptable 文件移到配置文件，详情见 config.sh
- 更新规则文件