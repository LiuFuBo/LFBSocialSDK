//
//  LFBChannelQQ.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/18.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBChannelQQ.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

@interface LFBChannelQQ ()<TencentSessionDelegate, QQApiInterfaceDelegate,LFBOpProcessProtocol>
@property (nonatomic, copy) NSString *appKey;
@property (nonatomic) TencentOAuth *auth;
@end

@implementation LFBChannelQQ

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.channelName = @"QQ好友";
    }
    return self;
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    if ([TencentOAuth HandleOpenURL:url])
        return YES;
    else
        return [QQApiInterface handleOpenURL:url delegate:self];
}

- (void)setupWithInfo:(NSDictionary *)info{
    [super setupWithInfo:info];
    NSString *appKey = info[@"appKey"];
    self.appKey = appKey;
}

- (LFBChannelType)channelType
{
    return LFBChannelTypeQQ;
}

- (void)login{
    //QQ空间SSO登录
    NSArray *permissionArr = @[kOPEN_PERMISSION_GET_USER_INFO,
                                kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                                kOPEN_PERMISSION_ADD_SHARE,
                                kOPEN_PERMISSION_ADD_TOPIC,
                                kOPEN_PERMISSION_GET_INFO,
                                kOPEN_PERMISSION_GET_OTHER_INFO,
                                kOPEN_PERMISSION_UPLOAD_PIC];
    if (![self.auth authorize:permissionArr inSafari:YES]) {
        NSError *error = LFBChannelError(LFBChannelErrorCodeUnsupport, @"登录失败");
        [self didFail:error];
    }
}

- (void)shareInfo:(LFBShareInfo *)shareInfo{
    [self reqWithInfo:shareInfo finish:^(SendMessageToQQReq *req) {
        if (!req) {
            NSError *error = LFBChannelError(LFBChannelErrorCodeUnsupport, @"不支持该类型数据");
            [self didFail:error];
        }else{
            QQApiSendResultCode shareRes;
            if (self.scene == LFBChannelQQSceneChat) {
                shareRes = [QQApiInterface sendReq:req];
            }else{
                shareRes = [QQApiInterface SendReqToQZone:req];
            }
            if (shareRes != EQQAPISENDSUCESS) {
                NSError *error = LFBChannelError(LFBChannelErrorCodeUnkonwn, @"分享失败");
                [self didFail:error];
            }
        }
    }];
}

- (void)getUserInfo:(LFBAuthInfo *)authInfo
{
    BOOL res = [self.auth getUserInfo];
    if (!res) {
        NSError *error = LFBChannelError(LFBChannelErrorCodeFail, @"获取用户信息失败");
        [self didFail:error];
    }
}

- (BOOL)couldLogin
{
    //就算没装客户端，QQ也支持网页登陆
    return YES;
}

- (BOOL)couldShare
{
    __unused TencentOAuth *auth = self.auth;
    return ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]);
}

#pragma mark - TencentLoginDelegate
//登陆成功的回调
- (void)tencentDidLogin{
    if (self.auth.accessToken) {
        LFBAuthInfo *authInfo = [[LFBAuthInfo alloc]init];
        authInfo.token = self.auth.accessToken;
        authInfo.expire = [self.auth.expirationDate timeIntervalSince1970];
        authInfo.openId = self.auth.openId;
        authInfo.channelType = self.channelType;
        [self didSuccess:authInfo];
    }else{
        [self didCancel];
    }
}
//登录失败的回调
- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
        [self didCancel];
    }else{
        NSError *error = LFBChannelError(LFBChannelErrorCodeUnkonwn, @"登录失败");
        [self didFail:error];
    }
}
//登录时网络有问题
- (void)tencentDidNotNetWork{
    NSError *error = LFBChannelError(kOpenSDKErrorNetwork, @"登录失败");
    [self didFail:error];
}

#pragma mark - QQApiInterfaceDelegate
- (void)onReq:(QQBaseReq *)req{
    //收到来自QQ的请求
}
- (void)onResp:(QQBaseResp *)resp{
    //收到来自QQ的响应
    if (!resp.errorDescription) {
        [self didSuccess:nil];
    }else if ([resp.errorDescription isEqualToString:@"the user give up the current operation"]){
        [self didCancel];
    }else{
        NSError *error = LFBChannelError(LFBChannelErrorCodeUnkonwn, resp.errorDescription);
        [self didFail:error];
    }
}

