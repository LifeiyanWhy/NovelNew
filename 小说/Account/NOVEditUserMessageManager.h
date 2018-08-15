//
//  NOVEditUserMessageManager.h
//  小说
//
//  Created by 李飞艳 on 2018/8/14.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^successBlock)(id  _Nullable responseObject);
typedef void(^failBlock)(NSError * _Nonnull error);
@interface NOVEditUserMessageManager : NSObject
//修改签名
+(void)changeUserSignText:(NSString *_Nonnull)signText success:(successBlock _Nullable )successBlock failure:(failBlock _Nullable )failBlock;
//上传头像
+(void)uploadMyImageWithImage:(UIImage *_Nonnull)image success:(successBlock _Nullable )successBlock failure:(failBlock _Nullable )failBlock;
//获取用户信息
+(void)getUserMessageSuccess:(successBlock _Nullable )successBlock failure:(failBlock _Nullable )failBlock;
@end
