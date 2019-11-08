//
//  StarView.h
//  EvaluationStar
//
//  Created by 赵贺 on 15/11/26.
//  Copyright © 2015年 赵贺. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StarViewDelegate <NSObject>

-(void)KaoPuDusendStarNum:(int)StarNum;
-(void)ZhuanYeZhiShusendStarNum:(int)StarNum;
-(void)XueBaZhiShusendStarNum:(int)StarNum;


@end

@interface StarView : UIView

- (id)initWithFrame:(CGRect)frame EmptyImage:(NSString *)Empty StarImage:(NSString *)Star;

@property(nonatomic,strong)id<StarViewDelegate>delegate;
@property(nonatomic,strong)id<StarViewDelegate>delegate1;
@property(nonatomic,strong)id<StarViewDelegate>delegate2;

@end
