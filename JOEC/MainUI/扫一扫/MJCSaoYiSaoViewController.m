//
//  MJCSaoYiSaoViewController.m
//  ZhuBaoApp
//
//  Created by mojiongchangMac on 2018/3/27.
//  Copyright © 2018年 HQJ. All rights reserved.
//

#import "MJCSaoYiSaoViewController.h"

#import "SGQRCode.h"


@interface MJCSaoYiSaoViewController ()<SGQRCodeScanManagerDelegate, SGQRCodeAlbumManagerDelegate>

{
    UIView *tbg;
}
@property (nonatomic, strong) SGQRCodeScanningView *scanningView;
@property (nonatomic, strong) UIButton *flashlightBtn;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;
@property (nonatomic, strong) UIView *qrView;

@end

@implementation MJCSaoYiSaoViewController
- (SGQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [SGQRCodeScanningView scanningViewWithFrame:self.view.bounds layer:self.view.layer];
//        _scanningView = [SGQRCodeScanningView scanningViewWithFrame:CGRectMake(0, NavHeight, CurrentWidth, CurrentHeight-NavHeight) layer:self.view.layer];
    }
    return _scanningView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scanningView];
    
    [tbg removeFromSuperview];
    [self setTitleBarWitntitle];
    
}

-(void)rightmengbutClick{
    
    [self rightStringBtnClick];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setupQRCodeScanning];
    
    self.navigationController.navigationBarHidden = YES;
    
    [tbg removeFromSuperview];
    [self setTitleBarWitntitle];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
    [self removeFlashlightBtn];
}

- (void)dealloc {
    NSLog(@"SGQRCodeScanningVC - dealloc");
    [self removeScanningView];
}


- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

-(void) rightStringBtnClick{
    
    SGQRCodeAlbumManager *manager = [SGQRCodeAlbumManager sharedManager];
    [manager SG_readQRCodeFromAlbumWithCurrentController:self];
    manager.delegate = self;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 栅栏函数
    dispatch_barrier_async(queue, ^{
        BOOL isPHAuthorization = manager.isPHAuthorization;
        if (isPHAuthorization == YES) {
            [self removeScanningView];
        }
    });
}

- (void)setupQRCodeScanning {
    SGQRCodeScanManager *manager = [SGQRCodeScanManager sharedManager];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [manager SG_setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    manager.delegate = self;
}

#pragma mark - - - SGQRCodeAlbumManagerDelegate
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(SGQRCodeAlbumManager *)albumManager {
    [self.view addSubview:self.scanningView];
}
- (void)QRCodeAlbumManager:(SGQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    
    NSLog(@"result - - %@", result);
    if (result != nil && result.length > 0) {
       
        NSLog(@"二维码信息------%@", result);
        
        [self.delegate erweimaSaoMiaoWith:result];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}

#pragma mark - - - SGQRCodeScanManagerDelegate
- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [scanManager SG_palySoundName:@"SGQRCode.bundle/sound.caf"];
        [scanManager SG_stopRunning];
        
//        [scanManager SG_videoPreviewLayerRemoveFromSuperlayer];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        NSLog(@"二维码信息------%@", [obj stringValue]);
        
        [self.delegate erweimaSaoMiaoWith:[obj stringValue]];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } else {
        NSLog(@"暂未识别出扫描的二维码");
    }
}


- (void)QRCodeScanManager:(SGQRCodeScanManager *)scanManager brightnessValue:(CGFloat)brightnessValue {
    if (brightnessValue < - 1) {
        [self.view addSubview:self.flashlightBtn];
    } else {
        if (self.isSelectedFlashlightBtn == NO) {
            [self removeFlashlightBtn];
        }
    }
}

- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
        // 添加闪光灯按钮
        _flashlightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat flashlightBtnW = 30;
        CGFloat flashlightBtnH = 30;
        CGFloat flashlightBtnX = 0.5 * (self.view.frame.size.width - flashlightBtnW);
        CGFloat flashlightBtnY = 0.55 * self.view.frame.size.height;
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
//        _flashlightBtn.backgroundColor = [UIColor redColor];
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightOpenImage"] forState:(UIControlStateNormal)];
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightCloseImage"] forState:(UIControlStateSelected)];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtn_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlightBtn;
}

- (void)flashlightBtn_action:(UIButton *)button {
    if (button.selected == NO) {
        [SGQRCodeHelperTool SG_openFlashlight];
        self.isSelectedFlashlightBtn = YES;
        button.selected = YES;
    } else {
        [self removeFlashlightBtn];
    }
}

- (void)removeFlashlightBtn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SGQRCodeHelperTool SG_CloseFlashlight];
        self.isSelectedFlashlightBtn = NO;
        self.flashlightBtn.selected = NO;
        [self.flashlightBtn removeFromSuperview];
    });
}



-(void)setTitleBarWitntitle{
    
    tbg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CurrentWidth, 44+20+TopiPhoneMax)];
    tbg.backgroundColor = color(56, 62, 73);
    [self.view addSubview:tbg];
    
    UIButton *backbut = [UIButton buttonWithType:UIButtonTypeCustom];
    backbut.frame = CGRectMake(10, tbg.height-44, 100, 44);
    [backbut addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backbut setImage:[UIImage imageNamed:@"mjcsy-more@2x"] forState:UIControlStateNormal];
    [backbut setImage:[UIImage imageNamed:@"mjcsy-more@2x"] forState:UIControlStateHighlighted];
    backbut.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 70);
    [tbg addSubview:backbut];
    
    UIButton *rightBut = [[UIButton alloc]initWithFrame:CGRectMake(CurrentWidth-120-15, tbg.height-44, 120, 44)];
    [rightBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBut.titleLabel.font = [UIFont systemFontOfSize:13];
    rightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBut setTitle:@"相册" forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(rightmengbutClick) forControlEvents:UIControlEventTouchUpInside];
    [tbg addSubview:rightBut];
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(CurrentWidth/2-100, tbg.height-44, 200, 44)];
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.text = @"扫一扫";
    titlelab.textColor = [UIColor whiteColor];
    titlelab.font = [UIFont systemFontOfSize:shibaSize];
    [tbg addSubview:titlelab];
    
}


- (void)backButtonClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
