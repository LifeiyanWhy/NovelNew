//
//  NOVNextChapterViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/8/8.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NOVbookMessage;
@interface NOVNextChapterViewController : UIViewController
@property(nonatomic,assign) NOVbookMessage *bookMessage;
@property(nonatomic,assign) NSInteger parentId;
@end
