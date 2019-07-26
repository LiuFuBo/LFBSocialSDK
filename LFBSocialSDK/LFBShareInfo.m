//
//  LFBShareInfo.m
//  LFBSocialSDKDemo
//
//  Created by liufubo on 2018/12/17.
//  Copyright © 2018 liufubo. All rights reserved.
//

#import "LFBShareInfo.h"

@implementation LFBShareInfo

@end

@implementation LFBShareText

@end

@implementation LFBShareMedia

@end

@implementation LFBShareImage

@end

@implementation LFBShareWebPage

@end

@implementation LFBShareMusic

@end

@implementation LFBShareVideo


@end

@implementation LFBShareApplet

- (void)setHdImageData:(NSData *)hdImageData {
    _hdImageData = [self condenceQualityWithObj:hdImageData maxLength:120*1024];
}

- (void)setThumbData:(NSData *)thumbData {
    _thumbData = [self condenceQualityWithObj:thumbData maxLength:30*1024];
}

- (NSData *)condenceQualityWithObj:(NSData *)obj maxLength:(NSInteger)maxLength {
    
    UIImage *image = nil;
    if (obj.length < maxLength) {
        return obj;
    }else{
        image = [UIImage imageWithData:obj];
    }
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    if (data.length < maxLength) return data;
    //连续6次压缩还是大于目标尺寸，则进行尺寸压缩
    UIImage *resultImage = [UIImage imageWithData:data];
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //这里之所以用开方是因为当一个数无限次开发，这个数字无限接近1
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return data;
}

@end


