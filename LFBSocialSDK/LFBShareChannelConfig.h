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

- (void)setChannelType:(LFBChannelType)channelType appKey:(NSString *)appkey appSecret:(NSString *)appSecret;

@end

