//
//  LFBChannelQQZone.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/18.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBChannelQQZone.h"

@implementation LFBChannelQQZone

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.channelName = @"QQ空间";
    }
    return self;
}

- (LFBChannelQQScene)scene
{
    return LFBChannelQQSceneQQZone;
}

- (BOOL)couldLogin
{
    //QQ空间不支持登录
    return NO;
}

- (LFBChannelType)channelType
{
    return LFBChannelTypeQQZone;
}


@end
