//
//  LFBShareModel.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/27.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFBShareInfo.h"
#import "LFBShareDefine.h"
#import <Foundation/Foundation.h>
#import "LFBChannelHeaderFile.h"


@interface LFBSharePlateforms : NSObject
/** 分享平台类型(当通过弹框选择是不需要传,其他渠道必传) */
@property (nonatomic) LFBChannelType shareType;
/** 分享数据类型(必传) */
@property (nonatomic) LFBShareInfoType shareInfoType;

/**
 *  以下内容根据个人需要选择填写
 */

/** 分享标题 */
@property (nonatomic, strong) NSString *title;
/** 分享标题注解 */
@property (nonatomic, strong) NSString *desc;
/** 分享文本,仅用于纯文字分享 */
@property (nonatomic, strong) NSString *text;
/** 分享内容缩略图 */
@property (nonatomic, strong) NSData *thubnailData;
/** 分享内容原图 */
@property (nonatomic, strong) NSData *originalImageData;
/** 分享URL */
@property (nonatomic, strong) NSString *url;
/** 分享图片,针对本地图片分享 */
@property (nonatomic, strong) UIImage *image;
/** 分享音乐网页链接地址 */
@property (nonatomic, strong) NSString *musicUrl;
/** 分享音乐低频段网页链接地址 */
@property (nonatomic, strong) NSString *musicLowBandUrl;
/** 分享音乐数据下载链接地址 */
@property (nonatomic, strong) NSString *musicDataUrl;
/** 分享音乐低频段数据下载链接地址 */
@property (nonatomic, strong) NSString *musicLowBandDataUrl;
/** 分享视频网页链接地址 */
@property (nonatomic, strong) NSString *videoUrl;
/** 分享视频低频段网页链接地址 */
@property (nonatomic, strong) NSString *videoLowBandUrl;
/** 分享视频流数据下载链接地址 */
@property (nonatomic, strong) NSString *videoStreamUrl;
/** 分享视频低频段数据流下载链接地址 */
@property (nonatomic, strong) NSString *videoLowBandStreamUrl;
/** 兼容低版本的网页链接，备注:限制长度不超过10KB  --小程序专用分享字段 */
@property (nonatomic, strong) NSString *webPageUrl;
/** 小程序的用户名,小程序原始ID获取方法，登陆小程序管理后台-设置-基本设置-账号s信息 */
@property (nonatomic, strong) NSString *userName;
/** 小程序页面路径 */
@property (nonatomic, strong) NSString *path;
/** 小程序新版本的预览图二进制数据,6.5.9及以上版本微信客户端支持,限制128KB,自定义b图片建议长宽比5:4 */
@property (nonatomic, strong) NSData *hdImageData;
/** 是否使用带shareTicket的分享,小程序被二次打开时可以获取到更多信息，例如群的标识 */
@property (nonatomic, assign) BOOL withShareTicket;
/** 小程序的类型，默认正式版，1.8.1及以上版本开发者工具包支持分享开发板和体验版 */
@property (nonatomic, assign) LFBShareMiniInfoType miniProgramType;

/***       以下方法调用者无须关心       */
/** 构建分享model */
- (LFBShareInfo *)shareModel;
/** 重置参数 */
- (void)resetParams;

@end

