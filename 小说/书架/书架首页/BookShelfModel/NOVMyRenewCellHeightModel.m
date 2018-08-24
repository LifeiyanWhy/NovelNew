//
//  NOVMyRenewCellHeightModel.m
//  小说
//
//  Created by 李飞艳 on 2018/8/16.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMyRenewCellHeightModel.h"
#import "NOVGetMyRenewModel.h"
#import "NOVMyCollectionModel.h"
static const CGFloat kMyRenewCellLeftSpacing = 10;
static const CGFloat kMyRenewCellRightSpacing = 10;
static const CGFloat kMyRenewCellTopSpacing = 10;
static const CGFloat kMyRenewCellBottomSpacing = 10;
static const CGFloat kMyRenewCellLineSpacing = 5;
static const CGFloat kMyCollectionCellLeftSpacing = 10;
static const CGFloat kMyCollectionCellRightSpacing = 10;
static const CGFloat kMyCollectionCellLineSpacing = 10;
@implementation NOVMyRenewCellHeightModel
+(CGFloat)getRenewCellHeightWithModel:(NOVMyBranchModel *)model{
    CGFloat cellHeight = 0;
    CGFloat summaryHeight = [model.summary boundingRectWithSize:CGSizeMake(ScreenWidth*0.94 - kMyRenewCellLeftSpacing - kMyRenewCellRightSpacing, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;
    cellHeight = summaryHeight + kMyRenewCellLineSpacing*2 + ScreenWidth*0.05*2 + kMyRenewCellTopSpacing + kMyRenewCellBottomSpacing;
    return cellHeight;
}

+(CGFloat)getCollectionCellHeightWithModel:(NOVMyCollectionModel *)model{
    CGFloat cellHeight = 0;
    CGFloat summaryHeight = [model.summary boundingRectWithSize:CGSizeMake(ScreenWidth*0.92 - kMyCollectionCellLeftSpacing - kMyCollectionCellRightSpacing, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    cellHeight = summaryHeight + kMyCollectionCellLineSpacing*3 + ScreenWidth*0.92*0.1 + 25;
    return cellHeight;
}

@end
