LFBSocialSDK
===========
[![License MIT](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/LiuFuBo1991/LFBSocialSDK)&nbsp;
[![Cocoapods](https://img.shields.io/badge/pod-v1.0.0-LFBModelFile.svg)](https://cocoapods.org/pods/LFBSocialSDK)&nbsp;
![Cocoapods](https://img.shields.io/badge/platform-osx%20%7C%20ios-LFBModelFile.svg)&nbsp;

LFBSocialSDK是一款第三方分享框架，提供了优雅便捷的调用方式，让你有更多的精力专注其他业务，只需要很少的配置，就可完成分享。


## LFBSocialSDK提供了哪些功能?

- [x] 支持微信、朋友圈、小程序、QQ、QQZone、新浪微博分享,并且后续会持续增加分享平台
- [x] 支持第三方的登陆功能
- [x] 支持个人自定义分享视图以及框架分享视图两种UI选择
- [x] 配置哪些平台，当使用框架展示视图时就展示你配置过的平台
- [x] 数据配置统一通过model配置，用户根据分享类型选择添加分享参数,项目提供有一份各个平台分享必要参数，用户可通过阅读文档来配置参数&nbsp;


## 安装


### CocoaPods

1、可以在Podfile中加入下面一行代码来使用LFBSocialSDK

pod 'LFBSocialSDK'

### 手动导入

1、下载LFBSocialSDK文件下所有内容并拖入你的工程中

2、导入 'LFBSocialSDK.h'


### 添加项目配置

在Other Linker Flags加入-Objc, 注意不要手动写为-Objc
