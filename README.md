# XQSiriDemo
一个测试Siri的Demo, Intents, IntentsUI, Siri Shortcuts


# info.plist

每次在 xx.intentdefinition 添加一个自定义类型 (系统类型也要, 不过系统会自动帮你添加进去, 但是系统不会帮你添加到 Extension 里面, 所以 Extension 还是要你自己去加), 就需要到 plist 里面 的  NSUserActivityTypes 字段下去添加多一个类型

extension Intents 里面的 info.plist 也要添加


# 坑

## CocoaPods 不能正常导入

在 stackoverflow 上找到这个放方法 https://stackoverflow.com/questions/52613170/ios-siri-intents-extension-i-dont-see-an-app-for-that-youll-need-to-download  
但这个还是不行  
后面又看到有人说, 自己打包成 framework, 然后再导进去, 看着好像类是能出来...  
但是, siri 它不买账...如果主项目没有 xx.intentdefinition 文件, 他会找不到该指令执行的APP...WTF

好吧, 最后选择把 xx.intentdefinition 打包成Framework,  这样可以有类名, 然后写处理逻辑相关文件.  
然后再让用库的人, 自己导入 xx.intentdefinition 文件到项目...虽然蠢, 但目前也没有发现其他解决方法了


不过这样运行时能运行...但是最烦就是报错提示了

```
objc[7424]: Class XQTestOneIntent is implemented in both /private/var/containers/Bundle/Application/4F3096CD-4D12-4291-8F0F-E13318CD8736/XQSiriDemo.app/Frameworks/XQSiriDemoFramework.framework/XQSiriDemoFramework (0x102f809f8) and /var/containers/Bundle/Application/4F3096CD-4D12-4291-8F0F-E13318CD8736/XQSiriDemo.app/XQSiriDemo (0x102bfa0e0). One of the two will be used. Which one is undefined.
objc[7424]: Class XQTestOneIntentResponse is implemented in both /private/var/containers/Bundle/Application/4F3096CD-4D12-4291-8F0F-E13318CD8736/XQSiriDemo.app/Frameworks/XQSiriDemoFramework.framework/XQSiriDemoFramework (0x102f80a58) and /var/containers/Bundle/Application/4F3096CD-4D12-4291-8F0F-E13318CD8736/XQSiriDemo.app/XQSiriDemo (0x102bfa140). One of the two will be used. Which one is undefined.
application(_:didFinishLaunchingWithOptions:)
```

就是说, 你有类名重复了, 小老弟.  
虽然不会崩溃， 但就总是有点不爽







