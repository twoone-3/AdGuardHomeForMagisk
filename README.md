# Adguard Home for Magisk

![Static Badge](https://img.shields.io/badge/arm--64-support-blue)
![GitHub all releases](https://img.shields.io/github/downloads/twoone-3/AdguardHome/total)

> 在 Magisk 上运行 Adguard Home 程序

使用前需关闭私人dns，不可用wap接入点，AdGuard Home后台管理地址http://127.0.0.1:3000，用户名/密码root (若面具页面显示运行中，但无法打开后台，则可能是系统被精简web服务相关导致，或者换浏览器试下)，本机流量数据或wifi都支持过滤，AdGuard Home后台有数据变化代表模块生效。

# Features
- DNS上游为腾讯阿里的DOH（IP）
- 仅内置[秋风广告规则](https://github.com/TG-Twilight/AWAvenue-Ads-Rule)

# 特殊使用环境说明

1. VPN类软件：SSR软件默认设置可用可过滤、V2RayNG软件默认设置可用可过滤，Clash软件默认设置加勾选网络-系统代理(可用但无法过滤)，其它软件自行测试。
2. 免流类Magisk模块：免流类模块在全局规则模式都可以使用。
3. 翻墙类Magisk模块：AdGuard Home后台里的DNS上游需全部删除，加一条：127.0.0.1:X (X是翻墙模块的监听端口)，才可以使用。
4. 模块默认监听端口为5591，若你有特殊需求，可在AdGuardHome.yaml文件修改 port: 5591 需要重启生效。(注意：若使用53端口，则无法开启热点)

# 为什么要做这个模块

> 这个模块是由topdalao制作的 [AdguardHome_magisk](https://github.com/410154425/AdGuardHome_magisk) 改版的，经过了一番研究，我精简掉了大部分代码，更换了默认规则，二改有着更好的性能，且不会强制更新，该模块仅供学习交流，如各路大神有好的建议欢迎指出！