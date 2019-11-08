//
//  Request.h
//  康熙来了
//
//  Created by gdswww-ios8 on 15/6/29.
//  Copyright (c) 2015年 gdswww-ios8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^requestError)(NSError *error);
typedef void(^requestSuccessful)(NSDictionary *dic);
typedef void(^requestBody)(id<AFMultipartFormData>formData);

@interface Request : NSObject
{
    requestError block_requestError;
    requestSuccessful block_requestSuccessful;
    requestBody block_requestBody;
}
//NO1
void requestGET(NSString *requestUrl,NSDictionary *parameter,requestError errorBlock,requestSuccessful successfulBlock);
//NO2
void requestPost(NSString *requestUrl,NSDictionary *parameter,requestError errorBlock,requestSuccessful successfulBlock);
//NO3
//void requestPostBody(NSString *requestUrl,NSDictionary *parameter, requestBody bodyBlock,requestError errorBlock,requestSuccessful successfulBlock);
//NO4
void requestPostImage(NSString *requestUrl,NSDictionary *parameter,NSArray *photoArr,requestError errorBlock,requestSuccessful successfulBlock);

void showAlertHint (NSString * hint);

void saveImage(UIImage *image,NSString *file);

-(void)saveImage:(UIImage*)image File:(NSString*)file;

@end
















