//
//  NOVMystartModel.m
//  小说
//
//  Created by 李飞艳 on 2018/5/23.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVStartBookModel.h"
#import "NOVGetMyStartModel.h"

@implementation NOVStartBookModel
-(instancetype)initWithDraft:(NOVGetMyStartModel *)draftBookModel{
    self = [super init];
    if (self) {
        _bookId = draftBookModel.bookId;
        _name = draftBookModel.bookName;
        if ([draftBookModel.bookType isEqualToString:@"FantasySentiment"]) {
            _bookType = 0;
        } else if ([draftBookModel.bookType isEqualToString:@"ImmortalChivalry"]){
            _bookType = 1;
        } else if ([draftBookModel.bookType isEqualToString:@"AncientSentiment"]){
            _bookType = 2;
        } else if ([draftBookModel.bookType isEqualToString:@"ModernSentiment"]){
            _bookType = 3;
        } else if ([draftBookModel.bookType isEqualToString:@"RomanticYouth"]){
            _bookType = 4;
        } else if ([draftBookModel.bookType isEqualToString:@"SuspensePsychic"]){
            _bookType = 5;
        } else if ([draftBookModel.bookType isEqualToString:@"ScienceSpace"]){
            _bookType = 6;
        } else if ([draftBookModel.bookType isEqualToString:@"GameCompetition"]){
            _bookType = 7;
        } else if ([draftBookModel.bookType isEqualToString:@"TanbiNovel"]){
            _bookType = 8;
        }
        _introduction = draftBookModel.content;
    }
    return self;
}

-(void)obtainDraftContentWithBookId:(NSInteger)bookId succeed:(succeedBlock _Nullable)success  fail:(failureBlock _Nullable)fail{
    NSLog(@"%ld",(long)bookId);
    NSString *url = [NSString stringWithFormat:@"http://47.95.207.40/branch/book_edit/%ld",(long)bookId];
    NOVDataModel *datamodel = [NOVDataModel shareInstance];
    NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
    
//    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
//    __block NSNumber *chapterId;
//    dispatch_async(queue, ^{//获取章节ID
//        NSString *urlString = [NSString stringWithFormat:@"http://47.95.207.40/branch/book/%ld/branch?parentId=0",(long)bookId];
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"====%@",responseObject);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"draft");
//        }];
//    });
//    dispatch_async(queue, ^{//根据ID获取内容
//        NOVDataModel *datamodel = [NOVDataModel shareInstance];
//        NSString *token = [NSString stringWithFormat:@"Bearer %@",[datamodel getToken]];
//        NSString* urlString = [NSString stringWithFormat:@"http://47.95.207.40/branch/book/branch/%ld",[chapterId integerValue]];
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
//        [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            success(responseObject);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            fail(error);
//            NSLog(@"draft");
//        }];
//    });
}
@end
