# AdGuardHome for Magisk
> 一个通过过滤DNS请求来屏蔽广告的 Magisk 模块，也能防止DNS污染，无需配置，在 Magisk 里安装重启即可使用，使用前需关闭私人dns，AdGuardHome 后台管理地址为 http://127.0.0.1:3000，用户名/密码root

![Static Badge](https://img.shields.io/badge/arm--64-support-blue)
![GitHub all releases](https://img.shields.io/github/downloads/twoone-3/AdguardHome/total)

加入我们的 [Telegram](https://t.me/adguardhome_for_magisk_release) 频道获取最新信息

# 特性
- DNS上游为DoH，稳定，减少污染
- 仅内置[秋风广告规则](https://github.com/TG-Twilight/AWAvenue-Ads-Rule)，省电，不误杀

# 特殊使用环境说明
1. 代理软件：Clash Meta for Android 代理的应用无法过滤（可设置分应用来达到过滤效果），其它软件自行测试。
2. 免流类Magisk模块：免流类模块在全局规则模式都可以使用。
3. 翻墙类Magisk模块：AdGuard Home后台里的DNS上游需全部删除，加一条：127.0.0.1:X (X是翻墙模块的监听端口)，才可以使用。
4. 模块默认监听端口为5591，若你有特殊需求，可在AdGuardHome.yaml文件修改 port: 5591 需要重启生效。

# 鸣谢
- [AdguardHome_magisk](https://github.com/410154425/AdGuardHome_magisk)
- [akashaProxy](https://github.com/ModuleList/akashaProxy)