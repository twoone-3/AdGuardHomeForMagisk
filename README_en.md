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
- In Magisk/KernelSU, you can start/stop the module in real-time through the module switch.
- You can modify the configuration file located in `/data/adb/agh/scripts/config.sh` to adjust the configuration.
- When overwriting installation, the original module will be automatically backed up.

# FAQ
> Q: Why can't the module block some ads?

> A: The module blocks ads by forwarding DNS requests on port 53, so it cannot block ads transmitted over HTTPS or ads on the same domain as normal content, such as Zhihu, Youtube, etc.

> Q: Why does the page slow down after installing the module?

> A: Because the module forwards all DNS requests to AdGuardHome, which then forwards them to the upstream public DNS, adding an extra layer of forwarding, but the module has optimistic caching enabled by default, which greatly reduces latency on the second visit.

> Q: Why can't I access a page that I could access before after a while?

> A: Because public DNS requests are slow, the module's default configuration file has optimistic caching enabled, which may cause some outdated IPs to continue to be used after they expire, you can clear the DNS cache in the background to alleviate this, or disable optimistic caching.

> Q: Can the module be used with other proxy modules/software?

> A: Yes, general proxy apps are directly compatible, and AdGuardHome's DNS queries will pass through the VPN, other proxy modules can be used as needed, you can disable automatic iptables rules to use it as a regular DNS.

# Acknowledgments
- [AdguardHome_magisk](https://github.com/410154425/AdGuardHome_magisk)
- [akashaProxy](https://github.com/ModuleList/akashaProxy)
- [box_for_magisk](https://github.com/taamarin/box_for_magisk)
- Translated with DeepL.com (free version)