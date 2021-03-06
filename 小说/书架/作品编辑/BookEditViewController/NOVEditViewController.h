//
//  NOVEditViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/5/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NOVStartBookModel;

typedef void(^novelTitleBlock)(NOVStartBookModel *model);

@interface NOVEditViewController : UIViewController
@property(nonatomic,copy) novelTitleBlock novelTitleBlock;
@property(nonatomic,strong) NOVStartBookModel *startModel;
@end
