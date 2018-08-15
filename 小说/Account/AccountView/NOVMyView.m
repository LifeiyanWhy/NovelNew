//
//  NOVMyView.m
//  小说
//
//  Created by 李飞艳 on 2018/5/7.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVMyView.h"
#import "Masonry.h"
#import "NOVMyheadView.h"

@implementation NOVMyView{
    NSArray *imageArray1;
    NSArray *imageArray2;
    NSArray *titleArray1;
    NSArray *titleArray2;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _myInformationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_myInformationButton];
        
        _myfootprintButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_myfootprintButton];

        _tableView = [[UITableView alloc] init];
        [self addSubview:_tableView];
        
        NSLog(@"%f",self.frame.size.height);
        _headview = [[NOVMyheadView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.43) Size:self.frame.size];
    }
    return self;
}

-(void)layoutSubviews{
    self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-50);
        make.left.and.right.equalTo(self);
    }];
    _tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    _tableView.tableHeaderView = _headview;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    _headview.nameLabel.text = @"用户名";
    [_headview.profileButton setTitle:@"简介:暂无介绍" forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
