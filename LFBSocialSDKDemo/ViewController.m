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
    model.shareType = LFBChannelTypeWX;
    model.shareInfoType = LFBShareInfoTypeText;
    model.text = @"大家来找茬!!!";
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
