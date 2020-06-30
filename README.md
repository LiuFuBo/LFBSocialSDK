![image](https://github.com/LiuFuBo/LFBSocialSDK/blob/master/LFBSocialSDKDemoTests/banner.png)

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

<pre><code>
libsqlite3.tbd &nbsp;
CoreGraphics.framework
</code></pre>


### 第三方平台库添加

根据集成的不同平台加入相关的依赖库，未列出平台则不需添加添加方式：选中项目Target -> General -> Linked Frameworks and Libraries列表中进行添加


微信(完整版)


精简版无需添加以下依赖库

<pre><code>
SystemConfiguration.framework&nbsp;
CoreTelephony.framework&nbsp;
libsqlite3.tbd&nbsp;
libc++.tbd&nbsp;
libz.tbd&nbsp;   
</code></pre>



QQ(完整版)


精简版无需添加以下依赖库

<pre><code>
SystemConfiguration.framework&nbsp;
libc++.tbd&nbsp;    
</code></pre>



新浪微博(精简版)

<pre><code> 
Photos.framework&nbsp;
</code></pre>



新浪微博(完整版)

<pre><code>  
SystemConfiguration.framework&nbsp;
CoreTelephony.framework&nbsp;
ImageIO.framework&nbsp;
libsqlite3.tbd&nbsp;
libz.tbd &nbsp;
Photos.framework&nbsp;
</code></pre>



### 配置SSO白名单


如果你的应用使用了如SSO授权登录或跳转到第三方分享功能，在iOS9/10下就需要增加一个可跳转的白名单，即LSApplicationQueriesSchemes，否则将在SDK判断是否跳转时用到的canOpenURL时返回NO，进而只进行webview授权或授权/分享失败。在项目中的info.plist中加入应用白名单，右键info.plist选择source code打开(plist具体设置在Build Setting -> Packaging -> Info.plist File可获取plist路径)请根据选择的平台对以下配置进行裁剪：


<pre><code>
<key>LSApplicationQueriesSchemes</key>
<array>
    /**!-- 微信 URL Scheme 白名单*/
    <string>wechat</string>
    <string>weixin</string>
    /** 新浪微博 URL Scheme 白名单*/
    <string>sinaweibohd</string>
    <string>sinaweibo</string>
    <string>sinaweibosso</string>
    <string>weibosdk</string>
    <string>weibosdk2.5</string>
    /** QQ、Qzone URL Scheme 白名单*/
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
    /** 支付宝 URL Scheme 白名单*/
    <string>alipay</string>
    <string>alipayshare</string>
    /** 钉钉 URL Scheme 白名单*/
      <string>dingtalk</string>
      <string>dingtalk-open</string>
    /** Linkedin URL Scheme 白名单*/
    <string>linkedin</string>
    <string>linkedin-sdk2</string>
    <string>linkedin-sdk</string>
    /** 点点虫 URL Scheme 白名单*/
    <string>laiwangsso</string>
    /** 易信 URL Scheme 白名单*/
    <string>yixin</string>
    <string>yixinopenapi</string>
    /** instagram URL Scheme 白名单*/
    <string>instagram</string>
    /** whatsapp URL Scheme 白名单*/
    <string>whatsapp</string>
    /** line URL Scheme 白名单*/
    <string>line</string>
    /** Facebook URL Scheme 白名单*/
    <string>fbapi</string>
    <string>fb-messenger-api</string>
    <string>fb-messenger-share-api</string>
    <string>fbauth2</string>
    <string>fbshareextension</string>
    /** Kakao URL Scheme 白名单,注：以下第一个参数需替换为自己的kakao appkey,格式为 kakao + "kakao appkey*/
    <string>kakaofa63a0b2356e923f3edd6512d531f546</string>
    <string>kakaokompassauth</string>
    <string>storykompassauth</string>
    <string>kakaolink</string>
    <string>kakaotalk-4.5.0</string>
    <string>kakaostory-2.9.0</string>
   /** pinterest URL Scheme 白名单*/ 
    <string>pinterestsdk.v1</string>
   /** Tumblr URL Scheme 白名单*/  
    <string>tumblr</string>
   /** 印象笔记 */
    <string>evernote</string>
    <string>en</string>
    <string>enx</string>
    <string>evernotecid</string>
    <string>evernotemsg</string>
   /** 有道云笔记*/
    <string>youdaonote</string>
    <string>ynotedictfav</string>
    <string>com.youdao.note.todayViewNote</string>
    <string>ynotesharesdk</string>
   /** Google+*/
    <string>gplus</string>
   /** Pocket*/
    <string>pocket</string>
    <string>readitlater</string>
    <string>pocket-oauth-v1</string>
    <string>fb131450656879143</string>
    <string>en-readitlater-5776</string>
    <string>com.ideashower.ReadItLaterPro3</string>
    <string>com.ideashower.ReadItLaterPro</string>
    <string>com.ideashower.ReadItLaterProAlpha</string>
    <string>com.ideashower.ReadItLaterProEnterprise</string>
   /** VKontakte*/
    <string>vk</string>
    <string>vk-share</string>
    <string>vkauthorize</string>
   /** Twitter*/
    <string>twitter</string>
    <string>twitterauth</string>
</array>
</code></pre>


### 配置URL Scheme

* URL Scheme是通过系统找到并跳转对应app的一类设置，通过向项目中的info.plist文件中加入URL types可使用第三方平台所注册的appkey信息向系统注册你的app，当跳转到第三方应用授权或分享后，可直接跳转回你的app。

* 添加URL Types可工程设置面板设置

![image](https://github.com/LiuFuBo1991/LFBSocialSDK/blob/master/imageFolder/icon_share_scheme.jpeg)


### 权限配置

微博

从微博SDk 3.2.1，即U-Share 6.9.1版开始，支持微博分享多张图片。需在 info.plist 文件中配置相册权限

<pre><code>
/** <key>NSPhotoLibraryUsageDescription</key> */
/** <string>App需要您的同意,才能访问相册</string> */
</code></pre>


### 初始化配置

应用启动后，需要在AppDelegate.m里面配置对应平台的AppKey和AppSecret

<pre><code>
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configChannel];
    return YES;
}

