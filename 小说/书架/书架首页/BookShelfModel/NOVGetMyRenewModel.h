//
//  NOVGetMyRenewModel.h
//  小说
//
//  Created by 李飞艳 on 2018/8/16.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "JSONModel.h"

@interface NOVAuthorModel :JSONModel
@property(nonatomic,copy) NSString *username;
@property(nonatomic,copy) NSString *account;
@end

@interface NOVSimpleBookModel : JSONModel
@property(nonatomic,assign) NSInteger bookId;
@property(nonatomic,copy) NSString *bookName;
@property(nonatomic,copy) NSString *bookType;
@property(nonatomic,copy) NSString *bookImage;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,assign) NSInteger joinUsers;
@property(nonatomic,strong) NOVAuthorModel *author;
@end

@interface NOVMyBranchModel : JSONModel
@property(nonatomic,assign) NSInteger branchId;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *summary;
@property(nonatomic,assign) NSInteger likeNum;
@property(nonatomic,assign) NSInteger dislikeNum;
@end

@interface NOVGetMyRenewModel : JSONModel
@property(nonatomic,strong) NOVSimpleBookModel *simpleBookDTO;
@property(nonatomic,strong) NSArray <NOVMyBranchModel *>*myWriteBranchDTOS;
@end
