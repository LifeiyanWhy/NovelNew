//
//  NOVObatinBookContent.h
//  小说
//
//  Created by 李飞艳 on 2018/6/27.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^succeedBlock)(id responseObject);
typedef void(^failBlock)(NSError* error);

@interface NOVObatinBookContent : NSObject
//获取章节内容
-(void)getChapterModelWithBranchId:(NSInteger)branchId succeed:(succeedBlock _Nullable)succeedBlock fail:(failBlock _Nullable)failBlock;
//关注一本书
-(void)followBookWithBookId:(NSInteger)bookId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock;
//取关
-(void)cancelFollowBookId:(NSInteger)bookId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock;
//获取首段ID
-(void)getBookFirstChapterIdWithBookID:(NSInteger)bookId succeed:(succeedBlock)succeedBlock fail:(failBlock)failBlock;
//根据段落ID获取本段续写列表
-(void)getRenewListWithBookId:(NSInteger)bookId ParentId:(NSInteger)parentId succeed:(succeedBlock _Nullable)succeedBlock fail:(failBlock _Nullable)failBlock;
+(void)collectionChapterWithBranchId:(NSInteger)branchId succeed:(succeedBlock _Nullable)succeedBlock fail:(failBlock _Nullable)failBlock;
+(void)cancelCollectionChapterWithBranchId:(NSInteger)branchId succeed:(succeedBlock _Nullable)succeedBlock fail:(failBlock _Nullable)failBlock;
//评论,喜欢或不喜欢
+(void)commentWithType:(NSInteger)typeNumber branchId:(NSInteger)branchId succeed:(succeedBlock _Nullable)succeedBlock fail:(failBlock _Nullable)failBlock;
@end
