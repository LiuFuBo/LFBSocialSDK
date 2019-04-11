//
//  AppDelegate+Scheme.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/26.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "AppDelegate+Scheme.h"
#import "LFBChannelManager.h"

@implementation AppDelegate (Scheme)

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if (@available(iOS 9.0, *)) {
        return  [self handlerOuterURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [self handlerOuterURL:url sourceApplication:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [self handlerOuterURL:url sourceApplication:sourceApplication];
}

- (BOOL)handlerOuterURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication{
    return [[LFBChannelManager sharedManager] handleOpenURL:url];
}


@end
