//
//  LFBChannelQQ.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/18.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBChannelBase.h"

typedef NS_ENUM(NSInteger,LFBChannelQQScene){
    LFBChannelQQSceneChat = 0,//qq聊天界面
    LFBChannelQQSceneQQZone = 1 //qq空间
};

@interface LFBChannelQQ : LFBChannelBase
@property (nonatomic, readonly) LFBChannelQQScene scene;

@end
