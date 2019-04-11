//
//  LFBShareMoudleView.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/25.
//  Copyright © 2018 liufubo. All rights reserved.
//
#import "Masonry.h"
#import "UIColor+RGB.h"
#import "LFBShareDefine.h"
#import "LFBShareCollectionView.h"
#import "LFBShareCollectionCell.h"
#import "LFBShareMoudleView.h"

@interface LFBShareMoudleView ()
@property (nonatomic, strong) LFBShareCollectionView *collectionView;//展示分享图collectionview
@property (nonatomic, strong) UIView *viewGesture;//手势view
@property (nonatomic, strong) UIView *viewCover;//背景view
@property (nonatomic, strong) UIButton *buttonCancel;//取消
@property (nonatomic, strong) UIView *viewLineBottom;//底部分割线

@end


@implementation LFBShareMoudleView{
    NSInteger totalChannel;//分享平台总数
    NSInteger lineChannel;//每行分享平台数
    CGFloat miniLineSpacing;//行间距
    CGFloat miniColumnSpacing;//最小列间距
    CGFloat itemW;//cell宽度
    CGFloat itemH;//cell高度
    CGFloat insetTop;//section顶部缩进
    CGFloat insetBottom;//section底部缩进
    CGFloat insetLeft;//section左边缩进
    CGFloat insetRight;//section右边缩进
    CGFloat width;//宽度
    CGFloat height;//高度
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, KShare_SCREEN_WIDTH, KShare_SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.viewGesture];
        [self addSubview:self.viewCover];
        [self.viewGesture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
        [self initConfig];
        [self bindEvents];
    }
    return self;
}

- (void)initConfig{
    lineChannel = 4;//每行展示4个分享平台
    itemW = 50;//每个Item宽度
    itemH = 70;//每个Item高度
    miniLineSpacing = 18;//最小行间距
    miniColumnSpacing = (self.frame.size.width - lineChannel*itemW)/(lineChannel + 1);//最小列间距
    insetTop = 24;//section顶部默认间距
    insetBottom = 24;//section底部默认间距
    insetLeft = miniColumnSpacing;//section左边默认间距
    insetRight = miniColumnSpacing;//section右边默认间距
}

- (void)setupUI{
    if (!self.plateforms.count) {
        return;
    }
    
    //collectionView高度
    CGFloat row = (self.plateforms.count - 1)/lineChannel;
    CGFloat collectionViewH = insetTop +insetBottom + (row + 1)*itemH+row*miniLineSpacing;
    self.viewCover.frame = CGRectMake(0, KShare_SCREEN_HEIGHT, KShare_SCREEN_WIDTH, collectionViewH+48+0.5+TabbarSafeBottomMargin);
    
    //取消
    [self.viewCover addSubview:self.buttonCancel];
    [self.buttonCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.viewCover);
        make.bottom.mas_equalTo(-TabbarSafeBottomMargin);
        make.height.mas_equalTo(48);
    }];
    
    //底部分割线
    [self.viewCover addSubview:self.viewLineBottom];
    [self.viewLineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.buttonCancel.mas_top).mas_offset(0.1);
    }];
    
    //平台按钮
    [self.viewCover addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.viewLineBottom.mas_top);
        make.height.mas_equalTo(collectionViewH);
    }];
}

- (void)setPlateforms:(NSArray *)plateforms{
    _plateforms = plateforms;
    self.collectionView.platforms = plateforms;
}

- (void)bindEvents{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewSingleTapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.viewGesture addGestureRecognizer:tapGesture];
    [self.buttonCancel addTarget:self action:@selector(cancelShare:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)show{
    [self setupUI];
    
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    [window addSubview:self];
    
    CGRect rect = self.viewCover.frame;
    rect.origin.y -= rect.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.viewGesture.backgroundColor = [[UIColor colorWithString:@"#000000"] colorWithAlphaComponent:0.7];
        self.viewCover.frame = rect;
    }];
}

- (void)dismiss{
    CGRect rect = self.viewCover.frame;
    rect.origin.y = KShare_SCREEN_HEIGHT;
    [UIView animateWithDuration:0.25 animations:^{
        self.viewGesture.backgroundColor = [UIColor clearColor];
        self.viewCover.frame = rect;
    } completion:^(BOOL finished) {
        [self.viewCover removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)viewSingleTapGesture:(UITapGestureRecognizer *)tap{
    [self dismiss];
}

- (void)cancelShare:(UIButton *)sender{
    [self dismiss];
}

#pragma mark - getter & setter
- (LFBShareCollectionView *)collectionView{
    return _collectionView?:({
        /** 上下缩进24,行间距24,列间距=左右缩进,cell大小(50,70) */
        UICollectionViewFlowLayout *viewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        viewFlowLayout.minimumLineSpacing = miniLineSpacing;
        viewFlowLayout.minimumInteritemSpacing = miniColumnSpacing;
        viewFlowLayout.itemSize = CGSizeMake(itemW, itemH);
        viewFlowLayout.sectionInset = UIEdgeInsetsMake(insetTop, insetLeft, insetBottom, insetRight);
        _collectionView = [[LFBShareCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:viewFlowLayout];
        [_collectionView registerClass:[LFBShareCollectionCell class] forCellWithReuseIdentifier:LFBShareCollectionViewCellIdentifier];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        @wwww(self);
        _collectionView.platformClicked = ^(id sender, id object) {
            @ssss(self);
            [self dismiss];
            if (self.clickPlateform) {
                self.clickPlateform(sender, object);
            }
        };
        _collectionView;
    });
}

- (UIView *)viewGesture{
    return _viewGesture?:({
        _viewGesture = [[UIView alloc]init];
        _viewGesture.backgroundColor = [UIColor clearColor];
        _viewGesture;
    });
}

- (UIView *)viewCover{
    return _viewCover?:({
        _viewCover = [[UIView alloc]init];
        _viewCover.backgroundColor =  [UIColor colorWithString:@"#F8F8F8"];
        _viewCover;
    });
}

- (UIButton *)buttonCancel{
    return _buttonCancel?:({
        _buttonCancel = [[UIButton alloc]init];
        [_buttonCancel.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_buttonCancel setTitleColor:[UIColor colorWithString:@"#1E1E1E"] forState:UIControlStateNormal];
        [_buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
        _buttonCancel;
    });
}

- (UIView *)viewLineBottom{
    return _viewLineBottom?:({
        _viewLineBottom = [[UIView alloc]init];
        _viewLineBottom.backgroundColor = [UIColor colorWithString:@"#E2E2E2"];
        _viewLineBottom;
    });
}


@end
