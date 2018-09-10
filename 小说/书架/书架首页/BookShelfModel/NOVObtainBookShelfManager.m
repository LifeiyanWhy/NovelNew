//
//  NOVObtainBookShelfManager.m
//  小说
//
//  Created by 李飞艳 on 2018/8/15.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVObtainBookShelfManager.h"

@implementation NOVObtainBookShelfManager
-(void)obtainFollowBookListSucceed:(successBlock)succeedBlock failure:(failBlock)failBlock{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSString *url = @"http://47.95.207.40/branch/user/focusOn/book";
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    [manger.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009) {
            NSLog(@"1009");
        }else{
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"follow%@",dict);
            failBlock(error);
        }
    }];
}
-(void)obtainMyRenewSucceed:(successBlock _Nullable )succeedBlock failure:(failBlock _Nullable)failBlock{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSString *url = [NSString stringWithFormat:@"http://47.95.207.40/branch/user/branch?status=%@",@"STATUS_ONLINE"];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    [manger.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
//        NSLog(@"renew%@",dict);
        failBlock(error);
    }];
}

-(void)obtainMyCollectionSucceed:(successBlock _Nullable )succeedBlock failure:(failBlock _Nullable)failBlock{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSString *url = @"http://47.95.207.40/branch/user/collection";
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    [manger.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manger GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"collection%@",dict);
        failBlock(error);
    }];
}
@end
