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
- Disable `private/specialized dns` in settings before use, then flush it in Magisk/KernelSU and follow the instructions to configure it, AdGuardHome admin address is http://127.0.0.1:3000, default username/password root.

# Features
- The primary DNS is Tencent DNSPod public DNS and AliCloud DNS, the backup DNS is Cloudflare DNS and Google DNS, you can change the DNS settings in AdGuardHome to meet your needs.
- Only built-in [Autumn Breeze Ad Rule](https://github.com/TG-Twilight/AWAvenue-Ads-Rule), accurate, lightweight, and low false positives.

# FAQ
> Q: Why can't the module block some ads?

> A: The module blocks ads by forwarding DNS requests on port 53, so it can't block ads delivered over HTTPS, such as Youtube, Twitter, etc.

> Q: Why the page access slows down after installing the module?

> A: Because the module forwards all DNS requests to AdGuardHome, which in turn forwards them to the upstream public DNS, there is an extra layer of forwarding, but the module has optimistic caching turned on by default, which greatly reduces the latency on the second visit.

> Q: Why the page that was accessible is not accessible after a while?

> A: Due to the slower public DNS requests, the module has optimistic caching enabled in the default configuration file, which may lead to some outdated IPs still being used after the expiration date, you can clean up DNS cache in the background to alleviate the problem, or turn off optimistic caching.

> Q: Can the module be used with proxy software?

> A: Yes, but it may cause some problems, such as some nodes being unreachable. If this is a serious issue, please see the previous FAQ to turn off optimistic caching.

> Q: Does the module conflict with other proxy modules?

> A: No, you can use 127.0.0.1:5591 as the DNS server of the proxy module.

# Acknowledgments
- [AdguardHome_magisk](https://github.com/410154425/AdGuardHome_magisk)
- [akashaProxy](https://github.com/ModuleList/akashaProxy)
- [box_for_magisk](https://github.com/taamarin/box_for_magisk)
- Translated with DeepL.com (free version)