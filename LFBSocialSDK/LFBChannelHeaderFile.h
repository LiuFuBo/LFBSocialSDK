//
//  LFBChannelHeaderFile.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/17.
//  Copyright © 2018 liufubo. All rights reserved.
//

#ifndef LFBChannelHeaderFile_h
#define LFBChannelHeaderFile_h

@class LFBChannelBase;

typedef void(^LFBNotSupportBlock)(LFBChannelBase *channel);
typedef void(^LFBOpSuccessBlock)(LFBChannelBase *channel, id data);
typedef void(^LFBOpFailBlock)(LFBChannelBase *channel, NSError *error);
typedef void(^LFBOpCancelBlock)(LFBChannelBase *channel);
typedef void(^LFBSimpleCallBlock)(id sender);

typedef NS_ENUM(NSInteger, LFBChannelErrorCode){
    LFBChannelErrorCodeCancel,
    LFBChannelErrorCodeFail,
    LFBChannelErrorCodeDataError,
    LFBChannelErrorCodeAuthDeny,
    LFBChannelErrorCodeUnsupport,
    LFBChannelErrorCodeUnkonwn
};

typedef NS_ENUM(NSInteger,LFBChannelType){
    LFBChannelTypeQQ, //QQ好友
    LFBChannelTypeQQZone, //QQ空间
    LFBChannelTypeWX, //微信
    LFBChannelTypePYQ, //朋友圈
    LFBChannelTypeSinaWB //新浪微博
};

#define LFBChannelError(theCode,desc)\
({\
NSDictionary *userInfo = nil;\
userInfo = @{NSLocalizedDescriptionKey:desc};\
NSString *domain = [NSString stringWithFormat:@"%s",__FILE__];\
[NSError errorWithDomain:domain code:theCode userInfo:userInfo];\
});

#define LFBRequestAcceptContentType(request)\
{\
[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];\
[request addValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];\
[request addValue:@"text/javascript" forHTTPHeaderField:@"Content-Type"];\
[request addValue:@"text/json" forHTTPHeaderField:@"Content-Type"];\
[request addValue:@"text/html" forHTTPHeaderField:@"Content-Type"];\
[request addValue:@"text/css" forHTTPHeaderField:@"Content-Type"];\
}

#ifndef weakify
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#endif

#ifndef strongify
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#endif


#endif /* LFBChannelHeaderFile_h */
