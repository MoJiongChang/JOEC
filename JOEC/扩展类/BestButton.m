//
//  BestButton.m
//  Cars
//
//  Created by gdswww on 14-11-19.
//  Copyright (c) 2014年 李铁柱. All rights reserved.
//

#import "BestButton.h"

@implementation BestButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super titleRectForContentRect:contentRect];
    
    if (_textAlignment == NSTextAlignmentLeft)
    {
        //interval
        frame.origin.x = _interval;
    }
    else if (_textAlignment == NSTextAlignmentRight)
    {
        frame.origin.x = contentRect.size.width - (_interval + frame.size.width);
    }
    else
    {
       frame.origin.x = (contentRect.size.width - frame.size.width) / 2.0f;
    }

    
    return frame;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super imageRectForContentRect:contentRect];
    if (CGSizeEqualToSize(_imageSize, CGSizeZero))
    {
        return frame;
    }
    frame.size = _imageSize;
    if (CGPointEqualToPoint(_imagePoint, CGPointZero))
    {
        frame.origin = CGPointMake((contentRect.size.width - _imageSize.width) / 2, (contentRect.size.height - _imageSize.height) / 2);
    }
    else
        frame.origin = _imagePoint;
    
    return frame;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
