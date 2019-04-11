//
//  LFBChannelBase.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/17.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBChannelBase.h"

@interface LFBChannelBase ()<LFBOpProcessProtocol>
//操作成功回调
@property (nonatomic) LFBOpSuccessBlock successBlock;
//取消操作回调
@property (nonatomic) LFBOpCancelBlock cancelBlock;
//操作失败回调
@property (nonatomic) LFBOpFailBlock failBlock;
//渠道类型
@property (nonatomic) LFBChannelType channelType;

/**
 * 以下是子类需要覆写的方法
 */
//channel是否支持登陆
- (BOOL)couldLogin;

//每个子类的登陆操作
- (void)login;

//每个子类的分享操作
- (void)shareInfo:(LFBShareInfo *)shareInfo;

//获得特定渠道的用户信息
- (void)getUserInfo:(LFBAuthInfo *)authInfo;


@end

@implementation LFBChannelBase

- (BOOL)couldLogin{
    return NO;
}

- (BOOL)couldShare{
    return NO;
}

- (void)login:(LFBOpSuccessBlock)success fail:(LFBOpFailBlock)fail cancel:(LFBOpCancelBlock)cancel
{
    self.successBlock = success;
    self.failBlock = fail;
    self.cancelBlock = cancel;
    if ([self couldLogin]) {
        [LFBChannelManager sharedManager].currentChannel = self;
        [self login];
    }else{
        [self didNotSupport];
    }
}

- (void)getUserInfoWithAuth:(LFBAuthInfo *)authInfo success:(LFBOpSuccessBlock)success fail:(LFBOpFailBlock)fail
{
    self.successBlock = success;
    self.failBlock = fail;
    if ([self couldLogin]) {
        [LFBChannelManager sharedManager].currentChannel = self;
        [self getUserInfo:authInfo];
    }else{
        [self didNotSupport];
    }
}

- (void)shareInfo:(LFBShareInfo *)shareInfo success:(LFBOpSuccessBlock)success fail:(LFBOpFailBlock)fail cancel:(LFBOpCancelBlock)cancel
{
    self.successBlock = success;
    self.failBlock = fail;
    self.cancelBlock = cancel;
    if ([self couldShare]) {
        [LFBChannelManager sharedManager].currentChannel = self;
        [self shareInfo:shareInfo];
    }else{
        [self didNotSupport];
    }
}

- (void)login{
    //子类实现
}

- (void)shareInfo:(LFBShareInfo *)shareInfo{
    //子类实现
}

- (void)getUserInfo:(LFBAuthInfo *)authInfo{
    //子类实现
}

- (void)setupWithInfo:(NSDictionary *)info{
    if (info[@"channelName"]) {
        self.channelName = info[@"channelName"];
    }
    if (info[@"normalIcon"] && [info[@"normalIcon"] isKindOfClass:[NSString class]]) {
        self.normalIcon = [UIImage imageNamed:info[@"normalIcon"]];
    }
    if (info[@"selectedIcon"] && [info[@"selectedIcon"] isKindOfClass:[NSString class]]) {
        self.selectedIcon = [UIImage imageNamed:info[@"selectedIcon"]];
    }
    if (info[@"highlightedIcon"] && [info[@"highlightedIcon"] isKindOfClass:[NSString class]]) {
        self.highlightedIcon = [UIImage imageNamed:info[@"highlightedIcon"]];
    }
}

- (void)didSuccess:(id)data{
    __unused LFBChannelBase *holder = self;
    [self clear];
    if (self.successBlock) {
        self.successBlock(self, data);
    }
}

- (void)didFail:(NSError *)error{
    //故意声明一个临时变量持有self,避免clear的时候self被释放掉
    __unused LFBChannelBase *holder = self;
    [self clear];
    if (self.failBlock) {
        self.failBlock(self, error);
    }
}

- (void)didCancel{
    __unused LFBChannelBase *holder = self;
    [self clear];
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }
}

- (void)didNotSupport
{
    [self clear];
    if (self.notSupportBlock) {
        self.notSupportBlock(self);
    }
}

- (void)clear{
    [[LFBChannelManager sharedManager] clear];
}

- (BOOL)handleOpenURL:(NSURL *)url{
    return NO;
}

@end
