//
//  MJCSaoYiSaoViewController.h
//  ZhuBaoApp
//
//  Created by mojiongchangMac on 2018/3/27.
//  Copyright © 2018年 HQJ. All rights reserved.
//


@protocol MJCSaoYiSaoViewControllerDelegate<NSObject>

-(void)erweimaSaoMiaoWith:(NSString *)idStr;

@end
@interface MJCSaoYiSaoViewController : UIViewController

@property(nonatomic,assign)int iszhuce;

@property(nonatomic,weak)id<MJCSaoYiSaoViewControllerDelegate>delegate;

@end
