//
//  LFBChannelWX.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/18.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBChannelWX.h"
#import <WXApi.h>


@interface LFBChannelWX ()<WXApiDelegate, LFBOpProcessProtocol>
@property (nonatomic) BOOL hasRegistered;
@property (nonatomic) NSString *appKey;
@property (nonatomic) NSString *appSecret;

@end

@implementation LFBChannelWX

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.channelName = @"微信好友";
    }
    return self;
}

- (enum WXScene)scene{
    return WXSceneSession;
}

- (BOOL)handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)couldLogin{
    [self registerApp];
    return [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi];
}

- (BOOL)couldShare{
    [self registerApp];
    return [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi];
}

- (void)registerApp{
    if (!self.hasRegistered) {
        [WXApi registerApp:self.appKey];
        self.hasRegistered = YES;
    }
}

-(void)setupWithInfo:(NSDictionary *)info{
    [super setupWithInfo:info];
    self.appKey = info[@"appKey"];
    self.appSecret = info[@"appSecret"];
}

- (LFBChannelType)channelType
{
    return LFBChannelTypeWX;
}

- (void)login{
    [self registerApp];
    
    SendAuthReq *authReq = [[SendAuthReq alloc]init];
    authReq.scope = @"snsapi_userinfo";
    authReq.state = @"wx_auth_authorization_state";
    
    BOOL res = [WXApi sendReq:authReq];
    if (!res) {
        NSError *error = LFBChannelError(LFBChannelErrorCodeUnkonwn, @"登陆失败");
        [self didFail:error];
    }
}

- (void)shareInfo:(LFBShareInfo *)shareInfo
{
    [self registerApp];
    [self reqWithInfo:shareInfo finish:^(SendMessageToWXReq *req) {
        if (!req) {
            NSError *error = LFBChannelError(LFBChannelErrorCodeUnsupport, @"不支持分享该类型数据");
            [self didFail:error];
        }else{
            BOOL sendRes = [WXApi sendReq:req];
            if (!sendRes) {
                NSError *error = LFBChannelError(LFBChannelErrorCodeUnkonwn, @"分享请求失败");
                [self didFail:error];
            }
        }
    }];
}

#pragma mark - WXApiDelegate
- (void)onReq:(BaseReq *)req{
    //收到一个来自微信的请求
}

- (void)onResp:(BaseResp *)resp{
    //收到一个来自微信的响应
    switch (resp.errCode) {
        case WXSuccess:
        {
            if ([resp isKindOfClass:[SendAuthResp class]]) {
                //登陆的响应
                SendAuthResp *authResp = (SendAuthResp *)resp;
                if (authResp.code.length) {
                    @weakify(self);
                    [self accessTokenWithCode:authResp.code success:^(LFBChannelBase *channel, LFBAuthInfo *authInfo) {
                        @strongify(self);
                        [self didSuccess:authInfo];
                    } fail:^(LFBChannelBase *channel, NSError *error) {
                        @strongify(self);
                        [self didFail:error];
                    }];
                }else{
                    [self didCancel];
                }
            }else if ([resp isKindOfClass:[SendMessageToWXResp class]]){
                [self didSuccess:nil];
            }
            break;
            }
          case WXErrCodeUserCancel:{
            [self didCancel];
            break;
        }
        default:{
            NSError *error = LFBChannelError(resp.errCode, resp.errStr);
            [self didFail:error];
            break;
          }
    }
}


