# PhoneticContacts

[![Git](https://img.shields.io/badge/GitHub-lexrus-blue.svg?style=flat)](https://github.com/lexrus)

[![Twitter](https://img.shields.io/badge/twitter-@lexrus-blue.svg?style=flat)](http://twitter.com/lexrus)

为你的联系人加上拼音属性，这样即使你的 iPhone 设置成英文，也能有按拼音分段的功能。

<img width="319" src="https://cloud.githubusercontent.com/assets/219689/8078530/e9482cde-0f90-11e5-8c7d-9a879110f08c.png" alt="screenshot"/>

这是 <del>Objective-C</del> Swift 2 的实现，参考了 [V2EX上网友写的 AppleScript](http://v2ex.com/t/52860)，查拼音的事可以交给 CFStringTransform ，不需要 curl ，所以速度更快更省事。在网上随便找到一些姓的特殊读音，做了替换的处理，可能不全，欢迎补充。

在 Xcode 7.2+ 里打开项目，运行项目后联系人就有拼音属性了。

