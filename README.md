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
![image](https://github.com/LiuFuBo1991/LFBSocialSDK/blob/master/imageFolder/icon_share_other_linke.jpeg)

-Objc属于链接必备参数，如果不加此项，会导致库文件无法被正确链接，SDK无法正常运行


### 加入依赖系统库

在General下的Linked Frameworks and Libraries添加系统库

![image](https://raw.githubusercontent.com/LiuFuBo1991/LFBSocialSDK/master/imageFolder/icon_share_libraries.png)

加入以下系统库


libsqlite3.tbd &nbsp;

CoreGraphics.framework


### 第三方平台库添加

根据集成的不同平台加入相关的依赖库，未列出平台则不需添加添加方式：选中项目Target -> General -> Linked Frameworks and Libraries列表中进行添加


微信(完整版)


精简版无需添加以下依赖库

SystemConfiguration.framework&nbsp;
CoreTelephony.framework&nbsp;
libsqlite3.tbd&nbsp;
libc++.tbd&nbsp;
libz.tbd&nbsp;


QQ(完整版)


精简版无需添加以下依赖库

SystemConfiguration.framework&nbsp;
libc++.tbd&nbsp;


新浪微博(精简版)

Photos.framework&nbsp;


新浪微博(完整版)


SystemConfiguration.framework&nbsp;
CoreTelephony.framework&nbsp;
ImageIO.framework&nbsp;
libsqlite3.tbd&nbsp;
libz.tbd &nbsp;
Photos.framework&nbsp;


### 配置SSO白名单


如果你的应用使用了如SSO授权登录或跳转到第三方分享功能，在iOS9/10下就需要增加一个可跳转的白名单，即LSApplicationQueriesSchemes，否则将在SDK判断是否跳转时用到的canOpenURL时返回NO，进而只进行webview授权或授权/分享失败。在项目中的info.plist中加入应用白名单，右键info.plist选择source code打开(plist具体设置在Build Setting -> Packaging -> Info.plist File可获取plist路径)请根据选择的平台对以下配置进行裁剪：


<pre><code>
<key>LSApplicationQueriesSchemes</key>
<array>
    /**!-- 微信 URL Scheme 白名单*/
    <string>wechat</string>
    <string>weixin</string>
    <!-- 新浪微博 URL Scheme 白名单-->
    <string>sinaweibohd</string>
    <string>sinaweibo</string>
    <string>sinaweibosso</string>
    <string>weibosdk</string>
    <string>weibosdk2.5</string>
    <!-- QQ、Qzone URL Scheme 白名单-->
    <string>mqqapi</string>
    <string>mqq</string>
    <string>mqqOpensdkSSoLogin</string>
    <string>mqqconnect</string>
    <string>mqqopensdkdataline</string>
    <string>mqqopensdkgrouptribeshare</string>
    <string>mqqopensdkfriend</string>
    <string>mqqopensdkapi</string>
    <string>mqqopensdkapiV2</string>
    <string>mqqopensdkapiV3</string>
    <string>mqqopensdkapiV4</string>
    <string>mqzoneopensdk</string>
    <string>wtloginmqq</string>
    <string>wtloginmqq2</string>
    <string>mqqwpa</string>
    <string>mqzone</string>
    <string>mqzonev2</string>
    <string>mqzoneshare</string>
    <string>wtloginqzone</string>
    <string>mqzonewx</string>
    <string>mqzoneopensdkapiV2</string>
    <string>mqzoneopensdkapi19</string>
    <string>mqzoneopensdkapi</string>
    <string>mqqbrowser</string>
    <string>mttbrowser</string>
    <string>tim</string>
    <string>timapi</string>
    <string>timopensdkfriend</string>
    <string>timwpa</string>
    <string>timgamebindinggroup</string>
    <string>timapiwallet</string>
    <string>timOpensdkSSoLogin</string>
    <string>wtlogintim</string>
    <string>timopensdkgrouptribeshare</string>
    <string>timopensdkapiV4</string>
    <string>timgamebindinggroup</string>
    <string>timopensdkdataline</string>
    <string>wtlogintimV1</string>
    <string>timapiV1</string>
    <!-- 支付宝 URL Scheme 白名单-->
    <string>alipay</string>
    <string>alipayshare</string>
    <!-- 钉钉 URL Scheme 白名单-->
      <string>dingtalk</string>
      <string>dingtalk-open</string>
    <!--Linkedin URL Scheme 白名单-->
    <string>linkedin</string>
    <string>linkedin-sdk2</string>
    <string>linkedin-sdk</string>
    <!-- 点点虫 URL Scheme 白名单-->
    <string>laiwangsso</string>
    <!-- 易信 URL Scheme 白名单-->
    <string>yixin</string>
    <string>yixinopenapi</string>
    <!-- instagram URL Scheme 白名单-->
    <string>instagram</string>
    <!-- whatsapp URL Scheme 白名单-->
    <string>whatsapp</string>
    <!-- line URL Scheme 白名单-->
    <string>line</string>
    <!-- Facebook URL Scheme 白名单-->
    <string>fbapi</string>
    <string>fb-messenger-api</string>
    <string>fb-messenger-share-api</string>
    <string>fbauth2</string>
    <string>fbshareextension</string>
    <!-- Kakao URL Scheme 白名单-->  
    <!-- 注：以下第一个参数需替换为自己的kakao appkey--> 
    <!-- 格式为 kakao + "kakao appkey"-->    
    <string>kakaofa63a0b2356e923f3edd6512d531f546</string>
    <string>kakaokompassauth</string>
    <string>storykompassauth</string>
    <string>kakaolink</string>
    <string>kakaotalk-4.5.0</string>
    <string>kakaostory-2.9.0</string>
   <!-- pinterest URL Scheme 白名单-->  
    <string>pinterestsdk.v1</string>
   <!-- Tumblr URL Scheme 白名单-->  
    <string>tumblr</string>
   <!-- 印象笔记 -->
    <string>evernote</string>
    <string>en</string>
    <string>enx</string>
    <string>evernotecid</string>
    <string>evernotemsg</string>
   <!-- 有道云笔记-->
    <string>youdaonote</string>
    <string>ynotedictfav</string>
    <string>com.youdao.note.todayViewNote</string>
    <string>ynotesharesdk</string>
   <!-- Google+-->
    <string>gplus</string>
   <!-- Pocket-->
    <string>pocket</string>
    <string>readitlater</string>
    <string>pocket-oauth-v1</string>
    <string>fb131450656879143</string>
    <string>en-readitlater-5776</string>
    <string>com.ideashower.ReadItLaterPro3</string>
    <string>com.ideashower.ReadItLaterPro</string>
    <string>com.ideashower.ReadItLaterProAlpha</string>
    <string>com.ideashower.ReadItLaterProEnterprise</string>
   <!-- VKontakte-->
    <string>vk</string>
    <string>vk-share</string>
    <string>vkauthorize</string>
   <!-- Twitter-->
    <string>twitter</string>
    <string>twitterauth</string>
</array>
</code></pre>


















