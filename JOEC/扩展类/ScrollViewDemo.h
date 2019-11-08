//
//  ScrollViewDemoj.h
//  UIScollView Sample
//
//  Created by QF on 15-6-18.
//  Copyright (c) 2015年 QF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJCScrollViewDemoDelegate<NSObject>

-(void)ScrollViewtupianClickWith:(int)cilckIndex;

@end

@interface ScrollViewDemo : UIViewController

@property(nonatomic,weak)id<MJCScrollViewDemoDelegate>delegate;

//require
@property(nonatomic,strong)NSArray *photoArray;

@property(nonatomic,assign)CGRect scrollViewFrame;

/*
 ScrollViewDemo *svc = [[ScrollViewDemo alloc]init];
 
 NSArray *photoArray = @[@"Welcome_3.0_1.jpg",@"Welcome_3.0_2.jpg",@"Welcome_3.0_3.jpg",@"Welcome_3.0_4.jpg",@"Welcome_3.0_5.jpg"];
 
 //必须设置的图片数组
 svc.photoArray = photoArray;
 
 //必须写在view.frame设置之前
 svc.scrollViewFrame = CGRectMake(0, 0, self.view.frame.size.width, 500);
 
 svc.view.frame = self.view.bounds;
 
 [self.view addSubview:svc.view];
 
 [self addChildViewController:svc];
 */

@end

