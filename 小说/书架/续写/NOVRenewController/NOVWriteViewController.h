//
//  NOVWriteViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/4/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVStartBookModel;

typedef void(^publishNovelBlock)(NSString *title,NSString *summary,NSString *content,Boolean isPublish);
@interface NOVWriteViewController : UIViewController
@property(nonatomic,copy)  publishNovelBlock publishNovelBlock;
@property(nonatomic,strong) NOVStartBookModel *bookModel;
@end
