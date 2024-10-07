# AdGuardHome for Magisk
[English](README_en.md) | 简体中文

一个通过重定向并过滤 DNS 请求来屏蔽广告的 Magisk/KernelSU 模块

![Static Badge](https://img.shields.io/badge/arm--64-support-blue)
![Static Badge](https://img.shields.io/badge/arm--v7-support-blue)
![GitHub all releases](https://img.shields.io/github/downloads/twoone-3/AdguardHome/total)
[![](https://img.shields.io/badge/Telegram-Join%20Channel-blue?logo=telegram)](https://t.me/adguardhome_for_magisk_release)
[![](https://img.shields.io/badge/Telegram-Join%20Group-blue?logo=telegram)](https://t.me/+mdZL11mJjxhkYjdl)

关注我们的频道以获取最新消息，或者加入我们的群组进行讨论！

# 用法
- 使用前需在设置里关闭 `私人/专用dns`，在 Magisk/KernelSU 刷入后即可使用，本模块默认后台管理地址为 http://127.0.0.1:3000 ，默认用户名/密码root
- 如果你从来没有接触过 AdGuardHome，你可以在这里找到[官方文档](https://github.com/AdguardTeam/AdGuardHome)，或者也可以看看这篇教程[AdGuard Home 中文指南](https://www.timochan.cn/posts/jc/adguard_home_configuration_guide)

# 特性
- DNS 服务器选用腾讯和阿里的公共 DNS，你也可以在 AdGuardHome 的 DNS 设置里更改来满足你的需求
- 仅内置[秋风广告规则](https://github.com/TG-Twilight/AWAvenue-Ads-Rule)，精准，轻量，少误杀
- 在 Magisk/KernelSU 中可以通过模块开关实时启动/关闭模块，当然你也可以在shell中模拟模块开关
```shell
touch /data/adb/modules/AdguardHome/disable
```
- 可修改位于 `/data/adb/agh/scripts/config.sh` 的配置文件来调整配置
- 在更新模块时，用户可自行选择是否保留原来的配置文件，即使你选择不保留，也会自动备份原来的配置文件到 `/data/adb/agh/backup` 目录下

# FAQ
> Q: 为什么模块无法屏蔽全部广告?

> A: 模块通过转发 53 端口的 DNS 请求来实现广告屏蔽，因此无法屏蔽通过 HTTPS 传输的广告，以及与正常内容同域名的广告，如 知乎，Youtube 等，好在大部分广告还是优先使用 53 端口的 DNS 请求。

> Q: 模块可以与其它代理模块/软件一起使用吗?

> A: 可以，一般的代理app可以直接兼容(这里推荐使用[FlClash](https://github.com/chen08209/FlClash))，且 AdGuardHome 的 DNS 查询会经过 VPN，其它代理模块看情况使用，可关闭自动 iptables 规则当作普通 DNS 使用

> Q: 为什么不接入 KernelSU 的 WebUI?

> A: 由于 KernelSU 的 WebUI 在无法显示确认弹窗，导致 AdGuardHome 管理端一些功能无法使用，因此暂时不接入



# 鸣谢
- [AdguardHome_magisk](https://github.com/410154425/AdGuardHome_magisk)
- [akashaProxy](https://github.com/ModuleList/akashaProxy)
- [box_for_magisk](https://github.com/taamarin/box_for_magisk)