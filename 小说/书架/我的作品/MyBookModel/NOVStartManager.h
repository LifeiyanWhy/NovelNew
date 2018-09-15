//
//  NOVStartManager.h
//  小说
//
//  Created by 李飞艳 on 2018/6/5.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NOVStartBookModel;
@class NOVRenewModel;

typedef void(^successBlock)(id _Nonnull responseObject);
typedef void(^failBlock)(NSError *_Nonnull error);

@interface NOVStartManager : NSObject
//获取我的发起
-(void)getMyStartSuccess:(successBlock _Nullable)successBlock fail:(failBlock _Nullable)failBlock;
//发起一本小说
-(void)startNovelWithModel:(NOVStartBookModel *_Nonnull)model isPublish:(Boolean)isPublish success:(successBlock _Nullable)successBlock fail:(failBlock _Nonnull)failBlock;
//发布续写
-(void)publishRenewWithRenewModel:(NOVRenewModel *_Nonnull)renewModel success:(successBlock _Nullable)successBlock fail:(failBlock _Nonnull)failBlock;
//上传书的封面
-(void)uploadBookImage:(UIImage *_Nonnull)image bookId:(NSInteger)bookId success:(successBlock _Nullable)successBlock fail:(failBlock _Nullable)failBlock;
@end
