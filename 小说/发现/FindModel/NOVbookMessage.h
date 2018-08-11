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
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *username;
@end

@interface NOVbookMessage : JSONModel
@property(nonatomic,strong) NOVBookStartUser *author;
@property(nonatomic,assign) NSInteger bookId;
//@property(nonatomic,strong) UIImage *bookImage;
@property(nonatomic,copy) NSString *bookName;
@property(nonatomic,assign) NSInteger bookType;
@property(nonatomic,assign) NSInteger branchNum;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,assign) NSInteger readNum;
@end

@interface NOVAllBookMesssage : JSONModel
@property(nonatomic,copy) NSArray <NOVbookMessage *>*list;
@end

@interface NOVbookData :JSONModel
@property(nonatomic,assign) NSInteger status;
@property(nonatomic,copy) NSDictionary *data;
@end
