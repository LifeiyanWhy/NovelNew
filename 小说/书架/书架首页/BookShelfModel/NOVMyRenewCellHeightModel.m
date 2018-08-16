//
//  NOVMyRenewCellHeightModel.m
//  小说
//
//  Created by 李飞艳 on 2018/8/16.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMyRenewCellHeightModel.h"
#import "NOVGetMyRenewModel.h"

static const CGFloat kMyRenewCellLeftSpacing = 10;
static const CGFloat kMyRenewCellRightSpacing = 10;
static const CGFloat kMyRenewCellTopSpacing = 10;
static const CGFloat kMyRenewCellBottomSpacing = 10;
static const CGFloat kMyRenewCellLineSpacing = 5;
@implementation NOVMyRenewCellHeightModel
+(CGFloat)getRenewCellHeightWithModel:(NOVGetMyRenewModel *)renewModel{
    NOVMyBranchModel *model = renewModel.myWriteBranchDTOS[0];
    CGFloat cellHeight = 0;
    CGFloat summaryHeight = [model.summary boundingRectWithSize:CGSizeMake(ScreenWidth*0.94 - kMyRenewCellLeftSpacing - kMyRenewCellRightSpacing, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    cellHeight = summaryHeight + kMyRenewCellLineSpacing*4 + ScreenWidth*0.94*0.06*4 + kMyRenewCellTopSpacing + kMyRenewCellBottomSpacing;
    return cellHeight;
}
@end
