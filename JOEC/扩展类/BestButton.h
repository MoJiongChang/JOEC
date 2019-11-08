//
//  BestButton.h
//  Cars
//
//  Created by gdswww on 14-11-19.
//  Copyright (c) 2014年 李铁柱. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface BestButton : UIButton


@property (nonatomic, assign) BOOL isTitleCenter;

/* 支持左对齐 居中 右对齐 */
@property (nonatomic) NSTextAlignment textAlignment;

/* 设置左对齐 右对齐 间距 */
@property (nonatomic) CGFloat interval;

/* 设置图片大小   */
@property (nonatomic) CGSize imageSize;

@property (nonatomic) CGPoint imagePoint;



@end
