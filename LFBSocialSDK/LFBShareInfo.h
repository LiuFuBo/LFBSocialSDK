//
//  LFBShareInfo.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/17.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFBShareDefine.h"
#import <UIKit/UIKit.h>


@interface LFBShareInfo : NSObject

@end

@interface LFBShareText : LFBShareInfo
@property (nonatomic, copy) NSString *text;

@end

@interface LFBShareMedia : LFBShareInfo
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;

//内容缩略图,一般<32K,如果超过,会导致接口调用失败
@property (nonatomic) NSData *thumbnailData;
@property (nonatomic) NSData *originalImageData;

@end

@interface LFBShareImage : LFBShareMedia
@property (nonatomic) UIImage *image;

@end

@interface LFBShareWebPage : LFBShareMedia
@property (nonatomic, copy) NSString *url;

@end

@interface LFBShareMusic : LFBShareMedia
//音乐网页url地址
@property (nonatomic, copy) NSString *musicUrl;
//音乐数据流url
@property (nonatomic, copy) NSString *musicDataUrl;
//音乐lowband网页url地址
@property (nonatomic, copy) NSString *musicLowBandUrl;
//音乐lowband数据流url
@property (nonatomic, copy) NSString *musicLowBandDataUrl;

@end

@interface LFBShareVideo : LFBShareMedia
//视频网页的url,不能为空且长度不能超过255
@property (nonatomic, strong) NSString *videoUrl;
//视频数据流url，长度有限制,不能超过255,否则直接分享失败
@property (nonatomic, strong) NSString *videoStreamUrl;
//视频lowband网页的url
@property (nonatomic, strong) NSString *videoLowBandUrl;
//视频lowband数据流url
@property (nonatomic, strong) NSString *videoLowBandStreamUrl;

@end

@interface LFBShareApplet : LFBShareInfo
/** 分享小程序标题 */
@property (nonatomic, copy) NSString *title;
/**  分享小程序描述 */
@property (nonatomic, copy) NSString *desc;
/** 兼容低版本的网页链接，备注:限制长度不超过10KB  --小程序分享字段 */
@property (nonatomic, strong) NSString *webPageUrl;
/** 小程序的用户名*/
@property (nonatomic, strong) NSString *userName;
/** 小程序页面路径 */
@property (nonatomic, strong) NSString *path;
/** 小程序新版本的预览图二进制数据 */
@property (nonatomic, strong) NSData *hdImageData;
/** 小程序缩略图,< 32KB,新版本优先 */
@property (nonatomic, strong) NSData *thumbData;
/** 是否使用带shareTicket的分享 */
@property (nonatomic, assign) BOOL withShareTicket;
/** 小程序的类型 */
@property (nonatomic, assign) LFBShareMiniInfoType miniProgramType;
@end




