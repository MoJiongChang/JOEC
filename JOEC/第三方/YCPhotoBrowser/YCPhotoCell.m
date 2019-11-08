//
//  YCImageCell.m
//  PhotoBrowser
//
//  Created by 余浩然 on 14-10-1.
//  Copyright (c) 2014年 YuChengGuo. All rights reserved.
//

#import "YCPhotoCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#define screenWidth  [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

//#import "YCHUD.h"
#import "MDRadialProgressView.h"  //进度视图
#import "MDRadialProgressTheme.h" //进度视图属性设置
#import "SDWebImageManager.h"     //下载图片有进度
#import "UIImageView+WebCache.h"  //异步下载图片
@implementation YCPhotoCell
{
    UIImageView *imageView;       //图片视图
    UIScrollView *imageScrollView;//显示图片放大的滚动视图
    
    MDRadialProgressView *progressView;//图片下载进度视图
    UIActivityIndicatorView *actView;  //图片下载菊花视图
    NSInteger selectedRow;             //记录翻到了那张图片
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor=[UIColor clearColor];
        [self setScrollView];
        [self setImageView];
        [self radialProgressView];
    }
    return self;
}
//设置滚动视图
-(void)setScrollView
{
    //滚动视图设置
    imageScrollView=[[UIScrollView alloc]init];
    imageScrollView.frame =CGRectMake(0, 0, screenWidth, screenHeight);//全屏
    //居中
    imageScrollView.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    imageScrollView.backgroundColor=[UIColor blackColor];//这个背景必须为黑色
    //设置滚动视图自带缩放的一些属性(在代理函数里指定那个视图可缩放,必须是加入到了滚动视图里的)
    imageScrollView.maximumZoomScale=4;   //放大到最大是5倍(这个可以不设置),1为不放大
    imageScrollView.zoomScale=1;          //设置放大缩小值(大于1为放大,小于1为缩小,等于1为原大小)
    imageScrollView.minimumZoomScale=1;   //缩小到最小是0.2倍(这个必须设置),1为不缩小
    imageScrollView.showsHorizontalScrollIndicator=NO;  //隐藏水平滚动条
    imageScrollView.showsVerticalScrollIndicator=NO;    //隐藏垂直滚动条
    imageScrollView.delegate=self;
    [self addSubview:imageScrollView];
    
    //点击手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] init];
    [tap1 addTarget:self action:@selector(tapImage:)];
    [imageScrollView addGestureRecognizer:tap1];
    
    //双击手势
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] init];
    [tap1 requireGestureRecognizerToFail:tap2];     //防止同时响应这2个手势
    [tap2 addTarget:self action:@selector(dblclickImage:)];
    tap2.numberOfTapsRequired=2;                    //设置为双击手势
    [imageScrollView addGestureRecognizer:tap2];
    
    //长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [tap2 requireGestureRecognizerToFail:longPress];//防止同时响应这2个手势
    //设置长按0.5秒调用第一次
    longPress.minimumPressDuration=0.5;
    [imageScrollView addGestureRecognizer:longPress];
}
//设置图片视图
-(void)setImageView
{
    //设置图片视图
    imageView=[[UIImageView alloc]init];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    [imageScrollView addSubview:imageView];
}
//设置进度视图
-(void)radialProgressView
{
    //进度视图一些属性设置
    MDRadialProgressTheme *newTheme = [[MDRadialProgressTheme alloc] init];
    newTheme.completedColor = [UIColor whiteColor];  //进度颜色
    newTheme.incompletedColor = [UIColor grayColor]; //木有进度的颜色
    newTheme.centerColor = [UIColor clearColor];     //圆圈中间的颜色
    newTheme.sliceDividerHidden = YES;               //显示圆形进度
    newTheme.labelColor = [UIColor clearColor];      //进度数字颜色(透明隐藏)
    newTheme.labelShadowColor = [UIColor clearColor];//进度数字阴影颜色(透明隐藏)
    
    //进度视图
    CGRect frame =CGRectMake(0, 0, 50, 50);
    progressView=[[MDRadialProgressView alloc] initWithFrame:frame andTheme:newTheme];
    //居中
    progressView.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    progressView.progressTotal = 100;//进度最大值
    progressView.progressCounter = 1;//开始的进度值
    //[self addSubview:progressView];
    
    //菊花视图
    actView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    actView.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    actView.color=[UIColor whiteColor];
    [self addSubview:actView];
}

