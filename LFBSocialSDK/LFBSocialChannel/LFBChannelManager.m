//
//  LFBChannelManager.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/18.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBChannelManager.h"
#import "LFBChannelWX.h"
#import "LFBChannelPYQ.h"
#import "LFBChannelQQ.h"
#import "LFBChannelQQZone.h"
#import "LFBChannelSinaWB.h"

@implementation LFBChannelManager

+ (instancetype)sharedManager{
    static id shareInstance = nil;
    static dispatch_once_t o;
    dispatch_once(&o, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

- (BOOL)handleOpenURL:(NSURL *)url{
    return [self.currentChannel handleOpenURL:url];
}

- (LFBChannelBase *)channelWithType:(LFBChannelType)channelType notInstallBlock:(LFBNotSupportBlock)block{
    LFBChannelBase *channel = [self channelWithType:channelType];
    channel.notSupportBlock = block;
    return channel;
}

- (LFBChannelBase *)channelWithType:(LFBChannelType)channelType
{
    LFBChannelBase *baseChannel;
    switch (channelType) {
        case LFBChannelTypeWX:
            baseChannel = [[LFBChannelWX alloc]init];
            break;
        case LFBChannelTypePYQ:
            baseChannel = [[LFBChannelPYQ alloc]init];
            break;
        case LFBChannelTypeQQ:
            baseChannel = [[LFBChannelQQ alloc]init];
            break;
        case LFBChannelTypeQQZone:
            baseChannel = [[LFBChannelQQZone alloc]init];
            break;
        case LFBChannelTypeSinaWB:
            baseChannel = [[LFBChannelSinaWB alloc]init];
            break;
        default:
            break;
    }
    if (!baseChannel) {
#ifdef DEBUG
        NSAssert(NO, @"不支持的渠道类型");
#endif
    }
    if (baseChannel && [self.delegate respondsToSelector:@selector(channelInfoWithType:)]) {
        [baseChannel setupWithInfo:[self.delegate channelInfoWithType:channelType]];
    }
    return baseChannel;
}

- (NSArray<LFBChannelBase *> *)validChannels
{
    NSArray *channelTypes = @[@(LFBChannelTypeWX),
                              @(LFBChannelTypePYQ),
                              @(LFBChannelTypeSinaWB),
                              @(LFBChannelTypeQQ),
                              @(LFBChannelTypeQQZone)];
    NSMutableArray<LFBChannelBase *> *channels = [NSMutableArray array];
    
    for (NSInteger index = 0; index < channelTypes.count; ++ index) {
        LFBChannelType type = [channelTypes[index] integerValue];
        if ([self.delegate channelInfoWithType:type]) {
            LFBChannelBase *channel = [self channelWithType:type];
            if ([channel couldShare]) {
                [channels addObject:channel];
            }
        }
    }
    if (!channels.count) {
        channels = nil;
    }
    return channels;
}

- (void)clear{
    self.currentChannel = nil;
}


@end
