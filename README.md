# PhoneticContacts

![Language](https://img.shields.io/badge/Language-Swift%203-orange.svg)
[![Git](https://img.shields.io/badge/GitHub-lexrus-blue.svg?style=flat)](https://github.com/lexrus)
[![Twitter](https://img.shields.io/badge/Twitter-@lexrus-blue.svg?style=flat)](http://twitter.com/lexrus)

为你的联系人加上拼音属性，
这样即使你的 iPhone 设置成英文，
也能有__按姓氏拼音首字母分段__的功能。

这个工具参考了 [V2EX 网友写的 AppleScript](http://v2ex.com/t/52860)，
但使用 CFStringTransform 查拼音，速度更快。

另外，有些汉字姓氏的读音比较特殊 (如「曾」作为姓时读作 zeng)。
我在网上随便找了一些，做了替换的处理，可能不全，欢迎补充。

请在 Xcode 8+ 里打开此项目，command + r 运行后联系人就有拼音属性了。
过不了多久(看脸)，这些更新后的联系人会通过 iCloud 同步到 iPhone。

