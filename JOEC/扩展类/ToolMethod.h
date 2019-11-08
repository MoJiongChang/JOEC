//
//  ToolMethod.h
//  TeacherHunter
//
//  Created by gdswww02 on 16/4/7.
//  Copyright (c) 2016年 gdswww02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ToolMethod : NSObject
/**
 *  创建label
 *
 *  @param frame         frame
 *  @param textColor     字体颜色
 *  @param textAlignment 对齐方式
 *  @param font          字体
 *  @param text          文本
 *
 *  @return 返回label
 */
+(UILabel *)createLableWithFrame:(CGRect)frame
                   withTextColor:(UIColor *)textColor
               withTextAlignment:(NSTextAlignment)textAlignment
                        withFont:(UIFont *)font
                        withText:(NSString *)text;



//创建按钮  同上
+(UIButton *)createButtonWithFrame:(CGRect)frame
                         withTitle:(NSString *)title
                     withTextColor:(UIColor *)textColor
                          withFont:(UIFont *)font;


//创建文本  同上
+(UITextField *)createTextFieldWithFrame:(CGRect)frame
                           withTextColor:(UIColor *)textColor
                       withTextAlignment:(NSTextAlignment)textAlignment
                                withFont:(CGFloat)font
                                withText:(NSString *)text;


//创建view 同上
+(UIView *)createViewWithFrame:(CGRect)frame
           withBackgroundColor:(UIColor *)backgroundColor
                     withAlpha:(CGFloat)alpha;

//图文按钮

+(UIButton *)createImageBtnWithFrame:(CGRect )frame
                           withTitle:(NSString *)title
                       withImageName:(NSString *)imageName
                       withTextColor:(UIColor *)textColor
               withSelectedTextColor:(UIColor *)selectedTextColor
            withHighlightedTextColor:(UIColor *)highlightedColor
                            withFont:(CGFloat)font
                 withImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
                 withTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;

//图片
+(UIImageView *)createImageViewWithFrame:(CGRect )frame
                           withImageName:(NSString *)imageName;

//切图角的图片
+(UIImageView *)createCornerRadiusImageViewWithFrame:(CGRect )frame
                                       withImageName:(NSString *)imageName
                                    withCornerRadius:(CGFloat)radius
                                         contentMode:(UIViewContentMode)contentMode;

//画线
+(UIControl *)createLineWithFrame:(CGRect )frame
              withBackgroundColor:(UIColor *)backgroundColor;

//创建透明层
+(UIView *)createWindowAlphaViewWithFrame:(CGRect)frame
                                withAlpha:(CGFloat)alpha
                               withTarget:(id)target
                                  withSEL:(SEL)selector;
@end
