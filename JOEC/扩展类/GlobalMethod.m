//
//  GlobalMethod.m
//  醉清风
//
//  Created by ltz on 14/12/3.
//  Copyright (c) 2014年 com.gdswww.www. All rights reserved.
//

#import "GlobalMethod.h"

static GlobalMethod *gl = nil;

@implementation GlobalMethod


GlobalMethod *globalMethod()
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gl = [[GlobalMethod alloc] init];
        gl.cachDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        
    });
    return gl;
}
NSString *getLibraryPath()
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    return path;
}
void saveImageToLocation(NSString *filename,NSData *data)
{
    NSString *path = getLibraryPath();
    path = [path stringByAppendingPathComponent:@"eImage"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isEx = [fm fileExistsAtPath:path];
    if (!isEx)
    {
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:filename];
    [data writeToFile:path atomically:YES];
    
}
UIImage *getImageFromLocation(NSString *filename)
{
    NSString *path = getLibraryPath();
    path = [path stringByAppendingPathComponent:@"eImage"];
    path = [path stringByAppendingPathComponent:filename];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage imageWithData:data];
    return image ? image : nil;
}

void saveUserInfo(NSString *keyName,NSString *valueName)
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:valueName forKey:keyName];
    [def synchronize];
    
}
NSString *  getUserInfo(NSString *keyName)
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:keyName];
}
void removeUserInfo(NSString *key)
{
   NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def removeObjectForKey:key];
    [def synchronize];
    
}

NSString *modeContent(id contentStr, NSString *tidaiStr)
{
    if (![contentStr isKindOfClass:[NSNull class]] && [contentStr isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@",contentStr];
    }
    return tidaiStr;
}

//自定义颜色转换
id colorWithHexString  (NSString *color)
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

UIImage * fixOrientation(UIImage *aImage)
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
