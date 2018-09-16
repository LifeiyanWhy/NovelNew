//
//  NOVAllMyStartView.h
//  小说
//
//  Created by 李飞艳 on 2018/9/16.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NOVView;
@class NOVMystartView;

@interface NOVAllMyStartView : UIView
@property(nonatomic,strong) NOVView *headView;
@property(nonatomic,strong) UIButton *leftButton;
@property(nonatomic,strong) UIButton *rightButton;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NOVMystartView *publishedView;//已发布
@property(nonatomic,strong) NOVMystartView *draftsView;//草稿箱
@end
