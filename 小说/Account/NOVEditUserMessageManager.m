//
//  NOVEditUserMessageManager.m
//  小说
//
//  Created by 李飞艳 on 2018/8/14.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVEditUserMessageManager.h"

@implementation NOVEditUserMessageManager
//修改用户信息
+(void)changeUserSignText:(NSString *_Nonnull)signText success:(successBlock _Nullable )successBlock failure:(failBlock _Nullable )failBlock{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSString *url = @"http://47.95.207.40/branch/me";
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    [manger.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    NSDictionary *parameters = @{
                                 @"signText":signText
                                 };
    [manger POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}
+(void)uploadMyImageWithImage:(UIImage *_Nonnull)image success:(successBlock _Nullable )successBlock failure:(failBlock _Nullable )failBlock{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSString *url = @"http://47.95.207.40/branch/upload/avatar";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"multipart/form-data;boundary="] forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"myImage.jpg" mimeType:@"image/jpg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}
//获取用户信息
+(void)getUserMessageSuccess:(successBlock _Nullable )successBlock failure:(failBlock _Nullable )failBlock{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSString *url = @"http://47.95.207.40/branch/me";
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    [manger.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}
@end
