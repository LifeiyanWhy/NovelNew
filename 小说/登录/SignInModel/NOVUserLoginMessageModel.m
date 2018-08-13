//
//  NOVUserLoginMessageModel.m
//  小说
//
//  Created by 李飞艳 on 2018/8/11.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVUserLoginMessageModel.h"

@implementation NOVUserLoginMessageModel
-(instancetype)initWithAccount:(NSString *)account password:(NSString *_Nullable)password isLogin:(BOOL)isLogin{
    self = [super init];
    if (self) {
        self.account = account;
        self.password = password;
        self.isLogin = isLogin;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.account forKey:@"account"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeBool:self.isLogin forKey:@"isLogin"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.account = [aDecoder decodeObjectForKey:@"account"];
    self.password = [aDecoder decodeObjectForKey:@"password"];
    self.isLogin = [aDecoder decodeBoolForKey:@"isLogin"];
    return self;
}
@end
