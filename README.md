# AdGuardHome for Magisk
一个通过过滤DNS请求来屏蔽广告的 Magisk 模块，也能防止DNS污染，

![Static Badge](https://img.shields.io/badge/arm--64-support-blue)
![GitHub all releases](https://img.shields.io/github/downloads/twoone-3/AdguardHome/total)

加入我们的 [Telegram](https://t.me/adguardhome_for_magisk_release) 频道获取最新信息以及FAQ

本模块基于[AdguardHome_magisk](https://github.com/410154425/AdGuardHome_magisk)二改而成，感谢原作者的付出

# 用法
- 使用前需在设置里关闭 `私人/专用dns`，在 Magisk/KernelSU 刷入后重启即可使用，AdGuardHome 后台管理地址为 http://127.0.0.1:3000，用户名/密码root

# 特性
- 修改DNS筛选规则为[秋风广告规则](https://github.com/TG-Twilight/AWAvenue-Ads-Rule)，省电，少误杀
- 添加了 KernelSU 的 web 管理页面支持
- 移除了强制自动更新
- 移除了赞助页面