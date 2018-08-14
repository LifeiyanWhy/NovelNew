//
//  NOVGetMyStartModel.h
//  小说
//
//  Created by 李飞艳 on 2018/8/14.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "JSONModel.h"

@interface NOVGetMyStartModel : JSONModel
@property(nonatomic,assign) NSInteger bookId;
@property(nonatomic,copy) NSString *bookName;
@property(nonatomic,copy) NSString *bookType;
//@property(nonatomic,strong) UIImage *bookImage;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,assign) NSInteger branchNum;
@property(nonatomic,assign) NSInteger readNum;
@property(nonatomic,strong) NSString  *content;
@end

@interface NOVGetAllMyStartModel :JSONModel
@property(nonatomic,assign) NSInteger status;
@property(nonatomic,copy) NSArray <NOVGetMyStartModel *>*data;
@end
