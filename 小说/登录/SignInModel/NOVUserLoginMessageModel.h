//
//  NOVUserLoginMessageModel.h
//  小说
//
//  Created by 李飞艳 on 2018/8/11.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NOVUserLoginMessageModel : NSObject
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *refreshToken;
@property(nonatomic,assign) BOOL isPassword;//记录用户是否记住密码
@property(nonatomic,assign) BOOL isLogin;//记录用户是否登录状态
@end