#pragma mark- 图片下载处理
//刷新图片
-(void)refreshImage:(NSString *)imageUrl selectedImage:(UIImage *)image selectedRow:(NSInteger)row;
{
    //记录翻到了那张图片
    selectedRow=row;
    
    //复用cell时,先还原图片大小
    imageScrollView.zoomScale=1;
    //显示下载进度视图
    progressView.alpha=1;
    //开始转圈
    [actView startAnimating];
     actView.hidesWhenStopped=NO;
    //设置新传来的缩略图
    imageView.image=image;
    //如果有缩略图就计算位置大小
    if (image!=nil) {
        imageView.frame=[self computingCenter:image];
    }

    //下载图片(SDWebImageRetryFailed:失败后重试)
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //设置进度
        NSInteger progressValue=(CGFloat)receivedSize/expectedSize *100;
        progressView.progressCounter = progressValue <1 ? 1:progressValue;//进度值
        //NSLog(@"%ld",progressValue);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        //如果断网会木有下载到图片就结束,不然会崩溃
        if (image==nil) {
            return ;
        }
        
        //设置图片视图的位置大小
        imageView.frame=[self computingCenter:image];
        //这样设置为了显示动态图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
        
        //下载完成隐藏进度视图
        progressView.alpha=0;
        //停止转圈
        [actView stopAnimating];
        actView.hidesWhenStopped=YES;
    }];
}
//计算UIImageView宽度和高度等比例自适应UIImage高,图片视图居中位置
-(CGRect)computingCenter:(UIImage *)image
{
    CGFloat w=screenHeight*(image.size.width/image.size.height);
    CGFloat h=screenWidth*(image.size.height/image.size.width);
    //判断如果计算的宽度大于屏幕宽度就设置为屏幕宽
    if (w>screenWidth) {
        w=screenWidth;
    }
    //判断如果计算的高度大于屏幕高度就设置为屏幕高
    if (h>screenHeight) {
        h=screenHeight;
    }
    //计算UIImageView在屏幕中间的w坐标和y坐标
    CGFloat x=(screenWidth-w)/2;
    CGFloat y=(screenHeight-h)/2;
    //记录这个位置和大小
    CGRect rect=CGRectMake(x, y, w, h);
    return rect;
}
//单击图片
-(void)tapImage:(UITapGestureRecognizer *)tap
{
    //隐藏页数标签
    self.photoBrowser.pagesLabel.alpha=0;
    
    //取出当前滚动到的图片的缩略图在屏幕下的位置和大小
    NSValue *rectVale=self.photoBrowser.thumbnailsRectArr[selectedRow];
    CGRect rect=[rectVale CGRectValue];
    //判断这张图的缩略图是不是在屏幕范围里
    if (rect.origin.y<=screenHeight-49-rect.size.height && rect.origin.y>=64) {
            //缩小到原来位置大小在删除
            [UIView animateWithDuration:0.3 animations:^{
                //全部背景慢慢透明
                self.photoBrowser.view.backgroundColor=[UIColor clearColor];
                self.photoBrowser.imageCollectionView.backgroundColor=[UIColor clearColor];
                imageScrollView.backgroundColor=[UIColor clearColor];
                //直接内容区域还原原大小
                imageScrollView.contentSize=CGSizeMake(screenWidth, screenHeight);
                
                //当前滚到的图片视图慢慢回到缩略图时的位置和大小
                imageView.frame=rect;
                //延迟设置图片视图内容模式
                [self performSelector:@selector(setImageViewContentMode) withObject:nil afterDelay:0.1];
                imageView.clipsToBounds=YES;
            } completion:^(BOOL finished) {
                //删除视图(关闭图片浏览器)
                [self.photoBrowser closePhotoBrowser];
            }];
    }else{
            //图片视图慢慢放大消失
            [UIView animateWithDuration:0.3 animations:^{
                //全部背景慢慢透明
                self.photoBrowser.view.backgroundColor=[UIColor clearColor];
                self.photoBrowser.imageCollectionView.backgroundColor=[UIColor clearColor];
                imageScrollView.backgroundColor=[UIColor clearColor];
                
                //当前滚到的图片视图慢慢放大消失
                imageView.transform=CGAffineTransformScale(imageView.transform, 1.2, 1.2);
                imageView.alpha=0;
            } completion:^(BOOL finished) {
                //删除视图(关闭图片浏览器)
                [self.photoBrowser closePhotoBrowser];
                
            }];
    }
}
//缩小效果必须延迟设置图片视图内容模式
-(void)setImageViewContentMode
{
    //UIViewContentModeScaleAspectFit,UIViewContentModeScaleAspectFill
    imageView.contentMode=UIViewContentModeScaleAspectFill;
}
//双击图片
-(void)dblclickImage:(UITapGestureRecognizer *)tap
{
    //双击图片的位置
    CGPoint touchPoint = [tap locationInView:self];
    //判断装图片的滚动视图有没有被放大
    if (imageScrollView.zoomScale == 1) {
        //放大
        [imageScrollView zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    } else {
        //缩小
        [imageScrollView setZoomScale:imageScrollView.minimumZoomScale animated:YES];
    }
}
//计算图片x,y坐标.
- (void)centerScrollViewContents
{
    //屏幕大小
    CGSize boundsSize = [[UIScreen mainScreen] bounds].size;
    CGRect contentsFrame = imageView.frame;
    //计算x坐标
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        //当图片放大的宽大于屏幕宽,设置x坐标为0
        contentsFrame.origin.x = 0.0f;
    }
    //计算y坐标
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        //当图片放大的高大于屏幕高,设置y坐标为0
        contentsFrame.origin.y = 0.0f;
    }
    //重新设置图片视图位置
    imageView.frame = contentsFrame;
}
#pragma mark- UIScrollView代理
//正在缩放
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerScrollViewContents];
}
//尝试进行缩放的时候调用
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    //返回要缩放的图片视图
    return imageView;
}
//默认是长按0.5后调用第一次,手放开再调一次
- (void)longPress:(UILongPressGestureRecognizer *)press
{
    if(press.state==UIGestureRecognizerStateBegan){
        //触下0.5秒
        
        if (self.photoBrowser.liaotianChaKanImg==1) {
            
            ///发送
            [[NSNotificationCenter defaultCenter]postNotificationName:@"TongZhiliaotianChaKanImg" object:imageView.image];
            
        }else{
            
            UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到相册",nil];
            [action showInView:self];
            
        }
        
        
    }
}
#pragma mark- UIActionSheet代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        
        
        //判断没有权限访问相册
        if (![self isAlbumPermission]) {
            //获取app名字
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
            NSString *msg=[NSString stringWithFormat:@"请在(设置-隐私-相机)中允许%@访问你的相机",appName];
            
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"没有权限访问照片" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        //保存图片到相册
        UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

        
    }
    
}
//保存图片后回调方法判断是否保存成功
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        NSString *msg = nil ;
        if(error != NULL){
            msg = @"保存图片失败" ;
//            [YCHUD showHUDWithText:msg Type:ShowNo Enabled:YES];
        }else{
            msg = @"保存图片成功" ;
//            [YCHUD showHUDWithText:msg Type:ShowYes Enabled:YES];
        }
    });
}
//判断是否有权限访问相册
-(BOOL)isAlbumPermission
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
        //无权限
        return NO;
    }
    return YES;
}

@end



