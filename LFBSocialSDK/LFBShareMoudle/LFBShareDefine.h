//
//  LFBShareDefine.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/25.
//  Copyright © 2018 liufubo. All rights reserved.
//

#ifndef LFBShareDefine_h
#define LFBShareDefine_h
#import "LFBChannelHeaderFile.h"



typedef NS_ENUM(NSInteger,LFBShareInfoType){
    LFBShareInfoTypeText,//分享文本
    LFBShareInfoTypeMedia,//分享媒体
    LFBShareInfoTypeMusic,//分享音乐
    LFBShareInfoTypeWeb,//分享网页
    LFBShareInfoTypeImage,//分享图片
    LFBShareInfoTypeVideo,//分享视频
    LFBShareInfoTypeApplet//分享小程序
};

typedef NS_ENUM(NSInteger,LFBShareState){
    LFBShareStateSuccess,//分享成功
    LFBShareStateFail,//分享失败
    LFBShareStateCancel//取消分享
};

typedef NS_ENUM(NSInteger,LFBShareMiniInfoType){
    LFBShareMiniInfoTypeRelease,//分享小程序正式版
    LFBShareMiniInfoTypeTest,//分享小程序测试版
    LFBShareMiniInfoTypePreview//分享小程序体验版
};


typedef void(^sharePlateformClicked)(id sender, id object);
typedef void(^shareCompletion)(id sender,LFBChannelType channelType,LFBShareState shareState);

#define KShare_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define KShare_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// 判断是否是X
#define  iPhoneX ((KShare_SCREEN_WIDTH == 375.f && KShare_SCREEN_HEIGHT == 812.f) || (KShare_SCREEN_WIDTH == 812.f && KShare_SCREEN_HEIGHT == 375.f))

//底部安全距离
#define  TabbarSafeBottomMargin         (iPhoneX ? 34.f : 0.f)

#define wwww(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#define ssss(object) autoreleasepool{} __typeof__(object) object = weak##_##object;

#endif /* LFBShareDefine_h */
