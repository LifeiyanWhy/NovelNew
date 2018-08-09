//
//  NOVStartManager.m
//  小说
//
//  Created by 李飞艳 on 2018/6/5.
//  Copyright © 2018年 李飞艳. All rights reserved.
//
//发布一个作品
#import "NOVStartManager.h"
#import "NOVMystartModel.h"
#import "AFNetworking.h"
#import "NOVDataModel.h"
#import "NOVRenewModel.h"

@implementation NOVStartManager

-(void)startNovelWithModel:(NOVMystartModel *)model success:(successBlock)successBlock fail:(failBlock)failBlock{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSString *url = @"http://47.95.207.40/branch/book";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    model.firstSummary = @"摘要";
    NSDictionary *parameters = @{@"bookName":model.name,
                                 @"bookType":[NSNumber numberWithInteger:model.bookType],
                                 @"bookIntroduce":model.introduction,
                                 @"bookImage":@"",
                                 @"firstTitle":model.firstTitle,
                                 @"firstContent":model.firstContent,
                                 @"firstSummary":model.firstSummary,
//                                 @"readType":[NSNumber numberWithInteger:model.viewerType],
//                                 @"writeType":[NSNumber numberWithInteger:model.renewPeople],
                                 };
    [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}

-(void)publishRenewWithRenewModel:(NOVRenewModel *)renewModel success:(successBlock)successBlock fail:(failBlock)failBlock{
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSString *url = @"http://47.95.207.40/branch/branch";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    renewModel.summary = @"摘要";
    NSDictionary *parameters = @{
                                 @"parentId":[NSNumber numberWithInteger:renewModel.parentId],
                                 @"bookId":[NSNumber numberWithInteger:renewModel.bookId],
                                 @"title":renewModel.title,
                                 @"content":renewModel.content,
                                 @"summary":renewModel.summary,
                                 };
    [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}

@end
