//
//  NOVUserLoginMessageModel.h
//  小说
//
//  Created by 李飞艳 on 2018/8/11.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOVUserLoginMessageModel : NSObject<NSCoding>
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,assign) BOOL isLogin;//记录用户是否登录状态
-(instancetype)initWithAccount:(NSString *)account password:(NSString *_Nullable)password isLogin:(BOOL)isLogin;
@end
