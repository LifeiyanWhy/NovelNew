//
//  NOVFindModel.h
//  小说
//
//  Created by 李飞艳 on 2018/6/26.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//书的发起人
@interface NOVBookStartUser :JSONModel

@property(nonatomic,strong) NSString *username;

@property(nonatomic,strong) NSString *account;

@end

@interface NOVbookMessage : JSONModel

@property(nonatomic,assign) NSInteger bookId;

@property(nonatomic,strong) NSString *bookName;

@property(nonatomic,strong) NSString *content;

@property(nonatomic,strong) NOVBookStartUser *createUser;

//@property(nonatomic,assign) NSInteger writeNum;

@end

@interface NOVAllBookMesssage : JSONModel

@property(nonatomic,assign) NSInteger status;

@property(nonatomic,strong) NSArray<NOVbookMessage *>* data;

@end
