//
//  MJCMianWebViewController.m
//  JOEC
//
//  Created by Apple on 2019/11/4.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "MJCMianWebViewController.h"

#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
//#import "AppJSObject.h"
#import <EventKit/EventKit.h>


#import "MJCSaoYiSaoViewController.h"

@interface MJCMianWebViewController ()</*WKNavigationDelegate,UIScrollViewDelegate,WKUIDelegate,WKScriptMessageHandler,AppJSObjectDelegate,*/UIWebViewDelegate,MJCSaoYiSaoViewControllerDelegate>

@property (strong, nonatomic)  WKWebView *webView;
@property (strong, nonatomic) WKUserContentController *userContent;

@property (strong, nonatomic)  UIWebView *myWebView;

@end

@implementation MJCMianWebViewController

///改变某个控制器状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//UIStatusBarStyleDefault;//白
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = color(56, 62, 73);
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CurrentWidth, NavHeight)];
//    view.backgroundColor = color(56, 62, 73);
//    [self.view addSubview:view];
   
    //========
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    _myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, CurrentWidth, CurrentHeight)];
    _myWebView.delegate = self;
    //    self.weburl = [self.weburl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:@"http://w103.ratafee.nl/web/"];//self.weburl];
    NSURLRequest *resquest = [[NSURLRequest alloc]initWithURL:url];
    [_myWebView loadRequest:resquest];
    //        NSString* path = [[NSBundle mainBundle] pathForResource:@"javascript" ofType:@"html"];
    //        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]] ;
    //        [_myWebView loadRequest:request];
    _myWebView.opaque = NO;
    _myWebView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_myWebView];
    
  
}

-(void)erweimaSaoMiaoWith:(NSString *)idStr{
    NSLog(@"二维码信息delegate返回------%@", idStr);
   
    ///1
//    JSValue *Callback = self.context[@"setScanAddress"];
//    //传值给web端
//    [Callback callWithArguments:@[idStr]];
    
    ////2
    //    NSString *js_str = [NSString stringWithFormat:@"setScanAddress('%@')", @"6666"]; //准备执行的js代码
    //    [_myWebView stringByEvaluatingJavaScriptFromString:js_str];
    
    NSString*funtionString=[NSString stringWithFormat:@"javascript:setScanAddress('%@')",idStr];
    [self.context evaluateScript:funtionString];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    // 以 html title 设置 导航栏 title
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    // Undocumented access to UIWebView's JSContext
    
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 打印异常
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    // 以 JSExport 协议关联 native 的方法
    self.context[@"JsInterface"] = self;
    
    /*
    // 以 block 形式关联 JavaScript function
    self.context[@"log"] =
    ^(NSString *str)
    {
        NSLog(@"--mmmmmmmmm--%@", str);
    };
    

    //多参数
    self.context[@"mutiParams"] =
    ^(NSString *a,NSString *b,NSString *c)
    {
        NSLog(@"%@ %@ %@",a,b,c);
    };
    
    */
   
    
}

#pragma mark - JSExport Methods

- (void)handleFactorialCalculateWithNumber:(NSString *)number
{
    NSLog(@"%@", number);
    
    NSNumber *result = [self calculateFactorialOfNumber:@([number integerValue])];
    
    NSLog(@"%@", result);
    
    [self.context[@"showResult"] callWithArguments:@[result]];
}

- (void)goScan
{
    NSLog(@"goScan");
    
//    MJCSaoYiSaoViewController *mvc = [[MJCSaoYiSaoViewController alloc]init];
//    mvc.delegate = self;
//    [self.navigationController pushViewController:mvc animated:YES];
    
    
    ////返回主线程
    dispatch_async(dispatch_get_main_queue(), ^{


        MJCSaoYiSaoViewController *mvc = [[MJCSaoYiSaoViewController alloc]init];
        mvc.delegate = self;
        [self.navigationController pushViewController:mvc animated:YES];
        
        
    });
    
    
}

/*
-(NSString *)getToken
{
    NSLog(@"getToken");
    
    //传值给web端
    NSString *token = @"";
    //    JSValue *jsParamFunc = self.context[@"getToken"];
    //    [jsParamFunc callWithArguments:@[@{@"token": token}]];
    
    return [self toJSONData:@{@"token": token}];
    
}
*/


