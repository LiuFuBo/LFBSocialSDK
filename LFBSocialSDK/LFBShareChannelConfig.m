//
//  LFBShareChannelConfig.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/20.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBShareChannelConfig.h"

@interface LFBShareChannelConfig ()
//渠道map
@property (nonatomic, strong) NSMutableDictionary *channelInfoMap;
@end

@implementation LFBShareChannelConfig

- (NSDictionary *)channelInfoWithType:(LFBChannelType)channelType
{
    return self.channelInfoMap[@(channelType)];
}

- (void)setChannelType:(LFBChannelType)channelType appKey:(NSString *)appkey appSecret:(NSString *)appSecret universalLink:(NSString *)universalLink{
    switch (channelType) {
        case LFBChannelTypeWX:
        {
            if (appkey.length == 0 || appSecret.length == 0 || universalLink.length == 0) {
                return;
            }
            NSDictionary *wxInfo = @{@"appKey": appkey,
                                     @"appSecret": appSecret,
                                     @"normalIcon": @"icon_share_weixin",
                                     @"selectedIcon": @"icon_share_weixin",
                                     @"universalLink":universalLink.length>0 ? universalLink : @""
                                     };
            [self.channelInfoMap setObject:wxInfo forKey:@(LFBChannelTypeWX)];
        }
            break;
        case LFBChannelTypePYQ:
        {
            if (appkey.length == 0 || appSecret.length == 0) {
                return;
            }
            NSDictionary *pyqInfo = @{@"appKey": appkey,
                                      @"appSecret": appSecret,
                                      @"normalIcon": @"icon_share_pengyouquan",
                                      @"selectedIcon": @"icon_share_pengyouquan",
                                      @"universalLink":universalLink.length>0 ? universalLink : @""
                                      };
            [self.channelInfoMap setObject:pyqInfo forKey:@(LFBChannelTypePYQ)];
        }
            break;
        case LFBChannelTypeQQ:
        {
            if (appkey.length == 0) {
                return;
            }
            NSDictionary *qqFriendInfo = @{@"appKey":appkey,
                                           @"normalIcon":  @"icon_share_qq",
                                           @"selectedIcon": @"icon_share_qq",
                                           @"universalLink":universalLink.length>0 ? universalLink : @""
                                           };
            [self.channelInfoMap setObject:qqFriendInfo forKey:@(LFBChannelTypeQQ)];
        }
            break;
        case LFBChannelTypeQQZone:
        {
            if (appkey.length == 0) {
                return;
            }
            NSDictionary *qqZoneInfo = @{@"appKey": appkey,
                                         @"normalIcon": @"icon_share_zone",
                                         @"selectedIcon": @"icon_share_zone",
                                         @"universalLink":universalLink.length>0 ? universalLink : @""
                                         };
            [self.channelInfoMap setObject:qqZoneInfo forKey:@(LFBChannelTypeQQZone)];
        }
            break;
        case LFBChannelTypeSinaWB:
        {
            if (appkey.length == 0 || appSecret.length == 0) {
                return;
            }
            NSDictionary *wbInfo = @{@"appKey": appkey,
                                     @"appSecret": appSecret,
                                     @"normalIcon": @"icon_share_weibo",
                                     @"selectedIcon": @"icon_share_weibo",
                                     @"universalLink":universalLink.length>0 ? universalLink : @""
                                     };
            [self.channelInfoMap setObject:wbInfo forKey:@(LFBChannelTypeSinaWB)];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Getter & Setter
- (NSMutableDictionary *)channelInfoMap{
    if (!_channelInfoMap) {
        _channelInfoMap = [NSMutableDictionary dictionary];
    }
    return _channelInfoMap;
}

@end
