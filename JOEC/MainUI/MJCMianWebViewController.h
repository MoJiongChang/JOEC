//
//  MJCMianWebViewController.h
//  JOEC
//
//  Created by Apple on 2019/11/4.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TestJSExport <JSExport>
JSExportAs
(calculateForJS  /** handleFactorialCalculateWithNumber 作为js方法的别名 */,
 - (void)handleFactorialCalculateWithNumber:(NSString *)number
 );


//-(NSString *)getToken;
- (void)saveImg:(NSString *)ImgStr;
- (void)goScan;

- (void)pushViewController:(NSString *)view title:(NSString *)title;
@end


@interface MJCMianWebViewController : UIViewController<UIWebViewDelegate,TestJSExport>

@property (nonatomic,strong)  NSString *weburl;

@property (strong, nonatomic) JSContext *context;

@end

NS_ASSUME_NONNULL_END
