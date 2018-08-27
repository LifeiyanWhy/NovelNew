//
//  NOVReadNovelViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/4/20.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,NOVPageChangeType){
    NOVPageChangeTypeAfter = 1, //向后翻页
    NOVPageChangeTypeBefore,    //向前翻页
};
@class NOVbookMessage;
@class NOVRecordModel;
@class NOVCatalogView;
@interface NOVReadNovelViewController : UIViewController
@property(nonatomic,strong) NOVbookMessage *bookMessage; //要阅读的小说信息
@property(nonatomic,strong) NOVRecordModel *recordModel;
@property(nonatomic,assign) NSInteger selectChapterId;//选择的章节ID
@property(nonatomic,strong) NOVCatalogView *catalogView;
@property(nonatomic,strong) UIImageView *backgroundView;
@property(nonatomic,assign) BOOL readFromCatalog;   //是否从目录进入阅读状态
-(void)obtainChapterContentWithBranchId:(NSInteger)branchId;
@end
