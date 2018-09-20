//
//  NOVMystartViewController.h
//  小说
//
//  Created by 李飞艳 on 2018/5/22.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NOVAllMyStartView;

@interface NOVMystartViewController : UIViewController
@property(nonatomic,strong) NOVAllMyStartView *allMyStartView;
@property(nonatomic,strong) NSMutableArray *novelArray;
@property(nonatomic,strong) NSMutableArray *draftsArray;
@property(nonatomic,assign) bool touchTopButton;
@property(nonatomic,assign) CGFloat lastX;
@end
