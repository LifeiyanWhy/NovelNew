//
//  NOVObtainBookShelfManager.h
//  小说
//
//  Created by 李飞艳 on 2018/8/15.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id  _Nullable responseObject);
typedef void(^failBlock)(NSError * _Nonnull error);

@interface NOVObtainBookShelfManager : NSObject
//获取关注列表
-(void)obtainFollowBookListSucceed:(successBlock _Nullable )succeedBlock failure:(failBlock _Nullable)failBlock;
//获取我的参与列表
-(void)obtainMyRenewSucceed:(successBlock _Nullable )succeedBlock failure:(failBlock _Nullable)failBlock;
//获取我的收藏
-(void)obtainMyCollectionSucceed:(successBlock _Nullable )succeedBlock failure:(failBlock _Nullable)failBlock;
@end
