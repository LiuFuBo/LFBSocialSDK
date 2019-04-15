//
//  LFBChannelSinaWB.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/18.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBChannelSinaWB.h"
#import <WeiboSDK.h>
#import <WeiboUser.h>

@interface LFBChannelSinaWB ()<WeiboSDKDelegate, LFBOpProcessProtocol>
@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic, copy) NSString *redirectURI;
@property (nonatomic) BOOL hasRegistered;
@end

@implementation LFBChannelSinaWB

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.channelName = @"新浪微博";
    }
    return self;
}

- (BOOL)couldLogin{
    return YES;
}

- (BOOL)couldShare{
    [self registerApp];
    return [WeiboSDK isWeiboAppInstalled] && [WeiboSDK isCanShareInWeiboAPP];
}

- (BOOL)handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)setupWithInfo:(NSDictionary *)info{
    [super setupWithInfo:info];
    self.appKey = info[@"appKey"];
    self.appSecret = info[@"appSecret"];
    self.redirectURI = info[@"redirectURI"];
    if (!self.redirectURI) {
        self.redirectURI = @"https://";
    }
}

- (LFBChannelType)channelType
{
    return LFBChannelTypeSinaWB;
}

- (void)login{
    [self registerApp];
    WBAuthorizeRequest *authReq = [WBAuthorizeRequest request];
    authReq.redirectURI = self.redirectURI;
    authReq.scope = @"all";
    
    BOOL res = [WeiboSDK sendRequest:authReq];
    if (!res) {
        NSError *error = LFBChannelError(LFBChannelErrorCodeUnkonwn, @"登录失败");
        [self didFail:error];
    }
}

- (void)getUserInfo:(LFBAuthInfo *)authInfo
{
    @weakify(self);
    [WBHttpRequest requestForUserProfile:authInfo.openId withAccessToken:authInfo.token andOtherProperties:nil queue:[NSOperationQueue mainQueue] withCompletionHandler:^(WBHttpRequest *httpRequest, WeiboUser *wbUser, NSError *error) {
        @strongify(self);
        if (error) {
            [self didFail:error];
        }else{
            LFBUserInfo *userInfo = [[LFBUserInfo alloc]init];
            userInfo.channelType = self.channelType;
            userInfo.nickname = wbUser.name;
            userInfo.profile = wbUser.profileImageUrl;
            userInfo.province = wbUser.province;
            userInfo.city = wbUser.city;
            //TODO：性别有可能没对应上
            userInfo.sex = LFBUserSexTypeUnkonwn;
            if ([wbUser.gender isEqualToString:@"m"]) {
                userInfo.sex = LFBUserSexTypeMale;
            }else if ([wbUser.gender isEqualToString:@"fm"]){
                userInfo.sex = LFBUserSexTypeFemale;
            }
        }
    }];
}

-(void)shareInfo:(LFBShareInfo *)shareInfo{
    [self registerApp];
    [self reqWithInfo:shareInfo finish:^(WBSendMessageToWeiboRequest *req) {
        if (req) {
            BOOL shareRes = [WeiboSDK sendRequest:req];
            if (!shareRes) {
                NSError *error = LFBChannelError(LFBChannelErrorCodeUnkonwn, @"分享失败");
                [self didFail:error];
            }
        }else{
            NSError *error = LFBChannelError(LFBChannelErrorCodeDataError, @"分享的数据类型不支持");
            [self didFail:error];
        }
    }];
}

- (void)registerApp{
    if (!self.hasRegistered) {
        @synchronized (self) {
            [WeiboSDK registerApp:self.appKey];
            self.hasRegistered = YES;
        }
    }
}

