//
//  UIImageView+Add.m
//  Cars
//
//  Created by gdswww on 14-11-20.
//  Copyright (c) 2014年 李铁柱. All rights reserved.
//

#import "UIImageView+Add.h"
#import "GlobalMethod.h"

@implementation UIImageView (Add)

- (void)setImageFormUrl:(NSString *)url
{
    if (!url){return;}
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *filename1 = [url lastPathComponent];
        
        UIImage *image = nil;
        
        image = [globalMethod().cachDict objectForKey:filename1];
        if (image)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
            });
            
            return ;
        }
        image = getImageFromLocation(filename1);
        if (image)
        {
            [globalMethod().cachDict setObject:image forKey:filename1];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
            });
            return;
        }
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        
        image = [UIImage imageWithData:data];
        if (image)
        {
            saveImageToLocation(filename1, data);
            [globalMethod().cachDict setObject:image forKey:filename1];
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.image = image;
            });
        }
    });
}

- (void)setImageViewFormUrl:(NSString *)url
{
    if (!url){return;}
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      //  NSString *filename1 = [url lastPathComponent];
        
        UIImage *image = nil;
       
       // NSLog(@"无缓存 url %@",url);
//        image = [globalMethod().cachDict objectForKey:filename1];
//        if (image)
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.image = image;
//            });
//            
//            return ;
//        }
//        image = getImageFromLocation(filename1);
//        if (image)
//        {
//            [globalMethod().cachDict setObject:image forKey:filename1];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.image = image;
//            });
//            return;
//        }
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        
        image = [UIImage imageWithData:data];
        if (image)
        {
//            saveImageToLocation(filename1, data);
//            [globalMethod().cachDict setObject:image forKey:filename1];
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.image = image;
            });
        }
    });

}

- (void)setImageFormUrl:(NSString *)url TmpImage:(UIImage *)tmpImage
{
    self.image = tmpImage;
    [self setImageFormUrl:url];
}



@end
