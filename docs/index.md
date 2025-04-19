# AdGuardHome For Magisk Wiki

## 简易教程

点击 [Release](https://github.com/twoone-3/AdGuardHomeForMagisk/releases/latest/download/AdGuardHomeForMagisk_arm64.zip) 下载模块  
在 root 管理器中安装模块，重启后无需配置即可实现广告屏蔽

## 详细教程

### 1. 安装

本模块仅适用于已经 root 的安卓设备，支持 Magisk/KernelSU 等 root 方案  
在 Release 页面下载 zip 文件，提供了 arm64 和 armv7 两个版本，一般推荐使用 arm64 版  
在 root 管理器中安装模块，重启即可生效，注意要在设置里关闭 `私人/专用dns`  

### 2. 配置

AdGuardHome 后台地址为 `http://127.0.0.1:3000`，可以在 root 管理器中通过`打开`按钮打开 AdGuardHome，也可通过浏览器直接访问，默认账号密码都是 `root`  
不过值得注意的是在KernelSU的WebUI打开的后台可能有些需要弹窗确认的功能无法使用  
在 AdGuardHome 后台有查看DNS查询统计信息、修改各种DNS配置、查看日志等功能  
如果你想使用app来管理，也可以使用 [AdGuard Home Manager](https://github.com/JGeek00/adguard-home-manager)  

模块的目录有两个，`/data/adb/agh` 含有 AdGuardHome 二进制文件、工具脚本和配置文件，`/data/adb/modules/AdGuardHome` 里面有一些数据文件和启动脚本  

模块的配置文件有两个，`/data/adb/agh/bin/AdGuardHome.yaml` 是 AdGuardHome 的配置文件，`/data/adb/agh/script/config.sh` 是模块的配置文件，具体见文件内注释  
在更新模块时，用户自行选择是否保留原来的配置文件，即使你选择不保留，也会自动备份原来的配置文件到 `/data/adb/agh/backup` 目录下  

### 3. 模块控制

模块的状态会实时显示在`module.prop`文件中，在root管理器中可以看到模块的状态信息（如果没刷新请手动刷新）  
模块实时监测`/data/adb/modules/AdGuardHome`目录下的`disable`文件，如果存在则禁用模块，不存在则启用模块  

如果你想用其他方法来启停，你可以在文件管理器中手动创建和删除文件，也可以使用shell命令

```shell
touch /data/adb/modules/AdGuardHome/disable
```

```shell
rm /data/adb/modules/AdGuardHome/disable
```

实际上本模块可以分为两部分，一部分是 AdGuardHome 本身，它在本地搭建了一个可自定义拦截功能的 DNS 服务器，另一部分是 iptables 转发规则，它负责将本机所有53端口出口流量重定向到 AdGuardHome

### 4. 与代理软件共存

代理软件分两种：代理 app (如 [NekoBox](https://github.com/MatsuriDayo/NekoBoxForAndroid),[FlClash](https://github.com/chen08209/FlClash)) 和 代理模块 (如 [box for magisk](https://github.com/taamarin/box_for_magisk))  

理论上本模块可以与任意代理app兼容，唯一需要注意的点是如果你启用了模块的iptables转发规则，最好在代理app把 `ipv6` 关闭  

代理app的 `分应用代理` 很有用，你可以将国内的app选择绕过模式来避免不必要的流量经过代理软件，此时这些绕过的应用也能正常屏蔽广告  

而要使用代理模块，建议将模块的 iptables 转发规则禁用，如果你不禁用也能正常使用，那就不需要下一步了  

禁用后模块仅运行 AdGuardHome 本身，接着我们将代理模块配置中的上游 DNS 服务器改为 `127.0.0.1:5591` 即可让代理软件的所有 DNS 查询都经过 AdGuardHome 进行广告屏蔽
以下给出了 Mihomo 的配置示例：

```yaml
dns:
  enable: true
  ipv6: true

  default-nameserver:
    - 127.0.0.1:5591

  listen: 0.0.0.0:1053
  use-hosts: true
  enhanced-mode: fake-ip
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - '*.lan'

  nameserver:
    - 127.0.0.1:5591
```

## 结尾的话

> 恭喜你阅读完了本 Wiki，如果有什么好的建议，可加入[Telegram群](https://t.me/+mdZL11mJjxhkYjdl)来讨论，另外本模块是 [秋风广告规则](https://github.com/TG-Twilight/AWAvenue-Ads-Rule) 官方模块，秋风规则是轻量、精准、高效的广告规则，也请有能力的朋友多多贡献
