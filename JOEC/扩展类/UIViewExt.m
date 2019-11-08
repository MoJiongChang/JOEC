/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import "UIViewExt.h"

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (ViewGeometry)

// Retrieve and set the origin
- (CGPoint) origin
{
	return self.frame.origin;
}

- (CGFloat)getRelativelyHight:(CGFloat)aH andY:(CGFloat)aY
{
    
    CGFloat h = [UIScreen mainScreen].bounds.size.height - aY - aH;
    return h;
    
}

- (void) setOrigin: (CGPoint) aPoint
{
	CGRect newframe = self.frame;
	newframe.origin = aPoint;
	self.frame = newframe;
}
- (CGFloat) getOriginXAddWidth
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    return x;
}
- (void) setAddFrmaeX: (CGFloat) aX andWidth:(CGFloat)aW
{
    CGRect rect = self.frame;
    rect.origin.x -= aX;
    rect.size.width += aW;
    self.frame = rect;
}
- (void) setLayerCornerRadius:(CGFloat)aC borderColor:(UIColor *)ab borderWidth:(CGFloat)aw
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = aC;
    if (ab)
    {
        self.layer.borderColor = ab.CGColor;
    }
    
    self.layer.borderWidth = aw;
}
- (void) setFrameY: (CGFloat)aY
{
    CGRect rect = self.frame;
    rect.origin.y = aY;
    self.frame = rect;
}
- (void) setReductionFrmaeX: (CGFloat) aX andWidth:(CGFloat)aW
{
    CGRect rect = self.frame;
    rect.origin.x += aX;
    rect.size.width -= aW;
    self.frame = rect;
}
- (void) setFrmaeWidth: (CGFloat) aW
{
    CGRect rect = self.frame;
    rect.size.width += aW;
    self.frame = rect;

}
// Retrieve and set the size
- (CGSize) size
{
	return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
	CGRect newframe = self.frame;
	newframe.size = aSize;
	self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
	CGFloat x = self.frame.origin.x;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint) topRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y;
	return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) height
{
	return self.frame.size.height;
}
- (void) CompatibleFrame
{
    CGRect frame = self.frame;
    frame.size.height -= 44 + 64;
    self.frame = frame;
}
- (void) CompatibleFrame1
{
    CGRect frame = self.frame;
    frame.size.height -= 64;
    self.frame = frame;
}
- (void) setHeight: (CGFloat) newheight
{
	CGRect newframe = self.frame;
	newframe.size.height = newheight;
 
	self.frame = newframe;
}
- (void) setViewLayer
{
    self.layer.cornerRadius = 3.0;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0;
    
}
- (CGFloat) width
{
	return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
	CGRect newframe = self.frame;
	newframe.size.width = newwidth;
	self.frame = newframe;
}

- (CGFloat) top
{
	return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
	CGRect newframe = self.frame;
	newframe.origin.y = newtop;
	self.frame = newframe;
}

- (CGFloat) left
{
	return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
	CGRect newframe = self.frame;
	newframe.origin.x = newleft;
	self.frame = newframe;
}

- (CGFloat) bottom
{
	return self.frame.origin.y + self.frame.size.height;
}
- (CGFloat) HorizontalIntermediate
{
    return self.bounds.size.width / 2.0;
}
- (CGFloat) LongitudinalMiddle
{
    return self.bounds.size.height / 2.0;
}

- (void) setBottom: (CGFloat) newbottom
{
	CGRect newframe = self.frame;
	newframe.origin.y = newbottom - self.frame.size.height;
	self.frame = newframe;
}

- (CGFloat) right
{
	return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
	CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
	CGRect newframe = self.frame;
	newframe.origin.x += delta ;
	self.frame = newframe;
}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
	CGPoint newcenter = self.center;
	newcenter.x += delta.x;
	newcenter.y += delta.y;
	self.center = newcenter;
}
- (void) setFrmaeHight: (CGFloat) aHight
{
    CGRect newframe = self.frame;
	newframe.size.height = aHight;
	self.frame = newframe;
}
- (void) addOriginY: (CGFloat) aY
{
    CGRect newframe = self.frame;
	newframe.origin.y += aY;
	self.frame = newframe;
}
// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
	CGRect newframe = self.frame;
	newframe.size.width *= scaleFactor;
	newframe.size.height *= scaleFactor;
	self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
	CGFloat scale;
	CGRect newframe = self.frame;
	
	if (newframe.size.height && (newframe.size.height > aSize.height))
	{
		scale = aSize.height / newframe.size.height;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	if (newframe.size.width && (newframe.size.width >= aSize.width))
	{
		scale = aSize.width / newframe.size.width;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	self.frame = newframe;	
}

- (UIImage *) getBackgroundColorImage
{
    self.layer.hidden = YES;
    id view = self.superview;
    if (!view)
    {
        return nil;
    }
    while (![view isMemberOfClass:[UIView class]])
    {
        
        view = [(UIView *)view superview];
    }
    UIView *superView = view;
    UIGraphicsBeginImageContext(superView.frame.size); //currentView 当前的view
    
    [superView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRef imageRef = CGImageCreateWithImageInRect(viewImage.CGImage, self.frame);
    viewImage = [UIImage imageWithCGImage:imageRef];
    CFRelease(imageRef);
    
    UIGraphicsEndImageContext();
    self.layer.hidden = NO;
    return viewImage;
}


- (void)shakeAnimation

{
    
    // 获取到当前的View
    
    CALayer *viewLayer = self.layer;
    
    // 获取当前View的位置
    
    CGPoint position = viewLayer.position;
    
    // 移动的两个终点位置
    
    CGPoint x = CGPointMake(position.x + 10, position.y);
    
    CGPoint y = CGPointMake(position.x - 10, position.y);
    
    // 设置动画
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    // 设置运动形式
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    // 设置开始位置
    
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    
    // 设置结束位置
    
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    
    // 设置自动反转
    
    [animation setAutoreverses:YES];
    
    // 设置时间
    
    [animation setDuration:.06];
    
    // 设置次数
    
    [animation setRepeatCount:3];
    
    // 添加上动画
    
    [viewLayer addAnimation:animation forKey:nil];
    
    
    
}


@end