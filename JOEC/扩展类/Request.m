//
//  Request.m
//  康熙来了
//
//  Created by gdswww-ios8 on 15/6/29.
//  Copyright (c) 2015年 gdswww-ios8. All rights reserved.
//

#import "Request.h"

@implementation Request

requestError block_requestError;
requestSuccessful block_requestSuccessful;
requestBody block_requestBody;

//NO1  get
void requestGET(NSString *requestUrl,NSDictionary *parameter,requestError errorBlock,requestSuccessful successfulBlock)
{
    Request *r = [Request new];
    
    if (r->block_requestError != errorBlock)
    {
        r->block_requestError = errorBlock;
    }
    if (r->block_requestSuccessful != successfulBlock)
    {
        r->block_requestSuccessful = successfulBlock;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:API_POST(requestUrl) parameters:parameter progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        r->block_requestSuccessful(responseObject);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
         r->block_requestError(error);
    }];
    
//    AFHTTPRequestOperationManager *om = [[AFHTTPRequestOperationManager alloc] init];
//    AFHTTPRequestOperation *oper = [om GET:API_POST(requestUrl) parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//       // NSLog(@"%@",dict);
//        r->block_requestSuccessful(dict);
////        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
////        r->block_requestSuccessful(str);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        r->block_requestError(error);
//    }];
//
//    oper.responseSerializer = [AFCompoundResponseSerializer serializer];
//    
//    [oper start];
}

//NO2  post
void requestPost(NSString *requestUrl,NSDictionary *parameter,requestError errorBlock,requestSuccessful successfulBlock)
{
    Request *request = [[Request alloc] init];
    if (request->block_requestError != errorBlock) {
        request->block_requestError = errorBlock;
    }
    if (request->block_requestSuccessful != successfulBlock) {
        request->block_requestSuccessful = successfulBlock;
    }
    
    NSLog(@"接口--mmm--- %@",API_POST(requestUrl));
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:API_POST(requestUrl) parameters:parameter progress:nil success:^(NSURLSessionTask *task, id responseObject) { //
        
        
        
        if (getUserInfo(@"token")&&[responseObject[@"code"] intValue]==2) {
            NSLog(@"responseObject--ttttttt--- %@",responseObject);
            //登录失效发送通知
            [[NSNotificationCenter defaultCenter]postNotificationName:@"YongHuDengLuShiXiaoNoti" object:responseObject];
            
            saveUserInfo(@"token", nil);
        }

        
//        NSLog(@"responseObject %@",responseObject);
        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        request->block_requestSuccessful(responseObject);
        //         NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //        request->block_requestSuccessful(str);

        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"error %@",error);
        request->block_requestError(error);
    }];
  
    
    //    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    AFHTTPRequestOperation *oper = [manager POST:API_POST(requestUrl) parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        request->block_requestSuccessful(dic);
//        
////         NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
////        request->block_requestSuccessful(str);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        request->block_requestError(error);
//        
//    }];
//    oper.responseSerializer = [AFCompoundResponseSerializer serializer];
//    [oper start];
}

////NO3
//void requestPostBody(NSString *requestUrl,NSDictionary *parameter, requestBody bodyBlock,requestError errorBlock,requestSuccessful successfulBlock)
//{
//    Request *r = [Request new];
//    
//    if (r->block_requestError != errorBlock)
//    {
//        r->block_requestError = errorBlock;
//    }
//    if (r->block_requestSuccessful != successfulBlock)
//    {
//        r->block_requestSuccessful = successfulBlock;
//    }
//    
//    r->block_requestBody = bodyBlock;
//    
//    AFHTTPRequestOperationManager *om = [[AFHTTPRequestOperationManager alloc] init];
//    AFHTTPRequestOperation *oper = [om POST:API_POST(requestUrl) parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        r->block_requestBody(formData);
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        r->block_requestSuccessful(dict);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        r->block_requestError(error);
//    }];
//    oper.responseSerializer = [AFCompoundResponseSerializer serializer];
//    [oper start];
//}

//NO4 上传图片
void requestPostImage(NSString *requestUrl,NSDictionary *parameter,NSArray *photoArr,requestError errorBlock,requestSuccessful successfulBlock){
    Request *request = [[Request alloc] init];
    if (request->block_requestError != errorBlock) {
        request->block_requestError = errorBlock;
    }
    if (request->block_requestSuccessful != successfulBlock) {
        request->block_requestSuccessful = successfulBlock;
    }
    //__unsafe_unretained __block Request *weakself = self;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:requestUrl parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSMutableArray *keyArr = [NSMutableArray array];
        for (int i = 0; i < photoArr.count; i++) {
            [keyArr addObject:[NSString stringWithFormat:@"img%d",i]];
            NSString* file_str = [NSString stringWithFormat:@"file%d.png",i];
            saveImage(photoArr[i], file_str);
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:userInfoFile(file_str)] name:keyArr[i] error:nil]; //keyArr[i]
        }
    } progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"= = = responseObject %@",responseObject);
//        NSArray *tempDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        // block_requestSuccessful(tempDic);
//         NSLog(@"= = = responseObject %@ %@",responseObject,tempDic);
        successfulBlock(responseObject);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"error %@",error);
        
//       block_requestError(error);
    }];
}

#pragma mark
void saveImage(UIImage *image,NSString *file){
    NSData *sizeData = UIImageJPEGRepresentation(image, 1.0);
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    if (sizeData.length > 80000) {
        
        data = UIImageJPEGRepresentation(image, 0.0001);
    }
    // NSData *data = UIImagePNGRepresentation(image);
    BOOL isSuccess =  [data writeToFile:userInfoFile(file) atomically:YES];
    NSLog(@"保存到 沙盒 ---%d----",isSuccess);
}

-(void)saveImage:(UIImage*)image File:(NSString*)file
{
    
    NSData *sizeData = UIImageJPEGRepresentation(image, 1.0);
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    if (sizeData.length > 80000) {
        
        data = UIImageJPEGRepresentation(image, 0.0001);
    }
    // NSData *data = UIImagePNGRepresentation(image);
    BOOL isSuccess =  [data writeToFile:userInfoFile(file) atomically:YES];
    NSLog(@"---%d----",isSuccess);
}


void showAlertHint (NSString * hint)
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_5?200.f:150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}




@end


















