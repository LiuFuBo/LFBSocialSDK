//
//  LFBChannelPYQ.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/18.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBChannelPYQ.h"

@implementation LFBChannelPYQ

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.channelName = @"朋友圈";
    }
    return self;
}

- (enum WXScene)scene{
    return WXSceneTimeline;
}

- (BOOL)couldLogin{
    //微信朋友圈不支持登陆
    return NO;
}

- (LFBChannelType)channelType
{
    return LFBChannelTypePYQ;
}

@end
