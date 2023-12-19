# Adguard Home for Magisk
> 在 Magisk 上运行 Adguard Home 程序

![Static Badge](https://img.shields.io/badge/arm--64-support-blue)
![GitHub all releases](https://img.shields.io/github/downloads/twoone-3/AdguardHome/total)
[![Telegram](https://img.shields.io/badge/Telegram-2CA5E0.svg?logo=telegram&logoColor=white)](https://t.me/adguardhome_for_magisk_release)

# 这是什么？
> 一个通过过滤DNS请求来屏蔽广告的magisk模块，也能防止DNS污染，无需配置，在magisk里安装重启即可使用，使用前需关闭私人dns，AdGuard Home后台管理地址http://127.0.0.1:3000，用户名/密码root

# Features
- DNS上游为DoH，快速稳定
- 仅内置[秋风广告规则](https://github.com/TG-Twilight/AWAvenue-Ads-Rule)，省电，不误杀

# 特殊使用环境说明
1. 代理软件：Clash Meta for Android 代理的应用无法过滤（可设置分应用来达到过滤效果），其它软件自行测试。
2. 免流类Magisk模块：免流类模块在全局规则模式都可以使用。
3. 翻墙类Magisk模块：AdGuard Home后台里的DNS上游需全部删除，加一条：127.0.0.1:X (X是翻墙模块的监听端口)，才可以使用。
4. 模块默认监听端口为5591，若你有特殊需求，可在AdGuardHome.yaml文件修改 port: 5591 需要重启生效。

# 鸣谢
- [AdguardHome_magisk](https://github.com/410154425/AdGuardHome_magisk)
- [akashaProxy](https://github.com/ModuleList/akashaProxy)