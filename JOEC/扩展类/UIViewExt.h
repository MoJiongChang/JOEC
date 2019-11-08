/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

//方便使用 [self.view.frame.orign.width] == [self.view.width]

#import <UIKit/UIKit.h>


CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)


@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;
@property CGFloat HorizontalIntermediate;
@property CGFloat LongitudinalMiddle;




- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;
- (void) setFrameY: (CGFloat)aY;
- (void) setFrmaeHight: (CGFloat) aHight;
- (void) setAddFrmaeX: (CGFloat) aX andWidth:(CGFloat)aW;
- (void) setReductionFrmaeX: (CGFloat) aX andWidth:(CGFloat)aW;
- (void) setAddFrmaeY: (CGFloat) aX andHight:(CGFloat)aH;
- (void) addOriginY: (CGFloat) aY;
- (CGFloat)getRelativelyHight:(CGFloat)aH andY:(CGFloat)aY;
- (CGFloat) getOriginXAddWidth;
- (void) setLayerCornerRadius:(CGFloat)aC borderColor:(UIColor *)ab borderWidth:(CGFloat)aw;
- (void) CompatibleFrame;
- (void) CompatibleFrame1;


- (void) setViewLayer;
- (void) shakeAnimation;


- (UIImage *) getBackgroundColorImage;



@end