- (void)saveImg:(NSString *)ImgStr{
    
    NSLog(@"%@", ImgStr);
    
    [self ssavemage:ImgStr];
}



- (void)pushViewController:(NSString *)view title:(NSString *)title
{
    Class second = NSClassFromString(view);
    id secondVC = [[second alloc]init];
    ((UIViewController*)secondVC).title = title;
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark - Factorial Method

- (NSNumber *)calculateFactorialOfNumber:(NSNumber *)number
{
    NSInteger i = [number integerValue];
    if (i < 0)
    {
        return [NSNumber numberWithInteger:0];
    }
    if (i == 0)
    {
        return [NSNumber numberWithInteger:1];
    }
    
    NSInteger r = (i * [(NSNumber *)[self calculateFactorialOfNumber:[NSNumber numberWithInteger:(i - 1)]] integerValue]);
    
    return [NSNumber numberWithInteger:r];
}


#pragma mark toJSONData  ++++++++将字典或者数组转化为JSON串
-(NSString *)toJSONData:(id)theData{
    NSLog(@"%@",theData);
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}

////--接收Str
-(void)jumpCalendarSet:(NSString *)settimeStr{
    
    
}


//********************

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = YES;
    
}



-(void)back {
    
    
    /*
     判断webview是否是还能在页面间返回
     能返回执行self.webView goBack
     不能返回调用自己写的返回逻辑
     closeBtn是关闭，直接退出webview
     */
    if (self.myWebView.canGoBack) {
        [self.myWebView goBack];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -  Alert弹窗
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message ? : @"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark -  Confirm弹框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message ? : @"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }];
    
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark -  TextInput弹框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text ? : @"");
    }];
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 保存图片到相册
-(void)baocunImage{
 
    UIImage *image = nil;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
    
}
-(void) savedPhotoImage:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    if (error) {
        NSLog(@"失败");
        
        showAlertHint(@"图片保存失败");
    }
    else {
       NSLog(@"成功");
        showAlertHint(@"图片保存成功");
    }
    
}

-(void)ssavemage:(NSString *)base64String{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:@""]];
        NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
        UIImage *image = [[UIImage alloc]initWithData:data];
        
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                 
                    
                    
                    UIImageWriteToSavedPhotosAlbum(image, self, @selector(savedPhotoImage:didFinishSavingWithError:contextInfo:), nil);
                    
                    /////image
                }
                
            });
        }
    });
    
}

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(BOOL)webView:(UIWebView* )webView shouldStartLoadWithRequest:(NSURLRequest* )request navigationType:(UIWebViewNavigationType)navigationType
{
    //网页加载之前会调用此方法
    
    // 以 html title 设置 导航栏 title
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    // Undocumented access to UIWebView's JSContext
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 打印异常
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    // 以 JSExport 协议关联 native 的方法
    self.context[@"JsInterface"] = self;
    
    // 以 block 形式关联 JavaScript function
    self.context[@"log"] =
    ^(NSString *str)
    {
        NSLog(@"--mmmmmmmmm--%@", str);
    };
    
    // 以 block 形式关联 JavaScript function
    //    self.context[@"alert"] =
    //    ^(NSString *str)
    //    {
    //
    //        NSLog(@"--mmmmmmmmm2--%@", str);
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"msg from js" message:str delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    //        [alert show];
    //    };
    
    //    __block typeof(self) weakSelf = self;
    //    self.context[@"addSubView"] =
    //    ^(NSString *viewname)
    //    {
    //        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 500, 300, 100)];
    //        view.backgroundColor = [UIColor redColor];
    //        UISwitch *sw = [[UISwitch alloc]init];
    //        [view addSubview:sw];
    //        [weakSelf.view addSubview:view];
    //    };
    //多参数
    self.context[@"mutiParams"] =
    ^(NSString *a,NSString *b,NSString *c)
    {
        NSLog(@"%@ %@ %@",a,b,c);
    };
    
    //retrun YES 表示正常加载网页 返回NO 将停止网页加载
    return YES;
    
}

*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
