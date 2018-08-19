//
//  NOVCatalogView.m
//  小说
//
//  Created by 李飞艳 on 2018/8/18.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "NOVCatalogView.h"

@implementation NOVCatalogView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _headLabel = [[UILabel alloc] init];
        [self addSubview:_headLabel];
        
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        
        _tableView  = [[UITableView alloc] init];
        [self addSubview:_tableView];
    }
    return self;
}

-(void)layoutSubviews{
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.height.mas_equalTo(44);
        make.left.and.right.equalTo(self);
    }];
    _headLabel.text = @"目录";
    _headLabel.textAlignment = NSTextAlignmentCenter;
    _headLabel.textColor = [UIColor blackColor];
    _headLabel.font = [UIFont systemFontOfSize:17];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headLabel.mas_bottom);
        make.height.equalTo(self).multipliedBy(0.05);
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];
    _titleLabel.textColor = [UIColor lightGrayColor];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.backgroundColor = [UIColor colorWithRed:0.96f green:0.97f blue:0.98f alpha:1.00f];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.bottom.equalTo(self);
        make.left.and.right.equalTo(self);
    }];
    _tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
