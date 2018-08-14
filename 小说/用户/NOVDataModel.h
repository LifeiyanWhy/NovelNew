//
//  NOVDataModel.h
//  小说
//
//  Created by 李飞艳 on 2018/6/9.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NOVUserMessage;
@class NOVUserLoginMessageModel;
@interface NOVDataModel : NSObject

+(NOVDataModel *)shareInstance;
+(void)updateCurrentUserWithLoginMessage:(NOVUserLoginMessageModel *)userMessage;
//获取最近一次登录的用户
+(NOVUserLoginMessageModel *_Nullable)getLastUserMessage;
//获取用户账号
+(NSString *)getUserAccount;
//获取token
-(NSString *)getToken;
//获取refreshToken
-(NSString *)getRefreshToken;
//更新token
-(void)updateToken:(NSString *)token refreshToken:(NSString *)refreshToken;
//获取关注列表
-(NSArray *)getFollowBookList;
-(void)updateFollowBookListWithArray:(NSMutableArray *)followBookList;
//更新用户信息
+(void)updateUserMessage:(NOVUserMessage *)userMessage;
//获取用户信息
+(NOVUserMessage *)getUserMessage;
//当用户退出登录时删除用户信息，若用户记住密码不删除账号密码信息
//+(void)deleteLastUserLoginMessage;
@end
