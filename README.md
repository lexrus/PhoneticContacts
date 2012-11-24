# PhoneticContacts

为你的联系人加上拼音属性，这样即使你的 iPhone 设置成英文，也能有按拼音分段的功能。

这是 Obj-C 的实现，参考了 [V2EX上网友写的AppleScript](http://v2ex.com/t/52860)，查拼音的事可以交给 CFStringTransform ，不需要 curl ，所以速度更快更省事。

在 Xcode 4.5+ 里打开项目，运行项目后联系人就有拼音属性了。