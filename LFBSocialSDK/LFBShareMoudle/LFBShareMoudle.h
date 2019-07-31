//
//  LFBShareMoudle.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/25.
//  Copyright © 2018 liufubo. All rights reserved.
//
#import "LFBShareDefine.h"
#import "LFBChannelHeaderFile.h"
#import <Foundation/Foundation.h>


@interface LFBShareMoudle : NSObject

/**
 *  该渠道是否支持分享
 *  未安装该渠道应用,或者安装的该渠道
 *  应用版本过低时可导致无法分享
 *  @param channel LFBChannelType 分享渠道
 */
+ (BOOL)couldShareWithChannel:(LFBChannelType)channel;
/**
 *  第三方分享弹框,弹出支持分享渠道
 *  @param object LFBSharePlateforms类型model
 */
+ (void)showShareViewWithObject:(id)object;
/**
 *  第三方分享
 *  @param object LFBSharePlateforms类型model
 */
+ (void)shareObject:(id)object;
/**
 *  第三方分享
 *  @param object LFBSharePlateforms类型model
 *  @param completionBlock 分享完成回调
 */
+ (void)shareObject:(id)object completion:(shareCompletion)completionBlock;
/**
* 第三方登录
* @param channelType 需要登录的平台
* @param success 成功回调 参数是LFBAuthInfo、LFBChannelBase
* @param fail 失败回调 参数是 NSError、LFBChannelBase
* @param cancel 取消回调 参数是 LFBChannelBase
*/
+ (void)loginWithChannelType:(LFBChannelType)channelType success:(LFBOpSuccessBlock)success fail:(LFBOpFailBlock)fail cancel:(LFBOpCancelBlock)cancel;




@end

