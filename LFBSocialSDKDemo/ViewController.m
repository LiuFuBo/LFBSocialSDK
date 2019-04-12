//
//  ViewController.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/17.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "ViewController.h"
#import "LFBSocialSDK.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wechatLoginTest];
}

- (void)wechatLoginTest{
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.bounds = CGRectMake(0, 0, 200, 40);
    loginBtn.center = self.view.center;
    loginBtn.layer.cornerRadius =12;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.backgroundColor = [UIColor orangeColor];
    [loginBtn setTitle:@"开始分享" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(startShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

- (void)startShare:(UIButton *)sender{
    LFBSharePlateforms *model = [[LFBSharePlateforms alloc]init];
//    model.shareType = LFBChannelType;
    model.shareInfoType = LFBShareInfoTypeApplet;
    model.title = @"小程序";
    model.text = @"大家来找茬!!!";
    model.webPageUrl =@"https://tapi.eyxyt.com/activefront/qrcode/shared_car_get_coupon?coupon_template_id=113";
    model.userName = @"gh_a4ff22eef403";
    model.path = @"pages/getcoupon?coupon_template_id=113";
    model.hdImageData = nil;
    model.withShareTicket = YES;
    model.miniProgramType = LFBShareMiniInfoTypeRelease;
    [LFBShareMoudle showShareViewWithObject:model];
}


- (void)loginBtn:(UIButton *)sender{
    [LFBShareMoudle loginWithChannelType:LFBChannelTypeWX success:^(LFBChannelBase *channel, id data) {
        LFBUserInfo *userInfo = data;
        NSLog(@"%@",userInfo.nickname);
    } fail:^(LFBChannelBase *channel, NSError *error) {
        NSLog(@"%@",error);
    } cancel:^(LFBChannelBase *channel) {
        NSLog(@"取消操作");
    }];
}




@end
