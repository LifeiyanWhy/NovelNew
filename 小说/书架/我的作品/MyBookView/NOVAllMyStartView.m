//
//  NOVAllMyStartView.m
//  小说
//
//  Created by 李飞艳 on 2018/9/16.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVAllMyStartView.h"
#import "NOVView.h"
#import "NOVMystartView.h"

@implementation NOVAllMyStartView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _headView = [[NOVView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.25, 0, ScreenWidth * 0.5, 64) titleArray:@[@"已发布",@"未发布"]];
        _headView.backgroundColor = SystemColor;
        [self addSubview:_headView];
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_leftButton];
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_rightButton];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
        [self addSubview:_scrollView];
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, ScreenHeight - 64);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor redColor];
        
        _publishedView = [[NOVMystartView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
        [_scrollView addSubview:_publishedView];
        
        _draftsView = [[NOVMystartView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - 64)];
        [_scrollView addSubview:_draftsView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _leftButton.backgroundColor = SystemColor;
    [_leftButton setImage:[UIImage imageNamed:@"返回white.png"] forState:UIControlStateNormal];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.15);
        make.bottom.equalTo(_headView);
        make.height.equalTo(_headView).multipliedBy(0.7);
    }];
    
    _rightButton.backgroundColor = SystemColor;
    [_rightButton setTitle:@"添加" forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_leftButton).multipliedBy(0.5);
        make.centerY.equalTo(_leftButton);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(self).multipliedBy(0.12);
    }];
    _rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _rightButton.layer.borderWidth = 0.3;
}

-(void)drawRect:(CGRect)rect{
    UIColor *color = SystemColor;
    [color set];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(ScreenWidth, 0)];
    [bezierPath addLineToPoint:CGPointMake(ScreenWidth, 64) ];
    [bezierPath addLineToPoint:CGPointMake(0, 64)];
    [bezierPath fill];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
