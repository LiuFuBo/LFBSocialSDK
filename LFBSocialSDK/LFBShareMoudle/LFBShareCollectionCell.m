//
//  LFBShareCollectionCell.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/27.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBShareCollectionCell.h"
#import "LFBChannelManager.h"
#import "Masonry.h"

@interface LFBShareCollectionCell ()
@property (nonatomic) UIImageView *channelIcon;
@property (nonatomic) UILabel *titleLabel;
@end

@implementation LFBShareCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self initLayout];
    }
    return self;
}

- (void)addSubviews{
    [self.contentView addSubview:self.channelIcon];
    [self.contentView addSubview:self.titleLabel];
}

- (void)initLayout{
    [self.channelIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self);
        make.width.height.mas_equalTo(50);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.channelIcon.mas_bottom).mas_offset(8);
        make.centerX.mas_equalTo(self);
    }];
}

- (void)setPlatform:(LFBChannelBase *)channel{
    NSString *title = nil;
    NSString *image = nil;
    NSString *highlightedImage = nil;
    NSDictionary *imageInfo = nil;
    if ([[LFBChannelManager sharedManager].delegate respondsToSelector:@selector(channelInfoWithType:)]) {
        imageInfo =  [[LFBChannelManager sharedManager].delegate channelInfoWithType:channel.channelType];
    }
    switch (channel.channelType) {
        case LFBChannelTypeWX:
            title = @"微信";
            image = imageInfo[@"normalIcon"];
            highlightedImage = imageInfo[@"selectedIcon"];
            break;
        case LFBChannelTypePYQ:
            title = @"朋友圈";
            image = imageInfo[@"normalIcon"];
            highlightedImage = imageInfo[@"selectedIcon"];
            break;
        case LFBChannelTypeQQ:
            title = @"QQ";
            image = imageInfo[@"normalIcon"];
            highlightedImage = imageInfo[@"selectedIcon"];
            break;
        case LFBChannelTypeQQZone:
            title = @"QQ空间";
            image = imageInfo[@"normalIcon"];
            highlightedImage = imageInfo[@"selectedIcon"];
            break;
        case LFBChannelTypeSinaWB:
            title = @"新浪微博";
            image = imageInfo[@"normalIcon"];
            highlightedImage = imageInfo[@"selectedIcon"];
            break;
        default:
            break;
    }
    self.titleLabel.text = title;
    if (image.length > 0) {
     self.channelIcon.image = [UIImage imageNamed:image];
    }
    if (highlightedImage.length > 0) {
     self.channelIcon.highlightedImage = [UIImage imageNamed:highlightedImage];
    }
}

#pragma mark - getter & setter
- (UIImageView *)channelIcon{
    return _channelIcon?:({
        _channelIcon = [[UIImageView alloc]init];
        _channelIcon.layer.cornerRadius = 25;
        _channelIcon;
    });
}

- (UILabel *)titleLabel{
    return _titleLabel?:({
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.userInteractionEnabled = YES;
        _titleLabel.textColor = [UIColor colorWithRed:30/255.0f green:30/255.0f blue:30/255.0f alpha:1];
        _titleLabel;
    });
}




@end