- (void)configChannel{
    LFBShareChannelConfig *config = [[LFBShareChannelConfig alloc]init];
    [[LFBChannelManager sharedManager] setDelegate:config];
    [config setChannelType:LFBChannelTypeWX appKey:@"wx515bbc9e05bf9dx80" appSecret:@"1d44d80947bb3821506e440116f73168"];
    [config setChannelType:LFBChannelTypePYQ appKey:@"wx515bbc9e05bf9dx80" appSecret:@"1d44d80947bb3821506e440116f73168"];
    [config setChannelType:LFBChannelTypeQQ appKey:@"1101053347" appSecret:nil];
    [config setChannelType:LFBChannelTypeQQZone appKey:@"1101053237" appSecret:nil];
    [config setChannelType:LFBChannelTypeSinaWB appKey:@"1843261032" appSecret:@"b2f5b2b661babaa3c01b57312decffd7"];
}

</code></pre>

### 设置系统回调

<pre><code>
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if (@available(iOS 9.0, *)) {
        return  [self handlerOuterURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [self handlerOuterURL:url sourceApplication:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [self handlerOuterURL:url sourceApplication:sourceApplication];
}

- (BOOL)handlerOuterURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication{
    return [[LFBChannelManager sharedManager] handleOpenURL:url];
}

</code></pre>


### 基本使用

当用户自定义分享渠道时，有两种调用方式分别如下:

* 带Block回调

<pre><code>
    
    LFBSharePlateforms *model = [[LFBSharePlateforms alloc]init];
    model.shareType = LFBChannelTypeWX;
    model.shareInfoType = LFBShareInfoTypeApplet;
    model.title = @"小程序";
    model.text = @"大家来找茬!!!";
    model.webPageUrl =@"https://tapi.liufuboExample.com/activefront/qrcode/shared_car_get_coupon?coupon_template_id=115";
    model.userName = @"gh_a4ff22eef403";
    model.path = @"pages/getcoupon?coupon_template_id=115";
    model.hdImageData = nil;
    model.withShareTicket = YES;
    model.miniProgramType = LFBShareMiniInfoTypeRelease;
    [LFBShareMoudle shareObject:model completion:^(id sender, LFBChannelType channelType, LFBShareState shareState) {
        
    }];

</code></pre>


* 不带block的调用方式

<pre><code>
    
    LFBSharePlateforms *model = [[LFBSharePlateforms alloc]init];
    model.shareType = LFBChannelTypeWX;
    model.shareInfoType = LFBShareInfoTypeApplet;
    model.title = @"小程序";
    model.text = @"大家来找茬!!!";
    model.webPageUrl =@"https://tapi.liufuboExample.com/activefront/qrcode/shared_car_get_coupon?coupon_template_id=115";
    model.userName = @"gh_a4ff22eef403";
    model.path = @"pages/getcoupon?coupon_template_id=115";
    model.hdImageData = nil;
    model.withShareTicket = YES;
    model.miniProgramType = LFBShareMiniInfoTypeRelease;
    [LFBShareMoudle shareObject:model];

</code></pre>


使用框架自带UI分享时,调用方式如下:

<pre><code>
    
    LFBSharePlateforms *model = [[LFBSharePlateforms alloc]init];
    model.shareType = LFBChannelTypeWX;
    model.shareInfoType = LFBShareInfoTypeApplet;
    model.title = @"小程序";
    model.text = @"大家来找茬!!!";
    model.webPageUrl =@"https://tapi.liufuboExample.com/activefront/qrcode/shared_car_get_coupon?coupon_template_id=115";
    model.userName = @"gh_a4ff22eef403";
    model.path = @"pages/getcoupon?coupon_template_id=115";
    model.hdImageData = nil;
    model.withShareTicket = YES;
    model.miniProgramType = LFBShareMiniInfoTypeRelease;
    [LFBShareMoudle showShareViewWithObject:model];

</code></pre>


关于登陆功能的使用方法:

<pre><code>
    
   [LFBShareMoudle loginWithChannelType:LFBChannelTypeWX success:^(LFBChannelBase *channel, id data) {
        LFBUserInfo *userInfo = data;
        NSLog(@"%@",userInfo.nickname);
    } fail:^(LFBChannelBase *channel, NSError *error) {
        NSLog(@"%@",error);
    } cancel:^(LFBChannelBase *channel) {
        NSLog(@"取消操作");
    }];

</code></pre>

### 关于升级微信分享SDK(WechatOpenSDK)到1.8.6以后，分享功能无法使用问题。

 苹果iOS 13系统版本安全升级，为此WechatOpenSDK在1.8.6版本进行了适配。 1.8.6版本支持Universal Links方式跳转，对openSDK分享进行合法性校验。因为微信SDK的变化，在升级openSDK以后，如果您的LFBSocialSDK不是最新版本，则会导致微信分享调用失败。这里强烈建议您升级LFBSocialSDK到最新版本。

 环境要求:
 > 1.SDK版本必须在1.8.6或以上
 > 2.微信版本7.0.7或以上
 > 3.系统版本iOS12或以上

SDK接入指引

1.根据[苹果文档](https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content)配置应用的Universal Links


微信使用第三方App的Universal Links唤起第三方App时，会在Universal Links末尾拼接路径和参数，因此开发者Universal Links配置必须加上通配符，并测试Universal Links拼接字符串能否唤起app

建议Universal Links配置path，例如"/app/* ", 避免全域命中Universal Links跳转

咱们以路劲applesite为例:
```
{
    "applinks": {
        "apps": [],
        "details": [{
            "appID": "6VUB45YDCB.com.yxyt.YXYT",
            "paths": ["/applesite/*"]
        }]
    }
}

```

注意：这里的appID格式为: TeamID（apple developer开发者账号登陆后可获取）+ . + BundleID(App项目可以查看)
     path这里可以直接填 " * " 也可以填写路劲并带*

 这里需要将该json文件上传至服务器根目录下，这里假设根域名为www.social.com,则通过通过https://www.social.com/apple-app-site-association访问可以查看到文件内容或者下载本地配置则成功。咱们还可以通过苹果提供的 [验证网址](https://search.developer.apple.com/appsearch-validation-tool) 来直接验证apple-app-site-association设置是否生效。

 2.微信开放平台配置Universal Links

 ![image](https://raw.githubusercontent.com/LiuFuBo1991/LFBSocialSDK/master/imageFolder/icon_share_universal_set.png)

 3.登录苹果开发者后台，在设置证书的页面找到 Identifiers -> App ID（设置包名）里，在对应的BundleId下勾选 Associated Domains如下图，然后保存设置，然后重新生成配置文件。
  ![image](https://raw.githubusercontent.com/LiuFuBo1991/LFBSocialSDK/master/imageFolder/icon_share_appstore_doam.png)

 4.在 Xcode 中，选择你的工程设置项，选中“TARGETS”一栏，在“info”标签栏下的“URL type“添加“URL scheme”为你所注册的应用程序 id：在“LSApplicationQueriesSchemes“添加weixin 和weixinULAPI（如下图所示）
 
 [image](https://raw.githubusercontent.com/LiuFuBo1991/LFBSocialSDK/master/imageFolder/icon_share_schem_set.png)
 
 5.打开Associated Domains开关，将Universal Links域名加到配置上

 ![image](https://raw.githubusercontent.com/LiuFuBo1991/LFBSocialSDK/master/imageFolder/icon_share_associatedDomain.png)

 注意点:在 Associated Domains里面配置的Universal Links必须要以applinks:开头，后面写上域名。
 例如：applinks:www.test.cn


 配置成功以后，咱们就可以来验证一下Universal Links是否生效

SDK成功验证指引

 1.确认微信的Universal Links能正常访问

 首先，确认微信(7.0.7或以上版本)的Universal Links在设备上正常，以确保openSDK与微信双向使用Universal Links通信，Safari输入您配置好的通用连接，下拉查看是否有打开微信入口(如下图)。若无入口，可能是App的Universal Links配置有问题，或者网络状态异常。

![image](https://raw.githubusercontent.com/LiuFuBo1991/LFBSocialSDK/master/imageFolder/icon_share_universal_wechat.png)

2.确保App的Universal Links配置成功


 3.连续发起分享，确认不会发生多次二次跳转行为

当用户首次使用新版本SDK发起分享时，将会出现如下交互流程：从App拉起微信-出现“正在连接”页面-返回App-重新打开微信。以上是新的安全验证流程，每个用户在首次使用时会出现上述跳转。（如同一用户多次使用分享都出现跳转，请按照以下接入指引，检查Universal Links配置）

![image](https://raw.githubusercontent.com/LiuFuBo1991/LFBSocialSDK/master/imageFolder/icon_share_ercilianjie_wechat.png)


4.如App有使用微信授权登录功能，确认授权不出现二次确认弹窗

授权登录如出现以下二次确认弹窗，原因是微信无法通过App提供的Universal Links返回导致，很可能是App的Universal Links不生效，请按照接入指引检查Universal Links配置

![image](https://raw.githubusercontent.com/LiuFuBo1991/LFBSocialSDK/master/imageFolder/icon_share_login_frae.png)

使用手则：

1.配置appkey和secret这里需要多配置一项UniversalLink字段，对于QQ、新浪微博等平台没用到该功能的UniversalLink字段直接传nil即可。

2.重写AppDelegate或SceneDelegate的continueUserActivity方法： 注意：适配了SceneDelegate的App，系统将会回调SceneDelegate的continueUserActivity方法，所以需要重写SceneDelegate的该方法。

AppDelegate:

```

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRest
oring>> * __nullable restorableObjects))restorationHandler {
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

```

SceneDelegate:

```
- (void)scene:(UIScene *)scene continueUserActivity:(NSUserActivity *)userActivity {
    [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

```

### 版本更新

- v1.0.4 修复了小程序分享预览图和缩略图过大,导致分享失败的问题
- v1.0.5 统一提供各平台是否支持分享的API接口


### 联系 

在使用LFBSocialSDK过程中有任何问题或者有更好的建议，都可以[issues](https://github.com/issues)我，我会及时解决。如果您想贡献代码，欢迎 [Pull Requests](https://github.com/pulls)。其他任何问题可以在下面留言，或者加QQ群:113950502联系我。

