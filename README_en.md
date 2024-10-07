# AdGuardHome for Magisk
English | [简体中文](README.md)

A Magisk/KernelSU module to block ads by redirecting and filtering DNS requests.

! [Static Badge](https://img.shields.io/badge/arm--64-support-blue)
! [Static Badge](https://img.shields.io/badge/arm--v7-support-blue) !
! [GitHub all releases](https://img.shields.io/github/downloads/twoone-3/AdguardHome/total)
[![](https://img.shields.io/badge/Telegram-Join%20Channel-blue?logo=telegram)](https://t.me/adguardhome_for_magisk_release)
[![](https://img.shields.io/badge/Telegram-Join%20Group-blue?logo=telegram)](https://t.me/+mdZL11mJjxhkYjdl)

Follow our channel for the latest news, or join our group for discussion!

# Usage
- Before using, turn off `Private/Custom DNS` in the settings, flash it in Magisk/KernelSU, and you can use it after installation. The default background management address is http://127.0.0.1:3000, and the default username/password is root.
- If you have never used AdGuardHome before, you can find the [official documentation](https://github.com/AdguardTeam/AdGuardHome) here, or you can also take a look at this tutorial [AdGuard Home 中文指南](https://www.timochan.cn/posts/jc/adguard_home_configuration_guide)

# Features
- The DNS server uses Tencent and Alibaba's public DNS, you can also change it in the DNS settings of AdGuardHome to meet your needs.
- Only built-in [Autumn Breeze Ad Rule](https://github.com/TG-Twilight/AWAvenue-Ads-Rule), accurate, lightweight, and low false positives.
- In Magisk/KernelSU, you can start/stop the module in real-time using the module switch, or you can simulate the module switch in the shell.
```shell
touch /data/adb/modules/AdguardHome/disable
```
- You can modify the configuration file located in `/data/adb/agh/scripts/config.sh` to adjust the configuration.
- When updating the module, users can choose whether to keep the original configuration file, even if you choose not to keep it, the original configuration file will be automatically backed up to the `/data/adb/agh/backup` directory.

# FAQ
> Q: Why can't the module block all ads?

> A: The module blocks ads by forwarding DNS requests on port 53, so it cannot block ads transmitted over HTTPS or ads on the same domain as normal content, such as Zhihu, Youtube, etc., but fortunately, most ads still prefer to use DNS requests on port 53.

> Q: Can the module be used with other proxy modules/software?

> A: Yes, general proxy apps can be directly compatible (here we recommend using [FlClash](https://github.com/chen08209/FlClash)), and AdGuardHome's DNS queries will pass through the VPN, other proxy modules can be used as needed, and the automatic iptables rules can be turned off for normal DNS use.

> Q: Why not integrate with KernelSU's WebUI?

> A: Because KernelSU's WebUI cannot display confirmation pop-ups, some functions of AdGuardHome's management end cannot be used, so it is not integrated for the time being.

# Acknowledgments
- [AdguardHome_magisk](https://github.com/410154425/AdGuardHome_magisk)
- [akashaProxy](https://github.com/ModuleList/akashaProxy)
- [box_for_magisk](https://github.com/taamarin/box_for_magisk)