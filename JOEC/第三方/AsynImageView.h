//
//  AsynImageView.h
//  yuexi
//
//  Created by ltz on 15/3/10.
//  Copyright (c) 2015年 李志彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AsynImageView : UIImageView
{
    NSURLConnection *connection;
    NSMutableData *loadData;
}
//图片对应的缓存在沙河中的路径
@property (nonatomic, retain) NSString *fileName;

//指定默认未加载时，显示的默认图片
@property (nonatomic, retain) UIImage *placeholderImage;

//请求网络图片的URL
@property (nonatomic, retain) NSString *imageURL;

@end
