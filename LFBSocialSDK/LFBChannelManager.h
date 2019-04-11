//
//  LFBChannelManager.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/18.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFBChannelBase.h"


@interface LFBChannelManager : NSObject

//当前操作的渠道，操作结束之后，会置为nil
@property (nonatomic) LFBChannelBase *currentChannel;
//它会持有代理,代理不能释放，不然初始化出来的channel，没有appKey等Info
@property (nonatomic) id<LFBConfigProtocol> delegate;

//单例
+ (instancetype)sharedManager;

//OpenURL回调
- (BOOL)handleOpenURL:(NSURL *)url;

//根据type，返回对应的channel,并且会配置好相应的信息 (appKey, appScret 等)
- (LFBChannelBase *)channelWithType:(LFBChannelType)channelType;

//根据type，返回对应的channel,并设置未安装的block回调
- (LFBChannelBase *)channelWithType:(LFBChannelType)channelType notInstallBlock:(LFBNotSupportBlock)block;

//客户端支持分享的渠道,没安装的不会返回 (QQ, QQ空间, 微信, 朋友圈, 新浪微博等)
- (NSArray<LFBChannelBase *> *)validChannels;

//清除保留的渠道等信息
- (void)clear;

@end


