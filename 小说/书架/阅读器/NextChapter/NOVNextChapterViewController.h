//
//  NOVNextChapterViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/8/8.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NOVbookMessage;

typedef void(^selectChapterIdBlock)(NSInteger chapter);

@interface NOVNextChapterViewController : UIViewController
@property(nonatomic,assign) NOVbookMessage *bookMessage;
@property(nonatomic,assign) NSInteger parentId;
@property(nonatomic,copy) selectChapterIdBlock chapterIdBlock;
@property(nonatomic,strong) NSMutableArray *modelArray;
@end
