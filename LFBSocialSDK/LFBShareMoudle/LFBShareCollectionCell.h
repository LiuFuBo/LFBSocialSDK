//
//  LFBShareCollectionCell.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/27.
//  Copyright © 2018 liufubo. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "LFBChannelBase.h"


static NSString *const LFBShareCollectionViewCellIdentifier = @"LFBShareCollectionViewCellIdentifier";
@interface LFBShareCollectionCell : UICollectionViewCell

- (void)setPlatform:(LFBChannelBase *)channel;

@end


