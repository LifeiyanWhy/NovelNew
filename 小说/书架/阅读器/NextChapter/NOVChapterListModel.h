//
//  NOVChapterListModel.h
//  小说
//
//  Created by 李飞艳 on 2018/8/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "JSONModel.h"

@interface NOVChapterAuthorModel :JSONModel
@property(nonatomic,assign) NSInteger userId;
@property(nonatomic,copy) NSString *username;
@property(nonatomic,copy) NSString *account;
@end

@interface NOVChapterListModel : JSONModel
@property(nonatomic,assign) NSInteger branchId;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) NSString *createTime;
@property(nonatomic,copy) NSString *summary;
@property(nonatomic,assign) NSInteger likeNum;
@property(nonatomic,assign) NSInteger dislikeNum;
@property(nonatomic,strong) NOVChapterAuthorModel *author;
@end

@interface NOVAllChapterListModel : JSONModel
@property(nonatomic,assign) NSInteger status;
@property(nonatomic,copy) NSArray <NOVChapterListModel *>*data;
@end
