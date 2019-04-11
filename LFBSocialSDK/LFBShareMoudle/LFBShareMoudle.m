//
//  LFBShareMoudle.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/25.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBChannelManager.h"
#import "LFBShareMoudle.h"
#import "LFBShareMoudleView.h"
#import "LFBSharePlateforms.h"

@interface LFBShareMoudle ()
@property (nonatomic, strong) LFBShareInfo *shareInfo;
@property (nonatomic, strong) LFBSharePlateforms *shareModel;
@property (nonatomic, copy) shareCompletion completion;
@end

@implementation LFBShareMoudle

+ (instancetype)share{
    static id share = nil;
    static dispatch_once_t o;
    dispatch_once(&o, ^{
        share = [[self alloc]init];
    });
    return share;
}

+ (void)shareObject:(id)object{
    LFBShareMoudle *moudle = [LFBShareMoudle share];
    [moudle shareObject:object];
}

+ (void)shareObject:(id)object completion:(shareCompletion)completionBlock{
    LFBShareMoudle *moudle = [LFBShareMoudle share];
    moudle.completion = completionBlock;
    [moudle shareObject:object];
}

- (void)shareObject:(id)object{
    [self setShareModel:object];
    LFBChannelBase *channel = [[LFBChannelManager sharedManager] channelWithType:self.shareModel.shareType];
    [self shareWithPlatform:channel];
}

+ (void)showShareViewWithObject:(id)object{
    LFBShareMoudle *moudle = [LFBShareMoudle share];
    [moudle setShareModel:object];
    [moudle showShareView];
}

- (void)showShareView{
    if (![self platforms].count) {
        NSLog(@"没有可以分享的地方噢");
        return;
    }
    LFBShareMoudleView *shareView = [[LFBShareMoudleView alloc]init];
    shareView.plateforms = [self platforms];
    [shareView show];
    @wwww(self);
    shareView.clickPlateform = ^(id sender, id object) {
        @ssss(self);
        [self shareWithPlatform:object];
    };
}

- (void)shareWithPlatform:(LFBChannelBase *)channel{
    if (self.shareModel == nil) {
        return;
    }
    self.shareInfo = [self.shareModel shareModel];
    @wwww(self);
    [channel shareInfo:_shareInfo success:^(LFBChannelBase *channel, id data) {
        @ssss(self);
        NSLog(@"分享成功");
        if (self.completion) {
            self.completion(self, [self.shareModel shareType], LFBShareStateSuccess);
        }
        [self.shareModel resetParams];
    } fail:^(LFBChannelBase *channel, NSError *error) {
        @ssss(self);
        NSLog(@"分享失败");
        if (self.completion) {
            self.completion(self, [self.shareModel shareType], LFBShareStateFail);
        }
        [self.shareModel resetParams];
    } cancel:^(LFBChannelBase *channel) {
        @ssss(self);
        NSLog(@"分享取消");
        if (self.completion) {
            self.completion(self, [self.shareModel shareType], LFBShareStateCancel);
        }
        [self.shareModel resetParams];
    }];
}

+ (void)loginWithChannelType:(LFBChannelType)channelType success:(LFBOpSuccessBlock)success fail:(LFBOpFailBlock)fail cancel:(LFBOpCancelBlock)cancel{
    LFBChannelBase *channels = [[LFBChannelManager sharedManager] channelWithType:channelType];
    [channels login:^(LFBChannelBase *channel, id data) {
        [self getUserInfoWithChannel:channel auth:data success:^(LFBChannelBase *channel, id data) {
           !success ? : success(channel,data);
        } fail:^(LFBChannelBase *channel, NSError *error) {
            fail ? : fail(channel,error);
        }];
    } fail:^(LFBChannelBase *channel, NSError *error) {
        !fail ? : fail(channel,error);
    } cancel:^(LFBChannelBase *channel) {
        !cancel ? : cancel(channel);
    }];
}

+ (void)getUserInfoWithChannel:(LFBChannelBase *)channel auth:(LFBAuthInfo *)authInfo success:(LFBOpSuccessBlock)success fail:(LFBOpFailBlock)fail{
    [channel getUserInfoWithAuth:authInfo success:^(LFBChannelBase *channel, id data) {
        !success ? : success(channel, data);
    } fail:^(LFBChannelBase *channel, NSError *error) {
        !fail ? : fail(channel,error);
    }];
}

- (NSArray *)platforms{
    return [LFBChannelManager sharedManager].validChannels;
}

@end
