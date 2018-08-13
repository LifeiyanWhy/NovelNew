//
//  NOVNextChapterCellHeightModel.m
//  小说
//
//  Created by 李飞艳 on 2018/8/13.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVNextChapterCellHeightModel.h"
#import "NOVChapterListModel.h"
static const CGFloat kNextChapterCellLeftSpacing = 10;
static const CGFloat kNextChapterCellRightSpacing = 10;
static const CGFloat kNextChapterCellLineSpacing = 10;
@implementation NOVNextChapterCellHeightModel
+(CGFloat)getCellHeightWithModel:(NOVChapterListModel *)model{
    CGFloat cellHeight = 0;
    CGFloat summaryHeight = [model.summary boundingRectWithSize:CGSizeMake(ScreenWidth*0.92 - kNextChapterCellLeftSpacing - kNextChapterCellRightSpacing, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    cellHeight = summaryHeight + kNextChapterCellLineSpacing*3 + ScreenWidth*0.92*0.1 + 25;
    return cellHeight;
}
@end
