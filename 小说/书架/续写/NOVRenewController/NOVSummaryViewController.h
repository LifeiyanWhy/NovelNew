//
//  NOVSummaryViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/9/6.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^summaryBlock)(NSString *summaryString);
@interface NOVSummaryViewController : UIViewController
@property(nonatomic,copy) summaryBlock summaryblock;
@end
