//
//  LFBShareModel.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/27.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBSharePlateforms.h"

@implementation LFBSharePlateforms

- (LFBShareInfo *)shareModel{
    if (_shareInfoType == LFBShareInfoTypeWeb) {
        LFBShareWebPage *web = [LFBShareWebPage new];
        web.title = self.title;
        web.desc = self.desc;
        web.url = self.url;
        web.thumbnailData = self.thubnailData;
        web.originalImageData = self.originalImageData;
        return web;
    }else if (_shareInfoType == LFBShareInfoTypeText){
        LFBShareText *text = [LFBShareText new];
        text.text = self.text;
        return text;
    }else if (_shareInfoType == LFBShareInfoTypeMedia){
        LFBShareMedia *media = [LFBShareMedia new];
        media.title = self.title;
        media.desc = self.desc;
        media.thumbnailData = self.thubnailData;
        media.originalImageData = self.originalImageData;
        return media;
    }else if (_shareInfoType == LFBShareInfoTypeImage){
        LFBShareImage *image = [LFBShareImage new];
        image.title = self.title;
        image.desc = self.desc;
        image.image = self.image;
        image.thumbnailData = self.thubnailData;
        image.originalImageData = self.originalImageData;
        return image;
    }else if (_shareInfoType == LFBShareInfoTypeMusic){
        LFBShareMusic *music = [LFBShareMusic new];
        music.title = self.title;
        music.desc = self.desc;
        music.thumbnailData = self.thubnailData;
        music.originalImageData = self.originalImageData;
        music.musicUrl = self.musicUrl;
        music.musicLowBandUrl = self.musicLowBandUrl;
        music.musicDataUrl = self.musicDataUrl;
        music.musicLowBandDataUrl = self.musicLowBandDataUrl;
        return music;
    }else if (_shareInfoType == LFBShareInfoTypeVideo){
        LFBShareVideo *video = [LFBShareVideo new];
        video.title = self.title;
        video.desc = self.desc;
        video.thumbnailData = self.thubnailData;
        video.originalImageData = self.originalImageData;
        video.videoUrl = self.videoUrl;
        video.videoLowBandUrl = self.videoLowBandUrl;
        video.videoStreamUrl = self.videoStreamUrl;
        video.videoLowBandStreamUrl = self.videoLowBandStreamUrl;
        return video;
    }else if (_shareInfoType == LFBShareInfoTypeApplet){
        LFBShareApplet *applet = [LFBShareApplet new];
        applet.title = self.title;
        applet.path = self.path;
        applet.desc = self.desc;
        applet.webPageUrl = self.webPageUrl;
        applet.userName = self.userName;
        applet.hdImageData = self.hdImageData;
        applet.withShareTicket = self.withShareTicket;
        applet.miniProgramType = self.miniProgramType;
        return applet;
    }
    return nil;
}

- (void)resetParams{
    _shareType = -1;
    _shareInfoType = -1;
    _title = nil;
    _desc = nil;
    _text = nil;
    _thubnailData = nil;
    _originalImageData = nil;
    _url = nil;
    _image = nil;
    _musicUrl = nil;
    _musicLowBandUrl= nil;
    _musicDataUrl = nil;
    _musicLowBandDataUrl = nil;
    _videoUrl = nil;
    _videoLowBandUrl = nil;
    _videoStreamUrl = nil;
    _videoLowBandStreamUrl = nil;
    _webPageUrl = nil;
    _userName = nil;
    _path = nil;
    _hdImageData = nil;
    _withShareTicket = NO;
    _miniProgramType = LFBShareMiniInfoTypeRelease;
}

@end
