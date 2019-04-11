//
//  LFBShareMoudleView.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/25.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBShareDefine.h"
#import <UIKit/UIKit.h>



@interface LFBShareMoudleView : UIView
//能够支持分享的平台
@property (nonatomic, strong) NSArray *plateforms;
//选择分享的平台
@property (nonatomic, copy) sharePlateformClicked clickPlateform;

- (void)show;
- (void)dismiss;

@end

