//
//  LFBOpProcessProtocol.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/18.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFBChannelHeaderFile.h"

@class LFBAuthInfo;

@protocol LFBOpProcessProtocol <NSObject>

@optional

//取消操作之后调用
- (void)didCancel;

//失败之后调用
- (void)didFail:(NSError *)error;

//成功之后调用
- (void)didSuccess:(id)data;

@end


@protocol LFBConfigProtocol <NSObject>

//渠道对应的信息，主要是appKey,appSecret等信息
- (NSDictionary *)channelInfoWithType:(LFBChannelType)channelType;

@end

