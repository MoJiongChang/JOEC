//
//  ToolMethod.m
//  TeacherHunter
//
//  Created by gdswww02 on 16/4/7.
//  Copyright (c) 2016年 gdswww02. All rights reserved.
//

#import "ToolMethod.h"

@implementation ToolMethod


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
                        withText:(NSString *)text{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.font = font;
    label.text = text;
    return label;
}


/**
 *  创建button
 *
 *  @param frame     frame
 *  @param title     文本
 *  @param textColor 字体颜色
 *  @param font      字体
 *
 *  @return <#return value description#>
 */
+(UIButton *)createButtonWithFrame:(CGRect)frame
                         withTitle:(NSString *)title
                     withTextColor:(UIColor *)textColor
                          withFont:(UIFont *)font
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
    
}


+(UITextField *)createTextFieldWithFrame:(CGRect)frame
                           withTextColor:(UIColor *)textColor
                       withTextAlignment:(NSTextAlignment)textAlignment
                                withFont:(CGFloat)font
                                withText:(NSString *)text{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.textColor = textColor;
    textField.textAlignment = textAlignment;
    textField.font = [UIFont systemFontOfSize:font];
    textField.text = text;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}



+(UIButton *)createImageBtnWithFrame:(CGRect )frame
                           withTitle:(NSString *)title
                       withImageName:(NSString *)imageName
                       withTextColor:(UIColor *)textColor
               withSelectedTextColor:(UIColor *)selectedTextColor
            withHighlightedTextColor:(UIColor *)highlightedColor
                            withFont:(CGFloat)font
                 withImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
                 withTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    //设置字体颜色
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    [btn setTitleColor:selectedTextColor forState:UIControlStateSelected];
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    // 设置文本和图片的位置
    [btn setImageEdgeInsets:imageEdgeInsets];
    [btn setTitleEdgeInsets:titleEdgeInsets];
    
    return btn;
}

+(UIView *)createViewWithFrame:(CGRect)frame
           withBackgroundColor:(UIColor *)backgroundColor
                     withAlpha:(CGFloat)alpha{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    view.alpha = alpha;
    return view;
}

+(UIImageView *)createImageViewWithFrame:(CGRect )frame
                           withImageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

+(UIImageView *)createCornerRadiusImageViewWithFrame:(CGRect )frame
                                       withImageName:(NSString *)imageName
                                    withCornerRadius:(CGFloat)radius
                                         contentMode:(UIViewContentMode)contentMode{
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:frame];
    imageview = [ToolMethod createImageViewWithFrame:frame withImageName:imageName];
    imageview.contentMode = contentMode;
    imageview.layer.cornerRadius = radius;
    imageview.clipsToBounds = YES;
    return imageview;
}



+(UIControl *)createLineWithFrame:(CGRect )frame
              withBackgroundColor:(UIColor *)backgroundColor{
    UIControl *line = [[UIControl alloc]init];
    line = [[UIControl alloc]initWithFrame:frame];
    line.backgroundColor = backgroundColor;
    return line;
}


+(UIView *)createWindowAlphaViewWithFrame:(CGRect)frame
                                withAlpha:(CGFloat)alpha
                               withTarget:(id)target
                                  withSEL:(SEL)selector{
    //透明层
    UIView* alphaView = [[UIView alloc]initWithFrame:frame];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    alphaView.userInteractionEnabled = YES;
    [alphaView addGestureRecognizer:tapGR];
    return alphaView;
}
@end
