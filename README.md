# AdGuardHome for Magisk
一个通过过滤DNS请求来屏蔽广告的 Magisk 模块，也能防止DNS污染，

![Static Badge](https://img.shields.io/badge/arm--64-support-blue)
![GitHub all releases](https://img.shields.io/github/downloads/twoone-3/AdguardHome/total)

加入我们的 [Telegram](https://t.me/adguardhome_for_magisk_release) 频道获取最新信息以及FAQ

# 用法
- 使用前需在设置里关闭 `私人/专用dns`，在 Magisk/KernelSU 刷入后重启即可使用，AdGuardHome 后台管理地址为 http://127.0.0.1:3000，用户名/密码root

# 特性
- DNS 上游为腾讯阿里 DoT，备用 DNS 为 Google 和 CloudFlare 的 DoT
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

# 鸣谢
- [AdguardHome_magisk](https://github.com/410154425/AdGuardHome_magisk)
- [akashaProxy](https://github.com/ModuleList/akashaProxy)