- (void)getUserInfoResponse:(APIResponse *)response{
    if (response.errorMsg.length) {
        NSError *error = LFBChannelError(response.retCode, response.errorMsg);
        [self didFail:error];
    }else{
        LFBUserInfo *userInfo = [[LFBUserInfo alloc]init];
        userInfo.channelType = self.channelType;
        userInfo.nickname = response.jsonResponse[@"nickname"];
        userInfo.city = response.jsonResponse[@"city"];
        userInfo.province = response.jsonResponse[@"province"];
        
        NSString *profileKey = @"figureurl_qq_2";
        if (self.scene == LFBChannelQQSceneChat) {
            profileKey = @"figureurl_2";
        }
        userInfo.profile = response.jsonResponse[profileKey];
        userInfo.sex = LFBUserSexTypeUnkonwn;
        NSString *gender = response.jsonResponse[@"gender"];
        if ([gender isEqualToString:@"男"]) {
            userInfo.sex = LFBUserSexTypeMale;
        }else if([gender isEqualToString:@"女"]){
            userInfo.sex = LFBUserSexTypeFemale;
        }
        [self didSuccess:userInfo];
    }
}

- (void)isOnlineResponse:(NSDictionary *)response{
    //QQ在线状态回调
}

- (void)reqWithInfo:(LFBShareInfo *)info finish:(LFBSimpleCallBlock)finish
{
    QQApiObject *obj;
    if([info isKindOfClass:[LFBShareText class]]){
        //文字分享
        LFBShareText *textInfo = (LFBShareText *)info;
        obj = [QQApiTextObject objectWithText:textInfo.text];
    }else if ([info isKindOfClass:[LFBShareImage class]]){
        //图片分享
        LFBShareImage *imageInfo = (LFBShareImage *)info;
        if (self.scene == LFBChannelQQSceneChat) {
            obj = [QQApiImageObject objectWithData:UIImageJPEGRepresentation(imageInfo.image, 0.9) previewImageData:nil title:imageInfo.title description:nil];
        }else{
            obj = [QQApiImageArrayForQZoneObject objectWithimageDataArray:@[UIImageJPEGRepresentation(imageInfo.image, 0.9)] title:imageInfo.title extMap:nil];
        }
    }else if ([info isKindOfClass:[LFBShareWebPage class]]){
        //网页分享
        LFBShareWebPage *webPageInfo = (LFBShareWebPage *)info;
        obj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:webPageInfo.url] title:webPageInfo.title description:webPageInfo.desc previewImageData:webPageInfo.thumbnailData];
    }else if ([info isKindOfClass:[LFBShareMusic class]]){
        //音频分享
        LFBShareMusic *musicInfo = (LFBShareMusic *)info;
        NSURL *url = [NSURL URLWithString:musicInfo.musicUrl];
        QQApiAudioObject *audioObj = [QQApiAudioObject objectWithURL:url title:musicInfo.title description:musicInfo.desc previewImageData:musicInfo.thumbnailData];
        audioObj.flashURL = [NSURL URLWithString:musicInfo.musicDataUrl];
        obj = audioObj;
    }else if ([info isKindOfClass:[LFBShareVideo class]]){
        //视频分享
        LFBShareVideo *videoInfo = (LFBShareVideo *)info;
        NSURL *url = [NSURL URLWithString:videoInfo.videoUrl];
        QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL:url title:videoInfo.title description:videoInfo.desc previewImageData:videoInfo.thumbnailData];
        videoObj.flashURL = [NSURL URLWithString:videoInfo.videoStreamUrl];
        obj = videoObj;
    }
    SendMessageToQQReq *req;
    if (obj) {
        req = [SendMessageToQQReq reqWithContent:obj];
    }
    if (finish) {
        finish(req);
    }
}
#pragma mark getter
- (TencentOAuth *)auth{
    if (!_auth) {
        @synchronized (self) {
            if (!_auth) {
                _auth = [[TencentOAuth alloc]initWithAppId:self.appKey andDelegate:self];
            }
        }
    }
    return _auth;
}

- (LFBChannelQQScene)scene{
    return LFBChannelQQSceneChat;
}

@end
