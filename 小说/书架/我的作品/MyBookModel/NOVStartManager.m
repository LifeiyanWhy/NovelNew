//
//  NOVStartManager.m
//  小说
//
//  Created by 李飞艳 on 2018/6/5.
//  Copyright © 2018年 李飞艳. All rights reserved.
//
//发布一个作品
#import "NOVStartManager.h"
#import "NOVStartBookModel.h"
#import "NOVRenewModel.h"

@implementation NOVStartManager
-(void)getMyStartSuccess:(successBlock _Nullable)successBlock fail:(failBlock _Nullable)failBlock{
    NOVDataModel *dataModel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[dataModel getToken]];
    NSString *url = @"http://47.95.207.40/branch/user/book";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}

-(void)startNovelWithModel:(NOVStartBookModel *)model success:(successBlock)successBlock fail:(failBlock)failBlock{
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

-(void)uploadBookImage:(UIImage *_Nonnull)image bookId:(NSInteger)bookId success:(successBlock _Nullable)successBlock fail:(failBlock _Nullable)failBlock{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    NSString *url = [NSString stringWithFormat:@"http://47.95.207.40/branch/book/upload/book_image/%ld",(long)bookId];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"bookimage.jpg" mimeType:@"image/jpg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
    renewModel.summary = @"父亲魏长泽，母亲藏色散人。长相俊美，性格不羁，三观极正，爱憎分明，重情义。幼年父母在夜猎中丧生，被江澄之父江枫眠带回云梦江氏莲花坞，与江澄、江厌离一同生活修习。";
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
