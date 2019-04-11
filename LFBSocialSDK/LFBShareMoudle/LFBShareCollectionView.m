//
//  LFBShareCollectionView.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/27.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBShareCollectionView.h"
#import "LFBShareCollectionCell.h"
#import "LFBChannelBase.h"

@implementation LFBShareCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[LFBShareCollectionCell class] forCellWithReuseIdentifier:LFBShareCollectionViewCellIdentifier];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.platforms.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LFBShareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LFBShareCollectionViewCellIdentifier forIndexPath:indexPath];
    LFBChannelBase *channel = self.platforms[indexPath.row];
    [cell setPlatform:channel];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LFBChannelBase *channel = self.platforms[indexPath.row];
    if (self.platformClicked) {
        self.platformClicked(self, channel);
    }
}

- (void)setPlatforms:(NSArray *)platforms{
    _platforms = platforms;
    [self reloadData];
}




@end
