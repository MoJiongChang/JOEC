//
//  common.h
//  LotusRoot
//
//  Created by ltz on 16/3/15.
//  Copyright © 2016年 gdshwhl007. All rights reserved.
//

#ifndef common_h
#define common_h

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

// 1.判断是否为ios7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)

///////6p/6sp
#define IS_iPhoneP ([UIScreen mainScreen].bounds.size.width == 540 && [UIScreen mainScreen].bounds.size.height == 960)

///////1、导航栏
#define TabbarHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?73:49) // 适配iPhone x 底栏高度 83:49
#define NavHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64) // 适配iPhone x
#define TopiPhoneMax     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?24:0) // 适配iPhone x 多24
#define BottomiPhoneMax     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?24:0) // 适配iPhone x 多34

// 2.RGB颜色
#define color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//主色调
#define mainColor [UIColor colorWithRed:246/255.0 green:172/255.0 blue:59/255.0 alpha:1.0]

//
#define HuangColor [UIColor colorWithRed:240/255.0 green:148/255.0 blue:64/255.0 alpha:1.0]

//横线色调
#define HXColor1 [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0]
#define HXColor2 [UIColor colorWithRed:237/255.0 green:238/255.0 blue:239/255.0 alpha:1.0]

#define labColor [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1.0]

#define TabarbgColor [UIColor colorWithRed:250/255.0 green:251/255.0 blue:251/255.0 alpha:1.0]
#define TabarSize 18


//当前屏幕的宽高
#define CurrentHeight ([UIScreen mainScreen].bounds.size.height)
#define CurrentWidth ([UIScreen mainScreen].bounds.size.width)
//#define KWIDTH [UIScreen mainScreen].bounds.size.width/375
/**宽度比例*/
#define KWIDTH(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375)*(__VA_ARGS__)
/**高度比例*/
#define KHEIGHT(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.height/667)*(__VA_ARGS__)
/**字体比例*/
//#define k_ScaleFont(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375)*(__VA_ARGS__)

#define baSize 8//*[UIScreen mainScreen].bounds.size.width/320
#define jiuSize 9//*[UIScreen mainScreen].bounds.size.width/320
#define shiSize 10//*[UIScreen mainScreen].bounds.size.width/320
#define shiyiSize 11//*[UIScreen mainScreen].bounds.size.width/320
#define shierSize 12//*[UIScreen mainScreen].bounds.size.width/320
#define shisanSize 13//*[UIScreen mainScreen].bounds.size.width/320
#define shisiSize 14//*[UIScreen mainScreen].bounds.size.width/320
#define shiwuSize 15//*[UIScreen mainScreen].bounds.size.width/320
#define shiliuSize 16//*[UIScreen mainScreen].bounds.size.width/320
#define shibaSize 18//*[UIScreen mainScreen].bounds.size.width/320

//文本size
#define BouingSize(str,with,size)   [str boundingRectWithSize:CGSizeMake(with, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil]

//文本size
#define AutoHeightSize(str,with,zsize)   [str boundingRectWithSize:CGSizeMake(with, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:zsize]} context:nil].size.height

#define AutoWidthSize(str,zsize)   [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:zsize]} context:nil].size.width

#define userInfoFile(filePath) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:filePath]
//#接口前缀http://aj.gdswww.com/index.php/Home/Index/log_consume

#define API_GET(_URL_) [NSURL URLWithString:[@"http://112.74.193.191:8010/Help/" stringByAppendingString:_URL_]]

#define API_POST(_URL_) [NSString stringWithFormat:@"http://api.hqjnet.com/ordering/index.php/%@",_URL_]

#define API_ZhiFuBaoPay @"http://apiphp.gdswlw.com/paomanage/manage.php/Notify/ZFBpay"

#define API_PowerGrid @"http://st.gdswww.com:88/index.php/"

#define API_image(_URL_) [NSString stringWithFormat:@"http://api.hqjnet.com/ordering/index.php/api/%@",_URL_]

#define areaDic [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]]

//YUNXIN
#define UICommonTableBkgColor UIColorFromRGB(0xe4e7ec)
#define Message_Font_Size   14        // 普通聊天文字大小
#define Notification_Font_Size   10   // 通知文字大小
#define Chatroom_Message_Font_Size 16 // 聊天室聊天文字大小
#pragma mark - UIColor宏定义
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0)

#define dispatch_sync_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define NTES_USE_CLEAR_BAR - (BOOL)useClearBar{return YES;}

#define NTES_FORBID_INTERACTIVE_POP - (BOOL)forbidInteractivePop{return YES;}

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif /* common_h */
