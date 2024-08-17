# AdGuardHome for Magisk
[English](README.md) | 简体中文

一个通过重定向并过滤 DNS 请求来屏蔽广告的 Magisk/KernelSU 模块

![Static Badge](https://img.shields.io/badge/arm--64-support-blue)
![Static Badge](https://img.shields.io/badge/arm--v7-support-blue)
![GitHub all releases](https://img.shields.io/github/downloads/twoone-3/AdguardHome/total)

加入我们的 [Telegram](https://t.me/adguardhome_for_magisk_release) 频道获取新消息

# 用法
- 使用前需在设置里关闭 `私人/专用dns`，在 Magisk/KernelSU 刷入后重启即可使用，AdGuardHome 后台管理地址为 http://127.0.0.1:3000，用户名/密码root
- 注意！本模块与可能与代理类模块冲突，同时使用两种模块会导致潜在问题！

# 特性
- DNS 上游为腾讯阿里 DoH，备用 DNS 为 Google 和 CloudFlare
- 仅内置[秋风广告规则](https://github.com/TG-Twilight/AWAvenue-Ads-Rule)，省电，少误杀
- 可配合第三方软件进行启动停止，通过执行位于 /data/adb/modules/AdGuardHome/bin/ 的 apply_iptables.sh 和 flush_iptables.sh，这里给出Anywhere的快捷导入链接（复制到剪贴板即可导入）

Anywhere启动链接
```
anywhere://share/J2VP8X5qVhbI2sRvhZ6JXLZdx7Y6JLmsCgw9Wd7k7qce3ERvOaJlWHt61Y8oalvceraVdBkTbIymWLyhgxRQLeICFi3/GKuZYkqPJ3A6WQ8+xW4nTvmC9SwzER2X/9PFEtjgZsphvy2R8suN6BOE3Pm10gwmsdoLwCuLxs0uIA2VmP25Ur1GHTCogIgJoWBpJpz0QT1/LvBtNXXdFwkilQNF8VvcKAO3cgKns+I3hUk0T2rbsjVfj4UwxgYxi5Yg9yiV53hOzIzVZ9uZki3uy6TNTnThFXM+Hg88m8dron/cJM9Qg5Y979j0YTVrA9XakpnXKlF7UvaDM85FSjXZpkXCzbn00lWcvQ==
```
Anywhere停止链接
```
anywhere://share/J2VP8X5qVhbI2sRvhZ2hdp4467QzpcHDlkAQil7Mg6oDOLdzYgAJO+9fKKenP2M28XWZ71jveGDq1E/sCmMAhBqd5N04LZkJp0EYtrFp7Vw9xPsYBhlmwlaKWljr9iIAMGWOulpW7Zzhm/tpfaDIKjweOGfIsONgcoWq89Idmb215WTrhfju+OeoNqDicBqrOLI5iyI8fTCQifRm7m7hq53WMgN/BoYbWnyE34AeVO2hq5btVggCTBGunrftXnlweSY4ngaN8CmhTlDWQeyjMJRZMooTPHwcQm3fisvBY6McMaVV5lSLHBe+MNaK1EwnzQ0RjNJh/3eoVGQJgUUyN8swAmtakrwaNA==
```

# FAQ
> Q: 为什么模块无法屏蔽某些广告?

> A: 模块通过转发53端口的DNS请求来实现广告屏蔽，因此无法屏蔽通过HTTPS传输的广告，如Youtube、Twitter等

> Q: 为什么装上模块后访问页面变慢?

> A: 因为模块会将所有DNS请求转发到AdGuardHome，再由AdGuardHome转发到上游的公共DNS，而这些DNS服务器一般比运营商的DNS服务器慢

> Q: 为什么本来可以访问的页面一段时间后出现了无法访问?

> A: 由于公共DNS请求较慢，模块默认配置文件里开启了乐观缓存，可能导致一些过时的IP在过期后仍然被使用，如需关闭请在AdGuardHome的DNS设置里关闭

> Q: 模块可以与代理软件一起使用吗?

> A: 可以，但是可能会导致一些问题，如某些节点无法访问，如这种情况很严重，请参见上一条FAQ，关闭乐观缓存

# 鸣谢
- [AdguardHome_magisk](https://github.com/410154425/AdGuardHome_magisk)
- [akashaProxy](https://github.com/ModuleList/akashaProxy)
- [box_for_magisk](https://github.com/taamarin/box_for_magisk)