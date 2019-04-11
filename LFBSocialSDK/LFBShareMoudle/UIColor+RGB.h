//
//  UIColor+RGB.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/27.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (RGB)

+ (UIColor *)colorWithString:(NSString *)colorStr;

+ (UIColor *)colorWithString:(NSString *)colorStr alpha:(float)alpha;

@end


