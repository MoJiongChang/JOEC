//
//  GlobalMethod.h
//  醉清风
//
//  Created by ltz on 14/12/3.
//  Copyright (c) 2014年 com.gdswww.www. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GlobalMethod : NSObject

@property (nonatomic, strong) NSMutableDictionary *cachDict;

GlobalMethod *globalMethod();

NSString *getLibraryPath();
void saveImageToLocation(NSString *filename,NSData *data);
UIImage *getImageFromLocation(NSString *filename);


void saveUserInfo(NSString *keyName,NSString *valueName);
NSString *  getUserInfo(NSString *keyName);

NSString *modeContent(id contentStr, NSString *tidaiStr);

id colorWithHexString  (NSString *color);

UIImage *fixOrientation(UIImage *aImage);

@end
