//
//  LFBShareChannelConfig.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/20.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFBOpProcessProtocol.h"

@interface LFBShareChannelConfig : NSObject<LFBConfigProtocol>
/*!
* 配置分享参数
* channelType 分享渠道
* appkey 平台appkey
* appSecret 平台appSecret
* see universalLink 通用连接
*/
- (void)setChannelType:(LFBChannelType)channelType appKey:(NSString *)appkey appSecret:(NSString *)appSecret universalLink:(NSString *)universalLink;

@end

