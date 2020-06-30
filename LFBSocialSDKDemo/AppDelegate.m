//
//  AppDelegate.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/17.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "AppDelegate.h"
#import "LFBChannelManager.h"
#import "LFBShareChannelConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configChannel];
    return YES;
}

- (void)configChannel{
    LFBShareChannelConfig *config = [[LFBShareChannelConfig alloc]init];
    [[LFBChannelManager sharedManager] setDelegate:config];
    [config setChannelType:LFBChannelTypeWX appKey:@"wx512bbc9e05bf9db0" appSecret:@"1d44d80947bb3821506e440116f73168" universalLink:@"https://tapi.eyxyt.com"];
    [config setChannelType:LFBChannelTypePYQ appKey:@"wx512bbc9e05bf9db0" appSecret:@"1d44d80947bb3821506e440116f73168" universalLink:nil];
    [config setChannelType:LFBChannelTypeQQ appKey:@"1101053067" appSecret:nil universalLink:nil];
    [config setChannelType:LFBChannelTypeQQZone appKey:@"1101053067" appSecret:nil universalLink:nil];
    [config setChannelType:LFBChannelTypeSinaWB appKey:@"1843267010" appSecret:@"b2f5b2b661babaa3c01b57312decffd7" universalLink:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