- (void)reqWithInfo:(LFBShareInfo *)info finish:(LFBSimpleCallBlock)finish
{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.scene = self.scene;
    if ([info isKindOfClass:[LFBShareText class]]) {
        //文本分享
        LFBShareText *textInfo = (LFBShareText *)info;
        req.bText = YES;
        req.text = textInfo.text;
    }else if ([info isKindOfClass:[LFBShareImage class]]){
        //分享图片
        LFBShareImage *imageInfo = (LFBShareImage *)info;
        WXMediaMessage *mediaMessage = [self messageWithInfo:imageInfo];
        WXImageObject *ext = [WXImageObject object];
        ext.imageData = UIImageJPEGRepresentation(imageInfo.image, 0.9);
        mediaMessage.mediaObject = ext;
        req.message = mediaMessage;
    }else if ([info isKindOfClass:[LFBShareWebPage class]]){
        //网页分享
        LFBShareWebPage *webPageInfo = (LFBShareWebPage *)info;
        WXMediaMessage *mediaMessage = [self messageWithInfo:webPageInfo];
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = webPageInfo.url;
        mediaMessage.mediaObject = ext;
        req.message = mediaMessage;
    }else if ([info isKindOfClass:[LFBShareMusic class]]){
        //音频分享
        LFBShareMusic *musicInfo = (LFBShareMusic *)info;
        WXMediaMessage *mediaMessage = [self messageWithInfo:musicInfo];
        WXMusicObject *ext = [WXMusicObject object];
        ext.musicUrl = musicInfo.musicUrl;
        ext.musicDataUrl = musicInfo.musicDataUrl;
        ext.musicLowBandUrl = musicInfo.musicLowBandUrl;
        ext.musicLowBandDataUrl = musicInfo.musicLowBandDataUrl;
        mediaMessage.mediaObject = ext;
        req.message = mediaMessage;
    }else if ([info isKindOfClass:[LFBShareVideo class]]){
        //视频分享
        LFBShareVideo *videoInfo = (LFBShareVideo *)info;
        WXMediaMessage *mediaMessage = [self messageWithInfo:videoInfo];
        WXVideoObject *ext = [WXVideoObject object];
        ext.videoUrl = videoInfo.videoUrl;
        ext.videoLowBandUrl = videoInfo.videoLowBandUrl;
        mediaMessage.mediaObject = ext;
        req.message = mediaMessage;
    }else if ([info isKindOfClass:[LFBShareApplet class]]) {
        //小程序分享
        LFBShareApplet *appletInfo = (LFBShareApplet *)info;
        WXMiniProgramObject *object = [WXMiniProgramObject object];
        object.webpageUrl = appletInfo.webPageUrl;
        object.userName = appletInfo.userName;
        object.path = appletInfo.path;
        object.hdImageData = appletInfo.hdImageData;
        object.withShareTicket = appletInfo.withShareTicket;
        if (appletInfo.miniProgramType == LFBShareMiniInfoTypeRelease) {
            object.miniProgramType = WXMiniProgramTypeRelease;
        }else if (appletInfo.miniProgramType == LFBShareMiniInfoTypeTest){
            object.miniProgramType = WXMiniProgramTypeTest;
        }else{
            object.miniProgramType = WXMiniProgramTypePreview;
        }
        //添加message信息
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = appletInfo.title;
        message.description = appletInfo.desc;
        message.thumbData = appletInfo.thumbData;
        message.mediaObject = object;
        //将组装内容添加到req中
        req.bText =  NO;
        req.message = message;
    }else{
        req = nil;
    }
    if (finish) {
        finish(req);
    }
}

- (WXMediaMessage *)messageWithInfo:(LFBShareMedia *)info
{
    WXMediaMessage *mediaMessage = [WXMediaMessage message];
    mediaMessage.title = info.title;
    mediaMessage.description = info.desc;
    mediaMessage.thumbData = info.thumbnailData;
    return mediaMessage;
}

- (void)accessTokenWithCode:(NSString *)code success:(LFBOpSuccessBlock)success fail:(LFBOpFailBlock)fail{
    
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",self.appKey,self.appSecret,code];
    NSURL *tokenUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:tokenUrl];
    LFBRequestAcceptContentType(request);
    @weakify(self);
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (dict[@"errcode"]) {
                //错误
                if (fail) {
                    NSError *error = LFBChannelError(LFBChannelErrorCodeDataError, dict[@"errmsg"]);
                    fail(nil,error);
                }
            }else{
                @strongify(self);
                LFBAuthInfo *authInfo = [[LFBAuthInfo alloc]init];
                authInfo.openId = dict[@"openid"];
                authInfo.token = dict[@"access_token"];
                authInfo.expire = [dict[@"expires_in"] longLongValue];
                authInfo.channelType = self.channelType;
                authInfo.unionId = dict[@"unionid"];
                authInfo.refresh_token = dict[@"refresh_token"];
                authInfo.scope = dict[@"scope"];
                if (success) {
                    success(nil,authInfo);
                }
            }
        }else{
            if (fail) {
                NSError *error = LFBChannelError(LFBChannelErrorCodeFail, @"网络连接失败");
                fail(nil,error);
            }
        }
    }];
}

- (void)getUserInfo:(LFBAuthInfo *)authInfo{
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", authInfo.token, authInfo.openId];
    NSURL *tokenUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:tokenUrl];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    LFBRequestAcceptContentType(request);
    @weakify(self);
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        @strongify(self);
        if (data) {
            NSError *error;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if (!error && [dict isKindOfClass:[NSDictionary class]]) {
                LFBUserInfo *userInfo = [[LFBUserInfo alloc]init];
                userInfo.channelType = self.channelType;
                userInfo.nickname = dict[@"nickname"];
                userInfo.profile = dict[@"headimgurl"];
                userInfo.province = dict[@"province"];
                userInfo.city = dict[@"city"];
                userInfo.sex = [dict[@"sex"] integerValue];
                userInfo.country = dict[@"country"];
                userInfo.headImgUrl = dict[@"headimgurl"];
                [self didSuccess:userInfo];
            }else{
                error = LFBChannelError(LFBChannelErrorCodeDataError, error.description);
                [self didFail:error];
            }
        }else{
            [self didFail:connectionError];
        }
    }];
}





@end
