//
//  NSString+Valid.h
//  Money_message
//
//  Created by linzhang on 14-11-25.
//  Copyright (c) 2014年 linzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Valid)
/**
 *  判断是不是中文
 *
 *  @return 返回是或否
 */
-(BOOL)isChinese;

/**
 *  判断是不是邮箱格式
 *
 *  @return 返回是或否
 */

-(BOOL)isEmail;

/**
 *    手机号码验证
 */

-(BOOL) validateMobile;
@end
