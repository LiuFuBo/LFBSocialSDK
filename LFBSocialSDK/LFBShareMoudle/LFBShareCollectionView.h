//
//  LFBShareCollectionView.h
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/27.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFBShareDefine.h"


@interface LFBShareCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *platforms;
@property (nonatomic,copy) sharePlateformClicked platformClicked;

@end


