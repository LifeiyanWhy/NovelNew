//
//  NOVReadPageViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/4/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVReadNovelView;
@class NOVChapterModel;

@interface NOVReadPageViewController : UIViewController
@property(nonatomic,strong) NOVChapterModel *chapterModel;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,strong) NOVReadNovelView *readNovelView;
-(void)setBookContent:(NSString *)content;
@end

