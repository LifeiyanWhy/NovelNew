//
//  NOVSignModel.h
//  小说
//
//  Created by 李飞艳 on 2018/5/27.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^successBlock)(id  _Nullable responseObject);
typedef void(^failBlock)(NSError * _Nonnull error);
@interface NOVSignModel : NSObject
//账号密码登录
-(void)loginWithAccount:(NSString *_Nonnull)account password:(NSString *_Nonnull)password verity:(NSString *)verity success:(successBlock _Nullable )successBlock failure:(failBlock _Nullable )failBlock;
+(void)updateToken;
+(void)token;
//账号密码注册
+(void)signUpWithAccount:(NSString *_Nonnull)account username:(NSString *_Nonnull)username passward:(NSString *_Nullable)password key:(NSString *)key success:(successBlock _Nullable )successBlock failure:(failBlock _Nullable )failBlock;
//获取图形验证码
-(void)getImageVeritysuccess:(successBlock _Nullable )successBlock failure:(failBlock _Nullable )failBlock;
//获取短信验证码
-(void)getPhoneVerityWithPhoneNum:(NSString *_Nonnull)phoneNum success:(successBlock _Nullable )successBlock failure:(failBlock _Nullable )failBlock;
//验证验证码
+(void)validateVerityWithPhoneNumber:(NSString *_Nonnull)phoneNumber validateCode:(NSString *_Nonnull)validateCode success:(successBlock _Nullable )successBlock failure:(failBlock _Nullable )failBlock;
//获取关注列表
+(void)obtainFollowList;
+(void)obtainCollectionList;
@end
