//
//  NOVMyCollectionModel.h
//  小说
//
//  Created by 李飞艳 on 2018/8/19.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "JSONModel.h"

@interface NOVMyCollectionAuthor :JSONModel
@property(nonatomic,copy) NSString *username;
@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *icon;
@end

@interface NOVMyCollectionModel : JSONModel
@property(nonatomic,assign) NSInteger branchId;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *summary;
@property(nonatomic,assign) NSInteger likeNum;
@property(nonatomic,assign) NSInteger dislikeNum;
@property(nonatomic,strong) NOVMyCollectionAuthor *author;
@end
