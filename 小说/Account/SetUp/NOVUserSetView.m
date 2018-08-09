//
//  NOVUserSetView.m
//  小说
//
//  Created by 李飞艳 on 2018/8/7.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVUserSetView.h"

@implementation NOVUserSetView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _tableView = [[UITableView alloc] initWithFrame:self.frame];
        _tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
        [self addSubview:_tableView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        _lightSwitch = [[UISwitch alloc] init];
        [self addSubview:_lightSwitch];
        _lightSwitch.onTintColor = SystemColor;
        _lightSwitch.on = NO;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
