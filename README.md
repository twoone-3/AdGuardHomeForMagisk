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
- 使用前需在设置里关闭 `私人/专用dns`，在 Magisk/KernelSU 刷入并按照操作提示配置完成后即可使用，AdGuardHome 后台管理地址为 http://127.0.0.1:3000，默认用户名/密码root

# 特性
- 主 DNS 为腾讯和阿里，备用 DNS 为 Cloudflare 和 Google，你可以在 AdGuardHome 的 DNS 设置里更改来满足你的需求
- 仅内置[秋风广告规则](https://github.com/TG-Twilight/AWAvenue-Ads-Rule)，精准，轻量，少误杀

# FAQ
> Q: 为什么模块无法屏蔽某些广告?

> A: 模块通过转发 53 端口的 DNS 请求来实现广告屏蔽，因此无法屏蔽通过 HTTPS 传输的广告，如 Youtube、Twitter 等

> Q: 为什么装上模块后访问页面变慢?

> A: 因为模块会将所有 DNS 请求转发到 AdGuardHome，再由 AdGuardHome 转发到上游的公共 DNS，中间多了一层转发，但模块默认开启了乐观缓存，在第二次访问时将大大减少延迟

> Q: 为什么本来可以访问的页面一段时间后出现了无法访问?

> A: 由于公共 DNS 请求较慢，模块默认配置文件里开启了乐观缓存，可能导致一些过时的 IP 在过期后仍然被使用，可在后台清理DNS缓存来缓解，或者关闭乐观缓存

> Q: 模块可以与代理软件一起使用吗?

> A: 可以，但是可能会导致一些问题，如某些节点无法访问，如这种情况很严重，请参见上一条 FAQ，关闭乐观缓存

> Q: 模块与其它代理模块冲突吗?

> A: 不冲突，将代理模块的 DNS 服务器填写为 127.0.0.1:5591 即可

# 鸣谢
- [AdguardHome_magisk](https://github.com/410154425/AdGuardHome_magisk)
- [akashaProxy](https://github.com/ModuleList/akashaProxy)
- [box_for_magisk](https://github.com/taamarin/box_for_magisk)