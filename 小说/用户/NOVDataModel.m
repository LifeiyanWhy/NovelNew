//
//  NOVDataModel.m
//  小说
//
//  Created by 李飞艳 on 2018/6/9.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVDataModel.h"
#import "NOVUserLoginMessageModel.h"
@implementation NOVDataModel

static NOVDataModel *datamodel = nil;
+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        datamodel = [super allocWithZone:zone];
    });
    return datamodel;
}

+(NOVDataModel *)shareInstance{
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        datamodel = [[NOVDataModel alloc] init];
    });
    return datamodel;
}

+(void)updateCurrentUserWithLoginMessage:(NOVUserLoginMessageModel *)userMessage{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userMessage.account forKey:@"account"];
    [userDefaults setObject:userMessage.password forKey:@"password"];
    [userDefaults setBool:userMessage.isLogin forKey:@"isLogin"];
    [userDefaults synchronize];
}

+(NOVUserLoginMessageModel *_Nullable)getLastUserMessage{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefault objectForKey:@"account"];
    if (!account) {
        return NULL;
    }
    NSString *password = [userDefault objectForKey:@"password"];
    BOOL isLogin = [userDefault boolForKey:@"isLogin"];
    return [[NOVUserLoginMessageModel alloc] initWithAccount:account password:password isLogin:isLogin];
}

+(NSString *)getUserAccount{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefault objectForKey:@"account"];
    return account;
}

-(void)updateToken:(NSString *)token refreshToken:(NSString *)refreshToken{
    //获取到沙盒路径
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取document的路径
    NSString *documentPath = [array objectAtIndex:0];
    //生成存储token的文件
    NSString *tokenPath = [documentPath stringByAppendingPathComponent:@"token.txt"];
    NSArray *dataArray = [NSArray arrayWithObjects:token,refreshToken,nil];
    //把token写入文件
    [dataArray writeToFile:tokenPath atomically:YES];
}

//从本地获取
-(NSString *)getToken{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [array objectAtIndex:0];
    NSString *tokenPath = [documentPath stringByAppendingPathComponent:@"token.txt"];
    NSArray *dataArray = [[NSArray alloc] initWithContentsOfFile:tokenPath];
    return dataArray[0];
}

-(NSString *)getRefreshToken{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [array objectAtIndex:0];
    NSString *tokenPath = [documentPath stringByAppendingPathComponent:@"token.txt"];
    NSArray *dataArray = [[NSArray alloc] initWithContentsOfFile:tokenPath];
//    if (dataArray.count < 2) {
//        return nil;
//    }
    return dataArray[1];
}

+(void)updateUserMessage:(NOVUserMessage *)userMessage{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = array[0];
    NSString *userMessagePath = [documentPath stringByAppendingPathComponent:@"userMessage.txt"];
    NSArray *dataArray = @[[NSKeyedArchiver archivedDataWithRootObject:userMessage]];
    [dataArray writeToFile:userMessagePath atomically:YES];
}

+(NOVUserMessage *)getUserMessage{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = array[0];
    NSString *userMessagePath = [documentPath stringByAppendingPathComponent:@"userMessage.txt"];
    NSArray *dataArray = [[NSArray alloc] initWithContentsOfFile:userMessagePath];
    return [NSKeyedUnarchiver unarchiveObjectWithData:dataArray[0]];
}

-(void)updateFollowBookListWithArray:(NSMutableArray *)followBookList{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [array objectAtIndex:0];
    NSString *followbooklist = [libraryPath stringByAppendingPathComponent:@"followBookList.txt"];
    [followBookList writeToFile:followbooklist atomically:YES];
}

-(NSArray *)getFollowBookList{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [array objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"followBookList.txt"];
    NSArray *dataArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    return dataArray;
}

+(void)updateCollectionListWithArray:(NSMutableArray *)collectionList{
    NSLog(@"collection%lu",(unsigned long)collectionList.count);
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [array objectAtIndex:0];
    NSString *collectionPath = [libraryPath stringByAppendingPathComponent:@"collectionList.txt"];
    [collectionList writeToFile:collectionPath atomically:YES];
}

+(NSArray *)getCollectionList{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [array objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"collectionList.txt"];
    NSArray *dataArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    NSLog(@"collection%lu",(unsigned long)dataArray.count);
    return dataArray;
}

@end
