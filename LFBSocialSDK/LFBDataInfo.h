//
//  LFBDataInfo.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/17.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFBChannelHeaderFile.h"


/**
*  登陆用户信息
*/

typedef NS_ENUM(NSInteger,LFBUserSexType){
    LFBUserSexTypeUnkonwn = 0,
    LFBUserSexTypeMale,
    LFBUserSexTypeFemale
};

@interface LFBUserInfo : NSObject
@property (nonatomic) LFBUserSexType sex;
@property (nonatomic) LFBChannelType channelType;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *profile;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *headImgUrl;

@end

/**
 *  授权信息
 */
@interface LFBAuthInfo : NSObject
@property (nonatomic) LFBChannelType channelType;//平台
@property (nonatomic, copy) NSString *openId;//授权用户唯一标识
@property (nonatomic, copy) NSString *unionId; //微信独有
@property (nonatomic, copy) NSString *token;//接口调用凭证
@property (nonatomic, copy) NSString *refresh_token;//用户刷新token
@property (nonatomic, copy) NSString *scope;//用户授权的作用域，使用逗号(,)分隔
@property (nonatomic) long long expire;//接口调用凭证超时时间, 单位(秒)



@end


