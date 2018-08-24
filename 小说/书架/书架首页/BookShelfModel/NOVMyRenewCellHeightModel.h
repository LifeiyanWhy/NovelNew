//
//  NOVMyRenewCellHeightModel.h
//  小说
//
//  Created by 李飞艳 on 2018/8/16.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NOVMyBranchModel;
@class NOVMyCollectionModel;
@interface NOVMyRenewCellHeightModel : NSObject
+(CGFloat)getRenewCellHeightWithModel:(NOVMyBranchModel *)model;
+(CGFloat)getCollectionCellHeightWithModel:(NOVMyCollectionModel *)model;
@end
