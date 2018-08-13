//
//  NOVNextChapterCellHeightModel.h
//  小说
//
//  Created by 李飞艳 on 2018/8/13.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NOVChapterListModel;
@interface NOVNextChapterCellHeightModel : NSObject
+(CGFloat)getCellHeightWithModel:(NOVChapterListModel *)model;
@end
