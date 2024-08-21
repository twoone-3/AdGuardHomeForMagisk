# AdGuardHome for Magisk
English | [简体中文](README_zh.md)

A Magisk/KernelSU module that blocks ads by redirecting and filtering DNS requests

![Static Badge](https://img.shields.io/badge/arm--64-support-blue)
![Static Badge](https://img.shields.io/badge/arm--v7-support-blue)
![GitHub all releases](https://img.shields.io/github/downloads/twoone-3/AdguardHome/total)

Join our [Telegram](https://t.me/adguardhome_for_magisk_release) channel for the latest information

# Usage
- Before using, turn off `Private DNS` in the settings, flash into Magisk/KernelSU and restart to use. The AdGuardHome background management address is http://127.0.0.1:3000, username/password root
- Note: The module conflicts with proxy modules, if you need to access the Internet, please use proxy software

# Features
- The main DNS is Tencent DNSPod public DNS and Aliyun DNS, the backup DNS is Cloudflare DNS and Google DNS, you can change them in AdGuardHome's DNS settings to meet your needs
- Only built-in [AWAvenue-Ads-Rule](https://github.com/TG-Twilight/AWAvenue-Ads-Rule), power-saving, less false positives
- Can be started and stopped with third-party software by executing apply_iptables.sh and flush_iptables.sh located in /data/adb/modules/AdGuardHome/bin/, here is the quick import link for Anywhere (copy to clipboard to import)

Anywhere start link
```
anywhere://share/J2VP8X5qVhbI2sRvhZ6JXLZdx7Y6JLmsCgw9Wd7k7qce3ERvOaJlWHt61Y8oalvceraVdBkTbIymWLyhgxRQLeICFi3/GKuZYkqPJ3A6WQ8+xW4nTvmC9SwzER2X/9PFEtjgZsphvy2R8suN6BOE3Pm10gwmsdoLwCuLxs0uIA2VmP25Ur1GHTCogIgJoWBpJpz0QT1/LvBtNXXdFwkilQNF8VvcKAO3cgKns+I3hUk0T2rbsjVfj4UwxgYxi5Yg9yiV53hOzIzVZ9uZki3uy6TNTnThFXM+Hg88m8dron/cJM9Qg5Y979j0YTVrA9XakpnXKlF7UvaDM85FSjXZpkXCzbn00lWcvQ==
```
Anywhere stop link
```
anywhere://share/J2VP8X5qVhbI2sRvhZ2hdp4467QzpcHDlkAQil7Mg6oDOLdzYgAJO+9fKKenP2M28XWZ71jveGDq1E/sCmMAhBqd5N04LZkJp0EYtrFp7Vw9xPsYBhlmwlaKWljr9iIAMGWOulpW7Zzhm/tpfaDIKjweOGfIsONgcoWq89Idmb215WTrhfju+OeoNqDicBqrOLI5iyI8fTCQifRm7m7hq53WMgN/BoYbWnyE34AeVO2hq5btVggCTBGunrftXnlweSY4ngaN8CmhTlDWQeyjMJRZMooTPHwcQm3fisvBY6McMaVV5lSLHBe+MNaK1EwnzQ0RjNJh/3eoVGQJgUUyN8swAmtakrwaNA==
```

# FAQ
> Q: Why can't the module block some ads?

> A: The module blocks ads by forwarding DNS requests on port 53, so it cannot block ads transmitted over HTTPS, such as Youtube, Twitter, etc.

> Q: Why does the page slow down after installing the module?

> A: Because the module forwards all DNS requests to AdGuardHome, which then forwards them to public DNS upstreams, which are generally slower than the operator's DNS servers.

> Q: Why can't I access a page that I could access before after a while?

> A: Because public DNS requests are slow, the module's default configuration file enables optimistic caching, which may cause some outdated IPs to continue to be used after expiration. To disable, please turn off in AdGuardHome's DNS settings.

> Q: Can the module be used with proxy software?

> A: Yes, but it may cause some problems, such as some nodes being inaccessible. If this is serious, please refer to the previous FAQ and turn off optimistic caching.

# Acknowledgements
- [AdguardHome_magisk](https://github.com/410154425/AdGuardHome_magisk)
- [akashaProxy](https://github.com/ModuleList/akashaProxy)
- [box_for_magisk](https://github.com/taamarin/box_for_magisk)