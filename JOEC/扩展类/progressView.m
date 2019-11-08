//
//  progressView.m
//  washinMachine
//
//  Created by ltz on 15/7/29.
//  Copyright (c) 2015年 李志彬. All rights reserved.
//

#import "progressView.h"



@implementation progressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
     [self addCenterBack];
}

- (void)addCenterBack
{
    
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    // Draw the slices.
    CGFloat radius = viewSize.width / 2;
    CGContextBeginPath(contextRef);
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y, radius - 10,0.3*M_PI,1.0*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef, [UIColor colorWithRed:46/255.0 green:186/255.0 blue:226/255.0 alpha:1].CGColor);

    CGContextFillPath(contextRef);

    CGContextRef contextRef1 = UIGraphicsGetCurrentContext();
    CGContextBeginPath(contextRef1);
    CGContextMoveToPoint(contextRef1, center.x, center.y);
    CGContextAddArc(contextRef1, center.x, center.y, radius,1.0*M_PI, 1.5*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef1, [UIColor colorWithRed:178/255.0 green:234/255.0 blue:253/255.0 alpha:1].CGColor);

    CGContextFillPath(contextRef1);
    
    CGContextRef contextRef2 = UIGraphicsGetCurrentContext();
    CGContextBeginPath(contextRef2);
    CGContextMoveToPoint(contextRef2, center.x, center.y);
    CGContextAddArc(contextRef2, center.x, center.y, radius-10,1.5*M_PI, 1.9*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef2, [UIColor colorWithRed:162/255.0 green:230/255.0 blue:253/255.0 alpha:1].CGColor);
    
    CGContextFillPath(contextRef2);
    
    
    CGContextRef contextRef3 = UIGraphicsGetCurrentContext();
    CGContextBeginPath(contextRef3);
    CGContextMoveToPoint(contextRef3, center.x, center.y);
    CGContextAddArc(contextRef3, center.x, center.y, radius-10,1.9*M_PI, 2.3*M_PI, 0);
    CGContextSetFillColorWithColor(contextRef3, [UIColor colorWithRed:104/255.0 green:205/255.0 blue:238/255.0 alpha:1].CGColor);
    
    CGContextFillPath(contextRef3);


}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/

@end