#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    //收到来自微博的请求
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    //收到来自微博的响应
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess:
        {
            if ([response isKindOfClass:[WBAuthorizeResponse class]]) {
            WBAuthorizeResponse *authResponse = (WBAuthorizeResponse *)response;
            if (authResponse.accessToken.length) {
                LFBAuthInfo *authInfo = [[LFBAuthInfo alloc]init];
                authInfo.openId = authResponse.userID;
                authInfo.token = authResponse.accessToken;
                authInfo.expire = [authResponse.expirationDate timeIntervalSince1970];
                authInfo.channelType = self.channelType;
            }else{
                [self didCancel];
            }
            }else if ([response isKindOfClass:[WBSendMessageToWeiboResponse class]]){
                NSMutableDictionary *dict = [@{@"status":@"success", @"type":@"sendMessage"} mutableCopy];
                if (response.userInfo) dict[@"userInfo"] = response.userInfo;
                if (response.requestUserInfo) dict[@"requestUserInfo"] = response.requestUserInfo;
                [self didSuccess:dict];
            }
#ifdef DEBUG
            NSLog(@"新浪微博操作成功......");
#endif
                break;
        }
        case WeiboSDKResponseStatusCodeUserCancel:
            break;
        case WeiboSDKResponseStatusCodeUserCancelInstall:
            [self didCancel];
            break;
        default:
        {
            NSError *error = LFBChannelError(LFBChannelErrorCodeUnkonwn, @"未知错误");
            [self didFail:error];
#ifdef DEBUG
            NSLog(@"新浪微博操作失败......");
#endif
            break;
        }
    }
}

- (void)reqWithInfo:(LFBShareInfo *)info finish:(LFBSimpleCallBlock)finish
{
    WBSendMessageToWeiboRequest *request;
    WBMessageObject *messageObj = [WBMessageObject message];
    if ([info isKindOfClass:[LFBShareText class]]) {
        //文字分享
        LFBShareText *textInfo = (LFBShareText *)info;
        messageObj.text = textInfo.text;
    }else if ([info isKindOfClass:[LFBShareImage class]]){
        //分享图片
        LFBShareImage *imageInfo = (LFBShareImage *)info;
        messageObj.text = imageInfo.desc;
        
        WBImageObject *imageObj = [WBImageObject object];
        imageObj.imageData = UIImageJPEGRepresentation(imageInfo.image, 0.9);
        messageObj.imageObject = imageObj;
    }else if ([info isKindOfClass:[LFBShareWebPage class]]){
        //分享网页
        LFBShareWebPage *webPageInfo = (LFBShareWebPage *)info;
        
        WBWebpageObject *webPageObj = [WBWebpageObject object];
        webPageObj.webpageUrl = webPageInfo.url;
        webPageObj.title = @"";
        webPageObj.description = webPageInfo.desc;
        webPageObj.thumbnailData = webPageInfo.thumbnailData;
        webPageObj.objectID = @"LFBThirdKit";
        messageObj.mediaObject = webPageObj;
        NSString *text = webPageInfo.desc;
        if (text.length > 140) {
            text = [text substringToIndex:139];
        }
        messageObj.text = text;
    }else if ([info isKindOfClass:[LFBShareMusic class]]){
        LFBShareMusic *musicInfo = (LFBShareMusic *)info;
        
        WBMusicObject *musicObjc = [WBMusicObject object];
        musicObjc.musicUrl = musicInfo.musicUrl;
        musicObjc.musicStreamUrl = musicInfo.musicDataUrl;
        musicObjc.musicLowBandUrl = musicInfo.musicLowBandUrl;
        musicObjc.musicLowBandStreamUrl = musicInfo.musicLowBandDataUrl;
        musicObjc.title = musicInfo.desc;
        musicObjc.description = musicInfo.desc;
        musicObjc.thumbnailData = musicInfo.thumbnailData;
        musicObjc.objectID = @"LFBThirdKit";
        messageObj.mediaObject = musicObjc;
    }else if ([info isKindOfClass:[LFBShareVideo class]]){
        LFBShareVideo *videoInfo = (LFBShareVideo *)info;
        
        WBVideoObject *videoObj = [WBVideoObject object];
        videoObj.videoUrl = videoInfo.videoUrl;
        videoObj.videoStreamUrl = videoInfo.videoStreamUrl;
        videoObj.videoLowBandUrl = videoInfo.videoLowBandUrl;
        videoObj.videoLowBandStreamUrl = videoInfo.videoLowBandStreamUrl;
        videoObj.title = videoInfo.desc;
        videoObj.description = videoInfo.desc;
        videoObj.thumbnailData = videoInfo.thumbnailData;
        videoObj.objectID = @"LFBThirdKit";
        messageObj.mediaObject = videoObj;
    }else{
        messageObj = nil;
    }
    if (messageObj) {
        request = [WBSendMessageToWeiboRequest requestWithMessage:messageObj];
    }
    if (finish) {
        finish(request);
    }
}

@end
